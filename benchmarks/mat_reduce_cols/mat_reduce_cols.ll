; ModuleID = 'mat_reduce_cols.c'
source_filename = "mat_reduce_cols.c"
target datalayout = "e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-f64:32-v64:32-v128:32-a:0:32-v256:32-v512:32-n8:16:32"
target triple = "arc-pc-unknown-gnu"

@.str.1 = private unnamed_addr constant [40 x i8] c"\09Elemento (%d) di A = %d mentre B = %d\0A\00", align 1
@.str.4 = private unnamed_addr constant [3 x i8] c"\09[\00", align 1
@.str.5 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.6 = private unnamed_addr constant [4 x i8] c"%d,\00", align 1
@str = private unnamed_addr constant [32 x i8] c"SUCCESSO! I vettori sono uguali\00", align 1
@str.10 = private unnamed_addr constant [37 x i8] c"ERRORE! I vettori non corrispondono!\00", align 1
@str.11 = private unnamed_addr constant [2 x i8] c"[\00", align 1
@str.13 = private unnamed_addr constant [3 x i8] c"],\00", align 1
@str.14 = private unnamed_addr constant [2 x i8] c"]\00", align 1

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
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !13

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
  br i1 %6, label %vec.epilog.middle.block, label %vec.epilog.vector.body, !llvm.loop !14

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
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !15
}

; Function Attrs: nofree nounwind
define dso_local void @check_result(ptr nocapture noundef readonly %A, ptr nocapture noundef readonly %B, i32 noundef %M) local_unnamed_addr #1 {
entry:
  %cmp20 = icmp sgt i32 %M, 0
  br i1 %cmp20, label %for.body.preheader, label %for.end

for.body.preheader:                               ; preds = %entry
  br label %for.body

for.body:                                         ; preds = %for.body.preheader, %for.inc
  %i.021 = phi i32 [ %inc, %for.inc ], [ 0, %for.body.preheader ]
  %arrayidx = getelementptr inbounds i32, ptr %A, i32 %i.021
  %0 = load i32, ptr %arrayidx, align 4, !tbaa !3
  %arrayidx1 = getelementptr inbounds i32, ptr %B, i32 %i.021
  %1 = load i32, ptr %arrayidx1, align 4, !tbaa !3
  %cmp2.not = icmp eq i32 %0, %1
  br i1 %cmp2.not, label %for.inc, label %cleanup

for.inc:                                          ; preds = %for.body
  %inc = add nuw nsw i32 %i.021, 1
  %cmp = icmp slt i32 %inc, %M
  br i1 %cmp, label %for.body, label %for.end, !llvm.loop !16

cleanup:                                          ; preds = %for.body
  %puts15 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.10)
  %2 = load i32, ptr %arrayidx, align 4, !tbaa !3
  %3 = load i32, ptr %arrayidx1, align 4, !tbaa !3
  %call5 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.1, i32 noundef %i.021, i32 noundef %2, i32 noundef %3)
  br label %return

for.end:                                          ; preds = %for.inc, %entry
  %puts = tail call i32 @puts(ptr nonnull dereferenceable(1) @str)
  br label %return

return:                                           ; preds = %cleanup, %for.end
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
  br i1 %cmp2.us.us, label %for.body4.us.us, label %for.cond.cleanup3.us.loopexit.us, !llvm.loop !17

for.cond.cleanup3.us.loopexit.us:                 ; preds = %for.body4.us.us
  %inc9.us.us = add nuw nsw i32 %i.023.us.us, 1
  %cmp.us.us = icmp slt i32 %inc9.us.us, %M
  br i1 %cmp.us.us, label %iter.check.us, label %for.cond.cleanup, !llvm.loop !18

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
  br i1 %cmp2.us.us48, label %for.body4.us.us42, label %for.cond.cleanup3.us.us49, !llvm.loop !17

for.cond.cleanup3.us.us49:                        ; preds = %for.body4.us.us42, %vec.epilog.middle.block.us
  %inc9.us.us50 = add nuw nsw i32 %i.023.us.us40, 1
  %cmp.us.us51 = icmp slt i32 %inc9.us.us50, %M
  br i1 %cmp.us.us51, label %iter.check.us39, label %for.cond.cleanup, !llvm.loop !18

vec.epilog.middle.block.us:                       ; preds = %vec.epilog.vector.body.us
  br i1 %cmp.n35, label %for.cond.cleanup3.us.us49, label %for.body4.us.us42.preheader

vec.epilog.vector.body.us:                        ; preds = %vec.epilog.vector.body.us.preheader, %vec.epilog.vector.body.us
  %index36.us = phi i32 [ %index.next38.us, %vec.epilog.vector.body.us ], [ 0, %vec.epilog.vector.body.us.preheader ]
  %5 = add nsw i32 %index36.us, %mul.us.us41
  %6 = getelementptr inbounds i32, ptr %src, i32 %5
  %wide.load37.us = load <8 x i32>, ptr %6, align 4, !tbaa !3, !alias.scope !19
  %7 = getelementptr inbounds i32, ptr %dst, i32 %5
  store <8 x i32> %wide.load37.us, ptr %7, align 4, !tbaa !3, !alias.scope !22, !noalias !19
  %index.next38.us = add nuw i32 %index36.us, 8
  %8 = icmp eq i32 %index.next38.us, %n.vec34
  br i1 %8, label %vec.epilog.middle.block.us, label %vec.epilog.vector.body.us, !llvm.loop !24

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
  br i1 %cmp2.us.us64, label %for.body4.us.us58, label %for.cond.cleanup3.us.us65, !llvm.loop !17

for.cond.cleanup3.us.us65:                        ; preds = %vector.body.us, %for.body4.us.us58
  %inc9.us.us66 = add nuw nsw i32 %i.023.us.us56, 1
  %cmp.us.us67 = icmp slt i32 %inc9.us.us66, %M
  br i1 %cmp.us.us67, label %iter.check.us55, label %for.cond.cleanup, !llvm.loop !18

vector.body.us:                                   ; preds = %vector.body.us.preheader, %vector.body.us
  %index.us = phi i32 [ %index.next.us, %vector.body.us ], [ 0, %vector.body.us.preheader ]
  %12 = add nsw i32 %index.us, %mul.us.us57
  %13 = getelementptr inbounds i32, ptr %src, i32 %12
  %wide.load.us = load <16 x i32>, ptr %13, align 4, !tbaa !3, !alias.scope !25
  %14 = getelementptr inbounds i32, ptr %13, i32 16
  %wide.load30.us = load <16 x i32>, ptr %14, align 4, !tbaa !3, !alias.scope !25
  %15 = getelementptr inbounds i32, ptr %13, i32 32
  %wide.load31.us = load <16 x i32>, ptr %15, align 4, !tbaa !3, !alias.scope !25
  %16 = getelementptr inbounds i32, ptr %13, i32 48
  %wide.load32.us = load <16 x i32>, ptr %16, align 4, !tbaa !3, !alias.scope !25
  %17 = getelementptr inbounds i32, ptr %dst, i32 %12
  store <16 x i32> %wide.load.us, ptr %17, align 4, !tbaa !3, !alias.scope !28, !noalias !25
  %18 = getelementptr inbounds i32, ptr %17, i32 16
  store <16 x i32> %wide.load30.us, ptr %18, align 4, !tbaa !3, !alias.scope !28, !noalias !25
  %19 = getelementptr inbounds i32, ptr %17, i32 32
  store <16 x i32> %wide.load31.us, ptr %19, align 4, !tbaa !3, !alias.scope !28, !noalias !25
  %20 = getelementptr inbounds i32, ptr %17, i32 48
  store <16 x i32> %wide.load32.us, ptr %20, align 4, !tbaa !3, !alias.scope !28, !noalias !25
  %index.next.us = add nuw i32 %index.us, 64
  %21 = icmp eq i32 %index.next.us, %N
  br i1 %21, label %for.cond.cleanup3.us.us65, label %vector.body.us, !llvm.loop !30

