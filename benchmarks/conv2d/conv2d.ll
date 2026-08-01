; ModuleID = 'conv2d.c'
source_filename = "conv2d.c"
target datalayout = "e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-f64:32-v64:32-v128:32-a:0:32-v256:32-v512:32-n8:16:32"
target triple = "arc-pc-unknown-gnu"

@.str.1 = private unnamed_addr constant [44 x i8] c"\09Elemento (%d, %d) di A = %d mentre B = %d\0A\00", align 1
@.str.4 = private unnamed_addr constant [3 x i8] c"\09[\00", align 1
@.str.5 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.6 = private unnamed_addr constant [4 x i8] c"%d,\00", align 1
@str = private unnamed_addr constant [33 x i8] c"SUCCESSO! Le matrici sono uguali\00", align 1
@str.9 = private unnamed_addr constant [38 x i8] c"ERRORE! Le matrici non corrispondono!\00", align 1
@str.10 = private unnamed_addr constant [2 x i8] c"[\00", align 1
@str.11 = private unnamed_addr constant [2 x i8] c"]\00", align 1
@str.12 = private unnamed_addr constant [3 x i8] c"],\00", align 1

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: write)
define dso_local void @init_matrix(ptr nocapture noundef writeonly %a, i32 noundef %M, i32 noundef %N, i32 noundef %value) local_unnamed_addr #0 {
entry:
  %mul = mul nsw i32 %N, %M
  %cmp3 = icmp sgt i32 %mul, 0
  br i1 %cmp3, label %iter.check, label %for.cond.cleanup

iter.check:                                       ; preds = %entry
  %min.iters.check = icmp ult i32 %mul, 8
  br i1 %min.iters.check, label %for.body.preheader, label %vector.main.loop.iter.check

vector.main.loop.iter.check:                      ; preds = %iter.check
  %min.iters.check5 = icmp ult i32 %mul, 64
  br i1 %min.iters.check5, label %vec.epilog.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.main.loop.iter.check
  %n.vec = and i32 %mul, -64
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
  %cmp.n = icmp eq i32 %mul, %n.vec
  br i1 %cmp.n, label %for.cond.cleanup, label %vec.epilog.iter.check

vec.epilog.iter.check:                            ; preds = %middle.block
  %n.vec.remaining = and i32 %mul, 56
  %min.epilog.iters.check = icmp eq i32 %n.vec.remaining, 0
  br i1 %min.epilog.iters.check, label %for.body.preheader, label %vec.epilog.ph

vec.epilog.ph:                                    ; preds = %vector.main.loop.iter.check, %vec.epilog.iter.check
  %vec.epilog.resume.val = phi i32 [ %n.vec, %vec.epilog.iter.check ], [ 0, %vector.main.loop.iter.check ]
  %n.vec13 = and i32 %mul, -8
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
  %cmp.n14 = icmp eq i32 %mul, %n.vec13
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
  %cmp = icmp slt i32 %inc, %mul
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !12
}

; Function Attrs: nofree nounwind
define dso_local void @check_result(ptr nocapture noundef readonly %A, ptr nocapture noundef readonly %B, i32 noundef %M, i32 noundef %N) local_unnamed_addr #1 {
entry:
  %cmp50 = icmp sgt i32 %M, 0
  %cmp248 = icmp sgt i32 %N, 0
  %or.cond = and i1 %cmp50, %cmp248
  br i1 %or.cond, label %for.body4.lr.ph.us.preheader, label %for.end20

for.body4.lr.ph.us.preheader:                     ; preds = %entry
  br label %for.body4.lr.ph.us

for.inc16.us:                                     ; preds = %for.inc.us
  %inc17.us = add nuw nsw i32 %i.051.us, 1
  %cmp.us = icmp slt i32 %inc17.us, %M
  br i1 %cmp.us, label %for.body4.lr.ph.us, label %for.end20, !llvm.loop !13

for.body4.us:                                     ; preds = %for.body4.lr.ph.us, %for.inc.us
  %j.049.us = phi i32 [ 0, %for.body4.lr.ph.us ], [ %inc.us, %for.inc.us ]
  %add.us = add nsw i32 %j.049.us, %mul.us
  %arrayidx.us = getelementptr inbounds i32, ptr %A, i32 %add.us
  %0 = load i32, ptr %arrayidx.us, align 4, !tbaa !3
  %arrayidx7.us = getelementptr inbounds i32, ptr %B, i32 %add.us
  %1 = load i32, ptr %arrayidx7.us, align 4, !tbaa !3
  %cmp8.not.us = icmp eq i32 %0, %1
  br i1 %cmp8.not.us, label %for.inc.us, label %cleanup18

for.inc.us:                                       ; preds = %for.body4.us
  %inc.us = add nuw nsw i32 %j.049.us, 1
  %cmp2.us = icmp slt i32 %inc.us, %N
  br i1 %cmp2.us, label %for.body4.us, label %for.inc16.us, !llvm.loop !14

for.body4.lr.ph.us:                               ; preds = %for.body4.lr.ph.us.preheader, %for.inc16.us
  %i.051.us = phi i32 [ %inc17.us, %for.inc16.us ], [ 0, %for.body4.lr.ph.us.preheader ]
  %mul.us = mul nsw i32 %i.051.us, %N
  br label %for.body4.us

cleanup18:                                        ; preds = %for.body4.us
  %puts41 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.9)
  %2 = load i32, ptr %arrayidx.us, align 4, !tbaa !3
  %3 = load i32, ptr %arrayidx7.us, align 4, !tbaa !3
  %call15 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.1, i32 noundef %i.051.us, i32 noundef %j.049.us, i32 noundef %2, i32 noundef %3)
  br label %return

for.end20:                                        ; preds = %for.inc16.us, %entry
  %puts = tail call i32 @puts(ptr nonnull dereferenceable(1) @str)
  br label %return

return:                                           ; preds = %cleanup18, %for.end20
  ret void
}

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #1

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local ptr @copy_matrix(ptr noundef returned writeonly %dst, ptr nocapture noundef readonly %src, i32 noundef %M, i32 noundef %N) local_unnamed_addr #2 {
entry:
  %cmp22 = icmp sgt i32 %M, 0
  %cmp220 = icmp sgt i32 %N, 0
  %or.cond = and i1 %cmp22, %cmp220
  br i1 %or.cond, label %for.body.lr.ph.split.us, label %for.cond.cleanup

for.body.lr.ph.split.us:                          ; preds = %entry
  %0 = shl i32 %N, 2
  %min.iters.check = icmp ult i32 %N, 8
  %n.vec = and i32 %N, -64
  %cmp.n = icmp eq i32 %n.vec, %N
  %n.vec.remaining = and i32 %N, 56
  %min.epilog.iters.check = icmp eq i32 %n.vec.remaining, 0
  %n.vec34 = and i32 %N, -8
  %cmp.n35 = icmp eq i32 %n.vec34, %N
  br i1 %min.iters.check, label %iter.check.us.preheader, label %for.body.lr.ph.split.us.split

iter.check.us.preheader:                          ; preds = %for.body.lr.ph.split.us
  br label %iter.check.us

iter.check.us:                                    ; preds = %iter.check.us.preheader, %for.cond.cleanup3.us.loopexit.us
  %i.023.us.us = phi i32 [ %inc9.us.us, %for.cond.cleanup3.us.loopexit.us ], [ 0, %iter.check.us.preheader ]
  %mul.us.us = mul nsw i32 %i.023.us.us, %N
  br label %for.body4.us.us

for.body4.us.us:                                  ; preds = %iter.check.us, %for.body4.us.us
  %j.021.us.us = phi i32 [ 0, %iter.check.us ], [ %inc.us.us, %for.body4.us.us ]
  %add.us.us = add nsw i32 %j.021.us.us, %mul.us.us
  %arrayidx.us.us = getelementptr inbounds i32, ptr %src, i32 %add.us.us
  %1 = load i32, ptr %arrayidx.us.us, align 4, !tbaa !3
  %arrayidx7.us.us = getelementptr inbounds i32, ptr %dst, i32 %add.us.us
  store i32 %1, ptr %arrayidx7.us.us, align 4, !tbaa !3
  %inc.us.us = add nuw nsw i32 %j.021.us.us, 1
  %cmp2.us.us = icmp slt i32 %inc.us.us, %N
  br i1 %cmp2.us.us, label %for.body4.us.us, label %for.cond.cleanup3.us.loopexit.us, !llvm.loop !15

for.cond.cleanup3.us.loopexit.us:                 ; preds = %for.body4.us.us
  %inc9.us.us = add nuw nsw i32 %i.023.us.us, 1
  %cmp.us.us = icmp slt i32 %inc9.us.us, %M
  br i1 %cmp.us.us, label %iter.check.us, label %for.cond.cleanup, !llvm.loop !16

for.body.lr.ph.split.us.split:                    ; preds = %for.body.lr.ph.split.us
  %min.iters.check29 = icmp ult i32 %N, 64
  br i1 %min.iters.check29, label %iter.check.us39.preheader, label %for.body.lr.ph.split.us.split.split

iter.check.us39.preheader:                        ; preds = %for.body.lr.ph.split.us.split
  br label %iter.check.us39

iter.check.us39:                                  ; preds = %iter.check.us39.preheader, %for.cond.cleanup3.us.us49
  %i.023.us.us40 = phi i32 [ %inc9.us.us50, %for.cond.cleanup3.us.us49 ], [ 0, %iter.check.us39.preheader ]
  %mul.us.us41 = mul nsw i32 %i.023.us.us40, %N
  %2 = mul i32 %0, %i.023.us.us40
  %3 = add i32 %0, %2
  %scevgep28.us = getelementptr i8, ptr %src, i32 %3
  %scevgep27.us = getelementptr i8, ptr %src, i32 %2
  %scevgep26.us = getelementptr i8, ptr %dst, i32 %3
  %scevgep.us = getelementptr i8, ptr %dst, i32 %2
  %bound0.us = icmp ult ptr %scevgep.us, %scevgep28.us
  %bound1.us = icmp ult ptr %scevgep27.us, %scevgep26.us
  %found.conflict.us = and i1 %bound0.us, %bound1.us
  br i1 %found.conflict.us, label %for.body4.us.us42.preheader, label %vec.epilog.vector.body.us.preheader

vec.epilog.vector.body.us.preheader:              ; preds = %iter.check.us39
  br label %vec.epilog.vector.body.us

for.body4.us.us42.preheader:                      ; preds = %vec.epilog.middle.block.us, %iter.check.us39
  %j.021.us.us43.ph = phi i32 [ 0, %iter.check.us39 ], [ %n.vec34, %vec.epilog.middle.block.us ]
  br label %for.body4.us.us42

for.body4.us.us42:                                ; preds = %for.body4.us.us42.preheader, %for.body4.us.us42
  %j.021.us.us43 = phi i32 [ %inc.us.us47, %for.body4.us.us42 ], [ %j.021.us.us43.ph, %for.body4.us.us42.preheader ]
  %add.us.us44 = add nsw i32 %j.021.us.us43, %mul.us.us41
  %arrayidx.us.us45 = getelementptr inbounds i32, ptr %src, i32 %add.us.us44
  %4 = load i32, ptr %arrayidx.us.us45, align 4, !tbaa !3
  %arrayidx7.us.us46 = getelementptr inbounds i32, ptr %dst, i32 %add.us.us44
  store i32 %4, ptr %arrayidx7.us.us46, align 4, !tbaa !3
  %inc.us.us47 = add nuw nsw i32 %j.021.us.us43, 1
  %cmp2.us.us48 = icmp slt i32 %inc.us.us47, %N
  br i1 %cmp2.us.us48, label %for.body4.us.us42, label %for.cond.cleanup3.us.us49, !llvm.loop !15

