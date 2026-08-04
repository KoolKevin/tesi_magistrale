; ModuleID = 'max_pooling.c'
source_filename = "max_pooling.c"
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

; Function Attrs: mustprogress nofree nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @max_pooling(i32 noundef %rows_out, i32 noundef %cols_out, i32 noundef %rows_in, i32 noundef %cols_in, i32 noundef %W, ptr nocapture noundef writeonly %output, ptr nocapture noundef readonly %input) local_unnamed_addr #3 {
entry:
  %cmp89 = icmp sgt i32 %rows_out, 0
  %cmp278 = icmp sgt i32 %cols_out, 0
  %or.cond = and i1 %cmp89, %cmp278
  br i1 %or.cond, label %for.body.lr.ph.split.us, label %for.cond.cleanup

for.body.lr.ph.split.us:                          ; preds = %entry
  %cmp874 = icmp sgt i32 %W, 0
  br i1 %cmp874, label %for.body.lr.ph.split.us.split.us.split.us, label %for.body4.lr.ph.split.us102.preheader

for.body4.lr.ph.split.us102.preheader:            ; preds = %for.body.lr.ph.split.us
  br label %for.body4.lr.ph.split.us102

for.body.lr.ph.split.us.split.us.split.us:        ; preds = %for.body.lr.ph.split.us
  %min.iters.check = icmp eq i32 %W, 1
  %n.vec = and i32 %W, -2
  %cmp.n = icmp eq i32 %n.vec, %W
  br i1 %min.iters.check, label %for.body4.lr.ph.split.us.split.us.us.us.us.us.preheader, label %for.body4.lr.ph.split.us.split.us.us.us.us.preheader

for.body4.lr.ph.split.us.split.us.us.us.us.preheader: ; preds = %for.body.lr.ph.split.us.split.us.split.us
  br label %for.body4.lr.ph.split.us.split.us.us.us.us

for.body4.lr.ph.split.us.split.us.us.us.us.us.preheader: ; preds = %for.body.lr.ph.split.us.split.us.split.us
  br label %for.body4.lr.ph.split.us.split.us.us.us.us.us

for.body4.lr.ph.split.us.split.us.us.us.us.us:    ; preds = %for.body4.lr.ph.split.us.split.us.us.us.us.us.preheader, %for.cond.cleanup3.us.us.us.split.us.us
  %i.090.us.us.us.us = phi i32 [ %inc40.us.us.us.us, %for.cond.cleanup3.us.us.us.split.us.us ], [ 0, %for.body4.lr.ph.split.us.split.us.us.us.us.us.preheader ]
  %mul5.us.us.us.us = mul nsw i32 %i.090.us.us.us.us, %cols_in
  %mul33.us.us.us.us = mul nsw i32 %i.090.us.us.us.us, %cols_out
  br label %for.cond.cleanup9.us.us.us.us.us.split.us.us.us

for.cond.cleanup9.us.us.us.us.us.split.us.us.us:  ; preds = %for.body4.lr.ph.split.us.split.us.us.us.us.us, %for.cond.cleanup9.us.us.us.us.us.split.us.us.us
  %j.079.us.us.us.us.us.us.us = phi i32 [ 0, %for.body4.lr.ph.split.us.split.us.us.us.us.us ], [ %inc37.us.us.us.us.us.us.us, %for.cond.cleanup9.us.us.us.us.us.split.us.us.us ]
  %add.us.us.us.us.us.us.us = add i32 %j.079.us.us.us.us.us.us.us, %mul5.us.us.us.us
  %arrayidx.us.us.us.us.us.us.us = getelementptr inbounds i32, ptr %input, i32 %add.us.us.us.us.us.us.us
  %0 = load i32, ptr %arrayidx.us.us.us.us.us.us.us, align 4, !tbaa !3
  %add34.us.us.us.us.us.us.us = add nsw i32 %j.079.us.us.us.us.us.us.us, %mul33.us.us.us.us
  %arrayidx35.us.us.us.us.us.us.us = getelementptr inbounds i32, ptr %output, i32 %add34.us.us.us.us.us.us.us
  store i32 %0, ptr %arrayidx35.us.us.us.us.us.us.us, align 4, !tbaa !3
  %inc37.us.us.us.us.us.us.us = add nuw nsw i32 %j.079.us.us.us.us.us.us.us, 1
  %cmp2.us.us.us.us.us.us.us = icmp slt i32 %inc37.us.us.us.us.us.us.us, %cols_out
  br i1 %cmp2.us.us.us.us.us.us.us, label %for.cond.cleanup9.us.us.us.us.us.split.us.us.us, label %for.cond.cleanup3.us.us.us.split.us.us, !llvm.loop !31

for.cond.cleanup3.us.us.us.split.us.us:           ; preds = %for.cond.cleanup9.us.us.us.us.us.split.us.us.us
  %inc40.us.us.us.us = add nuw nsw i32 %i.090.us.us.us.us, 1
  %cmp.us.us.us.us = icmp slt i32 %inc40.us.us.us.us, %rows_out
  br i1 %cmp.us.us.us.us, label %for.body4.lr.ph.split.us.split.us.us.us.us.us, label %for.cond.cleanup, !llvm.loop !36

for.cond.cleanup3.us.us.us:                       ; preds = %for.cond.cleanup9.us.us.us.us.us
  %inc40.us.us.us = add nuw nsw i32 %i.090.us.us.us, 1
  %cmp.us.us.us = icmp slt i32 %inc40.us.us.us, %rows_out
  br i1 %cmp.us.us.us, label %for.body4.lr.ph.split.us.split.us.us.us.us, label %for.cond.cleanup, !llvm.loop !36

for.body4.lr.ph.split.us.split.us.us.us.us:       ; preds = %for.body4.lr.ph.split.us.split.us.us.us.us.preheader, %for.cond.cleanup3.us.us.us
  %i.090.us.us.us = phi i32 [ %inc40.us.us.us, %for.cond.cleanup3.us.us.us ], [ 0, %for.body4.lr.ph.split.us.split.us.us.us.us.preheader ]
  %mul.us.us.us = mul nsw i32 %i.090.us.us.us, %W
  %mul5.us.us.us = mul nsw i32 %mul.us.us.us, %cols_in
  %mul33.us.us.us = mul nsw i32 %i.090.us.us.us, %cols_out
  br label %for.body10.lr.ph.split.us.us.us.us.us.us

for.cond.cleanup9.us.us.us.us.us:                 ; preds = %for.cond.cleanup13.us.us.us.us.us.us
  %add34.us.us.us.us.us = add nsw i32 %j.079.us.us.us.us.us, %mul33.us.us.us
  %arrayidx35.us.us.us.us.us = getelementptr inbounds i32, ptr %output, i32 %add34.us.us.us.us.us
  store i32 %spec.select.us.us.us.us.us.us.lcssa, ptr %arrayidx35.us.us.us.us.us, align 4, !tbaa !3
  %inc37.us.us.us.us.us = add nuw nsw i32 %j.079.us.us.us.us.us, 1
  %cmp2.us.us.us.us.us = icmp slt i32 %inc37.us.us.us.us.us, %cols_out
  br i1 %cmp2.us.us.us.us.us, label %for.body10.lr.ph.split.us.us.us.us.us.us, label %for.cond.cleanup3.us.us.us, !llvm.loop !31

for.body10.lr.ph.split.us.us.us.us.us.us:         ; preds = %for.cond.cleanup9.us.us.us.us.us, %for.body4.lr.ph.split.us.split.us.us.us.us
  %j.079.us.us.us.us.us = phi i32 [ 0, %for.body4.lr.ph.split.us.split.us.us.us.us ], [ %inc37.us.us.us.us.us, %for.cond.cleanup9.us.us.us.us.us ]
  %mul6.us.us.us.us.us = mul nsw i32 %j.079.us.us.us.us.us, %W
  %add.us.us.us.us.us = add nsw i32 %mul6.us.us.us.us.us, %mul5.us.us.us
  %arrayidx.us.us.us.us.us = getelementptr inbounds i32, ptr %input, i32 %add.us.us.us.us.us
  %1 = load i32, ptr %arrayidx.us.us.us.us.us, align 4, !tbaa !3
  br label %for.body14.lr.ph.us.us.us.us.us.us

for.cond.cleanup13.us.us.us.us.us.us:             ; preds = %for.body14.us.us.us.us.us.us, %middle.block
  %spec.select.us.us.us.us.us.us.lcssa = phi i32 [ %11, %middle.block ], [ %spec.select.us.us.us.us.us.us, %for.body14.us.us.us.us.us.us ]
  %inc31.us.us.us.us.us.us = add nuw nsw i32 %w_i.076.us.us.us.us.us.us, 1
  %cmp8.us.us.us.us.us.us = icmp slt i32 %inc31.us.us.us.us.us.us, %W
  br i1 %cmp8.us.us.us.us.us.us, label %for.body14.lr.ph.us.us.us.us.us.us, label %for.cond.cleanup9.us.us.us.us.us, !llvm.loop !39

for.body14.us.us.us.us.us.us:                     ; preds = %for.body14.us.us.us.us.us.us.preheader, %for.body14.us.us.us.us.us.us
  %w_j.073.us.us.us.us.us.us = phi i32 [ %inc.us.us.us.us.us.us, %for.body14.us.us.us.us.us.us ], [ %n.vec, %for.body14.us.us.us.us.us.us.preheader ]
  %max.172.us.us.us.us.us.us = phi i32 [ %spec.select.us.us.us.us.us.us, %for.body14.us.us.us.us.us.us ], [ %11, %for.body14.us.us.us.us.us.us.preheader ]
  %add20.us.us.us.us.us.us = add i32 %add19.us.us.us.us.us.us, %w_j.073.us.us.us.us.us.us
  %arrayidx21.us.us.us.us.us.us = getelementptr inbounds i32, ptr %input, i32 %add20.us.us.us.us.us.us
  %2 = load i32, ptr %arrayidx21.us.us.us.us.us.us, align 4, !tbaa !3
  %spec.select.us.us.us.us.us.us = tail call i32 @llvm.smax.i32(i32 %2, i32 %max.172.us.us.us.us.us.us)
  %inc.us.us.us.us.us.us = add nuw nsw i32 %w_j.073.us.us.us.us.us.us, 1
  %cmp12.us.us.us.us.us.us = icmp slt i32 %inc.us.us.us.us.us.us, %W
  br i1 %cmp12.us.us.us.us.us.us, label %for.body14.us.us.us.us.us.us, label %for.cond.cleanup13.us.us.us.us.us.us, !llvm.loop !42

