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
  %33 = icmp slt i32 %9, 0
  %34 = sub i32 -1, %9
  %35 = select i1 %33, i32 %34, i32 %9
  %36 = sdiv i32 %35, 16
  %37 = sub i32 -1, %36
  %38 = select i1 %33, i32 %37, i32 %36
  %39 = mul nsw i32 %38, 16
  br label %40

40:                                               ; preds = %82, %26
  %41 = phi i32 [ %83, %82 ], [ 0, %26 ]
  %42 = icmp slt i32 %41, %8
  br i1 %42, label %43, label %84

43:                                               ; preds = %40
  %44 = mul i32 %41, %9
  br label %45

45:                                               ; preds = %79, %43
  %46 = phi i32 [ %81, %79 ], [ 0, %43 ]
  %47 = icmp slt i32 %46, %39
  br i1 %47, label %48, label %82

48:                                               ; preds = %45
  %49 = add i32 %44, %46
  %50 = getelementptr i32, ptr addrspace(4) %30, i32 %49
  %51 = call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %50)
  %52 = call <16 x i32> @llvm.arc.vvcadd.init.acc.w.v512(<16 x i32> %51, <16 x i32> zeroinitializer)
  br label %53

53:                                               ; preds = %77, %48
  %54 = phi i32 [ %78, %77 ], [ 0, %48 ]
  %55 = phi <16 x i32> [ %62, %77 ], [ %52, %48 ]
  %56 = icmp slt i32 %54, %22
  br i1 %56, label %57, label %79

57:                                               ; preds = %53
  %58 = add i32 %41, %54
  %59 = mul i32 %58, %32
  br label %60

60:                                               ; preds = %64, %57
  %61 = phi i32 [ %76, %64 ], [ 0, %57 ]
  %62 = phi <16 x i32> [ %75, %64 ], [ %55, %57 ]
  %63 = icmp slt i32 %61, %23
  br i1 %63, label %64, label %77

64:                                               ; preds = %60
  %65 = add i32 %46, %61
  %66 = add i32 %59, %65
  %67 = getelementptr i32, ptr addrspace(4) %28, i32 %66
  %68 = call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %67)
  %69 = mul i32 %54, %24
  %70 = add i32 %69, %61
  %71 = getelementptr i32, ptr %20, i32 %70
  %72 = load i32, ptr %71, align 4
  %73 = insertelement <16 x i32> undef, i32 %72, i32 0
  %74 = shufflevector <16 x i32> %73, <16 x i32> undef, <16 x i32> zeroinitializer
  %75 = call <16 x i32> @llvm.arc.vvcmac.lo.acc.w.v512(<16 x i32> %62, <16 x i32> %68, <16 x i32> %74)
  %76 = add i32 %61, 1
  br label %60

77:                                               ; preds = %60
  %78 = add i32 %54, 1
  br label %53

79:                                               ; preds = %53
  %80 = call <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32> %55)
  call void @llvm.arc.vvst.w.v512(<16 x i32> %80, ptr addrspace(4) %50)
  %81 = add i32 %46, 16
  br label %45

82:                                               ; preds = %45
  %83 = add i32 %41, 1
  br label %40

84:                                               ; preds = %40
  br label %85

85:                                               ; preds = %124, %84
  %86 = phi i32 [ %125, %124 ], [ 0, %84 ]
  %87 = icmp slt i32 %86, %8
  br i1 %87, label %88, label %126

88:                                               ; preds = %85
  br label %89

89:                                               ; preds = %122, %88
  %90 = phi i32 [ %123, %122 ], [ %39, %88 ]
  %91 = icmp slt i32 %90, %9
  br i1 %91, label %92, label %124

92:                                               ; preds = %89
  %93 = mul i32 %86, %10
  %94 = add i32 %93, %90
  %95 = getelementptr i32, ptr %6, i32 %94
  %96 = load i32, ptr %95, align 4
  br label %97

97:                                               ; preds = %120, %92
  %98 = phi i32 [ %121, %120 ], [ 0, %92 ]
  %99 = phi i32 [ %105, %120 ], [ %96, %92 ]
  %100 = icmp slt i32 %98, %22
  br i1 %100, label %101, label %122

101:                                              ; preds = %97
  %102 = add i32 %86, %98
  br label %103

103:                                              ; preds = %107, %101
  %104 = phi i32 [ %119, %107 ], [ 0, %101 ]
  %105 = phi i32 [ %118, %107 ], [ %99, %101 ]
  %106 = icmp slt i32 %104, %23
  br i1 %106, label %107, label %120

107:                                              ; preds = %103
  %108 = add i32 %90, %104
  %109 = mul i32 %102, %17
  %110 = add i32 %109, %108
  %111 = getelementptr i32, ptr %13, i32 %110
  %112 = load i32, ptr %111, align 4
  %113 = mul i32 %98, %24
  %114 = add i32 %113, %104
  %115 = getelementptr i32, ptr %20, i32 %114
  %116 = load i32, ptr %115, align 4
  %117 = mul i32 %112, %116
  %118 = add i32 %105, %117
  %119 = add i32 %104, 1
  br label %103

120:                                              ; preds = %103
  %121 = add i32 %98, 1
  br label %97

122:                                              ; preds = %97
  store i32 %99, ptr %95, align 4
  %123 = add i32 %90, 1
  br label %89

124:                                              ; preds = %89
  %125 = add i32 %86, 1
  br label %85

126:                                              ; preds = %85
  ret void
}

declare <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4))

declare <16 x i32> @llvm.arc.vvcadd.init.acc.w.v512(<16 x i32>, <16 x i32>)

declare <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32>)

declare void @llvm.arc.vvst.w.v512(<16 x i32>, ptr addrspace(4))

declare <16 x i32> @llvm.arc.vvcmac.lo.acc.w.v512(<16 x i32>, <16 x i32>, <16 x i32>)

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
