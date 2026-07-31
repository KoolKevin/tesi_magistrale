// RUN: vekt-opt -vekt16 %s | FileCheck %s

// NB: Specializzato da generic utilizzando mlir23
// build/bin/vekt-opt -ppu-normalize-iterargs-reductions -ppu-raise-affine-to-linalg-generic test/vekt/raising/conv2d.affine.mlir
//      | ~/llvm-project/build/bin/mlir-opt -linalg-morph-ops="generic-to-named"
func.func @conv2d(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: memref<?x?xi32>, %arg6: memref<?x?xi32>, %arg7: memref<?x?xi32>) {
    linalg.conv_2d ins(%arg6, %arg7 : memref<?x?xi32>, memref<?x?xi32>) outs(%arg5 : memref<?x?xi32>)
    return
}