for.body14.lr.ph.us.us.us.us.us.us:               ; preds = %for.body10.lr.ph.split.us.us.us.us.us.us, %for.cond.cleanup13.us.us.us.us.us.us
  %w_i.076.us.us.us.us.us.us = phi i32 [ 0, %for.body10.lr.ph.split.us.us.us.us.us.us ], [ %inc31.us.us.us.us.us.us, %for.cond.cleanup13.us.us.us.us.us.us ]
  %max.075.us.us.us.us.us.us = phi i32 [ %1, %for.body10.lr.ph.split.us.us.us.us.us.us ], [ %spec.select.us.us.us.us.us.us.lcssa, %for.cond.cleanup13.us.us.us.us.us.us ]
  %add16.us.us.us.us.us.us = add nsw i32 %w_i.076.us.us.us.us.us.us, %mul.us.us.us
  %mul17.us.us.us.us.us.us = mul nsw i32 %add16.us.us.us.us.us.us, %cols_in
  %add19.us.us.us.us.us.us = add i32 %mul17.us.us.us.us.us.us, %mul6.us.us.us.us.us
  %3 = insertelement <2 x i32> poison, i32 %max.075.us.us.us.us.us.us, i64 0
  %4 = shufflevector <2 x i32> %3, <2 x i32> poison, <2 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %for.body14.lr.ph.us.us.us.us.us.us
  %index = phi i32 [ 0, %for.body14.lr.ph.us.us.us.us.us.us ], [ %index.next, %vector.body ]
  %5 = phi <2 x i32> [ %4, %for.body14.lr.ph.us.us.us.us.us.us ], [ %9, %vector.body ]
  %6 = add i32 %add19.us.us.us.us.us.us, %index
  %7 = getelementptr inbounds i32, ptr %input, i32 %6
  %8 = load <2 x i32>, ptr %7, align 4, !tbaa !3
  %9 = tail call <2 x i32> @llvm.smax.v2i32(<2 x i32> %8, <2 x i32> %5)
  %index.next = add nuw i32 %index, 2
  %10 = icmp eq i32 %index.next, %n.vec
  br i1 %10, label %middle.block, label %vector.body, !llvm.loop !44

middle.block:                                     ; preds = %vector.body
  %11 = tail call i32 @llvm.vector.reduce.smax.v2i32(<2 x i32> %9)
  br i1 %cmp.n, label %for.cond.cleanup13.us.us.us.us.us.us, label %for.body14.us.us.us.us.us.us.preheader

for.body14.us.us.us.us.us.us.preheader:           ; preds = %middle.block
  br label %for.body14.us.us.us.us.us.us

for.cond.cleanup3.us:                             ; preds = %for.cond.cleanup9.us96
  %inc40.us = add nuw nsw i32 %i.090.us, 1
  %cmp.us = icmp slt i32 %inc40.us, %rows_out
  br i1 %cmp.us, label %for.body4.lr.ph.split.us102, label %for.cond.cleanup, !llvm.loop !36

for.cond.cleanup9.us96:                           ; preds = %for.cond.cleanup9.us96, %for.body4.lr.ph.split.us102
  %j.079.us92 = phi i32 [ 0, %for.body4.lr.ph.split.us102 ], [ %inc37.us99, %for.cond.cleanup9.us96 ]
  %reass.add = add i32 %j.079.us92, %mul5.us
  %reass.mul = mul i32 %reass.add, %W
  %arrayidx.us95 = getelementptr inbounds i32, ptr %input, i32 %reass.mul
  %12 = load i32, ptr %arrayidx.us95, align 4, !tbaa !3
  %add34.us97 = add nsw i32 %j.079.us92, %mul33.us
  %arrayidx35.us98 = getelementptr inbounds i32, ptr %output, i32 %add34.us97
  store i32 %12, ptr %arrayidx35.us98, align 4, !tbaa !3
  %inc37.us99 = add nuw nsw i32 %j.079.us92, 1
  %cmp2.us100 = icmp slt i32 %inc37.us99, %cols_out
  br i1 %cmp2.us100, label %for.cond.cleanup9.us96, label %for.cond.cleanup3.us, !llvm.loop !31

for.body4.lr.ph.split.us102:                      ; preds = %for.body4.lr.ph.split.us102.preheader, %for.cond.cleanup3.us
  %i.090.us = phi i32 [ %inc40.us, %for.cond.cleanup3.us ], [ 0, %for.body4.lr.ph.split.us102.preheader ]
  %mul5.us = mul i32 %i.090.us, %cols_in
  %mul33.us = mul nsw i32 %i.090.us, %cols_out
  br label %for.cond.cleanup9.us96

for.cond.cleanup:                                 ; preds = %for.cond.cleanup3.us, %for.cond.cleanup3.us.us.us, %for.cond.cleanup3.us.us.us.split.us.us, %entry
  ret void
}

; Function Attrs: mustprogress nofree nosync nounwind willreturn
define dso_local void @vectorized_max_pooling(i32 noundef %rows_out, i32 noundef %cols_out, i32 noundef %rows_in, i32 noundef %cols_in, i32 noundef %W, ptr addrspace(4) noalias noundef %output, ptr addrspace(4) noalias noundef %input) local_unnamed_addr #4 {
entry:
  %div = sdiv i32 %cols_out, 16
  %mul = shl nsw i32 %div, 4
  %cmp172 = icmp sgt i32 %rows_out, 0
  br i1 %cmp172, label %for.body.lr.ph, label %for.cond.cleanup45

for.body.lr.ph:                                   ; preds = %entry
  %0 = tail call <16 x i32> @llvm.arc.vvci.w.v512()
  %splat.splatinsert = insertelement <16 x i32> poison, i32 %W, i64 0
  %splat.splat = shufflevector <16 x i32> %splat.splatinsert, <16 x i32> poison, <16 x i32> zeroinitializer
  %mul1 = mul <16 x i32> %0, %splat.splat
  %cmp3161 = icmp sgt i32 %cols_out, 15
  %shl.i = shl <16 x i32> %mul1, <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  br i1 %cmp3161, label %for.body.lr.ph.split.us, label %for.body46.lr.ph

for.body.lr.ph.split.us:                          ; preds = %for.body.lr.ph
  %cmp10157 = icmp sgt i32 %W, 0
  br i1 %cmp10157, label %for.body5.lr.ph.split.us.split.us.us.us.us.preheader, label %for.body5.lr.ph.split.us182.preheader

for.body5.lr.ph.split.us182.preheader:            ; preds = %for.body.lr.ph.split.us
  br label %for.body5.lr.ph.split.us182

for.body5.lr.ph.split.us.split.us.us.us.us.preheader: ; preds = %for.body.lr.ph.split.us
  br label %for.body5.lr.ph.split.us.split.us.us.us.us

for.cond.cleanup4.us.us.us:                       ; preds = %for.cond.cleanup11.us.us.us.us.us
  %inc40.us.us.us = add nuw nsw i32 %i.0173.us.us.us, 1
  %cmp.us.us.us = icmp slt i32 %inc40.us.us.us, %rows_out
  br i1 %cmp.us.us.us, label %for.body5.lr.ph.split.us.split.us.us.us.us, label %for.cond.cleanup, !llvm.loop !45

for.body5.lr.ph.split.us.split.us.us.us.us:       ; preds = %for.body5.lr.ph.split.us.split.us.us.us.us.preheader, %for.cond.cleanup4.us.us.us
  %i.0173.us.us.us = phi i32 [ %inc40.us.us.us, %for.cond.cleanup4.us.us.us ], [ 0, %for.body5.lr.ph.split.us.split.us.us.us.us.preheader ]
  %mul6.us.us.us = mul nsw i32 %i.0173.us.us.us, %cols_out
  %mul17.us.us.us = mul nsw i32 %i.0173.us.us.us, %W
  br label %for.body12.lr.ph.split.us.us.us.us.us.us

for.cond.cleanup11.us.us.us.us.us:                ; preds = %for.cond.cleanup15.us.us.us.us.us.us
  %1 = tail call <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32> %5)
  tail call void @llvm.arc.vvst.w.v512(<16 x i32> %1, ptr addrspace(4) %arrayidx.us.us.us.us.us)
  %add37.us.us.us.us.us = add nuw nsw i32 %j_vec.0162.us.us.us.us.us, 16
  %cmp3.us.us.us.us.us = icmp slt i32 %add37.us.us.us.us.us, %mul
  br i1 %cmp3.us.us.us.us.us, label %for.body12.lr.ph.split.us.us.us.us.us.us, label %for.cond.cleanup4.us.us.us, !llvm.loop !46

for.body12.lr.ph.split.us.us.us.us.us.us:         ; preds = %for.cond.cleanup11.us.us.us.us.us, %for.body5.lr.ph.split.us.split.us.us.us.us
  %j_vec.0162.us.us.us.us.us = phi i32 [ 0, %for.body5.lr.ph.split.us.split.us.us.us.us ], [ %add37.us.us.us.us.us, %for.cond.cleanup11.us.us.us.us.us ]
  %add.us.us.us.us.us = add nsw i32 %j_vec.0162.us.us.us.us.us, %mul6.us.us.us
  %arrayidx.us.us.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %output, i32 %add.us.us.us.us.us
  %2 = tail call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %arrayidx.us.us.us.us.us)
  %3 = tail call <16 x i32> @llvm.arc.vvcadd.init.acc.w.v512(<16 x i32> %2, <16 x i32> zeroinitializer)
  %mul20.us.us.us.us.us = mul nsw i32 %j_vec.0162.us.us.us.us.us, %W
  br label %for.body16.lr.ph.us.us.us.us.us.us

for.cond.cleanup15.us.us.us.us.us.us:             ; preds = %for.body16.us.us.us.us.us.us
  %inc29.us.us.us.us.us.us = add nuw nsw i32 %w_i.0159.us.us.us.us.us.us, 1
  %cmp10.us.us.us.us.us.us = icmp slt i32 %inc29.us.us.us.us.us.us, %W
  br i1 %cmp10.us.us.us.us.us.us, label %for.body16.lr.ph.us.us.us.us.us.us, label %for.cond.cleanup11.us.us.us.us.us, !llvm.loop !47

