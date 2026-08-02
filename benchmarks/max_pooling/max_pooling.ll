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
  %min.iters.check5 = icmp ult i32 %mul, 16
  br i1 %min.iters.check5, label %vec.epilog.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.main.loop.iter.check
  %n.vec = and i32 %mul, -16
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
  %cmp.n = icmp eq i32 %mul, %n.vec
  br i1 %cmp.n, label %for.cond.cleanup, label %vec.epilog.iter.check

vec.epilog.iter.check:                            ; preds = %middle.block
  %n.vec.remaining = and i32 %mul, 8
  %min.epilog.iters.check.not.not = icmp eq i32 %n.vec.remaining, 0
  br i1 %min.epilog.iters.check.not.not, label %for.body.preheader, label %vec.epilog.ph

vec.epilog.ph:                                    ; preds = %vector.main.loop.iter.check, %vec.epilog.iter.check
  %vec.epilog.resume.val = phi i32 [ %n.vec, %vec.epilog.iter.check ], [ 0, %vector.main.loop.iter.check ]
  %n.vec7 = and i32 %mul, -8
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
  %cmp.n8 = icmp eq i32 %mul, %n.vec7
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
  %cmp = icmp slt i32 %inc, %mul
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !13
}

; Function Attrs: nofree nounwind
define dso_local void @check_result(ptr nocapture noundef readonly %A, ptr nocapture noundef readonly %B, i32 noundef %M, i32 noundef %N) local_unnamed_addr #1 {
entry:
  %cmp48 = icmp sgt i32 %M, 0
  br i1 %cmp48, label %for.body.lr.ph, label %for.end20

for.body.lr.ph:                                   ; preds = %entry
  %cmp245 = icmp sgt i32 %N, 0
  br label %for.body

for.body:                                         ; preds = %for.body.lr.ph, %for.inc16
  %i.049 = phi i32 [ 0, %for.body.lr.ph ], [ %inc17, %for.inc16 ]
  br i1 %cmp245, label %for.body4.lr.ph, label %for.inc16

for.body4.lr.ph:                                  ; preds = %for.body
  %mul = mul nsw i32 %i.049, %N
  br label %for.body4

for.body4:                                        ; preds = %for.body4.lr.ph, %for.inc
  %j.046 = phi i32 [ 0, %for.body4.lr.ph ], [ %inc, %for.inc ]
  %add = add nsw i32 %j.046, %mul
  %arrayidx = getelementptr inbounds i32, ptr %A, i32 %add
  %0 = load i32, ptr %arrayidx, align 4, !tbaa !3
  %arrayidx7 = getelementptr inbounds i32, ptr %B, i32 %add
  %1 = load i32, ptr %arrayidx7, align 4, !tbaa !3
  %cmp8.not = icmp eq i32 %0, %1
  br i1 %cmp8.not, label %for.inc, label %if.then

if.then:                                          ; preds = %for.body4
  %puts41 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.9)
  %2 = load i32, ptr %arrayidx, align 4, !tbaa !3
  %3 = load i32, ptr %arrayidx7, align 4, !tbaa !3
  %call15 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.1, i32 noundef %i.049, i32 noundef %j.046, i32 noundef %2, i32 noundef %3)
  br label %return

for.inc:                                          ; preds = %for.body4
  %inc = add nuw nsw i32 %j.046, 1
  %cmp2 = icmp slt i32 %inc, %N
  br i1 %cmp2, label %for.body4, label %for.inc16, !llvm.loop !14

for.inc16:                                        ; preds = %for.inc, %for.body
  %inc17 = add nuw nsw i32 %i.049, 1
  %cmp = icmp slt i32 %inc17, %M
  br i1 %cmp, label %for.body, label %for.end20, !llvm.loop !15

for.end20:                                        ; preds = %for.inc16, %entry
  %puts = tail call i32 @puts(ptr nonnull dereferenceable(1) @str)
  br label %return

return:                                           ; preds = %if.then, %for.end20
  ret void
}

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #1

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local ptr @copy_matrix(ptr noundef returned writeonly %dst, ptr nocapture noundef readonly %src, i32 noundef %M, i32 noundef %N) local_unnamed_addr #2 {
entry:
  %cmp22 = icmp sgt i32 %M, 0
  br i1 %cmp22, label %for.body.lr.ph, label %for.cond.cleanup

