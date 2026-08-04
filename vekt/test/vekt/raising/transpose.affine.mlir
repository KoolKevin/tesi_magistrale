// RUN: vekt-opt -ppu-normalize-iterargs-reductions -ppu-raise-affine-to-linalg-generic %s | FileCheck %s

func.func @transpose(%arg0: i32, %arg1: i32, %arg2: memref<?x?xi32>, %arg3: memref<?x?xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %0 = arith.index_cast %arg0 : i32 to index
    %1 = arith.index_cast %arg1 : i32 to index
    affine.for %arg4 = 0 to %0 {
        affine.for %arg5 = 0 to %1 {
            %2 = affine.load %arg2[%arg4, %arg5] : memref<?x?xi32>
            affine.store %2, %arg3[%arg5, %arg4] : memref<?x?xi32>
        }
    }
    return
}
