// RUN: vekt-opt -vekt16 %s | FileCheck %s

module {
  func.func @dotp(%arg0: memref<?xi32>, %arg1: memref<?xi32>, %arg2: i32) -> i32 attributes {llvm.linkage = #llvm.linkage<external>} {
    %c0_i32 = arith.constant 0 : i32
    %alloca = memref.alloca() : memref<i32>
    affine.store %c0_i32, %alloca[] : memref<i32>
    linalg.dot ins(%arg0, %arg1 : memref<?xi32>, memref<?xi32>) outs(%alloca : memref<i32>)
    %0 = affine.load %alloca[] : memref<i32>
    return %0 : i32
  }
}

// CHECK-LABEL:   llvm.func @dotp(
// CHECK-SAME:                    %[[ARG0:.*]]: !llvm.ptr, %[[ARG1:.*]]: !llvm.ptr, %[[ARG2:.*]]: i32, %[[ARG3:.*]]: i32, %[[ARG4:.*]]: i32, %[[ARG5:.*]]: !llvm.ptr, %[[ARG6:.*]]: !llvm.ptr, %[[ARG7:.*]]: i32, %[[ARG8:.*]]: i32, %[[ARG9:.*]]: i32, %[[ARG10:.*]]: i32) -> i32 {
// CHECK:           %[[MLIR_0:.*]] = llvm.mlir.constant(dense<0> : vector<16xi32>) : vector<16xi32>
// CHECK:           %[[MLIR_1:.*]] = llvm.mlir.constant(-1 : index) : i32
// CHECK:           %[[MLIR_2:.*]] = llvm.mlir.constant(16 : index) : i32
// CHECK:           %[[MLIR_3:.*]] = llvm.mlir.constant(1 : index) : i32
// CHECK:           %[[MLIR_4:.*]] = llvm.mlir.constant(0 : index) : i32
// CHECK:           %[[VAL_0:.*]] = "ppu.vec_mpy_low_acc"(%[[MLIR_0]], %[[MLIR_0]]) : (vector<16xi32>, vector<16xi32>) -> vector<16xi32>
// CHECK:           %[[PTRTOINT_0:.*]] = llvm.ptrtoint %[[ARG1]] : !llvm.ptr to i32
// CHECK:           %[[INTTOPTR_0:.*]] = llvm.inttoptr %[[PTRTOINT_0]] : i32 to !llvm.ptr<4>
// CHECK:           %[[PTRTOINT_1:.*]] = llvm.ptrtoint %[[ARG6]] : !llvm.ptr to i32
// CHECK:           %[[INTTOPTR_1:.*]] = llvm.inttoptr %[[PTRTOINT_1]] : i32 to !llvm.ptr<4>
// CHECK:           %[[ICMP_0:.*]] = llvm.icmp "slt" %[[ARG3]], %[[MLIR_4]] : i32
// CHECK:           %[[SUB_0:.*]] = llvm.sub %[[MLIR_1]], %[[ARG3]] : i32
// CHECK:           %[[SELECT_0:.*]] = llvm.select %[[ICMP_0]], %[[SUB_0]], %[[ARG3]] : i1, i32
// CHECK:           %[[SDIV_0:.*]] = llvm.sdiv %[[SELECT_0]], %[[MLIR_2]] : i32
// CHECK:           %[[SUB_1:.*]] = llvm.sub %[[MLIR_1]], %[[SDIV_0]] : i32
// CHECK:           %[[SELECT_1:.*]] = llvm.select %[[ICMP_0]], %[[SUB_1]], %[[SDIV_0]] : i1, i32
// CHECK:           %[[MUL_0:.*]] = llvm.mul %[[SELECT_1]], %[[MLIR_2]] overflow<nsw> : i32
// CHECK:           llvm.br ^bb1(%[[MLIR_4]], %[[VAL_0]] : i32, vector<16xi32>)
// CHECK:         ^bb1(%[[VAL_1:.*]]: i32, %[[VAL_2:.*]]: vector<16xi32>):
// CHECK:           %[[ICMP_1:.*]] = llvm.icmp "slt" %[[VAL_1]], %[[MUL_0]] : i32
// CHECK:           llvm.cond_br %[[ICMP_1]], ^bb2, ^bb3
// CHECK:         ^bb2:
// CHECK:           %[[GETELEMENTPTR_0:.*]] = llvm.getelementptr %[[INTTOPTR_0]]{{\[}}%[[VAL_1]]] : (!llvm.ptr<4>, i32) -> !llvm.ptr<4>, i32
// CHECK:           %[[GETELEMENTPTR_1:.*]] = llvm.getelementptr %[[INTTOPTR_1]]{{\[}}%[[VAL_1]]] : (!llvm.ptr<4>, i32) -> !llvm.ptr<4>, i32
// CHECK:           %[[VAL_3:.*]] = "ppu.vec_load"(%[[GETELEMENTPTR_0]]) : (!llvm.ptr<4>) -> vector<16xi32>
// CHECK:           %[[VAL_4:.*]] = "ppu.vec_load"(%[[GETELEMENTPTR_1]]) : (!llvm.ptr<4>) -> vector<16xi32>
// CHECK:           %[[VAL_5:.*]] = "ppu.vec_mac_low"(%[[VAL_2]], %[[VAL_3]], %[[VAL_4]]) : (vector<16xi32>, vector<16xi32>, vector<16xi32>) -> vector<16xi32>
// CHECK:           %[[ADD_0:.*]] = llvm.add %[[VAL_1]], %[[MLIR_2]] : i32
// CHECK:           llvm.br ^bb1(%[[ADD_0]], %[[VAL_5]] : i32, vector<16xi32>)
// CHECK:         ^bb3:
// CHECK:           %[[VAL_6:.*]] = "ppu.vec_reduce_add"(%[[VAL_2]]) : (vector<16xi32>) -> i32
// CHECK:           llvm.br ^bb4(%[[MUL_0]], %[[VAL_6]] : i32, i32)
// CHECK:         ^bb4(%[[VAL_7:.*]]: i32, %[[VAL_8:.*]]: i32):
// CHECK:           %[[ICMP_2:.*]] = llvm.icmp "slt" %[[VAL_7]], %[[ARG3]] : i32
// CHECK:           llvm.cond_br %[[ICMP_2]], ^bb5, ^bb6
// CHECK:         ^bb5:
// CHECK:           %[[GETELEMENTPTR_2:.*]] = llvm.getelementptr %[[ARG1]]{{\[}}%[[VAL_7]]] : (!llvm.ptr, i32) -> !llvm.ptr, i32
// CHECK:           %[[LOAD_0:.*]] = llvm.load %[[GETELEMENTPTR_2]] : !llvm.ptr -> i32
// CHECK:           %[[GETELEMENTPTR_3:.*]] = llvm.getelementptr %[[ARG6]]{{\[}}%[[VAL_7]]] : (!llvm.ptr, i32) -> !llvm.ptr, i32
// CHECK:           %[[LOAD_1:.*]] = llvm.load %[[GETELEMENTPTR_3]] : !llvm.ptr -> i32
// CHECK:           %[[MUL_1:.*]] = llvm.mul %[[LOAD_0]], %[[LOAD_1]] : i32
// CHECK:           %[[ADD_1:.*]] = llvm.add %[[VAL_8]], %[[MUL_1]] : i32
// CHECK:           %[[ADD_2:.*]] = llvm.add %[[VAL_7]], %[[MLIR_3]] : i32
// CHECK:           llvm.br ^bb4(%[[ADD_2]], %[[ADD_1]] : i32, i32)
// CHECK:         ^bb6:
// CHECK:           llvm.return %[[VAL_8]] : i32
// CHECK:         }
