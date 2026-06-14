; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-f64:32-v64:32-v128:32-a:0:32-v256:32-v512:32-n8:16:32"
target triple = "arc-pc-unknown-gnu"

@.str.1 = private unnamed_addr constant [6 x i8] c"hello\00", align 1
@.str.3 = private unnamed_addr constant [40 x i8] c"Tempo di esecuzione di vec_sum: %.2fms\0A\00", align 1
@.str.5 = private unnamed_addr constant [30 x i8] c"a[%d]=%d, b[%d]=%d, c[%d]=%d\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"Vettorizzo su %d lane\0A\00", align 1
@.str.8 = private unnamed_addr constant [51 x i8] c"Tempo di esecuzione di vectorized_vec_sum: %.2fms\0A\00", align 1
@.str.9 = private unnamed_addr constant [15 x i8] c"Speedup: %.2f\0A\00", align 1
@str = private unnamed_addr constant [39 x i8] c"Errore nell'allocazione della memoria.\00", align 1
@str.11 = private unnamed_addr constant [30 x i8] c"Primi 5 elementi della somma:\00", align 1

; Function Attrs: nounwind
define dso_local i32 @main() local_unnamed_addr #0 {
entry:
  %puts = tail call i32 @puts(ptr nonnull dereferenceable(1) @.str.1)
  %0 = alloca [4096 x i8], align 16, addrspace(4)
  %1 = alloca [4096 x i8], align 16, addrspace(4)
  %2 = alloca [4096 x i8], align 16, addrspace(4)
  %tobool = icmp ne ptr addrspace(4) %0, null
  %tobool1 = icmp ne ptr addrspace(4) %1, null
  %or.cond = and i1 %tobool, %tobool1
  %tobool3 = icmp ne ptr addrspace(4) %2, null
  %or.cond55 = and i1 %or.cond, %tobool3
  br i1 %or.cond55, label %for.body.preheader, label %if.then

for.body.preheader:                               ; preds = %entry
  br label %for.body

if.then:                                          ; preds = %entry
  %puts95 = call i32 @puts(ptr nonnull dereferenceable(1) @str)
  br label %cleanup

