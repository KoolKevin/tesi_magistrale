#ifndef PPU_DIALECT
#define PPU_DIALECT

include "mlir/IR/OpBase.td"

//===----------------------------------------------------------------------===//
// ppu dialect definition.
//===----------------------------------------------------------------------===//

def PPU_Dialect : Dialect {
    // dialect namespace
    let name = "ppu";
    let summary = "Dialetto che rappresenta gli intrinseci LLVM della PPU";
    let description = [{
        Questo dialetto modella gli intrinseci LLVM utilizzati dal compilatore
        Metaware per generare codice vettoriale eseguito dalla Parallel
        Processing Unit dei microcontrollori della famiglia TC4 di Infineon.
        Il dialetto ppu è un dialetto di esportazione con cui si vuole uscire da
        mlir per andare verso llvm-ir.
    }];
    let cppNamespace = "::mlir::ppu";

    // let useDefaultTypePrinterParser = 1;
    // let extraClassDeclaration = [{
    //     void registerTypes();
    // }];
}

//===----------------------------------------------------------------------===//
// Base class for the definition of ppu dialect ops
//===----------------------------------------------------------------------===//

class PPU_Op<string mnemonic, list<Trait> traits = []> :
        Op<PPU_Dialect, mnemonic, traits>;

#endif //PPU_DIALECT
