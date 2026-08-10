; ModuleID = 'transpose.c'
source_filename = "transpose.c"
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
define dso_local void @transpose(ptr nocapture noundef readonly %a, ptr nocapture noundef writeonly %t, i32 noundef %M, i32 noundef %N) local_unnamed_addr #2 {
entry:
  %cmp21 = icmp sgt i32 %M, 0
  %cmp219 = icmp sgt i32 %N, 0
  %or.cond = and i1 %cmp21, %cmp219
  br i1 %or.cond, label %for.body4.lr.ph.us.preheader, label %for.cond.cleanup

for.body4.lr.ph.us.preheader:                     ; preds = %entry
  br label %for.body4.lr.ph.us

for.cond.cleanup3.us:                             ; preds = %for.body4.us
  %inc9.us = add nuw nsw i32 %i.022.us, 1
  %cmp.us = icmp slt i32 %inc9.us, %M
  br i1 %cmp.us, label %for.body4.lr.ph.us, label %for.cond.cleanup, !llvm.loop !31

for.body4.us:                                     ; preds = %for.body4.lr.ph.us, %for.body4.us
  %j.020.us = phi i32 [ 0, %for.body4.lr.ph.us ], [ %inc.us, %for.body4.us ]
  %add.us = add nsw i32 %j.020.us, %mul.us
  %arrayidx.us = getelementptr inbounds i32, ptr %a, i32 %add.us
  %0 = load i32, ptr %arrayidx.us, align 4, !tbaa !3
  %mul5.us = mul nsw i32 %j.020.us, %M
  %add6.us = add nsw i32 %mul5.us, %i.022.us
  %arrayidx7.us = getelementptr inbounds i32, ptr %t, i32 %add6.us
  store i32 %0, ptr %arrayidx7.us, align 4, !tbaa !3
  %inc.us = add nuw nsw i32 %j.020.us, 1
  %cmp2.us = icmp slt i32 %inc.us, %N
  br i1 %cmp2.us, label %for.body4.us, label %for.cond.cleanup3.us, !llvm.loop !36

for.body4.lr.ph.us:                               ; preds = %for.body4.lr.ph.us.preheader, %for.cond.cleanup3.us
  %i.022.us = phi i32 [ %inc9.us, %for.cond.cleanup3.us ], [ 0, %for.body4.lr.ph.us.preheader ]
  %mul.us = mul nsw i32 %i.022.us, %N
  br label %for.body4.us

for.cond.cleanup:                                 ; preds = %for.cond.cleanup3.us, %entry
  ret void
}

; Function Attrs: mustprogress nofree nosync nounwind willreturn
define dso_local void @vectorized_transpose(ptr addrspace(4) noalias noundef %a, ptr addrspace(4) noalias noundef %t, i32 noundef %M, i32 noundef %N) local_unnamed_addr #3 {
entry:
  %div = sdiv i32 %N, 16
  %mul = shl nsw i32 %div, 4
  %cmp62 = icmp sgt i32 %M, 0
  br i1 %cmp62, label %for.body.lr.ph, label %for.cond.cleanup17

for.body.lr.ph:                                   ; preds = %entry
  %0 = tail call <16 x i32> @llvm.arc.vvci.w.v512()
  %splat.splatinsert = insertelement <16 x i32> poison, i32 %M, i64 0
  %splat.splat = shufflevector <16 x i32> %splat.splatinsert, <16 x i32> poison, <16 x i32> zeroinitializer
  %mul1 = mul <16 x i32> %0, %splat.splat
  %cmp360 = icmp sgt i32 %N, 15
  %shl.i = shl <16 x i32> %mul1, <i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2>
  br i1 %cmp360, label %for.body5.lr.ph.us.preheader, label %for.body18.lr.ph

for.body5.lr.ph.us.preheader:                     ; preds = %for.body.lr.ph
  br label %for.body5.lr.ph.us

for.cond.cleanup4.us:                             ; preds = %for.body5.us
  %inc.us = add nuw nsw i32 %i.063.us, 1
  %cmp.us = icmp slt i32 %inc.us, %M
  br i1 %cmp.us, label %for.body5.lr.ph.us, label %for.cond.cleanup, !llvm.loop !39

for.body5.us:                                     ; preds = %for.body5.lr.ph.us, %for.body5.us
  %j.061.us = phi i32 [ 0, %for.body5.lr.ph.us ], [ %add11.us, %for.body5.us ]
  %add.us = add nsw i32 %j.061.us, %mul6.us
  %arrayidx.us = getelementptr inbounds i32, ptr addrspace(4) %a, i32 %add.us
  %1 = tail call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %arrayidx.us)
  %mul8.us = mul nsw i32 %j.061.us, %M
  %add9.us = add nsw i32 %mul8.us, %i.063.us
  %arrayidx10.us = getelementptr inbounds i32, ptr addrspace(4) %t, i32 %add9.us
  tail call void @llvm.arc.vscatter.int.v512(ptr addrspace(4) %arrayidx10.us, <16 x i32> %shl.i, <16 x i32> %1)
  %add11.us = add nuw nsw i32 %j.061.us, 16
  %cmp3.us = icmp slt i32 %add11.us, %mul
  br i1 %cmp3.us, label %for.body5.us, label %for.cond.cleanup4.us, !llvm.loop !40

