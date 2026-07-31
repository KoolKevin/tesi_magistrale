; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target datalayout = "e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-f64:32-v64:32-v128:32-a:0:32-v256:32-v512:32-n8:16:32"
target triple = "arc-pc-unknown-gnu"

define void @conv1d(i32 %0, i32 %1, i32 %2, ptr %3, ptr %4, i32 %5, i32 %6, i32 %7, ptr %8, ptr %9, i32 %10, i32 %11, i32 %12, ptr %13, ptr %14, i32 %15, i32 %16, i32 %17) {
  %19 = ptrtoint ptr %9 to i32
  %20 = inttoptr i32 %19 to ptr addrspace(4)
  %21 = ptrtoint ptr %4 to i32
  %22 = inttoptr i32 %21 to ptr addrspace(4)
  %23 = icmp slt i32 %6, 0
  %24 = sub i32 -1, %6
  %25 = select i1 %23, i32 %24, i32 %6
  %26 = sdiv i32 %25, 16
  %27 = sub i32 -1, %26
  %28 = select i1 %23, i32 %27, i32 %26
  %29 = mul nsw i32 %28, 16
  br label %30

30:                                               ; preds = %51, %18
  %31 = phi i32 [ %53, %51 ], [ 0, %18 ]
  %32 = icmp slt i32 %31, %29
  br i1 %32, label %33, label %54

33:                                               ; preds = %30
  %34 = getelementptr i32, ptr addrspace(4) %22, i32 %31
  %35 = call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %34)
  %36 = call <16 x i32> @llvm.arc.vvcadd.init.acc.w.v512(<16 x i32> %35, <16 x i32> zeroinitializer)
  br label %37

37:                                               ; preds = %41, %33
  %38 = phi i32 [ %50, %41 ], [ 0, %33 ]
  %39 = phi <16 x i32> [ %49, %41 ], [ %36, %33 ]
  %40 = icmp slt i32 %38, %16
  br i1 %40, label %41, label %51

41:                                               ; preds = %37
  %42 = add i32 %31, %38
  %43 = getelementptr i32, ptr addrspace(4) %20, i32 %42
  %44 = call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %43)
  %45 = getelementptr i32, ptr %14, i32 %38
  %46 = load i32, ptr %45, align 4
  %47 = insertelement <16 x i32> undef, i32 %46, i32 0
  %48 = shufflevector <16 x i32> %47, <16 x i32> undef, <16 x i32> zeroinitializer
  %49 = call <16 x i32> @llvm.arc.vvcmac.lo.acc.w.v512(<16 x i32> %39, <16 x i32> %44, <16 x i32> %48)
  %50 = add i32 %38, 1
  br label %37

51:                                               ; preds = %37
  %52 = call <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32> %39)
  call void @llvm.arc.vvst.w.v512(<16 x i32> %52, ptr addrspace(4) %34)
  %53 = add i32 %31, 16
  br label %30

54:                                               ; preds = %30
  br label %55

55:                                               ; preds = %74, %54
  %56 = phi i32 [ %75, %74 ], [ %29, %54 ]
  %57 = icmp slt i32 %56, %6
  br i1 %57, label %58, label %76

58:                                               ; preds = %55
  %59 = getelementptr i32, ptr %4, i32 %56
  %60 = load i32, ptr %59, align 4
  br label %61

61:                                               ; preds = %65, %58
  %62 = phi i32 [ %73, %65 ], [ 0, %58 ]
  %63 = phi i32 [ %72, %65 ], [ %60, %58 ]
  %64 = icmp slt i32 %62, %16
  br i1 %64, label %65, label %74

65:                                               ; preds = %61
  %66 = add i32 %56, %62
  %67 = getelementptr i32, ptr %9, i32 %66
  %68 = load i32, ptr %67, align 4
  %69 = getelementptr i32, ptr %14, i32 %62
  %70 = load i32, ptr %69, align 4
  %71 = mul i32 %68, %70
  %72 = add i32 %63, %71
  %73 = add i32 %62, 1
  br label %61

74:                                               ; preds = %61
  store i32 %63, ptr %59, align 4
  %75 = add i32 %56, 1
  br label %55

76:                                               ; preds = %55
  ret void
}

declare <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4))

declare <16 x i32> @llvm.arc.vvcadd.init.acc.w.v512(<16 x i32>, <16 x i32>)

declare <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32>)

declare void @llvm.arc.vvst.w.v512(<16 x i32>, ptr addrspace(4))

declare <16 x i32> @llvm.arc.vvcmac.lo.acc.w.v512(<16 x i32>, <16 x i32>, <16 x i32>)

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
