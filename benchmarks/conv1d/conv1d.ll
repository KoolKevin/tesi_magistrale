; ModuleID = 'conv1d.c'
source_filename = "conv1d.c"
target datalayout = "e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-f64:32-v64:32-v128:32-a:0:32-v256:32-v512:32-n8:16:32"
target triple = "arc-pc-unknown-gnu"

@.str = private unnamed_addr constant [54 x i8] c"ERRORE! All'indice %d: result = %d, groundtruth = %d\0A\00", align 1
@.str.3 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.4 = private unnamed_addr constant [4 x i8] c"%d,\00", align 1
@str = private unnamed_addr constant [25 x i8] c"SUCCESSO! Vettori uguali\00", align 1
@str.6 = private unnamed_addr constant [2 x i8] c"]\00", align 1

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: write)
define dso_local void @init_vector(ptr nocapture noundef writeonly %a, i32 noundef %dim, i32 noundef %value) local_unnamed_addr #0 {
entry:
  %cmp3 = icmp sgt i32 %dim, 0
  br i1 %cmp3, label %iter.check, label %for.cond.cleanup

iter.check:                                       ; preds = %entry
  %min.iters.check = icmp ult i32 %dim, 8
  br i1 %min.iters.check, label %for.body.preheader, label %vector.main.loop.iter.check

vector.main.loop.iter.check:                      ; preds = %iter.check
  %min.iters.check5 = icmp ult i32 %dim, 64
  br i1 %min.iters.check5, label %vec.epilog.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.main.loop.iter.check
  %n.vec = and i32 %dim, -64
  %broadcast.splatinsert = insertelement <16 x i32> poison, i32 %value, i64 0
  %broadcast.splat = shufflevector <16 x i32> %broadcast.splatinsert, <16 x i32> poison, <16 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %0 = getelementptr inbounds i32, ptr %a, i32 %index
  store <16 x i32> %broadcast.splat, ptr %0, align 4, !tbaa !3
  %1 = getelementptr inbounds i32, ptr %0, i32 16
  store <16 x i32> %broadcast.splat, ptr %1, align 4, !tbaa !3
  %2 = getelementptr inbounds i32, ptr %0, i32 32
  store <16 x i32> %broadcast.splat, ptr %2, align 4, !tbaa !3
  %3 = getelementptr inbounds i32, ptr %0, i32 48
  store <16 x i32> %broadcast.splat, ptr %3, align 4, !tbaa !3
  %index.next = add nuw i32 %index, 64
  %4 = icmp eq i32 %index.next, %n.vec
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !7

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i32 %n.vec, %dim
  br i1 %cmp.n, label %for.cond.cleanup, label %vec.epilog.iter.check

vec.epilog.iter.check:                            ; preds = %middle.block
  %n.vec.remaining = and i32 %dim, 56
  %min.epilog.iters.check = icmp eq i32 %n.vec.remaining, 0
  br i1 %min.epilog.iters.check, label %for.body.preheader, label %vec.epilog.ph

vec.epilog.ph:                                    ; preds = %vector.main.loop.iter.check, %vec.epilog.iter.check
  %vec.epilog.resume.val = phi i32 [ %n.vec, %vec.epilog.iter.check ], [ 0, %vector.main.loop.iter.check ]
  %n.vec13 = and i32 %dim, -8
  %broadcast.splatinsert16 = insertelement <8 x i32> poison, i32 %value, i64 0
  %broadcast.splat17 = shufflevector <8 x i32> %broadcast.splatinsert16, <8 x i32> poison, <8 x i32> zeroinitializer
  br label %vec.epilog.vector.body

vec.epilog.vector.body:                           ; preds = %vec.epilog.vector.body, %vec.epilog.ph
  %index15 = phi i32 [ %vec.epilog.resume.val, %vec.epilog.ph ], [ %index.next18, %vec.epilog.vector.body ]
  %5 = getelementptr inbounds i32, ptr %a, i32 %index15
  store <8 x i32> %broadcast.splat17, ptr %5, align 4, !tbaa !3
  %index.next18 = add nuw i32 %index15, 8
  %6 = icmp eq i32 %index.next18, %n.vec13
  br i1 %6, label %vec.epilog.middle.block, label %vec.epilog.vector.body, !llvm.loop !11

vec.epilog.middle.block:                          ; preds = %vec.epilog.vector.body
  %cmp.n14 = icmp eq i32 %n.vec13, %dim
  br i1 %cmp.n14, label %for.cond.cleanup, label %for.body.preheader

for.body.preheader:                               ; preds = %iter.check, %vec.epilog.iter.check, %vec.epilog.middle.block
  %i.04.ph = phi i32 [ 0, %iter.check ], [ %n.vec, %vec.epilog.iter.check ], [ %n.vec13, %vec.epilog.middle.block ]
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body, %middle.block, %vec.epilog.middle.block, %entry
  ret void