for.body5.lr.ph.us:                               ; preds = %for.body5.lr.ph.us.preheader, %for.cond.cleanup4.us
  %i.063.us = phi i32 [ %inc.us, %for.cond.cleanup4.us ], [ 0, %for.body5.lr.ph.us.preheader ]
  %mul6.us = mul nsw i32 %i.063.us, %N
  br label %for.body5.us

for.cond.cleanup:                                 ; preds = %for.cond.cleanup4.us
  %cmp2164 = icmp slt i32 %mul, %N
  br i1 %cmp2164, label %for.body18.lr.ph.split.us, label %for.cond.cleanup17

for.body18.lr.ph:                                 ; preds = %for.body.lr.ph
  %cmp2164.old = icmp slt i32 %mul, %N
  br i1 %cmp2164.old, label %for.body18.lr.ph.split.us, label %for.cond.cleanup17

for.body18.lr.ph.split.us:                        ; preds = %for.cond.cleanup, %for.body18.lr.ph
  %2 = add nuw nsw i32 %mul, 1
  %smax = tail call i32 @llvm.smax.i32(i32 %N, i32 %2)
  %3 = sub i32 %smax, %mul
  %min.iters.check = icmp ult i32 %3, 8
  %min.iters.check73 = icmp ult i32 %3, 64
  %n.vec = and i32 %3, -64
  %cmp.n = icmp eq i32 %3, %n.vec
  %n.vec.remaining = and i32 %3, 56
  %min.epilog.iters.check = icmp eq i32 %n.vec.remaining, 0
  %n.mod.vf77 = and i32 %smax, 7
  %n.vec78 = sub nuw i32 %3, %n.mod.vf77
  %cmp.n80 = icmp eq i32 %n.mod.vf77, 0
  br i1 %min.iters.check, label %iter.check.us.preheader, label %for.body18.lr.ph.split.us.split

iter.check.us.preheader:                          ; preds = %for.body18.lr.ph.split.us
  br label %iter.check.us

iter.check.us:                                    ; preds = %iter.check.us.preheader, %for.cond.cleanup22.us.us
  %i14.067.us.us = phi i32 [ %inc34.us.us, %for.cond.cleanup22.us.us ], [ 0, %iter.check.us.preheader ]
  %mul24.us.us = mul nsw i32 %i14.067.us.us, %N
  br label %for.body23.us.us

for.body23.us.us:                                 ; preds = %for.body23.us.us, %iter.check.us
  %j19.065.us.us = phi i32 [ %mul, %iter.check.us ], [ %inc31.us.us, %for.body23.us.us ]
  %add25.us.us = add nsw i32 %j19.065.us.us, %mul24.us.us
  %arrayidx26.us.us = getelementptr inbounds i32, ptr addrspace(4) %a, i32 %add25.us.us
  %4 = load i32, ptr addrspace(4) %arrayidx26.us.us, align 4, !tbaa !3
  %mul27.us.us = mul nsw i32 %j19.065.us.us, %M
  %add28.us.us = add nsw i32 %mul27.us.us, %i14.067.us.us
  %arrayidx29.us.us = getelementptr inbounds i32, ptr addrspace(4) %t, i32 %add28.us.us
  store i32 %4, ptr addrspace(4) %arrayidx29.us.us, align 4, !tbaa !3
  %inc31.us.us = add nsw i32 %j19.065.us.us, 1
  %cmp21.us.us = icmp slt i32 %inc31.us.us, %N
  br i1 %cmp21.us.us, label %for.body23.us.us, label %for.cond.cleanup22.us.us, !llvm.loop !41

for.cond.cleanup22.us.us:                         ; preds = %for.body23.us.us
  %inc34.us.us = add nuw nsw i32 %i14.067.us.us, 1
  %cmp16.us.us = icmp slt i32 %inc34.us.us, %M
  br i1 %cmp16.us.us, label %iter.check.us, label %for.cond.cleanup17, !llvm.loop !42

for.body18.lr.ph.split.us.split:                  ; preds = %for.body18.lr.ph.split.us
  %ident.check.not = icmp eq i32 %M, 1
  br i1 %ident.check.not, label %iter.check.us85, label %iter.check.preheader

iter.check.preheader:                             ; preds = %for.body18.lr.ph.split.us.split
  br label %iter.check

iter.check.us85:                                  ; preds = %for.body18.lr.ph.split.us.split
  br i1 %min.iters.check73, label %vec.epilog.vector.body.us.preheader, label %vector.body.us.preheader

