// RUN: vekt-opt -ppu-normalize-iterargs-reductions -ppu-raise-affine-to-linalg-generic %s | FileCheck %s

func.func @reduce_rows(%arg0: i32, %arg1: i32, %arg2: memref<?x?xi32>, %arg3: memref<?xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %0 = arith.index_cast %arg0 : i32 to index
    %1 = arith.index_cast %arg1 : i32 to index
    affine.for %arg4 = 0 to %0 {
      affine.for %arg5 = 0 to %1 {
        %2 = affine.load %arg2[%arg4, %arg5] : memref<?x?xi32>
        %3 = affine.load %arg3[%arg4] : memref<?xi32>
        %4 = arith.addi %3, %2 : i32
        affine.store %4, %arg3[%arg4] : memref<?xi32>
      }
    }
    return
}

// CHECK: #[[$ATTR_0:.+]] = affine_map<(d0, d1) -> (d0, d1)>
// CHECK: #[[$ATTR_1:.+]] = affine_map<(d0, d1) -> (d0)>
// CHECK-LABEL:   func.func @reduce_rows(
// CHECK-SAME:      %[[ARG0:.*]]: i32, %[[ARG1:.*]]: i32, %[[ARG2:.*]]: memref<?x?xi32>, %[[ARG3:.*]]: memref<?xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
// CHECK:           %[[INDEX_CAST_0:.*]] = arith.index_cast %[[ARG0]] : i32 to index
// CHECK:           %[[INDEX_CAST_1:.*]] = arith.index_cast %[[ARG1]] : i32 to index
// CHECK:           linalg.generic {indexing_maps = [#[[$ATTR_0]], #[[$ATTR_1]]], iterator_types = ["parallel", "reduction"]} ins(%[[ARG2]] : memref<?x?xi32>) outs(%[[ARG3]] : memref<?xi32>) {
// CHECK:           ^bb0(%[[VAL_0:.*]]: i32, %[[VAL_1:.*]]: i32):
// CHECK:             %[[ADDI_0:.*]] = arith.addi %[[VAL_1]], %[[VAL_0]] : i32
// CHECK:             linalg.yield %[[ADDI_0]] : i32
// CHECK:           }
// CHECK:           return
// CHECK:         }
