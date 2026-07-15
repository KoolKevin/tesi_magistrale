  func.func @conv1d(%arg0: memref<?xi32>, %arg1: memref<?xi32>, %arg2: i32, %arg3: memref<?xi32>, %arg4: i32) attributes {llvm.linkage = #llvm.linkage<external>} {
    %c-1_i32 = arith.constant -1 : i32
    %c2_i32 = arith.constant 2 : i32
    %0 = arith.addi %arg4, %c-1_i32 : i32
    %1 = arith.divsi %0, %c2_i32 : i32
    %2 = arith.muli %1, %c2_i32 : i32
    %3 = arith.subi %arg2, %2 : i32
    %4 = arith.index_cast %3 : i32 to index
    %5 = arith.index_cast %arg4 : i32 to index
    affine.for %arg5 = 0 to %4 {
      affine.for %arg6 = 0 to %5 {
        %6 = affine.load %arg1[%arg5 + %arg6] : memref<?xi32>
        %7 = affine.load %arg3[%arg6] : memref<?xi32>
        %8 = arith.muli %6, %7 : i32
        %9 = affine.load %arg0[%arg5] : memref<?xi32>
        %10 = arith.addi %9, %8 : i32
        affine.store %10, %arg0[%arg5] : memref<?xi32>
      }
    }
    return
  }