for.body16.us.us.us.us.us.us:                     ; preds = %for.body16.lr.ph.us.us.us.us.us.us, %for.body16.us.us.us.us.us.us
  %w_j.0156.us.us.us.us.us.us = phi i32 [ 0, %for.body16.lr.ph.us.us.us.us.us.us ], [ %inc.us.us.us.us.us.us, %for.body16.us.us.us.us.us.us ]
  %max_acc.sroa.0.1155.us.us.us.us.us.us = phi <16 x i32> [ %max_acc.sroa.0.0158.us.us.us.us.us.us, %for.body16.lr.ph.us.us.us.us.us.us ], [ %5, %for.body16.us.us.us.us.us.us ]
  %add22.us.us.us.us.us.us = add i32 %add21.us.us.us.us.us.us, %w_j.0156.us.us.us.us.us.us
  %arrayidx23.us.us.us.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %add22.us.us.us.us.us.us
  %4 = tail call <16 x i32> @llvm.arc.vgather.int.v512(ptr addrspace(4) %arrayidx23.us.us.us.us.us.us, <16 x i32> %shl.i)
  %5 = tail call <16 x i32> @llvm.arc.vvcmax.acc.w.v512(<16 x i32> %max_acc.sroa.0.1155.us.us.us.us.us.us, <16 x i32> %4)
  %inc.us.us.us.us.us.us = add nuw nsw i32 %w_j.0156.us.us.us.us.us.us, 1
  %cmp14.us.us.us.us.us.us = icmp slt i32 %inc.us.us.us.us.us.us, %W
  br i1 %cmp14.us.us.us.us.us.us, label %for.body16.us.us.us.us.us.us, label %for.cond.cleanup15.us.us.us.us.us.us, !llvm.loop !48

for.body16.lr.ph.us.us.us.us.us.us:               ; preds = %for.body12.lr.ph.split.us.us.us.us.us.us, %for.cond.cleanup15.us.us.us.us.us.us
  %w_i.0159.us.us.us.us.us.us = phi i32 [ 0, %for.body12.lr.ph.split.us.us.us.us.us.us ], [ %inc29.us.us.us.us.us.us, %for.cond.cleanup15.us.us.us.us.us.us ]
  %max_acc.sroa.0.0158.us.us.us.us.us.us = phi <16 x i32> [ %3, %for.body12.lr.ph.split.us.us.us.us.us.us ], [ %5, %for.cond.cleanup15.us.us.us.us.us.us ]
  %add18.us.us.us.us.us.us = add nsw i32 %w_i.0159.us.us.us.us.us.us, %mul17.us.us.us
  %mul19.us.us.us.us.us.us = mul nsw i32 %add18.us.us.us.us.us.us, %cols_in
  %add21.us.us.us.us.us.us = add i32 %mul19.us.us.us.us.us.us, %mul20.us.us.us.us.us
  br label %for.body16.us.us.us.us.us.us

for.cond.cleanup4.us:                             ; preds = %for.cond.cleanup11.us178
  %inc40.us = add nuw nsw i32 %i.0173.us, 1
  %cmp.us = icmp slt i32 %inc40.us, %rows_out
  br i1 %cmp.us, label %for.body5.lr.ph.split.us182, label %for.cond.cleanup, !llvm.loop !45

for.cond.cleanup11.us178:                         ; preds = %for.cond.cleanup11.us178, %for.body5.lr.ph.split.us182
  %j_vec.0162.us175 = phi i32 [ 0, %for.body5.lr.ph.split.us182 ], [ %add37.us179, %for.cond.cleanup11.us178 ]
  %add.us176 = add nsw i32 %j_vec.0162.us175, %mul6.us
  %arrayidx.us177 = getelementptr inbounds i32, ptr addrspace(4) %output, i32 %add.us176
  %6 = tail call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %arrayidx.us177)
  %7 = tail call <16 x i32> @llvm.arc.vvcadd.init.acc.w.v512(<16 x i32> %6, <16 x i32> zeroinitializer)
  %8 = tail call <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32> %7)
  tail call void @llvm.arc.vvst.w.v512(<16 x i32> %8, ptr addrspace(4) %arrayidx.us177)
  %add37.us179 = add nuw nsw i32 %j_vec.0162.us175, 16
  %cmp3.us180 = icmp slt i32 %add37.us179, %mul
  br i1 %cmp3.us180, label %for.cond.cleanup11.us178, label %for.cond.cleanup4.us, !llvm.loop !46

for.body5.lr.ph.split.us182:                      ; preds = %for.body5.lr.ph.split.us182.preheader, %for.cond.cleanup4.us
  %i.0173.us = phi i32 [ %inc40.us, %for.cond.cleanup4.us ], [ 0, %for.body5.lr.ph.split.us182.preheader ]
  %mul6.us = mul nsw i32 %i.0173.us, %cols_out
  br label %for.cond.cleanup11.us178

for.cond.cleanup:                                 ; preds = %for.cond.cleanup4.us, %for.cond.cleanup4.us.us.us
  %cmp48202 = icmp slt i32 %mul, %cols_out
  br i1 %cmp48202, label %for.body46.lr.ph.split.us, label %for.cond.cleanup45

for.body46.lr.ph:                                 ; preds = %for.body.lr.ph
  %cmp48202.old = icmp slt i32 %mul, %cols_out
  br i1 %cmp48202.old, label %for.body46.lr.ph.split.us, label %for.cond.cleanup45

for.body46.lr.ph.split.us:                        ; preds = %for.cond.cleanup, %for.body46.lr.ph
  %cmp58198 = icmp sgt i32 %W, 0
  br i1 %cmp58198, label %for.body46.lr.ph.split.us.split.us.split.us, label %for.body46.lr.ph.split.us.split

for.body46.lr.ph.split.us.split.us.split.us:      ; preds = %for.body46.lr.ph.split.us
  %min.iters.check270 = icmp ult i32 %W, 8
  %min.iters.check273 = icmp ult i32 %W, 64
  %n.vec277 = and i32 %W, -64
  %cmp.n278 = icmp eq i32 %n.vec277, %W
  %n.vec.remaining295 = and i32 %W, 56
  %min.epilog.iters.check296 = icmp eq i32 %n.vec.remaining295, 0
  %n.vec299 = and i32 %W, -8
  %cmp.n301 = icmp eq i32 %n.vec299, %W
  br i1 %min.iters.check270, label %for.body50.lr.ph.split.us.split.us.us.us.us.us.preheader, label %for.body50.lr.ph.split.us.split.us.us.us.us.preheader

for.body50.lr.ph.split.us.split.us.us.us.us.preheader: ; preds = %for.body46.lr.ph.split.us.split.us.split.us
  br label %for.body50.lr.ph.split.us.split.us.us.us.us

for.body50.lr.ph.split.us.split.us.us.us.us.us.preheader: ; preds = %for.body46.lr.ph.split.us.split.us.split.us
  br label %for.body50.lr.ph.split.us.split.us.us.us.us.us

for.body50.lr.ph.split.us.split.us.us.us.us.us:   ; preds = %for.body50.lr.ph.split.us.split.us.us.us.us.us.preheader, %for.cond.cleanup49.us.us.us.split.us.us
  %i42.0214.us.us.us.us = phi i32 [ %inc94.us.us.us.us, %for.cond.cleanup49.us.us.us.split.us.us ], [ 0, %for.body50.lr.ph.split.us.split.us.us.us.us.us.preheader ]
  %mul51.us.us.us.us = mul nsw i32 %i42.0214.us.us.us.us, %W
  %mul52.us.us.us.us = mul nsw i32 %mul51.us.us.us.us, %cols_in
  %mul87.us.us.us.us = mul nsw i32 %i42.0214.us.us.us.us, %cols_out
  br label %for.body60.lr.ph.split.us.us.us.us.us.us.us.us

for.body60.lr.ph.split.us.us.us.us.us.us.us.us:   ; preds = %for.cond.cleanup59.us.us.us.us.us.split.us.us.us, %for.body50.lr.ph.split.us.split.us.us.us.us.us
  %j.0203.us.us.us.us.us.us.us = phi i32 [ %mul, %for.body50.lr.ph.split.us.split.us.us.us.us.us ], [ %inc91.us.us.us.us.us.us.us, %for.cond.cleanup59.us.us.us.us.us.split.us.us.us ]
  %mul53.us.us.us.us.us.us.us = mul nsw i32 %j.0203.us.us.us.us.us.us.us, %W
  %add54.us.us.us.us.us.us.us = add nsw i32 %mul53.us.us.us.us.us.us.us, %mul52.us.us.us.us
  %arrayidx55.us.us.us.us.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %add54.us.us.us.us.us.us.us
  %9 = load i32, ptr addrspace(4) %arrayidx55.us.us.us.us.us.us.us, align 4, !tbaa !3
  br label %iter.check272.us.us.us

iter.check272.us.us.us:                           ; preds = %for.cond.cleanup64.us.us.us.us.us.us.us.us.us, %for.body60.lr.ph.split.us.us.us.us.us.us.us.us
  %w_i56.0200.us.us.us.us.us.us.us.us.us = phi i32 [ 0, %for.body60.lr.ph.split.us.us.us.us.us.us.us.us ], [ %inc85.us.us.us.us.us.us.us.us.us, %for.cond.cleanup64.us.us.us.us.us.us.us.us.us ]
  %max.0199.us.us.us.us.us.us.us.us.us = phi i32 [ %9, %for.body60.lr.ph.split.us.us.us.us.us.us.us.us ], [ %spec.select.us.us.us.us.us.us.us.us.us, %for.cond.cleanup64.us.us.us.us.us.us.us.us.us ]
  %add67.us.us.us.us.us.us.us.us.us = add nsw i32 %w_i56.0200.us.us.us.us.us.us.us.us.us, %mul51.us.us.us.us
  %mul68.us.us.us.us.us.us.us.us.us = mul nsw i32 %add67.us.us.us.us.us.us.us.us.us, %cols_in
  %add70.us.us.us.us.us.us.us.us.us = add i32 %mul68.us.us.us.us.us.us.us.us.us, %mul53.us.us.us.us.us.us.us
  br label %for.body65.us.us.us.us.us.us.us.us.us

