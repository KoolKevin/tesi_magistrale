func.func @matmul(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: memref<?x?xi32>, %arg4: memref<?x?xi32>, %arg5: memref<?x?xi32>) {
    %0 = arith.index_cast %arg0 : i32 to index
    %1 = arith.index_cast %arg1 : i32 to index
    %2 = arith.index_cast %arg2 : i32 to index
    affine.for %arg6 = 0 to %0 {
        affine.for %arg7 = 0 to %1 {
            affine.for %arg8 = 0 to %2 {
                %3 = affine.load %arg3[%arg6, %arg8] : memref<?x?xi32>
                %4 = affine.load %arg4[%arg8, %arg7] : memref<?x?xi32>
                %5 = arith.muli %3, %4 : i32
                %6 = affine.load %arg5[%arg6, %arg7] : memref<?x?xi32>
                %7 = arith.addi %6, %5 : i32
                affine.store %7, %arg5[%arg6, %arg7] : memref<?x?xi32>
            }
        }
    }
    return
}
