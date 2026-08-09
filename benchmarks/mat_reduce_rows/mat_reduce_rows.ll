; ModuleID = 'mat_reduce_rows.c'
source_filename = "mat_reduce_rows.c"
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
define dso_local void @mat_reduce_rows(ptr nocapture noundef readonly %A, ptr nocapture noundef writeonly %res, i32 noundef %M, i32 noundef %N) local_unnamed_addr #2 {
entry:
  %cmp20 = icmp sgt i32 %M, 0
  br i1 %cmp20, label %for.body.lr.ph, label %for.cond.cleanup

for.body.lr.ph:                                   ; preds = %entry
  %cmp217 = icmp sgt i32 %N, 0
  br i1 %cmp217, label %for.body.lr.ph.split.us, label %for.body.lr.ph.split

for.body.lr.ph.split.us:                          ; preds = %for.body.lr.ph
  %min.iters.check28 = icmp eq i32 %N, 1
  %n.vec31 = and i32 %N, -2
  br i1 %min.iters.check28, label %for.body4.lr.ph.us.us.preheader, label %for.body.lr.ph.split.us.split

for.body4.lr.ph.us.us.preheader:                  ; preds = %for.body.lr.ph.split.us
  br label %for.cond.cleanup3.us.loopexit.us

for.cond.cleanup3.us.loopexit.us:                 ; preds = %for.cond.cleanup3.us.loopexit.us, %for.body4.lr.ph.us.us.preheader
  %i.021.us.us = phi i32 [ %inc8.us.us, %for.cond.cleanup3.us.loopexit.us ], [ 0, %for.body4.lr.ph.us.us.preheader ]
  %arrayidx.us.us.phi.trans.insert = getelementptr inbounds i32, ptr %A, i32 %i.021.us.us
  %.pre = load i32, ptr %arrayidx.us.us.phi.trans.insert, align 4, !tbaa !3
  %arrayidx6.us.us = getelementptr inbounds i32, ptr %res, i32 %i.021.us.us
  store i32 %.pre, ptr %arrayidx6.us.us, align 4, !tbaa !3
  %inc8.us.us = add nuw nsw i32 %i.021.us.us, 1
  %cmp.us.us = icmp slt i32 %inc8.us.us, %M
  br i1 %cmp.us.us, label %for.cond.cleanup3.us.loopexit.us, label %for.cond.cleanup, !llvm.loop !34

for.body.lr.ph.split.us.split:                    ; preds = %for.body.lr.ph.split.us
  %cmp.n33 = icmp eq i32 %n.vec31, %N
  br i1 %cmp.n33, label %for.body4.lr.ph.us.us40.preheader, label %for.body4.lr.ph.us.preheader

for.body4.lr.ph.us.preheader:                     ; preds = %for.body.lr.ph.split.us.split
  br label %for.body4.lr.ph.us

for.body4.lr.ph.us.us40.preheader:                ; preds = %for.body.lr.ph.split.us.split
  br label %for.body4.lr.ph.us.us40

for.body4.lr.ph.us.us40:                          ; preds = %for.body4.lr.ph.us.us40.preheader, %middle.block26.us
  %i.021.us.us41 = phi i32 [ %inc8.us.us46, %middle.block26.us ], [ 0, %for.body4.lr.ph.us.us40.preheader ]
  %mul.us.us42 = mul nsw i32 %i.021.us.us41, %N
  br label %vector.body34.us

middle.block26.us:                                ; preds = %vector.body34.us
  %bin.rdx.us = add i32 %8, %7
  %arrayidx6.us.us45 = getelementptr inbounds i32, ptr %res, i32 %i.021.us.us41
  store i32 %bin.rdx.us, ptr %arrayidx6.us.us45, align 4, !tbaa !3
  %inc8.us.us46 = add nuw nsw i32 %i.021.us.us41, 1
  %cmp.us.us47 = icmp slt i32 %inc8.us.us46, %M
  br i1 %cmp.us.us47, label %for.body4.lr.ph.us.us40, label %for.cond.cleanup, !llvm.loop !34

vector.body34.us:                                 ; preds = %vector.body34.us, %for.body4.lr.ph.us.us40
  %index35.us = phi i32 [ 0, %for.body4.lr.ph.us.us40 ], [ %index.next37.us, %vector.body34.us ]
  %vec.phi.us = phi i32 [ 0, %for.body4.lr.ph.us.us40 ], [ %7, %vector.body34.us ]
  %vec.phi36.us = phi i32 [ 0, %for.body4.lr.ph.us.us40 ], [ %8, %vector.body34.us ]
  %0 = add nuw nsw i32 %index35.us, 1
  %1 = add nsw i32 %index35.us, %mul.us.us42
  %2 = add nsw i32 %0, %mul.us.us42
  %3 = getelementptr inbounds i32, ptr %A, i32 %1
  %4 = getelementptr inbounds i32, ptr %A, i32 %2
  %5 = load i32, ptr %3, align 4, !tbaa !3
  %6 = load i32, ptr %4, align 4, !tbaa !3
  %7 = add i32 %5, %vec.phi.us
  %8 = add i32 %6, %vec.phi36.us
  %index.next37.us = add nuw i32 %index35.us, 2
  %9 = icmp eq i32 %index.next37.us, %N
  br i1 %9, label %middle.block26.us, label %vector.body34.us, !llvm.loop !39

for.cond.cleanup3.us:                             ; preds = %for.body4.us
  %arrayidx6.us = getelementptr inbounds i32, ptr %res, i32 %i.021.us
  store i32 %add5.us, ptr %arrayidx6.us, align 4, !tbaa !3
  %inc8.us = add nuw nsw i32 %i.021.us, 1
  %cmp.us = icmp slt i32 %inc8.us, %M
  br i1 %cmp.us, label %for.body4.lr.ph.us, label %for.cond.cleanup, !llvm.loop !34

for.body4.us:                                     ; preds = %middle.block26, %for.body4.us
  %j.019.us = phi i32 [ %n.vec31, %middle.block26 ], [ %inc.us, %for.body4.us ]
  %acc.018.us = phi i32 [ %bin.rdx, %middle.block26 ], [ %add5.us, %for.body4.us ]
  %add.us = add nsw i32 %j.019.us, %mul.us
  %arrayidx.us = getelementptr inbounds i32, ptr %A, i32 %add.us
  %10 = load i32, ptr %arrayidx.us, align 4, !tbaa !3
  %add5.us = add nsw i32 %10, %acc.018.us
  %inc.us = add nuw nsw i32 %j.019.us, 1
  %cmp2.us = icmp slt i32 %inc.us, %N
  br i1 %cmp2.us, label %for.body4.us, label %for.cond.cleanup3.us, !llvm.loop !41

for.body4.lr.ph.us:                               ; preds = %for.body4.lr.ph.us.preheader, %for.cond.cleanup3.us
  %i.021.us = phi i32 [ %inc8.us, %for.cond.cleanup3.us ], [ 0, %for.body4.lr.ph.us.preheader ]
  %mul.us = mul nsw i32 %i.021.us, %N
  br label %vector.body34

