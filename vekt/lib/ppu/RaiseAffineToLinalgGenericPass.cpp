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

//===----------------------------------------------------------------------===//
// PPUNormalizeIterargsReductions
//===----------------------------------------------------------------------===//

// TODO: togli questi using
using namespace mlir;
using namespace mlir::affine;

/// One level of a pass-through iter_args chain.
struct ReductionLevel {
  AffineForOp forOp;
  BlockArgument iterArg; // forOp's sole region iter arg
  Value yieldedValue;    // operand of forOp's affine.yield
};

/// Starting at `outer` (must have exactly one iter_arg), walks down through
/// nested affine.for ops as long as each nested loop is a pure pass-through
/// of the enclosing one: the enclosing body is *only*
///   %r = affine.for ... iter_args(%x = <enclosing iterArg>) {...}
///   affine.yield %r
/// with nothing else in it. Stops at the first level whose body is NOT
/// itself just a single nested iter_args loop (the "terminal" / actually
/// computing level). Returns {} if the shape doesn't match at any point.
SmallVector<ReductionLevel> collectPassThroughChain(AffineForOp outer) {
  SmallVector<ReductionLevel> chain;
  AffineForOp cur = outer;
  while (true) {
    if (cur.getNumIterOperands() != 1)
      return {};
    BlockArgument iterArg = cur.getRegionIterArgs()[0];
    auto yieldOp = cast<AffineYieldOp>(cur.getBody()->getTerminator());
    if (yieldOp.getNumOperands() != 1)
      return {};
    chain.push_back({cur, iterArg, yieldOp.getOperand(0)});

    AffineForOp inner;
    unsigned otherOps = 0;
    for (Operation &op : cur.getBody()->without_terminator()) {
      if (auto f = dyn_cast<AffineForOp>(op)) {
        if (inner)
          return {}; // two nested loops at this level: not pass-through
        inner = f;
      } else {
        ++otherOps;
      }
    }
    if (!inner)
      break; // cur is the terminal, computing level
    if (otherOps != 0)
      return {}; // real work alongside the nested loop: not pure pass-through
    if (inner.getNumIterOperands() != 1 || inner.getInits()[0] != iterArg ||
        inner.getResult(0) != chain.back().yieldedValue)
      return {}; // not an exact pass-through of this level's iterArg/result
    cur = inner;
  }
  return chain;
}

enum class SinkKind { Return, InvariantStore, Unsupported };

struct SinkInfo {
  SinkKind kind = SinkKind::Unsupported;
  func::ReturnOp returnOp;
  unsigned returnOperandIdx = 0;
  AffineStoreOp storeOp;
};

/// Classifies the single use of the outermost loop's result. Bails
/// (Unsupported) for the interleaved-with-a-parallel-dim case -- see file
/// header.
SinkInfo classifySink(Value loopResult, ArrayRef<ReductionLevel> chain) {
  if (!loopResult.hasOneUse())
    return {};
  OpOperand &use = *loopResult.getUses().begin();
  Operation *user = use.getOwner();

  if (auto ret = dyn_cast<func::ReturnOp>(user)) {
    SinkInfo info;
    info.kind = SinkKind::Return;
    info.returnOp = ret;
    info.returnOperandIdx = use.getOperandNumber();
    return info;
  }

  if (auto store = dyn_cast<AffineStoreOp>(user)) {
    if (store.getValueToStore() != loopResult)
      return {};
    llvm::SmallPtrSet<Value, 4> chainIVs;
    for (auto &lvl : chain) {
      AffineForOp forOp = lvl.forOp; // copy: AffineForOp is a cheap handle,
                                     // but getInductionVar() needs a
                                     // non-const one and `chain` is an
                                     // ArrayRef (always const elements).
      chainIVs.insert(forOp.getInductionVar());
    }
    for (Value operand : store.getMapOperands())
      if (chainIVs.contains(operand))
        return {}; // address depends on a reduction IV: mixed case, bail
    SinkInfo info;
    info.kind = SinkKind::InvariantStore;
    info.storeOp = store;
    return info;
  }
  return {};
}

