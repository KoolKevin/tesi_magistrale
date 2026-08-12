; ModuleID = 'sad2d.c'
source_filename = "sad2d.c"
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

; Function Attrs: mustprogress nofree nosync nounwind willreturn memory(argmem: read)
define dso_local i32 @sad2d(i32 noundef %rows, i32 noundef %cols, ptr nocapture noundef readonly %input1, ptr nocapture noundef readonly %input2) local_unnamed_addr #3 {
entry:
  %cmp27 = icmp sgt i32 %rows, 0
  %cmp224 = icmp sgt i32 %cols, 0
  %or.cond = and i1 %cmp27, %cmp224
  br i1 %or.cond, label %for.body.lr.ph.split.us, label %for.cond.cleanup

for.body.lr.ph.split.us:                          ; preds = %entry
  %min.iters.check = icmp ult i32 %cols, 2
  %n.vec = and i32 %cols, -2
  br i1 %min.iters.check, label %for.body4.lr.ph.us.us.preheader, label %for.body.lr.ph.split.us.split

for.body4.lr.ph.us.us.preheader:                  ; preds = %for.body.lr.ph.split.us
  br label %for.body4.lr.ph.us.us

for.body4.lr.ph.us.us:                            ; preds = %for.body4.lr.ph.us.us.preheader, %for.cond.cleanup3.us.loopexit.us
  %res.029.us.us = phi i32 [ %add10.us.us, %for.cond.cleanup3.us.loopexit.us ], [ 0, %for.body4.lr.ph.us.us.preheader ]
  %i.028.us.us = phi i32 [ %inc12.us.us, %for.cond.cleanup3.us.loopexit.us ], [ 0, %for.body4.lr.ph.us.us.preheader ]
  %mul.us.us = mul nsw i32 %i.028.us.us, %cols
  br label %for.body4.us.us

for.body4.us.us:                                  ; preds = %for.body4.lr.ph.us.us, %for.body4.us.us
  %res.126.us.us = phi i32 [ %res.029.us.us, %for.body4.lr.ph.us.us ], [ %add10.us.us, %for.body4.us.us ]
  %j.025.us.us = phi i32 [ 0, %for.body4.lr.ph.us.us ], [ %inc.us.us, %for.body4.us.us ]
  %add.us.us = add nsw i32 %j.025.us.us, %mul.us.us
  %arrayidx.us.us = getelementptr inbounds i32, ptr %input1, i32 %add.us.us
  %0 = load i32, ptr %arrayidx.us.us, align 4, !tbaa !3
  %arrayidx7.us.us = getelementptr inbounds i32, ptr %input2, i32 %add.us.us
  %1 = load i32, ptr %arrayidx7.us.us, align 4, !tbaa !3
  %sub.us.us = sub nsw i32 %0, %1
  %cond.us.us = tail call i32 @llvm.abs.i32(i32 %sub.us.us, i1 true)
  %add10.us.us = add nsw i32 %cond.us.us, %res.126.us.us
  %inc.us.us = add nuw nsw i32 %j.025.us.us, 1
  %cmp2.us.us = icmp slt i32 %inc.us.us, %cols
  br i1 %cmp2.us.us, label %for.body4.us.us, label %for.cond.cleanup3.us.loopexit.us, !llvm.loop !31

for.cond.cleanup3.us.loopexit.us:                 ; preds = %for.body4.us.us
  %inc12.us.us = add nuw nsw i32 %i.028.us.us, 1
  %cmp.us.us = icmp slt i32 %inc12.us.us, %rows
  br i1 %cmp.us.us, label %for.body4.lr.ph.us.us, label %for.cond.cleanup, !llvm.loop !34

for.body.lr.ph.split.us.split:                    ; preds = %for.body.lr.ph.split.us
  %cmp.n = icmp eq i32 %n.vec, %cols
  br i1 %cmp.n, label %for.body4.lr.ph.us.us36.preheader, label %for.body4.lr.ph.us.preheader

for.body4.lr.ph.us.preheader:                     ; preds = %for.body.lr.ph.split.us.split
  br label %for.body4.lr.ph.us

for.body4.lr.ph.us.us36.preheader:                ; preds = %for.body.lr.ph.split.us.split
  br label %for.body4.lr.ph.us.us36

