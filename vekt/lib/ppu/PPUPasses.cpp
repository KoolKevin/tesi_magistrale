#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/IR/PatternMatch.h"
#include "mlir/Rewrite/FrozenRewritePatternSet.h"
#include "mlir/Transforms/GreedyPatternRewriteDriver.h"

#include "ppu/PPUOps.h"
#include "ppu/PPUPasses.h"

#include "mlir/Dialect/MemRef/IR/MemRef.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/BuiltinOps.h"
#include "mlir/Pass/Pass.h"

namespace mlir::ppu {
#define GEN_PASS_DEF_PPUSWITCHBARFOO
#define GEN_PASS_DEF_PPUINSERTVECLOAD
#include "ppu/PPUPasses.h.inc"

namespace {
class PPUSwitchBarFooRewriter : public OpRewritePattern<func::FuncOp> {
public:
  using OpRewritePattern<func::FuncOp>::OpRewritePattern;
  LogicalResult matchAndRewrite(func::FuncOp op,
                                PatternRewriter &rewriter) const final {
    if (op.getSymName() == "bar") {
      rewriter.modifyOpInPlace(op, [&op]() { op.setSymName("foo"); });
      return success();
    }
    return failure();
  }
};

class PPUSwitchBarFoo : public impl::PPUSwitchBarFooBase<PPUSwitchBarFoo> {
public:
  using impl::PPUSwitchBarFooBase<PPUSwitchBarFoo>::PPUSwitchBarFooBase;

  void runOnOperation() final {
    RewritePatternSet patterns(&getContext());
    patterns.add<PPUSwitchBarFooRewriter>(&getContext());
    FrozenRewritePatternSet patternSet(std::move(patterns));
    if (failed(applyPatternsGreedily(getOperation(), patternSet)))
      signalPassFailure();
  }
};

class PPUInsertVecLoad : public impl::PPUInsertVecLoadBase<PPUInsertVecLoad> {
public:
  using impl::PPUInsertVecLoadBase<PPUInsertVecLoad>::PPUInsertVecLoadBase;

  void runOnOperation() override {
    // questo metodo viene implementato dalla base-class OperationPass e
    // restituisce l'op a cui il passo viene ancorato (moduleOp in questo caso;
    // guarda la definizione nel file .td)
    ModuleOp module = getOperation();
    OpBuilder builder(module.getContext());

    // inserisco una funzione fittizia
    builder.setInsertionPointToStart(module.getBody());
    auto funcType = builder.getFunctionType({}, {});
    auto func = builder.create<func::FuncOp>(module.getLoc(),
                                             "test_ppu_vec_load", funcType);
    Block *entry = func.addEntryBlock();
    builder.setInsertionPointToStart(entry);

    // creo una memref.alloc come argomento per la vec_load
    auto memrefType = MemRefType::get({16}, builder.getI32Type());
    Value memref = builder.create<memref::AllocOp>(func.getLoc(), memrefType);

    // creo la ppu.vec_load
    auto vecType = VectorType::get({16}, builder.getI32Type());
    auto _ = builder.create<VecLoadOp>(func.getLoc(), vecType, memref);

    // aggiungo la return op
    builder.create<func::ReturnOp>(func.getLoc());
  }
};

} // namespace
} // namespace mlir::ppu