/// Ancestor affine.for ops of `chainOuter`, ordered outermost to innermost,
/// stopping at the first non-affine.for ancestor (typically the func.func
/// body). These are the "P" loops: genuinely parallel with respect to the
/// reduction chain, not part of it.
SmallVector<AffineForOp> collectEnclosingLoops(AffineForOp chainOuter) {
  SmallVector<AffineForOp> encl;
  Operation *cur = chainOuter->getParentOp();
  while (auto f = dyn_cast_or_null<AffineForOp>(cur)) {
    encl.push_back(f);
    cur = f->getParentOp();
  }
  std::reverse(encl.begin(), encl.end());
  return encl;
}

/// Clones `enclosing` (outermost to innermost) into a fresh, standalone
/// loop nest at the current insertion point, and emits the init store at
/// its innermost point (or with no loops at all, if `enclosing` is empty --
/// the pure total-reduction case). `targetIndices`'s operands are remapped
/// from the original enclosing IVs to the freshly cloned ones; any operand
/// that isn't one of `enclosing`'s IVs is assumed to dominate the new
/// insertion point already (it must, since it also had to dominate the
/// original store, which sits inside `enclosing`) and is left as-is.
///
/// Returns the outermost cloned AffineForOp, or null if `enclosing` was
/// empty (nothing was created besides the store itself).
AffineForOp buildInitNest(PatternRewriter &rewriter,
                          ArrayRef<AffineForOp> enclosing, Value initValue,
                          Value target, AffineMap targetMap,
                          ArrayRef<Value> targetIndices, Location loc) {
  if (enclosing.empty()) {
    rewriter.create<AffineStoreOp>(loc, initValue, target, targetMap,
                                   targetIndices);
    return nullptr;
  }

  IRMapping map;
  AffineForOp outermostClone;
  for (AffineForOp orig : enclosing) {
    SmallVector<Value> lb, ub;
    for (Value v : orig.getLowerBoundOperands())
      lb.push_back(map.lookupOrDefault(v));
    for (Value v : orig.getUpperBoundOperands())
      ub.push_back(map.lookupOrDefault(v));

    auto cloned = rewriter.create<AffineForOp>(loc, lb, orig.getLowerBoundMap(),
                                               ub, orig.getUpperBoundMap(),
                                               orig.getStepAsInt());
    map.map(orig.getInductionVar(), cloned.getInductionVar());
    if (!outermostClone)
      outermostClone = cloned;
    // Descend: whatever we build next (the next cloned level, or the
    // store) should land inside this loop's body, right before its
    // (default, auto-inserted) affine.yield terminator.
    rewriter.setInsertionPoint(cloned.getBody()->getTerminator());
  }

  SmallVector<Value> remappedIndices;
  for (Value v : targetIndices)
    remappedIndices.push_back(map.lookupOrDefault(v));
  rewriter.create<AffineStoreOp>(loc, initValue, target, targetMap,
                                 remappedIndices);
  return outermostClone;
}

struct NormalizeIterArgsReduction : public OpRewritePattern<AffineForOp> {
  using OpRewritePattern::OpRewritePattern;

