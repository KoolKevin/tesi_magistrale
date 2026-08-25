#include "mlir/Dialect/Affine/Analysis/AffineAnalysis.h"
#include "mlir/Dialect/Affine/IR/AffineOps.h"
#include "mlir/Dialect/Affine/IR/AffineValueMap.h"
#include "mlir/Dialect/Arith/IR/Arith.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/Index/IR/IndexDialect.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/Dialect/Linalg/IR/Linalg.h"
#include "mlir/Dialect/MemRef/IR/MemRef.h"
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

class ConvertLinalgToVectorOMPAlgorithm
    : public impl::ConvertLinalgToVectorOMPAlgorithmBase<
          ConvertLinalgToVectorOMPAlgorithm> {
public:
  using impl::ConvertLinalgToVectorOMPAlgorithmBase<
      ConvertLinalgToVectorOMPAlgorithm>::ConvertLinalgToVectorOMPAlgorithmBase;

  void runOnOperation() override {
    // ModuleOp module = getOperation();
    // MLIRContext *ctx = &getContext();
    llvm::errs() << "ciao\n";
  }
};

} // namespace
} // namespace mlir::vector_omp
