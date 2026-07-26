#ifndef PPU_OPS
#define PPU_OPS

include "ppu/PPUDialect.td"

include "mlir/IR/OpBase.td"
include "mlir/IR/CommonTypeConstraints.td"
include "mlir/Dialect/LLVMIR/LLVMOpBase.td"

include "mlir/Interfaces/InferTypeOpInterface.td"
include "mlir/Interfaces/SideEffectInterfaces.td"


// TODO: aggiungi supporto (tramite attributi?) per tipi di dato diversi da int
// e per dimensioni del registro diverse dai full 512 bit
// TODO: sarebbe bene modellare l'addrspace(4) che qualifica i puntatori come
// _vccm pointer
// TODO: sarebbe bene aggiustare anche i tipi dei vettori ammessi (rank 1,
// 8/16/32/64 elementi)

//===----------------------------------------------------------------------===//
// VecLoadOp
//===----------------------------------------------------------------------===//

def PPU_VecLoadOp : PPU_Op<"vec_load", [Pure]> {
    let summary = "Load di un registro vettoriale della PPU";
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

    let arguments = (ins LLVM_AnyPointer:$src);
    let results = (outs AnyVectorOfAnyRank:$res);
}

//===----------------------------------------------------------------------===//
// VecStoreOp
//===----------------------------------------------------------------------===//

def PPU_VecStoreOp : PPU_Op<"vec_store", []> {
    let summary = "Store di un registro vettoriale della PPU";
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
        LLVM_AnyPointer:$dest
    );
}


//===----------------------------------------------------------------------===//
// VecAddOp
//===----------------------------------------------------------------------===//


def PPU_VecAddOp : PPU_Op<"vec_add", [Pure, SameOperandsAndResultType]> {
    let summary = "Somma due registri vettoriali della PPU";
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
}

//===----------------------------------------------------------------------===//
// VecReduceAddOp
//===----------------------------------------------------------------------===//

def PPU_VecReduceAddOp : PPU_Op<"vec_reduce_add", [Pure]> {
    let summary = "Somma gli elementi di un registro vettoriale";

    let description = [{
        Per adesso modella ESATTAMENTE questo intrinseco llvm-ir:

        %25 = tail call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %rdx73)
    }];

    let arguments = (ins
        AnyVectorOfAnyRank:$arg1
    );
    let results = (outs I32:$res);
}

//===----------------------------------------------------------------------===//
// VecMpyLowAccOp
//===----------------------------------------------------------------------===//

def PPU_VecMpyLowAccOp: PPU_Op<"vec_mpy_low_acc", [Pure, SameOperandsAndResultType]> {
    let summary = "Moltiplicazione element-wise di due registri vettoriali"
                  " contenenti INTERI; il risultato viene salvato in un"
                  " registro accumulatore";

    let description = [{
        Per adesso modella ESATTAMENTE questo intrinseco llvm-ir:

        %0 = tail call <16 x i32> @llvm.arc.vvcmpy.lo.acc.w.v512(<16 x i32> zeroinitializer, <16 x i32> zeroinitializer)
    }];

    let arguments = (ins
        AnyVectorOfAnyRank:$arg1,
        AnyVectorOfAnyRank:$arg2
    );
    let results = (outs AnyVectorOfAnyRank:$res);
}

//===----------------------------------------------------------------------===//
// VecMACLowOp
//===----------------------------------------------------------------------===//

def PPU_VecMACLowOp: PPU_Op<"vec_mac_low", [Pure, SameOperandsAndResultType]> {
    let summary = "Moltiplicazione element-wise di due registri vettoriali fusa"
                  " alla somma con un registro accumulatore; dati INTERI";

    let description = [{
        Per adesso modella ESATTAMENTE questo intrinseco llvm-ir:

        %35 = tail call <16 x i32> @llvm.arc.vvcmac.lo.acc.w.v512(<16 x i32> %acc.sroa.0.056, <16 x i32> %33, <16 x i32> %34)
    }];

    let arguments = (ins
        AnyVectorOfAnyRank:$acc,
        AnyVectorOfAnyRank:$arg1,
        AnyVectorOfAnyRank:$arg2
    );
    let results = (outs AnyVectorOfAnyRank:$res);
}

//===----------------------------------------------------------------------===//
// AccToVecOp
//===----------------------------------------------------------------------===//

def PPU_AccToVecOp: PPU_Op<"acc_to_vec", [Pure, SameOperandsAndResultType]> {
    let summary = "converte un registro accumulatore in un registro vettoriale"
                  "senza bit di guardia; dati interi";

    let description = [{
        Per adesso modella ESATTAMENTE questo intrinseco llvm-ir:

        %5 = tail call <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32> %4)
    }];

    let arguments = (ins
        AnyVectorOfAnyRank:$acc,
    );
    let results = (outs AnyVectorOfAnyRank:$res);
}


#endif // PPU_OPS
