; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define void @vekt_vec_sum(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4, ptr %5, ptr %6, i64 %7, i64 %8, i64 %9, ptr %10, ptr %11, i64 %12, i64 %13, i64 %14, i32 %15) {
  %17 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } poison, ptr %10, 0
  %18 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %17, ptr %11, 1
  %19 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %18, i64 %12, 2
  %20 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %19, i64 %13, 3, 0
  %21 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } poison, ptr %5, 0
  %22 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %21, ptr %6, 1
  %23 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %22, i64 %7, 2
  %24 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %23, i64 %8, 3, 0
  %25 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } poison, ptr %0, 0
  %26 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %25, ptr %1, 1
  %27 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %26, i64 %2, 2
  %28 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %27, i64 %3, 3, 0
  %29 = sext i32 %15 to i64
  br label %30

30:                                               ; preds = %33, %16
  %31 = phi i64 [ %67, %33 ], [ 0, %16 ]
  %32 = icmp slt i64 %31, %29
  br i1 %32, label %33, label %68

33:                                               ; preds = %30
  %34 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %28, 3
  %35 = alloca [1 x i64], i64 1, align 8
  store [1 x i64] %34, ptr %35, align 4
  %36 = getelementptr [1 x i64], ptr %35, i32 0, i32 0
  %37 = load i64, ptr %36, align 4
  %38 = sub i64 %37, %31
  %39 = trunc i64 %38 to i32
  %40 = insertelement <16 x i32> poison, i32 %39, i32 0
  %41 = shufflevector <16 x i32> %40, <16 x i32> poison, <16 x i32> zeroinitializer
  %42 = icmp sgt <16 x i32> %41, <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %43 = getelementptr i32, ptr %1, i64 %31
  %44 = call <16 x i32> @llvm.masked.load.v16i32.p0(ptr align 4 %43, <16 x i1> %42, <16 x i32> poison)
  %45 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %24, 3
  %46 = alloca [1 x i64], i64 1, align 8
  store [1 x i64] %45, ptr %46, align 4
  %47 = getelementptr [1 x i64], ptr %46, i32 0, i32 0
  %48 = load i64, ptr %47, align 4
  %49 = sub i64 %48, %31
  %50 = trunc i64 %49 to i32
  %51 = insertelement <16 x i32> poison, i32 %50, i32 0
  %52 = shufflevector <16 x i32> %51, <16 x i32> poison, <16 x i32> zeroinitializer
  %53 = icmp sgt <16 x i32> %52, <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %54 = getelementptr i32, ptr %6, i64 %31
  %55 = call <16 x i32> @llvm.masked.load.v16i32.p0(ptr align 4 %54, <16 x i1> %53, <16 x i32> poison)
  %56 = add <16 x i32> %44, %55
  %57 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %20, 3
  %58 = alloca [1 x i64], i64 1, align 8
  store [1 x i64] %57, ptr %58, align 4
  %59 = getelementptr [1 x i64], ptr %58, i32 0, i32 0
  %60 = load i64, ptr %59, align 4
  %61 = sub i64 %60, %31
  %62 = trunc i64 %61 to i32
  %63 = insertelement <16 x i32> poison, i32 %62, i32 0
  %64 = shufflevector <16 x i32> %63, <16 x i32> poison, <16 x i32> zeroinitializer
  %65 = icmp sgt <16 x i32> %64, <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %66 = getelementptr i32, ptr %11, i64 %31
  call void @llvm.masked.store.v16i32.p0(<16 x i32> %56, ptr align 4 %66, <16 x i1> %65)
  %67 = add i64 %31, 16
  br label %30

68:                                               ; preds = %30
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare <16 x i32> @llvm.masked.load.v16i32.p0(ptr captures(none), <16 x i1>, <16 x i32>) #0

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.masked.store.v16i32.p0(<16 x i32>, ptr captures(none), <16 x i1>) #1

attributes #0 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: write) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