  LogicalResult matchAndRewrite(AffineForOp op,
                                PatternRewriter &rewriter) const override {
    if (op.getNumIterOperands() != 1)
      return failure();

    // Only fire on the outermost loop of a chain: if our parent is itself
    // an affine.for whose iterArg feeds us as a pure pass-through, let that
    // invocation (or one further up) handle the whole chain at once.
    if (auto parent = op->getParentOfType<AffineForOp>()) {
      if (parent.getNumIterOperands() == 1 && !op.getInits().empty() &&
          op.getInits()[0] == parent.getRegionIterArgs()[0])
        return failure();
    }

    SmallVector<ReductionLevel> chain = collectPassThroughChain(op);
    if (chain.empty())
      return failure();

    SinkInfo sink = classifySink(chain.front().forOp.getResult(0), chain);
    if (sink.kind == SinkKind::Unsupported)
      return failure();

    Location loc = op.getLoc();
    Value initValue = chain.front().forOp.getInits()[0];

    // Determine the accumulator location: reuse the existing store's
    // target if there is one, else materialize a scratch scalar.
    Value target;
    AffineMap targetMap;
    SmallVector<Value> targetIndices;
    if (sink.kind == SinkKind::InvariantStore) {
      target = sink.storeOp.getMemRef();
      targetMap = sink.storeOp.getAffineMap();
      targetIndices = llvm::to_vector(sink.storeOp.getMapOperands());
    } else {
      rewriter.setInsertionPoint(chain.front().forOp);
      auto memrefTy = MemRefType::get({}, initValue.getType());
      target = rewriter.create<memref::AllocaOp>(loc, memrefTy);
      targetMap = rewriter.getConstantAffineMap(0).getMultiDimIdentityMap(
          0, rewriter.getContext());
      // 0-D memref: no indices.
    }

    // 1. Initialize the accumulator. If the chain sits inside enclosing
    //    parallel loops (P), the init has to run once per iteration of P --
    //    done here as a standalone cloned nest over P, a sibling placed
    //    before P's outermost loop, rather than injected into any existing
    //    loop body (which would break that loop's perfect-nest shape).
    SmallVector<AffineForOp> enclosing =
        collectEnclosingLoops(chain.front().forOp);
    Operation *initAnchor = enclosing.empty()
                                ? static_cast<Operation *>(chain.front().forOp)
                                : static_cast<Operation *>(enclosing.front());
    rewriter.setInsertionPoint(initAnchor);
    buildInitNest(rewriter, enclosing, initValue, target, targetMap,
                  targetIndices, loc);

    // 2. Rebuild each level, innermost first (so an outer level's body
    //    already reflects its already-rebuilt nested loop by the time we
    //    get to it).
    for (unsigned i = chain.size(); i-- > 0;) {
      ReductionLevel &lvl = chain[i];
      bool isTerminal = (i == chain.size() - 1);
      AffineForOp old = lvl.forOp;

      rewriter.setInsertionPoint(old);
      auto newFor = rewriter.create<AffineForOp>(
          loc, old.getLowerBoundOperands(), old.getLowerBoundMap(),
          old.getUpperBoundOperands(), old.getUpperBoundMap(),
          old.getStepAsInt());
      Block *newBody = newFor.getBody();
      rewriter.eraseOp(newBody->getTerminator());

      Value ivReplacement = newFor.getInductionVar();
      Value iterArgReplacement;
      if (isTerminal) {
        // Insert the accumulator load FIRST, in the new (still-empty)
        // body, so it's available as the replacement value for the old
        // iterArg's uses when we merge the old body's ops in below.
        rewriter.setInsertionPointToStart(newBody);
        iterArgReplacement = rewriter.create<AffineLoadOp>(
            loc, target, targetMap, targetIndices);
      } else {
        // Pass-through level: iterArg has zero real uses left (its only
        // use -- feeding the nested loop's iter_operand -- was removed
        // when we rebuilt that nested loop in the previous iteration).
        // Any type-matching placeholder works; it will never be read.
        iterArgReplacement = initValue;
      }

      rewriter.mergeBlocks(old.getBody(), newBody,
                           {ivReplacement, iterArgReplacement});

      auto oldYield = cast<AffineYieldOp>(newBody->getTerminator());
      rewriter.setInsertionPoint(oldYield);
      if (isTerminal)
        rewriter.create<AffineStoreOp>(loc, oldYield.getOperand(0), target,
                                       targetMap, targetIndices);
      rewriter.eraseOp(oldYield);
      rewriter.setInsertionPointToEnd(newBody);
      rewriter.create<AffineYieldOp>(loc);

      // `old.getResult(0)` (this level's own loop result) must have zero
      // uses before we can erase `old`. Its sole consumer is either:
      //  - the external sink (return/store), if this is the outermost
      //    level (i == 0) -- wire that up for real now, or
      //  - the enclosing level's pass-through `affine.yield %r`, if i > 0
      //    -- that yield is discarded wholesale (replaced by a bare
      //    `affine.yield`) when we process the enclosing level in a later
      //    iteration of this same loop, so the value we substitute here is
      //    never actually observed; any dominating placeholder works.
      if (i == 0) {
        if (sink.kind == SinkKind::Return) {
          rewriter.setInsertionPointAfter(newFor);
          Value finalVal = rewriter.create<AffineLoadOp>(loc, target, targetMap,
                                                         targetIndices);
          rewriter.replaceAllUsesWith(old.getResult(0), finalVal);
        } else {
          rewriter.eraseOp(sink.storeOp); // was old's sole remaining use
        }
      } else {
        rewriter.replaceAllUsesWith(old.getResult(0), initValue);
      }

      rewriter.eraseOp(old);
    }
    return success();
  }
};