for.body4.lr.ph.us.us36:                          ; preds = %for.body4.lr.ph.us.us36.preheader, %middle.block.us
  %res.029.us.us37 = phi i32 [ %bin.rdx.us, %middle.block.us ], [ 0, %for.body4.lr.ph.us.us36.preheader ]
  %i.028.us.us38 = phi i32 [ %inc12.us.us42, %middle.block.us ], [ 0, %for.body4.lr.ph.us.us36.preheader ]
  %mul.us.us39 = mul nsw i32 %i.028.us.us38, %cols
  br label %vector.body.us

middle.block.us:                                  ; preds = %vector.body.us
  %bin.rdx.us = add i32 %18, %17
  %inc12.us.us42 = add nuw nsw i32 %i.028.us.us38, 1
  %cmp.us.us43 = icmp slt i32 %inc12.us.us42, %rows
  br i1 %cmp.us.us43, label %for.body4.lr.ph.us.us36, label %for.cond.cleanup, !llvm.loop !34

vector.body.us:                                   ; preds = %vector.body.us, %for.body4.lr.ph.us.us36
  %index.us = phi i32 [ 0, %for.body4.lr.ph.us.us36 ], [ %index.next.us, %vector.body.us ]
  %vec.phi.us = phi i32 [ %res.029.us.us37, %for.body4.lr.ph.us.us36 ], [ %17, %vector.body.us ]
  %vec.phi33.us = phi i32 [ 0, %for.body4.lr.ph.us.us36 ], [ %18, %vector.body.us ]
  %2 = add nuw nsw i32 %index.us, 1
  %3 = add nsw i32 %index.us, %mul.us.us39
  %4 = add nsw i32 %2, %mul.us.us39
  %5 = getelementptr inbounds i32, ptr %input1, i32 %3
  %6 = getelementptr inbounds i32, ptr %input1, i32 %4
  %7 = load i32, ptr %5, align 4, !tbaa !3
  %8 = load i32, ptr %6, align 4, !tbaa !3
  %9 = getelementptr inbounds i32, ptr %input2, i32 %3
  %10 = getelementptr inbounds i32, ptr %input2, i32 %4
  %11 = load i32, ptr %9, align 4, !tbaa !3
  %12 = load i32, ptr %10, align 4, !tbaa !3
  %13 = sub nsw i32 %7, %11
  %14 = sub nsw i32 %8, %12
  %15 = tail call i32 @llvm.abs.i32(i32 %13, i1 true)
  %16 = tail call i32 @llvm.abs.i32(i32 %14, i1 true)
  %17 = add i32 %15, %vec.phi.us
  %18 = add i32 %16, %vec.phi33.us
  %index.next.us = add nuw i32 %index.us, 2
  %19 = icmp eq i32 %index.next.us, %cols
  br i1 %19, label %middle.block.us, label %vector.body.us, !llvm.loop !38

for.cond.cleanup3.us:                             ; preds = %for.body4.us
  %inc12.us = add nuw nsw i32 %i.028.us, 1
  %cmp.us = icmp slt i32 %inc12.us, %rows
  br i1 %cmp.us, label %for.body4.lr.ph.us, label %for.cond.cleanup, !llvm.loop !34

for.body4.us:                                     ; preds = %middle.block, %for.body4.us
  %res.126.us = phi i32 [ %bin.rdx, %middle.block ], [ %add10.us, %for.body4.us ]
  %j.025.us = phi i32 [ %n.vec, %middle.block ], [ %inc.us, %for.body4.us ]
  %add.us = add nsw i32 %j.025.us, %mul.us
  %arrayidx.us = getelementptr inbounds i32, ptr %input1, i32 %add.us
  %20 = load i32, ptr %arrayidx.us, align 4, !tbaa !3
  %arrayidx7.us = getelementptr inbounds i32, ptr %input2, i32 %add.us
  %21 = load i32, ptr %arrayidx7.us, align 4, !tbaa !3
  %sub.us = sub nsw i32 %20, %21
  %cond.us = tail call i32 @llvm.abs.i32(i32 %sub.us, i1 true)
  %add10.us = add nsw i32 %cond.us, %res.126.us
  %inc.us = add nuw nsw i32 %j.025.us, 1
  %cmp2.us = icmp slt i32 %inc.us, %cols
  br i1 %cmp2.us, label %for.body4.us, label %for.cond.cleanup3.us, !llvm.loop !31