for.body.lr.ph:                                   ; preds = %entry
  %cmp220 = icmp sgt i32 %N, 0
  %0 = shl i32 %N, 2
  %min.iters.check = icmp ult i32 %N, 8
  %min.iters.check27 = icmp ult i32 %N, 16
  %n.vec = and i32 %N, -16
  %cmp.n = icmp eq i32 %n.vec, %N
  %n.vec.remaining = and i32 %N, 8
  %min.epilog.iters.check.not.not = icmp eq i32 %n.vec.remaining, 0
  %n.vec29 = and i32 %N, -8
  %cmp.n30 = icmp eq i32 %n.vec29, %N
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.cond.cleanup3, %entry
  ret ptr %dst

for.body:                                         ; preds = %for.body.lr.ph, %for.cond.cleanup3
  %i.023 = phi i32 [ 0, %for.body.lr.ph ], [ %inc9, %for.cond.cleanup3 ]
  %1 = mul i32 %0, %i.023
  %scevgep = getelementptr i8, ptr %dst, i32 %1
  %2 = add i32 %0, %1
  %scevgep24 = getelementptr i8, ptr %dst, i32 %2
  %scevgep25 = getelementptr i8, ptr %src, i32 %1
  %scevgep26 = getelementptr i8, ptr %src, i32 %2
  br i1 %cmp220, label %iter.check, label %for.cond.cleanup3

iter.check:                                       ; preds = %for.body
  %mul = mul nsw i32 %i.023, %N
  br i1 %min.iters.check, label %for.body4.preheader, label %vector.memcheck

vector.memcheck:                                  ; preds = %iter.check
  %bound0 = icmp ult ptr %scevgep, %scevgep26
  %bound1 = icmp ult ptr %scevgep25, %scevgep24
  %found.conflict = and i1 %bound0, %bound1
  br i1 %found.conflict, label %for.body4.preheader, label %vector.main.loop.iter.check

vector.main.loop.iter.check:                      ; preds = %vector.memcheck
  br i1 %min.iters.check27, label %vec.epilog.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.main.loop.iter.check
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %3 = add nsw i32 %index, %mul
  %4 = getelementptr inbounds i32, ptr %src, i32 %3
  %wide.load = load <16 x i32>, ptr %4, align 4, !tbaa !3, !alias.scope !16
  %5 = getelementptr inbounds i32, ptr %dst, i32 %3
  store <16 x i32> %wide.load, ptr %5, align 4, !tbaa !3, !alias.scope !19, !noalias !16
  %index.next = add nuw i32 %index, 16
  %6 = icmp eq i32 %index.next, %n.vec
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !21

middle.block:                                     ; preds = %vector.body
  br i1 %cmp.n, label %for.cond.cleanup3, label %vec.epilog.iter.check

vec.epilog.iter.check:                            ; preds = %middle.block
  br i1 %min.epilog.iters.check.not.not, label %for.body4.preheader, label %vec.epilog.ph

vec.epilog.ph:                                    ; preds = %vector.main.loop.iter.check, %vec.epilog.iter.check
  %vec.epilog.resume.val = phi i32 [ %n.vec, %vec.epilog.iter.check ], [ 0, %vector.main.loop.iter.check ]
  br label %vec.epilog.vector.body

vec.epilog.vector.body:                           ; preds = %vec.epilog.vector.body, %vec.epilog.ph
  %index31 = phi i32 [ %vec.epilog.resume.val, %vec.epilog.ph ], [ %index.next33, %vec.epilog.vector.body ]
  %7 = add nsw i32 %index31, %mul
  %8 = getelementptr inbounds i32, ptr %src, i32 %7
  %wide.load32 = load <8 x i32>, ptr %8, align 4, !tbaa !3, !alias.scope !22
  %9 = getelementptr inbounds i32, ptr %dst, i32 %7
  store <8 x i32> %wide.load32, ptr %9, align 4, !tbaa !3, !alias.scope !25, !noalias !22
  %index.next33 = add nuw i32 %index31, 8
  %10 = icmp eq i32 %index.next33, %n.vec29
  br i1 %10, label %vec.epilog.middle.block, label %vec.epilog.vector.body, !llvm.loop !27

