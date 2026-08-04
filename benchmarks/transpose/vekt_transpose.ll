; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target datalayout = "e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-f64:32-v64:32-v128:32-a:0:32-v256:32-v512:32-n8:16:32"
target triple = "arc-pc-unknown-gnu"

define void @vekt_transpose(i32 %0, i32 %1, ptr %2, ptr %3, i32 %4, i32 %5, i32 %6, i32 %7, i32 %8, ptr %9, ptr %10, i32 %11, i32 %12, i32 %13, i32 %14, i32 %15) {
  %17 = ptrtoint ptr %3 to i32
  %18 = inttoptr i32 %17 to ptr addrspace(4)
  %19 = ptrtoint ptr %10 to i32
  %20 = inttoptr i32 %19 to ptr addrspace(4)
  %21 = call <16 x i32> @llvm.arc.vvci.w.v512()
  %22 = mul i32 %5, 4
  %23 = insertelement <16 x i32> undef, i32 %22, i32 0
  %24 = shufflevector <16 x i32> %23, <16 x i32> undef, <16 x i32> zeroinitializer
  %25 = mul <16 x i32> %21, %24
  %26 = icmp slt i32 %6, 0
  %27 = sub i32 -1, %6
  %28 = select i1 %26, i32 %27, i32 %6
  %29 = sdiv i32 %28, 16
  %30 = sub i32 -1, %29
  %31 = select i1 %26, i32 %30, i32 %29
  %32 = mul nsw i32 %31, 16
  br label %33

33:                                               ; preds = %49, %16
  %34 = phi i32 [ %50, %49 ], [ 0, %16 ]
  %35 = icmp slt i32 %34, %5
  br i1 %35, label %36, label %51

36:                                               ; preds = %33
  %37 = mul i32 %34, %6
  br label %38

38:                                               ; preds = %41, %36
  %39 = phi i32 [ %48, %41 ], [ 0, %36 ]
  %40 = icmp slt i32 %39, %32
  br i1 %40, label %41, label %49

41:                                               ; preds = %38
  %42 = add i32 %37, %39
  %43 = getelementptr i32, ptr addrspace(4) %18, i32 %42
  %44 = call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %43)
  %45 = mul i32 %39, %5
  %46 = add i32 %45, %34
  %47 = getelementptr i32, ptr addrspace(4) %20, i32 %46
  call void @llvm.arc.vscatter.int.v512(ptr addrspace(4) %47, <16 x i32> %25, <16 x i32> %44)
  %48 = add i32 %39, 16
  br label %38

49:                                               ; preds = %38
  %50 = add i32 %34, 1
  br label %33

51:                                               ; preds = %33
  br label %52

52:                                               ; preds = %68, %51
  %53 = phi i32 [ %69, %68 ], [ 0, %51 ]
  %54 = icmp slt i32 %53, %5
  br i1 %54, label %55, label %70

55:                                               ; preds = %52
  br label %56

56:                                               ; preds = %59, %55
  %57 = phi i32 [ %67, %59 ], [ %32, %55 ]
  %58 = icmp slt i32 %57, %6
  br i1 %58, label %59, label %68

59:                                               ; preds = %56
  %60 = mul i32 %53, %7
  %61 = add i32 %60, %57
  %62 = getelementptr i32, ptr %3, i32 %61
  %63 = load i32, ptr %62, align 4
  %64 = mul i32 %57, %14
  %65 = add i32 %64, %53
  %66 = getelementptr i32, ptr %10, i32 %65
  store i32 %63, ptr %66, align 4
  %67 = add i32 %57, 1
  br label %56

68:                                               ; preds = %56
  %69 = add i32 %53, 1
  br label %52

70:                                               ; preds = %52
  ret void
}

declare <16 x i32> @llvm.arc.vvci.w.v512()

declare <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4))

declare void @llvm.arc.vscatter.int.v512(ptr addrspace(4), <16 x i32>, <16 x i32>)

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
