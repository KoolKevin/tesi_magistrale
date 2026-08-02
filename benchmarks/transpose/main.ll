; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-f64:32-v64:32-v128:32-a:0:32-v256:32-v512:32-n8:16:32"
target triple = "arc-pc-unknown-gnu"

@a = addrspace(4) global [12544 x i32] zeroinitializer, align 4
@t = addrspace(4) global [12544 x i32] zeroinitializer, align 4
@.str.2 = private unnamed_addr constant [29 x i8] c"Tempo di esecuzione: %.2fms\0A\00", align 1
@.str.3 = private unnamed_addr constant [23 x i8] c"Vettorizzo su %d lane\0A\00", align 1
@.str.4 = private unnamed_addr constant [53 x i8] c"Tempo di esecuzione di vectorized_transpose: %.2fms\0A\00", align 1
@.str.5 = private unnamed_addr constant [15 x i8] c"Speedup: %.2f\0A\00", align 1
@.str.7 = private unnamed_addr constant [57 x i8] c"Tempo di esecuzione di autovectorized_transpose: %.2fms\0A\00", align 1
@.str.9 = private unnamed_addr constant [47 x i8] c"Tempo di esecuzione di vekt_transpose: %.2fms\0A\00", align 1
@str = private unnamed_addr constant [7 x i8] c"Input:\00", align 1
@str.10 = private unnamed_addr constant [26 x i8] c"Versione autovettorizzata\00", align 1
@str.11 = private unnamed_addr constant [27 x i8] c"Versione vekt-vettorizzata\00", align 1

