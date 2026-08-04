; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-f64:32-v64:32-v128:32-a:0:32-v256:32-v512:32-n8:16:32"
target triple = "arc-pc-unknown-gnu"

@in = addrspace(4) global [4096 x i32] zeroinitializer, align 4
@out = addrspace(4) global [1024 x i32] zeroinitializer, align 4
@.str.2 = private unnamed_addr constant [29 x i8] c"Tempo di esecuzione: %.2fms\0A\00", align 1
@.str.3 = private unnamed_addr constant [23 x i8] c"Vettorizzo su %d lane\0A\00", align 1
@.str.4 = private unnamed_addr constant [55 x i8] c"Tempo di esecuzione di vectorized_max_pooling: %.2fms\0A\00", align 1
@.str.5 = private unnamed_addr constant [15 x i8] c"Speedup: %.2f\0A\00", align 1
@.str.7 = private unnamed_addr constant [59 x i8] c"Tempo di esecuzione di autovectorized_max_pooling: %.2fms\0A\00", align 1
@.str.9 = private unnamed_addr constant [49 x i8] c"Tempo di esecuzione di vekt_max_pooling: %.2fms\0A\00", align 1
@str = private unnamed_addr constant [6 x i8] c"Input\00", align 1
@str.10 = private unnamed_addr constant [26 x i8] c"Versione autovettorizzata\00", align 1
@str.11 = private unnamed_addr constant [27 x i8] c"Versione vekt-vettorizzata\00", align 1

