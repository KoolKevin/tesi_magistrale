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
@.str.11 = private unnamed_addr constant [55 x i8] c"Tempo di esecuzione di autovectorized_vec_sum: %.2fms\0A\00", align 1
@str = private unnamed_addr constant [39 x i8] c"Errore nell'allocazione della memoria.\00", align 1
@str.14 = private unnamed_addr constant [26 x i8] c"Versione autovettorizzata\00", align 1
@str.15 = private unnamed_addr constant [30 x i8] c"Primi 5 elementi della somma:\00", align 1

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
  %or.cond81 = and i1 %or.cond, %tobool3
  br i1 %or.cond81, label %vector.body.preheader, label %if.then

vector.body.preheader:                            ; preds = %entry
  br label %vector.body

if.then:                                          ; preds = %entry
  %puts138 = call i32 @puts(ptr nonnull dereferenceable(1) @str)
  br label %cleanup

vector.body:                                      ; preds = %vector.body, %vector.body.preheader
  %index = phi i32 [ 0, %vector.body.preheader ], [ %index.next.1, %vector.body ]
  %vec.ind = phi <16 x i32> [ <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>, %vector.body.preheader ], [ %vec.ind.next.1, %vector.body ]
  %3 = add nuw nsw <16 x i32> %vec.ind, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %4 = add <16 x i32> %vec.ind, <i32 17, i32 17, i32 17, i32 17, i32 17, i32 17, i32 17, i32 17, i32 17, i32 17, i32 17, i32 17, i32 17, i32 17, i32 17, i32 17>
  %5 = add <16 x i32> %vec.ind, <i32 33, i32 33, i32 33, i32 33, i32 33, i32 33, i32 33, i32 33, i32 33, i32 33, i32 33, i32 33, i32 33, i32 33, i32 33, i32 33>
  %6 = add <16 x i32> %vec.ind, <i32 49, i32 49, i32 49, i32 49, i32 49, i32 49, i32 49, i32 49, i32 49, i32 49, i32 49, i32 49, i32 49, i32 49, i32 49, i32 49>
  %7 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 %index
  store <16 x i32> %3, ptr addrspace(4) %7, align 16, !tbaa !3
  %8 = getelementptr inbounds i32, ptr addrspace(4) %7, i32 16
  store <16 x i32> %4, ptr addrspace(4) %8, align 16, !tbaa !3
  %9 = getelementptr inbounds i32, ptr addrspace(4) %7, i32 32
  store <16 x i32> %5, ptr addrspace(4) %9, align 16, !tbaa !3
  %10 = getelementptr inbounds i32, ptr addrspace(4) %7, i32 48
  store <16 x i32> %6, ptr addrspace(4) %10, align 16, !tbaa !3
  %11 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 %index
  store <16 x i32> %3, ptr addrspace(4) %11, align 16, !tbaa !3
  %12 = getelementptr inbounds i32, ptr addrspace(4) %11, i32 16
  store <16 x i32> %4, ptr addrspace(4) %12, align 16, !tbaa !3
  %13 = getelementptr inbounds i32, ptr addrspace(4) %11, i32 32
  store <16 x i32> %5, ptr addrspace(4) %13, align 16, !tbaa !3
  %14 = getelementptr inbounds i32, ptr addrspace(4) %11, i32 48
  store <16 x i32> %6, ptr addrspace(4) %14, align 16, !tbaa !3
  %index.next = add nuw nsw i32 %index, 64
  %15 = add <16 x i32> %vec.ind, <i32 65, i32 65, i32 65, i32 65, i32 65, i32 65, i32 65, i32 65, i32 65, i32 65, i32 65, i32 65, i32 65, i32 65, i32 65, i32 65>
  %16 = add <16 x i32> %vec.ind, <i32 81, i32 81, i32 81, i32 81, i32 81, i32 81, i32 81, i32 81, i32 81, i32 81, i32 81, i32 81, i32 81, i32 81, i32 81, i32 81>
  %17 = add <16 x i32> %vec.ind, <i32 97, i32 97, i32 97, i32 97, i32 97, i32 97, i32 97, i32 97, i32 97, i32 97, i32 97, i32 97, i32 97, i32 97, i32 97, i32 97>
  %18 = add <16 x i32> %vec.ind, <i32 113, i32 113, i32 113, i32 113, i32 113, i32 113, i32 113, i32 113, i32 113, i32 113, i32 113, i32 113, i32 113, i32 113, i32 113, i32 113>
  %19 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 %index.next
  store <16 x i32> %15, ptr addrspace(4) %19, align 16, !tbaa !3
  %20 = getelementptr inbounds i32, ptr addrspace(4) %19, i32 16
  store <16 x i32> %16, ptr addrspace(4) %20, align 16, !tbaa !3
  %21 = getelementptr inbounds i32, ptr addrspace(4) %19, i32 32
  store <16 x i32> %17, ptr addrspace(4) %21, align 16, !tbaa !3
  %22 = getelementptr inbounds i32, ptr addrspace(4) %19, i32 48
  store <16 x i32> %18, ptr addrspace(4) %22, align 16, !tbaa !3
  %23 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 %index.next
  store <16 x i32> %15, ptr addrspace(4) %23, align 16, !tbaa !3
  %24 = getelementptr inbounds i32, ptr addrspace(4) %23, i32 16
  store <16 x i32> %16, ptr addrspace(4) %24, align 16, !tbaa !3
  %25 = getelementptr inbounds i32, ptr addrspace(4) %23, i32 32
  store <16 x i32> %17, ptr addrspace(4) %25, align 16, !tbaa !3
  %26 = getelementptr inbounds i32, ptr addrspace(4) %23, i32 48
  store <16 x i32> %18, ptr addrspace(4) %26, align 16, !tbaa !3
  %index.next.1 = add nuw nsw i32 %index, 128
  %vec.ind.next.1 = add <16 x i32> %vec.ind, <i32 128, i32 128, i32 128, i32 128, i32 128, i32 128, i32 128, i32 128, i32 128, i32 128, i32 128, i32 128, i32 128, i32 128, i32 128, i32 128>
  %27 = icmp eq i32 %index.next.1, 1024
  br i1 %27, label %for.cond.cleanup, label %vector.body, !llvm.loop !7

