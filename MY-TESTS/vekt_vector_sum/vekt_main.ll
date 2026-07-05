; ModuleID = 'vekt_main.c'
source_filename = "vekt_main.c"
target datalayout = "e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-f64:32-v64:32-v128:32-a:0:32-v256:32-v512:32-n8:16:32"
target triple = "arc-pc-unknown-gnu"

@a = addrspace(4) global [8192 x i32] zeroinitializer, align 4
@b = addrspace(4) global [8192 x i32] zeroinitializer, align 4
@c = addrspace(4) global [8192 x i32] zeroinitializer, align 4
@.str = private unnamed_addr constant [40 x i8] c"Tempo di esecuzione di vec_sum: %.2fms\0A\00", align 1
@.str.2 = private unnamed_addr constant [30 x i8] c"a[%d]=%d, b[%d]=%d, c[%d]=%d\0A\00", align 1
@.str.4 = private unnamed_addr constant [23 x i8] c"Vettorizzo su %d lane\0A\00", align 1
@.str.5 = private unnamed_addr constant [51 x i8] c"Tempo di esecuzione di vectorized_vec_sum: %.2fms\0A\00", align 1
@.str.6 = private unnamed_addr constant [15 x i8] c"Speedup: %.2f\0A\00", align 1
@.str.8 = private unnamed_addr constant [30 x i8] c"\09puntatori array: %p, %p, %p\0A\00", align 1
@.str.9 = private unnamed_addr constant [55 x i8] c"Tempo di esecuzione di autovectorized_vec_sum: %.2fms\0A\00", align 1
@str.11 = private unnamed_addr constant [27 x i8] c"Versione vekt-vettorizzata\00", align 1
@str.12 = private unnamed_addr constant [30 x i8] c"Primi 5 elementi della somma:\00", align 1

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: write)
define dso_local void @init_vector(ptr nocapture noundef writeonly %a, i32 noundef %dim, i32 noundef %value) local_unnamed_addr #0 {
entry:
  %cmp3 = icmp sgt i32 %dim, 0
  br i1 %cmp3, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:                               ; preds = %entry
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body, %entry
  ret void

for.body:                                         ; preds = %for.body.preheader, %for.body
  %i.04 = phi i32 [ %inc, %for.body ], [ 0, %for.body.preheader ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i32 %i.04
  store i32 %value, ptr %arrayidx, align 4, !tbaa !3
  %inc = add nuw nsw i32 %i.04, 1
  %cmp = icmp slt i32 %inc, %dim
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !7
}

; Function Attrs: nounwind
define dso_local void @vekt_vec_sum_wrapper(ptr noundef %a, ptr noundef %b, ptr noundef %c, i32 noundef %n) local_unnamed_addr #1 {
entry:
  %conv = sext i32 %n to i64
  tail call void @vekt_vec_sum(ptr noundef %a, ptr noundef %a, i64 noundef 0, i64 noundef %conv, i64 noundef 1, ptr noundef %b, ptr noundef %b, i64 noundef 0, i64 noundef %conv, i64 noundef 1, ptr noundef %c, ptr noundef %c, i64 noundef 0, i64 noundef %conv, i64 noundef 1, i32 noundef %n) #10
  ret void
}

declare void @vekt_vec_sum(ptr noundef, ptr noundef, i64 noundef, i64 noundef, i64 noundef, ptr noundef, ptr noundef, i64 noundef, i64 noundef, i64 noundef, ptr noundef, ptr noundef, i64 noundef, i64 noundef, i64 noundef, i32 noundef) local_unnamed_addr #2

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @vec_sum(ptr nocapture noundef readonly %a, ptr nocapture noundef readonly %b, ptr nocapture noundef writeonly %c, i32 noundef %n) local_unnamed_addr #3 {
entry:
  %cmp7 = icmp sgt i32 %n, 0
  br i1 %cmp7, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:                               ; preds = %entry
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body, %entry
  ret void

