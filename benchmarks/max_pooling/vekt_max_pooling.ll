; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target datalayout = "e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-f64:32-v64:32-v128:32-a:0:32-v256:32-v512:32-n8:16:32"
target triple = "arc-pc-unknown-gnu"

declare i32 @printf(ptr, ...)
@.str_eccomi = private unnamed_addr constant [8 x i8] c"eccomi\0A\00", align 1

define void @vekt_max_pooling(i32 %0, i32 %1, i32 %2, i32 %3, i32 %4, ptr %5, ptr %6, i32 %7, i32 %8, i32 %9, i32 %10, i32 %11, ptr %12, ptr %13, i32 %14, i32 %15, i32 %16, i32 %17, i32 %18) {
  %20 = ptrtoint ptr %13 to i32
  %21 = inttoptr i32 %20 to ptr addrspace(4)
  %22 = ptrtoint ptr %6 to i32
  %23 = inttoptr i32 %22 to ptr addrspace(4)
  %24 = mul i32 %9, %4
  %25 = call <16 x i32> @llvm.arc.vvci.w.v512()
  %26 = insertelement <16 x i32> undef, i32 %4, i32 0
  %27 = shufflevector <16 x i32> %26, <16 x i32> undef, <16 x i32> zeroinitializer
  %28 = mul <16 x i32> %25, %27
  %29 = icmp slt i32 %9, 0
  %30 = sub i32 -1, %9
  %31 = select i1 %29, i32 %30, i32 %9
  %32 = sdiv i32 %31, 16
  %33 = sub i32 -1, %32
  %34 = select i1 %29, i32 %33, i32 %32
  %35 = mul nsw i32 %34, 16
  br label %36

36:                                               ; preds = %74, %19
  %37 = phi i32 [ %75, %74 ], [ 0, %19 ]
  %38 = icmp slt i32 %37, %8
  br i1 %38, label %39, label %76

39:                                               ; preds = %36
  %40 = mul i32 %37, %9
  %41 = mul i32 %37, %4
  br label %42

42:                                               ; preds = %71, %39
  %43 = phi i32 [ %73, %71 ], [ 0, %39 ]
  %44 = icmp slt i32 %43, %35
  br i1 %44, label %45, label %74

45:                                               ; preds = %42
  %46 = add i32 %40, %43
  %47 = getelementptr i32, ptr addrspace(4) %23, i32 %46
  %48 = call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %47)
  %49 = call <16 x i32> @llvm.arc.vvcadd.init.acc.w.v512(<16 x i32> %48, <16 x i32> zeroinitializer)
  %50 = mul i32 %43, %4
  br label %51

51:                                               ; preds = %69, %45
  %52 = phi i32 [ %70, %69 ], [ 0, %45 ]
  %53 = phi <16 x i32> [ %60, %69 ], [ %49, %45 ]
  %54 = icmp slt i32 %52, %4
  br i1 %54, label %55, label %71

55:                                               ; preds = %51
  %56 = add i32 %41, %52
  %57 = mul i32 %56, %24
  br label %58

58:                                               ; preds = %62, %55
  %59 = phi i32 [ %68, %62 ], [ 0, %55 ]
  %60 = phi <16 x i32> [ %67, %62 ], [ %53, %55 ]
  %61 = icmp slt i32 %59, %4
  br i1 %61, label %62, label %69

62:                                               ; preds = %58
  %63 = add i32 %50, %59
  %64 = add i32 %57, %63
  %65 = getelementptr i32, ptr addrspace(4) %21, i32 %64
  %66 = call <16 x i32> @llvm.arc.vgather.int.v512(ptr addrspace(4) %65, <16 x i32> %28)
  %67 = call <16 x i32> @llvm.arc.vvcmax.acc.w.v512(<16 x i32> %60, <16 x i32> %66)
  %68 = add i32 %59, 1
  br label %58

69:                                               ; preds = %58
  %70 = add i32 %52, 1
  br label %51

71:                                               ; preds = %51
  %72 = call <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32> %53)
  call void @llvm.arc.vvst.w.v512(<16 x i32> %72, ptr addrspace(4) %47)
  %73 = add i32 %43, 16
  br label %42

74:                                               ; preds = %42
  %75 = add i32 %37, 1
  br label %36

76:                                               ; preds = %36
  br label %77

77:                                               ; preds = %113, %76
  %78 = phi i32 [ %114, %113 ], [ 0, %76 ]
  %79 = icmp slt i32 %78, %8
  br i1 %79, label %80, label %115

80:                                               ; preds = %77
  %81 = mul nsw i32 %78, %4
  br label %82

82:                                               ; preds = %111, %80
  %83 = phi i32 [ %112, %111 ], [ %35, %80 ]
  %84 = icmp slt i32 %83, %9
  br i1 %84, label %85, label %113

85:                                               ; preds = %82
  %86 = mul i32 %78, %10
  %87 = add i32 %86, %83
  %88 = getelementptr i32, ptr %6, i32 %87
  %89 = load i32, ptr %88, align 4
  %90 = mul nsw i32 %83, %4
  br label %91

91:                                               ; preds = %109, %85
  %92 = phi i32 [ %110, %109 ], [ 0, %85 ]
  %93 = phi i32 [ %99, %109 ], [ %89, %85 ]
  %94 = icmp slt i32 %92, %4
  br i1 %94, label %95, label %111

95:                                               ; preds = %91
  %96 = add i32 %81, %92
  br label %97

97:                                               ; preds = %101, %95
  %98 = phi i32 [ %108, %101 ], [ 0, %95 ]
  %99 = phi i32 [ %107, %101 ], [ %93, %95 ]
  %100 = icmp slt i32 %98, %4
  br i1 %100, label %101, label %109

101:                                              ; preds = %97
  %102 = add i32 %90, %98
  %103 = mul i32 %96, %17
  %104 = add i32 %103, %102
  %105 = getelementptr i32, ptr %13, i32 %104
  %106 = load i32, ptr %105, align 4
  %107 = call i32 @llvm.smax.i32(i32 %99, i32 %106)
  %108 = add i32 %98, 1
  br label %97

109:                                              ; preds = %97
  %110 = add i32 %92, 1
  br label %91

111:                                              ; preds = %91
  store i32 %93, ptr %88, align 4
  %112 = add i32 %83, 1
  br label %82

113:                                              ; preds = %82
  %114 = add i32 %78, 1
  br label %77

115:                                              ; preds = %77
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
