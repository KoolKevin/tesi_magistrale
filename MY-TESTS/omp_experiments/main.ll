; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.ident_t = type { i32, i32, i32, i32, ptr }

@.str = private unnamed_addr constant [43 x i8] c"Tempo di esecuzione di vec_sum: %lu clock\0A\00", align 1
@0 = private unnamed_addr constant [20 x i8] c";main.c;main;38;1;;\00", align 1
@1 = private unnamed_addr constant %struct.ident_t { i32 0, i32 514, i32 0, i32 19, ptr @0 }, align 8
@2 = private unnamed_addr constant [21 x i8] c";main.c;main;38;55;;\00", align 1
@3 = private unnamed_addr constant %struct.ident_t { i32 0, i32 514, i32 0, i32 20, ptr @2 }, align 8
@4 = private unnamed_addr constant [21 x i8] c";main.c;main;38;31;;\00", align 1
@5 = private unnamed_addr constant %struct.ident_t { i32 0, i32 2, i32 0, i32 20, ptr @4 }, align 8
@6 = private unnamed_addr constant %struct.ident_t { i32 0, i32 2, i32 0, i32 19, ptr @0 }, align 8
@.str.2 = private unnamed_addr constant [47 x i8] c"Tempo di esecuzione di vec_sum_omp: %lu clock\0A\00", align 1
@.str.3 = private unnamed_addr constant [16 x i8] c"speedup: %.2fx\0A\00", align 1
@.str.5 = private unnamed_addr constant [30 x i8] c"a[%d]=%d, b[%d]=%d, c[%d]=%d\0A\00", align 1
@.str.6 = private unnamed_addr constant [52 x i8] c"Tempo di esecuzione di vec_sum_omp_mlir: %lu clock\0A\00", align 1
@str.7 = private unnamed_addr constant [30 x i8] c"Primi 5 elementi della somma:\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noundef i32 @main() local_unnamed_addr #0 !dbg !13 {
  %1 = alloca ptr, align 8
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = tail call i32 @__kmpc_global_thread_num(ptr nonnull @5), !dbg !16
  call void @llvm.lifetime.start.p0(ptr nonnull %1) #3, !dbg !17
  %5 = tail call noalias dereferenceable_or_null(16777216) ptr @malloc(i64 noundef 16777216) #9, !dbg !18
  store ptr %5, ptr %1, align 8, !dbg !19, !tbaa !20
  call void @llvm.lifetime.start.p0(ptr nonnull %2) #3, !dbg !23
  %6 = tail call noalias dereferenceable_or_null(16777216) ptr @malloc(i64 noundef 16777216) #9, !dbg !24
  store ptr %6, ptr %2, align 8, !dbg !25, !tbaa !20
  call void @llvm.lifetime.start.p0(ptr nonnull %3) #3, !dbg !26
  %7 = tail call noalias dereferenceable_or_null(16777216) ptr @malloc(i64 noundef 16777216) #9, !dbg !27
  store ptr %7, ptr %3, align 8, !dbg !28, !tbaa !20
  br label %8, !dbg !29

8:                                                ; preds = %8, %0
  %9 = phi i64 [ 0, %0 ], [ %16, %8 ], !dbg !30
  %10 = phi <16 x i64> [ <i64 0, i64 1, i64 2, i64 3, i64 4, i64 5, i64 6, i64 7, i64 8, i64 9, i64 10, i64 11, i64 12, i64 13, i64 14, i64 15>, %0 ], [ %17, %8 ]
  %11 = trunc <16 x i64> %10 to <16 x i8>, !dbg !31
  %12 = add <16 x i8> %11, splat (i8 1), !dbg !31
  %13 = getelementptr inbounds nuw i8, ptr %5, i64 %9, !dbg !32
  store <16 x i8> %12, ptr %13, align 1, !dbg !33, !tbaa !34
  %14 = getelementptr inbounds nuw i8, ptr %6, i64 %9, !dbg !35
  store <16 x i8> %12, ptr %14, align 1, !dbg !36, !tbaa !34
  %15 = getelementptr inbounds nuw i8, ptr %7, i64 %9, !dbg !37
  store <16 x i8> splat (i8 -1), ptr %15, align 1, !dbg !38, !tbaa !34
  %16 = add nuw i64 %9, 16, !dbg !30
  %17 = add nuw nsw <16 x i64> %10, splat (i64 16)
  %18 = icmp eq i64 %16, 16777216, !dbg !29
  br i1 %18, label %19, label %8, !dbg !29, !llvm.loop !39

19:                                               ; preds = %8
  %20 = tail call i64 @llvm.x86.rdtsc(), !dbg !43
  br label %21, !dbg !44