for.cond.cleanup3.us.us49:                        ; preds = %for.body4.us.us42, %vec.epilog.middle.block.us
  %inc9.us.us50 = add nuw nsw i32 %i.023.us.us40, 1
  %cmp.us.us51 = icmp slt i32 %inc9.us.us50, %M
  br i1 %cmp.us.us51, label %iter.check.us39, label %for.cond.cleanup, !llvm.loop !16

vec.epilog.middle.block.us:                       ; preds = %vec.epilog.vector.body.us
  br i1 %cmp.n35, label %for.cond.cleanup3.us.us49, label %for.body4.us.us42.preheader

vec.epilog.vector.body.us:                        ; preds = %vec.epilog.vector.body.us.preheader, %vec.epilog.vector.body.us
  %index36.us = phi i32 [ %index.next38.us, %vec.epilog.vector.body.us ], [ 0, %vec.epilog.vector.body.us.preheader ]
  %5 = add nsw i32 %index36.us, %mul.us.us41
  %6 = getelementptr inbounds i32, ptr %src, i32 %5
  %wide.load37.us = load <8 x i32>, ptr %6, align 4, !tbaa !3, !alias.scope !17
  %7 = getelementptr inbounds i32, ptr %dst, i32 %5
  store <8 x i32> %wide.load37.us, ptr %7, align 4, !tbaa !3, !alias.scope !20, !noalias !17
  %index.next38.us = add nuw i32 %index36.us, 8
  %8 = icmp eq i32 %index.next38.us, %n.vec34
  br i1 %8, label %vec.epilog.middle.block.us, label %vec.epilog.vector.body.us, !llvm.loop !22

for.body.lr.ph.split.us.split.split:              ; preds = %for.body.lr.ph.split.us.split
  br i1 %cmp.n, label %iter.check.us55.preheader, label %iter.check.preheader

iter.check.preheader:                             ; preds = %for.body.lr.ph.split.us.split.split
  br label %iter.check

iter.check.us55.preheader:                        ; preds = %for.body.lr.ph.split.us.split.split
  br label %iter.check.us55

iter.check.us55:                                  ; preds = %iter.check.us55.preheader, %for.cond.cleanup3.us.us65
  %i.023.us.us56 = phi i32 [ %inc9.us.us66, %for.cond.cleanup3.us.us65 ], [ 0, %iter.check.us55.preheader ]
  %mul.us.us57 = mul nsw i32 %i.023.us.us56, %N
  %9 = mul i32 %0, %i.023.us.us56
  %10 = add i32 %0, %9
  %scevgep28.us70 = getelementptr i8, ptr %src, i32 %10
  %scevgep27.us71 = getelementptr i8, ptr %src, i32 %9
  %scevgep26.us72 = getelementptr i8, ptr %dst, i32 %10
  %scevgep.us73 = getelementptr i8, ptr %dst, i32 %9
  %bound0.us74 = icmp ult ptr %scevgep.us73, %scevgep28.us70
  %bound1.us75 = icmp ult ptr %scevgep27.us71, %scevgep26.us72
  %found.conflict.us76 = and i1 %bound0.us74, %bound1.us75
  br i1 %found.conflict.us76, label %for.body4.us.us58.preheader, label %vector.body.us.preheader

vector.body.us.preheader:                         ; preds = %iter.check.us55
  br label %vector.body.us

for.body4.us.us58.preheader:                      ; preds = %iter.check.us55
  br label %for.body4.us.us58

for.body4.us.us58:                                ; preds = %for.body4.us.us58.preheader, %for.body4.us.us58
  %j.021.us.us59 = phi i32 [ %inc.us.us63, %for.body4.us.us58 ], [ 0, %for.body4.us.us58.preheader ]
  %add.us.us60 = add nsw i32 %j.021.us.us59, %mul.us.us57
  %arrayidx.us.us61 = getelementptr inbounds i32, ptr %src, i32 %add.us.us60
  %11 = load i32, ptr %arrayidx.us.us61, align 4, !tbaa !3
  %arrayidx7.us.us62 = getelementptr inbounds i32, ptr %dst, i32 %add.us.us60
  store i32 %11, ptr %arrayidx7.us.us62, align 4, !tbaa !3
  %inc.us.us63 = add nuw nsw i32 %j.021.us.us59, 1
  %cmp2.us.us64 = icmp slt i32 %inc.us.us63, %N
  br i1 %cmp2.us.us64, label %for.body4.us.us58, label %for.cond.cleanup3.us.us65, !llvm.loop !15

for.cond.cleanup3.us.us65:                        ; preds = %vector.body.us, %for.body4.us.us58
  %inc9.us.us66 = add nuw nsw i32 %i.023.us.us56, 1
  %cmp.us.us67 = icmp slt i32 %inc9.us.us66, %M
  br i1 %cmp.us.us67, label %iter.check.us55, label %for.cond.cleanup, !llvm.loop !16

vector.body.us:                                   ; preds = %vector.body.us.preheader, %vector.body.us
  %index.us = phi i32 [ %index.next.us, %vector.body.us ], [ 0, %vector.body.us.preheader ]
  %12 = add nsw i32 %index.us, %mul.us.us57
  %13 = getelementptr inbounds i32, ptr %src, i32 %12
  %wide.load.us = load <16 x i32>, ptr %13, align 4, !tbaa !3, !alias.scope !23
  %14 = getelementptr inbounds i32, ptr %13, i32 16
  %wide.load30.us = load <16 x i32>, ptr %14, align 4, !tbaa !3, !alias.scope !23
  %15 = getelementptr inbounds i32, ptr %13, i32 32
  %wide.load31.us = load <16 x i32>, ptr %15, align 4, !tbaa !3, !alias.scope !23
  %16 = getelementptr inbounds i32, ptr %13, i32 48
  %wide.load32.us = load <16 x i32>, ptr %16, align 4, !tbaa !3, !alias.scope !23
  %17 = getelementptr inbounds i32, ptr %dst, i32 %12
  store <16 x i32> %wide.load.us, ptr %17, align 4, !tbaa !3, !alias.scope !26, !noalias !23
  %18 = getelementptr inbounds i32, ptr %17, i32 16
  store <16 x i32> %wide.load30.us, ptr %18, align 4, !tbaa !3, !alias.scope !26, !noalias !23
  %19 = getelementptr inbounds i32, ptr %17, i32 32
  store <16 x i32> %wide.load31.us, ptr %19, align 4, !tbaa !3, !alias.scope !26, !noalias !23
  %20 = getelementptr inbounds i32, ptr %17, i32 48
  store <16 x i32> %wide.load32.us, ptr %20, align 4, !tbaa !3, !alias.scope !26, !noalias !23
  %index.next.us = add nuw i32 %index.us, 64
  %21 = icmp eq i32 %index.next.us, %N
  br i1 %21, label %for.cond.cleanup3.us.us65, label %vector.body.us, !llvm.loop !28

for.cond.cleanup3.us:                             ; preds = %for.body4.us, %vec.epilog.middle.block
  %inc9.us = add nuw nsw i32 %i.023.us, 1
  %cmp.us = icmp slt i32 %inc9.us, %M
  br i1 %cmp.us, label %iter.check, label %for.cond.cleanup, !llvm.loop !16

for.body4.us:                                     ; preds = %for.body4.us.preheader, %for.body4.us
  %j.021.us = phi i32 [ %inc.us, %for.body4.us ], [ %j.021.us.ph, %for.body4.us.preheader ]
  %add.us = add nsw i32 %j.021.us, %mul.us
  %arrayidx.us = getelementptr inbounds i32, ptr %src, i32 %add.us
  %22 = load i32, ptr %arrayidx.us, align 4, !tbaa !3
  %arrayidx7.us = getelementptr inbounds i32, ptr %dst, i32 %add.us
  store i32 %22, ptr %arrayidx7.us, align 4, !tbaa !3
  %inc.us = add nuw nsw i32 %j.021.us, 1
  %cmp2.us = icmp slt i32 %inc.us, %N
  br i1 %cmp2.us, label %for.body4.us, label %for.cond.cleanup3.us, !llvm.loop !15

iter.check:                                       ; preds = %iter.check.preheader, %for.cond.cleanup3.us
  %i.023.us = phi i32 [ %inc9.us, %for.cond.cleanup3.us ], [ 0, %iter.check.preheader ]
  %mul.us = mul nsw i32 %i.023.us, %N
  %23 = mul i32 %0, %i.023.us
  %24 = add i32 %0, %23
  %scevgep28 = getelementptr i8, ptr %src, i32 %24
  %scevgep27 = getelementptr i8, ptr %src, i32 %23
  %scevgep26 = getelementptr i8, ptr %dst, i32 %24
  %scevgep = getelementptr i8, ptr %dst, i32 %23
  %bound0 = icmp ult ptr %scevgep, %scevgep28
  %bound1 = icmp ult ptr %scevgep27, %scevgep26
  %found.conflict = and i1 %bound0, %bound1
  br i1 %found.conflict, label %for.body4.us.preheader, label %vector.body.preheader

vector.body.preheader:                            ; preds = %iter.check
  br label %vector.body

vector.body:                                      ; preds = %vector.body.preheader, %vector.body
  %index = phi i32 [ %index.next, %vector.body ], [ 0, %vector.body.preheader ]
  %25 = add nsw i32 %index, %mul.us
  %26 = getelementptr inbounds i32, ptr %src, i32 %25
  %wide.load = load <16 x i32>, ptr %26, align 4, !tbaa !3, !alias.scope !23
  %27 = getelementptr inbounds i32, ptr %26, i32 16
  %wide.load30 = load <16 x i32>, ptr %27, align 4, !tbaa !3, !alias.scope !23
  %28 = getelementptr inbounds i32, ptr %26, i32 32
  %wide.load31 = load <16 x i32>, ptr %28, align 4, !tbaa !3, !alias.scope !23
  %29 = getelementptr inbounds i32, ptr %26, i32 48
  %wide.load32 = load <16 x i32>, ptr %29, align 4, !tbaa !3, !alias.scope !23
  %30 = getelementptr inbounds i32, ptr %dst, i32 %25
  store <16 x i32> %wide.load, ptr %30, align 4, !tbaa !3, !alias.scope !26, !noalias !23
  %31 = getelementptr inbounds i32, ptr %30, i32 16
  store <16 x i32> %wide.load30, ptr %31, align 4, !tbaa !3, !alias.scope !26, !noalias !23
  %32 = getelementptr inbounds i32, ptr %30, i32 32
  store <16 x i32> %wide.load31, ptr %32, align 4, !tbaa !3, !alias.scope !26, !noalias !23
  %33 = getelementptr inbounds i32, ptr %30, i32 48
  store <16 x i32> %wide.load32, ptr %33, align 4, !tbaa !3, !alias.scope !26, !noalias !23
  %index.next = add nuw i32 %index, 64
  %34 = icmp eq i32 %index.next, %n.vec
  br i1 %34, label %vec.epilog.iter.check, label %vector.body, !llvm.loop !28

vec.epilog.iter.check:                            ; preds = %vector.body
  br i1 %min.epilog.iters.check, label %for.body4.us.preheader, label %vec.epilog.vector.body.preheader

vec.epilog.vector.body.preheader:                 ; preds = %vec.epilog.iter.check
  br label %vec.epilog.vector.body

vec.epilog.vector.body:                           ; preds = %vec.epilog.vector.body.preheader, %vec.epilog.vector.body
  %index36 = phi i32 [ %index.next38, %vec.epilog.vector.body ], [ %n.vec, %vec.epilog.vector.body.preheader ]
  %35 = add nsw i32 %index36, %mul.us
  %36 = getelementptr inbounds i32, ptr %src, i32 %35
  %wide.load37 = load <8 x i32>, ptr %36, align 4, !tbaa !3, !alias.scope !17
  %37 = getelementptr inbounds i32, ptr %dst, i32 %35
  store <8 x i32> %wide.load37, ptr %37, align 4, !tbaa !3, !alias.scope !20, !noalias !17
  %index.next38 = add nuw i32 %index36, 8
  %38 = icmp eq i32 %index.next38, %n.vec34
  br i1 %38, label %vec.epilog.middle.block, label %vec.epilog.vector.body, !llvm.loop !22

