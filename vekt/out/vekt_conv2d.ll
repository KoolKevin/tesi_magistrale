; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target datalayout = "e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-f64:32-v64:32-v128:32-a:0:32-v256:32-v512:32-n8:16:32"
target triple = "arc-pc-unknown-gnu"

define void @conv2d(i32 %0, i32 %1, i32 %2, i32 %3, i32 %4, ptr %5, ptr %6, i32 %7, i32 %8, i32 %9, i32 %10, i32 %11, ptr %12, ptr %13, i32 %14, i32 %15, i32 %16, i32 %17, i32 %18, ptr %19, ptr %20, i32 %21, i32 %22, i32 %23, i32 %24, i32 %25) {
  %27 = ptrtoint ptr %13 to i32
  %28 = inttoptr i32 %27 to ptr addrspace(4)
  %29 = ptrtoint ptr %6 to i32
  %30 = inttoptr i32 %29 to ptr addrspace(4)
  %31 = add i32 %9, %23
  %32 = sub i32 %31, 1
  br label %33

33:                                               ; preds = %82, %26
  %34 = phi i32 [ %83, %82 ], [ 0, %26 ]
  %35 = icmp slt i32 %34, %8
  br i1 %35, label %36, label %84

36:                                               ; preds = %33
  %37 = icmp slt i32 %9, 0
  %38 = sub i32 -1, %9
  %39 = select i1 %37, i32 %38, i32 %9
  %40 = sdiv i32 %39, 16
  %41 = sub i32 -1, %40
  %42 = select i1 %37, i32 %41, i32 %40
  %43 = mul nsw i32 %42, 16
  br label %44

44:                                               ; preds = %79, %36
  %45 = phi i32 [ %81, %79 ], [ 0, %36 ]
  %46 = icmp slt i32 %45, %43
  br i1 %46, label %47, label %82

47:                                               ; preds = %44
  %48 = mul i32 %34, %9
  %49 = add i32 %48, %45
  %50 = getelementptr i32, ptr addrspace(4) %30, i32 %49
  %51 = call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %50)
  %52 = call <16 x i32> @llvm.arc.vvcadd.init.acc.w.v512(<16 x i32> %51, <16 x i32> zeroinitializer)
  br label %53

53:                                               ; preds = %77, %47
  %54 = phi i32 [ %78, %77 ], [ 0, %47 ]
  %55 = phi <16 x i32> [ %60, %77 ], [ %52, %47 ]
  %56 = icmp slt i32 %54, %22
  br i1 %56, label %57, label %79

57:                                               ; preds = %53
  br label %58

58:                                               ; preds = %62, %57
  %59 = phi i32 [ %76, %62 ], [ 0, %57 ]
  %60 = phi <16 x i32> [ %75, %62 ], [ %55, %57 ]
  %61 = icmp slt i32 %59, %23
  br i1 %61, label %62, label %77

62:                                               ; preds = %58
  %63 = add i32 %34, %54
  %64 = add i32 %45, %59
  %65 = mul i32 %63, %32
  %66 = add i32 %65, %64
  %67 = getelementptr i32, ptr addrspace(4) %28, i32 %66
  %68 = call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %67)
  %69 = mul i32 %54, %24
  %70 = add i32 %69, %59
  %71 = getelementptr i32, ptr %20, i32 %70
  %72 = load i32, ptr %71, align 4
  %73 = insertelement <16 x i32> undef, i32 %72, i32 0
  %74 = shufflevector <16 x i32> %73, <16 x i32> undef, <16 x i32> zeroinitializer
  %75 = call <16 x i32> @llvm.arc.vvcmac.lo.acc.w.v512(<16 x i32> %60, <16 x i32> %68, <16 x i32> %74)
  %76 = add i32 %59, 1
  br label %58

77:                                               ; preds = %58
  %78 = add i32 %54, 1
  br label %53

79:                                               ; preds = %53
  %80 = call <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32> %55)
  call void @llvm.arc.vvst.w.v512(<16 x i32> %80, ptr addrspace(4) %50)
  %81 = add i32 %45, 16
  br label %44

82:                                               ; preds = %44
  %83 = add i32 %34, 1
  br label %33

84:                                               ; preds = %33
  br label %85

85:                                               ; preds = %131, %84
  %86 = phi i32 [ %132, %131 ], [ 0, %84 ]
  %87 = icmp slt i32 %86, %8
  br i1 %87, label %88, label %133

88:                                               ; preds = %85
  %89 = icmp slt i32 %9, 0
  %90 = sub i32 -1, %9
  %91 = select i1 %89, i32 %90, i32 %9
  %92 = sdiv i32 %91, 16
  %93 = sub i32 -1, %92
  %94 = select i1 %89, i32 %93, i32 %92
  %95 = mul nsw i32 %94, 16
  br label %96

96:                                               ; preds = %129, %88
  %97 = phi i32 [ %130, %129 ], [ %95, %88 ]
  %98 = icmp slt i32 %97, %9
  br i1 %98, label %99, label %131

99:                                               ; preds = %96
  %100 = mul i32 %86, %10
  %101 = add i32 %100, %97
  %102 = getelementptr i32, ptr %6, i32 %101
  %103 = load i32, ptr %102, align 4
  br label %104

104:                                              ; preds = %127, %99
  %105 = phi i32 [ %128, %127 ], [ 0, %99 ]
  %106 = phi i32 [ %111, %127 ], [ %103, %99 ]
  %107 = icmp slt i32 %105, %22
  br i1 %107, label %108, label %129

108:                                              ; preds = %104
  br label %109

109:                                              ; preds = %113, %108
  %110 = phi i32 [ %126, %113 ], [ 0, %108 ]
  %111 = phi i32 [ %125, %113 ], [ %106, %108 ]
  %112 = icmp slt i32 %110, %23
  br i1 %112, label %113, label %127

113:                                              ; preds = %109
  %114 = add i32 %86, %105
  %115 = add i32 %97, %110
  %116 = mul i32 %114, %17
  %117 = add i32 %116, %115
  %118 = getelementptr i32, ptr %13, i32 %117
  %119 = load i32, ptr %118, align 4
  %120 = mul i32 %105, %24
  %121 = add i32 %120, %110
  %122 = getelementptr i32, ptr %20, i32 %121
  %123 = load i32, ptr %122, align 4
  %124 = mul i32 %119, %123
  %125 = add i32 %111, %124
  %126 = add i32 %110, 1
  br label %109

127:                                              ; preds = %109
  %128 = add i32 %105, 1
  br label %104

129:                                              ; preds = %104
  store i32 %106, ptr %102, align 4
  %130 = add i32 %97, 1
  br label %96

131:                                              ; preds = %96
  %132 = add i32 %86, 1
  br label %85

133:                                              ; preds = %85
  ret void
}

declare <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4))

declare <16 x i32> @llvm.arc.vvcadd.init.acc.w.v512(<16 x i32>, <16 x i32>)

declare <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32>)

declare void @llvm.arc.vvst.w.v512(<16 x i32>, ptr addrspace(4))

declare <16 x i32> @llvm.arc.vvcmac.lo.acc.w.v512(<16 x i32>, <16 x i32>, <16 x i32>)

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