struct PPUNormalizeIterargsReductions
    : impl::PPUNormalizeIterargsReductionsBase<PPUNormalizeIterargsReductions> {
  using PPUNormalizeIterargsReductionsBase::PPUNormalizeIterargsReductionsBase;

  // NB: il walker non applica folding o DCE, è quindi una buona idea aggiungere
  // un passo di canonicalizzazione dopo questo
  void runOnOperation() override {
    MLIRContext *ctx = &getContext();

    RewritePatternSet patterns(ctx);
    patterns.add<NormalizeIterArgsReduction>(ctx);
    // TODO: usiamo il greedy pattern driver
    if (failed(applyPatternsGreedily(getOperation(), std::move(patterns))))
      signalPassFailure();
  }
};

//===----------------------------------------------------------------------===//
// PPURaiseAffineToLinalgGeneric
//===----------------------------------------------------------------------===//

/// Walks downward from `outer`, requiring each loop to be normalized and to
/// contain nothing but the next nested loop (affine.apply helpers for
/// address computation are tolerated). Returns {} on any mismatch.
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

// Returns the indexing_map of 'accessOp' (affineLoads e affineStore implicitely
// converted from the smart pointer Op derived class), composed/simplified and
// then re-permuted so that result dim `i` refers to `nestIVs[i]`. Returns
// std::nullopt if the access depends on anything other than nestIVs (e.g. a
// stride symbol from a linearized memref access).
// TODO: dovrei probabilmente aggiungere un check per assicurarmi di non stare
// passando spazzatura al costrutture di access.
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

  // TODO: togli debug
  //   llvm::outs() << "\t" << indexing_map << "\n";

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
  // TODO: qua devo aggiungere anche il caso di affine.for con attributo
  // iter_args per le riduzioni
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
  // nella indexing map dell'output
  llvm::SmallDenseSet<unsigned> outputDims;
  for (AffineExpr e : info.output.indexingMap.getResults()) {
    auto d = dyn_cast<AffineDimExpr>(e);
    // result composto (es. d0+d1) incasina il semplice algoritmo sotto per la
    // classificazione degli iterator_types ed è una caso strano (per l'output).
    // Per semplificarmi la vita ignoro e basta.
    if (!d)
      return std::nullopt;

    // get position restituisce l'indice della posizione nel lhs della mappa
    outputDims.insert(d.getPosition());
  }

  // capiamo quali dimensioni del nest sono parallele o di reduction
  for (unsigned i = 0; i < nestIVs.size(); ++i) {
    bool isParallel = outputDims.contains(i);

    // A dim missing from the output map MUST be backed by the RMW accumulator
    // pattern, or there's no accumulation to justify dropping it. Le dimensioni
    // non trovate sono automaticamente classificate come ridotte.
    // TODO: qua devo aggiungere anche il caso di affine.for con attributo
    // iter_args per le riduzioni
    if (!isParallel && !info.outputAccumulatorLoad)
      return std::nullopt;

    info.iteratorTypes.push_back(isParallel ? utils::IteratorType::parallel
                                            : utils::IteratorType::reduction);
  }

  // TODO: togli debug
  //   for (auto iType : info.iteratorTypes)
  //     llvm::outs() << "\t" << iType << "\n";

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
        Value yielded;
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

    // TODO: togli debug
    // for (affine::AffineForOp forOp : nest) {
    //   llvm::outs() << "\t" << forOp << "\n";
    // }

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
