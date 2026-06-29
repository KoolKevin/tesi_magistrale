module {
  func.func @test_ppu_vec_load(%ptr: !llvm.ptr) -> vector<16xi32> {
    %0 = "ppu.vec_load"(%ptr) : (!llvm.ptr) -> vector<16xi32>
    return %0 : vector<16xi32>
  }
}
