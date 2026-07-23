// NB: IR ottenuta tramite il seguente comando contorto:
//
// ```
//   build/bin/vekt-opt -ppu-normalize-iterargs-reductions -ppu-raise-affine-to-linalg-generic test/vekt/raising/vec_sum.affine.mlir |
//     ~/llvm-project/build/bin/mlir-opt -linalg-morph-ops="generic-to-named named-to-category"
// ```
//
// Devo fare questo giro strano dato che sto usando mlir 20 che non supporta il passo "linalg-morph-ops"
// (solo un passo deprecato chiamto -linalg-specialize-specialize-generic-ops che non gestisce molti casi).
// Anche questa mia soluzione non è il massimo dato che ad esempio non specializza vec_sum se uso i32 al
// al posto di f32, dovrei passare a mlir 24 (qua ho cambiato il tipo a mano). Chiaramente, la soluzione
// migliore sarebbe scrivere il mio passo di specializzazione.

// func.func @vec_sum(%arg0: memref<?xi32>, %arg1: memref<?xi32>, %arg2: memref<?xi32>, %arg3: i32) attributes {llvm.linkage = #llvm.linkage<external>} {
//   linalg.elementwise kind=#linalg.elementwise_kind<add> ins(%arg0, %arg1 : memref<?xi32>, memref<?xi32>) outs(%arg2 : memref<?xi32>)
//   return
// }

// NB: alla fine ho deciso di rimanere in mlir20 e utilizzare il passo di specializzazione antiquato
//  dato che mlir20 non ha linalg.elementwise ma piuttosto separa in elemwise_binary ed elemwise_unary.

// RUN: vekt-opt -convert-linalg-to-ppu-algorithm -canonicalize %s | FileCheck %s

func.func @vec_sum(%arg0: memref<?xi32>, %arg1: memref<?xi32>, %arg2: memref<?xi32>, %arg3: i32) attributes {llvm.linkage = #llvm.linkage<external>} {
    linalg.add ins(%arg0, %arg1 : memref<?xi32>, memref<?xi32>) outs(%arg2 : memref<?xi32>)

    return
}

// CHECK: #[[$ATTR_0:.+]] = affine_map<()[s0] -> ((s0 floordiv 16) * 16)>
// CHECK-LABEL:   func.func @vec_sum(
// CHECK-SAME:      %[[ARG0:.*]]: memref<?xi32>, %[[ARG1:.*]]: memref<?xi32>, %[[ARG2:.*]]: memref<?xi32>, %[[ARG3:.*]]: i32) attributes {llvm.linkage = #llvm.linkage<external>} {
// CHECK:           %[[CONSTANT_0:.*]] = arith.constant 0 : index
// CHECK:           %[[DIM_0:.*]] = memref.dim %[[ARG0]], %[[CONSTANT_0]] : memref<?xi32>
// CHECK:           %[[EXTRACT_ALIGNED_POINTER_AS_INDEX_0:.*]] = memref.extract_aligned_pointer_as_index %[[ARG0]] : memref<?xi32> -> index
// CHECK:           %[[INDEX_CAST_0:.*]] = arith.index_cast %[[EXTRACT_ALIGNED_POINTER_AS_INDEX_0]] : index to i64
// CHECK:           %[[INTTOPTR_0:.*]] = llvm.inttoptr %[[INDEX_CAST_0]] : i64 to !llvm.ptr<4>
// CHECK:           %[[EXTRACT_ALIGNED_POINTER_AS_INDEX_1:.*]] = memref.extract_aligned_pointer_as_index %[[ARG1]] : memref<?xi32> -> index
// CHECK:           %[[INDEX_CAST_1:.*]] = arith.index_cast %[[EXTRACT_ALIGNED_POINTER_AS_INDEX_1]] : index to i64
// CHECK:           %[[INTTOPTR_1:.*]] = llvm.inttoptr %[[INDEX_CAST_1]] : i64 to !llvm.ptr<4>
// CHECK:           %[[EXTRACT_ALIGNED_POINTER_AS_INDEX_2:.*]] = memref.extract_aligned_pointer_as_index %[[ARG2]] : memref<?xi32> -> index
// CHECK:           %[[INDEX_CAST_2:.*]] = arith.index_cast %[[EXTRACT_ALIGNED_POINTER_AS_INDEX_2]] : index to i64
// CHECK:           %[[INTTOPTR_2:.*]] = llvm.inttoptr %[[INDEX_CAST_2]] : i64 to !llvm.ptr<4>
// CHECK:           affine.for %[[VAL_0:.*]] = 0 to #[[$ATTR_0]](){{\[}}%[[DIM_0]]] step 16 {
// CHECK:             %[[INDEX_CAST_3:.*]] = arith.index_cast %[[VAL_0]] : index to i32
// CHECK:             %[[GETELEMENTPTR_0:.*]] = llvm.getelementptr %[[INTTOPTR_0]]{{\[}}%[[INDEX_CAST_3]]] : (!llvm.ptr<4>, i32) -> !llvm.ptr<4>, i32
// CHECK:             %[[INDEX_CAST_4:.*]] = arith.index_cast %[[VAL_0]] : index to i32
// CHECK:             %[[GETELEMENTPTR_1:.*]] = llvm.getelementptr %[[INTTOPTR_1]]{{\[}}%[[INDEX_CAST_4]]] : (!llvm.ptr<4>, i32) -> !llvm.ptr<4>, i32
// CHECK:             %[[INDEX_CAST_5:.*]] = arith.index_cast %[[VAL_0]] : index to i32
// CHECK:             %[[GETELEMENTPTR_2:.*]] = llvm.getelementptr %[[INTTOPTR_2]]{{\[}}%[[INDEX_CAST_5]]] : (!llvm.ptr<4>, i32) -> !llvm.ptr<4>, i32
// CHECK:             %[[VAL_1:.*]] = "ppu.vec_load"(%[[GETELEMENTPTR_0]]) : (!llvm.ptr<4>) -> vector<16xi32>
// CHECK:             %[[VAL_2:.*]] = "ppu.vec_load"(%[[GETELEMENTPTR_1]]) : (!llvm.ptr<4>) -> vector<16xi32>
// CHECK:             %[[VAL_3:.*]] = "ppu.vec_add"(%[[VAL_1]], %[[VAL_2]]) : (vector<16xi32>, vector<16xi32>) -> vector<16xi32>
// CHECK:             "ppu.vec_store"(%[[VAL_3]], %[[GETELEMENTPTR_2]]) : (vector<16xi32>, !llvm.ptr<4>) -> ()
// CHECK:           }
// CHECK:           affine.for %[[VAL_4:.*]] = #[[$ATTR_0]](){{\[}}%[[DIM_0]]] to %[[DIM_0]] {
// CHECK:             %[[LOAD_0:.*]] = affine.load %[[ARG0]]{{\[}}%[[VAL_4]]] : memref<?xi32>
// CHECK:             %[[LOAD_1:.*]] = affine.load %[[ARG1]]{{\[}}%[[VAL_4]]] : memref<?xi32>
// CHECK:             %[[ADDI_0:.*]] = arith.addi %[[LOAD_0]], %[[LOAD_1]] : i32
// CHECK:             affine.store %[[ADDI_0]], %[[ARG2]]{{\[}}%[[VAL_4]]] : memref<?xi32>
// CHECK:           }
// CHECK:           return
// CHECK:         }
