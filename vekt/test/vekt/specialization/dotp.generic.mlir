// RUN: vekt-opt -ppu-specialize-linalg-generic %s | FileCheck %s

#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0) -> ()>
module {
  func.func @dotp(%arg0: memref<?xi32>, %arg1: memref<?xi32>, %arg2: i32) -> i32 attributes {llvm.linkage = #llvm.linkage<external>} {
    %c0_i32 = arith.constant 0 : i32
    %alloca = memref.alloca() : memref<i32>
    affine.store %c0_i32, %alloca[] : memref<i32>
    linalg.generic {indexing_maps = [#map, #map, #map1], iterator_types = ["reduction"]} ins(%arg0, %arg1 : memref<?xi32>, memref<?xi32>) outs(%alloca : memref<i32>) {
    ^bb0(%in: i32, %in_0: i32, %out: i32):
      %1 = arith.muli %in, %in_0 : i32
      %2 = arith.addi %out, %1 : i32
      linalg.yield %2 : i32
    }
    %0 = affine.load %alloca[] : memref<i32>
    return %0 : i32
  }
}

// CHECK-LABEL:   func.func @dotp(
// CHECK-SAME:                    %[[ARG0:.*]]: memref<?xi32>, %[[ARG1:.*]]: memref<?xi32>, %[[ARG2:.*]]: i32) -> i32 attributes {llvm.linkage = #llvm.linkage<external>} {
// CHECK:           %[[CONSTANT_0:.*]] = arith.constant 0 : i32
// CHECK:           %[[ALLOCA_0:.*]] = memref.alloca() : memref<i32>
// CHECK:           affine.store %[[CONSTANT_0]], %[[ALLOCA_0]][] : memref<i32>
// CHECK:           linalg.dot ins(%[[ARG0]], %[[ARG1]] : memref<?xi32>, memref<?xi32>) outs(%[[ALLOCA_0]] : memref<i32>)
// CHECK:           %[[LOAD_0:.*]] = affine.load %[[ALLOCA_0]][] : memref<i32>
// CHECK:           return %[[LOAD_0]] : i32
// CHECK:         }
