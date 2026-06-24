; ModuleID = 'vekt_main.c'
source_filename = "vekt_main.c"
target datalayout = "e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-f64:32-v64:32-v128:32-a:0:32-v256:32-v512:32-n8:16:32"
target triple = "arc-pc-unknown-gnu"

@.str = private unnamed_addr constant [5 x i8] c"\09%d\0A\00", align 1
@.str.2 = private unnamed_addr constant [40 x i8] c"Tempo di esecuzione di vec_sum: %.2fms\0A\00", align 1
@.str.4 = private unnamed_addr constant [30 x i8] c"a[%d]=%d, b[%d]=%d, c[%d]=%d\0A\00", align 1
@.str.6 = private unnamed_addr constant [23 x i8] c"Vettorizzo su %d lane\0A\00", align 1
@.str.7 = private unnamed_addr constant [51 x i8] c"Tempo di esecuzione di vectorized_vec_sum: %.2fms\0A\00", align 1
@.str.8 = private unnamed_addr constant [15 x i8] c"Speedup: %.2f\0A\00", align 1
@.str.10 = private unnamed_addr constant [55 x i8] c"Tempo di esecuzione di autovectorized_vec_sum: %.2fms\0A\00", align 1
@str = private unnamed_addr constant [39 x i8] c"Errore nell'allocazione della memoria.\00", align 1
@str.13 = private unnamed_addr constant [27 x i8] c"Versione vekt-vettorizzata\00", align 1
@str.14 = private unnamed_addr constant [30 x i8] c"Primi 5 elementi della somma:\00", align 1

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
  tail call void @vekt_vec_sum(ptr noundef %a, ptr noundef %a, i32 noundef 0, i32 noundef %n, i32 noundef 1, ptr noundef %b, ptr noundef %b, i32 noundef 0, i32 noundef %n, i32 noundef 1, ptr noundef %c, ptr noundef %c, i32 noundef 0, i32 noundef %n, i32 noundef 1, i32 noundef %n) #9
  ret void
}

declare void @vekt_vec_sum(ptr noundef, ptr noundef, i32 noundef, i32 noundef, i32 noundef, ptr noundef, ptr noundef, i32 noundef, i32 noundef, i32 noundef, ptr noundef, ptr noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef) local_unnamed_addr #2

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
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !10
}

; Function Attrs: nofree nounwind
define dso_local void @vectorized_vec_sum(ptr addrspace(4) noalias noundef %a, ptr addrspace(4) noalias noundef %b, ptr addrspace(4) noalias noundef %c, i32 noundef %n) local_unnamed_addr #4 {
entry:
  %div = sdiv i32 %n, 16
  %cmp45 = icmp sgt i32 %n, 15
  br i1 %cmp45, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:                               ; preds = %entry
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body, %entry
  %mul10 = shl nsw i32 %div, 4
  %0 = shl nsw i32 %div, 4
  %rem.decomposed = sub i32 %n, %0
  %add = add nsw i32 %mul10, %rem.decomposed
  %cmp1347 = icmp sgt i32 %rem.decomposed, 0
  br i1 %cmp1347, label %for.body15.preheader, label %for.cond.cleanup14

for.body15.preheader:                             ; preds = %for.cond.cleanup
  br label %for.body15

for.body:                                         ; preds = %for.body.preheader, %for.body
  %i.046 = phi i32 [ %inc, %for.body ], [ 0, %for.body.preheader ]
  %mul = shl nsw i32 %i.046, 4
  %arrayidx = getelementptr inbounds i32, ptr addrspace(4) %a, i32 %mul
  %1 = tail call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %arrayidx)
  %arrayidx2 = getelementptr inbounds i32, ptr addrspace(4) %b, i32 %mul
  %2 = tail call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %arrayidx2)
  %3 = tail call <16 x i32> @llvm.arc.vvadd.w.v512(<16 x i32> %1, <16 x i32> %2)
  %arrayidx6 = getelementptr inbounds i32, ptr addrspace(4) %c, i32 %mul
  tail call void @llvm.arc.vvst.w.v512(<16 x i32> %3, ptr addrspace(4) %arrayidx6)
  %4 = load i32, ptr addrspace(4) %arrayidx6, align 4, !tbaa !3
  %call9 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i32 noundef %4)
  %inc = add nuw nsw i32 %i.046, 1
  %cmp = icmp slt i32 %inc, %div
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !15

