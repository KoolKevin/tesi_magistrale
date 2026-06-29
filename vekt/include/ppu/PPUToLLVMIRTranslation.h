// imitato da:
// .../include/mlir/target/LLVMIR/Dialect/Builtin/BuiltinToLLVMIRTranslation.h

#ifndef PPU_TRANSLATION_H
#define PPU_TRANSLATION_H

namespace mlir {

class DialectRegistry;
class MLIRContext;

/// Register the translation from the builtin dialect to the LLVM IR in the
/// given registry.
void registerPPUDialectTranslation(DialectRegistry &registry);

/// Register the translation from the builtin dialect in the registry associated
/// with the given context.
void registerPPUDialectTranslation(MLIRContext &context);

} // namespace mlir

#endif // PPU_TRANSLATION_H
