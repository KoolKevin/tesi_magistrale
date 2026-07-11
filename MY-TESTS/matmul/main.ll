; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-f64:32-v64:32-v128:32-a:0:32-v256:32-v512:32-n8:16:32"
target triple = "arc-pc-unknown-gnu"

@a = addrspace(4) global [256 x i32] zeroinitializer, align 4
@b = addrspace(4) global [256 x i32] zeroinitializer, align 4
@c = addrspace(4) global [256 x i32] zeroinitializer, align 4
@.str = private unnamed_addr constant [29 x i8] c"Tempo di esecuzione: %.2fms\0A\00", align 1
@.str.2 = private unnamed_addr constant [14 x i8] c"c[%d, %d]=%d\0A\00", align 1
@.str.4 = private unnamed_addr constant [23 x i8] c"Vettorizzo su %d lane\0A\00", align 1
@.str.5 = private unnamed_addr constant [51 x i8] c"Tempo di esecuzione di vectorized_vec_sum: %.2fms\0A\00", align 1
@.str.6 = private unnamed_addr constant [15 x i8] c"Speedup: %.2f\0A\00", align 1
@.str.8 = private unnamed_addr constant [55 x i8] c"Tempo di esecuzione di autovectorized_vec_sum: %.2fms\0A\00", align 1
@str.10 = private unnamed_addr constant [26 x i8] c"Versione autovettorizzata\00", align 1
@str.11 = private unnamed_addr constant [42 x i8] c"Primi 5 elementi della matrice risultato:\00", align 1