vector.body.us.preheader:                         ; preds = %iter.check.us85
  br label %vector.body.us

vector.body.us:                                   ; preds = %vector.body.us.preheader, %vector.body.us
  %index.us = phi i32 [ %index.next.us, %vector.body.us ], [ 0, %vector.body.us.preheader ]
  %offset.idx.us = add i32 %mul, %index.us
  %5 = getelementptr inbounds i32, ptr addrspace(4) %a, i32 %offset.idx.us
  %wide.load.us = load <16 x i32>, ptr addrspace(4) %5, align 4, !tbaa !3
  %6 = getelementptr inbounds i32, ptr addrspace(4) %5, i32 16
  %wide.load74.us = load <16 x i32>, ptr addrspace(4) %6, align 4, !tbaa !3
  %7 = getelementptr inbounds i32, ptr addrspace(4) %5, i32 32
  %wide.load75.us = load <16 x i32>, ptr addrspace(4) %7, align 4, !tbaa !3
  %8 = getelementptr inbounds i32, ptr addrspace(4) %5, i32 48
  %wide.load76.us = load <16 x i32>, ptr addrspace(4) %8, align 4, !tbaa !3
  %9 = getelementptr inbounds i32, ptr addrspace(4) %t, i32 %offset.idx.us
  store <16 x i32> %wide.load.us, ptr addrspace(4) %9, align 4, !tbaa !3
  %10 = getelementptr inbounds i32, ptr addrspace(4) %9, i32 16
  store <16 x i32> %wide.load74.us, ptr addrspace(4) %10, align 4, !tbaa !3
  %11 = getelementptr inbounds i32, ptr addrspace(4) %9, i32 32
  store <16 x i32> %wide.load75.us, ptr addrspace(4) %11, align 4, !tbaa !3
  %12 = getelementptr inbounds i32, ptr addrspace(4) %9, i32 48
  store <16 x i32> %wide.load76.us, ptr addrspace(4) %12, align 4, !tbaa !3
  %index.next.us = add nuw i32 %index.us, 64
  %13 = icmp eq i32 %index.next.us, %n.vec
  br i1 %13, label %middle.block.us, label %vector.body.us, !llvm.loop !43

middle.block.us:                                  ; preds = %vector.body.us
  br i1 %cmp.n, label %for.cond.cleanup17, label %vec.epilog.iter.check.us

vec.epilog.iter.check.us:                         ; preds = %middle.block.us
  br i1 %min.epilog.iters.check, label %vec.epilog.scalar.ph.us88, label %vec.epilog.vector.body.us.preheader

vec.epilog.vector.body.us.preheader:              ; preds = %vec.epilog.iter.check.us, %iter.check.us85
  %index81.us.ph = phi i32 [ 0, %iter.check.us85 ], [ %n.vec, %vec.epilog.iter.check.us ]
  br label %vec.epilog.vector.body.us

vec.epilog.vector.body.us:                        ; preds = %vec.epilog.vector.body.us.preheader, %vec.epilog.vector.body.us
  %index81.us = phi i32 [ %index.next84.us, %vec.epilog.vector.body.us ], [ %index81.us.ph, %vec.epilog.vector.body.us.preheader ]
  %offset.idx82.us = add i32 %mul, %index81.us
  %14 = getelementptr inbounds i32, ptr addrspace(4) %a, i32 %offset.idx82.us
  %wide.load83.us = load <8 x i32>, ptr addrspace(4) %14, align 4, !tbaa !3
  %15 = getelementptr inbounds i32, ptr addrspace(4) %t, i32 %offset.idx82.us
  store <8 x i32> %wide.load83.us, ptr addrspace(4) %15, align 4, !tbaa !3
  %index.next84.us = add nuw i32 %index81.us, 8
  %16 = icmp eq i32 %index.next84.us, %n.vec78
  br i1 %16, label %vec.epilog.middle.block.us, label %vec.epilog.vector.body.us, !llvm.loop !44

vec.epilog.middle.block.us:                       ; preds = %vec.epilog.vector.body.us
  br i1 %cmp.n80, label %for.cond.cleanup17, label %vec.epilog.scalar.ph.us88

vec.epilog.scalar.ph.us88:                        ; preds = %vec.epilog.middle.block.us, %vec.epilog.iter.check.us
  %n.vec78.pn = phi i32 [ %n.vec78, %vec.epilog.middle.block.us ], [ %n.vec, %vec.epilog.iter.check.us ]
  %bc.resume.val.us89 = add i32 %mul, %n.vec78.pn
  br label %for.body23.us.us90

