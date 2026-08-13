#include "mlir/Dialect/Affine/Passes.h"
#include "mlir/Dialect/Linalg/Passes.h"
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

  mlir::PassPipelineRegistration<>(
      "vekt", "naive vectorization", [](mlir::OpPassManager &pm) {
        pm.addPass(mlir::createCanonicalizerPass());

        pm.addPass(mlir::ppu::createPPUNormalizeIterargsReductions());
        pm.addPass(mlir::ppu::createPPURaiseAffineToLinalgGeneric());
        // NB: questo fa schifo e quindi lo devo complementare con il mio passo
        pm.addPass(mlir::createLinalgSpecializeGenericOpsPass());
        pm.addPass(mlir::ppu::createPPUSpecializeLinalgGeneric());
        pm.addPass(mlir::ppu::createPPUSpecializeAffineNests());

        // TODO: evetuali ottimizzazioni al livello di linalg
        // pm.addPass(mlir::createCanonicalizerPass());

        pm.addPass(mlir::ppu::createConvertLinalgToPPUAlgorithm());
        // cleanup intermedio importante dato che introduco costanti e
        // load/store ridondanti sopra
        pm.addPass(mlir::createCanonicalizerPass());
      });

  mlir::PassPipelineRegistration<>(
      "vekt-loop-opt", "naive vectorization", [](mlir::OpPassManager &pm) {
        pm.addPass(mlir::createCanonicalizerPass());

        pm.addPass(mlir::ppu::createPPUNormalizeIterargsReductions());
        pm.addPass(mlir::ppu::createPPURaiseAffineToLinalgGeneric());
        // NB: questo fa schifo e quindi lo devo complementare con il mio passo
        pm.addPass(mlir::createLinalgSpecializeGenericOpsPass());
        pm.addPass(mlir::ppu::createPPUSpecializeLinalgGeneric());
        pm.addPass(mlir::ppu::createPPUSpecializeAffineNests());

        // TODO: evetuali ottimizzazioni al livello di linalg
        // pm.addPass(mlir::createCanonicalizerPass());

        pm.addPass(mlir::ppu::createConvertLinalgToPPUAlgorithm());
        // cleanup intermedio importante dato che introduco costanti e
        // load/store ridondanti sopra
        pm.addPass(mlir::createCanonicalizerPass());

        // Loop optimizations
        pm.addPass(mlir::createConvertLinalgToAffineLoopsPass());
        // pm.addPass(mlir::affine::createLoopFusionPass());
        // NB: funziona ma il compilatore metaware non applica software
        // pipelining lo stesso
        // pm.addPass(mlir::affine::createLoopUnrollPass(4));
        // NB: buggato ma sarebbe comodo
        // pm.addPass(mlir::affine::createAffineScalarReplacementPass());
        pm.addPass(mlir::createLowerAffinePass());
        // NB: questo lo faccio al livello di scf dato che l'arrotondamento
        // dell'upperbound di un loop interno viene espanso a questo livello.
        // Questo rounding è loop-invariant e quindi può essere hoistato al
        // difuori del loop nest
        pm.addPass(mlir::createLoopInvariantCodeMotionPass());

        // puliamo un po' di costanti e sporcizia generate dalle loop-opt
        pm.addPass(mlir::createCanonicalizerPass());
      });

  mlir::PassPipelineRegistration<>(
      "vekt-codegen", "naive vectorization", [](mlir::OpPassManager &pm) {
        pm.addPass(mlir::ppu::createPPUAddDLTIInfo());
        pm.addPass(mlir::createCanonicalizerPass());

        pm.addPass(mlir::ppu::createPPUNormalizeIterargsReductions());
        pm.addPass(mlir::ppu::createPPURaiseAffineToLinalgGeneric());
        // NB: questo fa schifo e quindi lo devo complementare con il mio passo
        pm.addPass(mlir::createLinalgSpecializeGenericOpsPass());
        pm.addPass(mlir::ppu::createPPUSpecializeLinalgGeneric());
        pm.addPass(mlir::ppu::createPPUSpecializeAffineNests());

        // TODO: evetuali ottimizzazioni al livello di linalg
        // pm.addPass(mlir::createCanonicalizerPass());

        pm.addPass(mlir::ppu::createConvertLinalgToPPUAlgorithm());
        // cleanup intermedio importante dato che introduco costanti e
        // load/store ridondanti sopra
        pm.addPass(mlir::createCanonicalizerPass());

        // Loop optimizations
        pm.addPass(mlir::createConvertLinalgToAffineLoopsPass());
        // NB: funziona ma il compilatore metaware non applica software
        // pipelining lo stesso
        // pm.addPass(mlir::affine::createLoopUnrollPass(4));
        // NB: non funziona con ub dinamici
        // pm.addPass(mlir::affine::createLoopFusionPass());
        // NB: sarebbe utile per pulire le coppie store/load in eccesso dopo
        // fusion ma è buggato (TODO: linka la issue github)
        // pm.addPass(mlir::affine::createAffineScalarReplacementPass());
        pm.addPass(mlir::createLowerAffinePass());
        // NB: questo lo faccio al livello di scf dato che l'arrotondamento
        // dell'upperbound di un loop interno viene espanso a questo livello.
        // Questo rounding è loop-invariant e quindi può essere hoistato al di
        // fuori del loop nest
        pm.addPass(mlir::createLoopInvariantCodeMotionPass());
        // puliamo un po' di costanti e sporcizia generate dalle loop-opt
        pm.addPass(mlir::createCanonicalizerPass());

        // loweriamo ad llvm
        pm.addPass(
            mlir::createConvertVectorToLLVMPass()); // serve per broadcast
        pm.addPass(mlir::ppu::createPPULowerToLLVM());

        // cleanup finale
        pm.addPass(mlir::createCanonicalizerPass());
        pm.addPass(mlir::createLoopInvariantCodeMotionPass());
        pm.addPass(mlir::createMem2Reg());
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