for.body4.lr.ph.us:                               ; preds = %for.body4.lr.ph.us.preheader, %for.cond.cleanup3.us
  %res.029.us = phi i32 [ %add10.us, %for.cond.cleanup3.us ], [ 0, %for.body4.lr.ph.us.preheader ]
  %i.028.us = phi i32 [ %inc12.us, %for.cond.cleanup3.us ], [ 0, %for.body4.lr.ph.us.preheader ]
  %mul.us = mul nsw i32 %i.028.us, %cols
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %for.body4.lr.ph.us
  %index = phi i32 [ 0, %for.body4.lr.ph.us ], [ %index.next, %vector.body ]
  %vec.phi = phi i32 [ %res.029.us, %for.body4.lr.ph.us ], [ %37, %vector.body ]
  %vec.phi33 = phi i32 [ 0, %for.body4.lr.ph.us ], [ %38, %vector.body ]
  %22 = add nuw nsw i32 %index, 1
  %23 = add nsw i32 %index, %mul.us
  %24 = add nsw i32 %22, %mul.us
  %25 = getelementptr inbounds i32, ptr %input1, i32 %23
  %26 = getelementptr inbounds i32, ptr %input1, i32 %24
  %27 = load i32, ptr %25, align 4, !tbaa !3
  %28 = load i32, ptr %26, align 4, !tbaa !3
  %29 = getelementptr inbounds i32, ptr %input2, i32 %23
  %30 = getelementptr inbounds i32, ptr %input2, i32 %24
  %31 = load i32, ptr %29, align 4, !tbaa !3
  %32 = load i32, ptr %30, align 4, !tbaa !3
  %33 = sub nsw i32 %27, %31
  %34 = sub nsw i32 %28, %32
  %35 = tail call i32 @llvm.abs.i32(i32 %33, i1 true)
  %36 = tail call i32 @llvm.abs.i32(i32 %34, i1 true)
  %37 = add i32 %35, %vec.phi
  %38 = add i32 %36, %vec.phi33
  %index.next = add nuw i32 %index, 2
  %39 = icmp eq i32 %index.next, %n.vec
  br i1 %39, label %middle.block, label %vector.body, !llvm.loop !38

middle.block:                                     ; preds = %vector.body
  %bin.rdx = add i32 %38, %37
  br label %for.body4.us

for.cond.cleanup:                                 ; preds = %for.cond.cleanup3.us, %middle.block.us, %for.cond.cleanup3.us.loopexit.us, %entry
  %res.0.lcssa = phi i32 [ 0, %entry ], [ %add10.us.us, %for.cond.cleanup3.us.loopexit.us ], [ %bin.rdx.us, %middle.block.us ], [ %add10.us, %for.cond.cleanup3.us ]
  ret i32 %res.0.lcssa
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define dso_local i32 @vectorized_sad2d(i32 noundef %rows, i32 noundef %cols, ptr addrspace(4) noalias nocapture noundef readnone %input1, ptr addrspace(4) noalias nocapture noundef readnone %input2) local_unnamed_addr #4 {
entry:
  ret i32 -1
}

; Function Attrs: mustprogress nofree nosync nounwind willreturn memory(argmem: read)
define dso_local i32 @autovectorized_sad2d(i32 noundef %rows, i32 noundef %cols, ptr addrspace(4) noalias nocapture noundef readonly %input1, ptr addrspace(4) noalias nocapture noundef readonly %input2) local_unnamed_addr #3 {
entry:
  %cmp27 = icmp sgt i32 %rows, 0
  %cmp224 = icmp sgt i32 %cols, 0
  %or.cond = and i1 %cmp27, %cmp224
  br i1 %or.cond, label %for.body.lr.ph.split.us, label %for.cond.cleanup

for.body.lr.ph.split.us:                          ; preds = %entry
  %min.iters.check = icmp ult i32 %cols, 8
  %n.vec = and i32 %cols, -64
  %cmp.n = icmp eq i32 %n.vec, %cols
  %n.vec.remaining = and i32 %cols, 56
  %min.epilog.iters.check = icmp eq i32 %n.vec.remaining, 0
  %n.vec47 = and i32 %cols, -8
  %cmp.n48 = icmp eq i32 %n.vec47, %cols
  br i1 %min.iters.check, label %iter.check.us.preheader, label %for.body.lr.ph.split.us.split

iter.check.us.preheader:                          ; preds = %for.body.lr.ph.split.us
  br label %iter.check.us

iter.check.us:                                    ; preds = %iter.check.us.preheader, %for.cond.cleanup3.us.loopexit.us
  %res.029.us.us = phi i32 [ %add10.us.us, %for.cond.cleanup3.us.loopexit.us ], [ 0, %iter.check.us.preheader ]
  %i.028.us.us = phi i32 [ %inc12.us.us, %for.cond.cleanup3.us.loopexit.us ], [ 0, %iter.check.us.preheader ]
  %mul.us.us = mul nsw i32 %i.028.us.us, %cols
  br label %for.body4.us.us