vec.epilog.middle.block:                          ; preds = %vec.epilog.vector.body
  br i1 %cmp.n35, label %for.cond.cleanup3.us, label %for.body4.us.preheader

for.body4.us.preheader:                           ; preds = %iter.check, %vec.epilog.iter.check, %vec.epilog.middle.block
  %j.021.us.ph = phi i32 [ 0, %iter.check ], [ %n.vec, %vec.epilog.iter.check ], [ %n.vec34, %vec.epilog.middle.block ]
  br label %for.body4.us

for.cond.cleanup:                                 ; preds = %for.cond.cleanup3.us, %for.cond.cleanup3.us.us65, %for.cond.cleanup3.us.us49, %for.cond.cleanup3.us.loopexit.us, %entry
  ret ptr %dst
}

; Function Attrs: nofree nounwind
define dso_local void @print_matrix(ptr nocapture noundef readonly %A, i32 noundef %M, i32 noundef %N) local_unnamed_addr #1 {
entry:
  %puts = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.10)
  %cmp28 = icmp sgt i32 %M, 0
  br i1 %cmp28, label %for.body.lr.ph, label %for.cond.cleanup

for.body.lr.ph:                                   ; preds = %entry
  %cmp326 = icmp sgt i32 %N, 0
  %sub = add nsw i32 %N, -1
  br i1 %cmp326, label %for.body5.lr.ph.us.preheader, label %for.cond.cleanup4.preheader

for.cond.cleanup4.preheader:                      ; preds = %for.body.lr.ph
  br label %for.cond.cleanup4

for.body5.lr.ph.us.preheader:                     ; preds = %for.body.lr.ph
  br label %for.body5.lr.ph.us

for.cond.cleanup4.us:                             ; preds = %for.inc.us
  %puts25.us = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.12)
  %inc14.us = add nuw nsw i32 %i.029.us, 1
  %cmp.us = icmp slt i32 %inc14.us, %M
  br i1 %cmp.us, label %for.body5.lr.ph.us, label %for.cond.cleanup, !llvm.loop !29

for.body5.us:                                     ; preds = %for.body5.lr.ph.us, %for.inc.us
  %j.027.us = phi i32 [ 0, %for.body5.lr.ph.us ], [ %inc.us, %for.inc.us ]
  %cmp6.us = icmp eq i32 %j.027.us, %sub
  %add.us = add nsw i32 %j.027.us, %mul.us
  %arrayidx.us = getelementptr inbounds i32, ptr %A, i32 %add.us
  %0 = load i32, ptr %arrayidx.us, align 4, !tbaa !3
  br i1 %cmp6.us, label %if.then.us, label %if.else.us

if.else.us:                                       ; preds = %for.body5.us
  %call11.us = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.6, i32 noundef %0)
  br label %for.inc.us

if.then.us:                                       ; preds = %for.body5.us
  %call7.us = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, i32 noundef %0)
  br label %for.inc.us

for.inc.us:                                       ; preds = %if.then.us, %if.else.us
  %inc.us = add nuw nsw i32 %j.027.us, 1
  %cmp3.us = icmp slt i32 %inc.us, %N
  br i1 %cmp3.us, label %for.body5.us, label %for.cond.cleanup4.us, !llvm.loop !30

for.body5.lr.ph.us:                               ; preds = %for.body5.lr.ph.us.preheader, %for.cond.cleanup4.us
  %i.029.us = phi i32 [ %inc14.us, %for.cond.cleanup4.us ], [ 0, %for.body5.lr.ph.us.preheader ]
  %call1.us = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.4)
  %mul.us = mul nsw i32 %i.029.us, %N
  br label %for.body5.us

for.cond.cleanup:                                 ; preds = %for.cond.cleanup4, %for.cond.cleanup4.us, %entry
  %puts24 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.11)
  ret void

for.cond.cleanup4:                                ; preds = %for.cond.cleanup4.preheader, %for.cond.cleanup4
  %i.029 = phi i32 [ %inc14, %for.cond.cleanup4 ], [ 0, %for.cond.cleanup4.preheader ]
  %call1 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.4)
  %puts25 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.12)
  %inc14 = add nuw nsw i32 %i.029, 1
  %cmp = icmp slt i32 %inc14, %M
  br i1 %cmp, label %for.cond.cleanup4, label %for.cond.cleanup, !llvm.loop !29
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @conv2d(i32 noundef %rows_out, i32 noundef %cols_out, i32 noundef %rows_in, i32 noundef %cols_in, i32 noundef %K, ptr nocapture noundef %output, ptr nocapture noundef readonly %input, ptr nocapture noundef readonly %kernel) local_unnamed_addr #2 {
entry:
  %cmp63 = icmp sgt i32 %rows_out, 0
  %cmp253 = icmp sgt i32 %cols_out, 0
  %or.cond = and i1 %cmp63, %cmp253
  %cmp650 = icmp sgt i32 %K, 0
  %or.cond88 = and i1 %or.cond, %cmp650
  br i1 %or.cond88, label %for.body4.lr.ph.split.us.split.us.us.us.us.preheader, label %for.cond.cleanup

for.body4.lr.ph.split.us.split.us.us.us.us.preheader: ; preds = %entry
  br label %for.body4.lr.ph.split.us.split.us.us.us.us

for.cond.cleanup3.us.us.us:                       ; preds = %for.cond.cleanup7.us.us.us.us.us
  %inc30.us.us.us = add nuw nsw i32 %i.064.us.us.us, 1
  %cmp.us.us.us = icmp slt i32 %inc30.us.us.us, %rows_out
  br i1 %cmp.us.us.us, label %for.body4.lr.ph.split.us.split.us.us.us.us, label %for.cond.cleanup, !llvm.loop !31

for.body4.lr.ph.split.us.split.us.us.us.us:       ; preds = %for.body4.lr.ph.split.us.split.us.us.us.us.preheader, %for.cond.cleanup3.us.us.us
  %i.064.us.us.us = phi i32 [ %inc30.us.us.us, %for.cond.cleanup3.us.us.us ], [ 0, %for.body4.lr.ph.split.us.split.us.us.us.us.preheader ]
  %mul19.us.us.us = mul nsw i32 %i.064.us.us.us, %cols_out
  br label %for.body8.lr.ph.split.us.us.us.us.us.us

for.cond.cleanup7.us.us.us.us.us:                 ; preds = %for.cond.cleanup11.us.us.us.us.us.us
  %inc27.us.us.us.us.us = add nuw nsw i32 %j.054.us.us.us.us.us, 1
  %cmp2.us.us.us.us.us = icmp slt i32 %inc27.us.us.us.us.us, %cols_out
  br i1 %cmp2.us.us.us.us.us, label %for.body8.lr.ph.split.us.us.us.us.us.us, label %for.cond.cleanup3.us.us.us, !llvm.loop !36

for.body8.lr.ph.split.us.us.us.us.us.us:          ; preds = %for.cond.cleanup7.us.us.us.us.us, %for.body4.lr.ph.split.us.split.us.us.us.us
  %j.054.us.us.us.us.us = phi i32 [ 0, %for.body4.lr.ph.split.us.split.us.us.us.us ], [ %inc27.us.us.us.us.us, %for.cond.cleanup7.us.us.us.us.us ]
  %add20.us.us.us.us.us = add nsw i32 %j.054.us.us.us.us.us, %mul19.us.us.us
  %arrayidx21.us.us.us.us.us = getelementptr inbounds i32, ptr %output, i32 %add20.us.us.us.us.us
  %arrayidx21.promoted.us.us.us.us.us = load i32, ptr %arrayidx21.us.us.us.us.us, align 4, !tbaa !3
  br label %for.body12.lr.ph.us.us.us.us.us.us

for.cond.cleanup11.us.us.us.us.us.us:             ; preds = %for.body12.us.us.us.us.us.us
  %inc24.us.us.us.us.us.us = add nuw nsw i32 %k_i.051.us.us.us.us.us.us, 1
  %cmp6.us.us.us.us.us.us = icmp slt i32 %inc24.us.us.us.us.us.us, %K
  br i1 %cmp6.us.us.us.us.us.us, label %for.body12.lr.ph.us.us.us.us.us.us, label %for.cond.cleanup7.us.us.us.us.us, !llvm.loop !39

for.body12.us.us.us.us.us.us:                     ; preds = %for.body12.lr.ph.us.us.us.us.us.us, %for.body12.us.us.us.us.us.us
  %add2249.us.us.us.us.us.us = phi i32 [ %arrayidx21.promoted.us52.us.us.us.us.us, %for.body12.lr.ph.us.us.us.us.us.us ], [ %add22.us.us.us.us.us.us, %for.body12.us.us.us.us.us.us ]
  %k_j.048.us.us.us.us.us.us = phi i32 [ 0, %for.body12.lr.ph.us.us.us.us.us.us ], [ %inc.us.us.us.us.us.us, %for.body12.us.us.us.us.us.us ]
  %add14.us.us.us.us.us.us = add i32 %add13.us.us.us.us.us.us, %k_j.048.us.us.us.us.us.us
  %arrayidx.us.us.us.us.us.us = getelementptr inbounds i32, ptr %input, i32 %add14.us.us.us.us.us.us
  %0 = load i32, ptr %arrayidx.us.us.us.us.us.us, align 4, !tbaa !3
  %add16.us.us.us.us.us.us = add nsw i32 %k_j.048.us.us.us.us.us.us, %mul15.us.us.us.us.us.us
  %arrayidx17.us.us.us.us.us.us = getelementptr inbounds i32, ptr %kernel, i32 %add16.us.us.us.us.us.us
  %1 = load i32, ptr %arrayidx17.us.us.us.us.us.us, align 4, !tbaa !3
  %mul18.us.us.us.us.us.us = mul nsw i32 %1, %0
  %add22.us.us.us.us.us.us = add nsw i32 %mul18.us.us.us.us.us.us, %add2249.us.us.us.us.us.us
  store i32 %add22.us.us.us.us.us.us, ptr %arrayidx21.us.us.us.us.us, align 4, !tbaa !3
  %inc.us.us.us.us.us.us = add nuw nsw i32 %k_j.048.us.us.us.us.us.us, 1
  %cmp10.us.us.us.us.us.us = icmp slt i32 %inc.us.us.us.us.us.us, %K
  br i1 %cmp10.us.us.us.us.us.us, label %for.body12.us.us.us.us.us.us, label %for.cond.cleanup11.us.us.us.us.us.us, !llvm.loop !42

for.body12.lr.ph.us.us.us.us.us.us:               ; preds = %for.body8.lr.ph.split.us.us.us.us.us.us, %for.cond.cleanup11.us.us.us.us.us.us
  %arrayidx21.promoted.us52.us.us.us.us.us = phi i32 [ %arrayidx21.promoted.us.us.us.us.us, %for.body8.lr.ph.split.us.us.us.us.us.us ], [ %add22.us.us.us.us.us.us, %for.cond.cleanup11.us.us.us.us.us.us ]
  %k_i.051.us.us.us.us.us.us = phi i32 [ 0, %for.body8.lr.ph.split.us.us.us.us.us.us ], [ %inc24.us.us.us.us.us.us, %for.cond.cleanup11.us.us.us.us.us.us ]
  %add.us.us.us.us.us.us = add nuw nsw i32 %k_i.051.us.us.us.us.us.us, %i.064.us.us.us
  %mul.us.us.us.us.us.us = mul nsw i32 %add.us.us.us.us.us.us, %cols_in
  %add13.us.us.us.us.us.us = add i32 %mul.us.us.us.us.us.us, %j.054.us.us.us.us.us
  %mul15.us.us.us.us.us.us = mul nsw i32 %k_i.051.us.us.us.us.us.us, %K
  br label %for.body12.us.us.us.us.us.us

for.cond.cleanup:                                 ; preds = %for.cond.cleanup3.us.us.us, %entry
  ret void
}