for.body65.us.us.us.us.us.us.us.us.us:            ; preds = %for.body65.us.us.us.us.us.us.us.us.us, %iter.check272.us.us.us
  %w_j61.0197.us.us.us.us.us.us.us.us.us = phi i32 [ 0, %iter.check272.us.us.us ], [ %inc82.us.us.us.us.us.us.us.us.us, %for.body65.us.us.us.us.us.us.us.us.us ]
  %max.1196.us.us.us.us.us.us.us.us.us = phi i32 [ %max.0199.us.us.us.us.us.us.us.us.us, %iter.check272.us.us.us ], [ %spec.select.us.us.us.us.us.us.us.us.us, %for.body65.us.us.us.us.us.us.us.us.us ]
  %add71.us.us.us.us.us.us.us.us.us = add i32 %add70.us.us.us.us.us.us.us.us.us, %w_j61.0197.us.us.us.us.us.us.us.us.us
  %arrayidx72.us.us.us.us.us.us.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %add71.us.us.us.us.us.us.us.us.us
  %10 = load i32, ptr addrspace(4) %arrayidx72.us.us.us.us.us.us.us.us.us, align 4, !tbaa !3
  %spec.select.us.us.us.us.us.us.us.us.us = tail call i32 @llvm.smax.i32(i32 %10, i32 %max.1196.us.us.us.us.us.us.us.us.us)
  %inc82.us.us.us.us.us.us.us.us.us = add nuw nsw i32 %w_j61.0197.us.us.us.us.us.us.us.us.us, 1
  %cmp63.us.us.us.us.us.us.us.us.us = icmp slt i32 %inc82.us.us.us.us.us.us.us.us.us, %W
  br i1 %cmp63.us.us.us.us.us.us.us.us.us, label %for.body65.us.us.us.us.us.us.us.us.us, label %for.cond.cleanup64.us.us.us.us.us.us.us.us.us, !llvm.loop !49

for.cond.cleanup64.us.us.us.us.us.us.us.us.us:    ; preds = %for.body65.us.us.us.us.us.us.us.us.us
  %inc85.us.us.us.us.us.us.us.us.us = add nuw nsw i32 %w_i56.0200.us.us.us.us.us.us.us.us.us, 1
  %cmp58.us.us.us.us.us.us.us.us.us = icmp slt i32 %inc85.us.us.us.us.us.us.us.us.us, %W
  br i1 %cmp58.us.us.us.us.us.us.us.us.us, label %iter.check272.us.us.us, label %for.cond.cleanup59.us.us.us.us.us.split.us.us.us, !llvm.loop !50

for.cond.cleanup59.us.us.us.us.us.split.us.us.us: ; preds = %for.cond.cleanup64.us.us.us.us.us.us.us.us.us
  %add88.us.us.us.us.us.us.us = add nsw i32 %j.0203.us.us.us.us.us.us.us, %mul87.us.us.us.us
  %arrayidx89.us.us.us.us.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %output, i32 %add88.us.us.us.us.us.us.us
  store i32 %spec.select.us.us.us.us.us.us.us.us.us, ptr addrspace(4) %arrayidx89.us.us.us.us.us.us.us, align 4, !tbaa !3
  %inc91.us.us.us.us.us.us.us = add nsw i32 %j.0203.us.us.us.us.us.us.us, 1
  %cmp48.us.us.us.us.us.us.us = icmp slt i32 %inc91.us.us.us.us.us.us.us, %cols_out
  br i1 %cmp48.us.us.us.us.us.us.us, label %for.body60.lr.ph.split.us.us.us.us.us.us.us.us, label %for.cond.cleanup49.us.us.us.split.us.us, !llvm.loop !51

for.cond.cleanup49.us.us.us.split.us.us:          ; preds = %for.cond.cleanup59.us.us.us.us.us.split.us.us.us
  %inc94.us.us.us.us = add nuw nsw i32 %i42.0214.us.us.us.us, 1
  %cmp44.us.us.us.us = icmp slt i32 %inc94.us.us.us.us, %rows_out
  br i1 %cmp44.us.us.us.us, label %for.body50.lr.ph.split.us.split.us.us.us.us.us, label %for.cond.cleanup45, !llvm.loop !52

for.cond.cleanup49.us.us.us:                      ; preds = %for.cond.cleanup59.us.us.us.us.us
  %inc94.us.us.us = add nuw nsw i32 %i42.0214.us.us.us, 1
  %cmp44.us.us.us = icmp slt i32 %inc94.us.us.us, %rows_out
  br i1 %cmp44.us.us.us, label %for.body50.lr.ph.split.us.split.us.us.us.us, label %for.cond.cleanup45, !llvm.loop !52

for.body50.lr.ph.split.us.split.us.us.us.us:      ; preds = %for.body50.lr.ph.split.us.split.us.us.us.us.preheader, %for.cond.cleanup49.us.us.us
  %i42.0214.us.us.us = phi i32 [ %inc94.us.us.us, %for.cond.cleanup49.us.us.us ], [ 0, %for.body50.lr.ph.split.us.split.us.us.us.us.preheader ]
  %mul51.us.us.us = mul nsw i32 %i42.0214.us.us.us, %W
  %mul52.us.us.us = mul nsw i32 %mul51.us.us.us, %cols_in
  %mul87.us.us.us = mul nsw i32 %i42.0214.us.us.us, %cols_out
  br label %for.body60.lr.ph.split.us.us.us.us.us.us

for.cond.cleanup59.us.us.us.us.us:                ; preds = %for.cond.cleanup64.us.us.us.us.us.us
  %add88.us.us.us.us.us = add nsw i32 %j.0203.us.us.us.us.us, %mul87.us.us.us
  %arrayidx89.us.us.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %output, i32 %add88.us.us.us.us.us
  store i32 %spec.select.us.us.us.us.us.us.lcssa, ptr addrspace(4) %arrayidx89.us.us.us.us.us, align 4, !tbaa !3
  %inc91.us.us.us.us.us = add nsw i32 %j.0203.us.us.us.us.us, 1
  %cmp48.us.us.us.us.us = icmp slt i32 %inc91.us.us.us.us.us, %cols_out
  br i1 %cmp48.us.us.us.us.us, label %for.body60.lr.ph.split.us.us.us.us.us.us, label %for.cond.cleanup49.us.us.us, !llvm.loop !51

for.body60.lr.ph.split.us.us.us.us.us.us:         ; preds = %for.cond.cleanup59.us.us.us.us.us, %for.body50.lr.ph.split.us.split.us.us.us.us
  %j.0203.us.us.us.us.us = phi i32 [ %mul, %for.body50.lr.ph.split.us.split.us.us.us.us ], [ %inc91.us.us.us.us.us, %for.cond.cleanup59.us.us.us.us.us ]
  %mul53.us.us.us.us.us = mul nsw i32 %j.0203.us.us.us.us.us, %W
  %add54.us.us.us.us.us = add nsw i32 %mul53.us.us.us.us.us, %mul52.us.us.us
  %arrayidx55.us.us.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %add54.us.us.us.us.us
  %11 = load i32, ptr addrspace(4) %arrayidx55.us.us.us.us.us, align 4, !tbaa !3
  br label %iter.check272

for.cond.cleanup64.us.us.us.us.us.us:             ; preds = %for.body65.us.us.us.us.us.us, %vec.epilog.middle.block291, %middle.block269
  %spec.select.us.us.us.us.us.us.lcssa = phi i32 [ %23, %middle.block269 ], [ %28, %vec.epilog.middle.block291 ], [ %spec.select.us.us.us.us.us.us, %for.body65.us.us.us.us.us.us ]
  %inc85.us.us.us.us.us.us = add nuw nsw i32 %w_i56.0200.us.us.us.us.us.us, 1
  %cmp58.us.us.us.us.us.us = icmp slt i32 %inc85.us.us.us.us.us.us, %W
  br i1 %cmp58.us.us.us.us.us.us, label %iter.check272, label %for.cond.cleanup59.us.us.us.us.us, !llvm.loop !50

for.body65.us.us.us.us.us.us:                     ; preds = %for.body65.us.us.us.us.us.us.preheader, %for.body65.us.us.us.us.us.us
  %w_j61.0197.us.us.us.us.us.us = phi i32 [ %inc82.us.us.us.us.us.us, %for.body65.us.us.us.us.us.us ], [ %w_j61.0197.us.us.us.us.us.us.ph, %for.body65.us.us.us.us.us.us.preheader ]
  %max.1196.us.us.us.us.us.us = phi i32 [ %spec.select.us.us.us.us.us.us, %for.body65.us.us.us.us.us.us ], [ %max.1196.us.us.us.us.us.us.ph, %for.body65.us.us.us.us.us.us.preheader ]
  %add71.us.us.us.us.us.us = add i32 %add70.us.us.us.us.us.us, %w_j61.0197.us.us.us.us.us.us
  %arrayidx72.us.us.us.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %add71.us.us.us.us.us.us
  %12 = load i32, ptr addrspace(4) %arrayidx72.us.us.us.us.us.us, align 4, !tbaa !3
  %spec.select.us.us.us.us.us.us = tail call i32 @llvm.smax.i32(i32 %12, i32 %max.1196.us.us.us.us.us.us)
  %inc82.us.us.us.us.us.us = add nuw nsw i32 %w_j61.0197.us.us.us.us.us.us, 1
  %cmp63.us.us.us.us.us.us = icmp slt i32 %inc82.us.us.us.us.us.us, %W
  br i1 %cmp63.us.us.us.us.us.us, label %for.body65.us.us.us.us.us.us, label %for.cond.cleanup64.us.us.us.us.us.us, !llvm.loop !49

iter.check272:                                    ; preds = %for.body60.lr.ph.split.us.us.us.us.us.us, %for.cond.cleanup64.us.us.us.us.us.us
  %w_i56.0200.us.us.us.us.us.us = phi i32 [ 0, %for.body60.lr.ph.split.us.us.us.us.us.us ], [ %inc85.us.us.us.us.us.us, %for.cond.cleanup64.us.us.us.us.us.us ]
  %max.0199.us.us.us.us.us.us = phi i32 [ %11, %for.body60.lr.ph.split.us.us.us.us.us.us ], [ %spec.select.us.us.us.us.us.us.lcssa, %for.cond.cleanup64.us.us.us.us.us.us ]
  %add67.us.us.us.us.us.us = add nsw i32 %w_i56.0200.us.us.us.us.us.us, %mul51.us.us.us
  %mul68.us.us.us.us.us.us = mul nsw i32 %add67.us.us.us.us.us.us, %cols_in
  %add70.us.us.us.us.us.us = add i32 %mul68.us.us.us.us.us.us, %mul53.us.us.us.us.us
  br i1 %min.iters.check273, label %vec.epilog.ph294, label %vector.ph275

