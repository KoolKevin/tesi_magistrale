// RUN: vekt-opt -convert-linalg-to-ppu-algorithm -canonicalize %s | FileCheck %s

module {
  func.func @transpose(%arg0: i32, %arg1: i32, %arg2: memref<?x?xi32>, %arg3: memref<?x?xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
    linalg.transpose ins(%arg2 : memref<?x?xi32>) outs(%arg3 : memref<?x?xi32>) permutation = [1, 0]
    return
  }
}

// CHECK: #[[$ATTR_0:.+]] = affine_map<()[s0] -> ((s0 floordiv 16) * 16)>
// CHECK-LABEL:   func.func @transpose(
// CHECK-SAME:      %[[ARG0:.*]]: i32, %[[ARG1:.*]]: i32, %[[ARG2:.*]]: memref<?x?xi32>, %[[ARG3:.*]]: memref<?x?xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
// CHECK:           %[[CONSTANT_0:.*]] = arith.constant 4 : index
// CHECK:           %[[CONSTANT_1:.*]] = arith.constant 1 : index
// CHECK:           %[[CONSTANT_2:.*]] = arith.constant 0 : index
// CHECK:           %[[DIM_0:.*]] = memref.dim %[[ARG2]], %[[CONSTANT_2]] : memref<?x?xi32>
// CHECK:           %[[DIM_1:.*]] = memref.dim %[[ARG2]], %[[CONSTANT_1]] : memref<?x?xi32>
// CHECK:           %[[EXTRACT_ALIGNED_POINTER_AS_INDEX_0:.*]] = memref.extract_aligned_pointer_as_index %[[ARG2]] : memref<?x?xi32> -> index
// CHECK:           %[[INDEX_CAST_0:.*]] = arith.index_cast %[[EXTRACT_ALIGNED_POINTER_AS_INDEX_0]] : index to i32
// CHECK:           %[[INTTOPTR_0:.*]] = llvm.inttoptr %[[INDEX_CAST_0]] : i32 to !llvm.ptr<4>
// CHECK:           %[[EXTRACT_ALIGNED_POINTER_AS_INDEX_1:.*]] = memref.extract_aligned_pointer_as_index %[[ARG3]] : memref<?x?xi32> -> index
// CHECK:           %[[INDEX_CAST_1:.*]] = arith.index_cast %[[EXTRACT_ALIGNED_POINTER_AS_INDEX_1]] : index to i32
// CHECK:           %[[INTTOPTR_1:.*]] = llvm.inttoptr %[[INDEX_CAST_1]] : i32 to !llvm.ptr<4>
// CHECK:           %[[VAL_0:.*]] = "ppu.vec_constant_index"() : () -> vector<16xi32>
// CHECK:           %[[MULI_0:.*]] = arith.muli %[[DIM_0]], %[[CONSTANT_0]] : index
// CHECK:           %[[INDEX_CAST_2:.*]] = arith.index_cast %[[MULI_0]] : index to i32
// CHECK:           %[[BROADCAST_0:.*]] = vector.broadcast %[[INDEX_CAST_2]] : i32 to vector<16xi32>
// CHECK:           %[[MULI_1:.*]] = arith.muli %[[VAL_0]], %[[BROADCAST_0]] : vector<16xi32>
// CHECK:           affine.for %[[VAL_1:.*]] = 0 to %[[DIM_0]] {
// CHECK:             affine.for %[[VAL_2:.*]] = 0 to #[[$ATTR_0]](){{\[}}%[[DIM_1]]] step 16 {
// CHECK:               %[[MULI_2:.*]] = arith.muli %[[VAL_1]], %[[DIM_1]] : index
// CHECK:               %[[ADDI_0:.*]] = arith.addi %[[MULI_2]], %[[VAL_2]] : index
// CHECK:               %[[INDEX_CAST_3:.*]] = arith.index_cast %[[ADDI_0]] : index to i32
// CHECK:               %[[GETELEMENTPTR_0:.*]] = llvm.getelementptr %[[INTTOPTR_0]]{{\[}}%[[INDEX_CAST_3]]] : (!llvm.ptr<4>, i32) -> !llvm.ptr<4>, i32
// CHECK:               %[[VAL_3:.*]] = "ppu.vec_load"(%[[GETELEMENTPTR_0]]) : (!llvm.ptr<4>) -> vector<16xi32>
// CHECK:               %[[MULI_3:.*]] = arith.muli %[[VAL_2]], %[[DIM_0]] : index
// CHECK:               %[[ADDI_1:.*]] = arith.addi %[[MULI_3]], %[[VAL_1]] : index
// CHECK:               %[[INDEX_CAST_4:.*]] = arith.index_cast %[[ADDI_1]] : index to i32
// CHECK:               %[[GETELEMENTPTR_1:.*]] = llvm.getelementptr %[[INTTOPTR_1]]{{\[}}%[[INDEX_CAST_4]]] : (!llvm.ptr<4>, i32) -> !llvm.ptr<4>, i32
// CHECK:               "ppu.vec_scatter"(%[[GETELEMENTPTR_1]], %[[MULI_1]], %[[VAL_3]]) : (!llvm.ptr<4>, vector<16xi32>, vector<16xi32>) -> ()
// CHECK:             }
// CHECK:           }
// CHECK:           affine.for %[[VAL_4:.*]] = 0 to %[[DIM_0]] {
// CHECK:             affine.for %[[VAL_5:.*]] = #[[$ATTR_0]](){{\[}}%[[DIM_1]]] to %[[DIM_1]] {
// CHECK:               %[[LOAD_0:.*]] = affine.load %[[ARG2]]{{\[}}%[[VAL_4]], %[[VAL_5]]] : memref<?x?xi32>
// CHECK:               affine.store %[[LOAD_0]], %[[ARG3]]{{\[}}%[[VAL_5]], %[[VAL_4]]] : memref<?x?xi32>
// CHECK:             }
// CHECK:           }
// CHECK:           return
// CHECK:         }
