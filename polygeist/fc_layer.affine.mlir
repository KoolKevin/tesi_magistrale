func.func @fc_layer(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: memref<?x?xi32>, %arg4: memref<?x?xi32>, %arg5: memref<?x?xi32>, %arg6: memref<?xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
  %0 = arith.index_cast %arg0 : i32 to index
  %1 = arith.index_cast %arg1 : i32 to index
  %2 = arith.index_cast %arg2 : i32 to index
  affine.for %arg7 = 0 to %0 {
    affine.for %arg8 = 0 to %1 {
      affine.for %arg9 = 0 to %2 {
        %6 = affine.load %arg3[%arg7, %arg9] : memref<?x?xi32>
        %7 = affine.load %arg4[%arg9, %arg8] : memref<?x?xi32>
        %8 = arith.muli %6, %7 : i32
        %9 = affine.load %arg5[%arg7, %arg8] : memref<?x?xi32>
        %10 = arith.addi %9, %8 : i32
        affine.store %10, %arg5[%arg7, %arg8] : memref<?x?xi32>
      }
      %3 = affine.load %arg6[%arg8] : memref<?xi32>
      %4 = affine.load %arg5[%arg7, %arg8] : memref<?x?xi32>
      %5 = arith.addi %4, %3 : i32
      affine.store %5, %arg5[%arg7, %arg8] : memref<?x?xi32>
    }
  }
  return
}