vector.ph275:                                     ; preds = %iter.check272
  %minmax.ident.splatinsert = insertelement <16 x i32> poison, i32 %max.0199.us.us.us.us.us.us, i64 0
  %minmax.ident.splat = shufflevector <16 x i32> %minmax.ident.splatinsert, <16 x i32> poison, <16 x i32> zeroinitializer
  br label %vector.body279

vector.body279:                                   ; preds = %vector.body279, %vector.ph275
  %index280 = phi i32 [ 0, %vector.ph275 ], [ %index.next288, %vector.body279 ]
  %vec.phi = phi <16 x i32> [ %minmax.ident.splat, %vector.ph275 ], [ %18, %vector.body279 ]
  %vec.phi281 = phi <16 x i32> [ %minmax.ident.splat, %vector.ph275 ], [ %19, %vector.body279 ]
  %vec.phi282 = phi <16 x i32> [ %minmax.ident.splat, %vector.ph275 ], [ %20, %vector.body279 ]
  %vec.phi283 = phi <16 x i32> [ %minmax.ident.splat, %vector.ph275 ], [ %21, %vector.body279 ]
  %13 = add i32 %add70.us.us.us.us.us.us, %index280
  %14 = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %13
  %wide.load284 = load <16 x i32>, ptr addrspace(4) %14, align 4, !tbaa !3
  %15 = getelementptr inbounds i32, ptr addrspace(4) %14, i32 16
  %wide.load285 = load <16 x i32>, ptr addrspace(4) %15, align 4, !tbaa !3
  %16 = getelementptr inbounds i32, ptr addrspace(4) %14, i32 32
  %wide.load286 = load <16 x i32>, ptr addrspace(4) %16, align 4, !tbaa !3
  %17 = getelementptr inbounds i32, ptr addrspace(4) %14, i32 48
  %wide.load287 = load <16 x i32>, ptr addrspace(4) %17, align 4, !tbaa !3
  %18 = tail call <16 x i32> @llvm.smax.v16i32(<16 x i32> %wide.load284, <16 x i32> %vec.phi)
  %19 = tail call <16 x i32> @llvm.smax.v16i32(<16 x i32> %wide.load285, <16 x i32> %vec.phi281)
  %20 = tail call <16 x i32> @llvm.smax.v16i32(<16 x i32> %wide.load286, <16 x i32> %vec.phi282)
  %21 = tail call <16 x i32> @llvm.smax.v16i32(<16 x i32> %wide.load287, <16 x i32> %vec.phi283)
  %index.next288 = add nuw i32 %index280, 64
  %22 = icmp eq i32 %index.next288, %n.vec277
  br i1 %22, label %middle.block269, label %vector.body279, !llvm.loop !53

middle.block269:                                  ; preds = %vector.body279
  %rdx.minmax = tail call <16 x i32> @llvm.smax.v16i32(<16 x i32> %18, <16 x i32> %19)
  %rdx.minmax289 = tail call <16 x i32> @llvm.smax.v16i32(<16 x i32> %rdx.minmax, <16 x i32> %20)
  %rdx.minmax290 = tail call <16 x i32> @llvm.smax.v16i32(<16 x i32> %rdx.minmax289, <16 x i32> %21)
  %23 = tail call i32 @llvm.vector.reduce.smax.v16i32(<16 x i32> %rdx.minmax290)
  br i1 %cmp.n278, label %for.cond.cleanup64.us.us.us.us.us.us, label %vec.epilog.iter.check293

vec.epilog.iter.check293:                         ; preds = %middle.block269
  br i1 %min.epilog.iters.check296, label %for.body65.us.us.us.us.us.us.preheader, label %vec.epilog.ph294

vec.epilog.ph294:                                 ; preds = %iter.check272, %vec.epilog.iter.check293
  %bc.merge.rdx = phi i32 [ %max.0199.us.us.us.us.us.us, %iter.check272 ], [ %23, %vec.epilog.iter.check293 ]
  %vec.epilog.resume.val297 = phi i32 [ 0, %iter.check272 ], [ %n.vec277, %vec.epilog.iter.check293 ]
  %minmax.ident.splatinsert305 = insertelement <8 x i32> poison, i32 %bc.merge.rdx, i64 0
  %minmax.ident.splat306 = shufflevector <8 x i32> %minmax.ident.splatinsert305, <8 x i32> poison, <8 x i32> zeroinitializer
  br label %vec.epilog.vector.body302

vec.epilog.vector.body302:                        ; preds = %vec.epilog.vector.body302, %vec.epilog.ph294
  %index303 = phi i32 [ %vec.epilog.resume.val297, %vec.epilog.ph294 ], [ %index.next308, %vec.epilog.vector.body302 ]
  %vec.phi304 = phi <8 x i32> [ %minmax.ident.splat306, %vec.epilog.ph294 ], [ %26, %vec.epilog.vector.body302 ]
  %24 = add i32 %add70.us.us.us.us.us.us, %index303
  %25 = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %24
  %wide.load307 = load <8 x i32>, ptr addrspace(4) %25, align 4, !tbaa !3
  %26 = tail call <8 x i32> @llvm.smax.v8i32(<8 x i32> %wide.load307, <8 x i32> %vec.phi304)
  %index.next308 = add nuw i32 %index303, 8
  %27 = icmp eq i32 %index.next308, %n.vec299
  br i1 %27, label %vec.epilog.middle.block291, label %vec.epilog.vector.body302, !llvm.loop !54

vec.epilog.middle.block291:                       ; preds = %vec.epilog.vector.body302
  %28 = tail call i32 @llvm.vector.reduce.smax.v8i32(<8 x i32> %26)
  br i1 %cmp.n301, label %for.cond.cleanup64.us.us.us.us.us.us, label %for.body65.us.us.us.us.us.us.preheader

for.body65.us.us.us.us.us.us.preheader:           ; preds = %vec.epilog.iter.check293, %vec.epilog.middle.block291
  %w_j61.0197.us.us.us.us.us.us.ph = phi i32 [ %n.vec277, %vec.epilog.iter.check293 ], [ %n.vec299, %vec.epilog.middle.block291 ]
  %max.1196.us.us.us.us.us.us.ph = phi i32 [ %23, %vec.epilog.iter.check293 ], [ %28, %vec.epilog.middle.block291 ]
  br label %for.body65.us.us.us.us.us.us

for.body46.lr.ph.split.us.split:                  ; preds = %for.body46.lr.ph.split.us
  %29 = add nuw nsw i32 %mul, 1
  %smax = tail call i32 @llvm.smax.i32(i32 %cols_out, i32 %29)
  %30 = sub i32 %smax, %mul
  %min.iters.check = icmp ult i32 %30, 8
  br i1 %min.iters.check, label %iter.check.us.preheader, label %for.body46.lr.ph.split.us.split.split

iter.check.us.preheader:                          ; preds = %for.body46.lr.ph.split.us.split
  br label %iter.check.us

iter.check.us:                                    ; preds = %iter.check.us.preheader, %for.cond.cleanup49.us.us
  %i42.0214.us.us = phi i32 [ %inc94.us.us, %for.cond.cleanup49.us.us ], [ 0, %iter.check.us.preheader ]
  %mul52.us.us = mul i32 %i42.0214.us.us, %cols_in
  %mul87.us.us = mul nsw i32 %i42.0214.us.us, %cols_out
  br label %for.cond.cleanup59.us220.us

for.cond.cleanup59.us220.us:                      ; preds = %for.cond.cleanup59.us220.us, %iter.check.us
  %j.0203.us216.us = phi i32 [ %mul, %iter.check.us ], [ %inc91.us223.us, %for.cond.cleanup59.us220.us ]
  %reass.add.us = add i32 %j.0203.us216.us, %mul52.us.us
  %reass.mul.us = mul i32 %reass.add.us, %W
  %arrayidx55.us219.us = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %reass.mul.us
  %31 = load i32, ptr addrspace(4) %arrayidx55.us219.us, align 4, !tbaa !3
  %add88.us221.us = add nsw i32 %j.0203.us216.us, %mul87.us.us
  %arrayidx89.us222.us = getelementptr inbounds i32, ptr addrspace(4) %output, i32 %add88.us221.us
  store i32 %31, ptr addrspace(4) %arrayidx89.us222.us, align 4, !tbaa !3
  %inc91.us223.us = add nsw i32 %j.0203.us216.us, 1
  %cmp48.us224.us = icmp slt i32 %inc91.us223.us, %cols_out
  br i1 %cmp48.us224.us, label %for.cond.cleanup59.us220.us, label %for.cond.cleanup49.us.us, !llvm.loop !55

for.cond.cleanup49.us.us:                         ; preds = %for.cond.cleanup59.us220.us
  %inc94.us.us = add nuw nsw i32 %i42.0214.us.us, 1
  %cmp44.us.us = icmp slt i32 %inc94.us.us, %rows_out
  br i1 %cmp44.us.us, label %iter.check.us, label %for.cond.cleanup45, !llvm.loop !52

for.body46.lr.ph.split.us.split.split:            ; preds = %for.body46.lr.ph.split.us.split
  br label %iter.check

for.cond.cleanup49.us:                            ; preds = %for.cond.cleanup59.us220
  %inc94.us = add nuw nsw i32 %i42.0214.us, 1
  %cmp44.us = icmp slt i32 %inc94.us, %rows_out
  br i1 %cmp44.us, label %iter.check, label %for.cond.cleanup45, !llvm.loop !52

