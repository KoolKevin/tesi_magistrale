#include "mlir/InitAllDialects.h"
#include "mlir/Target/LLVMIR/Dialect/Builtin/BuiltinToLLVMIRTranslation.h"
#include "mlir/Target/LLVMIR/Dialect/LLVMIR/LLVMToLLVMIRTranslation.h"
#include "mlir/Target/LLVMIR/ModuleTranslation.h"
#include "mlir/Tools/mlir-translate/MlirTranslateMain.h"
#include "mlir/Tools/mlir-translate/Translation.h"

#include "ppu/PPUDialect.h"
#include "ppu/PPUToLLVMIRTranslation.h"

// Prima del main viene eseguito questo costruttore per registrare delle lambda
// invocate da quest'ultimo
static mlir::TranslateFromMLIRRegistration registration(
    "vekt-to-llvmir", "Translate to LLVM IR",
    // this lambda does the translation
    [](mlir::ModuleOp module, llvm::raw_ostream &output) {
      llvm::LLVMContext llvmContext;
      auto llvmModule = mlir::translateModuleToLLVMIR(module, llvmContext);
      if (!llvmModule)
        return mlir::failure();
      llvmModule->print(output, nullptr);
      return mlir::success();
    },
    // this lambda registers the dialects that need to be known to parse the
    // input mlir that is being translated
    [](mlir::DialectRegistry &registry) {
      mlir::registerAllDialects(registry);
      registry.insert<mlir::ppu::PPUDialect>();
      // registriamo anche le interfacce che definiscono come effettuare la
      // translation. La prima serve per op builtin (a quanto pare solo 'module'
      // da quanto leggo), la seconda serve per le op del dialetto 'llvm' (la
      // maggior parte).
      //
      // Interessante notare che queste interfacce estendono
      // 'LLVMTranslationDialectInterface' che il mio dialetto per la ppu deve
      // implementare
      mlir::registerBuiltinDialectTranslation(registry);
      mlir::registerLLVMDialectTranslation(registry);
      // TODO: questa è ancora da implementare
      mlir::registerPPUDialectTranslation(registry);
    });

int main(int argc, char **argv) {
  return failed(mlir::mlirTranslateMain(argc, argv, "vekt-translate\n"));
}
