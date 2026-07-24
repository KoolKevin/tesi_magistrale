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

// RUN: vekt-opt -vekt16 %s | FileCheck %s

// TODO: qua dovrei partire da loop, purtroppo il passo di specializzazione di mlir20
// non mi specializza se uso interi
func.func @vec_sum(%arg0: memref<?xi32>, %arg1: memref<?xi32>, %arg2: memref<?xi32>, %arg3: i32) attributes {llvm.linkage = #llvm.linkage<external>} {
    linalg.add ins(%arg0, %arg1 : memref<?xi32>, memref<?xi32>) outs(%arg2 : memref<?xi32>)

    return
}

// CHECK-LABEL:   llvm.func @vec_sum(
// CHECK-SAME:      %[[ARG0:.*]]: !llvm.ptr, %[[ARG1:.*]]: !llvm.ptr, %[[ARG2:.*]]: i32, %[[ARG3:.*]]: i32, %[[ARG4:.*]]: i32, %[[ARG5:.*]]: !llvm.ptr, %[[ARG6:.*]]: !llvm.ptr, %[[ARG7:.*]]: i32, %[[ARG8:.*]]: i32, %[[ARG9:.*]]: i32, %[[ARG10:.*]]: !llvm.ptr, %[[ARG11:.*]]: !llvm.ptr, %[[ARG12:.*]]: i32, %[[ARG13:.*]]: i32, %[[ARG14:.*]]: i32, %[[ARG15:.*]]: i32) {
// CHECK:           %[[MLIR_0:.*]] = llvm.mlir.constant(1 : index) : i32
// CHECK:           %[[MLIR_1:.*]] = llvm.mlir.constant(-1 : index) : i32
// CHECK:           %[[MLIR_2:.*]] = llvm.mlir.constant(16 : index) : i32
// CHECK:           %[[MLIR_3:.*]] = llvm.mlir.constant(0 : index) : i32
// CHECK:           %[[PTRTOINT_0:.*]] = llvm.ptrtoint %[[ARG1]] : !llvm.ptr to i32
// CHECK:           %[[INTTOPTR_0:.*]] = llvm.inttoptr %[[PTRTOINT_0]] : i32 to !llvm.ptr<4>
// CHECK:           %[[PTRTOINT_1:.*]] = llvm.ptrtoint %[[ARG6]] : !llvm.ptr to i32
// CHECK:           %[[INTTOPTR_1:.*]] = llvm.inttoptr %[[PTRTOINT_1]] : i32 to !llvm.ptr<4>
// CHECK:           %[[PTRTOINT_2:.*]] = llvm.ptrtoint %[[ARG11]] : !llvm.ptr to i32
// CHECK:           %[[INTTOPTR_2:.*]] = llvm.inttoptr %[[PTRTOINT_2]] : i32 to !llvm.ptr<4>
// CHECK:           %[[ICMP_0:.*]] = llvm.icmp "slt" %[[ARG3]], %[[MLIR_3]] : i32
// CHECK:           %[[SUB_0:.*]] = llvm.sub %[[MLIR_1]], %[[ARG3]] : i32
// CHECK:           %[[SELECT_0:.*]] = llvm.select %[[ICMP_0]], %[[SUB_0]], %[[ARG3]] : i1, i32
// CHECK:           %[[SDIV_0:.*]] = llvm.sdiv %[[SELECT_0]], %[[MLIR_2]] : i32
// CHECK:           %[[SUB_1:.*]] = llvm.sub %[[MLIR_1]], %[[SDIV_0]] : i32
// CHECK:           %[[SELECT_1:.*]] = llvm.select %[[ICMP_0]], %[[SUB_1]], %[[SDIV_0]] : i1, i32
// CHECK:           %[[MUL_0:.*]] = llvm.mul %[[SELECT_1]], %[[MLIR_2]] overflow<nsw> : i32
// CHECK:           llvm.br ^bb1(%[[MLIR_3]] : i32)
// CHECK:         ^bb1(%[[VAL_0:.*]]: i32):
// CHECK:           %[[ICMP_1:.*]] = llvm.icmp "slt" %[[VAL_0]], %[[MUL_0]] : i32
// CHECK:           llvm.cond_br %[[ICMP_1]], ^bb2, ^bb3
// CHECK:         ^bb2:
// CHECK:           %[[GETELEMENTPTR_0:.*]] = llvm.getelementptr %[[INTTOPTR_0]]{{\[}}%[[VAL_0]]] : (!llvm.ptr<4>, i32) -> !llvm.ptr<4>, i32
// CHECK:           %[[GETELEMENTPTR_1:.*]] = llvm.getelementptr %[[INTTOPTR_1]]{{\[}}%[[VAL_0]]] : (!llvm.ptr<4>, i32) -> !llvm.ptr<4>, i32
// CHECK:           %[[GETELEMENTPTR_2:.*]] = llvm.getelementptr %[[INTTOPTR_2]]{{\[}}%[[VAL_0]]] : (!llvm.ptr<4>, i32) -> !llvm.ptr<4>, i32
// CHECK:           %[[VAL_1:.*]] = "ppu.vec_load"(%[[GETELEMENTPTR_0]]) : (!llvm.ptr<4>) -> vector<16xi32>
// CHECK:           %[[VAL_2:.*]] = "ppu.vec_load"(%[[GETELEMENTPTR_1]]) : (!llvm.ptr<4>) -> vector<16xi32>
// CHECK:           %[[VAL_3:.*]] = "ppu.vec_add"(%[[VAL_1]], %[[VAL_2]]) : (vector<16xi32>, vector<16xi32>) -> vector<16xi32>
// CHECK:           "ppu.vec_store"(%[[VAL_3]], %[[GETELEMENTPTR_2]]) : (vector<16xi32>, !llvm.ptr<4>) -> ()
// CHECK:           %[[ADD_0:.*]] = llvm.add %[[VAL_0]], %[[MLIR_2]] : i32
// CHECK:           llvm.br ^bb1(%[[ADD_0]] : i32)
// CHECK:         ^bb3:
// CHECK:           llvm.br ^bb4(%[[MUL_0]] : i32)
// CHECK:         ^bb4(%[[VAL_4:.*]]: i32):
// CHECK:           %[[ICMP_2:.*]] = llvm.icmp "slt" %[[VAL_4]], %[[ARG3]] : i32
// CHECK:           llvm.cond_br %[[ICMP_2]], ^bb5, ^bb6
// CHECK:         ^bb5:
// CHECK:           %[[GETELEMENTPTR_3:.*]] = llvm.getelementptr %[[ARG1]]{{\[}}%[[VAL_4]]] : (!llvm.ptr, i32) -> !llvm.ptr, i32
// CHECK:           %[[LOAD_0:.*]] = llvm.load %[[GETELEMENTPTR_3]] : !llvm.ptr -> i32
// CHECK:           %[[GETELEMENTPTR_4:.*]] = llvm.getelementptr %[[ARG6]]{{\[}}%[[VAL_4]]] : (!llvm.ptr, i32) -> !llvm.ptr, i32
// CHECK:           %[[LOAD_1:.*]] = llvm.load %[[GETELEMENTPTR_4]] : !llvm.ptr -> i32
// CHECK:           %[[ADD_1:.*]] = llvm.add %[[LOAD_0]], %[[LOAD_1]] : i32
// CHECK:           %[[GETELEMENTPTR_5:.*]] = llvm.getelementptr %[[ARG11]]{{\[}}%[[VAL_4]]] : (!llvm.ptr, i32) -> !llvm.ptr, i32
// CHECK:           llvm.store %[[ADD_1]], %[[GETELEMENTPTR_5]] : i32, !llvm.ptr
// CHECK:           %[[ADD_2:.*]] = llvm.add %[[VAL_4]], %[[MLIR_0]] : i32
// CHECK:           llvm.br ^bb4(%[[ADD_2]] : i32)
// CHECK:         ^bb6:
// CHECK:           llvm.return
// CHECK:         }
