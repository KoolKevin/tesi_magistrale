// RUN: vekt-opt -ppu-normalize-iterargs-reductions -ppu-raise-affine-to-linalg-generic %s | FileCheck %s

func.func @conv1d(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: memref<?xi32>, %arg4: memref<?xi32>, %arg5: memref<?xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %0 = arith.index_cast %arg0 : i32 to index
    %1 = arith.index_cast %arg2 : i32 to index
    affine.for %arg6 = 0 to %0 {
        affine.for %arg7 = 0 to %1 {
            %2 = affine.load %arg4[%arg6 + %arg7] : memref<?xi32>
            %3 = affine.load %arg5[%arg7] : memref<?xi32>
            %4 = arith.muli %2, %3 : i32
            %5 = affine.load %arg3[%arg6] : memref<?xi32>
            %6 = arith.addi %5, %4 : i32
            affine.store %6, %arg3[%arg6] : memref<?xi32>
        }
    }
    return
}

// CHECK: #[[$ATTR_0:.+]] = affine_map<(d0, d1) -> (d0 + d1)>
// CHECK: #[[$ATTR_1:.+]] = affine_map<(d0, d1) -> (d1)>
// CHECK: #[[$ATTR_2:.+]] = affine_map<(d0, d1) -> (d0)>
// CHECK-LABEL:   func.func @conv1d(
// CHECK-SAME:                      %[[ARG0:.*]]: i32, %[[ARG1:.*]]: i32, %[[ARG2:.*]]: i32, %[[ARG3:.*]]: memref<?xi32>, %[[ARG4:.*]]: memref<?xi32>, %[[ARG5:.*]]: memref<?xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
// CHECK:           %[[INDEX_CAST_0:.*]] = arith.index_cast %[[ARG0]] : i32 to index
// CHECK:           %[[INDEX_CAST_1:.*]] = arith.index_cast %[[ARG2]] : i32 to index
// CHECK:           linalg.generic {indexing_maps = [#[[$ATTR_0]], #[[$ATTR_1]], #[[$ATTR_2]]], iterator_types = ["parallel", "reduction"]} ins(%[[ARG4]], %[[ARG5]] : memref<?xi32>, memref<?xi32>) outs(%[[ARG3]] : memref<?xi32>) {
// CHECK:           ^bb0(%[[VAL_0:.*]]: i32, %[[VAL_1:.*]]: i32, %[[VAL_2:.*]]: i32):
// CHECK:             %[[MULI_0:.*]] = arith.muli %[[VAL_0]], %[[VAL_1]] : i32
// CHECK:             %[[ADDI_0:.*]] = arith.addi %[[VAL_2]], %[[MULI_0]] : i32
// CHECK:             linalg.yield %[[ADDI_0]] : i32
// CHECK:           }
// CHECK:           return
// CHECK:         }