vec.epilog.middle.block:                          ; preds = %vec.epilog.vector.body
  br i1 %cmp.n30, label %for.cond.cleanup3, label %for.body4.preheader

for.body4.preheader:                              ; preds = %vector.memcheck, %iter.check, %vec.epilog.iter.check, %vec.epilog.middle.block
  %j.021.ph = phi i32 [ 0, %iter.check ], [ 0, %vector.memcheck ], [ %n.vec, %vec.epilog.iter.check ], [ %n.vec29, %vec.epilog.middle.block ]
  br label %for.body4

for.cond.cleanup3:                                ; preds = %for.body4, %middle.block, %vec.epilog.middle.block, %for.body
  %inc9 = add nuw nsw i32 %i.023, 1
  %cmp = icmp slt i32 %inc9, %M
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !28

for.body4:                                        ; preds = %for.body4.preheader, %for.body4
  %j.021 = phi i32 [ %inc, %for.body4 ], [ %j.021.ph, %for.body4.preheader ]
  %add = add nsw i32 %j.021, %mul
  %arrayidx = getelementptr inbounds i32, ptr %src, i32 %add
  %11 = load i32, ptr %arrayidx, align 4, !tbaa !3
  %arrayidx7 = getelementptr inbounds i32, ptr %dst, i32 %add
  store i32 %11, ptr %arrayidx7, align 4, !tbaa !3
  %inc = add nuw nsw i32 %j.021, 1
  %cmp2 = icmp slt i32 %inc, %N
  br i1 %cmp2, label %for.body4, label %for.cond.cleanup3, !llvm.loop !29
}

; Function Attrs: nofree nounwind
define dso_local void @print_matrix(ptr nocapture noundef readonly %A, i32 noundef %M, i32 noundef %N) local_unnamed_addr #1 {
entry:
  %puts = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.10)
  %cmp32 = icmp sgt i32 %M, 0
  br i1 %cmp32, label %for.body.lr.ph, label %for.cond.cleanup

for.body.lr.ph:                                   ; preds = %entry
  %cmp330 = icmp sgt i32 %N, 0
  %sub = add nsw i32 %N, -1
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.cond.cleanup4, %entry
  %puts28 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.11)
  ret void

for.body:                                         ; preds = %for.body.lr.ph, %for.cond.cleanup4
  %i.033 = phi i32 [ 0, %for.body.lr.ph ], [ %inc14, %for.cond.cleanup4 ]
  %call1 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.4)
  br i1 %cmp330, label %for.body5.lr.ph, label %for.cond.cleanup4

for.body5.lr.ph:                                  ; preds = %for.body
  %mul.mul8 = mul nsw i32 %i.033, %N
  br label %for.body5

for.cond.cleanup4:                                ; preds = %for.body5, %for.body
  %puts29 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.12)
  %inc14 = add nuw nsw i32 %i.033, 1
  %cmp = icmp slt i32 %inc14, %M
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !30

for.body5:                                        ; preds = %for.body5.lr.ph, %for.body5
  %j.031 = phi i32 [ 0, %for.body5.lr.ph ], [ %inc, %for.body5 ]
  %cmp6 = icmp eq i32 %j.031, %sub
  %.str.5..str.6 = select i1 %cmp6, ptr @.str.5, ptr @.str.6
  %add = add nsw i32 %j.031, %mul.mul8
  %arrayidx = getelementptr inbounds i32, ptr %A, i32 %add
  %0 = load i32, ptr %arrayidx, align 4, !tbaa !3
  %call7 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) %.str.5..str.6, i32 noundef %0)
  %inc = add nuw nsw i32 %j.031, 1
  %cmp3 = icmp slt i32 %inc, %N
  br i1 %cmp3, label %for.body5, label %for.cond.cleanup4, !llvm.loop !31
}

; Function Attrs: mustprogress nofree nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @max_pooling(i32 noundef %rows_out, i32 noundef %cols_out, i32 noundef %rows_in, i32 noundef %cols_in, i32 noundef %W, ptr nocapture noundef writeonly %output, ptr nocapture noundef readonly %input) local_unnamed_addr #3 {
entry:
  %cmp80 = icmp sgt i32 %rows_out, 0
  br i1 %cmp80, label %for.body.lr.ph, label %for.cond.cleanup