21:                                               ; preds = %21, %19
  %22 = phi i64 [ 0, %19 ], [ %48, %21 ], !dbg !45
  %23 = getelementptr inbounds nuw i8, ptr %5, i64 %22, !dbg !46
  %24 = getelementptr inbounds nuw i8, ptr %23, i64 16, !dbg !46
  %25 = load <16 x i8>, ptr %23, align 1, !dbg !46, !tbaa !34
  %26 = load <16 x i8>, ptr %24, align 1, !dbg !46, !tbaa !34
  %27 = getelementptr inbounds nuw i8, ptr %6, i64 %22, !dbg !47
  %28 = getelementptr inbounds nuw i8, ptr %27, i64 16, !dbg !47
  %29 = load <16 x i8>, ptr %27, align 1, !dbg !47, !tbaa !34
  %30 = load <16 x i8>, ptr %28, align 1, !dbg !47, !tbaa !34
  %31 = add <16 x i8> %29, %25, !dbg !48
  %32 = add <16 x i8> %30, %26, !dbg !48
  %33 = getelementptr inbounds nuw i8, ptr %7, i64 %22, !dbg !49
  %34 = getelementptr inbounds nuw i8, ptr %33, i64 16, !dbg !50
  store <16 x i8> %31, ptr %33, align 1, !dbg !50, !tbaa !34
  store <16 x i8> %32, ptr %34, align 1, !dbg !50, !tbaa !34
  %35 = or disjoint i64 %22, 32, !dbg !45
  %36 = getelementptr inbounds nuw i8, ptr %5, i64 %35, !dbg !46
  %37 = getelementptr inbounds nuw i8, ptr %36, i64 16, !dbg !46
  %38 = load <16 x i8>, ptr %36, align 1, !dbg !46, !tbaa !34
  %39 = load <16 x i8>, ptr %37, align 1, !dbg !46, !tbaa !34
  %40 = getelementptr inbounds nuw i8, ptr %6, i64 %35, !dbg !47
  %41 = getelementptr inbounds nuw i8, ptr %40, i64 16, !dbg !47
  %42 = load <16 x i8>, ptr %40, align 1, !dbg !47, !tbaa !34
  %43 = load <16 x i8>, ptr %41, align 1, !dbg !47, !tbaa !34
  %44 = add <16 x i8> %42, %38, !dbg !48
  %45 = add <16 x i8> %43, %39, !dbg !48
  %46 = getelementptr inbounds nuw i8, ptr %7, i64 %35, !dbg !49
  %47 = getelementptr inbounds nuw i8, ptr %46, i64 16, !dbg !50
  store <16 x i8> %44, ptr %46, align 1, !dbg !50, !tbaa !34
  store <16 x i8> %45, ptr %47, align 1, !dbg !50, !tbaa !34
  %48 = add nuw nsw i64 %22, 64, !dbg !45
  %49 = icmp eq i64 %48, 16777216, !dbg !44
  br i1 %49, label %50, label %21, !dbg !44, !llvm.loop !51

50:                                               ; preds = %21
  %51 = tail call i64 @llvm.x86.rdtsc(), !dbg !52
  %52 = sub i64 %51, %20, !dbg !53
  %53 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i64 noundef %52), !dbg !54
  %54 = tail call i32 @putchar(i32 10), !dbg !55
  br label %55, !dbg !56

55:                                               ; preds = %55, %50
  %56 = phi i64 [ 0, %50 ], [ %68, %55 ], !dbg !57
  %57 = getelementptr inbounds nuw i8, ptr %7, i64 %56, !dbg !58
  %58 = getelementptr inbounds nuw i8, ptr %57, i64 16, !dbg !59
  store <16 x i8> splat (i8 -1), ptr %57, align 1, !dbg !59, !tbaa !34
  store <16 x i8> splat (i8 -1), ptr %58, align 1, !dbg !59, !tbaa !34
  %59 = getelementptr inbounds nuw i8, ptr %7, i64 %56, !dbg !58
  %60 = getelementptr inbounds nuw i8, ptr %59, i64 32, !dbg !58
  %61 = getelementptr inbounds nuw i8, ptr %59, i64 48, !dbg !59
  store <16 x i8> splat (i8 -1), ptr %60, align 1, !dbg !59, !tbaa !34
  store <16 x i8> splat (i8 -1), ptr %61, align 1, !dbg !59, !tbaa !34
  %62 = getelementptr inbounds nuw i8, ptr %7, i64 %56, !dbg !58
  %63 = getelementptr inbounds nuw i8, ptr %62, i64 64, !dbg !58
  %64 = getelementptr inbounds nuw i8, ptr %62, i64 80, !dbg !59
  store <16 x i8> splat (i8 -1), ptr %63, align 1, !dbg !59, !tbaa !34
  store <16 x i8> splat (i8 -1), ptr %64, align 1, !dbg !59, !tbaa !34
  %65 = getelementptr inbounds nuw i8, ptr %7, i64 %56, !dbg !58
  %66 = getelementptr inbounds nuw i8, ptr %65, i64 96, !dbg !58
  %67 = getelementptr inbounds nuw i8, ptr %65, i64 112, !dbg !59
  store <16 x i8> splat (i8 -1), ptr %66, align 1, !dbg !59, !tbaa !34
  store <16 x i8> splat (i8 -1), ptr %67, align 1, !dbg !59, !tbaa !34
  %68 = add nuw nsw i64 %56, 128, !dbg !57
  %69 = icmp eq i64 %68, 16777216, !dbg !56
  br i1 %69, label %70, label %55, !dbg !56, !llvm.loop !60