for.body23.us.us90:                               ; preds = %for.body23.us.us90, %vec.epilog.scalar.ph.us88
  %j19.065.us.us91 = phi i32 [ %bc.resume.val.us89, %vec.epilog.scalar.ph.us88 ], [ %inc31.us.us97, %for.body23.us.us90 ]
  %arrayidx26.us.us93 = getelementptr inbounds i32, ptr addrspace(4) %a, i32 %j19.065.us.us91
  %17 = load i32, ptr addrspace(4) %arrayidx26.us.us93, align 4, !tbaa !3
  %arrayidx29.us.us96 = getelementptr inbounds i32, ptr addrspace(4) %t, i32 %j19.065.us.us91
  store i32 %17, ptr addrspace(4) %arrayidx29.us.us96, align 4, !tbaa !3
  %inc31.us.us97 = add nsw i32 %j19.065.us.us91, 1
  %cmp21.us.us98 = icmp slt i32 %inc31.us.us97, %N
  br i1 %cmp21.us.us98, label %for.body23.us.us90, label %for.cond.cleanup17, !llvm.loop !41

for.cond.cleanup22.us:                            ; preds = %for.body23.us
  %inc34.us = add nuw nsw i32 %i14.067.us, 1
  %cmp16.us = icmp slt i32 %inc34.us, %M
  br i1 %cmp16.us, label %iter.check, label %for.cond.cleanup17, !llvm.loop !42

for.body23.us:                                    ; preds = %iter.check, %for.body23.us
  %j19.065.us = phi i32 [ %mul, %iter.check ], [ %inc31.us, %for.body23.us ]
  %add25.us = add nsw i32 %j19.065.us, %mul24.us
  %arrayidx26.us = getelementptr inbounds i32, ptr addrspace(4) %a, i32 %add25.us
  %18 = load i32, ptr addrspace(4) %arrayidx26.us, align 4, !tbaa !3
  %mul27.us = mul nsw i32 %j19.065.us, %M
  %add28.us = add nsw i32 %mul27.us, %i14.067.us
  %arrayidx29.us = getelementptr inbounds i32, ptr addrspace(4) %t, i32 %add28.us
  store i32 %18, ptr addrspace(4) %arrayidx29.us, align 4, !tbaa !3
  %inc31.us = add nsw i32 %j19.065.us, 1
  %cmp21.us = icmp slt i32 %inc31.us, %N
  br i1 %cmp21.us, label %for.body23.us, label %for.cond.cleanup22.us, !llvm.loop !41

iter.check:                                       ; preds = %iter.check.preheader, %for.cond.cleanup22.us
  %i14.067.us = phi i32 [ %inc34.us, %for.cond.cleanup22.us ], [ 0, %iter.check.preheader ]
  %mul24.us = mul nsw i32 %i14.067.us, %N
  br label %for.body23.us

for.cond.cleanup17:                               ; preds = %for.cond.cleanup22.us, %for.body23.us.us90, %vec.epilog.middle.block.us, %middle.block.us, %for.cond.cleanup22.us.us, %entry, %for.body18.lr.ph, %for.cond.cleanup
  ret void
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @autovectorized_transpose(ptr addrspace(4) noalias nocapture noundef readonly %a, ptr addrspace(4) noalias nocapture noundef writeonly %t, i32 noundef %M, i32 noundef %N) local_unnamed_addr #2 {
entry:
  %cmp22 = icmp sgt i32 %N, 0
  br i1 %cmp22, label %for.body.lr.ph.split.us, label %for.cond.cleanup

for.body.lr.ph.split.us:                          ; preds = %entry
  %min.iters.check = icmp ult i32 %N, 8
  %n.vec = and i32 %N, -64
  %broadcast.splatinsert = insertelement <16 x i32> poison, i32 %N, i64 0
  %broadcast.splat = shufflevector <16 x i32> %broadcast.splatinsert, <16 x i32> poison, <16 x i32> zeroinitializer
  %cmp.n = icmp eq i32 %n.vec, %N
  %n.vec.remaining = and i32 %N, 56
  %min.epilog.iters.check = icmp eq i32 %n.vec.remaining, 0
  %n.vec46 = and i32 %N, -8
  %broadcast.splatinsert54 = insertelement <8 x i32> poison, i32 %N, i64 0
  %broadcast.splat55 = shufflevector <8 x i32> %broadcast.splatinsert54, <8 x i32> poison, <8 x i32> zeroinitializer
  %cmp.n48 = icmp eq i32 %n.vec46, %N
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
  %arrayidx.us.us = getelementptr inbounds i32, ptr addrspace(4) %a, i32 %add.us.us
  %0 = load i32, ptr addrspace(4) %arrayidx.us.us, align 4, !tbaa !3
  %mul5.us.us = mul nsw i32 %j.021.us.us, %N
  %add6.us.us = add nsw i32 %mul5.us.us, %i.023.us.us
  %arrayidx7.us.us = getelementptr inbounds i32, ptr addrspace(4) %t, i32 %add6.us.us
  store i32 %0, ptr addrspace(4) %arrayidx7.us.us, align 4, !tbaa !3
  %inc.us.us = add nuw nsw i32 %j.021.us.us, 1
  %cmp2.us.us = icmp slt i32 %inc.us.us, %N
  br i1 %cmp2.us.us, label %for.body4.us.us, label %for.cond.cleanup3.us.loopexit.us, !llvm.loop !45

