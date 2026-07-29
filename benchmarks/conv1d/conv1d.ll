; ModuleID = 'conv1d.c'
source_filename = "conv1d.c"
target datalayout = "e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-f64:32-v64:32-v128:32-a:0:32-v256:32-v512:32-n8:16:32"
target triple = "arc-pc-unknown-gnu"

@.str.1 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.2 = private unnamed_addr constant [4 x i8] c"%d,\00", align 1
@str = private unnamed_addr constant [2 x i8] c"]\00", align 1

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: write)
define dso_local void @init_vector(ptr nocapture noundef writeonly %a, i32 noundef %dim, i32 noundef %value) local_unnamed_addr #0 {
entry:
  %cmp3 = icmp sgt i32 %dim, 0
  br i1 %cmp3, label %iter.check, label %for.cond.cleanup

iter.check:                                       ; preds = %entry
  %min.iters.check = icmp ult i32 %dim, 8
  br i1 %min.iters.check, label %for.body.preheader, label %vector.main.loop.iter.check

vector.main.loop.iter.check:                      ; preds = %iter.check
  %min.iters.check5 = icmp ult i32 %dim, 16
  br i1 %min.iters.check5, label %vec.epilog.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.main.loop.iter.check
  %n.vec = and i32 %dim, -16
  %broadcast.splatinsert = insertelement <16 x i32> poison, i32 %value, i64 0
  %broadcast.splat = shufflevector <16 x i32> %broadcast.splatinsert, <16 x i32> poison, <16 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %0 = getelementptr inbounds i32, ptr %a, i32 %index
  store <16 x i32> %broadcast.splat, ptr %0, align 4, !tbaa !3
  %index.next = add nuw i32 %index, 16
  %1 = icmp eq i32 %index.next, %n.vec
  br i1 %1, label %middle.block, label %vector.body, !llvm.loop !7

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i32 %n.vec, %dim
  br i1 %cmp.n, label %for.cond.cleanup, label %vec.epilog.iter.check

vec.epilog.iter.check:                            ; preds = %middle.block
  %n.vec.remaining = and i32 %dim, 8
  %min.epilog.iters.check.not.not = icmp eq i32 %n.vec.remaining, 0
  br i1 %min.epilog.iters.check.not.not, label %for.body.preheader, label %vec.epilog.ph

vec.epilog.ph:                                    ; preds = %vector.main.loop.iter.check, %vec.epilog.iter.check
  %vec.epilog.resume.val = phi i32 [ %n.vec, %vec.epilog.iter.check ], [ 0, %vector.main.loop.iter.check ]
  %n.vec7 = and i32 %dim, -8
  %broadcast.splatinsert10 = insertelement <8 x i32> poison, i32 %value, i64 0
  %broadcast.splat11 = shufflevector <8 x i32> %broadcast.splatinsert10, <8 x i32> poison, <8 x i32> zeroinitializer
  br label %vec.epilog.vector.body

vec.epilog.vector.body:                           ; preds = %vec.epilog.vector.body, %vec.epilog.ph
  %index9 = phi i32 [ %vec.epilog.resume.val, %vec.epilog.ph ], [ %index.next12, %vec.epilog.vector.body ]
  %2 = getelementptr inbounds i32, ptr %a, i32 %index9
  store <8 x i32> %broadcast.splat11, ptr %2, align 4, !tbaa !3
  %index.next12 = add nuw i32 %index9, 8
  %3 = icmp eq i32 %index.next12, %n.vec7
  br i1 %3, label %vec.epilog.middle.block, label %vec.epilog.vector.body, !llvm.loop !12

vec.epilog.middle.block:                          ; preds = %vec.epilog.vector.body
  %cmp.n8 = icmp eq i32 %n.vec7, %dim
  br i1 %cmp.n8, label %for.cond.cleanup, label %for.body.preheader

for.body.preheader:                               ; preds = %iter.check, %vec.epilog.iter.check, %vec.epilog.middle.block
  %i.04.ph = phi i32 [ 0, %iter.check ], [ %n.vec, %vec.epilog.iter.check ], [ %n.vec7, %vec.epilog.middle.block ]
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body, %middle.block, %vec.epilog.middle.block, %entry
  ret void

