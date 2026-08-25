// RUN: vekt-opt -vekt %s | FileCheck %s

// NB: Specializzato da generic utilizzando mlir23
// build/bin/vekt-opt -ppu-normalize-iterargs-reductions -ppu-raise-affine-to-linalg-generic test/vekt/raising/conv1d.affine.mlir
//      | ~/llvm-project/build/bin/mlir-opt -linalg-morph-ops="generic-to-named"
func.func @conv1d(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: memref<?xi32>, %arg4: memref<?xi32>, %arg5: memref<?xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
    linalg.conv_1d ins(%arg4, %arg5 : memref<?xi32>, memref<?xi32>) outs(%arg3 : memref<?xi32>)
    return
}

// CHECK: #[[$ATTR_0:.+]] = affine_map<()[s0] -> ((s0 floordiv 16) * 16)>
// CHECK-LABEL:   func.func @conv1d(
// CHECK-SAME:                      %[[ARG0:.*]]: i32, %[[ARG1:.*]]: i32, %[[ARG2:.*]]: i32, %[[ARG3:.*]]: memref<?xi32>, %[[ARG4:.*]]: memref<?xi32>, %[[ARG5:.*]]: memref<?xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
// CHECK:           %[[CONSTANT_0:.*]] = arith.constant dense<0> : vector<16xi32>
// CHECK:           %[[CONSTANT_1:.*]] = arith.constant 0 : index
// CHECK:           %[[DIM_0:.*]] = memref.dim %[[ARG5]], %[[CONSTANT_1]] : memref<?xi32>
// CHECK:           %[[DIM_1:.*]] = memref.dim %[[ARG3]], %[[CONSTANT_1]] : memref<?xi32>
// CHECK:           %[[EXTRACT_ALIGNED_POINTER_AS_INDEX_0:.*]] = memref.extract_aligned_pointer_as_index %[[ARG4]] : memref<?xi32> -> index
// CHECK:           %[[INDEX_CAST_0:.*]] = arith.index_cast %[[EXTRACT_ALIGNED_POINTER_AS_INDEX_0]] : index to i32
// CHECK:           %[[INTTOPTR_0:.*]] = llvm.inttoptr %[[INDEX_CAST_0]] : i32 to !llvm.ptr<4>
// CHECK:           %[[EXTRACT_ALIGNED_POINTER_AS_INDEX_1:.*]] = memref.extract_aligned_pointer_as_index %[[ARG3]] : memref<?xi32> -> index
// CHECK:           %[[INDEX_CAST_1:.*]] = arith.index_cast %[[EXTRACT_ALIGNED_POINTER_AS_INDEX_1]] : index to i32
// CHECK:           %[[INTTOPTR_1:.*]] = llvm.inttoptr %[[INDEX_CAST_1]] : i32 to !llvm.ptr<4>
// CHECK:           affine.for %[[VAL_0:.*]] = 0 to #[[$ATTR_0]](){{\[}}%[[DIM_1]]] step 16 {
// CHECK:             %[[INDEX_CAST_2:.*]] = arith.index_cast %[[VAL_0]] : index to i32
// CHECK:             %[[GETELEMENTPTR_0:.*]] = llvm.getelementptr %[[INTTOPTR_1]]{{\[}}%[[INDEX_CAST_2]]] : (!llvm.ptr<4>, i32) -> !llvm.ptr<4>, i32
// CHECK:             %[[VAL_1:.*]] = "ppu.vec_load"(%[[GETELEMENTPTR_0]]) : (!llvm.ptr<4>) -> vector<16xi32>
// CHECK:             %[[VAL_2:.*]] = "ppu.vec_add_init_acc"(%[[VAL_1]], %[[CONSTANT_0]]) : (vector<16xi32>, vector<16xi32>) -> vector<16xi32>
// CHECK:             %[[FOR_0:.*]] = affine.for %[[VAL_3:.*]] = 0 to %[[DIM_0]] iter_args(%[[VAL_4:.*]] = %[[VAL_2]]) -> (vector<16xi32>) {
// CHECK:               %[[ADDI_0:.*]] = arith.addi %[[VAL_0]], %[[VAL_3]] : index
// CHECK:               %[[INDEX_CAST_3:.*]] = arith.index_cast %[[ADDI_0]] : index to i32
// CHECK:               %[[GETELEMENTPTR_1:.*]] = llvm.getelementptr %[[INTTOPTR_0]]{{\[}}%[[INDEX_CAST_3]]] : (!llvm.ptr<4>, i32) -> !llvm.ptr<4>, i32
// CHECK:               %[[VAL_5:.*]] = "ppu.vec_load"(%[[GETELEMENTPTR_1]]) : (!llvm.ptr<4>) -> vector<16xi32>
// CHECK:               %[[LOAD_0:.*]] = affine.load %[[ARG5]]{{\[}}%[[VAL_3]]] : memref<?xi32>
// CHECK:               %[[BROADCAST_0:.*]] = vector.broadcast %[[LOAD_0]] : i32 to vector<16xi32>
// CHECK:               %[[VAL_6:.*]] = "ppu.vec_mac_low"(%[[VAL_4]], %[[VAL_5]], %[[BROADCAST_0]]) : (vector<16xi32>, vector<16xi32>, vector<16xi32>) -> vector<16xi32>
// CHECK:               affine.yield %[[VAL_6]] : vector<16xi32>
// CHECK:             }
// CHECK:             %[[VAL_7:.*]] = "ppu.acc_to_vec"(%[[FOR_0]]) : (vector<16xi32>) -> vector<16xi32>
// CHECK:             "ppu.vec_store"(%[[VAL_7]], %[[GETELEMENTPTR_0]]) : (vector<16xi32>, !llvm.ptr<4>) -> ()
// CHECK:           }
// CHECK:           affine.for %[[VAL_8:.*]] = #[[$ATTR_0]](){{\[}}%[[DIM_1]]] to %[[DIM_1]] {
// CHECK:             %[[LOAD_1:.*]] = affine.load %[[ARG3]]{{\[}}%[[VAL_8]]] : memref<?xi32>
// CHECK:             %[[FOR_1:.*]] = affine.for %[[VAL_9:.*]] = 0 to %[[DIM_0]] iter_args(%[[VAL_10:.*]] = %[[LOAD_1]]) -> (i32) {
// CHECK:               %[[LOAD_2:.*]] = affine.load %[[ARG4]]{{\[}}%[[VAL_8]] + %[[VAL_9]]] : memref<?xi32>
// CHECK:               %[[LOAD_3:.*]] = affine.load %[[ARG5]]{{\[}}%[[VAL_9]]] : memref<?xi32>
// CHECK:               %[[MULI_0:.*]] = arith.muli %[[LOAD_2]], %[[LOAD_3]] : i32
// CHECK:               %[[ADDI_1:.*]] = arith.addi %[[VAL_10]], %[[MULI_0]] : i32
// CHECK:               affine.yield %[[ADDI_1]] : i32
// CHECK:             }
// CHECK:             affine.store %[[FOR_1]], %[[ARG3]]{{\[}}%[[VAL_8]]] : memref<?xi32>
// CHECK:           }
// CHECK:           return
// CHECK:         }
