; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-f64:32-v64:32-v128:32-a:0:32-v256:32-v512:32-n8:16:32"
target triple = "arc-pc-unknown-gnu"

@.str.1 = private unnamed_addr constant [29 x i8] c"Tempo di esecuzione: %.2fms\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"Risultato: %d\0A\00", align 1
@.str.4 = private unnamed_addr constant [23 x i8] c"Vettorizzo su %d lane\0A\00", align 1
@.str.5 = private unnamed_addr constant [40 x i8] c"Tempo di esecuzione vectorized: %.2fms\0A\00", align 1
@.str.6 = private unnamed_addr constant [15 x i8] c"Speedup: %.2f\0A\00", align 1
@.str.8 = private unnamed_addr constant [47 x i8] c"Tempo di esecuzione di autovectorized: %.2fms\0A\00", align 1
@str = private unnamed_addr constant [39 x i8] c"Errore nell'allocazione della memoria.\00", align 1
@str.9 = private unnamed_addr constant [26 x i8] c"Versione autovettorizzata\00", align 1

; Function Attrs: nounwind
define dso_local i32 @main() local_unnamed_addr #0 {
entry:
  %0 = alloca [4096 x i8], align 16, addrspace(4)
  %1 = alloca [4096 x i8], align 16, addrspace(4)
  %tobool = icmp ne ptr addrspace(4) %0, null
  %tobool1 = icmp ne ptr addrspace(4) %1, null
  %or.cond = and i1 %tobool, %tobool1
  br i1 %or.cond, label %vector.body.preheader, label %if.then

vector.body.preheader:                            ; preds = %entry
  br label %vector.body

if.then:                                          ; preds = %entry
  %puts = call i32 @puts(ptr nonnull dereferenceable(1) @str)
  br label %cleanup

vector.body:                                      ; preds = %vector.body, %vector.body.preheader
  %index = phi i32 [ 0, %vector.body.preheader ], [ %index.next.1, %vector.body ]
  %vec.ind = phi <16 x i32> [ <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>, %vector.body.preheader ], [ %vec.ind.next.1, %vector.body ]
  %step.add = add <16 x i32> %vec.ind, <i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16>
  %step.add69 = add <16 x i32> %vec.ind, <i32 32, i32 32, i32 32, i32 32, i32 32, i32 32, i32 32, i32 32, i32 32, i32 32, i32 32, i32 32, i32 32, i32 32, i32 32, i32 32>
  %step.add70 = add <16 x i32> %vec.ind, <i32 48, i32 48, i32 48, i32 48, i32 48, i32 48, i32 48, i32 48, i32 48, i32 48, i32 48, i32 48, i32 48, i32 48, i32 48, i32 48>
  %2 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 %index
  store <16 x i32> %vec.ind, ptr addrspace(4) %2, align 16, !tbaa !3
  %3 = getelementptr inbounds i32, ptr addrspace(4) %2, i32 16
  store <16 x i32> %step.add, ptr addrspace(4) %3, align 16, !tbaa !3
  %4 = getelementptr inbounds i32, ptr addrspace(4) %2, i32 32
  store <16 x i32> %step.add69, ptr addrspace(4) %4, align 16, !tbaa !3
  %5 = getelementptr inbounds i32, ptr addrspace(4) %2, i32 48
  store <16 x i32> %step.add70, ptr addrspace(4) %5, align 16, !tbaa !3
  %6 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 %index
  store <16 x i32> %vec.ind, ptr addrspace(4) %6, align 16, !tbaa !3
  %7 = getelementptr inbounds i32, ptr addrspace(4) %6, i32 16
  store <16 x i32> %step.add, ptr addrspace(4) %7, align 16, !tbaa !3
  %8 = getelementptr inbounds i32, ptr addrspace(4) %6, i32 32
  store <16 x i32> %step.add69, ptr addrspace(4) %8, align 16, !tbaa !3
  %9 = getelementptr inbounds i32, ptr addrspace(4) %6, i32 48
  store <16 x i32> %step.add70, ptr addrspace(4) %9, align 16, !tbaa !3
  %index.next = add nuw nsw i32 %index, 64
  %vec.ind.next = add <16 x i32> %vec.ind, <i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64>
  %step.add.1 = add <16 x i32> %vec.ind, <i32 80, i32 80, i32 80, i32 80, i32 80, i32 80, i32 80, i32 80, i32 80, i32 80, i32 80, i32 80, i32 80, i32 80, i32 80, i32 80>
  %step.add69.1 = add <16 x i32> %vec.ind, <i32 96, i32 96, i32 96, i32 96, i32 96, i32 96, i32 96, i32 96, i32 96, i32 96, i32 96, i32 96, i32 96, i32 96, i32 96, i32 96>
  %step.add70.1 = add <16 x i32> %vec.ind, <i32 112, i32 112, i32 112, i32 112, i32 112, i32 112, i32 112, i32 112, i32 112, i32 112, i32 112, i32 112, i32 112, i32 112, i32 112, i32 112>
  %10 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 %index.next
  store <16 x i32> %vec.ind.next, ptr addrspace(4) %10, align 16, !tbaa !3
  %11 = getelementptr inbounds i32, ptr addrspace(4) %10, i32 16
  store <16 x i32> %step.add.1, ptr addrspace(4) %11, align 16, !tbaa !3
  %12 = getelementptr inbounds i32, ptr addrspace(4) %10, i32 32
  store <16 x i32> %step.add69.1, ptr addrspace(4) %12, align 16, !tbaa !3
  %13 = getelementptr inbounds i32, ptr addrspace(4) %10, i32 48
  store <16 x i32> %step.add70.1, ptr addrspace(4) %13, align 16, !tbaa !3
  %14 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 %index.next
  store <16 x i32> %vec.ind.next, ptr addrspace(4) %14, align 16, !tbaa !3
  %15 = getelementptr inbounds i32, ptr addrspace(4) %14, i32 16
  store <16 x i32> %step.add.1, ptr addrspace(4) %15, align 16, !tbaa !3
  %16 = getelementptr inbounds i32, ptr addrspace(4) %14, i32 32
  store <16 x i32> %step.add69.1, ptr addrspace(4) %16, align 16, !tbaa !3
  %17 = getelementptr inbounds i32, ptr addrspace(4) %14, i32 48
  store <16 x i32> %step.add70.1, ptr addrspace(4) %17, align 16, !tbaa !3
  %index.next.1 = add nuw nsw i32 %index, 128
  %vec.ind.next.1 = add <16 x i32> %vec.ind, <i32 128, i32 128, i32 128, i32 128, i32 128, i32 128, i32 128, i32 128, i32 128, i32 128, i32 128, i32 128, i32 128, i32 128, i32 128, i32 128>
  %18 = icmp eq i32 %index.next.1, 1024
  br i1 %18, label %for.cond.cleanup, label %vector.body, !llvm.loop !7