for.cond.cleanup59.us220:                         ; preds = %for.cond.cleanup59.us220, %iter.check
  %j.0203.us216 = phi i32 [ %mul, %iter.check ], [ %inc91.us223, %for.cond.cleanup59.us220 ]
  %reass.add = add i32 %j.0203.us216, %mul52.us
  %reass.mul = mul i32 %reass.add, %W
  %arrayidx55.us219 = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %reass.mul
  %32 = load i32, ptr addrspace(4) %arrayidx55.us219, align 4, !tbaa !3
  %add88.us221 = add nsw i32 %j.0203.us216, %mul87.us
  %arrayidx89.us222 = getelementptr inbounds i32, ptr addrspace(4) %output, i32 %add88.us221
  store i32 %32, ptr addrspace(4) %arrayidx89.us222, align 4, !tbaa !3
  %inc91.us223 = add nsw i32 %j.0203.us216, 1
  %cmp48.us224 = icmp slt i32 %inc91.us223, %cols_out
  br i1 %cmp48.us224, label %for.cond.cleanup59.us220, label %for.cond.cleanup49.us, !llvm.loop !55

iter.check:                                       ; preds = %for.body46.lr.ph.split.us.split.split, %for.cond.cleanup49.us
  %i42.0214.us = phi i32 [ %inc94.us, %for.cond.cleanup49.us ], [ 0, %for.body46.lr.ph.split.us.split.split ]
  %mul52.us = mul i32 %i42.0214.us, %cols_in
  %mul87.us = mul nsw i32 %i42.0214.us, %cols_out
  br label %for.cond.cleanup59.us220

for.cond.cleanup45:                               ; preds = %for.cond.cleanup49.us, %for.cond.cleanup49.us.us, %for.cond.cleanup49.us.us.us, %for.cond.cleanup49.us.us.us.split.us.us, %entry, %for.body46.lr.ph, %for.cond.cleanup
  ret void
}

; Function Attrs: mustprogress nofree nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @autovectorized_max_pooling(i32 noundef %rows_out, i32 noundef %cols_out, i32 noundef %rows_in, i32 noundef %cols_in, i32 noundef %W, ptr addrspace(4) noalias nocapture noundef writeonly %output, ptr addrspace(4) noalias nocapture noundef readonly %input) local_unnamed_addr #3 {
entry:
  %cmp89 = icmp sgt i32 %rows_out, 0
  %cmp278 = icmp sgt i32 %cols_out, 0
  %or.cond = and i1 %cmp89, %cmp278
  br i1 %or.cond, label %for.body.lr.ph.split.us, label %for.cond.cleanup

for.body.lr.ph.split.us:                          ; preds = %entry
  %cmp874 = icmp sgt i32 %W, 0
  br i1 %cmp874, label %for.body.lr.ph.split.us.split.us.split.us, label %for.body.lr.ph.split.us.split

for.body.lr.ph.split.us.split.us.split.us:        ; preds = %for.body.lr.ph.split.us
  %min.iters.check135 = icmp ult i32 %W, 8
  %min.iters.check138 = icmp ult i32 %W, 64
  %n.vec142 = and i32 %W, -64
  %cmp.n143 = icmp eq i32 %n.vec142, %W
  %n.vec.remaining160 = and i32 %W, 56
  %min.epilog.iters.check161 = icmp eq i32 %n.vec.remaining160, 0
  %n.vec164 = and i32 %W, -8
  %cmp.n166 = icmp eq i32 %n.vec164, %W
  br i1 %min.iters.check135, label %for.body4.lr.ph.split.us.split.us.us.us.us.us.preheader, label %for.body4.lr.ph.split.us.split.us.us.us.us.preheader

for.body4.lr.ph.split.us.split.us.us.us.us.preheader: ; preds = %for.body.lr.ph.split.us.split.us.split.us
  br label %for.body4.lr.ph.split.us.split.us.us.us.us

for.body4.lr.ph.split.us.split.us.us.us.us.us.preheader: ; preds = %for.body.lr.ph.split.us.split.us.split.us
  br label %for.body4.lr.ph.split.us.split.us.us.us.us.us

for.body4.lr.ph.split.us.split.us.us.us.us.us:    ; preds = %for.body4.lr.ph.split.us.split.us.us.us.us.us.preheader, %for.cond.cleanup3.us.us.us.split.us.us
  %i.090.us.us.us.us = phi i32 [ %inc40.us.us.us.us, %for.cond.cleanup3.us.us.us.split.us.us ], [ 0, %for.body4.lr.ph.split.us.split.us.us.us.us.us.preheader ]
  %mul.us.us.us.us = mul nsw i32 %i.090.us.us.us.us, %W
  %mul5.us.us.us.us = mul nsw i32 %mul.us.us.us.us, %cols_in
  %mul33.us.us.us.us = mul nsw i32 %i.090.us.us.us.us, %cols_out
  br label %for.body10.lr.ph.split.us.us.us.us.us.us.us.us

for.body10.lr.ph.split.us.us.us.us.us.us.us.us:   ; preds = %for.cond.cleanup9.us.us.us.us.us.split.us.us.us, %for.body4.lr.ph.split.us.split.us.us.us.us.us
  %j.079.us.us.us.us.us.us.us = phi i32 [ 0, %for.body4.lr.ph.split.us.split.us.us.us.us.us ], [ %inc37.us.us.us.us.us.us.us, %for.cond.cleanup9.us.us.us.us.us.split.us.us.us ]
  %mul6.us.us.us.us.us.us.us = mul nsw i32 %j.079.us.us.us.us.us.us.us, %W
  %add.us.us.us.us.us.us.us = add nsw i32 %mul6.us.us.us.us.us.us.us, %mul5.us.us.us.us
  %arrayidx.us.us.us.us.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %add.us.us.us.us.us.us.us
  %0 = load i32, ptr addrspace(4) %arrayidx.us.us.us.us.us.us.us, align 4, !tbaa !3
  br label %iter.check137.us.us.us

iter.check137.us.us.us:                           ; preds = %for.cond.cleanup13.us.us.us.us.us.us.loopexit.us.us.us, %for.body10.lr.ph.split.us.us.us.us.us.us.us.us
  %w_i.076.us.us.us.us.us.us.us.us.us = phi i32 [ 0, %for.body10.lr.ph.split.us.us.us.us.us.us.us.us ], [ %inc31.us.us.us.us.us.us.us.us.us, %for.cond.cleanup13.us.us.us.us.us.us.loopexit.us.us.us ]
  %max.075.us.us.us.us.us.us.us.us.us = phi i32 [ %0, %for.body10.lr.ph.split.us.us.us.us.us.us.us.us ], [ %spec.select.us.us.us.us.us.us.us.us.us, %for.cond.cleanup13.us.us.us.us.us.us.loopexit.us.us.us ]
  %add16.us.us.us.us.us.us.us.us.us = add nsw i32 %w_i.076.us.us.us.us.us.us.us.us.us, %mul.us.us.us.us
  %mul17.us.us.us.us.us.us.us.us.us = mul nsw i32 %add16.us.us.us.us.us.us.us.us.us, %cols_in
  %add19.us.us.us.us.us.us.us.us.us = add i32 %mul17.us.us.us.us.us.us.us.us.us, %mul6.us.us.us.us.us.us.us
  br label %for.body14.us.us.us.us.us.us.us.us.us

for.body14.us.us.us.us.us.us.us.us.us:            ; preds = %iter.check137.us.us.us, %for.body14.us.us.us.us.us.us.us.us.us
  %w_j.073.us.us.us.us.us.us.us.us.us = phi i32 [ 0, %iter.check137.us.us.us ], [ %inc.us.us.us.us.us.us.us.us.us, %for.body14.us.us.us.us.us.us.us.us.us ]
  %max.172.us.us.us.us.us.us.us.us.us = phi i32 [ %max.075.us.us.us.us.us.us.us.us.us, %iter.check137.us.us.us ], [ %spec.select.us.us.us.us.us.us.us.us.us, %for.body14.us.us.us.us.us.us.us.us.us ]
  %add20.us.us.us.us.us.us.us.us.us = add i32 %add19.us.us.us.us.us.us.us.us.us, %w_j.073.us.us.us.us.us.us.us.us.us
  %arrayidx21.us.us.us.us.us.us.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %add20.us.us.us.us.us.us.us.us.us
  %1 = load i32, ptr addrspace(4) %arrayidx21.us.us.us.us.us.us.us.us.us, align 4, !tbaa !3
  %spec.select.us.us.us.us.us.us.us.us.us = tail call i32 @llvm.smax.i32(i32 %1, i32 %max.172.us.us.us.us.us.us.us.us.us)
  %inc.us.us.us.us.us.us.us.us.us = add nuw nsw i32 %w_j.073.us.us.us.us.us.us.us.us.us, 1
  %cmp12.us.us.us.us.us.us.us.us.us = icmp slt i32 %inc.us.us.us.us.us.us.us.us.us, %W
  br i1 %cmp12.us.us.us.us.us.us.us.us.us, label %for.body14.us.us.us.us.us.us.us.us.us, label %for.cond.cleanup13.us.us.us.us.us.us.loopexit.us.us.us, !llvm.loop !56

for.cond.cleanup13.us.us.us.us.us.us.loopexit.us.us.us: ; preds = %for.body14.us.us.us.us.us.us.us.us.us
  %inc31.us.us.us.us.us.us.us.us.us = add nuw nsw i32 %w_i.076.us.us.us.us.us.us.us.us.us, 1
  %cmp8.us.us.us.us.us.us.us.us.us = icmp slt i32 %inc31.us.us.us.us.us.us.us.us.us, %W
  br i1 %cmp8.us.us.us.us.us.us.us.us.us, label %iter.check137.us.us.us, label %for.cond.cleanup9.us.us.us.us.us.split.us.us.us, !llvm.loop !57

for.cond.cleanup9.us.us.us.us.us.split.us.us.us:  ; preds = %for.cond.cleanup13.us.us.us.us.us.us.loopexit.us.us.us
  %add34.us.us.us.us.us.us.us = add nsw i32 %j.079.us.us.us.us.us.us.us, %mul33.us.us.us.us
  %arrayidx35.us.us.us.us.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %output, i32 %add34.us.us.us.us.us.us.us
  store i32 %spec.select.us.us.us.us.us.us.us.us.us, ptr addrspace(4) %arrayidx35.us.us.us.us.us.us.us, align 4, !tbaa !3
  %inc37.us.us.us.us.us.us.us = add nuw nsw i32 %j.079.us.us.us.us.us.us.us, 1
  %cmp2.us.us.us.us.us.us.us = icmp slt i32 %inc37.us.us.us.us.us.us.us, %cols_out
  br i1 %cmp2.us.us.us.us.us.us.us, label %for.body10.lr.ph.split.us.us.us.us.us.us.us.us, label %for.cond.cleanup3.us.us.us.split.us.us, !llvm.loop !58