for.body4.us.us:                                  ; preds = %iter.check.us, %for.body4.us.us
  %res.126.us.us = phi i32 [ %res.029.us.us, %iter.check.us ], [ %add10.us.us, %for.body4.us.us ]
  %j.025.us.us = phi i32 [ 0, %iter.check.us ], [ %inc.us.us, %for.body4.us.us ]
  %add.us.us = add nsw i32 %j.025.us.us, %mul.us.us
  %arrayidx.us.us = getelementptr inbounds i32, ptr addrspace(4) %input1, i32 %add.us.us
  %0 = load i32, ptr addrspace(4) %arrayidx.us.us, align 4, !tbaa !3
  %arrayidx7.us.us = getelementptr inbounds i32, ptr addrspace(4) %input2, i32 %add.us.us
  %1 = load i32, ptr addrspace(4) %arrayidx7.us.us, align 4, !tbaa !3
  %sub.us.us = sub nsw i32 %0, %1
  %cond.us.us = tail call i32 @llvm.abs.i32(i32 %sub.us.us, i1 true)
  %add10.us.us = add nsw i32 %cond.us.us, %res.126.us.us
  %inc.us.us = add nuw nsw i32 %j.025.us.us, 1
  %cmp2.us.us = icmp slt i32 %inc.us.us, %cols
  br i1 %cmp2.us.us, label %for.body4.us.us, label %for.cond.cleanup3.us.loopexit.us, !llvm.loop !39

for.cond.cleanup3.us.loopexit.us:                 ; preds = %for.body4.us.us
  %inc12.us.us = add nuw nsw i32 %i.028.us.us, 1
  %cmp.us.us = icmp slt i32 %inc12.us.us, %rows
  br i1 %cmp.us.us, label %iter.check.us, label %for.cond.cleanup, !llvm.loop !40

for.body.lr.ph.split.us.split:                    ; preds = %for.body.lr.ph.split.us
  %min.iters.check33 = icmp ult i32 %cols, 64
  br i1 %min.iters.check33, label %iter.check.us60.preheader, label %for.body.lr.ph.split.us.split.split

iter.check.us60.preheader:                        ; preds = %for.body.lr.ph.split.us.split
  br label %iter.check.us60

iter.check.us60:                                  ; preds = %iter.check.us60.preheader, %for.cond.cleanup3.us.us75
  %res.029.us.us61 = phi i32 [ %add10.us.lcssa.us76, %for.cond.cleanup3.us.us75 ], [ 0, %iter.check.us60.preheader ]
  %i.028.us.us62 = phi i32 [ %inc12.us.us77, %for.cond.cleanup3.us.us75 ], [ 0, %iter.check.us60.preheader ]
  %mul.us.us63 = mul nsw i32 %i.028.us.us62, %cols
  %2 = insertelement <8 x i32> <i32 poison, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, i32 %res.029.us.us61, i64 0
  br label %vec.epilog.vector.body.us

for.body4.us.us64:                                ; preds = %for.body4.us.us64.preheader, %for.body4.us.us64
  %res.126.us.us65 = phi i32 [ %add10.us.us72, %for.body4.us.us64 ], [ %5, %for.body4.us.us64.preheader ]
  %j.025.us.us66 = phi i32 [ %inc.us.us73, %for.body4.us.us64 ], [ %n.vec47, %for.body4.us.us64.preheader ]
  %add.us.us67 = add nsw i32 %j.025.us.us66, %mul.us.us63
  %arrayidx.us.us68 = getelementptr inbounds i32, ptr addrspace(4) %input1, i32 %add.us.us67
  %3 = load i32, ptr addrspace(4) %arrayidx.us.us68, align 4, !tbaa !3
  %arrayidx7.us.us69 = getelementptr inbounds i32, ptr addrspace(4) %input2, i32 %add.us.us67
  %4 = load i32, ptr addrspace(4) %arrayidx7.us.us69, align 4, !tbaa !3
  %sub.us.us70 = sub nsw i32 %3, %4
  %cond.us.us71 = tail call i32 @llvm.abs.i32(i32 %sub.us.us70, i1 true)
  %add10.us.us72 = add nsw i32 %cond.us.us71, %res.126.us.us65
  %inc.us.us73 = add nuw nsw i32 %j.025.us.us66, 1
  %cmp2.us.us74 = icmp slt i32 %inc.us.us73, %cols
  br i1 %cmp2.us.us74, label %for.body4.us.us64, label %for.cond.cleanup3.us.us75, !llvm.loop !39

