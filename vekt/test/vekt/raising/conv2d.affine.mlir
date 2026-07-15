// questa è la versione senza controllo delle dimensioni
func.func @conv2d(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: memref<?x?xi32>, %arg6: memref<?x?xi32>, %arg7: memref<?x?xi32>) -> i32 {
    %c0_i32 = arith.constant 0 : i32
    %0 = arith.index_cast %arg0 : i32 to index
    %1 = arith.index_cast %arg1 : i32 to index
    %2 = arith.index_cast %arg4 : i32 to index
    affine.for %arg8 = 0 to %0 {
      affine.for %arg9 = 0 to %1 {
        affine.for %arg10 = 0 to %2 {
          affine.for %arg11 = 0 to %2 {
            %3 = affine.load %arg6[%arg8 + %arg10, %arg9 + %arg11] : memref<?x?xi32>
            %4 = affine.load %arg7[%arg10, %arg11] : memref<?x?xi32>
            %5 = arith.muli %3, %4 : i32
            %6 = affine.load %arg5[%arg8, %arg9] : memref<?x?xi32>
            %7 = arith.addi %6, %5 : i32
            affine.store %7, %arg5[%arg8, %arg9] : memref<?x?xi32>
          }
        }
      }
    }
    return %c0_i32 : i32
}
