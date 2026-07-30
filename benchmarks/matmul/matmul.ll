; ModuleID = 'matmul.c'
source_filename = "matmul.c"
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
define dso_local void @matmul(ptr nocapture noundef readonly %A, ptr nocapture noundef readonly %B, ptr nocapture noundef %C, i32 noundef %M, i32 noundef %N, i32 noundef %K) local_unnamed_addr #2 {
entry:
  %cmp40 = icmp sgt i32 %M, 0
  %cmp238 = icmp sgt i32 %N, 0
  %or.cond = and i1 %cmp40, %cmp238
  %cmp635 = icmp sgt i32 %K, 0
  %or.cond53 = and i1 %or.cond, %cmp635
  br i1 %or.cond53, label %for.body4.lr.ph.split.us.us.us.preheader, label %for.cond.cleanup

for.body4.lr.ph.split.us.us.us.preheader:         ; preds = %entry
  br label %for.body4.lr.ph.split.us.us.us

for.cond.cleanup3.us.us:                          ; preds = %for.cond.cleanup7.us.us.us
  %inc21.us.us = add nuw nsw i32 %i.041.us.us, 1
  %cmp.us.us = icmp slt i32 %inc21.us.us, %M
  br i1 %cmp.us.us, label %for.body4.lr.ph.split.us.us.us, label %for.cond.cleanup, !llvm.loop !31

for.body4.lr.ph.split.us.us.us:                   ; preds = %for.body4.lr.ph.split.us.us.us.preheader, %for.cond.cleanup3.us.us
  %i.041.us.us = phi i32 [ %inc21.us.us, %for.cond.cleanup3.us.us ], [ 0, %for.body4.lr.ph.split.us.us.us.preheader ]
  %mul.us.us = mul nsw i32 %i.041.us.us, %K
  %mul13.us.us = mul nsw i32 %i.041.us.us, %N
  br label %for.body8.lr.ph.us.us.us

for.cond.cleanup7.us.us.us:                       ; preds = %for.body8.us.us.us
  %inc18.us.us.us = add nuw nsw i32 %j.039.us.us.us, 1
  %cmp2.us.us.us = icmp slt i32 %inc18.us.us.us, %N
  br i1 %cmp2.us.us.us, label %for.body8.lr.ph.us.us.us, label %for.cond.cleanup3.us.us, !llvm.loop !36

for.body8.us.us.us:                               ; preds = %for.body8.lr.ph.us.us.us, %for.body8.us.us.us
  %add1637.us.us.us = phi i32 [ %arrayidx15.promoted.us.us.us, %for.body8.lr.ph.us.us.us ], [ %add16.us.us.us, %for.body8.us.us.us ]
  %k.036.us.us.us = phi i32 [ 0, %for.body8.lr.ph.us.us.us ], [ %inc.us.us.us, %for.body8.us.us.us ]
  %add.us.us.us = add nsw i32 %k.036.us.us.us, %mul.us.us
  %arrayidx.us.us.us = getelementptr inbounds i32, ptr %A, i32 %add.us.us.us
  %0 = load i32, ptr %arrayidx.us.us.us, align 4, !tbaa !3
  %mul9.us.us.us = mul nsw i32 %k.036.us.us.us, %N
  %add10.us.us.us = add nsw i32 %mul9.us.us.us, %j.039.us.us.us
  %arrayidx11.us.us.us = getelementptr inbounds i32, ptr %B, i32 %add10.us.us.us
  %1 = load i32, ptr %arrayidx11.us.us.us, align 4, !tbaa !3
  %mul12.us.us.us = mul nsw i32 %1, %0
  %add16.us.us.us = add nsw i32 %mul12.us.us.us, %add1637.us.us.us
  store i32 %add16.us.us.us, ptr %arrayidx15.us.us.us, align 4, !tbaa !3
  %inc.us.us.us = add nuw nsw i32 %k.036.us.us.us, 1
  %cmp6.us.us.us = icmp slt i32 %inc.us.us.us, %K
  br i1 %cmp6.us.us.us, label %for.body8.us.us.us, label %for.cond.cleanup7.us.us.us, !llvm.loop !39

for.body8.lr.ph.us.us.us:                         ; preds = %for.body4.lr.ph.split.us.us.us, %for.cond.cleanup7.us.us.us
  %j.039.us.us.us = phi i32 [ 0, %for.body4.lr.ph.split.us.us.us ], [ %inc18.us.us.us, %for.cond.cleanup7.us.us.us ]
  %add14.us.us.us = add nsw i32 %j.039.us.us.us, %mul13.us.us
  %arrayidx15.us.us.us = getelementptr inbounds i32, ptr %C, i32 %add14.us.us.us
  %arrayidx15.promoted.us.us.us = load i32, ptr %arrayidx15.us.us.us, align 4, !tbaa !3
  br label %for.body8.us.us.us

for.cond.cleanup:                                 ; preds = %for.cond.cleanup3.us.us, %entry
  ret void
}

; Function Attrs: mustprogress nofree nosync nounwind willreturn
define dso_local void @vectorized_matmul(ptr addrspace(4) noalias nocapture noundef readonly %A, ptr addrspace(4) noalias noundef %B, ptr addrspace(4) noalias noundef %C, i32 noundef %M, i32 noundef %N, i32 noundef %K) local_unnamed_addr #3 {
entry:
  %div = sdiv i32 %N, 16
  %mul = shl nsw i32 %div, 4
  %cmp111 = icmp sgt i32 %M, 0
  br i1 %cmp111, label %for.body.lr.ph, label %for.cond.cleanup35

for.body.lr.ph:                                   ; preds = %entry
  %cmp2109 = icmp sgt i32 %N, 15
  br i1 %cmp2109, label %for.body.lr.ph.split.us, label %for.body36.lr.ph

for.body.lr.ph.split.us:                          ; preds = %for.body.lr.ph
  %cmp8106 = icmp sgt i32 %K, 0
  br i1 %cmp8106, label %for.body4.lr.ph.split.us.us.us.preheader, label %for.body4.lr.ph.split.us121.preheader

for.body4.lr.ph.split.us121.preheader:            ; preds = %for.body.lr.ph.split.us
  br label %for.body4.lr.ph.split.us121

for.body4.lr.ph.split.us.us.us.preheader:         ; preds = %for.body.lr.ph.split.us
  br label %for.body4.lr.ph.split.us.us.us

for.cond.cleanup3.us.us:                          ; preds = %for.cond.cleanup9.us.us.us
  %inc30.us.us = add nuw nsw i32 %i.0112.us.us, 1
  %cmp.us.us = icmp slt i32 %inc30.us.us, %M
  br i1 %cmp.us.us, label %for.body4.lr.ph.split.us.us.us, label %for.cond.cleanup, !llvm.loop !42

for.body4.lr.ph.split.us.us.us:                   ; preds = %for.body4.lr.ph.split.us.us.us.preheader, %for.cond.cleanup3.us.us
  %i.0112.us.us = phi i32 [ %inc30.us.us, %for.cond.cleanup3.us.us ], [ 0, %for.body4.lr.ph.split.us.us.us.preheader ]
  %mul5.us.us = mul nsw i32 %i.0112.us.us, %N
  %mul15.us.us = mul nsw i32 %i.0112.us.us, %K
  br label %for.body10.lr.ph.us.us.us

for.cond.cleanup9.us.us.us:                       ; preds = %for.body10.us.us.us
  %0 = tail call <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32> %3)
  tail call void @llvm.arc.vvst.w.v512(<16 x i32> %0, ptr addrspace(4) %arrayidx.us.us.us)
  %add27.us.us.us = add nuw nsw i32 %j_vec.0110.us.us.us, 16
  %cmp2.us.us.us = icmp slt i32 %add27.us.us.us, %mul
  br i1 %cmp2.us.us.us, label %for.body10.lr.ph.us.us.us, label %for.cond.cleanup3.us.us, !llvm.loop !43

for.body10.us.us.us:                              ; preds = %for.body10.lr.ph.us.us.us, %for.body10.us.us.us
  %k.0108.us.us.us = phi i32 [ 0, %for.body10.lr.ph.us.us.us ], [ %inc.us.us.us, %for.body10.us.us.us ]
  %acc.sroa.0.0107.us.us.us = phi <16 x i32> [ %5, %for.body10.lr.ph.us.us.us ], [ %3, %for.body10.us.us.us ]
  %mul11.us.us.us = mul nsw i32 %k.0108.us.us.us, %N
  %add12.us.us.us = add nsw i32 %mul11.us.us.us, %j_vec.0110.us.us.us
  %arrayidx13.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %B, i32 %add12.us.us.us
  %1 = tail call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %arrayidx13.us.us.us)
  %add16.us.us.us = add nsw i32 %k.0108.us.us.us, %mul15.us.us
  %arrayidx17.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %add16.us.us.us
  %2 = load i32, ptr addrspace(4) %arrayidx17.us.us.us, align 4, !tbaa !3
  %splat.splatinsert.us.us.us = insertelement <16 x i32> poison, i32 %2, i64 0
  %splat.splat.us.us.us = shufflevector <16 x i32> %splat.splatinsert.us.us.us, <16 x i32> poison, <16 x i32> zeroinitializer
  %3 = tail call <16 x i32> @llvm.arc.vvcmac.lo.acc.w.v512(<16 x i32> %acc.sroa.0.0107.us.us.us, <16 x i32> %1, <16 x i32> %splat.splat.us.us.us)
  %inc.us.us.us = add nuw nsw i32 %k.0108.us.us.us, 1
  %cmp8.us.us.us = icmp slt i32 %inc.us.us.us, %K
  br i1 %cmp8.us.us.us, label %for.body10.us.us.us, label %for.cond.cleanup9.us.us.us, !llvm.loop !44

for.body10.lr.ph.us.us.us:                        ; preds = %for.body4.lr.ph.split.us.us.us, %for.cond.cleanup9.us.us.us
  %j_vec.0110.us.us.us = phi i32 [ 0, %for.body4.lr.ph.split.us.us.us ], [ %add27.us.us.us, %for.cond.cleanup9.us.us.us ]
  %add.us.us.us = add nsw i32 %j_vec.0110.us.us.us, %mul5.us.us
  %arrayidx.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %C, i32 %add.us.us.us
  %4 = tail call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %arrayidx.us.us.us)
  %5 = tail call <16 x i32> @llvm.arc.vvcadd.init.acc.w.v512(<16 x i32> %4, <16 x i32> zeroinitializer)
  br label %for.body10.us.us.us

for.cond.cleanup3.us:                             ; preds = %for.cond.cleanup9.us117
  %inc30.us = add nuw nsw i32 %i.0112.us, 1
  %cmp.us = icmp slt i32 %inc30.us, %M
  br i1 %cmp.us, label %for.body4.lr.ph.split.us121, label %for.cond.cleanup, !llvm.loop !42

for.cond.cleanup9.us117:                          ; preds = %for.cond.cleanup9.us117, %for.body4.lr.ph.split.us121
  %j_vec.0110.us114 = phi i32 [ 0, %for.body4.lr.ph.split.us121 ], [ %add27.us118, %for.cond.cleanup9.us117 ]
  %add.us115 = add nsw i32 %j_vec.0110.us114, %mul5.us
  %arrayidx.us116 = getelementptr inbounds i32, ptr addrspace(4) %C, i32 %add.us115
  %6 = tail call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %arrayidx.us116)
  %7 = tail call <16 x i32> @llvm.arc.vvcadd.init.acc.w.v512(<16 x i32> %6, <16 x i32> zeroinitializer)
  %8 = tail call <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32> %7)
  tail call void @llvm.arc.vvst.w.v512(<16 x i32> %8, ptr addrspace(4) %arrayidx.us116)
  %add27.us118 = add nuw nsw i32 %j_vec.0110.us114, 16
  %cmp2.us119 = icmp slt i32 %add27.us118, %mul
  br i1 %cmp2.us119, label %for.cond.cleanup9.us117, label %for.cond.cleanup3.us, !llvm.loop !43