vector.body34:                                    ; preds = %vector.body34, %for.body4.lr.ph.us
  %index35 = phi i32 [ 0, %for.body4.lr.ph.us ], [ %index.next37, %vector.body34 ]
  %vec.phi = phi i32 [ 0, %for.body4.lr.ph.us ], [ %18, %vector.body34 ]
  %vec.phi36 = phi i32 [ 0, %for.body4.lr.ph.us ], [ %19, %vector.body34 ]
  %11 = add nuw nsw i32 %index35, 1
  %12 = add nsw i32 %index35, %mul.us
  %13 = add nsw i32 %11, %mul.us
  %14 = getelementptr inbounds i32, ptr %A, i32 %12
  %15 = getelementptr inbounds i32, ptr %A, i32 %13
  %16 = load i32, ptr %14, align 4, !tbaa !3
  %17 = load i32, ptr %15, align 4, !tbaa !3
  %18 = add i32 %16, %vec.phi
  %19 = add i32 %17, %vec.phi36
  %index.next37 = add nuw i32 %index35, 2
  %20 = icmp eq i32 %index.next37, %n.vec31
  br i1 %20, label %middle.block26, label %vector.body34, !llvm.loop !39

middle.block26:                                   ; preds = %vector.body34
  %bin.rdx = add i32 %19, %18
  br label %for.body4.us

for.body.lr.ph.split:                             ; preds = %for.body.lr.ph
  %min.iters.check = icmp ult i32 %M, 4
  br i1 %min.iters.check, label %for.cond.cleanup3.preheader, label %vector.ph

vector.ph:                                        ; preds = %for.body.lr.ph.split
  %n.vec = and i32 %M, -4
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %21 = getelementptr inbounds i32, ptr %res, i32 %index
  store <4 x i32> zeroinitializer, ptr %21, align 4, !tbaa !3
  %index.next = add nuw i32 %index, 4
  %22 = icmp eq i32 %index.next, %n.vec
  br i1 %22, label %middle.block, label %vector.body, !llvm.loop !42

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i32 %n.vec, %M
  br i1 %cmp.n, label %for.cond.cleanup, label %for.cond.cleanup3.preheader

for.cond.cleanup3.preheader:                      ; preds = %for.body.lr.ph.split, %middle.block
  %i.021.ph = phi i32 [ 0, %for.body.lr.ph.split ], [ %n.vec, %middle.block ]
  br label %for.cond.cleanup3

for.cond.cleanup:                                 ; preds = %for.cond.cleanup3, %for.cond.cleanup3.us, %middle.block26.us, %for.cond.cleanup3.us.loopexit.us, %middle.block, %entry
  ret void

for.cond.cleanup3:                                ; preds = %for.cond.cleanup3.preheader, %for.cond.cleanup3
  %i.021 = phi i32 [ %inc8, %for.cond.cleanup3 ], [ %i.021.ph, %for.cond.cleanup3.preheader ]
  %arrayidx6 = getelementptr inbounds i32, ptr %res, i32 %i.021
  store i32 0, ptr %arrayidx6, align 4, !tbaa !3
  %inc8 = add nuw nsw i32 %i.021, 1
  %cmp = icmp slt i32 %inc8, %M
  br i1 %cmp, label %for.cond.cleanup3, label %for.cond.cleanup, !llvm.loop !43
}

; Function Attrs: mustprogress nofree nosync nounwind willreturn memory(read, argmem: readwrite)
define dso_local void @vectorized_mat_reduce_rows(ptr addrspace(4) noalias noundef %A, ptr addrspace(4) noalias nocapture noundef writeonly %res, i32 noundef %M, i32 noundef %N) local_unnamed_addr #3 {
entry:
  %div = sdiv i32 %N, 16
  %mul = shl nsw i32 %div, 4
  %cmp71 = icmp sgt i32 %M, 0
  br i1 %cmp71, label %for.body.lr.ph, label %for.cond.cleanup

for.body.lr.ph:                                   ; preds = %entry
  %0 = tail call <16 x i32> @llvm.arc.vvcadd.init.acc.w.v512(<16 x i32> zeroinitializer, <16 x i32> zeroinitializer)
  %cmp264 = icmp sgt i32 %N, 15
  %cmp3067 = icmp slt i32 %mul, %N
  br i1 %cmp264, label %for.body.lr.ph.split.us, label %for.body.lr.ph.split

for.body.lr.ph.split.us:                          ; preds = %for.body.lr.ph
  br i1 %cmp3067, label %for.body.lr.ph.split.us.split.us, label %for.body4.lr.ph.us.preheader

for.body4.lr.ph.us.preheader:                     ; preds = %for.body.lr.ph.split.us
  br label %for.body4.lr.ph.us

for.body.lr.ph.split.us.split.us:                 ; preds = %for.body.lr.ph.split.us
  %1 = sub i32 %N, %mul
  %min.iters.check164 = icmp ult i32 %1, 8
  %min.iters.check167 = icmp ult i32 %1, 64
  %n.vec171 = and i32 %1, -64
  %cmp.n172 = icmp eq i32 %1, %n.vec171
  %ind.end199 = add i32 %mul, %n.vec171
  %n.vec.remaining193 = and i32 %1, 56
  %min.epilog.iters.check194 = icmp eq i32 %n.vec.remaining193, 0
  %n.mod.vf196 = and i32 %N, 7
  %n.vec197 = sub nuw i32 %1, %n.mod.vf196
  %ind.end198 = add i32 %mul, %n.vec197
  %cmp.n201 = icmp eq i32 %n.mod.vf196, 0
  br label %for.body4.lr.ph.us.us

for.cond.cleanup31.us.us:                         ; preds = %for.body32.us.us, %vec.epilog.middle.block189, %middle.block163
  %add36.us.us.lcssa = phi i32 [ %21, %middle.block163 ], [ %27, %vec.epilog.middle.block189 ], [ %add36.us.us, %for.body32.us.us ]
  %arrayidx39.us.us = getelementptr inbounds i32, ptr addrspace(4) %res, i32 %i.072.us.us
  store i32 %add36.us.us.lcssa, ptr addrspace(4) %arrayidx39.us.us, align 4, !tbaa !3
  %inc41.us.us = add nuw nsw i32 %i.072.us.us, 1
  %cmp.us.us = icmp slt i32 %inc41.us.us, %M
  br i1 %cmp.us.us, label %for.body4.lr.ph.us.us, label %for.cond.cleanup, !llvm.loop !44

for.body32.us.us:                                 ; preds = %for.body32.us.us.preheader, %for.body32.us.us
  %j.069.us.us = phi i32 [ %inc.us.us, %for.body32.us.us ], [ %j.069.us.us.ph, %for.body32.us.us.preheader ]
  %row_res.068.us.us = phi i32 [ %add36.us.us, %for.body32.us.us ], [ %row_res.068.us.us.ph, %for.body32.us.us.preheader ]
  %add34.us.us = add nsw i32 %j.069.us.us, %mul5.us.us
  %arrayidx35.us.us = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %add34.us.us
  %2 = load i32, ptr addrspace(4) %arrayidx35.us.us, align 4, !tbaa !3
  %add36.us.us = add nsw i32 %2, %row_res.068.us.us
  %inc.us.us = add nsw i32 %j.069.us.us, 1
  %cmp30.us.us = icmp slt i32 %inc.us.us, %N
  br i1 %cmp30.us.us, label %for.body32.us.us, label %for.cond.cleanup31.us.us, !llvm.loop !45

