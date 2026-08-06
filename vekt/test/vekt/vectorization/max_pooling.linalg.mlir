// RUN: vekt-opt -convert-linalg-to-ppu-algorithm -canonicalize %s | FileCheck %s

func.func @max_pooling(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: memref<?x?xi32>, %arg6: memref<?x?xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %c-1_i32 = arith.constant -1 : i32
    %0 = arith.index_cast %arg4 : i32 to index
    %1 = arith.index_cast %arg0 : i32 to index
    %2 = arith.index_cast %arg1 : i32 to index
    affine.for %arg7 = 0 to %1 {
      affine.for %arg8 = 0 to %2 {
        affine.store %c-1_i32, %arg5[%arg7, %arg8] : memref<?x?xi32>
      }
    }
    "ppu.max_pool_2d"(%arg6, %0, %arg5) : (memref<?x?xi32>, index, memref<?x?xi32>) -> ()

    return
}