for.cond.cleanup3.us.loopexit.us:                 ; preds = %for.body4.us.us
  %inc9.us.us = add nuw nsw i32 %i.023.us.us, 1
  %cmp.us.us = icmp slt i32 %inc9.us.us, %N
  br i1 %cmp.us.us, label %iter.check.us, label %for.cond.cleanup, !llvm.loop !46

for.body.lr.ph.split.us.split:                    ; preds = %for.body.lr.ph.split.us
  %min.iters.check24 = icmp ult i32 %N, 64
  br i1 %min.iters.check24, label %for.body.lr.ph.split.us.split.split.us, label %iter.check.preheader

iter.check.preheader:                             ; preds = %for.body.lr.ph.split.us.split
  %.splatinsert = insertelement <8 x i32> poison, i32 %n.vec, i64 0
  %.splat = shufflevector <8 x i32> %.splatinsert, <8 x i32> poison, <8 x i32> zeroinitializer
  %induction = add nuw nsw <8 x i32> %.splat, <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  br label %iter.check

for.body.lr.ph.split.us.split.split.us:           ; preds = %for.body.lr.ph.split.us.split
  br i1 %cmp.n48, label %iter.check.us59.us.preheader, label %iter.check.us59.preheader

iter.check.us59.preheader:                        ; preds = %for.body.lr.ph.split.us.split.split.us
  br label %iter.check.us59

iter.check.us59.us.preheader:                     ; preds = %for.body.lr.ph.split.us.split.split.us
  br label %iter.check.us59.us

iter.check.us59.us:                               ; preds = %iter.check.us59.us.preheader, %vec.epilog.middle.block.us.us
  %i.023.us.us60.us = phi i32 [ %inc9.us.us72.us, %vec.epilog.middle.block.us.us ], [ 0, %iter.check.us59.us.preheader ]
  %mul.us.us61.us = mul nsw i32 %i.023.us.us60.us, %N
  %broadcast.splatinsert56.us.us = insertelement <8 x i32> poison, i32 %i.023.us.us60.us, i64 0
  %broadcast.splat57.us.us = shufflevector <8 x i32> %broadcast.splatinsert56.us.us, <8 x i32> poison, <8 x i32> zeroinitializer
  br label %vec.epilog.vector.body.us.us

vec.epilog.middle.block.us.us:                    ; preds = %vec.epilog.vector.body.us.us
  %inc9.us.us72.us = add nuw nsw i32 %i.023.us.us60.us, 1
  %cmp.us.us73.us = icmp slt i32 %inc9.us.us72.us, %N
  br i1 %cmp.us.us73.us, label %iter.check.us59.us, label %for.cond.cleanup, !llvm.loop !46

vec.epilog.vector.body.us.us:                     ; preds = %vec.epilog.vector.body.us.us, %iter.check.us59.us
  %index49.us.us = phi i32 [ 0, %iter.check.us59.us ], [ %index.next58.us.us, %vec.epilog.vector.body.us.us ]
  %vec.ind50.us.us = phi <8 x i32> [ <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>, %iter.check.us59.us ], [ %vec.ind.next52.us.us, %vec.epilog.vector.body.us.us ]
  %1 = add nsw i32 %index49.us.us, %mul.us.us61.us
  %2 = getelementptr inbounds i32, ptr addrspace(4) %a, i32 %1
  %wide.load53.us.us = load <8 x i32>, ptr addrspace(4) %2, align 4, !tbaa !3
  %3 = mul nsw <8 x i32> %vec.ind50.us.us, %broadcast.splat55
  %4 = add nsw <8 x i32> %3, %broadcast.splat57.us.us
  %5 = getelementptr inbounds i32, ptr addrspace(4) %t, <8 x i32> %4
  tail call void @llvm.masked.scatter.v8i32.v8p4(<8 x i32> %wide.load53.us.us, <8 x ptr addrspace(4)> %5, i32 4, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>), !tbaa !3
  %index.next58.us.us = add nuw i32 %index49.us.us, 8
  %vec.ind.next52.us.us = add <8 x i32> %vec.ind50.us.us, <i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8>
  %6 = icmp eq i32 %index.next58.us.us, %N
  br i1 %6, label %vec.epilog.middle.block.us.us, label %vec.epilog.vector.body.us.us, !llvm.loop !47

