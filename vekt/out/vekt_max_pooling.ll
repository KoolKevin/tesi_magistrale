; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target datalayout = "e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-f64:32-v64:32-v128:32-a:0:32-v256:32-v512:32-n8:16:32"
target triple = "arc-pc-unknown-gnu"

define void @max_pooling(i32 %0, i32 %1, i32 %2, i32 %3, i32 %4, ptr %5, ptr %6, i32 %7, i32 %8, i32 %9, i32 %10, i32 %11, ptr %12, ptr %13, i32 %14, i32 %15, i32 %16, i32 %17, i32 %18) {
  br label %20

20:                                               ; preds = %32, %19
  %21 = phi i32 [ %33, %32 ], [ 0, %19 ]
  %22 = icmp slt i32 %21, %8
  br i1 %22, label %23, label %34

23:                                               ; preds = %20
  br label %24

24:                                               ; preds = %27, %23
  %25 = phi i32 [ %31, %27 ], [ 0, %23 ]
  %26 = icmp slt i32 %25, %9
  br i1 %26, label %27, label %32

27:                                               ; preds = %24
  %28 = mul i32 %21, %10
  %29 = add i32 %28, %25
  %30 = getelementptr i32, ptr %6, i32 %29
  store i32 -1, ptr %30, align 4
  %31 = add i32 %25, 1
  br label %24

32:                                               ; preds = %24
  %33 = add i32 %21, 1
  br label %20

34:                                               ; preds = %20
  %35 = ptrtoint ptr %13 to i32
  %36 = inttoptr i32 %35 to ptr addrspace(4)
  %37 = ptrtoint ptr %6 to i32
  %38 = inttoptr i32 %37 to ptr addrspace(4)
  %39 = mul i32 %9, %4
  %40 = call <16 x i32> @llvm.arc.vvci.w.v512()
  %41 = insertelement <16 x i32> undef, i32 %4, i32 0
  %42 = shufflevector <16 x i32> %41, <16 x i32> undef, <16 x i32> zeroinitializer
  %43 = mul <16 x i32> %40, %42
  %44 = icmp slt i32 %9, 0
  %45 = sub i32 -1, %9
  %46 = select i1 %44, i32 %45, i32 %9
  %47 = sdiv i32 %46, 16
  %48 = sub i32 -1, %47
  %49 = select i1 %44, i32 %48, i32 %47
  %50 = mul nsw i32 %49, 16
  br label %51

51:                                               ; preds = %89, %34
  %52 = phi i32 [ %90, %89 ], [ 0, %34 ]
  %53 = icmp slt i32 %52, %8
  br i1 %53, label %54, label %91

54:                                               ; preds = %51
  %55 = mul i32 %52, %9
  %56 = mul i32 %52, %4
  br label %57

57:                                               ; preds = %86, %54
  %58 = phi i32 [ %88, %86 ], [ 0, %54 ]
  %59 = icmp slt i32 %58, %50
  br i1 %59, label %60, label %89

60:                                               ; preds = %57
  %61 = add i32 %55, %58
  %62 = getelementptr i32, ptr addrspace(4) %38, i32 %61
  %63 = call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %62)
  %64 = call <16 x i32> @llvm.arc.vvcadd.init.acc.w.v512(<16 x i32> %63, <16 x i32> zeroinitializer)
  %65 = mul i32 %58, %4
  br label %66

66:                                               ; preds = %84, %60
  %67 = phi i32 [ %85, %84 ], [ 0, %60 ]
  %68 = phi <16 x i32> [ %75, %84 ], [ %64, %60 ]
  %69 = icmp slt i32 %67, %4
  br i1 %69, label %70, label %86

70:                                               ; preds = %66
  %71 = add i32 %56, %67
  %72 = mul i32 %71, %39
  br label %73

73:                                               ; preds = %77, %70
  %74 = phi i32 [ %83, %77 ], [ 0, %70 ]
  %75 = phi <16 x i32> [ %82, %77 ], [ %68, %70 ]
  %76 = icmp slt i32 %74, %4
  br i1 %76, label %77, label %84

