// RUN: vekt-opt -convert-linalg-to-ppu-algorithm -canonicalize %s | FileCheck %s

func.func @max_pooling(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: memref<?x?xi32>, %arg6: memref<?x?xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %0 = arith.index_cast %arg4 : i32 to index
    "ppu.max_pool_2d"(%arg6, %0, %arg5) : (memref<?x?xi32>, index, memref<?x?xi32>) -> ()

    return
}