for.body:                                         ; preds = %for.body.preheader, %for.body
  %i.04 = phi i32 [ %inc, %for.body ], [ %i.04.ph, %for.body.preheader ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i32 %i.04
  store i32 %value, ptr %arrayidx, align 4, !tbaa !3
  %inc = add nuw nsw i32 %i.04, 1
  %cmp = icmp slt i32 %inc, %dim
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !12
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @copy_vector(ptr nocapture noundef readonly %src, ptr nocapture noundef writeonly %dst, i32 noundef %N) local_unnamed_addr #1 {
entry:
  %cmp5 = icmp sgt i32 %N, 0
  br i1 %cmp5, label %iter.check, label %for.cond.cleanup

iter.check:                                       ; preds = %entry
  %min.iters.check = icmp ult i32 %N, 8
  br i1 %min.iters.check, label %for.body.preheader, label %vector.memcheck

vector.memcheck:                                  ; preds = %iter.check
  %0 = shl i32 %N, 2
  %scevgep = getelementptr i8, ptr %dst, i32 %0
  %scevgep7 = getelementptr i8, ptr %src, i32 %0
  %bound0 = icmp ugt ptr %scevgep7, %dst
  %bound1 = icmp ugt ptr %scevgep, %src
  %found.conflict = and i1 %bound0, %bound1
  br i1 %found.conflict, label %for.body.preheader, label %vector.main.loop.iter.check

vector.main.loop.iter.check:                      ; preds = %vector.memcheck
  %min.iters.check8 = icmp ult i32 %N, 64
  br i1 %min.iters.check8, label %vec.epilog.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.main.loop.iter.check
  %n.vec = and i32 %N, -64
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %1 = getelementptr inbounds i32, ptr %src, i32 %index
  %wide.load = load <16 x i32>, ptr %1, align 4, !tbaa !3, !alias.scope !13
  %2 = getelementptr inbounds i32, ptr %1, i32 16
  %wide.load9 = load <16 x i32>, ptr %2, align 4, !tbaa !3, !alias.scope !13
  %3 = getelementptr inbounds i32, ptr %1, i32 32
  %wide.load10 = load <16 x i32>, ptr %3, align 4, !tbaa !3, !alias.scope !13
  %4 = getelementptr inbounds i32, ptr %1, i32 48
  %wide.load11 = load <16 x i32>, ptr %4, align 4, !tbaa !3, !alias.scope !13
  %5 = getelementptr inbounds i32, ptr %dst, i32 %index
  store <16 x i32> %wide.load, ptr %5, align 4, !tbaa !3, !alias.scope !16, !noalias !13
  %6 = getelementptr inbounds i32, ptr %5, i32 16
  store <16 x i32> %wide.load9, ptr %6, align 4, !tbaa !3, !alias.scope !16, !noalias !13
  %7 = getelementptr inbounds i32, ptr %5, i32 32
  store <16 x i32> %wide.load10, ptr %7, align 4, !tbaa !3, !alias.scope !16, !noalias !13
  %8 = getelementptr inbounds i32, ptr %5, i32 48
  store <16 x i32> %wide.load11, ptr %8, align 4, !tbaa !3, !alias.scope !16, !noalias !13
  %index.next = add nuw i32 %index, 64
  %9 = icmp eq i32 %index.next, %n.vec
  br i1 %9, label %middle.block, label %vector.body, !llvm.loop !18

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i32 %n.vec, %N
  br i1 %cmp.n, label %for.cond.cleanup, label %vec.epilog.iter.check

vec.epilog.iter.check:                            ; preds = %middle.block
  %n.vec.remaining = and i32 %N, 56
  %min.epilog.iters.check = icmp eq i32 %n.vec.remaining, 0
  br i1 %min.epilog.iters.check, label %for.body.preheader, label %vec.epilog.ph

vec.epilog.ph:                                    ; preds = %vector.main.loop.iter.check, %vec.epilog.iter.check
  %vec.epilog.resume.val = phi i32 [ %n.vec, %vec.epilog.iter.check ], [ 0, %vector.main.loop.iter.check ]
  %n.vec13 = and i32 %N, -8
  br label %vec.epilog.vector.body

vec.epilog.vector.body:                           ; preds = %vec.epilog.vector.body, %vec.epilog.ph
  %index15 = phi i32 [ %vec.epilog.resume.val, %vec.epilog.ph ], [ %index.next17, %vec.epilog.vector.body ]
  %10 = getelementptr inbounds i32, ptr %src, i32 %index15
  %wide.load16 = load <8 x i32>, ptr %10, align 4, !tbaa !3, !alias.scope !19
  %11 = getelementptr inbounds i32, ptr %dst, i32 %index15
  store <8 x i32> %wide.load16, ptr %11, align 4, !tbaa !3, !alias.scope !22, !noalias !19
  %index.next17 = add nuw i32 %index15, 8
  %12 = icmp eq i32 %index.next17, %n.vec13
  br i1 %12, label %vec.epilog.middle.block, label %vec.epilog.vector.body, !llvm.loop !24

vec.epilog.middle.block:                          ; preds = %vec.epilog.vector.body
  %cmp.n14 = icmp eq i32 %n.vec13, %N
  br i1 %cmp.n14, label %for.cond.cleanup, label %for.body.preheader

for.body.preheader:                               ; preds = %vector.memcheck, %iter.check, %vec.epilog.iter.check, %vec.epilog.middle.block
  %i.06.ph = phi i32 [ 0, %iter.check ], [ 0, %vector.memcheck ], [ %n.vec, %vec.epilog.iter.check ], [ %n.vec13, %vec.epilog.middle.block ]
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body, %middle.block, %vec.epilog.middle.block, %entry
  ret void

for.body:                                         ; preds = %for.body.preheader, %for.body
  %i.06 = phi i32 [ %inc, %for.body ], [ %i.06.ph, %for.body.preheader ]
  %arrayidx = getelementptr inbounds i32, ptr %src, i32 %i.06
  %13 = load i32, ptr %arrayidx, align 4, !tbaa !3
  %arrayidx1 = getelementptr inbounds i32, ptr %dst, i32 %i.06
  store i32 %13, ptr %arrayidx1, align 4, !tbaa !3
  %inc = add nuw nsw i32 %i.06, 1
  %cmp = icmp slt i32 %inc, %N
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !25
}

; Function Attrs: nofree nounwind
define dso_local void @check_result(ptr nocapture noundef readonly %result, ptr nocapture noundef readonly %groundtruth, i32 noundef %N) local_unnamed_addr #2 {
entry:
  %cmp19 = icmp sgt i32 %N, 0
  br i1 %cmp19, label %for.body.preheader, label %for.end

for.body.preheader:                               ; preds = %entry
  br label %for.body

for.body:                                         ; preds = %for.body.preheader, %for.inc
  %i.020 = phi i32 [ %inc, %for.inc ], [ 0, %for.body.preheader ]
  %arrayidx = getelementptr inbounds i32, ptr %result, i32 %i.020
  %0 = load i32, ptr %arrayidx, align 4, !tbaa !3
  %arrayidx1 = getelementptr inbounds i32, ptr %groundtruth, i32 %i.020
  %1 = load i32, ptr %arrayidx1, align 4, !tbaa !3
  %cmp2.not = icmp eq i32 %0, %1
  br i1 %cmp2.not, label %for.inc, label %cleanup

for.inc:                                          ; preds = %for.body
  %inc = add nuw nsw i32 %i.020, 1
  %cmp = icmp slt i32 %inc, %N
  br i1 %cmp, label %for.body, label %for.end, !llvm.loop !26

cleanup:                                          ; preds = %for.body
  %call = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i32 noundef %i.020, i32 noundef %0, i32 noundef %1)
  br label %return

for.end:                                          ; preds = %for.inc, %entry
  %puts = tail call i32 @puts(ptr nonnull dereferenceable(1) @str)
  br label %return

return:                                           ; preds = %cleanup, %for.end
  ret void
}

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #2

; Function Attrs: nofree nounwind
define dso_local void @print_vector(ptr nocapture noundef readonly %A, i32 noundef %N) local_unnamed_addr #2 {
entry:
  %putchar = tail call i32 @putchar(i32 91)
  %cmp10 = icmp sgt i32 %N, 0
  br i1 %cmp10, label %for.body.lr.ph, label %for.cond.cleanup

for.body.lr.ph:                                   ; preds = %entry
  %sub = add nsw i32 %N, -1
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.inc, %entry
  %puts = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.6)
  ret void

for.body:                                         ; preds = %for.body.lr.ph, %for.inc
  %i.011 = phi i32 [ 0, %for.body.lr.ph ], [ %inc, %for.inc ]
  %cmp1 = icmp eq i32 %i.011, %sub
  %arrayidx = getelementptr inbounds i32, ptr %A, i32 %i.011
  %0 = load i32, ptr %arrayidx, align 4, !tbaa !3
  br i1 %cmp1, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %call2 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, i32 noundef %0)
  br label %for.inc

if.else:                                          ; preds = %for.body
  %call4 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.4, i32 noundef %0)
  br label %for.inc

for.inc:                                          ; preds = %if.then, %if.else
  %inc = add nuw nsw i32 %i.011, 1
  %cmp = icmp slt i32 %inc, %N
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !27
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @conv1d(i32 noundef %N_out, i32 noundef %N_in, i32 noundef %W, ptr nocapture noundef %output, ptr nocapture noundef readonly %input, ptr nocapture noundef readonly %window) local_unnamed_addr #1 {
entry:
  %cmp22 = icmp sgt i32 %N_out, 0
  %cmp219 = icmp sgt i32 %W, 0
  %or.cond = and i1 %cmp22, %cmp219
  br i1 %or.cond, label %for.body4.lr.ph.us.preheader, label %for.cond.cleanup

for.body4.lr.ph.us.preheader:                     ; preds = %entry
  br label %for.body4.lr.ph.us