for.cond.cleanup3.us:                             ; preds = %for.body4.us, %vec.epilog.middle.block
  %inc9.us = add nuw nsw i32 %i.023.us, 1
  %cmp.us = icmp slt i32 %inc9.us, %M
  br i1 %cmp.us, label %iter.check, label %for.cond.cleanup, !llvm.loop !18

for.body4.us:                                     ; preds = %for.body4.us.preheader, %for.body4.us
  %j.021.us = phi i32 [ %inc.us, %for.body4.us ], [ %j.021.us.ph, %for.body4.us.preheader ]
  %add.us = add nsw i32 %j.021.us, %mul.us
  %arrayidx.us = getelementptr inbounds i32, ptr %src, i32 %add.us
  %22 = load i32, ptr %arrayidx.us, align 4, !tbaa !3
  %arrayidx7.us = getelementptr inbounds i32, ptr %dst, i32 %add.us
  store i32 %22, ptr %arrayidx7.us, align 4, !tbaa !3
  %inc.us = add nuw nsw i32 %j.021.us, 1
  %cmp2.us = icmp slt i32 %inc.us, %N
  br i1 %cmp2.us, label %for.body4.us, label %for.cond.cleanup3.us, !llvm.loop !17

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
  %wide.load = load <16 x i32>, ptr %26, align 4, !tbaa !3, !alias.scope !25
  %27 = getelementptr inbounds i32, ptr %26, i32 16
  %wide.load30 = load <16 x i32>, ptr %27, align 4, !tbaa !3, !alias.scope !25
  %28 = getelementptr inbounds i32, ptr %26, i32 32
  %wide.load31 = load <16 x i32>, ptr %28, align 4, !tbaa !3, !alias.scope !25
  %29 = getelementptr inbounds i32, ptr %26, i32 48
  %wide.load32 = load <16 x i32>, ptr %29, align 4, !tbaa !3, !alias.scope !25
  %30 = getelementptr inbounds i32, ptr %dst, i32 %25
  store <16 x i32> %wide.load, ptr %30, align 4, !tbaa !3, !alias.scope !28, !noalias !25
  %31 = getelementptr inbounds i32, ptr %30, i32 16
  store <16 x i32> %wide.load30, ptr %31, align 4, !tbaa !3, !alias.scope !28, !noalias !25
  %32 = getelementptr inbounds i32, ptr %30, i32 32
  store <16 x i32> %wide.load31, ptr %32, align 4, !tbaa !3, !alias.scope !28, !noalias !25
  %33 = getelementptr inbounds i32, ptr %30, i32 48
  store <16 x i32> %wide.load32, ptr %33, align 4, !tbaa !3, !alias.scope !28, !noalias !25
  %index.next = add nuw i32 %index, 64
  %34 = icmp eq i32 %index.next, %n.vec
  br i1 %34, label %vec.epilog.iter.check, label %vector.body, !llvm.loop !30

vec.epilog.iter.check:                            ; preds = %vector.body
  br i1 %min.epilog.iters.check, label %for.body4.us.preheader, label %vec.epilog.vector.body.preheader

vec.epilog.vector.body.preheader:                 ; preds = %vec.epilog.iter.check
  br label %vec.epilog.vector.body

vec.epilog.vector.body:                           ; preds = %vec.epilog.vector.body.preheader, %vec.epilog.vector.body
  %index36 = phi i32 [ %index.next38, %vec.epilog.vector.body ], [ %n.vec, %vec.epilog.vector.body.preheader ]
  %35 = add nsw i32 %index36, %mul.us
  %36 = getelementptr inbounds i32, ptr %src, i32 %35
  %wide.load37 = load <8 x i32>, ptr %36, align 4, !tbaa !3, !alias.scope !19
  %37 = getelementptr inbounds i32, ptr %dst, i32 %35
  store <8 x i32> %wide.load37, ptr %37, align 4, !tbaa !3, !alias.scope !22, !noalias !19
  %index.next38 = add nuw i32 %index36, 8
  %38 = icmp eq i32 %index.next38, %n.vec34
  br i1 %38, label %vec.epilog.middle.block, label %vec.epilog.vector.body, !llvm.loop !24

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
  %puts = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.11)
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
  %puts25.us = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.13)
  %inc14.us = add nuw nsw i32 %i.029.us, 1
  %cmp.us = icmp slt i32 %inc14.us, %M
  br i1 %cmp.us, label %for.body5.lr.ph.us, label %for.cond.cleanup, !llvm.loop !31

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
  br i1 %cmp3.us, label %for.body5.us, label %for.cond.cleanup4.us, !llvm.loop !32

for.body5.lr.ph.us:                               ; preds = %for.body5.lr.ph.us.preheader, %for.cond.cleanup4.us
  %i.029.us = phi i32 [ %inc14.us, %for.cond.cleanup4.us ], [ 0, %for.body5.lr.ph.us.preheader ]
  %call1.us = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.4)
  %mul.us = mul nsw i32 %i.029.us, %N
  br label %for.body5.us

for.cond.cleanup:                                 ; preds = %for.cond.cleanup4, %for.cond.cleanup4.us, %entry
  %puts24 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.14)
  ret void

for.cond.cleanup4:                                ; preds = %for.cond.cleanup4.preheader, %for.cond.cleanup4
  %i.029 = phi i32 [ %inc14, %for.cond.cleanup4 ], [ 0, %for.cond.cleanup4.preheader ]
  %call1 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.4)
  %puts25 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.13)
  %inc14 = add nuw nsw i32 %i.029, 1
  %cmp = icmp slt i32 %inc14, %M
  br i1 %cmp, label %for.cond.cleanup4, label %for.cond.cleanup, !llvm.loop !31
}

; Function Attrs: nofree nounwind
define dso_local void @print_vector(ptr nocapture noundef readonly %A, i32 noundef %M) local_unnamed_addr #1 {
entry:
  %putchar = tail call i32 @putchar(i32 91)
  %cmp10 = icmp sgt i32 %M, 0
  br i1 %cmp10, label %for.body.lr.ph, label %for.cond.cleanup

for.body.lr.ph:                                   ; preds = %entry
  %sub = add nsw i32 %M, -1
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.inc, %entry
  %puts = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.14)
  ret void

for.body:                                         ; preds = %for.body.lr.ph, %for.inc
  %i.011 = phi i32 [ 0, %for.body.lr.ph ], [ %inc, %for.inc ]
  %cmp1 = icmp eq i32 %i.011, %sub
  %arrayidx = getelementptr inbounds i32, ptr %A, i32 %i.011
  %0 = load i32, ptr %arrayidx, align 4, !tbaa !3
  br i1 %cmp1, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %call2 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, i32 noundef %0)
  br label %for.inc

if.else:                                          ; preds = %for.body
  %call4 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.6, i32 noundef %0)
  br label %for.inc

for.inc:                                          ; preds = %if.then, %if.else
  %inc = add nuw nsw i32 %i.011, 1
  %cmp = icmp slt i32 %inc, %M
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !33
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @mat_reduce_cols(ptr nocapture noundef readonly %A, ptr nocapture noundef writeonly %res, i32 noundef %M, i32 noundef %N) local_unnamed_addr #2 {
entry:
  %cmp20 = icmp sgt i32 %N, 0
  br i1 %cmp20, label %for.body.lr.ph, label %for.cond.cleanup

for.body.lr.ph:                                   ; preds = %entry
  %cmp217 = icmp sgt i32 %M, 0
  br i1 %cmp217, label %for.body.lr.ph.split.us, label %for.body.lr.ph.split

for.body.lr.ph.split.us:                          ; preds = %for.body.lr.ph
  %min.iters.check28 = icmp eq i32 %M, 1
  %n.vec31 = and i32 %M, -2
  br i1 %min.iters.check28, label %for.body4.lr.ph.us.us.preheader, label %for.body.lr.ph.split.us.split

for.body4.lr.ph.us.us.preheader:                  ; preds = %for.body.lr.ph.split.us
  br label %for.cond.cleanup3.us.loopexit.us