for.body.lr.ph:                                   ; preds = %entry
  %cmp278 = icmp sgt i32 %cols_out, 0
  %cmp874 = icmp sgt i32 %W, 0
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.cond.cleanup3, %entry
  ret void

for.body:                                         ; preds = %for.body.lr.ph, %for.cond.cleanup3
  %i.081 = phi i32 [ 0, %for.body.lr.ph ], [ %inc40, %for.cond.cleanup3 ]
  br i1 %cmp278, label %for.body4.lr.ph, label %for.cond.cleanup3

for.body4.lr.ph:                                  ; preds = %for.body
  %mul = mul nsw i32 %i.081, %W
  %mul5 = mul nsw i32 %mul, %cols_in
  %mul33 = mul nsw i32 %i.081, %cols_out
  br label %for.body4

for.cond.cleanup3:                                ; preds = %for.cond.cleanup9, %for.body
  %inc40 = add nuw nsw i32 %i.081, 1
  %cmp = icmp slt i32 %inc40, %rows_out
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !32

for.body4:                                        ; preds = %for.body4.lr.ph, %for.cond.cleanup9
  %j.079 = phi i32 [ 0, %for.body4.lr.ph ], [ %inc37, %for.cond.cleanup9 ]
  %mul6 = mul nsw i32 %j.079, %W
  %add = add nsw i32 %mul6, %mul5
  %arrayidx = getelementptr inbounds i32, ptr %input, i32 %add
  %0 = load i32, ptr %arrayidx, align 4, !tbaa !3
  br i1 %cmp874, label %for.body10.preheader, label %for.cond.cleanup9

for.body10.preheader:                             ; preds = %for.body4
  br label %for.body10

for.cond.cleanup9:                                ; preds = %for.cond.cleanup13, %for.body4
  %max.0.lcssa = phi i32 [ %0, %for.body4 ], [ %spec.select, %for.cond.cleanup13 ]
  %add34 = add nsw i32 %j.079, %mul33
  %arrayidx35 = getelementptr inbounds i32, ptr %output, i32 %add34
  store i32 %max.0.lcssa, ptr %arrayidx35, align 4, !tbaa !3
  %inc37 = add nuw nsw i32 %j.079, 1
  %cmp2 = icmp slt i32 %inc37, %cols_out
  br i1 %cmp2, label %for.body4, label %for.cond.cleanup3, !llvm.loop !37

for.body10:                                       ; preds = %for.body10.preheader, %for.cond.cleanup13
  %w_i.076 = phi i32 [ %inc31, %for.cond.cleanup13 ], [ 0, %for.body10.preheader ]
  %max.075 = phi i32 [ %spec.select, %for.cond.cleanup13 ], [ %0, %for.body10.preheader ]
  %add16 = add nsw i32 %w_i.076, %mul
  %mul17 = mul nsw i32 %add16, %cols_in
  %add19 = add i32 %mul17, %mul6
  br label %for.body14

for.cond.cleanup13:                               ; preds = %for.body14
  %inc31 = add nuw nsw i32 %w_i.076, 1
  %cmp8 = icmp slt i32 %inc31, %W
  br i1 %cmp8, label %for.body10, label %for.cond.cleanup9, !llvm.loop !40

for.body14:                                       ; preds = %for.body10, %for.body14
  %w_j.073 = phi i32 [ 0, %for.body10 ], [ %inc, %for.body14 ]
  %max.172 = phi i32 [ %max.075, %for.body10 ], [ %spec.select, %for.body14 ]
  %add20 = add i32 %add19, %w_j.073
  %arrayidx21 = getelementptr inbounds i32, ptr %input, i32 %add20
  %1 = load i32, ptr %arrayidx21, align 4, !tbaa !3
  %spec.select = tail call i32 @llvm.smax.i32(i32 %1, i32 %max.172)
  %inc = add nuw nsw i32 %w_j.073, 1
  %cmp12 = icmp slt i32 %inc, %W
  br i1 %cmp12, label %for.body14, label %for.cond.cleanup13, !llvm.loop !43
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define dso_local void @vectorized_max_pooling(i32 noundef %rows_out, i32 noundef %cols_out, i32 noundef %rows_in, i32 noundef %cols_in, i32 noundef %W, ptr addrspace(4) noalias nocapture noundef %output, ptr addrspace(4) noalias nocapture noundef %input) local_unnamed_addr #4 {
entry:
  ret void
}