for.cond.cleanup3.us:                             ; preds = %for.body4.us
  %inc9.us = add nuw nsw i32 %i.023.us, 1
  %cmp.us = icmp slt i32 %inc9.us, %N_out
  br i1 %cmp.us, label %for.body4.lr.ph.us, label %for.cond.cleanup, !llvm.loop !28

for.body4.us:                                     ; preds = %for.body4.lr.ph.us, %for.body4.us
  %add721.us = phi i32 [ %arrayidx6.promoted.us, %for.body4.lr.ph.us ], [ %add7.us, %for.body4.us ]
  %w_i.020.us = phi i32 [ 0, %for.body4.lr.ph.us ], [ %inc.us, %for.body4.us ]
  %add.us = add nuw nsw i32 %w_i.020.us, %i.023.us
  %arrayidx.us = getelementptr inbounds i32, ptr %input, i32 %add.us
  %0 = load i32, ptr %arrayidx.us, align 4, !tbaa !3
  %arrayidx5.us = getelementptr inbounds i32, ptr %window, i32 %w_i.020.us
  %1 = load i32, ptr %arrayidx5.us, align 4, !tbaa !3
  %mul.us = mul nsw i32 %1, %0
  %add7.us = add nsw i32 %mul.us, %add721.us
  store i32 %add7.us, ptr %arrayidx6.us, align 4, !tbaa !3
  %inc.us = add nuw nsw i32 %w_i.020.us, 1
  %cmp2.us = icmp slt i32 %inc.us, %W
  br i1 %cmp2.us, label %for.body4.us, label %for.cond.cleanup3.us, !llvm.loop !33

for.body4.lr.ph.us:                               ; preds = %for.body4.lr.ph.us.preheader, %for.cond.cleanup3.us
  %i.023.us = phi i32 [ %inc9.us, %for.cond.cleanup3.us ], [ 0, %for.body4.lr.ph.us.preheader ]
  %arrayidx6.us = getelementptr inbounds i32, ptr %output, i32 %i.023.us
  %arrayidx6.promoted.us = load i32, ptr %arrayidx6.us, align 4, !tbaa !3
  br label %for.body4.us

for.cond.cleanup:                                 ; preds = %for.cond.cleanup3.us, %entry
  ret void
}

; Function Attrs: mustprogress nofree nosync nounwind willreturn
define dso_local void @vectorized_conv1d(i32 noundef %N_out, i32 noundef %N_in, i32 noundef %W, ptr addrspace(4) noalias noundef %output, ptr addrspace(4) noalias noundef %input, ptr addrspace(4) noalias nocapture noundef readonly %window) local_unnamed_addr #3 {
entry:
  %div = sdiv i32 %N_out, 16
  %mul = shl nsw i32 %div, 4
  %cmp66 = icmp sgt i32 %N_out, 15
  br i1 %cmp66, label %for.body.lr.ph, label %for.cond.cleanup

for.body.lr.ph:                                   ; preds = %entry
  %cmp363 = icmp sgt i32 %W, 0
  br i1 %cmp363, label %for.body5.lr.ph.us.preheader, label %for.cond.cleanup4.preheader

for.cond.cleanup4.preheader:                      ; preds = %for.body.lr.ph
  br label %for.cond.cleanup4

for.body5.lr.ph.us.preheader:                     ; preds = %for.body.lr.ph
  br label %for.body5.lr.ph.us

for.cond.cleanup4.us:                             ; preds = %for.body5.us
  %0 = tail call <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32> %3)
  tail call void @llvm.arc.vvst.w.v512(<16 x i32> %0, ptr addrspace(4) %arrayidx.us)
  %add16.us = add nuw nsw i32 %i.067.us, 16
  %cmp.us = icmp slt i32 %add16.us, %mul
  br i1 %cmp.us, label %for.body5.lr.ph.us, label %for.cond.cleanup, !llvm.loop !36

for.body5.us:                                     ; preds = %for.body5.lr.ph.us, %for.body5.us
  %acc.sroa.0.065.us = phi <16 x i32> [ %5, %for.body5.lr.ph.us ], [ %3, %for.body5.us ]
  %w_i.064.us = phi i32 [ 0, %for.body5.lr.ph.us ], [ %inc.us, %for.body5.us ]
  %arrayidx6.us = getelementptr inbounds i32, ptr addrspace(4) %window, i32 %w_i.064.us
  %1 = load i32, ptr addrspace(4) %arrayidx6.us, align 4, !tbaa !3
  %add.us = add nuw nsw i32 %w_i.064.us, %i.067.us
  %arrayidx7.us = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %add.us
  %2 = tail call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %arrayidx7.us)
  %splat.splatinsert.us = insertelement <16 x i32> poison, i32 %1, i64 0
  %splat.splat.us = shufflevector <16 x i32> %splat.splatinsert.us, <16 x i32> poison, <16 x i32> zeroinitializer
  %3 = tail call <16 x i32> @llvm.arc.vvcmac.lo.acc.w.v512(<16 x i32> %acc.sroa.0.065.us, <16 x i32> %2, <16 x i32> %splat.splat.us)
  %inc.us = add nuw nsw i32 %w_i.064.us, 1
  %cmp3.us = icmp slt i32 %inc.us, %W
  br i1 %cmp3.us, label %for.body5.us, label %for.cond.cleanup4.us, !llvm.loop !37

for.body5.lr.ph.us:                               ; preds = %for.body5.lr.ph.us.preheader, %for.cond.cleanup4.us
  %i.067.us = phi i32 [ %add16.us, %for.cond.cleanup4.us ], [ 0, %for.body5.lr.ph.us.preheader ]
  %arrayidx.us = getelementptr inbounds i32, ptr addrspace(4) %output, i32 %i.067.us
  %4 = tail call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %arrayidx.us)
  %5 = tail call <16 x i32> @llvm.arc.vvcadd.init.acc.w.v512(<16 x i32> %4, <16 x i32> zeroinitializer)
  br label %for.body5.us

for.cond.cleanup:                                 ; preds = %for.cond.cleanup4, %for.cond.cleanup4.us, %entry
  %cmp2071 = icmp slt i32 %mul, %N_out
  %cmp2568 = icmp sgt i32 %W, 0
  %or.cond = and i1 %cmp2071, %cmp2568
  br i1 %or.cond, label %for.body22.lr.ph.split.us, label %for.cond.cleanup21

for.body22.lr.ph.split.us:                        ; preds = %for.cond.cleanup
  %min.iters.check = icmp ult i32 %W, 8
  %min.iters.check79 = icmp ult i32 %W, 64
  %n.vec = and i32 %W, -64
  %cmp.n = icmp eq i32 %n.vec, %W
  %n.vec.remaining = and i32 %W, 56
  %min.epilog.iters.check = icmp eq i32 %n.vec.remaining, 0
  %n.vec93 = and i32 %W, -8
  %cmp.n94 = icmp eq i32 %n.vec93, %W
  br i1 %min.iters.check, label %iter.check.us.preheader, label %iter.check.preheader

iter.check.preheader:                             ; preds = %for.body22.lr.ph.split.us
  br label %iter.check

iter.check.us.preheader:                          ; preds = %for.body22.lr.ph.split.us
  br label %iter.check.us