for.cond.cleanup3.us.loopexit.us:                 ; preds = %for.cond.cleanup3.us.loopexit.us, %for.body4.lr.ph.us.us.preheader
  %j.021.us.us = phi i32 [ %inc8.us.us, %for.cond.cleanup3.us.loopexit.us ], [ 0, %for.body4.lr.ph.us.us.preheader ]
  %arrayidx.us.us.phi.trans.insert = getelementptr inbounds i32, ptr %A, i32 %j.021.us.us
  %.pre = load i32, ptr %arrayidx.us.us.phi.trans.insert, align 4, !tbaa !3
  %arrayidx6.us.us = getelementptr inbounds i32, ptr %res, i32 %j.021.us.us
  store i32 %.pre, ptr %arrayidx6.us.us, align 4, !tbaa !3
  %inc8.us.us = add nuw nsw i32 %j.021.us.us, 1
  %cmp.us.us = icmp slt i32 %inc8.us.us, %N
  br i1 %cmp.us.us, label %for.cond.cleanup3.us.loopexit.us, label %for.cond.cleanup, !llvm.loop !34

for.body.lr.ph.split.us.split:                    ; preds = %for.body.lr.ph.split.us
  %cmp.n33 = icmp eq i32 %n.vec31, %M
  br i1 %cmp.n33, label %for.body4.lr.ph.us.us40.preheader, label %for.body4.lr.ph.us.preheader

for.body4.lr.ph.us.preheader:                     ; preds = %for.body.lr.ph.split.us.split
  br label %for.body4.lr.ph.us

for.body4.lr.ph.us.us40.preheader:                ; preds = %for.body.lr.ph.split.us.split
  br label %for.body4.lr.ph.us.us40

for.body4.lr.ph.us.us40:                          ; preds = %for.body4.lr.ph.us.us40.preheader, %middle.block26.us
  %j.021.us.us41 = phi i32 [ %inc8.us.us45, %middle.block26.us ], [ 0, %for.body4.lr.ph.us.us40.preheader ]
  br label %vector.body34.us

middle.block26.us:                                ; preds = %vector.body34.us
  %bin.rdx.us = add i32 %10, %9
  %arrayidx6.us.us44 = getelementptr inbounds i32, ptr %res, i32 %j.021.us.us41
  store i32 %bin.rdx.us, ptr %arrayidx6.us.us44, align 4, !tbaa !3
  %inc8.us.us45 = add nuw nsw i32 %j.021.us.us41, 1
  %cmp.us.us46 = icmp slt i32 %inc8.us.us45, %N
  br i1 %cmp.us.us46, label %for.body4.lr.ph.us.us40, label %for.cond.cleanup, !llvm.loop !34

vector.body34.us:                                 ; preds = %vector.body34.us, %for.body4.lr.ph.us.us40
  %index35.us = phi i32 [ 0, %for.body4.lr.ph.us.us40 ], [ %index.next37.us, %vector.body34.us ]
  %vec.phi.us = phi i32 [ 0, %for.body4.lr.ph.us.us40 ], [ %9, %vector.body34.us ]
  %vec.phi36.us = phi i32 [ 0, %for.body4.lr.ph.us.us40 ], [ %10, %vector.body34.us ]
  %0 = add nuw nsw i32 %index35.us, 1
  %1 = mul nsw i32 %index35.us, %N
  %2 = mul nsw i32 %0, %N
  %3 = add nsw i32 %1, %j.021.us.us41
  %4 = add nsw i32 %2, %j.021.us.us41
  %5 = getelementptr inbounds i32, ptr %A, i32 %3
  %6 = getelementptr inbounds i32, ptr %A, i32 %4
  %7 = load i32, ptr %5, align 4, !tbaa !3
  %8 = load i32, ptr %6, align 4, !tbaa !3
  %9 = add i32 %7, %vec.phi.us
  %10 = add i32 %8, %vec.phi36.us
  %index.next37.us = add nuw i32 %index35.us, 2
  %11 = icmp eq i32 %index.next37.us, %M
  br i1 %11, label %middle.block26.us, label %vector.body34.us, !llvm.loop !39

for.cond.cleanup3.us:                             ; preds = %for.body4.us
  %arrayidx6.us = getelementptr inbounds i32, ptr %res, i32 %j.021.us
  store i32 %add5.us, ptr %arrayidx6.us, align 4, !tbaa !3
  %inc8.us = add nuw nsw i32 %j.021.us, 1
  %cmp.us = icmp slt i32 %inc8.us, %N
  br i1 %cmp.us, label %for.body4.lr.ph.us, label %for.cond.cleanup, !llvm.loop !34

for.body4.us:                                     ; preds = %middle.block26, %for.body4.us
  %i.019.us = phi i32 [ %n.vec31, %middle.block26 ], [ %inc.us, %for.body4.us ]
  %acc.018.us = phi i32 [ %bin.rdx, %middle.block26 ], [ %add5.us, %for.body4.us ]
  %mul.us = mul nsw i32 %i.019.us, %N
  %add.us = add nsw i32 %mul.us, %j.021.us
  %arrayidx.us = getelementptr inbounds i32, ptr %A, i32 %add.us
  %12 = load i32, ptr %arrayidx.us, align 4, !tbaa !3
  %add5.us = add nsw i32 %12, %acc.018.us
  %inc.us = add nuw nsw i32 %i.019.us, 1
  %cmp2.us = icmp slt i32 %inc.us, %M
  br i1 %cmp2.us, label %for.body4.us, label %for.cond.cleanup3.us, !llvm.loop !41

for.body4.lr.ph.us:                               ; preds = %for.body4.lr.ph.us.preheader, %for.cond.cleanup3.us
  %j.021.us = phi i32 [ %inc8.us, %for.cond.cleanup3.us ], [ 0, %for.body4.lr.ph.us.preheader ]
  br label %vector.body34

vector.body34:                                    ; preds = %vector.body34, %for.body4.lr.ph.us
  %index35 = phi i32 [ 0, %for.body4.lr.ph.us ], [ %index.next37, %vector.body34 ]
  %vec.phi = phi i32 [ 0, %for.body4.lr.ph.us ], [ %22, %vector.body34 ]
  %vec.phi36 = phi i32 [ 0, %for.body4.lr.ph.us ], [ %23, %vector.body34 ]
  %13 = add nuw nsw i32 %index35, 1
  %14 = mul nsw i32 %index35, %N
  %15 = mul nsw i32 %13, %N
  %16 = add nsw i32 %14, %j.021.us
  %17 = add nsw i32 %15, %j.021.us
  %18 = getelementptr inbounds i32, ptr %A, i32 %16
  %19 = getelementptr inbounds i32, ptr %A, i32 %17
  %20 = load i32, ptr %18, align 4, !tbaa !3
  %21 = load i32, ptr %19, align 4, !tbaa !3
  %22 = add i32 %20, %vec.phi
  %23 = add i32 %21, %vec.phi36
  %index.next37 = add nuw i32 %index35, 2
  %24 = icmp eq i32 %index.next37, %n.vec31
  br i1 %24, label %middle.block26, label %vector.body34, !llvm.loop !39

middle.block26:                                   ; preds = %vector.body34
  %bin.rdx = add i32 %23, %22
  br label %for.body4.us

for.body.lr.ph.split:                             ; preds = %for.body.lr.ph
  %min.iters.check = icmp ult i32 %N, 4
  br i1 %min.iters.check, label %for.cond.cleanup3.preheader, label %vector.ph

vector.ph:                                        ; preds = %for.body.lr.ph.split
  %n.vec = and i32 %N, -4
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %25 = getelementptr inbounds i32, ptr %res, i32 %index
  store <4 x i32> zeroinitializer, ptr %25, align 4, !tbaa !3
  %index.next = add nuw i32 %index, 4
  %26 = icmp eq i32 %index.next, %n.vec
  br i1 %26, label %middle.block, label %vector.body, !llvm.loop !42

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i32 %n.vec, %N
  br i1 %cmp.n, label %for.cond.cleanup, label %for.cond.cleanup3.preheader

