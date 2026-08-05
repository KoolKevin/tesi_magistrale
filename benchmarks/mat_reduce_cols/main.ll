; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-f64:32-v64:32-v128:32-a:0:32-v256:32-v512:32-n8:16:32"
target triple = "arc-pc-unknown-gnu"

@a = addrspace(4) global [2048 x i32] zeroinitializer, align 4
@res = addrspace(4) global [16 x i32] zeroinitializer, align 4
@.str = private unnamed_addr constant [29 x i8] c"Tempo di esecuzione: %.2fms\0A\00", align 1
@.str.2 = private unnamed_addr constant [23 x i8] c"Vettorizzo su %d lane\0A\00", align 1
@.str.3 = private unnamed_addr constant [59 x i8] c"Tempo di esecuzione di vectorized_mat_reduce_cols: %.2fms\0A\00", align 1
@.str.4 = private unnamed_addr constant [15 x i8] c"Speedup: %.2f\0A\00", align 1
@.str.6 = private unnamed_addr constant [63 x i8] c"Tempo di esecuzione di autovectorized_mat_reduce_cols: %.2fms\0A\00", align 1
@.str.8 = private unnamed_addr constant [53 x i8] c"Tempo di esecuzione di vekt_mat_reduce_cols: %.2fms\0A\00", align 1
@str = private unnamed_addr constant [26 x i8] c"Versione autovettorizzata\00", align 1
@str.9 = private unnamed_addr constant [27 x i8] c"Versione vekt-vettorizzata\00", align 1