; Function Attrs: mustprogress nofree nosync nounwind willreturn
define dso_local void @vectorized_conv2d(i32 noundef %rows_out, i32 noundef %cols_out, i32 noundef %rows_in, i32 noundef %cols_in, i32 noundef %K, ptr addrspace(4) noalias noundef %output, ptr addrspace(4) noalias noundef %input, ptr addrspace(4) noalias nocapture noundef readonly %kernel) local_unnamed_addr #3 {
entry:
  %div = sdiv i32 %cols_out, 16
  %mul = shl nsw i32 %div, 4
  %cmp149 = icmp sgt i32 %rows_out, 0
  br i1 %cmp149, label %for.body.lr.ph, label %for.cond.cleanup44

for.body.lr.ph:                                   ; preds = %entry
  %cmp2137 = icmp sgt i32 %cols_out, 15
  br i1 %cmp2137, label %for.body.lr.ph.split.us, label %for.body45.lr.ph

for.body.lr.ph.split.us:                          ; preds = %for.body.lr.ph
  %cmp8133 = icmp sgt i32 %K, 0
  br i1 %cmp8133, label %for.body4.lr.ph.split.us.split.us.us.us.us.preheader, label %for.body4.lr.ph.split.us161.preheader

for.body4.lr.ph.split.us161.preheader:            ; preds = %for.body.lr.ph.split.us
  br label %for.body4.lr.ph.split.us161

for.body4.lr.ph.split.us.split.us.us.us.us.preheader: ; preds = %for.body.lr.ph.split.us
  br label %for.body4.lr.ph.split.us.split.us.us.us.us

for.cond.cleanup3.us.us.us:                       ; preds = %for.cond.cleanup9.us.us.us.us.us
  %inc39.us.us.us = add nuw nsw i32 %i.0150.us.us.us, 1
  %cmp.us.us.us = icmp slt i32 %inc39.us.us.us, %rows_out
  br i1 %cmp.us.us.us, label %for.body4.lr.ph.split.us.split.us.us.us.us, label %for.cond.cleanup, !llvm.loop !45

for.body4.lr.ph.split.us.split.us.us.us.us:       ; preds = %for.body4.lr.ph.split.us.split.us.us.us.us.preheader, %for.cond.cleanup3.us.us.us
  %i.0150.us.us.us = phi i32 [ %inc39.us.us.us, %for.cond.cleanup3.us.us.us ], [ 0, %for.body4.lr.ph.split.us.split.us.us.us.us.preheader ]
  %mul5.us.us.us = mul nsw i32 %i.0150.us.us.us, %cols_out
  br label %for.body10.lr.ph.split.us.us.us.us.us.us

for.cond.cleanup9.us.us.us.us.us:                 ; preds = %for.cond.cleanup13.us.us.us.us.us.us
  %0 = tail call <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32> %5)
  tail call void @llvm.arc.vvst.w.v512(<16 x i32> %0, ptr addrspace(4) %arrayidx.us.us.us.us.us)
  %add36.us.us.us.us.us = add nuw nsw i32 %j_vec.0138.us.us.us.us.us, 16
  %cmp2.us.us.us.us.us = icmp slt i32 %add36.us.us.us.us.us, %mul
  br i1 %cmp2.us.us.us.us.us, label %for.body10.lr.ph.split.us.us.us.us.us.us, label %for.cond.cleanup3.us.us.us, !llvm.loop !46

for.body10.lr.ph.split.us.us.us.us.us.us:         ; preds = %for.cond.cleanup9.us.us.us.us.us, %for.body4.lr.ph.split.us.split.us.us.us.us
  %j_vec.0138.us.us.us.us.us = phi i32 [ 0, %for.body4.lr.ph.split.us.split.us.us.us.us ], [ %add36.us.us.us.us.us, %for.cond.cleanup9.us.us.us.us.us ]
  %add.us.us.us.us.us = add nsw i32 %j_vec.0138.us.us.us.us.us, %mul5.us.us.us
  %arrayidx.us.us.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %output, i32 %add.us.us.us.us.us
  %1 = tail call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %arrayidx.us.us.us.us.us)
  %2 = tail call <16 x i32> @llvm.arc.vvcadd.init.acc.w.v512(<16 x i32> %1, <16 x i32> zeroinitializer)
  br label %for.body14.lr.ph.us.us.us.us.us.us

for.cond.cleanup13.us.us.us.us.us.us:             ; preds = %for.body14.us.us.us.us.us.us
  %inc28.us.us.us.us.us.us = add nuw nsw i32 %k_i.0135.us.us.us.us.us.us, 1
  %cmp8.us.us.us.us.us.us = icmp slt i32 %inc28.us.us.us.us.us.us, %K
  br i1 %cmp8.us.us.us.us.us.us, label %for.body14.lr.ph.us.us.us.us.us.us, label %for.cond.cleanup9.us.us.us.us.us, !llvm.loop !47

for.body14.us.us.us.us.us.us:                     ; preds = %for.body14.lr.ph.us.us.us.us.us.us, %for.body14.us.us.us.us.us.us
  %k_j.0132.us.us.us.us.us.us = phi i32 [ 0, %for.body14.lr.ph.us.us.us.us.us.us ], [ %inc.us.us.us.us.us.us, %for.body14.us.us.us.us.us.us ]
  %conv2d_acc.sroa.0.1131.us.us.us.us.us.us = phi <16 x i32> [ %conv2d_acc.sroa.0.0134.us.us.us.us.us.us, %for.body14.lr.ph.us.us.us.us.us.us ], [ %5, %for.body14.us.us.us.us.us.us ]
  %add16.us.us.us.us.us.us = add nsw i32 %k_j.0132.us.us.us.us.us.us, %mul15.us.us.us.us.us.us
  %arrayidx17.us.us.us.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %kernel, i32 %add16.us.us.us.us.us.us
  %3 = load i32, ptr addrspace(4) %arrayidx17.us.us.us.us.us.us, align 4, !tbaa !3
  %add21.us.us.us.us.us.us = add i32 %add20.us.us.us.us.us.us, %k_j.0132.us.us.us.us.us.us
  %arrayidx22.us.us.us.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %add21.us.us.us.us.us.us
  %4 = tail call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %arrayidx22.us.us.us.us.us.us)
  %splat.splatinsert.us.us.us.us.us.us = insertelement <16 x i32> poison, i32 %3, i64 0
  %splat.splat.us.us.us.us.us.us = shufflevector <16 x i32> %splat.splatinsert.us.us.us.us.us.us, <16 x i32> poison, <16 x i32> zeroinitializer
  %5 = tail call <16 x i32> @llvm.arc.vvcmac.lo.acc.w.v512(<16 x i32> %conv2d_acc.sroa.0.1131.us.us.us.us.us.us, <16 x i32> %4, <16 x i32> %splat.splat.us.us.us.us.us.us)
  %inc.us.us.us.us.us.us = add nuw nsw i32 %k_j.0132.us.us.us.us.us.us, 1
  %cmp12.us.us.us.us.us.us = icmp slt i32 %inc.us.us.us.us.us.us, %K
  br i1 %cmp12.us.us.us.us.us.us, label %for.body14.us.us.us.us.us.us, label %for.cond.cleanup13.us.us.us.us.us.us, !llvm.loop !48

for.body14.lr.ph.us.us.us.us.us.us:               ; preds = %for.body10.lr.ph.split.us.us.us.us.us.us, %for.cond.cleanup13.us.us.us.us.us.us
  %k_i.0135.us.us.us.us.us.us = phi i32 [ 0, %for.body10.lr.ph.split.us.us.us.us.us.us ], [ %inc28.us.us.us.us.us.us, %for.cond.cleanup13.us.us.us.us.us.us ]
  %conv2d_acc.sroa.0.0134.us.us.us.us.us.us = phi <16 x i32> [ %2, %for.body10.lr.ph.split.us.us.us.us.us.us ], [ %5, %for.cond.cleanup13.us.us.us.us.us.us ]
  %mul15.us.us.us.us.us.us = mul nsw i32 %k_i.0135.us.us.us.us.us.us, %K
  %add18.us.us.us.us.us.us = add nuw nsw i32 %k_i.0135.us.us.us.us.us.us, %i.0150.us.us.us
  %mul19.us.us.us.us.us.us = mul nsw i32 %add18.us.us.us.us.us.us, %cols_in
  %add20.us.us.us.us.us.us = add i32 %mul19.us.us.us.us.us.us, %j_vec.0138.us.us.us.us.us
  br label %for.body14.us.us.us.us.us.us

for.cond.cleanup3.us:                             ; preds = %for.cond.cleanup9.us157
  %inc39.us = add nuw nsw i32 %i.0150.us, 1
  %cmp.us = icmp slt i32 %inc39.us, %rows_out
  br i1 %cmp.us, label %for.body4.lr.ph.split.us161, label %for.cond.cleanup, !llvm.loop !45

for.cond.cleanup9.us157:                          ; preds = %for.cond.cleanup9.us157, %for.body4.lr.ph.split.us161
  %j_vec.0138.us154 = phi i32 [ 0, %for.body4.lr.ph.split.us161 ], [ %add36.us158, %for.cond.cleanup9.us157 ]
  %add.us155 = add nsw i32 %j_vec.0138.us154, %mul5.us
  %arrayidx.us156 = getelementptr inbounds i32, ptr addrspace(4) %output, i32 %add.us155
  %6 = tail call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %arrayidx.us156)
  %7 = tail call <16 x i32> @llvm.arc.vvcadd.init.acc.w.v512(<16 x i32> %6, <16 x i32> zeroinitializer)
  %8 = tail call <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32> %7)
  tail call void @llvm.arc.vvst.w.v512(<16 x i32> %8, ptr addrspace(4) %arrayidx.us156)
  %add36.us158 = add nuw nsw i32 %j_vec.0138.us154, 16
  %cmp2.us159 = icmp slt i32 %add36.us158, %mul
  br i1 %cmp2.us159, label %for.cond.cleanup9.us157, label %for.cond.cleanup3.us, !llvm.loop !46

for.body4.lr.ph.split.us161:                      ; preds = %for.body4.lr.ph.split.us161.preheader, %for.cond.cleanup3.us
  %i.0150.us = phi i32 [ %inc39.us, %for.cond.cleanup3.us ], [ 0, %for.body4.lr.ph.split.us161.preheader ]
  %mul5.us = mul nsw i32 %i.0150.us, %cols_out
  br label %for.cond.cleanup9.us157

for.cond.cleanup:                                 ; preds = %for.cond.cleanup3.us, %for.cond.cleanup3.us.us.us
  %cmp47181 = icmp slt i32 %mul, %cols_out
  %or.cond222 = and i1 %cmp47181, %cmp8133
  br i1 %or.cond222, label %for.body45.lr.ph.split.us.split.us.split.us, label %for.cond.cleanup44

for.body45.lr.ph:                                 ; preds = %for.body.lr.ph
  %cmp47181.old = icmp slt i32 %mul, %cols_out
  %cmp52178.old = icmp sgt i32 %K, 0
  %or.cond223 = and i1 %cmp47181.old, %cmp52178.old
  br i1 %or.cond223, label %for.body45.lr.ph.split.us.split.us.split.us, label %for.cond.cleanup44

for.body45.lr.ph.split.us.split.us.split.us:      ; preds = %for.body45.lr.ph, %for.cond.cleanup
  %min.iters.check = icmp ult i32 %K, 8
  %min.iters.check225 = icmp ult i32 %K, 64
  %n.vec = and i32 %K, 2147483584
  %cmp.n = icmp eq i32 %n.vec, %K
  %n.vec.remaining = and i32 %K, 56
  %min.epilog.iters.check = icmp eq i32 %n.vec.remaining, 0
  %n.vec239 = and i32 %K, 2147483640
  %cmp.n240 = icmp eq i32 %n.vec239, %K
  br i1 %min.iters.check, label %for.body49.lr.ph.split.us.split.us.us.us.us.us.preheader, label %for.body49.lr.ph.split.us.split.us.us.us.us.preheader