for.body4.lr.ph.split.us121:                      ; preds = %for.body4.lr.ph.split.us121.preheader, %for.cond.cleanup3.us
  %i.0112.us = phi i32 [ %inc30.us, %for.cond.cleanup3.us ], [ 0, %for.body4.lr.ph.split.us121.preheader ]
  %mul5.us = mul nsw i32 %i.0112.us, %N
  br label %for.cond.cleanup9.us117

for.cond.cleanup:                                 ; preds = %for.cond.cleanup3.us, %for.cond.cleanup3.us.us
  %cmp38125 = icmp slt i32 %mul, %N
  br i1 %cmp38125, label %for.body36.lr.ph.split.us, label %for.cond.cleanup35

for.body36.lr.ph:                                 ; preds = %for.body.lr.ph
  %cmp38125.old = icmp slt i32 %mul, %N
  br i1 %cmp38125.old, label %for.body36.lr.ph.split.us, label %for.cond.cleanup35

for.body36.lr.ph.split.us:                        ; preds = %for.cond.cleanup, %for.body36.lr.ph
  %cmp44122 = icmp sgt i32 %K, 0
  br i1 %cmp44122, label %for.body36.lr.ph.split.us.split.us, label %for.body36.lr.ph.split.us.split

for.body36.lr.ph.split.us.split.us:               ; preds = %for.body36.lr.ph.split.us
  %min.iters.check161 = icmp ult i32 %K, 8
  %min.iters.check164 = icmp ult i32 %K, 64
  %n.vec168 = and i32 %K, -64
  %cmp.n169 = icmp eq i32 %n.vec168, %K
  %n.vec.remaining189 = and i32 %K, 56
  %min.epilog.iters.check190 = icmp eq i32 %n.vec.remaining189, 0
  %n.vec193 = and i32 %K, -8
  %cmp.n195 = icmp eq i32 %n.vec193, %K
  br i1 %min.iters.check161, label %for.body40.lr.ph.split.us.us.us.us.preheader, label %for.body36.lr.ph.split.us.split.us.split

for.body40.lr.ph.split.us.us.us.us.preheader:     ; preds = %for.body36.lr.ph.split.us.split.us
  br label %for.body40.lr.ph.split.us.us.us.us

for.body40.lr.ph.split.us.us.us.us:               ; preds = %for.body40.lr.ph.split.us.us.us.us.preheader, %for.cond.cleanup39.us.us.split.us.us
  %i32.0128.us.us.us = phi i32 [ %inc65.us.us.us, %for.cond.cleanup39.us.us.split.us.us ], [ 0, %for.body40.lr.ph.split.us.us.us.us.preheader ]
  %mul50.us.us.us = mul nsw i32 %i32.0128.us.us.us, %K
  %mul58.us.us.us = mul nsw i32 %i32.0128.us.us.us, %N
  br label %iter.check163.us.us

iter.check163.us.us:                              ; preds = %for.cond.cleanup45.us.us.us.us.us, %for.body40.lr.ph.split.us.us.us.us
  %j.0126.us.us.us.us.us = phi i32 [ %mul, %for.body40.lr.ph.split.us.us.us.us ], [ %inc62.us.us.us.us.us, %for.cond.cleanup45.us.us.us.us.us ]
  br label %for.body46.us.us.us.us.us

for.body46.us.us.us.us.us:                        ; preds = %for.body46.us.us.us.us.us, %iter.check163.us.us
  %k42.0124.us.us.us.us.us = phi i32 [ 0, %iter.check163.us.us ], [ %inc56.us.us.us.us.us, %for.body46.us.us.us.us.us ]
  %acc41.0123.us.us.us.us.us = phi i32 [ 0, %iter.check163.us.us ], [ %add54.us.us.us.us.us, %for.body46.us.us.us.us.us ]
  %mul47.us.us.us.us.us = mul nsw i32 %k42.0124.us.us.us.us.us, %N
  %add48.us.us.us.us.us = add nsw i32 %mul47.us.us.us.us.us, %j.0126.us.us.us.us.us
  %arrayidx49.us.us.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %B, i32 %add48.us.us.us.us.us
  %9 = load i32, ptr addrspace(4) %arrayidx49.us.us.us.us.us, align 4, !tbaa !3
  %add51.us.us.us.us.us = add nsw i32 %k42.0124.us.us.us.us.us, %mul50.us.us.us
  %arrayidx52.us.us.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %add51.us.us.us.us.us
  %10 = load i32, ptr addrspace(4) %arrayidx52.us.us.us.us.us, align 4, !tbaa !3
  %mul53.us.us.us.us.us = mul nsw i32 %10, %9
  %add54.us.us.us.us.us = add nsw i32 %mul53.us.us.us.us.us, %acc41.0123.us.us.us.us.us
  %inc56.us.us.us.us.us = add nuw nsw i32 %k42.0124.us.us.us.us.us, 1
  %cmp44.us.us.us.us.us = icmp slt i32 %inc56.us.us.us.us.us, %K
  br i1 %cmp44.us.us.us.us.us, label %for.body46.us.us.us.us.us, label %for.cond.cleanup45.us.us.us.us.us, !llvm.loop !45

for.cond.cleanup45.us.us.us.us.us:                ; preds = %for.body46.us.us.us.us.us
  %add59.us.us.us.us.us = add nsw i32 %j.0126.us.us.us.us.us, %mul58.us.us.us
  %arrayidx60.us.us.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %C, i32 %add59.us.us.us.us.us
  store i32 %add54.us.us.us.us.us, ptr addrspace(4) %arrayidx60.us.us.us.us.us, align 4, !tbaa !3
  %inc62.us.us.us.us.us = add nsw i32 %j.0126.us.us.us.us.us, 1
  %cmp38.us.us.us.us.us = icmp slt i32 %inc62.us.us.us.us.us, %N
  br i1 %cmp38.us.us.us.us.us, label %iter.check163.us.us, label %for.cond.cleanup39.us.us.split.us.us, !llvm.loop !46

for.cond.cleanup39.us.us.split.us.us:             ; preds = %for.cond.cleanup45.us.us.us.us.us
  %inc65.us.us.us = add nuw nsw i32 %i32.0128.us.us.us, 1
  %cmp34.us.us.us = icmp slt i32 %inc65.us.us.us, %M
  br i1 %cmp34.us.us.us, label %for.body40.lr.ph.split.us.us.us.us, label %for.cond.cleanup35, !llvm.loop !47

for.body36.lr.ph.split.us.split.us.split:         ; preds = %for.body36.lr.ph.split.us.split.us
  %ident.check.not = icmp eq i32 %N, 1
  br i1 %ident.check.not, label %for.body36.lr.ph.split.us.split.us.split.split.us, label %for.body40.lr.ph.split.us.us.us.preheader

for.body40.lr.ph.split.us.us.us.preheader:        ; preds = %for.body36.lr.ph.split.us.split.us.split
  br label %for.body40.lr.ph.split.us.us.us

for.body36.lr.ph.split.us.split.us.split.split.us: ; preds = %for.body36.lr.ph.split.us.split.us.split
  br i1 %min.iters.check164, label %for.body40.lr.ph.split.us.us.us.us254.us.preheader, label %for.body40.lr.ph.split.us.us.us.us254.preheader

for.body40.lr.ph.split.us.us.us.us254.preheader:  ; preds = %for.body36.lr.ph.split.us.split.us.split.split.us
  br label %for.body40.lr.ph.split.us.us.us.us254

for.body40.lr.ph.split.us.us.us.us254.us.preheader: ; preds = %for.body36.lr.ph.split.us.split.us.split.split.us
  br label %for.body40.lr.ph.split.us.us.us.us254.us

for.body40.lr.ph.split.us.us.us.us254.us:         ; preds = %for.body40.lr.ph.split.us.us.us.us254.us.preheader, %for.cond.cleanup39.us.us.split.split.us.us.split.us.us
  %i32.0128.us.us.us255.us = phi i32 [ %inc65.us.us.us259.us, %for.cond.cleanup39.us.us.split.split.us.us.split.us.us ], [ 0, %for.body40.lr.ph.split.us.us.us.us254.us.preheader ]
  %mul50.us.us.us256.us = mul nsw i32 %i32.0128.us.us.us255.us, %K
  br i1 %cmp.n195, label %iter.check163.us229.us.us.us.us.preheader, label %iter.check163.us229.us.us.us.preheader

iter.check163.us229.us.us.us.preheader:           ; preds = %for.body40.lr.ph.split.us.us.us.us254.us
  br label %iter.check163.us229.us.us.us

iter.check163.us229.us.us.us.us.preheader:        ; preds = %for.body40.lr.ph.split.us.us.us.us254.us
  br label %iter.check163.us229.us.us.us.us

iter.check163.us229.us.us.us.us:                  ; preds = %iter.check163.us229.us.us.us.us.preheader, %vec.epilog.middle.block185.us.us.us.us.us
  %j.0126.us.us.us.us230.us.us.us.us = phi i32 [ %inc62.us.us.us.us252.us.us.us.us, %vec.epilog.middle.block185.us.us.us.us.us ], [ %mul, %iter.check163.us229.us.us.us.us.preheader ]
  br label %vec.epilog.vector.body196.us.us.us.us.us

vec.epilog.vector.body196.us.us.us.us.us:         ; preds = %vec.epilog.vector.body196.us.us.us.us.us, %iter.check163.us229.us.us.us.us
  %index197.us.us.us.us.us = phi i32 [ 0, %iter.check163.us229.us.us.us.us ], [ %index.next201.us.us.us.us.us, %vec.epilog.vector.body196.us.us.us.us.us ]
  %vec.phi198.us.us.us.us.us = phi <8 x i32> [ zeroinitializer, %iter.check163.us229.us.us.us.us ], [ %16, %vec.epilog.vector.body196.us.us.us.us.us ]
  %11 = add nsw i32 %index197.us.us.us.us.us, %j.0126.us.us.us.us230.us.us.us.us
  %12 = getelementptr inbounds i32, ptr addrspace(4) %B, i32 %11
  %wide.load199.us.us.us.us.us = load <8 x i32>, ptr addrspace(4) %12, align 4, !tbaa !3
  %13 = add nsw i32 %index197.us.us.us.us.us, %mul50.us.us.us256.us
  %14 = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %13
  %wide.load200.us.us.us.us.us = load <8 x i32>, ptr addrspace(4) %14, align 4, !tbaa !3
  %15 = mul nsw <8 x i32> %wide.load200.us.us.us.us.us, %wide.load199.us.us.us.us.us
  %16 = add <8 x i32> %15, %vec.phi198.us.us.us.us.us
  %index.next201.us.us.us.us.us = add nuw i32 %index197.us.us.us.us.us, 8
  %17 = icmp eq i32 %index.next201.us.us.us.us.us, %K
  br i1 %17, label %vec.epilog.middle.block185.us.us.us.us.us, label %vec.epilog.vector.body196.us.us.us.us.us, !llvm.loop !48

