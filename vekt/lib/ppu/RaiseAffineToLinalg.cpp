#include "mlir/Transforms/GreedyPatternRewriteDriver.h"
#include "ppu/PPUDialect.h"
#include "ppu/PPUOps.h"
#include "ppu/PPUPasses.h"

#include "mlir/Dialect/Affine/Analysis/AffineAnalysis.h"
#include "mlir/Dialect/Affine/IR/AffineOps.h"
#include "mlir/Dialect/Affine/IR/AffineValueMap.h"
#include "mlir/Dialect/Affine/LoopUtils.h"
#include "mlir/Dialect/Arith/IR/Arith.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/Linalg/IR/Linalg.h"
#include "mlir/Dialect/MemRef/IR/MemRef.h"
#include "mlir/IR/IRMapping.h"
#include "mlir/IR/OpDefinition.h"
#include "mlir/IR/PatternMatch.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Transforms/WalkPatternRewriteDriver.h"
#include "llvm/ADT/DenseMap.h"
#include "llvm/ADT/STLExtras.h"
#include "llvm/ADT/SmallPtrSet.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/Support/raw_ostream.h"

#include <functional>
#include <queue>

namespace mlir::ppu {

#define GEN_PASS_DEF_PPURAISEAFFINETOLINALGGENERIC
#define GEN_PASS_DEF_PPUNORMALIZEITERARGSREDUCTIONS
#define GEN_PASS_DEF_PPUSPECIALIZELINALGGENERIC
#define GEN_PASS_DEF_PPUSPECIALIZEAFFINENESTS
#define GEN_PASS_DEF_PPUDELINEARIZEACCESSES
#define GEN_PASS_DEF_PPUDISTRIBUTELOOPS
#include "ppu/PPUPasses.h.inc"

namespace {

// NB: questa è la sintassi esplicita di un affine for, ricordatela per i passi
// sotto!
//
// Nota che:
// - i bound statici e lo step sono attributi
//   - abbiamo delle affine_maps per i bound dato che devono essere funzioni
//   affini delle iv
// - la induction variable e gli iter_args sono block_arguments
// - abbiamo come argomento dell'op i bound dinamici e il valore iniziale degli
// iter_args
//
// ```
// %result = "affine.for"(%N, %sum_init) ({
// ^bb0(%i: index, %sum_iter: f32):
//   // ... corpo del ciclo ...
//   "affine.yield"(%next_sum) : (f32) -> ()
// }) {
//   lower_bound = affine_map<() -> (0)>,
//   upper_bound = affine_map<(s0) -> (s0)>,
//   step = 1 : index
// } : (index, f32) -> f32
// ```

//===----------------------------------------------------------------------===//
// PPUNormalizeIterargsReductions
//===----------------------------------------------------------------------===//
// (guarda docs in passes.td per una descrizione di alto livello)
//===----------------------------------------------------------------------===//

// Questa struct salva le informazioni relative ad una forOp con iter_args
// appartenente ad una pass-through chain
struct ReductionLevel {
  affine::AffineForOp forOp;
  BlockArgument iterArg; // forOp's sole iter arg
  Value yieldedValue;    // operand of forOp's affine.yield
};

// riconosce e recupera una struttura di riduzione del tipo:
//
// for (iter_args)
//     for (iter_args)
//         for (iter_args)
//             ...
//
// dove i loop intermedi fanno solamente da "passaggio" dell'accumulatore.
// senza altre istruzioni nei loop intermedi. L'ultimo loop è quello che esegue
// realmente la riduzione.
SmallVector<ReductionLevel> collectPassThroughChain(affine::AffineForOp outer) {
  SmallVector<ReductionLevel> chain;
  affine::AffineForOp cur = outer;

  while (true) {
    // se ho più di un iter_arg, è un caso complicato che non gestisco
    if (cur.getNumIterOperands() != 1)
      return {};

    // recupero le informazioni del loop di reduction corrente
    BlockArgument iterArg = cur.getRegionIterArgs()[0];
    auto yieldOp = cast<affine::AffineYieldOp>(cur.getBody()->getTerminator());
    chain.push_back({cur, iterArg, yieldOp.getOperand(0)});

    // scorro le op dentro al for corrente per capire se c'è un ulteriore
    // inner-loop, e per verificare che la struttura a pass-through chain sia
    // verificata
    affine::AffineForOp inner;
    unsigned otherOps = 0;
    for (Operation &op : cur.getBody()->without_terminator()) {
      if (auto f = dyn_cast<affine::AffineForOp>(op)) {
        // two nested loops at this level -> not a pass-through chain
        if (inner)
          return {};

        inner = f;
      } else {
        ++otherOps;
      }
    }

    // se non abbiamo trovato altri affine for abbiamo raggiunto la fine della
    // catena
    if (!inner)
      break;

    // real work alongside the nested loop: not a pure pass-through chain
    if (otherOps != 0)
      return {};

    // controlliamo che l'inner loop trovato appartenga alla pass-through chain
    // - un solo iter_arg inizializzato con l'iter_arg del suo padre
    // - il risultato di inner deve essere l'operando della yield del padre
    if (inner.getNumIterOperands() != 1 || inner.getInits()[0] != iterArg ||
        inner.getResult(0) != chain.back().yieldedValue)
      return {};

    cur = inner;
  }

  return chain;
}

enum class SinkKind { Return, InvariantStore, Unsupported };

struct SinkInfo {
  SinkKind kind = SinkKind::Unsupported;
  // usati solo in caso di SinkKind::Return
  func::ReturnOp returnOp;
  unsigned returnOperandIdx = 0;
  // usato solo in caso di SinkKind::InvariantStore
  affine::AffineStoreOp storeOp;
};

// Verifica che il risultato dell'outermost loop della catena di riduzione sia
// una vera reduction controllando dove viene usato quest'ultimo catena
// (loopResult).
//
// Sono supportati due casi:
// - viene restituito con func.return
// - viene scritto tramite un affine.store in un indirizzo che non dipende dalle
// iv dei loop di riduzione (altrimenti il pattern non viene applicato dato che
// è un caso complicato)
// - TODO: potrebbe esserci anche un terzo caso, ovvero di riduzione totale ma
// senza ritorno immediato; semplicemente il valore viene utilizzato da ir
// successiva.
//
// NOTA: che passiamo ArrayRef al posto di SmallVector, la prima è
// sostanzialmente equivalente a 'const SmallVector<ReductionLevel> &chain'.
// Per convenzione, nelle librerie LLVM / MLIR si preferisce ArrayRef<T> quando
// la funzione non modifica il contenitore;
SinkInfo classifySink(ArrayRef<ReductionLevel> chain) {
  // recuperiamo lo user del (singolo per semplificare) risultato del mio
  // outermost reduction loop (valore della riduzione)
  auto outermostLoop = chain.front().forOp;
  auto loopResult = outermostLoop.getResult(0);
  if (!loopResult.hasOneUse())
    return {};
  OpOperand &use = *loopResult.getUses().begin();
  Operation *user = use.getOwner();

  // controlliamo se il valore della riduzione viene ritornato
  if (auto ret = dyn_cast<func::ReturnOp>(user)) {
    SinkInfo info;
    info.kind = SinkKind::Return;
    info.returnOp = ret;
    info.returnOperandIdx = use.getOperandNumber();

    return info;
  }

  // controlliamo se il valore della riduzione viene storato
  if (auto store = dyn_cast<affine::AffineStoreOp>(user)) {
    // recuperiamo le iv della chain
    llvm::SmallPtrSet<Value, 4> chainIVs;
    for (auto &lvl : chain) {
      // need a copy because getInductionVar() requires non-const elements
      affine::AffineForOp forOp = lvl.forOp;
      chainIVs.insert(forOp.getInductionVar());
    }

    // Controlliamo di non stare usando una iv di un loop di riduzione
    // (getMapOperands recupera gli operandi utilizzati come subscript per la
    // memref della store; affineMap dato che devono formare una affine
    // equation)
    for (Value operand : store.getMapOperands())
      if (chainIVs.contains(operand))
        return {}; // address depends on a reduction IV: mixed case, bail

    SinkInfo info;
    info.kind = SinkKind::InvariantStore;
    info.storeOp = store;

    return info;
  }

  // altrimenti sto usando il valore della riduzione in una maniera diversa
  // che non mi interessa
  return {};
}

// Ancestor affine.for ops of `outerLoopOfChain`, ordered outermost to
// innermost, stopping at the first non-affine.for ancestor (typically the
// func.func body). These are the "P" loops: genuinely parallel with respect to
// the reduction chain, not part of it.
SmallVector<affine::AffineForOp>
collectEnclosingLoops(affine::AffineForOp outerLoopOfChain) {
  SmallVector<affine::AffineForOp> encl;
  Operation *cur = outerLoopOfChain->getParentOp();
  while (auto f = dyn_cast_or_null<affine::AffineForOp>(cur)) {
    encl.push_back(f);
    cur = f->getParentOp();
  }
  std::reverse(encl.begin(), encl.end());

  return encl;
}

// Clones `enclosing` (outermost to innermost) into a fresh, standalone
// loop nest at the current insertion point, and emits the init store at
// its innermost point (or with no loops at all, if `enclosing` is empty --
// the pure total-reduction case). `targetIndices`'s operands are remapped
// from the original enclosing IVs to the freshly cloned ones; any operand
// that isn't one of `enclosing`'s IVs is assumed to dominate the new
// insertion point already (it must, since it also had to dominate the
// original store, which sits inside `enclosing`) and is left as-is.
//
// Returns the outermost cloned AffineForOp, or null if `enclosing` was
// empty (nothing was created besides the store itself).
affine::AffineForOp buildInitNest(PatternRewriter &rewriter,
                                  ArrayRef<affine::AffineForOp> enclosing,
                                  Value initValue, Value target,
                                  AffineMap targetMap,
                                  ArrayRef<Value> targetIndices, Location loc) {

  // se non ci sono enclosing parallel loops, l'inizializzazione consiste
  // semplicemente in una store (inserita prima di outer)
  if (enclosing.empty()) {
    rewriter.create<affine::AffineStoreOp>(loc, initValue, target, targetMap,
                                           targetIndices);
    return nullptr;
  }

  IRMapping map;
  affine::AffineForOp outermostClone;
  for (affine::AffineForOp orig : enclosing) {
    // Salviamo gli operandi per upper e lower bound del for (la versione
    // clonata se si è già processato il loop di origine)
    //
    // NB: se il ciclo MLIR ha una mappa fissa con costanti (es. affine.for %i =
    // 0 to 10), la mappa non ha variabili esterne. Di conseguenza,
    // getLowerBoundOperands() restituirà una lista vuota. Se invece il ciclo
    // dipende da una variabile esterna %N (es. affine.for %i = %N to 10),
    // allora %N è un operando della mappa. In questo caso,
    // getLowerBoundOperands() restituirà una lista contenente proprio quel
    // Value (%N).
    //
    // es: affine.for %i = affine_map<(d0, d1) -> (d0 + d1)>(%N, %M) to 100 { }
    SmallVector<Value> lb, ub;
    for (Value v : orig.getLowerBoundOperands())
      lb.push_back(map.lookupOrDefault(v));
    for (Value v : orig.getUpperBoundOperands())
      ub.push_back(map.lookupOrDefault(v));

    // cloniamo il loop e mappiamo l'iv (blockArg)
    auto cloned = rewriter.create<affine::AffineForOp>(
        loc, lb, orig.getLowerBoundMap(), ub, orig.getUpperBoundMap(),
        orig.getStepAsInt());
    map.map(orig.getInductionVar(), cloned.getInductionVar());
    if (!outermostClone)
      outermostClone = cloned;

    // whatever we build next (the next cloned level, or the store) should land
    // inside this loop's body, right before its (implicit) affine.yield
    // terminator.
    rewriter.setInsertionPoint(cloned.getBody()->getTerminator());
  }

  // recuperiamo gli indici che formano il subscript per la store di
  // inizializzazione dell'accumulatore (assenti in caso di accumulatore
  // scalare), e creiamo la store
  SmallVector<Value> remappedIndices;
  for (Value v : targetIndices)
    remappedIndices.push_back(map.lookupOrDefault(v));
  rewriter.create<affine::AffineStoreOp>(loc, initValue, target, targetMap,
                                         remappedIndices);

  return outermostClone;
}

struct NormalizeIterArgsReduction
    : public OpRewritePattern<affine::AffineForOp> {
  using OpRewritePattern::OpRewritePattern;

  LogicalResult matchAndRewrite(affine::AffineForOp op,
                                PatternRewriter &rewriter) const override {
    // Facciamo dei check preliminari per capire se possiamo matchare
    // (iterOperand == iter_arg == accumulatore). Vogliamo affine.for con:
    // - un solo accumulatore per semplificare la logica successiva del passo
    // (no allocazioni molteplici, load/store molteplici, ... )
    // - senza for padri che fanno parte della stessa catena di riduzione
    // (l'iter_arg del loop figlio è inizializzato proprio con l'iter_arg del
    // padre?) -> vogliamo matchare il for più esterno della catena
    //
    // API usate:
    // - op.getRegionIterArgs(), restituisce la lista dei iter_args (blockArg
    // della regione)
    // - op.getInits(), dà i valori iniziali passati da fuori all'operazione
    // (operandi della for op)
    if (op.getNumIterOperands() != 1)
      return failure();
    // FIXME: questo check non è corretto dato che il padre potrebbe avere più
    // di un iterOperand. Siccome nei miei benchmark non capita per adesso
    // ignoro
    if (auto parent = op->getParentOfType<affine::AffineForOp>()) {
      if (parent.getNumIterOperands() == 1 &&
          op.getInits()[0] == parent.getRegionIterArgs()[0])
        return failure();
    }

    // recuperiamo le informazioni del loop-nest di riduzione (pass-through
    // chain)
    SmallVector<ReductionLevel> chain = collectPassThroughChain(op);
    if (chain.empty())
      return failure();

    // recuperiamo l'informazione sul sink del valore della riduzione (result
    // dell'outermost loop)
    // - se la riduzione è parziale, sarà una store fuori dall'outermost loop
    // - se la riduzione è totale sarà una return (per quello che supportiamo
    // fino ad ora)
    SinkInfo sink = classifySink(chain);
    if (sink.kind == SinkKind::Unsupported)
      return failure();

    Location loc = op.getLoc();
    Value initValue = chain.front().forOp.getInits()[0];

    // Determine the accumulator memory location:
    // - reuse the existing store's target if there is one
    // - else materialize a scratch scalar
    //
    // (se la riduzione è completa (e.g. dotp), non c'è una store ma un qualcosa
    // tipo return; se la riduzione è parziale (e.g. matmul) ci sarà una store
    // fuori dall'outermost loop di accumulazione in cui viene salvato il valore
    // finale dell'accumulatore)
    Value target;
    AffineMap targetMap;
    SmallVector<Value> targetIndices;
    if (sink.kind == SinkKind::InvariantStore) {
      target = sink.storeOp.getMemRef();
      targetMap = sink.storeOp.getAffineMap();
      targetIndices = llvm::to_vector(sink.storeOp.getMapOperands());
    } else {
      rewriter.setInsertionPoint(chain.front().forOp);
      // memref di rango 0
      auto memrefTy = MemRefType::get({}, initValue.getType());
      target = rewriter.create<memref::AllocaOp>(loc, memrefTy);
      // recuperiamo una mappa di questo tipo: affine_map<() -> ()>. Non la
      // stiamo materializzando nell'ir ma ci servirà dopo per le operazioni di
      // store.
      targetMap = rewriter.getConstantAffineMap(0).getMultiDimIdentityMap(
          0, rewriter.getContext());
    }

    // Initialize the accumulator. If the chain sits inside enclosing parallel
    // loops (P), the init has to run once per iteration of P. This is done here
    // as a standalone cloned nest over P placed before P's outermost loop,
    // rather than injected into any existing loop body (which would break that
    // loop's perfect-nest shape).
    SmallVector<affine::AffineForOp> enclosing =
        collectEnclosingLoops(chain.front().forOp);
    // setto l'insertion point prima dell'outermost loop (sia esso parallel
    // oppure il primo di una chain di reduction)
    Operation *initAnchor = enclosing.empty()
                                ? static_cast<Operation *>(chain.front().forOp)
                                : static_cast<Operation *>(enclosing.front());
    rewriter.setInsertionPoint(initAnchor);
    buildInitNest(rewriter, enclosing, initValue, target, targetMap,
                  targetIndices, loc);

    // Rebuild each level, innermost first so an outer level's body already
    // reflects its already-rebuilt nested loop by the time we get to it.
    //
    // Per ogni livello della catena:
    // - crea un nuovo affine.for questa volta senza iter_args
    // - sposta dentro il corpo
    // - rimpiazza gli usi dell'iterArg.
    //
    // Nel loop innermost inserisce una load esplicita dell'accumulatore
    // all'inizio del corpo e una store esplicita dell'accumulatore incrementato
    // alla fine. In questo modo il valore dell'accumulatore non viene più
    // trasportato tramite SSA ma tramite memoria.
    //
    // Infine:
    // - se il risultato veniva restituito, materializza una load per ottenere
    // il valore della riduzione sostituendo il result del loop
    // - se il risultato veniva memorizzato, elimina lo store originale perché
    // ormai già avvenuto dentro ai nuovi loop di riduzione.
    for (auto [revIdx, lvl] : llvm::enumerate(llvm::reverse(chain))) {
      bool isTerminal = (revIdx == 0);
      bool isOutermost = (revIdx == chain.size() - 1);
      // NB: in chain, mi sono salvato la catena di AffineForOp con iter_args
      // (old chain), e adesso sto sostituendo gradualmente questi for nella
      // versione senza iter_args (new chain). Notevolmente, gli enclosing fors
      // hanno già nel loro corpo tutta la new chain di for processata senza
      // essere andati a modificare il loro corpo direttamente. Questo in quanto
      // bisogna ricordarsi che le Op-derived classes sono un handle
      // (smart-pointer wrapper) attorno a un'Operation*, non una copia
      // dell'operazione. Quindi i vecchi for continuano a puntare alle stesse
      // operazioni dell'IR, e quando il loro contenuto (body) viene modificato
      // come sotto, il wrapper "vede" le modifiche.
      affine::AffineForOp oldForOp = lvl.forOp;

      // creiamo un nuovo for senza body, risultati, iter_args e senza la yield
      // implicita (il builder la aggiunge automaticamente per far avere al
      // blocco un terminatore valido)
      rewriter.setInsertionPoint(oldForOp);
      auto newFor = rewriter.create<affine::AffineForOp>(
          loc, oldForOp.getLowerBoundOperands(), oldForOp.getLowerBoundMap(),
          oldForOp.getUpperBoundOperands(), oldForOp.getUpperBoundMap(),
          oldForOp.getStepAsInt());
      Block *newBody = newFor.getBody();
      rewriter.eraseOp(newBody->getTerminator());

      // Costruiamo il corpo del nuovo for con rewriter.mergeBlocks():
      //
      // void mergeBlocks(Block *source, Block *dest, ValueRange argValues);
      // - source = blocco da svuotare
      // - dest = blocco in cui spostare tutte le operazioni
      // - argValues = valori con cui sostituire i blockArgs di source dentro al
      // nuovo blocco dest
      //   - nota che il nuovo for non ha iter_arg e quindi ha un blockArg in
      //   meno. mergeBlocks() gestisce la situazione sostituendo l'uso del
      //   blockArg con quello che diciamo noi (e.g. load materializzata)
      Value ivReplacement = newFor.getInductionVar();
      Value iterArgReplacement;
      if (isTerminal) {
        // Insert the accumulator load FIRST, in the new (still-empty)
        // body, so it's available as the replacement value for the old
        // iterArg's uses when we merge the old body's ops in below.
        rewriter.setInsertionPointToStart(newBody);
        iterArgReplacement = rewriter.create<affine::AffineLoadOp>(
            loc, target, targetMap, targetIndices);
      } else {
        // L'iterArg di un livello intermedio aveva come uso solamente essere
        // passato come argomento di inizializzazione dell'iter_arg della forOp
        // sottostante. La nuova forOp non ha più questo argomento e quindi non
        // c'è più neanche alcun uso da sostituire. Usiamo un Value qualsiasi
        // per non creare codice di gestione speciale per mergeBlocks(). Any
        // type-matching placeholder works; it will never be used.
        iterArgReplacement = initValue;
      }
      rewriter.mergeBlocks(oldForOp.getBody(), newBody,
                           {ivReplacement, iterArgReplacement});

      // il vecchio body ha anche lui il suo terminatore (stavolta esplicito).
      // Noi l'abbiamo mergeato dentro al body del nuovo for e adesso dobbiamo
      // sostituirlo con uno yield implicito e materializzare la store
      // dell'accumulatore nel livello più interno
      auto oldYield = cast<affine::AffineYieldOp>(newBody->getTerminator());
      rewriter.setInsertionPoint(oldYield);
      if (isTerminal)
        rewriter.create<affine::AffineStoreOp>(
            loc, oldYield.getOperand(0), target, targetMap, targetIndices);
      rewriter.eraseOp(oldYield);
      rewriter.setInsertionPointToEnd(newBody);
      rewriter.create<affine::AffineYieldOp>(loc);

      // Rimpiazzo gli usi del result del loop (attento che old.getResult(0)
      // must have zero uses before we can erase old). Considera questa IR come
      // reference:
      //
      // affine.for %arg8 = 0 to %0 {
      //   affine.for %arg9 = 0 to %1 {
      //     %3 = affine.for %arg10 = 0 to %2 iter_args(%arg11 = %c0) -> (i32) {
      //       %4 = affine.for %arg12 = 0 to %2 iter_args(%arg13 = %arg11) ->
      //       (i32) {
      //         %5 = affine.load %arg6[%arg8 + %arg10, %arg9 + %arg12] :
      //         memref<?x?xi32> %6 = affine.load %arg7[%arg10, %arg12] :
      //         memref<?x?xi32> %7 = arith.muli %5, %6 : i32 %8 = arith.addi
      //         %arg13, %7 : i32 affine.yield %8 : i32
      //       }
      //       affine.yield %4 : i32
      //     }
      //     affine.store %3, %arg5[%arg8, %arg9] : memref<?x?xi32>
      //   }
      // }
      //
      // - se sono l'outer-most loop della reduction chain devo controllare il
      // mio sink.kind e
      //    - materializzare una load per la return-op e usarla per sostituire
      //    gli usi del mio result
      //    - eliminare semplicemente la store subito fuori dal mio corpo dato
      //    che faccio già le store dentro a inner
      // - se sono un loop interno il mio risultato è una riduzione parziale
      // utilizzata come incremento per il mio enclosing loop tramite la sua
      // yield. Quella yield verrà eliminata e quindi non fa differenza cosa uso
      // come replacement ma devo per forza sostituire altrimenti mi rimane un
      // uso del result quando vado ad eliminare la vecchia forOp che mi fa
      // crashare tutto
      if (isOutermost) {
        if (sink.kind == SinkKind::Return) {
          rewriter.setInsertionPointAfter(newFor);
          Value finalVal = rewriter.create<affine::AffineLoadOp>(
              loc, target, targetMap, targetIndices);
          rewriter.replaceAllUsesWith(oldForOp.getResult(0), finalVal);
        } else {
          rewriter.eraseOp(sink.storeOp); // was old's sole remaining use
        }
      } else {
        rewriter.replaceAllUsesWith(oldForOp.getResult(0), initValue);
      }

      rewriter.eraseOp(oldForOp);
    }

    return success();
  }
};

struct PPUNormalizeIterargsReductions
    : impl::PPUNormalizeIterargsReductionsBase<PPUNormalizeIterargsReductions> {
  using PPUNormalizeIterargsReductionsBase::PPUNormalizeIterargsReductionsBase;

  void runOnOperation() override {
    MLIRContext *ctx = &getContext();

    RewritePatternSet patterns(ctx);
    patterns.add<NormalizeIterArgsReduction>(ctx);
    // NB: usiamo il greedy driver dato che il passo modifica l'ir anche ad un
    // livello di innestamento superiore rispetto alla op matchata. Questo rompe
    // gli iteratori utilizzati da walkAndApplyPatterns() causando crash.
    // walkAndApplyPatterns () è pensato per pattern che garantiscono di mutare
    // solo il proprio sottoalbero (questo permette un implementazione con
    // performance migliori)
    if (failed(applyPatternsGreedily(getOperation(), std::move(patterns))))
      signalPassFailure();
  }
};

//===----------------------------------------------------------------------===//
// PPURaiseAffineToLinalgGeneric
//===----------------------------------------------------------------------===//
// (guarda docs in passes.td per una descrizione di alto livello)
//===----------------------------------------------------------------------===//

// Walks downward from `outer`, requiring each loop to be normalized and to
// contain nothing but the next nested loop (affine.apply helpers for
// address computation are tolerated). Returns {} on any mismatch.
SmallVector<affine::AffineForOp> collectPerfectNest(affine::AffineForOp outer) {
  SmallVector<affine::AffineForOp> nest;
  affine::AffineForOp cur = outer;

  while (true) {
    if (!cur.hasConstantLowerBound() || cur.getConstantLowerBound() != 0)
      return {};

    if (cur.getStep() != 1)
      return {};

    nest.push_back(cur);

    affine::AffineForOp inner;
    unsigned otherOps = 0;
    // scorriamo le op interne del loop corrente per controllare se ce ne sono
    // altri
    for (Operation &op : cur.getBody()->without_terminator()) {
      if (auto f = dyn_cast<affine::AffineForOp>(op)) {
        if (inner)
          return {}; // two loops at the same level: not perfectly nested

        inner = f;
      } else if (!isa<affine::AffineApplyOp>(op)) {
        ++otherOps;
        // TODO: togli debug
        // llvm::errs() << "\ttrovato op prima di un altro loop:" << op << "\n";
      }
    }

    if (!inner)
      break; // cur is innermost

    if (otherOps != 0)
      return {}; // real work sits above the inner loop: imperfect nest

    cur = inner;
  }

  return nest;
}

// Returns the indexing_map of 'accessOp' (affineLoads e affineStore implicitly
// converted from the smart pointer Op derived class), composed/simplified and
// then re-permuted so that result dim `i` refers to `nestIVs[i]`. Returns
// std::nullopt if the access depends on anything other than nestIVs (e.g. a
// stride symbol from a linearized memref access).
// TODO: dovrei probabilmente aggiungere un check per assicurarmi di non stare
// passando spazzatura al costruttore di access.
std::optional<AffineMap> buildIndexingMapFromAccess(Operation *accessOp,
                                                    ArrayRef<Value> nestIVs) {
  // recuperiamo la AffineValueMap utilizzata dall'accesso
  // es: %3 = affine.load %arg3[%arg6, %arg8] : memref<?x?xi32>
  // - mappa interna (implicita): (d0, d1) -> (d0, d1) (identità)
  // - array di value associati: [%arg6, %arg8] (ivs)
  affine::MemRefAccess access(accessOp);
  affine::AffineValueMap avm;
  access.getAccessMap(&avm);
  // semplifica la mappa calcolata espandendo valori provenienti da espressioni
  // affini (affine.apply ops) nelle rispettive funzioni dell ivs e
  // canonicalizzando. Non penso sia necessario nella maggior parte dei miei
  // casi (ma male non fa)
  avm.composeSimplifyAndCanonicalize();
  // se la mappa dell'accesso ha un simbolo, probabilmente è un accesso
  // linearizzato. In ogni caso, i simboli non possono essere presenti in una
  // indexing_map e quindi ritorno subito
  AffineMap raw = avm.getAffineMap();
  if (raw.getNumSymbols() != 0)
    return std::nullopt;

  // scorriamo gli operandi utilizzati dalla access op (e presenti nella
  // valueMap) per capire a che iv corrispondono.
  SmallVector<unsigned> dimForOperand(avm.getNumDims());
  for (auto [idx, operand] : llvm::enumerate(avm.getOperands())) {
    auto it = llvm::find(nestIVs, operand);
    // the access depends on symbol or on something outside the nest's IVs, non
    // va bene per le indexing_maps
    if (it == nestIVs.end())
      return std::nullopt;

    // es: %3 = affine.load %arg3[%arg6, %arg8] : memref<?x?xi32>, con arg6,
    // arg7, arg8 come iv di loop nest profondo 3
    // -> ottengo: [0, 2]
    dimForOperand[idx] = std::distance(nestIVs.begin(), it);
  }

  // scorriamo la lista di iv-index usati dagli operandi costruita sopra per
  // costruire il rhs della affine map risultato (eg. [0, 2] -> [d0, d2])
  SmallVector<AffineExpr> dimReplacements(raw.getNumDims());
  for (auto [operandIdx, nestPos] : llvm::enumerate(dimForOperand))
    // questa funzione converte gli indici in etichette per le dimensioni (e.g.
    // 2 -> d2)
    dimReplacements[operandIdx] = getAffineDimExpr(nestPos, raw.getContext());

  // creiamo la indexing map finale aggiornando il numero di dimensioni della
  // mappa dell'accesso al numero di iv del nest e sostituendo il della mappa
  // con la lista costruita sopra. (le indexing map non hanno simboli e quindi i
  // relativi parametri sono nulli)
  AffineMap indexing_map =
      raw.replaceDimsAndSymbols(dimReplacements, {}, nestIVs.size(), 0);

  return indexing_map;
}

struct AccessOpInfo {
  Value memref;          // memref argument that is being accessed
  AffineMap indexingMap; // numDims == nest.size(), zero symbols
  Operation *accessOp;   // the affine.load / affine.store it came from
};

struct LinalgGenericOpInfo {
  SmallVector<AccessOpInfo> inputs;
  AccessOpInfo output;
  // null if purely elementwise (no reduction)
  affine::AffineLoadOp outputAccumulatorLoad;
  // value stored into output inside the body of the nest
  Value yieldedScalar;
  SmallVector<utils::IteratorType> iteratorTypes;
};

// NB: qua sono stato portato su una via sbagliata da Claude (me lo merito).
// Popolare a mano le sizes delle memref dinamiche che compaiono nelle firme
// delle funzioni non è necessario. Va benissimo usare memref.dim dato
// che le memref verranno lowerate nei descriptor e sarà il chiamante a passare
// le sizes della memref. Non c'è pericolo di non avere le sizes come pensavo.
// NB: inferire le dimensioni delle memref però è comunque una trasformazione
// interessante. Non cancello questo commento perchè potrebbe rivelarsi utile.
//
// // Data una memref, gli ub del loop_nest in cui viene acceduta, e la sua
// // indexing_map, questa funziona materializza un reinterpret_cast op che
// // arricchisce la memref con i valodi di sizes e strides
// Value materializeSizedMemref(OpBuilder &builder, Location loc, Value memref,
//                              AffineMap indexingMap, ArrayRef<Value> bound) {
//   auto ty = cast<MemRefType>(memref.getType());
//   int64_t rank = ty.getRank();

//   // recuperiamo le sizes della memref utilizzando gli upperBounds del
//   loop-nest
//   // e le dimensioni usate nella indexingMap di accesso. Se una size è già
//   nota
//   // in quanto statica nella memref la materializziamo comunque come costante
//   // in maniera tale da ottenere un Value da passare al builder insieme alle
//   // altre sizes.
//   SmallVector<Value> sizes(rank);
//   for (int64_t p = 0; p < rank; p++) {
//     if (ty.isDynamicDim(p)) {
//       auto d = cast<AffineDimExpr>(indexingMap.getResult(p));
//       sizes[p] = bound[d.getPosition()];
//     } else {
//       sizes[p] = builder.create<arith::ConstantIndexOp>(loc,
//       ty.getDimSize(p));
//     }
//   }

//   // Calcoliamo gli stride usando le sizes recuperate. Layout row-major
//   // contiguo: l'ultima dimensione ha stride 1, ogni altra ha stride = size
//   // della dimensione successiva * stride dimensione successiva. Anche qui
//   // materializziamo dei Value da passare al builder
//   SmallVector<Value> strides(rank);
//   if (rank > 0)
//     strides[rank - 1] = builder.create<arith::ConstantIndexOp>(loc, 1);
//   for (int64_t p = rank - 2; p >= 0; p--)
//     strides[p] =
//         builder.create<arith::MulIOp>(loc, sizes[p + 1], strides[p + 1]);

//   // Creiamo la reinterpret_cast op:
//   // - stesso buffer sottostante
//   // - offset 0
//   // - shape con TUTTE le dimensioni dinamiche nel tipo per semplicità
//   //    - tanto, probabilmente lo erano già e sizes porta comunque
//   //    l'informazione e -canonicalize aggiusterà dove possibile
//   // todo: risultato dinamico sempre e comunque
//   // todo: materializza un sacco di costanti
//   // todo: stasha i changes e vedi se le sizes c'erano già con VLA
//   SmallVector<int64_t> dynamicStrides(rank, ShapedType::kDynamic);
//   auto layout = StridedLayoutAttr::get(builder.getContext(), 0,
//   dynamicStrides); auto resultTy =
//       MemRefType::get(SmallVector<int64_t>(rank, ShapedType::kDynamic),
//                       ty.getElementType(), layout);
//   // Il builder di ReinterpretCastOp prende infatti ArrayRef<OpFoldResult>
//   per
//   // sizes e strides. Usare OpFoldResult è la convenzione MLIR per
//   rappresentare
//   // un valore che è o una costante compile-time (un Attribute) o un valore
//   SSA
//   // runtime (Value) in un unico slot, usata da tutte le op "a shape mista
//   // static/dynamic" (alcune dimensioni sono note e altre no)
//   return builder.create<memref::ReinterpretCastOp>(
//       loc, resultTy, memref, builder.getIndexAttr(0),
//       SmallVector<OpFoldResult>(sizes.begin(), sizes.end()),
//       SmallVector<OpFoldResult>(strides.begin(), strides.end()));
// }

// classify operands + iterator types
std::optional<LinalgGenericOpInfo>
analyzeNest(ArrayRef<affine::AffineForOp> nest) {
  affine::AffineForOp innermostLoop = nest.back();
  SmallVector<Value> nestIVs;
  for (affine::AffineForOp f : nest)
    nestIVs.push_back(f.getInductionVar());

  // scorriamo le op del body del nest e controlliamo che ci siano solo op che
  // ci aspettiamo (loads, una singola store, arithmetic ops)
  SmallVector<affine::AffineLoadOp> loads;
  affine::AffineStoreOp store;
  for (Operation &op : innermostLoop.getBody()->without_terminator()) {
    if (auto ld = dyn_cast<affine::AffineLoadOp>(op)) {
      loads.push_back(ld);
    } else if (auto st = dyn_cast<affine::AffineStoreOp>(op)) {
      if (store)
        return std::nullopt; // more than one store: not a single generic
      store = st;
    } else if (isa<arith::MulIOp, arith::AddIOp, arith::MulFOp, arith::AddFOp,
                   arith::SubIOp, arith::SubFOp, arith::CmpIOp,
                   arith::SelectOp>(op)) {
      // payload arithmetic -- fine. Extend this list as needed; anything
      // with side effects or control flow should NOT be added here.
    } else {
      return std::nullopt; // unsupported op in the body
    }
  }
  if (!store)
    return std::nullopt;

  LinalgGenericOpInfo info;
  info.yieldedScalar = store.getValueToStore();

  // scorriamo le loads trovate e calcoliamo le relative indexing_map salvando
  // anche tutte le info necessarie. Inoltre controlliamo la presenza di pattern
  // RMW di eventuali riduzioni.
  for (auto ld : loads) {
    // le affine.load/store hanno una affine.map implicita come attributo che
    // specifica come gli operandi del subscript vengono usati (di default è
    // una mappa identità)
    bool sameAddrAsStore = ld.getMemRef() == store.getMemRef() &&
                           ld.getAffineMap() == store.getAffineMap() &&
                           ld.getMapOperands() == store.getMapOperands();
    if (sameAddrAsStore) {
      info.outputAccumulatorLoad = ld; // this is the RMW accumulator read
      // l'indexing_map è quella della store e quindi non ho bisogno di
      // calcolarla
      continue;
    }

    auto map = buildIndexingMapFromAccess(ld, nestIVs);
    if (!map)
      return std::nullopt;
    info.inputs.push_back({ld.getMemRef(), *map, ld});
  }

  // calcoliamo indexing map per la store
  auto outMap = buildIndexingMapFromAccess(store, nestIVs);
  if (!outMap)
    return std::nullopt;
  info.output = {store.getMemRef(), *outMap, store};

  // controlliamo quali dimensioni del nest (lhs della indexing map), compaiono
  // nella indexing map dell'output. (getResults restituisce le espressioni nel
  // rhs della affineMap; usiamo il rhs per controllare se stanno venendo
  // utilizzate espressioni che non supportiamo (subscript troppo complicato))
  llvm::SmallDenseSet<unsigned> outputDims;
  for (AffineExpr e : info.output.indexingMap.getResults()) {
    auto d = dyn_cast<AffineDimExpr>(e);
    // result composto (es. d0+d1) incasina il semplice algoritmo sotto per la
    // classificazione degli iterator_types ed è una caso strano (per l'output).
    // Per semplificarmi la vita ignoro e basta.
    if (!d)
      return std::nullopt;

    // getPosition() restituisce l'indice della posizione nel lhs della mappa
    outputDims.insert(d.getPosition());
  }

  // capiamo quali dimensioni del nest sono parallele o di reduction
  // controllando semplicemente quali compaiono nel subscript della store di
  // output e quali no (e.g. store[%i, %j] ha come affineMap (d0,d1) -> (d0,d1),
  // e quindi d2 sarà di reduction)
  for (unsigned i = 0; i < nestIVs.size(); ++i) {
    bool isParallel = outputDims.contains(i);

    // A dim missing from the output map MUST be backed by the RMW accumulator
    // pattern, or there's no accumulation to justify dropping it. Le dimensioni
    // non trovate sono automaticamente classificate come ridotte.
    if (!isParallel && !info.outputAccumulatorLoad)
      return std::nullopt;

    info.iteratorTypes.push_back(isParallel ? utils::IteratorType::parallel
                                            : utils::IteratorType::reduction);
  }

  return info;
}

void buildGenericFromNest(PatternRewriter &rewriter,
                          ArrayRef<affine::AffineForOp> nest,
                          LinalgGenericOpInfo &info) {

  affine::AffineForOp outer = nest.front();
  affine::AffineForOp innermost = nest.back();
  Location loc = outer.getLoc();

  // NB: lascio commentato il codice relativo al popolamento esplicto delle
  // sizes delle memref; non serve, ma potrebbe tornare utile in futuro

  // recuperiamo gli upper bound usati nel nest
  //   SmallVector<Value> bound;
  //   for (affine::AffineForOp forOp : nest)
  //     bound.push_back(forOp.getUpperBoundOperands()[0]);

  // recuperiamo da info, indexingMaps e inputs
  SmallVector<Value> ins;
  SmallVector<AffineMap> indexingMaps;
  for (auto &in : info.inputs) {
    // ins.push_back(materializeSizedMemref(rewriter, loc, in.memref,
    //                                      in.indexingMap, bound));
    ins.push_back(in.memref);
    indexingMaps.push_back(in.indexingMap);
  }
  //   materializeSizedMemref(rewriter, loc, info.output.memref,
  //                          info.output.indexingMap, bound);
  indexingMaps.push_back(info.output.indexingMap);

  // inseriamo la generic prima di outer
  rewriter.setInsertionPoint(outer);

  // costruiamo la generic passando:
  // - il tipo del risultato (vuoto dato che siamo già bufferized e non su
  // tensor)
  // - le memref di input e output (ins e outs)
  // - indexing_maps e iterator_types
  rewriter.create<linalg::GenericOp>(
      loc, TypeRange{}, ins, ValueRange{info.output.memref}, indexingMaps,
      info.iteratorTypes,
      [&](OpBuilder &builder, Location bodyLoc, ValueRange blockArgs) {
        // Mappiamo i risultati delle affine.load nel corpo nei rispettivi
        // blockArgs:
        // - one per input (in 'ins' == 'info.inputs' order), then one for the
        // output accumulator.
        // - blockArgs[0..ins.size()-1] corrispondono agli input
        // - blockArgs.back() (l'ultimo) corrisponde all'output
        //
        // Questo mappa serve a builder.clone() per sostituire automaticamente
        // usi della chiave ad usi del valore del mapping.
        IRMapping map;
        for (auto [in, arg] : llvm::zip(info.inputs, blockArgs))
          map.map(cast<affine::AffineLoadOp>(in.accessOp).getResult(), arg);
        if (info.outputAccumulatorLoad)
          map.map(info.outputAccumulatorLoad.getResult(), blockArgs.back());

        // Scorriamo le op del body e cloniamo le op aritmetiche sostituendo
        // automaticamente gli usi dei memref inputs grazie al mapping costruito
        // sopra.
        //
        // Es:
        //
        // %3 = affine.load %arg6[%arg8 + %arg10, %arg9 + %arg11] :
        // memref<?x?xi32>
        // %4 = affine.load %arg7[%arg10, %arg11] : memref<?x?xi32>
        // %5 = arith.muli %3, %4 : i32
        //
        // diventa
        // ^bb0(%in: i32, %in_0: i32, %out: i32):
        //    %0 = arith.muli %in, %in_0 : i32
        //
        // Il valore da yieldare è quello passato come argomento alla store
        // dentro al body. Quest'ultimo può essere prodotto dentro al body,
        // oppure può essere loop-invariant (e.g. inizializzazione). è quindi
        // importante inizializzare yielded.
        Value yielded = info.yieldedScalar;
        for (Operation &op : innermost.getBody()->without_terminator()) {
          // ignoro load e store in quanto rimpiazzate da block args / yield
          if (isa<affine::AffineLoadOp, affine::AffineStoreOp>(op))
            continue;

          Operation *cloned = builder.clone(op, map);

          // se l'op che ho appena clonato produce il risultato che passo come
          // argomento della store nel body. Ho trovato l'op che sarà l'uso
          // della linalg.yield (chiaramente la versione clonata che ha come usi
          // le blockArgs)
          if (op.getResult(0) == info.yieldedScalar)
            yielded = cloned->getResult(0);
        }

        // NB: Se yielded non è stato aggiornato da un'operazione clonata (e.g.
        // nella trasposta dove yielded è il risultato della affine.load),
        // usiamo il mapping per prendere direttamente il blockArg.
        yielded = map.lookupOrDefault(yielded);
        builder.create<linalg::YieldOp>(bodyLoc, yielded);
      });

  rewriter.eraseOp(outer);
}

struct ConvertAffineLoopNestToLinalgGeneric
    : public OpRewritePattern<affine::AffineForOp> {
  using OpRewritePattern::OpRewritePattern;

  LogicalResult matchAndRewrite(affine::AffineForOp op,
                                PatternRewriter &rewriter) const override {

    // TODO: per semplicità matcho solo outer-most loops. Questo è limitante
    // se un pattern si trova a sua volta dentro a dei loop (e.g. calcolo della
    // disparità da una coppia di immagini stereo tramite un for che scorre una
    // riga di pixel e applica una SAD (pattern) ad ogni posizione).
    // Dovrei poter matchare anche loop interni per trovare più pattern
    // possibile, magari iterando
    if (op->getParentOfType<affine::AffineForOp>())
      return failure();

    SmallVector<affine::AffineForOp> nest = collectPerfectNest(op);
    if (nest.empty())
      return failure();

    auto info = analyzeNest(nest);
    if (!info)
      return failure();

    buildGenericFromNest(rewriter, nest, *info);

    return success();
  }
};

struct PPURaiseAffineToLinalgGeneric
    : impl::PPURaiseAffineToLinalgGenericBase<PPURaiseAffineToLinalgGeneric> {
  using PPURaiseAffineToLinalgGenericBase::PPURaiseAffineToLinalgGenericBase;

  // NB: il walker non applica folding o DCE, è quindi una buona idea aggiungere
  // un passo di canonicalizzazione dopo questo
  void runOnOperation() override {
    MLIRContext *ctx = &getContext();
    ModuleOp module = getOperation();

    RewritePatternSet patterns(ctx);
    patterns.add<ConvertAffineLoopNestToLinalgGeneric>(ctx);
    // Post-order, forward walk traversal of ops (excluding input `op`).
    walkAndApplyPatterns(module, std::move(patterns));
  }
};

//===----------------------------------------------------------------------===//
// PPUSpecializeLinalgGeneric
//===----------------------------------------------------------------------===//

struct ConvertGenericToDotp : public OpRewritePattern<mlir::linalg::GenericOp> {