iter.check.us59:                                  ; preds = %iter.check.us59.preheader, %for.cond.cleanup3.us.loopexit.us76
  %i.023.us.us60 = phi i32 [ %inc9.us.us72, %for.cond.cleanup3.us.loopexit.us76 ], [ 0, %iter.check.us59.preheader ]
  %mul.us.us61 = mul nsw i32 %i.023.us.us60, %N
  %broadcast.splatinsert56.us = insertelement <8 x i32> poison, i32 %i.023.us.us60, i64 0
  %broadcast.splat57.us = shufflevector <8 x i32> %broadcast.splatinsert56.us, <8 x i32> poison, <8 x i32> zeroinitializer
  br label %vec.epilog.vector.body.us

for.body4.us.us62:                                ; preds = %for.body4.us.us62.preheader, %for.body4.us.us62
  %j.021.us.us63 = phi i32 [ %inc.us.us69, %for.body4.us.us62 ], [ %n.vec46, %for.body4.us.us62.preheader ]
  %add.us.us64 = add nsw i32 %j.021.us.us63, %mul.us.us61
  %arrayidx.us.us65 = getelementptr inbounds i32, ptr addrspace(4) %a, i32 %add.us.us64
  %7 = load i32, ptr addrspace(4) %arrayidx.us.us65, align 4, !tbaa !3
  %mul5.us.us66 = mul nsw i32 %j.021.us.us63, %N
  %add6.us.us67 = add nsw i32 %mul5.us.us66, %i.023.us.us60
  %arrayidx7.us.us68 = getelementptr inbounds i32, ptr addrspace(4) %t, i32 %add6.us.us67
  store i32 %7, ptr addrspace(4) %arrayidx7.us.us68, align 4, !tbaa !3
  %inc.us.us69 = add nuw nsw i32 %j.021.us.us63, 1
  %cmp2.us.us70 = icmp slt i32 %inc.us.us69, %N
  br i1 %cmp2.us.us70, label %for.body4.us.us62, label %for.cond.cleanup3.us.loopexit.us76, !llvm.loop !45

vec.epilog.vector.body.us:                        ; preds = %vec.epilog.vector.body.us, %iter.check.us59
  %index49.us = phi i32 [ 0, %iter.check.us59 ], [ %index.next58.us, %vec.epilog.vector.body.us ]
  %vec.ind50.us = phi <8 x i32> [ <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>, %iter.check.us59 ], [ %vec.ind.next52.us, %vec.epilog.vector.body.us ]
  %8 = add nsw i32 %index49.us, %mul.us.us61
  %9 = getelementptr inbounds i32, ptr addrspace(4) %a, i32 %8
  %wide.load53.us = load <8 x i32>, ptr addrspace(4) %9, align 4, !tbaa !3
  %10 = mul nsw <8 x i32> %vec.ind50.us, %broadcast.splat55
  %11 = add nsw <8 x i32> %10, %broadcast.splat57.us
  %12 = getelementptr inbounds i32, ptr addrspace(4) %t, <8 x i32> %11
  tail call void @llvm.masked.scatter.v8i32.v8p4(<8 x i32> %wide.load53.us, <8 x ptr addrspace(4)> %12, i32 4, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>), !tbaa !3
  %index.next58.us = add nuw i32 %index49.us, 8
  %vec.ind.next52.us = add <8 x i32> %vec.ind50.us, <i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8>
  %13 = icmp eq i32 %index.next58.us, %n.vec46
  br i1 %13, label %for.body4.us.us62.preheader, label %vec.epilog.vector.body.us, !llvm.loop !47

for.body4.us.us62.preheader:                      ; preds = %vec.epilog.vector.body.us
  br label %for.body4.us.us62

for.cond.cleanup3.us.loopexit.us76:               ; preds = %for.body4.us.us62
  %inc9.us.us72 = add nuw nsw i32 %i.023.us.us60, 1
  %cmp.us.us73 = icmp slt i32 %inc9.us.us72, %N
  br i1 %cmp.us.us73, label %iter.check.us59, label %for.cond.cleanup, !llvm.loop !46

for.cond.cleanup3.us:                             ; preds = %for.body4.us, %vec.epilog.middle.block, %middle.block
  %inc9.us = add nuw nsw i32 %i.023.us, 1
  %cmp.us = icmp slt i32 %inc9.us, %N
  br i1 %cmp.us, label %iter.check, label %for.cond.cleanup, !llvm.loop !46

for.body4.us:                                     ; preds = %for.body4.us.preheader, %for.body4.us
  %j.021.us = phi i32 [ %inc.us, %for.body4.us ], [ %j.021.us.ph, %for.body4.us.preheader ]
  %add.us = add nsw i32 %j.021.us, %mul.us
  %arrayidx.us = getelementptr inbounds i32, ptr addrspace(4) %a, i32 %add.us
  %14 = load i32, ptr addrspace(4) %arrayidx.us, align 4, !tbaa !3
  %mul5.us = mul nsw i32 %j.021.us, %N
  %add6.us = add nsw i32 %mul5.us, %i.023.us
  %arrayidx7.us = getelementptr inbounds i32, ptr addrspace(4) %t, i32 %add6.us
  store i32 %14, ptr addrspace(4) %arrayidx7.us, align 4, !tbaa !3
  %inc.us = add nuw nsw i32 %j.021.us, 1
  %cmp2.us = icmp slt i32 %inc.us, %N
  br i1 %cmp2.us, label %for.body4.us, label %for.cond.cleanup3.us, !llvm.loop !45