vec.epilog.middle.block185.us.us.us.us.us:        ; preds = %vec.epilog.vector.body196.us.us.us.us.us
  %18 = tail call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %16)
  %add59.us.us.us.us250.us.us.us.us = add nsw i32 %j.0126.us.us.us.us230.us.us.us.us, %i32.0128.us.us.us255.us
  %arrayidx60.us.us.us.us251.us.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %C, i32 %add59.us.us.us.us250.us.us.us.us
  store i32 %18, ptr addrspace(4) %arrayidx60.us.us.us.us251.us.us.us.us, align 4, !tbaa !3
  %inc62.us.us.us.us252.us.us.us.us = add nsw i32 %j.0126.us.us.us.us230.us.us.us.us, 1
  %cmp38.us.us.us.us253.us.us.us.us = icmp slt i32 %j.0126.us.us.us.us230.us.us.us.us, 0
  br i1 %cmp38.us.us.us.us253.us.us.us.us, label %iter.check163.us229.us.us.us.us, label %for.cond.cleanup39.us.us.split.split.us.us.split.us.us, !llvm.loop !46

iter.check163.us229.us.us.us:                     ; preds = %iter.check163.us229.us.us.us.preheader, %for.cond.cleanup45.us.us.us.us248.us.us.us
  %j.0126.us.us.us.us230.us.us.us = phi i32 [ %inc62.us.us.us.us252.us.us.us, %for.cond.cleanup45.us.us.us.us248.us.us.us ], [ %mul, %iter.check163.us229.us.us.us.preheader ]
  br label %vec.epilog.vector.body196.us.us.us.us

vec.epilog.vector.body196.us.us.us.us:            ; preds = %vec.epilog.vector.body196.us.us.us.us, %iter.check163.us229.us.us.us
  %index197.us.us.us.us = phi i32 [ 0, %iter.check163.us229.us.us.us ], [ %index.next201.us.us.us.us, %vec.epilog.vector.body196.us.us.us.us ]
  %vec.phi198.us.us.us.us = phi <8 x i32> [ zeroinitializer, %iter.check163.us229.us.us.us ], [ %24, %vec.epilog.vector.body196.us.us.us.us ]
  %19 = add nsw i32 %index197.us.us.us.us, %j.0126.us.us.us.us230.us.us.us
  %20 = getelementptr inbounds i32, ptr addrspace(4) %B, i32 %19
  %wide.load199.us.us.us.us = load <8 x i32>, ptr addrspace(4) %20, align 4, !tbaa !3
  %21 = add nsw i32 %index197.us.us.us.us, %mul50.us.us.us256.us
  %22 = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %21
  %wide.load200.us.us.us.us = load <8 x i32>, ptr addrspace(4) %22, align 4, !tbaa !3
  %23 = mul nsw <8 x i32> %wide.load200.us.us.us.us, %wide.load199.us.us.us.us
  %24 = add <8 x i32> %23, %vec.phi198.us.us.us.us
  %index.next201.us.us.us.us = add nuw i32 %index197.us.us.us.us, 8
  %25 = icmp eq i32 %index.next201.us.us.us.us, %n.vec193
  br i1 %25, label %vec.epilog.middle.block185.us.us.us.us, label %vec.epilog.vector.body196.us.us.us.us, !llvm.loop !48

vec.epilog.middle.block185.us.us.us.us:           ; preds = %vec.epilog.vector.body196.us.us.us.us
  %26 = tail call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %24)
  br label %for.body46.us.us.us.us234.us.us.us

for.body46.us.us.us.us234.us.us.us:               ; preds = %for.body46.us.us.us.us234.us.us.us, %vec.epilog.middle.block185.us.us.us.us
  %k42.0124.us.us.us.us235.us.us.us = phi i32 [ %n.vec193, %vec.epilog.middle.block185.us.us.us.us ], [ %inc56.us.us.us.us244.us.us.us, %for.body46.us.us.us.us234.us.us.us ]
  %acc41.0123.us.us.us.us236.us.us.us = phi i32 [ %26, %vec.epilog.middle.block185.us.us.us.us ], [ %add54.us.us.us.us243.us.us.us, %for.body46.us.us.us.us234.us.us.us ]
  %add48.us.us.us.us238.us.us.us = add nsw i32 %k42.0124.us.us.us.us235.us.us.us, %j.0126.us.us.us.us230.us.us.us
  %arrayidx49.us.us.us.us239.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %B, i32 %add48.us.us.us.us238.us.us.us
  %27 = load i32, ptr addrspace(4) %arrayidx49.us.us.us.us239.us.us.us, align 4, !tbaa !3
  %add51.us.us.us.us240.us.us.us = add nsw i32 %k42.0124.us.us.us.us235.us.us.us, %mul50.us.us.us256.us
  %arrayidx52.us.us.us.us241.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %add51.us.us.us.us240.us.us.us
  %28 = load i32, ptr addrspace(4) %arrayidx52.us.us.us.us241.us.us.us, align 4, !tbaa !3
  %mul53.us.us.us.us242.us.us.us = mul nsw i32 %28, %27
  %add54.us.us.us.us243.us.us.us = add nsw i32 %mul53.us.us.us.us242.us.us.us, %acc41.0123.us.us.us.us236.us.us.us
  %inc56.us.us.us.us244.us.us.us = add nuw nsw i32 %k42.0124.us.us.us.us235.us.us.us, 1
  %cmp44.us.us.us.us245.us.us.us = icmp slt i32 %inc56.us.us.us.us244.us.us.us, %K
  br i1 %cmp44.us.us.us.us245.us.us.us, label %for.body46.us.us.us.us234.us.us.us, label %for.cond.cleanup45.us.us.us.us248.us.us.us, !llvm.loop !45

for.cond.cleanup45.us.us.us.us248.us.us.us:       ; preds = %for.body46.us.us.us.us234.us.us.us
  %add59.us.us.us.us250.us.us.us = add nsw i32 %j.0126.us.us.us.us230.us.us.us, %i32.0128.us.us.us255.us
  %arrayidx60.us.us.us.us251.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %C, i32 %add59.us.us.us.us250.us.us.us
  store i32 %add54.us.us.us.us243.us.us.us, ptr addrspace(4) %arrayidx60.us.us.us.us251.us.us.us, align 4, !tbaa !3
  %inc62.us.us.us.us252.us.us.us = add nsw i32 %j.0126.us.us.us.us230.us.us.us, 1
  %cmp38.us.us.us.us253.us.us.us = icmp slt i32 %j.0126.us.us.us.us230.us.us.us, 0
  br i1 %cmp38.us.us.us.us253.us.us.us, label %iter.check163.us229.us.us.us, label %for.cond.cleanup39.us.us.split.split.us.us.split.us.us, !llvm.loop !46

for.cond.cleanup39.us.us.split.split.us.us.split.us.us: ; preds = %for.cond.cleanup45.us.us.us.us248.us.us.us, %vec.epilog.middle.block185.us.us.us.us.us
  %inc65.us.us.us259.us = add nuw nsw i32 %i32.0128.us.us.us255.us, 1
  %cmp34.us.us.us260.us = icmp slt i32 %inc65.us.us.us259.us, %M
  br i1 %cmp34.us.us.us260.us, label %for.body40.lr.ph.split.us.us.us.us254.us, label %for.cond.cleanup35, !llvm.loop !47

for.body40.lr.ph.split.us.us.us.us254:            ; preds = %for.body40.lr.ph.split.us.us.us.us254.preheader, %for.cond.cleanup39.us.us.split.split.us.us
  %i32.0128.us.us.us255 = phi i32 [ %inc65.us.us.us259, %for.cond.cleanup39.us.us.split.split.us.us ], [ 0, %for.body40.lr.ph.split.us.us.us.us254.preheader ]
  %mul50.us.us.us256 = mul nsw i32 %i32.0128.us.us.us255, %K
  br label %iter.check163.us229.us

iter.check163.us229.us:                           ; preds = %for.cond.cleanup45.us.us.us.us248.us, %for.body40.lr.ph.split.us.us.us.us254
  %j.0126.us.us.us.us230.us = phi i32 [ %mul, %for.body40.lr.ph.split.us.us.us.us254 ], [ %inc62.us.us.us.us252.us, %for.cond.cleanup45.us.us.us.us248.us ]
  br label %vector.body170.us.us

vector.body170.us.us:                             ; preds = %vector.body170.us.us, %iter.check163.us229.us
  %index171.us.us = phi i32 [ 0, %iter.check163.us229.us ], [ %index.next182.us.us, %vector.body170.us.us ]
  %vec.phi.us.us = phi <16 x i32> [ zeroinitializer, %iter.check163.us229.us ], [ %43, %vector.body170.us.us ]
  %vec.phi172.us.us = phi <16 x i32> [ zeroinitializer, %iter.check163.us229.us ], [ %44, %vector.body170.us.us ]
  %vec.phi173.us.us = phi <16 x i32> [ zeroinitializer, %iter.check163.us229.us ], [ %45, %vector.body170.us.us ]
  %vec.phi174.us.us = phi <16 x i32> [ zeroinitializer, %iter.check163.us229.us ], [ %46, %vector.body170.us.us ]
  %29 = add nsw i32 %index171.us.us, %j.0126.us.us.us.us230.us
  %30 = getelementptr inbounds i32, ptr addrspace(4) %B, i32 %29
  %wide.load.us.us = load <16 x i32>, ptr addrspace(4) %30, align 4, !tbaa !3
  %31 = getelementptr inbounds i32, ptr addrspace(4) %30, i32 16
  %wide.load175.us.us = load <16 x i32>, ptr addrspace(4) %31, align 4, !tbaa !3
  %32 = getelementptr inbounds i32, ptr addrspace(4) %30, i32 32
  %wide.load176.us.us = load <16 x i32>, ptr addrspace(4) %32, align 4, !tbaa !3
  %33 = getelementptr inbounds i32, ptr addrspace(4) %30, i32 48
  %wide.load177.us.us = load <16 x i32>, ptr addrspace(4) %33, align 4, !tbaa !3
  %34 = add nsw i32 %index171.us.us, %mul50.us.us.us256
  %35 = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %34
  %wide.load178.us.us = load <16 x i32>, ptr addrspace(4) %35, align 4, !tbaa !3
  %36 = getelementptr inbounds i32, ptr addrspace(4) %35, i32 16
  %wide.load179.us.us = load <16 x i32>, ptr addrspace(4) %36, align 4, !tbaa !3
  %37 = getelementptr inbounds i32, ptr addrspace(4) %35, i32 32
  %wide.load180.us.us = load <16 x i32>, ptr addrspace(4) %37, align 4, !tbaa !3
  %38 = getelementptr inbounds i32, ptr addrspace(4) %35, i32 48
  %wide.load181.us.us = load <16 x i32>, ptr addrspace(4) %38, align 4, !tbaa !3
  %39 = mul nsw <16 x i32> %wide.load178.us.us, %wide.load.us.us
  %40 = mul nsw <16 x i32> %wide.load179.us.us, %wide.load175.us.us
  %41 = mul nsw <16 x i32> %wide.load180.us.us, %wide.load176.us.us
  %42 = mul nsw <16 x i32> %wide.load181.us.us, %wide.load177.us.us
  %43 = add <16 x i32> %39, %vec.phi.us.us
  %44 = add <16 x i32> %40, %vec.phi172.us.us
  %45 = add <16 x i32> %41, %vec.phi173.us.us
  %46 = add <16 x i32> %42, %vec.phi174.us.us
  %index.next182.us.us = add nuw i32 %index171.us.us, 64
  %47 = icmp eq i32 %index.next182.us.us, %n.vec168
  br i1 %47, label %middle.block160.us.us, label %vector.body170.us.us, !llvm.loop !49

