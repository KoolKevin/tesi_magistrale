// questa è la versione senza controllo delle dimensioni
// func.func @conv2d(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: memref<?x?xi32>, %arg6: memref<?x?xi32>, %arg7: memref<?x?xi32>) -> i32 {
//     %c0_i32 = arith.constant 0 : i32
//     %0 = arith.index_cast %arg0 : i32 to index
//     %1 = arith.index_cast %arg1 : i32 to index
//     %2 = arith.index_cast %arg4 : i32 to index
//     affine.for %arg8 = 0 to %0 {
//       affine.for %arg9 = 0 to %1 {
//         affine.for %arg10 = 0 to %2 {
//           affine.for %arg11 = 0 to %2 {
//             %3 = affine.load %arg6[%arg8 + %arg10, %arg9 + %arg11] : memref<?x?xi32>
//             %4 = affine.load %arg7[%arg10, %arg11] : memref<?x?xi32>
//             %5 = arith.muli %3, %4 : i32
//             %6 = affine.load %arg5[%arg8, %arg9] : memref<?x?xi32>
//             %7 = arith.addi %6, %5 : i32
//             affine.store %7, %arg5[%arg8, %arg9] : memref<?x?xi32>
//           }
//         }
//       }
//     }
//     return %c0_i32 : i32
// }

// RUN: vekt-opt -ppu-normalize-iterargs-reductions -ppu-raise-affine-to-linalg-generic %s | FileCheck %s

func.func @conv2d(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: memref<?x?xi32>, %arg6: memref<?x?xi32>, %arg7: memref<?x?xi32>) -> i32 attributes {llvm.linkage = #llvm.linkage<external>} {
    %c0_i32 = arith.constant 0 : i32
    %0 = arith.index_cast %arg0 : i32 to index
    %1 = arith.index_cast %arg1 : i32 to index
    %2 = arith.index_cast %arg4 : i32 to index
    affine.for %arg8 = 0 to %0 {
      affine.for %arg9 = 0 to %1 {
        %3 = affine.for %arg10 = 0 to %2 iter_args(%arg11 = %c0_i32) -> (i32) {
          %4 = affine.for %arg12 = 0 to %2 iter_args(%arg13 = %arg11) -> (i32) {
            %5 = affine.load %arg6[%arg8 + %arg10, %arg9 + %arg12] : memref<?x?xi32>
            %6 = affine.load %arg7[%arg10, %arg12] : memref<?x?xi32>
            %7 = arith.muli %5, %6 : i32
            %8 = arith.addi %arg13, %7 : i32
            affine.yield %8 : i32
          }
          affine.yield %4 : i32
        }
        affine.store %3, %arg5[%arg8, %arg9] : memref<?x?xi32>
      }
    }
    return %c0_i32 : i32
}

// CHECK: #[[$ATTR_0:.+]] = affine_map<(d0, d1) -> (d0, d1)>
// CHECK: #[[$ATTR_1:.+]] = affine_map<(d0, d1, d2, d3) -> (d0 + d2, d1 + d3)>
// CHECK: #[[$ATTR_2:.+]] = affine_map<(d0, d1, d2, d3) -> (d2, d3)>
// CHECK: #[[$ATTR_3:.+]] = affine_map<(d0, d1, d2, d3) -> (d0, d1)>
// CHECK-LABEL:   func.func @conv2d(
// CHECK-SAME:                      %[[ARG0:.*]]: i32, %[[ARG1:.*]]: i32, %[[ARG2:.*]]: i32, %[[ARG3:.*]]: i32, %[[ARG4:.*]]: i32, %[[ARG5:.*]]: memref<?x?xi32>, %[[ARG6:.*]]: memref<?x?xi32>, %[[ARG7:.*]]: memref<?x?xi32>) -> i32 attributes {llvm.linkage = #llvm.linkage<external>} {
// CHECK:           %[[CONSTANT_0:.*]] = arith.constant 0 : i32
// CHECK:           %[[INDEX_CAST_0:.*]] = arith.index_cast %[[ARG0]] : i32 to index
// CHECK:           %[[INDEX_CAST_1:.*]] = arith.index_cast %[[ARG1]] : i32 to index
// CHECK:           %[[INDEX_CAST_2:.*]] = arith.index_cast %[[ARG4]] : i32 to index
// CHECK:           linalg.generic {indexing_maps = [#[[$ATTR_0]]], iterator_types = ["parallel", "parallel"]} outs(%[[ARG5]] : memref<?x?xi32>) {
// CHECK:           ^bb0(%[[VAL_0:.*]]: i32):
// CHECK:             linalg.yield %[[CONSTANT_0]] : i32
// CHECK:           }
// CHECK:           linalg.generic {indexing_maps = [#[[$ATTR_1]], #[[$ATTR_2]], #[[$ATTR_3]]], iterator_types = ["parallel", "parallel", "reduction", "reduction"]} ins(%[[ARG6]], %[[ARG7]] : memref<?x?xi32>, memref<?x?xi32>) outs(%[[ARG5]] : memref<?x?xi32>) {
// CHECK:           ^bb0(%[[VAL_1:.*]]: i32, %[[VAL_2:.*]]: i32, %[[VAL_3:.*]]: i32):
// CHECK:             %[[MULI_0:.*]] = arith.muli %[[VAL_1]], %[[VAL_2]] : i32
// CHECK:             %[[ADDI_0:.*]] = arith.addi %[[VAL_3]], %[[MULI_0]] : i32
// CHECK:             linalg.yield %[[ADDI_0]] : i32
// CHECK:           }
// CHECK:           return %[[CONSTANT_0]] : i32
// CHECK:         }