for.body:                                         ; preds = %for.body.preheader, %for.body
  %i.04 = phi i32 [ %inc, %for.body ], [ %i.04.ph, %for.body.preheader ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i32 %i.04
  store i32 %value, ptr %arrayidx, align 4, !tbaa !3
  %inc = add nuw nsw i32 %i.04, 1
  %cmp = icmp slt i32 %inc, %dim
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !13
}

; Function Attrs: nofree nounwind
define dso_local void @print_vector(ptr nocapture noundef readonly %A, i32 noundef %N) local_unnamed_addr #1 {
entry:
  %putchar = tail call i32 @putchar(i32 91)
  %cmp10 = icmp sgt i32 %N, 0
  br i1 %cmp10, label %for.body.lr.ph, label %for.cond.cleanup

for.body.lr.ph:                                   ; preds = %entry
  %sub = add nsw i32 %N, -1
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.inc, %entry
  %puts = tail call i32 @puts(ptr nonnull dereferenceable(1) @str)
  ret void

for.body:                                         ; preds = %for.body.lr.ph, %for.inc
  %i.011 = phi i32 [ 0, %for.body.lr.ph ], [ %inc, %for.inc ]
  %cmp1 = icmp eq i32 %i.011, %sub
  %arrayidx = getelementptr inbounds i32, ptr %A, i32 %i.011
  %0 = load i32, ptr %arrayidx, align 4, !tbaa !3
  br i1 %cmp1, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %call2 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.1, i32 noundef %0)
  br label %for.inc

if.else:                                          ; preds = %for.body
  %call4 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef %0)
  br label %for.inc

for.inc:                                          ; preds = %if.then, %if.else
  %inc = add nuw nsw i32 %i.011, 1
  %cmp = icmp slt i32 %inc, %N
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !14
}

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #1

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @conv1d(i32 noundef %N_out, i32 noundef %N_in, i32 noundef %W, ptr nocapture noundef %output, ptr nocapture noundef readonly %input, ptr nocapture noundef readonly %window) local_unnamed_addr #2 {
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
  br i1 %cmp.us, label %for.body4.lr.ph.us, label %for.cond.cleanup, !llvm.loop !15

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
  br i1 %cmp2.us, label %for.body4.us, label %for.cond.cleanup3.us, !llvm.loop !20

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
  %cmp28 = icmp sgt i32 %N_out, 15
  br i1 %cmp28, label %for.body.lr.ph, label %for.cond.cleanup

for.body.lr.ph:                                   ; preds = %entry
  %0 = tail call <16 x i32> @llvm.arc.vvcmpy.lo.acc.w.v512(<16 x i32> zeroinitializer, <16 x i32> zeroinitializer)
  %cmp225 = icmp sgt i32 %W, 0
  br i1 %cmp225, label %for.body4.lr.ph.us.preheader, label %for.body.lr.ph.split

for.body4.lr.ph.us.preheader:                     ; preds = %for.body.lr.ph
  br label %for.body4.lr.ph.us

for.cond.cleanup3.us:                             ; preds = %for.body4.us
  %1 = tail call <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32> %4)
  %arrayidx12.us = getelementptr inbounds i32, ptr addrspace(4) %output, i32 %i.029.us
  tail call void @llvm.arc.vvst.w.v512(<16 x i32> %1, ptr addrspace(4) %arrayidx12.us)
  %add14.us = add nuw nsw i32 %i.029.us, 16
  %cmp.us = icmp slt i32 %add14.us, %mul
  br i1 %cmp.us, label %for.body4.lr.ph.us, label %for.cond.cleanup, !llvm.loop !23

