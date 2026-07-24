; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target datalayout = "e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-f64:32-v64:32-v128:32-a:0:32-v256:32-v512:32-n8:16:32"
target triple = "arc-pc-unknown-gnu"

define void @vekt_vec_sum(ptr %0, ptr %1, i32 %2, i32 %3, i32 %4, ptr %5, ptr %6, i32 %7, i32 %8, i32 %9, ptr %10, ptr %11, i32 %12, i32 %13, i32 %14, i32 %15) {
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
  %29 = mul nsw i32 %28, 16
  br label %30

30:                                               ; preds = %33, %16
  %31 = phi i32 [ %40, %33 ], [ 0, %16 ]
  %32 = icmp slt i32 %31, %29
  br i1 %32, label %33, label %41

33:                                               ; preds = %30
  %34 = getelementptr i32, ptr addrspace(4) %18, i32 %31
  %35 = getelementptr i32, ptr addrspace(4) %20, i32 %31
  %36 = getelementptr i32, ptr addrspace(4) %22, i32 %31
  %37 = call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %34)
  %38 = call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %35)
  %39 = call <16 x i32> @llvm.arc.vvadd.w.v512(<16 x i32> %37, <16 x i32> %38)
  call void @llvm.arc.vvst.w.v512(<16 x i32> %39, ptr addrspace(4) %36)
  %40 = add i32 %31, 16
  br label %30

41:                                               ; preds = %30
  br label %42

42:                                               ; preds = %45, %41
  %43 = phi i32 [ %52, %45 ], [ %29, %41 ]
  %44 = icmp slt i32 %43, %3
  br i1 %44, label %45, label %53

45:                                               ; preds = %42
  %46 = getelementptr i32, ptr %1, i32 %43
  %47 = load i32, ptr %46, align 4
  %48 = getelementptr i32, ptr %6, i32 %43
  %49 = load i32, ptr %48, align 4
  %50 = add i32 %47, %49
  %51 = getelementptr i32, ptr %11, i32 %43
  store i32 %50, ptr %51, align 4
  %52 = add i32 %43, 1
  br label %42

53:                                               ; preds = %42
  ret void
}

declare <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4))

declare <16 x i32> @llvm.arc.vvadd.w.v512(<16 x i32>, <16 x i32>)

declare void @llvm.arc.vvst.w.v512(<16 x i32>, ptr addrspace(4))

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
