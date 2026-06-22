// -----// IR Dump After Canonicalizer (canonicalize) //----- //
module {
  func.func @vec_sum(%arg0: memref<?xi32>, %arg1: memref<?xi32>, %arg2: memref<?xi32>, %arg3: i32) attributes {llvm.linkage = #llvm.linkage<external>} {
    %0 = arith.index_cast %arg3 : i32 to index
    affine.for %arg4 = 0 to %0 {
      %1 = affine.load %arg0[%arg4] : memref<?xi32>
      %2 = affine.load %arg1[%arg4] : memref<?xi32>
      %3 = arith.addi %1, %2 : i32
      affine.store %3, %arg2[%arg4] : memref<?xi32>
    }
    return
  }
}


// -----// IR Dump After AffineVectorize (affine-super-vectorize) //----- //
func.func @vec_sum(%arg0: memref<?xi32>, %arg1: memref<?xi32>, %arg2: memref<?xi32>, %arg3: i32) attributes {llvm.linkage = #llvm.linkage<external>} {
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

// -----// IR Dump After LowerAffinePass (lower-affine) //----- //
module {
  func.func @vec_sum(%arg0: memref<?xi32>, %arg1: memref<?xi32>, %arg2: memref<?xi32>, %arg3: i32) attributes {llvm.linkage = #llvm.linkage<external>} {
    %0 = arith.index_cast %arg3 : i32 to index
    %c0 = arith.constant 0 : index
    %c16 = arith.constant 16 : index
    scf.for %arg4 = %c0 to %0 step %c16 {
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


// -----// IR Dump After SCFToControlFlowPass (convert-scf-to-cf) //----- //
module {
  func.func @vec_sum(%arg0: memref<?xi32>, %arg1: memref<?xi32>, %arg2: memref<?xi32>, %arg3: i32) attributes {llvm.linkage = #llvm.linkage<external>} {
    %0 = arith.index_cast %arg3 : i32 to index
    %c0 = arith.constant 0 : index
    %c16 = arith.constant 16 : index
    cf.br ^bb1(%c0 : index)
  ^bb1(%1: index):  // 2 preds: ^bb0, ^bb2
    %2 = arith.cmpi slt, %1, %0 : index
    cf.cond_br %2, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %3 = ub.poison : i32
    %4 = vector.transfer_read %arg0[%1], %3 : memref<?xi32>, vector<16xi32>
    %5 = ub.poison : i32
    %6 = vector.transfer_read %arg1[%1], %5 : memref<?xi32>, vector<16xi32>
    %7 = arith.addi %4, %6 : vector<16xi32>
    vector.transfer_write %7, %arg2[%1] : vector<16xi32>, memref<?xi32>
    %8 = arith.addi %1, %c16 : index
    cf.br ^bb1(%8 : index)
  ^bb3:  // pred: ^bb1
    return
  }
}


// -----// IR Dump After ConvertFuncToLLVMPass (convert-func-to-llvm) //----- //
module {
  llvm.func @vec_sum(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: !llvm.ptr, %arg6: !llvm.ptr, %arg7: i64, %arg8: i64, %arg9: i64, %arg10: !llvm.ptr, %arg11: !llvm.ptr, %arg12: i64, %arg13: i64, %arg14: i64, %arg15: i32) {
    %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.insertvalue %arg10, %0[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %2 = llvm.insertvalue %arg11, %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.insertvalue %arg12, %2[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %4 = llvm.insertvalue %arg13, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %5 = llvm.insertvalue %arg14, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %6 = builtin.unrealized_conversion_cast %5 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> to memref<?xi32>
    %7 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %8 = llvm.insertvalue %arg5, %7[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %9 = llvm.insertvalue %arg6, %8[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %10 = llvm.insertvalue %arg7, %9[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.insertvalue %arg8, %10[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.insertvalue %arg9, %11[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = builtin.unrealized_conversion_cast %12 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> to memref<?xi32>
    %14 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %15 = llvm.insertvalue %arg0, %14[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %16 = llvm.insertvalue %arg1, %15[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %17 = llvm.insertvalue %arg2, %16[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %18 = llvm.insertvalue %arg3, %17[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %19 = llvm.insertvalue %arg4, %18[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %20 = builtin.unrealized_conversion_cast %19 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> to memref<?xi32>
    %21 = arith.index_cast %arg15 : i32 to index
    %c0 = arith.constant 0 : index
    %c16 = arith.constant 16 : index
    cf.br ^bb1(%c0 : index)
  ^bb1(%22: index):  // 2 preds: ^bb0, ^bb2
    %23 = arith.cmpi slt, %22, %21 : index
    cf.cond_br %23, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %24 = ub.poison : i32
    %25 = vector.transfer_read %20[%22], %24 : memref<?xi32>, vector<16xi32>
    %26 = ub.poison : i32
    %27 = vector.transfer_read %13[%22], %26 : memref<?xi32>, vector<16xi32>
    %28 = arith.addi %25, %27 : vector<16xi32>
    vector.transfer_write %28, %6[%22] : vector<16xi32>, memref<?xi32>
    %29 = arith.addi %22, %c16 : index
    cf.br ^bb1(%29 : index)
  ^bb3:  // pred: ^bb1
    llvm.return
  }
}


// -----// IR Dump After ConvertControlFlowToLLVMPass (convert-cf-to-llvm) //----- //
module {
  llvm.func @vec_sum(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: !llvm.ptr, %arg6: !llvm.ptr, %arg7: i64, %arg8: i64, %arg9: i64, %arg10: !llvm.ptr, %arg11: !llvm.ptr, %arg12: i64, %arg13: i64, %arg14: i64, %arg15: i32) {
    %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.insertvalue %arg10, %0[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %2 = llvm.insertvalue %arg11, %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.insertvalue %arg12, %2[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %4 = llvm.insertvalue %arg13, %3[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %5 = llvm.insertvalue %arg14, %4[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %6 = builtin.unrealized_conversion_cast %5 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> to memref<?xi32>
    %7 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %8 = llvm.insertvalue %arg5, %7[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %9 = llvm.insertvalue %arg6, %8[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %10 = llvm.insertvalue %arg7, %9[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.insertvalue %arg8, %10[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.insertvalue %arg9, %11[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = builtin.unrealized_conversion_cast %12 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> to memref<?xi32>
    %14 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %15 = llvm.insertvalue %arg0, %14[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %16 = llvm.insertvalue %arg1, %15[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %17 = llvm.insertvalue %arg2, %16[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %18 = llvm.insertvalue %arg3, %17[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %19 = llvm.insertvalue %arg4, %18[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %20 = builtin.unrealized_conversion_cast %19 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> to memref<?xi32>
    %21 = arith.index_cast %arg15 : i32 to index
    %c0 = arith.constant 0 : index
    %22 = builtin.unrealized_conversion_cast %c0 : index to i64
    %c16 = arith.constant 16 : index
    llvm.br ^bb1(%22 : i64)
  ^bb1(%23: i64):  // 2 preds: ^bb0, ^bb2
    %24 = builtin.unrealized_conversion_cast %23 : i64 to index
    %25 = arith.cmpi slt, %24, %21 : index
    llvm.cond_br %25, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %26 = ub.poison : i32
    %27 = vector.transfer_read %20[%24], %26 : memref<?xi32>, vector<16xi32>
    %28 = ub.poison : i32
    %29 = vector.transfer_read %13[%24], %28 : memref<?xi32>, vector<16xi32>
    %30 = arith.addi %27, %29 : vector<16xi32>
    vector.transfer_write %30, %6[%24] : vector<16xi32>, memref<?xi32>
    %31 = arith.addi %24, %c16 : index
    %32 = builtin.unrealized_conversion_cast %31 : index to i64
    llvm.br ^bb1(%32 : i64)
  ^bb3:  // pred: ^bb1
    llvm.return
  }
}


// -----// IR Dump After ConvertVectorToLLVMPass (convert-vector-to-llvm) //----- //
module {
  llvm.func @vec_sum(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: !llvm.ptr, %arg6: !llvm.ptr, %arg7: i64, %arg8: i64, %arg9: i64, %arg10: !llvm.ptr, %arg11: !llvm.ptr, %arg12: i64, %arg13: i64, %arg14: i64, %arg15: i32) {
    %0 = ub.poison : vector<16xi32>
    %cst = arith.constant dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]> : vector<16xi32>
    %c16 = arith.constant 16 : index
    %c0 = arith.constant 0 : index
    %1 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = llvm.insertvalue %arg10, %1[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.insertvalue %arg11, %2[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %4 = llvm.insertvalue %arg12, %3[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %5 = llvm.insertvalue %arg13, %4[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %6 = llvm.insertvalue %arg14, %5[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %7 = builtin.unrealized_conversion_cast %6 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> to memref<?xi32>
    %8 = llvm.insertvalue %arg5, %1[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %9 = llvm.insertvalue %arg6, %8[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %10 = llvm.insertvalue %arg7, %9[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.insertvalue %arg8, %10[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.insertvalue %arg9, %11[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = builtin.unrealized_conversion_cast %12 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> to memref<?xi32>
    %14 = llvm.insertvalue %arg0, %1[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %15 = llvm.insertvalue %arg1, %14[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %16 = llvm.insertvalue %arg2, %15[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %17 = llvm.insertvalue %arg3, %16[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %18 = llvm.insertvalue %arg4, %17[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %19 = builtin.unrealized_conversion_cast %18 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> to memref<?xi32>
    %20 = arith.index_cast %arg15 : i32 to index
    %21 = builtin.unrealized_conversion_cast %c0 : index to i64
    llvm.br ^bb1(%21 : i64)
  ^bb1(%22: i64):  // 2 preds: ^bb0, ^bb2
    %23 = builtin.unrealized_conversion_cast %22 : i64 to index
    %24 = arith.cmpi slt, %23, %20 : index
    llvm.cond_br %24, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %dim = memref.dim %19, %c0 : memref<?xi32>
    %25 = arith.subi %dim, %23 : index
    %26 = arith.index_cast %25 : index to i32
    %27 = llvm.mlir.poison : vector<16xi32>
    %28 = llvm.mlir.constant(0 : i32) : i32
    %29 = llvm.insertelement %26, %27[%28 : i32] : vector<16xi32>
    %30 = llvm.shufflevector %29, %27 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<16xi32> 
    %31 = arith.cmpi sgt, %30, %cst : vector<16xi32>
    %32 = llvm.extractvalue %18[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %33 = llvm.getelementptr %32[%22] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %34 = llvm.intr.masked.load %33, %31, %0 {alignment = 4 : i32} : (!llvm.ptr, vector<16xi1>, vector<16xi32>) -> vector<16xi32>
    %dim_0 = memref.dim %13, %c0 : memref<?xi32>
    %35 = arith.subi %dim_0, %23 : index
    %36 = arith.index_cast %35 : index to i32
    %37 = llvm.mlir.poison : vector<16xi32>
    %38 = llvm.mlir.constant(0 : i32) : i32
    %39 = llvm.insertelement %36, %37[%38 : i32] : vector<16xi32>
    %40 = llvm.shufflevector %39, %37 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<16xi32> 
    %41 = arith.cmpi sgt, %40, %cst : vector<16xi32>
    %42 = llvm.extractvalue %12[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %43 = llvm.getelementptr %42[%22] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %44 = llvm.intr.masked.load %43, %41, %0 {alignment = 4 : i32} : (!llvm.ptr, vector<16xi1>, vector<16xi32>) -> vector<16xi32>
    %45 = arith.addi %34, %44 : vector<16xi32>
    %dim_1 = memref.dim %7, %c0 : memref<?xi32>
    %46 = arith.subi %dim_1, %23 : index
    %47 = arith.index_cast %46 : index to i32
    %48 = llvm.mlir.poison : vector<16xi32>
    %49 = llvm.mlir.constant(0 : i32) : i32
    %50 = llvm.insertelement %47, %48[%49 : i32] : vector<16xi32>
    %51 = llvm.shufflevector %50, %48 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<16xi32> 
    %52 = arith.cmpi sgt, %51, %cst : vector<16xi32>
    %53 = llvm.extractvalue %6[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %54 = llvm.getelementptr %53[%22] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.intr.masked.store %45, %54, %52 {alignment = 4 : i32} : vector<16xi32>, vector<16xi1> into !llvm.ptr
    %55 = arith.addi %23, %c16 : index
    %56 = builtin.unrealized_conversion_cast %55 : index to i64
    llvm.br ^bb1(%56 : i64)
  ^bb3:  // pred: ^bb1
    llvm.return
  }
}


// -----// IR Dump After ArithToLLVMConversionPass (convert-arith-to-llvm) //----- //
module {
  llvm.func @vec_sum(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: !llvm.ptr, %arg6: !llvm.ptr, %arg7: i64, %arg8: i64, %arg9: i64, %arg10: !llvm.ptr, %arg11: !llvm.ptr, %arg12: i64, %arg13: i64, %arg14: i64, %arg15: i32) {
    %0 = ub.poison : vector<16xi32>
    %1 = llvm.mlir.constant(dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]> : vector<16xi32>) : vector<16xi32>
    %2 = llvm.mlir.constant(16 : index) : i64
    %3 = llvm.mlir.constant(0 : index) : i64
    %4 = builtin.unrealized_conversion_cast %3 : i64 to index
    %5 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %6 = llvm.insertvalue %arg10, %5[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %7 = llvm.insertvalue %arg11, %6[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %8 = llvm.insertvalue %arg12, %7[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %9 = llvm.insertvalue %arg13, %8[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %10 = llvm.insertvalue %arg14, %9[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = builtin.unrealized_conversion_cast %10 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> to memref<?xi32>
    %12 = llvm.insertvalue %arg5, %5[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = llvm.insertvalue %arg6, %12[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %14 = llvm.insertvalue %arg7, %13[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %15 = llvm.insertvalue %arg8, %14[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %16 = llvm.insertvalue %arg9, %15[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %17 = builtin.unrealized_conversion_cast %16 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> to memref<?xi32>
    %18 = llvm.insertvalue %arg0, %5[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %19 = llvm.insertvalue %arg1, %18[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %20 = llvm.insertvalue %arg2, %19[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %21 = llvm.insertvalue %arg3, %20[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %22 = llvm.insertvalue %arg4, %21[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %23 = builtin.unrealized_conversion_cast %22 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> to memref<?xi32>
    %24 = llvm.sext %arg15 : i32 to i64
    %25 = builtin.unrealized_conversion_cast %4 : index to i64
    llvm.br ^bb1(%25 : i64)
  ^bb1(%26: i64):  // 2 preds: ^bb0, ^bb2
    %27 = builtin.unrealized_conversion_cast %26 : i64 to index
    %28 = llvm.icmp "slt" %26, %24 : i64
    llvm.cond_br %28, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %dim = memref.dim %23, %4 : memref<?xi32>
    %29 = builtin.unrealized_conversion_cast %dim : index to i64
    %30 = llvm.sub %29, %26 : i64
    %31 = llvm.trunc %30 : i64 to i32
    %32 = llvm.mlir.poison : vector<16xi32>
    %33 = llvm.mlir.constant(0 : i32) : i32
    %34 = llvm.insertelement %31, %32[%33 : i32] : vector<16xi32>
    %35 = llvm.shufflevector %34, %32 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<16xi32> 
    %36 = llvm.icmp "sgt" %35, %1 : vector<16xi32>
    %37 = llvm.extractvalue %22[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %38 = llvm.getelementptr %37[%26] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %39 = llvm.intr.masked.load %38, %36, %0 {alignment = 4 : i32} : (!llvm.ptr, vector<16xi1>, vector<16xi32>) -> vector<16xi32>
    %dim_0 = memref.dim %17, %4 : memref<?xi32>
    %40 = builtin.unrealized_conversion_cast %dim_0 : index to i64
    %41 = llvm.sub %40, %26 : i64
    %42 = llvm.trunc %41 : i64 to i32
    %43 = llvm.mlir.poison : vector<16xi32>
    %44 = llvm.mlir.constant(0 : i32) : i32
    %45 = llvm.insertelement %42, %43[%44 : i32] : vector<16xi32>
    %46 = llvm.shufflevector %45, %43 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<16xi32> 
    %47 = llvm.icmp "sgt" %46, %1 : vector<16xi32>
    %48 = llvm.extractvalue %16[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %49 = llvm.getelementptr %48[%26] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %50 = llvm.intr.masked.load %49, %47, %0 {alignment = 4 : i32} : (!llvm.ptr, vector<16xi1>, vector<16xi32>) -> vector<16xi32>
    %51 = llvm.add %39, %50 : vector<16xi32>
    %dim_1 = memref.dim %11, %4 : memref<?xi32>
    %52 = builtin.unrealized_conversion_cast %dim_1 : index to i64
    %53 = llvm.sub %52, %26 : i64
    %54 = llvm.trunc %53 : i64 to i32
    %55 = llvm.mlir.poison : vector<16xi32>
    %56 = llvm.mlir.constant(0 : i32) : i32
    %57 = llvm.insertelement %54, %55[%56 : i32] : vector<16xi32>
    %58 = llvm.shufflevector %57, %55 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<16xi32> 
    %59 = llvm.icmp "sgt" %58, %1 : vector<16xi32>
    %60 = llvm.extractvalue %10[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %61 = llvm.getelementptr %60[%26] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.intr.masked.store %51, %61, %59 {alignment = 4 : i32} : vector<16xi32>, vector<16xi1> into !llvm.ptr
    %62 = llvm.add %26, %2 : i64
    %63 = builtin.unrealized_conversion_cast %62 : i64 to index
    %64 = builtin.unrealized_conversion_cast %63 : index to i64
    llvm.br ^bb1(%64 : i64)
  ^bb3:  // pred: ^bb1
    llvm.return
  }
}


// -----// IR Dump After UBToLLVMConversionPass (convert-ub-to-llvm) //----- //
module {
  llvm.func @vec_sum(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: !llvm.ptr, %arg6: !llvm.ptr, %arg7: i64, %arg8: i64, %arg9: i64, %arg10: !llvm.ptr, %arg11: !llvm.ptr, %arg12: i64, %arg13: i64, %arg14: i64, %arg15: i32) {
    %0 = llvm.mlir.poison : vector<16xi32>
    %1 = llvm.mlir.constant(dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]> : vector<16xi32>) : vector<16xi32>
    %2 = llvm.mlir.constant(16 : index) : i64
    %3 = llvm.mlir.constant(0 : index) : i64
    %4 = builtin.unrealized_conversion_cast %3 : i64 to index
    %5 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %6 = llvm.insertvalue %arg10, %5[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %7 = llvm.insertvalue %arg11, %6[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %8 = llvm.insertvalue %arg12, %7[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %9 = llvm.insertvalue %arg13, %8[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %10 = llvm.insertvalue %arg14, %9[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = builtin.unrealized_conversion_cast %10 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> to memref<?xi32>
    %12 = llvm.insertvalue %arg5, %5[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = llvm.insertvalue %arg6, %12[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %14 = llvm.insertvalue %arg7, %13[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %15 = llvm.insertvalue %arg8, %14[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %16 = llvm.insertvalue %arg9, %15[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %17 = builtin.unrealized_conversion_cast %16 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> to memref<?xi32>
    %18 = llvm.insertvalue %arg0, %5[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %19 = llvm.insertvalue %arg1, %18[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %20 = llvm.insertvalue %arg2, %19[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %21 = llvm.insertvalue %arg3, %20[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %22 = llvm.insertvalue %arg4, %21[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %23 = builtin.unrealized_conversion_cast %22 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> to memref<?xi32>
    %24 = llvm.sext %arg15 : i32 to i64
    %25 = builtin.unrealized_conversion_cast %4 : index to i64
    llvm.br ^bb1(%25 : i64)
  ^bb1(%26: i64):  // 2 preds: ^bb0, ^bb2
    %27 = builtin.unrealized_conversion_cast %26 : i64 to index
    %28 = llvm.icmp "slt" %26, %24 : i64
    llvm.cond_br %28, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %dim = memref.dim %23, %4 : memref<?xi32>
    %29 = builtin.unrealized_conversion_cast %dim : index to i64
    %30 = llvm.sub %29, %26 : i64
    %31 = llvm.trunc %30 : i64 to i32
    %32 = llvm.mlir.poison : vector<16xi32>
    %33 = llvm.mlir.constant(0 : i32) : i32
    %34 = llvm.insertelement %31, %32[%33 : i32] : vector<16xi32>
    %35 = llvm.shufflevector %34, %32 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<16xi32> 
    %36 = llvm.icmp "sgt" %35, %1 : vector<16xi32>
    %37 = llvm.extractvalue %22[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %38 = llvm.getelementptr %37[%26] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %39 = llvm.intr.masked.load %38, %36, %0 {alignment = 4 : i32} : (!llvm.ptr, vector<16xi1>, vector<16xi32>) -> vector<16xi32>
    %dim_0 = memref.dim %17, %4 : memref<?xi32>
    %40 = builtin.unrealized_conversion_cast %dim_0 : index to i64
    %41 = llvm.sub %40, %26 : i64
    %42 = llvm.trunc %41 : i64 to i32
    %43 = llvm.mlir.poison : vector<16xi32>
    %44 = llvm.mlir.constant(0 : i32) : i32
    %45 = llvm.insertelement %42, %43[%44 : i32] : vector<16xi32>
    %46 = llvm.shufflevector %45, %43 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<16xi32> 
    %47 = llvm.icmp "sgt" %46, %1 : vector<16xi32>
    %48 = llvm.extractvalue %16[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %49 = llvm.getelementptr %48[%26] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %50 = llvm.intr.masked.load %49, %47, %0 {alignment = 4 : i32} : (!llvm.ptr, vector<16xi1>, vector<16xi32>) -> vector<16xi32>
    %51 = llvm.add %39, %50 : vector<16xi32>
    %dim_1 = memref.dim %11, %4 : memref<?xi32>
    %52 = builtin.unrealized_conversion_cast %dim_1 : index to i64
    %53 = llvm.sub %52, %26 : i64
    %54 = llvm.trunc %53 : i64 to i32
    %55 = llvm.mlir.poison : vector<16xi32>
    %56 = llvm.mlir.constant(0 : i32) : i32
    %57 = llvm.insertelement %54, %55[%56 : i32] : vector<16xi32>
    %58 = llvm.shufflevector %57, %55 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<16xi32> 
    %59 = llvm.icmp "sgt" %58, %1 : vector<16xi32>
    %60 = llvm.extractvalue %10[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %61 = llvm.getelementptr %60[%26] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.intr.masked.store %51, %61, %59 {alignment = 4 : i32} : vector<16xi32>, vector<16xi1> into !llvm.ptr
    %62 = llvm.add %26, %2 : i64
    %63 = builtin.unrealized_conversion_cast %62 : i64 to index
    %64 = builtin.unrealized_conversion_cast %63 : index to i64
    llvm.br ^bb1(%64 : i64)
  ^bb3:  // pred: ^bb1
    llvm.return
  }
}


// -----// IR Dump After FinalizeMemRefToLLVMConversionPass (finalize-memref-to-llvm) //----- //
module {
  llvm.func @vec_sum(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: !llvm.ptr, %arg6: !llvm.ptr, %arg7: i64, %arg8: i64, %arg9: i64, %arg10: !llvm.ptr, %arg11: !llvm.ptr, %arg12: i64, %arg13: i64, %arg14: i64, %arg15: i32) {
    %0 = llvm.mlir.poison : vector<16xi32>
    %1 = llvm.mlir.constant(dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]> : vector<16xi32>) : vector<16xi32>
    %2 = llvm.mlir.constant(16 : index) : i64
    %3 = llvm.mlir.constant(0 : index) : i64
    %4 = builtin.unrealized_conversion_cast %3 : i64 to index
    %5 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %6 = llvm.insertvalue %arg10, %5[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %7 = llvm.insertvalue %arg11, %6[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %8 = llvm.insertvalue %arg12, %7[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %9 = llvm.insertvalue %arg13, %8[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %10 = llvm.insertvalue %arg14, %9[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = builtin.unrealized_conversion_cast %10 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> to memref<?xi32>
    %12 = llvm.insertvalue %arg5, %5[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = llvm.insertvalue %arg6, %12[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %14 = llvm.insertvalue %arg7, %13[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %15 = llvm.insertvalue %arg8, %14[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %16 = llvm.insertvalue %arg9, %15[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %17 = builtin.unrealized_conversion_cast %16 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> to memref<?xi32>
    %18 = llvm.insertvalue %arg0, %5[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %19 = llvm.insertvalue %arg1, %18[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %20 = llvm.insertvalue %arg2, %19[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %21 = llvm.insertvalue %arg3, %20[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %22 = llvm.insertvalue %arg4, %21[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %23 = builtin.unrealized_conversion_cast %22 : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> to memref<?xi32>
    %24 = llvm.sext %arg15 : i32 to i64
    %25 = builtin.unrealized_conversion_cast %4 : index to i64
    llvm.br ^bb1(%25 : i64)
  ^bb1(%26: i64):  // 2 preds: ^bb0, ^bb2
    %27 = builtin.unrealized_conversion_cast %26 : i64 to index
    %28 = llvm.icmp "slt" %26, %24 : i64
    llvm.cond_br %28, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %29 = llvm.mlir.constant(1 : index) : i64
    %30 = llvm.extractvalue %22[3] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %31 = llvm.alloca %29 x !llvm.array<1 x i64> : (i64) -> !llvm.ptr
    llvm.store %30, %31 : !llvm.array<1 x i64>, !llvm.ptr
    %32 = llvm.getelementptr %31[0, %3] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.array<1 x i64>
    %33 = llvm.load %32 : !llvm.ptr -> i64
    %34 = builtin.unrealized_conversion_cast %33 : i64 to index
    %35 = builtin.unrealized_conversion_cast %34 : index to i64
    %36 = llvm.sub %35, %26 : i64
    %37 = llvm.trunc %36 : i64 to i32
    %38 = llvm.mlir.poison : vector<16xi32>
    %39 = llvm.mlir.constant(0 : i32) : i32
    %40 = llvm.insertelement %37, %38[%39 : i32] : vector<16xi32>
    %41 = llvm.shufflevector %40, %38 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<16xi32> 
    %42 = llvm.icmp "sgt" %41, %1 : vector<16xi32>
    %43 = llvm.extractvalue %22[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %44 = llvm.getelementptr %43[%26] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %45 = llvm.intr.masked.load %44, %42, %0 {alignment = 4 : i32} : (!llvm.ptr, vector<16xi1>, vector<16xi32>) -> vector<16xi32>
    %46 = llvm.mlir.constant(1 : index) : i64
    %47 = llvm.extractvalue %16[3] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %48 = llvm.alloca %46 x !llvm.array<1 x i64> : (i64) -> !llvm.ptr
    llvm.store %47, %48 : !llvm.array<1 x i64>, !llvm.ptr
    %49 = llvm.getelementptr %48[0, %3] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.array<1 x i64>
    %50 = llvm.load %49 : !llvm.ptr -> i64
    %51 = builtin.unrealized_conversion_cast %50 : i64 to index
    %52 = builtin.unrealized_conversion_cast %51 : index to i64
    %53 = llvm.sub %52, %26 : i64
    %54 = llvm.trunc %53 : i64 to i32
    %55 = llvm.mlir.poison : vector<16xi32>
    %56 = llvm.mlir.constant(0 : i32) : i32
    %57 = llvm.insertelement %54, %55[%56 : i32] : vector<16xi32>
    %58 = llvm.shufflevector %57, %55 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<16xi32> 
    %59 = llvm.icmp "sgt" %58, %1 : vector<16xi32>
    %60 = llvm.extractvalue %16[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %61 = llvm.getelementptr %60[%26] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %62 = llvm.intr.masked.load %61, %59, %0 {alignment = 4 : i32} : (!llvm.ptr, vector<16xi1>, vector<16xi32>) -> vector<16xi32>
    %63 = llvm.add %45, %62 : vector<16xi32>
    %64 = llvm.mlir.constant(1 : index) : i64
    %65 = llvm.extractvalue %10[3] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %66 = llvm.alloca %64 x !llvm.array<1 x i64> : (i64) -> !llvm.ptr
    llvm.store %65, %66 : !llvm.array<1 x i64>, !llvm.ptr
    %67 = llvm.getelementptr %66[0, %3] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.array<1 x i64>
    %68 = llvm.load %67 : !llvm.ptr -> i64
    %69 = builtin.unrealized_conversion_cast %68 : i64 to index
    %70 = builtin.unrealized_conversion_cast %69 : index to i64
    %71 = llvm.sub %70, %26 : i64
    %72 = llvm.trunc %71 : i64 to i32
    %73 = llvm.mlir.poison : vector<16xi32>
    %74 = llvm.mlir.constant(0 : i32) : i32
    %75 = llvm.insertelement %72, %73[%74 : i32] : vector<16xi32>
    %76 = llvm.shufflevector %75, %73 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<16xi32> 
    %77 = llvm.icmp "sgt" %76, %1 : vector<16xi32>
    %78 = llvm.extractvalue %10[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %79 = llvm.getelementptr %78[%26] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.intr.masked.store %63, %79, %77 {alignment = 4 : i32} : vector<16xi32>, vector<16xi1> into !llvm.ptr
    %80 = llvm.add %26, %2 : i64
    %81 = builtin.unrealized_conversion_cast %80 : i64 to index
    %82 = builtin.unrealized_conversion_cast %81 : index to i64
    llvm.br ^bb1(%82 : i64)
  ^bb3:  // pred: ^bb1
    llvm.return
  }
}


// -----// IR Dump After ReconcileUnrealizedCastsPass (reconcile-unrealized-casts) //----- //
module {
  llvm.func @vec_sum(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: !llvm.ptr, %arg6: !llvm.ptr, %arg7: i64, %arg8: i64, %arg9: i64, %arg10: !llvm.ptr, %arg11: !llvm.ptr, %arg12: i64, %arg13: i64, %arg14: i64, %arg15: i32) {
    %0 = llvm.mlir.poison : vector<16xi32>
    %1 = llvm.mlir.constant(dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]> : vector<16xi32>) : vector<16xi32>
    %2 = llvm.mlir.constant(16 : index) : i64
    %3 = llvm.mlir.constant(0 : index) : i64
    %4 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %5 = llvm.insertvalue %arg10, %4[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %6 = llvm.insertvalue %arg11, %5[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %7 = llvm.insertvalue %arg12, %6[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %8 = llvm.insertvalue %arg13, %7[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %9 = llvm.insertvalue %arg14, %8[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %10 = llvm.insertvalue %arg5, %4[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.insertvalue %arg6, %10[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.insertvalue %arg7, %11[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = llvm.insertvalue %arg8, %12[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %14 = llvm.insertvalue %arg9, %13[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %15 = llvm.insertvalue %arg0, %4[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %16 = llvm.insertvalue %arg1, %15[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %17 = llvm.insertvalue %arg2, %16[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %18 = llvm.insertvalue %arg3, %17[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %19 = llvm.insertvalue %arg4, %18[4, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %20 = llvm.sext %arg15 : i32 to i64
    llvm.br ^bb1(%3 : i64)
  ^bb1(%21: i64):  // 2 preds: ^bb0, ^bb2
    %22 = llvm.icmp "slt" %21, %20 : i64
    llvm.cond_br %22, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %23 = llvm.mlir.constant(1 : index) : i64
    %24 = llvm.extractvalue %19[3] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %25 = llvm.alloca %23 x !llvm.array<1 x i64> : (i64) -> !llvm.ptr
    llvm.store %24, %25 : !llvm.array<1 x i64>, !llvm.ptr
    %26 = llvm.getelementptr %25[0, %3] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.array<1 x i64>
    %27 = llvm.load %26 : !llvm.ptr -> i64
    %28 = llvm.sub %27, %21 : i64
    %29 = llvm.trunc %28 : i64 to i32
    %30 = llvm.mlir.poison : vector<16xi32>
    %31 = llvm.mlir.constant(0 : i32) : i32
    %32 = llvm.insertelement %29, %30[%31 : i32] : vector<16xi32>
    %33 = llvm.shufflevector %32, %30 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<16xi32> 
    %34 = llvm.icmp "sgt" %33, %1 : vector<16xi32>
    %35 = llvm.extractvalue %19[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %36 = llvm.getelementptr %35[%21] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %37 = llvm.intr.masked.load %36, %34, %0 {alignment = 4 : i32} : (!llvm.ptr, vector<16xi1>, vector<16xi32>) -> vector<16xi32>
    %38 = llvm.mlir.constant(1 : index) : i64
    %39 = llvm.extractvalue %14[3] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %40 = llvm.alloca %38 x !llvm.array<1 x i64> : (i64) -> !llvm.ptr
    llvm.store %39, %40 : !llvm.array<1 x i64>, !llvm.ptr
    %41 = llvm.getelementptr %40[0, %3] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.array<1 x i64>
    %42 = llvm.load %41 : !llvm.ptr -> i64
    %43 = llvm.sub %42, %21 : i64
    %44 = llvm.trunc %43 : i64 to i32
    %45 = llvm.mlir.poison : vector<16xi32>
    %46 = llvm.mlir.constant(0 : i32) : i32
    %47 = llvm.insertelement %44, %45[%46 : i32] : vector<16xi32>
    %48 = llvm.shufflevector %47, %45 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<16xi32> 
    %49 = llvm.icmp "sgt" %48, %1 : vector<16xi32>
    %50 = llvm.extractvalue %14[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %51 = llvm.getelementptr %50[%21] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %52 = llvm.intr.masked.load %51, %49, %0 {alignment = 4 : i32} : (!llvm.ptr, vector<16xi1>, vector<16xi32>) -> vector<16xi32>
    %53 = llvm.add %37, %52 : vector<16xi32>
    %54 = llvm.mlir.constant(1 : index) : i64
    %55 = llvm.extractvalue %9[3] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %56 = llvm.alloca %54 x !llvm.array<1 x i64> : (i64) -> !llvm.ptr
    llvm.store %55, %56 : !llvm.array<1 x i64>, !llvm.ptr
    %57 = llvm.getelementptr %56[0, %3] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.array<1 x i64>
    %58 = llvm.load %57 : !llvm.ptr -> i64
    %59 = llvm.sub %58, %21 : i64
    %60 = llvm.trunc %59 : i64 to i32
    %61 = llvm.mlir.poison : vector<16xi32>
    %62 = llvm.mlir.constant(0 : i32) : i32
    %63 = llvm.insertelement %60, %61[%62 : i32] : vector<16xi32>
    %64 = llvm.shufflevector %63, %61 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<16xi32> 
    %65 = llvm.icmp "sgt" %64, %1 : vector<16xi32>
    %66 = llvm.extractvalue %9[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %67 = llvm.getelementptr %66[%21] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.intr.masked.store %53, %67, %65 {alignment = 4 : i32} : vector<16xi32>, vector<16xi1> into !llvm.ptr
    %68 = llvm.add %21, %2 : i64
    llvm.br ^bb1(%68 : i64)
  ^bb3:  // pred: ^bb1
    llvm.return
  }
}


// -----// IR Dump After Canonicalizer (canonicalize) //----- //
module {
  llvm.func @vec_sum(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: !llvm.ptr, %arg6: !llvm.ptr, %arg7: i64, %arg8: i64, %arg9: i64, %arg10: !llvm.ptr, %arg11: !llvm.ptr, %arg12: i64, %arg13: i64, %arg14: i64, %arg15: i32) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : index) : i64
    %2 = llvm.mlir.poison : vector<16xi32>
    %3 = llvm.mlir.constant(dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]> : vector<16xi32>) : vector<16xi32>
    %4 = llvm.mlir.constant(16 : index) : i64
    %5 = llvm.mlir.constant(0 : index) : i64
    %6 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %7 = llvm.insertvalue %arg10, %6[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %8 = llvm.insertvalue %arg11, %7[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %9 = llvm.insertvalue %arg12, %8[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %10 = llvm.insertvalue %arg13, %9[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.insertvalue %arg5, %6[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.insertvalue %arg6, %11[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = llvm.insertvalue %arg7, %12[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %14 = llvm.insertvalue %arg8, %13[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %15 = llvm.insertvalue %arg0, %6[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %16 = llvm.insertvalue %arg1, %15[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %17 = llvm.insertvalue %arg2, %16[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %18 = llvm.insertvalue %arg3, %17[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %19 = llvm.sext %arg15 : i32 to i64
    llvm.br ^bb1(%5 : i64)
  ^bb1(%20: i64):  // 2 preds: ^bb0, ^bb2
    %21 = llvm.icmp "slt" %20, %19 : i64
    llvm.cond_br %21, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %22 = llvm.extractvalue %18[3] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %23 = llvm.alloca %1 x !llvm.array<1 x i64> : (i64) -> !llvm.ptr
    llvm.store %22, %23 : !llvm.array<1 x i64>, !llvm.ptr
    %24 = llvm.getelementptr %23[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<1 x i64>
    %25 = llvm.load %24 : !llvm.ptr -> i64
    %26 = llvm.sub %25, %20 : i64
    %27 = llvm.trunc %26 : i64 to i32
    %28 = llvm.insertelement %27, %2[%0 : i32] : vector<16xi32>
    %29 = llvm.shufflevector %28, %2 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<16xi32> 
    %30 = llvm.icmp "sgt" %29, %3 : vector<16xi32>
    %31 = llvm.getelementptr %arg1[%20] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %32 = llvm.intr.masked.load %31, %30, %2 {alignment = 4 : i32} : (!llvm.ptr, vector<16xi1>, vector<16xi32>) -> vector<16xi32>
    %33 = llvm.extractvalue %14[3] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %34 = llvm.alloca %1 x !llvm.array<1 x i64> : (i64) -> !llvm.ptr
    llvm.store %33, %34 : !llvm.array<1 x i64>, !llvm.ptr
    %35 = llvm.getelementptr %34[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<1 x i64>
    %36 = llvm.load %35 : !llvm.ptr -> i64
    %37 = llvm.sub %36, %20 : i64
    %38 = llvm.trunc %37 : i64 to i32
    %39 = llvm.insertelement %38, %2[%0 : i32] : vector<16xi32>
    %40 = llvm.shufflevector %39, %2 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<16xi32> 
    %41 = llvm.icmp "sgt" %40, %3 : vector<16xi32>
    %42 = llvm.getelementptr %arg6[%20] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %43 = llvm.intr.masked.load %42, %41, %2 {alignment = 4 : i32} : (!llvm.ptr, vector<16xi1>, vector<16xi32>) -> vector<16xi32>
    %44 = llvm.add %32, %43 : vector<16xi32>
    %45 = llvm.extractvalue %10[3] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %46 = llvm.alloca %1 x !llvm.array<1 x i64> : (i64) -> !llvm.ptr
    llvm.store %45, %46 : !llvm.array<1 x i64>, !llvm.ptr
    %47 = llvm.getelementptr %46[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<1 x i64>
    %48 = llvm.load %47 : !llvm.ptr -> i64
    %49 = llvm.sub %48, %20 : i64
    %50 = llvm.trunc %49 : i64 to i32
    %51 = llvm.insertelement %50, %2[%0 : i32] : vector<16xi32>
    %52 = llvm.shufflevector %51, %2 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<16xi32> 
    %53 = llvm.icmp "sgt" %52, %3 : vector<16xi32>
    %54 = llvm.getelementptr %arg11[%20] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.intr.masked.store %44, %54, %53 {alignment = 4 : i32} : vector<16xi32>, vector<16xi1> into !llvm.ptr
    %55 = llvm.add %20, %4 : i64
    llvm.br ^bb1(%55 : i64)
  ^bb3:  // pred: ^bb1
    llvm.return
  }
}


// -----// IR Dump After SCCP (sccp) //----- //
module {
  llvm.func @vec_sum(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: !llvm.ptr, %arg6: !llvm.ptr, %arg7: i64, %arg8: i64, %arg9: i64, %arg10: !llvm.ptr, %arg11: !llvm.ptr, %arg12: i64, %arg13: i64, %arg14: i64, %arg15: i32) {
    %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.mlir.constant(dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]> : vector<16xi32>) : vector<16xi32>
    %2 = llvm.mlir.poison : vector<16xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(1 : index) : i64
    %5 = llvm.mlir.constant(16 : index) : i64
    %6 = llvm.mlir.constant(0 : index) : i64
    %7 = llvm.insertvalue %arg10, %0[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %8 = llvm.insertvalue %arg11, %7[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %9 = llvm.insertvalue %arg12, %8[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %10 = llvm.insertvalue %arg13, %9[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.insertvalue %arg5, %0[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.insertvalue %arg6, %11[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = llvm.insertvalue %arg7, %12[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %14 = llvm.insertvalue %arg8, %13[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %15 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %16 = llvm.insertvalue %arg1, %15[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %17 = llvm.insertvalue %arg2, %16[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %18 = llvm.insertvalue %arg3, %17[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %19 = llvm.sext %arg15 : i32 to i64
    llvm.br ^bb1(%6 : i64)
  ^bb1(%20: i64):  // 2 preds: ^bb0, ^bb2
    %21 = llvm.icmp "slt" %20, %19 : i64
    llvm.cond_br %21, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %22 = llvm.extractvalue %18[3] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %23 = llvm.alloca %4 x !llvm.array<1 x i64> : (i64) -> !llvm.ptr
    llvm.store %22, %23 : !llvm.array<1 x i64>, !llvm.ptr
    %24 = llvm.getelementptr %23[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<1 x i64>
    %25 = llvm.load %24 : !llvm.ptr -> i64
    %26 = llvm.sub %25, %20 : i64
    %27 = llvm.trunc %26 : i64 to i32
    %28 = llvm.insertelement %27, %2[%3 : i32] : vector<16xi32>
    %29 = llvm.shufflevector %28, %2 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<16xi32> 
    %30 = llvm.icmp "sgt" %29, %1 : vector<16xi32>
    %31 = llvm.getelementptr %arg1[%20] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %32 = llvm.intr.masked.load %31, %30, %2 {alignment = 4 : i32} : (!llvm.ptr, vector<16xi1>, vector<16xi32>) -> vector<16xi32>
    %33 = llvm.extractvalue %14[3] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %34 = llvm.alloca %4 x !llvm.array<1 x i64> : (i64) -> !llvm.ptr
    llvm.store %33, %34 : !llvm.array<1 x i64>, !llvm.ptr
    %35 = llvm.getelementptr %34[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<1 x i64>
    %36 = llvm.load %35 : !llvm.ptr -> i64
    %37 = llvm.sub %36, %20 : i64
    %38 = llvm.trunc %37 : i64 to i32
    %39 = llvm.insertelement %38, %2[%3 : i32] : vector<16xi32>
    %40 = llvm.shufflevector %39, %2 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<16xi32> 
    %41 = llvm.icmp "sgt" %40, %1 : vector<16xi32>
    %42 = llvm.getelementptr %arg6[%20] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %43 = llvm.intr.masked.load %42, %41, %2 {alignment = 4 : i32} : (!llvm.ptr, vector<16xi1>, vector<16xi32>) -> vector<16xi32>
    %44 = llvm.add %32, %43 : vector<16xi32>
    %45 = llvm.extractvalue %10[3] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %46 = llvm.alloca %4 x !llvm.array<1 x i64> : (i64) -> !llvm.ptr
    llvm.store %45, %46 : !llvm.array<1 x i64>, !llvm.ptr
    %47 = llvm.getelementptr %46[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<1 x i64>
    %48 = llvm.load %47 : !llvm.ptr -> i64
    %49 = llvm.sub %48, %20 : i64
    %50 = llvm.trunc %49 : i64 to i32
    %51 = llvm.insertelement %50, %2[%3 : i32] : vector<16xi32>
    %52 = llvm.shufflevector %51, %2 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<16xi32> 
    %53 = llvm.icmp "sgt" %52, %1 : vector<16xi32>
    %54 = llvm.getelementptr %arg11[%20] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.intr.masked.store %44, %54, %53 {alignment = 4 : i32} : vector<16xi32>, vector<16xi1> into !llvm.ptr
    %55 = llvm.add %20, %5 : i64
    llvm.br ^bb1(%55 : i64)
  ^bb3:  // pred: ^bb1
    llvm.return
  }
}


// -----// IR Dump After CSE (cse) //----- //
module {
  llvm.func @vec_sum(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: !llvm.ptr, %arg6: !llvm.ptr, %arg7: i64, %arg8: i64, %arg9: i64, %arg10: !llvm.ptr, %arg11: !llvm.ptr, %arg12: i64, %arg13: i64, %arg14: i64, %arg15: i32) {
    %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.mlir.constant(dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]> : vector<16xi32>) : vector<16xi32>
    %2 = llvm.mlir.poison : vector<16xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(1 : index) : i64
    %5 = llvm.mlir.constant(16 : index) : i64
    %6 = llvm.mlir.constant(0 : index) : i64
    %7 = llvm.insertvalue %arg10, %0[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %8 = llvm.insertvalue %arg11, %7[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %9 = llvm.insertvalue %arg12, %8[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %10 = llvm.insertvalue %arg13, %9[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.insertvalue %arg5, %0[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.insertvalue %arg6, %11[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = llvm.insertvalue %arg7, %12[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %14 = llvm.insertvalue %arg8, %13[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %15 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %16 = llvm.insertvalue %arg1, %15[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %17 = llvm.insertvalue %arg2, %16[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %18 = llvm.insertvalue %arg3, %17[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %19 = llvm.sext %arg15 : i32 to i64
    llvm.br ^bb1(%6 : i64)
  ^bb1(%20: i64):  // 2 preds: ^bb0, ^bb2
    %21 = llvm.icmp "slt" %20, %19 : i64
    llvm.cond_br %21, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %22 = llvm.extractvalue %18[3] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %23 = llvm.alloca %4 x !llvm.array<1 x i64> : (i64) -> !llvm.ptr
    llvm.store %22, %23 : !llvm.array<1 x i64>, !llvm.ptr
    %24 = llvm.getelementptr %23[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<1 x i64>
    %25 = llvm.load %24 : !llvm.ptr -> i64
    %26 = llvm.sub %25, %20 : i64
    %27 = llvm.trunc %26 : i64 to i32
    %28 = llvm.insertelement %27, %2[%3 : i32] : vector<16xi32>
    %29 = llvm.shufflevector %28, %2 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<16xi32> 
    %30 = llvm.icmp "sgt" %29, %1 : vector<16xi32>
    %31 = llvm.getelementptr %arg1[%20] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %32 = llvm.intr.masked.load %31, %30, %2 {alignment = 4 : i32} : (!llvm.ptr, vector<16xi1>, vector<16xi32>) -> vector<16xi32>
    %33 = llvm.extractvalue %14[3] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %34 = llvm.alloca %4 x !llvm.array<1 x i64> : (i64) -> !llvm.ptr
    llvm.store %33, %34 : !llvm.array<1 x i64>, !llvm.ptr
    %35 = llvm.getelementptr %34[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<1 x i64>
    %36 = llvm.load %35 : !llvm.ptr -> i64
    %37 = llvm.sub %36, %20 : i64
    %38 = llvm.trunc %37 : i64 to i32
    %39 = llvm.insertelement %38, %2[%3 : i32] : vector<16xi32>
    %40 = llvm.shufflevector %39, %2 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<16xi32> 
    %41 = llvm.icmp "sgt" %40, %1 : vector<16xi32>
    %42 = llvm.getelementptr %arg6[%20] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %43 = llvm.intr.masked.load %42, %41, %2 {alignment = 4 : i32} : (!llvm.ptr, vector<16xi1>, vector<16xi32>) -> vector<16xi32>
    %44 = llvm.add %32, %43 : vector<16xi32>
    %45 = llvm.extractvalue %10[3] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %46 = llvm.alloca %4 x !llvm.array<1 x i64> : (i64) -> !llvm.ptr
    llvm.store %45, %46 : !llvm.array<1 x i64>, !llvm.ptr
    %47 = llvm.getelementptr %46[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<1 x i64>
    %48 = llvm.load %47 : !llvm.ptr -> i64
    %49 = llvm.sub %48, %20 : i64
    %50 = llvm.trunc %49 : i64 to i32
    %51 = llvm.insertelement %50, %2[%3 : i32] : vector<16xi32>
    %52 = llvm.shufflevector %51, %2 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<16xi32> 
    %53 = llvm.icmp "sgt" %52, %1 : vector<16xi32>
    %54 = llvm.getelementptr %arg11[%20] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.intr.masked.store %44, %54, %53 {alignment = 4 : i32} : vector<16xi32>, vector<16xi1> into !llvm.ptr
    %55 = llvm.add %20, %5 : i64
    llvm.br ^bb1(%55 : i64)
  ^bb3:  // pred: ^bb1
    llvm.return
  }
}


// -----// IR Dump After SymbolDCE (symbol-dce) //----- //
module {
  llvm.func @vec_sum(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: !llvm.ptr, %arg6: !llvm.ptr, %arg7: i64, %arg8: i64, %arg9: i64, %arg10: !llvm.ptr, %arg11: !llvm.ptr, %arg12: i64, %arg13: i64, %arg14: i64, %arg15: i32) {
    %0 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.mlir.constant(dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]> : vector<16xi32>) : vector<16xi32>
    %2 = llvm.mlir.poison : vector<16xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(1 : index) : i64
    %5 = llvm.mlir.constant(16 : index) : i64
    %6 = llvm.mlir.constant(0 : index) : i64
    %7 = llvm.insertvalue %arg10, %0[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %8 = llvm.insertvalue %arg11, %7[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %9 = llvm.insertvalue %arg12, %8[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %10 = llvm.insertvalue %arg13, %9[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.insertvalue %arg5, %0[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.insertvalue %arg6, %11[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = llvm.insertvalue %arg7, %12[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %14 = llvm.insertvalue %arg8, %13[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %15 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %16 = llvm.insertvalue %arg1, %15[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %17 = llvm.insertvalue %arg2, %16[2] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %18 = llvm.insertvalue %arg3, %17[3, 0] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %19 = llvm.sext %arg15 : i32 to i64
    llvm.br ^bb1(%6 : i64)
  ^bb1(%20: i64):  // 2 preds: ^bb0, ^bb2
    %21 = llvm.icmp "slt" %20, %19 : i64
    llvm.cond_br %21, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %22 = llvm.extractvalue %18[3] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %23 = llvm.alloca %4 x !llvm.array<1 x i64> : (i64) -> !llvm.ptr
    llvm.store %22, %23 : !llvm.array<1 x i64>, !llvm.ptr
    %24 = llvm.getelementptr %23[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<1 x i64>
    %25 = llvm.load %24 : !llvm.ptr -> i64
    %26 = llvm.sub %25, %20 : i64
    %27 = llvm.trunc %26 : i64 to i32
    %28 = llvm.insertelement %27, %2[%3 : i32] : vector<16xi32>
    %29 = llvm.shufflevector %28, %2 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<16xi32> 
    %30 = llvm.icmp "sgt" %29, %1 : vector<16xi32>
    %31 = llvm.getelementptr %arg1[%20] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %32 = llvm.intr.masked.load %31, %30, %2 {alignment = 4 : i32} : (!llvm.ptr, vector<16xi1>, vector<16xi32>) -> vector<16xi32>
    %33 = llvm.extractvalue %14[3] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %34 = llvm.alloca %4 x !llvm.array<1 x i64> : (i64) -> !llvm.ptr
    llvm.store %33, %34 : !llvm.array<1 x i64>, !llvm.ptr
    %35 = llvm.getelementptr %34[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<1 x i64>
    %36 = llvm.load %35 : !llvm.ptr -> i64
    %37 = llvm.sub %36, %20 : i64
    %38 = llvm.trunc %37 : i64 to i32
    %39 = llvm.insertelement %38, %2[%3 : i32] : vector<16xi32>
    %40 = llvm.shufflevector %39, %2 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<16xi32> 
    %41 = llvm.icmp "sgt" %40, %1 : vector<16xi32>
    %42 = llvm.getelementptr %arg6[%20] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %43 = llvm.intr.masked.load %42, %41, %2 {alignment = 4 : i32} : (!llvm.ptr, vector<16xi1>, vector<16xi32>) -> vector<16xi32>
    %44 = llvm.add %32, %43 : vector<16xi32>
    %45 = llvm.extractvalue %10[3] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %46 = llvm.alloca %4 x !llvm.array<1 x i64> : (i64) -> !llvm.ptr
    llvm.store %45, %46 : !llvm.array<1 x i64>, !llvm.ptr
    %47 = llvm.getelementptr %46[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<1 x i64>
    %48 = llvm.load %47 : !llvm.ptr -> i64
    %49 = llvm.sub %48, %20 : i64
    %50 = llvm.trunc %49 : i64 to i32
    %51 = llvm.insertelement %50, %2[%3 : i32] : vector<16xi32>
    %52 = llvm.shufflevector %51, %2 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<16xi32> 
    %53 = llvm.icmp "sgt" %52, %1 : vector<16xi32>
    %54 = llvm.getelementptr %arg11[%20] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.intr.masked.store %44, %54, %53 {alignment = 4 : i32} : vector<16xi32>, vector<16xi1> into !llvm.ptr
    %55 = llvm.add %20, %5 : i64
    llvm.br ^bb1(%55 : i64)
  ^bb3:  // pred: ^bb1
    llvm.return
  }
}