for.body:                                         ; preds = %for.body.preheader, %for.body
  %i.08 = phi i32 [ %inc, %for.body ], [ 0, %for.body.preheader ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i32 %i.08
  %0 = load i32, ptr %arrayidx, align 4, !tbaa !3
  %arrayidx1 = getelementptr inbounds i32, ptr %b, i32 %i.08
  %1 = load i32, ptr %arrayidx1, align 4, !tbaa !3
  %add = add nsw i32 %1, %0
  %arrayidx2 = getelementptr inbounds i32, ptr %c, i32 %i.08
  store i32 %add, ptr %arrayidx2, align 4, !tbaa !3
  %inc = add nuw nsw i32 %i.08, 1
  %cmp = icmp slt i32 %inc, %n
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !9
}

; Function Attrs: mustprogress nofree nosync nounwind willreturn
define dso_local void @vectorized_vec_sum(ptr addrspace(4) noalias noundef %a, ptr addrspace(4) noalias noundef %b, ptr addrspace(4) noalias noundef %c, i32 noundef %n) local_unnamed_addr #4 {
entry:
  %div = sdiv i32 %n, 16
  %cmp14 = icmp sgt i32 %n, 15
  br i1 %cmp14, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:                               ; preds = %entry
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body, %entry
  ret void

for.body:                                         ; preds = %for.body.preheader, %for.body
  %i.015 = phi i32 [ %inc, %for.body ], [ 0, %for.body.preheader ]
  %mul = shl nsw i32 %i.015, 4
  %arrayidx = getelementptr inbounds i32, ptr addrspace(4) %a, i32 %mul
  %0 = tail call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %arrayidx)
  %arrayidx2 = getelementptr inbounds i32, ptr addrspace(4) %b, i32 %mul
  %1 = tail call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %arrayidx2)
  %2 = tail call <16 x i32> @llvm.arc.vvadd.w.v512(<16 x i32> %0, <16 x i32> %1)
  %arrayidx6 = getelementptr inbounds i32, ptr addrspace(4) %c, i32 %mul
  tail call void @llvm.arc.vvst.w.v512(<16 x i32> %2, ptr addrspace(4) %arrayidx6)
  %inc = add nuw nsw i32 %i.015, 1
  %cmp = icmp slt i32 %inc, %div
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !14
}

; Function Attrs: nounwind
define dso_local i32 @main() local_unnamed_addr #1 {
entry:
  br label %for.body

for.body.i:                                       ; preds = %for.body.i, %for.body.i.preheader
  %i.04.i = phi i32 [ 0, %for.body.i.preheader ], [ %inc.i.1, %for.body.i ]
  %arrayidx.i = getelementptr inbounds i32, ptr addrspacecast (ptr addrspace(4) @c to ptr), i32 %i.04.i
  store i32 -1, ptr %arrayidx.i, align 4, !tbaa !3
  %inc.i = add nuw nsw i32 %i.04.i, 1
  %arrayidx.i.1 = getelementptr inbounds i32, ptr addrspacecast (ptr addrspace(4) @c to ptr), i32 %inc.i
  store i32 -1, ptr %arrayidx.i.1, align 4, !tbaa !3
  %inc.i.1 = add nuw nsw i32 %i.04.i, 2
  %cmp.i.1 = icmp ult i32 %inc.i.1, 8192
  br i1 %cmp.i.1, label %for.body.i, label %init_vector.exit, !llvm.loop !7

init_vector.exit:                                 ; preds = %for.body.i
  %call = tail call i32 @clock() #10
  br label %for.body.i114

