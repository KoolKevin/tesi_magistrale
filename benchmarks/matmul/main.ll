; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-f64:32-v64:32-v128:32-a:0:32-v256:32-v512:32-n8:16:32"
target triple = "arc-pc-unknown-gnu"

@a = addrspace(4) global [1089 x i32] zeroinitializer, align 4
@b = addrspace(4) global [1089 x i32] zeroinitializer, align 4
@c = addrspace(4) global [1089 x i32] zeroinitializer, align 4
@.str = private unnamed_addr constant [29 x i8] c"Tempo di esecuzione: %.2fms\0A\00", align 1
@.str.2 = private unnamed_addr constant [23 x i8] c"Vettorizzo su %d lane\0A\00", align 1
@.str.3 = private unnamed_addr constant [51 x i8] c"Tempo di esecuzione di vectorized_vec_sum: %.2fms\0A\00", align 1
@.str.4 = private unnamed_addr constant [15 x i8] c"Speedup: %.2f\0A\00", align 1
@.str.6 = private unnamed_addr constant [55 x i8] c"Tempo di esecuzione di autovectorized_vec_sum: %.2fms\0A\00", align 1
@.str.8 = private unnamed_addr constant [44 x i8] c"Tempo di esecuzione di vekt_matmul: %.2fms\0A\00", align 1
@str = private unnamed_addr constant [26 x i8] c"Versione autovettorizzata\00", align 1
@str.9 = private unnamed_addr constant [27 x i8] c"Versione vekt-vettorizzata\00", align 1

; Function Attrs: nounwind
define dso_local i32 @main() local_unnamed_addr #0 {
entry:
  %groundtruth = alloca [33 x [33 x i32]], align 4
  tail call void @init_matrix(ptr noundef addrspacecast (ptr addrspace(4) @a to ptr), i32 noundef 33, i32 noundef 33, i32 noundef 1) #5
  tail call void @init_matrix(ptr noundef addrspacecast (ptr addrspace(4) @b to ptr), i32 noundef 33, i32 noundef 33, i32 noundef 1) #5
  tail call void @init_matrix(ptr noundef addrspacecast (ptr addrspace(4) @c to ptr), i32 noundef 33, i32 noundef 33, i32 noundef 0) #5
  %call = tail call i32 @clock() #5
  tail call void @matmul(ptr noundef addrspacecast (ptr addrspace(4) @a to ptr), ptr noundef addrspacecast (ptr addrspace(4) @b to ptr), ptr noundef addrspacecast (ptr addrspace(4) @c to ptr), i32 noundef 33, i32 noundef 33, i32 noundef 33) #5
  %call1 = tail call i32 @clock() #5
  %sub = sub nsw i32 %call1, %call
  %conv = sitofp i32 %sub to double
  %call2 = tail call i32 @_timer_clocks_per_sec() #5
  %conv3 = uitofp i32 %call2 to double
  %0 = fmul fast double %conv, 1.000000e+03
  %mul = fdiv fast double %0, %conv3
  %call4 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, double noundef nofpclass(nan inf) %mul)
  tail call void @print_matrix(ptr noundef addrspacecast (ptr addrspace(4) @c to ptr), i32 noundef 33, i32 noundef 33) #5
  call void @llvm.lifetime.start.p0(i64 4356, ptr nonnull %groundtruth) #5
  %call5 = call ptr @copy_matrix(ptr noundef nonnull %groundtruth, ptr noundef addrspacecast (ptr addrspace(4) @c to ptr), i32 noundef 33, i32 noundef 33) #5
  %putchar = call i32 @putchar(i32 10)
  %call7 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef 16)
  call void @init_matrix(ptr noundef addrspacecast (ptr addrspace(4) @c to ptr), i32 noundef 33, i32 noundef 33, i32 noundef 0) #5
  %call8 = call i32 @clock() #5
  call void @vectorized_matmul(ptr addrspace(4) noundef @a, ptr addrspace(4) noundef @b, ptr addrspace(4) noundef @c, i32 noundef 33, i32 noundef 33, i32 noundef 33) #5
  %call9 = call i32 @clock() #5
  %sub10 = sub nsw i32 %call9, %call8
  %conv11 = sitofp i32 %sub10 to double
  %call12 = call i32 @_timer_clocks_per_sec() #5
  %conv13 = uitofp i32 %call12 to double
  %1 = fmul fast double %conv11, 1.000000e+03
  %mul15 = fdiv fast double %1, %conv13
  %call16 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, double noundef nofpclass(nan inf) %mul15)
  %div17 = fdiv fast double %mul, %mul15
  %call18 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.4, double noundef nofpclass(nan inf) %div17)
  call void @print_matrix(ptr noundef addrspacecast (ptr addrspace(4) @c to ptr), i32 noundef 33, i32 noundef 33) #5
  call void @check_result(ptr noundef nonnull %groundtruth, ptr noundef addrspacecast (ptr addrspace(4) @c to ptr), i32 noundef 33, i32 noundef 33) #5
  %putchar60 = call i32 @putchar(i32 10)
  %puts = call i32 @puts(ptr nonnull dereferenceable(1) @str)
  call void @init_matrix(ptr noundef addrspacecast (ptr addrspace(4) @c to ptr), i32 noundef 33, i32 noundef 33, i32 noundef 0) #5
  %call22 = call i32 @clock() #5
  call void @autovectorized_matmul(ptr addrspace(4) noundef @a, ptr addrspace(4) noundef @b, ptr addrspace(4) noundef @c, i32 noundef 33, i32 noundef 33, i32 noundef 33) #5
  %call23 = call i32 @clock() #5
  %sub24 = sub nsw i32 %call23, %call22
  %conv25 = sitofp i32 %sub24 to double
  %call26 = call i32 @_timer_clocks_per_sec() #5
  %conv27 = uitofp i32 %call26 to double
  %2 = fmul fast double %conv25, 1.000000e+03
  %mul29 = fdiv fast double %2, %conv27
  %call30 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.6, double noundef nofpclass(nan inf) %mul29)
  %div31 = fdiv fast double %mul, %mul29
  %call32 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.4, double noundef nofpclass(nan inf) %div31)
  call void @print_matrix(ptr noundef addrspacecast (ptr addrspace(4) @c to ptr), i32 noundef 33, i32 noundef 33) #5
  %putchar61 = call i32 @putchar(i32 10)
  %puts62 = call i32 @puts(ptr nonnull dereferenceable(1) @str.9)
  call void @init_matrix(ptr noundef addrspacecast (ptr addrspace(4) @c to ptr), i32 noundef 33, i32 noundef 33, i32 noundef 0) #5
  %call35 = call i32 @clock() #5
  call void @vekt_matmul_wrapper(ptr noundef addrspacecast (ptr addrspace(4) @a to ptr), ptr noundef addrspacecast (ptr addrspace(4) @b to ptr), ptr noundef addrspacecast (ptr addrspace(4) @c to ptr), i32 noundef 33, i32 noundef 33, i32 noundef 33) #5
  %call36 = call i32 @clock() #5
  %sub37 = sub nsw i32 %call36, %call35
  %conv38 = sitofp i32 %sub37 to double
  %call39 = call i32 @_timer_clocks_per_sec() #5
  %conv40 = uitofp i32 %call39 to double
  %3 = fmul fast double %conv38, 1.000000e+03
  %mul42 = fdiv fast double %3, %conv40
  %call43 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.8, double noundef nofpclass(nan inf) %mul42)
  %div44 = fdiv fast double %mul, %mul42
  %call45 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.4, double noundef nofpclass(nan inf) %div44)
  call void @print_matrix(ptr noundef addrspacecast (ptr addrspace(4) @c to ptr), i32 noundef 33, i32 noundef 33) #5
  call void @check_result(ptr noundef nonnull %groundtruth, ptr noundef addrspacecast (ptr addrspace(4) @c to ptr), i32 noundef 33, i32 noundef 33) #5
  %putchar63 = call i32 @putchar(i32 10)
  call void @llvm.lifetime.end.p0(i64 4356, ptr nonnull %groundtruth) #5
  ret i32 0
}