for.body4.us.us:                                  ; preds = %for.body4.lr.ph.us.us, %for.body4.us.us
  %acc.sroa.0.066.us.us = phi <16 x i32> [ %0, %for.body4.lr.ph.us.us ], [ %4, %for.body4.us.us ]
  %j_vec.065.us.us = phi i32 [ 0, %for.body4.lr.ph.us.us ], [ %add10.us.us, %for.body4.us.us ]
  %add.us.us = add nsw i32 %j_vec.065.us.us, %mul5.us.us
  %arrayidx.us.us = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %add.us.us
  %3 = tail call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %arrayidx.us.us)
  %4 = tail call <16 x i32> @llvm.arc.vvcadd.acc.w.v512(<16 x i32> %acc.sroa.0.066.us.us, <16 x i32> %3, <16 x i32> zeroinitializer)
  %add10.us.us = add nuw nsw i32 %j_vec.065.us.us, 16
  %cmp2.us.us = icmp slt i32 %add10.us.us, %mul
  br i1 %cmp2.us.us, label %for.body4.us.us, label %iter.check166, !llvm.loop !46

for.body4.lr.ph.us.us:                            ; preds = %for.body.lr.ph.split.us.split.us, %for.cond.cleanup31.us.us
  %i.072.us.us = phi i32 [ 0, %for.body.lr.ph.split.us.split.us ], [ %inc41.us.us, %for.cond.cleanup31.us.us ]
  %mul5.us.us = mul nsw i32 %i.072.us.us, %N
  br label %for.body4.us.us

iter.check166:                                    ; preds = %for.body4.us.us
  %5 = tail call <16 x i32> @llvm.arc.vvc4add.acc.w.v512(<16 x i32> %4)
  %6 = tail call <16 x i32> @llvm.arc.vvc4pack.acc.w.v512(<16 x i32> %5)
  %7 = tail call <16 x i32> @llvm.arc.vvc4add.acc.w.v512(<16 x i32> %6)
  %8 = tail call <16 x i32> @llvm.arc.vvc4pack.acc.w.v512(<16 x i32> %7)
  %9 = tail call <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32> %8)
  %vecext.us.us = extractelement <16 x i32> %9, i64 0
  br i1 %min.iters.check164, label %for.body32.us.us.preheader, label %vector.main.loop.iter.check168

vector.main.loop.iter.check168:                   ; preds = %iter.check166
  br i1 %min.iters.check167, label %vec.epilog.ph192, label %vector.ph169

vector.ph169:                                     ; preds = %vector.main.loop.iter.check168
  %10 = shufflevector <16 x i32> <i32 0, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>, <16 x i32> %9, <16 x i32> <i32 16, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>
  br label %vector.body173

vector.body173:                                   ; preds = %vector.body173, %vector.ph169
  %index174 = phi i32 [ 0, %vector.ph169 ], [ %index.next184, %vector.body173 ]
  %vec.phi175 = phi <16 x i32> [ %10, %vector.ph169 ], [ %16, %vector.body173 ]
  %vec.phi176 = phi <16 x i32> [ zeroinitializer, %vector.ph169 ], [ %17, %vector.body173 ]
  %vec.phi177 = phi <16 x i32> [ zeroinitializer, %vector.ph169 ], [ %18, %vector.body173 ]
  %vec.phi178 = phi <16 x i32> [ zeroinitializer, %vector.ph169 ], [ %19, %vector.body173 ]
  %offset.idx179 = add i32 %mul, %index174
  %11 = add nsw i32 %offset.idx179, %mul5.us.us
  %12 = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %11
  %wide.load180 = load <16 x i32>, ptr addrspace(4) %12, align 4, !tbaa !3
  %13 = getelementptr inbounds i32, ptr addrspace(4) %12, i32 16
  %wide.load181 = load <16 x i32>, ptr addrspace(4) %13, align 4, !tbaa !3
  %14 = getelementptr inbounds i32, ptr addrspace(4) %12, i32 32
  %wide.load182 = load <16 x i32>, ptr addrspace(4) %14, align 4, !tbaa !3
  %15 = getelementptr inbounds i32, ptr addrspace(4) %12, i32 48
  %wide.load183 = load <16 x i32>, ptr addrspace(4) %15, align 4, !tbaa !3
  %16 = add <16 x i32> %wide.load180, %vec.phi175
  %17 = add <16 x i32> %wide.load181, %vec.phi176
  %18 = add <16 x i32> %wide.load182, %vec.phi177
  %19 = add <16 x i32> %wide.load183, %vec.phi178
  %index.next184 = add nuw i32 %index174, 64
  %20 = icmp eq i32 %index.next184, %n.vec171
  br i1 %20, label %middle.block163, label %vector.body173, !llvm.loop !47

middle.block163:                                  ; preds = %vector.body173
  %bin.rdx185 = add <16 x i32> %17, %16
  %bin.rdx186 = add <16 x i32> %18, %bin.rdx185
  %bin.rdx187 = add <16 x i32> %19, %bin.rdx186
  %21 = tail call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %bin.rdx187)
  br i1 %cmp.n172, label %for.cond.cleanup31.us.us, label %vec.epilog.iter.check191

vec.epilog.iter.check191:                         ; preds = %middle.block163
  br i1 %min.epilog.iters.check194, label %for.body32.us.us.preheader, label %vec.epilog.ph192

vec.epilog.ph192:                                 ; preds = %vector.main.loop.iter.check168, %vec.epilog.iter.check191
  %bc.merge.rdx188 = phi i32 [ %vecext.us.us, %vector.main.loop.iter.check168 ], [ %21, %vec.epilog.iter.check191 ]
  %vec.epilog.resume.val195 = phi i32 [ 0, %vector.main.loop.iter.check168 ], [ %n.vec171, %vec.epilog.iter.check191 ]
  %22 = insertelement <8 x i32> <i32 poison, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, i32 %bc.merge.rdx188, i64 0
  br label %vec.epilog.vector.body202

vec.epilog.vector.body202:                        ; preds = %vec.epilog.vector.body202, %vec.epilog.ph192
  %index203 = phi i32 [ %vec.epilog.resume.val195, %vec.epilog.ph192 ], [ %index.next207, %vec.epilog.vector.body202 ]
  %vec.phi204 = phi <8 x i32> [ %22, %vec.epilog.ph192 ], [ %25, %vec.epilog.vector.body202 ]
  %offset.idx205 = add i32 %mul, %index203
  %23 = add nsw i32 %offset.idx205, %mul5.us.us
  %24 = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %23
  %wide.load206 = load <8 x i32>, ptr addrspace(4) %24, align 4, !tbaa !3
  %25 = add <8 x i32> %wide.load206, %vec.phi204
  %index.next207 = add nuw i32 %index203, 8
  %26 = icmp eq i32 %index.next207, %n.vec197
  br i1 %26, label %vec.epilog.middle.block189, label %vec.epilog.vector.body202, !llvm.loop !48

vec.epilog.middle.block189:                       ; preds = %vec.epilog.vector.body202
  %27 = tail call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %25)
  br i1 %cmp.n201, label %for.cond.cleanup31.us.us, label %for.body32.us.us.preheader