iter.check.us:                                    ; preds = %iter.check.us.preheader, %for.cond.cleanup26.us.loopexit.us
  %i18.072.us.us = phi i32 [ %inc38.us.us, %for.cond.cleanup26.us.loopexit.us ], [ %mul, %iter.check.us.preheader ]
  %arrayidx32.us.us = getelementptr inbounds i32, ptr addrspace(4) %output, i32 %i18.072.us.us
  %arrayidx32.promoted.us.us = load i32, ptr addrspace(4) %arrayidx32.us.us, align 4, !tbaa !3
  br label %for.body27.us.us

for.body27.us.us:                                 ; preds = %iter.check.us, %for.body27.us.us
  %add3370.us.us = phi i32 [ %arrayidx32.promoted.us.us, %iter.check.us ], [ %add33.us.us, %for.body27.us.us ]
  %w_i23.069.us.us = phi i32 [ 0, %iter.check.us ], [ %inc35.us.us, %for.body27.us.us ]
  %add28.us.us = add nsw i32 %w_i23.069.us.us, %i18.072.us.us
  %arrayidx29.us.us = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %add28.us.us
  %6 = load i32, ptr addrspace(4) %arrayidx29.us.us, align 4, !tbaa !3
  %arrayidx30.us.us = getelementptr inbounds i32, ptr addrspace(4) %window, i32 %w_i23.069.us.us
  %7 = load i32, ptr addrspace(4) %arrayidx30.us.us, align 4, !tbaa !3
  %mul31.us.us = mul nsw i32 %7, %6
  %add33.us.us = add nsw i32 %mul31.us.us, %add3370.us.us
  %inc35.us.us = add nuw nsw i32 %w_i23.069.us.us, 1
  %cmp25.us.us = icmp slt i32 %inc35.us.us, %W
  br i1 %cmp25.us.us, label %for.body27.us.us, label %for.cond.cleanup26.us.loopexit.us, !llvm.loop !38

for.cond.cleanup26.us.loopexit.us:                ; preds = %for.body27.us.us
  store i32 %add33.us.us, ptr addrspace(4) %arrayidx32.us.us, align 4, !tbaa !3
  %inc38.us.us = add nsw i32 %i18.072.us.us, 1
  %cmp20.us.us = icmp slt i32 %inc38.us.us, %N_out
  br i1 %cmp20.us.us, label %iter.check.us, label %for.cond.cleanup21, !llvm.loop !39

for.cond.cleanup26.us:                            ; preds = %for.body27.us, %vec.epilog.middle.block, %middle.block
  %add33.us.lcssa = phi i32 [ %29, %middle.block ], [ %37, %vec.epilog.middle.block ], [ %add33.us, %for.body27.us ]
  store i32 %add33.us.lcssa, ptr addrspace(4) %arrayidx32.us, align 4, !tbaa !3
  %inc38.us = add nsw i32 %i18.072.us, 1
  %cmp20.us = icmp slt i32 %inc38.us, %N_out
  br i1 %cmp20.us, label %iter.check, label %for.cond.cleanup21, !llvm.loop !39

for.body27.us:                                    ; preds = %for.body27.us.preheader, %for.body27.us
  %add3370.us = phi i32 [ %add33.us, %for.body27.us ], [ %add3370.us.ph, %for.body27.us.preheader ]
  %w_i23.069.us = phi i32 [ %inc35.us, %for.body27.us ], [ %w_i23.069.us.ph, %for.body27.us.preheader ]
  %add28.us = add nsw i32 %w_i23.069.us, %i18.072.us
  %arrayidx29.us = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %add28.us
  %8 = load i32, ptr addrspace(4) %arrayidx29.us, align 4, !tbaa !3
  %arrayidx30.us = getelementptr inbounds i32, ptr addrspace(4) %window, i32 %w_i23.069.us
  %9 = load i32, ptr addrspace(4) %arrayidx30.us, align 4, !tbaa !3
  %mul31.us = mul nsw i32 %9, %8
  %add33.us = add nsw i32 %mul31.us, %add3370.us
  %inc35.us = add nuw nsw i32 %w_i23.069.us, 1
  %cmp25.us = icmp slt i32 %inc35.us, %W
  br i1 %cmp25.us, label %for.body27.us, label %for.cond.cleanup26.us, !llvm.loop !38

iter.check:                                       ; preds = %iter.check.preheader, %for.cond.cleanup26.us
  %i18.072.us = phi i32 [ %inc38.us, %for.cond.cleanup26.us ], [ %mul, %iter.check.preheader ]
  %arrayidx32.us = getelementptr inbounds i32, ptr addrspace(4) %output, i32 %i18.072.us
  %arrayidx32.promoted.us = load i32, ptr addrspace(4) %arrayidx32.us, align 4, !tbaa !3
  br i1 %min.iters.check79, label %vec.epilog.ph, label %vector.ph

vector.ph:                                        ; preds = %iter.check
  %10 = insertelement <16 x i32> <i32 poison, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, i32 %arrayidx32.promoted.us, i64 0
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi <16 x i32> [ %10, %vector.ph ], [ %24, %vector.body ]
  %vec.phi80 = phi <16 x i32> [ zeroinitializer, %vector.ph ], [ %25, %vector.body ]
  %vec.phi81 = phi <16 x i32> [ zeroinitializer, %vector.ph ], [ %26, %vector.body ]
  %vec.phi82 = phi <16 x i32> [ zeroinitializer, %vector.ph ], [ %27, %vector.body ]
  %11 = add nsw i32 %index, %i18.072.us
  %12 = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %11
  %wide.load = load <16 x i32>, ptr addrspace(4) %12, align 4, !tbaa !3
  %13 = getelementptr inbounds i32, ptr addrspace(4) %12, i32 16
  %wide.load83 = load <16 x i32>, ptr addrspace(4) %13, align 4, !tbaa !3
  %14 = getelementptr inbounds i32, ptr addrspace(4) %12, i32 32
  %wide.load84 = load <16 x i32>, ptr addrspace(4) %14, align 4, !tbaa !3
  %15 = getelementptr inbounds i32, ptr addrspace(4) %12, i32 48
  %wide.load85 = load <16 x i32>, ptr addrspace(4) %15, align 4, !tbaa !3
  %16 = getelementptr inbounds i32, ptr addrspace(4) %window, i32 %index
  %wide.load86 = load <16 x i32>, ptr addrspace(4) %16, align 4, !tbaa !3
  %17 = getelementptr inbounds i32, ptr addrspace(4) %16, i32 16
  %wide.load87 = load <16 x i32>, ptr addrspace(4) %17, align 4, !tbaa !3
  %18 = getelementptr inbounds i32, ptr addrspace(4) %16, i32 32
  %wide.load88 = load <16 x i32>, ptr addrspace(4) %18, align 4, !tbaa !3
  %19 = getelementptr inbounds i32, ptr addrspace(4) %16, i32 48
  %wide.load89 = load <16 x i32>, ptr addrspace(4) %19, align 4, !tbaa !3
  %20 = mul nsw <16 x i32> %wide.load86, %wide.load
  %21 = mul nsw <16 x i32> %wide.load87, %wide.load83
  %22 = mul nsw <16 x i32> %wide.load88, %wide.load84
  %23 = mul nsw <16 x i32> %wide.load89, %wide.load85
  %24 = add <16 x i32> %20, %vec.phi
  %25 = add <16 x i32> %21, %vec.phi80
  %26 = add <16 x i32> %22, %vec.phi81
  %27 = add <16 x i32> %23, %vec.phi82
  %index.next = add nuw i32 %index, 64
  %28 = icmp eq i32 %index.next, %n.vec
  br i1 %28, label %middle.block, label %vector.body, !llvm.loop !40

