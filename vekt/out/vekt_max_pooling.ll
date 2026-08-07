; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target datalayout = "e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-f64:32-v64:32-v128:32-a:0:32-v256:32-v512:32-n8:16:32"
target triple = "arc-pc-unknown-gnu"

define void @max_pooling(i32 %0, i32 %1, i32 %2, i32 %3, i32 %4, ptr %5, ptr %6, i32 %7, i32 %8, i32 %9, i32 %10, i32 %11, ptr %12, ptr %13, i32 %14, i32 %15, i32 %16, i32 %17, i32 %18) {
  %20 = ptrtoint ptr %13 to i32
  %21 = inttoptr i32 %20 to ptr addrspace(4)
  %22 = ptrtoint ptr %6 to i32
  %23 = inttoptr i32 %22 to ptr addrspace(4)
  %24 = mul i32 %9, %4
  %25 = call <16 x i32> @llvm.arc.vvci.w.v512()
  %26 = mul i32 %4, 4
  %27 = insertelement <16 x i32> undef, i32 %26, i32 0
  %28 = shufflevector <16 x i32> %27, <16 x i32> undef, <16 x i32> zeroinitializer
  %29 = mul <16 x i32> %25, %28
  %30 = icmp slt i32 %9, 0
  %31 = sub i32 -1, %9
  %32 = select i1 %30, i32 %31, i32 %9
  %33 = sdiv i32 %32, 16
  %34 = sub i32 -1, %33
  %35 = select i1 %30, i32 %34, i32 %33
  %36 = mul nsw i32 %35, 16
  br label %37

37:                                               ; preds = %75, %19
  %38 = phi i32 [ %76, %75 ], [ 0, %19 ]
  %39 = icmp slt i32 %38, %8
  br i1 %39, label %40, label %77

40:                                               ; preds = %37
  %41 = mul i32 %38, %9
  %42 = mul i32 %38, %4
  br label %43

43:                                               ; preds = %72, %40
  %44 = phi i32 [ %74, %72 ], [ 0, %40 ]
  %45 = icmp slt i32 %44, %36
  br i1 %45, label %46, label %75

46:                                               ; preds = %43
  %47 = add i32 %41, %44
  %48 = getelementptr i32, ptr addrspace(4) %23, i32 %47
  %49 = call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %48)
  %50 = call <16 x i32> @llvm.arc.vvcadd.init.acc.w.v512(<16 x i32> %49, <16 x i32> zeroinitializer)
  %51 = mul i32 %44, %4
  br label %52

52:                                               ; preds = %70, %46
  %53 = phi i32 [ %71, %70 ], [ 0, %46 ]
  %54 = phi <16 x i32> [ %61, %70 ], [ %50, %46 ]
  %55 = icmp slt i32 %53, %4
  br i1 %55, label %56, label %72

56:                                               ; preds = %52
  %57 = add i32 %42, %53
  %58 = mul i32 %57, %24
  br label %59

59:                                               ; preds = %63, %56
  %60 = phi i32 [ %69, %63 ], [ 0, %56 ]
  %61 = phi <16 x i32> [ %68, %63 ], [ %54, %56 ]
  %62 = icmp slt i32 %60, %4
  br i1 %62, label %63, label %70

63:                                               ; preds = %59
  %64 = add i32 %51, %60
  %65 = add i32 %58, %64
  %66 = getelementptr i32, ptr addrspace(4) %21, i32 %65
  %67 = call <16 x i32> @llvm.arc.vgather.int.v512(ptr addrspace(4) %66, <16 x i32> %29)
  %68 = call <16 x i32> @llvm.arc.vvcmax.acc.w.v512(<16 x i32> %61, <16 x i32> %67)
  %69 = add i32 %60, 1
  br label %59

70:                                               ; preds = %59
  %71 = add i32 %53, 1
  br label %52

72:                                               ; preds = %52
  %73 = call <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32> %54)
  call void @llvm.arc.vvst.w.v512(<16 x i32> %73, ptr addrspace(4) %48)
  %74 = add i32 %44, 16
  br label %43

75:                                               ; preds = %43
  %76 = add i32 %38, 1
  br label %37

77:                                               ; preds = %37
  br label %78

78:                                               ; preds = %114, %77
  %79 = phi i32 [ %115, %114 ], [ 0, %77 ]
  %80 = icmp slt i32 %79, %8
  br i1 %80, label %81, label %116

81:                                               ; preds = %78
  %82 = mul nsw i32 %79, %4
  br label %83

83:                                               ; preds = %112, %81
  %84 = phi i32 [ %113, %112 ], [ %36, %81 ]
  %85 = icmp slt i32 %84, %9
  br i1 %85, label %86, label %114

86:                                               ; preds = %83
  %87 = mul i32 %79, %10
  %88 = add i32 %87, %84
  %89 = getelementptr i32, ptr %6, i32 %88
  %90 = load i32, ptr %89, align 4
  %91 = mul nsw i32 %84, %4
  br label %92

92:                                               ; preds = %110, %86
  %93 = phi i32 [ %111, %110 ], [ 0, %86 ]
  %94 = phi i32 [ %100, %110 ], [ %90, %86 ]
  %95 = icmp slt i32 %93, %4
  br i1 %95, label %96, label %112

96:                                               ; preds = %92
  %97 = add i32 %82, %93
  br label %98

98:                                               ; preds = %102, %96
  %99 = phi i32 [ %109, %102 ], [ 0, %96 ]
  %100 = phi i32 [ %108, %102 ], [ %94, %96 ]
  %101 = icmp slt i32 %99, %4
  br i1 %101, label %102, label %110

102:                                              ; preds = %98
  %103 = add i32 %91, %99
  %104 = mul i32 %97, %17
  %105 = add i32 %104, %103
  %106 = getelementptr i32, ptr %13, i32 %105
  %107 = load i32, ptr %106, align 4
  %108 = call i32 @llvm.smax.i32(i32 %100, i32 %107)
  %109 = add i32 %99, 1
  br label %98

110:                                              ; preds = %98
  %111 = add i32 %93, 1
  br label %92

112:                                              ; preds = %92
  store i32 %94, ptr %89, align 4
  %113 = add i32 %84, 1
  br label %83

114:                                              ; preds = %83
  %115 = add i32 %79, 1
  br label %78

116:                                              ; preds = %78
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