  ConvertGenericToDotp(mlir::MLIRContext *context)
      : OpRewritePattern<mlir::linalg::GenericOp>(context) {}

  using OpRewritePattern::OpRewritePattern;

  LogicalResult matchAndRewrite(mlir::linalg::GenericOp op,
                                PatternRewriter &rewriter) const final {
    // NB: Utilizziamo un interfaccia già pronta per verificare
    // - mul + add body
    //   - con anche tutte le varianti di tipo gestite
    // - projected-permutation indexing maps
    //   - solo permutazioni degli iteratori; no +1, *2 etc.
    // - 2 ins and 1 out
    //
    // Da mlir/include/mlir/Dialect/Linalg/IR/LinalgInterfaces.td:
    //
    // "A Linalg contraction is defined in general terms:
    //  1. Has 2 input and 1 output shapes.
    //  2. Has at least one reduction dimension.
    //  3. Has only projected permutation indexing maps.
    //  4. its body computes `u5(u1(c) + u2(u3(a) * u4(b)))` on some field
    //  (AddOpType, MulOpType), where u1, u2, u3, u4 and u5 represent scalar
    //  unary operations that may change the type (e.g. for mixed-precision)."
    if (!isaContractionOpInterface(op))
      return rewriter.notifyMatchFailure(op, "not a contraction");

    // un dotp è una contraction con solamente una reduction dimension
    // (questo implicitamente controlla anche che il rango degli operandi sia 1)
    if (op.getNumParallelLoops() != 0 || op.getNumReductionLoops() != 1)
      return rewriter.notifyMatchFailure(op, "not a dotp contraction");

    // una dotp ha due identity indexingMaps per i vettori di input, e una
    // indexingMap vuota per lo scalare di output
    auto maps = op.getIndexingMapsArray();
    if (!maps[0].isIdentity() || !maps[1].isIdentity() ||
        maps[2].getNumResults() != 0)
      return rewriter.notifyMatchFailure(op, "indexing map sbagliate");

    rewriter.replaceOpWithNewOp<linalg::DotOp>(op, op.getDpsInputs(),
                                               op.getDpsInits());

    return success();
  }
};

struct ConvertGenericToTranspose
    : public OpRewritePattern<mlir::linalg::GenericOp> {

  ConvertGenericToTranspose(mlir::MLIRContext *context)
      : OpRewritePattern<mlir::linalg::GenericOp>(context) {}

  using OpRewritePattern::OpRewritePattern;

  LogicalResult matchAndRewrite(mlir::linalg::GenericOp op,
                                PatternRewriter &rewriter) const final {

    // due dimensioni parallele e zero di reduction
    if (op.getNumParallelLoops() != 2 || op.getNumReductionLoops() != 0)
      return rewriter.notifyMatchFailure(op, "iterator_types non matchano");

    // una trasposta ha queste indexing maps
    // - <(d0, d1) -> (d0, d1)>
    // - <(d0, d1) -> (d1, d0)>
    auto maps = op.getIndexingMapsArray();
    if (maps.size() != 2)
      return rewriter.notifyMatchFailure(
          op, "gli accessi devono essere esattamente 2");
    if (!maps[0].isIdentity() || !maps[1].isPermutation())
      return rewriter.notifyMatchFailure(op, "indexing map sbagliate");

    // il body deve essere semplicemente una yield del primo block-arg
    mlir::Block *body = op.getBlock();
    if (body->getOperations().size() != 1) {
      return rewriter.notifyMatchFailure(
          op, "il body deve contenere solo la linalg.yield");
    }
    auto yieldOp = mlir::dyn_cast<mlir::linalg::YieldOp>(body->getTerminator());
    if (!yieldOp || yieldOp.getNumOperands() != 1 ||
        yieldOp.getOperand(0) != body->getArgument(0)) {
      return rewriter.notifyMatchFailure(op, "il body non yiels blockArgs[0]");
    }

    // NB: linalg.transpose è pensata per gestire anche dimensionalità maggiori
    // di 2 tramite una permutation map. Io gestisco solo matrici e quindi
    // hard-codo {1, 0}
    rewriter.replaceOpWithNewOp<linalg::TransposeOp>(
        op, op.getDpsInputs()[0], op.getDpsInits()[0],
        rewriter.getDenseI64ArrayAttr({1, 0}));

    return success();
  }
};

struct ConvertGenericToReduce
    : public OpRewritePattern<mlir::linalg::GenericOp> {

  ConvertGenericToReduce(mlir::MLIRContext *context)
      : OpRewritePattern<mlir::linalg::GenericOp>(context) {}

  using OpRewritePattern::OpRewritePattern;

  LogicalResult matchAndRewrite(mlir::linalg::GenericOp op,
                                PatternRewriter &rewriter) const final {

    if (op.getNumDpsInputs() != 1)
      return rewriter.notifyMatchFailure(
          op, "ci deve essere esattamente un operando da ridurre");

    SmallVector<int64_t> reductionDims;
    // recupero il rhs della mappa di input
    auto inputMap = op.getMatchingIndexingMap(op.getDpsInputOperand(0));
    auto exprs = inputMap.getResults();
    // per ogni dimensione nel rhs controllo se il loop associato è di
    // riduzione; nel caso questo sia vero, salvo la posizione della dimensione
    // nel rhs come asse di riduzione.
    //
    // es mat_reduce_cols:
    // - accedo alla matrice scorrendo le colonne d0,d1 -> d1,d0
    // - il loop interno è quello di riduzione
    //  - ad ogni iterazione accedo ad una riga diversa
    // - la dimensione di riduzione è quindi 0 (posizione di d1 nel rhs)
    for (auto [dim, expr] : llvm::enumerate(exprs)) {
      auto dimExpr = dyn_cast<AffineDimExpr>(expr);
      unsigned loopDim = dimExpr.getPosition();
      if (op.getIteratorTypesArray()[loopDim] == utils::IteratorType::reduction)
        reductionDims.push_back(dim);
    }

    if (reductionDims.empty())
      return rewriter.notifyMatchFailure(op, "nessuna dimensione di riduzione");

    rewriter.replaceOpWithNewOp<linalg::ReduceOp>(
        op, op.getDpsInputs(), op.getDpsInits(), reductionDims,
        [&](OpBuilder &builder, Location loc, ValueRange args) {
          Block &oldBlock = op.getRegion().front();

          // creo una mappa che associa gli arg del body della generic
          // agli arg del body della reduce
          IRMapping mapping;
          for (auto [oldArg, newArg] : llvm::zip(oldBlock.getArguments(), args))
            mapping.map(oldArg, newArg);

          // clono il body della generic nel body della reduce sostituendo gli
          // argomenti vecchi con il mapping
          for (Operation &nestedOp : oldBlock.without_terminator()) {
            builder.clone(nestedOp, mapping);
          }
          builder.clone(oldBlock.back(), mapping);
        });

    return success();
  }
};

struct PPUSpecializeLinalgGeneric
    : impl::PPUSpecializeLinalgGenericBase<PPUSpecializeLinalgGeneric> {
  using PPUSpecializeLinalgGenericBase::PPUSpecializeLinalgGenericBase;

  void runOnOperation() override {
    MLIRContext *ctx = &getContext();
    ModuleOp module = getOperation();

    RewritePatternSet patterns(ctx);
    patterns.add<ConvertGenericToDotp, ConvertGenericToTranspose,
                 ConvertGenericToReduce>(ctx);
    walkAndApplyPatterns(module, std::move(patterns));
  }
};

//===----------------------------------------------------------------------===//
// PPUSpecializeAffineNests
//===----------------------------------------------------------------------===//

struct ConvertNestToMaxPool2D
    : public mlir::OpRewritePattern<mlir::affine::AffineForOp> {

  ConvertNestToMaxPool2D(mlir::MLIRContext *context)
      : mlir::OpRewritePattern<mlir::affine::AffineForOp>(context) {}

  mlir::LogicalResult
  matchAndRewrite(mlir::affine::AffineForOp outerLoop,
                  mlir::PatternRewriter &rewriter) const final {

    // controllo la profondità del nest
    llvm::SmallVector<mlir::affine::AffineForOp, 4> nestedLoops;
    mlir::affine::getPerfectlyNestedLoops(nestedLoops, outerLoop);
    if (nestedLoops.size() != 4)
      return rewriter.notifyMatchFailure(
          outerLoop, "maxPool deve avere un loop nest profondo 4");

    mlir::affine::AffineForOp loop0 = nestedLoops[0];
    mlir::affine::AffineForOp loop1 = nestedLoops[1];
    mlir::affine::AffineForOp loop2 = nestedLoops[2];
    mlir::affine::AffineForOp loop3 = nestedLoops[3];
    mlir::Block *body3 = loop3.getBody();

    // controllo del numero di op (5 op + terminator affine.yield)
    if (body3->getOperations().size() != 6)
      return rewriter.notifyMatchFailure(
          loop3, "Il blocco interno deve contenere esattamente 5 operazioni");

    // controllo la sequenza di operazioni nel body
    auto it = body3->without_terminator().begin();
    auto loadAccOp = mlir::dyn_cast<mlir::affine::AffineLoadOp>(&(*it));
    it++;
    auto loadSrcOp = mlir::dyn_cast<mlir::affine::AffineLoadOp>(&(*it));
    it++;
    auto cmpiOp = mlir::dyn_cast<mlir::arith::CmpIOp>(&(*it));
    it++;
    auto selectOp = mlir::dyn_cast<mlir::arith::SelectOp>(&(*it));
    it++;
    auto storeOp = mlir::dyn_cast<mlir::affine::AffineStoreOp>(&(*it));
    it++;
    if (!loadAccOp || !loadSrcOp || !cmpiOp || !selectOp || !storeOp)
      return rewriter.notifyMatchFailure(loop3,
                                         "Sequenza di operazioni non valida");

    // controllo se sto calcolando un massimo
    // NB: sto controllando un caso molto specifico ovvero: input > acc.
    // Se il check fosse: acc < input, non matcherei.
    if (cmpiOp.getPredicate() != mlir::arith::CmpIPredicate::sgt ||
        cmpiOp.getLhs() != loadSrcOp.getResult() ||
        cmpiOp.getRhs() != loadAccOp.getResult() ||
        selectOp.getTrueValue() != loadSrcOp.getResult() ||
        selectOp.getFalseValue() != loadAccOp.getResult()) {
      return rewriter.notifyMatchFailure(
          loop3, "L'IR non corrisponde a una riduzione MaxPool");
    }

    // controllo i subscript degli accessi
    mlir::Value iv0 = loop0.getInductionVar();
    mlir::Value iv1 = loop1.getInductionVar();
    mlir::Value iv2 = loop2.getInductionVar();
    mlir::Value iv3 = loop3.getInductionVar();
    mlir::Value kernelDim = loop3.getUpperBoundOperands().front();

    // loadAcc deve indicizzare con [iv0, iv1] e con identity map
    auto accOperands = loadAccOp.getMapOperands();
    if (!loadAccOp.getAffineMap().isIdentity() || accOperands.size() != 2 ||
        accOperands[0] != iv0 || accOperands[1] != iv1)
      return rewriter.notifyMatchFailure(
          loop3, "Indicizzazione dell'accumulatore sbagliata");
    // la store deve usare esattamente gli stessi operandi/mappa di loadAcc
    if (storeOp.getAffineMap() != loadAccOp.getAffineMap() ||
        storeOp.getMapOperands() != accOperands)
      return rewriter.notifyMatchFailure(
          loop3, "store non coerente con la load dell'accumulatore");

    // loadSrc deve indicizzare con [iv2 + iv0*W][iv3 + iv1*W]
    // NB: l'ordine degli operandi della load è esattamente quello scritto sopra
    ValueRange operands = loadSrcOp.getMapOperands(); // [dims..., symbols...]

    MLIRContext *ctx = loadSrcOp.getContext();
    AffineExpr d0, d1, d2, d3, s0;
    bindDims(ctx, d0, d1, d2, d3);
    bindSymbols(ctx, s0);
    AffineMap expected =
        AffineMap::get(4, 1, {d0 + d1 * s0, d2 + d3 * s0}, ctx);
    if (loadSrcOp.getAffineMap() != expected)
      return rewriter.notifyMatchFailure(loadSrcOp,
                                         "shape sbagliata dell'accesso");

    if (operands.size() != 5)
      return rewriter.notifyMatchFailure(loadSrcOp,
                                         "expected 4 dimensions and 1 symbol");
    if (operands[0] != iv2 || operands[1] != iv0 || operands[2] != iv3 ||
        operands[3] != iv1 || operands[4] != kernelDim)
      return rewriter.notifyMatchFailure(loadSrcOp,
                                         "unexpected affine map operands");

    // loop2/loop3 devono condividere lo stesso bound (kernel quadrato)
    if (loop2.getUpperBoundMap() != loop3.getUpperBoundMap() ||
        loop2.getUpperBoundOperands() != loop3.getUpperBoundOperands())
      return rewriter.notifyMatchFailure(loop3, "Kernel non quadrato");

    // ho matchato, genero la mia op
    rewriter.setInsertionPoint(outerLoop);
    rewriter.create<ppu::MaxPool2DOp>(outerLoop.getLoc(), loadSrcOp.getMemRef(),
                                      kernelDim, loadAccOp.getMemRef());
    rewriter.eraseOp(outerLoop);
    return mlir::success();
  }
};

struct PPUSpecializeAffineNests
    : impl::PPUSpecializeAffineNestsBase<PPUSpecializeAffineNests> {
  using PPUSpecializeAffineNestsBase::PPUSpecializeAffineNestsBase;

  void runOnOperation() override {
    MLIRContext *ctx = &getContext();
    ModuleOp module = getOperation();

    RewritePatternSet patterns(ctx);
    patterns.add<ConvertNestToMaxPool2D>(ctx);
    walkAndApplyPatterns(module, std::move(patterns));
  }
};

//===----------------------------------------------------------------------===//
// PPUDelinearizeAccesses
//===----------------------------------------------------------------------===//

class PPUDelinearizeAccesses
    : public impl::PPUDelinearizeAccessesBase<PPUDelinearizeAccesses> {
public:
  using impl::PPUDelinearizeAccessesBase<
      PPUDelinearizeAccesses>::PPUDelinearizeAccessesBase;

  void runOnOperation() override {
    // TODO: pensa meglio a come vuoi approcciare la delinearizzazione.
    //
    // L'approccio descritto in "Optimistic Delinearization of Parametrically
    // Sized Arrays" è complesso e richiede l'aggiunta di runtime checks per
    // assicurarsi della correttezza della delinearizzazione.
    //
    // Invece di aggiungere questi runtime checks, io potrei provare a
    // controllare se dopo la delinearizzazione ottimistica riesco a matchare
    // un pattern, questa sarebbe la conferma che la mia delinearizzazione
    // è corretta. Tuttavia, questo complica l'architettura dato che in questo
    // modo dovrei fondere delinearizzazione e raising nello stesso passo,
    // altrimenti non riuscirei a fare un rollback.
  }
};

//===----------------------------------------------------------------------===//
// PPUDistributeLoops
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// DistributionGraph
//
// One node per top-level operation in the block being distributed. If a
// node's op is itself an affine.for, the node stands for the *entire* nest
// rooted at it (matching how mlir::affine::MemRefDependenceGraph treats
// loop-nest nodes). Two kinds of edges are built:
//
//   1. SSA def-use edges between ANY two top-level nodes in the block --
//      this is the piece mlir::affine::MemRefDependenceGraph does not give
//      you: its producer->consumer edge logic only fires when the consumer
//      is nested inside a loop that is itself a top-level node. Two flat
//      ops sitting side by side in the same block (like your bias-load and
//      the arith.addi that consumes it) get no edge from that class.
//   2. Memref-based edges between any two nodes that access a common
//      memref, where at least one side stores. This mirrors (a
//      conservative version of) MemRefDependenceGraph::init()'s second
//      edge-building pass.
//===----------------------------------------------------------------------===//

struct DGNode {
  unsigned id;
  Operation *op;
  SmallVector<Operation *, 4> loads;
  SmallVector<Operation *, 4> stores;
};

class DistributionGraph {
public:
  explicit DistributionGraph(Block &block) : block(block) {}