iter.check:                                       ; preds = %iter.check.preheader, %for.cond.cleanup3.us
  %i.023.us = phi i32 [ %inc9.us, %for.cond.cleanup3.us ], [ 0, %iter.check.preheader ]
  %mul.us = mul nsw i32 %i.023.us, %N
  %broadcast.splatinsert37 = insertelement <16 x i32> poison, i32 %i.023.us, i64 0
  %broadcast.splat38 = shufflevector <16 x i32> %broadcast.splatinsert37, <16 x i32> poison, <16 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %iter.check
  %index = phi i32 [ 0, %iter.check ], [ %index.next, %vector.body ]
  %vec.ind = phi <16 x i32> [ <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>, %iter.check ], [ %vec.ind.next, %vector.body ]
  %step.add = add <16 x i32> %vec.ind, <i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16>
  %step.add25 = add <16 x i32> %vec.ind, <i32 32, i32 32, i32 32, i32 32, i32 32, i32 32, i32 32, i32 32, i32 32, i32 32, i32 32, i32 32, i32 32, i32 32, i32 32, i32 32>
  %step.add26 = add <16 x i32> %vec.ind, <i32 48, i32 48, i32 48, i32 48, i32 48, i32 48, i32 48, i32 48, i32 48, i32 48, i32 48, i32 48, i32 48, i32 48, i32 48, i32 48>
  %15 = add nsw i32 %index, %mul.us
  %16 = getelementptr inbounds i32, ptr addrspace(4) %a, i32 %15
  %wide.load = load <16 x i32>, ptr addrspace(4) %16, align 4, !tbaa !3
  %17 = getelementptr inbounds i32, ptr addrspace(4) %16, i32 16
  %wide.load28 = load <16 x i32>, ptr addrspace(4) %17, align 4, !tbaa !3
  %18 = getelementptr inbounds i32, ptr addrspace(4) %16, i32 32
  %wide.load29 = load <16 x i32>, ptr addrspace(4) %18, align 4, !tbaa !3
  %19 = getelementptr inbounds i32, ptr addrspace(4) %16, i32 48
  %wide.load30 = load <16 x i32>, ptr addrspace(4) %19, align 4, !tbaa !3
  %20 = mul nsw <16 x i32> %vec.ind, %broadcast.splat
  %21 = mul nsw <16 x i32> %step.add, %broadcast.splat
  %22 = mul nsw <16 x i32> %step.add25, %broadcast.splat
  %23 = mul nsw <16 x i32> %step.add26, %broadcast.splat
  %24 = add nsw <16 x i32> %20, %broadcast.splat38
  %25 = add nsw <16 x i32> %21, %broadcast.splat38
  %26 = add nsw <16 x i32> %22, %broadcast.splat38
  %27 = add nsw <16 x i32> %23, %broadcast.splat38
  %28 = getelementptr inbounds i32, ptr addrspace(4) %t, <16 x i32> %24
  %29 = getelementptr inbounds i32, ptr addrspace(4) %t, <16 x i32> %25
  %30 = getelementptr inbounds i32, ptr addrspace(4) %t, <16 x i32> %26
  %31 = getelementptr inbounds i32, ptr addrspace(4) %t, <16 x i32> %27
  tail call void @llvm.masked.scatter.v16i32.v16p4(<16 x i32> %wide.load, <16 x ptr addrspace(4)> %28, i32 4, <16 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>), !tbaa !3
  tail call void @llvm.masked.scatter.v16i32.v16p4(<16 x i32> %wide.load28, <16 x ptr addrspace(4)> %29, i32 4, <16 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>), !tbaa !3
  tail call void @llvm.masked.scatter.v16i32.v16p4(<16 x i32> %wide.load29, <16 x ptr addrspace(4)> %30, i32 4, <16 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>), !tbaa !3
  tail call void @llvm.masked.scatter.v16i32.v16p4(<16 x i32> %wide.load30, <16 x ptr addrspace(4)> %31, i32 4, <16 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>), !tbaa !3
  %index.next = add nuw i32 %index, 64
  %vec.ind.next = add <16 x i32> %vec.ind, <i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64, i32 64>
  %32 = icmp eq i32 %index.next, %n.vec
  br i1 %32, label %middle.block, label %vector.body, !llvm.loop !48

middle.block:                                     ; preds = %vector.body
  br i1 %cmp.n, label %for.cond.cleanup3.us, label %vec.epilog.iter.check

