; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-f64:32-v64:32-v128:32-a:0:32-v256:32-v512:32-n8:16:32"
target triple = "arc-pc-unknown-gnu"

@a = addrspace(4) global [1024 x i32] zeroinitializer, align 4
@b = addrspace(4) global [1024 x i32] zeroinitializer, align 4
@c = addrspace(4) global [1024 x i32] zeroinitializer, align 4
@.str = private unnamed_addr constant [40 x i8] c"Tempo di esecuzione di vec_sum: %.2fms\0A\00", align 1
@.str.1 = private unnamed_addr constant [31 x i8] c"Primi 5 elementi della somma:\0A\00", align 1
@.str.2 = private unnamed_addr constant [30 x i8] c"a[%d]=%d, b[%d]=%d, c[%d]=%d\0A\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.4 = private unnamed_addr constant [23 x i8] c"Vettorizzo su %d lane\0A\00", align 1
@.str.5 = private unnamed_addr constant [51 x i8] c"Tempo di esecuzione di vectorized_vec_sum: %.2fms\0A\00", align 1
@.str.6 = private unnamed_addr constant [15 x i8] c"Speedup: %.2f\0A\00", align 1
@.str.7 = private unnamed_addr constant [27 x i8] c"Versione autovettorizzata\0A\00", align 1
@.str.8 = private unnamed_addr constant [55 x i8] c"Tempo di esecuzione di autovectorized_vec_sum: %.2fms\0A\00", align 1

; Function Attrs: noinline nounwind
define dso_local i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %i = alloca i32, align 4
  %start = alloca i32, align 4
  %end = alloca i32, align 4
  %time_scalar = alloca double, align 4
  %i8 = alloca i32, align 4
  %time_vectorized = alloca double, align 4
  %i34 = alloca i32, align 4
  %time_autovectorized = alloca double, align 4
  %i60 = alloca i32, align 4
  store i32 0, ptr %retval, align 4
  store i32 0, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, ptr %i, align 4
  %cmp = icmp slt i32 %0, 1024
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32, ptr %i, align 4
  %add = add nsw i32 %1, 1
  %2 = load i32, ptr %i, align 4
  %arrayidx = getelementptr inbounds [1024 x i32], ptr addrspace(4) @a, i32 0, i32 %2
  store i32 %add, ptr addrspace(4) %arrayidx, align 4
  %3 = load i32, ptr %i, align 4
  %add1 = add nsw i32 %3, 1
  %4 = load i32, ptr %i, align 4
  %arrayidx2 = getelementptr inbounds [1024 x i32], ptr addrspace(4) @b, i32 0, i32 %4
  store i32 %add1, ptr addrspace(4) %arrayidx2, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %5 = load i32, ptr %i, align 4
  %inc = add nsw i32 %5, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !3

for.end:                                          ; preds = %for.cond
  call void @init_vector(ptr noundef addrspacecast (ptr addrspace(4) @c to ptr), i32 noundef 1024, i32 noundef -1)
  %call = call i32 @clock()
  store i32 %call, ptr %start, align 4
  call void @vec_sum(ptr noundef addrspacecast (ptr addrspace(4) @a to ptr), ptr noundef addrspacecast (ptr addrspace(4) @b to ptr), ptr noundef addrspacecast (ptr addrspace(4) @c to ptr), i32 noundef 1024)
  %call3 = call i32 @clock()
  store i32 %call3, ptr %end, align 4
  %6 = load i32, ptr %end, align 4
  %7 = load i32, ptr %start, align 4
  %sub = sub nsw i32 %6, %7
  %conv = sitofp i32 %sub to double
  %call4 = call i32 @_timer_clocks_per_sec()
  %conv5 = uitofp i32 %call4 to double
  %div = fdiv contract double %conv, %conv5
  %mul = fmul contract double %div, 1.000000e+03
  store double %mul, ptr %time_scalar, align 4
  %8 = load double, ptr %time_scalar, align 4
  %call6 = call i32 (ptr, ...) @printf(ptr noundef @.str, double noundef %8)
  %call7 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  store i32 0, ptr %i8, align 4
  br label %for.cond9

for.cond9:                                        ; preds = %for.inc17, %for.end
  %9 = load i32, ptr %i8, align 4
  %cmp10 = icmp slt i32 %9, 5
  br i1 %cmp10, label %for.body12, label %for.end19

