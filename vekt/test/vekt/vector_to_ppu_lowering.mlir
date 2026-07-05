// RUN: vekt-opt -vekt16 %s | FileCheck %s

module {
  func.func @vec_sum(%arg0: memref<?xi32>, %arg1: memref<?xi32>, %arg2: memref<?xi32>, %arg3: i32) {
    %0 = arith.index_cast %arg3 : i32 to index
    affine.for %arg4 = 0 to %0 step 16 {
        %1 = ub.poison : i32
        %2 = vector.transfer_read %arg0[%arg4], %1 : memref<?xi32>, vector<16xi32>
        %3 = ub.poison : i32
        %4 = vector.transfer_read %arg1[%arg4], %3 : memref<?xi32>, vector<16xi32>
        %5 = arith.addi %2, %4 : vector<16xi32>
        vector.transfer_write %5, %arg2[%arg4] : vector<16xi32>, memref<?xi32>
    }

    return
  }
}

// CHECK-LABEL: llvm.func @vec_sum(
// CHECK-SAME: %{{.*}}: !llvm.ptr, %[[ARG1:.*]]: !llvm.ptr, {{.*}} %[[ARG6:.*]]: !llvm.ptr, {{.*}} %[[ARG11:.*]]: !llvm.ptr, {{.*}} %[[ARG15:.*]]: i32) {
// CHECK:           %[[MLIR_0:.*]] = llvm.mlir.constant(16 : index) : i64
// CHECK:           %[[MLIR_1:.*]] = llvm.mlir.constant(0 : index) : i64
// CHECK:           %[[SEXT_0:.*]] = llvm.sext %[[ARG15]] : i32 to i64
// CHECK:           llvm.br ^bb1(%[[MLIR_1]] : i64)
// CHECK:         ^bb1(%[[VAL_0:.*]]: i64):
// CHECK:           %[[ICMP_0:.*]] = llvm.icmp "slt" %[[VAL_0]], %[[SEXT_0]] : i64
// CHECK:           llvm.cond_br %[[ICMP_0]], ^bb2, ^bb3
// CHECK:         ^bb2:
// CHECK:           %[[PTRTOINT_0:.*]] = llvm.ptrtoint %[[ARG1]] : !llvm.ptr to i64
// CHECK:           %[[INTTOPTR_0:.*]] = llvm.inttoptr %[[PTRTOINT_0]] : i64 to !llvm.ptr<4>
// CHECK:           %[[GETELEMENTPTR_0:.*]] = llvm.getelementptr %[[INTTOPTR_0]]{{\[}}%[[VAL_0]]] : (!llvm.ptr<4>, i64) -> !llvm.ptr<4>, i32
// CHECK:           %[[VAL_1:.*]] = "ppu.vec_load"(%[[GETELEMENTPTR_0]]) : (!llvm.ptr<4>) -> vector<16xi32>
// CHECK:           %[[PTRTOINT_1:.*]] = llvm.ptrtoint %[[ARG6]] : !llvm.ptr to i64
// CHECK:           %[[INTTOPTR_1:.*]] = llvm.inttoptr %[[PTRTOINT_1]] : i64 to !llvm.ptr<4>
// CHECK:           %[[GETELEMENTPTR_1:.*]] = llvm.getelementptr %[[INTTOPTR_1]]{{\[}}%[[VAL_0]]] : (!llvm.ptr<4>, i64) -> !llvm.ptr<4>, i32
// CHECK:           %[[VAL_2:.*]] = "ppu.vec_load"(%[[GETELEMENTPTR_1]]) : (!llvm.ptr<4>) -> vector<16xi32>
// CHECK:           %[[ADD_0:.*]] = llvm.add %[[VAL_1]], %[[VAL_2]] : vector<16xi32>
// CHECK:           %[[PTRTOINT_2:.*]] = llvm.ptrtoint %[[ARG11]] : !llvm.ptr to i64
// CHECK:           %[[INTTOPTR_2:.*]] = llvm.inttoptr %[[PTRTOINT_2]] : i64 to !llvm.ptr<4>
// CHECK:           %[[GETELEMENTPTR_2:.*]] = llvm.getelementptr %[[INTTOPTR_2]]{{\[}}%[[VAL_0]]] : (!llvm.ptr<4>, i64) -> !llvm.ptr<4>, i32
// CHECK:           "ppu.vec_store"(%[[ADD_0]], %[[GETELEMENTPTR_2]]) : (vector<16xi32>, !llvm.ptr<4>) -> ()
// CHECK:           %[[ADD_1:.*]] = llvm.add %[[VAL_0]], %[[MLIR_0]] : i64
// CHECK:           llvm.br ^bb1(%[[ADD_1]] : i64)
// CHECK:         ^bb3:
// CHECK:           llvm.return
// CHECK:         }