for.body.i114:                                    ; preds = %for.body.i114, %init_vector.exit
  %i.08.i = phi i32 [ 0, %init_vector.exit ], [ %inc.i116.1, %for.body.i114 ]
  %arrayidx.i115 = getelementptr inbounds i32, ptr addrspacecast (ptr addrspace(4) @a to ptr), i32 %i.08.i
  %0 = load i32, ptr %arrayidx.i115, align 4, !tbaa !3
  %arrayidx1.i = getelementptr inbounds i32, ptr addrspacecast (ptr addrspace(4) @b to ptr), i32 %i.08.i
  %1 = load i32, ptr %arrayidx1.i, align 4, !tbaa !3
  %add.i = add nsw i32 %1, %0
  %arrayidx2.i = getelementptr inbounds i32, ptr addrspacecast (ptr addrspace(4) @c to ptr), i32 %i.08.i
  store i32 %add.i, ptr %arrayidx2.i, align 4, !tbaa !3
  %inc.i116 = add nuw nsw i32 %i.08.i, 1
  %arrayidx.i115.1 = getelementptr inbounds i32, ptr addrspacecast (ptr addrspace(4) @a to ptr), i32 %inc.i116
  %2 = load i32, ptr %arrayidx.i115.1, align 4, !tbaa !3
  %arrayidx1.i.1 = getelementptr inbounds i32, ptr addrspacecast (ptr addrspace(4) @b to ptr), i32 %inc.i116
  %3 = load i32, ptr %arrayidx1.i.1, align 4, !tbaa !3
  %add.i.1 = add nsw i32 %3, %2
  %arrayidx2.i.1 = getelementptr inbounds i32, ptr addrspacecast (ptr addrspace(4) @c to ptr), i32 %inc.i116
  store i32 %add.i.1, ptr %arrayidx2.i.1, align 4, !tbaa !3
  %inc.i116.1 = add nuw nsw i32 %i.08.i, 2
  %cmp.i117.1 = icmp ult i32 %inc.i116.1, 8192
  br i1 %cmp.i117.1, label %for.body.i114, label %vec_sum.exit, !llvm.loop !9

vec_sum.exit:                                     ; preds = %for.body.i114
  %call3 = tail call i32 @clock() #10
  %sub = sub nsw i32 %call3, %call
  %conv = sitofp i32 %sub to double
  %call4 = tail call i32 @_timer_clocks_per_sec() #10
  %conv5 = uitofp i32 %call4 to double
  %div = fdiv contract double %conv, %conv5
  %mul = fmul contract double %div, 1.000000e+03
  %call6 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, double noundef %mul)
  %puts = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.12)
  %4 = load i32, ptr addrspace(4) @a, align 4, !tbaa !3
  %5 = load i32, ptr addrspace(4) @b, align 4, !tbaa !3
  %6 = load i32, ptr addrspace(4) @c, align 4, !tbaa !3
  %call17 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef 0, i32 noundef %4, i32 noundef 0, i32 noundef %5, i32 noundef 0, i32 noundef %6)
  %7 = load i32, ptr addrspace(4) getelementptr inbounds ([8192 x i32], ptr addrspace(4) @a, i32 0, i32 1), align 4, !tbaa !3
  %8 = load i32, ptr addrspace(4) getelementptr inbounds ([8192 x i32], ptr addrspace(4) @b, i32 0, i32 1), align 4, !tbaa !3
  %9 = load i32, ptr addrspace(4) getelementptr inbounds ([8192 x i32], ptr addrspace(4) @c, i32 0, i32 1), align 4, !tbaa !3
  %call17.1 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef 1, i32 noundef %7, i32 noundef 1, i32 noundef %8, i32 noundef 1, i32 noundef %9)
  %10 = load i32, ptr addrspace(4) getelementptr inbounds ([8192 x i32], ptr addrspace(4) @a, i32 0, i32 2), align 4, !tbaa !3
  %11 = load i32, ptr addrspace(4) getelementptr inbounds ([8192 x i32], ptr addrspace(4) @b, i32 0, i32 2), align 4, !tbaa !3
  %12 = load i32, ptr addrspace(4) getelementptr inbounds ([8192 x i32], ptr addrspace(4) @c, i32 0, i32 2), align 4, !tbaa !3
  %call17.2 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef 2, i32 noundef %10, i32 noundef 2, i32 noundef %11, i32 noundef 2, i32 noundef %12)
  %13 = load i32, ptr addrspace(4) getelementptr inbounds ([8192 x i32], ptr addrspace(4) @a, i32 0, i32 3), align 4, !tbaa !3
  %14 = load i32, ptr addrspace(4) getelementptr inbounds ([8192 x i32], ptr addrspace(4) @b, i32 0, i32 3), align 4, !tbaa !3
  %15 = load i32, ptr addrspace(4) getelementptr inbounds ([8192 x i32], ptr addrspace(4) @c, i32 0, i32 3), align 4, !tbaa !3
  %call17.3 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef 3, i32 noundef %13, i32 noundef 3, i32 noundef %14, i32 noundef 3, i32 noundef %15)
  %16 = load i32, ptr addrspace(4) getelementptr inbounds ([8192 x i32], ptr addrspace(4) @a, i32 0, i32 4), align 4, !tbaa !3
  %17 = load i32, ptr addrspace(4) getelementptr inbounds ([8192 x i32], ptr addrspace(4) @b, i32 0, i32 4), align 4, !tbaa !3
  %18 = load i32, ptr addrspace(4) getelementptr inbounds ([8192 x i32], ptr addrspace(4) @c, i32 0, i32 4), align 4, !tbaa !3
  %call17.4 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef 4, i32 noundef %16, i32 noundef 4, i32 noundef %17, i32 noundef 4, i32 noundef %18)
  %putchar = tail call i32 @putchar(i32 10)
  %call22 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.4, i32 noundef 16)
  br label %for.body.i118