vec.epilog.iter.check:                            ; preds = %middle.block
  br i1 %min.epilog.iters.check, label %for.body4.us.preheader, label %vec.epilog.ph

vec.epilog.ph:                                    ; preds = %vec.epilog.iter.check
  %broadcast.splatinsert56 = insertelement <8 x i32> poison, i32 %i.023.us, i64 0
  %broadcast.splat57 = shufflevector <8 x i32> %broadcast.splatinsert56, <8 x i32> poison, <8 x i32> zeroinitializer
  br label %vec.epilog.vector.body

vec.epilog.vector.body:                           ; preds = %vec.epilog.vector.body, %vec.epilog.ph
  %index49 = phi i32 [ %n.vec, %vec.epilog.ph ], [ %index.next58, %vec.epilog.vector.body ]
  %vec.ind50 = phi <8 x i32> [ %induction, %vec.epilog.ph ], [ %vec.ind.next52, %vec.epilog.vector.body ]
  %33 = add nsw i32 %index49, %mul.us
  %34 = getelementptr inbounds i32, ptr addrspace(4) %a, i32 %33
  %wide.load53 = load <8 x i32>, ptr addrspace(4) %34, align 4, !tbaa !3
  %35 = mul nsw <8 x i32> %vec.ind50, %broadcast.splat55
  %36 = add nsw <8 x i32> %35, %broadcast.splat57
  %37 = getelementptr inbounds i32, ptr addrspace(4) %t, <8 x i32> %36
  tail call void @llvm.masked.scatter.v8i32.v8p4(<8 x i32> %wide.load53, <8 x ptr addrspace(4)> %37, i32 4, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>), !tbaa !3
  %index.next58 = add nuw i32 %index49, 8
  %vec.ind.next52 = add <8 x i32> %vec.ind50, <i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8>
  %38 = icmp eq i32 %index.next58, %n.vec46
  br i1 %38, label %vec.epilog.middle.block, label %vec.epilog.vector.body, !llvm.loop !47

vec.epilog.middle.block:                          ; preds = %vec.epilog.vector.body
  br i1 %cmp.n48, label %for.cond.cleanup3.us, label %for.body4.us.preheader

for.body4.us.preheader:                           ; preds = %vec.epilog.iter.check, %vec.epilog.middle.block
  %j.021.us.ph = phi i32 [ %n.vec, %vec.epilog.iter.check ], [ %n.vec46, %vec.epilog.middle.block ]
  br label %for.body4.us

for.cond.cleanup:                                 ; preds = %for.cond.cleanup3.us, %for.cond.cleanup3.us.loopexit.us76, %vec.epilog.middle.block.us.us, %for.cond.cleanup3.us.loopexit.us, %entry
  ret void
}

; Function Attrs: nounwind
define dso_local void @vekt_transpose_wrapper(ptr noundef %a, ptr noundef %t, i32 noundef %M, i32 noundef %N) local_unnamed_addr #4 {
entry:
  tail call void @vekt_transpose(i32 noundef %M, i32 noundef %N, ptr noundef %a, ptr noundef %a, i32 noundef 0, i32 noundef %M, i32 noundef %N, i32 noundef %N, i32 noundef 1, ptr noundef %t, ptr noundef %t, i32 noundef 0, i32 noundef %N, i32 noundef %M, i32 noundef %M, i32 noundef 1) #12
  ret void
}

declare void @vekt_transpose(i32 noundef, i32 noundef, ptr noundef, ptr noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef, ptr noundef, ptr noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef) local_unnamed_addr #5

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <16 x i32> @llvm.arc.vvci.w.v512() #6

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(read)
declare <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4)) #7

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(write)
declare void @llvm.arc.vscatter.int.v512(ptr addrspace(4), <16 x i32>, <16 x i32>) #8

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #9

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smax.i32(i32, i32) #10

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(write)
declare void @llvm.masked.scatter.v16i32.v16p4(<16 x i32>, <16 x ptr addrspace(4)>, i32 immarg, <16 x i1>) #11

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(write)
declare void @llvm.masked.scatter.v8i32.v8p4(<8 x i32>, <8 x ptr addrspace(4)>, i32 immarg, <8 x i1>) #11

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
attributes #11 = { nocallback nofree nosync nounwind willreturn memory(write) }
attributes #12 = { nounwind }

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
!39 = distinct !{!39, !8}
!40 = distinct !{!40, !8}
!41 = distinct !{!41, !8, !9}
!42 = distinct !{!42, !8}
!43 = distinct !{!43, !8, !9, !10}
!44 = distinct !{!44, !8, !9, !10}
!45 = distinct !{!45, !8, !10, !9}
!46 = distinct !{!46, !8}
!47 = distinct !{!47, !8, !9, !10}
!48 = distinct !{!48, !8, !9, !10}
