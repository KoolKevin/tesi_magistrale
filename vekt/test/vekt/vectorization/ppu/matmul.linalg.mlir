// RUN: vekt-opt -vekt %s | FileCheck %s

module {
  func.func @matmul(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: memref<?x?xi32>, %arg4: memref<?x?xi32>, %arg5: memref<?x?xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
    linalg.matmul ins(%arg3, %arg4 : memref<?x?xi32>, memref<?x?xi32>) outs(%arg5 : memref<?x?xi32>)
    return
  }
}

// CHECK: #[[$ATTR_0:.+]] = affine_map<()[s0] -> ((s0 floordiv 16) * 16)>
// CHECK-LABEL:   func.func @matmul(
// CHECK-SAME:                      %[[ARG0:.*]]: i32, %[[ARG1:.*]]: i32, %[[ARG2:.*]]: i32, %[[ARG3:.*]]: memref<?x?xi32>, %[[ARG4:.*]]: memref<?x?xi32>, %[[ARG5:.*]]: memref<?x?xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
// CHECK:           %[[CONSTANT_0:.*]] = arith.constant 0 : i32
// CHECK:           %[[CONSTANT_1:.*]] = arith.constant dense<0> : vector<16xi32>
// CHECK:           %[[CONSTANT_2:.*]] = arith.constant 1 : index
// CHECK:           %[[CONSTANT_3:.*]] = arith.constant 0 : index
// CHECK:           %[[DIM_0:.*]] = memref.dim %[[ARG3]], %[[CONSTANT_3]] : memref<?x?xi32>
// CHECK:           %[[DIM_1:.*]] = memref.dim %[[ARG3]], %[[CONSTANT_2]] : memref<?x?xi32>
// CHECK:           %[[DIM_2:.*]] = memref.dim %[[ARG4]], %[[CONSTANT_2]] : memref<?x?xi32>
// CHECK:           %[[EXTRACT_ALIGNED_POINTER_AS_INDEX_0:.*]] = memref.extract_aligned_pointer_as_index %[[ARG4]] : memref<?x?xi32> -> index
// CHECK:           %[[INDEX_CAST_0:.*]] = arith.index_cast %[[EXTRACT_ALIGNED_POINTER_AS_INDEX_0]] : index to i32
// CHECK:           %[[INTTOPTR_0:.*]] = llvm.inttoptr %[[INDEX_CAST_0]] : i32 to !llvm.ptr<4>
// CHECK:           %[[EXTRACT_ALIGNED_POINTER_AS_INDEX_1:.*]] = memref.extract_aligned_pointer_as_index %[[ARG5]] : memref<?x?xi32> -> index
// CHECK:           %[[INDEX_CAST_1:.*]] = arith.index_cast %[[EXTRACT_ALIGNED_POINTER_AS_INDEX_1]] : index to i32
// CHECK:           %[[INTTOPTR_1:.*]] = llvm.inttoptr %[[INDEX_CAST_1]] : i32 to !llvm.ptr<4>
// CHECK:           affine.for %[[VAL_0:.*]] = 0 to %[[DIM_0]] {
// CHECK:             affine.for %[[VAL_1:.*]] = 0 to #[[$ATTR_0]](){{\[}}%[[DIM_2]]] step 16 {
// CHECK:               %[[MULI_0:.*]] = arith.muli %[[VAL_0]], %[[DIM_2]] : index
// CHECK:               %[[ADDI_0:.*]] = arith.addi %[[MULI_0]], %[[VAL_1]] : index
// CHECK:               %[[INDEX_CAST_2:.*]] = arith.index_cast %[[ADDI_0]] : index to i32
// CHECK:               %[[GETELEMENTPTR_0:.*]] = llvm.getelementptr %[[INTTOPTR_1]]{{\[}}%[[INDEX_CAST_2]]] : (!llvm.ptr<4>, i32) -> !llvm.ptr<4>, i32
// CHECK:               %[[VAL_2:.*]] = "ppu.vec_load"(%[[GETELEMENTPTR_0]]) : (!llvm.ptr<4>) -> vector<16xi32>
// CHECK:               %[[VAL_3:.*]] = "ppu.vec_add_init_acc"(%[[VAL_2]], %[[CONSTANT_1]]) : (vector<16xi32>, vector<16xi32>) -> vector<16xi32>
// CHECK:               %[[FOR_0:.*]] = affine.for %[[VAL_4:.*]] = 0 to %[[DIM_1]] iter_args(%[[VAL_5:.*]] = %[[VAL_3]]) -> (vector<16xi32>) {
// CHECK:                 %[[MULI_1:.*]] = arith.muli %[[VAL_4]], %[[DIM_2]] : index
// CHECK:                 %[[ADDI_1:.*]] = arith.addi %[[MULI_1]], %[[VAL_1]] : index
// CHECK:                 %[[INDEX_CAST_3:.*]] = arith.index_cast %[[ADDI_1]] : index to i32
// CHECK:                 %[[GETELEMENTPTR_1:.*]] = llvm.getelementptr %[[INTTOPTR_0]]{{\[}}%[[INDEX_CAST_3]]] : (!llvm.ptr<4>, i32) -> !llvm.ptr<4>, i32
// CHECK:                 %[[VAL_6:.*]] = "ppu.vec_load"(%[[GETELEMENTPTR_1]]) : (!llvm.ptr<4>) -> vector<16xi32>
// CHECK:                 %[[LOAD_0:.*]] = affine.load %[[ARG3]]{{\[}}%[[VAL_0]], %[[VAL_4]]] : memref<?x?xi32>
// CHECK:                 %[[BROADCAST_0:.*]] = vector.broadcast %[[LOAD_0]] : i32 to vector<16xi32>
// CHECK:                 %[[VAL_7:.*]] = "ppu.vec_mac_low"(%[[VAL_5]], %[[VAL_6]], %[[BROADCAST_0]]) : (vector<16xi32>, vector<16xi32>, vector<16xi32>) -> vector<16xi32>
// CHECK:                 affine.yield %[[VAL_7]] : vector<16xi32>
// CHECK:               }
// CHECK:               %[[VAL_8:.*]] = "ppu.acc_to_vec"(%[[FOR_0]]) : (vector<16xi32>) -> vector<16xi32>
// CHECK:               "ppu.vec_store"(%[[VAL_8]], %[[GETELEMENTPTR_0]]) : (vector<16xi32>, !llvm.ptr<4>) -> ()
// CHECK:             }
// CHECK:           }
// CHECK:           affine.for %[[VAL_9:.*]] = 0 to %[[DIM_0]] {
// CHECK:             affine.for %[[VAL_10:.*]] = #[[$ATTR_0]](){{\[}}%[[DIM_2]]] to %[[DIM_2]] {
// CHECK:               %[[FOR_1:.*]] = affine.for %[[VAL_11:.*]] = 0 to %[[DIM_1]] iter_args(%[[VAL_12:.*]] = %[[CONSTANT_0]]) -> (i32) {
// CHECK:                 %[[LOAD_1:.*]] = affine.load %[[ARG3]]{{\[}}%[[VAL_9]], %[[VAL_11]]] : memref<?x?xi32>
// CHECK:                 %[[LOAD_2:.*]] = affine.load %[[ARG4]]{{\[}}%[[VAL_11]], %[[VAL_10]]] : memref<?x?xi32>
// CHECK:                 %[[MULI_2:.*]] = arith.muli %[[LOAD_1]], %[[LOAD_2]] : i32
// CHECK:                 %[[ADDI_2:.*]] = arith.addi %[[VAL_12]], %[[MULI_2]] : i32
// CHECK:                 affine.yield %[[ADDI_2]] : i32
// CHECK:               }
// CHECK:               affine.store %[[FOR_1]], %[[ARG5]]{{\[}}%[[VAL_9]], %[[VAL_10]]] : memref<?x?xi32>
// CHECK:             }
// CHECK:           }
// CHECK:           return
// CHECK:         }
