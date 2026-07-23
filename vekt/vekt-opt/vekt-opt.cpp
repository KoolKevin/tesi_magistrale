#include "mlir/Dialect/Affine/Passes.h"
#include "mlir/IR/MLIRContext.h"
#include "mlir/InitAllDialects.h"
#include "mlir/InitAllPasses.h"
#include "mlir/Pass/PassManager.h"
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

#include "ppu/PPUDialect.h"
#include "ppu/PPUPasses.h"

int main(int argc, char **argv) {
  // Registra i passi in maniera tale da renderli disponibili al tool
  mlir::registerAllPasses();
  mlir::ppu::registerPasses();

  // TODO: dato che la specializzazione mi richiede un altro tool, devo spezzare
  // questa pipeline in più pipeline distinte (generalizzazione,
  // specializzazione (con mlir24), vettorizzazione e lowering)
  mlir::PassPipelineRegistration<>(
      "vekt16", "naive vectorization", [](mlir::OpPassManager &pm) {
        pm.addPass(mlir::createCanonicalizerPass());
        mlir::affine::AffineVectorizeOptions vectorizeOpts;
        vectorizeOpts.vectorSizes = {16};
        pm.addPass(mlir::affine::createAffineVectorize(vectorizeOpts));

        // il lowering di memrefs con dimensione dinamica non è ammesso 😭​
        // https://mlir.llvm.org/doxygen/LLVMCommon_2TypeConverter_8cpp_source.html#l00593
        // funcToLLVMOpts.useBarePtrCallConv = false;
        // pm.addPass(mlir::createConvertFuncToLLVMPass(funcToLLVMOpts));

        // uso questo passo invece di aggiungere i suoi pattern in quello sotto
        // dato che non riesco a farlo funzionare ;)
        pm.addPass(mlir::ppu::createConvertLinalgToPPUAlgorithm());
        pm.addPass(mlir::createCanonicalizerPass()); // importante
        pm.addPass(mlir::createConvertVectorToLLVMPass());
        pm.addPass(mlir::ppu::createPPULowerToLLVM());

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
  // will be parsed by the tool, not generated ones
  registerAllDialects(registry);
  registry.insert<mlir::ppu::PPUDialect>();

  //   // TODO: capisci a cosa serve e a cosa serve questo e tutte le
  //   registrazioni
  //   // sopra Load our Dialect in this MLIR Context.
  //   mlir::MLIRContext context(registry);
  //   context.getOrLoadDialect<mlir::ppu::PPUDialect>();

  return mlir::asMainReturnCode(
      mlir::MlirOptMain(argc, argv, "Standalone optimizer driver\n", registry));
}
