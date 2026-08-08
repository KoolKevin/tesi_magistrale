; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target datalayout = "e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-f64:32-v64:32-v128:32-a:0:32-v256:32-v512:32-n8:16:32"
target triple = "arc-pc-unknown-gnu"

define void @vec_sum(ptr %0, ptr %1, i32 %2, i32 %3, i32 %4, ptr %5, ptr %6, i32 %7, i32 %8, i32 %9, ptr %10, ptr %11, i32 %12, i32 %13, i32 %14, i32 %15) {
  %17 = ptrtoint ptr %1 to i32
  %18 = inttoptr i32 %17 to ptr addrspace(4)
  %19 = ptrtoint ptr %6 to i32
  %20 = inttoptr i32 %19 to ptr addrspace(4)
  %21 = ptrtoint ptr %11 to i32
  %22 = inttoptr i32 %21 to ptr addrspace(4)
  %23 = icmp slt i32 %3, 0
  %24 = sub i32 -1, %3
  %25 = select i1 %23, i32 %24, i32 %3
  %26 = sdiv i32 %25, 16
  %27 = sub i32 -1, %26
  %28 = select i1 %23, i32 %27, i32 %26
  %29 = icmp slt i32 %28, 0
  %30 = sub i32 -1, %28
  %31 = select i1 %29, i32 %30, i32 %28
  %32 = sdiv i32 %31, 4
  %33 = sub i32 -1, %32
  %34 = select i1 %29, i32 %33, i32 %32
  %35 = mul nsw i32 %34, 64
  br label %36

36:                                               ; preds = %39, %16
  %37 = phi i32 [ %67, %39 ], [ 0, %16 ]
  %38 = icmp slt i32 %37, %35
  br i1 %38, label %39, label %68

39:                                               ; preds = %36
  %40 = getelementptr i32, ptr addrspace(4) %18, i32 %37
  %41 = getelementptr i32, ptr addrspace(4) %20, i32 %37
  %42 = getelementptr i32, ptr addrspace(4) %22, i32 %37
  %43 = load <16 x i32>, ptr addrspace(4) %40, align 4
  %44 = load <16 x i32>, ptr addrspace(4) %41, align 4
  %45 = add <16 x i32> %43, %44
  store <16 x i32> %45, ptr addrspace(4) %42, align 4
  %46 = add i32 %37, 16
  %47 = getelementptr i32, ptr addrspace(4) %18, i32 %46
  %48 = getelementptr i32, ptr addrspace(4) %20, i32 %46
  %49 = getelementptr i32, ptr addrspace(4) %22, i32 %46
  %50 = load <16 x i32>, ptr addrspace(4) %47, align 4
  %51 = load <16 x i32>, ptr addrspace(4) %48, align 4
  %52 = add <16 x i32> %50, %51
  store <16 x i32> %52, ptr addrspace(4) %49, align 4
  %53 = add i32 %37, 32
  %54 = getelementptr i32, ptr addrspace(4) %18, i32 %53
  %55 = getelementptr i32, ptr addrspace(4) %20, i32 %53
  %56 = getelementptr i32, ptr addrspace(4) %22, i32 %53
  %57 = load <16 x i32>, ptr addrspace(4) %54, align 4
  %58 = load <16 x i32>, ptr addrspace(4) %55, align 4
  %59 = add <16 x i32> %57, %58
  store <16 x i32> %59, ptr addrspace(4) %56, align 4
  %60 = add i32 %37, 48
  %61 = getelementptr i32, ptr addrspace(4) %18, i32 %60
  %62 = getelementptr i32, ptr addrspace(4) %20, i32 %60
  %63 = getelementptr i32, ptr addrspace(4) %22, i32 %60
  %64 = load <16 x i32>, ptr addrspace(4) %61, align 4
  %65 = load <16 x i32>, ptr addrspace(4) %62, align 4
  %66 = add <16 x i32> %64, %65
  store <16 x i32> %66, ptr addrspace(4) %63, align 4
  %67 = add i32 %37, 64
  br label %36

68:                                               ; preds = %36
  %69 = mul nsw i32 %28, 16
  br label %70

70:                                               ; preds = %73, %68
  %71 = phi i32 [ %80, %73 ], [ %35, %68 ]
  %72 = icmp slt i32 %71, %69
  br i1 %72, label %73, label %81

73:                                               ; preds = %70
  %74 = getelementptr i32, ptr addrspace(4) %18, i32 %71
  %75 = getelementptr i32, ptr addrspace(4) %20, i32 %71
  %76 = getelementptr i32, ptr addrspace(4) %22, i32 %71
  %77 = load <16 x i32>, ptr addrspace(4) %74, align 4
  %78 = load <16 x i32>, ptr addrspace(4) %75, align 4
  %79 = add <16 x i32> %77, %78
  store <16 x i32> %79, ptr addrspace(4) %76, align 4
  %80 = add i32 %71, 16
  br label %70

81:                                               ; preds = %70
  %82 = sdiv i32 %25, 4
  %83 = sub i32 -1, %82
  %84 = select i1 %23, i32 %83, i32 %82
  %85 = mul nsw i32 %84, 4
  br label %86

86:                                               ; preds = %89, %81
  %87 = phi i32 [ %117, %89 ], [ %69, %81 ]
  %88 = icmp slt i32 %87, %85
  br i1 %88, label %89, label %118

89:                                               ; preds = %86
  %90 = getelementptr i32, ptr %1, i32 %87
  %91 = load i32, ptr %90, align 4
  %92 = getelementptr i32, ptr %6, i32 %87
  %93 = load i32, ptr %92, align 4
  %94 = add i32 %91, %93
  %95 = getelementptr i32, ptr %11, i32 %87
  store i32 %94, ptr %95, align 4
  %96 = add i32 %87, 1
  %97 = getelementptr i32, ptr %1, i32 %96
  %98 = load i32, ptr %97, align 4
  %99 = getelementptr i32, ptr %6, i32 %96
  %100 = load i32, ptr %99, align 4
  %101 = add i32 %98, %100
  %102 = getelementptr i32, ptr %11, i32 %96
  store i32 %101, ptr %102, align 4
  %103 = add i32 %87, 2
  %104 = getelementptr i32, ptr %1, i32 %103
  %105 = load i32, ptr %104, align 4
  %106 = getelementptr i32, ptr %6, i32 %103
  %107 = load i32, ptr %106, align 4
  %108 = add i32 %105, %107
  %109 = getelementptr i32, ptr %11, i32 %103
  store i32 %108, ptr %109, align 4
  %110 = add i32 %87, 3
  %111 = getelementptr i32, ptr %1, i32 %110
  %112 = load i32, ptr %111, align 4
  %113 = getelementptr i32, ptr %6, i32 %110
  %114 = load i32, ptr %113, align 4
  %115 = add i32 %112, %114
  %116 = getelementptr i32, ptr %11, i32 %110
  store i32 %115, ptr %116, align 4
  %117 = add i32 %87, 4
  br label %86

118:                                              ; preds = %86
  br label %119

119:                                              ; preds = %122, %118
  %120 = phi i32 [ %129, %122 ], [ %85, %118 ]
  %121 = icmp slt i32 %120, %3
  br i1 %121, label %122, label %130

122:                                              ; preds = %119
  %123 = getelementptr i32, ptr %1, i32 %120
  %124 = load i32, ptr %123, align 4
  %125 = getelementptr i32, ptr %6, i32 %120
  %126 = load i32, ptr %125, align 4
  %127 = add i32 %124, %126
  %128 = getelementptr i32, ptr %11, i32 %120
  store i32 %127, ptr %128, align 4
  %129 = add i32 %120, 1
  br label %119

130:                                              ; preds = %119
  ret void
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
