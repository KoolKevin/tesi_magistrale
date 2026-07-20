; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define void @vekt_vec_sum(ptr %0, ptr addrspace(4) %1, i64 %2, i64 %3, i64 %4, ptr %5, ptr addrspace(4) %6, i64 %7, i64 %8, i64 %9, ptr %10, ptr addrspace(4) %11, i64 %12, i64 %13, i64 %14, i32 %15) {
  ; %17 = sext i32 %15 to i64 ; perchè n è sign-extended??
  %17 = add i32 %15, 0 ; creiamo un alias
  br label %18

18:                                               ; preds = %21, %16
  %19 = phi i32 [ %28, %21 ], [ 0, %16 ]
  %20 = icmp slt i32 %19, %17
  br i1 %20, label %21, label %29

21:                                               ; preds = %18
;   %22 = ptrtoint ptr %1 to i64
;   %23 = inttoptr i64 %22 to ptr addrspace(4)
  %22 = getelementptr i32, ptr addrspace(4) %1, i32 %19
  %23 = tail call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %22)
;   %26 = ptrtoint ptr %6 to i64
;   %27 = inttoptr i64 %26 to ptr addrspace(4)
  %24 = getelementptr i32, ptr addrspace(4) %6, i32 %19
  %25 = tail call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %24)

  %26 = add <16 x i32> %23, %25
  ; usare l'intrinseco non cambia niente
  ; %26 = tail call <16 x i32> @llvm.arc.vvadd.w.v512(<16 x i32> %0, <16 x i32> %1)

;   %31 = ptrtoint ptr %11 to i64
;   %32 = inttoptr i64 %31 to ptr addrspace(4)
  %27 = getelementptr i32, ptr addrspace(4) %11, i32 %19
  tail call void @llvm.arc.vvst.w.v512(<16 x i32> %26, ptr addrspace(4) %27)
  %28 = add i32 %19, 16
  br label %18

29:                                               ; preds = %18
  ret void
}

declare <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4))

declare void @llvm.arc.vvst.w.v512(<16 x i32>, ptr addrspace(4))

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