; Function Attrs: nounwind
define dso_local i32 @main() local_unnamed_addr #0 {
entry:
  %groundtruth = alloca [32 x [32 x i32]], align 4
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body
  tail call void @init_matrix(ptr noundef addrspacecast (ptr addrspace(4) @out to ptr), i32 noundef 32, i32 noundef 32, i32 noundef 0) #5
  %puts = tail call i32 @puts(ptr nonnull dereferenceable(1) @str)
  tail call void @print_matrix(ptr noundef addrspacecast (ptr addrspace(4) @in to ptr), i32 noundef 64, i32 noundef 64) #5
  %putchar = tail call i32 @putchar(i32 10)
  %call10 = tail call i32 @clock() #5
  tail call void @max_pooling(i32 noundef 32, i32 noundef 32, i32 noundef 64, i32 noundef 64, i32 noundef 2, ptr noundef addrspacecast (ptr addrspace(4) @out to ptr), ptr noundef addrspacecast (ptr addrspace(4) @in to ptr)) #5
  %call11 = tail call i32 @clock() #5
  %sub = sub nsw i32 %call11, %call10
  %conv = sitofp i32 %sub to double
  %call12 = tail call i32 @_timer_clocks_per_sec() #5
  %conv13 = uitofp i32 %call12 to double
  %0 = fmul fast double %conv, 1.000000e+03
  %mul14 = fdiv fast double %0, %conv13
  %call15 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, double noundef nofpclass(nan inf) %mul14)
  tail call void @print_matrix(ptr noundef addrspacecast (ptr addrspace(4) @out to ptr), i32 noundef 32, i32 noundef 32) #5
  call void @llvm.lifetime.start.p0(i64 4096, ptr nonnull %groundtruth) #5
  %call16 = call ptr @copy_matrix(ptr noundef nonnull %groundtruth, ptr noundef addrspacecast (ptr addrspace(4) @out to ptr), i32 noundef 32, i32 noundef 32) #5
  %putchar77 = call i32 @putchar(i32 10)
  %call18 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, i32 noundef 16)
  call void @init_matrix(ptr noundef addrspacecast (ptr addrspace(4) @out to ptr), i32 noundef 32, i32 noundef 32, i32 noundef 0) #5
  %call19 = call i32 @clock() #5
  call void @vectorized_max_pooling(i32 noundef 32, i32 noundef 32, i32 noundef 64, i32 noundef 64, i32 noundef 2, ptr addrspace(4) noundef @out, ptr addrspace(4) noundef @in) #5
  %call20 = call i32 @clock() #5
  %sub21 = sub nsw i32 %call20, %call19
  %conv22 = sitofp i32 %sub21 to double
  %call23 = call i32 @_timer_clocks_per_sec() #5
  %conv24 = uitofp i32 %call23 to double
  %1 = fmul fast double %conv22, 1.000000e+03
  %mul26 = fdiv fast double %1, %conv24
  %call27 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.4, double noundef nofpclass(nan inf) %mul26)
  %div28 = fdiv fast double %mul14, %mul26
  %call29 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, double noundef nofpclass(nan inf) %div28)
  call void @print_matrix(ptr noundef addrspacecast (ptr addrspace(4) @out to ptr), i32 noundef 32, i32 noundef 32) #5
  call void @check_result(ptr noundef nonnull %groundtruth, ptr noundef addrspacecast (ptr addrspace(4) @out to ptr), i32 noundef 32, i32 noundef 32) #5
  %putchar78 = call i32 @putchar(i32 10)
  %puts79 = call i32 @puts(ptr nonnull dereferenceable(1) @str.10)
  call void @init_matrix(ptr noundef addrspacecast (ptr addrspace(4) @out to ptr), i32 noundef 32, i32 noundef 32, i32 noundef 0) #5
  %call33 = call i32 @clock() #5
  call void @autovectorized_max_pooling(i32 noundef 32, i32 noundef 32, i32 noundef 64, i32 noundef 64, i32 noundef 2, ptr addrspace(4) noundef @out, ptr addrspace(4) noundef @in) #5
  %call34 = call i32 @clock() #5
  %sub35 = sub nsw i32 %call34, %call33
  %conv36 = sitofp i32 %sub35 to double
  %call37 = call i32 @_timer_clocks_per_sec() #5
  %conv38 = uitofp i32 %call37 to double
  %2 = fmul fast double %conv36, 1.000000e+03
  %mul40 = fdiv fast double %2, %conv38
  %call41 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.7, double noundef nofpclass(nan inf) %mul40)
  %div42 = fdiv fast double %mul14, %mul40
  %call43 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, double noundef nofpclass(nan inf) %div42)
  call void @print_matrix(ptr noundef addrspacecast (ptr addrspace(4) @out to ptr), i32 noundef 32, i32 noundef 32) #5
  %putchar80 = call i32 @putchar(i32 10)
  %puts81 = call i32 @puts(ptr nonnull dereferenceable(1) @str.11)
  call void @init_matrix(ptr noundef addrspacecast (ptr addrspace(4) @out to ptr), i32 noundef 32, i32 noundef 32, i32 noundef 0) #5
  %call46 = call i32 @clock() #5
  call void @vekt_max_pooling_wrapper(i32 noundef 32, i32 noundef 32, i32 noundef 64, i32 noundef 64, i32 noundef 2, ptr noundef addrspacecast (ptr addrspace(4) @out to ptr), ptr noundef addrspacecast (ptr addrspace(4) @in to ptr)) #5
  %call47 = call i32 @clock() #5
  %sub48 = sub nsw i32 %call47, %call46
  %conv49 = sitofp i32 %sub48 to double
  %call50 = call i32 @_timer_clocks_per_sec() #5
  %conv51 = uitofp i32 %call50 to double
  %3 = fmul fast double %conv49, 1.000000e+03
  %mul53 = fdiv fast double %3, %conv51
  %call54 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.9, double noundef nofpclass(nan inf) %mul53)
  %div55 = fdiv fast double %mul14, %mul53
  %call56 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, double noundef nofpclass(nan inf) %div55)
  call void @print_matrix(ptr noundef addrspacecast (ptr addrspace(4) @out to ptr), i32 noundef 32, i32 noundef 32) #5
  call void @check_result(ptr noundef nonnull %groundtruth, ptr noundef addrspacecast (ptr addrspace(4) @out to ptr), i32 noundef 32, i32 noundef 32) #5
  %putchar82 = call i32 @putchar(i32 10)
  call void @llvm.lifetime.end.p0(i64 4096, ptr nonnull %groundtruth) #5
  ret i32 0