for.body4.us:                                     ; preds = %for.body4.lr.ph.us, %for.body4.us
  %acc.sroa.0.027.us = phi <16 x i32> [ %0, %for.body4.lr.ph.us ], [ %4, %for.body4.us ]
  %w_i.026.us = phi i32 [ 0, %for.body4.lr.ph.us ], [ %inc.us, %for.body4.us ]
  %arrayidx.us = getelementptr inbounds i32, ptr addrspace(4) %window, i32 %w_i.026.us
  %2 = load i32, ptr addrspace(4) %arrayidx.us, align 4, !tbaa !3
  %add.us = add nuw nsw i32 %w_i.026.us, %i.029.us
  %arrayidx5.us = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %add.us
  %3 = tail call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %arrayidx5.us)
  %splat.splatinsert.us = insertelement <16 x i32> poison, i32 %2, i64 0
  %splat.splat.us = shufflevector <16 x i32> %splat.splatinsert.us, <16 x i32> poison, <16 x i32> zeroinitializer
  %4 = tail call <16 x i32> @llvm.arc.vvcmac.lo.acc.w.v512(<16 x i32> %acc.sroa.0.027.us, <16 x i32> %3, <16 x i32> %splat.splat.us)
  %inc.us = add nuw nsw i32 %w_i.026.us, 1
  %cmp2.us = icmp slt i32 %inc.us, %W
  br i1 %cmp2.us, label %for.body4.us, label %for.cond.cleanup3.us, !llvm.loop !24

for.body4.lr.ph.us:                               ; preds = %for.body4.lr.ph.us.preheader, %for.cond.cleanup3.us
  %i.029.us = phi i32 [ %add14.us, %for.cond.cleanup3.us ], [ 0, %for.body4.lr.ph.us.preheader ]
  br label %for.body4.us

for.body.lr.ph.split:                             ; preds = %for.body.lr.ph
  %5 = tail call <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32> %0)
  br label %for.cond.cleanup3

for.cond.cleanup:                                 ; preds = %for.cond.cleanup3, %for.cond.cleanup3.us, %entry
  ret void

for.cond.cleanup3:                                ; preds = %for.cond.cleanup3, %for.body.lr.ph.split
  %i.029 = phi i32 [ 0, %for.body.lr.ph.split ], [ %add14, %for.cond.cleanup3 ]
  %arrayidx12 = getelementptr inbounds i32, ptr addrspace(4) %output, i32 %i.029
  tail call void @llvm.arc.vvst.w.v512(<16 x i32> %5, ptr addrspace(4) %arrayidx12)
  %add14 = add nuw nsw i32 %i.029, 16
  %cmp = icmp slt i32 %add14, %mul
  br i1 %cmp, label %for.cond.cleanup3, label %for.cond.cleanup, !llvm.loop !23
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @autovectorized_conv1d(i32 noundef %N_out, i32 noundef %N_in, i32 noundef %W, ptr addrspace(4) noalias nocapture noundef %output, ptr addrspace(4) noalias nocapture noundef readonly %input, ptr addrspace(4) noalias nocapture noundef readonly %window) local_unnamed_addr #2 {
entry:
  %cmp20 = icmp sgt i32 %N_out, 0
  %cmp217 = icmp sgt i32 %W, 0
  %or.cond = and i1 %cmp20, %cmp217
  br i1 %or.cond, label %for.body.lr.ph.split.us, label %for.cond.cleanup

for.body.lr.ph.split.us:                          ; preds = %entry
  %min.iters.check = icmp ult i32 %W, 8
  %n.vec = and i32 %W, -16
  %cmp.n = icmp eq i32 %n.vec, %W
  %n.vec.remaining = and i32 %W, 8
  %min.epilog.iters.check.not.not = icmp eq i32 %n.vec.remaining, 0
  %n.vec27 = and i32 %W, -8
  %cmp.n28 = icmp eq i32 %n.vec27, %W
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
  br i1 %cmp2.us.us, label %for.body4.us.us, label %for.cond.cleanup3.us.loopexit.us, !llvm.loop !25

for.cond.cleanup3.us.loopexit.us:                 ; preds = %for.body4.us.us
  store i32 %add7.us.us, ptr addrspace(4) %arrayidx6.us.us, align 4, !tbaa !3
  %inc9.us.us = add nuw nsw i32 %i.021.us.us, 1
  %cmp.us.us = icmp slt i32 %inc9.us.us, %N_out
  br i1 %cmp.us.us, label %iter.check.us, label %for.cond.cleanup, !llvm.loop !26

