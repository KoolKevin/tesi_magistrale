// func.func @matmul(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: memref<?x?xi32>, %arg4: memref<?x?xi32>, %arg5: memref<?x?xi32>) {
//     %0 = arith.index_cast %arg0 : i32 to index
//     %1 = arith.index_cast %arg1 : i32 to index
//     %2 = arith.index_cast %arg2 : i32 to index
//     affine.for %arg6 = 0 to %0 {
//         affine.for %arg7 = 0 to %1 {
//             affine.for %arg8 = 0 to %2 {
//                 %3 = affine.load %arg3[%arg6, %arg8] : memref<?x?xi32>
//                 %4 = affine.load %arg4[%arg8, %arg7] : memref<?x?xi32>
//                 %5 = arith.muli %3, %4 : i32
//                 %6 = affine.load %arg5[%arg6, %arg7] : memref<?x?xi32>
//                 %7 = arith.addi %6, %5 : i32
//                 affine.store %7, %arg5[%arg6, %arg7] : memref<?x?xi32>
//             }
//         }
//     }
//     return
// }

func.func @matmul(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: memref<?x?xi32>, %arg4: memref<?x?xi32>, %arg5: memref<?x?xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %c0_i32 = arith.constant 0 : i32
    %0 = arith.index_cast %arg0 : i32 to index
    %1 = arith.index_cast %arg1 : i32 to index
    %2 = arith.index_cast %arg2 : i32 to index
    affine.for %arg6 = 0 to %0 {
      affine.for %arg7 = 0 to %1 {
        %3 = affine.for %arg8 = 0 to %2 iter_args(%arg9 = %c0_i32) -> (i32) {
          %4 = affine.load %arg3[%arg6, %arg8] : memref<?x?xi32>
          %5 = affine.load %arg4[%arg8, %arg7] : memref<?x?xi32>
          %6 = arith.muli %4, %5 : i32
          %7 = arith.addi %arg9, %6 : i32
          affine.yield %7 : i32
        }
        affine.store %3, %arg5[%arg6, %arg7] : memref<?x?xi32>
      }
    }
    return
}