for.body32.us.us.preheader:                       ; preds = %iter.check166, %vec.epilog.iter.check191, %vec.epilog.middle.block189
  %j.069.us.us.ph = phi i32 [ %mul, %iter.check166 ], [ %ind.end199, %vec.epilog.iter.check191 ], [ %ind.end198, %vec.epilog.middle.block189 ]
  %row_res.068.us.us.ph = phi i32 [ %vecext.us.us, %iter.check166 ], [ %21, %vec.epilog.iter.check191 ], [ %27, %vec.epilog.middle.block189 ]
  br label %for.body32.us.us

for.cond.cleanup31.us:                            ; preds = %for.body4.us
  %28 = tail call <16 x i32> @llvm.arc.vvc4add.acc.w.v512(<16 x i32> %34)
  %29 = tail call <16 x i32> @llvm.arc.vvc4pack.acc.w.v512(<16 x i32> %28)
  %30 = tail call <16 x i32> @llvm.arc.vvc4add.acc.w.v512(<16 x i32> %29)
  %31 = tail call <16 x i32> @llvm.arc.vvc4pack.acc.w.v512(<16 x i32> %30)
  %32 = tail call <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32> %31)
  %vecext.us = extractelement <16 x i32> %32, i64 0
  %arrayidx39.us = getelementptr inbounds i32, ptr addrspace(4) %res, i32 %i.072.us
  store i32 %vecext.us, ptr addrspace(4) %arrayidx39.us, align 4, !tbaa !3
  %inc41.us = add nuw nsw i32 %i.072.us, 1
  %cmp.us = icmp slt i32 %inc41.us, %M
  br i1 %cmp.us, label %for.body4.lr.ph.us, label %for.cond.cleanup, !llvm.loop !44

for.body4.us:                                     ; preds = %for.body4.lr.ph.us, %for.body4.us
  %acc.sroa.0.066.us = phi <16 x i32> [ %0, %for.body4.lr.ph.us ], [ %34, %for.body4.us ]
  %j_vec.065.us = phi i32 [ 0, %for.body4.lr.ph.us ], [ %add10.us, %for.body4.us ]
  %add.us = add nsw i32 %j_vec.065.us, %mul5.us
  %arrayidx.us = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %add.us
  %33 = tail call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %arrayidx.us)
  %34 = tail call <16 x i32> @llvm.arc.vvcadd.acc.w.v512(<16 x i32> %acc.sroa.0.066.us, <16 x i32> %33, <16 x i32> zeroinitializer)
  %add10.us = add nuw nsw i32 %j_vec.065.us, 16
  %cmp2.us = icmp slt i32 %add10.us, %mul
  br i1 %cmp2.us, label %for.body4.us, label %for.cond.cleanup31.us, !llvm.loop !46

for.body4.lr.ph.us:                               ; preds = %for.body4.lr.ph.us.preheader, %for.cond.cleanup31.us
  %i.072.us = phi i32 [ %inc41.us, %for.cond.cleanup31.us ], [ 0, %for.body4.lr.ph.us.preheader ]
  %mul5.us = mul nsw i32 %i.072.us, %N
  br label %for.body4.us

for.body.lr.ph.split:                             ; preds = %for.body.lr.ph
  %35 = tail call <16 x i32> @llvm.arc.vvc4add.acc.w.v512(<16 x i32> %0)
  %36 = tail call <16 x i32> @llvm.arc.vvc4pack.acc.w.v512(<16 x i32> %35)
  %37 = tail call <16 x i32> @llvm.arc.vvc4add.acc.w.v512(<16 x i32> %36)
  %38 = tail call <16 x i32> @llvm.arc.vvc4pack.acc.w.v512(<16 x i32> %37)
  %39 = tail call <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32> %38)
  %vecext = extractelement <16 x i32> %39, i64 0
  br i1 %cmp3067, label %for.body.lr.ph.split.split.us, label %iter.check

for.body.lr.ph.split.split.us:                    ; preds = %for.body.lr.ph.split
  %40 = sub i32 %N, %mul
  %min.iters.check124 = icmp ult i32 %40, 8
  %min.iters.check127 = icmp ult i32 %40, 64
  %n.vec131 = and i32 %40, -64
  %41 = shufflevector <16 x i32> <i32 0, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>, <16 x i32> %39, <16 x i32> <i32 16, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>
  %cmp.n132 = icmp eq i32 %40, %n.vec131
  %n.vec.remaining148 = and i32 %40, 56
  %min.epilog.iters.check149 = icmp eq i32 %n.vec.remaining148, 0
  %n.mod.vf151 = and i32 %N, 7
  %n.vec152 = sub nuw i32 %40, %n.mod.vf151
  %cmp.n155 = icmp eq i32 %n.mod.vf151, 0
  br i1 %min.iters.check124, label %iter.check126.us.preheader, label %iter.check126.preheader

iter.check126.preheader:                          ; preds = %for.body.lr.ph.split.split.us
  br label %iter.check126

iter.check126.us.preheader:                       ; preds = %for.body.lr.ph.split.split.us
  br label %iter.check126.us

iter.check126.us:                                 ; preds = %iter.check126.us.preheader, %for.cond.cleanup31.us76.us
  %i.072.us74.us = phi i32 [ %inc41.us79.us, %for.cond.cleanup31.us76.us ], [ 0, %iter.check126.us.preheader ]
  %mul33.us90.us = mul nsw i32 %i.072.us74.us, %N
  br label %for.body32.us81.us

for.body32.us81.us:                               ; preds = %for.body32.us81.us, %iter.check126.us
  %j.069.us82.us = phi i32 [ %mul, %iter.check126.us ], [ %inc.us87.us, %for.body32.us81.us ]
  %row_res.068.us83.us = phi i32 [ %vecext, %iter.check126.us ], [ %add36.us86.us, %for.body32.us81.us ]
  %add34.us84.us = add nsw i32 %j.069.us82.us, %mul33.us90.us
  %arrayidx35.us85.us = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %add34.us84.us
  %42 = load i32, ptr addrspace(4) %arrayidx35.us85.us, align 4, !tbaa !3
  %add36.us86.us = add nsw i32 %42, %row_res.068.us83.us
  %inc.us87.us = add nsw i32 %j.069.us82.us, 1
  %cmp30.us88.us = icmp slt i32 %inc.us87.us, %N
  br i1 %cmp30.us88.us, label %for.body32.us81.us, label %for.cond.cleanup31.us76.us, !llvm.loop !49

for.cond.cleanup31.us76.us:                       ; preds = %for.body32.us81.us
  %arrayidx39.us78.us = getelementptr inbounds i32, ptr addrspace(4) %res, i32 %i.072.us74.us
  store i32 %add36.us86.us, ptr addrspace(4) %arrayidx39.us78.us, align 4, !tbaa !3
  %inc41.us79.us = add nuw nsw i32 %i.072.us74.us, 1
  %cmp.us80.us = icmp slt i32 %inc41.us79.us, %M
  br i1 %cmp.us80.us, label %iter.check126.us, label %for.cond.cleanup, !llvm.loop !44

for.cond.cleanup31.us76:                          ; preds = %for.body32.us81, %vec.epilog.middle.block144, %middle.block123
  %add36.us86.lcssa = phi i32 [ %54, %middle.block123 ], [ %60, %vec.epilog.middle.block144 ], [ %add36.us86, %for.body32.us81 ]
  %arrayidx39.us78 = getelementptr inbounds i32, ptr addrspace(4) %res, i32 %i.072.us74
  store i32 %add36.us86.lcssa, ptr addrspace(4) %arrayidx39.us78, align 4, !tbaa !3
  %inc41.us79 = add nuw nsw i32 %i.072.us74, 1
  %cmp.us80 = icmp slt i32 %inc41.us79, %M
  br i1 %cmp.us80, label %iter.check126, label %for.cond.cleanup, !llvm.loop !44