70:                                               ; preds = %55
  %71 = tail call i64 @llvm.x86.rdtsc(), !dbg !61
  tail call void @__kmpc_push_num_threads(ptr nonnull @5, i32 %4, i32 8), !dbg !62
  call void (ptr, i32, ptr, ...) @__kmpc_fork_call(ptr nonnull @6, i32 3, ptr nonnull @main.omp_outlined, ptr nonnull %3, ptr nonnull %1, ptr nonnull %2), !dbg !62
  %72 = call i64 @llvm.x86.rdtsc(), !dbg !63
  %73 = sub i64 %72, %71, !dbg !64
  %74 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i64 noundef %73), !dbg !65
  %75 = uitofp i64 %52 to double, !dbg !66
  %76 = uitofp i64 %73 to double, !dbg !67
  %77 = fdiv double %75, %76, !dbg !68
  %78 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, double noundef %77), !dbg !69
  %79 = call i32 @puts(ptr nonnull dereferenceable(1) @str.7), !dbg !70
  %80 = load ptr, ptr %1, align 8, !dbg !71, !tbaa !20
  %81 = load i8, ptr %80, align 1, !dbg !71, !tbaa !34
  %82 = sext i8 %81 to i32, !dbg !71
  %83 = load ptr, ptr %2, align 8, !dbg !72, !tbaa !20
  %84 = load i8, ptr %83, align 1, !dbg !72, !tbaa !34
  %85 = sext i8 %84 to i32, !dbg !72
  %86 = load ptr, ptr %3, align 8, !dbg !73, !tbaa !20
  %87 = load i8, ptr %86, align 1, !dbg !73, !tbaa !34
  %88 = sext i8 %87 to i32, !dbg !73
  %89 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, i32 noundef 0, i32 noundef %82, i32 noundef 0, i32 noundef %85, i32 noundef 0, i32 noundef %88), !dbg !74
  %90 = load ptr, ptr %1, align 8, !dbg !71, !tbaa !20
  %91 = getelementptr inbounds nuw i8, ptr %90, i64 1, !dbg !71
  %92 = load i8, ptr %91, align 1, !dbg !71, !tbaa !34
  %93 = sext i8 %92 to i32, !dbg !71
  %94 = load ptr, ptr %2, align 8, !dbg !72, !tbaa !20
  %95 = getelementptr inbounds nuw i8, ptr %94, i64 1, !dbg !72
  %96 = load i8, ptr %95, align 1, !dbg !72, !tbaa !34
  %97 = sext i8 %96 to i32, !dbg !72
  %98 = load ptr, ptr %3, align 8, !dbg !73, !tbaa !20
  %99 = getelementptr inbounds nuw i8, ptr %98, i64 1, !dbg !73
  %100 = load i8, ptr %99, align 1, !dbg !73, !tbaa !34
  %101 = sext i8 %100 to i32, !dbg !73
  %102 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, i32 noundef 1, i32 noundef %93, i32 noundef 1, i32 noundef %97, i32 noundef 1, i32 noundef %101), !dbg !74
  %103 = load ptr, ptr %1, align 8, !dbg !71, !tbaa !20
  %104 = getelementptr inbounds nuw i8, ptr %103, i64 2, !dbg !71
  %105 = load i8, ptr %104, align 1, !dbg !71, !tbaa !34
  %106 = sext i8 %105 to i32, !dbg !71
  %107 = load ptr, ptr %2, align 8, !dbg !72, !tbaa !20
  %108 = getelementptr inbounds nuw i8, ptr %107, i64 2, !dbg !72
  %109 = load i8, ptr %108, align 1, !dbg !72, !tbaa !34
  %110 = sext i8 %109 to i32, !dbg !72
  %111 = load ptr, ptr %3, align 8, !dbg !73, !tbaa !20
  %112 = getelementptr inbounds nuw i8, ptr %111, i64 2, !dbg !73
  %113 = load i8, ptr %112, align 1, !dbg !73, !tbaa !34
  %114 = sext i8 %113 to i32, !dbg !73
  %115 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, i32 noundef 2, i32 noundef %106, i32 noundef 2, i32 noundef %110, i32 noundef 2, i32 noundef %114), !dbg !74
  %116 = load ptr, ptr %1, align 8, !dbg !71, !tbaa !20
  %117 = getelementptr inbounds nuw i8, ptr %116, i64 3, !dbg !71
  %118 = load i8, ptr %117, align 1, !dbg !71, !tbaa !34
  %119 = sext i8 %118 to i32, !dbg !71
  %120 = load ptr, ptr %2, align 8, !dbg !72, !tbaa !20
  %121 = getelementptr inbounds nuw i8, ptr %120, i64 3, !dbg !72
  %122 = load i8, ptr %121, align 1, !dbg !72, !tbaa !34
  %123 = sext i8 %122 to i32, !dbg !72
  %124 = load ptr, ptr %3, align 8, !dbg !73, !tbaa !20
  %125 = getelementptr inbounds nuw i8, ptr %124, i64 3, !dbg !73
  %126 = load i8, ptr %125, align 1, !dbg !73, !tbaa !34
  %127 = sext i8 %126 to i32, !dbg !73
  %128 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, i32 noundef 3, i32 noundef %119, i32 noundef 3, i32 noundef %123, i32 noundef 3, i32 noundef %127), !dbg !74
  %129 = load ptr, ptr %1, align 8, !dbg !71, !tbaa !20
  %130 = getelementptr inbounds nuw i8, ptr %129, i64 4, !dbg !71
  %131 = load i8, ptr %130, align 1, !dbg !71, !tbaa !34
  %132 = sext i8 %131 to i32, !dbg !71
  %133 = load ptr, ptr %2, align 8, !dbg !72, !tbaa !20
  %134 = getelementptr inbounds nuw i8, ptr %133, i64 4, !dbg !72
  %135 = load i8, ptr %134, align 1, !dbg !72, !tbaa !34
  %136 = sext i8 %135 to i32, !dbg !72
  %137 = load ptr, ptr %3, align 8, !dbg !73, !tbaa !20
  %138 = getelementptr inbounds nuw i8, ptr %137, i64 4, !dbg !73
  %139 = load i8, ptr %138, align 1, !dbg !73, !tbaa !34
  %140 = sext i8 %139 to i32, !dbg !73
  %141 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, i32 noundef 4, i32 noundef %132, i32 noundef 4, i32 noundef %136, i32 noundef 4, i32 noundef %140), !dbg !74
  %142 = call i32 @putchar(i32 10), !dbg !75
  br label %218, !dbg !76

