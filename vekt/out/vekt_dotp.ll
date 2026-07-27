; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target datalayout = "e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-f64:32-v64:32-v128:32-a:0:32-v256:32-v512:32-n8:16:32"
target triple = "arc-pc-unknown-gnu"

define i32 @dotp(ptr %0, ptr %1, i32 %2, i32 %3, i32 %4, ptr %5, ptr %6, i32 %7, i32 %8, i32 %9, i32 %10) {
  %12 = call <16 x i32> @llvm.arc.vvcmpy.lo.acc.w.v512(<16 x i32> zeroinitializer, <16 x i32> zeroinitializer)
  %13 = ptrtoint ptr %1 to i32
  %14 = inttoptr i32 %13 to ptr addrspace(4)
  %15 = ptrtoint ptr %6 to i32
  %16 = inttoptr i32 %15 to ptr addrspace(4)
  %17 = icmp slt i32 %3, 0
  %18 = sub i32 -1, %3
  %19 = select i1 %17, i32 %18, i32 %3
  %20 = sdiv i32 %19, 16
  %21 = sub i32 -1, %20
  %22 = select i1 %17, i32 %21, i32 %20
  %23 = mul nsw i32 %22, 16
  br label %24

24:                                               ; preds = %28, %11
  %25 = phi i32 [ %34, %28 ], [ 0, %11 ]
  %26 = phi <16 x i32> [ %33, %28 ], [ %12, %11 ]
  %27 = icmp slt i32 %25, %23
  br i1 %27, label %28, label %35

28:                                               ; preds = %24
  %29 = getelementptr i32, ptr addrspace(4) %14, i32 %25
  %30 = getelementptr i32, ptr addrspace(4) %16, i32 %25
  %31 = call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %29)
  %32 = call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %30)
  %33 = call <16 x i32> @llvm.arc.vvcmac.lo.acc.w.v512(<16 x i32> %26, <16 x i32> %31, <16 x i32> %32)
  %34 = add i32 %25, 16
  br label %24

35:                                               ; preds = %24
  %36 = call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %26)
  br label %37

37:                                               ; preds = %41, %35
  %38 = phi i32 [ %48, %41 ], [ %23, %35 ]
  %39 = phi i32 [ %47, %41 ], [ %36, %35 ]
  %40 = icmp slt i32 %38, %3
  br i1 %40, label %41, label %49

41:                                               ; preds = %37
  %42 = getelementptr i32, ptr %1, i32 %38
  %43 = load i32, ptr %42, align 4
  %44 = getelementptr i32, ptr %6, i32 %38
  %45 = load i32, ptr %44, align 4
  %46 = mul i32 %43, %45
  %47 = add i32 %39, %46
  %48 = add i32 %38, 1
  br label %37

49:                                               ; preds = %37
  ret i32 %39
}

declare <16 x i32> @llvm.arc.vvcmpy.lo.acc.w.v512(<16 x i32>, <16 x i32>)

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.add.v16i32(<16 x i32>) #0

declare <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4))

declare <16 x i32> @llvm.arc.vvcmac.lo.acc.w.v512(<16 x i32>, <16 x i32>, <16 x i32>)

attributes #0 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