middle.block160.us.us:                            ; preds = %vector.body170.us.us
  %bin.rdx.us.us = add <16 x i32> %44, %43
  %bin.rdx183.us.us = add <16 x i32> %45, %bin.rdx.us.us
  %bin.rdx184.us.us = add <16 x i32> %46, %bin.rdx183.us.us
  %48 = tail call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %bin.rdx184.us.us)
  br i1 %cmp.n169, label %for.cond.cleanup45.us.us.us.us248.us, label %vec.epilog.iter.check187.us.us

vec.epilog.iter.check187.us.us:                   ; preds = %middle.block160.us.us
  br i1 %min.epilog.iters.check190, label %for.body46.us.us.us.us234.us.preheader, label %vec.epilog.ph188.us.us

vec.epilog.ph188.us.us:                           ; preds = %vec.epilog.iter.check187.us.us
  %49 = insertelement <8 x i32> <i32 poison, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, i32 %48, i64 0
  br label %vec.epilog.vector.body196.us.us

vec.epilog.vector.body196.us.us:                  ; preds = %vec.epilog.vector.body196.us.us, %vec.epilog.ph188.us.us
  %index197.us.us = phi i32 [ %n.vec168, %vec.epilog.ph188.us.us ], [ %index.next201.us.us, %vec.epilog.vector.body196.us.us ]
  %vec.phi198.us.us = phi <8 x i32> [ %49, %vec.epilog.ph188.us.us ], [ %55, %vec.epilog.vector.body196.us.us ]
  %50 = add nsw i32 %index197.us.us, %j.0126.us.us.us.us230.us
  %51 = getelementptr inbounds i32, ptr addrspace(4) %B, i32 %50
  %wide.load199.us.us = load <8 x i32>, ptr addrspace(4) %51, align 4, !tbaa !3
  %52 = add nsw i32 %index197.us.us, %mul50.us.us.us256
  %53 = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %52
  %wide.load200.us.us = load <8 x i32>, ptr addrspace(4) %53, align 4, !tbaa !3
  %54 = mul nsw <8 x i32> %wide.load200.us.us, %wide.load199.us.us
  %55 = add <8 x i32> %54, %vec.phi198.us.us
  %index.next201.us.us = add nuw i32 %index197.us.us, 8
  %56 = icmp eq i32 %index.next201.us.us, %n.vec193
  br i1 %56, label %vec.epilog.middle.block185.us.us, label %vec.epilog.vector.body196.us.us, !llvm.loop !48

vec.epilog.middle.block185.us.us:                 ; preds = %vec.epilog.vector.body196.us.us
  %57 = tail call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %55)
  br i1 %cmp.n195, label %for.cond.cleanup45.us.us.us.us248.us, label %for.body46.us.us.us.us234.us.preheader

for.body46.us.us.us.us234.us.preheader:           ; preds = %vec.epilog.middle.block185.us.us, %vec.epilog.iter.check187.us.us
  %k42.0124.us.us.us.us235.us.ph = phi i32 [ %n.vec168, %vec.epilog.iter.check187.us.us ], [ %n.vec193, %vec.epilog.middle.block185.us.us ]
  %acc41.0123.us.us.us.us236.us.ph = phi i32 [ %48, %vec.epilog.iter.check187.us.us ], [ %57, %vec.epilog.middle.block185.us.us ]
  br label %for.body46.us.us.us.us234.us

for.body46.us.us.us.us234.us:                     ; preds = %for.body46.us.us.us.us234.us.preheader, %for.body46.us.us.us.us234.us
  %k42.0124.us.us.us.us235.us = phi i32 [ %inc56.us.us.us.us244.us, %for.body46.us.us.us.us234.us ], [ %k42.0124.us.us.us.us235.us.ph, %for.body46.us.us.us.us234.us.preheader ]
  %acc41.0123.us.us.us.us236.us = phi i32 [ %add54.us.us.us.us243.us, %for.body46.us.us.us.us234.us ], [ %acc41.0123.us.us.us.us236.us.ph, %for.body46.us.us.us.us234.us.preheader ]
  %add48.us.us.us.us238.us = add nsw i32 %k42.0124.us.us.us.us235.us, %j.0126.us.us.us.us230.us
  %arrayidx49.us.us.us.us239.us = getelementptr inbounds i32, ptr addrspace(4) %B, i32 %add48.us.us.us.us238.us
  %58 = load i32, ptr addrspace(4) %arrayidx49.us.us.us.us239.us, align 4, !tbaa !3
  %add51.us.us.us.us240.us = add nsw i32 %k42.0124.us.us.us.us235.us, %mul50.us.us.us256
  %arrayidx52.us.us.us.us241.us = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %add51.us.us.us.us240.us
  %59 = load i32, ptr addrspace(4) %arrayidx52.us.us.us.us241.us, align 4, !tbaa !3
  %mul53.us.us.us.us242.us = mul nsw i32 %59, %58
  %add54.us.us.us.us243.us = add nsw i32 %mul53.us.us.us.us242.us, %acc41.0123.us.us.us.us236.us
  %inc56.us.us.us.us244.us = add nuw nsw i32 %k42.0124.us.us.us.us235.us, 1
  %cmp44.us.us.us.us245.us = icmp slt i32 %inc56.us.us.us.us244.us, %K
  br i1 %cmp44.us.us.us.us245.us, label %for.body46.us.us.us.us234.us, label %for.cond.cleanup45.us.us.us.us248.us, !llvm.loop !45

for.cond.cleanup45.us.us.us.us248.us:             ; preds = %for.body46.us.us.us.us234.us, %vec.epilog.middle.block185.us.us, %middle.block160.us.us
  %add54.us.us.us.lcssa.us249.us = phi i32 [ %48, %middle.block160.us.us ], [ %57, %vec.epilog.middle.block185.us.us ], [ %add54.us.us.us.us243.us, %for.body46.us.us.us.us234.us ]
  %add59.us.us.us.us250.us = add nsw i32 %j.0126.us.us.us.us230.us, %i32.0128.us.us.us255
  %arrayidx60.us.us.us.us251.us = getelementptr inbounds i32, ptr addrspace(4) %C, i32 %add59.us.us.us.us250.us
  store i32 %add54.us.us.us.lcssa.us249.us, ptr addrspace(4) %arrayidx60.us.us.us.us251.us, align 4, !tbaa !3
  %inc62.us.us.us.us252.us = add nsw i32 %j.0126.us.us.us.us230.us, 1
  %cmp38.us.us.us.us253.us = icmp slt i32 %j.0126.us.us.us.us230.us, 0
  br i1 %cmp38.us.us.us.us253.us, label %iter.check163.us229.us, label %for.cond.cleanup39.us.us.split.split.us.us, !llvm.loop !46

for.cond.cleanup39.us.us.split.split.us.us:       ; preds = %for.cond.cleanup45.us.us.us.us248.us
  %inc65.us.us.us259 = add nuw nsw i32 %i32.0128.us.us.us255, 1
  %cmp34.us.us.us260 = icmp slt i32 %inc65.us.us.us259, %M
  br i1 %cmp34.us.us.us260, label %for.body40.lr.ph.split.us.us.us.us254, label %for.cond.cleanup35, !llvm.loop !47

for.cond.cleanup39.us.us:                         ; preds = %for.cond.cleanup45.us.us.us
  %inc65.us.us = add nuw nsw i32 %i32.0128.us.us, 1
  %cmp34.us.us = icmp slt i32 %inc65.us.us, %M
  br i1 %cmp34.us.us, label %for.body40.lr.ph.split.us.us.us, label %for.cond.cleanup35, !llvm.loop !47

for.body40.lr.ph.split.us.us.us:                  ; preds = %for.body40.lr.ph.split.us.us.us.preheader, %for.cond.cleanup39.us.us
  %i32.0128.us.us = phi i32 [ %inc65.us.us, %for.cond.cleanup39.us.us ], [ 0, %for.body40.lr.ph.split.us.us.us.preheader ]
  %mul50.us.us = mul nsw i32 %i32.0128.us.us, %K
  %mul58.us.us = mul nsw i32 %i32.0128.us.us, %N
  br label %iter.check163

for.cond.cleanup45.us.us.us:                      ; preds = %for.body46.us.us.us
  %add59.us.us.us = add nsw i32 %j.0126.us.us.us, %mul58.us.us
  %arrayidx60.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %C, i32 %add59.us.us.us
  store i32 %add54.us.us.us, ptr addrspace(4) %arrayidx60.us.us.us, align 4, !tbaa !3
  %inc62.us.us.us = add nsw i32 %j.0126.us.us.us, 1
  %cmp38.us.us.us = icmp slt i32 %inc62.us.us.us, %N
  br i1 %cmp38.us.us.us, label %iter.check163, label %for.cond.cleanup39.us.us, !llvm.loop !46

for.body46.us.us.us:                              ; preds = %iter.check163, %for.body46.us.us.us
  %k42.0124.us.us.us = phi i32 [ 0, %iter.check163 ], [ %inc56.us.us.us, %for.body46.us.us.us ]
  %acc41.0123.us.us.us = phi i32 [ 0, %iter.check163 ], [ %add54.us.us.us, %for.body46.us.us.us ]
  %mul47.us.us.us = mul nsw i32 %k42.0124.us.us.us, %N
  %add48.us.us.us = add nsw i32 %mul47.us.us.us, %j.0126.us.us.us
  %arrayidx49.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %B, i32 %add48.us.us.us
  %60 = load i32, ptr addrspace(4) %arrayidx49.us.us.us, align 4, !tbaa !3
  %add51.us.us.us = add nsw i32 %k42.0124.us.us.us, %mul50.us.us
  %arrayidx52.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %add51.us.us.us
  %61 = load i32, ptr addrspace(4) %arrayidx52.us.us.us, align 4, !tbaa !3
  %mul53.us.us.us = mul nsw i32 %61, %60
  %add54.us.us.us = add nsw i32 %mul53.us.us.us, %acc41.0123.us.us.us
  %inc56.us.us.us = add nuw nsw i32 %k42.0124.us.us.us, 1
  %cmp44.us.us.us = icmp slt i32 %inc56.us.us.us, %K
  br i1 %cmp44.us.us.us, label %for.body46.us.us.us, label %for.cond.cleanup45.us.us.us, !llvm.loop !45

iter.check163:                                    ; preds = %for.body40.lr.ph.split.us.us.us, %for.cond.cleanup45.us.us.us
  %j.0126.us.us.us = phi i32 [ %mul, %for.body40.lr.ph.split.us.us.us ], [ %inc62.us.us.us, %for.cond.cleanup45.us.us.us ]
  br label %for.body46.us.us.us

for.body36.lr.ph.split.us.split:                  ; preds = %for.body36.lr.ph.split.us
  %62 = add nuw nsw i32 %mul, 1
  %smax = tail call i32 @llvm.smax.i32(i32 %N, i32 %62)
  %63 = sub i32 %smax, %mul
  %min.iters.check = icmp ult i32 %63, 8
  %n.vec = and i32 %63, -64
  %cmp.n = icmp eq i32 %63, %n.vec
  %ind.end155 = add i32 %mul, %n.vec
  %n.vec.remaining = and i32 %63, 56
  %min.epilog.iters.check = icmp eq i32 %n.vec.remaining, 0
  %n.mod.vf153 = and i32 %smax, 7
  %n.vec154 = sub nuw i32 %63, %n.mod.vf153
  %ind.end = add i32 %mul, %n.vec154
  %cmp.n156 = icmp eq i32 %n.mod.vf153, 0
  br i1 %min.iters.check, label %iter.check.us.preheader, label %for.body36.lr.ph.split.us.split.split