middle.block:                                     ; preds = %vector.body
  %bin.rdx = add <16 x i32> %25, %24
  %bin.rdx90 = add <16 x i32> %26, %bin.rdx
  %bin.rdx91 = add <16 x i32> %27, %bin.rdx90
  %29 = tail call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %bin.rdx91)
  br i1 %cmp.n, label %for.cond.cleanup26.us, label %vec.epilog.iter.check

vec.epilog.iter.check:                            ; preds = %middle.block
  br i1 %min.epilog.iters.check, label %for.body27.us.preheader, label %vec.epilog.ph

vec.epilog.ph:                                    ; preds = %iter.check, %vec.epilog.iter.check
  %bc.merge.rdx = phi i32 [ %arrayidx32.promoted.us, %iter.check ], [ %29, %vec.epilog.iter.check ]
  %vec.epilog.resume.val = phi i32 [ 0, %iter.check ], [ %n.vec, %vec.epilog.iter.check ]
  %30 = insertelement <8 x i32> <i32 poison, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, i32 %bc.merge.rdx, i64 0
  br label %vec.epilog.vector.body

vec.epilog.vector.body:                           ; preds = %vec.epilog.vector.body, %vec.epilog.ph
  %index95 = phi i32 [ %vec.epilog.resume.val, %vec.epilog.ph ], [ %index.next99, %vec.epilog.vector.body ]
  %vec.phi96 = phi <8 x i32> [ %30, %vec.epilog.ph ], [ %35, %vec.epilog.vector.body ]
  %31 = add nsw i32 %index95, %i18.072.us
  %32 = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %31
  %wide.load97 = load <8 x i32>, ptr addrspace(4) %32, align 4, !tbaa !3
  %33 = getelementptr inbounds i32, ptr addrspace(4) %window, i32 %index95
  %wide.load98 = load <8 x i32>, ptr addrspace(4) %33, align 4, !tbaa !3
  %34 = mul nsw <8 x i32> %wide.load98, %wide.load97
  %35 = add <8 x i32> %34, %vec.phi96
  %index.next99 = add nuw i32 %index95, 8
  %36 = icmp eq i32 %index.next99, %n.vec93
  br i1 %36, label %vec.epilog.middle.block, label %vec.epilog.vector.body, !llvm.loop !41

vec.epilog.middle.block:                          ; preds = %vec.epilog.vector.body
  %37 = tail call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %35)
  br i1 %cmp.n94, label %for.cond.cleanup26.us, label %for.body27.us.preheader

for.body27.us.preheader:                          ; preds = %vec.epilog.iter.check, %vec.epilog.middle.block
  %add3370.us.ph = phi i32 [ %29, %vec.epilog.iter.check ], [ %37, %vec.epilog.middle.block ]
  %w_i23.069.us.ph = phi i32 [ %n.vec, %vec.epilog.iter.check ], [ %n.vec93, %vec.epilog.middle.block ]
  br label %for.body27.us

for.cond.cleanup4:                                ; preds = %for.cond.cleanup4.preheader, %for.cond.cleanup4
  %i.067 = phi i32 [ %add16, %for.cond.cleanup4 ], [ 0, %for.cond.cleanup4.preheader ]
  %arrayidx = getelementptr inbounds i32, ptr addrspace(4) %output, i32 %i.067
  %38 = tail call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %arrayidx)
  %39 = tail call <16 x i32> @llvm.arc.vvcadd.init.acc.w.v512(<16 x i32> %38, <16 x i32> zeroinitializer)
  %40 = tail call <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32> %39)
  tail call void @llvm.arc.vvst.w.v512(<16 x i32> %40, ptr addrspace(4) %arrayidx)
  %add16 = add nuw nsw i32 %i.067, 16
  %cmp = icmp slt i32 %add16, %mul
  br i1 %cmp, label %for.cond.cleanup4, label %for.cond.cleanup, !llvm.loop !36

for.cond.cleanup21:                               ; preds = %for.cond.cleanup26.us, %for.cond.cleanup26.us.loopexit.us, %for.cond.cleanup
  ret void
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @autovectorized_conv1d(i32 noundef %N_out, i32 noundef %N_in, i32 noundef %W, ptr addrspace(4) noalias nocapture noundef %output, ptr addrspace(4) noalias nocapture noundef readonly %input, ptr addrspace(4) noalias nocapture noundef readonly %window) local_unnamed_addr #1 {
entry:
  %cmp20 = icmp sgt i32 %N_out, 0
  %cmp217 = icmp sgt i32 %W, 0
  %or.cond = and i1 %cmp20, %cmp217
  br i1 %or.cond, label %for.body.lr.ph.split.us, label %for.cond.cleanup

for.body.lr.ph.split.us:                          ; preds = %entry
  %min.iters.check = icmp ult i32 %W, 8
  %n.vec = and i32 %W, -64
  %cmp.n = icmp eq i32 %n.vec, %W
  %n.vec.remaining = and i32 %W, 56
  %min.epilog.iters.check = icmp eq i32 %n.vec.remaining, 0
  %n.vec38 = and i32 %W, -8
  %cmp.n39 = icmp eq i32 %n.vec38, %W
  br i1 %min.iters.check, label %iter.check.us.preheader, label %for.body.lr.ph.split.us.split

iter.check.us.preheader:                          ; preds = %for.body.lr.ph.split.us
  br label %iter.check.us

iter.check.us:                                    ; preds = %iter.check.us.preheader, %for.cond.cleanup3.us.loopexit.us
  %i.021.us.us = phi i32 [ %inc9.us.us, %for.cond.cleanup3.us.loopexit.us ], [ 0, %iter.check.us.preheader ]
  %arrayidx6.us.us = getelementptr inbounds i32, ptr addrspace(4) %output, i32 %i.021.us.us
  %arrayidx6.promoted.us.us = load i32, ptr addrspace(4) %arrayidx6.us.us, align 4, !tbaa !3
  br label %for.body4.us.us

for.body4.us.us:                                  ; preds = %iter.check.us, %for.body4.us.us
  %add719.us.us = phi i32 [ %arrayidx6.promoted.us.us, %iter.check.us ], [ %add7.us.us, %for.body4.us.us ]
  %w_i.018.us.us = phi i32 [ 0, %iter.check.us ], [ %inc.us.us, %for.body4.us.us ]
  %add.us.us = add nuw nsw i32 %w_i.018.us.us, %i.021.us.us
  %arrayidx.us.us = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %add.us.us
  %0 = load i32, ptr addrspace(4) %arrayidx.us.us, align 4, !tbaa !3
  %arrayidx5.us.us = getelementptr inbounds i32, ptr addrspace(4) %window, i32 %w_i.018.us.us
  %1 = load i32, ptr addrspace(4) %arrayidx5.us.us, align 4, !tbaa !3
  %mul.us.us = mul nsw i32 %1, %0
  %add7.us.us = add nsw i32 %mul.us.us, %add719.us.us
  %inc.us.us = add nuw nsw i32 %w_i.018.us.us, 1
  %cmp2.us.us = icmp slt i32 %inc.us.us, %W
  br i1 %cmp2.us.us, label %for.body4.us.us, label %for.cond.cleanup3.us.loopexit.us, !llvm.loop !42