for.cond.cleanup14:                               ; preds = %for.body15, %for.cond.cleanup
  ret void

for.body15:                                       ; preds = %for.body15.preheader, %for.body15
  %i11.048 = phi i32 [ %inc21, %for.body15 ], [ %mul10, %for.body15.preheader ]
  %arrayidx16 = getelementptr inbounds i32, ptr addrspace(4) %a, i32 %i11.048
  %5 = load i32, ptr addrspace(4) %arrayidx16, align 4, !tbaa !3
  %arrayidx17 = getelementptr inbounds i32, ptr addrspace(4) %b, i32 %i11.048
  %6 = load i32, ptr addrspace(4) %arrayidx17, align 4, !tbaa !3
  %add18 = add nsw i32 %6, %5
  %arrayidx19 = getelementptr inbounds i32, ptr addrspace(4) %c, i32 %i11.048
  store i32 %add18, ptr addrspace(4) %arrayidx19, align 4, !tbaa !3
  %inc21 = add nsw i32 %i11.048, 1
  %cmp13 = icmp slt i32 %inc21, %add
  br i1 %cmp13, label %for.body15, label %for.cond.cleanup14, !llvm.loop !16
}

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #4

; Function Attrs: nounwind
define dso_local i32 @main() local_unnamed_addr #1 {
entry:
  %0 = alloca [4096 x i8], align 16, addrspace(4)
  %1 = alloca [4096 x i8], align 16, addrspace(4)
  %2 = alloca [4096 x i8], align 16, addrspace(4)
  %tobool = icmp ne ptr addrspace(4) %0, null
  %tobool1 = icmp ne ptr addrspace(4) %1, null
  %or.cond = and i1 %tobool, %tobool1
  %tobool3 = icmp ne ptr addrspace(4) %2, null
  %or.cond81 = and i1 %or.cond, %tobool3
  br i1 %or.cond81, label %for.body.preheader, label %if.then

for.body.preheader:                               ; preds = %entry
  br label %for.body

if.then:                                          ; preds = %entry
  %puts = call i32 @puts(ptr nonnull dereferenceable(1) @str)
  br label %cleanup

for.body.i:                                       ; preds = %for.body.i.preheader, %for.body.i
  %i.04.i = phi i32 [ %inc.i, %for.body.i ], [ 0, %for.body.i.preheader ]
  %arrayidx.i.addrspace = getelementptr inbounds i32, ptr addrspace(4) %2, i32 %i.04.i
  store i32 0, ptr addrspace(4) %arrayidx.i.addrspace, align 4, !tbaa !3
  %inc.i = add nuw nsw i32 %i.04.i, 1
  %cmp.i = icmp ult i32 %inc.i, 1024
  br i1 %cmp.i, label %for.body.i, label %init_vector.exit, !llvm.loop !7

init_vector.exit:                                 ; preds = %for.body.i
  %call6 = call i32 @clock() #9
  br label %for.body.i146

for.body.i146:                                    ; preds = %for.body.i146, %init_vector.exit
  %i.08.i = phi i32 [ 0, %init_vector.exit ], [ %inc.i148, %for.body.i146 ]
  %arrayidx.i147.addrspace = getelementptr inbounds i32, ptr addrspace(4) %0, i32 %i.08.i
  %3 = load i32, ptr addrspace(4) %arrayidx.i147.addrspace, align 4, !tbaa !3
  %arrayidx1.i.addrspace = getelementptr inbounds i32, ptr addrspace(4) %1, i32 %i.08.i
  %4 = load i32, ptr addrspace(4) %arrayidx1.i.addrspace, align 4, !tbaa !3
  %add.i = add nsw i32 %4, %3
  %arrayidx2.i.addrspace = getelementptr inbounds i32, ptr addrspace(4) %2, i32 %i.08.i
  store i32 %add.i, ptr addrspace(4) %arrayidx2.i.addrspace, align 4, !tbaa !3
  %inc.i148 = add nuw nsw i32 %i.08.i, 1
  %cmp.i149 = icmp ult i32 %inc.i148, 1024
  br i1 %cmp.i149, label %for.body.i146, label %vec_sum.exit, !llvm.loop !10

