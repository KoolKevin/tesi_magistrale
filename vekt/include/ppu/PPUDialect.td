#ifndef PPU_DIALECT
#define PPU_DIALECT

include "mlir/IR/OpBase.td"

//===----------------------------------------------------------------------===//
// ppu dialect definition.
//===----------------------------------------------------------------------===//

def PPU_Dialect : Dialect {
    // dialect namespace
    let name = "ppu"; 
    let summary = "un dialetto che rappresenta gli intrinseci della PPU";
    let description = [{
        aggiungi descrizione quando hai completato
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