for.cond.cleanup3.us.us.us.split.us.us:           ; preds = %for.cond.cleanup9.us.us.us.us.us.split.us.us.us
  %inc40.us.us.us.us = add nuw nsw i32 %i.090.us.us.us.us, 1
  %cmp.us.us.us.us = icmp slt i32 %inc40.us.us.us.us, %rows_out
  br i1 %cmp.us.us.us.us, label %for.body4.lr.ph.split.us.split.us.us.us.us.us, label %for.cond.cleanup, !llvm.loop !59

for.cond.cleanup3.us.us.us:                       ; preds = %for.cond.cleanup9.us.us.us.us.us
  %inc40.us.us.us = add nuw nsw i32 %i.090.us.us.us, 1
  %cmp.us.us.us = icmp slt i32 %inc40.us.us.us, %rows_out
  br i1 %cmp.us.us.us, label %for.body4.lr.ph.split.us.split.us.us.us.us, label %for.cond.cleanup, !llvm.loop !59

for.body4.lr.ph.split.us.split.us.us.us.us:       ; preds = %for.body4.lr.ph.split.us.split.us.us.us.us.preheader, %for.cond.cleanup3.us.us.us
  %i.090.us.us.us = phi i32 [ %inc40.us.us.us, %for.cond.cleanup3.us.us.us ], [ 0, %for.body4.lr.ph.split.us.split.us.us.us.us.preheader ]
  %mul.us.us.us = mul nsw i32 %i.090.us.us.us, %W
  %mul5.us.us.us = mul nsw i32 %mul.us.us.us, %cols_in
  %mul33.us.us.us = mul nsw i32 %i.090.us.us.us, %cols_out
  br label %for.body10.lr.ph.split.us.us.us.us.us.us

for.cond.cleanup9.us.us.us.us.us:                 ; preds = %for.cond.cleanup13.us.us.us.us.us.us
  %add34.us.us.us.us.us = add nsw i32 %j.079.us.us.us.us.us, %mul33.us.us.us
  %arrayidx35.us.us.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %output, i32 %add34.us.us.us.us.us
  store i32 %spec.select.us.us.us.us.us.us.lcssa, ptr addrspace(4) %arrayidx35.us.us.us.us.us, align 4, !tbaa !3
  %inc37.us.us.us.us.us = add nuw nsw i32 %j.079.us.us.us.us.us, 1
  %cmp2.us.us.us.us.us = icmp slt i32 %inc37.us.us.us.us.us, %cols_out
  br i1 %cmp2.us.us.us.us.us, label %for.body10.lr.ph.split.us.us.us.us.us.us, label %for.cond.cleanup3.us.us.us, !llvm.loop !58

for.body10.lr.ph.split.us.us.us.us.us.us:         ; preds = %for.cond.cleanup9.us.us.us.us.us, %for.body4.lr.ph.split.us.split.us.us.us.us
  %j.079.us.us.us.us.us = phi i32 [ 0, %for.body4.lr.ph.split.us.split.us.us.us.us ], [ %inc37.us.us.us.us.us, %for.cond.cleanup9.us.us.us.us.us ]
  %mul6.us.us.us.us.us = mul nsw i32 %j.079.us.us.us.us.us, %W
  %add.us.us.us.us.us = add nsw i32 %mul6.us.us.us.us.us, %mul5.us.us.us
  %arrayidx.us.us.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %add.us.us.us.us.us
  %2 = load i32, ptr addrspace(4) %arrayidx.us.us.us.us.us, align 4, !tbaa !3
  br label %iter.check137

for.cond.cleanup13.us.us.us.us.us.us:             ; preds = %for.body14.us.us.us.us.us.us, %vec.epilog.middle.block156, %middle.block134
  %spec.select.us.us.us.us.us.us.lcssa = phi i32 [ %14, %middle.block134 ], [ %19, %vec.epilog.middle.block156 ], [ %spec.select.us.us.us.us.us.us, %for.body14.us.us.us.us.us.us ]
  %inc31.us.us.us.us.us.us = add nuw nsw i32 %w_i.076.us.us.us.us.us.us, 1
  %cmp8.us.us.us.us.us.us = icmp slt i32 %inc31.us.us.us.us.us.us, %W
  br i1 %cmp8.us.us.us.us.us.us, label %iter.check137, label %for.cond.cleanup9.us.us.us.us.us, !llvm.loop !57

for.body14.us.us.us.us.us.us:                     ; preds = %for.body14.us.us.us.us.us.us.preheader, %for.body14.us.us.us.us.us.us
  %w_j.073.us.us.us.us.us.us = phi i32 [ %inc.us.us.us.us.us.us, %for.body14.us.us.us.us.us.us ], [ %w_j.073.us.us.us.us.us.us.ph, %for.body14.us.us.us.us.us.us.preheader ]
  %max.172.us.us.us.us.us.us = phi i32 [ %spec.select.us.us.us.us.us.us, %for.body14.us.us.us.us.us.us ], [ %max.172.us.us.us.us.us.us.ph, %for.body14.us.us.us.us.us.us.preheader ]
  %add20.us.us.us.us.us.us = add i32 %add19.us.us.us.us.us.us, %w_j.073.us.us.us.us.us.us
  %arrayidx21.us.us.us.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %add20.us.us.us.us.us.us
  %3 = load i32, ptr addrspace(4) %arrayidx21.us.us.us.us.us.us, align 4, !tbaa !3
  %spec.select.us.us.us.us.us.us = tail call i32 @llvm.smax.i32(i32 %3, i32 %max.172.us.us.us.us.us.us)
  %inc.us.us.us.us.us.us = add nuw nsw i32 %w_j.073.us.us.us.us.us.us, 1
  %cmp12.us.us.us.us.us.us = icmp slt i32 %inc.us.us.us.us.us.us, %W
  br i1 %cmp12.us.us.us.us.us.us, label %for.body14.us.us.us.us.us.us, label %for.cond.cleanup13.us.us.us.us.us.us, !llvm.loop !56

iter.check137:                                    ; preds = %for.body10.lr.ph.split.us.us.us.us.us.us, %for.cond.cleanup13.us.us.us.us.us.us
  %w_i.076.us.us.us.us.us.us = phi i32 [ 0, %for.body10.lr.ph.split.us.us.us.us.us.us ], [ %inc31.us.us.us.us.us.us, %for.cond.cleanup13.us.us.us.us.us.us ]
  %max.075.us.us.us.us.us.us = phi i32 [ %2, %for.body10.lr.ph.split.us.us.us.us.us.us ], [ %spec.select.us.us.us.us.us.us.lcssa, %for.cond.cleanup13.us.us.us.us.us.us ]
  %add16.us.us.us.us.us.us = add nsw i32 %w_i.076.us.us.us.us.us.us, %mul.us.us.us
  %mul17.us.us.us.us.us.us = mul nsw i32 %add16.us.us.us.us.us.us, %cols_in
  %add19.us.us.us.us.us.us = add i32 %mul17.us.us.us.us.us.us, %mul6.us.us.us.us.us
  br i1 %min.iters.check138, label %vec.epilog.ph159, label %vector.ph140

vector.ph140:                                     ; preds = %iter.check137
  %minmax.ident.splatinsert = insertelement <16 x i32> poison, i32 %max.075.us.us.us.us.us.us, i64 0
  %minmax.ident.splat = shufflevector <16 x i32> %minmax.ident.splatinsert, <16 x i32> poison, <16 x i32> zeroinitializer
  br label %vector.body144

vector.body144:                                   ; preds = %vector.body144, %vector.ph140
  %index145 = phi i32 [ 0, %vector.ph140 ], [ %index.next153, %vector.body144 ]
  %vec.phi = phi <16 x i32> [ %minmax.ident.splat, %vector.ph140 ], [ %9, %vector.body144 ]
  %vec.phi146 = phi <16 x i32> [ %minmax.ident.splat, %vector.ph140 ], [ %10, %vector.body144 ]
  %vec.phi147 = phi <16 x i32> [ %minmax.ident.splat, %vector.ph140 ], [ %11, %vector.body144 ]
  %vec.phi148 = phi <16 x i32> [ %minmax.ident.splat, %vector.ph140 ], [ %12, %vector.body144 ]
  %4 = add i32 %add19.us.us.us.us.us.us, %index145
  %5 = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %4
  %wide.load149 = load <16 x i32>, ptr addrspace(4) %5, align 4, !tbaa !3
  %6 = getelementptr inbounds i32, ptr addrspace(4) %5, i32 16
  %wide.load150 = load <16 x i32>, ptr addrspace(4) %6, align 4, !tbaa !3
  %7 = getelementptr inbounds i32, ptr addrspace(4) %5, i32 32
  %wide.load151 = load <16 x i32>, ptr addrspace(4) %7, align 4, !tbaa !3
  %8 = getelementptr inbounds i32, ptr addrspace(4) %5, i32 48
  %wide.load152 = load <16 x i32>, ptr addrspace(4) %8, align 4, !tbaa !3
  %9 = tail call <16 x i32> @llvm.smax.v16i32(<16 x i32> %wide.load149, <16 x i32> %vec.phi)
  %10 = tail call <16 x i32> @llvm.smax.v16i32(<16 x i32> %wide.load150, <16 x i32> %vec.phi146)
  %11 = tail call <16 x i32> @llvm.smax.v16i32(<16 x i32> %wide.load151, <16 x i32> %vec.phi147)
  %12 = tail call <16 x i32> @llvm.smax.v16i32(<16 x i32> %wide.load152, <16 x i32> %vec.phi148)
  %index.next153 = add nuw i32 %index145, 64
  %13 = icmp eq i32 %index.next153, %n.vec142
  br i1 %13, label %middle.block134, label %vector.body144, !llvm.loop !60

middle.block134:                                  ; preds = %vector.body144
  %rdx.minmax = tail call <16 x i32> @llvm.smax.v16i32(<16 x i32> %9, <16 x i32> %10)
  %rdx.minmax154 = tail call <16 x i32> @llvm.smax.v16i32(<16 x i32> %rdx.minmax, <16 x i32> %11)
  %rdx.minmax155 = tail call <16 x i32> @llvm.smax.v16i32(<16 x i32> %rdx.minmax154, <16 x i32> %12)
  %14 = tail call i32 @llvm.vector.reduce.smax.v16i32(<16 x i32> %rdx.minmax155)
  br i1 %cmp.n143, label %for.cond.cleanup13.us.us.us.us.us.us, label %vec.epilog.iter.check158