143:                                              ; preds = %218
  %144 = call i64 @llvm.x86.rdtsc(), !dbg !77
  %145 = load ptr, ptr %1, align 8, !dbg !78, !tbaa !20
  %146 = load ptr, ptr %2, align 8, !dbg !79, !tbaa !20
  %147 = load ptr, ptr %3, align 8, !dbg !80, !tbaa !20
  call void @vec_sum_omp(ptr noundef %145, ptr noundef %146, ptr noundef %147, i64 noundef 16777216, i32 noundef 8) #3, !dbg !81
  %148 = call i64 @llvm.x86.rdtsc(), !dbg !82
  %149 = sub i64 %148, %144, !dbg !83
  %150 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.6, i64 noundef %149), !dbg !84
  %151 = uitofp i64 %149 to double, !dbg !85
  %152 = fdiv double %75, %151, !dbg !86
  %153 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, double noundef %152), !dbg !87
  %154 = call i32 @puts(ptr nonnull dereferenceable(1) @str.7), !dbg !88
  %155 = load ptr, ptr %1, align 8, !dbg !89, !tbaa !20
  %156 = load i8, ptr %155, align 1, !dbg !89, !tbaa !34
  %157 = sext i8 %156 to i32, !dbg !89
  %158 = load ptr, ptr %2, align 8, !dbg !90, !tbaa !20
  %159 = load i8, ptr %158, align 1, !dbg !90, !tbaa !34
  %160 = sext i8 %159 to i32, !dbg !90
  %161 = load ptr, ptr %3, align 8, !dbg !91, !tbaa !20
  %162 = load i8, ptr %161, align 1, !dbg !91, !tbaa !34
  %163 = sext i8 %162 to i32, !dbg !91
  %164 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, i32 noundef 0, i32 noundef %157, i32 noundef 0, i32 noundef %160, i32 noundef 0, i32 noundef %163), !dbg !92
  %165 = load ptr, ptr %1, align 8, !dbg !89, !tbaa !20
  %166 = getelementptr inbounds nuw i8, ptr %165, i64 1, !dbg !89
  %167 = load i8, ptr %166, align 1, !dbg !89, !tbaa !34
  %168 = sext i8 %167 to i32, !dbg !89
  %169 = load ptr, ptr %2, align 8, !dbg !90, !tbaa !20
  %170 = getelementptr inbounds nuw i8, ptr %169, i64 1, !dbg !90
  %171 = load i8, ptr %170, align 1, !dbg !90, !tbaa !34
  %172 = sext i8 %171 to i32, !dbg !90
  %173 = load ptr, ptr %3, align 8, !dbg !91, !tbaa !20
  %174 = getelementptr inbounds nuw i8, ptr %173, i64 1, !dbg !91
  %175 = load i8, ptr %174, align 1, !dbg !91, !tbaa !34
  %176 = sext i8 %175 to i32, !dbg !91
  %177 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, i32 noundef 1, i32 noundef %168, i32 noundef 1, i32 noundef %172, i32 noundef 1, i32 noundef %176), !dbg !92
  %178 = load ptr, ptr %1, align 8, !dbg !89, !tbaa !20
  %179 = getelementptr inbounds nuw i8, ptr %178, i64 2, !dbg !89
  %180 = load i8, ptr %179, align 1, !dbg !89, !tbaa !34
  %181 = sext i8 %180 to i32, !dbg !89
  %182 = load ptr, ptr %2, align 8, !dbg !90, !tbaa !20
  %183 = getelementptr inbounds nuw i8, ptr %182, i64 2, !dbg !90
  %184 = load i8, ptr %183, align 1, !dbg !90, !tbaa !34
  %185 = sext i8 %184 to i32, !dbg !90
  %186 = load ptr, ptr %3, align 8, !dbg !91, !tbaa !20
  %187 = getelementptr inbounds nuw i8, ptr %186, i64 2, !dbg !91
  %188 = load i8, ptr %187, align 1, !dbg !91, !tbaa !34
  %189 = sext i8 %188 to i32, !dbg !91
  %190 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, i32 noundef 2, i32 noundef %181, i32 noundef 2, i32 noundef %185, i32 noundef 2, i32 noundef %189), !dbg !92
  %191 = load ptr, ptr %1, align 8, !dbg !89, !tbaa !20
  %192 = getelementptr inbounds nuw i8, ptr %191, i64 3, !dbg !89
  %193 = load i8, ptr %192, align 1, !dbg !89, !tbaa !34
  %194 = sext i8 %193 to i32, !dbg !89
  %195 = load ptr, ptr %2, align 8, !dbg !90, !tbaa !20
  %196 = getelementptr inbounds nuw i8, ptr %195, i64 3, !dbg !90
  %197 = load i8, ptr %196, align 1, !dbg !90, !tbaa !34
  %198 = sext i8 %197 to i32, !dbg !90
  %199 = load ptr, ptr %3, align 8, !dbg !91, !tbaa !20
  %200 = getelementptr inbounds nuw i8, ptr %199, i64 3, !dbg !91
  %201 = load i8, ptr %200, align 1, !dbg !91, !tbaa !34
  %202 = sext i8 %201 to i32, !dbg !91
  %203 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, i32 noundef 3, i32 noundef %194, i32 noundef 3, i32 noundef %198, i32 noundef 3, i32 noundef %202), !dbg !92
  %204 = load ptr, ptr %1, align 8, !dbg !89, !tbaa !20
  %205 = getelementptr inbounds nuw i8, ptr %204, i64 4, !dbg !89
  %206 = load i8, ptr %205, align 1, !dbg !89, !tbaa !34
  %207 = sext i8 %206 to i32, !dbg !89
  %208 = load ptr, ptr %2, align 8, !dbg !90, !tbaa !20
  %209 = getelementptr inbounds nuw i8, ptr %208, i64 4, !dbg !90
  %210 = load i8, ptr %209, align 1, !dbg !90, !tbaa !34
  %211 = sext i8 %210 to i32, !dbg !90
  %212 = load ptr, ptr %3, align 8, !dbg !91, !tbaa !20
  %213 = getelementptr inbounds nuw i8, ptr %212, i64 4, !dbg !91
  %214 = load i8, ptr %213, align 1, !dbg !91, !tbaa !34
  %215 = sext i8 %214 to i32, !dbg !91
  %216 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, i32 noundef 4, i32 noundef %207, i32 noundef 4, i32 noundef %211, i32 noundef 4, i32 noundef %215), !dbg !92
  %217 = call i32 @putchar(i32 10), !dbg !93
  call void @llvm.lifetime.end.p0(ptr nonnull %3) #3, !dbg !94
  call void @llvm.lifetime.end.p0(ptr nonnull %2) #3, !dbg !94
  call void @llvm.lifetime.end.p0(ptr nonnull %1) #3, !dbg !94
  ret i32 0, !dbg !95

