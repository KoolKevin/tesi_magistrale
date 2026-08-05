; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target datalayout = "e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-f64:32-v64:32-v128:32-a:0:32-v256:32-v512:32-n8:16:32"
target triple = "arc-pc-unknown-gnu"

define void @reduce_rows(i32 %0, i32 %1, ptr %2, ptr %3, i32 %4, i32 %5, i32 %6, i32 %7, i32 %8, ptr %9, ptr %10, i32 %11, i32 %12, i32 %13) {
  %15 = ptrtoint ptr %3 to i32
  %16 = inttoptr i32 %15 to ptr addrspace(4)
  %17 = call <16 x i32> @llvm.arc.vvcadd.init.acc.w.v512(<16 x i32> zeroinitializer, <16 x i32> zeroinitializer)
  %18 = icmp slt i32 %6, 0
  %19 = sub i32 -1, %6
  %20 = select i1 %18, i32 %19, i32 %6
  %21 = sdiv i32 %20, 16
  %22 = sub i32 -1, %21
  %23 = select i1 %18, i32 %22, i32 %21
  %24 = mul nsw i32 %23, 16
  br label %25

25:                                               ; preds = %53, %14
  %26 = phi i32 [ %55, %53 ], [ 0, %14 ]
  %27 = icmp slt i32 %26, %5
  br i1 %27, label %28, label %56

28:                                               ; preds = %25
  %29 = mul i32 %26, %6
  br label %30

30:                                               ; preds = %34, %28
  %31 = phi i32 [ %39, %34 ], [ 0, %28 ]
  %32 = phi <16 x i32> [ %38, %34 ], [ %17, %28 ]
  %33 = icmp slt i32 %31, %24
  br i1 %33, label %34, label %40

34:                                               ; preds = %30
  %35 = add i32 %29, %31
  %36 = getelementptr i32, ptr addrspace(4) %16, i32 %35
  %37 = call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %36)
  %38 = call <16 x i32> @llvm.arc.vvadd.w.v512(<16 x i32> %32, <16 x i32> %37)
  %39 = add i32 %31, 16
  br label %30

40:                                               ; preds = %30
  %41 = call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %32)
  br label %42

42:                                               ; preds = %46, %40
  %43 = phi i32 [ %52, %46 ], [ %24, %40 ]
  %44 = phi i32 [ %51, %46 ], [ %41, %40 ]
  %45 = icmp slt i32 %43, %6
  br i1 %45, label %46, label %53

46:                                               ; preds = %42
  %47 = mul i32 %26, %7
  %48 = add i32 %47, %43
  %49 = getelementptr i32, ptr %3, i32 %48
  %50 = load i32, ptr %49, align 4
  %51 = add i32 %44, %50
  %52 = add i32 %43, 1
  br label %42

53:                                               ; preds = %42
  %54 = getelementptr i32, ptr %10, i32 %26
  store i32 %44, ptr %54, align 4
  %55 = add i32 %26, 1
  br label %25

56:                                               ; preds = %25
  ret void
}

declare <16 x i32> @llvm.arc.vvcadd.init.acc.w.v512(<16 x i32>, <16 x i32>)

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.add.v16i32(<16 x i32>) #0

declare <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4))

declare <16 x i32> @llvm.arc.vvadd.w.v512(<16 x i32>, <16 x i32>)

attributes #0 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