for.body:                                         ; preds = %for.body, %entry
  %i.0135 = phi i32 [ 0, %entry ], [ %add.1, %for.body ]
  %add = add nuw nsw i32 %i.0135, 1
  %arrayidx = getelementptr inbounds [8192 x i32], ptr addrspace(4) @a, i32 0, i32 %i.0135
  store i32 %add, ptr addrspace(4) %arrayidx, align 4, !tbaa !3
  %arrayidx2 = getelementptr inbounds [8192 x i32], ptr addrspace(4) @b, i32 0, i32 %i.0135
  store i32 %add, ptr addrspace(4) %arrayidx2, align 4, !tbaa !3
  %add.1 = add nuw nsw i32 %i.0135, 2
  %arrayidx.1 = getelementptr inbounds [8192 x i32], ptr addrspace(4) @a, i32 0, i32 %add
  store i32 %add.1, ptr addrspace(4) %arrayidx.1, align 4, !tbaa !3
  %arrayidx2.1 = getelementptr inbounds [8192 x i32], ptr addrspace(4) @b, i32 0, i32 %add
  store i32 %add.1, ptr addrspace(4) %arrayidx2.1, align 4, !tbaa !3
  %cmp.1 = icmp ult i32 %add.1, 8192
  br i1 %cmp.1, label %for.body, label %for.body.i.preheader, !llvm.loop !15

for.body.i.preheader:                             ; preds = %for.body
  br label %for.body.i

for.body.i118:                                    ; preds = %for.body.i118, %vec_sum.exit
  %i.04.i119 = phi i32 [ 0, %vec_sum.exit ], [ %inc.i121.1, %for.body.i118 ]
  %arrayidx.i120 = getelementptr inbounds i32, ptr addrspacecast (ptr addrspace(4) @c to ptr), i32 %i.04.i119
  store i32 -1, ptr %arrayidx.i120, align 4, !tbaa !3
  %inc.i121 = add nuw nsw i32 %i.04.i119, 1
  %arrayidx.i120.1 = getelementptr inbounds i32, ptr addrspacecast (ptr addrspace(4) @c to ptr), i32 %inc.i121
  store i32 -1, ptr %arrayidx.i120.1, align 4, !tbaa !3
  %inc.i121.1 = add nuw nsw i32 %i.04.i119, 2
  %cmp.i122.1 = icmp ult i32 %inc.i121.1, 8192
  br i1 %cmp.i122.1, label %for.body.i118, label %init_vector.exit123, !llvm.loop !7

init_vector.exit123:                              ; preds = %for.body.i118
  %call23 = tail call i32 @clock() #10
  br label %for.body.i124

