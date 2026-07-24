// RUN: vekt-opt -vekt16 %s | FileCheck %s

func.func @test_index_lowering(%arg0: index, %arg1: index) -> index {
    %res = index.add %arg0, %arg1
    return %res : index
}

// CHECK-LABEL:   llvm.func @test_index_lowering(
// CHECK-SAME:      %[[ARG0:.*]]: i32,
// CHECK-SAME:      %[[ARG1:.*]]: i32) -> i32 {
// CHECK:           %[[ADD_0:.*]] = llvm.add %[[ARG0]], %[[ARG1]] : i32
// CHECK:           llvm.return %[[ADD_0]] : i32
// CHECK:         }
