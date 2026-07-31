// RUN: vekt-opt -vekt16 %s | FileCheck %s

module {
  func.func @matmul(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: memref<?x?xi32>, %arg4: memref<?x?xi32>, %arg5: memref<?x?xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
    linalg.matmul ins(%arg3, %arg4 : memref<?x?xi32>, memref<?x?xi32>) outs(%arg5 : memref<?x?xi32>)
    return
  }
}

// CHECK-LABEL:   llvm.func @matmul(
// CHECK-SAME:                      %[[ARG0:.*]]: i32, %[[ARG1:.*]]: i32, %[[ARG2:.*]]: i32, %[[ARG3:.*]]: !llvm.ptr, %[[ARG4:.*]]: !llvm.ptr, %[[ARG5:.*]]: i32, %[[ARG6:.*]]: i32, %[[ARG7:.*]]: i32, %[[ARG8:.*]]: i32, %[[ARG9:.*]]: i32, %[[ARG10:.*]]: !llvm.ptr, %[[ARG11:.*]]: !llvm.ptr, %[[ARG12:.*]]: i32, %[[ARG13:.*]]: i32, %[[ARG14:.*]]: i32, %[[ARG15:.*]]: i32, %[[ARG16:.*]]: i32, %[[ARG17:.*]]: !llvm.ptr, %[[ARG18:.*]]: !llvm.ptr, %[[ARG19:.*]]: i32, %[[ARG20:.*]]: i32, %[[ARG21:.*]]: i32, %[[ARG22:.*]]: i32, %[[ARG23:.*]]: i32) {
// CHECK:           %[[MLIR_0:.*]] = llvm.mlir.constant(0 : i32) : i32
// CHECK:           %[[MLIR_1:.*]] = llvm.mlir.constant(dense<0> : vector<16xi32>) : vector<16xi32>
// CHECK:           %[[MLIR_2:.*]] = llvm.mlir.undef : vector<16xi32>
// CHECK:           %[[MLIR_3:.*]] = llvm.mlir.constant(-1 : index) : i32
// CHECK:           %[[MLIR_4:.*]] = llvm.mlir.constant(16 : index) : i32
// CHECK:           %[[MLIR_5:.*]] = llvm.mlir.constant(0 : index) : i32
// CHECK:           %[[MLIR_6:.*]] = llvm.mlir.constant(1 : index) : i32
// CHECK:           %[[PTRTOINT_0:.*]] = llvm.ptrtoint %[[ARG11]] : !llvm.ptr to i32
// CHECK:           %[[INTTOPTR_0:.*]] = llvm.inttoptr %[[PTRTOINT_0]] : i32 to !llvm.ptr<4>
// CHECK:           %[[PTRTOINT_1:.*]] = llvm.ptrtoint %[[ARG18]] : !llvm.ptr to i32
// CHECK:           %[[INTTOPTR_1:.*]] = llvm.inttoptr %[[PTRTOINT_1]] : i32 to !llvm.ptr<4>
// CHECK:           llvm.br ^bb1(%[[MLIR_5]] : i32)
// CHECK:         ^bb1(%[[VAL_0:.*]]: i32):
// CHECK:           %[[ICMP_0:.*]] = llvm.icmp "slt" %[[VAL_0]], %[[ARG6]] : i32
// CHECK:           llvm.cond_br %[[ICMP_0]], ^bb2, ^bb9
// CHECK:         ^bb2:
// CHECK:           %[[ICMP_1:.*]] = llvm.icmp "slt" %[[ARG14]], %[[MLIR_5]] : i32
// CHECK:           %[[SUB_0:.*]] = llvm.sub %[[MLIR_3]], %[[ARG14]] : i32
// CHECK:           %[[SELECT_0:.*]] = llvm.select %[[ICMP_1]], %[[SUB_0]], %[[ARG14]] : i1, i32
// CHECK:           %[[SDIV_0:.*]] = llvm.sdiv %[[SELECT_0]], %[[MLIR_4]] : i32
// CHECK:           %[[SUB_1:.*]] = llvm.sub %[[MLIR_3]], %[[SDIV_0]] : i32
// CHECK:           %[[SELECT_1:.*]] = llvm.select %[[ICMP_1]], %[[SUB_1]], %[[SDIV_0]] : i1, i32
// CHECK:           %[[MUL_0:.*]] = llvm.mul %[[SELECT_1]], %[[MLIR_4]] overflow<nsw> : i32
// CHECK:           llvm.br ^bb3(%[[MLIR_5]] : i32)
// CHECK:         ^bb3(%[[VAL_1:.*]]: i32):
// CHECK:           %[[ICMP_2:.*]] = llvm.icmp "slt" %[[VAL_1]], %[[MUL_0]] : i32
// CHECK:           llvm.cond_br %[[ICMP_2]], ^bb4, ^bb8
// CHECK:         ^bb4:
// CHECK:           %[[MUL_1:.*]] = llvm.mul %[[VAL_0]], %[[ARG14]] : i32
// CHECK:           %[[ADD_0:.*]] = llvm.add %[[MUL_1]], %[[VAL_1]] : i32
// CHECK:           %[[GETELEMENTPTR_0:.*]] = llvm.getelementptr %[[INTTOPTR_1]]{{\[}}%[[ADD_0]]] : (!llvm.ptr<4>, i32) -> !llvm.ptr<4>, i32
// CHECK:           %[[VAL_2:.*]] = "ppu.vec_load"(%[[GETELEMENTPTR_0]]) : (!llvm.ptr<4>) -> vector<16xi32>
// CHECK:           %[[VAL_3:.*]] = "ppu.vec_add_init_acc"(%[[VAL_2]], %[[MLIR_1]]) : (vector<16xi32>, vector<16xi32>) -> vector<16xi32>
// CHECK:           llvm.br ^bb5(%[[MLIR_5]], %[[VAL_3]] : i32, vector<16xi32>)
// CHECK:         ^bb5(%[[VAL_4:.*]]: i32, %[[VAL_5:.*]]: vector<16xi32>):
// CHECK:           %[[ICMP_3:.*]] = llvm.icmp "slt" %[[VAL_4]], %[[ARG7]] : i32
// CHECK:           llvm.cond_br %[[ICMP_3]], ^bb6, ^bb7
// CHECK:         ^bb6:
// CHECK:           %[[MUL_2:.*]] = llvm.mul %[[VAL_4]], %[[ARG14]] : i32
// CHECK:           %[[ADD_1:.*]] = llvm.add %[[MUL_2]], %[[VAL_1]] : i32
// CHECK:           %[[GETELEMENTPTR_1:.*]] = llvm.getelementptr %[[INTTOPTR_0]]{{\[}}%[[ADD_1]]] : (!llvm.ptr<4>, i32) -> !llvm.ptr<4>, i32
// CHECK:           %[[VAL_6:.*]] = "ppu.vec_load"(%[[GETELEMENTPTR_1]]) : (!llvm.ptr<4>) -> vector<16xi32>
// CHECK:           %[[MUL_3:.*]] = llvm.mul %[[VAL_0]], %[[ARG8]] : i32
// CHECK:           %[[ADD_2:.*]] = llvm.add %[[MUL_3]], %[[VAL_4]] : i32
// CHECK:           %[[GETELEMENTPTR_2:.*]] = llvm.getelementptr %[[ARG4]]{{\[}}%[[ADD_2]]] : (!llvm.ptr, i32) -> !llvm.ptr, i32
// CHECK:           %[[LOAD_0:.*]] = llvm.load %[[GETELEMENTPTR_2]] : !llvm.ptr -> i32
// CHECK:           %[[INSERTELEMENT_0:.*]] = llvm.insertelement %[[LOAD_0]], %[[MLIR_2]]{{\[}}%[[MLIR_0]] : i32] : vector<16xi32>
// CHECK:           %[[SHUFFLEVECTOR_0:.*]] = llvm.shufflevector %[[INSERTELEMENT_0]], %[[MLIR_2]] [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<16xi32>
// CHECK:           %[[VAL_7:.*]] = "ppu.vec_mac_low"(%[[VAL_5]], %[[VAL_6]], %[[SHUFFLEVECTOR_0]]) : (vector<16xi32>, vector<16xi32>, vector<16xi32>) -> vector<16xi32>
// CHECK:           %[[ADD_3:.*]] = llvm.add %[[VAL_4]], %[[MLIR_6]] : i32
// CHECK:           llvm.br ^bb5(%[[ADD_3]], %[[VAL_7]] : i32, vector<16xi32>)
// CHECK:         ^bb7:
// CHECK:           %[[VAL_8:.*]] = "ppu.acc_to_vec"(%[[VAL_5]]) : (vector<16xi32>) -> vector<16xi32>
// CHECK:           "ppu.vec_store"(%[[VAL_8]], %[[GETELEMENTPTR_0]]) : (vector<16xi32>, !llvm.ptr<4>) -> ()
// CHECK:           %[[ADD_4:.*]] = llvm.add %[[VAL_1]], %[[MLIR_4]] : i32
// CHECK:           llvm.br ^bb3(%[[ADD_4]] : i32)
// CHECK:         ^bb8:
// CHECK:           %[[ADD_5:.*]] = llvm.add %[[VAL_0]], %[[MLIR_6]] : i32
// CHECK:           llvm.br ^bb1(%[[ADD_5]] : i32)
// CHECK:         ^bb9:
// CHECK:           llvm.br ^bb10(%[[MLIR_5]] : i32)
// CHECK:         ^bb10(%[[VAL_9:.*]]: i32):
// CHECK:           %[[ICMP_4:.*]] = llvm.icmp "slt" %[[VAL_9]], %[[ARG6]] : i32
// CHECK:           llvm.cond_br %[[ICMP_4]], ^bb11, ^bb18
// CHECK:         ^bb11:
// CHECK:           %[[ICMP_5:.*]] = llvm.icmp "slt" %[[ARG14]], %[[MLIR_5]] : i32
// CHECK:           %[[SUB_2:.*]] = llvm.sub %[[MLIR_3]], %[[ARG14]] : i32
// CHECK:           %[[SELECT_2:.*]] = llvm.select %[[ICMP_5]], %[[SUB_2]], %[[ARG14]] : i1, i32
// CHECK:           %[[SDIV_1:.*]] = llvm.sdiv %[[SELECT_2]], %[[MLIR_4]] : i32
// CHECK:           %[[SUB_3:.*]] = llvm.sub %[[MLIR_3]], %[[SDIV_1]] : i32
// CHECK:           %[[SELECT_3:.*]] = llvm.select %[[ICMP_5]], %[[SUB_3]], %[[SDIV_1]] : i1, i32
// CHECK:           %[[MUL_4:.*]] = llvm.mul %[[SELECT_3]], %[[MLIR_4]] overflow<nsw> : i32
// CHECK:           llvm.br ^bb12(%[[MUL_4]] : i32)
// CHECK:         ^bb12(%[[VAL_10:.*]]: i32):
// CHECK:           %[[ICMP_6:.*]] = llvm.icmp "slt" %[[VAL_10]], %[[ARG14]] : i32
// CHECK:           llvm.cond_br %[[ICMP_6]], ^bb13, ^bb17
// CHECK:         ^bb13:
// CHECK:           llvm.br ^bb14(%[[MLIR_5]], %[[MLIR_0]] : i32, i32)
// CHECK:         ^bb14(%[[VAL_11:.*]]: i32, %[[VAL_12:.*]]: i32):
// CHECK:           %[[ICMP_7:.*]] = llvm.icmp "slt" %[[VAL_11]], %[[ARG7]] : i32
// CHECK:           llvm.cond_br %[[ICMP_7]], ^bb15, ^bb16
// CHECK:         ^bb15:
// CHECK:           %[[MUL_5:.*]] = llvm.mul %[[VAL_9]], %[[ARG8]] : i32
// CHECK:           %[[ADD_6:.*]] = llvm.add %[[MUL_5]], %[[VAL_11]] : i32
// CHECK:           %[[GETELEMENTPTR_3:.*]] = llvm.getelementptr %[[ARG4]]{{\[}}%[[ADD_6]]] : (!llvm.ptr, i32) -> !llvm.ptr, i32
// CHECK:           %[[LOAD_1:.*]] = llvm.load %[[GETELEMENTPTR_3]] : !llvm.ptr -> i32
// CHECK:           %[[MUL_6:.*]] = llvm.mul %[[VAL_11]], %[[ARG15]] : i32
// CHECK:           %[[ADD_7:.*]] = llvm.add %[[MUL_6]], %[[VAL_10]] : i32
// CHECK:           %[[GETELEMENTPTR_4:.*]] = llvm.getelementptr %[[ARG11]]{{\[}}%[[ADD_7]]] : (!llvm.ptr, i32) -> !llvm.ptr, i32
// CHECK:           %[[LOAD_2:.*]] = llvm.load %[[GETELEMENTPTR_4]] : !llvm.ptr -> i32
// CHECK:           %[[MUL_7:.*]] = llvm.mul %[[LOAD_1]], %[[LOAD_2]] : i32
// CHECK:           %[[ADD_8:.*]] = llvm.add %[[VAL_12]], %[[MUL_7]] : i32
// CHECK:           %[[ADD_9:.*]] = llvm.add %[[VAL_11]], %[[MLIR_6]] : i32
// CHECK:           llvm.br ^bb14(%[[ADD_9]], %[[ADD_8]] : i32, i32)
// CHECK:         ^bb16:
// CHECK:           %[[MUL_8:.*]] = llvm.mul %[[VAL_9]], %[[ARG22]] : i32
// CHECK:           %[[ADD_10:.*]] = llvm.add %[[MUL_8]], %[[VAL_10]] : i32
// CHECK:           %[[GETELEMENTPTR_5:.*]] = llvm.getelementptr %[[ARG18]]{{\[}}%[[ADD_10]]] : (!llvm.ptr, i32) -> !llvm.ptr, i32
// CHECK:           llvm.store %[[VAL_12]], %[[GETELEMENTPTR_5]] : i32, !llvm.ptr
// CHECK:           %[[ADD_11:.*]] = llvm.add %[[VAL_10]], %[[MLIR_6]] : i32
// CHECK:           llvm.br ^bb12(%[[ADD_11]] : i32)
// CHECK:         ^bb17:
// CHECK:           %[[ADD_12:.*]] = llvm.add %[[VAL_9]], %[[MLIR_6]] : i32
// CHECK:           llvm.br ^bb10(%[[ADD_12]] : i32)
// CHECK:         ^bb18:
// CHECK:           llvm.return
// CHECK:         }
