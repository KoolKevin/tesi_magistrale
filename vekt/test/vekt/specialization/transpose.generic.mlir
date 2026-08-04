// RUN: vekt-opt -ppu-specialize-linalg-generic %s | FileCheck %s

#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1, d0)>
module {
  func.func @transpose(%arg0: i32, %arg1: i32, %arg2: memref<?x?xi32>, %arg3: memref<?x?xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %0 = arith.index_cast %arg0 : i32 to index
    %1 = arith.index_cast %arg1 : i32 to index
    linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel"]} ins(%arg2 : memref<?x?xi32>) outs(%arg3 : memref<?x?xi32>) {
    ^bb0(%in: i32, %out: i32):
      linalg.yield %in : i32
    }
    return
  }
}

// CHECK-LABEL:   func.func @transpose(
// CHECK-SAME:      %[[ARG0:.*]]: i32, %[[ARG1:.*]]: i32, %[[ARG2:.*]]: memref<?x?xi32>, %[[ARG3:.*]]: memref<?x?xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
// CHECK:           %[[INDEX_CAST_0:.*]] = arith.index_cast %[[ARG0]] : i32 to index
// CHECK:           %[[INDEX_CAST_1:.*]] = arith.index_cast %[[ARG1]] : i32 to index
// CHECK:           linalg.transpose ins(%[[ARG2]] : memref<?x?xi32>) outs(%[[ARG3]] : memref<?x?xi32>) permutation = [1, 0]
// CHECK:           return
// CHECK:         }
