#include "mlir/Dialect/Affine/Transforms/Passes.h"
#include "mlir/IR/MLIRContext.h"
#include "mlir/InitAllDialects.h"
#include "mlir/InitAllPasses.h"
#include "mlir/Support/FileUtilities.h"
#include "mlir/Tools/mlir-opt/MlirOptMain.h"
#include "mlir/Transforms/Passes.h"

#include "mlir/Conversion/AffineToStandard/AffineToStandard.h"
#include "mlir/Conversion/ControlFlowToLLVM/ControlFlowToLLVM.h"
#include "mlir/Conversion/FuncToLLVM/ConvertFuncToLLVM.h"
#include "mlir/Conversion/MemRefToLLVM/MemRefToLLVM.h"
#include "mlir/Conversion/Passes.h"
#include "mlir/Conversion/SCFToControlFlow/SCFToControlFlow.h"
#include "mlir/Conversion/UBToLLVM/UBToLLVM.h"
#include "mlir/Conversion/VectorToLLVM/ConvertVectorToLLVM.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/Target/LLVMIR/Dialect/LLVMIR/LLVMToLLVMIRTranslation.h"

#include "Standalone/StandaloneDialect.h"
#include "Standalone/StandalonePasses.h"

int main(int argc, char **argv) {
  mlir::registerAllPasses();
  mlir::standalone::registerPasses();

  mlir::PassPipelineRegistration<>(
      "vekt16", "naive vectorization", [](mlir::OpPassManager &pm) {
        pm.addPass(mlir::createCanonicalizerPass());

        mlir::affine::AffineVectorizeOptions opts;
        opts.vectorSizes = {16};
        pm.addPass(mlir::affine::createAffineVectorize(opts));

        // lower to llvm
        pm.addPass(mlir::createLowerAffinePass());
        pm.addPass(mlir::createSCFToControlFlowPass());
        pm.addPass(mlir::createConvertControlFlowToLLVMPass());
        pm.addPass(mlir::createConvertVectorToLLVMPass());
        pm.addPass(mlir::createArithToLLVMConversionPass());
        pm.addPass(mlir::createConvertFuncToLLVMPass());
        pm.addPass(mlir::createUBToLLVMConversionPass());

        pm.addPass(mlir::createReconcileUnrealizedCastsPass());
        pm.addPass(mlir::createFinalizeMemRefToLLVMConversionPass());

        // cleanup
        pm.addPass(mlir::createCanonicalizerPass());
        pm.addPass(mlir::createSCCPPass());
        pm.addPass(mlir::createCSEPass());
        pm.addPass(mlir::createSymbolDCEPass());
      });

  mlir::DialectRegistry registry;
  //   registry.insert<mlir::standalone::StandaloneDialect,
  //                   mlir::arith::ArithDialect, mlir::func::FuncDialect>();
  // Add the following to include *all* MLIR Core dialects, or selectively
  // include what you need like above. You only need to register dialects that
  // will be *parsed* by the tool, not the one generated
  registerAllDialects(registry);

  return mlir::asMainReturnCode(
      mlir::MlirOptMain(argc, argv, "Standalone optimizer driver\n", registry));
}