; Function Attrs: nounwind
define dso_local i32 @main() local_unnamed_addr #0 {
entry:
  tail call void @init_matrix(ptr noundef addrspacecast (ptr addrspace(4) @a to ptr), i32 noundef 16, i32 noundef 16, i32 noundef 1) #4
  tail call void @init_matrix(ptr noundef addrspacecast (ptr addrspace(4) @b to ptr), i32 noundef 16, i32 noundef 16, i32 noundef 1) #4
  tail call void @init_matrix(ptr noundef addrspacecast (ptr addrspace(4) @c to ptr), i32 noundef 16, i32 noundef 16, i32 noundef 0) #4
  %call = tail call i32 @clock() #4
  tail call void @matmul(ptr noundef addrspacecast (ptr addrspace(4) @a to ptr), ptr noundef addrspacecast (ptr addrspace(4) @b to ptr), ptr noundef addrspacecast (ptr addrspace(4) @c to ptr), i32 noundef 16, i32 noundef 16, i32 noundef 16) #4
  %call1 = tail call i32 @clock() #4
  %sub = sub nsw i32 %call1, %call
  %conv = sitofp i32 %sub to double
  %call2 = tail call i32 @_timer_clocks_per_sec() #4
  %conv3 = uitofp i32 %call2 to double
  %0 = fmul fast double %conv, 1.000000e+03
  %mul = fdiv fast double %0, %conv3
  %call4 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, double noundef nofpclass(nan inf) %mul)
  %puts = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.11)
  %1 = load i32, ptr addrspace(4) @c, align 4, !tbaa !3
  %call8 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef 0, i32 noundef 0, i32 noundef %1)
  %2 = load i32, ptr addrspace(4) getelementptr inbounds ([256 x i32], ptr addrspace(4) @c, i32 0, i32 1), align 4, !tbaa !3
  %call8.1 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef 0, i32 noundef 1, i32 noundef %2)
  %3 = load i32, ptr addrspace(4) getelementptr inbounds ([256 x i32], ptr addrspace(4) @c, i32 0, i32 2), align 4, !tbaa !3
  %call8.2 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef 0, i32 noundef 2, i32 noundef %3)
  %4 = load i32, ptr addrspace(4) getelementptr inbounds ([256 x i32], ptr addrspace(4) @c, i32 0, i32 3), align 4, !tbaa !3
  %call8.3 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef 0, i32 noundef 3, i32 noundef %4)
  %5 = load i32, ptr addrspace(4) getelementptr inbounds ([256 x i32], ptr addrspace(4) @c, i32 0, i32 4), align 4, !tbaa !3
  %call8.4 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef 0, i32 noundef 4, i32 noundef %5)
  %putchar = tail call i32 @putchar(i32 10)
  %call10 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.4, i32 noundef 16)
  tail call void @init_matrix(ptr noundef addrspacecast (ptr addrspace(4) @c to ptr), i32 noundef 16, i32 noundef 16, i32 noundef 0) #4
  %call11 = tail call i32 @clock() #4
  tail call void @vectorized_matmul(ptr addrspace(4) noundef @a, ptr addrspace(4) noundef @b, ptr addrspace(4) noundef @c, i32 noundef 16, i32 noundef 16, i32 noundef 16) #4
  %call12 = tail call i32 @clock() #4
  %sub13 = sub nsw i32 %call12, %call11
  %conv14 = sitofp i32 %sub13 to double
  %call15 = tail call i32 @_timer_clocks_per_sec() #4
  %conv16 = uitofp i32 %call15 to double
  %6 = fmul fast double %conv14, 1.000000e+03
  %mul18 = fdiv fast double %6, %conv16
  %call19 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, double noundef nofpclass(nan inf) %mul18)
  %div20 = fdiv fast double %mul, %mul18
  %call21 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.6, double noundef nofpclass(nan inf) %div20)
  %puts83 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.11)
  %7 = load i32, ptr addrspace(4) @c, align 4, !tbaa !3
  %call32 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef 0, i32 noundef 0, i32 noundef %7)
  %8 = load i32, ptr addrspace(4) getelementptr inbounds ([256 x i32], ptr addrspace(4) @c, i32 0, i32 1), align 4, !tbaa !3
  %call32.1 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef 0, i32 noundef 1, i32 noundef %8)
  %9 = load i32, ptr addrspace(4) getelementptr inbounds ([256 x i32], ptr addrspace(4) @c, i32 0, i32 2), align 4, !tbaa !3
  %call32.2 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef 0, i32 noundef 2, i32 noundef %9)
  %10 = load i32, ptr addrspace(4) getelementptr inbounds ([256 x i32], ptr addrspace(4) @c, i32 0, i32 3), align 4, !tbaa !3
  %call32.3 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef 0, i32 noundef 3, i32 noundef %10)
  %11 = load i32, ptr addrspace(4) getelementptr inbounds ([256 x i32], ptr addrspace(4) @c, i32 0, i32 4), align 4, !tbaa !3
  %call32.4 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef 0, i32 noundef 4, i32 noundef %11)
  %putchar84 = tail call i32 @putchar(i32 10)
  %puts85 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.10)
  tail call void @init_matrix(ptr noundef addrspacecast (ptr addrspace(4) @c to ptr), i32 noundef 16, i32 noundef 16, i32 noundef 0) #4
  %call38 = tail call i32 @clock() #4
  tail call void @autovectorized_matmul(ptr addrspace(4) noundef @a, ptr addrspace(4) noundef @b, ptr addrspace(4) noundef @c, i32 noundef 16, i32 noundef 16, i32 noundef 16) #4
  %call39 = tail call i32 @clock() #4
  %sub40 = sub nsw i32 %call39, %call38
  %conv41 = sitofp i32 %sub40 to double
  %call42 = tail call i32 @_timer_clocks_per_sec() #4
  %conv43 = uitofp i32 %call42 to double
  %12 = fmul fast double %conv41, 1.000000e+03
  %mul45 = fdiv fast double %12, %conv43
  %call46 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.8, double noundef nofpclass(nan inf) %mul45)
  %div47 = fdiv fast double %mul, %mul45
  %call48 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.6, double noundef nofpclass(nan inf) %div47)
  %puts86 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.11)
  %13 = load i32, ptr addrspace(4) @c, align 4, !tbaa !3
  %call59 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef 0, i32 noundef 0, i32 noundef %13)
  %14 = load i32, ptr addrspace(4) getelementptr inbounds ([256 x i32], ptr addrspace(4) @c, i32 0, i32 1), align 4, !tbaa !3
  %call59.1 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef 0, i32 noundef 1, i32 noundef %14)
  %15 = load i32, ptr addrspace(4) getelementptr inbounds ([256 x i32], ptr addrspace(4) @c, i32 0, i32 2), align 4, !tbaa !3
  %call59.2 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef 0, i32 noundef 2, i32 noundef %15)
  %16 = load i32, ptr addrspace(4) getelementptr inbounds ([256 x i32], ptr addrspace(4) @c, i32 0, i32 3), align 4, !tbaa !3
  %call59.3 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef 0, i32 noundef 3, i32 noundef %16)
  %17 = load i32, ptr addrspace(4) getelementptr inbounds ([256 x i32], ptr addrspace(4) @c, i32 0, i32 4), align 4, !tbaa !3
  %call59.4 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef 0, i32 noundef 4, i32 noundef %17)
  ret i32 0
}

declare void @init_matrix(ptr noundef, i32 noundef, i32 noundef, i32 noundef) local_unnamed_addr #1

declare i32 @clock() local_unnamed_addr #1

declare void @matmul(ptr noundef, ptr noundef, ptr noundef, i32 noundef, i32 noundef, i32 noundef) local_unnamed_addr #1

declare i32 @_timer_clocks_per_sec() local_unnamed_addr #1

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #2

declare void @vectorized_matmul(ptr addrspace(4) noundef, ptr addrspace(4) noundef, ptr addrspace(4) noundef, i32 noundef, i32 noundef, i32 noundef) local_unnamed_addr #1

declare void @autovectorized_matmul(ptr addrspace(4) noundef, ptr addrspace(4) noundef, ptr addrspace(4) noundef, i32 noundef, i32 noundef, i32 noundef) local_unnamed_addr #1

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #3

; Function Attrs: nofree nounwind
declare noundef i32 @putchar(i32 noundef) local_unnamed_addr #3

attributes #0 = { nounwind "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #1 = { "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #2 = { nofree nounwind "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
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
