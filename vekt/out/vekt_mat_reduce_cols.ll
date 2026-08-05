; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target datalayout = "e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-f64:32-v64:32-v128:32-a:0:32-v256:32-v512:32-n8:16:32"
target triple = "arc-pc-unknown-gnu"

define void @reduce_cols(i32 %0, i32 %1, ptr %2, ptr %3, i32 %4, i32 %5, i32 %6, i32 %7, i32 %8, ptr %9, ptr %10, i32 %11, i32 %12, i32 %13) {
  %15 = ptrtoint ptr %3 to i32
  %16 = inttoptr i32 %15 to ptr addrspace(4)
  %17 = ptrtoint ptr %10 to i32
  %18 = inttoptr i32 %17 to ptr addrspace(4)
  %19 = icmp slt i32 %6, 0
  %20 = sub i32 -1, %6
  %21 = select i1 %19, i32 %20, i32 %6
  %22 = sdiv i32 %21, 16
  %23 = sub i32 -1, %22
  %24 = select i1 %19, i32 %23, i32 %22
  %25 = mul nsw i32 %24, 16
  br label %26

26:                                               ; preds = %41, %14
  %27 = phi i32 [ %43, %41 ], [ 0, %14 ]
  %28 = icmp slt i32 %27, %25
  br i1 %28, label %29, label %44

29:                                               ; preds = %26
  br label %30

30:                                               ; preds = %34, %29
  %31 = phi i32 [ %40, %34 ], [ 0, %29 ]
  %32 = phi <16 x i32> [ %39, %34 ], [ zeroinitializer, %29 ]
  %33 = icmp slt i32 %31, %5
  br i1 %33, label %34, label %41

34:                                               ; preds = %30
  %35 = mul i32 %31, %6
  %36 = add i32 %35, %27
  %37 = getelementptr i32, ptr addrspace(4) %16, i32 %36
  %38 = call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %37)
  %39 = call <16 x i32> @llvm.arc.vvadd.w.v512(<16 x i32> %32, <16 x i32> %38)
  %40 = add i32 %31, 1
  br label %30

41:                                               ; preds = %30
  %42 = getelementptr i32, ptr addrspace(4) %18, i32 %27
  call void @llvm.arc.vvst.w.v512(<16 x i32> %32, ptr addrspace(4) %42)
  %43 = add i32 %27, 16
  br label %26

44:                                               ; preds = %26
  br label %45

45:                                               ; preds = %60, %44
  %46 = phi i32 [ %62, %60 ], [ %25, %44 ]
  %47 = icmp slt i32 %46, %6
  br i1 %47, label %48, label %63

48:                                               ; preds = %45
  br label %49

49:                                               ; preds = %53, %48
  %50 = phi i32 [ %59, %53 ], [ 0, %48 ]
  %51 = phi i32 [ %58, %53 ], [ 0, %48 ]
  %52 = icmp slt i32 %50, %5
  br i1 %52, label %53, label %60

53:                                               ; preds = %49
  %54 = mul i32 %50, %7
  %55 = add i32 %54, %46
  %56 = getelementptr i32, ptr %3, i32 %55
  %57 = load i32, ptr %56, align 4
  %58 = add i32 %51, %57
  %59 = add i32 %50, 1
  br label %49

60:                                               ; preds = %49
  %61 = getelementptr i32, ptr %10, i32 %46
  store i32 %51, ptr %61, align 4
  %62 = add i32 %46, 1
  br label %45

63:                                               ; preds = %45
  ret void
}

declare void @llvm.arc.vvst.w.v512(<16 x i32>, ptr addrspace(4))

declare <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4))

declare <16 x i32> @llvm.arc.vvadd.w.v512(<16 x i32>, <16 x i32>)

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
