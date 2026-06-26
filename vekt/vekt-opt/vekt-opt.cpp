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

#include "Standalone/StandaloneDialect.h"
#include "Standalone/StandalonePasses.h"

int main(int argc, char **argv) {
  mlir::registerAllPasses();
  mlir::standalone::registerPasses();

  mlir::PassPipelineRegistration<>(
      "vekt16", "naive vectorization", [](mlir::OpPassManager &pm) {
        pm.addPass(mlir::createCanonicalizerPass());
        mlir::affine::AffineVectorizeOptions vectorizeOpts;
        vectorizeOpts.vectorSizes = {16};
        pm.addPass(mlir::affine::createAffineVectorize(vectorizeOpts));

        // lower to llvm
        pm.addPass(mlir::createLowerAffinePass());
        pm.addPass(mlir::createConvertSCFToCFPass());
        // NB: una memref NON è solo un puntatore, è una struct con 5 campi
        // - allocated pointer: puntatore restituito da malloc o altro
        //   allocator che bisognerà passare a free.
        //   - Non è sempre l'indirizzo dell'elemento [0]!
        //   - Es:
        //     - buffer con header/metadati iniziali
        //     - slice su buffer esistente
        // - aligned pointer: indirizzo dell'elemento [0] allineato in base a
        //   come richiesto.
        // - offset: la differenza tra allocated pointer e aligned pointer
        // - sizes: un array di interi grande quanto il rango del tensore
        //   contenente le sue dimensioni
        // - strides: un array grande quanto il rango del tensore contenente un
        // intero per dimensione che rappresenta la distanza (in elementi) tra
        // elementi adiacenti in quella dimensione.
        //   - Es: for a contiguous row-major array the strides are
        //   [size[1]*size[2]*..., size[2]*..., ..., 1]
        //
        // Tutto questo per arrivare a dire che, se faccio un lowering senza
        // specificare nulla, le memref vengono espanse nei loro 5 campi. Nel
        // caso delle funzioni, questo modifica le firme e rompe l'ABI con i
        // chiamanti. Devo usare quindi usare l'opzione sotto
        mlir::ConvertFuncToLLVMPassOptions funcToLLVMOpts;
        // FIXME: NON STA FUNZIONANDO!!! Il lowering fallisce per motivi
        // misteriosi. Per adesso lascio stare e uso un wrapper lato chiamante
        // - ho scoperto perchè fallisce... il lowering di memrefs con
        // dimensione dinamica non è supportato 😭​
        // https://mlir.llvm.org/doxygen/LLVMCommon_2TypeConverter_8cpp_source.html#l00593
        // - mi sa che dovrò fare un passo a mano
        funcToLLVMOpts.useBarePtrCallConv = false;
        pm.addPass(mlir::createConvertFuncToLLVMPass(funcToLLVMOpts));

        pm.addPass(mlir::createConvertControlFlowToLLVMPass());
        pm.addPass(mlir::createConvertVectorToLLVMPass());
        pm.addPass(mlir::createArithToLLVMConversionPass());
        pm.addPass(mlir::createUBToLLVMConversionPass());
        pm.addPass(mlir::createFinalizeMemRefToLLVMConversionPass());
        pm.addPass(mlir::createReconcileUnrealizedCastsPass());

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