for.cond.cleanup3.preheader:                      ; preds = %for.body.lr.ph.split, %middle.block
  %j.021.ph = phi i32 [ 0, %for.body.lr.ph.split ], [ %n.vec, %middle.block ]
  br label %for.cond.cleanup3

for.cond.cleanup:                                 ; preds = %for.cond.cleanup3, %for.cond.cleanup3.us, %middle.block26.us, %for.cond.cleanup3.us.loopexit.us, %middle.block, %entry
  ret void

for.cond.cleanup3:                                ; preds = %for.cond.cleanup3.preheader, %for.cond.cleanup3
  %j.021 = phi i32 [ %inc8, %for.cond.cleanup3 ], [ %j.021.ph, %for.cond.cleanup3.preheader ]
  %arrayidx6 = getelementptr inbounds i32, ptr %res, i32 %j.021
  store i32 0, ptr %arrayidx6, align 4, !tbaa !3
  %inc8 = add nuw nsw i32 %j.021, 1
  %cmp = icmp slt i32 %inc8, %N
  br i1 %cmp, label %for.cond.cleanup3, label %for.cond.cleanup, !llvm.loop !43
}

; Function Attrs: mustprogress nofree nosync nounwind willreturn
define dso_local void @vectorized_mat_reduce_cols(ptr addrspace(4) noalias noundef %A, ptr addrspace(4) noalias noundef %res, i32 noundef %M, i32 noundef %N) local_unnamed_addr #3 {
entry:
  %div = sdiv i32 %N, 16
  %mul = shl nsw i32 %div, 4
  %cmp56 = icmp sgt i32 %N, 15
  br i1 %cmp56, label %for.body.lr.ph, label %for.cond.cleanup

for.body.lr.ph:                                   ; preds = %entry
  %cmp253 = icmp sgt i32 %M, 0
  br i1 %cmp253, label %for.body4.lr.ph.us.preheader, label %for.cond.cleanup3.preheader

for.cond.cleanup3.preheader:                      ; preds = %for.body.lr.ph
  br label %for.cond.cleanup3

for.body4.lr.ph.us.preheader:                     ; preds = %for.body.lr.ph
  br label %for.body4.lr.ph.us

for.cond.cleanup3.us:                             ; preds = %for.body4.us
  %arrayidx7.us = getelementptr inbounds i32, ptr addrspace(4) %res, i32 %j_vec.057.us
  tail call void @llvm.arc.vvst.w.v512(<16 x i32> %1, ptr addrspace(4) %arrayidx7.us)
  %add9.us = add nuw nsw i32 %j_vec.057.us, 16
  %cmp.us = icmp slt i32 %add9.us, %mul
  br i1 %cmp.us, label %for.body4.lr.ph.us, label %for.cond.cleanup, !llvm.loop !44

for.body4.us:                                     ; preds = %for.body4.lr.ph.us, %for.body4.us
  %i.055.us = phi i32 [ 0, %for.body4.lr.ph.us ], [ %inc.us, %for.body4.us ]
  %acc.054.us = phi <16 x i32> [ zeroinitializer, %for.body4.lr.ph.us ], [ %1, %for.body4.us ]
  %mul5.us = mul nsw i32 %i.055.us, %N
  %add.us = add nsw i32 %mul5.us, %j_vec.057.us
  %arrayidx.us = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %add.us
  %0 = tail call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %arrayidx.us)
  %1 = tail call <16 x i32> @llvm.arc.vvadd.w.v512(<16 x i32> %acc.054.us, <16 x i32> %0)
  %inc.us = add nuw nsw i32 %i.055.us, 1
  %cmp2.us = icmp slt i32 %inc.us, %M
  br i1 %cmp2.us, label %for.body4.us, label %for.cond.cleanup3.us, !llvm.loop !45

for.body4.lr.ph.us:                               ; preds = %for.body4.lr.ph.us.preheader, %for.cond.cleanup3.us
  %j_vec.057.us = phi i32 [ %add9.us, %for.cond.cleanup3.us ], [ 0, %for.body4.lr.ph.us.preheader ]
  br label %for.body4.us

for.cond.cleanup:                                 ; preds = %for.cond.cleanup3, %for.cond.cleanup3.us, %entry
  %cmp1261 = icmp slt i32 %mul, %N
  br i1 %cmp1261, label %for.body14.lr.ph, label %for.cond.cleanup13

for.body14.lr.ph:                                 ; preds = %for.cond.cleanup
  %cmp1858 = icmp sgt i32 %M, 0
  br i1 %cmp1858, label %for.body14.lr.ph.split.us, label %iter.check

for.body14.lr.ph.split.us:                        ; preds = %for.body14.lr.ph
  %min.iters.check81 = icmp ult i32 %M, 8
  %ident.check.not = icmp eq i32 %N, 1
  %min.iters.check84 = icmp ult i32 %M, 64
  %n.vec88 = and i32 %M, -64
  %cmp.n89 = icmp eq i32 %n.vec88, %M
  %n.vec.remaining105 = and i32 %M, 56
  %min.epilog.iters.check106 = icmp eq i32 %n.vec.remaining105, 0
  %n.vec109 = and i32 %M, -8
  %cmp.n111 = icmp eq i32 %n.vec109, %M
  br i1 %min.iters.check81, label %iter.check83.us.preheader, label %iter.check83.preheader

iter.check83.preheader:                           ; preds = %for.body14.lr.ph.split.us
  br label %iter.check83

iter.check83.us.preheader:                        ; preds = %for.body14.lr.ph.split.us
  br label %iter.check83.us

iter.check83.us:                                  ; preds = %iter.check83.us.preheader, %for.cond.cleanup19.us.us
  %j.062.us.us = phi i32 [ %inc30.us.us, %for.cond.cleanup19.us.us ], [ %mul, %iter.check83.us.preheader ]
  br label %for.body20.us.us

for.body20.us.us:                                 ; preds = %for.body20.us.us, %iter.check83.us
  %i16.060.us.us = phi i32 [ 0, %iter.check83.us ], [ %inc26.us.us, %for.body20.us.us ]
  %acc15.059.us.us = phi i32 [ 0, %iter.check83.us ], [ %add24.us.us, %for.body20.us.us ]
  %mul21.us.us = mul nsw i32 %i16.060.us.us, %N
  %add22.us.us = add nsw i32 %mul21.us.us, %j.062.us.us
  %arrayidx23.us.us = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %add22.us.us
  %2 = load i32, ptr addrspace(4) %arrayidx23.us.us, align 4, !tbaa !3
  %add24.us.us = add nsw i32 %2, %acc15.059.us.us
  %inc26.us.us = add nuw nsw i32 %i16.060.us.us, 1
  %cmp18.us.us = icmp slt i32 %inc26.us.us, %M
  br i1 %cmp18.us.us, label %for.body20.us.us, label %for.cond.cleanup19.us.us, !llvm.loop !46

for.cond.cleanup19.us.us:                         ; preds = %for.body20.us.us
  %arrayidx28.us.us = getelementptr inbounds i32, ptr addrspace(4) %res, i32 %j.062.us.us
  store i32 %add24.us.us, ptr addrspace(4) %arrayidx28.us.us, align 4, !tbaa !3
  %inc30.us.us = add nsw i32 %j.062.us.us, 1
  %cmp12.us.us = icmp slt i32 %inc30.us.us, %N
  br i1 %cmp12.us.us, label %iter.check83.us, label %for.cond.cleanup13, !llvm.loop !47

for.cond.cleanup19.us:                            ; preds = %for.body20.us, %vec.epilog.middle.block101, %middle.block80
  %add24.us.lcssa = phi i32 [ %14, %middle.block80 ], [ %20, %vec.epilog.middle.block101 ], [ %add24.us, %for.body20.us ]
  %arrayidx28.us = getelementptr inbounds i32, ptr addrspace(4) %res, i32 %j.062.us
  store i32 %add24.us.lcssa, ptr addrspace(4) %arrayidx28.us, align 4, !tbaa !3
  %inc30.us = add nsw i32 %j.062.us, 1
  %cmp12.us = icmp slt i32 %inc30.us, %N
  br i1 %cmp12.us, label %iter.check83, label %for.cond.cleanup13, !llvm.loop !47

