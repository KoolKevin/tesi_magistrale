; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define void @vec_sum(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4, ptr %5, ptr %6, i64 %7, i64 %8, i64 %9, ptr %10, ptr %11, i64 %12, i64 %13, i64 %14, i32 %15) {
  %17 = sext i32 %15 to i64
  br label %18

18:                                               ; preds = %21, %16
  %19 = phi i64 [ %34, %21 ], [ 0, %16 ]
  %20 = icmp slt i64 %19, %17
  br i1 %20, label %21, label %35

21:                                               ; preds = %18
  %22 = ptrtoint ptr %1 to i64
  %23 = inttoptr i64 %22 to ptr addrspace(4)
  %24 = getelementptr i32, ptr addrspace(4) %23, i64 %19
  %25 = call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %24)
  %26 = ptrtoint ptr %6 to i64
  %27 = inttoptr i64 %26 to ptr addrspace(4)
  %28 = getelementptr i32, ptr addrspace(4) %27, i64 %19
  %29 = call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %28)
  %30 = add <16 x i32> %25, %29
  %31 = ptrtoint ptr %11 to i64
  %32 = inttoptr i64 %31 to ptr addrspace(4)
  %33 = getelementptr i32, ptr addrspace(4) %32, i64 %19
  call void @llvm.arc.vvst.w.v512(<16 x i32> %30, ptr addrspace(4) %33)
  %34 = add i64 %19, 16
  br label %18

35:                                               ; preds = %18
  ret void
}

declare <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4))

declare void @llvm.arc.vvst.w.v512(<16 x i32>, ptr addrspace(4))

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