vec_sum.exit:                                     ; preds = %for.body.i146
  %call7 = call i32 @clock() #9
  %sub = sub nsw i32 %call7, %call6
  %conv = sitofp i32 %sub to double
  %call8 = call i32 @_timer_clocks_per_sec() #9
  %conv9 = uitofp i32 %call8 to double
  %div = fdiv contract double %conv, %conv9
  %mul = fmul contract double %div, 1.000000e+03
  %call10 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, double noundef %mul)
  %puts141 = call i32 @puts(ptr nonnull dereferenceable(1) @str.14)
  br label %for.body17

for.body:                                         ; preds = %for.body.preheader, %for.body
  %i.0173 = phi i32 [ %add, %for.body ], [ 0, %for.body.preheader ]
  %add = add nuw nsw i32 %i.0173, 1
  %arrayidx = getelementptr inbounds i32, ptr addrspace(4) %0, i32 %i.0173
  store i32 %add, ptr addrspace(4) %arrayidx, align 4, !tbaa !3
  %arrayidx5 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 %i.0173
  store i32 %add, ptr addrspace(4) %arrayidx5, align 4, !tbaa !3
  %cmp = icmp ult i32 %add, 1024
  br i1 %cmp, label %for.body, label %for.body.i.preheader, !llvm.loop !17

for.body.i.preheader:                             ; preds = %for.body
  br label %for.body.i

for.cond.cleanup16:                               ; preds = %for.body17
  %putchar = call i32 @putchar(i32 10)
  %call26 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.6, i32 noundef 16)
  br label %for.body.i150

for.body.i150:                                    ; preds = %for.body.i150, %for.cond.cleanup16
  %i.04.i151 = phi i32 [ 0, %for.cond.cleanup16 ], [ %inc.i153, %for.body.i150 ]
  %arrayidx.i152.addrspace = getelementptr inbounds i32, ptr addrspace(4) %2, i32 %i.04.i151
  store i32 0, ptr addrspace(4) %arrayidx.i152.addrspace, align 4, !tbaa !3
  %inc.i153 = add nuw nsw i32 %i.04.i151, 1
  %cmp.i154 = icmp ult i32 %inc.i153, 1024
  br i1 %cmp.i154, label %for.body.i150, label %init_vector.exit155, !llvm.loop !7

init_vector.exit155:                              ; preds = %for.body.i150
  %call27 = call i32 @clock() #9
  br label %for.body.i156

for.body.i156:                                    ; preds = %for.body.i156, %init_vector.exit155
  %i.046.i = phi i32 [ 0, %init_vector.exit155 ], [ %inc.i159, %for.body.i156 ]
  %mul.i = shl nsw i32 %i.046.i, 4
  %arrayidx.i157 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 %mul.i
  %5 = call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %arrayidx.i157)
  %arrayidx2.i158 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 %mul.i
  %6 = call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %arrayidx2.i158)
  %7 = call <16 x i32> @llvm.arc.vvadd.w.v512(<16 x i32> %5, <16 x i32> %6)
  %arrayidx6.i = getelementptr inbounds i32, ptr addrspace(4) %2, i32 %mul.i
  call void @llvm.arc.vvst.w.v512(<16 x i32> %7, ptr addrspace(4) %arrayidx6.i)
  %8 = load i32, ptr addrspace(4) %arrayidx6.i, align 16, !tbaa !3, !alias.scope !18, !noalias !21
  %call9.i = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i32 noundef %8)
  %inc.i159 = add nuw nsw i32 %i.046.i, 1
  %cmp.i160 = icmp ult i32 %inc.i159, 64
  br i1 %cmp.i160, label %for.body.i156, label %vectorized_vec_sum.exit, !llvm.loop !15

