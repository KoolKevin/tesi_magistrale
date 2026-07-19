// RUN: vekt-opt -ppu-normalize-iterargs-reductions -ppu-raise-affine-to-linalg-generic %s | FileCheck %s

func.func @dotp(%arg0: memref<?xi32>, %arg1: memref<?xi32>, %arg2: i32) -> i32 attributes {llvm.linkage = #llvm.linkage<external>} {
    %c0_i32 = arith.constant 0 : i32
    %0 = arith.index_cast %arg2 : i32 to index
    %1 = affine.for %arg3 = 0 to %0 iter_args(%arg4 = %c0_i32) -> (i32) {
      %2 = affine.load %arg0[%arg3] : memref<?xi32>
      %3 = affine.load %arg1[%arg3] : memref<?xi32>
      %4 = arith.muli %2, %3 : i32
      %5 = arith.addi %arg4, %4 : i32
      affine.yield %5 : i32
    }
    return %1 : i32
}

// CHECK: #[[$ATTR_0:.+]] = affine_map<(d0) -> (d0)>
// CHECK: #[[$ATTR_1:.+]] = affine_map<(d0) -> ()>
// CHECK-LABEL:   func.func @dotp(
// CHECK-SAME:                    %[[ARG0:.*]]: memref<?xi32>, %[[ARG1:.*]]: memref<?xi32>, %[[ARG2:.*]]: i32) -> i32 attributes {llvm.linkage = #llvm.linkage<external>} {
// CHECK:           %[[CONSTANT_0:.*]] = arith.constant 0 : i32
// CHECK:           %[[INDEX_CAST_0:.*]] = arith.index_cast %[[ARG2]] : i32 to index
// CHECK:           %[[ALLOCA_0:.*]] = memref.alloca() : memref<i32>
// CHECK:           affine.store %[[CONSTANT_0]], %[[ALLOCA_0]][] : memref<i32>
// CHECK:           linalg.generic {indexing_maps = [#[[$ATTR_0]], #[[$ATTR_0]], #[[$ATTR_1]]], iterator_types = ["reduction"]} ins(%[[ARG0]], %[[ARG1]] : memref<?xi32>, memref<?xi32>) outs(%[[ALLOCA_0]] : memref<i32>) {
// CHECK:           ^bb0(%[[VAL_0:.*]]: i32, %[[VAL_1:.*]]: i32, %[[VAL_2:.*]]: i32):
// CHECK:             %[[MULI_0:.*]] = arith.muli %[[VAL_0]], %[[VAL_1]] : i32
// CHECK:             %[[ADDI_0:.*]] = arith.addi %[[VAL_2]], %[[MULI_0]] : i32
// CHECK:             linalg.yield %[[ADDI_0]] : i32
// CHECK:           }
// CHECK:           %[[LOAD_0:.*]] = affine.load %[[ALLOCA_0]][] : memref<i32>
// CHECK:           return %[[LOAD_0]] : i32
// CHECK:         }