for.body49.lr.ph.split.us.split.us.us.us.us.preheader: ; preds = %for.body45.lr.ph.split.us.split.us.split.us
  br label %for.body49.lr.ph.split.us.split.us.us.us.us

for.body49.lr.ph.split.us.split.us.us.us.us.us.preheader: ; preds = %for.body45.lr.ph.split.us.split.us.split.us
  br label %for.body49.lr.ph.split.us.split.us.us.us.us.us

for.body49.lr.ph.split.us.split.us.us.us.us.us:   ; preds = %for.body49.lr.ph.split.us.split.us.us.us.us.us.preheader, %for.cond.cleanup48.us.us.us.split.us.us
  %i41.0192.us.us.us.us = phi i32 [ %inc83.us.us.us.us, %for.cond.cleanup48.us.us.us.split.us.us ], [ 0, %for.body49.lr.ph.split.us.split.us.us.us.us.us.preheader ]
  %mul69.us.us.us.us = mul nsw i32 %i41.0192.us.us.us.us, %cols_out
  br label %for.body54.lr.ph.split.us.us.us.us.us.us.us.us

for.body54.lr.ph.split.us.us.us.us.us.us.us.us:   ; preds = %for.cond.cleanup53.us.us.us.us.us.split.us.us.us, %for.body49.lr.ph.split.us.split.us.us.us.us.us
  %j.0182.us.us.us.us.us.us.us = phi i32 [ %mul, %for.body49.lr.ph.split.us.split.us.us.us.us.us ], [ %inc80.us.us.us.us.us.us.us, %for.cond.cleanup53.us.us.us.us.us.split.us.us.us ]
  %add70.us.us.us.us.us.us.us = add nsw i32 %j.0182.us.us.us.us.us.us.us, %mul69.us.us.us.us
  %arrayidx71.us.us.us.us.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %output, i32 %add70.us.us.us.us.us.us.us
  %arrayidx71.promoted.us.us.us.us.us.us.us = load i32, ptr addrspace(4) %arrayidx71.us.us.us.us.us.us.us, align 4, !tbaa !3
  br label %iter.check.us.us.us

iter.check.us.us.us:                              ; preds = %for.cond.cleanup58.us.us.us.us.us.us.us.us.us, %for.body54.lr.ph.split.us.us.us.us.us.us.us.us
  %add72.lcssa.us180.us.us.us.us.us.us.us.us = phi i32 [ %arrayidx71.promoted.us.us.us.us.us.us.us, %for.body54.lr.ph.split.us.us.us.us.us.us.us.us ], [ %add72.us.us.us.us.us.us.us.us.us, %for.cond.cleanup58.us.us.us.us.us.us.us.us.us ]
  %k_i50.0179.us.us.us.us.us.us.us.us.us = phi i32 [ 0, %for.body54.lr.ph.split.us.us.us.us.us.us.us.us ], [ %inc77.us.us.us.us.us.us.us.us.us, %for.cond.cleanup58.us.us.us.us.us.us.us.us.us ]
  %add60.us.us.us.us.us.us.us.us.us = add nuw nsw i32 %k_i50.0179.us.us.us.us.us.us.us.us.us, %i41.0192.us.us.us.us
  %mul61.us.us.us.us.us.us.us.us.us = mul nsw i32 %add60.us.us.us.us.us.us.us.us.us, %cols_in
  %add62.us.us.us.us.us.us.us.us.us = add i32 %mul61.us.us.us.us.us.us.us.us.us, %j.0182.us.us.us.us.us.us.us
  %mul65.us.us.us.us.us.us.us.us.us = mul nsw i32 %k_i50.0179.us.us.us.us.us.us.us.us.us, %K
  br label %for.body59.us.us.us.us.us.us.us.us.us

for.body59.us.us.us.us.us.us.us.us.us:            ; preds = %for.body59.us.us.us.us.us.us.us.us.us, %iter.check.us.us.us
  %add72177.us.us.us.us.us.us.us.us.us = phi i32 [ %add72.lcssa.us180.us.us.us.us.us.us.us.us, %iter.check.us.us.us ], [ %add72.us.us.us.us.us.us.us.us.us, %for.body59.us.us.us.us.us.us.us.us.us ]
  %k_j55.0176.us.us.us.us.us.us.us.us.us = phi i32 [ 0, %iter.check.us.us.us ], [ %inc74.us.us.us.us.us.us.us.us.us, %for.body59.us.us.us.us.us.us.us.us.us ]
  %add63.us.us.us.us.us.us.us.us.us = add i32 %add62.us.us.us.us.us.us.us.us.us, %k_j55.0176.us.us.us.us.us.us.us.us.us
  %arrayidx64.us.us.us.us.us.us.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %add63.us.us.us.us.us.us.us.us.us
  %9 = load i32, ptr addrspace(4) %arrayidx64.us.us.us.us.us.us.us.us.us, align 4, !tbaa !3
  %add66.us.us.us.us.us.us.us.us.us = add nsw i32 %k_j55.0176.us.us.us.us.us.us.us.us.us, %mul65.us.us.us.us.us.us.us.us.us
  %arrayidx67.us.us.us.us.us.us.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %kernel, i32 %add66.us.us.us.us.us.us.us.us.us
  %10 = load i32, ptr addrspace(4) %arrayidx67.us.us.us.us.us.us.us.us.us, align 4, !tbaa !3
  %mul68.us.us.us.us.us.us.us.us.us = mul nsw i32 %10, %9
  %add72.us.us.us.us.us.us.us.us.us = add nsw i32 %mul68.us.us.us.us.us.us.us.us.us, %add72177.us.us.us.us.us.us.us.us.us
  %inc74.us.us.us.us.us.us.us.us.us = add nuw nsw i32 %k_j55.0176.us.us.us.us.us.us.us.us.us, 1
  %cmp57.us.us.us.us.us.us.us.us.us = icmp slt i32 %inc74.us.us.us.us.us.us.us.us.us, %K
  br i1 %cmp57.us.us.us.us.us.us.us.us.us, label %for.body59.us.us.us.us.us.us.us.us.us, label %for.cond.cleanup58.us.us.us.us.us.us.us.us.us, !llvm.loop !49

for.cond.cleanup58.us.us.us.us.us.us.us.us.us:    ; preds = %for.body59.us.us.us.us.us.us.us.us.us
  %inc77.us.us.us.us.us.us.us.us.us = add nuw nsw i32 %k_i50.0179.us.us.us.us.us.us.us.us.us, 1
  %cmp52.us.us.us.us.us.us.us.us.us = icmp slt i32 %inc77.us.us.us.us.us.us.us.us.us, %K
  br i1 %cmp52.us.us.us.us.us.us.us.us.us, label %iter.check.us.us.us, label %for.cond.cleanup53.us.us.us.us.us.split.us.us.us, !llvm.loop !50

for.cond.cleanup53.us.us.us.us.us.split.us.us.us: ; preds = %for.cond.cleanup58.us.us.us.us.us.us.us.us.us
  store i32 %add72.us.us.us.us.us.us.us.us.us, ptr addrspace(4) %arrayidx71.us.us.us.us.us.us.us, align 4, !tbaa !3
  %inc80.us.us.us.us.us.us.us = add nsw i32 %j.0182.us.us.us.us.us.us.us, 1
  %cmp47.us.us.us.us.us.us.us = icmp slt i32 %inc80.us.us.us.us.us.us.us, %cols_out
  br i1 %cmp47.us.us.us.us.us.us.us, label %for.body54.lr.ph.split.us.us.us.us.us.us.us.us, label %for.cond.cleanup48.us.us.us.split.us.us, !llvm.loop !51

for.cond.cleanup48.us.us.us.split.us.us:          ; preds = %for.cond.cleanup53.us.us.us.us.us.split.us.us.us
  %inc83.us.us.us.us = add nuw nsw i32 %i41.0192.us.us.us.us, 1
  %cmp43.us.us.us.us = icmp slt i32 %inc83.us.us.us.us, %rows_out
  br i1 %cmp43.us.us.us.us, label %for.body49.lr.ph.split.us.split.us.us.us.us.us, label %for.cond.cleanup44, !llvm.loop !52

for.cond.cleanup48.us.us.us:                      ; preds = %for.cond.cleanup53.us.us.us.us.us
  %inc83.us.us.us = add nuw nsw i32 %i41.0192.us.us.us, 1
  %cmp43.us.us.us = icmp slt i32 %inc83.us.us.us, %rows_out
  br i1 %cmp43.us.us.us, label %for.body49.lr.ph.split.us.split.us.us.us.us, label %for.cond.cleanup44, !llvm.loop !52

for.body49.lr.ph.split.us.split.us.us.us.us:      ; preds = %for.body49.lr.ph.split.us.split.us.us.us.us.preheader, %for.cond.cleanup48.us.us.us
  %i41.0192.us.us.us = phi i32 [ %inc83.us.us.us, %for.cond.cleanup48.us.us.us ], [ 0, %for.body49.lr.ph.split.us.split.us.us.us.us.preheader ]
  %mul69.us.us.us = mul nsw i32 %i41.0192.us.us.us, %cols_out
  br label %for.body54.lr.ph.split.us.us.us.us.us.us

for.cond.cleanup53.us.us.us.us.us:                ; preds = %for.cond.cleanup58.us.us.us.us.us.us
  store i32 %add72.us.us.us.us.us.us.lcssa, ptr addrspace(4) %arrayidx71.us.us.us.us.us, align 4, !tbaa !3
  %inc80.us.us.us.us.us = add nsw i32 %j.0182.us.us.us.us.us, 1
  %cmp47.us.us.us.us.us = icmp slt i32 %inc80.us.us.us.us.us, %cols_out
  br i1 %cmp47.us.us.us.us.us, label %for.body54.lr.ph.split.us.us.us.us.us.us, label %for.cond.cleanup48.us.us.us, !llvm.loop !51

for.body54.lr.ph.split.us.us.us.us.us.us:         ; preds = %for.cond.cleanup53.us.us.us.us.us, %for.body49.lr.ph.split.us.split.us.us.us.us
  %j.0182.us.us.us.us.us = phi i32 [ %mul, %for.body49.lr.ph.split.us.split.us.us.us.us ], [ %inc80.us.us.us.us.us, %for.cond.cleanup53.us.us.us.us.us ]
  %add70.us.us.us.us.us = add nsw i32 %j.0182.us.us.us.us.us, %mul69.us.us.us
  %arrayidx71.us.us.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %output, i32 %add70.us.us.us.us.us
  %arrayidx71.promoted.us.us.us.us.us = load i32, ptr addrspace(4) %arrayidx71.us.us.us.us.us, align 4, !tbaa !3
  br label %iter.check

for.cond.cleanup58.us.us.us.us.us.us:             ; preds = %for.body59.us.us.us.us.us.us, %vec.epilog.middle.block, %middle.block
  %add72.us.us.us.us.us.us.lcssa = phi i32 [ %33, %middle.block ], [ %42, %vec.epilog.middle.block ], [ %add72.us.us.us.us.us.us, %for.body59.us.us.us.us.us.us ]
  %inc77.us.us.us.us.us.us = add nuw nsw i32 %k_i50.0179.us.us.us.us.us.us, 1
  %cmp52.us.us.us.us.us.us = icmp slt i32 %inc77.us.us.us.us.us.us, %K
  br i1 %cmp52.us.us.us.us.us.us, label %iter.check, label %for.cond.cleanup53.us.us.us.us.us, !llvm.loop !50