vectorized_vec_sum.exit:                          ; preds = %for.body.i156
  %call28 = call i32 @clock() #9
  %sub29 = sub nsw i32 %call28, %call27
  %conv30 = sitofp i32 %sub29 to double
  %call31 = call i32 @_timer_clocks_per_sec() #9
  %conv32 = uitofp i32 %call31 to double
  %div33 = fdiv contract double %conv30, %conv32
  %mul34 = fmul contract double %div33, 1.000000e+03
  %call35 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.7, double noundef %mul34)
  %div36 = fdiv contract double %mul, %mul34
  %call37 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.8, double noundef %div36)
  %puts142 = call i32 @puts(ptr nonnull dereferenceable(1) @str.14)
  br label %for.body44

for.body17:                                       ; preds = %vec_sum.exit, %for.body17
  %i12.0174 = phi i32 [ 0, %vec_sum.exit ], [ %inc23, %for.body17 ]
  %arrayidx18 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 %i12.0174
  %9 = load i32, ptr addrspace(4) %arrayidx18, align 4, !tbaa !3
  %arrayidx19 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 %i12.0174
  %10 = load i32, ptr addrspace(4) %arrayidx19, align 4, !tbaa !3
  %arrayidx20 = getelementptr inbounds i32, ptr addrspace(4) %2, i32 %i12.0174
  %11 = load i32, ptr addrspace(4) %arrayidx20, align 4, !tbaa !3
  %call21 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.4, i32 noundef %i12.0174, i32 noundef %9, i32 noundef %i12.0174, i32 noundef %10, i32 noundef %i12.0174, i32 noundef %11)
  %inc23 = add nuw nsw i32 %i12.0174, 1
  %cmp14 = icmp ult i32 %inc23, 5
  br i1 %cmp14, label %for.body17, label %for.cond.cleanup16, !llvm.loop !24

for.cond.cleanup43:                               ; preds = %for.body44
  %putchar143 = call i32 @putchar(i32 10)
  %puts144 = call i32 @puts(ptr nonnull dereferenceable(1) @str.13)
  br label %for.body.i161

for.body.i161:                                    ; preds = %for.body.i161, %for.cond.cleanup43
  %i.04.i162 = phi i32 [ 0, %for.cond.cleanup43 ], [ %inc.i164, %for.body.i161 ]
  %arrayidx.i163.addrspace = getelementptr inbounds i32, ptr addrspace(4) %2, i32 %i.04.i162
  store i32 0, ptr addrspace(4) %arrayidx.i163.addrspace, align 4, !tbaa !3
  %inc.i164 = add nuw nsw i32 %i.04.i162, 1
  %cmp.i165 = icmp ult i32 %inc.i164, 1024
  br i1 %cmp.i165, label %for.body.i161, label %init_vector.exit166, !llvm.loop !7

init_vector.exit166:                              ; preds = %for.body.i161
  %12 = addrspacecast ptr addrspace(4) %2 to ptr
  %13 = addrspacecast ptr addrspace(4) %0 to ptr
  %14 = addrspacecast ptr addrspace(4) %1 to ptr
  %call54 = call i32 @clock() #9
  call void @vekt_vec_sum(ptr noundef %13, ptr noundef %13, i32 noundef 0, i32 noundef 1024, i32 noundef 1, ptr noundef %14, ptr noundef %14, i32 noundef 0, i32 noundef 1024, i32 noundef 1, ptr noundef %12, ptr noundef %12, i32 noundef 0, i32 noundef 1024, i32 noundef 1, i32 noundef 1024) #9
  %call55 = call i32 @clock() #9
  %sub56 = sub nsw i32 %call55, %call54
  %conv57 = sitofp i32 %sub56 to double
  %call58 = call i32 @_timer_clocks_per_sec() #9
  %conv59 = uitofp i32 %call58 to double
  %div60 = fdiv contract double %conv57, %conv59
  %mul61 = fmul contract double %div60, 1.000000e+03
  %call62 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.10, double noundef %mul61)
  %div63 = fdiv contract double %mul, %mul61
  %call64 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.8, double noundef %div63)
  %puts145 = call i32 @puts(ptr nonnull dereferenceable(1) @str.14)
  br label %for.body71

