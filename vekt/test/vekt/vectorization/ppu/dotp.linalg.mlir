// RUN: vekt-opt -vekt %s | FileCheck %s

module {
  func.func @dotp(%arg0: memref<?xi32>, %arg1: memref<?xi32>, %arg2: i32) -> i32 attributes {llvm.linkage = #llvm.linkage<external>} {
    %c0_i32 = arith.constant 0 : i32
    %alloca = memref.alloca() : memref<i32>
    affine.store %c0_i32, %alloca[] : memref<i32>
    linalg.dot ins(%arg0, %arg1 : memref<?xi32>, memref<?xi32>) outs(%alloca : memref<i32>)
    %0 = affine.load %alloca[] : memref<i32>
    return %0 : i32
  }
}

// CHECK: #[[$ATTR_0:.+]] = affine_map<()[s0] -> ((s0 floordiv 16) * 16)>
// CHECK-LABEL:   func.func @dotp(
// CHECK-SAME:                    %[[ARG0:.*]]: memref<?xi32>, %[[ARG1:.*]]: memref<?xi32>, %[[ARG2:.*]]: i32) -> i32 attributes {llvm.linkage = #llvm.linkage<external>} {
// CHECK:           %[[CONSTANT_0:.*]] = arith.constant dense<0> : vector<16xi32>
// CHECK:           %[[CONSTANT_1:.*]] = arith.constant 0 : index
// CHECK:           %[[CONSTANT_2:.*]] = arith.constant 0 : i32
// CHECK:           %[[ALLOCA_0:.*]] = memref.alloca() : memref<i32>
// CHECK:           affine.store %[[CONSTANT_2]], %[[ALLOCA_0]][] : memref<i32>
// CHECK:           %[[DIM_0:.*]] = memref.dim %[[ARG0]], %[[CONSTANT_1]] : memref<?xi32>
// CHECK:           %[[VAL_0:.*]] = "ppu.vec_mpy_low_acc"(%[[CONSTANT_0]], %[[CONSTANT_0]]) : (vector<16xi32>, vector<16xi32>) -> vector<16xi32>
// CHECK:           %[[EXTRACT_ALIGNED_POINTER_AS_INDEX_0:.*]] = memref.extract_aligned_pointer_as_index %[[ARG0]] : memref<?xi32> -> index
// CHECK:           %[[INDEX_CAST_0:.*]] = arith.index_cast %[[EXTRACT_ALIGNED_POINTER_AS_INDEX_0]] : index to i32
// CHECK:           %[[INTTOPTR_0:.*]] = llvm.inttoptr %[[INDEX_CAST_0]] : i32 to !llvm.ptr<4>
// CHECK:           %[[EXTRACT_ALIGNED_POINTER_AS_INDEX_1:.*]] = memref.extract_aligned_pointer_as_index %[[ARG1]] : memref<?xi32> -> index
// CHECK:           %[[INDEX_CAST_1:.*]] = arith.index_cast %[[EXTRACT_ALIGNED_POINTER_AS_INDEX_1]] : index to i32
// CHECK:           %[[INTTOPTR_1:.*]] = llvm.inttoptr %[[INDEX_CAST_1]] : i32 to !llvm.ptr<4>
// CHECK:           %[[FOR_0:.*]] = affine.for %[[VAL_1:.*]] = 0 to #[[$ATTR_0]](){{\[}}%[[DIM_0]]] step 16 iter_args(%[[VAL_2:.*]] = %[[VAL_0]]) -> (vector<16xi32>) {
// CHECK:             %[[INDEX_CAST_2:.*]] = arith.index_cast %[[VAL_1]] : index to i32
// CHECK:             %[[GETELEMENTPTR_0:.*]] = llvm.getelementptr %[[INTTOPTR_0]]{{\[}}%[[INDEX_CAST_2]]] : (!llvm.ptr<4>, i32) -> !llvm.ptr<4>, i32
// CHECK:             %[[INDEX_CAST_3:.*]] = arith.index_cast %[[VAL_1]] : index to i32
// CHECK:             %[[GETELEMENTPTR_1:.*]] = llvm.getelementptr %[[INTTOPTR_1]]{{\[}}%[[INDEX_CAST_3]]] : (!llvm.ptr<4>, i32) -> !llvm.ptr<4>, i32
// CHECK:             %[[VAL_3:.*]] = "ppu.vec_load"(%[[GETELEMENTPTR_0]]) : (!llvm.ptr<4>) -> vector<16xi32>
// CHECK:             %[[VAL_4:.*]] = "ppu.vec_load"(%[[GETELEMENTPTR_1]]) : (!llvm.ptr<4>) -> vector<16xi32>
// CHECK:             %[[VAL_5:.*]] = "ppu.vec_mac_low"(%[[VAL_2]], %[[VAL_3]], %[[VAL_4]]) : (vector<16xi32>, vector<16xi32>, vector<16xi32>) -> vector<16xi32>
// CHECK:             affine.yield %[[VAL_5]] : vector<16xi32>
// CHECK:           }
// CHECK:           %[[VAL_6:.*]] = "ppu.vec_reduce_add"(%[[FOR_0]]) : (vector<16xi32>) -> i32
// CHECK:           %[[FOR_1:.*]] = affine.for %[[VAL_7:.*]] = #[[$ATTR_0]](){{\[}}%[[DIM_0]]] to %[[DIM_0]] iter_args(%[[VAL_8:.*]] = %[[VAL_6]]) -> (i32) {
// CHECK:             %[[LOAD_0:.*]] = affine.load %[[ARG0]]{{\[}}%[[VAL_7]]] : memref<?xi32>
// CHECK:             %[[LOAD_1:.*]] = affine.load %[[ARG1]]{{\[}}%[[VAL_7]]] : memref<?xi32>
// CHECK:             %[[MULI_0:.*]] = arith.muli %[[LOAD_0]], %[[LOAD_1]] : i32
// CHECK:             %[[ADDI_0:.*]] = arith.addi %[[VAL_8]], %[[MULI_0]] : i32
// CHECK:             affine.yield %[[ADDI_0]] : i32
// CHECK:           }
// CHECK:           affine.store %[[FOR_1]], %[[ALLOCA_0]][] : memref<i32>
// CHECK:           %[[LOAD_2:.*]] = affine.load %[[ALLOCA_0]][] : memref<i32>
// CHECK:           return %[[LOAD_2]] : i32
// CHECK:         }