; Function Attrs: nounwind
define dso_local i32 @main() local_unnamed_addr #0 {
entry:
  %groundtruth = alloca [112 x [112 x i32]], align 4
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body
  tail call void @init_matrix(ptr noundef addrspacecast (ptr addrspace(4) @t to ptr), i32 noundef 112, i32 noundef 112, i32 noundef 0) #5
  %puts = tail call i32 @puts(ptr nonnull dereferenceable(1) @str)
  %putchar = tail call i32 @putchar(i32 10)
  %call11 = tail call i32 @clock() #5
  tail call void @transpose(ptr noundef addrspacecast (ptr addrspace(4) @a to ptr), ptr noundef addrspacecast (ptr addrspace(4) @t to ptr), i32 noundef 112, i32 noundef 112) #5
  %call12 = tail call i32 @clock() #5
  %sub = sub nsw i32 %call12, %call11
  %conv = sitofp i32 %sub to double
  %call13 = tail call i32 @_timer_clocks_per_sec() #5
  %conv14 = uitofp i32 %call13 to double
  %0 = fmul fast double %conv, 1.000000e+03
  %mul15 = fdiv fast double %0, %conv14
  %call16 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, double noundef nofpclass(nan inf) %mul15)
  call void @llvm.lifetime.start.p0(i64 50176, ptr nonnull %groundtruth) #5
  %call17 = call ptr @copy_matrix(ptr noundef nonnull %groundtruth, ptr noundef addrspacecast (ptr addrspace(4) @t to ptr), i32 noundef 112, i32 noundef 112) #5
  %putchar78 = call i32 @putchar(i32 10)
  %call19 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, i32 noundef 16)
  call void @init_matrix(ptr noundef addrspacecast (ptr addrspace(4) @t to ptr), i32 noundef 112, i32 noundef 112, i32 noundef 0) #5
  %call20 = call i32 @clock() #5
  call void @vectorized_transpose(ptr addrspace(4) noundef @a, ptr addrspace(4) noundef @t, i32 noundef 112, i32 noundef 112) #5
  %call21 = call i32 @clock() #5
  %sub22 = sub nsw i32 %call21, %call20
  %conv23 = sitofp i32 %sub22 to double
  %call24 = call i32 @_timer_clocks_per_sec() #5
  %conv25 = uitofp i32 %call24 to double
  %1 = fmul fast double %conv23, 1.000000e+03
  %mul27 = fdiv fast double %1, %conv25
  %call28 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.4, double noundef nofpclass(nan inf) %mul27)
  %div29 = fdiv fast double %mul15, %mul27
  %call30 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, double noundef nofpclass(nan inf) %div29)
  call void @check_result(ptr noundef nonnull %groundtruth, ptr noundef addrspacecast (ptr addrspace(4) @t to ptr), i32 noundef 112, i32 noundef 112) #5
  %putchar79 = call i32 @putchar(i32 10)
  %puts80 = call i32 @puts(ptr nonnull dereferenceable(1) @str.10)
  call void @init_matrix(ptr noundef addrspacecast (ptr addrspace(4) @t to ptr), i32 noundef 112, i32 noundef 112, i32 noundef 0) #5
  %call34 = call i32 @clock() #5
  call void @autovectorized_transpose(ptr addrspace(4) noundef @a, ptr addrspace(4) noundef @t, i32 noundef 112, i32 noundef 112) #5
  %call35 = call i32 @clock() #5
  %sub36 = sub nsw i32 %call35, %call34
  %conv37 = sitofp i32 %sub36 to double
  %call38 = call i32 @_timer_clocks_per_sec() #5
  %conv39 = uitofp i32 %call38 to double
  %2 = fmul fast double %conv37, 1.000000e+03
  %mul41 = fdiv fast double %2, %conv39
  %call42 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.7, double noundef nofpclass(nan inf) %mul41)
  %div43 = fdiv fast double %mul15, %mul41
  %call44 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, double noundef nofpclass(nan inf) %div43)
  %putchar81 = call i32 @putchar(i32 10)
  %puts82 = call i32 @puts(ptr nonnull dereferenceable(1) @str.11)
  call void @init_matrix(ptr noundef addrspacecast (ptr addrspace(4) @t to ptr), i32 noundef 112, i32 noundef 112, i32 noundef 0) #5
  %call47 = call i32 @clock() #5
  call void @vekt_transpose_wrapper(ptr noundef addrspacecast (ptr addrspace(4) @a to ptr), ptr noundef addrspacecast (ptr addrspace(4) @t to ptr), i32 noundef 112, i32 noundef 112) #5
  %call48 = call i32 @clock() #5
  %sub49 = sub nsw i32 %call48, %call47
  %conv50 = sitofp i32 %sub49 to double
  %call51 = call i32 @_timer_clocks_per_sec() #5
  %conv52 = uitofp i32 %call51 to double
  %3 = fmul fast double %conv50, 1.000000e+03
  %mul54 = fdiv fast double %3, %conv52
  %call55 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.9, double noundef nofpclass(nan inf) %mul54)
  %div56 = fdiv fast double %mul15, %mul54
  %call57 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, double noundef nofpclass(nan inf) %div56)
  call void @check_result(ptr noundef nonnull %groundtruth, ptr noundef addrspacecast (ptr addrspace(4) @t to ptr), i32 noundef 112, i32 noundef 112) #5
  %putchar83 = call i32 @putchar(i32 10)
  call void @llvm.lifetime.end.p0(i64 50176, ptr nonnull %groundtruth) #5
  ret i32 0