218:                                              ; preds = %218, %70
  %219 = phi i64 [ 0, %70 ], [ %231, %218 ]
  %220 = load ptr, ptr %3, align 8, !dbg !96, !tbaa !20
  %221 = getelementptr inbounds nuw i8, ptr %220, i64 %219, !dbg !96
  store i8 -1, ptr %221, align 1, !dbg !97, !tbaa !34
  %222 = load ptr, ptr %3, align 8, !dbg !96, !tbaa !20
  %223 = getelementptr inbounds nuw i8, ptr %222, i64 %219, !dbg !96
  %224 = getelementptr inbounds nuw i8, ptr %223, i64 1, !dbg !96
  store i8 -1, ptr %224, align 1, !dbg !97, !tbaa !34
  %225 = load ptr, ptr %3, align 8, !dbg !96, !tbaa !20
  %226 = getelementptr inbounds nuw i8, ptr %225, i64 %219, !dbg !96
  %227 = getelementptr inbounds nuw i8, ptr %226, i64 2, !dbg !96
  store i8 -1, ptr %227, align 1, !dbg !97, !tbaa !34
  %228 = load ptr, ptr %3, align 8, !dbg !96, !tbaa !20
  %229 = getelementptr inbounds nuw i8, ptr %228, i64 %219, !dbg !96
  %230 = getelementptr inbounds nuw i8, ptr %229, i64 3, !dbg !96
  store i8 -1, ptr %230, align 1, !dbg !97, !tbaa !34
  %231 = add nuw nsw i64 %219, 4, !dbg !98
  %232 = icmp eq i64 %231, 16777216, !dbg !99
  br i1 %232, label %143, label %218, !dbg !76, !llvm.loop !100
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(ptr captures(none)) #1

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(ptr captures(none)) #1