for.body59.us.us.us.us.us.us:                     ; preds = %for.body59.us.us.us.us.us.us.preheader, %for.body59.us.us.us.us.us.us
  %add72177.us.us.us.us.us.us = phi i32 [ %add72.us.us.us.us.us.us, %for.body59.us.us.us.us.us.us ], [ %add72177.us.us.us.us.us.us.ph, %for.body59.us.us.us.us.us.us.preheader ]
  %k_j55.0176.us.us.us.us.us.us = phi i32 [ %inc74.us.us.us.us.us.us, %for.body59.us.us.us.us.us.us ], [ %k_j55.0176.us.us.us.us.us.us.ph, %for.body59.us.us.us.us.us.us.preheader ]
  %add63.us.us.us.us.us.us = add i32 %add62.us.us.us.us.us.us, %k_j55.0176.us.us.us.us.us.us
  %arrayidx64.us.us.us.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %add63.us.us.us.us.us.us
  %11 = load i32, ptr addrspace(4) %arrayidx64.us.us.us.us.us.us, align 4, !tbaa !3
  %add66.us.us.us.us.us.us = add nsw i32 %k_j55.0176.us.us.us.us.us.us, %mul65.us.us.us.us.us.us
  %arrayidx67.us.us.us.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %kernel, i32 %add66.us.us.us.us.us.us
  %12 = load i32, ptr addrspace(4) %arrayidx67.us.us.us.us.us.us, align 4, !tbaa !3
  %mul68.us.us.us.us.us.us = mul nsw i32 %12, %11
  %add72.us.us.us.us.us.us = add nsw i32 %mul68.us.us.us.us.us.us, %add72177.us.us.us.us.us.us
  %inc74.us.us.us.us.us.us = add nuw nsw i32 %k_j55.0176.us.us.us.us.us.us, 1
  %cmp57.us.us.us.us.us.us = icmp slt i32 %inc74.us.us.us.us.us.us, %K
  br i1 %cmp57.us.us.us.us.us.us, label %for.body59.us.us.us.us.us.us, label %for.cond.cleanup58.us.us.us.us.us.us, !llvm.loop !49

iter.check:                                       ; preds = %for.body54.lr.ph.split.us.us.us.us.us.us, %for.cond.cleanup58.us.us.us.us.us.us
  %add72.lcssa.us180.us.us.us.us.us = phi i32 [ %arrayidx71.promoted.us.us.us.us.us, %for.body54.lr.ph.split.us.us.us.us.us.us ], [ %add72.us.us.us.us.us.us.lcssa, %for.cond.cleanup58.us.us.us.us.us.us ]
  %k_i50.0179.us.us.us.us.us.us = phi i32 [ 0, %for.body54.lr.ph.split.us.us.us.us.us.us ], [ %inc77.us.us.us.us.us.us, %for.cond.cleanup58.us.us.us.us.us.us ]
  %add60.us.us.us.us.us.us = add nuw nsw i32 %k_i50.0179.us.us.us.us.us.us, %i41.0192.us.us.us
  %mul61.us.us.us.us.us.us = mul nsw i32 %add60.us.us.us.us.us.us, %cols_in
  %add62.us.us.us.us.us.us = add i32 %mul61.us.us.us.us.us.us, %j.0182.us.us.us.us.us
  %mul65.us.us.us.us.us.us = mul nsw i32 %k_i50.0179.us.us.us.us.us.us, %K
  br i1 %min.iters.check225, label %vec.epilog.ph, label %vector.ph

vector.ph:                                        ; preds = %iter.check
  %13 = insertelement <16 x i32> <i32 poison, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, i32 %add72.lcssa.us180.us.us.us.us.us, i64 0
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi <16 x i32> [ %13, %vector.ph ], [ %28, %vector.body ]
  %vec.phi226 = phi <16 x i32> [ zeroinitializer, %vector.ph ], [ %29, %vector.body ]
  %vec.phi227 = phi <16 x i32> [ zeroinitializer, %vector.ph ], [ %30, %vector.body ]
  %vec.phi228 = phi <16 x i32> [ zeroinitializer, %vector.ph ], [ %31, %vector.body ]
  %14 = add i32 %add62.us.us.us.us.us.us, %index
  %15 = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %14
  %wide.load = load <16 x i32>, ptr addrspace(4) %15, align 4, !tbaa !3
  %16 = getelementptr inbounds i32, ptr addrspace(4) %15, i32 16
  %wide.load229 = load <16 x i32>, ptr addrspace(4) %16, align 4, !tbaa !3
  %17 = getelementptr inbounds i32, ptr addrspace(4) %15, i32 32
  %wide.load230 = load <16 x i32>, ptr addrspace(4) %17, align 4, !tbaa !3
  %18 = getelementptr inbounds i32, ptr addrspace(4) %15, i32 48
  %wide.load231 = load <16 x i32>, ptr addrspace(4) %18, align 4, !tbaa !3
  %19 = add nsw i32 %index, %mul65.us.us.us.us.us.us
  %20 = getelementptr inbounds i32, ptr addrspace(4) %kernel, i32 %19
  %wide.load232 = load <16 x i32>, ptr addrspace(4) %20, align 4, !tbaa !3
  %21 = getelementptr inbounds i32, ptr addrspace(4) %20, i32 16
  %wide.load233 = load <16 x i32>, ptr addrspace(4) %21, align 4, !tbaa !3
  %22 = getelementptr inbounds i32, ptr addrspace(4) %20, i32 32
  %wide.load234 = load <16 x i32>, ptr addrspace(4) %22, align 4, !tbaa !3
  %23 = getelementptr inbounds i32, ptr addrspace(4) %20, i32 48
  %wide.load235 = load <16 x i32>, ptr addrspace(4) %23, align 4, !tbaa !3
  %24 = mul nsw <16 x i32> %wide.load232, %wide.load
  %25 = mul nsw <16 x i32> %wide.load233, %wide.load229
  %26 = mul nsw <16 x i32> %wide.load234, %wide.load230
  %27 = mul nsw <16 x i32> %wide.load235, %wide.load231
  %28 = add <16 x i32> %24, %vec.phi
  %29 = add <16 x i32> %25, %vec.phi226
  %30 = add <16 x i32> %26, %vec.phi227
  %31 = add <16 x i32> %27, %vec.phi228
  %index.next = add nuw i32 %index, 64
  %32 = icmp eq i32 %index.next, %n.vec
  br i1 %32, label %middle.block, label %vector.body, !llvm.loop !53

middle.block:                                     ; preds = %vector.body
  %bin.rdx = add <16 x i32> %29, %28
  %bin.rdx236 = add <16 x i32> %30, %bin.rdx
  %bin.rdx237 = add <16 x i32> %31, %bin.rdx236
  %33 = tail call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %bin.rdx237)
  br i1 %cmp.n, label %for.cond.cleanup58.us.us.us.us.us.us, label %vec.epilog.iter.check

vec.epilog.iter.check:                            ; preds = %middle.block
  br i1 %min.epilog.iters.check, label %for.body59.us.us.us.us.us.us.preheader, label %vec.epilog.ph

vec.epilog.ph:                                    ; preds = %iter.check, %vec.epilog.iter.check
  %bc.merge.rdx = phi i32 [ %add72.lcssa.us180.us.us.us.us.us, %iter.check ], [ %33, %vec.epilog.iter.check ]
  %vec.epilog.resume.val = phi i32 [ 0, %iter.check ], [ %n.vec, %vec.epilog.iter.check ]
  %34 = insertelement <8 x i32> <i32 poison, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, i32 %bc.merge.rdx, i64 0
  br label %vec.epilog.vector.body

vec.epilog.vector.body:                           ; preds = %vec.epilog.vector.body, %vec.epilog.ph
  %index241 = phi i32 [ %vec.epilog.resume.val, %vec.epilog.ph ], [ %index.next245, %vec.epilog.vector.body ]
  %vec.phi242 = phi <8 x i32> [ %34, %vec.epilog.ph ], [ %40, %vec.epilog.vector.body ]
  %35 = add i32 %add62.us.us.us.us.us.us, %index241
  %36 = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %35
  %wide.load243 = load <8 x i32>, ptr addrspace(4) %36, align 4, !tbaa !3
  %37 = add nsw i32 %index241, %mul65.us.us.us.us.us.us
  %38 = getelementptr inbounds i32, ptr addrspace(4) %kernel, i32 %37
  %wide.load244 = load <8 x i32>, ptr addrspace(4) %38, align 4, !tbaa !3
  %39 = mul nsw <8 x i32> %wide.load244, %wide.load243
  %40 = add <8 x i32> %39, %vec.phi242
  %index.next245 = add nuw i32 %index241, 8
  %41 = icmp eq i32 %index.next245, %n.vec239
  br i1 %41, label %vec.epilog.middle.block, label %vec.epilog.vector.body, !llvm.loop !54

vec.epilog.middle.block:                          ; preds = %vec.epilog.vector.body
  %42 = tail call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %40)
  br i1 %cmp.n240, label %for.cond.cleanup58.us.us.us.us.us.us, label %for.body59.us.us.us.us.us.us.preheader

for.body59.us.us.us.us.us.us.preheader:           ; preds = %vec.epilog.iter.check, %vec.epilog.middle.block
  %add72177.us.us.us.us.us.us.ph = phi i32 [ %33, %vec.epilog.iter.check ], [ %42, %vec.epilog.middle.block ]
  %k_j55.0176.us.us.us.us.us.us.ph = phi i32 [ %n.vec, %vec.epilog.iter.check ], [ %n.vec239, %vec.epilog.middle.block ]
  br label %for.body59.us.us.us.us.us.us

for.cond.cleanup44:                               ; preds = %for.cond.cleanup48.us.us.us, %for.cond.cleanup48.us.us.us.split.us.us, %entry, %for.body45.lr.ph, %for.cond.cleanup
  ret void
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @autovectorized_conv2d(i32 noundef %rows_out, i32 noundef %cols_out, i32 noundef %rows_in, i32 noundef %cols_in, i32 noundef %K, ptr addrspace(4) noalias nocapture noundef %output, ptr addrspace(4) noalias nocapture noundef readonly %input, ptr addrspace(4) noalias nocapture noundef readonly %kernel) local_unnamed_addr #2 {
entry:
  %cmp63 = icmp sgt i32 %rows_out, 0
  %cmp253 = icmp sgt i32 %cols_out, 0
  %or.cond = and i1 %cmp63, %cmp253
  %cmp650 = icmp sgt i32 %K, 0
  %or.cond88 = and i1 %or.cond, %cmp650
  br i1 %or.cond88, label %for.body.lr.ph.split.us.split.us.split.us, label %for.cond.cleanup

for.body.lr.ph.split.us.split.us.split.us:        ; preds = %entry
  %min.iters.check = icmp ult i32 %K, 8
  %min.iters.check89 = icmp ult i32 %K, 64
  %n.vec = and i32 %K, -64
  %cmp.n = icmp eq i32 %n.vec, %K
  %n.vec.remaining = and i32 %K, 56
  %min.epilog.iters.check = icmp eq i32 %n.vec.remaining, 0
  %n.vec103 = and i32 %K, -8
  %cmp.n104 = icmp eq i32 %n.vec103, %K
  br i1 %min.iters.check, label %for.body4.lr.ph.split.us.split.us.us.us.us.us.preheader, label %for.body4.lr.ph.split.us.split.us.us.us.us.preheader

for.body4.lr.ph.split.us.split.us.us.us.us.preheader: ; preds = %for.body.lr.ph.split.us.split.us.split.us
  br label %for.body4.lr.ph.split.us.split.us.us.us.us

for.body4.lr.ph.split.us.split.us.us.us.us.us.preheader: ; preds = %for.body.lr.ph.split.us.split.us.split.us
  br label %for.body4.lr.ph.split.us.split.us.us.us.us.us

for.body4.lr.ph.split.us.split.us.us.us.us.us:    ; preds = %for.body4.lr.ph.split.us.split.us.us.us.us.us.preheader, %for.cond.cleanup3.us.us.us.split.us.us
  %i.064.us.us.us.us = phi i32 [ %inc30.us.us.us.us, %for.cond.cleanup3.us.us.us.split.us.us ], [ 0, %for.body4.lr.ph.split.us.split.us.us.us.us.us.preheader ]
  %mul19.us.us.us.us = mul nsw i32 %i.064.us.us.us.us, %cols_out
  br label %for.body8.lr.ph.split.us.us.us.us.us.us.us.us

