#include "mlir/Conversion/OpenMPToLLVM/ConvertOpenMPToLLVM.h"
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

// my stuff
#include "ppu/PPUDialect.h"
#include "ppu/PPUPasses.h"
#include "vector-omp/VectorOMPPasses.h"

int main(int argc, char **argv) {
  // Registra i passi nel pass-registry globale in maniera tale da renderli
  // disponibili al tool
  mlir::registerAllPasses();
  mlir::ppu::registerPasses();
  mlir::vector_omp::registerPasses();

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
      });

  mlir::PassPipelineRegistration<>(
      "vekt-omp", "omp parallelization and vectorization of patterns",
      [](mlir::OpPassManager &pm) {
        pm.addPass(mlir::createCanonicalizerPass());

        pm.addPass(mlir::ppu::createPPUNormalizeIterargsReductions());
        pm.addPass(mlir::ppu::createPPURaiseAffineToLinalgGeneric());
        // NB: questo fa schifo e quindi lo devo complementare con il mio passo
        pm.addPass(mlir::createLinalgSpecializeGenericOpsPass());
        pm.addPass(mlir::ppu::createPPUSpecializeLinalgGeneric());
        pm.addPass(mlir::ppu::createPPUSpecializeAffineNests());

        // TODO: evetuali ottimizzazioni al livello di linalg
        // pm.addPass(mlir::createCanonicalizerPass());

        pm.addPass(mlir::vector_omp::createConvertLinalgToVectorOMPAlgorithm());
        // cleanup intermedio importante dato che introduco costanti e
        // load/store ridondanti sopra
        pm.addPass(mlir::createCanonicalizerPass());
      });

  mlir::PassPipelineRegistration<>(
      "vekt-omp-codegen", "omp parallelization and vectorization of patterns",
      [](mlir::OpPassManager &pm) {
        pm.addPass(mlir::createCanonicalizerPass());

        pm.addPass(mlir::ppu::createPPUNormalizeIterargsReductions());
        pm.addPass(mlir::ppu::createPPURaiseAffineToLinalgGeneric());
        // NB: questo fa schifo e quindi lo devo complementare con il mio passo
        pm.addPass(mlir::createLinalgSpecializeGenericOpsPass());
        pm.addPass(mlir::ppu::createPPUSpecializeLinalgGeneric());
        pm.addPass(mlir::ppu::createPPUSpecializeAffineNests());

        // TODO: evetuali ottimizzazioni al livello di linalg
        // pm.addPass(mlir::createCanonicalizerPass());

        pm.addPass(mlir::vector_omp::createConvertLinalgToVectorOMPAlgorithm());
        // cleanup intermedio importante dato che introduco costanti e
        // load/store ridondanti sopra
        pm.addPass(mlir::createCanonicalizerPass());

        // TODO: eventuali ottimizzazioin al livello di omp+vector

        // loweriamo ad llvm: sembra che basti convert-openmp-to-llvm
        // -> "Convert the OpenMP ops to OpenMP ops with LLVM dialect"
        //
        // pm.addPass(
        //     mlir::createConvertVectorToLLVMPass()); // serve per broadcast
        // pm.addPass(mlir::ppu::createPPULowerToLLVM());
        pm.addPass(mlir::createConvertOpenMPToLLVMPass());

        // cleanup finale
        pm.addPass(mlir::createCanonicalizerPass());
        pm.addPass(mlir::createLoopInvariantCodeMotionPass());
        pm.addPass(mlir::createMem2Reg());
        pm.addPass(mlir::createSCCPPass());
        pm.addPass(mlir::createCSEPass());
      });

  // NB: Qua sotto aggiungiamo dei dialetti ad un DialectRegistry in maniera
  // tale da renderli noti ad un MLIRContext. MLIRContext è l'oggetto che
  // contiene lo stato runtime di una specifica istanza di MLIR.
  //
  // Dentro un context vivono, tra le altre cose:
  //
  // - uniqued types
  // - uniqued attributes
  // - MLIR operations
  // - loaded dialects
  // - registry associato al context
  //
  // Il punto importante è: UN DIALECT REGISTRATO NON È NECESSARIAMENTE UN
  // DIALECT CARICATO NEL CONTESTO
  //
  // Il DialectRegistry è un catalogo di dialect disponibili (e di estensioni
  // associate). Quando fai:
  //
  // mlir::DialectRegistry registry;
  // registerAllDialects(registry);
  // registry.insert<mlir::ppu::PPUDialect>();
  //
  // non stai ancora creando un PPUDialect. Stai dicendo: "Se qualcuno vuole
  // usare PPUDialect, questa è la classe che sa come crearlo."
  //
  // PERCHÉ BISOGNA REGISTRARE I DIALECT?
  //
  // Immagina che il file input contenga:
  //
  // module {
  //   %0 = arith.constant 42 : i32
  // }
  //
  // Il parser vede: arith.constant, e deve sapere che cos'è arith. Il registry
  // gli permette di trovare la classe che definisce il dialetto e caricarla nel
  // contesto in maniera tale da conoscere:
  //
  // - quali operations esistono;
  // - quali attributes esistono;
  // - quali types esistono;
  // - quali interfaces sono associate;
  // ecc.
  //
  // Similmente, anche i passi devono essere registrati in un registro
  // (PassRegistry), altrimenti il tool non è in grado di sapere qual'è la
  // classe che implementa il passo associato al nome fornito da CLI. Stavolta
  // però, non c'è un contesto a differenza dei dialetti (non c'è stato da
  // mantenere in memoria)
  //
  //                        APPLICATION
  //                           |
  //           +---------------+---------------+
  //           |                               |
  //           v                               v
  //    GLOBAL PASS REGISTRY             DialectRegistry
  //           |                               |
  //    registerAllPasses()             insert<PPU>()
  //    ppu::registerPasses()           registerAllDialects()
  //           |                         addExtension(...)
  //           |                               |
  //           v                               v
  //      "which passes?"                "which dialects and extensions
  //                                       are available?"
  //           |                               |
  //           +---------------+---------------+
  //                           |
  //                           v
  //                      MLIRContext
  //                           |
  //                 +---------+---------+
  //                 |                   |
  //                 v                   v
  //           loaded dialects      pass execution
  //                 |
  //                 +-- PPU
  //                 |    |
  //                 |    +-- interfaces
  //                 |
  //                 +-- arith
  //                 +-- func
  //                 +-- ...
  mlir::DialectRegistry registry;
  //   registry.insert<mlir::standalone::StandaloneDialect,
  //                   mlir::arith::ArithDialect, mlir::func::FuncDialect>();
  // Add the following to include *all* MLIR Core dialects, or selectively
  // include what you need like above. You only need to register dialects that
  // will be parsed by the tool, not generated ones
  registerAllDialects(registry);
  registry.insert<mlir::ppu::PPUDialect>();

  // Per caricare esplicitamente in un contesto un dialetto registrato puoi
  // fare come sotto (preso da toy tutorial):
  // mlir::MLIRContext context(registry);
  // context.getOrLoadDialect<mlir::ppu::PPUDialect>();

  // MlirOptMain() si occupa di creare/configurare il context necessario dato un
  // DialectRegistry.
  return mlir::asMainReturnCode(
      mlir::MlirOptMain(argc, argv, "Standalone optimizer driver\n", registry));
}