for.body.i124:                                    ; preds = %for.body.i124, %init_vector.exit123
  %i.015.i = phi i32 [ 0, %init_vector.exit123 ], [ %inc.i127.1, %for.body.i124 ]
  %mul.i = shl i32 %i.015.i, 4
  %arrayidx.i125 = getelementptr inbounds i32, ptr addrspace(4) @a, i32 %mul.i
  %19 = tail call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %arrayidx.i125)
  %arrayidx2.i126 = getelementptr inbounds i32, ptr addrspace(4) @b, i32 %mul.i
  %20 = tail call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %arrayidx2.i126)
  %21 = tail call <16 x i32> @llvm.arc.vvadd.w.v512(<16 x i32> %19, <16 x i32> %20)
  %arrayidx6.i = getelementptr inbounds i32, ptr addrspace(4) @c, i32 %mul.i
  tail call void @llvm.arc.vvst.w.v512(<16 x i32> %21, ptr addrspace(4) %arrayidx6.i)
  %mul.i.1 = add nuw nsw i32 %mul.i, 16
  %arrayidx.i125.1 = getelementptr inbounds i32, ptr addrspace(4) @a, i32 %mul.i.1
  %22 = tail call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %arrayidx.i125.1)
  %arrayidx2.i126.1 = getelementptr inbounds i32, ptr addrspace(4) @b, i32 %mul.i.1
  %23 = tail call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %arrayidx2.i126.1)
  %24 = tail call <16 x i32> @llvm.arc.vvadd.w.v512(<16 x i32> %22, <16 x i32> %23)
  %arrayidx6.i.1 = getelementptr inbounds i32, ptr addrspace(4) @c, i32 %mul.i.1
  tail call void @llvm.arc.vvst.w.v512(<16 x i32> %24, ptr addrspace(4) %arrayidx6.i.1)
  %inc.i127.1 = add nuw nsw i32 %i.015.i, 2
  %cmp.i128.1 = icmp ult i32 %inc.i127.1, 512
  br i1 %cmp.i128.1, label %for.body.i124, label %vectorized_vec_sum.exit, !llvm.loop !14

vectorized_vec_sum.exit:                          ; preds = %for.body.i124
  %call24 = tail call i32 @clock() #10
  %sub25 = sub nsw i32 %call24, %call23
  %conv26 = sitofp i32 %sub25 to double
  %call27 = tail call i32 @_timer_clocks_per_sec() #10
  %conv28 = uitofp i32 %call27 to double
  %div29 = fdiv contract double %conv26, %conv28
  %mul30 = fmul contract double %div29, 1.000000e+03
  %call31 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, double noundef %mul30)
  %div32 = fdiv contract double %mul, %mul30
  %call33 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.6, double noundef %div32)
  %puts110 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.12)
  %25 = load i32, ptr addrspace(4) @a, align 4, !tbaa !3
  %26 = load i32, ptr addrspace(4) @b, align 4, !tbaa !3
  %27 = load i32, ptr addrspace(4) @c, align 4, !tbaa !3
  %call44 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef 0, i32 noundef %25, i32 noundef 0, i32 noundef %26, i32 noundef 0, i32 noundef %27)
  %28 = load i32, ptr addrspace(4) getelementptr inbounds ([8192 x i32], ptr addrspace(4) @a, i32 0, i32 1), align 4, !tbaa !3
  %29 = load i32, ptr addrspace(4) getelementptr inbounds ([8192 x i32], ptr addrspace(4) @b, i32 0, i32 1), align 4, !tbaa !3
  %30 = load i32, ptr addrspace(4) getelementptr inbounds ([8192 x i32], ptr addrspace(4) @c, i32 0, i32 1), align 4, !tbaa !3
  %call44.1 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef 1, i32 noundef %28, i32 noundef 1, i32 noundef %29, i32 noundef 1, i32 noundef %30)
  %31 = load i32, ptr addrspace(4) getelementptr inbounds ([8192 x i32], ptr addrspace(4) @a, i32 0, i32 2), align 4, !tbaa !3
  %32 = load i32, ptr addrspace(4) getelementptr inbounds ([8192 x i32], ptr addrspace(4) @b, i32 0, i32 2), align 4, !tbaa !3
  %33 = load i32, ptr addrspace(4) getelementptr inbounds ([8192 x i32], ptr addrspace(4) @c, i32 0, i32 2), align 4, !tbaa !3
  %call44.2 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef 2, i32 noundef %31, i32 noundef 2, i32 noundef %32, i32 noundef 2, i32 noundef %33)
  %34 = load i32, ptr addrspace(4) getelementptr inbounds ([8192 x i32], ptr addrspace(4) @a, i32 0, i32 3), align 4, !tbaa !3
  %35 = load i32, ptr addrspace(4) getelementptr inbounds ([8192 x i32], ptr addrspace(4) @b, i32 0, i32 3), align 4, !tbaa !3
  %36 = load i32, ptr addrspace(4) getelementptr inbounds ([8192 x i32], ptr addrspace(4) @c, i32 0, i32 3), align 4, !tbaa !3
  %call44.3 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef 3, i32 noundef %34, i32 noundef 3, i32 noundef %35, i32 noundef 3, i32 noundef %36)
  %37 = load i32, ptr addrspace(4) getelementptr inbounds ([8192 x i32], ptr addrspace(4) @a, i32 0, i32 4), align 4, !tbaa !3
  %38 = load i32, ptr addrspace(4) getelementptr inbounds ([8192 x i32], ptr addrspace(4) @b, i32 0, i32 4), align 4, !tbaa !3
  %39 = load i32, ptr addrspace(4) getelementptr inbounds ([8192 x i32], ptr addrspace(4) @c, i32 0, i32 4), align 4, !tbaa !3
  %call44.4 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef 4, i32 noundef %37, i32 noundef 4, i32 noundef %38, i32 noundef 4, i32 noundef %39)
  %putchar111 = tail call i32 @putchar(i32 10)
  %puts112 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.11)
  %call50 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.8, ptr addrspace(4) noundef @a, ptr addrspace(4) noundef @b, ptr addrspace(4) noundef @c)
  br label %for.body.i129