for.body8.lr.ph.split.us.us.us.us.us.us.us.us:    ; preds = %for.cond.cleanup7.us.us.us.us.us.split.us.us.us, %for.body4.lr.ph.split.us.split.us.us.us.us.us
  %j.054.us.us.us.us.us.us.us = phi i32 [ 0, %for.body4.lr.ph.split.us.split.us.us.us.us.us ], [ %inc27.us.us.us.us.us.us.us, %for.cond.cleanup7.us.us.us.us.us.split.us.us.us ]
  %add20.us.us.us.us.us.us.us = add nsw i32 %j.054.us.us.us.us.us.us.us, %mul19.us.us.us.us
  %arrayidx21.us.us.us.us.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %output, i32 %add20.us.us.us.us.us.us.us
  %arrayidx21.promoted.us.us.us.us.us.us.us = load i32, ptr addrspace(4) %arrayidx21.us.us.us.us.us.us.us, align 4, !tbaa !3
  br label %iter.check.us.us.us

iter.check.us.us.us:                              ; preds = %for.cond.cleanup11.us.us.us.us.us.us.loopexit.us.us.us, %for.body8.lr.ph.split.us.us.us.us.us.us.us.us
  %add22.lcssa.us52.us.us.us.us.us.us.us.us = phi i32 [ %arrayidx21.promoted.us.us.us.us.us.us.us, %for.body8.lr.ph.split.us.us.us.us.us.us.us.us ], [ %add22.us.us.us.us.us.us.us.us.us, %for.cond.cleanup11.us.us.us.us.us.us.loopexit.us.us.us ]
  %k_i.051.us.us.us.us.us.us.us.us.us = phi i32 [ 0, %for.body8.lr.ph.split.us.us.us.us.us.us.us.us ], [ %inc24.us.us.us.us.us.us.us.us.us, %for.cond.cleanup11.us.us.us.us.us.us.loopexit.us.us.us ]
  %add.us.us.us.us.us.us.us.us.us = add nuw nsw i32 %k_i.051.us.us.us.us.us.us.us.us.us, %i.064.us.us.us.us
  %mul.us.us.us.us.us.us.us.us.us = mul nsw i32 %add.us.us.us.us.us.us.us.us.us, %cols_in
  %add13.us.us.us.us.us.us.us.us.us = add i32 %mul.us.us.us.us.us.us.us.us.us, %j.054.us.us.us.us.us.us.us
  %mul15.us.us.us.us.us.us.us.us.us = mul nsw i32 %k_i.051.us.us.us.us.us.us.us.us.us, %K
  br label %for.body12.us.us.us.us.us.us.us.us.us

for.body12.us.us.us.us.us.us.us.us.us:            ; preds = %iter.check.us.us.us, %for.body12.us.us.us.us.us.us.us.us.us
  %add2249.us.us.us.us.us.us.us.us.us = phi i32 [ %add22.lcssa.us52.us.us.us.us.us.us.us.us, %iter.check.us.us.us ], [ %add22.us.us.us.us.us.us.us.us.us, %for.body12.us.us.us.us.us.us.us.us.us ]
  %k_j.048.us.us.us.us.us.us.us.us.us = phi i32 [ 0, %iter.check.us.us.us ], [ %inc.us.us.us.us.us.us.us.us.us, %for.body12.us.us.us.us.us.us.us.us.us ]
  %add14.us.us.us.us.us.us.us.us.us = add i32 %add13.us.us.us.us.us.us.us.us.us, %k_j.048.us.us.us.us.us.us.us.us.us
  %arrayidx.us.us.us.us.us.us.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %add14.us.us.us.us.us.us.us.us.us
  %0 = load i32, ptr addrspace(4) %arrayidx.us.us.us.us.us.us.us.us.us, align 4, !tbaa !3
  %add16.us.us.us.us.us.us.us.us.us = add nsw i32 %k_j.048.us.us.us.us.us.us.us.us.us, %mul15.us.us.us.us.us.us.us.us.us
  %arrayidx17.us.us.us.us.us.us.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %kernel, i32 %add16.us.us.us.us.us.us.us.us.us
  %1 = load i32, ptr addrspace(4) %arrayidx17.us.us.us.us.us.us.us.us.us, align 4, !tbaa !3
  %mul18.us.us.us.us.us.us.us.us.us = mul nsw i32 %1, %0
  %add22.us.us.us.us.us.us.us.us.us = add nsw i32 %mul18.us.us.us.us.us.us.us.us.us, %add2249.us.us.us.us.us.us.us.us.us
  %inc.us.us.us.us.us.us.us.us.us = add nuw nsw i32 %k_j.048.us.us.us.us.us.us.us.us.us, 1
  %cmp10.us.us.us.us.us.us.us.us.us = icmp slt i32 %inc.us.us.us.us.us.us.us.us.us, %K
  br i1 %cmp10.us.us.us.us.us.us.us.us.us, label %for.body12.us.us.us.us.us.us.us.us.us, label %for.cond.cleanup11.us.us.us.us.us.us.loopexit.us.us.us, !llvm.loop !55

for.cond.cleanup11.us.us.us.us.us.us.loopexit.us.us.us: ; preds = %for.body12.us.us.us.us.us.us.us.us.us
  %inc24.us.us.us.us.us.us.us.us.us = add nuw nsw i32 %k_i.051.us.us.us.us.us.us.us.us.us, 1
  %cmp6.us.us.us.us.us.us.us.us.us = icmp slt i32 %inc24.us.us.us.us.us.us.us.us.us, %K
  br i1 %cmp6.us.us.us.us.us.us.us.us.us, label %iter.check.us.us.us, label %for.cond.cleanup7.us.us.us.us.us.split.us.us.us, !llvm.loop !56

for.cond.cleanup7.us.us.us.us.us.split.us.us.us:  ; preds = %for.cond.cleanup11.us.us.us.us.us.us.loopexit.us.us.us
  store i32 %add22.us.us.us.us.us.us.us.us.us, ptr addrspace(4) %arrayidx21.us.us.us.us.us.us.us, align 4, !tbaa !3
  %inc27.us.us.us.us.us.us.us = add nuw nsw i32 %j.054.us.us.us.us.us.us.us, 1
  %cmp2.us.us.us.us.us.us.us = icmp slt i32 %inc27.us.us.us.us.us.us.us, %cols_out
  br i1 %cmp2.us.us.us.us.us.us.us, label %for.body8.lr.ph.split.us.us.us.us.us.us.us.us, label %for.cond.cleanup3.us.us.us.split.us.us, !llvm.loop !57

for.cond.cleanup3.us.us.us.split.us.us:           ; preds = %for.cond.cleanup7.us.us.us.us.us.split.us.us.us
  %inc30.us.us.us.us = add nuw nsw i32 %i.064.us.us.us.us, 1
  %cmp.us.us.us.us = icmp slt i32 %inc30.us.us.us.us, %rows_out
  br i1 %cmp.us.us.us.us, label %for.body4.lr.ph.split.us.split.us.us.us.us.us, label %for.cond.cleanup, !llvm.loop !58

for.cond.cleanup3.us.us.us:                       ; preds = %for.cond.cleanup7.us.us.us.us.us
  %inc30.us.us.us = add nuw nsw i32 %i.064.us.us.us, 1
  %cmp.us.us.us = icmp slt i32 %inc30.us.us.us, %rows_out
  br i1 %cmp.us.us.us, label %for.body4.lr.ph.split.us.split.us.us.us.us, label %for.cond.cleanup, !llvm.loop !58

for.body4.lr.ph.split.us.split.us.us.us.us:       ; preds = %for.body4.lr.ph.split.us.split.us.us.us.us.preheader, %for.cond.cleanup3.us.us.us
  %i.064.us.us.us = phi i32 [ %inc30.us.us.us, %for.cond.cleanup3.us.us.us ], [ 0, %for.body4.lr.ph.split.us.split.us.us.us.us.preheader ]
  %mul19.us.us.us = mul nsw i32 %i.064.us.us.us, %cols_out
  br label %for.body8.lr.ph.split.us.us.us.us.us.us

for.cond.cleanup7.us.us.us.us.us:                 ; preds = %for.cond.cleanup11.us.us.us.us.us.us
  store i32 %add22.us.us.us.us.us.us.lcssa, ptr addrspace(4) %arrayidx21.us.us.us.us.us, align 4, !tbaa !3
  %inc27.us.us.us.us.us = add nuw nsw i32 %j.054.us.us.us.us.us, 1
  %cmp2.us.us.us.us.us = icmp slt i32 %inc27.us.us.us.us.us, %cols_out
  br i1 %cmp2.us.us.us.us.us, label %for.body8.lr.ph.split.us.us.us.us.us.us, label %for.cond.cleanup3.us.us.us, !llvm.loop !57

for.body8.lr.ph.split.us.us.us.us.us.us:          ; preds = %for.cond.cleanup7.us.us.us.us.us, %for.body4.lr.ph.split.us.split.us.us.us.us
  %j.054.us.us.us.us.us = phi i32 [ 0, %for.body4.lr.ph.split.us.split.us.us.us.us ], [ %inc27.us.us.us.us.us, %for.cond.cleanup7.us.us.us.us.us ]
  %add20.us.us.us.us.us = add nsw i32 %j.054.us.us.us.us.us, %mul19.us.us.us
  %arrayidx21.us.us.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %output, i32 %add20.us.us.us.us.us
  %arrayidx21.promoted.us.us.us.us.us = load i32, ptr addrspace(4) %arrayidx21.us.us.us.us.us, align 4, !tbaa !3
  br label %iter.check

for.cond.cleanup11.us.us.us.us.us.us:             ; preds = %for.body12.us.us.us.us.us.us, %vec.epilog.middle.block, %middle.block
  %add22.us.us.us.us.us.us.lcssa = phi i32 [ %24, %middle.block ], [ %33, %vec.epilog.middle.block ], [ %add22.us.us.us.us.us.us, %for.body12.us.us.us.us.us.us ]
  %inc24.us.us.us.us.us.us = add nuw nsw i32 %k_i.051.us.us.us.us.us.us, 1
  %cmp6.us.us.us.us.us.us = icmp slt i32 %inc24.us.us.us.us.us.us, %K
  br i1 %cmp6.us.us.us.us.us.us, label %iter.check, label %for.cond.cleanup7.us.us.us.us.us, !llvm.loop !56

for.body12.us.us.us.us.us.us:                     ; preds = %for.body12.us.us.us.us.us.us.preheader, %for.body12.us.us.us.us.us.us
  %add2249.us.us.us.us.us.us = phi i32 [ %add22.us.us.us.us.us.us, %for.body12.us.us.us.us.us.us ], [ %add2249.us.us.us.us.us.us.ph, %for.body12.us.us.us.us.us.us.preheader ]
  %k_j.048.us.us.us.us.us.us = phi i32 [ %inc.us.us.us.us.us.us, %for.body12.us.us.us.us.us.us ], [ %k_j.048.us.us.us.us.us.us.ph, %for.body12.us.us.us.us.us.us.preheader ]
  %add14.us.us.us.us.us.us = add i32 %add13.us.us.us.us.us.us, %k_j.048.us.us.us.us.us.us
  %arrayidx.us.us.us.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %add14.us.us.us.us.us.us
  %2 = load i32, ptr addrspace(4) %arrayidx.us.us.us.us.us.us, align 4, !tbaa !3
  %add16.us.us.us.us.us.us = add nsw i32 %k_j.048.us.us.us.us.us.us, %mul15.us.us.us.us.us.us
  %arrayidx17.us.us.us.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %kernel, i32 %add16.us.us.us.us.us.us
  %3 = load i32, ptr addrspace(4) %arrayidx17.us.us.us.us.us.us, align 4, !tbaa !3
  %mul18.us.us.us.us.us.us = mul nsw i32 %3, %2
  %add22.us.us.us.us.us.us = add nsw i32 %mul18.us.us.us.us.us.us, %add2249.us.us.us.us.us.us
  %inc.us.us.us.us.us.us = add nuw nsw i32 %k_j.048.us.us.us.us.us.us, 1
  %cmp10.us.us.us.us.us.us = icmp slt i32 %inc.us.us.us.us.us.us, %K
  br i1 %cmp10.us.us.us.us.us.us, label %for.body12.us.us.us.us.us.us, label %for.cond.cleanup11.us.us.us.us.us.us, !llvm.loop !55