  void build();
  void dump(llvm::raw_ostream &os) const;
  void dumpDot(llvm::raw_ostream &os) const;

  // Computes the final, materializable partitioning. This is NOT simply
  // "SCCs in topological order" -- see the long comment on
  // computePartitions()'s definition for why that's insufficient (it's
  // what caused the dangling-IRMapping-entry segfault).
  SmallVector<SmallVector<unsigned>> computePartitions() const;

  SmallVector<DGNode> nodes;
  SmallVector<SmallVector<unsigned>> outEdges;
  SmallVector<SmallVector<unsigned>> inEdges;
  // Edges that carry an SSA (register) value, as opposed to a memref-based
  // dependence. Tracked separately because the two kinds of edges impose
  // different constraints on partitioning (see computePartitions()).
  SmallVector<std::pair<unsigned, unsigned>> ssaEdges;

private:
  Block &block;
  void addEdge(unsigned src, unsigned dst, bool isSSA);
};

void DistributionGraph::addEdge(unsigned src, unsigned dst, bool isSSA) {
  if (src == dst)
    return; // A node depending on itself (e.g. the k-loop's own carried
            // reduction) doesn't need a graph self-loop: the node is
            // already atomic, so it can never be split internally.
  if (!llvm::is_contained(outEdges[src], dst)) {
    outEdges[src].push_back(dst);
    inEdges[dst].push_back(src);
  }
  if (isSSA)
    ssaEdges.push_back({src, dst});
}

void DistributionGraph::build() {
  // --- 1. One node per top-level op (skip the terminator). ---------------
  DenseMap<Operation *, unsigned> opToNode;
  for (Operation &op : block) {
    if (op.hasTrait<OpTrait::IsTerminator>())
      continue;
    unsigned id = nodes.size();
    DGNode node{id, &op, {}, {}};
    // For a plain load/store this collects just itself; for a nested
    // affine.for it walks the whole subtree, exactly like
    // mlir::affine::LoopNestStateCollector does for MemRefDependenceGraph.
    op.walk([&](Operation *inner) {
      if (isa<affine::AffineReadOpInterface>(inner))
        node.loads.push_back(inner);
      else if (isa<affine::AffineWriteOpInterface>(inner))
        node.stores.push_back(inner);
    });
    opToNode[&op] = id;
    nodes.push_back(std::move(node));
  }
  outEdges.resize(nodes.size());
  inEdges.resize(nodes.size());

  // --- 2. SSA def-use edges between top-level nodes. ---------------------
  for (auto &node : nodes) {
    for (Value result : node.op->getResults()) {
      for (Operation *user : result.getUsers()) {
        Operation *top = block.findAncestorOpInBlock(*user);
        if (!top || top == node.op)
          continue; // use is inside this same node's own subtree
        auto it = opToNode.find(top);
        if (it != opToNode.end())
          addEdge(node.id, it->second, /*isSSA=*/true);
      }
    }
  }

  // --- 3. Memref-based edges (conservative). ------------------------------
  // For real dependence-distance/direction info, replace this block with
  // calls to mlir::affine::checkMemrefAccessDependence on each (load,
  // store) or (store, store) pair -- see mlir/Dialect/Affine/Analysis/
  // AffineAnalysis.h. Here we just connect any two nodes that touch the
  // same memref, provided at least one side writes it.
  DenseMap<Value, SmallVector<unsigned>> memrefAccesses;
  for (auto &node : nodes) {
    for (Operation *ld : node.loads)
      memrefAccesses[cast<affine::AffineReadOpInterface>(ld).getMemRef()]
          .push_back(node.id);
    for (Operation *st : node.stores)
      memrefAccesses[cast<affine::AffineWriteOpInterface>(st).getMemRef()]
          .push_back(node.id);
  }
  auto hasStore = [&](unsigned id, Value memref) {
    return llvm::any_of(nodes[id].stores, [&](Operation *st) {
      return cast<affine::AffineWriteOpInterface>(st).getMemRef() == memref;
    });
  };
  for (auto &kv : memrefAccesses) {
    Value memref = kv.first;
    ArrayRef<unsigned> ids = kv.second;
    for (size_t i = 0; i < ids.size(); ++i)
      for (size_t j = i + 1; j < ids.size(); ++j)
        if (hasStore(ids[i], memref) || hasStore(ids[j], memref))
          addEdge(ids[i], ids[j],
                  /*isSSA=*/false); // ids[] was built in
                                    // block order, so ids[i] always
                                    // precedes ids[j] textually
  }
}

// Minimal union-find, used to hard-merge nodes that must live in the same
// partition (see computePartitions()).
struct DisjointSet {
  explicit DisjointSet(unsigned n) : parent(n) {
    for (unsigned i = 0; i < n; ++i)
      parent[i] = i;
  }
  unsigned find(unsigned x) {
    while (parent[x] != x) {
      parent[x] = parent[parent[x]];
      x = parent[x];
    }
    return x;
  }
  void merge(unsigned a, unsigned b) {
    a = find(a);
    b = find(b);
    if (a != b)
      parent[a] = b;
  }
  SmallVector<unsigned> parent;
};

// Tarjan's SCC algorithm over an arbitrary small adjacency list. Returns
// SCCs; caller decides what order matters.
SmallVector<SmallVector<unsigned>>
tarjanSCCs(unsigned n, ArrayRef<SmallVector<unsigned>> adj) {
  SmallVector<int> index(n, -1), lowlink(n, -1);
  SmallVector<bool> onStack(n, false);
  SmallVector<unsigned> stack;
  int counter = 0;
  SmallVector<SmallVector<unsigned>> sccs;
  std::function<void(unsigned)> strongconnect = [&](unsigned v) {
    index[v] = lowlink[v] = counter++;
    stack.push_back(v);
    onStack[v] = true;
    for (unsigned w : adj[v]) {
      if (index[w] == -1) {
        strongconnect(w);
        lowlink[v] = std::min(lowlink[v], lowlink[w]);
      } else if (onStack[w]) {
        lowlink[v] = std::min(lowlink[v], index[w]);
      }
    }
    if (lowlink[v] == index[v]) {
      SmallVector<unsigned> scc;
      unsigned w;
      do {
        w = stack.pop_back_val();
        onStack[w] = false;
        scc.push_back(w);
      } while (w != v);
      sccs.push_back(std::move(scc));
    }
  };
  for (unsigned v = 0; v < n; ++v)
    if (index[v] == -1)
      strongconnect(v);
  return sccs;
}

SmallVector<SmallVector<unsigned>>
DistributionGraph::computePartitions() const {
  unsigned n = nodes.size();
  DisjointSet dsu(n);

  // Step 1: hard-merge every SSA edge's endpoints.
  for (auto &e : ssaEdges)
    dsu.merge(e.first, e.second);

  // Step 2: repeatedly contract any cycle that appears in the group-level
  // condensation graph, using ALL edges. Terminates because every
  // iteration that finds a cycle strictly reduces the number of groups.
  bool changed = true;
  while (changed) {
    changed = false;
    DenseMap<unsigned, unsigned> groupIndex;
    SmallVector<unsigned> roots;
    for (unsigned i = 0; i < n; ++i) {
      unsigned r = dsu.find(i);
      if (!groupIndex.count(r)) {
        groupIndex[r] = roots.size();
        roots.push_back(r);
      }
    }
    unsigned m = roots.size();
    SmallVector<SmallVector<unsigned>> gOut(m);
    for (unsigned u = 0; u < n; ++u) {
      unsigned gu = groupIndex[dsu.find(u)];
      for (unsigned v : outEdges[u]) {
        unsigned gv = groupIndex[dsu.find(v)];
        if (gu != gv && !llvm::is_contained(gOut[gu], gv))
          gOut[gu].push_back(gv);
      }
    }
    for (auto &scc : tarjanSCCs(m, gOut)) {
      if (scc.size() > 1) {
        for (unsigned i = 1; i < scc.size(); ++i)
          dsu.merge(roots[scc[0]], roots[scc[i]]);
        changed = true;
      }
    }
  }

  // Step 3: stable topological sort of the final groups (Kahn's algorithm,
  // always picking the ready group with the smallest original node id).
  DenseMap<unsigned, unsigned> groupIndex;
  SmallVector<unsigned> roots;
  for (unsigned i = 0; i < n; ++i) {
    unsigned r = dsu.find(i);
    if (!groupIndex.count(r)) {
      groupIndex[r] = roots.size();
      roots.push_back(r);
    }
  }
  unsigned m = roots.size();
  SmallVector<SmallVector<unsigned>> members(m);
  for (unsigned i = 0; i < n; ++i)
    members[groupIndex[dsu.find(i)]].push_back(i);
  for (auto &v : members)
    llvm::sort(v);

  SmallVector<SmallVector<unsigned>> gOut(m);
  SmallVector<unsigned> indegree(m, 0);
  for (unsigned u = 0; u < n; ++u) {
    unsigned gu = groupIndex[dsu.find(u)];
    for (unsigned v : outEdges[u]) {
      unsigned gv = groupIndex[dsu.find(v)];
      if (gu != gv && !llvm::is_contained(gOut[gu], gv)) {
        gOut[gu].push_back(gv);
        indegree[gv]++;
      }
    }
  }

  auto byFirstMember = [&](unsigned a, unsigned b) {
    return members[a][0] > members[b][0]; // max-heap -> smallest on top
  };
  std::priority_queue<unsigned, std::vector<unsigned>, decltype(byFirstMember)>
      ready(byFirstMember);
  for (unsigned g = 0; g < m; ++g)
    if (indegree[g] == 0)
      ready.push(g);

  SmallVector<unsigned> groupOrder;
  while (!ready.empty()) {
    unsigned g = ready.top();
    ready.pop();
    groupOrder.push_back(g);
    for (unsigned h : gOut[g])
      if (--indegree[h] == 0)
        ready.push(h);
  }

  // Step 4: merge ordered groups into final partitions with the
  // loop-nest-boundary policy: a new partition starts at any group
  // containing a loop nest, or right after one.
  SmallVector<SmallVector<unsigned>> partitions;
  bool prevWasLoop = false;
  for (unsigned g : groupOrder) {
    bool isLoop = llvm::any_of(members[g], [&](unsigned id) {
      return isa<affine::AffineForOp>(nodes[id].op);
    });
    if (partitions.empty() || isLoop || prevWasLoop)
      partitions.push_back(members[g]);
    else
      partitions.back().append(members[g].begin(), members[g].end());
    prevWasLoop = isLoop;
  }
  for (auto &p : partitions)
    llvm::sort(p);
  return partitions;
}

static std::string describeOp(Operation *op) {
  std::string s;
  llvm::raw_string_ostream os(s);
  if (auto forOp = dyn_cast<affine::AffineForOp>(op)) {
    os << "affine.for [nest] " << forOp.getLowerBoundMap() << " to "
       << forOp.getUpperBoundMap();
  } else {
    op->print(os, OpPrintingFlags().skipRegions().elideLargeElementsAttrs());
  }
  return s;
}

void DistributionGraph::dump(llvm::raw_ostream &os) const {
  os << "=== Distribution dependence graph (" << nodes.size()
     << " nodes) ===\n";
  for (const DGNode &node : nodes) {
    os << "Node " << node.id << ": " << describeOp(node.op) << "\n";
    if (!outEdges[node.id].empty()) {
      os << "    -> ";
      llvm::interleaveComma(outEdges[node.id], os);
      os << "\n";
    }
  }
}

void DistributionGraph::dumpDot(llvm::raw_ostream &os) const {
  os << "digraph DDG {\n  rankdir=TB;\n  node [shape=box,fontsize=10];\n";
  for (const DGNode &node : nodes) {
    std::string label = describeOp(node.op);
    // crude escaping so quotes/newlines don't break the .dot file
    std::string escaped;
    for (char c : label) {
      if (c == '"' || c == '\\')
        escaped.push_back('\\');
      if (c == '\n')
        continue;
      escaped.push_back(c);
    }
    os << "  n" << node.id << " [label=\"" << node.id << ": " << escaped
       << "\"];\n";
  }
  for (const DGNode &node : nodes)
    for (unsigned dst : outEdges[node.id])
      os << "  n" << node.id << " -> n" << dst << ";\n";
  os << "}\n";
}

//===----------------------------------------------------------------------===//
// Distribution driver
//===----------------------------------------------------------------------===//

static void distributeLoop(affine::AffineForOp target) {
  DistributionGraph graph(*target.getBody());
  graph.build();

  llvm::outs() << "\n--- Distributing loop at " << target.getLoc() << " ---\n";
  graph.dump(llvm::outs());
  llvm::outs() << "\n--- Graphviz DOT (pipe to `dot -Tpng -o ddg.png`) ---\n";
  graph.dumpDot(llvm::outs());

  auto partitions = graph.computePartitions();

  llvm::outs() << "\n--- Partitions ---\n";
  for (const auto &p : partitions) {
    llvm::outs() << "  { ";
    llvm::interleaveComma(p, llvm::outs());
    llvm::outs() << " }\n";
  }

  if (partitions.size() <= 1) {
    llvm::outs() << "Only one partition -- nothing to distribute here.\n";
    return;
  }

  // Collect the chain of affine.for loops enclosing (and including) the
  // target, outermost first.
  SmallVector<affine::AffineForOp> ancestorChain;
  for (affine::AffineForOp cur = target; cur;
       cur = cur->getParentOfType<affine::AffineForOp>())
    ancestorChain.push_back(cur);
  std::reverse(ancestorChain.begin(), ancestorChain.end());
  affine::AffineForOp outermost = ancestorChain.front();

  OpBuilder builder(outermost);
  Block *insertBlock = outermost->getBlock();

  // NOTE on an earlier, buggier version of this function: it deep-cloned
  // the *entire* enclosing chain (via Operation::clone on `outermost`) and
  // then erased everything in the clone's innermost body except this
  // partition's statements, before re-cloning just those statements from
  // the originals. That leaves a stale IRMapping entry behind whenever a
  // statement's *header* (an AffineForOp) is discarded: cloning the header
  // registers a mapping for its induction variable pointing at the
  // now-to-be-erased clone, and if no *other* clone of that same original
  // header happens later in the same partition, nothing overwrites the
  // stale entry -- so a later clone() call that (transitively) needs it
  // dereferences a dangling Value. That's what produced the
  // Region::cloneInto/OperandStorage::setOperands segfault.
  //
  // The fix: never clone-then-discard. Build each partition's loop headers
  // fresh (same bounds/step, empty body) and only ever clone() the
  // operations we are actually keeping.
  for (const auto &partition : partitions) {
    IRMapping mapping;
    // Always anchor on the *original* outermost loop, not the previous
    // partition's output -- inserting "before the original" on every
    // iteration naturally accumulates partitions in the order we process
    // them (partition 0, then partition 1, ..., then the original, which
    // we erase last). Anchoring on the previous partition's clone instead
    // would insert each new partition *before* the last one, reversing
    // the output order.
    builder.setInsertionPoint(insertBlock,
                              Block::iterator(outermost.getOperation()));

    Operation *newOutermost = nullptr;
    for (affine::AffineForOp orig : ancestorChain) {
      // Loop-bound operands may reference values from outside the whole
      // nest (e.g. the index-cast'd trip counts here) -- lookupOrDefault
      // leaves those as-is (identity) since they were never mapped.
      SmallVector<Value> lbOperands, ubOperands;
      for (Value v : orig.getLowerBoundOperands())
        lbOperands.push_back(mapping.lookupOrDefault(v));
      for (Value v : orig.getUpperBoundOperands())
        ubOperands.push_back(mapping.lookupOrDefault(v));

      auto newFor = builder.create<affine::AffineForOp>(
          orig.getLoc(), lbOperands, orig.getLowerBoundMap(), ubOperands,
          orig.getUpperBoundMap(),
          orig.getStepAsInt()); // some MLIR versions instead expose this
                                // as `orig.getStep()` returning int64_t
                                // directly -- adjust to match your tree.
      mapping.map(orig.getInductionVar(), newFor.getInductionVar());
      if (!newOutermost)
        newOutermost = newFor;

      // Descend into the freshly created (currently empty) body for the
      // next header level / for the statement-cloning step below.
      builder.setInsertionPoint(newFor.getBody()->getTerminator());
    }

    // We're now positioned inside the freshly built target-level loop,
    // right before its terminator. Clone just this partition's
    // statements, in program order, so each one's operands are already
    // present in `mapping` by the time it's needed.
    for (unsigned id : partition)
      builder.clone(*graph.nodes[id].op, mapping);
  }

  outermost.erase();
}

//===----------------------------------------------------------------------===//
// Pass
//===----------------------------------------------------------------------===//

class PPUDistributeLoops
    : public impl::PPUDistributeLoopsBase<PPUDistributeLoops> {
public:
  using impl::PPUDistributeLoopsBase<
      PPUDistributeLoops>::PPUDistributeLoopsBase;

  void runOnOperation() override {
    // Collect candidates first, then transform -- distributeLoop() erases
    // and re-inserts ops, which would invalidate an in-progress walk().
    SmallVector<affine::AffineForOp> candidates;
    getOperation()->walk([&](affine::AffineForOp forOp) {
      Block &body = *forOp.getBody();
      unsigned nonTerminatorOps = 0;
      bool hasNestedFor = false;
      for (Operation &op : body) {
        if (op.hasTrait<OpTrait::IsTerminator>())
          continue;
        ++nonTerminatorOps;
        if (isa<affine::AffineForOp>(op))
          hasNestedFor = true;
      }
      // Only imperfectly-nested loops (a nested for-loop plus other
      // top-level statements) are candidates -- that's the shape
      // distribution actually changes.
      if (hasNestedFor && nonTerminatorOps > 1)
        candidates.push_back(forOp);
    });

    for (affine::AffineForOp forOp : candidates)
      distributeLoop(forOp);
  }
};

} // namespace
} // namespace mlir::ppu