; Function Attrs: mustprogress nofree nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @autovectorized_max_pooling(i32 noundef %rows_out, i32 noundef %cols_out, i32 noundef %rows_in, i32 noundef %cols_in, i32 noundef %W, ptr addrspace(4) noalias nocapture noundef writeonly %output, ptr addrspace(4) noalias nocapture noundef readonly %input) local_unnamed_addr #3 {
entry:
  %cmp80 = icmp sgt i32 %rows_out, 0
  br i1 %cmp80, label %for.body.lr.ph, label %for.cond.cleanup

for.body.lr.ph:                                   ; preds = %entry
  %cmp278 = icmp sgt i32 %cols_out, 0
  %cmp874 = icmp sgt i32 %W, 0
  %min.iters.check = icmp ult i32 %W, 8
  %min.iters.check82 = icmp ult i32 %W, 16
  %n.vec = and i32 %W, -16
  %cmp.n = icmp eq i32 %n.vec, %W
  %n.vec.remaining = and i32 %W, 8
  %min.epilog.iters.check.not.not = icmp eq i32 %n.vec.remaining, 0
  %n.vec84 = and i32 %W, -8
  %cmp.n85 = icmp eq i32 %n.vec84, %W
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.cond.cleanup3, %entry
  ret void

for.body:                                         ; preds = %for.body.lr.ph, %for.cond.cleanup3
  %i.081 = phi i32 [ 0, %for.body.lr.ph ], [ %inc40, %for.cond.cleanup3 ]
  br i1 %cmp278, label %for.body4.lr.ph, label %for.cond.cleanup3

for.body4.lr.ph:                                  ; preds = %for.body
  %mul = mul nsw i32 %i.081, %W
  %mul5 = mul nsw i32 %mul, %cols_in
  %mul33 = mul nsw i32 %i.081, %cols_out
  br label %for.body4

for.cond.cleanup3:                                ; preds = %for.cond.cleanup9, %for.body
  %inc40 = add nuw nsw i32 %i.081, 1
  %cmp = icmp slt i32 %inc40, %rows_out
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !46

for.body4:                                        ; preds = %for.body4.lr.ph, %for.cond.cleanup9
  %j.079 = phi i32 [ 0, %for.body4.lr.ph ], [ %inc37, %for.cond.cleanup9 ]
  %mul6 = mul nsw i32 %j.079, %W
  %add = add nsw i32 %mul6, %mul5
  %arrayidx = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %add
  %0 = load i32, ptr addrspace(4) %arrayidx, align 4, !tbaa !3
  br i1 %cmp874, label %iter.check.preheader, label %for.cond.cleanup9

iter.check.preheader:                             ; preds = %for.body4
  br label %iter.check

for.cond.cleanup9:                                ; preds = %for.cond.cleanup13, %for.body4
  %max.0.lcssa = phi i32 [ %0, %for.body4 ], [ %spec.select.lcssa, %for.cond.cleanup13 ]
  %add34 = add nsw i32 %j.079, %mul33
  %arrayidx35 = getelementptr inbounds i32, ptr addrspace(4) %output, i32 %add34
  store i32 %max.0.lcssa, ptr addrspace(4) %arrayidx35, align 4, !tbaa !3
  %inc37 = add nuw nsw i32 %j.079, 1
  %cmp2 = icmp slt i32 %inc37, %cols_out
  br i1 %cmp2, label %for.body4, label %for.cond.cleanup3, !llvm.loop !47

iter.check:                                       ; preds = %iter.check.preheader, %for.cond.cleanup13
  %w_i.076 = phi i32 [ %inc31, %for.cond.cleanup13 ], [ 0, %iter.check.preheader ]
  %max.075 = phi i32 [ %spec.select.lcssa, %for.cond.cleanup13 ], [ %0, %iter.check.preheader ]
  %add16 = add nsw i32 %w_i.076, %mul
  %mul17 = mul nsw i32 %add16, %cols_in
  %add19 = add i32 %mul17, %mul6
  br i1 %min.iters.check, label %for.body14.preheader, label %vector.main.loop.iter.check