for.body20.us:                                    ; preds = %for.body20.us.preheader, %for.body20.us
  %i16.060.us = phi i32 [ %inc26.us, %for.body20.us ], [ %i16.060.us.ph, %for.body20.us.preheader ]
  %acc15.059.us = phi i32 [ %add24.us, %for.body20.us ], [ %acc15.059.us.ph, %for.body20.us.preheader ]
  %mul21.us = mul nsw i32 %i16.060.us, %N
  %add22.us = add nsw i32 %mul21.us, %j.062.us
  %arrayidx23.us = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %add22.us
  %3 = load i32, ptr addrspace(4) %arrayidx23.us, align 4, !tbaa !3
  %add24.us = add nsw i32 %3, %acc15.059.us
  %inc26.us = add nuw nsw i32 %i16.060.us, 1
  %cmp18.us = icmp slt i32 %inc26.us, %M
  br i1 %cmp18.us, label %for.body20.us, label %for.cond.cleanup19.us, !llvm.loop !46

iter.check83:                                     ; preds = %iter.check83.preheader, %for.cond.cleanup19.us
  %j.062.us = phi i32 [ %inc30.us, %for.cond.cleanup19.us ], [ %mul, %iter.check83.preheader ]
  br i1 %ident.check.not, label %vector.main.loop.iter.check85, label %for.body20.us.preheader

vector.main.loop.iter.check85:                    ; preds = %iter.check83
  br i1 %min.iters.check84, label %vec.epilog.ph104, label %vector.body90.preheader

vector.body90.preheader:                          ; preds = %vector.main.loop.iter.check85
  br label %vector.body90

vector.body90:                                    ; preds = %vector.body90.preheader, %vector.body90
  %index91 = phi i32 [ %index.next98, %vector.body90 ], [ 0, %vector.body90.preheader ]
  %vec.phi = phi <16 x i32> [ %9, %vector.body90 ], [ zeroinitializer, %vector.body90.preheader ]
  %vec.phi92 = phi <16 x i32> [ %10, %vector.body90 ], [ zeroinitializer, %vector.body90.preheader ]
  %vec.phi93 = phi <16 x i32> [ %11, %vector.body90 ], [ zeroinitializer, %vector.body90.preheader ]
  %vec.phi94 = phi <16 x i32> [ %12, %vector.body90 ], [ zeroinitializer, %vector.body90.preheader ]
  %4 = add nsw i32 %index91, %j.062.us
  %5 = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %4
  %wide.load = load <16 x i32>, ptr addrspace(4) %5, align 4, !tbaa !3
  %6 = getelementptr inbounds i32, ptr addrspace(4) %5, i32 16
  %wide.load95 = load <16 x i32>, ptr addrspace(4) %6, align 4, !tbaa !3
  %7 = getelementptr inbounds i32, ptr addrspace(4) %5, i32 32
  %wide.load96 = load <16 x i32>, ptr addrspace(4) %7, align 4, !tbaa !3
  %8 = getelementptr inbounds i32, ptr addrspace(4) %5, i32 48
  %wide.load97 = load <16 x i32>, ptr addrspace(4) %8, align 4, !tbaa !3
  %9 = add <16 x i32> %wide.load, %vec.phi
  %10 = add <16 x i32> %wide.load95, %vec.phi92
  %11 = add <16 x i32> %wide.load96, %vec.phi93
  %12 = add <16 x i32> %wide.load97, %vec.phi94
  %index.next98 = add nuw i32 %index91, 64
  %13 = icmp eq i32 %index.next98, %n.vec88
  br i1 %13, label %middle.block80, label %vector.body90, !llvm.loop !48

middle.block80:                                   ; preds = %vector.body90
  %bin.rdx = add <16 x i32> %10, %9
  %bin.rdx99 = add <16 x i32> %11, %bin.rdx
  %bin.rdx100 = add <16 x i32> %12, %bin.rdx99
  %14 = tail call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %bin.rdx100)
  br i1 %cmp.n89, label %for.cond.cleanup19.us, label %vec.epilog.iter.check103

vec.epilog.iter.check103:                         ; preds = %middle.block80
  br i1 %min.epilog.iters.check106, label %for.body20.us.preheader, label %vec.epilog.ph104

vec.epilog.ph104:                                 ; preds = %vector.main.loop.iter.check85, %vec.epilog.iter.check103
  %bc.merge.rdx = phi i32 [ 0, %vector.main.loop.iter.check85 ], [ %14, %vec.epilog.iter.check103 ]
  %vec.epilog.resume.val107 = phi i32 [ 0, %vector.main.loop.iter.check85 ], [ %n.vec88, %vec.epilog.iter.check103 ]
  %15 = insertelement <8 x i32> <i32 poison, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, i32 %bc.merge.rdx, i64 0
  br label %vec.epilog.vector.body112

vec.epilog.vector.body112:                        ; preds = %vec.epilog.vector.body112, %vec.epilog.ph104
  %index113 = phi i32 [ %vec.epilog.resume.val107, %vec.epilog.ph104 ], [ %index.next116, %vec.epilog.vector.body112 ]
  %vec.phi114 = phi <8 x i32> [ %15, %vec.epilog.ph104 ], [ %18, %vec.epilog.vector.body112 ]
  %16 = add nsw i32 %index113, %j.062.us
  %17 = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %16
  %wide.load115 = load <8 x i32>, ptr addrspace(4) %17, align 4, !tbaa !3
  %18 = add <8 x i32> %wide.load115, %vec.phi114
  %index.next116 = add nuw i32 %index113, 8
  %19 = icmp eq i32 %index.next116, %n.vec109
  br i1 %19, label %vec.epilog.middle.block101, label %vec.epilog.vector.body112, !llvm.loop !49

vec.epilog.middle.block101:                       ; preds = %vec.epilog.vector.body112
  %20 = tail call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %18)
  br i1 %cmp.n111, label %for.cond.cleanup19.us, label %for.body20.us.preheader

for.body20.us.preheader:                          ; preds = %iter.check83, %vec.epilog.iter.check103, %vec.epilog.middle.block101
  %i16.060.us.ph = phi i32 [ 0, %iter.check83 ], [ %n.vec88, %vec.epilog.iter.check103 ], [ %n.vec109, %vec.epilog.middle.block101 ]
  %acc15.059.us.ph = phi i32 [ 0, %iter.check83 ], [ %14, %vec.epilog.iter.check103 ], [ %20, %vec.epilog.middle.block101 ]
  br label %for.body20.us

iter.check:                                       ; preds = %for.body14.lr.ph
  %21 = sub i32 %N, %mul
  %min.iters.check = icmp ult i32 %21, 8
  br i1 %min.iters.check, label %for.cond.cleanup19.preheader, label %vector.main.loop.iter.check

vector.main.loop.iter.check:                      ; preds = %iter.check
  %min.iters.check72 = icmp ult i32 %21, 64
  br i1 %min.iters.check72, label %vec.epilog.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.main.loop.iter.check
  %n.vec = and i32 %21, -64
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %offset.idx = add i32 %mul, %index
  %22 = getelementptr inbounds i32, ptr addrspace(4) %res, i32 %offset.idx
  store <16 x i32> zeroinitializer, ptr addrspace(4) %22, align 4, !tbaa !3
  %23 = getelementptr inbounds i32, ptr addrspace(4) %22, i32 16
  store <16 x i32> zeroinitializer, ptr addrspace(4) %23, align 4, !tbaa !3
  %24 = getelementptr inbounds i32, ptr addrspace(4) %22, i32 32
  store <16 x i32> zeroinitializer, ptr addrspace(4) %24, align 4, !tbaa !3
  %25 = getelementptr inbounds i32, ptr addrspace(4) %22, i32 48
  store <16 x i32> zeroinitializer, ptr addrspace(4) %25, align 4, !tbaa !3
  %index.next = add nuw i32 %index, 64
  %26 = icmp eq i32 %index.next, %n.vec
  br i1 %26, label %middle.block, label %vector.body, !llvm.loop !50

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i32 %21, %n.vec
  br i1 %cmp.n, label %for.cond.cleanup13, label %vec.epilog.iter.check

