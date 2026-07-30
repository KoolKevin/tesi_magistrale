; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target datalayout = "e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-f64:32-v64:32-v128:32-a:0:32-v256:32-v512:32-n8:16:32"
target triple = "arc-pc-unknown-gnu"

define void @matmul(i32 %0, i32 %1, i32 %2, ptr %3, ptr %4, i32 %5, i32 %6, i32 %7, i32 %8, i32 %9, ptr %10, ptr %11, i32 %12, i32 %13, i32 %14, i32 %15, i32 %16, ptr %17, ptr %18, i32 %19, i32 %20, i32 %21, i32 %22, i32 %23) {
  %25 = ptrtoint ptr %11 to i32
  %26 = inttoptr i32 %25 to ptr addrspace(4)
  %27 = ptrtoint ptr %18 to i32
  %28 = inttoptr i32 %27 to ptr addrspace(4)
  br label %29

29:                                               ; preds = %69, %24
  %30 = phi i32 [ %70, %69 ], [ 0, %24 ]
  %31 = icmp slt i32 %30, %6
  br i1 %31, label %32, label %71

32:                                               ; preds = %29
  %33 = icmp slt i32 %14, 0
  %34 = sub i32 -1, %14
  %35 = select i1 %33, i32 %34, i32 %14
  %36 = sdiv i32 %35, 16
  %37 = sub i32 -1, %36
  %38 = select i1 %33, i32 %37, i32 %36
  %39 = mul nsw i32 %38, 16
  br label %40

40:                                               ; preds = %66, %32
  %41 = phi i32 [ %68, %66 ], [ 0, %32 ]
  %42 = icmp slt i32 %41, %39
  br i1 %42, label %43, label %69

43:                                               ; preds = %40
  %44 = mul i32 %30, %14
  %45 = add i32 %44, %41
  %46 = getelementptr i32, ptr addrspace(4) %28, i32 %45
  %47 = call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %46)
  %48 = call <16 x i32> @llvm.arc.vvcmpy.lo.acc.w.v512(<16 x i32> %47, <16 x i32> splat (i32 1))
  br label %49

49:                                               ; preds = %53, %43
  %50 = phi i32 [ %65, %53 ], [ 0, %43 ]
  %51 = phi <16 x i32> [ %64, %53 ], [ %48, %43 ]
  %52 = icmp slt i32 %50, %7
  br i1 %52, label %53, label %66

53:                                               ; preds = %49
  %54 = mul i32 %50, %14
  %55 = add i32 %54, %41
  %56 = getelementptr i32, ptr addrspace(4) %26, i32 %55
  %57 = call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %56)
  %58 = mul i32 %30, %8
  %59 = add i32 %58, %50
  %60 = getelementptr i32, ptr %4, i32 %59
  %61 = load i32, ptr %60, align 4
  %62 = insertelement <16 x i32> undef, i32 %61, i32 0
  %63 = shufflevector <16 x i32> %62, <16 x i32> undef, <16 x i32> zeroinitializer
  %64 = call <16 x i32> @llvm.arc.vvcmac.lo.acc.w.v512(<16 x i32> %51, <16 x i32> %57, <16 x i32> %63)
  %65 = add i32 %50, 1
  br label %49

66:                                               ; preds = %49
  %67 = call <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32> %51)
  call void @llvm.arc.vvst.w.v512(<16 x i32> %67, ptr addrspace(4) %46)
  %68 = add i32 %41, 16
  br label %40

69:                                               ; preds = %40
  %70 = add i32 %30, 1
  br label %29

71:                                               ; preds = %29
  br label %72

72:                                               ; preds = %108, %71
  %73 = phi i32 [ %109, %108 ], [ 0, %71 ]
  %74 = icmp slt i32 %73, %6
  br i1 %74, label %75, label %110

75:                                               ; preds = %72
  %76 = icmp slt i32 %14, 0
  %77 = sub i32 -1, %14
  %78 = select i1 %76, i32 %77, i32 %14
  %79 = sdiv i32 %78, 16
  %80 = sub i32 -1, %79
  %81 = select i1 %76, i32 %80, i32 %79
  %82 = mul nsw i32 %81, 16
  br label %83

83:                                               ; preds = %103, %75
  %84 = phi i32 [ %107, %103 ], [ %82, %75 ]
  %85 = icmp slt i32 %84, %14
  br i1 %85, label %86, label %108

86:                                               ; preds = %83
  br label %87

87:                                               ; preds = %91, %86
  %88 = phi i32 [ %102, %91 ], [ 0, %86 ]
  %89 = phi i32 [ %101, %91 ], [ 0, %86 ]
  %90 = icmp slt i32 %88, %7
  br i1 %90, label %91, label %103

91:                                               ; preds = %87
  %92 = mul i32 %73, %8
  %93 = add i32 %92, %88
  %94 = getelementptr i32, ptr %4, i32 %93
  %95 = load i32, ptr %94, align 4
  %96 = mul i32 %88, %15
  %97 = add i32 %96, %84
  %98 = getelementptr i32, ptr %11, i32 %97
  %99 = load i32, ptr %98, align 4
  %100 = mul i32 %95, %99
  %101 = add i32 %89, %100
  %102 = add i32 %88, 1
  br label %87

103:                                              ; preds = %87
  %104 = mul i32 %73, %22
  %105 = add i32 %104, %84
  %106 = getelementptr i32, ptr %18, i32 %105
  store i32 %89, ptr %106, align 4
  %107 = add i32 %84, 1
  br label %83

108:                                              ; preds = %83
  %109 = add i32 %73, 1
  br label %72

110:                                              ; preds = %72
  ret void
}

declare <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4))

declare <16 x i32> @llvm.arc.vvcmpy.lo.acc.w.v512(<16 x i32>, <16 x i32>)

declare <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32>)

declare void @llvm.arc.vvst.w.v512(<16 x i32>, ptr addrspace(4))

declare <16 x i32> @llvm.arc.vvcmac.lo.acc.w.v512(<16 x i32>, <16 x i32>, <16 x i32>)

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
