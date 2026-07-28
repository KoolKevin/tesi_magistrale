// RUN: vekt-opt -vekt16 %s | FileCheck %s

module {
  func.func @matmul(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: memref<?x?xi32>, %arg4: memref<?x?xi32>, %arg5: memref<?x?xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
    linalg.matmul ins(%arg3, %arg4 : memref<?x?xi32>, memref<?x?xi32>) outs(%arg5 : memref<?x?xi32>)
    return
  }
}