for.body32.us81:                                  ; preds = %vec.epilog.scalar.ph145, %for.body32.us81
  %j.069.us82 = phi i32 [ %bc.resume.val154, %vec.epilog.scalar.ph145 ], [ %inc.us87, %for.body32.us81 ]
  %row_res.068.us83 = phi i32 [ %bc.merge.rdx162, %vec.epilog.scalar.ph145 ], [ %add36.us86, %for.body32.us81 ]
  %add34.us84 = add nsw i32 %j.069.us82, %mul33.us90
  %arrayidx35.us85 = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %add34.us84
  %43 = load i32, ptr addrspace(4) %arrayidx35.us85, align 4, !tbaa !3
  %add36.us86 = add nsw i32 %43, %row_res.068.us83
  %inc.us87 = add nsw i32 %j.069.us82, 1
  %cmp30.us88 = icmp slt i32 %inc.us87, %N
  br i1 %cmp30.us88, label %for.body32.us81, label %for.cond.cleanup31.us76, !llvm.loop !49

iter.check126:                                    ; preds = %iter.check126.preheader, %for.cond.cleanup31.us76
  %i.072.us74 = phi i32 [ %inc41.us79, %for.cond.cleanup31.us76 ], [ 0, %iter.check126.preheader ]
  %mul33.us90 = mul nsw i32 %i.072.us74, %N
  br i1 %min.iters.check127, label %vec.epilog.ph147, label %vector.body133.preheader

vector.body133.preheader:                         ; preds = %iter.check126
  br label %vector.body133

vector.body133:                                   ; preds = %vector.body133.preheader, %vector.body133
  %index134 = phi i32 [ %index.next141, %vector.body133 ], [ 0, %vector.body133.preheader ]
  %vec.phi = phi <16 x i32> [ %49, %vector.body133 ], [ %41, %vector.body133.preheader ]
  %vec.phi135 = phi <16 x i32> [ %50, %vector.body133 ], [ zeroinitializer, %vector.body133.preheader ]
  %vec.phi136 = phi <16 x i32> [ %51, %vector.body133 ], [ zeroinitializer, %vector.body133.preheader ]
  %vec.phi137 = phi <16 x i32> [ %52, %vector.body133 ], [ zeroinitializer, %vector.body133.preheader ]
  %offset.idx = add i32 %mul, %index134
  %44 = add nsw i32 %offset.idx, %mul33.us90
  %45 = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %44
  %wide.load = load <16 x i32>, ptr addrspace(4) %45, align 4, !tbaa !3
  %46 = getelementptr inbounds i32, ptr addrspace(4) %45, i32 16
  %wide.load138 = load <16 x i32>, ptr addrspace(4) %46, align 4, !tbaa !3
  %47 = getelementptr inbounds i32, ptr addrspace(4) %45, i32 32
  %wide.load139 = load <16 x i32>, ptr addrspace(4) %47, align 4, !tbaa !3
  %48 = getelementptr inbounds i32, ptr addrspace(4) %45, i32 48
  %wide.load140 = load <16 x i32>, ptr addrspace(4) %48, align 4, !tbaa !3
  %49 = add <16 x i32> %wide.load, %vec.phi
  %50 = add <16 x i32> %wide.load138, %vec.phi135
  %51 = add <16 x i32> %wide.load139, %vec.phi136
  %52 = add <16 x i32> %wide.load140, %vec.phi137
  %index.next141 = add nuw i32 %index134, 64
  %53 = icmp eq i32 %index.next141, %n.vec131
  br i1 %53, label %middle.block123, label %vector.body133, !llvm.loop !50

middle.block123:                                  ; preds = %vector.body133
  %bin.rdx = add <16 x i32> %50, %49
  %bin.rdx142 = add <16 x i32> %51, %bin.rdx
  %bin.rdx143 = add <16 x i32> %52, %bin.rdx142
  %54 = tail call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %bin.rdx143)
  br i1 %cmp.n132, label %for.cond.cleanup31.us76, label %vec.epilog.iter.check146

vec.epilog.iter.check146:                         ; preds = %middle.block123
  br i1 %min.epilog.iters.check149, label %vec.epilog.scalar.ph145, label %vec.epilog.ph147

vec.epilog.ph147:                                 ; preds = %iter.check126, %vec.epilog.iter.check146
  %bc.merge.rdx = phi i32 [ %vecext, %iter.check126 ], [ %54, %vec.epilog.iter.check146 ]
  %vec.epilog.resume.val150 = phi i32 [ 0, %iter.check126 ], [ %n.vec131, %vec.epilog.iter.check146 ]
  %55 = insertelement <8 x i32> <i32 poison, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, i32 %bc.merge.rdx, i64 0
  br label %vec.epilog.vector.body156

vec.epilog.vector.body156:                        ; preds = %vec.epilog.vector.body156, %vec.epilog.ph147
  %index157 = phi i32 [ %vec.epilog.resume.val150, %vec.epilog.ph147 ], [ %index.next161, %vec.epilog.vector.body156 ]
  %vec.phi158 = phi <8 x i32> [ %55, %vec.epilog.ph147 ], [ %58, %vec.epilog.vector.body156 ]
  %offset.idx159 = add i32 %mul, %index157
  %56 = add nsw i32 %offset.idx159, %mul33.us90
  %57 = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %56
  %wide.load160 = load <8 x i32>, ptr addrspace(4) %57, align 4, !tbaa !3
  %58 = add <8 x i32> %wide.load160, %vec.phi158
  %index.next161 = add nuw i32 %index157, 8
  %59 = icmp eq i32 %index.next161, %n.vec152
  br i1 %59, label %vec.epilog.middle.block144, label %vec.epilog.vector.body156, !llvm.loop !51

vec.epilog.middle.block144:                       ; preds = %vec.epilog.vector.body156
  %60 = tail call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %58)
  br i1 %cmp.n155, label %for.cond.cleanup31.us76, label %vec.epilog.scalar.ph145

vec.epilog.scalar.ph145:                          ; preds = %vec.epilog.iter.check146, %vec.epilog.middle.block144
  %n.vec152.pn = phi i32 [ %n.vec152, %vec.epilog.middle.block144 ], [ %n.vec131, %vec.epilog.iter.check146 ]
  %bc.merge.rdx162 = phi i32 [ %60, %vec.epilog.middle.block144 ], [ %54, %vec.epilog.iter.check146 ]
  %bc.resume.val154 = add i32 %mul, %n.vec152.pn
  br label %for.body32.us81

iter.check:                                       ; preds = %for.body.lr.ph.split
  %min.iters.check = icmp ult i32 %M, 8
  br i1 %min.iters.check, label %for.cond.cleanup31.preheader, label %vector.main.loop.iter.check