for.cond.cleanup3.us.us75:                        ; preds = %for.body4.us.us64, %vec.epilog.middle.block.us
  %add10.us.lcssa.us76 = phi i32 [ %5, %vec.epilog.middle.block.us ], [ %add10.us.us72, %for.body4.us.us64 ]
  %inc12.us.us77 = add nuw nsw i32 %i.028.us.us62, 1
  %cmp.us.us78 = icmp slt i32 %inc12.us.us77, %rows
  br i1 %cmp.us.us78, label %iter.check.us60, label %for.cond.cleanup, !llvm.loop !40

vec.epilog.middle.block.us:                       ; preds = %vec.epilog.vector.body.us
  %5 = tail call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %11)
  br i1 %cmp.n48, label %for.cond.cleanup3.us.us75, label %for.body4.us.us64.preheader

for.body4.us.us64.preheader:                      ; preds = %vec.epilog.middle.block.us
  br label %for.body4.us.us64

vec.epilog.vector.body.us:                        ; preds = %vec.epilog.vector.body.us, %iter.check.us60
  %index49.us = phi i32 [ 0, %iter.check.us60 ], [ %index.next53.us, %vec.epilog.vector.body.us ]
  %vec.phi50.us = phi <8 x i32> [ %2, %iter.check.us60 ], [ %11, %vec.epilog.vector.body.us ]
  %6 = add nsw i32 %index49.us, %mul.us.us63
  %7 = getelementptr inbounds i32, ptr addrspace(4) %input1, i32 %6
  %wide.load51.us = load <8 x i32>, ptr addrspace(4) %7, align 4, !tbaa !3
  %8 = getelementptr inbounds i32, ptr addrspace(4) %input2, i32 %6
  %wide.load52.us = load <8 x i32>, ptr addrspace(4) %8, align 4, !tbaa !3
  %9 = sub nsw <8 x i32> %wide.load51.us, %wide.load52.us
  %10 = tail call <8 x i32> @llvm.abs.v8i32(<8 x i32> %9, i1 true)
  %11 = add <8 x i32> %10, %vec.phi50.us
  %index.next53.us = add nuw i32 %index49.us, 8
  %12 = icmp eq i32 %index.next53.us, %n.vec47
  br i1 %12, label %vec.epilog.middle.block.us, label %vec.epilog.vector.body.us, !llvm.loop !41

for.body.lr.ph.split.us.split.split:              ; preds = %for.body.lr.ph.split.us.split
  br i1 %cmp.n, label %iter.check.us86.preheader, label %iter.check.preheader

iter.check.preheader:                             ; preds = %for.body.lr.ph.split.us.split.split
  br label %iter.check

iter.check.us86.preheader:                        ; preds = %for.body.lr.ph.split.us.split.split
  br label %iter.check.us86

iter.check.us86:                                  ; preds = %iter.check.us86.preheader, %middle.block.us
  %res.029.us.us87 = phi i32 [ %14, %middle.block.us ], [ 0, %iter.check.us86.preheader ]
  %i.028.us.us88 = phi i32 [ %inc12.us.us92, %middle.block.us ], [ 0, %iter.check.us86.preheader ]
  %mul.us.us89 = mul nsw i32 %i.028.us.us88, %cols
  %13 = insertelement <16 x i32> <i32 poison, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, i32 %res.029.us.us87, i64 0
  br label %vector.body.us

middle.block.us:                                  ; preds = %vector.body.us
  %bin.rdx.us = add <16 x i32> %33, %32
  %bin.rdx44.us = add <16 x i32> %34, %bin.rdx.us
  %bin.rdx45.us = add <16 x i32> %35, %bin.rdx44.us
  %14 = tail call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %bin.rdx45.us)
  %inc12.us.us92 = add nuw nsw i32 %i.028.us.us88, 1
  %cmp.us.us93 = icmp slt i32 %inc12.us.us92, %rows
  br i1 %cmp.us.us93, label %iter.check.us86, label %for.cond.cleanup, !llvm.loop !40

