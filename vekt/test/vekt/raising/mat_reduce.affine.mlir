// RUN: vekt-opt -ppu-normalize-iterargs-reductions -ppu-raise-affine-to-linalg-generic %s | FileCheck %s

func.func @reduce_into_scalar(%arg0: i32, %arg1: i32, %arg2: memref<?x?xi32>) -> i32 attributes {llvm.linkage = #llvm.linkage<external>} {
    %c0_i32 = arith.constant 0 : i32
    %0 = arith.index_cast %arg0 : i32 to index
    %1 = arith.index_cast %arg1 : i32 to index
    %2 = affine.for %arg3 = 0 to %0 iter_args(%arg4 = %c0_i32) -> (i32) {
      %3 = affine.for %arg5 = 0 to %1 iter_args(%arg6 = %arg4) -> (i32) {
        %4 = affine.load %arg2[%arg3, %arg5] : memref<?x?xi32>
        %5 = arith.addi %arg6, %4 : i32
        affine.yield %5 : i32
      }
      affine.yield %3 : i32
    }
    return %2 : i32
}

// CHECK: #[[$ATTR_0:.+]] = affine_map<(d0, d1) -> (d0, d1)>
// CHECK: #[[$ATTR_1:.+]] = affine_map<(d0, d1) -> ()>
// CHECK-LABEL:   func.func @reduce_into_scalar(
// CHECK-SAME:      %[[ARG0:.*]]: i32, %[[ARG1:.*]]: i32, %[[ARG2:.*]]: memref<?x?xi32>) -> i32 attributes {llvm.linkage = #llvm.linkage<external>} {
// CHECK:           %[[CONSTANT_0:.*]] = arith.constant 0 : i32
// CHECK:           %[[INDEX_CAST_0:.*]] = arith.index_cast %[[ARG0]] : i32 to index
// CHECK:           %[[INDEX_CAST_1:.*]] = arith.index_cast %[[ARG1]] : i32 to index
// CHECK:           %[[ALLOCA_0:.*]] = memref.alloca() : memref<i32>
// CHECK:           affine.store %[[CONSTANT_0]], %[[ALLOCA_0]][] : memref<i32>
// CHECK:           linalg.generic {indexing_maps = [#[[$ATTR_0]], #[[$ATTR_1]]], iterator_types = ["reduction", "reduction"]} ins(%[[ARG2]] : memref<?x?xi32>) outs(%[[ALLOCA_0]] : memref<i32>) {
// CHECK:           ^bb0(%[[VAL_0:.*]]: i32, %[[VAL_1:.*]]: i32):
// CHECK:             %[[ADDI_0:.*]] = arith.addi %[[VAL_1]], %[[VAL_0]] : i32
// CHECK:             linalg.yield %[[ADDI_0]] : i32
// CHECK:           }
// CHECK:           %[[LOAD_0:.*]] = affine.load %[[ALLOCA_0]][] : memref<i32>
// CHECK:           return %[[LOAD_0]] : i32
// CHECK:         }