for.body.lr.ph.split.us.split:                    ; preds = %for.body.lr.ph.split.us
  %min.iters.check24 = icmp ult i32 %W, 16
  br i1 %min.iters.check24, label %iter.check.us37.preheader, label %for.body.lr.ph.split.us.split.split

iter.check.us37.preheader:                        ; preds = %for.body.lr.ph.split.us.split
  br label %iter.check.us37

iter.check.us37:                                  ; preds = %iter.check.us37.preheader, %for.cond.cleanup3.us.us51
  %i.021.us.us38 = phi i32 [ %inc9.us.us53, %for.cond.cleanup3.us.us51 ], [ 0, %iter.check.us37.preheader ]
  %arrayidx6.us.us39 = getelementptr inbounds i32, ptr addrspace(4) %output, i32 %i.021.us.us38
  %arrayidx6.promoted.us.us40 = load i32, ptr addrspace(4) %arrayidx6.us.us39, align 4, !tbaa !3
  %2 = insertelement <8 x i32> <i32 poison, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, i32 %arrayidx6.promoted.us.us40, i64 0
  br label %vec.epilog.vector.body.us

for.body4.us.us41:                                ; preds = %for.body4.us.us41.preheader, %for.body4.us.us41
  %add719.us.us42 = phi i32 [ %add7.us.us48, %for.body4.us.us41 ], [ %5, %for.body4.us.us41.preheader ]
  %w_i.018.us.us43 = phi i32 [ %inc.us.us49, %for.body4.us.us41 ], [ %n.vec27, %for.body4.us.us41.preheader ]
  %add.us.us44 = add nuw nsw i32 %w_i.018.us.us43, %i.021.us.us38
  %arrayidx.us.us45 = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %add.us.us44
  %3 = load i32, ptr addrspace(4) %arrayidx.us.us45, align 4, !tbaa !3
  %arrayidx5.us.us46 = getelementptr inbounds i32, ptr addrspace(4) %window, i32 %w_i.018.us.us43
  %4 = load i32, ptr addrspace(4) %arrayidx5.us.us46, align 4, !tbaa !3
  %mul.us.us47 = mul nsw i32 %4, %3
  %add7.us.us48 = add nsw i32 %mul.us.us47, %add719.us.us42
  %inc.us.us49 = add nuw nsw i32 %w_i.018.us.us43, 1
  %cmp2.us.us50 = icmp slt i32 %inc.us.us49, %W
  br i1 %cmp2.us.us50, label %for.body4.us.us41, label %for.cond.cleanup3.us.us51, !llvm.loop !25

for.cond.cleanup3.us.us51:                        ; preds = %for.body4.us.us41, %vec.epilog.middle.block.us
  %add7.us.lcssa.us52 = phi i32 [ %5, %vec.epilog.middle.block.us ], [ %add7.us.us48, %for.body4.us.us41 ]
  store i32 %add7.us.lcssa.us52, ptr addrspace(4) %arrayidx6.us.us39, align 4, !tbaa !3
  %inc9.us.us53 = add nuw nsw i32 %i.021.us.us38, 1
  %cmp.us.us54 = icmp slt i32 %inc9.us.us53, %N_out
  br i1 %cmp.us.us54, label %iter.check.us37, label %for.cond.cleanup, !llvm.loop !26

vec.epilog.middle.block.us:                       ; preds = %vec.epilog.vector.body.us
  %5 = tail call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %10)
  br i1 %cmp.n28, label %for.cond.cleanup3.us.us51, label %for.body4.us.us41.preheader

for.body4.us.us41.preheader:                      ; preds = %vec.epilog.middle.block.us
  br label %for.body4.us.us41