vector.body.us:                                   ; preds = %vector.body.us, %iter.check.us86
  %index.us = phi i32 [ 0, %iter.check.us86 ], [ %index.next.us, %vector.body.us ]
  %vec.phi.us = phi <16 x i32> [ %13, %iter.check.us86 ], [ %32, %vector.body.us ]
  %vec.phi34.us = phi <16 x i32> [ zeroinitializer, %iter.check.us86 ], [ %33, %vector.body.us ]
  %vec.phi35.us = phi <16 x i32> [ zeroinitializer, %iter.check.us86 ], [ %34, %vector.body.us ]
  %vec.phi36.us = phi <16 x i32> [ zeroinitializer, %iter.check.us86 ], [ %35, %vector.body.us ]
  %15 = add nsw i32 %index.us, %mul.us.us89
  %16 = getelementptr inbounds i32, ptr addrspace(4) %input1, i32 %15
  %wide.load.us = load <16 x i32>, ptr addrspace(4) %16, align 4, !tbaa !3
  %17 = getelementptr inbounds i32, ptr addrspace(4) %16, i32 16
  %wide.load37.us = load <16 x i32>, ptr addrspace(4) %17, align 4, !tbaa !3
  %18 = getelementptr inbounds i32, ptr addrspace(4) %16, i32 32
  %wide.load38.us = load <16 x i32>, ptr addrspace(4) %18, align 4, !tbaa !3
  %19 = getelementptr inbounds i32, ptr addrspace(4) %16, i32 48
  %wide.load39.us = load <16 x i32>, ptr addrspace(4) %19, align 4, !tbaa !3
  %20 = getelementptr inbounds i32, ptr addrspace(4) %input2, i32 %15
  %wide.load40.us = load <16 x i32>, ptr addrspace(4) %20, align 4, !tbaa !3
  %21 = getelementptr inbounds i32, ptr addrspace(4) %20, i32 16
  %wide.load41.us = load <16 x i32>, ptr addrspace(4) %21, align 4, !tbaa !3
  %22 = getelementptr inbounds i32, ptr addrspace(4) %20, i32 32
  %wide.load42.us = load <16 x i32>, ptr addrspace(4) %22, align 4, !tbaa !3
  %23 = getelementptr inbounds i32, ptr addrspace(4) %20, i32 48
  %wide.load43.us = load <16 x i32>, ptr addrspace(4) %23, align 4, !tbaa !3
  %24 = sub nsw <16 x i32> %wide.load.us, %wide.load40.us
  %25 = sub nsw <16 x i32> %wide.load37.us, %wide.load41.us
  %26 = sub nsw <16 x i32> %wide.load38.us, %wide.load42.us
  %27 = sub nsw <16 x i32> %wide.load39.us, %wide.load43.us
  %28 = tail call <16 x i32> @llvm.abs.v16i32(<16 x i32> %24, i1 true)
  %29 = tail call <16 x i32> @llvm.abs.v16i32(<16 x i32> %25, i1 true)
  %30 = tail call <16 x i32> @llvm.abs.v16i32(<16 x i32> %26, i1 true)
  %31 = tail call <16 x i32> @llvm.abs.v16i32(<16 x i32> %27, i1 true)
  %32 = add <16 x i32> %28, %vec.phi.us
  %33 = add <16 x i32> %29, %vec.phi34.us
  %34 = add <16 x i32> %30, %vec.phi35.us
  %35 = add <16 x i32> %31, %vec.phi36.us
  %index.next.us = add nuw i32 %index.us, 64
  %36 = icmp eq i32 %index.next.us, %cols
  br i1 %36, label %middle.block.us, label %vector.body.us, !llvm.loop !42

for.cond.cleanup3.us:                             ; preds = %for.body4.us, %vec.epilog.middle.block
  %add10.us.lcssa = phi i32 [ %71, %vec.epilog.middle.block ], [ %add10.us, %for.body4.us ]
  %inc12.us = add nuw nsw i32 %i.028.us, 1
  %cmp.us = icmp slt i32 %inc12.us, %rows
  br i1 %cmp.us, label %iter.check, label %for.cond.cleanup, !llvm.loop !40

for.body4.us:                                     ; preds = %for.body4.us.preheader, %for.body4.us
  %res.126.us = phi i32 [ %add10.us, %for.body4.us ], [ %res.126.us.ph, %for.body4.us.preheader ]
  %j.025.us = phi i32 [ %inc.us, %for.body4.us ], [ %j.025.us.ph, %for.body4.us.preheader ]
  %add.us = add nsw i32 %j.025.us, %mul.us
  %arrayidx.us = getelementptr inbounds i32, ptr addrspace(4) %input1, i32 %add.us
  %37 = load i32, ptr addrspace(4) %arrayidx.us, align 4, !tbaa !3
  %arrayidx7.us = getelementptr inbounds i32, ptr addrspace(4) %input2, i32 %add.us
  %38 = load i32, ptr addrspace(4) %arrayidx7.us, align 4, !tbaa !3
  %sub.us = sub nsw i32 %37, %38
  %cond.us = tail call i32 @llvm.abs.i32(i32 %sub.us, i1 true)
  %add10.us = add nsw i32 %cond.us, %res.126.us
  %inc.us = add nuw nsw i32 %j.025.us, 1
  %cmp2.us = icmp slt i32 %inc.us, %cols
  br i1 %cmp2.us, label %for.body4.us, label %for.cond.cleanup3.us, !llvm.loop !39