iter.check.us.preheader:                          ; preds = %for.body36.lr.ph.split.us.split
  br label %iter.check.us

iter.check.us:                                    ; preds = %iter.check.us.preheader, %for.cond.cleanup39.us.us211
  %i32.0128.us.us209 = phi i32 [ %inc65.us.us212, %for.cond.cleanup39.us.us211 ], [ 0, %iter.check.us.preheader ]
  %mul58.us.us210 = mul nsw i32 %i32.0128.us.us209, %N
  br label %for.cond.cleanup45.us131.us

for.cond.cleanup45.us131.us:                      ; preds = %for.cond.cleanup45.us131.us, %iter.check.us
  %j.0126.us130.us = phi i32 [ %mul, %iter.check.us ], [ %inc62.us134.us, %for.cond.cleanup45.us131.us ]
  %add59.us132.us = add nsw i32 %j.0126.us130.us, %mul58.us.us210
  %arrayidx60.us133.us = getelementptr inbounds i32, ptr addrspace(4) %C, i32 %add59.us132.us
  store i32 0, ptr addrspace(4) %arrayidx60.us133.us, align 4, !tbaa !3
  %inc62.us134.us = add nsw i32 %j.0126.us130.us, 1
  %cmp38.us135.us = icmp slt i32 %inc62.us134.us, %N
  br i1 %cmp38.us135.us, label %for.cond.cleanup45.us131.us, label %for.cond.cleanup39.us.us211, !llvm.loop !50

for.cond.cleanup39.us.us211:                      ; preds = %for.cond.cleanup45.us131.us
  %inc65.us.us212 = add nuw nsw i32 %i32.0128.us.us209, 1
  %cmp34.us.us213 = icmp slt i32 %inc65.us.us212, %M
  br i1 %cmp34.us.us213, label %iter.check.us, label %for.cond.cleanup35, !llvm.loop !47

for.body36.lr.ph.split.us.split.split:            ; preds = %for.body36.lr.ph.split.us.split
  %min.iters.check152 = icmp ult i32 %63, 64
  br i1 %min.iters.check152, label %for.body36.lr.ph.split.us.split.split.split.us, label %iter.check.preheader

iter.check.preheader:                             ; preds = %for.body36.lr.ph.split.us.split.split
  br label %iter.check

for.body36.lr.ph.split.us.split.split.split.us:   ; preds = %for.body36.lr.ph.split.us.split.split
  br i1 %cmp.n156, label %iter.check.us214.us.preheader, label %iter.check.us214.preheader

iter.check.us214.preheader:                       ; preds = %for.body36.lr.ph.split.us.split.split.split.us
  br label %iter.check.us214

iter.check.us214.us.preheader:                    ; preds = %for.body36.lr.ph.split.us.split.split.split.us
  br label %iter.check.us214.us

iter.check.us214.us:                              ; preds = %iter.check.us214.us.preheader, %for.cond.cleanup39.us.us226.us
  %i32.0128.us.us215.us = phi i32 [ %inc65.us.us227.us, %for.cond.cleanup39.us.us226.us ], [ 0, %iter.check.us214.us.preheader ]
  %mul58.us.us216.us = mul nsw i32 %i32.0128.us.us215.us, %N
  br label %vec.epilog.vector.body.us.us

vec.epilog.vector.body.us.us:                     ; preds = %vec.epilog.vector.body.us.us, %iter.check.us214.us
  %index157.us.us = phi i32 [ 0, %iter.check.us214.us ], [ %index.next159.us.us, %vec.epilog.vector.body.us.us ]
  %offset.idx158.us.us = add i32 %mul, %index157.us.us
  %64 = add nsw i32 %offset.idx158.us.us, %mul58.us.us216.us
  %65 = getelementptr inbounds i32, ptr addrspace(4) %C, i32 %64
  store <8 x i32> zeroinitializer, ptr addrspace(4) %65, align 4, !tbaa !3
  %index.next159.us.us = add nuw i32 %index157.us.us, 8
  %66 = icmp eq i32 %index.next159.us.us, %n.vec154
  br i1 %66, label %for.cond.cleanup39.us.us226.us, label %vec.epilog.vector.body.us.us, !llvm.loop !51

for.cond.cleanup39.us.us226.us:                   ; preds = %vec.epilog.vector.body.us.us
  %inc65.us.us227.us = add nuw nsw i32 %i32.0128.us.us215.us, 1
  %cmp34.us.us228.us = icmp slt i32 %inc65.us.us227.us, %M
  br i1 %cmp34.us.us228.us, label %iter.check.us214.us, label %for.cond.cleanup35, !llvm.loop !47

iter.check.us214:                                 ; preds = %iter.check.us214.preheader, %for.cond.cleanup39.us.us226
  %i32.0128.us.us215 = phi i32 [ %inc65.us.us227, %for.cond.cleanup39.us.us226 ], [ 0, %iter.check.us214.preheader ]
  %mul58.us.us216 = mul nsw i32 %i32.0128.us.us215, %N
  br label %vec.epilog.vector.body.us

vec.epilog.vector.body.us:                        ; preds = %vec.epilog.vector.body.us, %iter.check.us214
  %index157.us = phi i32 [ 0, %iter.check.us214 ], [ %index.next159.us, %vec.epilog.vector.body.us ]
  %offset.idx158.us = add i32 %mul, %index157.us
  %67 = add nsw i32 %offset.idx158.us, %mul58.us.us216
  %68 = getelementptr inbounds i32, ptr addrspace(4) %C, i32 %67
  store <8 x i32> zeroinitializer, ptr addrspace(4) %68, align 4, !tbaa !3
  %index.next159.us = add nuw i32 %index157.us, 8
  %69 = icmp eq i32 %index.next159.us, %n.vec154
  br i1 %69, label %for.cond.cleanup45.us131.us219.preheader, label %vec.epilog.vector.body.us, !llvm.loop !51

for.cond.cleanup45.us131.us219.preheader:         ; preds = %vec.epilog.vector.body.us
  br label %for.cond.cleanup45.us131.us219

for.cond.cleanup45.us131.us219:                   ; preds = %for.cond.cleanup45.us131.us219.preheader, %for.cond.cleanup45.us131.us219
  %j.0126.us130.us220 = phi i32 [ %inc62.us134.us223, %for.cond.cleanup45.us131.us219 ], [ %ind.end, %for.cond.cleanup45.us131.us219.preheader ]
  %add59.us132.us221 = add nsw i32 %j.0126.us130.us220, %mul58.us.us216
  %arrayidx60.us133.us222 = getelementptr inbounds i32, ptr addrspace(4) %C, i32 %add59.us132.us221
  store i32 0, ptr addrspace(4) %arrayidx60.us133.us222, align 4, !tbaa !3
  %inc62.us134.us223 = add nsw i32 %j.0126.us130.us220, 1
  %cmp38.us135.us224 = icmp slt i32 %inc62.us134.us223, %N
  br i1 %cmp38.us135.us224, label %for.cond.cleanup45.us131.us219, label %for.cond.cleanup39.us.us226, !llvm.loop !50

for.cond.cleanup39.us.us226:                      ; preds = %for.cond.cleanup45.us131.us219
  %inc65.us.us227 = add nuw nsw i32 %i32.0128.us.us215, 1
  %cmp34.us.us228 = icmp slt i32 %inc65.us.us227, %M
  br i1 %cmp34.us.us228, label %iter.check.us214, label %for.cond.cleanup35, !llvm.loop !47

for.cond.cleanup39.us:                            ; preds = %for.cond.cleanup45.us131, %vec.epilog.middle.block, %middle.block
  %inc65.us = add nuw nsw i32 %i32.0128.us, 1
  %cmp34.us = icmp slt i32 %inc65.us, %M
  br i1 %cmp34.us, label %iter.check, label %for.cond.cleanup35, !llvm.loop !47

for.cond.cleanup45.us131:                         ; preds = %for.cond.cleanup45.us131.preheader, %for.cond.cleanup45.us131
  %j.0126.us130 = phi i32 [ %inc62.us134, %for.cond.cleanup45.us131 ], [ %j.0126.us130.ph, %for.cond.cleanup45.us131.preheader ]
  %add59.us132 = add nsw i32 %j.0126.us130, %mul58.us
  %arrayidx60.us133 = getelementptr inbounds i32, ptr addrspace(4) %C, i32 %add59.us132
  store i32 0, ptr addrspace(4) %arrayidx60.us133, align 4, !tbaa !3
  %inc62.us134 = add nsw i32 %j.0126.us130, 1
  %cmp38.us135 = icmp slt i32 %inc62.us134, %N
  br i1 %cmp38.us135, label %for.cond.cleanup45.us131, label %for.cond.cleanup39.us, !llvm.loop !50

iter.check:                                       ; preds = %iter.check.preheader, %for.cond.cleanup39.us
  %i32.0128.us = phi i32 [ %inc65.us, %for.cond.cleanup39.us ], [ 0, %iter.check.preheader ]
  %mul58.us = mul nsw i32 %i32.0128.us, %N
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %iter.check
  %index = phi i32 [ 0, %iter.check ], [ %index.next, %vector.body ]
  %offset.idx = add i32 %mul, %index
  %70 = add nsw i32 %offset.idx, %mul58.us
  %71 = getelementptr inbounds i32, ptr addrspace(4) %C, i32 %70
  store <16 x i32> zeroinitializer, ptr addrspace(4) %71, align 4, !tbaa !3
  %72 = getelementptr inbounds i32, ptr addrspace(4) %71, i32 16
  store <16 x i32> zeroinitializer, ptr addrspace(4) %72, align 4, !tbaa !3
  %73 = getelementptr inbounds i32, ptr addrspace(4) %71, i32 32
  store <16 x i32> zeroinitializer, ptr addrspace(4) %73, align 4, !tbaa !3
  %74 = getelementptr inbounds i32, ptr addrspace(4) %71, i32 48
  store <16 x i32> zeroinitializer, ptr addrspace(4) %74, align 4, !tbaa !3
  %index.next = add nuw i32 %index, 64
  %75 = icmp eq i32 %index.next, %n.vec
  br i1 %75, label %middle.block, label %vector.body, !llvm.loop !52

middle.block:                                     ; preds = %vector.body
  br i1 %cmp.n, label %for.cond.cleanup39.us, label %vec.epilog.iter.check

vec.epilog.iter.check:                            ; preds = %middle.block
  br i1 %min.epilog.iters.check, label %for.cond.cleanup45.us131.preheader, label %vec.epilog.vector.body.preheader

vec.epilog.vector.body.preheader:                 ; preds = %vec.epilog.iter.check
  br label %vec.epilog.vector.body

vec.epilog.vector.body:                           ; preds = %vec.epilog.vector.body.preheader, %vec.epilog.vector.body
  %index157 = phi i32 [ %index.next159, %vec.epilog.vector.body ], [ %n.vec, %vec.epilog.vector.body.preheader ]
  %offset.idx158 = add i32 %mul, %index157
  %76 = add nsw i32 %offset.idx158, %mul58.us
  %77 = getelementptr inbounds i32, ptr addrspace(4) %C, i32 %76
  store <8 x i32> zeroinitializer, ptr addrspace(4) %77, align 4, !tbaa !3
  %index.next159 = add nuw i32 %index157, 8
  %78 = icmp eq i32 %index.next159, %n.vec154
  br i1 %78, label %vec.epilog.middle.block, label %vec.epilog.vector.body, !llvm.loop !51

