// RUN: vekt-opt -vekt %s | FileCheck %s

func.func @max_pooling(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: memref<?x?xi32>, %arg6: memref<?x?xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %0 = arith.index_cast %arg4 : i32 to index
    "ppu.max_pool_2d"(%arg6, %0, %arg5) : (memref<?x?xi32>, index, memref<?x?xi32>) -> ()

    return
}

// CHECK: #[[$ATTR_0:.+]] = affine_map<()[s0] -> ((s0 floordiv 16) * 16)>
// CHECK-LABEL:   func.func @max_pooling(
// CHECK-SAME:      %[[ARG0:.*]]: i32, %[[ARG1:.*]]: i32, %[[ARG2:.*]]: i32, %[[ARG3:.*]]: i32, %[[ARG4:.*]]: i32, %[[ARG5:.*]]: memref<?x?xi32>, %[[ARG6:.*]]: memref<?x?xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
// CHECK:           %[[CONSTANT_0:.*]] = arith.constant dense<0> : vector<16xi32>
// CHECK:           %[[CONSTANT_1:.*]] = arith.constant 4 : index
// CHECK:           %[[CONSTANT_2:.*]] = arith.constant 1 : index
// CHECK:           %[[CONSTANT_3:.*]] = arith.constant 0 : index
// CHECK:           %[[INDEX_CAST_0:.*]] = arith.index_cast %[[ARG4]] : i32 to index
// CHECK:           %[[DIM_0:.*]] = memref.dim %[[ARG5]], %[[CONSTANT_3]] : memref<?x?xi32>
// CHECK:           %[[DIM_1:.*]] = memref.dim %[[ARG5]], %[[CONSTANT_2]] : memref<?x?xi32>
// CHECK:           %[[EXTRACT_ALIGNED_POINTER_AS_INDEX_0:.*]] = memref.extract_aligned_pointer_as_index %[[ARG6]] : memref<?x?xi32> -> index
// CHECK:           %[[INDEX_CAST_1:.*]] = arith.index_cast %[[EXTRACT_ALIGNED_POINTER_AS_INDEX_0]] : index to i32
// CHECK:           %[[INTTOPTR_0:.*]] = llvm.inttoptr %[[INDEX_CAST_1]] : i32 to !llvm.ptr<4>
// CHECK:           %[[EXTRACT_ALIGNED_POINTER_AS_INDEX_1:.*]] = memref.extract_aligned_pointer_as_index %[[ARG5]] : memref<?x?xi32> -> index
// CHECK:           %[[INDEX_CAST_2:.*]] = arith.index_cast %[[EXTRACT_ALIGNED_POINTER_AS_INDEX_1]] : index to i32
// CHECK:           %[[INTTOPTR_1:.*]] = llvm.inttoptr %[[INDEX_CAST_2]] : i32 to !llvm.ptr<4>
// CHECK:           %[[MULI_0:.*]] = arith.muli %[[DIM_1]], %[[INDEX_CAST_0]] : index
// CHECK:           %[[VAL_0:.*]] = "ppu.vec_constant_index"() : () -> vector<16xi32>
// CHECK:           %[[MULI_1:.*]] = arith.muli %[[INDEX_CAST_0]], %[[CONSTANT_1]] : index
// CHECK:           %[[INDEX_CAST_3:.*]] = arith.index_cast %[[MULI_1]] : index to i32
// CHECK:           %[[BROADCAST_0:.*]] = vector.broadcast %[[INDEX_CAST_3]] : i32 to vector<16xi32>
// CHECK:           %[[MULI_2:.*]] = arith.muli %[[VAL_0]], %[[BROADCAST_0]] : vector<16xi32>
// CHECK:           affine.for %[[VAL_1:.*]] = 0 to %[[DIM_0]] {
// CHECK:             affine.for %[[VAL_2:.*]] = 0 to #[[$ATTR_0]](){{\[}}%[[DIM_1]]] step 16 {
// CHECK:               %[[MULI_3:.*]] = arith.muli %[[VAL_1]], %[[DIM_1]] : index
// CHECK:               %[[ADDI_0:.*]] = arith.addi %[[MULI_3]], %[[VAL_2]] : index
// CHECK:               %[[INDEX_CAST_4:.*]] = arith.index_cast %[[ADDI_0]] : index to i32
// CHECK:               %[[GETELEMENTPTR_0:.*]] = llvm.getelementptr %[[INTTOPTR_1]]{{\[}}%[[INDEX_CAST_4]]] : (!llvm.ptr<4>, i32) -> !llvm.ptr<4>, i32
// CHECK:               %[[VAL_3:.*]] = "ppu.vec_load"(%[[GETELEMENTPTR_0]]) : (!llvm.ptr<4>) -> vector<16xi32>
// CHECK:               %[[VAL_4:.*]] = "ppu.vec_add_init_acc"(%[[VAL_3]], %[[CONSTANT_0]]) : (vector<16xi32>, vector<16xi32>) -> vector<16xi32>
// CHECK:               %[[FOR_0:.*]] = affine.for %[[VAL_5:.*]] = 0 to %[[INDEX_CAST_0]] iter_args(%[[VAL_6:.*]] = %[[VAL_4]]) -> (vector<16xi32>) {
// CHECK:                 %[[FOR_1:.*]] = affine.for %[[VAL_7:.*]] = 0 to %[[INDEX_CAST_0]] iter_args(%[[VAL_8:.*]] = %[[VAL_6]]) -> (vector<16xi32>) {
// CHECK:                   %[[MULI_4:.*]] = arith.muli %[[VAL_1]], %[[INDEX_CAST_0]] : index
// CHECK:                   %[[MULI_5:.*]] = arith.muli %[[VAL_2]], %[[INDEX_CAST_0]] : index
// CHECK:                   %[[ADDI_1:.*]] = arith.addi %[[MULI_4]], %[[VAL_5]] : index
// CHECK:                   %[[ADDI_2:.*]] = arith.addi %[[MULI_5]], %[[VAL_7]] : index
// CHECK:                   %[[MULI_6:.*]] = arith.muli %[[ADDI_1]], %[[MULI_0]] : index
// CHECK:                   %[[ADDI_3:.*]] = arith.addi %[[MULI_6]], %[[ADDI_2]] : index
// CHECK:                   %[[INDEX_CAST_5:.*]] = arith.index_cast %[[ADDI_3]] : index to i32
// CHECK:                   %[[GETELEMENTPTR_1:.*]] = llvm.getelementptr %[[INTTOPTR_0]]{{\[}}%[[INDEX_CAST_5]]] : (!llvm.ptr<4>, i32) -> !llvm.ptr<4>, i32
// CHECK:                   %[[VAL_9:.*]] = "ppu.vec_gather"(%[[GETELEMENTPTR_1]], %[[MULI_2]]) : (!llvm.ptr<4>, vector<16xi32>) -> vector<16xi32>
// CHECK:                   %[[VAL_10:.*]] = "ppu.vec_max"(%[[VAL_8]], %[[VAL_9]]) : (vector<16xi32>, vector<16xi32>) -> vector<16xi32>
// CHECK:                   affine.yield %[[VAL_10]] : vector<16xi32>
// CHECK:                 }
// CHECK:                 affine.yield %[[FOR_1]] : vector<16xi32>
// CHECK:               }
// CHECK:               %[[VAL_11:.*]] = "ppu.acc_to_vec"(%[[FOR_0]]) : (vector<16xi32>) -> vector<16xi32>
// CHECK:               "ppu.vec_store"(%[[VAL_11]], %[[GETELEMENTPTR_0]]) : (vector<16xi32>, !llvm.ptr<4>) -> ()
// CHECK:             }
// CHECK:           }
// CHECK:           affine.for %[[VAL_12:.*]] = 0 to %[[DIM_0]] {
// CHECK:             affine.for %[[VAL_13:.*]] = #[[$ATTR_0]](){{\[}}%[[DIM_1]]] to %[[DIM_1]] {
// CHECK:               %[[LOAD_0:.*]] = affine.load %[[ARG5]]{{\[}}%[[VAL_12]], %[[VAL_13]]] : memref<?x?xi32>
// CHECK:               %[[FOR_2:.*]] = affine.for %[[VAL_14:.*]] = 0 to %[[INDEX_CAST_0]] iter_args(%[[VAL_15:.*]] = %[[LOAD_0]]) -> (i32) {
// CHECK:                 %[[FOR_3:.*]] = affine.for %[[VAL_16:.*]] = 0 to %[[INDEX_CAST_0]] iter_args(%[[VAL_17:.*]] = %[[VAL_15]]) -> (i32) {
// CHECK:                   %[[LOAD_1:.*]] = affine.load %[[ARG6]]{{\[}}%[[VAL_12]] * symbol(%[[INDEX_CAST_0]]) + %[[VAL_14]], %[[VAL_13]] * symbol(%[[INDEX_CAST_0]]) + %[[VAL_16]]] : memref<?x?xi32>
// CHECK:                   %[[MAXSI_0:.*]] = arith.maxsi %[[VAL_17]], %[[LOAD_1]] : i32
// CHECK:                   affine.yield %[[MAXSI_0]] : i32
// CHECK:                 }
// CHECK:                 affine.yield %[[FOR_3]] : i32
// CHECK:               }
// CHECK:               affine.store %[[FOR_2]], %[[ARG5]]{{\[}}%[[VAL_12]], %[[VAL_13]]] : memref<?x?xi32>
// CHECK:             }
// CHECK:           }
// CHECK:           return
// CHECK:         }
