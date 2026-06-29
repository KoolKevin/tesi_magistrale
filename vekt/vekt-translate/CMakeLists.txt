# Questa variabile è il modo idiomatico per gestire le librerie LLVM (distinte
# da quelle MLIR). 'LLVM_LINK_COMPONENTS' viene letta da 'add_llvm_executable()'
# - usa 'set(LLVM_LINK_COMPONENTS ...)' per tutto ciò che inizia con llvm::
# - usa 'target_link_libraries(...)' per tutto ciò che inizia con mlir::
set(LLVM_LINK_COMPONENTS
  Support
)

get_property(dialect_libs GLOBAL PROPERTY MLIR_DIALECT_LIBS)
get_property(translation_libs GLOBAL PROPERTY MLIR_TRANSLATION_LIBS)

set(LIBS
    PRIVATE
    ${dialect_libs}
    ${translation_libs}
    MLIRIR
    MLIRParser
    MLIRPass
    MLIRSPIRVDialect
    MLIRTranslateLib
    MLIRSupport

    MLIRPPU
)

# version llvm di add_executable per aggiungere un executable target
add_llvm_executable(vekt-translate vekt-translate.cpp)
# applichiamo i vari flag visti nel root CML qua
llvm_update_compile_flags(vekt-translate)
# linkiamo con le dipendenze
target_link_libraries(vekt-translate PRIVATE ${LIBS})
# check di mlir per l'eseguibile appena creato (don't care).
mlir_check_all_link_libraries(vekt-translate)
