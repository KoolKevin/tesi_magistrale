// RUN: vekt-opt -vekt16 %s | FileCheck %s

// NB: Specializzato da generic utilizzando mlir23
// build/bin/vekt-opt -ppu-normalize-iterargs-reductions -ppu-raise-affine-to-linalg-generic test/vekt/raising/conv1d.affine.mlir
//      | ~/llvm-project/build/bin/mlir-opt -linalg-morph-ops="generic-to-named"
func.func @conv1d(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: memref<?xi32>, %arg4: memref<?xi32>, %arg5: memref<?xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
    linalg.conv_1d ins(%arg4, %arg5 : memref<?xi32>, memref<?xi32>) outs(%arg3 : memref<?xi32>)
    return
}

// CHECK-LABEL:   llvm.func @conv1d(
// CHECK-SAME:                      %[[ARG0:.*]]: i32, %[[ARG1:.*]]: i32, %[[ARG2:.*]]: i32, %[[ARG3:.*]]: !llvm.ptr, %[[ARG4:.*]]: !llvm.ptr, %[[ARG5:.*]]: i32, %[[ARG6:.*]]: i32, %[[ARG7:.*]]: i32, %[[ARG8:.*]]: !llvm.ptr, %[[ARG9:.*]]: !llvm.ptr, %[[ARG10:.*]]: i32, %[[ARG11:.*]]: i32, %[[ARG12:.*]]: i32, %[[ARG13:.*]]: !llvm.ptr, %[[ARG14:.*]]: !llvm.ptr, %[[ARG15:.*]]: i32, %[[ARG16:.*]]: i32, %[[ARG17:.*]]: i32) {
// CHECK:           %[[MLIR_0:.*]] = llvm.mlir.constant(dense<0> : vector<16xi32>) : vector<16xi32>
// CHECK:           %[[MLIR_1:.*]] = llvm.mlir.undef : vector<16xi32>
// CHECK:           %[[MLIR_2:.*]] = llvm.mlir.constant(0 : i32) : i32
// CHECK:           %[[MLIR_3:.*]] = llvm.mlir.constant(1 : index) : i32
// CHECK:           %[[MLIR_4:.*]] = llvm.mlir.constant(-1 : index) : i32
// CHECK:           %[[MLIR_5:.*]] = llvm.mlir.constant(16 : index) : i32
// CHECK:           %[[MLIR_6:.*]] = llvm.mlir.constant(0 : index) : i32
// CHECK:           %[[PTRTOINT_0:.*]] = llvm.ptrtoint %[[ARG9]] : !llvm.ptr to i32
// CHECK:           %[[INTTOPTR_0:.*]] = llvm.inttoptr %[[PTRTOINT_0]] : i32 to !llvm.ptr<4>
// CHECK:           %[[PTRTOINT_1:.*]] = llvm.ptrtoint %[[ARG4]] : !llvm.ptr to i32
// CHECK:           %[[INTTOPTR_1:.*]] = llvm.inttoptr %[[PTRTOINT_1]] : i32 to !llvm.ptr<4>
// CHECK:           %[[ICMP_0:.*]] = llvm.icmp "slt" %[[ARG6]], %[[MLIR_6]] : i32
// CHECK:           %[[SUB_0:.*]] = llvm.sub %[[MLIR_4]], %[[ARG6]] : i32
// CHECK:           %[[SELECT_0:.*]] = llvm.select %[[ICMP_0]], %[[SUB_0]], %[[ARG6]] : i1, i32
// CHECK:           %[[SDIV_0:.*]] = llvm.sdiv %[[SELECT_0]], %[[MLIR_5]] : i32
// CHECK:           %[[SUB_1:.*]] = llvm.sub %[[MLIR_4]], %[[SDIV_0]] : i32
// CHECK:           %[[SELECT_1:.*]] = llvm.select %[[ICMP_0]], %[[SUB_1]], %[[SDIV_0]] : i1, i32
// CHECK:           %[[MUL_0:.*]] = llvm.mul %[[SELECT_1]], %[[MLIR_5]] overflow<nsw> : i32
// CHECK:           llvm.br ^bb1(%[[MLIR_6]] : i32)
// CHECK:         ^bb1(%[[VAL_0:.*]]: i32):
// CHECK:           %[[ICMP_1:.*]] = llvm.icmp "slt" %[[VAL_0]], %[[MUL_0]] : i32
// CHECK:           llvm.cond_br %[[ICMP_1]], ^bb2, ^bb6
// CHECK:         ^bb2:
// CHECK:           %[[GETELEMENTPTR_0:.*]] = llvm.getelementptr %[[INTTOPTR_1]]{{\[}}%[[VAL_0]]] : (!llvm.ptr<4>, i32) -> !llvm.ptr<4>, i32
// CHECK:           %[[VAL_1:.*]] = "ppu.vec_load"(%[[GETELEMENTPTR_0]]) : (!llvm.ptr<4>) -> vector<16xi32>
// CHECK:           %[[VAL_2:.*]] = "ppu.vec_add_init_acc"(%[[VAL_1]], %[[MLIR_0]]) : (vector<16xi32>, vector<16xi32>) -> vector<16xi32>
// CHECK:           llvm.br ^bb3(%[[MLIR_6]], %[[VAL_2]] : i32, vector<16xi32>)
// CHECK:         ^bb3(%[[VAL_3:.*]]: i32, %[[VAL_4:.*]]: vector<16xi32>):
// CHECK:           %[[ICMP_2:.*]] = llvm.icmp "slt" %[[VAL_3]], %[[ARG16]] : i32
// CHECK:           llvm.cond_br %[[ICMP_2]], ^bb4, ^bb5
// CHECK:         ^bb4:
// CHECK:           %[[ADD_0:.*]] = llvm.add %[[VAL_0]], %[[VAL_3]] : i32
// CHECK:           %[[GETELEMENTPTR_1:.*]] = llvm.getelementptr %[[INTTOPTR_0]]{{\[}}%[[ADD_0]]] : (!llvm.ptr<4>, i32) -> !llvm.ptr<4>, i32
// CHECK:           %[[VAL_5:.*]] = "ppu.vec_load"(%[[GETELEMENTPTR_1]]) : (!llvm.ptr<4>) -> vector<16xi32>
// CHECK:           %[[GETELEMENTPTR_2:.*]] = llvm.getelementptr %[[ARG14]]{{\[}}%[[VAL_3]]] : (!llvm.ptr, i32) -> !llvm.ptr, i32
// CHECK:           %[[LOAD_0:.*]] = llvm.load %[[GETELEMENTPTR_2]] : !llvm.ptr -> i32
// CHECK:           %[[INSERTELEMENT_0:.*]] = llvm.insertelement %[[LOAD_0]], %[[MLIR_1]]{{\[}}%[[MLIR_2]] : i32] : vector<16xi32>
// CHECK:           %[[SHUFFLEVECTOR_0:.*]] = llvm.shufflevector %[[INSERTELEMENT_0]], %[[MLIR_1]] [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<16xi32>
// CHECK:           %[[VAL_6:.*]] = "ppu.vec_mac_low"(%[[VAL_4]], %[[VAL_5]], %[[SHUFFLEVECTOR_0]]) : (vector<16xi32>, vector<16xi32>, vector<16xi32>) -> vector<16xi32>
// CHECK:           %[[ADD_1:.*]] = llvm.add %[[VAL_3]], %[[MLIR_3]] : i32
// CHECK:           llvm.br ^bb3(%[[ADD_1]], %[[VAL_6]] : i32, vector<16xi32>)
// CHECK:         ^bb5:
// CHECK:           %[[VAL_7:.*]] = "ppu.acc_to_vec"(%[[VAL_4]]) : (vector<16xi32>) -> vector<16xi32>
// CHECK:           "ppu.vec_store"(%[[VAL_7]], %[[GETELEMENTPTR_0]]) : (vector<16xi32>, !llvm.ptr<4>) -> ()
// CHECK:           %[[ADD_2:.*]] = llvm.add %[[VAL_0]], %[[MLIR_5]] : i32
// CHECK:           llvm.br ^bb1(%[[ADD_2]] : i32)
// CHECK:         ^bb6:
// CHECK:           llvm.br ^bb7(%[[MUL_0]] : i32)
// CHECK:         ^bb7(%[[VAL_8:.*]]: i32):
// CHECK:           %[[ICMP_3:.*]] = llvm.icmp "slt" %[[VAL_8]], %[[ARG6]] : i32
// CHECK:           llvm.cond_br %[[ICMP_3]], ^bb8, ^bb12
// CHECK:         ^bb8:
// CHECK:           %[[GETELEMENTPTR_3:.*]] = llvm.getelementptr %[[ARG4]]{{\[}}%[[VAL_8]]] : (!llvm.ptr, i32) -> !llvm.ptr, i32
// CHECK:           %[[LOAD_1:.*]] = llvm.load %[[GETELEMENTPTR_3]] : !llvm.ptr -> i32
// CHECK:           llvm.br ^bb9(%[[MLIR_6]], %[[LOAD_1]] : i32, i32)
// CHECK:         ^bb9(%[[VAL_9:.*]]: i32, %[[VAL_10:.*]]: i32):
// CHECK:           %[[ICMP_4:.*]] = llvm.icmp "slt" %[[VAL_9]], %[[ARG16]] : i32
// CHECK:           llvm.cond_br %[[ICMP_4]], ^bb10, ^bb11
// CHECK:         ^bb10:
// CHECK:           %[[ADD_3:.*]] = llvm.add %[[VAL_8]], %[[VAL_9]] : i32
// CHECK:           %[[GETELEMENTPTR_4:.*]] = llvm.getelementptr %[[ARG9]]{{\[}}%[[ADD_3]]] : (!llvm.ptr, i32) -> !llvm.ptr, i32
// CHECK:           %[[LOAD_2:.*]] = llvm.load %[[GETELEMENTPTR_4]] : !llvm.ptr -> i32
// CHECK:           %[[GETELEMENTPTR_5:.*]] = llvm.getelementptr %[[ARG14]]{{\[}}%[[VAL_9]]] : (!llvm.ptr, i32) -> !llvm.ptr, i32
// CHECK:           %[[LOAD_3:.*]] = llvm.load %[[GETELEMENTPTR_5]] : !llvm.ptr -> i32
// CHECK:           %[[MUL_1:.*]] = llvm.mul %[[LOAD_2]], %[[LOAD_3]] : i32
// CHECK:           %[[ADD_4:.*]] = llvm.add %[[VAL_10]], %[[MUL_1]] : i32
// CHECK:           %[[ADD_5:.*]] = llvm.add %[[VAL_9]], %[[MLIR_3]] : i32
// CHECK:           llvm.br ^bb9(%[[ADD_5]], %[[ADD_4]] : i32, i32)
// CHECK:         ^bb11:
// CHECK:           llvm.store %[[VAL_10]], %[[GETELEMENTPTR_3]] : i32, !llvm.ptr
// CHECK:           %[[ADD_6:.*]] = llvm.add %[[VAL_8]], %[[MLIR_3]] : i32
// CHECK:           llvm.br ^bb7(%[[ADD_6]] : i32)
// CHECK:         ^bb12:
// CHECK:           llvm.return
// CHECK:         }