for.cond.cleanup:                                 ; preds = %vector.body
  %call7 = call i32 @clock() #4
  %28 = addrspacecast ptr addrspace(4) %0 to ptr
  %29 = addrspacecast ptr addrspace(4) %1 to ptr
  %30 = addrspacecast ptr addrspace(4) %2 to ptr
  call void @vec_sum(ptr noundef %28, ptr noundef %29, ptr noundef %30, i32 noundef 1024) #4
  %call8 = call i32 @clock() #4
  %sub = sub nsw i32 %call8, %call7
  %conv = sitofp i32 %sub to double
  %call9 = call i32 @_timer_clocks_per_sec() #4
  %conv10 = uitofp i32 %call9 to double
  %31 = fmul fast double %conv, 1.000000e+03
  %mul = fdiv fast double %31, %conv10
  %call11 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, double noundef nofpclass(nan inf) %mul)
  %puts139 = call i32 @puts(ptr nonnull dereferenceable(1) @str.15)
  %32 = load i32, ptr addrspace(4) %0, align 16, !tbaa !3
  %33 = load i32, ptr addrspace(4) %1, align 16, !tbaa !3
  %34 = load i32, ptr addrspace(4) %2, align 16, !tbaa !3
  %call22 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, i32 noundef 0, i32 noundef %32, i32 noundef 0, i32 noundef %33, i32 noundef 0, i32 noundef %34)
  %arrayidx19.1 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 1
  %35 = load i32, ptr addrspace(4) %arrayidx19.1, align 4, !tbaa !3
  %arrayidx20.1 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 1
  %36 = load i32, ptr addrspace(4) %arrayidx20.1, align 4, !tbaa !3
  %arrayidx21.1 = getelementptr inbounds i32, ptr addrspace(4) %2, i32 1
  %37 = load i32, ptr addrspace(4) %arrayidx21.1, align 4, !tbaa !3
  %call22.1 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, i32 noundef 1, i32 noundef %35, i32 noundef 1, i32 noundef %36, i32 noundef 1, i32 noundef %37)
  %arrayidx19.2 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 2
  %38 = load i32, ptr addrspace(4) %arrayidx19.2, align 8, !tbaa !3
  %arrayidx20.2 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 2
  %39 = load i32, ptr addrspace(4) %arrayidx20.2, align 8, !tbaa !3
  %arrayidx21.2 = getelementptr inbounds i32, ptr addrspace(4) %2, i32 2
  %40 = load i32, ptr addrspace(4) %arrayidx21.2, align 8, !tbaa !3
  %call22.2 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, i32 noundef 2, i32 noundef %38, i32 noundef 2, i32 noundef %39, i32 noundef 2, i32 noundef %40)
  %arrayidx19.3 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 3
  %41 = load i32, ptr addrspace(4) %arrayidx19.3, align 4, !tbaa !3
  %arrayidx20.3 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 3
  %42 = load i32, ptr addrspace(4) %arrayidx20.3, align 4, !tbaa !3
  %arrayidx21.3 = getelementptr inbounds i32, ptr addrspace(4) %2, i32 3
  %43 = load i32, ptr addrspace(4) %arrayidx21.3, align 4, !tbaa !3
  %call22.3 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, i32 noundef 3, i32 noundef %41, i32 noundef 3, i32 noundef %42, i32 noundef 3, i32 noundef %43)
  %arrayidx19.4 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 4
  %44 = load i32, ptr addrspace(4) %arrayidx19.4, align 16, !tbaa !3
  %arrayidx20.4 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 4
  %45 = load i32, ptr addrspace(4) %arrayidx20.4, align 16, !tbaa !3
  %arrayidx21.4 = getelementptr inbounds i32, ptr addrspace(4) %2, i32 4
  %46 = load i32, ptr addrspace(4) %arrayidx21.4, align 16, !tbaa !3
  %call22.4 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, i32 noundef 4, i32 noundef %44, i32 noundef 4, i32 noundef %45, i32 noundef 4, i32 noundef %46)
  %putchar = call i32 @putchar(i32 10)
  %call27 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.7, i32 noundef 16)
  %call28 = call i32 @clock() #4
  call void @vectorized_vec_sum(ptr addrspace(4) noundef nonnull %0, ptr addrspace(4) noundef nonnull %1, ptr addrspace(4) noundef nonnull %2, i32 noundef 1024) #4
  %call29 = call i32 @clock() #4
  %sub30 = sub nsw i32 %call29, %call28
  %conv31 = sitofp i32 %sub30 to double
  %call32 = call i32 @_timer_clocks_per_sec() #4
  %conv33 = uitofp i32 %call32 to double
  %47 = fmul fast double %conv31, 1.000000e+03
  %mul35 = fdiv fast double %47, %conv33
  %call36 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.8, double noundef nofpclass(nan inf) %mul35)
  %div37 = fdiv fast double %mul, %mul35
  %call38 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.9, double noundef nofpclass(nan inf) %div37)
  %puts140 = call i32 @puts(ptr nonnull dereferenceable(1) @str.15)
  %48 = load i32, ptr addrspace(4) %0, align 16, !tbaa !3
  %49 = load i32, ptr addrspace(4) %1, align 16, !tbaa !3
  %50 = load i32, ptr addrspace(4) %2, align 16, !tbaa !3
  %call49 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, i32 noundef 0, i32 noundef %48, i32 noundef 0, i32 noundef %49, i32 noundef 0, i32 noundef %50)
  %51 = load i32, ptr addrspace(4) %arrayidx19.1, align 4, !tbaa !3
  %52 = load i32, ptr addrspace(4) %arrayidx20.1, align 4, !tbaa !3
  %53 = load i32, ptr addrspace(4) %arrayidx21.1, align 4, !tbaa !3
  %call49.1 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, i32 noundef 1, i32 noundef %51, i32 noundef 1, i32 noundef %52, i32 noundef 1, i32 noundef %53)
  %54 = load i32, ptr addrspace(4) %arrayidx19.2, align 8, !tbaa !3
  %55 = load i32, ptr addrspace(4) %arrayidx20.2, align 8, !tbaa !3
  %56 = load i32, ptr addrspace(4) %arrayidx21.2, align 8, !tbaa !3
  %call49.2 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, i32 noundef 2, i32 noundef %54, i32 noundef 2, i32 noundef %55, i32 noundef 2, i32 noundef %56)
  %57 = load i32, ptr addrspace(4) %arrayidx19.3, align 4, !tbaa !3
  %58 = load i32, ptr addrspace(4) %arrayidx20.3, align 4, !tbaa !3
  %59 = load i32, ptr addrspace(4) %arrayidx21.3, align 4, !tbaa !3
  %call49.3 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, i32 noundef 3, i32 noundef %57, i32 noundef 3, i32 noundef %58, i32 noundef 3, i32 noundef %59)
  %60 = load i32, ptr addrspace(4) %arrayidx19.4, align 16, !tbaa !3
  %61 = load i32, ptr addrspace(4) %arrayidx20.4, align 16, !tbaa !3
  %62 = load i32, ptr addrspace(4) %arrayidx21.4, align 16, !tbaa !3
  %call49.4 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, i32 noundef 4, i32 noundef %60, i32 noundef 4, i32 noundef %61, i32 noundef 4, i32 noundef %62)
  %puts141 = call i32 @puts(ptr nonnull dereferenceable(1) @str.14)
  %call54 = call i32 @clock() #4
  call void @autovectorized_vec_sum(ptr addrspace(4) noundef nonnull %0, ptr addrspace(4) noundef nonnull %1, ptr addrspace(4) noundef nonnull %2, i32 noundef 1024) #4
  %call55 = call i32 @clock() #4
  %sub56 = sub nsw i32 %call55, %call54
  %conv57 = sitofp i32 %sub56 to double
  %call58 = call i32 @_timer_clocks_per_sec() #4
  %conv59 = uitofp i32 %call58 to double
  %63 = fmul fast double %conv57, 1.000000e+03
  %mul61 = fdiv fast double %63, %conv59
  %call62 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.11, double noundef nofpclass(nan inf) %mul61)
  %div63 = fdiv fast double %mul, %mul61
  %call64 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.9, double noundef nofpclass(nan inf) %div63)
  %puts142 = call i32 @puts(ptr nonnull dereferenceable(1) @str.15)
  %64 = load i32, ptr addrspace(4) %0, align 16, !tbaa !3
  %65 = load i32, ptr addrspace(4) %1, align 16, !tbaa !3
  %66 = load i32, ptr addrspace(4) %2, align 16, !tbaa !3
  %call75 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, i32 noundef 0, i32 noundef %64, i32 noundef 0, i32 noundef %65, i32 noundef 0, i32 noundef %66)
  %67 = load i32, ptr addrspace(4) %arrayidx19.1, align 4, !tbaa !3
  %68 = load i32, ptr addrspace(4) %arrayidx20.1, align 4, !tbaa !3
  %69 = load i32, ptr addrspace(4) %arrayidx21.1, align 4, !tbaa !3
  %call75.1 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, i32 noundef 1, i32 noundef %67, i32 noundef 1, i32 noundef %68, i32 noundef 1, i32 noundef %69)
  %70 = load i32, ptr addrspace(4) %arrayidx19.2, align 8, !tbaa !3
  %71 = load i32, ptr addrspace(4) %arrayidx20.2, align 8, !tbaa !3
  %72 = load i32, ptr addrspace(4) %arrayidx21.2, align 8, !tbaa !3
  %call75.2 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, i32 noundef 2, i32 noundef %70, i32 noundef 2, i32 noundef %71, i32 noundef 2, i32 noundef %72)
  %73 = load i32, ptr addrspace(4) %arrayidx19.3, align 4, !tbaa !3
  %74 = load i32, ptr addrspace(4) %arrayidx20.3, align 4, !tbaa !3
  %75 = load i32, ptr addrspace(4) %arrayidx21.3, align 4, !tbaa !3
  %call75.3 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, i32 noundef 3, i32 noundef %73, i32 noundef 3, i32 noundef %74, i32 noundef 3, i32 noundef %75)
  %76 = load i32, ptr addrspace(4) %arrayidx19.4, align 16, !tbaa !3
  %77 = load i32, ptr addrspace(4) %arrayidx20.4, align 16, !tbaa !3
  %78 = load i32, ptr addrspace(4) %arrayidx21.4, align 16, !tbaa !3
  %call75.4 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, i32 noundef 4, i32 noundef %76, i32 noundef 4, i32 noundef %77, i32 noundef 4, i32 noundef %78)
  br label %cleanup

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

declare void @autovectorized_vec_sum(ptr addrspace(4) noundef, ptr addrspace(4) noundef, ptr addrspace(4) noundef, i32 noundef) local_unnamed_addr #2

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