for.cond.cleanup3.us.loopexit.us:                 ; preds = %for.body4.us.us
  store i32 %add7.us.us, ptr addrspace(4) %arrayidx6.us.us, align 4, !tbaa !3
  %inc9.us.us = add nuw nsw i32 %i.021.us.us, 1
  %cmp.us.us = icmp slt i32 %inc9.us.us, %N_out
  br i1 %cmp.us.us, label %iter.check.us, label %for.cond.cleanup, !llvm.loop !43

for.body.lr.ph.split.us.split:                    ; preds = %for.body.lr.ph.split.us
  %min.iters.check24 = icmp ult i32 %W, 64
  br i1 %min.iters.check24, label %iter.check.us51.preheader, label %for.body.lr.ph.split.us.split.split

iter.check.us51.preheader:                        ; preds = %for.body.lr.ph.split.us.split
  br label %iter.check.us51

iter.check.us51:                                  ; preds = %iter.check.us51.preheader, %for.cond.cleanup3.us.us65
  %i.021.us.us52 = phi i32 [ %inc9.us.us67, %for.cond.cleanup3.us.us65 ], [ 0, %iter.check.us51.preheader ]
  %arrayidx6.us.us53 = getelementptr inbounds i32, ptr addrspace(4) %output, i32 %i.021.us.us52
  %arrayidx6.promoted.us.us54 = load i32, ptr addrspace(4) %arrayidx6.us.us53, align 4, !tbaa !3
  %2 = insertelement <8 x i32> <i32 poison, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, i32 %arrayidx6.promoted.us.us54, i64 0
  br label %vec.epilog.vector.body.us

for.body4.us.us55:                                ; preds = %for.body4.us.us55.preheader, %for.body4.us.us55
  %add719.us.us56 = phi i32 [ %add7.us.us62, %for.body4.us.us55 ], [ %5, %for.body4.us.us55.preheader ]
  %w_i.018.us.us57 = phi i32 [ %inc.us.us63, %for.body4.us.us55 ], [ %n.vec38, %for.body4.us.us55.preheader ]
  %add.us.us58 = add nuw nsw i32 %w_i.018.us.us57, %i.021.us.us52
  %arrayidx.us.us59 = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %add.us.us58
  %3 = load i32, ptr addrspace(4) %arrayidx.us.us59, align 4, !tbaa !3
  %arrayidx5.us.us60 = getelementptr inbounds i32, ptr addrspace(4) %window, i32 %w_i.018.us.us57
  %4 = load i32, ptr addrspace(4) %arrayidx5.us.us60, align 4, !tbaa !3
  %mul.us.us61 = mul nsw i32 %4, %3
  %add7.us.us62 = add nsw i32 %mul.us.us61, %add719.us.us56
  %inc.us.us63 = add nuw nsw i32 %w_i.018.us.us57, 1
  %cmp2.us.us64 = icmp slt i32 %inc.us.us63, %W
  br i1 %cmp2.us.us64, label %for.body4.us.us55, label %for.cond.cleanup3.us.us65, !llvm.loop !42

for.cond.cleanup3.us.us65:                        ; preds = %for.body4.us.us55, %vec.epilog.middle.block.us
  %add7.us.lcssa.us66 = phi i32 [ %5, %vec.epilog.middle.block.us ], [ %add7.us.us62, %for.body4.us.us55 ]
  store i32 %add7.us.lcssa.us66, ptr addrspace(4) %arrayidx6.us.us53, align 4, !tbaa !3
  %inc9.us.us67 = add nuw nsw i32 %i.021.us.us52, 1
  %cmp.us.us68 = icmp slt i32 %inc9.us.us67, %N_out
  br i1 %cmp.us.us68, label %iter.check.us51, label %for.cond.cleanup, !llvm.loop !43

vec.epilog.middle.block.us:                       ; preds = %vec.epilog.vector.body.us
  %5 = tail call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %10)
  br i1 %cmp.n39, label %for.cond.cleanup3.us.us65, label %for.body4.us.us55.preheader

for.body4.us.us55.preheader:                      ; preds = %vec.epilog.middle.block.us
  br label %for.body4.us.us55

vec.epilog.vector.body.us:                        ; preds = %vec.epilog.vector.body.us, %iter.check.us51
  %index40.us = phi i32 [ 0, %iter.check.us51 ], [ %index.next44.us, %vec.epilog.vector.body.us ]
  %vec.phi41.us = phi <8 x i32> [ %2, %iter.check.us51 ], [ %10, %vec.epilog.vector.body.us ]
  %6 = add nuw nsw i32 %index40.us, %i.021.us.us52
  %7 = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %6
  %wide.load42.us = load <8 x i32>, ptr addrspace(4) %7, align 4, !tbaa !3
  %8 = getelementptr inbounds i32, ptr addrspace(4) %window, i32 %index40.us
  %wide.load43.us = load <8 x i32>, ptr addrspace(4) %8, align 4, !tbaa !3
  %9 = mul nsw <8 x i32> %wide.load43.us, %wide.load42.us
  %10 = add <8 x i32> %9, %vec.phi41.us
  %index.next44.us = add nuw i32 %index40.us, 8
  %11 = icmp eq i32 %index.next44.us, %n.vec38
  br i1 %11, label %vec.epilog.middle.block.us, label %vec.epilog.vector.body.us, !llvm.loop !44

for.body.lr.ph.split.us.split.split:              ; preds = %for.body.lr.ph.split.us.split
  br i1 %cmp.n, label %iter.check.us74.preheader, label %iter.check.preheader

iter.check.preheader:                             ; preds = %for.body.lr.ph.split.us.split.split
  br label %iter.check

iter.check.us74.preheader:                        ; preds = %for.body.lr.ph.split.us.split.split
  br label %iter.check.us74

iter.check.us74:                                  ; preds = %iter.check.us74.preheader, %middle.block.us
  %i.021.us.us75 = phi i32 [ %inc9.us.us80, %middle.block.us ], [ 0, %iter.check.us74.preheader ]
  %arrayidx6.us.us76 = getelementptr inbounds i32, ptr addrspace(4) %output, i32 %i.021.us.us75
  %arrayidx6.promoted.us.us77 = load i32, ptr addrspace(4) %arrayidx6.us.us76, align 4, !tbaa !3
  %12 = insertelement <16 x i32> <i32 poison, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, i32 %arrayidx6.promoted.us.us77, i64 0
  br label %vector.body.us

middle.block.us:                                  ; preds = %vector.body.us
  %bin.rdx.us = add <16 x i32> %28, %27
  %bin.rdx35.us = add <16 x i32> %29, %bin.rdx.us
  %bin.rdx36.us = add <16 x i32> %30, %bin.rdx35.us
  %13 = tail call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %bin.rdx36.us)
  store i32 %13, ptr addrspace(4) %arrayidx6.us.us76, align 4, !tbaa !3
  %inc9.us.us80 = add nuw nsw i32 %i.021.us.us75, 1
  %cmp.us.us81 = icmp slt i32 %inc9.us.us80, %N_out
  br i1 %cmp.us.us81, label %iter.check.us74, label %for.cond.cleanup, !llvm.loop !43

