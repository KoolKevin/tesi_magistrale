; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-f64:32-v64:32-v128:32-a:0:32-v256:32-v512:32-n8:16:32"
target triple = "arc-pc-unknown-gnu"

@in = addrspace(4) global [2050 x i32] zeroinitializer, align 4
@out = addrspace(4) global [2048 x i32] zeroinitializer, align 4
@kernel = addrspace(4) global [3 x i32] zeroinitializer, align 4
@.str = private unnamed_addr constant [39 x i8] c"Tempo di esecuzione di conv1d: %.2fms\0A\00", align 1
@.str.2 = private unnamed_addr constant [23 x i8] c"Vettorizzo su %d lane\0A\00", align 1
@.str.3 = private unnamed_addr constant [50 x i8] c"Tempo di esecuzione di vectorized_conv1d: %.2fms\0A\00", align 1
@.str.4 = private unnamed_addr constant [15 x i8] c"Speedup: %.2f\0A\00", align 1
@.str.6 = private unnamed_addr constant [54 x i8] c"Tempo di esecuzione di autovectorized_conv1d: %.2fms\0A\00", align 1
@.str.8 = private unnamed_addr constant [44 x i8] c"Tempo di esecuzione di vekt_conv1d: %.2fms\0A\00", align 1
@str = private unnamed_addr constant [26 x i8] c"Versione autovettorizzata\00", align 1
@str.9 = private unnamed_addr constant [27 x i8] c"Versione vekt-vettorizzata\00", align 1

; Function Attrs: nounwind
define dso_local i32 @main() local_unnamed_addr #0 {
iter.check:
  %groundtruth = alloca [2048 x i32], align 4
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %iter.check
  %index = phi i32 [ 0, %iter.check ], [ %index.next.1, %vector.body ]
  %vec.ind = phi <16 x i16> [ <i16 0, i16 1, i16 2, i16 3, i16 4, i16 5, i16 6, i16 7, i16 8, i16 9, i16 10, i16 11, i16 12, i16 13, i16 14, i16 15>, %iter.check ], [ %vec.ind.next.1, %vector.body ]
  %step.add = add <16 x i16> %vec.ind, <i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16>
  %step.add67 = add <16 x i16> %vec.ind, <i16 32, i16 32, i16 32, i16 32, i16 32, i16 32, i16 32, i16 32, i16 32, i16 32, i16 32, i16 32, i16 32, i16 32, i16 32, i16 32>
  %step.add68 = add <16 x i16> %vec.ind, <i16 48, i16 48, i16 48, i16 48, i16 48, i16 48, i16 48, i16 48, i16 48, i16 48, i16 48, i16 48, i16 48, i16 48, i16 48, i16 48>
  %0 = urem <16 x i16> %vec.ind, <i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10>
  %1 = urem <16 x i16> %step.add, <i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10>
  %2 = urem <16 x i16> %step.add67, <i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10>
  %3 = urem <16 x i16> %step.add68, <i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10>
  %4 = zext <16 x i16> %0 to <16 x i32>
  %5 = zext <16 x i16> %1 to <16 x i32>
  %6 = zext <16 x i16> %2 to <16 x i32>
  %7 = zext <16 x i16> %3 to <16 x i32>
  %8 = getelementptr inbounds [2050 x i32], ptr addrspace(4) @in, i32 0, i32 %index
  store <16 x i32> %4, ptr addrspace(4) %8, align 4, !tbaa !3
  %9 = getelementptr inbounds i32, ptr addrspace(4) %8, i32 16
  store <16 x i32> %5, ptr addrspace(4) %9, align 4, !tbaa !3
  %10 = getelementptr inbounds i32, ptr addrspace(4) %8, i32 32
  store <16 x i32> %6, ptr addrspace(4) %10, align 4, !tbaa !3
  %11 = getelementptr inbounds i32, ptr addrspace(4) %8, i32 48
  store <16 x i32> %7, ptr addrspace(4) %11, align 4, !tbaa !3
  %index.next = add nuw nsw i32 %index, 64
  %vec.ind.next = add <16 x i16> %vec.ind, <i16 64, i16 64, i16 64, i16 64, i16 64, i16 64, i16 64, i16 64, i16 64, i16 64, i16 64, i16 64, i16 64, i16 64, i16 64, i16 64>
  %step.add.1 = add <16 x i16> %vec.ind, <i16 80, i16 80, i16 80, i16 80, i16 80, i16 80, i16 80, i16 80, i16 80, i16 80, i16 80, i16 80, i16 80, i16 80, i16 80, i16 80>
  %step.add67.1 = add <16 x i16> %vec.ind, <i16 96, i16 96, i16 96, i16 96, i16 96, i16 96, i16 96, i16 96, i16 96, i16 96, i16 96, i16 96, i16 96, i16 96, i16 96, i16 96>
  %step.add68.1 = add <16 x i16> %vec.ind, <i16 112, i16 112, i16 112, i16 112, i16 112, i16 112, i16 112, i16 112, i16 112, i16 112, i16 112, i16 112, i16 112, i16 112, i16 112, i16 112>
  %12 = urem <16 x i16> %vec.ind.next, <i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10>
  %13 = urem <16 x i16> %step.add.1, <i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10>
  %14 = urem <16 x i16> %step.add67.1, <i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10>
  %15 = urem <16 x i16> %step.add68.1, <i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10, i16 10>
  %16 = zext <16 x i16> %12 to <16 x i32>
  %17 = zext <16 x i16> %13 to <16 x i32>
  %18 = zext <16 x i16> %14 to <16 x i32>
  %19 = zext <16 x i16> %15 to <16 x i32>
  %20 = getelementptr inbounds [2050 x i32], ptr addrspace(4) @in, i32 0, i32 %index.next
  store <16 x i32> %16, ptr addrspace(4) %20, align 4, !tbaa !3
  %21 = getelementptr inbounds i32, ptr addrspace(4) %20, i32 16
  store <16 x i32> %17, ptr addrspace(4) %21, align 4, !tbaa !3
  %22 = getelementptr inbounds i32, ptr addrspace(4) %20, i32 32
  store <16 x i32> %18, ptr addrspace(4) %22, align 4, !tbaa !3
  %23 = getelementptr inbounds i32, ptr addrspace(4) %20, i32 48
  store <16 x i32> %19, ptr addrspace(4) %23, align 4, !tbaa !3
  %index.next.1 = add nuw nsw i32 %index, 128
  %vec.ind.next.1 = add <16 x i16> %vec.ind, <i16 128, i16 128, i16 128, i16 128, i16 128, i16 128, i16 128, i16 128, i16 128, i16 128, i16 128, i16 128, i16 128, i16 128, i16 128, i16 128>
  %24 = icmp eq i32 %index.next.1, 2048
  br i1 %24, label %vec.epilog.vector.body, label %vector.body, !llvm.loop !7