iter.check:                                       ; preds = %for.body8.lr.ph.split.us.us.us.us.us.us, %for.cond.cleanup11.us.us.us.us.us.us
  %add22.lcssa.us52.us.us.us.us.us = phi i32 [ %arrayidx21.promoted.us.us.us.us.us, %for.body8.lr.ph.split.us.us.us.us.us.us ], [ %add22.us.us.us.us.us.us.lcssa, %for.cond.cleanup11.us.us.us.us.us.us ]
  %k_i.051.us.us.us.us.us.us = phi i32 [ 0, %for.body8.lr.ph.split.us.us.us.us.us.us ], [ %inc24.us.us.us.us.us.us, %for.cond.cleanup11.us.us.us.us.us.us ]
  %add.us.us.us.us.us.us = add nuw nsw i32 %k_i.051.us.us.us.us.us.us, %i.064.us.us.us
  %mul.us.us.us.us.us.us = mul nsw i32 %add.us.us.us.us.us.us, %cols_in
  %add13.us.us.us.us.us.us = add i32 %mul.us.us.us.us.us.us, %j.054.us.us.us.us.us
  %mul15.us.us.us.us.us.us = mul nsw i32 %k_i.051.us.us.us.us.us.us, %K
  br i1 %min.iters.check89, label %vec.epilog.ph, label %vector.ph

vector.ph:                                        ; preds = %iter.check
  %4 = insertelement <16 x i32> <i32 poison, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, i32 %add22.lcssa.us52.us.us.us.us.us, i64 0
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi <16 x i32> [ %4, %vector.ph ], [ %19, %vector.body ]
  %vec.phi90 = phi <16 x i32> [ zeroinitializer, %vector.ph ], [ %20, %vector.body ]
  %vec.phi91 = phi <16 x i32> [ zeroinitializer, %vector.ph ], [ %21, %vector.body ]
  %vec.phi92 = phi <16 x i32> [ zeroinitializer, %vector.ph ], [ %22, %vector.body ]
  %5 = add i32 %add13.us.us.us.us.us.us, %index
  %6 = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %5
  %wide.load = load <16 x i32>, ptr addrspace(4) %6, align 4, !tbaa !3
  %7 = getelementptr inbounds i32, ptr addrspace(4) %6, i32 16
  %wide.load93 = load <16 x i32>, ptr addrspace(4) %7, align 4, !tbaa !3
  %8 = getelementptr inbounds i32, ptr addrspace(4) %6, i32 32
  %wide.load94 = load <16 x i32>, ptr addrspace(4) %8, align 4, !tbaa !3
  %9 = getelementptr inbounds i32, ptr addrspace(4) %6, i32 48
  %wide.load95 = load <16 x i32>, ptr addrspace(4) %9, align 4, !tbaa !3
  %10 = add nsw i32 %index, %mul15.us.us.us.us.us.us
  %11 = getelementptr inbounds i32, ptr addrspace(4) %kernel, i32 %10
  %wide.load96 = load <16 x i32>, ptr addrspace(4) %11, align 4, !tbaa !3
  %12 = getelementptr inbounds i32, ptr addrspace(4) %11, i32 16
  %wide.load97 = load <16 x i32>, ptr addrspace(4) %12, align 4, !tbaa !3
  %13 = getelementptr inbounds i32, ptr addrspace(4) %11, i32 32
  %wide.load98 = load <16 x i32>, ptr addrspace(4) %13, align 4, !tbaa !3
  %14 = getelementptr inbounds i32, ptr addrspace(4) %11, i32 48
  %wide.load99 = load <16 x i32>, ptr addrspace(4) %14, align 4, !tbaa !3
  %15 = mul nsw <16 x i32> %wide.load96, %wide.load
  %16 = mul nsw <16 x i32> %wide.load97, %wide.load93
  %17 = mul nsw <16 x i32> %wide.load98, %wide.load94
  %18 = mul nsw <16 x i32> %wide.load99, %wide.load95
  %19 = add <16 x i32> %15, %vec.phi
  %20 = add <16 x i32> %16, %vec.phi90
  %21 = add <16 x i32> %17, %vec.phi91
  %22 = add <16 x i32> %18, %vec.phi92
  %index.next = add nuw i32 %index, 64
  %23 = icmp eq i32 %index.next, %n.vec
  br i1 %23, label %middle.block, label %vector.body, !llvm.loop !59

middle.block:                                     ; preds = %vector.body
  %bin.rdx = add <16 x i32> %20, %19
  %bin.rdx100 = add <16 x i32> %21, %bin.rdx
  %bin.rdx101 = add <16 x i32> %22, %bin.rdx100
  %24 = tail call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %bin.rdx101)
  br i1 %cmp.n, label %for.cond.cleanup11.us.us.us.us.us.us, label %vec.epilog.iter.check

vec.epilog.iter.check:                            ; preds = %middle.block
  br i1 %min.epilog.iters.check, label %for.body12.us.us.us.us.us.us.preheader, label %vec.epilog.ph

vec.epilog.ph:                                    ; preds = %iter.check, %vec.epilog.iter.check
  %bc.merge.rdx = phi i32 [ %add22.lcssa.us52.us.us.us.us.us, %iter.check ], [ %24, %vec.epilog.iter.check ]
  %vec.epilog.resume.val = phi i32 [ 0, %iter.check ], [ %n.vec, %vec.epilog.iter.check ]
  %25 = insertelement <8 x i32> <i32 poison, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, i32 %bc.merge.rdx, i64 0
  br label %vec.epilog.vector.body

vec.epilog.vector.body:                           ; preds = %vec.epilog.vector.body, %vec.epilog.ph
  %index105 = phi i32 [ %vec.epilog.resume.val, %vec.epilog.ph ], [ %index.next109, %vec.epilog.vector.body ]
  %vec.phi106 = phi <8 x i32> [ %25, %vec.epilog.ph ], [ %31, %vec.epilog.vector.body ]
  %26 = add i32 %add13.us.us.us.us.us.us, %index105
  %27 = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %26
  %wide.load107 = load <8 x i32>, ptr addrspace(4) %27, align 4, !tbaa !3
  %28 = add nsw i32 %index105, %mul15.us.us.us.us.us.us
  %29 = getelementptr inbounds i32, ptr addrspace(4) %kernel, i32 %28
  %wide.load108 = load <8 x i32>, ptr addrspace(4) %29, align 4, !tbaa !3
  %30 = mul nsw <8 x i32> %wide.load108, %wide.load107
  %31 = add <8 x i32> %30, %vec.phi106
  %index.next109 = add nuw i32 %index105, 8
  %32 = icmp eq i32 %index.next109, %n.vec103
  br i1 %32, label %vec.epilog.middle.block, label %vec.epilog.vector.body, !llvm.loop !60

vec.epilog.middle.block:                          ; preds = %vec.epilog.vector.body
  %33 = tail call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %31)
  br i1 %cmp.n104, label %for.cond.cleanup11.us.us.us.us.us.us, label %for.body12.us.us.us.us.us.us.preheader

for.body12.us.us.us.us.us.us.preheader:           ; preds = %vec.epilog.iter.check, %vec.epilog.middle.block
  %add2249.us.us.us.us.us.us.ph = phi i32 [ %24, %vec.epilog.iter.check ], [ %33, %vec.epilog.middle.block ]
  %k_j.048.us.us.us.us.us.us.ph = phi i32 [ %n.vec, %vec.epilog.iter.check ], [ %n.vec103, %vec.epilog.middle.block ]
  br label %for.body12.us.us.us.us.us.us

for.cond.cleanup:                                 ; preds = %for.cond.cleanup3.us.us.us, %for.cond.cleanup3.us.us.us.split.us.us, %entry
  ret void
}

; Function Attrs: nounwind
define dso_local void @vekt_conv2d_wrapper(i32 noundef %rows_out, i32 noundef %cols_out, i32 noundef %rows_in, i32 noundef %cols_in, i32 noundef %K, ptr noundef %output, ptr noundef %input, ptr noundef %kernel) local_unnamed_addr #4 {
entry:
  tail call void @vekt_conv2d(i32 noundef %rows_out, i32 noundef %cols_out, i32 noundef %rows_in, i32 noundef %cols_in, i32 noundef %K, ptr noundef %output, ptr noundef %output, i32 noundef 0, i32 noundef %rows_out, i32 noundef %cols_out, i32 noundef %cols_out, i32 noundef 1, ptr noundef %input, ptr noundef %input, i32 noundef 0, i32 noundef %rows_in, i32 noundef %cols_in, i32 noundef %cols_in, i32 noundef 1, ptr noundef %kernel, ptr noundef %kernel, i32 noundef 0, i32 noundef %K, i32 noundef %K, i32 noundef %K, i32 noundef 1) #11
  ret void
}

declare void @vekt_conv2d(i32 noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef, ptr noundef, ptr noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef, ptr noundef, ptr noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef, ptr noundef, ptr noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef) local_unnamed_addr #5

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

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.add.v16i32(<16 x i32>) #10

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.add.v8i32(<8 x i32>) #10

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: write) "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #1 = { nofree nounwind "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #2 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite) "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
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
!13 = distinct !{!13, !8}
!14 = distinct !{!14, !8}
!15 = distinct !{!15, !8, !9}
!16 = distinct !{!16, !8}
!17 = !{!18}
!18 = distinct !{!18, !19}
!19 = distinct !{!19, !"LVerDomain"}
!20 = !{!21}
!21 = distinct !{!21, !19}
!22 = distinct !{!22, !8, !9, !10}
!23 = !{!24}
!24 = distinct !{!24, !25}
!25 = distinct !{!25, !"LVerDomain"}
!26 = !{!27}
!27 = distinct !{!27, !25}
!28 = distinct !{!28, !8, !9, !10}
!29 = distinct !{!29, !8}
!30 = distinct !{!30, !8}
!31 = distinct !{!31, !8, !32, !33}
!32 = !{!"llvm.loop.vectorize.width", i32 1}
!33 = !{!"llvm.loop.vectorize.followup_all", !34}
!34 = distinct !{!34, !8, !35}
!35 = !{!"llvm.loop.isvectorized"}
!36 = distinct !{!36, !8, !32, !37}
!37 = !{!"llvm.loop.vectorize.followup_all", !38}
!38 = distinct !{!38, !8, !35}
!39 = distinct !{!39, !8, !32, !40}
!40 = !{!"llvm.loop.vectorize.followup_all", !41}
!41 = distinct !{!41, !8, !35}
!42 = distinct !{!42, !8, !32, !43}
!43 = !{!"llvm.loop.vectorize.followup_all", !44}
!44 = distinct !{!44, !8, !35}
!45 = distinct !{!45, !8}
!46 = distinct !{!46, !8}
!47 = distinct !{!47, !8}
!48 = distinct !{!48, !8}
!49 = distinct !{!49, !8, !10, !9}
!50 = distinct !{!50, !8}
!51 = distinct !{!51, !8}
!52 = distinct !{!52, !8}
!53 = distinct !{!53, !8, !9, !10}
!54 = distinct !{!54, !8, !9, !10}
!55 = distinct !{!55, !8, !10, !9}
!56 = distinct !{!56, !8}
!57 = distinct !{!57, !8}
!58 = distinct !{!58, !8}
!59 = distinct !{!59, !8, !9, !10}
!60 = distinct !{!60, !8, !9, !10}
