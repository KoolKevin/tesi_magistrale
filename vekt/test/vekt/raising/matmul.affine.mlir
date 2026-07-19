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

// RUN: vekt-opt -ppu-normalize-iterargs-reductions -ppu-raise-affine-to-linalg-generic %s | FileCheck %s

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

// CHECK: #[[$ATTR_0:.+]] = affine_map<(d0, d1) -> (d0, d1)>
// CHECK: #[[$ATTR_1:.+]] = affine_map<(d0, d1, d2) -> (d0, d2)>
// CHECK: #[[$ATTR_2:.+]] = affine_map<(d0, d1, d2) -> (d2, d1)>
// CHECK: #[[$ATTR_3:.+]] = affine_map<(d0, d1, d2) -> (d0, d1)>
// CHECK-LABEL:   func.func @matmul(
// CHECK-SAME:                      %[[ARG0:.*]]: i32, %[[ARG1:.*]]: i32, %[[ARG2:.*]]: i32, %[[ARG3:.*]]: memref<?x?xi32>, %[[ARG4:.*]]: memref<?x?xi32>, %[[ARG5:.*]]: memref<?x?xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
// CHECK:           %[[CONSTANT_0:.*]] = arith.constant 0 : i32
// CHECK:           %[[INDEX_CAST_0:.*]] = arith.index_cast %[[ARG0]] : i32 to index
// CHECK:           %[[INDEX_CAST_1:.*]] = arith.index_cast %[[ARG1]] : i32 to index
// CHECK:           %[[INDEX_CAST_2:.*]] = arith.index_cast %[[ARG2]] : i32 to index
// CHECK:           linalg.generic {indexing_maps = [#[[$ATTR_0]]], iterator_types = ["parallel", "parallel"]} outs(%[[ARG5]] : memref<?x?xi32>) {
// CHECK:           ^bb0(%[[VAL_0:.*]]: i32):
// CHECK:             linalg.yield %[[CONSTANT_0]] : i32
// CHECK:           }
// CHECK:           linalg.generic {indexing_maps = [#[[$ATTR_1]], #[[$ATTR_2]], #[[$ATTR_3]]], iterator_types = ["parallel", "parallel", "reduction"]} ins(%[[ARG3]], %[[ARG4]] : memref<?x?xi32>, memref<?x?xi32>) outs(%[[ARG5]] : memref<?x?xi32>) {
// CHECK:           ^bb0(%[[VAL_1:.*]]: i32, %[[VAL_2:.*]]: i32, %[[VAL_3:.*]]: i32):
// CHECK:             %[[MULI_0:.*]] = arith.muli %[[VAL_1]], %[[VAL_2]] : i32
// CHECK:             %[[ADDI_0:.*]] = arith.addi %[[VAL_3]], %[[MULI_0]] : i32
// CHECK:             linalg.yield %[[ADDI_0]] : i32
// CHECK:           }
// CHECK:           return
// CHECK:         }
