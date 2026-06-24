; ModuleID = 'vec_sum.ll'
source_filename = "LLVMDialectModule"

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite)
define void @vec_sum(ptr readnone captures(none) %0, ptr readonly captures(none) %1, i64 %2, i64 %3, i64 %4, ptr readnone captures(none) %5, ptr readonly captures(none) %6, i64 %7, i64 %8, i64 %9, ptr readnone captures(none) %10, ptr writeonly captures(none) %11, i64 %12, i64 %13, i64 %14, i32 %15) local_unnamed_addr #0 {
  %17 = sext i32 %15 to i64
  %18 = icmp sgt i32 %15, 0
  br i1 %18, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %16, %.lr.ph
  %19 = phi i64 [ %41, %.lr.ph ], [ 0, %16 ]

  %20 = sub i64 %3, %19
  %21 = trunc i64 %20 to i32
  %22 = insertelement <16 x i32> poison, i32 %21, i64 0
  %23 = shufflevector <16 x i32> %22, <16 x i32> poison, <16 x i32> zeroinitializer
  %24 = icmp sgt <16 x i32> %23, <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %25 = getelementptr i32, ptr %1, i64 %19
  %26 = tail call <16 x i32> @llvm.masked.load.v16i32.p0(ptr align 4 %25, <16 x i1> %24, <16 x i32> poison)

  %27 = sub i64 %8, %19
  %28 = trunc i64 %27 to i32
  %29 = insertelement <16 x i32> poison, i32 %28, i64 0
  %30 = shufflevector <16 x i32> %29, <16 x i32> poison, <16 x i32> zeroinitializer
  %31 = icmp sgt <16 x i32> %30, <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %32 = getelementptr i32, ptr %6, i64 %19
  %33 = tail call <16 x i32> @llvm.masked.load.v16i32.p0(ptr align 4 %32, <16 x i1> %31, <16 x i32> poison)

  %34 = add <16 x i32> %33, %26

  %35 = sub i64 %13, %19
  %36 = trunc i64 %35 to i32
  %37 = insertelement <16 x i32> poison, i32 %36, i64 0
  %38 = shufflevector <16 x i32> %37, <16 x i32> poison, <16 x i32> zeroinitializer
  %39 = icmp sgt <16 x i32> %38, <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %40 = getelementptr i32, ptr %11, i64 %19
  tail call void @llvm.masked.store.v16i32.p0(<16 x i32> %34, ptr align 4 %40, <16 x i1> %39)

  %41 = add nuw nsw i64 %19, 16
  %42 = icmp slt i64 %41, %17
  br i1 %42, label %.lr.ph, label %._crit_edge

._crit_edge:                                      ; preds = %.lr.ph, %16
  ret void
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <16 x i32> @llvm.masked.load.v16i32.p0(ptr captures(none), <16 x i1>, <16 x i32>) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.masked.store.v16i32.p0(<16 x i32>, ptr captures(none), <16 x i1>) #2

attributes #0 = { nofree norecurse nosync nounwind memory(argmem: readwrite) }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #2 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: write) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