vec.epilog.vector.body:                           ; preds = %vector.body
  store <2 x i32> <i32 8, i32 9>, ptr addrspace(4) getelementptr inbounds ([2050 x i32], ptr addrspace(4) @in, i32 0, i32 2048), align 4, !tbaa !3
  tail call void @init_vector(ptr noundef addrspacecast (ptr addrspace(4) @out to ptr), i32 noundef 2048, i32 noundef 0) #5
  tail call void @init_vector(ptr noundef addrspacecast (ptr addrspace(4) @kernel to ptr), i32 noundef 3, i32 noundef 1) #5
  %call = tail call i32 @clock() #5
  tail call void @conv1d(i32 noundef 2048, i32 noundef 2050, i32 noundef 3, ptr noundef addrspacecast (ptr addrspace(4) @out to ptr), ptr noundef addrspacecast (ptr addrspace(4) @in to ptr), ptr noundef addrspacecast (ptr addrspace(4) @kernel to ptr)) #5
  %call1 = tail call i32 @clock() #5
  %sub = sub nsw i32 %call1, %call
  %conv = sitofp i32 %sub to double
  %call2 = tail call i32 @_timer_clocks_per_sec() #5
  %conv3 = uitofp i32 %call2 to double
  %25 = fmul fast double %conv, 1.000000e+03
  %mul = fdiv fast double %25, %conv3
  %call4 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, double noundef nofpclass(nan inf) %mul)
  %putchar = tail call i32 @putchar(i32 10)
  call void @llvm.lifetime.start.p0(i64 8192, ptr nonnull %groundtruth) #5
  call void @copy_vector(ptr noundef addrspacecast (ptr addrspace(4) @out to ptr), ptr noundef nonnull %groundtruth, i32 noundef 2048) #5
  %call6 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef 16)
  call void @init_vector(ptr noundef addrspacecast (ptr addrspace(4) @out to ptr), i32 noundef 2048, i32 noundef 0) #5
  %call7 = call i32 @clock() #5
  call void @vectorized_conv1d(i32 noundef 2048, i32 noundef 2050, i32 noundef 3, ptr addrspace(4) noundef @out, ptr addrspace(4) noundef @in, ptr addrspace(4) noundef @kernel) #5
  %call8 = call i32 @clock() #5
  %sub9 = sub nsw i32 %call8, %call7
  %conv10 = sitofp i32 %sub9 to double
  %call11 = call i32 @_timer_clocks_per_sec() #5
  %conv12 = uitofp i32 %call11 to double
  %26 = fmul fast double %conv10, 1.000000e+03
  %mul14 = fdiv fast double %26, %conv12
  %call15 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, double noundef nofpclass(nan inf) %mul14)
  %div16 = fdiv fast double %mul, %mul14
  %call17 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.4, double noundef nofpclass(nan inf) %div16)
  call void @check_result(ptr noundef addrspacecast (ptr addrspace(4) @out to ptr), ptr noundef nonnull %groundtruth, i32 noundef 2048) #5
  %putchar62 = call i32 @putchar(i32 10)
  %puts = call i32 @puts(ptr nonnull dereferenceable(1) @str)
  call void @init_vector(ptr noundef addrspacecast (ptr addrspace(4) @out to ptr), i32 noundef 2048, i32 noundef 0) #5
  %call21 = call i32 @clock() #5
  call void @autovectorized_conv1d(i32 noundef 2048, i32 noundef 2050, i32 noundef 3, ptr addrspace(4) noundef @out, ptr addrspace(4) noundef @in, ptr addrspace(4) noundef @kernel) #5
  %call22 = call i32 @clock() #5
  %sub23 = sub nsw i32 %call22, %call21
  %conv24 = sitofp i32 %sub23 to double
  %call25 = call i32 @_timer_clocks_per_sec() #5
  %conv26 = uitofp i32 %call25 to double
  %27 = fmul fast double %conv24, 1.000000e+03
  %mul28 = fdiv fast double %27, %conv26
  %call29 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.6, double noundef nofpclass(nan inf) %mul28)
  %div30 = fdiv fast double %mul, %mul28
  %call31 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.4, double noundef nofpclass(nan inf) %div30)
  call void @check_result(ptr noundef addrspacecast (ptr addrspace(4) @out to ptr), ptr noundef nonnull %groundtruth, i32 noundef 2048) #5
  %putchar63 = call i32 @putchar(i32 10)
  %puts64 = call i32 @puts(ptr nonnull dereferenceable(1) @str.9)
  call void @init_vector(ptr noundef addrspacecast (ptr addrspace(4) @out to ptr), i32 noundef 2048, i32 noundef 0) #5
  %call35 = call i32 @clock() #5
  call void @vekt_conv1d_wrapper(i32 noundef 2048, i32 noundef 2050, i32 noundef 3, ptr noundef addrspacecast (ptr addrspace(4) @out to ptr), ptr noundef addrspacecast (ptr addrspace(4) @in to ptr), ptr noundef addrspacecast (ptr addrspace(4) @kernel to ptr)) #5
  %call36 = call i32 @clock() #5
  %sub37 = sub nsw i32 %call36, %call35
  %conv38 = sitofp i32 %sub37 to double
  %call39 = call i32 @_timer_clocks_per_sec() #5
  %conv40 = uitofp i32 %call39 to double
  %28 = fmul fast double %conv38, 1.000000e+03
  %mul42 = fdiv fast double %28, %conv40
  %call43 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.8, double noundef nofpclass(nan inf) %mul42)
  %div44 = fdiv fast double %mul, %mul42
  %call45 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.4, double noundef nofpclass(nan inf) %div44)
  call void @check_result(ptr noundef addrspacecast (ptr addrspace(4) @out to ptr), ptr noundef nonnull %groundtruth, i32 noundef 2048) #5
  call void @llvm.lifetime.end.p0(i64 8192, ptr nonnull %groundtruth) #5
  ret i32 0
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

