module {
  func.func @transpose(%arg0: i32, %arg1: i32, %arg2: memref<?x?xi32>, %arg3: memref<?x?xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
    linalg.transpose ins(%arg2 : memref<?x?xi32>) outs(%arg3 : memref<?x?xi32>) permutation = [1, 0]
    return
  }
}