vec.epilog.middle.block:                          ; preds = %vec.epilog.vector.body
  br i1 %cmp.n156, label %for.cond.cleanup39.us, label %for.cond.cleanup45.us131.preheader

for.cond.cleanup45.us131.preheader:               ; preds = %vec.epilog.iter.check, %vec.epilog.middle.block
  %j.0126.us130.ph = phi i32 [ %ind.end155, %vec.epilog.iter.check ], [ %ind.end, %vec.epilog.middle.block ]
  br label %for.cond.cleanup45.us131

for.cond.cleanup35:                               ; preds = %for.cond.cleanup39.us, %for.cond.cleanup39.us.us226, %for.cond.cleanup39.us.us226.us, %for.cond.cleanup39.us.us211, %for.cond.cleanup39.us.us, %for.cond.cleanup39.us.us.split.split.us.us, %for.cond.cleanup39.us.us.split.split.us.us.split.us.us, %for.cond.cleanup39.us.us.split.us.us, %entry, %for.body36.lr.ph, %for.cond.cleanup
  ret void
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @autovectorized_matmul(ptr addrspace(4) noalias nocapture noundef readonly %A, ptr addrspace(4) noalias nocapture noundef readonly %B, ptr addrspace(4) noalias nocapture noundef %C, i32 noundef %M, i32 noundef %N, i32 noundef %K) local_unnamed_addr #2 {
entry:
  %cmp40 = icmp sgt i32 %M, 0
  %cmp238 = icmp sgt i32 %N, 0
  %or.cond = and i1 %cmp40, %cmp238
  %cmp635 = icmp sgt i32 %K, 0
  %or.cond53 = and i1 %or.cond, %cmp635
  br i1 %or.cond53, label %for.body.lr.ph.split.us.split.us, label %for.cond.cleanup

for.body.lr.ph.split.us.split.us:                 ; preds = %entry
  %min.iters.check = icmp ult i32 %K, 8
  %min.iters.check54 = icmp ult i32 %K, 64
  %n.vec = and i32 %K, -64
  %cmp.n = icmp eq i32 %n.vec, %K
  %n.vec.remaining = and i32 %K, 56
  %min.epilog.iters.check = icmp eq i32 %n.vec.remaining, 0
  %n.vec68 = and i32 %K, -8
  %cmp.n69 = icmp eq i32 %n.vec68, %K
  br i1 %min.iters.check, label %for.body4.lr.ph.split.us.us.us.us.preheader, label %for.body.lr.ph.split.us.split.us.split

for.body4.lr.ph.split.us.us.us.us.preheader:      ; preds = %for.body.lr.ph.split.us.split.us
  br label %for.body4.lr.ph.split.us.us.us.us

for.body4.lr.ph.split.us.us.us.us:                ; preds = %for.body4.lr.ph.split.us.us.us.us.preheader, %for.cond.cleanup3.us.us.split.us.us
  %i.041.us.us.us = phi i32 [ %inc21.us.us.us, %for.cond.cleanup3.us.us.split.us.us ], [ 0, %for.body4.lr.ph.split.us.us.us.us.preheader ]
  %mul.us.us.us = mul nsw i32 %i.041.us.us.us, %K
  %mul13.us.us.us = mul nsw i32 %i.041.us.us.us, %N
  br label %iter.check.us.us

iter.check.us.us:                                 ; preds = %for.cond.cleanup7.us.us.us.loopexit.us.us, %for.body4.lr.ph.split.us.us.us.us
  %j.039.us.us.us.us.us = phi i32 [ 0, %for.body4.lr.ph.split.us.us.us.us ], [ %inc18.us.us.us.us.us, %for.cond.cleanup7.us.us.us.loopexit.us.us ]
  %add14.us.us.us.us.us = add nsw i32 %j.039.us.us.us.us.us, %mul13.us.us.us
  %arrayidx15.us.us.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %C, i32 %add14.us.us.us.us.us
  %arrayidx15.promoted.us.us.us.us.us = load i32, ptr addrspace(4) %arrayidx15.us.us.us.us.us, align 4, !tbaa !3
  br label %for.body8.us.us.us.us.us

for.body8.us.us.us.us.us:                         ; preds = %iter.check.us.us, %for.body8.us.us.us.us.us
  %add1637.us.us.us.us.us = phi i32 [ %arrayidx15.promoted.us.us.us.us.us, %iter.check.us.us ], [ %add16.us.us.us.us.us, %for.body8.us.us.us.us.us ]
  %k.036.us.us.us.us.us = phi i32 [ 0, %iter.check.us.us ], [ %inc.us.us.us.us.us, %for.body8.us.us.us.us.us ]
  %add.us.us.us.us.us = add nsw i32 %k.036.us.us.us.us.us, %mul.us.us.us
  %arrayidx.us.us.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %add.us.us.us.us.us
  %0 = load i32, ptr addrspace(4) %arrayidx.us.us.us.us.us, align 4, !tbaa !3
  %mul9.us.us.us.us.us = mul nsw i32 %k.036.us.us.us.us.us, %N
  %add10.us.us.us.us.us = add nsw i32 %mul9.us.us.us.us.us, %j.039.us.us.us.us.us
  %arrayidx11.us.us.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %B, i32 %add10.us.us.us.us.us
  %1 = load i32, ptr addrspace(4) %arrayidx11.us.us.us.us.us, align 4, !tbaa !3
  %mul12.us.us.us.us.us = mul nsw i32 %1, %0
  %add16.us.us.us.us.us = add nsw i32 %mul12.us.us.us.us.us, %add1637.us.us.us.us.us
  %inc.us.us.us.us.us = add nuw nsw i32 %k.036.us.us.us.us.us, 1
  %cmp6.us.us.us.us.us = icmp slt i32 %inc.us.us.us.us.us, %K
  br i1 %cmp6.us.us.us.us.us, label %for.body8.us.us.us.us.us, label %for.cond.cleanup7.us.us.us.loopexit.us.us, !llvm.loop !53

for.cond.cleanup7.us.us.us.loopexit.us.us:        ; preds = %for.body8.us.us.us.us.us
  store i32 %add16.us.us.us.us.us, ptr addrspace(4) %arrayidx15.us.us.us.us.us, align 4, !tbaa !3
  %inc18.us.us.us.us.us = add nuw nsw i32 %j.039.us.us.us.us.us, 1
  %cmp2.us.us.us.us.us = icmp slt i32 %inc18.us.us.us.us.us, %N
  br i1 %cmp2.us.us.us.us.us, label %iter.check.us.us, label %for.cond.cleanup3.us.us.split.us.us, !llvm.loop !54

for.cond.cleanup3.us.us.split.us.us:              ; preds = %for.cond.cleanup7.us.us.us.loopexit.us.us
  %inc21.us.us.us = add nuw nsw i32 %i.041.us.us.us, 1
  %cmp.us.us.us = icmp slt i32 %inc21.us.us.us, %M
  br i1 %cmp.us.us.us, label %for.body4.lr.ph.split.us.us.us.us, label %for.cond.cleanup, !llvm.loop !55

for.body.lr.ph.split.us.split.us.split:           ; preds = %for.body.lr.ph.split.us.split.us
  %ident.check.not = icmp eq i32 %N, 1
  br i1 %ident.check.not, label %for.body.lr.ph.split.us.split.us.split.split.us, label %for.body4.lr.ph.split.us.us.us.preheader

for.body4.lr.ph.split.us.us.us.preheader:         ; preds = %for.body.lr.ph.split.us.split.us.split
  br label %for.body4.lr.ph.split.us.us.us

for.body.lr.ph.split.us.split.us.split.split.us:  ; preds = %for.body.lr.ph.split.us.split.us.split
  br i1 %min.iters.check54, label %for.body.lr.ph.split.us.split.us.split.split.us.split.us, label %for.body4.lr.ph.split.us.us.us.us107.preheader

for.body4.lr.ph.split.us.us.us.us107.preheader:   ; preds = %for.body.lr.ph.split.us.split.us.split.split.us
  br label %iter.check.us81.us

for.body.lr.ph.split.us.split.us.split.split.us.split.us: ; preds = %for.body.lr.ph.split.us.split.us.split.split.us
  br i1 %cmp.n69, label %for.body4.lr.ph.split.us.us.us.us107.us.us.preheader, label %for.body4.lr.ph.split.us.us.us.us107.us.preheader

for.body4.lr.ph.split.us.us.us.us107.us.preheader: ; preds = %for.body.lr.ph.split.us.split.us.split.split.us.split.us
  br label %iter.check.us81.us.us.us

for.body4.lr.ph.split.us.us.us.us107.us.us.preheader: ; preds = %for.body.lr.ph.split.us.split.us.split.split.us.split.us
  br label %iter.check.us81.us.us.us.us.us

iter.check.us81.us.us.us.us.us:                   ; preds = %for.cond.cleanup3.us.us.split.split.us.us.split.us.us.split.us.us, %for.body4.lr.ph.split.us.us.us.us107.us.us.preheader
  %i.041.us.us.us108.us.us = phi i32 [ %inc21.us.us.us112.us.us, %for.cond.cleanup3.us.us.split.split.us.us.split.us.us.split.us.us ], [ 0, %for.body4.lr.ph.split.us.us.us.us107.us.us.preheader ]
  %mul.us.us.us109.us.us = mul nsw i32 %i.041.us.us.us108.us.us, %K
  %arrayidx15.us.us.us.us84.us.us.us.us.us.phi.trans.insert = getelementptr inbounds i32, ptr addrspace(4) %C, i32 %i.041.us.us.us108.us.us
  %arrayidx15.promoted.us.us.us.us85.us.us.us.us.us.pre = load i32, ptr addrspace(4) %arrayidx15.us.us.us.us84.us.us.us.us.us.phi.trans.insert, align 4, !tbaa !3
  %2 = insertelement <8 x i32> <i32 poison, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, i32 %arrayidx15.promoted.us.us.us.us85.us.us.us.us.us.pre, i64 0
  br label %vec.epilog.vector.body.us.us.us.us.us.us

vec.epilog.vector.body.us.us.us.us.us.us:         ; preds = %vec.epilog.vector.body.us.us.us.us.us.us, %iter.check.us81.us.us.us.us.us
  %index70.us.us.us.us.us.us = phi i32 [ 0, %iter.check.us81.us.us.us.us.us ], [ %index.next74.us.us.us.us.us.us, %vec.epilog.vector.body.us.us.us.us.us.us ]
  %vec.phi71.us.us.us.us.us.us = phi <8 x i32> [ %2, %iter.check.us81.us.us.us.us.us ], [ %7, %vec.epilog.vector.body.us.us.us.us.us.us ]
  %3 = add nsw i32 %index70.us.us.us.us.us.us, %mul.us.us.us109.us.us
  %4 = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %3
  %wide.load72.us.us.us.us.us.us = load <8 x i32>, ptr addrspace(4) %4, align 4, !tbaa !3
  %5 = getelementptr inbounds i32, ptr addrspace(4) %B, i32 %index70.us.us.us.us.us.us
  %wide.load73.us.us.us.us.us.us = load <8 x i32>, ptr addrspace(4) %5, align 4, !tbaa !3
  %6 = mul nsw <8 x i32> %wide.load73.us.us.us.us.us.us, %wide.load72.us.us.us.us.us.us
  %7 = add <8 x i32> %6, %vec.phi71.us.us.us.us.us.us
  %index.next74.us.us.us.us.us.us = add nuw i32 %index70.us.us.us.us.us.us, 8
  %8 = icmp eq i32 %index.next74.us.us.us.us.us.us, %K
  br i1 %8, label %for.cond.cleanup3.us.us.split.split.us.us.split.us.us.split.us.us, label %vec.epilog.vector.body.us.us.us.us.us.us, !llvm.loop !56

