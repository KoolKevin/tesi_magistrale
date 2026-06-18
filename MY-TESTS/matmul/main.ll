; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-f64:32-v64:32-v128:32-a:0:32-v256:32-v512:32-n8:16:32"
target triple = "arc-pc-unknown-gnu"

@.str.1 = private unnamed_addr constant [29 x i8] c"Tempo di esecuzione: %.2fms\0A\00", align 1
@.str.3 = private unnamed_addr constant [14 x i8] c"c[%d, %d]=%d\0A\00", align 1
@.str.6 = private unnamed_addr constant [55 x i8] c"Tempo di esecuzione di autovectorized_vec_sum: %.2fms\0A\00", align 1
@.str.7 = private unnamed_addr constant [15 x i8] c"Speedup: %.2f\0A\00", align 1
@str = private unnamed_addr constant [39 x i8] c"Errore nell'allocazione della memoria.\00", align 1
@str.9 = private unnamed_addr constant [26 x i8] c"Versione autovettorizzata\00", align 1
@str.10 = private unnamed_addr constant [42 x i8] c"Primi 5 elementi della matrice risultato:\00", align 1

; Function Attrs: nounwind
define dso_local i32 @main() local_unnamed_addr #0 {
entry:
  %0 = alloca [4096 x i8], align 16, addrspace(4)
  %1 = alloca [128 x i8], align 16, addrspace(4)
  %2 = alloca [128 x i8], align 16, addrspace(4)
  %tobool = icmp ne ptr addrspace(4) %0, null
  %tobool1 = icmp ne ptr addrspace(4) %1, null
  %or.cond = and i1 %tobool, %tobool1
  %tobool3 = icmp ne ptr addrspace(4) %2, null
  %or.cond42 = and i1 %or.cond, %tobool3
  br i1 %or.cond42, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  %puts = call i32 @puts(ptr nonnull dereferenceable(1) @str)
  br label %cleanup

if.end:                                           ; preds = %entry
  %3 = addrspacecast ptr addrspace(4) %0 to ptr
  call void @init_matrix(ptr noundef %3, i32 noundef 32, i32 noundef 32, i32 noundef 1) #4
  %4 = addrspacecast ptr addrspace(4) %1 to ptr
  call void @init_matrix(ptr noundef %4, i32 noundef 32, i32 noundef 1, i32 noundef 1) #4
  %5 = addrspacecast ptr addrspace(4) %2 to ptr
  call void @init_matrix(ptr noundef %5, i32 noundef 32, i32 noundef 1, i32 noundef 0) #4
  %call4 = call i32 @clock() #4
  call void @matmul(ptr noundef %3, ptr noundef %4, ptr noundef %5, i32 noundef 32, i32 noundef 1, i32 noundef 32) #4
  %call5 = call i32 @clock() #4
  %sub = sub nsw i32 %call5, %call4
  %conv = sitofp i32 %sub to double
  %call6 = call i32 @_timer_clocks_per_sec() #4
  %conv7 = uitofp i32 %call6 to double
  %6 = fmul fast double %conv, 1.000000e+03
  %mul = fdiv fast double %6, %conv7
  %call8 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.1, double noundef nofpclass(nan inf) %mul)
  %puts69 = call i32 @puts(ptr nonnull dereferenceable(1) @str.10)
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body
  %putchar = call i32 @putchar(i32 10)
  %puts70 = call i32 @puts(ptr nonnull dereferenceable(1) @str.9)
  call void @init_matrix(ptr noundef %5, i32 noundef 32, i32 noundef 1, i32 noundef 0) #4
  %call15 = call i32 @clock() #4
  call void @autovectorized_matmul(ptr addrspace(4) noundef nonnull %0, ptr addrspace(4) noundef nonnull %1, ptr addrspace(4) noundef nonnull %2, i32 noundef 32, i32 noundef 1, i32 noundef 32) #4
  %call16 = call i32 @clock() #4
  %sub17 = sub nsw i32 %call16, %call15
  %conv18 = sitofp i32 %sub17 to double
  %call19 = call i32 @_timer_clocks_per_sec() #4
  %conv20 = uitofp i32 %call19 to double
  %7 = fmul fast double %conv18, 1.000000e+03
  %mul22 = fdiv fast double %7, %conv20
  %call23 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.6, double noundef nofpclass(nan inf) %mul22)
  %div24 = fdiv fast double %mul, %mul22
  %call25 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.7, double noundef nofpclass(nan inf) %div24)
  %puts71 = call i32 @puts(ptr nonnull dereferenceable(1) @str.10)
  br label %for.body32

for.body:                                         ; preds = %if.end, %for.body
  %i.072 = phi i32 [ 0, %if.end ], [ %inc, %for.body ]
  %arrayidx = getelementptr inbounds i32, ptr addrspace(4) %2, i32 %i.072
  %8 = load i32, ptr addrspace(4) %arrayidx, align 4, !tbaa !3
  %call12 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, i32 noundef %i.072, i32 noundef 0, i32 noundef %8)
  %inc = add nuw nsw i32 %i.072, 1
  %cmp = icmp ult i32 %inc, 5
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !7

for.body32:                                       ; preds = %for.cond.cleanup, %for.body32
  %i27.073 = phi i32 [ 0, %for.cond.cleanup ], [ %inc38, %for.body32 ]
  %arrayidx35 = getelementptr inbounds i32, ptr addrspace(4) %2, i32 %i27.073
  %9 = load i32, ptr addrspace(4) %arrayidx35, align 4, !tbaa !3
  %call36 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, i32 noundef %i27.073, i32 noundef 0, i32 noundef %9)
  %inc38 = add nuw nsw i32 %i27.073, 1
  %cmp29 = icmp ult i32 %inc38, 5
  br i1 %cmp29, label %for.body32, label %cleanup, !llvm.loop !10

cleanup:                                          ; preds = %for.body32, %if.then
  %retval.0 = phi i32 [ 1, %if.then ], [ 0, %for.body32 ]
  ret i32 %retval.0
}

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #1

declare void @init_matrix(ptr noundef, i32 noundef, i32 noundef, i32 noundef) local_unnamed_addr #2

declare i32 @clock() local_unnamed_addr #2

declare void @matmul(ptr noundef, ptr noundef, ptr noundef, i32 noundef, i32 noundef, i32 noundef) local_unnamed_addr #2

declare i32 @_timer_clocks_per_sec() local_unnamed_addr #2

declare void @autovectorized_matmul(ptr addrspace(4) noundef, ptr addrspace(4) noundef, ptr addrspace(4) noundef, i32 noundef, i32 noundef, i32 noundef) local_unnamed_addr #2

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #3

; Function Attrs: nofree nounwind
declare noundef i32 @putchar(i32 noundef) local_unnamed_addr #3

attributes #0 = { nounwind "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #1 = { nofree nounwind "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #2 = { "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
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
!7 = distinct !{!7, !8, !9, !9}
!8 = !{!"llvm.loop.mustprogress"}
!9 = !{!"llvm.loop.unroll.disable"}
!10 = distinct !{!10, !8, !9, !9}
