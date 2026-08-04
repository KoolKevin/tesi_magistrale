// RUN: vekt-opt -convert-linalg-to-ppu-algorithm -canonicalize %s | FileCheck %s

func.func @reduce_rows(%arg0: i32, %arg1: i32, %arg2: memref<?x?xi32>, %arg3: memref<?xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
    linalg.reduce { arith.addi {overflowFlags = #arith.overflow<none>} } ins(%arg2 : memref<?x?xi32>) outs(%arg3 : memref<?xi32>) dimensions = [1]
    return
}
