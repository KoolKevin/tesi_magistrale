  func.func @dotp(%arg0: memref<?xi32>, %arg1: memref<?xi32>, %arg2: i32) -> i32 attributes {llvm.linkage = #llvm.linkage<external>} {
    %c0_i32 = arith.constant 0 : i32
    %0 = arith.index_cast %arg2 : i32 to index
    %1 = affine.for %arg3 = 0 to %0 iter_args(%arg4 = %c0_i32) -> (i32) {
      %2 = affine.load %arg0[%arg3] : memref<?xi32>
      %3 = affine.load %arg1[%arg3] : memref<?xi32>
      %4 = arith.muli %2, %3 : i32
      %5 = arith.addi %arg4, %4 : i32
      affine.yield %5 : i32
    }
    return %1 : i32
  }