for.cond.cleanup3.us.us.split.split.us.us.split.us.us.split.us.us: ; preds = %vec.epilog.vector.body.us.us.us.us.us.us
  %9 = tail call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %7)
  store i32 %9, ptr addrspace(4) %arrayidx15.us.us.us.us84.us.us.us.us.us.phi.trans.insert, align 4, !tbaa !3
  %inc21.us.us.us112.us.us = add nuw nsw i32 %i.041.us.us.us108.us.us, 1
  %cmp.us.us.us113.us.us = icmp slt i32 %inc21.us.us.us112.us.us, %M
  br i1 %cmp.us.us.us113.us.us, label %iter.check.us81.us.us.us.us.us, label %for.cond.cleanup, !llvm.loop !55

iter.check.us81.us.us.us:                         ; preds = %for.cond.cleanup3.us.us.split.split.us.us.split.us.us, %for.body4.lr.ph.split.us.us.us.us107.us.preheader
  %i.041.us.us.us108.us = phi i32 [ %inc21.us.us.us112.us, %for.cond.cleanup3.us.us.split.split.us.us.split.us.us ], [ 0, %for.body4.lr.ph.split.us.us.us.us107.us.preheader ]
  %mul.us.us.us109.us = mul nsw i32 %i.041.us.us.us108.us, %K
  %arrayidx15.us.us.us.us84.us.us.us.phi.trans.insert = getelementptr inbounds i32, ptr addrspace(4) %C, i32 %i.041.us.us.us108.us
  %arrayidx15.promoted.us.us.us.us85.us.us.us.pre = load i32, ptr addrspace(4) %arrayidx15.us.us.us.us84.us.us.us.phi.trans.insert, align 4, !tbaa !3
  %10 = insertelement <8 x i32> <i32 poison, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, i32 %arrayidx15.promoted.us.us.us.us85.us.us.us.pre, i64 0
  br label %vec.epilog.vector.body.us.us.us.us

for.body8.us.us.us.us86.us.us.us:                 ; preds = %vec.epilog.middle.block.us.us.us.us, %for.body8.us.us.us.us86.us.us.us
  %add1637.us.us.us.us87.us.us.us = phi i32 [ %13, %vec.epilog.middle.block.us.us.us.us ], [ %add16.us.us.us.us95.us.us.us, %for.body8.us.us.us.us86.us.us.us ]
  %k.036.us.us.us.us88.us.us.us = phi i32 [ %n.vec68, %vec.epilog.middle.block.us.us.us.us ], [ %inc.us.us.us.us96.us.us.us, %for.body8.us.us.us.us86.us.us.us ]
  %add.us.us.us.us89.us.us.us = add nsw i32 %k.036.us.us.us.us88.us.us.us, %mul.us.us.us109.us
  %arrayidx.us.us.us.us90.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %add.us.us.us.us89.us.us.us
  %11 = load i32, ptr addrspace(4) %arrayidx.us.us.us.us90.us.us.us, align 4, !tbaa !3
  %arrayidx11.us.us.us.us93.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %B, i32 %k.036.us.us.us.us88.us.us.us
  %12 = load i32, ptr addrspace(4) %arrayidx11.us.us.us.us93.us.us.us, align 4, !tbaa !3
  %mul12.us.us.us.us94.us.us.us = mul nsw i32 %12, %11
  %add16.us.us.us.us95.us.us.us = add nsw i32 %mul12.us.us.us.us94.us.us.us, %add1637.us.us.us.us87.us.us.us
  %inc.us.us.us.us96.us.us.us = add nuw nsw i32 %k.036.us.us.us.us88.us.us.us, 1
  %cmp6.us.us.us.us97.us.us.us = icmp slt i32 %inc.us.us.us.us96.us.us.us, %K
  br i1 %cmp6.us.us.us.us97.us.us.us, label %for.body8.us.us.us.us86.us.us.us, label %for.cond.cleanup3.us.us.split.split.us.us.split.us.us, !llvm.loop !53

vec.epilog.middle.block.us.us.us.us:              ; preds = %vec.epilog.vector.body.us.us.us.us
  %13 = tail call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %18)
  br label %for.body8.us.us.us.us86.us.us.us

vec.epilog.vector.body.us.us.us.us:               ; preds = %vec.epilog.vector.body.us.us.us.us, %iter.check.us81.us.us.us
  %index70.us.us.us.us = phi i32 [ 0, %iter.check.us81.us.us.us ], [ %index.next74.us.us.us.us, %vec.epilog.vector.body.us.us.us.us ]
  %vec.phi71.us.us.us.us = phi <8 x i32> [ %10, %iter.check.us81.us.us.us ], [ %18, %vec.epilog.vector.body.us.us.us.us ]
  %14 = add nsw i32 %index70.us.us.us.us, %mul.us.us.us109.us
  %15 = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %14
  %wide.load72.us.us.us.us = load <8 x i32>, ptr addrspace(4) %15, align 4, !tbaa !3
  %16 = getelementptr inbounds i32, ptr addrspace(4) %B, i32 %index70.us.us.us.us
  %wide.load73.us.us.us.us = load <8 x i32>, ptr addrspace(4) %16, align 4, !tbaa !3
  %17 = mul nsw <8 x i32> %wide.load73.us.us.us.us, %wide.load72.us.us.us.us
  %18 = add <8 x i32> %17, %vec.phi71.us.us.us.us
  %index.next74.us.us.us.us = add nuw i32 %index70.us.us.us.us, 8
  %19 = icmp eq i32 %index.next74.us.us.us.us, %n.vec68
  br i1 %19, label %vec.epilog.middle.block.us.us.us.us, label %vec.epilog.vector.body.us.us.us.us, !llvm.loop !56

for.cond.cleanup3.us.us.split.split.us.us.split.us.us: ; preds = %for.body8.us.us.us.us86.us.us.us
  store i32 %add16.us.us.us.us95.us.us.us, ptr addrspace(4) %arrayidx15.us.us.us.us84.us.us.us.phi.trans.insert, align 4, !tbaa !3
  %inc21.us.us.us112.us = add nuw nsw i32 %i.041.us.us.us108.us, 1
  %cmp.us.us.us113.us = icmp slt i32 %inc21.us.us.us112.us, %M
  br i1 %cmp.us.us.us113.us, label %iter.check.us81.us.us.us, label %for.cond.cleanup, !llvm.loop !55

iter.check.us81.us:                               ; preds = %for.cond.cleanup3.us.us.split.split.us.us, %for.body4.lr.ph.split.us.us.us.us107.preheader
  %i.041.us.us.us108 = phi i32 [ %inc21.us.us.us112, %for.cond.cleanup3.us.us.split.split.us.us ], [ 0, %for.body4.lr.ph.split.us.us.us.us107.preheader ]
  %mul.us.us.us109 = mul nsw i32 %i.041.us.us.us108, %K
  %arrayidx15.us.us.us.us84.us.phi.trans.insert = getelementptr inbounds i32, ptr addrspace(4) %C, i32 %i.041.us.us.us108
  %arrayidx15.promoted.us.us.us.us85.us.pre = load i32, ptr addrspace(4) %arrayidx15.us.us.us.us84.us.phi.trans.insert, align 4, !tbaa !3
  %20 = insertelement <16 x i32> <i32 poison, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, i32 %arrayidx15.promoted.us.us.us.us85.us.pre, i64 0
  br label %vector.body.us.us

for.body8.us.us.us.us86.us:                       ; preds = %for.body8.us.us.us.us86.us.preheader, %for.body8.us.us.us.us86.us
  %add1637.us.us.us.us87.us = phi i32 [ %add16.us.us.us.us95.us, %for.body8.us.us.us.us86.us ], [ %add1637.us.us.us.us87.us.ph, %for.body8.us.us.us.us86.us.preheader ]
  %k.036.us.us.us.us88.us = phi i32 [ %inc.us.us.us.us96.us, %for.body8.us.us.us.us86.us ], [ %k.036.us.us.us.us88.us.ph, %for.body8.us.us.us.us86.us.preheader ]
  %add.us.us.us.us89.us = add nsw i32 %k.036.us.us.us.us88.us, %mul.us.us.us109
  %arrayidx.us.us.us.us90.us = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %add.us.us.us.us89.us
  %21 = load i32, ptr addrspace(4) %arrayidx.us.us.us.us90.us, align 4, !tbaa !3
  %arrayidx11.us.us.us.us93.us = getelementptr inbounds i32, ptr addrspace(4) %B, i32 %k.036.us.us.us.us88.us
  %22 = load i32, ptr addrspace(4) %arrayidx11.us.us.us.us93.us, align 4, !tbaa !3
  %mul12.us.us.us.us94.us = mul nsw i32 %22, %21
  %add16.us.us.us.us95.us = add nsw i32 %mul12.us.us.us.us94.us, %add1637.us.us.us.us87.us
  %inc.us.us.us.us96.us = add nuw nsw i32 %k.036.us.us.us.us88.us, 1
  %cmp6.us.us.us.us97.us = icmp slt i32 %inc.us.us.us.us96.us, %K
  br i1 %cmp6.us.us.us.us97.us, label %for.body8.us.us.us.us86.us, label %for.cond.cleanup3.us.us.split.split.us.us, !llvm.loop !53

middle.block.us.us:                               ; preds = %vector.body.us.us
  %bin.rdx.us.us = add <16 x i32> %38, %37
  %bin.rdx65.us.us = add <16 x i32> %39, %bin.rdx.us.us
  %bin.rdx66.us.us = add <16 x i32> %40, %bin.rdx65.us.us
  %23 = tail call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %bin.rdx66.us.us)
  br i1 %cmp.n, label %for.cond.cleanup3.us.us.split.split.us.us, label %vec.epilog.iter.check.us.us

vec.epilog.iter.check.us.us:                      ; preds = %middle.block.us.us
  br i1 %min.epilog.iters.check, label %for.body8.us.us.us.us86.us.preheader, label %vec.epilog.ph.us.us

for.body8.us.us.us.us86.us.preheader:             ; preds = %vec.epilog.middle.block.us.us, %vec.epilog.iter.check.us.us
  %add1637.us.us.us.us87.us.ph = phi i32 [ %23, %vec.epilog.iter.check.us.us ], [ %42, %vec.epilog.middle.block.us.us ]
  %k.036.us.us.us.us88.us.ph = phi i32 [ %n.vec, %vec.epilog.iter.check.us.us ], [ %n.vec68, %vec.epilog.middle.block.us.us ]
  br label %for.body8.us.us.us.us86.us