for.body12:                                       ; preds = %for.cond9
  %10 = load i32, ptr %i8, align 4
  %11 = load i32, ptr %i8, align 4
  %arrayidx13 = getelementptr inbounds [1024 x i32], ptr addrspace(4) @a, i32 0, i32 %11
  %12 = load i32, ptr addrspace(4) %arrayidx13, align 4
  %13 = load i32, ptr %i8, align 4
  %14 = load i32, ptr %i8, align 4
  %arrayidx14 = getelementptr inbounds [1024 x i32], ptr addrspace(4) @b, i32 0, i32 %14
  %15 = load i32, ptr addrspace(4) %arrayidx14, align 4
  %16 = load i32, ptr %i8, align 4
  %17 = load i32, ptr %i8, align 4
  %arrayidx15 = getelementptr inbounds [1024 x i32], ptr addrspace(4) @c, i32 0, i32 %17
  %18 = load i32, ptr addrspace(4) %arrayidx15, align 4
  %call16 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, i32 noundef %10, i32 noundef %12, i32 noundef %13, i32 noundef %15, i32 noundef %16, i32 noundef %18)
  br label %for.inc17

for.inc17:                                        ; preds = %for.body12
  %19 = load i32, ptr %i8, align 4
  %inc18 = add nsw i32 %19, 1
  store i32 %inc18, ptr %i8, align 4
  br label %for.cond9, !llvm.loop !5

for.end19:                                        ; preds = %for.cond9
  %call20 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  %call21 = call i32 (ptr, ...) @printf(ptr noundef @.str.4, i32 noundef 16)
  call void @init_vector(ptr noundef addrspacecast (ptr addrspace(4) @c to ptr), i32 noundef 1024, i32 noundef -1)
  %call22 = call i32 @clock()
  store i32 %call22, ptr %start, align 4
  call void @vectorized_vec_sum(ptr addrspace(4) noundef @a, ptr addrspace(4) noundef @b, ptr addrspace(4) noundef @c, i32 noundef 1024)
  %call23 = call i32 @clock()
  store i32 %call23, ptr %end, align 4
  %20 = load i32, ptr %end, align 4
  %21 = load i32, ptr %start, align 4
  %sub24 = sub nsw i32 %20, %21
  %conv25 = sitofp i32 %sub24 to double
  %call26 = call i32 @_timer_clocks_per_sec()
  %conv27 = uitofp i32 %call26 to double
  %div28 = fdiv contract double %conv25, %conv27
  %mul29 = fmul contract double %div28, 1.000000e+03
  store double %mul29, ptr %time_vectorized, align 4
  %22 = load double, ptr %time_vectorized, align 4
  %call30 = call i32 (ptr, ...) @printf(ptr noundef @.str.5, double noundef %22)
  %23 = load double, ptr %time_scalar, align 4
  %24 = load double, ptr %time_vectorized, align 4
  %div31 = fdiv contract double %23, %24
  %call32 = call i32 (ptr, ...) @printf(ptr noundef @.str.6, double noundef %div31)
  %call33 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  store i32 0, ptr %i34, align 4
  br label %for.cond35

for.cond35:                                       ; preds = %for.inc43, %for.end19
  %25 = load i32, ptr %i34, align 4
  %cmp36 = icmp slt i32 %25, 5
  br i1 %cmp36, label %for.body38, label %for.end45

for.body38:                                       ; preds = %for.cond35
  %26 = load i32, ptr %i34, align 4
  %27 = load i32, ptr %i34, align 4
  %arrayidx39 = getelementptr inbounds [1024 x i32], ptr addrspace(4) @a, i32 0, i32 %27
  %28 = load i32, ptr addrspace(4) %arrayidx39, align 4
  %29 = load i32, ptr %i34, align 4
  %30 = load i32, ptr %i34, align 4
  %arrayidx40 = getelementptr inbounds [1024 x i32], ptr addrspace(4) @b, i32 0, i32 %30
  %31 = load i32, ptr addrspace(4) %arrayidx40, align 4
  %32 = load i32, ptr %i34, align 4
  %33 = load i32, ptr %i34, align 4
  %arrayidx41 = getelementptr inbounds [1024 x i32], ptr addrspace(4) @c, i32 0, i32 %33
  %34 = load i32, ptr addrspace(4) %arrayidx41, align 4
  %call42 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, i32 noundef %26, i32 noundef %28, i32 noundef %29, i32 noundef %31, i32 noundef %32, i32 noundef %34)
  br label %for.inc43

for.inc43:                                        ; preds = %for.body38
  %35 = load i32, ptr %i34, align 4
  %inc44 = add nsw i32 %35, 1
  store i32 %inc44, ptr %i34, align 4
  br label %for.cond35, !llvm.loop !6

