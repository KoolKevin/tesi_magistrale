; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define void @vekt_vec_sum(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4, ptr %5, ptr %6, i64 %7, i64 %8, i64 %9, ptr %10, ptr %11, i64 %12, i64 %13, i64 %14, i32 %15) {
  %17 = sext i32 %15 to i64
  br label %18

18:                                               ; preds = %21, %16
  %19 = phi i64 [ %43, %21 ], [ 0, %16 ]
  %20 = icmp slt i64 %19, %17
  br i1 %20, label %21, label %44

21:                                               ; preds = %18
  %22 = sub i64 %3, %19
  %23 = trunc i64 %22 to i32
  %24 = insertelement <16 x i32> undef, i32 %23, i32 0
  %25 = shufflevector <16 x i32> %24, <16 x i32> undef, <16 x i32> zeroinitializer
  %26 = icmp sgt <16 x i32> %25, <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %27 = getelementptr i32, ptr %1, i64 %19
  %28 = call <16 x i32> @llvm.masked.load.v16i32.p0(ptr %27, i32 4, <16 x i1> %26, <16 x i32> zeroinitializer)
  %29 = sub i64 %8, %19
  %30 = trunc i64 %29 to i32
  %31 = insertelement <16 x i32> undef, i32 %30, i32 0
  %32 = shufflevector <16 x i32> %31, <16 x i32> undef, <16 x i32> zeroinitializer
  %33 = icmp sgt <16 x i32> %32, <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %34 = getelementptr i32, ptr %6, i64 %19
  %35 = call <16 x i32> @llvm.masked.load.v16i32.p0(ptr %34, i32 4, <16 x i1> %33, <16 x i32> zeroinitializer)
  %36 = add <16 x i32> %28, %35
  %37 = sub i64 %13, %19
  %38 = trunc i64 %37 to i32
  %39 = insertelement <16 x i32> undef, i32 %38, i32 0
  %40 = shufflevector <16 x i32> %39, <16 x i32> undef, <16 x i32> zeroinitializer
  %41 = icmp sgt <16 x i32> %40, <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %42 = getelementptr i32, ptr %11, i64 %19
  call void @llvm.masked.store.v16i32.p0(<16 x i32> %36, ptr %42, i32 4, <16 x i1> %41)
  %43 = add i64 %19, 16
  br label %18

44:                                               ; preds = %18
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <16 x i32> @llvm.masked.load.v16i32.p0(ptr nocapture, i32 immarg, <16 x i1>, <16 x i32>) #0

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.masked.store.v16i32.p0(<16 x i32>, ptr nocapture, i32 immarg, <16 x i1>) #1

attributes #0 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}