vec.epilog.iter.check:                            ; preds = %middle.block
  %ind.end75 = add i32 %mul, %n.vec
  %n.vec.remaining = and i32 %21, 56
  %min.epilog.iters.check = icmp eq i32 %n.vec.remaining, 0
  br i1 %min.epilog.iters.check, label %for.cond.cleanup19.preheader, label %vec.epilog.ph

vec.epilog.ph:                                    ; preds = %vector.main.loop.iter.check, %vec.epilog.iter.check
  %vec.epilog.resume.val = phi i32 [ %n.vec, %vec.epilog.iter.check ], [ 0, %vector.main.loop.iter.check ]
  %n.mod.vf73 = and i32 %N, 7
  %n.vec74 = sub nuw i32 %21, %n.mod.vf73
  %ind.end = add i32 %mul, %n.vec74
  br label %vec.epilog.vector.body

vec.epilog.vector.body:                           ; preds = %vec.epilog.vector.body, %vec.epilog.ph
  %index77 = phi i32 [ %vec.epilog.resume.val, %vec.epilog.ph ], [ %index.next79, %vec.epilog.vector.body ]
  %offset.idx78 = add i32 %mul, %index77
  %27 = getelementptr inbounds i32, ptr addrspace(4) %res, i32 %offset.idx78
  store <8 x i32> zeroinitializer, ptr addrspace(4) %27, align 4, !tbaa !3
  %index.next79 = add nuw i32 %index77, 8
  %28 = icmp eq i32 %index.next79, %n.vec74
  br i1 %28, label %vec.epilog.middle.block, label %vec.epilog.vector.body, !llvm.loop !51

vec.epilog.middle.block:                          ; preds = %vec.epilog.vector.body
  %cmp.n76 = icmp eq i32 %n.mod.vf73, 0
  br i1 %cmp.n76, label %for.cond.cleanup13, label %for.cond.cleanup19.preheader

for.cond.cleanup19.preheader:                     ; preds = %iter.check, %vec.epilog.iter.check, %vec.epilog.middle.block
  %j.062.ph = phi i32 [ %mul, %iter.check ], [ %ind.end75, %vec.epilog.iter.check ], [ %ind.end, %vec.epilog.middle.block ]
  br label %for.cond.cleanup19

for.cond.cleanup3:                                ; preds = %for.cond.cleanup3.preheader, %for.cond.cleanup3
  %j_vec.057 = phi i32 [ %add9, %for.cond.cleanup3 ], [ 0, %for.cond.cleanup3.preheader ]
  %arrayidx7 = getelementptr inbounds i32, ptr addrspace(4) %res, i32 %j_vec.057
  tail call void @llvm.arc.vvst.w.v512(<16 x i32> zeroinitializer, ptr addrspace(4) %arrayidx7)
  %add9 = add nuw nsw i32 %j_vec.057, 16
  %cmp = icmp slt i32 %add9, %mul
  br i1 %cmp, label %for.cond.cleanup3, label %for.cond.cleanup, !llvm.loop !44

for.cond.cleanup13:                               ; preds = %for.cond.cleanup19, %for.cond.cleanup19.us, %for.cond.cleanup19.us.us, %middle.block, %vec.epilog.middle.block, %for.cond.cleanup
  ret void

for.cond.cleanup19:                               ; preds = %for.cond.cleanup19.preheader, %for.cond.cleanup19
  %j.062 = phi i32 [ %inc30, %for.cond.cleanup19 ], [ %j.062.ph, %for.cond.cleanup19.preheader ]
  %arrayidx28 = getelementptr inbounds i32, ptr addrspace(4) %res, i32 %j.062
  store i32 0, ptr addrspace(4) %arrayidx28, align 4, !tbaa !3
  %inc30 = add nsw i32 %j.062, 1
  %cmp12 = icmp slt i32 %inc30, %N
  br i1 %cmp12, label %for.cond.cleanup19, label %for.cond.cleanup13, !llvm.loop !52
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @autovectorized_mat_reduce_cols(ptr addrspace(4) noalias nocapture noundef readonly %A, ptr addrspace(4) noalias nocapture noundef writeonly %res, i32 noundef %M, i32 noundef %N) local_unnamed_addr #2 {
entry:
  %cmp20 = icmp sgt i32 %N, 0
  br i1 %cmp20, label %for.body.lr.ph, label %for.cond.cleanup

for.body.lr.ph:                                   ; preds = %entry
  %cmp217 = icmp sgt i32 %M, 0
  br i1 %cmp217, label %for.body.lr.ph.split.us, label %iter.check

for.body.lr.ph.split.us:                          ; preds = %for.body.lr.ph
  %min.iters.check33 = icmp ult i32 %M, 8
  %min.iters.check36 = icmp ult i32 %M, 64
  %n.vec40 = and i32 %M, -64
  %cmp.n41 = icmp eq i32 %n.vec40, %M
  %n.vec.remaining57 = and i32 %M, 56
  %min.epilog.iters.check58 = icmp eq i32 %n.vec.remaining57, 0
  %n.vec61 = and i32 %M, -8
  %cmp.n63 = icmp eq i32 %n.vec61, %M
  br i1 %min.iters.check33, label %iter.check35.us.preheader, label %for.body.lr.ph.split.us.split

iter.check35.us.preheader:                        ; preds = %for.body.lr.ph.split.us
  br label %iter.check35.us

iter.check35.us:                                  ; preds = %iter.check35.us.preheader, %for.cond.cleanup3.us.loopexit.us
  %j.021.us.us = phi i32 [ %inc8.us.us, %for.cond.cleanup3.us.loopexit.us ], [ 0, %iter.check35.us.preheader ]
  br label %for.body4.us.us

for.body4.us.us:                                  ; preds = %iter.check35.us, %for.body4.us.us
  %i.019.us.us = phi i32 [ 0, %iter.check35.us ], [ %inc.us.us, %for.body4.us.us ]
  %acc.018.us.us = phi i32 [ 0, %iter.check35.us ], [ %add5.us.us, %for.body4.us.us ]
  %mul.us.us = mul nsw i32 %i.019.us.us, %N
  %add.us.us = add nsw i32 %mul.us.us, %j.021.us.us
  %arrayidx.us.us = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %add.us.us
  %0 = load i32, ptr addrspace(4) %arrayidx.us.us, align 4, !tbaa !3
  %add5.us.us = add nsw i32 %0, %acc.018.us.us
  %inc.us.us = add nuw nsw i32 %i.019.us.us, 1
  %cmp2.us.us = icmp slt i32 %inc.us.us, %M
  br i1 %cmp2.us.us, label %for.body4.us.us, label %for.cond.cleanup3.us.loopexit.us, !llvm.loop !53

for.cond.cleanup3.us.loopexit.us:                 ; preds = %for.body4.us.us
  %arrayidx6.us.us = getelementptr inbounds i32, ptr addrspace(4) %res, i32 %j.021.us.us
  store i32 %add5.us.us, ptr addrspace(4) %arrayidx6.us.us, align 4, !tbaa !3
  %inc8.us.us = add nuw nsw i32 %j.021.us.us, 1
  %cmp.us.us = icmp slt i32 %inc8.us.us, %N
  br i1 %cmp.us.us, label %iter.check35.us, label %for.cond.cleanup, !llvm.loop !54

for.body.lr.ph.split.us.split:                    ; preds = %for.body.lr.ph.split.us
  %ident.check.not = icmp eq i32 %N, 1
  br i1 %ident.check.not, label %iter.check35.us75, label %iter.check35.preheader

iter.check35.preheader:                           ; preds = %for.body.lr.ph.split.us.split
  br label %iter.check35

iter.check35.us75:                                ; preds = %for.body.lr.ph.split.us.split
  br i1 %min.iters.check36, label %vec.epilog.ph56.us, label %vector.body42.us.preheader

