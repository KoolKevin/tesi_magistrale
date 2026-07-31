// RUN: vekt-opt -vekt16 %s | FileCheck %s

// NB: Specializzato da generic utilizzando mlir23
// build/bin/vekt-opt -ppu-normalize-iterargs-reductions -ppu-raise-affine-to-linalg-generic test/vekt/raising/conv1d.affine.mlir
//      | ~/llvm-project/build/bin/mlir-opt -linalg-morph-ops="generic-to-named"
func.func @conv1d(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: memref<?xi32>, %arg4: memref<?xi32>, %arg5: memref<?xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
    linalg.conv_1d ins(%arg4, %arg5 : memref<?xi32>, memref<?xi32>) outs(%arg3 : memref<?xi32>)
    return
}