vec.epilog.vector.body.us:                        ; preds = %vec.epilog.vector.body.us, %iter.check.us37
  %index29.us = phi i32 [ 0, %iter.check.us37 ], [ %index.next33.us, %vec.epilog.vector.body.us ]
  %vec.phi30.us = phi <8 x i32> [ %2, %iter.check.us37 ], [ %10, %vec.epilog.vector.body.us ]
  %6 = add nuw nsw i32 %index29.us, %i.021.us.us38
  %7 = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %6
  %wide.load31.us = load <8 x i32>, ptr addrspace(4) %7, align 4, !tbaa !3
  %8 = getelementptr inbounds i32, ptr addrspace(4) %window, i32 %index29.us
  %wide.load32.us = load <8 x i32>, ptr addrspace(4) %8, align 4, !tbaa !3
  %9 = mul nsw <8 x i32> %wide.load32.us, %wide.load31.us
  %10 = add <8 x i32> %9, %vec.phi30.us
  %index.next33.us = add nuw i32 %index29.us, 8
  %11 = icmp eq i32 %index.next33.us, %n.vec27
  br i1 %11, label %vec.epilog.middle.block.us, label %vec.epilog.vector.body.us, !llvm.loop !27

for.body.lr.ph.split.us.split.split:              ; preds = %for.body.lr.ph.split.us.split
  br i1 %cmp.n, label %iter.check.us60.preheader, label %iter.check.preheader

iter.check.preheader:                             ; preds = %for.body.lr.ph.split.us.split.split
  br label %iter.check

iter.check.us60.preheader:                        ; preds = %for.body.lr.ph.split.us.split.split
  br label %iter.check.us60

iter.check.us60:                                  ; preds = %iter.check.us60.preheader, %middle.block.us
  %i.021.us.us61 = phi i32 [ %inc9.us.us66, %middle.block.us ], [ 0, %iter.check.us60.preheader ]
  %arrayidx6.us.us62 = getelementptr inbounds i32, ptr addrspace(4) %output, i32 %i.021.us.us61
  %arrayidx6.promoted.us.us63 = load i32, ptr addrspace(4) %arrayidx6.us.us62, align 4, !tbaa !3
  %12 = insertelement <16 x i32> <i32 poison, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, i32 %arrayidx6.promoted.us.us63, i64 0
  br label %vector.body.us

middle.block.us:                                  ; preds = %vector.body.us
  %13 = tail call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %18)
  store i32 %13, ptr addrspace(4) %arrayidx6.us.us62, align 4, !tbaa !3
  %inc9.us.us66 = add nuw nsw i32 %i.021.us.us61, 1
  %cmp.us.us67 = icmp slt i32 %inc9.us.us66, %N_out
  br i1 %cmp.us.us67, label %iter.check.us60, label %for.cond.cleanup, !llvm.loop !26

vector.body.us:                                   ; preds = %vector.body.us, %iter.check.us60
  %index.us = phi i32 [ 0, %iter.check.us60 ], [ %index.next.us, %vector.body.us ]
  %vec.phi.us = phi <16 x i32> [ %12, %iter.check.us60 ], [ %18, %vector.body.us ]
  %14 = add nuw nsw i32 %index.us, %i.021.us.us61
  %15 = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %14
  %wide.load.us = load <16 x i32>, ptr addrspace(4) %15, align 4, !tbaa !3
  %16 = getelementptr inbounds i32, ptr addrspace(4) %window, i32 %index.us
  %wide.load25.us = load <16 x i32>, ptr addrspace(4) %16, align 4, !tbaa !3
  %17 = mul nsw <16 x i32> %wide.load25.us, %wide.load.us
  %18 = add <16 x i32> %17, %vec.phi.us
  %index.next.us = add nuw i32 %index.us, 16
  %19 = icmp eq i32 %index.next.us, %n.vec
  br i1 %19, label %middle.block.us, label %vector.body.us, !llvm.loop !28

for.cond.cleanup3.us:                             ; preds = %for.body4.us, %vec.epilog.middle.block
  %add7.us.lcssa = phi i32 [ %37, %vec.epilog.middle.block ], [ %add7.us, %for.body4.us ]
  store i32 %add7.us.lcssa, ptr addrspace(4) %arrayidx6.us, align 4, !tbaa !3
  %inc9.us = add nuw nsw i32 %i.021.us, 1
  %cmp.us = icmp slt i32 %inc9.us, %N_out
  br i1 %cmp.us, label %iter.check, label %for.cond.cleanup, !llvm.loop !26