vector.body42.us.preheader:                       ; preds = %iter.check35.us75
  br label %vector.body42.us

for.body4.us.us77:                                ; preds = %for.body4.us.us77.preheader, %for.body4.us.us77
  %i.019.us.us78 = phi i32 [ %inc.us.us84, %for.body4.us.us77 ], [ %i.019.us.us78.ph, %for.body4.us.us77.preheader ]
  %acc.018.us.us79 = phi i32 [ %add5.us.us83, %for.body4.us.us77 ], [ %acc.018.us.us79.ph, %for.body4.us.us77.preheader ]
  %arrayidx.us.us82 = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %i.019.us.us78
  %1 = load i32, ptr addrspace(4) %arrayidx.us.us82, align 4, !tbaa !3
  %add5.us.us83 = add nsw i32 %1, %acc.018.us.us79
  %inc.us.us84 = add nuw nsw i32 %i.019.us.us78, 1
  %cmp2.us.us85 = icmp slt i32 %inc.us.us84, %M
  br i1 %cmp2.us.us85, label %for.body4.us.us77, label %for.cond.cleanup.loopexit113, !llvm.loop !53

middle.block32.us:                                ; preds = %vector.body42.us
  %bin.rdx.us = add <16 x i32> %8, %7
  %bin.rdx51.us = add <16 x i32> %9, %bin.rdx.us
  %bin.rdx52.us = add <16 x i32> %10, %bin.rdx51.us
  %2 = tail call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %bin.rdx52.us)
  br i1 %cmp.n41, label %for.cond.cleanup.loopexit113, label %vec.epilog.iter.check55.us

vec.epilog.iter.check55.us:                       ; preds = %middle.block32.us
  br i1 %min.epilog.iters.check58, label %for.body4.us.us77.preheader, label %vec.epilog.ph56.us

for.body4.us.us77.preheader:                      ; preds = %vec.epilog.middle.block53.us, %vec.epilog.iter.check55.us
  %i.019.us.us78.ph = phi i32 [ %n.vec40, %vec.epilog.iter.check55.us ], [ %n.vec61, %vec.epilog.middle.block53.us ]
  %acc.018.us.us79.ph = phi i32 [ %2, %vec.epilog.iter.check55.us ], [ %12, %vec.epilog.middle.block53.us ]
  br label %for.body4.us.us77

vector.body42.us:                                 ; preds = %vector.body42.us.preheader, %vector.body42.us
  %index43.us = phi i32 [ %index.next50.us, %vector.body42.us ], [ 0, %vector.body42.us.preheader ]
  %vec.phi.us = phi <16 x i32> [ %7, %vector.body42.us ], [ zeroinitializer, %vector.body42.us.preheader ]
  %vec.phi44.us = phi <16 x i32> [ %8, %vector.body42.us ], [ zeroinitializer, %vector.body42.us.preheader ]
  %vec.phi45.us = phi <16 x i32> [ %9, %vector.body42.us ], [ zeroinitializer, %vector.body42.us.preheader ]
  %vec.phi46.us = phi <16 x i32> [ %10, %vector.body42.us ], [ zeroinitializer, %vector.body42.us.preheader ]
  %3 = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %index43.us
  %wide.load.us = load <16 x i32>, ptr addrspace(4) %3, align 4, !tbaa !3
  %4 = getelementptr inbounds i32, ptr addrspace(4) %3, i32 16
  %wide.load47.us = load <16 x i32>, ptr addrspace(4) %4, align 4, !tbaa !3
  %5 = getelementptr inbounds i32, ptr addrspace(4) %3, i32 32
  %wide.load48.us = load <16 x i32>, ptr addrspace(4) %5, align 4, !tbaa !3
  %6 = getelementptr inbounds i32, ptr addrspace(4) %3, i32 48
  %wide.load49.us = load <16 x i32>, ptr addrspace(4) %6, align 4, !tbaa !3
  %7 = add <16 x i32> %wide.load.us, %vec.phi.us
  %8 = add <16 x i32> %wide.load47.us, %vec.phi44.us
  %9 = add <16 x i32> %wide.load48.us, %vec.phi45.us
  %10 = add <16 x i32> %wide.load49.us, %vec.phi46.us
  %index.next50.us = add nuw i32 %index43.us, 64
  %11 = icmp eq i32 %index.next50.us, %n.vec40
  br i1 %11, label %middle.block32.us, label %vector.body42.us, !llvm.loop !55

vec.epilog.middle.block53.us:                     ; preds = %vec.epilog.vector.body64.us
  %12 = tail call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %15)
  br i1 %cmp.n63, label %for.cond.cleanup.loopexit113, label %for.body4.us.us77.preheader

vec.epilog.ph56.us:                               ; preds = %iter.check35.us75, %vec.epilog.iter.check55.us
  %bc.merge.rdx.us = phi i32 [ 0, %iter.check35.us75 ], [ %2, %vec.epilog.iter.check55.us ]
  %vec.epilog.resume.val59.us = phi i32 [ 0, %iter.check35.us75 ], [ %n.vec40, %vec.epilog.iter.check55.us ]
  %13 = insertelement <8 x i32> <i32 poison, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, i32 %bc.merge.rdx.us, i64 0
  br label %vec.epilog.vector.body64.us

vec.epilog.vector.body64.us:                      ; preds = %vec.epilog.vector.body64.us, %vec.epilog.ph56.us
  %index65.us = phi i32 [ %vec.epilog.resume.val59.us, %vec.epilog.ph56.us ], [ %index.next68.us, %vec.epilog.vector.body64.us ]
  %vec.phi66.us = phi <8 x i32> [ %13, %vec.epilog.ph56.us ], [ %15, %vec.epilog.vector.body64.us ]
  %14 = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %index65.us
  %wide.load67.us = load <8 x i32>, ptr addrspace(4) %14, align 4, !tbaa !3
  %15 = add <8 x i32> %wide.load67.us, %vec.phi66.us
  %index.next68.us = add nuw i32 %index65.us, 8
  %16 = icmp eq i32 %index.next68.us, %n.vec61
  br i1 %16, label %vec.epilog.middle.block53.us, label %vec.epilog.vector.body64.us, !llvm.loop !56

for.cond.cleanup3.us:                             ; preds = %for.body4.us
  %arrayidx6.us = getelementptr inbounds i32, ptr addrspace(4) %res, i32 %j.021.us
  store i32 %add5.us, ptr addrspace(4) %arrayidx6.us, align 4, !tbaa !3
  %inc8.us = add nuw nsw i32 %j.021.us, 1
  %cmp.us = icmp slt i32 %inc8.us, %N
  br i1 %cmp.us, label %iter.check35, label %for.cond.cleanup, !llvm.loop !54

for.body4.us:                                     ; preds = %iter.check35, %for.body4.us
  %i.019.us = phi i32 [ 0, %iter.check35 ], [ %inc.us, %for.body4.us ]
  %acc.018.us = phi i32 [ 0, %iter.check35 ], [ %add5.us, %for.body4.us ]
  %mul.us = mul nsw i32 %i.019.us, %N
  %add.us = add nsw i32 %mul.us, %j.021.us
  %arrayidx.us = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %add.us
  %17 = load i32, ptr addrspace(4) %arrayidx.us, align 4, !tbaa !3
  %add5.us = add nsw i32 %17, %acc.018.us
  %inc.us = add nuw nsw i32 %i.019.us, 1
  %cmp2.us = icmp slt i32 %inc.us, %M
  br i1 %cmp2.us, label %for.body4.us, label %for.cond.cleanup3.us, !llvm.loop !53

iter.check35:                                     ; preds = %iter.check35.preheader, %for.cond.cleanup3.us
  %j.021.us = phi i32 [ %inc8.us, %for.cond.cleanup3.us ], [ 0, %iter.check35.preheader ]
  br label %for.body4.us

iter.check:                                       ; preds = %for.body.lr.ph
  %min.iters.check = icmp ult i32 %N, 8
  br i1 %min.iters.check, label %for.cond.cleanup3.preheader, label %vector.main.loop.iter.check

