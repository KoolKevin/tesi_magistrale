// RUN: vekt-opt -ppu-specialize-linalg-generic %s | FileCheck %s

#map = affine_map<(d0, d1) -> (d1, d0)>
#map1 = affine_map<(d0, d1) -> (d0)>
module {
  func.func @reduce_cols(%arg0: i32, %arg1: i32, %arg2: memref<?x?xi32>, %arg3: memref<?xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
    linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "reduction"]} ins(%arg2 : memref<?x?xi32>) outs(%arg3 : memref<?xi32>) {
    ^bb0(%in: i32, %out: i32):
      %0 = arith.addi %out, %in : i32
      linalg.yield %0 : i32
    }
    return
  }
}

// CHECK-LABEL:   func.func @reduce_cols(
// CHECK-SAME:      %[[ARG0:.*]]: i32, %[[ARG1:.*]]: i32, %[[ARG2:.*]]: memref<?x?xi32>, %[[ARG3:.*]]: memref<?xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
// CHECK:           linalg.reduce { arith.addi {overflowFlags = #arith.overflow<none>} } ins(%[[ARG2]] : memref<?x?xi32>) outs(%[[ARG3]] : memref<?xi32>) dimensions = [0]
// CHECK:           return
// CHECK:         }