for.cond.cleanup:                                 ; preds = %for.body
  %call7 = call i32 @clock() #4
  %3 = addrspacecast ptr addrspace(4) %0 to ptr
  %4 = addrspacecast ptr addrspace(4) %1 to ptr
  %5 = addrspacecast ptr addrspace(4) %2 to ptr
  call void @vec_sum(ptr noundef %3, ptr noundef %4, ptr noundef %5, i32 noundef 1024) #4
  %call8 = call i32 @clock() #4
  %sub = sub nsw i32 %call8, %call7
  %conv = sitofp i32 %sub to double
  %call9 = call i32 @_timer_clocks_per_sec() #4
  %conv10 = uitofp i32 %call9 to double
  %div = fdiv contract double %conv, %conv10
  %mul = fmul contract double %div, 1.000000e+03
  %call11 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, double noundef %mul)
  %puts96 = call i32 @puts(ptr nonnull dereferenceable(1) @str.11)
  %6 = load i32, ptr addrspace(4) %0, align 16, !tbaa !3
  %7 = load i32, ptr addrspace(4) %1, align 16, !tbaa !3
  %8 = load i32, ptr addrspace(4) %2, align 16, !tbaa !3
  %call22 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, i32 noundef 0, i32 noundef %6, i32 noundef 0, i32 noundef %7, i32 noundef 0, i32 noundef %8)
  %arrayidx19.1 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 1
  %9 = load i32, ptr addrspace(4) %arrayidx19.1, align 4, !tbaa !3
  %arrayidx20.1 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 1
  %10 = load i32, ptr addrspace(4) %arrayidx20.1, align 4, !tbaa !3
  %arrayidx21.1 = getelementptr inbounds i32, ptr addrspace(4) %2, i32 1
  %11 = load i32, ptr addrspace(4) %arrayidx21.1, align 4, !tbaa !3
  %call22.1 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, i32 noundef 1, i32 noundef %9, i32 noundef 1, i32 noundef %10, i32 noundef 1, i32 noundef %11)
  %arrayidx19.2 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 2
  %12 = load i32, ptr addrspace(4) %arrayidx19.2, align 8, !tbaa !3
  %arrayidx20.2 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 2
  %13 = load i32, ptr addrspace(4) %arrayidx20.2, align 8, !tbaa !3
  %arrayidx21.2 = getelementptr inbounds i32, ptr addrspace(4) %2, i32 2
  %14 = load i32, ptr addrspace(4) %arrayidx21.2, align 8, !tbaa !3
  %call22.2 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, i32 noundef 2, i32 noundef %12, i32 noundef 2, i32 noundef %13, i32 noundef 2, i32 noundef %14)
  %arrayidx19.3 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 3
  %15 = load i32, ptr addrspace(4) %arrayidx19.3, align 4, !tbaa !3
  %arrayidx20.3 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 3
  %16 = load i32, ptr addrspace(4) %arrayidx20.3, align 4, !tbaa !3
  %arrayidx21.3 = getelementptr inbounds i32, ptr addrspace(4) %2, i32 3
  %17 = load i32, ptr addrspace(4) %arrayidx21.3, align 4, !tbaa !3
  %call22.3 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, i32 noundef 3, i32 noundef %15, i32 noundef 3, i32 noundef %16, i32 noundef 3, i32 noundef %17)
  %arrayidx19.4 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 4
  %18 = load i32, ptr addrspace(4) %arrayidx19.4, align 16, !tbaa !3
  %arrayidx20.4 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 4
  %19 = load i32, ptr addrspace(4) %arrayidx20.4, align 16, !tbaa !3
  %arrayidx21.4 = getelementptr inbounds i32, ptr addrspace(4) %2, i32 4
  %20 = load i32, ptr addrspace(4) %arrayidx21.4, align 16, !tbaa !3
  %call22.4 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, i32 noundef 4, i32 noundef %18, i32 noundef 4, i32 noundef %19, i32 noundef 4, i32 noundef %20)
  %putchar = call i32 @putchar(i32 10)
  %call27 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.7, i32 noundef 16)
  %call28 = call i32 @clock() #4
  call void @vectorized_vec_sum(ptr addrspace(4) noundef nonnull %0, ptr addrspace(4) noundef nonnull %1, ptr addrspace(4) noundef nonnull %2, i32 noundef 1024) #4
  %call29 = call i32 @clock() #4
  %sub30 = sub nsw i32 %call29, %call28
  %conv31 = sitofp i32 %sub30 to double
  %call32 = call i32 @_timer_clocks_per_sec() #4
  %conv33 = uitofp i32 %call32 to double
  %div34 = fdiv contract double %conv31, %conv33
  %mul35 = fmul contract double %div34, 1.000000e+03
  %call36 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.8, double noundef %mul35)
  %div37 = fdiv contract double %mul, %mul35
  %call38 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.9, double noundef %div37)
  %puts97 = call i32 @puts(ptr nonnull dereferenceable(1) @str.11)
  %21 = load i32, ptr addrspace(4) %0, align 16, !tbaa !3
  %22 = load i32, ptr addrspace(4) %1, align 16, !tbaa !3
  %23 = load i32, ptr addrspace(4) %2, align 16, !tbaa !3
  %call49 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, i32 noundef 0, i32 noundef %21, i32 noundef 0, i32 noundef %22, i32 noundef 0, i32 noundef %23)
  %24 = load i32, ptr addrspace(4) %arrayidx19.1, align 4, !tbaa !3
  %25 = load i32, ptr addrspace(4) %arrayidx20.1, align 4, !tbaa !3
  %26 = load i32, ptr addrspace(4) %arrayidx21.1, align 4, !tbaa !3
  %call49.1 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, i32 noundef 1, i32 noundef %24, i32 noundef 1, i32 noundef %25, i32 noundef 1, i32 noundef %26)
  %27 = load i32, ptr addrspace(4) %arrayidx19.2, align 8, !tbaa !3
  %28 = load i32, ptr addrspace(4) %arrayidx20.2, align 8, !tbaa !3
  %29 = load i32, ptr addrspace(4) %arrayidx21.2, align 8, !tbaa !3
  %call49.2 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, i32 noundef 2, i32 noundef %27, i32 noundef 2, i32 noundef %28, i32 noundef 2, i32 noundef %29)
  %30 = load i32, ptr addrspace(4) %arrayidx19.3, align 4, !tbaa !3
  %31 = load i32, ptr addrspace(4) %arrayidx20.3, align 4, !tbaa !3
  %32 = load i32, ptr addrspace(4) %arrayidx21.3, align 4, !tbaa !3
  %call49.3 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, i32 noundef 3, i32 noundef %30, i32 noundef 3, i32 noundef %31, i32 noundef 3, i32 noundef %32)
  %33 = load i32, ptr addrspace(4) %arrayidx19.4, align 16, !tbaa !3
  %34 = load i32, ptr addrspace(4) %arrayidx20.4, align 16, !tbaa !3
  %35 = load i32, ptr addrspace(4) %arrayidx21.4, align 16, !tbaa !3
  %call49.4 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, i32 noundef 4, i32 noundef %33, i32 noundef 4, i32 noundef %34, i32 noundef 4, i32 noundef %35)
  br label %cleanup

for.body:                                         ; preds = %for.body, %for.body.preheader
  %i.098 = phi i32 [ 0, %for.body.preheader ], [ %add.1, %for.body ]
  %add = add nuw nsw i32 %i.098, 1
  %arrayidx = getelementptr inbounds i32, ptr addrspace(4) %0, i32 %i.098
  store i32 %add, ptr addrspace(4) %arrayidx, align 8, !tbaa !3
  %arrayidx6 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 %i.098
  store i32 %add, ptr addrspace(4) %arrayidx6, align 8, !tbaa !3
  %add.1 = add nuw nsw i32 %i.098, 2
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 %add
  store i32 %add.1, ptr addrspace(4) %arrayidx.1, align 4, !tbaa !3
  %arrayidx6.1 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 %add
  store i32 %add.1, ptr addrspace(4) %arrayidx6.1, align 4, !tbaa !3
  %cmp.1 = icmp ult i32 %add.1, 1024
  br i1 %cmp.1, label %for.body, label %for.cond.cleanup, !llvm.loop !7

cleanup:                                          ; preds = %for.cond.cleanup, %if.then
  %retval.0 = phi i32 [ 1, %if.then ], [ 0, %for.cond.cleanup ]
  ret i32 %retval.0
}

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #1

declare i32 @clock() local_unnamed_addr #2

declare void @vec_sum(ptr noundef, ptr noundef, ptr noundef, i32 noundef) local_unnamed_addr #2

declare i32 @_timer_clocks_per_sec() local_unnamed_addr #2

declare void @vectorized_vec_sum(ptr addrspace(4) noundef, ptr addrspace(4) noundef, ptr addrspace(4) noundef, i32 noundef) local_unnamed_addr #2

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #3

; Function Attrs: nofree nounwind
declare noundef i32 @putchar(i32 noundef) local_unnamed_addr #3

attributes #0 = { nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" }
attributes #1 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" }
attributes #2 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" }
attributes #3 = { nofree nounwind }
attributes #4 = { nounwind }

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