77:                                               ; preds = %73
  %78 = add i32 %65, %74
  %79 = add i32 %72, %78
  %80 = getelementptr i32, ptr addrspace(4) %36, i32 %79
  %81 = call <16 x i32> @llvm.arc.vgather.int.v512(ptr addrspace(4) %80, <16 x i32> %43)
  %82 = call <16 x i32> @llvm.arc.vvcmax.acc.w.v512(<16 x i32> %75, <16 x i32> %81)
  %83 = add i32 %74, 1
  br label %73

84:                                               ; preds = %73
  %85 = add i32 %67, 1
  br label %66

86:                                               ; preds = %66
  %87 = call <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32> %68)
  call void @llvm.arc.vvst.w.v512(<16 x i32> %87, ptr addrspace(4) %62)
  %88 = add i32 %58, 16
  br label %57

89:                                               ; preds = %57
  %90 = add i32 %52, 1
  br label %51

91:                                               ; preds = %51
  br label %92

92:                                               ; preds = %128, %91
  %93 = phi i32 [ %129, %128 ], [ 0, %91 ]
  %94 = icmp slt i32 %93, %8
  br i1 %94, label %95, label %130

95:                                               ; preds = %92
  %96 = mul nsw i32 %93, %4
  br label %97

97:                                               ; preds = %126, %95
  %98 = phi i32 [ %127, %126 ], [ %50, %95 ]
  %99 = icmp slt i32 %98, %9
  br i1 %99, label %100, label %128

100:                                              ; preds = %97
  %101 = mul i32 %93, %10
  %102 = add i32 %101, %98
  %103 = getelementptr i32, ptr %6, i32 %102
  %104 = load i32, ptr %103, align 4
  %105 = mul nsw i32 %98, %4
  br label %106

106:                                              ; preds = %124, %100
  %107 = phi i32 [ %125, %124 ], [ 0, %100 ]
  %108 = phi i32 [ %114, %124 ], [ %104, %100 ]
  %109 = icmp slt i32 %107, %4
  br i1 %109, label %110, label %126

110:                                              ; preds = %106
  %111 = add i32 %96, %107
  br label %112

112:                                              ; preds = %116, %110
  %113 = phi i32 [ %123, %116 ], [ 0, %110 ]
  %114 = phi i32 [ %122, %116 ], [ %108, %110 ]
  %115 = icmp slt i32 %113, %4
  br i1 %115, label %116, label %124

116:                                              ; preds = %112
  %117 = add i32 %105, %113
  %118 = mul i32 %111, %17
  %119 = add i32 %118, %117
  %120 = getelementptr i32, ptr %13, i32 %119
  %121 = load i32, ptr %120, align 4
  %122 = call i32 @llvm.smax.i32(i32 %114, i32 %121)
  %123 = add i32 %113, 1
  br label %112

124:                                              ; preds = %112
  %125 = add i32 %107, 1
  br label %106

126:                                              ; preds = %106
  store i32 %108, ptr %103, align 4
  %127 = add i32 %98, 1
  br label %97

128:                                              ; preds = %97
  %129 = add i32 %93, 1
  br label %92

130:                                              ; preds = %92
  ret void
}

declare <16 x i32> @llvm.arc.vvci.w.v512()

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smax.i32(i32, i32) #0

declare <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4))

declare <16 x i32> @llvm.arc.vvcadd.init.acc.w.v512(<16 x i32>, <16 x i32>)

declare <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32>)

declare void @llvm.arc.vvst.w.v512(<16 x i32>, ptr addrspace(4))

declare <16 x i32> @llvm.arc.vgather.int.v512(ptr addrspace(4), <16 x i32>)

declare <16 x i32> @llvm.arc.vvcmax.acc.w.v512(<16 x i32>, <16 x i32>)

attributes #0 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
