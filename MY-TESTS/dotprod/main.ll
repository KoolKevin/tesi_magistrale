; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-f64:32-v64:32-v128:32-a:0:32-v256:32-v512:32-n8:16:32"
target triple = "arc-pc-unknown-gnu"

@.str.1 = private unnamed_addr constant [6 x i8] c"hello\00", align 1
@.str.3 = private unnamed_addr constant [29 x i8] c"Tempo di esecuzione: %.2fms\0A\00", align 1
@.str.4 = private unnamed_addr constant [15 x i8] c"Risultato: %d\0A\00", align 1
@.str.7 = private unnamed_addr constant [47 x i8] c"Tempo di esecuzione di autovectorized: %.2fms\0A\00", align 1
@.str.8 = private unnamed_addr constant [15 x i8] c"Speedup: %.2f\0A\00", align 1
@str = private unnamed_addr constant [39 x i8] c"Errore nell'allocazione della memoria.\00", align 1
@str.9 = private unnamed_addr constant [26 x i8] c"Versione autovettorizzata\00", align 1

; Function Attrs: nounwind
define dso_local i32 @main() local_unnamed_addr #0 {
entry:
  %puts = tail call i32 @puts(ptr nonnull dereferenceable(1) @.str.1)
  %0 = alloca [4096 x i8], align 16, addrspace(4)
  %1 = alloca [4096 x i8], align 16, addrspace(4)
  %tobool = icmp ne ptr addrspace(4) %0, null
  %tobool1 = icmp ne ptr addrspace(4) %1, null
  %or.cond = and i1 %tobool, %tobool1
  br i1 %or.cond, label %vector.body.preheader, label %if.then

vector.body.preheader:                            ; preds = %entry
  br label %vector.body

if.then:                                          ; preds = %entry
  %puts43 = call i32 @puts(ptr nonnull dereferenceable(1) @str)
  br label %cleanup

vector.body:                                      ; preds = %vector.body.preheader, %vector.body
  %index = phi i32 [ %index.next, %vector.body ], [ 0, %vector.body.preheader ]
  %2 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 %index
  store <16 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>, ptr addrspace(4) %2, align 16, !tbaa !3
  %3 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 %index
  store <16 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>, ptr addrspace(4) %3, align 16, !tbaa !3
  %index.next = add nuw i32 %index, 16
  %4 = icmp eq i32 %index.next, 1024
  br i1 %4, label %for.cond.cleanup, label %vector.body, !llvm.loop !7

for.cond.cleanup:                                 ; preds = %vector.body
  %call4 = call i32 @clock() #4
  %5 = addrspacecast ptr addrspace(4) %0 to ptr
  %6 = addrspacecast ptr addrspace(4) %1 to ptr
  %call5 = call i32 @dotp(ptr noundef %5, ptr noundef %6, i32 noundef 1024) #4
  %call6 = call i32 @clock() #4
  %sub = sub nsw i32 %call6, %call4
  %conv = sitofp i32 %sub to double
  %call7 = call i32 @_timer_clocks_per_sec() #4
  %conv8 = uitofp i32 %call7 to double
  %7 = fmul fast double %conv, 1.000000e+03
  %mul = fdiv fast double %7, %conv8
  %call9 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, double noundef nofpclass(nan inf) %mul)
  %call10 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.4, i32 noundef %call5)
  %putchar = call i32 @putchar(i32 10)
  %putchar44 = call i32 @putchar(i32 10)
  %puts45 = call i32 @puts(ptr nonnull dereferenceable(1) @str.9)
  %call14 = call i32 @clock() #4
  %call15 = call i32 @autovectorized_dotp(ptr addrspace(4) noundef nonnull %0, ptr addrspace(4) noundef nonnull %1, i32 noundef 1024) #4
  %call16 = call i32 @clock() #4
  %sub17 = sub nsw i32 %call16, %call14
  %conv18 = sitofp i32 %sub17 to double
  %call19 = call i32 @_timer_clocks_per_sec() #4
  %conv20 = uitofp i32 %call19 to double
  %8 = fmul fast double %conv18, 1.000000e+03
  %mul22 = fdiv fast double %8, %conv20
  %call23 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.7, double noundef nofpclass(nan inf) %mul22)
  %div24 = fdiv fast double %mul, %mul22
  %call25 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.8, double noundef nofpclass(nan inf) %div24)
  %call26 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.4, i32 noundef %call15)
  br label %cleanup

cleanup:                                          ; preds = %for.cond.cleanup, %if.then
  %retval.0 = phi i32 [ 0, %for.cond.cleanup ], [ 1, %if.then ]
  ret i32 %retval.0
}

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #1

declare i32 @clock() local_unnamed_addr #2

declare i32 @dotp(ptr noundef, ptr noundef, i32 noundef) local_unnamed_addr #2

declare i32 @_timer_clocks_per_sec() local_unnamed_addr #2

declare i32 @autovectorized_dotp(ptr addrspace(4) noundef, ptr addrspace(4) noundef, i32 noundef) local_unnamed_addr #2

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
!7 = distinct !{!7, !8, !9, !9, !10, !11}
!8 = !{!"llvm.loop.mustprogress"}
!9 = !{!"llvm.loop.unroll.disable"}
!10 = !{!"llvm.loop.isvectorized", i32 1}
!11 = !{!"llvm.loop.unroll.runtime.disable"}