iter.check:                                       ; preds = %iter.check.preheader, %for.cond.cleanup3.us
  %res.029.us = phi i32 [ %add10.us.lcssa, %for.cond.cleanup3.us ], [ 0, %iter.check.preheader ]
  %i.028.us = phi i32 [ %inc12.us, %for.cond.cleanup3.us ], [ 0, %iter.check.preheader ]
  %mul.us = mul nsw i32 %i.028.us, %cols
  %39 = insertelement <16 x i32> <i32 poison, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, i32 %res.029.us, i64 0
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %iter.check
  %index = phi i32 [ 0, %iter.check ], [ %index.next, %vector.body ]
  %vec.phi = phi <16 x i32> [ %39, %iter.check ], [ %57, %vector.body ]
  %vec.phi34 = phi <16 x i32> [ zeroinitializer, %iter.check ], [ %58, %vector.body ]
  %vec.phi35 = phi <16 x i32> [ zeroinitializer, %iter.check ], [ %59, %vector.body ]
  %vec.phi36 = phi <16 x i32> [ zeroinitializer, %iter.check ], [ %60, %vector.body ]
  %40 = add nsw i32 %index, %mul.us
  %41 = getelementptr inbounds i32, ptr addrspace(4) %input1, i32 %40
  %wide.load = load <16 x i32>, ptr addrspace(4) %41, align 4, !tbaa !3
  %42 = getelementptr inbounds i32, ptr addrspace(4) %41, i32 16
  %wide.load37 = load <16 x i32>, ptr addrspace(4) %42, align 4, !tbaa !3
  %43 = getelementptr inbounds i32, ptr addrspace(4) %41, i32 32
  %wide.load38 = load <16 x i32>, ptr addrspace(4) %43, align 4, !tbaa !3
  %44 = getelementptr inbounds i32, ptr addrspace(4) %41, i32 48
  %wide.load39 = load <16 x i32>, ptr addrspace(4) %44, align 4, !tbaa !3
  %45 = getelementptr inbounds i32, ptr addrspace(4) %input2, i32 %40
  %wide.load40 = load <16 x i32>, ptr addrspace(4) %45, align 4, !tbaa !3
  %46 = getelementptr inbounds i32, ptr addrspace(4) %45, i32 16
  %wide.load41 = load <16 x i32>, ptr addrspace(4) %46, align 4, !tbaa !3
  %47 = getelementptr inbounds i32, ptr addrspace(4) %45, i32 32
  %wide.load42 = load <16 x i32>, ptr addrspace(4) %47, align 4, !tbaa !3
  %48 = getelementptr inbounds i32, ptr addrspace(4) %45, i32 48
  %wide.load43 = load <16 x i32>, ptr addrspace(4) %48, align 4, !tbaa !3
  %49 = sub nsw <16 x i32> %wide.load, %wide.load40
  %50 = sub nsw <16 x i32> %wide.load37, %wide.load41
  %51 = sub nsw <16 x i32> %wide.load38, %wide.load42
  %52 = sub nsw <16 x i32> %wide.load39, %wide.load43
  %53 = tail call <16 x i32> @llvm.abs.v16i32(<16 x i32> %49, i1 true)
  %54 = tail call <16 x i32> @llvm.abs.v16i32(<16 x i32> %50, i1 true)
  %55 = tail call <16 x i32> @llvm.abs.v16i32(<16 x i32> %51, i1 true)
  %56 = tail call <16 x i32> @llvm.abs.v16i32(<16 x i32> %52, i1 true)
  %57 = add <16 x i32> %53, %vec.phi
  %58 = add <16 x i32> %54, %vec.phi34
  %59 = add <16 x i32> %55, %vec.phi35
  %60 = add <16 x i32> %56, %vec.phi36
  %index.next = add nuw i32 %index, 64
  %61 = icmp eq i32 %index.next, %n.vec
  br i1 %61, label %middle.block, label %vector.body, !llvm.loop !42