; Function Attrs: nounwind
define dso_local i32 @main() local_unnamed_addr #0 {
entry:
  %groundtruth = alloca [16 x i32], align 4
  tail call void @init_matrix(ptr noundef addrspacecast (ptr addrspace(4) @a to ptr), i32 noundef 128, i32 noundef 16, i32 noundef 1) #5
  tail call void @init_vector(ptr noundef addrspacecast (ptr addrspace(4) @res to ptr), i32 noundef 16, i32 noundef 0) #5
  %call = tail call i32 @clock() #5
  tail call void @mat_reduce_cols(ptr noundef addrspacecast (ptr addrspace(4) @a to ptr), ptr noundef addrspacecast (ptr addrspace(4) @res to ptr), i32 noundef 128, i32 noundef 16) #5
  %call1 = tail call i32 @clock() #5
  %sub = sub nsw i32 %call1, %call
  %conv = sitofp i32 %sub to double
  %call2 = tail call i32 @_timer_clocks_per_sec() #5
  %conv3 = uitofp i32 %call2 to double
  %0 = fmul fast double %conv, 1.000000e+03
  %mul = fdiv fast double %0, %conv3
  %call4 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, double noundef nofpclass(nan inf) %mul)
  tail call void @print_vector(ptr noundef addrspacecast (ptr addrspace(4) @res to ptr), i32 noundef 16) #5
  call void @llvm.lifetime.start.p0(i64 64, ptr nonnull %groundtruth) #5
  %1 = load <16 x i32>, ptr addrspace(4) @res, align 4, !tbaa !3
  store <16 x i32> %1, ptr %groundtruth, align 4, !tbaa !3
  %putchar = tail call i32 @putchar(i32 10)
  %call8 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef 16)
  tail call void @init_vector(ptr noundef addrspacecast (ptr addrspace(4) @res to ptr), i32 noundef 16, i32 noundef 0) #5
  %call9 = tail call i32 @clock() #5
  tail call void @vectorized_mat_reduce_cols(ptr addrspace(4) noundef @a, ptr addrspace(4) noundef @res, i32 noundef 128, i32 noundef 16) #5
  %call10 = tail call i32 @clock() #5
  %sub11 = sub nsw i32 %call10, %call9
  %conv12 = sitofp i32 %sub11 to double
  %call13 = tail call i32 @_timer_clocks_per_sec() #5
  %conv14 = uitofp i32 %call13 to double
  %2 = fmul fast double %conv12, 1.000000e+03
  %mul16 = fdiv fast double %2, %conv14
  %call17 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, double noundef nofpclass(nan inf) %mul16)
  %div18 = fdiv fast double %mul, %mul16
  %call19 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.4, double noundef nofpclass(nan inf) %div18)
  tail call void @print_vector(ptr noundef addrspacecast (ptr addrspace(4) @res to ptr), i32 noundef 16) #5
  call void @check_result(ptr noundef nonnull %groundtruth, ptr noundef addrspacecast (ptr addrspace(4) @res to ptr), i32 noundef 16) #5
  %putchar64 = call i32 @putchar(i32 10)
  %puts = call i32 @puts(ptr nonnull dereferenceable(1) @str)
  call void @init_vector(ptr noundef addrspacecast (ptr addrspace(4) @res to ptr), i32 noundef 16, i32 noundef 0) #5
  %call22 = call i32 @clock() #5
  call void @autovectorized_mat_reduce_cols(ptr addrspace(4) noundef @a, ptr addrspace(4) noundef @res, i32 noundef 128, i32 noundef 16) #5
  %call23 = call i32 @clock() #5
  %sub24 = sub nsw i32 %call23, %call22
  %conv25 = sitofp i32 %sub24 to double
  %call26 = call i32 @_timer_clocks_per_sec() #5
  %conv27 = uitofp i32 %call26 to double
  %3 = fmul fast double %conv25, 1.000000e+03
  %mul29 = fdiv fast double %3, %conv27
  %call30 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.6, double noundef nofpclass(nan inf) %mul29)
  %div31 = fdiv fast double %mul, %mul29
  %call32 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.4, double noundef nofpclass(nan inf) %div31)
  call void @print_vector(ptr noundef addrspacecast (ptr addrspace(4) @res to ptr), i32 noundef 16) #5
  call void @check_result(ptr noundef nonnull %groundtruth, ptr noundef addrspacecast (ptr addrspace(4) @res to ptr), i32 noundef 16) #5
  %putchar65 = call i32 @putchar(i32 10)
  %puts66 = call i32 @puts(ptr nonnull dereferenceable(1) @str.9)
  call void @init_vector(ptr noundef addrspacecast (ptr addrspace(4) @res to ptr), i32 noundef 16, i32 noundef 0) #5
  %call36 = call i32 @clock() #5
  call void @vekt_mat_reduce_cols_wrapper(ptr noundef addrspacecast (ptr addrspace(4) @a to ptr), ptr noundef addrspacecast (ptr addrspace(4) @res to ptr), i32 noundef 128, i32 noundef 16) #5
  %call37 = call i32 @clock() #5
  %sub38 = sub nsw i32 %call37, %call36
  %conv39 = sitofp i32 %sub38 to double
  %call40 = call i32 @_timer_clocks_per_sec() #5
  %conv41 = uitofp i32 %call40 to double
  %4 = fmul fast double %conv39, 1.000000e+03
  %mul43 = fdiv fast double %4, %conv41
  %call44 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.8, double noundef nofpclass(nan inf) %mul43)
  %div45 = fdiv fast double %mul, %mul43
  %call46 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.4, double noundef nofpclass(nan inf) %div45)
  call void @print_vector(ptr noundef addrspacecast (ptr addrspace(4) @res to ptr), i32 noundef 16) #5
  call void @check_result(ptr noundef nonnull %groundtruth, ptr noundef addrspacecast (ptr addrspace(4) @res to ptr), i32 noundef 16) #5
  %putchar67 = call i32 @putchar(i32 10)
  call void @llvm.lifetime.end.p0(i64 64, ptr nonnull %groundtruth) #5
  ret i32 0
}

declare void @init_matrix(ptr noundef, i32 noundef, i32 noundef, i32 noundef) local_unnamed_addr #1

declare void @init_vector(ptr noundef, i32 noundef, i32 noundef) local_unnamed_addr #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #2

declare i32 @clock() local_unnamed_addr #1

declare void @mat_reduce_cols(ptr noundef, ptr noundef, i32 noundef, i32 noundef) local_unnamed_addr #1

declare i32 @_timer_clocks_per_sec() local_unnamed_addr #1

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #3

declare void @print_vector(ptr noundef, i32 noundef) local_unnamed_addr #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #2

declare void @vectorized_mat_reduce_cols(ptr addrspace(4) noundef, ptr addrspace(4) noundef, i32 noundef, i32 noundef) local_unnamed_addr #1

declare void @check_result(ptr noundef, ptr noundef, i32 noundef) local_unnamed_addr #1

declare void @autovectorized_mat_reduce_cols(ptr addrspace(4) noundef, ptr addrspace(4) noundef, i32 noundef, i32 noundef) local_unnamed_addr #1

declare void @vekt_mat_reduce_cols_wrapper(ptr noundef, ptr noundef, i32 noundef, i32 noundef) local_unnamed_addr #1

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
!3 = !{!4, !4, i64 0}
!4 = !{!"int", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C/C++ TBAA"}
