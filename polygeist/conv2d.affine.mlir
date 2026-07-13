module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>, #dlti.dl_entry<"dlti.endianness", "little">>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @conv2d(%arg0: memref<?xi32>, %arg1: memref<?xi32>, %arg2: i32, %arg3: i32, %arg4: memref<?xi32>, %arg5: i32) attributes {llvm.linkage = #llvm.linkage<external>} {
    %c2_i32 = arith.constant 2 : i32
    %c-1_i32 = arith.constant -1 : i32
    %0 = arith.index_cast %arg3 : i32 to index
    %1 = arith.index_cast %arg5 : i32 to index
    %2 = arith.addi %arg5, %c-1_i32 : i32
    %3 = arith.divsi %2, %c2_i32 : i32
    %4 = arith.muli %3, %c2_i32 : i32
    %5 = arith.subi %arg2, %4 : i32
    %6 = arith.subi %arg3, %4 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = arith.index_cast %5 : i32 to index
    affine.for %arg6 = 0 to %8 {
      affine.for %arg7 = 0 to %7 {
        affine.for %arg8 = 0 to %1 {
          affine.for %arg9 = 0 to %1 {
            %9 = affine.load %arg1[%arg7 + %arg9 + (%arg6 + %arg8) * symbol(%0)] : memref<?xi32>
            %10 = affine.load %arg4[%arg9 + %arg8 * symbol(%1)] : memref<?xi32>
            %11 = arith.muli %9, %10 : i32
            %12 = affine.load %arg0[%arg7 + %arg6 * symbol(%7)] : memref<?xi32>
            %13 = arith.addi %12, %11 : i32
            affine.store %13, %arg0[%arg7 + %arg6 * symbol(%7)] : memref<?xi32>
          }
        }
      }
    }
    return
  }
}
