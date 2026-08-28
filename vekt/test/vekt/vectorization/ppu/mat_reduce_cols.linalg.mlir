// RUN: vekt-opt -vekt %s | FileCheck %s

func.func @reduce_cols(%arg0: i32, %arg1: i32, %arg2: memref<?x?xi32>, %arg3: memref<?xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
    linalg.reduce { arith.addi {overflowFlags = #arith.overflow<none>} } ins(%arg2 : memref<?x?xi32>) outs(%arg3 : memref<?xi32>) dimensions = [0]
    return
}

// CHECK: #[[$ATTR_0:.+]] = affine_map<()[s0] -> ((s0 floordiv 16) * 16)>
// CHECK-LABEL:   func.func @reduce_cols(
// CHECK-SAME:      %[[ARG0:.*]]: i32, %[[ARG1:.*]]: i32, %[[ARG2:.*]]: memref<?x?xi32>, %[[ARG3:.*]]: memref<?xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
// CHECK:           %[[CONSTANT_0:.*]] = arith.constant 0 : i32
// CHECK:           %[[CONSTANT_1:.*]] = arith.constant dense<0> : vector<16xi32>
// CHECK:           %[[CONSTANT_2:.*]] = arith.constant 1 : index
// CHECK:           %[[CONSTANT_3:.*]] = arith.constant 0 : index
// CHECK:           %[[DIM_0:.*]] = memref.dim %[[ARG2]], %[[CONSTANT_3]] : memref<?x?xi32>
// CHECK:           %[[DIM_1:.*]] = memref.dim %[[ARG2]], %[[CONSTANT_2]] : memref<?x?xi32>
// CHECK:           %[[EXTRACT_ALIGNED_POINTER_AS_INDEX_0:.*]] = memref.extract_aligned_pointer_as_index %[[ARG2]] : memref<?x?xi32> -> index
// CHECK:           %[[INDEX_CAST_0:.*]] = arith.index_cast %[[EXTRACT_ALIGNED_POINTER_AS_INDEX_0]] : index to i32
// CHECK:           %[[INTTOPTR_0:.*]] = llvm.inttoptr %[[INDEX_CAST_0]] : i32 to !llvm.ptr<4>
// CHECK:           %[[EXTRACT_ALIGNED_POINTER_AS_INDEX_1:.*]] = memref.extract_aligned_pointer_as_index %[[ARG3]] : memref<?xi32> -> index
// CHECK:           %[[INDEX_CAST_1:.*]] = arith.index_cast %[[EXTRACT_ALIGNED_POINTER_AS_INDEX_1]] : index to i32
// CHECK:           %[[INTTOPTR_1:.*]] = llvm.inttoptr %[[INDEX_CAST_1]] : i32 to !llvm.ptr<4>
// CHECK:           affine.for %[[VAL_0:.*]] = 0 to #[[$ATTR_0]](){{\[}}%[[DIM_1]]] step 16 {
// CHECK:             %[[FOR_0:.*]] = affine.for %[[VAL_1:.*]] = 0 to %[[DIM_0]] iter_args(%[[VAL_2:.*]] = %[[CONSTANT_1]]) -> (vector<16xi32>) {
// CHECK:               %[[MULI_0:.*]] = arith.muli %[[VAL_1]], %[[DIM_1]] : index
// CHECK:               %[[ADDI_0:.*]] = arith.addi %[[MULI_0]], %[[VAL_0]] : index
// CHECK:               %[[INDEX_CAST_2:.*]] = arith.index_cast %[[ADDI_0]] : index to i32
// CHECK:               %[[GETELEMENTPTR_0:.*]] = llvm.getelementptr %[[INTTOPTR_0]]{{\[}}%[[INDEX_CAST_2]]] : (!llvm.ptr<4>, i32) -> !llvm.ptr<4>, i32
// CHECK:               %[[VAL_3:.*]] = "ppu.vec_load"(%[[GETELEMENTPTR_0]]) : (!llvm.ptr<4>) -> vector<16xi32>
// CHECK:               %[[VAL_4:.*]] = "ppu.vec_add"(%[[VAL_2]], %[[VAL_3]]) : (vector<16xi32>, vector<16xi32>) -> vector<16xi32>
// CHECK:               affine.yield %[[VAL_4]] : vector<16xi32>
// CHECK:             }
// CHECK:             %[[INDEX_CAST_3:.*]] = arith.index_cast %[[VAL_0]] : index to i32
// CHECK:             %[[GETELEMENTPTR_1:.*]] = llvm.getelementptr %[[INTTOPTR_1]]{{\[}}%[[INDEX_CAST_3]]] : (!llvm.ptr<4>, i32) -> !llvm.ptr<4>, i32
// CHECK:             "ppu.vec_store"(%[[FOR_0]], %[[GETELEMENTPTR_1]]) : (vector<16xi32>, !llvm.ptr<4>) -> ()
// CHECK:           }
// CHECK:           affine.for %[[VAL_5:.*]] = #[[$ATTR_0]](){{\[}}%[[DIM_1]]] to %[[DIM_1]] {
// CHECK:             %[[FOR_1:.*]] = affine.for %[[VAL_6:.*]] = 0 to %[[DIM_0]] iter_args(%[[VAL_7:.*]] = %[[CONSTANT_0]]) -> (i32) {
// CHECK:               %[[LOAD_0:.*]] = affine.load %[[ARG2]]{{\[}}%[[VAL_6]], %[[VAL_5]]] : memref<?x?xi32>
// CHECK:               %[[ADDI_1:.*]] = arith.addi %[[VAL_7]], %[[LOAD_0]] : i32
// CHECK:               affine.yield %[[ADDI_1]] : i32
// CHECK:             }
// CHECK:             affine.store %[[FOR_1]], %[[ARG3]]{{\[}}%[[VAL_5]]] : memref<?xi32>
// CHECK:           }
// CHECK:           return
// CHECK:         }