vector.main.loop.iter.check:                      ; preds = %iter.check
  %min.iters.check109 = icmp ult i32 %M, 64
  br i1 %min.iters.check109, label %vec.epilog.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.main.loop.iter.check
  %n.vec = and i32 %M, -64
  %broadcast.splat = shufflevector <16 x i32> %39, <16 x i32> poison, <16 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %61 = getelementptr inbounds i32, ptr addrspace(4) %res, i32 %index
  store <16 x i32> %broadcast.splat, ptr addrspace(4) %61, align 4, !tbaa !3
  %62 = getelementptr inbounds i32, ptr addrspace(4) %61, i32 16
  store <16 x i32> %broadcast.splat, ptr addrspace(4) %62, align 4, !tbaa !3
  %63 = getelementptr inbounds i32, ptr addrspace(4) %61, i32 32
  store <16 x i32> %broadcast.splat, ptr addrspace(4) %63, align 4, !tbaa !3
  %64 = getelementptr inbounds i32, ptr addrspace(4) %61, i32 48
  store <16 x i32> %broadcast.splat, ptr addrspace(4) %64, align 4, !tbaa !3
  %index.next = add nuw i32 %index, 64
  %65 = icmp eq i32 %index.next, %n.vec
  br i1 %65, label %middle.block, label %vector.body, !llvm.loop !52

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i32 %n.vec, %M
  br i1 %cmp.n, label %for.cond.cleanup, label %vec.epilog.iter.check

vec.epilog.iter.check:                            ; preds = %middle.block
  %n.vec.remaining = and i32 %M, 56
  %min.epilog.iters.check = icmp eq i32 %n.vec.remaining, 0
  br i1 %min.epilog.iters.check, label %for.cond.cleanup31.preheader, label %vec.epilog.ph

vec.epilog.ph:                                    ; preds = %vector.main.loop.iter.check, %vec.epilog.iter.check
  %vec.epilog.resume.val = phi i32 [ %n.vec, %vec.epilog.iter.check ], [ 0, %vector.main.loop.iter.check ]
  %n.vec117 = and i32 %M, -8
  %broadcast.splat121 = shufflevector <16 x i32> %39, <16 x i32> undef, <8 x i32> zeroinitializer
  br label %vec.epilog.vector.body

vec.epilog.vector.body:                           ; preds = %vec.epilog.vector.body, %vec.epilog.ph
  %index119 = phi i32 [ %vec.epilog.resume.val, %vec.epilog.ph ], [ %index.next122, %vec.epilog.vector.body ]
  %66 = getelementptr inbounds i32, ptr addrspace(4) %res, i32 %index119
  store <8 x i32> %broadcast.splat121, ptr addrspace(4) %66, align 4, !tbaa !3
  %index.next122 = add nuw i32 %index119, 8
  %67 = icmp eq i32 %index.next122, %n.vec117
  br i1 %67, label %vec.epilog.middle.block, label %vec.epilog.vector.body, !llvm.loop !53

vec.epilog.middle.block:                          ; preds = %vec.epilog.vector.body
  %cmp.n118 = icmp eq i32 %n.vec117, %M
  br i1 %cmp.n118, label %for.cond.cleanup, label %for.cond.cleanup31.preheader

for.cond.cleanup31.preheader:                     ; preds = %iter.check, %vec.epilog.iter.check, %vec.epilog.middle.block
  %i.072.ph = phi i32 [ 0, %iter.check ], [ %n.vec, %vec.epilog.iter.check ], [ %n.vec117, %vec.epilog.middle.block ]
  br label %for.cond.cleanup31

for.cond.cleanup:                                 ; preds = %for.cond.cleanup31, %for.cond.cleanup31.us76, %for.cond.cleanup31.us76.us, %for.cond.cleanup31.us, %for.cond.cleanup31.us.us, %middle.block, %vec.epilog.middle.block, %entry
  ret void

for.cond.cleanup31:                               ; preds = %for.cond.cleanup31.preheader, %for.cond.cleanup31
  %i.072 = phi i32 [ %inc41, %for.cond.cleanup31 ], [ %i.072.ph, %for.cond.cleanup31.preheader ]
  %arrayidx39 = getelementptr inbounds i32, ptr addrspace(4) %res, i32 %i.072
  store i32 %vecext, ptr addrspace(4) %arrayidx39, align 4, !tbaa !3
  %inc41 = add nuw nsw i32 %i.072, 1
  %cmp = icmp slt i32 %inc41, %M
  br i1 %cmp, label %for.cond.cleanup31, label %for.cond.cleanup, !llvm.loop !54
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @autovectorized_mat_reduce_rows(ptr addrspace(4) noalias nocapture noundef readonly %A, ptr addrspace(4) noalias nocapture noundef writeonly %res, i32 noundef %M, i32 noundef %N) local_unnamed_addr #2 {
entry:
  %cmp20 = icmp sgt i32 %M, 0
  br i1 %cmp20, label %for.body.lr.ph, label %for.cond.cleanup

for.body.lr.ph:                                   ; preds = %entry
  %cmp217 = icmp sgt i32 %N, 0
  br i1 %cmp217, label %for.body.lr.ph.split.us, label %iter.check

for.body.lr.ph.split.us:                          ; preds = %for.body.lr.ph
  %min.iters.check33 = icmp ult i32 %N, 8
  %min.iters.check36 = icmp ult i32 %N, 64
  %n.vec40 = and i32 %N, -64
  %cmp.n41 = icmp eq i32 %n.vec40, %N
  %n.vec.remaining57 = and i32 %N, 56
  %min.epilog.iters.check58 = icmp eq i32 %n.vec.remaining57, 0
  %n.vec61 = and i32 %N, -8
  %cmp.n63 = icmp eq i32 %n.vec61, %N
  br i1 %min.iters.check33, label %iter.check35.us.preheader, label %iter.check35.preheader

iter.check35.preheader:                           ; preds = %for.body.lr.ph.split.us
  br label %iter.check35

iter.check35.us.preheader:                        ; preds = %for.body.lr.ph.split.us
  br label %iter.check35.us

iter.check35.us:                                  ; preds = %iter.check35.us.preheader, %for.cond.cleanup3.us.loopexit.us
  %i.021.us.us = phi i32 [ %inc8.us.us, %for.cond.cleanup3.us.loopexit.us ], [ 0, %iter.check35.us.preheader ]
  %mul.us.us = mul nsw i32 %i.021.us.us, %N
  br label %for.body4.us.us

for.body4.us.us:                                  ; preds = %iter.check35.us, %for.body4.us.us
  %j.019.us.us = phi i32 [ 0, %iter.check35.us ], [ %inc.us.us, %for.body4.us.us ]
  %acc.018.us.us = phi i32 [ 0, %iter.check35.us ], [ %add5.us.us, %for.body4.us.us ]
  %add.us.us = add nsw i32 %j.019.us.us, %mul.us.us
  %arrayidx.us.us = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %add.us.us
  %0 = load i32, ptr addrspace(4) %arrayidx.us.us, align 4, !tbaa !3
  %add5.us.us = add nsw i32 %0, %acc.018.us.us
  %inc.us.us = add nuw nsw i32 %j.019.us.us, 1
  %cmp2.us.us = icmp slt i32 %inc.us.us, %N
  br i1 %cmp2.us.us, label %for.body4.us.us, label %for.cond.cleanup3.us.loopexit.us, !llvm.loop !55

