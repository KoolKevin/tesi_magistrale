module {
  func.func @vec_sum(%arg0: memref<?xi32>, %arg1: memref<?xi32>, %arg2: memref<?xi32>, %arg3: i32) {
    %0 = arith.index_cast %arg3 : i32 to index
    affine.for %arg4 = 0 to %0 step 16 {
        %1 = ub.poison : i32
        %2 = vector.transfer_read %arg0[%arg4], %1 : memref<?xi32>, vector<16xi32>
        %3 = ub.poison : i32
        %4 = vector.transfer_read %arg1[%arg4], %3 : memref<?xi32>, vector<16xi32>
        %5 = arith.addi %2, %4 : vector<16xi32>
        vector.transfer_write %5, %arg2[%arg4] : vector<16xi32>, memref<?xi32>
    }

    return
  }
}
