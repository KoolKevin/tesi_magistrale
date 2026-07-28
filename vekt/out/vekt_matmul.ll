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

29:                                               ; preds = %68, %24
  %30 = phi i32 [ %69, %68 ], [ 0, %24 ]
  %31 = icmp slt i32 %30, %6
  br i1 %31, label %32, label %70

32:                                               ; preds = %29
  %33 = icmp slt i32 %14, 0
  %34 = sub i32 -1, %14
  %35 = select i1 %33, i32 %34, i32 %14
  %36 = sdiv i32 %35, 16
  %37 = sub i32 -1, %36
  %38 = select i1 %33, i32 %37, i32 %36
  %39 = mul nsw i32 %38, 16
  br label %40

40:                                               ; preds = %62, %32
  %41 = phi i32 [ %67, %62 ], [ 0, %32 ]
  %42 = icmp slt i32 %41, %39
  br i1 %42, label %43, label %68

43:                                               ; preds = %40
  %44 = call <16 x i32> @llvm.arc.vvcmpy.lo.acc.w.v512(<16 x i32> zeroinitializer, <16 x i32> zeroinitializer)
  br label %45

45:                                               ; preds = %49, %43
  %46 = phi i32 [ %61, %49 ], [ 0, %43 ]
  %47 = phi <16 x i32> [ %60, %49 ], [ %44, %43 ]
  %48 = icmp slt i32 %46, %7
  br i1 %48, label %49, label %62

49:                                               ; preds = %45
  %50 = mul i32 %46, %14
  %51 = add i32 %50, %41
  %52 = getelementptr i32, ptr addrspace(4) %26, i32 %51
  %53 = call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %52)
  %54 = mul i32 %30, %8
  %55 = add i32 %54, %46
  %56 = getelementptr i32, ptr %4, i32 %55
  %57 = load i32, ptr %56, align 4
  %58 = insertelement <16 x i32> undef, i32 %57, i32 0
  %59 = shufflevector <16 x i32> %58, <16 x i32> undef, <16 x i32> zeroinitializer
  %60 = call <16 x i32> @llvm.arc.vvcmac.lo.acc.w.v512(<16 x i32> %47, <16 x i32> %53, <16 x i32> %59)
  %61 = add i32 %46, 1
  br label %45

62:                                               ; preds = %45
  %63 = call <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32> %47)
  %64 = mul i32 %30, %14
  %65 = add i32 %64, %41
  %66 = getelementptr i32, ptr addrspace(4) %28, i32 %65
  call void @llvm.arc.vvst.w.v512(<16 x i32> %63, ptr addrspace(4) %66)
  %67 = add i32 %41, 16
  br label %40

68:                                               ; preds = %40
  %69 = add i32 %30, 1
  br label %29

70:                                               ; preds = %29
  br label %71

71:                                               ; preds = %107, %70
  %72 = phi i32 [ %108, %107 ], [ 0, %70 ]
  %73 = icmp slt i32 %72, %6
  br i1 %73, label %74, label %109

74:                                               ; preds = %71
  %75 = icmp slt i32 %14, 0
  %76 = sub i32 -1, %14
  %77 = select i1 %75, i32 %76, i32 %14
  %78 = sdiv i32 %77, 16
  %79 = sub i32 -1, %78
  %80 = select i1 %75, i32 %79, i32 %78
  %81 = mul nsw i32 %80, 16
  br label %82

82:                                               ; preds = %102, %74
  %83 = phi i32 [ %106, %102 ], [ %81, %74 ]
  %84 = icmp slt i32 %83, %14
  br i1 %84, label %85, label %107

85:                                               ; preds = %82
  br label %86

86:                                               ; preds = %90, %85
  %87 = phi i32 [ %101, %90 ], [ 0, %85 ]
  %88 = phi i32 [ %100, %90 ], [ 0, %85 ]
  %89 = icmp slt i32 %87, %7
  br i1 %89, label %90, label %102

90:                                               ; preds = %86
  %91 = mul i32 %72, %8
  %92 = add i32 %91, %87
  %93 = getelementptr i32, ptr %4, i32 %92
  %94 = load i32, ptr %93, align 4
  %95 = mul i32 %87, %15
  %96 = add i32 %95, %83
  %97 = getelementptr i32, ptr %11, i32 %96
  %98 = load i32, ptr %97, align 4
  %99 = mul i32 %94, %98
  %100 = add i32 %88, %99
  %101 = add i32 %87, 1
  br label %86

102:                                              ; preds = %86
  %103 = mul i32 %72, %22
  %104 = add i32 %103, %83
  %105 = getelementptr i32, ptr %18, i32 %104
  store i32 %88, ptr %105, align 4
  %106 = add i32 %83, 1
  br label %82

107:                                              ; preds = %82
  %108 = add i32 %72, 1
  br label %71

109:                                              ; preds = %71
  ret void
}

declare <16 x i32> @llvm.arc.vvcmpy.lo.acc.w.v512(<16 x i32>, <16 x i32>)

declare <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32>)

declare void @llvm.arc.vvst.w.v512(<16 x i32>, ptr addrspace(4))

declare <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4))

declare <16 x i32> @llvm.arc.vvcmac.lo.acc.w.v512(<16 x i32>, <16 x i32>, <16 x i32>)

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
