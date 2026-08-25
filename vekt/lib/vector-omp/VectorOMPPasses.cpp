#include "mlir/Dialect/Affine/Analysis/AffineAnalysis.h"
#include "mlir/Dialect/Affine/IR/AffineOps.h"
#include "mlir/Dialect/Affine/IR/AffineValueMap.h"
#include "mlir/Dialect/Arith/IR/Arith.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/Index/IR/IndexDialect.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/Dialect/Linalg/IR/Linalg.h"
#include "mlir/Dialect/MemRef/IR/MemRef.h"
#include "mlir/Dialect/OpenMP/OpenMPDialect.h"
#include "mlir/Dialect/Utils/StaticValueUtils.h" // Per getValueOrCreateConstantIndexOp e getConstantIntValue
#include "mlir/Dialect/Vector/IR/VectorOps.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/BuiltinOps.h"
#include "mlir/IR/PatternMatch.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Target/LLVMIR/Import.h"
#include "mlir/Transforms/GreedyPatternRewriteDriver.h"
#include "mlir/Transforms/WalkPatternRewriteDriver.h"

#include "vector-omp/VectorOMPPasses.h"

namespace mlir::vector_omp {
#define GEN_PASS_DEF_CONVERTLINALGTOVECTOROMPALGORITHM
#include "vector-omp/VectorOMPPasses.h.inc"

namespace {
//===----------------------------------------------------------------------===//
// ConvertLinalgToVectorOMPAlgorithm
//===----------------------------------------------------------------------===//

const int vectorRegisterBits = 128;

struct ConvertLinalgAdd : public OpRewritePattern<mlir::linalg::AddOp> {

  ConvertLinalgAdd(mlir::MLIRContext *context)
      : OpRewritePattern<mlir::linalg::AddOp>(context) {}

  using OpRewritePattern::OpRewritePattern;

  LogicalResult matchAndRewrite(mlir::linalg::AddOp op,
                                PatternRewriter &rewriter) const final {

    mlir::Location loc = op.getLoc();

    // recuperiamo i ranges dei loop (start, stop, step)
    auto linalgOp = ::llvm::cast<mlir::linalg::LinalgOp>(op.getOperation());
    mlir::SmallVector<mlir::Range> loopRanges =
        linalgOp.createLoopRanges(rewriter, loc);
    // TODO: voglio gestire solamente la somma tra vettori per addesso
    if (loopRanges.size() != 1)
      return rewriter.notifyMatchFailure(op, "voglio solo un ciclo");

    // Recuperiamo gli operandi
    mlir::Value lhs = op.getInputs()[0];
    mlir::Value rhs = op.getInputs()[1];
    mlir::Value out = op.getOutputs()[0];

    // recuperiamo vari tipi e il numero di lane considerando il tipo degli
    // operandi
    Type elemTy = mlir::cast<MemRefType>(lhs.getType()).getElementType();
    if (!elemTy.isIntOrFloat())
      return rewriter.notifyMatchFailure(
          op, "tipo elemento non supportato per vettorizzazione");
    unsigned bitWidth = elemTy.getIntOrFloatBitWidth();
    int numLanes = vectorRegisterBits / bitWidth;
    // auto vecTy = mlir::VectorType::get({numLanes}, elemTy);

    // Estrazione dei limiti del ciclo dal range
    Value lowerBound = mlir::getValueOrCreateConstantIndexOp(
        rewriter, loc, loopRanges[0].offset);
    Value upperBound = mlir::getValueOrCreateConstantIndexOp(
        rewriter, loc, loopRanges[0].size);
    Value step = mlir::getValueOrCreateConstantIndexOp(rewriter, loc,
                                                       loopRanges[0].stride);

    // costruzione del ciclo #pragma omp parallel for simd
    auto parallelOp = rewriter.create<mlir::omp::ParallelOp>(loc);
    // NB: la regione non è automaticamente popolata con il blocco e quindi
    // lo inseriamo noi. Questo sposta anche l'insertion-point del rewriter
    // e quindi in seguito stiamo innestando le operazioni
    rewriter.createBlock(&parallelOp.getRegion());

    auto wsloopOp = rewriter.create<mlir::omp::WsloopOp>(loc);
    wsloopOp.setComposite(true);
    rewriter.createBlock(&wsloopOp.getRegion());

    omp::SimdOperands clauses;
    clauses.simdlen = rewriter.getI64IntegerAttr(numLanes);
    auto simdOp = rewriter.create<mlir::omp::SimdOp>(loc, clauses);
    simdOp.setComposite(true);
    rewriter.createBlock(&simdOp.getRegion());

    // TODO: non vuole dei valueRange? come fa a funzionare?
    auto loopNestOp = rewriter.create<mlir::omp::LoopNestOp>(loc, lowerBound,
                                                             upperBound, step);

    // Il blocco del loop_nest ha una sola iv come argomento
    mlir::Block *loopBody = rewriter.createBlock(&loopNestOp.getRegion(),
                                                 loopNestOp.getRegion().begin(),
                                                 {lowerBound.getType()}, {loc});
    mlir::Value iv = loopBody->getArgument(0);

    // generazione body del ciclo
    rewriter.setInsertionPointToStart(loopBody);
    mlir::Value valA = rewriter.create<mlir::memref::LoadOp>(loc, lhs, iv);
    mlir::Value valB = rewriter.create<mlir::memref::LoadOp>(loc, rhs, iv);
    // Gestione tipo di somma (Float vs Int)
    mlir::Value sum;
    if (mlir::isa<mlir::FloatType>(elemTy)) {
      sum = rewriter.create<mlir::arith::AddFOp>(loc, valA, valB);
    } else {
      sum = rewriter.create<mlir::arith::AddIOp>(loc, valA, valB);
    }
    rewriter.create<mlir::memref::StoreOp>(loc, sum, out, iv);
    rewriter.create<mlir::omp::YieldOp>(loc);

    // chiudiamo le regione parallela con la terminator op
    rewriter.setInsertionPointToEnd(&parallelOp.getRegion().front());
    rewriter.create<mlir::omp::TerminatorOp>(loc);

    rewriter.eraseOp(op);

    return success();
  }
};

class ConvertLinalgToVectorOMPAlgorithm
    : public impl::ConvertLinalgToVectorOMPAlgorithmBase<
          ConvertLinalgToVectorOMPAlgorithm> {
public:
  using impl::ConvertLinalgToVectorOMPAlgorithmBase<
      ConvertLinalgToVectorOMPAlgorithm>::ConvertLinalgToVectorOMPAlgorithmBase;

  void runOnOperation() override {
    ModuleOp module = getOperation();
    MLIRContext *ctx = &getContext();

    RewritePatternSet patterns(ctx);
    patterns.add<ConvertLinalgAdd>(ctx);
    // Post-order, forward walk traversal of ops (excluding input `op`).
    walkAndApplyPatterns(module, std::move(patterns));
  }
};

} // namespace
} // namespace mlir::vector_omp