middle.block:                                     ; preds = %vector.body
  %bin.rdx = add <16 x i32> %58, %57
  %bin.rdx44 = add <16 x i32> %59, %bin.rdx
  %bin.rdx45 = add <16 x i32> %60, %bin.rdx44
  %62 = tail call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %bin.rdx45)
  br i1 %min.epilog.iters.check, label %for.body4.us.preheader, label %vec.epilog.ph

vec.epilog.ph:                                    ; preds = %middle.block
  %63 = insertelement <8 x i32> <i32 poison, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, i32 %62, i64 0
  br label %vec.epilog.vector.body

vec.epilog.vector.body:                           ; preds = %vec.epilog.vector.body, %vec.epilog.ph
  %index49 = phi i32 [ %n.vec, %vec.epilog.ph ], [ %index.next53, %vec.epilog.vector.body ]
  %vec.phi50 = phi <8 x i32> [ %63, %vec.epilog.ph ], [ %69, %vec.epilog.vector.body ]
  %64 = add nsw i32 %index49, %mul.us
  %65 = getelementptr inbounds i32, ptr addrspace(4) %input1, i32 %64
  %wide.load51 = load <8 x i32>, ptr addrspace(4) %65, align 4, !tbaa !3
  %66 = getelementptr inbounds i32, ptr addrspace(4) %input2, i32 %64
  %wide.load52 = load <8 x i32>, ptr addrspace(4) %66, align 4, !tbaa !3
  %67 = sub nsw <8 x i32> %wide.load51, %wide.load52
  %68 = tail call <8 x i32> @llvm.abs.v8i32(<8 x i32> %67, i1 true)
  %69 = add <8 x i32> %68, %vec.phi50
  %index.next53 = add nuw i32 %index49, 8
  %70 = icmp eq i32 %index.next53, %n.vec47
  br i1 %70, label %vec.epilog.middle.block, label %vec.epilog.vector.body, !llvm.loop !41

vec.epilog.middle.block:                          ; preds = %vec.epilog.vector.body
  %71 = tail call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %69)
  br i1 %cmp.n48, label %for.cond.cleanup3.us, label %for.body4.us.preheader

for.body4.us.preheader:                           ; preds = %middle.block, %vec.epilog.middle.block
  %res.126.us.ph = phi i32 [ %62, %middle.block ], [ %71, %vec.epilog.middle.block ]
  %j.025.us.ph = phi i32 [ %n.vec, %middle.block ], [ %n.vec47, %vec.epilog.middle.block ]
  br label %for.body4.us

for.cond.cleanup:                                 ; preds = %for.cond.cleanup3.us, %middle.block.us, %for.cond.cleanup3.us.us75, %for.cond.cleanup3.us.loopexit.us, %entry
  %res.0.lcssa = phi i32 [ 0, %entry ], [ %add10.us.us, %for.cond.cleanup3.us.loopexit.us ], [ %add10.us.lcssa.us76, %for.cond.cleanup3.us.us75 ], [ %14, %middle.block.us ], [ %add10.us.lcssa, %for.cond.cleanup3.us ]
  ret i32 %res.0.lcssa
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define dso_local i32 @vekt_sad2d_wrapper(i32 noundef %rows, i32 noundef %cols, ptr nocapture noundef readnone %input1, ptr nocapture noundef readnone %input2) local_unnamed_addr #4 {
entry:
  ret i32 -1
}

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #5

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.abs.i32(i32, i1 immarg) #6

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <16 x i32> @llvm.abs.v16i32(<16 x i32>, i1 immarg) #6

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.add.v16i32(<16 x i32>) #6

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <8 x i32> @llvm.abs.v8i32(<8 x i32>, i1 immarg) #6

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.add.v8i32(<8 x i32>) #6

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: write) "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #1 = { nofree nounwind "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #2 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite) "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #3 = { mustprogress nofree nosync nounwind willreturn memory(argmem: read) "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #4 = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #5 = { nofree nounwind }
attributes #6 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

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
!31 = distinct !{!31, !32}
!32 = distinct !{!32, !8, !33}
!33 = !{!"llvm.loop.isvectorized"}
!34 = distinct !{!34, !8, !35, !36}
!35 = !{!"llvm.loop.vectorize.width", i32 1}
!36 = !{!"llvm.loop.vectorize.followup_all", !37}
!37 = distinct !{!37, !8, !33}
!38 = distinct !{!38, !32, !10}
!39 = distinct !{!39, !8, !10, !9}
!40 = distinct !{!40, !8}
!41 = distinct !{!41, !8, !9, !10}
!42 = distinct !{!42, !8, !9, !10}