vector.body.us:                                   ; preds = %vector.body.us, %iter.check.us74
  %index.us = phi i32 [ 0, %iter.check.us74 ], [ %index.next.us, %vector.body.us ]
  %vec.phi.us = phi <16 x i32> [ %12, %iter.check.us74 ], [ %27, %vector.body.us ]
  %vec.phi25.us = phi <16 x i32> [ zeroinitializer, %iter.check.us74 ], [ %28, %vector.body.us ]
  %vec.phi26.us = phi <16 x i32> [ zeroinitializer, %iter.check.us74 ], [ %29, %vector.body.us ]
  %vec.phi27.us = phi <16 x i32> [ zeroinitializer, %iter.check.us74 ], [ %30, %vector.body.us ]
  %14 = add nuw nsw i32 %index.us, %i.021.us.us75
  %15 = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %14
  %wide.load.us = load <16 x i32>, ptr addrspace(4) %15, align 4, !tbaa !3
  %16 = getelementptr inbounds i32, ptr addrspace(4) %15, i32 16
  %wide.load28.us = load <16 x i32>, ptr addrspace(4) %16, align 4, !tbaa !3
  %17 = getelementptr inbounds i32, ptr addrspace(4) %15, i32 32
  %wide.load29.us = load <16 x i32>, ptr addrspace(4) %17, align 4, !tbaa !3
  %18 = getelementptr inbounds i32, ptr addrspace(4) %15, i32 48
  %wide.load30.us = load <16 x i32>, ptr addrspace(4) %18, align 4, !tbaa !3
  %19 = getelementptr inbounds i32, ptr addrspace(4) %window, i32 %index.us
  %wide.load31.us = load <16 x i32>, ptr addrspace(4) %19, align 4, !tbaa !3
  %20 = getelementptr inbounds i32, ptr addrspace(4) %19, i32 16
  %wide.load32.us = load <16 x i32>, ptr addrspace(4) %20, align 4, !tbaa !3
  %21 = getelementptr inbounds i32, ptr addrspace(4) %19, i32 32
  %wide.load33.us = load <16 x i32>, ptr addrspace(4) %21, align 4, !tbaa !3
  %22 = getelementptr inbounds i32, ptr addrspace(4) %19, i32 48
  %wide.load34.us = load <16 x i32>, ptr addrspace(4) %22, align 4, !tbaa !3
  %23 = mul nsw <16 x i32> %wide.load31.us, %wide.load.us
  %24 = mul nsw <16 x i32> %wide.load32.us, %wide.load28.us
  %25 = mul nsw <16 x i32> %wide.load33.us, %wide.load29.us
  %26 = mul nsw <16 x i32> %wide.load34.us, %wide.load30.us
  %27 = add <16 x i32> %23, %vec.phi.us
  %28 = add <16 x i32> %24, %vec.phi25.us
  %29 = add <16 x i32> %25, %vec.phi26.us
  %30 = add <16 x i32> %26, %vec.phi27.us
  %index.next.us = add nuw i32 %index.us, 64
  %31 = icmp eq i32 %index.next.us, %W
  br i1 %31, label %middle.block.us, label %vector.body.us, !llvm.loop !45

for.cond.cleanup3.us:                             ; preds = %for.body4.us, %vec.epilog.middle.block
  %add7.us.lcssa = phi i32 [ %61, %vec.epilog.middle.block ], [ %add7.us, %for.body4.us ]
  store i32 %add7.us.lcssa, ptr addrspace(4) %arrayidx6.us, align 4, !tbaa !3
  %inc9.us = add nuw nsw i32 %i.021.us, 1
  %cmp.us = icmp slt i32 %inc9.us, %N_out
  br i1 %cmp.us, label %iter.check, label %for.cond.cleanup, !llvm.loop !43

for.body4.us:                                     ; preds = %for.body4.us.preheader, %for.body4.us
  %add719.us = phi i32 [ %add7.us, %for.body4.us ], [ %add719.us.ph, %for.body4.us.preheader ]
  %w_i.018.us = phi i32 [ %inc.us, %for.body4.us ], [ %w_i.018.us.ph, %for.body4.us.preheader ]
  %add.us = add nuw nsw i32 %w_i.018.us, %i.021.us
  %arrayidx.us = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %add.us
  %32 = load i32, ptr addrspace(4) %arrayidx.us, align 4, !tbaa !3
  %arrayidx5.us = getelementptr inbounds i32, ptr addrspace(4) %window, i32 %w_i.018.us
  %33 = load i32, ptr addrspace(4) %arrayidx5.us, align 4, !tbaa !3
  %mul.us = mul nsw i32 %33, %32
  %add7.us = add nsw i32 %mul.us, %add719.us
  %inc.us = add nuw nsw i32 %w_i.018.us, 1
  %cmp2.us = icmp slt i32 %inc.us, %W
  br i1 %cmp2.us, label %for.body4.us, label %for.cond.cleanup3.us, !llvm.loop !42

iter.check:                                       ; preds = %iter.check.preheader, %for.cond.cleanup3.us
  %i.021.us = phi i32 [ %inc9.us, %for.cond.cleanup3.us ], [ 0, %iter.check.preheader ]
  %arrayidx6.us = getelementptr inbounds i32, ptr addrspace(4) %output, i32 %i.021.us
  %arrayidx6.promoted.us = load i32, ptr addrspace(4) %arrayidx6.us, align 4, !tbaa !3
  %34 = insertelement <16 x i32> <i32 poison, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, i32 %arrayidx6.promoted.us, i64 0
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %iter.check
  %index = phi i32 [ 0, %iter.check ], [ %index.next, %vector.body ]
  %vec.phi = phi <16 x i32> [ %34, %iter.check ], [ %48, %vector.body ]
  %vec.phi25 = phi <16 x i32> [ zeroinitializer, %iter.check ], [ %49, %vector.body ]
  %vec.phi26 = phi <16 x i32> [ zeroinitializer, %iter.check ], [ %50, %vector.body ]
  %vec.phi27 = phi <16 x i32> [ zeroinitializer, %iter.check ], [ %51, %vector.body ]
  %35 = add nuw nsw i32 %index, %i.021.us
  %36 = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %35
  %wide.load = load <16 x i32>, ptr addrspace(4) %36, align 4, !tbaa !3
  %37 = getelementptr inbounds i32, ptr addrspace(4) %36, i32 16
  %wide.load28 = load <16 x i32>, ptr addrspace(4) %37, align 4, !tbaa !3
  %38 = getelementptr inbounds i32, ptr addrspace(4) %36, i32 32
  %wide.load29 = load <16 x i32>, ptr addrspace(4) %38, align 4, !tbaa !3
  %39 = getelementptr inbounds i32, ptr addrspace(4) %36, i32 48
  %wide.load30 = load <16 x i32>, ptr addrspace(4) %39, align 4, !tbaa !3
  %40 = getelementptr inbounds i32, ptr addrspace(4) %window, i32 %index
  %wide.load31 = load <16 x i32>, ptr addrspace(4) %40, align 4, !tbaa !3
  %41 = getelementptr inbounds i32, ptr addrspace(4) %40, i32 16
  %wide.load32 = load <16 x i32>, ptr addrspace(4) %41, align 4, !tbaa !3
  %42 = getelementptr inbounds i32, ptr addrspace(4) %40, i32 32
  %wide.load33 = load <16 x i32>, ptr addrspace(4) %42, align 4, !tbaa !3
  %43 = getelementptr inbounds i32, ptr addrspace(4) %40, i32 48
  %wide.load34 = load <16 x i32>, ptr addrspace(4) %43, align 4, !tbaa !3
  %44 = mul nsw <16 x i32> %wide.load31, %wide.load
  %45 = mul nsw <16 x i32> %wide.load32, %wide.load28
  %46 = mul nsw <16 x i32> %wide.load33, %wide.load29
  %47 = mul nsw <16 x i32> %wide.load34, %wide.load30
  %48 = add <16 x i32> %44, %vec.phi
  %49 = add <16 x i32> %45, %vec.phi25
  %50 = add <16 x i32> %46, %vec.phi26
  %51 = add <16 x i32> %47, %vec.phi27
  %index.next = add nuw i32 %index, 64
  %52 = icmp eq i32 %index.next, %n.vec
  br i1 %52, label %middle.block, label %vector.body, !llvm.loop !45