for.body4.us:                                     ; preds = %for.body4.us.preheader, %for.body4.us
  %add719.us = phi i32 [ %add7.us, %for.body4.us ], [ %add719.us.ph, %for.body4.us.preheader ]
  %w_i.018.us = phi i32 [ %inc.us, %for.body4.us ], [ %w_i.018.us.ph, %for.body4.us.preheader ]
  %add.us = add nuw nsw i32 %w_i.018.us, %i.021.us
  %arrayidx.us = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %add.us
  %20 = load i32, ptr addrspace(4) %arrayidx.us, align 4, !tbaa !3
  %arrayidx5.us = getelementptr inbounds i32, ptr addrspace(4) %window, i32 %w_i.018.us
  %21 = load i32, ptr addrspace(4) %arrayidx5.us, align 4, !tbaa !3
  %mul.us = mul nsw i32 %21, %20
  %add7.us = add nsw i32 %mul.us, %add719.us
  %inc.us = add nuw nsw i32 %w_i.018.us, 1
  %cmp2.us = icmp slt i32 %inc.us, %W
  br i1 %cmp2.us, label %for.body4.us, label %for.cond.cleanup3.us, !llvm.loop !25

iter.check:                                       ; preds = %iter.check.preheader, %for.cond.cleanup3.us
  %i.021.us = phi i32 [ %inc9.us, %for.cond.cleanup3.us ], [ 0, %iter.check.preheader ]
  %arrayidx6.us = getelementptr inbounds i32, ptr addrspace(4) %output, i32 %i.021.us
  %arrayidx6.promoted.us = load i32, ptr addrspace(4) %arrayidx6.us, align 4, !tbaa !3
  %22 = insertelement <16 x i32> <i32 poison, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, i32 %arrayidx6.promoted.us, i64 0
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %iter.check
  %index = phi i32 [ 0, %iter.check ], [ %index.next, %vector.body ]
  %vec.phi = phi <16 x i32> [ %22, %iter.check ], [ %27, %vector.body ]
  %23 = add nuw nsw i32 %index, %i.021.us
  %24 = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %23
  %wide.load = load <16 x i32>, ptr addrspace(4) %24, align 4, !tbaa !3
  %25 = getelementptr inbounds i32, ptr addrspace(4) %window, i32 %index
  %wide.load25 = load <16 x i32>, ptr addrspace(4) %25, align 4, !tbaa !3
  %26 = mul nsw <16 x i32> %wide.load25, %wide.load
  %27 = add <16 x i32> %26, %vec.phi
  %index.next = add nuw i32 %index, 16
  %28 = icmp eq i32 %index.next, %n.vec
  br i1 %28, label %middle.block, label %vector.body, !llvm.loop !28

middle.block:                                     ; preds = %vector.body
  %29 = tail call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %27)
  br i1 %min.epilog.iters.check.not.not, label %for.body4.us.preheader, label %vec.epilog.ph

vec.epilog.ph:                                    ; preds = %middle.block
  %30 = insertelement <8 x i32> <i32 poison, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, i32 %29, i64 0
  br label %vec.epilog.vector.body

vec.epilog.vector.body:                           ; preds = %vec.epilog.vector.body, %vec.epilog.ph
  %index29 = phi i32 [ %n.vec, %vec.epilog.ph ], [ %index.next33, %vec.epilog.vector.body ]
  %vec.phi30 = phi <8 x i32> [ %30, %vec.epilog.ph ], [ %35, %vec.epilog.vector.body ]
  %31 = add nuw nsw i32 %index29, %i.021.us
  %32 = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %31
  %wide.load31 = load <8 x i32>, ptr addrspace(4) %32, align 4, !tbaa !3
  %33 = getelementptr inbounds i32, ptr addrspace(4) %window, i32 %index29
  %wide.load32 = load <8 x i32>, ptr addrspace(4) %33, align 4, !tbaa !3
  %34 = mul nsw <8 x i32> %wide.load32, %wide.load31
  %35 = add <8 x i32> %34, %vec.phi30
  %index.next33 = add nuw i32 %index29, 8
  %36 = icmp eq i32 %index.next33, %n.vec27
  br i1 %36, label %vec.epilog.middle.block, label %vec.epilog.vector.body, !llvm.loop !27