for.body:                                         ; preds = %for.body, %entry
  %i.084 = phi i32 [ 0, %entry ], [ %inc7.1, %for.body ]
  %mul = shl nuw nsw i32 %i.084, 6
  %broadcast.splatinsert = insertelement <16 x i32> poison, i32 %i.084, i64 0
  %broadcast.splat = shufflevector <16 x i32> %broadcast.splatinsert, <16 x i32> poison, <16 x i32> zeroinitializer
  %4 = add nuw nsw <16 x i32> %broadcast.splat, <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %5 = urem <16 x i32> %4, <i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10>
  %6 = getelementptr inbounds [4096 x i32], ptr addrspace(4) @in, i32 0, i32 %mul
  store <16 x i32> %5, ptr addrspace(4) %6, align 4, !tbaa !3
  %7 = add nuw nsw <16 x i32> %broadcast.splat, <i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31>
  %8 = urem <16 x i32> %7, <i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10>
  %9 = add nuw nsw i32 %mul, 16
  %10 = getelementptr inbounds [4096 x i32], ptr addrspace(4) @in, i32 0, i32 %9
  store <16 x i32> %8, ptr addrspace(4) %10, align 4, !tbaa !3
  %11 = add nuw nsw <16 x i32> %broadcast.splat, <i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47>
  %12 = urem <16 x i32> %11, <i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10>
  %13 = add nuw nsw i32 %mul, 32
  %14 = getelementptr inbounds [4096 x i32], ptr addrspace(4) @in, i32 0, i32 %13
  store <16 x i32> %12, ptr addrspace(4) %14, align 4, !tbaa !3
  %15 = add nuw nsw <16 x i32> %broadcast.splat, <i32 48, i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55, i32 56, i32 57, i32 58, i32 59, i32 60, i32 61, i32 62, i32 63>
  %16 = urem <16 x i32> %15, <i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10>
  %17 = add nuw nsw i32 %mul, 48
  %18 = getelementptr inbounds [4096 x i32], ptr addrspace(4) @in, i32 0, i32 %17
  store <16 x i32> %16, ptr addrspace(4) %18, align 4, !tbaa !3
  %inc7 = add nuw nsw i32 %i.084, 1
  %mul.1 = shl nuw nsw i32 %inc7, 6
  %broadcast.splatinsert.1 = insertelement <16 x i32> poison, i32 %inc7, i64 0
  %broadcast.splat.1 = shufflevector <16 x i32> %broadcast.splatinsert.1, <16 x i32> poison, <16 x i32> zeroinitializer
  %19 = add nuw nsw <16 x i32> %broadcast.splat.1, <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %20 = urem <16 x i32> %19, <i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10>
  %21 = getelementptr inbounds [4096 x i32], ptr addrspace(4) @in, i32 0, i32 %mul.1
  store <16 x i32> %20, ptr addrspace(4) %21, align 4, !tbaa !3
  %22 = add nuw nsw <16 x i32> %broadcast.splat.1, <i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31>
  %23 = urem <16 x i32> %22, <i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10>
  %24 = add nuw nsw i32 %mul.1, 16
  %25 = getelementptr inbounds [4096 x i32], ptr addrspace(4) @in, i32 0, i32 %24
  store <16 x i32> %23, ptr addrspace(4) %25, align 4, !tbaa !3
  %26 = add nuw nsw <16 x i32> %broadcast.splat.1, <i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47>
  %27 = urem <16 x i32> %26, <i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10>
  %28 = add nuw nsw i32 %mul.1, 32
  %29 = getelementptr inbounds [4096 x i32], ptr addrspace(4) @in, i32 0, i32 %28
  store <16 x i32> %27, ptr addrspace(4) %29, align 4, !tbaa !3
  %30 = add nuw nsw <16 x i32> %broadcast.splat.1, <i32 48, i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55, i32 56, i32 57, i32 58, i32 59, i32 60, i32 61, i32 62, i32 63>
  %31 = urem <16 x i32> %30, <i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10, i32 10>
  %32 = add nuw nsw i32 %mul.1, 48
  %33 = getelementptr inbounds [4096 x i32], ptr addrspace(4) @in, i32 0, i32 %32
  store <16 x i32> %31, ptr addrspace(4) %33, align 4, !tbaa !3
  %inc7.1 = add nuw nsw i32 %i.084, 2
  %cmp.1 = icmp ult i32 %inc7.1, 64
  br i1 %cmp.1, label %for.body, label %for.cond.cleanup, !llvm.loop !7
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

declare void @init_matrix(ptr noundef, i32 noundef, i32 noundef, i32 noundef) local_unnamed_addr #2

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #3

declare void @print_matrix(ptr noundef, i32 noundef, i32 noundef) local_unnamed_addr #2

declare i32 @clock() local_unnamed_addr #2

declare void @max_pooling(i32 noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef, ptr noundef, ptr noundef) local_unnamed_addr #2

declare i32 @_timer_clocks_per_sec() local_unnamed_addr #2

declare ptr @copy_matrix(ptr noundef, ptr noundef, i32 noundef, i32 noundef) local_unnamed_addr #2

declare void @vectorized_max_pooling(i32 noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef, ptr addrspace(4) noundef, ptr addrspace(4) noundef) local_unnamed_addr #2

declare void @check_result(ptr noundef, ptr noundef, i32 noundef, i32 noundef) local_unnamed_addr #2

declare void @autovectorized_max_pooling(i32 noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef, ptr addrspace(4) noundef, ptr addrspace(4) noundef) local_unnamed_addr #2

declare void @vekt_max_pooling_wrapper(i32 noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef, ptr noundef, ptr noundef) local_unnamed_addr #2

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