for.end45:                                        ; preds = %for.cond35
  %call46 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  %call47 = call i32 (ptr, ...) @printf(ptr noundef @.str.7)
  call void @init_vector(ptr noundef addrspacecast (ptr addrspace(4) @c to ptr), i32 noundef 1024, i32 noundef -1)
  %call48 = call i32 @clock()
  store i32 %call48, ptr %start, align 4
  call void @autovectorized_vec_sum(ptr addrspace(4) noundef @a, ptr addrspace(4) noundef @b, ptr addrspace(4) noundef @c, i32 noundef 1024)
  %call49 = call i32 @clock()
  store i32 %call49, ptr %end, align 4
  %36 = load i32, ptr %end, align 4
  %37 = load i32, ptr %start, align 4
  %sub50 = sub nsw i32 %36, %37
  %conv51 = sitofp i32 %sub50 to double
  %call52 = call i32 @_timer_clocks_per_sec()
  %conv53 = uitofp i32 %call52 to double
  %div54 = fdiv contract double %conv51, %conv53
  %mul55 = fmul contract double %div54, 1.000000e+03
  store double %mul55, ptr %time_autovectorized, align 4
  %38 = load double, ptr %time_autovectorized, align 4
  %call56 = call i32 (ptr, ...) @printf(ptr noundef @.str.8, double noundef %38)
  %39 = load double, ptr %time_scalar, align 4
  %40 = load double, ptr %time_autovectorized, align 4
  %div57 = fdiv contract double %39, %40
  %call58 = call i32 (ptr, ...) @printf(ptr noundef @.str.6, double noundef %div57)
  %call59 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  store i32 0, ptr %i60, align 4
  br label %for.cond61

for.cond61:                                       ; preds = %for.inc69, %for.end45
  %41 = load i32, ptr %i60, align 4
  %cmp62 = icmp slt i32 %41, 5
  br i1 %cmp62, label %for.body64, label %for.end71

for.body64:                                       ; preds = %for.cond61
  %42 = load i32, ptr %i60, align 4
  %43 = load i32, ptr %i60, align 4
  %arrayidx65 = getelementptr inbounds [1024 x i32], ptr addrspace(4) @a, i32 0, i32 %43
  %44 = load i32, ptr addrspace(4) %arrayidx65, align 4
  %45 = load i32, ptr %i60, align 4
  %46 = load i32, ptr %i60, align 4
  %arrayidx66 = getelementptr inbounds [1024 x i32], ptr addrspace(4) @b, i32 0, i32 %46
  %47 = load i32, ptr addrspace(4) %arrayidx66, align 4
  %48 = load i32, ptr %i60, align 4
  %49 = load i32, ptr %i60, align 4
  %arrayidx67 = getelementptr inbounds [1024 x i32], ptr addrspace(4) @c, i32 0, i32 %49
  %50 = load i32, ptr addrspace(4) %arrayidx67, align 4
  %call68 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, i32 noundef %42, i32 noundef %44, i32 noundef %45, i32 noundef %47, i32 noundef %48, i32 noundef %50)
  br label %for.inc69

for.inc69:                                        ; preds = %for.body64
  %51 = load i32, ptr %i60, align 4
  %inc70 = add nsw i32 %51, 1
  store i32 %inc70, ptr %i60, align 4
  br label %for.cond61, !llvm.loop !7

for.end71:                                        ; preds = %for.cond61
  ret i32 0
}

declare void @init_vector(ptr noundef, i32 noundef, i32 noundef) #1

declare i32 @clock() #1

declare void @vec_sum(ptr noundef, ptr noundef, ptr noundef, i32 noundef) #1

declare i32 @_timer_clocks_per_sec() #1

declare i32 @printf(ptr noundef, ...) #1

declare void @vectorized_vec_sum(ptr addrspace(4) noundef, ptr addrspace(4) noundef, ptr addrspace(4) noundef, i32 noundef) #1

declare void @autovectorized_vec_sum(ptr addrspace(4) noundef, ptr addrspace(4) noundef, ptr addrspace(4) noundef, i32 noundef) #1

attributes #0 = { noinline nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" }
attributes #1 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"ArcIntrinsicCheck", i32 28778521}
!1 = !{i32 1, !"wchar_size", i32 2}
!2 = !{!"clang version 17.0.7 (git@gitsnps.internal.synopsys.com:MetaWare/mwdt-llvm-project.git 3cb6cb7579aa39b9c4db2b6a06b7c2eb3174f977)"}
!3 = distinct !{!3, !4}
!4 = !{!"llvm.loop.mustprogress"}
!5 = distinct !{!5, !4}
!6 = distinct !{!6, !4}
!7 = distinct !{!7, !4}