; Function Attrs: nounwind
declare i64 @llvm.x86.rdtsc() #3

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr noundef readonly captures(none), ...) local_unnamed_addr #4

; Function Attrs: alwaysinline norecurse nounwind uwtable
define internal void @main.omp_outlined(ptr noalias noundef readonly captures(none) %0, ptr noalias readnone captures(none) %1, ptr noundef nonnull readonly align 8 captures(none) dereferenceable(8) %2, ptr noundef nonnull readonly align 8 captures(none) dereferenceable(8) %3, ptr noundef nonnull readonly align 8 captures(none) dereferenceable(8) %4) #5 !dbg !102 {
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  call void @llvm.lifetime.start.p0(ptr nonnull %6) #3, !dbg !103
  store i32 0, ptr %6, align 4, !dbg !104, !tbaa !9
  call void @llvm.lifetime.start.p0(ptr nonnull %7) #3, !dbg !103
  store i32 16777215, ptr %7, align 4, !dbg !104, !tbaa !9
  call void @llvm.lifetime.start.p0(ptr nonnull %8) #3, !dbg !103
  store i32 1, ptr %8, align 4, !dbg !104, !tbaa !9
  call void @llvm.lifetime.start.p0(ptr nonnull %9) #3, !dbg !103
  store i32 0, ptr %9, align 4, !dbg !104, !tbaa !9
  %10 = load i32, ptr %0, align 4, !dbg !103, !tbaa !9
  call void @__kmpc_for_static_init_4(ptr nonnull @1, i32 %10, i32 34, ptr nonnull %9, ptr nonnull %6, ptr nonnull %7, ptr nonnull %8, i32 1, i32 1), !dbg !103
  %11 = load i32, ptr %7, align 4, !dbg !104, !tbaa !9
  %12 = call i32 @llvm.smin.i32(i32 %11, i32 16777215), !dbg !104
  store i32 %12, ptr %7, align 4, !dbg !104, !tbaa !9
  %13 = load i32, ptr %6, align 4, !dbg !104, !tbaa !9
  %14 = icmp sgt i32 %13, %12, !dbg !105
  br i1 %14, label %32, label %15, !dbg !103

15:                                               ; preds = %5
  %16 = sext i32 %13 to i64, !dbg !103
  br label %17, !dbg !103

17:                                               ; preds = %15, %17
  %18 = phi i64 [ %16, %15 ], [ %28, %17 ]
  %19 = load ptr, ptr %3, align 8, !dbg !106, !tbaa !20, !llvm.access.group !107
  %20 = getelementptr inbounds i8, ptr %19, i64 %18, !dbg !106
  %21 = load i8, ptr %20, align 1, !dbg !106, !tbaa !34, !llvm.access.group !107
  %22 = load ptr, ptr %4, align 8, !dbg !108, !tbaa !20, !llvm.access.group !107
  %23 = getelementptr inbounds i8, ptr %22, i64 %18, !dbg !108
  %24 = load i8, ptr %23, align 1, !dbg !108, !tbaa !34, !llvm.access.group !107
  %25 = add i8 %24, %21, !dbg !109
  %26 = load ptr, ptr %2, align 8, !dbg !110, !tbaa !20, !llvm.access.group !107
  %27 = getelementptr inbounds i8, ptr %26, i64 %18, !dbg !110
  store i8 %25, ptr %27, align 1, !dbg !111, !tbaa !34, !llvm.access.group !107
  %28 = add nsw i64 %18, 1, !dbg !105
  %29 = load i32, ptr %7, align 4, !dbg !104, !tbaa !9, !llvm.access.group !107
  %30 = sext i32 %29 to i64, !dbg !105
  %31 = icmp slt i64 %18, %30, !dbg !105
  br i1 %31, label %17, label %32, !dbg !103, !llvm.loop !112

