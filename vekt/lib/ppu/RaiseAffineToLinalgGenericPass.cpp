#include "ppu/PPUDialect.h"
#include "ppu/PPUOps.h"
#include "ppu/PPUPasses.h"

#include "mlir/Dialect/Affine/Analysis/AffineAnalysis.h"
#include "mlir/Dialect/Affine/IR/AffineOps.h"
#include "mlir/Dialect/Affine/IR/AffineValueMap.h"
#include "mlir/Dialect/Arith/IR/Arith.h"
#include "mlir/Dialect/Linalg/IR/Linalg.h"
#include "mlir/IR/PatternMatch.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Transforms/WalkPatternRewriteDriver.h"

namespace mlir::ppu {

#define GEN_PASS_DEF_PPURAISEAFFINETOLINALGGENERIC
#include "ppu/PPUPasses.h.inc"

namespace {

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
