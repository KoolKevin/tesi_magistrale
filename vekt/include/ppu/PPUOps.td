#ifndef PPU_OPS
#define PPU_OPS

include "ppu/PPUDialect.td"

include "mlir/IR/OpBase.td"
include "mlir/IR/CommonTypeConstraints.td"
include "mlir/Dialect/LLVMIR/LLVMOpBase.td"

include "mlir/Interfaces/InferTypeOpInterface.td"
include "mlir/Interfaces/SideEffectInterfaces.td"

//===----------------------------------------------------------------------===//
// FooOp
//===----------------------------------------------------------------------===//

def PPU_FooOp : PPU_Op<"foo", [Pure, SameOperandsAndResultType]> {
    let summary = "Illustrates how to define an operation.";
    let description = [{
        The `ppu.foo` operation illustrates how to define a new
        operation in a dialect. It uses an operation trait to declare that it
        has no side effects.

        This operation takes an integer argument and returns an integer.

        Example:

        ```mlir
        %0 = arith.constant 2 : i32
        // Apply the foo operation to %0
        %1 = standalone.foo %0 : i32
        ```
    }];

    let arguments = (ins I32:$input);
    let results = (outs I32:$res);

    let assemblyFormat = [{
        $input attr-dict `:` type($input)
    }];
}

//===----------------------------------------------------------------------===//
// VecLoadOp
//===----------------------------------------------------------------------===//

// TODO: completa aggiungendo attributi per la dimensione del registro e
// dimensione del tipo di dato
// TODO: capisci meglio come vengono gestiti i tipi di dato. Le load vettoriali
// della ppu sembrano semplicemente preoccuparsi della dimensione in bit dell'
// elemento (b, h, w, d), sono poi le istruzioni successive a definire come
// interpretare gli elementi nelle lane (ad esempio se faccio vvadd sto facendo
// una somma vettoriale tra interi, mentre se faccio vvfadd sto facendo una
// somma tra float). Nella llvm-ir però, il tipo sembra esserci e quindi forse
// lo devo propagare anche io.
// TODO: vedi se è necessario modellare il 'addrspace(4)' che dice che l'input è
// un _vccm pointer
def PPU_VecLoadOp : PPU_Op<"vec_load", [Pure]> {
    let summary = "Load di un registro vettoriale della PPU";
    // TODO: aggiusta anche la descrizione quando completi l'op
    let description = [{
        Per adesso modella ESATTAMENTE questo intrinseco llvm-ir:

        `%13 = call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %12)`

        Ha un attributo per specificare la dimensione del registro vettoriale
        (128/256/512 bit) e il tipo di dato (byte, half, word, double). Il
        numero di elementi è conseguenza di questi due valori.

        Esempio:

        ```mlir
        %alloc = memref.alloc() : memref<16xi32>
        %0 = "ppu.vec_load"(%alloc) : (memref<16xi32>) -> vector<16xi32>
        ```
    }];

    let arguments = (ins AnyTypeOf<[AnyMemRef, LLVM_AnyPointer]>:$src);
    let results = (outs AnyVectorOfAnyRank:$res);

    // let assemblyFormat = [{
    //     $src attr-dict `:` type($res)
    // }];
}

//===----------------------------------------------------------------------===//
// VecStoreOp
//===----------------------------------------------------------------------===//

// TODO: completa aggiungendo attributi per la dimensione del registro e
// dimensione del tipo di dato
// TODO: capisci meglio come vengono gestiti i tipi di dato. Le load vettoriali
// della ppu sembrano semplicemente preoccuparsi della dimensione in bit dell'
// elemento (b, h, w, d), sono poi le istruzioni successive a definire come
// interpretare gli elementi nelle lane (ad esempio se faccio vvadd sto facendo
// una somma vettoriale tra interi, mentre se faccio vvfadd sto facendo una
// somma tra float). Nella llvm-ir però, il tipo sembra esserci e quindi forse
// lo devo propagare anche io.
// TODO: vedi se è necessario modellare il 'addrspace(4)' che dice che l'input è
// un _vccm pointer
def PPU_VecStoreOp : PPU_Op<"vec_store", []> {
    let summary = "Store di un registro vettoriale della PPU";
    // TODO: aggiusta anche la descrizione quando completi l'op
    let description = [{
        Per adesso modella ESATTAMENTE questo intrinseco llvm-ir:

        `call void @llvm.arc.vvst.w.v512(<16 x i32> %23, ptr addrspace(4) %24)`

        Ha un attributo per specificare la dimensione del registro vettoriale
        (128/256/512 bit) e il tipo di dato (byte, half, word, double). Il
        numero di elementi è conseguenza di questi due valori.

        Esempio:

        ```mlir
        %alloc = memref.alloc() : memref<16xi32>
        %0 = "ppu.vec_load"(%alloc) : (memref<16xi32>) -> vector<16xi32>
        "ppu.vec_store"(%0, %alloc) : (vector<16xi32>, memref<16xi32>) -> ()
        ```
    }];

    let arguments = (ins
        AnyVectorOfAnyRank:$vecToStore,
        AnyTypeOf<[AnyMemRef, LLVM_AnyPointer]>:$dest
    );

    // let assemblyFormat = [{
    //     $src attr-dict `:` type($res)
    // }];
}


//===----------------------------------------------------------------------===//
// VecAddOp
//===----------------------------------------------------------------------===//

// TODO: completa aggiungendo attributi per la dimensione del registro e
// dimensione del tipo di dato
// TODO: capisci meglio come vengono gestiti i tipi di dato. Le load vettoriali
// della ppu sembrano semplicemente preoccuparsi della dimensione in bit dell'
// elemento (b, h, w, d), sono poi le istruzioni successive a definire come
// interpretare gli elementi nelle lane (ad esempio se faccio vvadd sto facendo
// una somma vettoriale tra interi, mentre se faccio vvfadd sto facendo una
// somma tra float). Nella llvm-ir però, il tipo sembra esserci e quindi forse
// lo devo propagare anche io.
// TODO: vedi se è necessario modellare il 'addrspace(4)' che dice che l'input è
// un _vccm pointer
def PPU_VecAddOp : PPU_Op<"vec_add", [Pure, SameOperandsAndResultType]> {
    let summary = "Somma due registri vettoriali della PPU";
    // TODO: aggiusta anche la descrizione quando completi l'op
    let description = [{
        Per adesso modella ESATTAMENTE questo intrinseco llvm-ir:

        %18 = call <16 x i32> @llvm.arc.vvadd.w.v512(<16 x i32> %16, <16 x i32> %17)

        Ha un attributo per specificare la dimensione del registro vettoriale
        (128/256/512 bit) e il tipo di dato (byte, half, word, double). Il
        numero di elementi è conseguenza di questi due valori.

        Esempio:

        ```mlir
        %alloc = memref.alloc() : memref<16xi32>
        %0 = "ppu.vec_load"(%alloc) : (memref<16xi32>) -> vector<16xi32>
        %1 = "ppu.vec_add"(%0, %0) : (vector<16xi32>, vector<16xi32>) -> vector<16xi32>
        "ppu.vec_store"(%1, %alloc) : (vector<16xi32>, memref<16xi32>) -> ()
        ```
    }];

    let arguments = (ins
        AnyVectorOfAnyRank:$arg1,
        AnyVectorOfAnyRank:$arg2
    );
    let results = (outs AnyVectorOfAnyRank:$res);

    // let assemblyFormat = [{
    //     $src attr-dict `:` type($res)
    // }];
}







#endif // PPU_OPS