middle.block:                                     ; preds = %vector.body
  %bin.rdx = add <16 x i32> %49, %48
  %bin.rdx35 = add <16 x i32> %50, %bin.rdx
  %bin.rdx36 = add <16 x i32> %51, %bin.rdx35
  %53 = tail call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %bin.rdx36)
  br i1 %min.epilog.iters.check, label %for.body4.us.preheader, label %vec.epilog.ph

vec.epilog.ph:                                    ; preds = %middle.block
  %54 = insertelement <8 x i32> <i32 poison, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, i32 %53, i64 0
  br label %vec.epilog.vector.body

vec.epilog.vector.body:                           ; preds = %vec.epilog.vector.body, %vec.epilog.ph
  %index40 = phi i32 [ %n.vec, %vec.epilog.ph ], [ %index.next44, %vec.epilog.vector.body ]
  %vec.phi41 = phi <8 x i32> [ %54, %vec.epilog.ph ], [ %59, %vec.epilog.vector.body ]
  %55 = add nuw nsw i32 %index40, %i.021.us
  %56 = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %55
  %wide.load42 = load <8 x i32>, ptr addrspace(4) %56, align 4, !tbaa !3
  %57 = getelementptr inbounds i32, ptr addrspace(4) %window, i32 %index40
  %wide.load43 = load <8 x i32>, ptr addrspace(4) %57, align 4, !tbaa !3
  %58 = mul nsw <8 x i32> %wide.load43, %wide.load42
  %59 = add <8 x i32> %58, %vec.phi41
  %index.next44 = add nuw i32 %index40, 8
  %60 = icmp eq i32 %index.next44, %n.vec38
  br i1 %60, label %vec.epilog.middle.block, label %vec.epilog.vector.body, !llvm.loop !44

vec.epilog.middle.block:                          ; preds = %vec.epilog.vector.body
  %61 = tail call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %59)
  br i1 %cmp.n39, label %for.cond.cleanup3.us, label %for.body4.us.preheader

for.body4.us.preheader:                           ; preds = %middle.block, %vec.epilog.middle.block
  %add719.us.ph = phi i32 [ %53, %middle.block ], [ %61, %vec.epilog.middle.block ]
  %w_i.018.us.ph = phi i32 [ %n.vec, %middle.block ], [ %n.vec38, %vec.epilog.middle.block ]
  br label %for.body4.us

for.cond.cleanup:                                 ; preds = %for.cond.cleanup3.us, %middle.block.us, %for.cond.cleanup3.us.us65, %for.cond.cleanup3.us.loopexit.us, %entry
  ret void
}

; Function Attrs: nounwind
define dso_local void @vekt_conv1d_wrapper(i32 noundef %N_out, i32 noundef %N_in, i32 noundef %W, ptr noundef %output, ptr noundef %input, ptr noundef %window) local_unnamed_addr #4 {
entry:
  tail call void @vekt_conv1d(i32 noundef %N_out, i32 noundef %N_in, i32 noundef %W, ptr noundef %output, ptr noundef %output, i32 noundef 0, i32 noundef %N_out, i32 noundef 1, ptr noundef %input, ptr noundef %input, i32 noundef 0, i32 noundef %N_in, i32 noundef 1, ptr noundef %window, ptr noundef %window, i32 noundef 0, i32 noundef %W, i32 noundef 1) #11
  ret void
}

declare void @vekt_conv1d(i32 noundef, i32 noundef, i32 noundef, ptr noundef, ptr noundef, i32 noundef, i32 noundef, i32 noundef, ptr noundef, ptr noundef, i32 noundef, i32 noundef, i32 noundef, ptr noundef, ptr noundef, i32 noundef, i32 noundef, i32 noundef) local_unnamed_addr #5

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <16 x i32> @llvm.arc.vvcadd.init.acc.w.v512(<16 x i32>, <16 x i32>) #6

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(read)
declare <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4)) #7

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <16 x i32> @llvm.arc.vvcmac.lo.acc.w.v512(<16 x i32>, <16 x i32>, <16 x i32>) #6

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(write)
declare void @llvm.arc.vvst.w.v512(<16 x i32>, ptr addrspace(4)) #8

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32>) #6

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #9

; Function Attrs: nofree nounwind
declare noundef i32 @putchar(i32 noundef) local_unnamed_addr #9

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.add.v16i32(<16 x i32>) #10

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.add.v8i32(<8 x i32>) #10

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: write) "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #1 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite) "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #2 = { nofree nounwind "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #3 = { mustprogress nofree nosync nounwind willreturn "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #4 = { nounwind "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #5 = { "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #6 = { mustprogress nocallback nofree nosync nounwind willreturn memory(none) }
attributes #7 = { mustprogress nocallback nofree nosync nounwind willreturn memory(read) }
attributes #8 = { mustprogress nocallback nofree nosync nounwind willreturn memory(write) }
attributes #9 = { nofree nounwind }
attributes #10 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #11 = { nounwind }

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
!11 = distinct !{!11, !8, !9, !10}
!12 = distinct !{!12, !8, !10, !9}
!13 = !{!14}
!14 = distinct !{!14, !15}
!15 = distinct !{!15, !"LVerDomain"}
!16 = !{!17}
!17 = distinct !{!17, !15}
!18 = distinct !{!18, !8, !9, !10}
!19 = !{!20}
!20 = distinct !{!20, !21}
!21 = distinct !{!21, !"LVerDomain"}
!22 = !{!23}
!23 = distinct !{!23, !21}
!24 = distinct !{!24, !8, !9, !10}
!25 = distinct !{!25, !8, !9}
!26 = distinct !{!26, !8}
!27 = distinct !{!27, !8}
!28 = distinct !{!28, !8, !29, !30}
!29 = !{!"llvm.loop.vectorize.width", i32 1}
!30 = !{!"llvm.loop.vectorize.followup_all", !31}
!31 = distinct !{!31, !8, !32}
!32 = !{!"llvm.loop.isvectorized"}
!33 = distinct !{!33, !8, !29, !34}
!34 = !{!"llvm.loop.vectorize.followup_all", !35}
!35 = distinct !{!35, !8, !32}
!36 = distinct !{!36, !8}
!37 = distinct !{!37, !8}
!38 = distinct !{!38, !8, !10, !9}
!39 = distinct !{!39, !8}
!40 = distinct !{!40, !8, !9, !10}
!41 = distinct !{!41, !8, !9, !10}
!42 = distinct !{!42, !8, !10, !9}
!43 = distinct !{!43, !8}
!44 = distinct !{!44, !8, !9, !10}
!45 = distinct !{!45, !8, !9, !10}
