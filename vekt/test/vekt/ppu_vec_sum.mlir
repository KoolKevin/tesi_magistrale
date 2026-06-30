// RUN: vekt-opt -vekt16 %s | vekt-translate -vekt-to-llvmir
module {
  func.func @test_ppu_vec_ops(%alloc: !llvm.ptr) -> vector<16xi32> {
    %0 = "ppu.vec_load"(%alloc) : (!llvm.ptr) -> vector<16xi32>
    %1 = "ppu.vec_add"(%0, %0) : (vector<16xi32>, vector<16xi32>) -> vector<16xi32>
    "ppu.vec_store"(%1, %alloc) : (vector<16xi32>, !llvm.ptr) -> ()

    return %1 : vector<16xi32>
  }
}

// CHECK-LABEL:
// CHECK-SAME:    %[[VAL_0:.*]] = call <16 x i32> @llvm.arc.vvld.w.v512(ptr
// CHECK-SAME:    %[[VAL_1:.*]])
// CHECK:         %[[VAL_2:.*]] = call <16 x i32> @llvm.arc.vvadd.w.v512(<16 x i32> %[[VAL_0]], <16 x i32> %[[VAL_0]])
// CHECK:         call void @llvm.arc.vvst.w.v512(<16 x i32> %[[VAL_2]], ptr %[[VAL_1]])
// CHECK:         ret <16 x i32> %[[VAL_2]]