32:                                               ; preds = %17, %5
  call void @__kmpc_for_static_fini(ptr nonnull @3, i32 %10), !dbg !113
  call void @llvm.lifetime.end.p0(ptr nonnull %9) #3, !dbg !103
  call void @llvm.lifetime.end.p0(ptr nonnull %8) #3, !dbg !103
  call void @llvm.lifetime.end.p0(ptr nonnull %7) #3, !dbg !103
  call void @llvm.lifetime.end.p0(ptr nonnull %6) #3, !dbg !103
  ret void, !dbg !116
}

; Function Attrs: nounwind
declare void @__kmpc_for_static_init_4(ptr, i32, i32, ptr, ptr, ptr, ptr, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind
declare void @__kmpc_for_static_fini(ptr, i32) local_unnamed_addr #3

; Function Attrs: nounwind
declare i32 @__kmpc_global_thread_num(ptr) local_unnamed_addr #3

; Function Attrs: nounwind
declare void @__kmpc_push_num_threads(ptr, i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind
declare !callback !117 void @__kmpc_fork_call(ptr, i32, ptr, ...) local_unnamed_addr #3

declare void @vec_sum_omp(ptr noundef, ptr noundef, ptr noundef, i64 noundef, i32 noundef) local_unnamed_addr #6

; Function Attrs: nofree nounwind
declare noundef i32 @putchar(i32 noundef) local_unnamed_addr #7

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr noundef readonly captures(none)) local_unnamed_addr #7

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smin.i32(i32, i32) #8

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind }
attributes #4 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { alwaysinline norecurse nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #7 = { nofree nounwind }
attributes #8 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #9 = { nounwind allocsize(0) }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5, !6, !7}
!llvm.ident = !{!8}
!llvm.errno.tbaa = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C11, file: !1, producer: "clang version 23.0.0git (https://github.com/llvm/llvm-project.git 6c80beea68a535cfe66350613f797061c3eca872)", isOptimized: true, runtimeVersion: 0, emissionKind: NoDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "main.c", directory: "/home/kevin/Git_learning_repos/tesi_magistrale/MY-TESTS/omp_experiments")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{i32 7, !"openmp", i32 51}
!5 = !{i32 8, !"PIC Level", i32 2}
!6 = !{i32 7, !"PIE Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 2}
!8 = !{!"clang version 23.0.0git (https://github.com/llvm/llvm-project.git 6c80beea68a535cfe66350613f797061c3eca872)"}
!9 = !{!10, !10, i64 0}
!10 = !{!"int", !11, i64 0}
!11 = !{!"omnipotent char", !12, i64 0}
!12 = !{!"Simple C/C++ TBAA"}
!13 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 11, type: !14, scopeLine: 11, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!14 = !DISubroutineType(types: !15)
!15 = !{}
!16 = !DILocation(line: 38, column: 31, scope: !13)
!17 = !DILocation(line: 12, column: 3, scope: !13)
!18 = !DILocation(line: 12, column: 25, scope: !13)
!19 = !DILocation(line: 12, column: 11, scope: !13)
!20 = !{!21, !21, i64 0}
!21 = !{!"p1 omnipotent char", !22, i64 0}
!22 = !{!"any pointer", !11, i64 0}
!23 = !DILocation(line: 13, column: 3, scope: !13)
!24 = !DILocation(line: 13, column: 25, scope: !13)
!25 = !DILocation(line: 13, column: 11, scope: !13)
!26 = !DILocation(line: 14, column: 3, scope: !13)
!27 = !DILocation(line: 14, column: 25, scope: !13)
!28 = !DILocation(line: 14, column: 11, scope: !13)
!29 = !DILocation(line: 17, column: 3, scope: !13)
!30 = !DILocation(line: 18, column: 14, scope: !13)
!31 = !DILocation(line: 18, column: 12, scope: !13)
!32 = !DILocation(line: 18, column: 5, scope: !13)
!33 = !DILocation(line: 18, column: 10, scope: !13)
!34 = !{!11, !11, i64 0}
!35 = !DILocation(line: 19, column: 5, scope: !13)
!36 = !DILocation(line: 19, column: 10, scope: !13)
!37 = !DILocation(line: 20, column: 5, scope: !13)
!38 = !DILocation(line: 20, column: 10, scope: !13)
!39 = distinct !{!39, !40, !41, !42}
!40 = !{!"llvm.loop.mustprogress"}
!41 = !{!"llvm.loop.isvectorized", i32 1}
!42 = !{!"llvm.loop.unroll.runtime.disable"}
!43 = !DILocation(line: 23, column: 20, scope: !13)
!44 = !DILocation(line: 24, column: 3, scope: !13)
!45 = !DILocation(line: 24, column: 27, scope: !13)
!46 = !DILocation(line: 25, column: 12, scope: !13)
!47 = !DILocation(line: 25, column: 19, scope: !13)
!48 = !DILocation(line: 25, column: 17, scope: !13)
!49 = !DILocation(line: 25, column: 5, scope: !13)
!50 = !DILocation(line: 25, column: 10, scope: !13)
!51 = distinct !{!51, !40, !41, !42}
!52 = !DILocation(line: 27, column: 18, scope: !13)
!53 = !DILocation(line: 28, column: 30, scope: !13)
!54 = !DILocation(line: 29, column: 3, scope: !13)
!55 = !DILocation(line: 30, column: 3, scope: !13)
!56 = !DILocation(line: 33, column: 3, scope: !13)
!57 = !DILocation(line: 33, column: 27, scope: !13)
!58 = !DILocation(line: 34, column: 5, scope: !13)
!59 = !DILocation(line: 34, column: 10, scope: !13)
!60 = distinct !{!60, !40, !41, !42}
!61 = !DILocation(line: 37, column: 11, scope: !13)
!62 = !DILocation(line: 38, column: 1, scope: !13)
!63 = !DILocation(line: 42, column: 9, scope: !13)
!64 = !DILocation(line: 43, column: 27, scope: !13)
!65 = !DILocation(line: 44, column: 3, scope: !13)
!66 = !DILocation(line: 45, column: 30, scope: !13)
!67 = !DILocation(line: 45, column: 52, scope: !13)
!68 = !DILocation(line: 45, column: 50, scope: !13)
!69 = !DILocation(line: 45, column: 3, scope: !13)
!70 = !DILocation(line: 46, column: 3, scope: !13)
!71 = !DILocation(line: 48, column: 49, scope: !13)
!72 = !DILocation(line: 48, column: 58, scope: !13)
!73 = !DILocation(line: 48, column: 67, scope: !13)
!74 = !DILocation(line: 48, column: 5, scope: !13)
!75 = !DILocation(line: 50, column: 3, scope: !13)
!76 = !DILocation(line: 53, column: 3, scope: !13)
!77 = !DILocation(line: 57, column: 11, scope: !13)
!78 = !DILocation(line: 58, column: 15, scope: !13)
!79 = !DILocation(line: 58, column: 18, scope: !13)
!80 = !DILocation(line: 58, column: 21, scope: !13)
!81 = !DILocation(line: 58, column: 3, scope: !13)
!82 = !DILocation(line: 59, column: 9, scope: !13)
!83 = !DILocation(line: 60, column: 32, scope: !13)
!84 = !DILocation(line: 61, column: 3, scope: !13)
!85 = !DILocation(line: 62, column: 52, scope: !13)
!86 = !DILocation(line: 62, column: 50, scope: !13)
!87 = !DILocation(line: 62, column: 3, scope: !13)
!88 = !DILocation(line: 63, column: 3, scope: !13)
!89 = !DILocation(line: 65, column: 49, scope: !13)
!90 = !DILocation(line: 65, column: 58, scope: !13)
!91 = !DILocation(line: 65, column: 67, scope: !13)
!92 = !DILocation(line: 65, column: 5, scope: !13)
!93 = !DILocation(line: 67, column: 3, scope: !13)
!94 = !DILocation(line: 70, column: 1, scope: !13)
!95 = !DILocation(line: 69, column: 3, scope: !13)
!96 = !DILocation(line: 54, column: 5, scope: !13)
!97 = !DILocation(line: 54, column: 10, scope: !13)
!98 = !DILocation(line: 53, column: 27, scope: !13)
!99 = !DILocation(line: 53, column: 21, scope: !13)
!100 = distinct !{!100, !76, !101, !40}
!101 = !DILocation(line: 55, column: 3, scope: !13)
!102 = distinct !DISubprogram(name: "main.omp_outlined", scope: !1, file: !1, line: 38, type: !14, scopeLine: 38, flags: DIFlagArtificial | DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!103 = !DILocation(line: 38, column: 1, scope: !102)
!104 = !DILocation(line: 39, column: 8, scope: !102)
!105 = !DILocation(line: 39, column: 3, scope: !102)
!106 = !DILocation(line: 40, column: 12, scope: !102)
!107 = distinct !{}
!108 = !DILocation(line: 40, column: 19, scope: !102)
!109 = !DILocation(line: 40, column: 17, scope: !102)
!110 = !DILocation(line: 40, column: 5, scope: !102)
!111 = !DILocation(line: 40, column: 10, scope: !102)
!112 = distinct !{!112, !103, !113, !114, !115}
!113 = !DILocation(line: 38, column: 55, scope: !102)
!114 = !{!"llvm.loop.parallel_accesses", !107}
!115 = !{!"llvm.loop.vectorize.enable", i1 true}
!116 = !DILocation(line: 41, column: 3, scope: !102)
!117 = !{!118}
!118 = !{i64 2, i64 -1, i64 -1, i1 true}