for.body:                                         ; preds = %for.body, %entry
  %i.085 = phi i32 [ 0, %entry ], [ %inc8.1, %for.body ]
  %mul5 = mul nuw nsw i32 %i.085, 112
  %mul = mul nuw nsw i32 %i.085, 100
  %broadcast.splatinsert = insertelement <16 x i32> poison, i32 %mul, i64 0
  %broadcast.splat = shufflevector <16 x i32> %broadcast.splatinsert, <16 x i32> poison, <16 x i32> zeroinitializer
  %4 = add nuw nsw <16 x i32> %broadcast.splat, <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %5 = getelementptr inbounds [12544 x i32], ptr addrspace(4) @a, i32 0, i32 %mul5
  store <16 x i32> %4, ptr addrspace(4) %5, align 4, !tbaa !3
  %6 = add nuw nsw <16 x i32> %broadcast.splat, <i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31>
  %7 = add nuw nsw i32 %mul5, 16
  %8 = getelementptr inbounds [12544 x i32], ptr addrspace(4) @a, i32 0, i32 %7
  store <16 x i32> %6, ptr addrspace(4) %8, align 4, !tbaa !3
  %9 = add nuw nsw <16 x i32> %broadcast.splat, <i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47>
  %10 = add nuw nsw i32 %mul5, 32
  %11 = getelementptr inbounds [12544 x i32], ptr addrspace(4) @a, i32 0, i32 %10
  store <16 x i32> %9, ptr addrspace(4) %11, align 4, !tbaa !3
  %12 = add nuw nsw <16 x i32> %broadcast.splat, <i32 48, i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55, i32 56, i32 57, i32 58, i32 59, i32 60, i32 61, i32 62, i32 63>
  %13 = add nuw nsw i32 %mul5, 48
  %14 = getelementptr inbounds [12544 x i32], ptr addrspace(4) @a, i32 0, i32 %13
  store <16 x i32> %12, ptr addrspace(4) %14, align 4, !tbaa !3
  %15 = add nuw nsw <16 x i32> %broadcast.splat, <i32 64, i32 65, i32 66, i32 67, i32 68, i32 69, i32 70, i32 71, i32 72, i32 73, i32 74, i32 75, i32 76, i32 77, i32 78, i32 79>
  %16 = add nuw nsw i32 %mul5, 64
  %17 = getelementptr inbounds [12544 x i32], ptr addrspace(4) @a, i32 0, i32 %16
  store <16 x i32> %15, ptr addrspace(4) %17, align 4, !tbaa !3
  %18 = add nuw nsw <16 x i32> %broadcast.splat, <i32 80, i32 81, i32 82, i32 83, i32 84, i32 85, i32 86, i32 87, i32 88, i32 89, i32 90, i32 91, i32 92, i32 93, i32 94, i32 95>
  %19 = add nuw nsw i32 %mul5, 80
  %20 = getelementptr inbounds [12544 x i32], ptr addrspace(4) @a, i32 0, i32 %19
  store <16 x i32> %18, ptr addrspace(4) %20, align 4, !tbaa !3
  %21 = add nuw nsw <16 x i32> %broadcast.splat, <i32 96, i32 97, i32 98, i32 99, i32 100, i32 101, i32 102, i32 103, i32 104, i32 105, i32 106, i32 107, i32 108, i32 109, i32 110, i32 111>
  %22 = add nuw nsw i32 %mul5, 96
  %23 = getelementptr inbounds [12544 x i32], ptr addrspace(4) @a, i32 0, i32 %22
  store <16 x i32> %21, ptr addrspace(4) %23, align 4, !tbaa !3
  %inc8 = add nuw nsw i32 %i.085, 1
  %mul5.1 = mul nuw nsw i32 %inc8, 112
  %mul.1 = mul nuw nsw i32 %inc8, 100
  %broadcast.splatinsert.1 = insertelement <16 x i32> poison, i32 %mul.1, i64 0
  %broadcast.splat.1 = shufflevector <16 x i32> %broadcast.splatinsert.1, <16 x i32> poison, <16 x i32> zeroinitializer
  %24 = add nuw nsw <16 x i32> %broadcast.splat.1, <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %25 = getelementptr inbounds [12544 x i32], ptr addrspace(4) @a, i32 0, i32 %mul5.1
  store <16 x i32> %24, ptr addrspace(4) %25, align 4, !tbaa !3
  %26 = add nuw nsw <16 x i32> %broadcast.splat.1, <i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31>
  %27 = add nuw nsw i32 %mul5.1, 16
  %28 = getelementptr inbounds [12544 x i32], ptr addrspace(4) @a, i32 0, i32 %27
  store <16 x i32> %26, ptr addrspace(4) %28, align 4, !tbaa !3
  %29 = add nuw nsw <16 x i32> %broadcast.splat.1, <i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47>
  %30 = add nuw nsw i32 %mul5.1, 32
  %31 = getelementptr inbounds [12544 x i32], ptr addrspace(4) @a, i32 0, i32 %30
  store <16 x i32> %29, ptr addrspace(4) %31, align 4, !tbaa !3
  %32 = add nuw nsw <16 x i32> %broadcast.splat.1, <i32 48, i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55, i32 56, i32 57, i32 58, i32 59, i32 60, i32 61, i32 62, i32 63>
  %33 = add nuw nsw i32 %mul5.1, 48
  %34 = getelementptr inbounds [12544 x i32], ptr addrspace(4) @a, i32 0, i32 %33
  store <16 x i32> %32, ptr addrspace(4) %34, align 4, !tbaa !3
  %35 = add nuw nsw <16 x i32> %broadcast.splat.1, <i32 64, i32 65, i32 66, i32 67, i32 68, i32 69, i32 70, i32 71, i32 72, i32 73, i32 74, i32 75, i32 76, i32 77, i32 78, i32 79>
  %36 = add nuw nsw i32 %mul5.1, 64
  %37 = getelementptr inbounds [12544 x i32], ptr addrspace(4) @a, i32 0, i32 %36
  store <16 x i32> %35, ptr addrspace(4) %37, align 4, !tbaa !3
  %38 = add nuw nsw <16 x i32> %broadcast.splat.1, <i32 80, i32 81, i32 82, i32 83, i32 84, i32 85, i32 86, i32 87, i32 88, i32 89, i32 90, i32 91, i32 92, i32 93, i32 94, i32 95>
  %39 = add nuw nsw i32 %mul5.1, 80
  %40 = getelementptr inbounds [12544 x i32], ptr addrspace(4) @a, i32 0, i32 %39
  store <16 x i32> %38, ptr addrspace(4) %40, align 4, !tbaa !3
  %41 = add nuw nsw <16 x i32> %broadcast.splat.1, <i32 96, i32 97, i32 98, i32 99, i32 100, i32 101, i32 102, i32 103, i32 104, i32 105, i32 106, i32 107, i32 108, i32 109, i32 110, i32 111>
  %42 = add nuw nsw i32 %mul5.1, 96
  %43 = getelementptr inbounds [12544 x i32], ptr addrspace(4) @a, i32 0, i32 %42
  store <16 x i32> %41, ptr addrspace(4) %43, align 4, !tbaa !3
  %inc8.1 = add nuw nsw i32 %i.085, 2
  %cmp.1 = icmp ult i32 %inc8.1, 112
  br i1 %cmp.1, label %for.body, label %for.cond.cleanup, !llvm.loop !7
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