declare void @init_matrix(ptr noundef, i32 noundef, i32 noundef, i32 noundef) local_unnamed_addr #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #2

declare i32 @clock() local_unnamed_addr #1

declare void @matmul(ptr noundef, ptr noundef, ptr noundef, i32 noundef, i32 noundef, i32 noundef) local_unnamed_addr #1

declare i32 @_timer_clocks_per_sec() local_unnamed_addr #1

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #3

declare void @print_matrix(ptr noundef, i32 noundef, i32 noundef) local_unnamed_addr #1

declare ptr @copy_matrix(ptr noundef, ptr noundef, i32 noundef, i32 noundef) local_unnamed_addr #1

declare void @vectorized_matmul(ptr addrspace(4) noundef, ptr addrspace(4) noundef, ptr addrspace(4) noundef, i32 noundef, i32 noundef, i32 noundef) local_unnamed_addr #1

declare void @check_result(ptr noundef, ptr noundef, i32 noundef, i32 noundef) local_unnamed_addr #1

declare void @autovectorized_matmul(ptr addrspace(4) noundef, ptr addrspace(4) noundef, ptr addrspace(4) noundef, i32 noundef, i32 noundef, i32 noundef) local_unnamed_addr #1

declare void @vekt_matmul_wrapper(ptr noundef, ptr noundef, ptr noundef, i32 noundef, i32 noundef, i32 noundef) local_unnamed_addr #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #2

; Function Attrs: nofree nounwind
declare noundef i32 @putchar(i32 noundef) local_unnamed_addr #4

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #4

attributes #0 = { nounwind "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #1 = { "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #2 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #3 = { nofree nounwind "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #4 = { nofree nounwind }
attributes #5 = { nounwind }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"ArcIntrinsicCheck", i32 28778521}
!1 = !{i32 1, !"wchar_size", i32 2}
!2 = !{!"clang version 17.0.7 (git@gitsnps.internal.synopsys.com:MetaWare/mwdt-llvm-project.git 3cb6cb7579aa39b9c4db2b6a06b7c2eb3174f977)"}