for.cond.cleanup3.us.loopexit.us:                 ; preds = %for.body4.us.us
  %arrayidx6.us.us = getelementptr inbounds i32, ptr addrspace(4) %res, i32 %i.021.us.us
  store i32 %add5.us.us, ptr addrspace(4) %arrayidx6.us.us, align 4, !tbaa !3
  %inc8.us.us = add nuw nsw i32 %i.021.us.us, 1
  %cmp.us.us = icmp slt i32 %inc8.us.us, %M
  br i1 %cmp.us.us, label %iter.check35.us, label %for.cond.cleanup, !llvm.loop !56

for.cond.cleanup3.us:                             ; preds = %for.body4.us, %vec.epilog.middle.block53, %middle.block32
  %add5.us.lcssa = phi i32 [ %12, %middle.block32 ], [ %18, %vec.epilog.middle.block53 ], [ %add5.us, %for.body4.us ]
  %arrayidx6.us = getelementptr inbounds i32, ptr addrspace(4) %res, i32 %i.021.us
  store i32 %add5.us.lcssa, ptr addrspace(4) %arrayidx6.us, align 4, !tbaa !3
  %inc8.us = add nuw nsw i32 %i.021.us, 1
  %cmp.us = icmp slt i32 %inc8.us, %M
  br i1 %cmp.us, label %iter.check35, label %for.cond.cleanup, !llvm.loop !56

for.body4.us:                                     ; preds = %for.body4.us.preheader, %for.body4.us
  %j.019.us = phi i32 [ %inc.us, %for.body4.us ], [ %j.019.us.ph, %for.body4.us.preheader ]
  %acc.018.us = phi i32 [ %add5.us, %for.body4.us ], [ %acc.018.us.ph, %for.body4.us.preheader ]
  %add.us = add nsw i32 %j.019.us, %mul.us
  %arrayidx.us = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %add.us
  %1 = load i32, ptr addrspace(4) %arrayidx.us, align 4, !tbaa !3
  %add5.us = add nsw i32 %1, %acc.018.us
  %inc.us = add nuw nsw i32 %j.019.us, 1
  %cmp2.us = icmp slt i32 %inc.us, %N
  br i1 %cmp2.us, label %for.body4.us, label %for.cond.cleanup3.us, !llvm.loop !55

iter.check35:                                     ; preds = %iter.check35.preheader, %for.cond.cleanup3.us
  %i.021.us = phi i32 [ %inc8.us, %for.cond.cleanup3.us ], [ 0, %iter.check35.preheader ]
  %mul.us = mul nsw i32 %i.021.us, %N
  br i1 %min.iters.check36, label %vec.epilog.ph56, label %vector.body42.preheader

vector.body42.preheader:                          ; preds = %iter.check35
  br label %vector.body42

vector.body42:                                    ; preds = %vector.body42.preheader, %vector.body42
  %index43 = phi i32 [ %index.next50, %vector.body42 ], [ 0, %vector.body42.preheader ]
  %vec.phi = phi <16 x i32> [ %7, %vector.body42 ], [ zeroinitializer, %vector.body42.preheader ]
  %vec.phi44 = phi <16 x i32> [ %8, %vector.body42 ], [ zeroinitializer, %vector.body42.preheader ]
  %vec.phi45 = phi <16 x i32> [ %9, %vector.body42 ], [ zeroinitializer, %vector.body42.preheader ]
  %vec.phi46 = phi <16 x i32> [ %10, %vector.body42 ], [ zeroinitializer, %vector.body42.preheader ]
  %2 = add nsw i32 %index43, %mul.us
  %3 = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %2
  %wide.load = load <16 x i32>, ptr addrspace(4) %3, align 4, !tbaa !3
  %4 = getelementptr inbounds i32, ptr addrspace(4) %3, i32 16
  %wide.load47 = load <16 x i32>, ptr addrspace(4) %4, align 4, !tbaa !3
  %5 = getelementptr inbounds i32, ptr addrspace(4) %3, i32 32
  %wide.load48 = load <16 x i32>, ptr addrspace(4) %5, align 4, !tbaa !3
  %6 = getelementptr inbounds i32, ptr addrspace(4) %3, i32 48
  %wide.load49 = load <16 x i32>, ptr addrspace(4) %6, align 4, !tbaa !3
  %7 = add <16 x i32> %wide.load, %vec.phi
  %8 = add <16 x i32> %wide.load47, %vec.phi44
  %9 = add <16 x i32> %wide.load48, %vec.phi45
  %10 = add <16 x i32> %wide.load49, %vec.phi46
  %index.next50 = add nuw i32 %index43, 64
  %11 = icmp eq i32 %index.next50, %n.vec40
  br i1 %11, label %middle.block32, label %vector.body42, !llvm.loop !57

middle.block32:                                   ; preds = %vector.body42
  %bin.rdx = add <16 x i32> %8, %7
  %bin.rdx51 = add <16 x i32> %9, %bin.rdx
  %bin.rdx52 = add <16 x i32> %10, %bin.rdx51
  %12 = tail call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %bin.rdx52)
  br i1 %cmp.n41, label %for.cond.cleanup3.us, label %vec.epilog.iter.check55

vec.epilog.iter.check55:                          ; preds = %middle.block32
  br i1 %min.epilog.iters.check58, label %for.body4.us.preheader, label %vec.epilog.ph56

vec.epilog.ph56:                                  ; preds = %iter.check35, %vec.epilog.iter.check55
  %bc.merge.rdx = phi i32 [ 0, %iter.check35 ], [ %12, %vec.epilog.iter.check55 ]
  %vec.epilog.resume.val59 = phi i32 [ 0, %iter.check35 ], [ %n.vec40, %vec.epilog.iter.check55 ]
  %13 = insertelement <8 x i32> <i32 poison, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, i32 %bc.merge.rdx, i64 0
  br label %vec.epilog.vector.body64

vec.epilog.vector.body64:                         ; preds = %vec.epilog.vector.body64, %vec.epilog.ph56
  %index65 = phi i32 [ %vec.epilog.resume.val59, %vec.epilog.ph56 ], [ %index.next68, %vec.epilog.vector.body64 ]
  %vec.phi66 = phi <8 x i32> [ %13, %vec.epilog.ph56 ], [ %16, %vec.epilog.vector.body64 ]
  %14 = add nsw i32 %index65, %mul.us
  %15 = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %14
  %wide.load67 = load <8 x i32>, ptr addrspace(4) %15, align 4, !tbaa !3
  %16 = add <8 x i32> %wide.load67, %vec.phi66
  %index.next68 = add nuw i32 %index65, 8
  %17 = icmp eq i32 %index.next68, %n.vec61
  br i1 %17, label %vec.epilog.middle.block53, label %vec.epilog.vector.body64, !llvm.loop !58

vec.epilog.middle.block53:                        ; preds = %vec.epilog.vector.body64
  %18 = tail call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %16)
  br i1 %cmp.n63, label %for.cond.cleanup3.us, label %for.body4.us.preheader

for.body4.us.preheader:                           ; preds = %vec.epilog.iter.check55, %vec.epilog.middle.block53
  %j.019.us.ph = phi i32 [ %n.vec40, %vec.epilog.iter.check55 ], [ %n.vec61, %vec.epilog.middle.block53 ]
  %acc.018.us.ph = phi i32 [ %12, %vec.epilog.iter.check55 ], [ %18, %vec.epilog.middle.block53 ]
  br label %for.body4.us

iter.check:                                       ; preds = %for.body.lr.ph
  %min.iters.check = icmp ult i32 %M, 8
  br i1 %min.iters.check, label %for.cond.cleanup3.preheader, label %vector.main.loop.iter.check