declare void @init_matrix(ptr noundef, i32 noundef, i32 noundef, i32 noundef) local_unnamed_addr #2

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #3

declare i32 @clock() local_unnamed_addr #2

declare void @transpose(ptr noundef, ptr noundef, i32 noundef, i32 noundef) local_unnamed_addr #2

declare i32 @_timer_clocks_per_sec() local_unnamed_addr #2

declare ptr @copy_matrix(ptr noundef, ptr noundef, i32 noundef, i32 noundef) local_unnamed_addr #2

declare void @vectorized_transpose(ptr addrspace(4) noundef, ptr addrspace(4) noundef, i32 noundef, i32 noundef) local_unnamed_addr #2

declare void @check_result(ptr noundef, ptr noundef, i32 noundef, i32 noundef) local_unnamed_addr #2

declare void @autovectorized_transpose(ptr addrspace(4) noundef, ptr addrspace(4) noundef, i32 noundef, i32 noundef) local_unnamed_addr #2

declare void @vekt_transpose_wrapper(ptr noundef, ptr noundef, i32 noundef, i32 noundef) local_unnamed_addr #2

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #4

; Function Attrs: nofree nounwind
declare noundef i32 @putchar(i32 noundef) local_unnamed_addr #4

attributes #0 = { nounwind "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #3 = { nofree nounwind "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #4 = { nofree nounwind }
attributes #5 = { nounwind }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"ArcIntrinsicCheck", i32 28778521}
!1 = !{i32 1, !"wchar_size", i32 2}
!2 = !{!"clang version 17.0.7 (git@gitsnps.internal.synopsys.com:MetaWare/mwdt-llvm-project.git 3cb6cb7579aa39b9c4db2b6a06b7c2eb3174f977)"}
!3 = !{!4, !4, i64 0}
!4 = !{!"int", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C/C++ TBAA"}
!7 = distinct !{!7, !8}
!8 = !{!"llvm.loop.mustprogress"}