for.cond.cleanup:                                 ; preds = %vector.body
  %call3 = call i32 @clock() #4
  %19 = addrspacecast ptr addrspace(4) %0 to ptr
  %20 = addrspacecast ptr addrspace(4) %1 to ptr
  %call4 = call i32 @dotp(ptr noundef %19, ptr noundef %20, i32 noundef 1024) #4
  %call5 = call i32 @clock() #4
  %sub = sub nsw i32 %call5, %call3
  %conv = sitofp i32 %sub to double
  %call6 = call i32 @_timer_clocks_per_sec() #4
  %conv7 = uitofp i32 %call6 to double
  %21 = fmul fast double %conv, 1.000000e+03
  %mul = fdiv fast double %21, %conv7
  %call8 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.1, double noundef nofpclass(nan inf) %mul)
  %call9 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef %call4)
  %putchar = call i32 @putchar(i32 10)
  %call11 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.4, i32 noundef 16)
  %call12 = call i32 @clock() #4
  %call13 = call i32 @vectorized_dotp(ptr addrspace(4) noundef nonnull %0, ptr addrspace(4) noundef nonnull %1, i32 noundef 1024) #4
  %call14 = call i32 @clock() #4
  %sub15 = sub nsw i32 %call14, %call12
  %conv16 = sitofp i32 %sub15 to double
  %call17 = call i32 @_timer_clocks_per_sec() #4
  %conv18 = uitofp i32 %call17 to double
  %22 = fmul fast double %conv16, 1.000000e+03
  %mul20 = fdiv fast double %22, %conv18
  %call21 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, double noundef nofpclass(nan inf) %mul20)
  %div22 = fdiv fast double %mul, %mul20
  %call23 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.6, double noundef nofpclass(nan inf) %div22)
  %call24 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef %call13)
  %putchar65 = call i32 @putchar(i32 10)
  %puts66 = call i32 @puts(ptr nonnull dereferenceable(1) @str.9)
  %call27 = call i32 @clock() #4
  %call28 = call i32 @autovectorized_dotp(ptr addrspace(4) noundef nonnull %0, ptr addrspace(4) noundef nonnull %1, i32 noundef 1024) #4
  %call29 = call i32 @clock() #4
  %sub30 = sub nsw i32 %call29, %call27
  %conv31 = sitofp i32 %sub30 to double
  %call32 = call i32 @_timer_clocks_per_sec() #4
  %conv33 = uitofp i32 %call32 to double
  %23 = fmul fast double %conv31, 1.000000e+03
  %mul35 = fdiv fast double %23, %conv33
  %call36 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.8, double noundef nofpclass(nan inf) %mul35)
  %div37 = fdiv fast double %mul, %mul35
  %call38 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.6, double noundef nofpclass(nan inf) %div37)
  %call39 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef %call28)
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

declare i32 @vectorized_dotp(ptr addrspace(4) noundef, ptr addrspace(4) noundef, i32 noundef) local_unnamed_addr #2

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
!7 = distinct !{!7, !8, !9, !10}
!8 = !{!"llvm.loop.mustprogress"}
!9 = !{!"llvm.loop.isvectorized", i32 1}
!10 = !{!"llvm.loop.unroll.runtime.disable"}