for.body.i129:                                    ; preds = %for.body.i129, %vectorized_vec_sum.exit
  %i.04.i130 = phi i32 [ 0, %vectorized_vec_sum.exit ], [ %inc.i132.1, %for.body.i129 ]
  %arrayidx.i131 = getelementptr inbounds i32, ptr addrspacecast (ptr addrspace(4) @c to ptr), i32 %i.04.i130
  store i32 -1, ptr %arrayidx.i131, align 4, !tbaa !3
  %inc.i132 = add nuw nsw i32 %i.04.i130, 1
  %arrayidx.i131.1 = getelementptr inbounds i32, ptr addrspacecast (ptr addrspace(4) @c to ptr), i32 %inc.i132
  store i32 -1, ptr %arrayidx.i131.1, align 4, !tbaa !3
  %inc.i132.1 = add nuw nsw i32 %i.04.i130, 2
  %cmp.i133.1 = icmp ult i32 %inc.i132.1, 8192
  br i1 %cmp.i133.1, label %for.body.i129, label %init_vector.exit134, !llvm.loop !7

init_vector.exit134:                              ; preds = %for.body.i129
  %call51 = tail call i32 @clock() #10
  tail call void @vekt_vec_sum(ptr noundef addrspacecast (ptr addrspace(4) @a to ptr), ptr noundef addrspacecast (ptr addrspace(4) @a to ptr), i64 noundef 0, i64 noundef 8192, i64 noundef 1, ptr noundef addrspacecast (ptr addrspace(4) @b to ptr), ptr noundef addrspacecast (ptr addrspace(4) @b to ptr), i64 noundef 0, i64 noundef 8192, i64 noundef 1, ptr noundef addrspacecast (ptr addrspace(4) @c to ptr), ptr noundef addrspacecast (ptr addrspace(4) @c to ptr), i64 noundef 0, i64 noundef 8192, i64 noundef 1, i32 noundef 8192) #10
  %call52 = tail call i32 @clock() #10
  %sub53 = sub nsw i32 %call52, %call51
  %conv54 = sitofp i32 %sub53 to double
  %call55 = tail call i32 @_timer_clocks_per_sec() #10
  %conv56 = uitofp i32 %call55 to double
  %div57 = fdiv contract double %conv54, %conv56
  %mul58 = fmul contract double %div57, 1.000000e+03
  %call59 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.9, double noundef %mul58)
  %div60 = fdiv contract double %mul, %mul58
  %call61 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.6, double noundef %div60)
  %puts113 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.12)
  %40 = load i32, ptr addrspace(4) @a, align 4, !tbaa !3
  %41 = load i32, ptr addrspace(4) @b, align 4, !tbaa !3
  %42 = load i32, ptr addrspace(4) @c, align 4, !tbaa !3
  %call72 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef 0, i32 noundef %40, i32 noundef 0, i32 noundef %41, i32 noundef 0, i32 noundef %42)
  %43 = load i32, ptr addrspace(4) getelementptr inbounds ([8192 x i32], ptr addrspace(4) @a, i32 0, i32 1), align 4, !tbaa !3
  %44 = load i32, ptr addrspace(4) getelementptr inbounds ([8192 x i32], ptr addrspace(4) @b, i32 0, i32 1), align 4, !tbaa !3
  %45 = load i32, ptr addrspace(4) getelementptr inbounds ([8192 x i32], ptr addrspace(4) @c, i32 0, i32 1), align 4, !tbaa !3
  %call72.1 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef 1, i32 noundef %43, i32 noundef 1, i32 noundef %44, i32 noundef 1, i32 noundef %45)
  %46 = load i32, ptr addrspace(4) getelementptr inbounds ([8192 x i32], ptr addrspace(4) @a, i32 0, i32 2), align 4, !tbaa !3
  %47 = load i32, ptr addrspace(4) getelementptr inbounds ([8192 x i32], ptr addrspace(4) @b, i32 0, i32 2), align 4, !tbaa !3
  %48 = load i32, ptr addrspace(4) getelementptr inbounds ([8192 x i32], ptr addrspace(4) @c, i32 0, i32 2), align 4, !tbaa !3
  %call72.2 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef 2, i32 noundef %46, i32 noundef 2, i32 noundef %47, i32 noundef 2, i32 noundef %48)
  %49 = load i32, ptr addrspace(4) getelementptr inbounds ([8192 x i32], ptr addrspace(4) @a, i32 0, i32 3), align 4, !tbaa !3
  %50 = load i32, ptr addrspace(4) getelementptr inbounds ([8192 x i32], ptr addrspace(4) @b, i32 0, i32 3), align 4, !tbaa !3
  %51 = load i32, ptr addrspace(4) getelementptr inbounds ([8192 x i32], ptr addrspace(4) @c, i32 0, i32 3), align 4, !tbaa !3
  %call72.3 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef 3, i32 noundef %49, i32 noundef 3, i32 noundef %50, i32 noundef 3, i32 noundef %51)
  %52 = load i32, ptr addrspace(4) getelementptr inbounds ([8192 x i32], ptr addrspace(4) @a, i32 0, i32 4), align 4, !tbaa !3
  %53 = load i32, ptr addrspace(4) getelementptr inbounds ([8192 x i32], ptr addrspace(4) @b, i32 0, i32 4), align 4, !tbaa !3
  %54 = load i32, ptr addrspace(4) getelementptr inbounds ([8192 x i32], ptr addrspace(4) @c, i32 0, i32 4), align 4, !tbaa !3
  %call72.4 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef 4, i32 noundef %52, i32 noundef 4, i32 noundef %53, i32 noundef 4, i32 noundef %54)
  ret i32 0
}

