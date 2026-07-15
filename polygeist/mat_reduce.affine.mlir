  func.func @reduce_into_scalar(%arg0: i32, %arg1: i32, %arg2: memref<?x?xi32>) -> i32 attributes {llvm.linkage = #llvm.linkage<external>} {
    %c0_i32 = arith.constant 0 : i32
    %0 = arith.index_cast %arg0 : i32 to index
    %1 = arith.index_cast %arg1 : i32 to index
    %2 = affine.for %arg3 = 0 to %0 iter_args(%arg4 = %c0_i32) -> (i32) {
      %3 = affine.for %arg5 = 0 to %1 iter_args(%arg6 = %arg4) -> (i32) {
        %4 = affine.load %arg2[%arg3, %arg5] : memref<?x?xi32>
        %5 = arith.addi %arg6, %4 : i32
        affine.yield %5 : i32
      }
      affine.yield %3 : i32
    }
    return %2 : i32
  }

  func.func @reduce_rows(%arg0: i32, %arg1: i32, %arg2: memref<?x?xi32>, %arg3: memref<?xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %0 = arith.index_cast %arg0 : i32 to index
    %1 = arith.index_cast %arg1 : i32 to index
    affine.for %arg4 = 0 to %0 {
      affine.for %arg5 = 0 to %1 {
        %2 = affine.load %arg2[%arg4, %arg5] : memref<?x?xi32>
        %3 = affine.load %arg3[%arg4] : memref<?xi32>
        %4 = arith.addi %3, %2 : i32
        affine.store %4, %arg3[%arg4] : memref<?xi32>
      }
    }
    return
  }

  func.func @reduce_cols(%arg0: i32, %arg1: i32, %arg2: memref<?x?xi32>, %arg3: memref<?xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %0 = arith.index_cast %arg1 : i32 to index
    %1 = arith.index_cast %arg0 : i32 to index
    affine.for %arg4 = 0 to %0 {
      affine.for %arg5 = 0 to %1 {
        %2 = affine.load %arg2[%arg5, %arg4] : memref<?x?xi32>
        %3 = affine.load %arg3[%arg4] : memref<?xi32>
        %4 = arith.addi %3, %2 : i32
        affine.store %4, %arg3[%arg4] : memref<?xi32>
      }
    }
    return
  }