declare void @init_vector(ptr noundef, i32 noundef, i32 noundef) local_unnamed_addr #2

declare i32 @clock() local_unnamed_addr #2

declare void @conv1d(i32 noundef, i32 noundef, i32 noundef, ptr noundef, ptr noundef, ptr noundef) local_unnamed_addr #2

declare i32 @_timer_clocks_per_sec() local_unnamed_addr #2

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #3

declare void @copy_vector(ptr noundef, ptr noundef, i32 noundef) local_unnamed_addr #2

declare void @vectorized_conv1d(i32 noundef, i32 noundef, i32 noundef, ptr addrspace(4) noundef, ptr addrspace(4) noundef, ptr addrspace(4) noundef) local_unnamed_addr #2

declare void @check_result(ptr noundef, ptr noundef, i32 noundef) local_unnamed_addr #2

declare void @autovectorized_conv1d(i32 noundef, i32 noundef, i32 noundef, ptr addrspace(4) noundef, ptr addrspace(4) noundef, ptr addrspace(4) noundef) local_unnamed_addr #2

declare void @vekt_conv1d_wrapper(i32 noundef, i32 noundef, i32 noundef, ptr noundef, ptr noundef, ptr noundef) local_unnamed_addr #2

; Function Attrs: nofree nounwind
declare noundef i32 @putchar(i32 noundef) local_unnamed_addr #4

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #4

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
!7 = distinct !{!7, !8, !9, !10}
!8 = !{!"llvm.loop.mustprogress"}
!9 = !{!"llvm.loop.isvectorized", i32 1}
!10 = !{!"llvm.loop.unroll.runtime.disable"}
