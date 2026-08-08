; ModuleID = 'vekt_conv2d.licm2.ll'
source_filename = "LLVMDialectModule"
target datalayout = "e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-f64:32-v64:32-v128:32-a:0:32-v256:32-v512:32-n8:16:32"

define void @conv2d(i32 %0, i32 %1, i32 %2, i32 %3, i32 %4, ptr %5, ptr %6, i32 %7, i32 %8, i32 %9, i32 %10, i32 %11, ptr %12, ptr %13, i32 %14, i32 %15, i32 %16, i32 %17, i32 %18, ptr %19, ptr %20, i32 %21, i32 %22, i32 %23, i32 %24, i32 %25) {
  %27 = ptrtoint ptr %13 to i32
  %28 = inttoptr i32 %27 to ptr addrspace(4)
  %29 = ptrtoint ptr %6 to i32
  %30 = inttoptr i32 %29 to ptr addrspace(4)
  %31 = add i32 %9, %23
  %32 = sub i32 %31, 1
  %33 = icmp slt i32 %9, 0
  %34 = sub i32 -1, %9
  %35 = select i1 %33, i32 %34, i32 %9
  %36 = sdiv i32 %35, 16
  %37 = sub i32 -1, %36
  %38 = select i1 %33, i32 %37, i32 %36
  %39 = mul nsw i32 %38, 16
  br label %40

40:                                               ; preds = %80, %26
  %41 = phi i32 [ %81, %80 ], [ 0, %26 ]
  %42 = icmp slt i32 %41, %8
  br i1 %42, label %43, label %82

43:                                               ; preds = %40
  %44 = mul i32 %41, %9
  br label %45

45:                                               ; preds = %77, %43
  %46 = phi i32 [ %79, %77 ], [ 0, %43 ]
  %47 = icmp slt i32 %46, %39
  br i1 %47, label %48, label %80

48:                                               ; preds = %45
  %49 = add i32 %44, %46
  %50 = getelementptr i32, ptr addrspace(4) %30, i32 %49
  %51 = load <16 x i32>, ptr addrspace(4) %50, align 4
  %52 = call <16 x i32> @llvm.arc.vvcadd.init.acc.w.v512(<16 x i32> %51, <16 x i32> zeroinitializer)
  br label %53

53:                                               ; preds = %75, %48
  %54 = phi i32 [ %76, %75 ], [ 0, %48 ]
  %55 = phi <16 x i32> [ %.lcssa2, %75 ], [ %52, %48 ]
  %56 = icmp slt i32 %54, %22
  br i1 %56, label %57, label %77

57:                                               ; preds = %53
  %58 = add i32 %41, %54
  %59 = mul i32 %58, %32
  %invariant.op = add i32 %46, %59
  %60 = mul i32 %54, %24
  br label %61

61:                                               ; preds = %65, %57
  %62 = phi i32 [ %74, %65 ], [ 0, %57 ]
  %63 = phi <16 x i32> [ %73, %65 ], [ %55, %57 ]
  %64 = icmp slt i32 %62, %23
  br i1 %64, label %65, label %75

65:                                               ; preds = %61
  %.reass = add i32 %62, %invariant.op
  %66 = getelementptr i32, ptr addrspace(4) %28, i32 %.reass
  %67 = load <16 x i32>, ptr addrspace(4) %66, align 4
  %68 = add i32 %60, %62
  %69 = getelementptr i32, ptr %20, i32 %68
  %70 = load i32, ptr %69, align 4
  %71 = insertelement <16 x i32> undef, i32 %70, i32 0
  %72 = shufflevector <16 x i32> %71, <16 x i32> undef, <16 x i32> zeroinitializer
  %73 = call <16 x i32> @llvm.arc.vvcmac.lo.acc.w.v512(<16 x i32> %63, <16 x i32> %67, <16 x i32> %72)
  %74 = add i32 %62, 1
  br label %61

75:                                               ; preds = %61
  %.lcssa2 = phi <16 x i32> [ %63, %61 ]
  %76 = add i32 %54, 1
  br label %53

77:                                               ; preds = %53
  %.lcssa3 = phi <16 x i32> [ %55, %53 ]
  %78 = call <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32> %.lcssa3)
  store <16 x i32> %78, ptr addrspace(4) %50, align 4
  %79 = add i32 %46, 16
  br label %45

80:                                               ; preds = %45
  %81 = add i32 %41, 1
  br label %40

82:                                               ; preds = %40
  br label %83

83:                                               ; preds = %120, %82
  %84 = phi i32 [ %121, %120 ], [ 0, %82 ]
  %85 = icmp slt i32 %84, %8
  br i1 %85, label %86, label %122

86:                                               ; preds = %83
  %87 = mul i32 %84, %10
  br label %88

88:                                               ; preds = %118, %86
  %89 = phi i32 [ %119, %118 ], [ %39, %86 ]
  %90 = icmp slt i32 %89, %9
  br i1 %90, label %91, label %120

91:                                               ; preds = %88
  %92 = add i32 %87, %89
  %93 = getelementptr i32, ptr %6, i32 %92
  %94 = load i32, ptr %93, align 4
  br label %95

95:                                               ; preds = %116, %91
  %96 = phi i32 [ %117, %116 ], [ 0, %91 ]
  %97 = phi i32 [ %.lcssa, %116 ], [ %94, %91 ]
  %98 = icmp slt i32 %96, %22
  br i1 %98, label %99, label %118

99:                                               ; preds = %95
  %100 = add i32 %84, %96
  %101 = mul i32 %100, %17
  %invariant.op4 = add i32 %89, %101
  %102 = mul i32 %96, %24
  br label %103

103:                                              ; preds = %107, %99
  %104 = phi i32 [ %115, %107 ], [ 0, %99 ]
  %105 = phi i32 [ %114, %107 ], [ %97, %99 ]
  %106 = icmp slt i32 %104, %23
  br i1 %106, label %107, label %116

107:                                              ; preds = %103
  %.reass5 = add i32 %104, %invariant.op4
  %108 = getelementptr i32, ptr %13, i32 %.reass5
  %109 = load i32, ptr %108, align 4
  %110 = add i32 %102, %104
  %111 = getelementptr i32, ptr %20, i32 %110
  %112 = load i32, ptr %111, align 4
  %113 = mul i32 %109, %112
  %114 = add i32 %105, %113
  %115 = add i32 %104, 1
  br label %103

116:                                              ; preds = %103
  %.lcssa = phi i32 [ %105, %103 ]
  %117 = add i32 %96, 1
  br label %95

118:                                              ; preds = %95
  %.lcssa1 = phi i32 [ %97, %95 ]
  store i32 %.lcssa1, ptr %93, align 4
  %119 = add i32 %89, 1
  br label %88

120:                                              ; preds = %88
  %121 = add i32 %84, 1
  br label %83

122:                                              ; preds = %83
  ret void
}

declare <16 x i32> @llvm.arc.vvcadd.init.acc.w.v512(<16 x i32>, <16 x i32>)

declare <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32>)

declare <16 x i32> @llvm.arc.vvcmac.lo.acc.w.v512(<16 x i32>, <16 x i32>, <16 x i32>)

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
