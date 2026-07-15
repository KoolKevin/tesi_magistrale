  func.func @reduce_into_scalar(%arg0: i32, %arg1: i32, %arg2: memref<?x?xi32>) -> i32 attributes {llvm.linkage = #llvm.linkage<external>} {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c0_i32 = arith.constant 0 : i32
    %0 = arith.index_cast %arg0 : i32 to index
    %1 = arith.index_cast %arg1 : i32 to index
    %2 = scf.for %arg3 = %c0 to %0 step %c1 iter_args(%arg4 = %c0_i32) -> (i32) {
      %3 = scf.for %arg5 = %c0 to %1 step %c1 iter_args(%arg6 = %arg4) -> (i32) {
        %4 = memref.load %arg2[%arg3, %arg5] : memref<?x?xi32>
        %5 = arith.addi %arg6, %4 : i32
        scf.yield %5 : i32
      }
      scf.yield %3 : i32
    }
    return %2 : i32
  }

  func.func @reduce_rows(%arg0: i32, %arg1: i32, %arg2: memref<?x?xi32>, %arg3: memref<?xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c0_i32 = arith.constant 0 : i32
    %0 = arith.index_cast %arg0 : i32 to index
    %1 = arith.index_cast %arg1 : i32 to index
    scf.for %arg4 = %c0 to %0 step %c1 {
      %2 = scf.for %arg5 = %c0 to %1 step %c1 iter_args(%arg6 = %c0_i32) -> (i32) {
        %3 = memref.load %arg2[%arg4, %arg5] : memref<?x?xi32>
        %4 = arith.addi %arg6, %3 : i32
        scf.yield %4 : i32
      }
      memref.store %2, %arg3[%arg4] : memref<?xi32>
    }
    return
  }

  func.func @reduce_cols(%arg0: i32, %arg1: i32, %arg2: memref<?x?xi32>, %arg3: memref<?xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c0_i32 = arith.constant 0 : i32
    %0 = arith.index_cast %arg1 : i32 to index
    %1 = arith.index_cast %arg0 : i32 to index
    scf.for %arg4 = %c0 to %0 step %c1 {
      %2 = scf.for %arg5 = %c0 to %1 step %c1 iter_args(%arg6 = %c0_i32) -> (i32) {
        %3 = memref.load %arg2[%arg5, %arg4] : memref<?x?xi32>
        %4 = arith.addi %arg6, %3 : i32
        scf.yield %4 : i32
      }
      memref.store %2, %arg3[%arg4] : memref<?xi32>
    }
    return
  }