declare i32 @clock() local_unnamed_addr #2

declare i32 @_timer_clocks_per_sec() local_unnamed_addr #2

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #5

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(read)
declare <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4)) #6

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <16 x i32> @llvm.arc.vvadd.w.v512(<16 x i32>, <16 x i32>) #7

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(write)
declare void @llvm.arc.vvst.w.v512(<16 x i32>, ptr addrspace(4)) #8

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #9

; Function Attrs: nofree nounwind
declare noundef i32 @putchar(i32 noundef) local_unnamed_addr #9

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: write) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" }
attributes #1 = { nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" }
attributes #2 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" }
attributes #3 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" }
attributes #4 = { mustprogress nofree nosync nounwind willreturn "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" }
attributes #5 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" }
attributes #6 = { mustprogress nocallback nofree nosync nounwind willreturn memory(read) }
attributes #7 = { mustprogress nocallback nofree nosync nounwind willreturn memory(none) }
attributes #8 = { mustprogress nocallback nofree nosync nounwind willreturn memory(write) }
attributes #9 = { nofree nounwind }
attributes #10 = { nounwind }

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
!9 = distinct !{!9, !8, !10, !11}
!10 = !{!"llvm.loop.vectorize.width", i32 1}
!11 = !{!"llvm.loop.vectorize.followup_all", !12}
!12 = distinct !{!12, !8, !13}
!13 = !{!"llvm.loop.isvectorized"}
!14 = distinct !{!14, !8}
!15 = distinct !{!15, !8}