for.body44:                                       ; preds = %vectorized_vec_sum.exit, %for.body44
  %i39.0175 = phi i32 [ 0, %vectorized_vec_sum.exit ], [ %inc50, %for.body44 ]
  %arrayidx45 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 %i39.0175
  %15 = load i32, ptr addrspace(4) %arrayidx45, align 4, !tbaa !3
  %arrayidx46 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 %i39.0175
  %16 = load i32, ptr addrspace(4) %arrayidx46, align 4, !tbaa !3
  %arrayidx47 = getelementptr inbounds i32, ptr addrspace(4) %2, i32 %i39.0175
  %17 = load i32, ptr addrspace(4) %arrayidx47, align 4, !tbaa !3
  %call48 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.4, i32 noundef %i39.0175, i32 noundef %15, i32 noundef %i39.0175, i32 noundef %16, i32 noundef %i39.0175, i32 noundef %17)
  %inc50 = add nuw nsw i32 %i39.0175, 1
  %cmp41 = icmp ult i32 %inc50, 5
  br i1 %cmp41, label %for.body44, label %for.cond.cleanup43, !llvm.loop !25

for.body71:                                       ; preds = %init_vector.exit166, %for.body71
  %i66.0176 = phi i32 [ 0, %init_vector.exit166 ], [ %inc77, %for.body71 ]
  %arrayidx72 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 %i66.0176
  %18 = load i32, ptr addrspace(4) %arrayidx72, align 4, !tbaa !3
  %arrayidx73 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 %i66.0176
  %19 = load i32, ptr addrspace(4) %arrayidx73, align 4, !tbaa !3
  %arrayidx74 = getelementptr inbounds i32, ptr addrspace(4) %2, i32 %i66.0176
  %20 = load i32, ptr addrspace(4) %arrayidx74, align 4, !tbaa !3
  %call75 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.4, i32 noundef %i66.0176, i32 noundef %18, i32 noundef %i66.0176, i32 noundef %19, i32 noundef %i66.0176, i32 noundef %20)
  %inc77 = add nuw nsw i32 %i66.0176, 1
  %cmp68 = icmp ult i32 %inc77, 5
  br i1 %cmp68, label %for.body71, label %cleanup, !llvm.loop !26

cleanup:                                          ; preds = %for.body71, %if.then
  %retval.0 = phi i32 [ 1, %if.then ], [ 0, %for.body71 ]
  ret i32 %retval.0
}

declare i32 @clock() local_unnamed_addr #2

declare i32 @_timer_clocks_per_sec() local_unnamed_addr #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(read)
declare <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4)) #5

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <16 x i32> @llvm.arc.vvadd.w.v512(<16 x i32>, <16 x i32>) #6

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(write)
declare void @llvm.arc.vvst.w.v512(<16 x i32>, ptr addrspace(4)) #7

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #8

; Function Attrs: nofree nounwind
declare noundef i32 @putchar(i32 noundef) local_unnamed_addr #8

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: write) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" }
attributes #1 = { nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" }
attributes #2 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" }
attributes #3 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" }
attributes #4 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" }
attributes #5 = { mustprogress nocallback nofree nosync nounwind willreturn memory(read) }
attributes #6 = { mustprogress nocallback nofree nosync nounwind willreturn memory(none) }
attributes #7 = { mustprogress nocallback nofree nosync nounwind willreturn memory(write) }
attributes #8 = { nofree nounwind }
attributes #9 = { nounwind }

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
!10 = distinct !{!10, !8, !9, !9, !11, !12}
!11 = !{!"llvm.loop.vectorize.width", i32 1}
!12 = !{!"llvm.loop.vectorize.followup_all", !13}
!13 = distinct !{!13, !8, !9, !9, !14}
!14 = !{!"llvm.loop.isvectorized"}
!15 = distinct !{!15, !8, !9, !9}
!16 = distinct !{!16, !8, !9, !9}
!17 = distinct !{!17, !8, !9, !9}
!18 = !{!19}
!19 = distinct !{!19, !20, !"vectorized_vec_sum: %c"}
!20 = distinct !{!20, !"vectorized_vec_sum"}
!21 = !{!22, !23}
!22 = distinct !{!22, !20, !"vectorized_vec_sum: %a"}
!23 = distinct !{!23, !20, !"vectorized_vec_sum: %b"}
!24 = distinct !{!24, !8, !9, !9}
!25 = distinct !{!25, !8, !9, !9}
!26 = distinct !{!26, !8, !9, !9}
