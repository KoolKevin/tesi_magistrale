; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-f64:32-v64:32-v128:32-a:0:32-v256:32-v512:32-n8:16:32"
target triple = "arc-pc-unknown-gnu"

@input1 = addrspace(4) global [16384 x i32] zeroinitializer, align 4
@input2 = addrspace(4) global [16384 x i32] zeroinitializer, align 4
@.str = private unnamed_addr constant [29 x i8] c"Tempo di esecuzione: %.2fms\0A\00", align 1
@.str.1 = private unnamed_addr constant [9 x i8] c"res: %d\0A\00", align 1
@.str.3 = private unnamed_addr constant [23 x i8] c"Vettorizzo su %d lane\0A\00", align 1
@.str.4 = private unnamed_addr constant [49 x i8] c"Tempo di esecuzione di vectorized_sad2d: %.2fms\0A\00", align 1
@.str.5 = private unnamed_addr constant [15 x i8] c"Speedup: %.2f\0A\00", align 1
@.str.7 = private unnamed_addr constant [53 x i8] c"Tempo di esecuzione di autovectorized_sad2d: %.2fms\0A\00", align 1
@.str.9 = private unnamed_addr constant [43 x i8] c"Tempo di esecuzione di vekt_sad2d: %.2fms\0A\00", align 1
@str = private unnamed_addr constant [26 x i8] c"Versione autovettorizzata\00", align 1
@str.10 = private unnamed_addr constant [27 x i8] c"Versione vekt-vettorizzata\00", align 1

; Function Attrs: nounwind
define dso_local i32 @main() local_unnamed_addr #0 {
entry:
  tail call void @init_matrix(ptr noundef addrspacecast (ptr addrspace(4) @input1 to ptr), i32 noundef 128, i32 noundef 128, i32 noundef 1) #4
  tail call void @init_matrix(ptr noundef addrspacecast (ptr addrspace(4) @input2 to ptr), i32 noundef 128, i32 noundef 128, i32 noundef 2) #4
  %call = tail call i32 @clock() #4
  %call1 = tail call i32 @sad2d(i32 noundef 128, i32 noundef 128, ptr noundef addrspacecast (ptr addrspace(4) @input1 to ptr), ptr noundef addrspacecast (ptr addrspace(4) @input2 to ptr)) #4
  %call2 = tail call i32 @clock() #4
  %sub = sub nsw i32 %call2, %call
  %conv = sitofp i32 %sub to double
  %call3 = tail call i32 @_timer_clocks_per_sec() #4
  %conv4 = uitofp i32 %call3 to double
  %0 = fmul fast double %conv, 1.000000e+03
  %mul = fdiv fast double %0, %conv4
  %call5 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, double noundef nofpclass(nan inf) %mul)
  %call6 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.1, i32 noundef %call1)
  %putchar = tail call i32 @putchar(i32 10)
  %call8 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, i32 noundef 16)
  %call9 = tail call i32 @clock() #4
  %call10 = tail call i32 @vectorized_sad2d(i32 noundef 128, i32 noundef 128, ptr addrspace(4) noundef @input1, ptr addrspace(4) noundef @input2) #4
  %call11 = tail call i32 @clock() #4
  %sub12 = sub nsw i32 %call11, %call9
  %conv13 = sitofp i32 %sub12 to double
  %call14 = tail call i32 @_timer_clocks_per_sec() #4
  %conv15 = uitofp i32 %call14 to double
  %1 = fmul fast double %conv13, 1.000000e+03
  %mul17 = fdiv fast double %1, %conv15
  %call18 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.4, double noundef nofpclass(nan inf) %mul17)
  %div19 = fdiv fast double %mul, %mul17
  %call20 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, double noundef nofpclass(nan inf) %div19)
  %call21 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.1, i32 noundef %call10)
  %putchar68 = tail call i32 @putchar(i32 10)
  %puts = tail call i32 @puts(ptr nonnull dereferenceable(1) @str)
  %call24 = tail call i32 @clock() #4
  %call25 = tail call i32 @autovectorized_sad2d(i32 noundef 128, i32 noundef 128, ptr addrspace(4) noundef @input1, ptr addrspace(4) noundef @input2) #4
  %call26 = tail call i32 @clock() #4
  %sub27 = sub nsw i32 %call26, %call24
  %conv28 = sitofp i32 %sub27 to double
  %call29 = tail call i32 @_timer_clocks_per_sec() #4
  %conv30 = uitofp i32 %call29 to double
  %2 = fmul fast double %conv28, 1.000000e+03
  %mul32 = fdiv fast double %2, %conv30
  %call33 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.7, double noundef nofpclass(nan inf) %mul32)
  %div34 = fdiv fast double %mul, %mul32
  %call35 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, double noundef nofpclass(nan inf) %div34)
  %call36 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.1, i32 noundef %call25)
  %putchar69 = tail call i32 @putchar(i32 10)
  %puts70 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.10)
  %call39 = tail call i32 @clock() #4
  %call40 = tail call i32 @vekt_sad2d_wrapper(i32 noundef 128, i32 noundef 128, ptr noundef addrspacecast (ptr addrspace(4) @input1 to ptr), ptr noundef addrspacecast (ptr addrspace(4) @input2 to ptr)) #4
  %call41 = tail call i32 @clock() #4
  %sub42 = sub nsw i32 %call41, %call39
  %conv43 = sitofp i32 %sub42 to double
  %call44 = tail call i32 @_timer_clocks_per_sec() #4
  %conv45 = uitofp i32 %call44 to double
  %3 = fmul fast double %conv43, 1.000000e+03
  %mul47 = fdiv fast double %3, %conv45
  %call48 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.9, double noundef nofpclass(nan inf) %mul47)
  %div49 = fdiv fast double %mul, %mul47
  %call50 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, double noundef nofpclass(nan inf) %div49)
  %call51 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.1, i32 noundef %call40)
  %putchar71 = tail call i32 @putchar(i32 10)
  ret i32 0
}

declare void @init_matrix(ptr noundef, i32 noundef, i32 noundef, i32 noundef) local_unnamed_addr #1

declare i32 @clock() local_unnamed_addr #1

declare i32 @sad2d(i32 noundef, i32 noundef, ptr noundef, ptr noundef) local_unnamed_addr #1

declare i32 @_timer_clocks_per_sec() local_unnamed_addr #1

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #2

declare i32 @vectorized_sad2d(i32 noundef, i32 noundef, ptr addrspace(4) noundef, ptr addrspace(4) noundef) local_unnamed_addr #1

declare i32 @autovectorized_sad2d(i32 noundef, i32 noundef, ptr addrspace(4) noundef, ptr addrspace(4) noundef) local_unnamed_addr #1

declare i32 @vekt_sad2d_wrapper(i32 noundef, i32 noundef, ptr noundef, ptr noundef) local_unnamed_addr #1

; Function Attrs: nofree nounwind
declare noundef i32 @putchar(i32 noundef) local_unnamed_addr #3

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #3

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