vector.body.us.us:                                ; preds = %vector.body.us.us, %iter.check.us81.us
  %index.us.us = phi i32 [ 0, %iter.check.us81.us ], [ %index.next.us.us, %vector.body.us.us ]
  %vec.phi.us.us = phi <16 x i32> [ %20, %iter.check.us81.us ], [ %37, %vector.body.us.us ]
  %vec.phi55.us.us = phi <16 x i32> [ zeroinitializer, %iter.check.us81.us ], [ %38, %vector.body.us.us ]
  %vec.phi56.us.us = phi <16 x i32> [ zeroinitializer, %iter.check.us81.us ], [ %39, %vector.body.us.us ]
  %vec.phi57.us.us = phi <16 x i32> [ zeroinitializer, %iter.check.us81.us ], [ %40, %vector.body.us.us ]
  %24 = add nsw i32 %index.us.us, %mul.us.us.us109
  %25 = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %24
  %wide.load.us.us = load <16 x i32>, ptr addrspace(4) %25, align 4, !tbaa !3
  %26 = getelementptr inbounds i32, ptr addrspace(4) %25, i32 16
  %wide.load58.us.us = load <16 x i32>, ptr addrspace(4) %26, align 4, !tbaa !3
  %27 = getelementptr inbounds i32, ptr addrspace(4) %25, i32 32
  %wide.load59.us.us = load <16 x i32>, ptr addrspace(4) %27, align 4, !tbaa !3
  %28 = getelementptr inbounds i32, ptr addrspace(4) %25, i32 48
  %wide.load60.us.us = load <16 x i32>, ptr addrspace(4) %28, align 4, !tbaa !3
  %29 = getelementptr inbounds i32, ptr addrspace(4) %B, i32 %index.us.us
  %wide.load61.us.us = load <16 x i32>, ptr addrspace(4) %29, align 4, !tbaa !3
  %30 = getelementptr inbounds i32, ptr addrspace(4) %29, i32 16
  %wide.load62.us.us = load <16 x i32>, ptr addrspace(4) %30, align 4, !tbaa !3
  %31 = getelementptr inbounds i32, ptr addrspace(4) %29, i32 32
  %wide.load63.us.us = load <16 x i32>, ptr addrspace(4) %31, align 4, !tbaa !3
  %32 = getelementptr inbounds i32, ptr addrspace(4) %29, i32 48
  %wide.load64.us.us = load <16 x i32>, ptr addrspace(4) %32, align 4, !tbaa !3
  %33 = mul nsw <16 x i32> %wide.load61.us.us, %wide.load.us.us
  %34 = mul nsw <16 x i32> %wide.load62.us.us, %wide.load58.us.us
  %35 = mul nsw <16 x i32> %wide.load63.us.us, %wide.load59.us.us
  %36 = mul nsw <16 x i32> %wide.load64.us.us, %wide.load60.us.us
  %37 = add <16 x i32> %33, %vec.phi.us.us
  %38 = add <16 x i32> %34, %vec.phi55.us.us
  %39 = add <16 x i32> %35, %vec.phi56.us.us
  %40 = add <16 x i32> %36, %vec.phi57.us.us
  %index.next.us.us = add nuw i32 %index.us.us, 64
  %41 = icmp eq i32 %index.next.us.us, %n.vec
  br i1 %41, label %middle.block.us.us, label %vector.body.us.us, !llvm.loop !57

vec.epilog.middle.block.us.us:                    ; preds = %vec.epilog.vector.body.us.us
  %42 = tail call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %48)
  br i1 %cmp.n69, label %for.cond.cleanup3.us.us.split.split.us.us, label %for.body8.us.us.us.us86.us.preheader

vec.epilog.ph.us.us:                              ; preds = %vec.epilog.iter.check.us.us
  %43 = insertelement <8 x i32> <i32 poison, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, i32 %23, i64 0
  br label %vec.epilog.vector.body.us.us

vec.epilog.vector.body.us.us:                     ; preds = %vec.epilog.vector.body.us.us, %vec.epilog.ph.us.us
  %index70.us.us = phi i32 [ %n.vec, %vec.epilog.ph.us.us ], [ %index.next74.us.us, %vec.epilog.vector.body.us.us ]
  %vec.phi71.us.us = phi <8 x i32> [ %43, %vec.epilog.ph.us.us ], [ %48, %vec.epilog.vector.body.us.us ]
  %44 = add nsw i32 %index70.us.us, %mul.us.us.us109
  %45 = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %44
  %wide.load72.us.us = load <8 x i32>, ptr addrspace(4) %45, align 4, !tbaa !3
  %46 = getelementptr inbounds i32, ptr addrspace(4) %B, i32 %index70.us.us
  %wide.load73.us.us = load <8 x i32>, ptr addrspace(4) %46, align 4, !tbaa !3
  %47 = mul nsw <8 x i32> %wide.load73.us.us, %wide.load72.us.us
  %48 = add <8 x i32> %47, %vec.phi71.us.us
  %index.next74.us.us = add nuw i32 %index70.us.us, 8
  %49 = icmp eq i32 %index.next74.us.us, %n.vec68
  br i1 %49, label %vec.epilog.middle.block.us.us, label %vec.epilog.vector.body.us.us, !llvm.loop !56

for.cond.cleanup3.us.us.split.split.us.us:        ; preds = %middle.block.us.us, %vec.epilog.middle.block.us.us, %for.body8.us.us.us.us86.us
  %add16.us.us.us.lcssa.us99.us = phi i32 [ %23, %middle.block.us.us ], [ %42, %vec.epilog.middle.block.us.us ], [ %add16.us.us.us.us95.us, %for.body8.us.us.us.us86.us ]
  store i32 %add16.us.us.us.lcssa.us99.us, ptr addrspace(4) %arrayidx15.us.us.us.us84.us.phi.trans.insert, align 4, !tbaa !3
  %inc21.us.us.us112 = add nuw nsw i32 %i.041.us.us.us108, 1
  %cmp.us.us.us113 = icmp slt i32 %inc21.us.us.us112, %M
  br i1 %cmp.us.us.us113, label %iter.check.us81.us, label %for.cond.cleanup, !llvm.loop !55

for.cond.cleanup3.us.us:                          ; preds = %for.cond.cleanup7.us.us.us
  %inc21.us.us = add nuw nsw i32 %i.041.us.us, 1
  %cmp.us.us = icmp slt i32 %inc21.us.us, %M
  br i1 %cmp.us.us, label %for.body4.lr.ph.split.us.us.us, label %for.cond.cleanup, !llvm.loop !55

for.body4.lr.ph.split.us.us.us:                   ; preds = %for.body4.lr.ph.split.us.us.us.preheader, %for.cond.cleanup3.us.us
  %i.041.us.us = phi i32 [ %inc21.us.us, %for.cond.cleanup3.us.us ], [ 0, %for.body4.lr.ph.split.us.us.us.preheader ]
  %mul.us.us = mul nsw i32 %i.041.us.us, %K
  %mul13.us.us = mul nsw i32 %i.041.us.us, %N
  br label %iter.check

for.cond.cleanup7.us.us.us:                       ; preds = %for.body8.us.us.us
  store i32 %add16.us.us.us, ptr addrspace(4) %arrayidx15.us.us.us, align 4, !tbaa !3
  %inc18.us.us.us = add nuw nsw i32 %j.039.us.us.us, 1
  %cmp2.us.us.us = icmp slt i32 %inc18.us.us.us, %N
  br i1 %cmp2.us.us.us, label %iter.check, label %for.cond.cleanup3.us.us, !llvm.loop !54

for.body8.us.us.us:                               ; preds = %iter.check, %for.body8.us.us.us
  %add1637.us.us.us = phi i32 [ %arrayidx15.promoted.us.us.us, %iter.check ], [ %add16.us.us.us, %for.body8.us.us.us ]
  %k.036.us.us.us = phi i32 [ 0, %iter.check ], [ %inc.us.us.us, %for.body8.us.us.us ]
  %add.us.us.us = add nsw i32 %k.036.us.us.us, %mul.us.us
  %arrayidx.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %add.us.us.us
  %50 = load i32, ptr addrspace(4) %arrayidx.us.us.us, align 4, !tbaa !3
  %mul9.us.us.us = mul nsw i32 %k.036.us.us.us, %N
  %add10.us.us.us = add nsw i32 %mul9.us.us.us, %j.039.us.us.us
  %arrayidx11.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %B, i32 %add10.us.us.us
  %51 = load i32, ptr addrspace(4) %arrayidx11.us.us.us, align 4, !tbaa !3
  %mul12.us.us.us = mul nsw i32 %51, %50
  %add16.us.us.us = add nsw i32 %mul12.us.us.us, %add1637.us.us.us
  %inc.us.us.us = add nuw nsw i32 %k.036.us.us.us, 1
  %cmp6.us.us.us = icmp slt i32 %inc.us.us.us, %K
  br i1 %cmp6.us.us.us, label %for.body8.us.us.us, label %for.cond.cleanup7.us.us.us, !llvm.loop !53

iter.check:                                       ; preds = %for.body4.lr.ph.split.us.us.us, %for.cond.cleanup7.us.us.us
  %j.039.us.us.us = phi i32 [ 0, %for.body4.lr.ph.split.us.us.us ], [ %inc18.us.us.us, %for.cond.cleanup7.us.us.us ]
  %add14.us.us.us = add nsw i32 %j.039.us.us.us, %mul13.us.us
  %arrayidx15.us.us.us = getelementptr inbounds i32, ptr addrspace(4) %C, i32 %add14.us.us.us
  %arrayidx15.promoted.us.us.us = load i32, ptr addrspace(4) %arrayidx15.us.us.us, align 4, !tbaa !3
  br label %for.body8.us.us.us

for.cond.cleanup:                                 ; preds = %for.cond.cleanup3.us.us, %for.cond.cleanup3.us.us.split.split.us.us, %for.cond.cleanup3.us.us.split.split.us.us.split.us.us, %for.cond.cleanup3.us.us.split.split.us.us.split.us.us.split.us.us, %for.cond.cleanup3.us.us.split.us.us, %entry
  ret void
}

; Function Attrs: nounwind
define dso_local void @vekt_matmul_wrapper(ptr noundef %a, ptr noundef %b, ptr noundef %c, i32 noundef %M, i32 noundef %N, i32 noundef %K) local_unnamed_addr #4 {
entry:
  tail call void @vekt_matmul(i32 noundef %M, i32 noundef %N, i32 noundef %K, ptr noundef %a, ptr noundef %a, i32 noundef 0, i32 noundef %M, i32 noundef %K, i32 noundef %K, i32 noundef 1, ptr noundef %b, ptr noundef %b, i32 noundef 0, i32 noundef %K, i32 noundef %N, i32 noundef %N, i32 noundef 1, ptr noundef %c, ptr noundef %c, i32 noundef 0, i32 noundef %M, i32 noundef %N, i32 noundef %N, i32 noundef 1) #11
  ret void
}

declare void @vekt_matmul(i32 noundef, i32 noundef, i32 noundef, ptr noundef, ptr noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef, ptr noundef, ptr noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef, ptr noundef, ptr noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef) local_unnamed_addr #5

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
declare i32 @llvm.smax.i32(i32, i32) #10

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
!42 = distinct !{!42, !8}
!43 = distinct !{!43, !8}
!44 = distinct !{!44, !8}
!45 = distinct !{!45, !8, !9}
!46 = distinct !{!46, !8}
!47 = distinct !{!47, !8}
!48 = distinct !{!48, !8, !9, !10}
!49 = distinct !{!49, !8, !9, !10}
!50 = distinct !{!50, !8, !10, !9}
!51 = distinct !{!51, !8, !9, !10}
!52 = distinct !{!52, !8, !9, !10}
!53 = distinct !{!53, !8, !9}
!54 = distinct !{!54, !8}
!55 = distinct !{!55, !8}
!56 = distinct !{!56, !8, !9, !10}
!57 = distinct !{!57, !8, !9, !10}