vector.main.loop.iter.check:                      ; preds = %iter.check
  %min.iters.check26 = icmp ult i32 %N, 64
  br i1 %min.iters.check26, label %vec.epilog.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.main.loop.iter.check
  %n.vec = and i32 %N, -64
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %18 = getelementptr inbounds i32, ptr addrspace(4) %res, i32 %index
  store <16 x i32> zeroinitializer, ptr addrspace(4) %18, align 4, !tbaa !3
  %19 = getelementptr inbounds i32, ptr addrspace(4) %18, i32 16
  store <16 x i32> zeroinitializer, ptr addrspace(4) %19, align 4, !tbaa !3
  %20 = getelementptr inbounds i32, ptr addrspace(4) %18, i32 32
  store <16 x i32> zeroinitializer, ptr addrspace(4) %20, align 4, !tbaa !3
  %21 = getelementptr inbounds i32, ptr addrspace(4) %18, i32 48
  store <16 x i32> zeroinitializer, ptr addrspace(4) %21, align 4, !tbaa !3
  %index.next = add nuw i32 %index, 64
  %22 = icmp eq i32 %index.next, %n.vec
  br i1 %22, label %middle.block, label %vector.body, !llvm.loop !57

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i32 %n.vec, %N
  br i1 %cmp.n, label %for.cond.cleanup, label %vec.epilog.iter.check

vec.epilog.iter.check:                            ; preds = %middle.block
  %n.vec.remaining = and i32 %N, 56
  %min.epilog.iters.check = icmp eq i32 %n.vec.remaining, 0
  br i1 %min.epilog.iters.check, label %for.cond.cleanup3.preheader, label %vec.epilog.ph

vec.epilog.ph:                                    ; preds = %vector.main.loop.iter.check, %vec.epilog.iter.check
  %vec.epilog.resume.val = phi i32 [ %n.vec, %vec.epilog.iter.check ], [ 0, %vector.main.loop.iter.check ]
  %n.vec28 = and i32 %N, -8
  br label %vec.epilog.vector.body

vec.epilog.vector.body:                           ; preds = %vec.epilog.vector.body, %vec.epilog.ph
  %index30 = phi i32 [ %vec.epilog.resume.val, %vec.epilog.ph ], [ %index.next31, %vec.epilog.vector.body ]
  %23 = getelementptr inbounds i32, ptr addrspace(4) %res, i32 %index30
  store <8 x i32> zeroinitializer, ptr addrspace(4) %23, align 4, !tbaa !3
  %index.next31 = add nuw i32 %index30, 8
  %24 = icmp eq i32 %index.next31, %n.vec28
  br i1 %24, label %vec.epilog.middle.block, label %vec.epilog.vector.body, !llvm.loop !58

vec.epilog.middle.block:                          ; preds = %vec.epilog.vector.body
  %cmp.n29 = icmp eq i32 %n.vec28, %N
  br i1 %cmp.n29, label %for.cond.cleanup, label %for.cond.cleanup3.preheader

for.cond.cleanup3.preheader:                      ; preds = %iter.check, %vec.epilog.iter.check, %vec.epilog.middle.block
  %j.021.ph = phi i32 [ 0, %iter.check ], [ %n.vec, %vec.epilog.iter.check ], [ %n.vec28, %vec.epilog.middle.block ]
  br label %for.cond.cleanup3

for.cond.cleanup.loopexit113:                     ; preds = %middle.block32.us, %vec.epilog.middle.block53.us, %for.body4.us.us77
  %add5.us.lcssa.us87 = phi i32 [ %2, %middle.block32.us ], [ %12, %vec.epilog.middle.block53.us ], [ %add5.us.us83, %for.body4.us.us77 ]
  store i32 %add5.us.lcssa.us87, ptr addrspace(4) %res, align 4, !tbaa !3
  br label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond.cleanup3, %for.cond.cleanup3.us, %for.cond.cleanup3.us.loopexit.us, %for.cond.cleanup.loopexit113, %middle.block, %vec.epilog.middle.block, %entry
  ret void

for.cond.cleanup3:                                ; preds = %for.cond.cleanup3.preheader, %for.cond.cleanup3
  %j.021 = phi i32 [ %inc8, %for.cond.cleanup3 ], [ %j.021.ph, %for.cond.cleanup3.preheader ]
  %arrayidx6 = getelementptr inbounds i32, ptr addrspace(4) %res, i32 %j.021
  store i32 0, ptr addrspace(4) %arrayidx6, align 4, !tbaa !3
  %inc8 = add nuw nsw i32 %j.021, 1
  %cmp = icmp slt i32 %inc8, %N
  br i1 %cmp, label %for.cond.cleanup3, label %for.cond.cleanup, !llvm.loop !59
}

; Function Attrs: nounwind
define dso_local void @vekt_mat_reduce_cols_wrapper(ptr noundef %A, ptr noundef %res, i32 noundef %M, i32 noundef %N) local_unnamed_addr #4 {
entry:
  tail call void @vekt_mat_reduce_cols(i32 noundef %M, i32 noundef %N, ptr noundef %A, ptr noundef %A, i32 noundef 0, i32 noundef %M, i32 noundef %N, i32 noundef %N, i32 noundef 1, ptr noundef %res, ptr noundef %res, i32 noundef 0, i32 noundef %N, i32 noundef 1) #11
  ret void
}

declare void @vekt_mat_reduce_cols(i32 noundef, i32 noundef, ptr noundef, ptr noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef, ptr noundef, ptr noundef, i32 noundef, i32 noundef, i32 noundef) local_unnamed_addr #5

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
attributes #6 = { mustprogress nocallback nofree nosync nounwind willreturn memory(read) }
attributes #7 = { mustprogress nocallback nofree nosync nounwind willreturn memory(none) }
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
!13 = distinct !{!13, !8, !9, !10}
!14 = distinct !{!14, !8, !9, !10}
!15 = distinct !{!15, !8, !10, !9}
!16 = distinct !{!16, !8}
!17 = distinct !{!17, !8, !9}
!18 = distinct !{!18, !8}
!19 = !{!20}
!20 = distinct !{!20, !21}
!21 = distinct !{!21, !"LVerDomain"}
!22 = !{!23}
!23 = distinct !{!23, !21}
!24 = distinct !{!24, !8, !9, !10}
!25 = !{!26}
!26 = distinct !{!26, !27}
!27 = distinct !{!27, !"LVerDomain"}
!28 = !{!29}
!29 = distinct !{!29, !27}
!30 = distinct !{!30, !8, !9, !10}
!31 = distinct !{!31, !8}
!32 = distinct !{!32, !8}
!33 = distinct !{!33, !8}
!34 = distinct !{!34, !8, !35, !36}
!35 = !{!"llvm.loop.vectorize.width", i32 1}
!36 = !{!"llvm.loop.vectorize.followup_all", !37}
!37 = distinct !{!37, !8, !38}
!38 = !{!"llvm.loop.isvectorized"}
!39 = distinct !{!39, !40, !10}
!40 = distinct !{!40, !8, !38}
!41 = distinct !{!41, !40}
!42 = distinct !{!42, !37, !10}
!43 = distinct !{!43, !37}
!44 = distinct !{!44, !8}
!45 = distinct !{!45, !8}
!46 = distinct !{!46, !8, !9}
!47 = distinct !{!47, !8}
!48 = distinct !{!48, !8, !9, !10}
!49 = distinct !{!49, !8, !9, !10}
!50 = distinct !{!50, !8, !9, !10}
!51 = distinct !{!51, !8, !9, !10}
!52 = distinct !{!52, !8, !10, !9}
!53 = distinct !{!53, !8, !9}
!54 = distinct !{!54, !8}
!55 = distinct !{!55, !8, !9, !10}
!56 = distinct !{!56, !8, !9, !10}
!57 = distinct !{!57, !8, !9, !10}
!58 = distinct !{!58, !8, !9, !10}
!59 = distinct !{!59, !8, !10, !9}
