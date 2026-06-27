get_property(dialect_libs GLOBAL PROPERTY MLIR_DIALECT_LIBS)
get_property(conversion_libs GLOBAL PROPERTY MLIR_CONVERSION_LIBS)
get_property(extension_libs GLOBAL PROPERTY MLIR_EXTENSION_LIBS)

set(LIBS
    MLIROptLib

    # non presenti in llvm19
    # # MLIRRegisterAllDialects
    # # MLIRRegisterAllPasses
    MLIRMlirOptMain
    ${dialect_libs}
    ${conversion_libs}
    ${extension_libs}

    MLIRPass
    MLIRTransforms
    MLIRTransformUtils

    MLIRPPU
)

# version llvm di add_executable per aggiungere un executable target
add_llvm_executable(vekt-opt vekt-opt.cpp)
# applichiamo i vari flag visti nel root CML qua
llvm_update_compile_flags(vekt-opt)
# linkiamo con le dipendenze
target_link_libraries(vekt-opt PRIVATE ${LIBS})
# check di mlir per l'eseguibile appena creato (don't care).
mlir_check_all_link_libraries(vekt-opt)
