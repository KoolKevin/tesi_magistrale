set(LLVM_TARGET_DEFINITIONS VectorOMPPasses.td)
mlir_tablegen(VectorOMPPasses.h.inc --gen-pass-decls)
add_public_tablegen_target(MLIRVectorOMPPassesIncGen)