vec.epilog.middle.block:                          ; preds = %vec.epilog.vector.body
  %37 = tail call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %35)
  br i1 %cmp.n28, label %for.cond.cleanup3.us, label %for.body4.us.preheader

for.body4.us.preheader:                           ; preds = %middle.block, %vec.epilog.middle.block
  %add719.us.ph = phi i32 [ %29, %middle.block ], [ %37, %vec.epilog.middle.block ]
  %w_i.018.us.ph = phi i32 [ %n.vec, %middle.block ], [ %n.vec27, %vec.epilog.middle.block ]
  br label %for.body4.us

for.cond.cleanup:                                 ; preds = %for.cond.cleanup3.us, %middle.block.us, %for.cond.cleanup3.us.us51, %for.cond.cleanup3.us.loopexit.us, %entry
  ret void
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define dso_local void @vekt_conv1d_wrapper(i32 noundef %N_out, i32 noundef %N_in, i32 noundef %W, ptr nocapture noundef %output, ptr nocapture noundef %input, ptr nocapture noundef %window) local_unnamed_addr #4 {
entry:
  ret void
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <16 x i32> @llvm.arc.vvcmpy.lo.acc.w.v512(<16 x i32>, <16 x i32>) #5

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(read)
declare <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4)) #6

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <16 x i32> @llvm.arc.vvcmac.lo.acc.w.v512(<16 x i32>, <16 x i32>, <16 x i32>) #5

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(write)
declare void @llvm.arc.vvst.w.v512(<16 x i32>, ptr addrspace(4)) #7

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32>) #5

; Function Attrs: nofree nounwind
declare noundef i32 @putchar(i32 noundef) local_unnamed_addr #8

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #8

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.add.v16i32(<16 x i32>) #9

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.add.v8i32(<8 x i32>) #9

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: write) "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #1 = { nofree nounwind "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #2 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite) "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #3 = { mustprogress nofree nosync nounwind willreturn "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #4 = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #5 = { mustprogress nocallback nofree nosync nounwind willreturn memory(none) }
attributes #6 = { mustprogress nocallback nofree nosync nounwind willreturn memory(read) }
attributes #7 = { mustprogress nocallback nofree nosync nounwind willreturn memory(write) }
attributes #8 = { nofree nounwind }
attributes #9 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"ArcIntrinsicCheck", i32 28778521}
!1 = !{i32 1, !"wchar_size", i32 2}
!2 = !{!"clang version 17.0.7 (git@gitsnps.internal.synopsys.com:MetaWare/mwdt-llvm-project.git 3cb6cb7579aa39b9c4db2b6a06b7c2eb3174f977)"}
!3 = !{!4, !4, i64 0}
!4 = !{!"int", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C/C++ TBAA"}
!7 = distinct !{!7, !8, !9, !9, !10, !11}
!8 = !{!"llvm.loop.mustprogress"}
!9 = !{!"llvm.loop.unroll.disable"}
!10 = !{!"llvm.loop.isvectorized", i32 1}
!11 = !{!"llvm.loop.unroll.runtime.disable"}
!12 = distinct !{!12, !8, !9, !9, !10, !11}
!13 = distinct !{!13, !8, !9, !9, !10}
!14 = distinct !{!14, !8, !9, !9}
!15 = distinct !{!15, !8, !9, !9, !16, !17}
!16 = !{!"llvm.loop.vectorize.width", i32 1}
!17 = !{!"llvm.loop.vectorize.followup_all", !18}
!18 = distinct !{!18, !8, !9, !9, !19}
!19 = !{!"llvm.loop.isvectorized"}
!20 = distinct !{!20, !8, !9, !9, !16, !21}
!21 = !{!"llvm.loop.vectorize.followup_all", !22}
!22 = distinct !{!22, !8, !9, !9, !19}
!23 = distinct !{!23, !8, !9, !9}
!24 = distinct !{!24, !8, !9, !9}
!25 = distinct !{!25, !8, !9, !9, !10}
!26 = distinct !{!26, !8, !9, !9}
!27 = distinct !{!27, !8, !9, !9, !10, !11}
!28 = distinct !{!28, !8, !9, !9, !10, !11}
