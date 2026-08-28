// RUN: vekt-opt -vekt-omp %s | FileCheck %s

func.func @vec_sum(%arg0: memref<?xi32>, %arg1: memref<?xi32>, %arg2: memref<?xi32>, %arg3: i32) attributes {llvm.linkage = #llvm.linkage<external>} {
    linalg.add ins(%arg0, %arg1 : memref<?xi32>, memref<?xi32>) outs(%arg2 : memref<?xi32>)

    return
}

// CHECK-LABEL:   func.func @vec_sum(
// CHECK-SAME:      %[[ARG0:.*]]: memref<?xi32>, %[[ARG1:.*]]: memref<?xi32>, %[[ARG2:.*]]: memref<?xi32>, %[[ARG3:.*]]: i32) attributes {llvm.linkage = #llvm.linkage<external>} {
// CHECK:           %[[CONSTANT_0:.*]] = arith.constant 1 : index
// CHECK:           %[[CONSTANT_1:.*]] = arith.constant 0 : index
// CHECK:           %[[DIM_0:.*]] = memref.dim %[[ARG0]], %[[CONSTANT_1]] : memref<?xi32>
// CHECK:           omp.parallel {
// CHECK:             omp.wsloop {
// CHECK:               omp.simd simdlen(4) {
// CHECK:                 omp.loop_nest (%[[VAL_0:.*]]) : index = (%[[CONSTANT_1]]) to (%[[DIM_0]]) step (%[[CONSTANT_0]]) {
// CHECK:                   %[[LOAD_0:.*]] = memref.load %[[ARG0]]{{\[}}%[[VAL_0]]] : memref<?xi32>
// CHECK:                   %[[LOAD_1:.*]] = memref.load %[[ARG1]]{{\[}}%[[VAL_0]]] : memref<?xi32>
// CHECK:                   %[[ADDI_0:.*]] = arith.addi %[[LOAD_0]], %[[LOAD_1]] : i32
// CHECK:                   memref.store %[[ADDI_0]], %[[ARG2]]{{\[}}%[[VAL_0]]] : memref<?xi32>
// CHECK:                   omp.yield
// CHECK:                 }
// CHECK:               } {omp.composite}
// CHECK:             } {omp.composite}
// CHECK:             omp.terminator
// CHECK:           }
// CHECK:           return
// CHECK:         }
