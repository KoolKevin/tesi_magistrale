set(LIBS
    MLIRArithDialect
    MLIROptLib

    # non presenti in llvm19
    # MLIRRegisterAllDialects
    # MLIRRegisterAllPasses
    MLIRMlirOptMain

    # includiamo la libreria creata in lib/ con le sue dipendenze PUBLIC
    MLIRStandalone
  )

# version llvm di add_executable per aggiungere un executable target
add_llvm_executable(vekt-opt vekt-opt.cpp)
# applichiamo i vari flag visti nel root CML qua
llvm_update_compile_flags(vekt-opt)
# linkiamo con le dipendenze
target_link_libraries(vekt-opt PRIVATE ${LIBS})
# check di mlir per l'eseguibile appena creato (don't care).
mlir_check_all_link_libraries(vekt-opt)
