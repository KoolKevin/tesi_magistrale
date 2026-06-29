# Crea una libreria (libMLIRPPU.a) con tutto cio che definisce il dialetto
add_mlir_dialect_library(MLIRPPU
        PPUDialect.cpp
        PPUOps.cpp
        PPUPasses.cpp
        PPUToLLVMIRTranslation.cpp

        ADDITIONAL_HEADER_DIRS
        ${PROJECT_SOURCE_DIR}/include/ppu
        # definiamo come dipendenze i target che generano gli header a partire
        # dai .td. Questo va a definire un ordine di compilazione, e permette
        # di rilevare modifiche ai file .td da cui si dipende.
        DEPENDS
        MLIRPPUOpsIncGen
        MLIRPPUPassesIncGen

        # PUBLIC: chiunque userà la libreria MLIRPPU (include la libreria
        # in target_link_libraries()) erediterà automaticamente anche il link
        # a queste librerie.
        LINK_LIBS PUBLIC
        # questi non sono sempre facili da trovare, guarda i link errors e
        # fai come ti ha insegnato il russo
        MLIRIR
        MLIRInferTypeOpInterface
        MLIRFuncDialect
        )
