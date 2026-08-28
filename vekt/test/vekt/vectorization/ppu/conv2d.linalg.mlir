// RUN: vekt-opt -vekt %s | FileCheck %s

// NB: Specializzato da generic utilizzando mlir23
// build/bin/vekt-opt -ppu-normalize-iterargs-reductions -ppu-raise-affine-to-linalg-generic test/vekt/raising/conv2d.affine.mlir
//      | ~/llvm-project/build/bin/mlir-opt -linalg-morph-ops="generic-to-named"
func.func @conv2d(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: memref<?x?xi32>, %arg6: memref<?x?xi32>, %arg7: memref<?x?xi32>) {
    linalg.conv_2d ins(%arg6, %arg7 : memref<?x?xi32>, memref<?x?xi32>) outs(%arg5 : memref<?x?xi32>)
    return
}

// CHECK: #[[$ATTR_0:.+]] = affine_map<()[s0] -> ((s0 floordiv 16) * 16)>
// CHECK-LABEL:   func.func @conv2d(
// CHECK-SAME:                      %[[ARG0:.*]]: i32, %[[ARG1:.*]]: i32, %[[ARG2:.*]]: i32, %[[ARG3:.*]]: i32, %[[ARG4:.*]]: i32, %[[ARG5:.*]]: memref<?x?xi32>, %[[ARG6:.*]]: memref<?x?xi32>, %[[ARG7:.*]]: memref<?x?xi32>) {
// CHECK:           %[[CONSTANT_0:.*]] = arith.constant dense<0> : vector<16xi32>
// CHECK:           %[[CONSTANT_1:.*]] = arith.constant 1 : index
// CHECK:           %[[CONSTANT_2:.*]] = arith.constant 0 : index
// CHECK:           %[[DIM_0:.*]] = memref.dim %[[ARG7]], %[[CONSTANT_2]] : memref<?x?xi32>
// CHECK:           %[[DIM_1:.*]] = memref.dim %[[ARG7]], %[[CONSTANT_1]] : memref<?x?xi32>
// CHECK:           %[[DIM_2:.*]] = memref.dim %[[ARG5]], %[[CONSTANT_2]] : memref<?x?xi32>
// CHECK:           %[[DIM_3:.*]] = memref.dim %[[ARG5]], %[[CONSTANT_1]] : memref<?x?xi32>
// CHECK:           %[[EXTRACT_ALIGNED_POINTER_AS_INDEX_0:.*]] = memref.extract_aligned_pointer_as_index %[[ARG6]] : memref<?x?xi32> -> index
// CHECK:           %[[INDEX_CAST_0:.*]] = arith.index_cast %[[EXTRACT_ALIGNED_POINTER_AS_INDEX_0]] : index to i32
// CHECK:           %[[INTTOPTR_0:.*]] = llvm.inttoptr %[[INDEX_CAST_0]] : i32 to !llvm.ptr<4>
// CHECK:           %[[EXTRACT_ALIGNED_POINTER_AS_INDEX_1:.*]] = memref.extract_aligned_pointer_as_index %[[ARG5]] : memref<?x?xi32> -> index
// CHECK:           %[[INDEX_CAST_1:.*]] = arith.index_cast %[[EXTRACT_ALIGNED_POINTER_AS_INDEX_1]] : index to i32
// CHECK:           %[[INTTOPTR_1:.*]] = llvm.inttoptr %[[INDEX_CAST_1]] : i32 to !llvm.ptr<4>
// CHECK:           %[[ADDI_0:.*]] = arith.addi %[[DIM_3]], %[[DIM_1]] : index
// CHECK:           %[[SUBI_0:.*]] = arith.subi %[[ADDI_0]], %[[CONSTANT_1]] : index
// CHECK:           affine.for %[[VAL_0:.*]] = 0 to %[[DIM_2]] {
// CHECK:             affine.for %[[VAL_1:.*]] = 0 to #[[$ATTR_0]](){{\[}}%[[DIM_3]]] step 16 {
// CHECK:               %[[MULI_0:.*]] = arith.muli %[[VAL_0]], %[[DIM_3]] : index
// CHECK:               %[[ADDI_1:.*]] = arith.addi %[[MULI_0]], %[[VAL_1]] : index
// CHECK:               %[[INDEX_CAST_2:.*]] = arith.index_cast %[[ADDI_1]] : index to i32
// CHECK:               %[[GETELEMENTPTR_0:.*]] = llvm.getelementptr %[[INTTOPTR_1]]{{\[}}%[[INDEX_CAST_2]]] : (!llvm.ptr<4>, i32) -> !llvm.ptr<4>, i32
// CHECK:               %[[VAL_2:.*]] = "ppu.vec_load"(%[[GETELEMENTPTR_0]]) : (!llvm.ptr<4>) -> vector<16xi32>
// CHECK:               %[[VAL_3:.*]] = "ppu.vec_add_init_acc"(%[[VAL_2]], %[[CONSTANT_0]]) : (vector<16xi32>, vector<16xi32>) -> vector<16xi32>
// CHECK:               %[[FOR_0:.*]] = affine.for %[[VAL_4:.*]] = 0 to %[[DIM_0]] iter_args(%[[VAL_5:.*]] = %[[VAL_3]]) -> (vector<16xi32>) {
// CHECK:                 %[[FOR_1:.*]] = affine.for %[[VAL_6:.*]] = 0 to %[[DIM_1]] iter_args(%[[VAL_7:.*]] = %[[VAL_5]]) -> (vector<16xi32>) {
// CHECK:                   %[[ADDI_2:.*]] = arith.addi %[[VAL_0]], %[[VAL_4]] : index
// CHECK:                   %[[ADDI_3:.*]] = arith.addi %[[VAL_1]], %[[VAL_6]] : index
// CHECK:                   %[[MULI_1:.*]] = arith.muli %[[ADDI_2]], %[[SUBI_0]] : index
// CHECK:                   %[[ADDI_4:.*]] = arith.addi %[[MULI_1]], %[[ADDI_3]] : index
// CHECK:                   %[[INDEX_CAST_3:.*]] = arith.index_cast %[[ADDI_4]] : index to i32
// CHECK:                   %[[GETELEMENTPTR_1:.*]] = llvm.getelementptr %[[INTTOPTR_0]]{{\[}}%[[INDEX_CAST_3]]] : (!llvm.ptr<4>, i32) -> !llvm.ptr<4>, i32
// CHECK:                   %[[VAL_8:.*]] = "ppu.vec_load"(%[[GETELEMENTPTR_1]]) : (!llvm.ptr<4>) -> vector<16xi32>
// CHECK:                   %[[LOAD_0:.*]] = affine.load %[[ARG7]]{{\[}}%[[VAL_4]], %[[VAL_6]]] : memref<?x?xi32>
// CHECK:                   %[[BROADCAST_0:.*]] = vector.broadcast %[[LOAD_0]] : i32 to vector<16xi32>
// CHECK:                   %[[VAL_9:.*]] = "ppu.vec_mac_low"(%[[VAL_7]], %[[VAL_8]], %[[BROADCAST_0]]) : (vector<16xi32>, vector<16xi32>, vector<16xi32>) -> vector<16xi32>
// CHECK:                   affine.yield %[[VAL_9]] : vector<16xi32>
// CHECK:                 }
// CHECK:                 affine.yield %[[FOR_1]] : vector<16xi32>
// CHECK:               }
// CHECK:               %[[VAL_10:.*]] = "ppu.acc_to_vec"(%[[FOR_0]]) : (vector<16xi32>) -> vector<16xi32>
// CHECK:               "ppu.vec_store"(%[[VAL_10]], %[[GETELEMENTPTR_0]]) : (vector<16xi32>, !llvm.ptr<4>) -> ()
// CHECK:             }
// CHECK:           }
// CHECK:           affine.for %[[VAL_11:.*]] = 0 to %[[DIM_2]] {
// CHECK:             affine.for %[[VAL_12:.*]] = #[[$ATTR_0]](){{\[}}%[[DIM_3]]] to %[[DIM_3]] {
// CHECK:               %[[LOAD_1:.*]] = affine.load %[[ARG5]]{{\[}}%[[VAL_11]], %[[VAL_12]]] : memref<?x?xi32>
// CHECK:               %[[FOR_2:.*]] = affine.for %[[VAL_13:.*]] = 0 to %[[DIM_0]] iter_args(%[[VAL_14:.*]] = %[[LOAD_1]]) -> (i32) {
// CHECK:                 %[[FOR_3:.*]] = affine.for %[[VAL_15:.*]] = 0 to %[[DIM_1]] iter_args(%[[VAL_16:.*]] = %[[VAL_14]]) -> (i32) {
// CHECK:                   %[[LOAD_2:.*]] = affine.load %[[ARG6]]{{\[}}%[[VAL_11]] + %[[VAL_13]], %[[VAL_12]] + %[[VAL_15]]] : memref<?x?xi32>
// CHECK:                   %[[LOAD_3:.*]] = affine.load %[[ARG7]]{{\[}}%[[VAL_13]], %[[VAL_15]]] : memref<?x?xi32>
// CHECK:                   %[[MULI_2:.*]] = arith.muli %[[LOAD_2]], %[[LOAD_3]] : i32
// CHECK:                   %[[ADDI_5:.*]] = arith.addi %[[VAL_16]], %[[MULI_2]] : i32
// CHECK:                   affine.yield %[[ADDI_5]] : i32
// CHECK:                 }
// CHECK:                 affine.yield %[[FOR_3]] : i32
// CHECK:               }
// CHECK:               affine.store %[[FOR_2]], %[[ARG5]]{{\[}}%[[VAL_11]], %[[VAL_12]]] : memref<?x?xi32>
// CHECK:             }
// CHECK:           }
// CHECK:           return
// CHECK:         }
