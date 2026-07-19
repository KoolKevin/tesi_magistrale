// RUN: vekt-opt -ppu-normalize-iterargs-reductions -ppu-raise-affine-to-linalg-generic %s | FileCheck %s

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

// CHECK: #[[$ATTR_0:.+]] = affine_map<(d0, d1) -> (d0 + d1)>
// CHECK: #[[$ATTR_1:.+]] = affine_map<(d0, d1) -> (d1)>
// CHECK: #[[$ATTR_2:.+]] = affine_map<(d0, d1) -> (d0)>
// CHECK-LABEL:   func.func @conv1d(
// CHECK-SAME:                      %[[ARG0:.*]]: memref<?xi32>, %[[ARG1:.*]]: memref<?xi32>, %[[ARG2:.*]]: i32, %[[ARG3:.*]]: memref<?xi32>, %[[ARG4:.*]]: i32) attributes {llvm.linkage = #llvm.linkage<external>} {
// CHECK:           %[[CONSTANT_0:.*]] = arith.constant -1 : i32
// CHECK:           %[[CONSTANT_1:.*]] = arith.constant 2 : i32
// CHECK:           %[[ADDI_0:.*]] = arith.addi %[[ARG4]], %[[CONSTANT_0]] : i32
// CHECK:           %[[DIVSI_0:.*]] = arith.divsi %[[ADDI_0]], %[[CONSTANT_1]] : i32
// CHECK:           %[[MULI_0:.*]] = arith.muli %[[DIVSI_0]], %[[CONSTANT_1]] : i32
// CHECK:           %[[SUBI_0:.*]] = arith.subi %[[ARG2]], %[[MULI_0]] : i32
// CHECK:           %[[INDEX_CAST_0:.*]] = arith.index_cast %[[SUBI_0]] : i32 to index
// CHECK:           %[[INDEX_CAST_1:.*]] = arith.index_cast %[[ARG4]] : i32 to index
// CHECK:           linalg.generic {indexing_maps = [#[[$ATTR_0]], #[[$ATTR_1]], #[[$ATTR_2]]], iterator_types = ["parallel", "reduction"]} ins(%[[ARG1]], %[[ARG3]] : memref<?xi32>, memref<?xi32>) outs(%[[ARG0]] : memref<?xi32>) {
// CHECK:           ^bb0(%[[VAL_0:.*]]: i32, %[[VAL_1:.*]]: i32, %[[VAL_2:.*]]: i32):
// CHECK:             %[[MULI_1:.*]] = arith.muli %[[VAL_0]], %[[VAL_1]] : i32
// CHECK:             %[[ADDI_1:.*]] = arith.addi %[[VAL_2]], %[[MULI_1]] : i32
// CHECK:             linalg.yield %[[ADDI_1]] : i32
// CHECK:           }
// CHECK:           return
// CHECK:         }