vector.main.loop.iter.check:                      ; preds = %iter.check
  %min.iters.check26 = icmp ult i32 %M, 64
  br i1 %min.iters.check26, label %vec.epilog.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.main.loop.iter.check
  %n.vec = and i32 %M, -64
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %19 = getelementptr inbounds i32, ptr addrspace(4) %res, i32 %index
  store <16 x i32> zeroinitializer, ptr addrspace(4) %19, align 4, !tbaa !3
  %20 = getelementptr inbounds i32, ptr addrspace(4) %19, i32 16
  store <16 x i32> zeroinitializer, ptr addrspace(4) %20, align 4, !tbaa !3
  %21 = getelementptr inbounds i32, ptr addrspace(4) %19, i32 32
  store <16 x i32> zeroinitializer, ptr addrspace(4) %21, align 4, !tbaa !3
  %22 = getelementptr inbounds i32, ptr addrspace(4) %19, i32 48
  store <16 x i32> zeroinitializer, ptr addrspace(4) %22, align 4, !tbaa !3
  %index.next = add nuw i32 %index, 64
  %23 = icmp eq i32 %index.next, %n.vec
  br i1 %23, label %middle.block, label %vector.body, !llvm.loop !59

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i32 %n.vec, %M
  br i1 %cmp.n, label %for.cond.cleanup, label %vec.epilog.iter.check

vec.epilog.iter.check:                            ; preds = %middle.block
  %n.vec.remaining = and i32 %M, 56
  %min.epilog.iters.check = icmp eq i32 %n.vec.remaining, 0
  br i1 %min.epilog.iters.check, label %for.cond.cleanup3.preheader, label %vec.epilog.ph

vec.epilog.ph:                                    ; preds = %vector.main.loop.iter.check, %vec.epilog.iter.check
  %vec.epilog.resume.val = phi i32 [ %n.vec, %vec.epilog.iter.check ], [ 0, %vector.main.loop.iter.check ]
  %n.vec28 = and i32 %M, -8
  br label %vec.epilog.vector.body

vec.epilog.vector.body:                           ; preds = %vec.epilog.vector.body, %vec.epilog.ph
  %index30 = phi i32 [ %vec.epilog.resume.val, %vec.epilog.ph ], [ %index.next31, %vec.epilog.vector.body ]
  %24 = getelementptr inbounds i32, ptr addrspace(4) %res, i32 %index30
  store <8 x i32> zeroinitializer, ptr addrspace(4) %24, align 4, !tbaa !3
  %index.next31 = add nuw i32 %index30, 8
  %25 = icmp eq i32 %index.next31, %n.vec28
  br i1 %25, label %vec.epilog.middle.block, label %vec.epilog.vector.body, !llvm.loop !60

vec.epilog.middle.block:                          ; preds = %vec.epilog.vector.body
  %cmp.n29 = icmp eq i32 %n.vec28, %M
  br i1 %cmp.n29, label %for.cond.cleanup, label %for.cond.cleanup3.preheader

for.cond.cleanup3.preheader:                      ; preds = %iter.check, %vec.epilog.iter.check, %vec.epilog.middle.block
  %i.021.ph = phi i32 [ 0, %iter.check ], [ %n.vec, %vec.epilog.iter.check ], [ %n.vec28, %vec.epilog.middle.block ]
  br label %for.cond.cleanup3

for.cond.cleanup:                                 ; preds = %for.cond.cleanup3, %for.cond.cleanup3.us, %for.cond.cleanup3.us.loopexit.us, %middle.block, %vec.epilog.middle.block, %entry
  ret void

for.cond.cleanup3:                                ; preds = %for.cond.cleanup3.preheader, %for.cond.cleanup3
  %i.021 = phi i32 [ %inc8, %for.cond.cleanup3 ], [ %i.021.ph, %for.cond.cleanup3.preheader ]
  %arrayidx6 = getelementptr inbounds i32, ptr addrspace(4) %res, i32 %i.021
  store i32 0, ptr addrspace(4) %arrayidx6, align 4, !tbaa !3
  %inc8 = add nuw nsw i32 %i.021, 1
  %cmp = icmp slt i32 %inc8, %M
  br i1 %cmp, label %for.cond.cleanup3, label %for.cond.cleanup, !llvm.loop !61
}

; Function Attrs: nounwind
define dso_local void @vekt_mat_reduce_rows_wrapper(ptr noundef %A, ptr noundef %res, i32 noundef %M, i32 noundef %N) local_unnamed_addr #4 {
entry:
  tail call void @vekt_mat_reduce_rows(i32 noundef %M, i32 noundef %N, ptr noundef %A, ptr noundef %A, i32 noundef 0, i32 noundef %M, i32 noundef %N, i32 noundef %N, i32 noundef 1, ptr noundef %res, ptr noundef %res, i32 noundef 0, i32 noundef %M, i32 noundef 1) #10
  ret void
}

declare void @vekt_mat_reduce_rows(i32 noundef, i32 noundef, ptr noundef, ptr noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef, ptr noundef, ptr noundef, i32 noundef, i32 noundef, i32 noundef) local_unnamed_addr #5

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <16 x i32> @llvm.arc.vvcadd.init.acc.w.v512(<16 x i32>, <16 x i32>) #6

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(read)
declare <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4)) #7

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <16 x i32> @llvm.arc.vvcadd.acc.w.v512(<16 x i32>, <16 x i32>, <16 x i32>) #6

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <16 x i32> @llvm.arc.vvc4add.acc.w.v512(<16 x i32>) #6

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <16 x i32> @llvm.arc.vvc4pack.acc.w.v512(<16 x i32>) #6

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32>) #6

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #8

; Function Attrs: nofree nounwind
declare noundef i32 @putchar(i32 noundef) local_unnamed_addr #8

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.add.v16i32(<16 x i32>) #9

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.add.v8i32(<8 x i32>) #9

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: write) "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #1 = { nofree nounwind "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #2 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite) "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #3 = { mustprogress nofree nosync nounwind willreturn memory(read, argmem: readwrite) "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #4 = { nounwind "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #5 = { "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #6 = { mustprogress nocallback nofree nosync nounwind willreturn memory(none) }
attributes #7 = { mustprogress nocallback nofree nosync nounwind willreturn memory(read) }
attributes #8 = { nofree nounwind }
attributes #9 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
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
!45 = distinct !{!45, !8, !10, !9}
!46 = distinct !{!46, !8}
!47 = distinct !{!47, !8, !9, !10}
!48 = distinct !{!48, !8, !9, !10}
!49 = distinct !{!49, !8, !10, !9}
!50 = distinct !{!50, !8, !9, !10}
!51 = distinct !{!51, !8, !9, !10}
!52 = distinct !{!52, !8, !9, !10}
!53 = distinct !{!53, !8, !9, !10}
!54 = distinct !{!54, !8, !10, !9}
!55 = distinct !{!55, !8, !10, !9}
!56 = distinct !{!56, !8}
!57 = distinct !{!57, !8, !9, !10}
!58 = distinct !{!58, !8, !9, !10}
!59 = distinct !{!59, !8, !9, !10}
!60 = distinct !{!60, !8, !9, !10}
!61 = distinct !{!61, !8, !10, !9}