vec.epilog.iter.check158:                         ; preds = %middle.block134
  br i1 %min.epilog.iters.check161, label %for.body14.us.us.us.us.us.us.preheader, label %vec.epilog.ph159

vec.epilog.ph159:                                 ; preds = %iter.check137, %vec.epilog.iter.check158
  %bc.merge.rdx = phi i32 [ %max.075.us.us.us.us.us.us, %iter.check137 ], [ %14, %vec.epilog.iter.check158 ]
  %vec.epilog.resume.val162 = phi i32 [ 0, %iter.check137 ], [ %n.vec142, %vec.epilog.iter.check158 ]
  %minmax.ident.splatinsert170 = insertelement <8 x i32> poison, i32 %bc.merge.rdx, i64 0
  %minmax.ident.splat171 = shufflevector <8 x i32> %minmax.ident.splatinsert170, <8 x i32> poison, <8 x i32> zeroinitializer
  br label %vec.epilog.vector.body167

vec.epilog.vector.body167:                        ; preds = %vec.epilog.vector.body167, %vec.epilog.ph159
  %index168 = phi i32 [ %vec.epilog.resume.val162, %vec.epilog.ph159 ], [ %index.next173, %vec.epilog.vector.body167 ]
  %vec.phi169 = phi <8 x i32> [ %minmax.ident.splat171, %vec.epilog.ph159 ], [ %17, %vec.epilog.vector.body167 ]
  %15 = add i32 %add19.us.us.us.us.us.us, %index168
  %16 = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %15
  %wide.load172 = load <8 x i32>, ptr addrspace(4) %16, align 4, !tbaa !3
  %17 = tail call <8 x i32> @llvm.smax.v8i32(<8 x i32> %wide.load172, <8 x i32> %vec.phi169)
  %index.next173 = add nuw i32 %index168, 8
  %18 = icmp eq i32 %index.next173, %n.vec164
  br i1 %18, label %vec.epilog.middle.block156, label %vec.epilog.vector.body167, !llvm.loop !61

vec.epilog.middle.block156:                       ; preds = %vec.epilog.vector.body167
  %19 = tail call i32 @llvm.vector.reduce.smax.v8i32(<8 x i32> %17)
  br i1 %cmp.n166, label %for.cond.cleanup13.us.us.us.us.us.us, label %for.body14.us.us.us.us.us.us.preheader

for.body14.us.us.us.us.us.us.preheader:           ; preds = %vec.epilog.iter.check158, %vec.epilog.middle.block156
  %w_j.073.us.us.us.us.us.us.ph = phi i32 [ %n.vec142, %vec.epilog.iter.check158 ], [ %n.vec164, %vec.epilog.middle.block156 ]
  %max.172.us.us.us.us.us.us.ph = phi i32 [ %14, %vec.epilog.iter.check158 ], [ %19, %vec.epilog.middle.block156 ]
  br label %for.body14.us.us.us.us.us.us

for.body.lr.ph.split.us.split:                    ; preds = %for.body.lr.ph.split.us
  %min.iters.check = icmp ult i32 %cols_out, 8
  br i1 %min.iters.check, label %iter.check.us.preheader, label %for.body.lr.ph.split.us.split.split

iter.check.us.preheader:                          ; preds = %for.body.lr.ph.split.us.split
  br label %iter.check.us

iter.check.us:                                    ; preds = %iter.check.us.preheader, %for.cond.cleanup3.us.loopexit.us
  %i.090.us.us = phi i32 [ %inc40.us.us, %for.cond.cleanup3.us.loopexit.us ], [ 0, %iter.check.us.preheader ]
  %mul5.us.us = mul i32 %i.090.us.us, %cols_in
  %mul33.us.us = mul nsw i32 %i.090.us.us, %cols_out
  br label %for.cond.cleanup9.us96.us

for.cond.cleanup9.us96.us:                        ; preds = %iter.check.us, %for.cond.cleanup9.us96.us
  %j.079.us92.us = phi i32 [ 0, %iter.check.us ], [ %inc37.us99.us, %for.cond.cleanup9.us96.us ]
  %reass.add.us = add i32 %j.079.us92.us, %mul5.us.us
  %reass.mul.us = mul i32 %reass.add.us, %W
  %arrayidx.us95.us = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %reass.mul.us
  %20 = load i32, ptr addrspace(4) %arrayidx.us95.us, align 4, !tbaa !3
  %add34.us97.us = add nsw i32 %j.079.us92.us, %mul33.us.us
  %arrayidx35.us98.us = getelementptr inbounds i32, ptr addrspace(4) %output, i32 %add34.us97.us
  store i32 %20, ptr addrspace(4) %arrayidx35.us98.us, align 4, !tbaa !3
  %inc37.us99.us = add nuw nsw i32 %j.079.us92.us, 1
  %cmp2.us100.us = icmp slt i32 %inc37.us99.us, %cols_out
  br i1 %cmp2.us100.us, label %for.cond.cleanup9.us96.us, label %for.cond.cleanup3.us.loopexit.us, !llvm.loop !62

for.cond.cleanup3.us.loopexit.us:                 ; preds = %for.cond.cleanup9.us96.us
  %inc40.us.us = add nuw nsw i32 %i.090.us.us, 1
  %cmp.us.us = icmp slt i32 %inc40.us.us, %rows_out
  br i1 %cmp.us.us, label %iter.check.us, label %for.cond.cleanup, !llvm.loop !59

for.body.lr.ph.split.us.split.split:              ; preds = %for.body.lr.ph.split.us.split
  br label %iter.check

for.cond.cleanup3.us:                             ; preds = %for.cond.cleanup9.us96
  %inc40.us = add nuw nsw i32 %i.090.us, 1
  %cmp.us = icmp slt i32 %inc40.us, %rows_out
  br i1 %cmp.us, label %iter.check, label %for.cond.cleanup, !llvm.loop !59

for.cond.cleanup9.us96:                           ; preds = %for.cond.cleanup9.us96, %iter.check
  %j.079.us92 = phi i32 [ 0, %iter.check ], [ %inc37.us99, %for.cond.cleanup9.us96 ]
  %reass.add = add i32 %j.079.us92, %mul5.us
  %reass.mul = mul i32 %reass.add, %W
  %arrayidx.us95 = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %reass.mul
  %21 = load i32, ptr addrspace(4) %arrayidx.us95, align 4, !tbaa !3
  %add34.us97 = add nsw i32 %j.079.us92, %mul33.us
  %arrayidx35.us98 = getelementptr inbounds i32, ptr addrspace(4) %output, i32 %add34.us97
  store i32 %21, ptr addrspace(4) %arrayidx35.us98, align 4, !tbaa !3
  %inc37.us99 = add nuw nsw i32 %j.079.us92, 1
  %cmp2.us100 = icmp slt i32 %inc37.us99, %cols_out
  br i1 %cmp2.us100, label %for.cond.cleanup9.us96, label %for.cond.cleanup3.us, !llvm.loop !62

iter.check:                                       ; preds = %for.body.lr.ph.split.us.split.split, %for.cond.cleanup3.us
  %i.090.us = phi i32 [ %inc40.us, %for.cond.cleanup3.us ], [ 0, %for.body.lr.ph.split.us.split.split ]
  %mul5.us = mul i32 %i.090.us, %cols_in
  %mul33.us = mul nsw i32 %i.090.us, %cols_out
  br label %for.cond.cleanup9.us96

for.cond.cleanup:                                 ; preds = %for.cond.cleanup3.us, %for.cond.cleanup3.us.loopexit.us, %for.cond.cleanup3.us.us.us, %for.cond.cleanup3.us.us.us.split.us.us, %entry
  ret void
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define dso_local void @vekt_max_pooling_wrapper(i32 noundef %rows_out, i32 noundef %cols_out, i32 noundef %rows_in, i32 noundef %cols_in, i32 noundef %W, ptr nocapture noundef %output, ptr nocapture noundef %input) local_unnamed_addr #5 {
entry:
  ret void
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <16 x i32> @llvm.arc.vvci.w.v512() #6

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <16 x i32> @llvm.arc.vvcadd.init.acc.w.v512(<16 x i32>, <16 x i32>) #6

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(read)
declare <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4)) #7

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(read)
declare <16 x i32> @llvm.arc.vgather.int.v512(ptr addrspace(4), <16 x i32>) #7

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <16 x i32> @llvm.arc.vvcmax.acc.w.v512(<16 x i32>, <16 x i32>) #6

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(write)
declare void @llvm.arc.vvst.w.v512(<16 x i32>, ptr addrspace(4)) #8

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32>) #6

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #9

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smax.i32(i32, i32) #10

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <2 x i32> @llvm.smax.v2i32(<2 x i32>, <2 x i32>) #10

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.smax.v2i32(<2 x i32>) #10

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <16 x i32> @llvm.smax.v16i32(<16 x i32>, <16 x i32>) #10

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.smax.v16i32(<16 x i32>) #10

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <8 x i32> @llvm.smax.v8i32(<8 x i32>, <8 x i32>) #10

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.smax.v8i32(<8 x i32>) #10

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: write) "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #1 = { nofree nounwind "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #2 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite) "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #3 = { mustprogress nofree nosync nounwind willreturn memory(argmem: readwrite) "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #4 = { mustprogress nofree nosync nounwind willreturn "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #5 = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #6 = { mustprogress nocallback nofree nosync nounwind willreturn memory(none) }
attributes #7 = { mustprogress nocallback nofree nosync nounwind willreturn memory(read) }
attributes #8 = { mustprogress nocallback nofree nosync nounwind willreturn memory(write) }
attributes #9 = { nofree nounwind }
attributes #10 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

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
!42 = distinct !{!42, !43}
!43 = distinct !{!43, !8, !35}
!44 = distinct !{!44, !43, !10}
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
!55 = distinct !{!55, !8, !9}
!56 = distinct !{!56, !8, !10, !9}
!57 = distinct !{!57, !8}
!58 = distinct !{!58, !8}
!59 = distinct !{!59, !8}
!60 = distinct !{!60, !8, !9, !10}
!61 = distinct !{!61, !8, !9, !10}
!62 = distinct !{!62, !8, !9}