vector.main.loop.iter.check:                      ; preds = %iter.check
  br i1 %min.iters.check82, label %vec.epilog.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.main.loop.iter.check
  %minmax.ident.splatinsert = insertelement <16 x i32> poison, i32 %max.075, i64 0
  %minmax.ident.splat = shufflevector <16 x i32> %minmax.ident.splatinsert, <16 x i32> poison, <16 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi <16 x i32> [ %minmax.ident.splat, %vector.ph ], [ %3, %vector.body ]
  %1 = add i32 %add19, %index
  %2 = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %1
  %wide.load = load <16 x i32>, ptr addrspace(4) %2, align 4, !tbaa !3
  %3 = tail call <16 x i32> @llvm.smax.v16i32(<16 x i32> %wide.load, <16 x i32> %vec.phi)
  %index.next = add nuw i32 %index, 16
  %4 = icmp eq i32 %index.next, %n.vec
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !48

middle.block:                                     ; preds = %vector.body
  %5 = tail call i32 @llvm.vector.reduce.smax.v16i32(<16 x i32> %3)
  br i1 %cmp.n, label %for.cond.cleanup13, label %vec.epilog.iter.check

vec.epilog.iter.check:                            ; preds = %middle.block
  br i1 %min.epilog.iters.check.not.not, label %for.body14.preheader, label %vec.epilog.ph

vec.epilog.ph:                                    ; preds = %vector.main.loop.iter.check, %vec.epilog.iter.check
  %bc.merge.rdx = phi i32 [ %max.075, %vector.main.loop.iter.check ], [ %5, %vec.epilog.iter.check ]
  %vec.epilog.resume.val = phi i32 [ 0, %vector.main.loop.iter.check ], [ %n.vec, %vec.epilog.iter.check ]
  %minmax.ident.splatinsert88 = insertelement <8 x i32> poison, i32 %bc.merge.rdx, i64 0
  %minmax.ident.splat89 = shufflevector <8 x i32> %minmax.ident.splatinsert88, <8 x i32> poison, <8 x i32> zeroinitializer
  br label %vec.epilog.vector.body

vec.epilog.vector.body:                           ; preds = %vec.epilog.vector.body, %vec.epilog.ph
  %index86 = phi i32 [ %vec.epilog.resume.val, %vec.epilog.ph ], [ %index.next91, %vec.epilog.vector.body ]
  %vec.phi87 = phi <8 x i32> [ %minmax.ident.splat89, %vec.epilog.ph ], [ %8, %vec.epilog.vector.body ]
  %6 = add i32 %add19, %index86
  %7 = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %6
  %wide.load90 = load <8 x i32>, ptr addrspace(4) %7, align 4, !tbaa !3
  %8 = tail call <8 x i32> @llvm.smax.v8i32(<8 x i32> %wide.load90, <8 x i32> %vec.phi87)
  %index.next91 = add nuw i32 %index86, 8
  %9 = icmp eq i32 %index.next91, %n.vec84
  br i1 %9, label %vec.epilog.middle.block, label %vec.epilog.vector.body, !llvm.loop !49

vec.epilog.middle.block:                          ; preds = %vec.epilog.vector.body
  %10 = tail call i32 @llvm.vector.reduce.smax.v8i32(<8 x i32> %8)
  br i1 %cmp.n85, label %for.cond.cleanup13, label %for.body14.preheader

for.body14.preheader:                             ; preds = %iter.check, %vec.epilog.iter.check, %vec.epilog.middle.block
  %w_j.073.ph = phi i32 [ 0, %iter.check ], [ %n.vec, %vec.epilog.iter.check ], [ %n.vec84, %vec.epilog.middle.block ]
  %max.172.ph = phi i32 [ %max.075, %iter.check ], [ %5, %vec.epilog.iter.check ], [ %10, %vec.epilog.middle.block ]
  br label %for.body14

for.cond.cleanup13:                               ; preds = %for.body14, %vec.epilog.middle.block, %middle.block
  %spec.select.lcssa = phi i32 [ %5, %middle.block ], [ %10, %vec.epilog.middle.block ], [ %spec.select, %for.body14 ]
  %inc31 = add nuw nsw i32 %w_i.076, 1
  %cmp8 = icmp slt i32 %inc31, %W
  br i1 %cmp8, label %iter.check, label %for.cond.cleanup9, !llvm.loop !50

