#include "mlir/Transforms/GreedyPatternRewriteDriver.h"
#include "ppu/PPUDialect.h"
#include "ppu/PPUOps.h"
#include "ppu/PPUPasses.h"

#include "mlir/Dialect/Affine/Analysis/AffineAnalysis.h"
#include "mlir/Dialect/Affine/IR/AffineOps.h"
#include "mlir/Dialect/Affine/IR/AffineValueMap.h"
#include "mlir/Dialect/Arith/IR/Arith.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/Linalg/IR/Linalg.h"
#include "mlir/Dialect/MemRef/IR/MemRef.h"
#include "mlir/IR/PatternMatch.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Transforms/WalkPatternRewriteDriver.h"
#include "llvm/ADT/SmallPtrSet.h"

namespace mlir::ppu {

#define GEN_PASS_DEF_PPURAISEAFFINETOLINALGGENERIC
#define GEN_PASS_DEF_PPUNORMALIZEITERARGSREDUCTIONS
#include "ppu/PPUPasses.h.inc"

namespace {

// NB: questa è la sintassi esplicita di un affine for, ricordatela per i passi
// sotto!
//
// Nota che:
// - i bounds e lo step sono attributi
//   - i bound sono affine_maps dato che devono essere funzioni affini delle iv
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
                   arith::SubIOp, arith::SubFOp, arith::SelectOp>(op)) {
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

  // recuperiamo da info, indexingMaps e inputs
  SmallVector<Value> ins;
  SmallVector<AffineMap> indexingMaps;
  for (auto &in : info.inputs) {
    ins.push_back(in.memref);
    indexingMaps.push_back(in.indexingMap);
  }
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

        builder.create<linalg::YieldOp>(bodyLoc, yielded);
      });

  rewriter.eraseOp(outer);
}

struct ConvertAffineLoopNestToLinalgGeneric
    : public OpRewritePattern<affine::AffineForOp> {
  using OpRewritePattern::OpRewritePattern;

  LogicalResult matchAndRewrite(affine::AffineForOp op,
                                PatternRewriter &rewriter) const override {

    // voglio matchare solo con top-level loops
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

} // namespace
} // namespace mlir::ppu
