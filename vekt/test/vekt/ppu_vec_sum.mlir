module {
  func.func @test_ppu_vec_ops(%alloc: !llvm.ptr<4>) -> vector<16xi32> {
    %0 = "ppu.vec_load"(%alloc) : (!llvm.ptr<4>) -> vector<16xi32>
    %1 = "ppu.vec_add"(%0, %0) : (vector<16xi32>, vector<16xi32>) -> vector<16xi32>
    "ppu.vec_store"(%1, %alloc) : (vector<16xi32>, !llvm.ptr<4>) -> ()

    return %1 : vector<16xi32>
  }
}