for.body14:                                       ; preds = %for.body14.preheader, %for.body14
  %w_j.073 = phi i32 [ %inc, %for.body14 ], [ %w_j.073.ph, %for.body14.preheader ]
  %max.172 = phi i32 [ %spec.select, %for.body14 ], [ %max.172.ph, %for.body14.preheader ]
  %add20 = add i32 %add19, %w_j.073
  %arrayidx21 = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %add20
  %11 = load i32, ptr addrspace(4) %arrayidx21, align 4, !tbaa !3
  %spec.select = tail call i32 @llvm.smax.i32(i32 %11, i32 %max.172)
  %inc = add nuw nsw i32 %w_j.073, 1
  %cmp12 = icmp slt i32 %inc, %W
  br i1 %cmp12, label %for.body14, label %for.cond.cleanup13, !llvm.loop !51
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define dso_local void @vekt_max_pooling_wrapper(i32 noundef %rows_out, i32 noundef %cols_out, i32 noundef %rows_in, i32 noundef %cols_in, i32 noundef %W, ptr nocapture noundef %output, ptr nocapture noundef %input) local_unnamed_addr #4 {
entry:
  ret void
}

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #5

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smax.i32(i32, i32) #6

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <16 x i32> @llvm.smax.v16i32(<16 x i32>, <16 x i32>) #6

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.smax.v16i32(<16 x i32>) #6

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <8 x i32> @llvm.smax.v8i32(<8 x i32>, <8 x i32>) #6

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.smax.v8i32(<8 x i32>) #6

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: write) "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #1 = { nofree nounwind "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #2 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite) "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #3 = { mustprogress nofree nosync nounwind willreturn memory(argmem: readwrite) "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
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
!7 = distinct !{!7, !8, !9, !9, !10, !11}
!8 = !{!"llvm.loop.mustprogress"}
!9 = !{!"llvm.loop.unroll.disable"}
!10 = !{!"llvm.loop.isvectorized", i32 1}
!11 = !{!"llvm.loop.unroll.runtime.disable"}
!12 = distinct !{!12, !8, !9, !9, !10, !11}
!13 = distinct !{!13, !8, !9, !9, !10}
!14 = distinct !{!14, !8, !9, !9}
!15 = distinct !{!15, !8, !9, !9}
!16 = !{!17}
!17 = distinct !{!17, !18}
!18 = distinct !{!18, !"LVerDomain"}
!19 = !{!20}
!20 = distinct !{!20, !18}
!21 = distinct !{!21, !8, !9, !9, !10, !11}
!22 = !{!23}
!23 = distinct !{!23, !24}
!24 = distinct !{!24, !"LVerDomain"}
!25 = !{!26}
!26 = distinct !{!26, !24}
!27 = distinct !{!27, !8, !9, !9, !10, !11}
!28 = distinct !{!28, !8, !9, !9}
!29 = distinct !{!29, !8, !9, !9, !10}
!30 = distinct !{!30, !8, !9, !9}
!31 = distinct !{!31, !8, !9, !9}
!32 = distinct !{!32, !8, !9, !9, !33, !34}
!33 = !{!"llvm.loop.vectorize.width", i32 1}
!34 = !{!"llvm.loop.vectorize.followup_all", !35}
!35 = distinct !{!35, !8, !9, !9, !36}
!36 = !{!"llvm.loop.isvectorized"}
!37 = distinct !{!37, !8, !9, !9, !33, !38}
!38 = !{!"llvm.loop.vectorize.followup_all", !39}
!39 = distinct !{!39, !8, !9, !9, !36}
!40 = distinct !{!40, !8, !9, !9, !33, !41}
!41 = !{!"llvm.loop.vectorize.followup_all", !42}
!42 = distinct !{!42, !8, !9, !9, !36}
!43 = distinct !{!43, !8, !9, !9, !33, !44}
!44 = !{!"llvm.loop.vectorize.followup_all", !45}
!45 = distinct !{!45, !8, !9, !9, !36}
!46 = distinct !{!46, !8, !9, !9}
!47 = distinct !{!47, !8, !9, !9}
!48 = distinct !{!48, !8, !9, !9, !10, !11}
!49 = distinct !{!49, !8, !9, !9, !10, !11}
!50 = distinct !{!50, !8, !9, !9}
!51 = distinct !{!51, !8, !9, !9, !10}
