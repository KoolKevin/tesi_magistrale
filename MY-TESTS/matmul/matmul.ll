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
  br i1 %cmp50, label %for.body.lr.ph, label %for.end20

for.body.lr.ph:                                   ; preds = %entry
  %cmp248 = icmp sgt i32 %N, 0
  br label %for.body

for.body:                                         ; preds = %for.body.lr.ph, %for.inc16
  %i.051 = phi i32 [ 0, %for.body.lr.ph ], [ %inc17, %for.inc16 ]
  br i1 %cmp248, label %for.body4.lr.ph, label %for.inc16

for.body4.lr.ph:                                  ; preds = %for.body
  %mul = mul nsw i32 %i.051, %N
  br label %for.body4

for.body4:                                        ; preds = %for.body4.lr.ph, %for.inc
  %j.049 = phi i32 [ 0, %for.body4.lr.ph ], [ %inc, %for.inc ]
  %add = add nsw i32 %j.049, %mul
  %arrayidx = getelementptr inbounds i32, ptr %A, i32 %add
  %0 = load i32, ptr %arrayidx, align 4, !tbaa !3
  %arrayidx7 = getelementptr inbounds i32, ptr %B, i32 %add
  %1 = load i32, ptr %arrayidx7, align 4, !tbaa !3
  %cmp8.not = icmp eq i32 %0, %1
  br i1 %cmp8.not, label %for.inc, label %cleanup18

for.inc:                                          ; preds = %for.body4
  %inc = add nuw nsw i32 %j.049, 1
  %cmp2 = icmp slt i32 %inc, %N
  br i1 %cmp2, label %for.body4, label %for.inc16, !llvm.loop !13

for.inc16:                                        ; preds = %for.inc, %for.body
  %inc17 = add nuw nsw i32 %i.051, 1
  %cmp = icmp slt i32 %inc17, %M
  br i1 %cmp, label %for.body, label %for.end20, !llvm.loop !14

cleanup18:                                        ; preds = %for.body4
  %puts41 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.9)
  %2 = load i32, ptr %arrayidx, align 4, !tbaa !3
  %3 = load i32, ptr %arrayidx7, align 4, !tbaa !3
  %call15 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.1, i32 noundef %i.051, i32 noundef %j.049, i32 noundef %2, i32 noundef %3)
  br label %return

for.end20:                                        ; preds = %for.inc16, %entry
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
  br i1 %cmp22, label %for.body.lr.ph, label %for.cond.cleanup

for.body.lr.ph:                                   ; preds = %entry
  %cmp220 = icmp sgt i32 %N, 0
  %0 = shl i32 %N, 2
  %min.iters.check = icmp ult i32 %N, 8
  %min.iters.check27 = icmp ult i32 %N, 64
  %n.vec = and i32 %N, -64
  %cmp.n = icmp eq i32 %n.vec, %N
  %n.vec.remaining = and i32 %N, 56
  %min.epilog.iters.check = icmp eq i32 %n.vec.remaining, 0
  %n.vec32 = and i32 %N, -8
  %cmp.n33 = icmp eq i32 %n.vec32, %N
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
  br i1 %min.iters.check27, label %vec.epilog.vector.body.preheader, label %vector.body.preheader

vector.body.preheader:                            ; preds = %vector.main.loop.iter.check
  br label %vector.body

vector.body:                                      ; preds = %vector.body.preheader, %vector.body
  %index = phi i32 [ %index.next, %vector.body ], [ 0, %vector.body.preheader ]
  %3 = add nsw i32 %index, %mul
  %4 = getelementptr inbounds i32, ptr %src, i32 %3
  %wide.load = load <16 x i32>, ptr %4, align 4, !tbaa !3, !alias.scope !15
  %5 = getelementptr inbounds i32, ptr %4, i32 16
  %wide.load28 = load <16 x i32>, ptr %5, align 4, !tbaa !3, !alias.scope !15
  %6 = getelementptr inbounds i32, ptr %4, i32 32
  %wide.load29 = load <16 x i32>, ptr %6, align 4, !tbaa !3, !alias.scope !15
  %7 = getelementptr inbounds i32, ptr %4, i32 48
  %wide.load30 = load <16 x i32>, ptr %7, align 4, !tbaa !3, !alias.scope !15
  %8 = getelementptr inbounds i32, ptr %dst, i32 %3
  store <16 x i32> %wide.load, ptr %8, align 4, !tbaa !3, !alias.scope !18, !noalias !15
  %9 = getelementptr inbounds i32, ptr %8, i32 16
  store <16 x i32> %wide.load28, ptr %9, align 4, !tbaa !3, !alias.scope !18, !noalias !15
  %10 = getelementptr inbounds i32, ptr %8, i32 32
  store <16 x i32> %wide.load29, ptr %10, align 4, !tbaa !3, !alias.scope !18, !noalias !15
  %11 = getelementptr inbounds i32, ptr %8, i32 48
  store <16 x i32> %wide.load30, ptr %11, align 4, !tbaa !3, !alias.scope !18, !noalias !15
  %index.next = add nuw i32 %index, 64
  %12 = icmp eq i32 %index.next, %n.vec
  br i1 %12, label %middle.block, label %vector.body, !llvm.loop !20

middle.block:                                     ; preds = %vector.body
  br i1 %cmp.n, label %for.cond.cleanup3, label %vec.epilog.iter.check

vec.epilog.iter.check:                            ; preds = %middle.block
  br i1 %min.epilog.iters.check, label %for.body4.preheader, label %vec.epilog.vector.body.preheader

vec.epilog.vector.body.preheader:                 ; preds = %vector.main.loop.iter.check, %vec.epilog.iter.check
  %index34.ph = phi i32 [ 0, %vector.main.loop.iter.check ], [ %n.vec, %vec.epilog.iter.check ]
  br label %vec.epilog.vector.body

vec.epilog.vector.body:                           ; preds = %vec.epilog.vector.body.preheader, %vec.epilog.vector.body
  %index34 = phi i32 [ %index.next36, %vec.epilog.vector.body ], [ %index34.ph, %vec.epilog.vector.body.preheader ]
  %13 = add nsw i32 %index34, %mul
  %14 = getelementptr inbounds i32, ptr %src, i32 %13
  %wide.load35 = load <8 x i32>, ptr %14, align 4, !tbaa !3, !alias.scope !21
  %15 = getelementptr inbounds i32, ptr %dst, i32 %13
  store <8 x i32> %wide.load35, ptr %15, align 4, !tbaa !3, !alias.scope !24, !noalias !21
  %index.next36 = add nuw i32 %index34, 8
  %16 = icmp eq i32 %index.next36, %n.vec32
  br i1 %16, label %vec.epilog.middle.block, label %vec.epilog.vector.body, !llvm.loop !26

vec.epilog.middle.block:                          ; preds = %vec.epilog.vector.body
  br i1 %cmp.n33, label %for.cond.cleanup3, label %for.body4.preheader

for.body4.preheader:                              ; preds = %vector.memcheck, %iter.check, %vec.epilog.iter.check, %vec.epilog.middle.block
  %j.021.ph = phi i32 [ 0, %iter.check ], [ 0, %vector.memcheck ], [ %n.vec, %vec.epilog.iter.check ], [ %n.vec32, %vec.epilog.middle.block ]
  br label %for.body4

for.cond.cleanup3:                                ; preds = %for.body4, %middle.block, %vec.epilog.middle.block, %for.body
  %inc9 = add nuw nsw i32 %i.023, 1
  %cmp = icmp slt i32 %inc9, %M
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !27

for.body4:                                        ; preds = %for.body4.preheader, %for.body4
  %j.021 = phi i32 [ %inc, %for.body4 ], [ %j.021.ph, %for.body4.preheader ]
  %add = add nsw i32 %j.021, %mul
  %arrayidx = getelementptr inbounds i32, ptr %src, i32 %add
  %17 = load i32, ptr %arrayidx, align 4, !tbaa !3
  %arrayidx7 = getelementptr inbounds i32, ptr %dst, i32 %add
  store i32 %17, ptr %arrayidx7, align 4, !tbaa !3
  %inc = add nuw nsw i32 %j.021, 1
  %cmp2 = icmp slt i32 %inc, %N
  br i1 %cmp2, label %for.body4, label %for.cond.cleanup3, !llvm.loop !28
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
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.cond.cleanup4, %entry
  %puts24 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.11)
  ret void

for.body:                                         ; preds = %for.body.lr.ph, %for.cond.cleanup4
  %i.029 = phi i32 [ 0, %for.body.lr.ph ], [ %inc14, %for.cond.cleanup4 ]
  %call1 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.4)
  br i1 %cmp326, label %for.body5.lr.ph, label %for.cond.cleanup4

for.body5.lr.ph:                                  ; preds = %for.body
  %mul = mul nsw i32 %i.029, %N
  br label %for.body5

for.cond.cleanup4:                                ; preds = %for.inc, %for.body
  %puts25 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.12)
  %inc14 = add nuw nsw i32 %i.029, 1
  %cmp = icmp slt i32 %inc14, %M
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !29

for.body5:                                        ; preds = %for.body5.lr.ph, %for.inc
  %j.027 = phi i32 [ 0, %for.body5.lr.ph ], [ %inc, %for.inc ]
  %cmp6 = icmp eq i32 %j.027, %sub
  %add = add nsw i32 %j.027, %mul
  %arrayidx = getelementptr inbounds i32, ptr %A, i32 %add
  %0 = load i32, ptr %arrayidx, align 4, !tbaa !3
  br i1 %cmp6, label %if.then, label %if.else

if.then:                                          ; preds = %for.body5
  %call7 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, i32 noundef %0)
  br label %for.inc

if.else:                                          ; preds = %for.body5
  %call11 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.6, i32 noundef %0)
  br label %for.inc

for.inc:                                          ; preds = %if.then, %if.else
  %inc = add nuw nsw i32 %j.027, 1
  %cmp3 = icmp slt i32 %inc, %N
  br i1 %cmp3, label %for.body5, label %for.cond.cleanup4, !llvm.loop !30
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @matmul(ptr nocapture noundef readonly %A, ptr nocapture noundef readonly %B, ptr nocapture noundef %C, i32 noundef %M, i32 noundef %N, i32 noundef %K) local_unnamed_addr #2 {
entry:
  %cmp40 = icmp sgt i32 %M, 0
  br i1 %cmp40, label %for.body.lr.ph, label %for.cond.cleanup

for.body.lr.ph:                                   ; preds = %entry
  %cmp238 = icmp sgt i32 %N, 0
  %cmp635 = icmp sgt i32 %K, 0
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.cond.cleanup3, %entry
  ret void

for.body:                                         ; preds = %for.body.lr.ph, %for.cond.cleanup3
  %i.041 = phi i32 [ 0, %for.body.lr.ph ], [ %inc21, %for.cond.cleanup3 ]
  br i1 %cmp238, label %for.body4.lr.ph, label %for.cond.cleanup3

for.body4.lr.ph:                                  ; preds = %for.body
  %mul = mul nsw i32 %i.041, %K
  %mul13 = mul nsw i32 %i.041, %N
  br label %for.body4

for.cond.cleanup3:                                ; preds = %for.cond.cleanup7, %for.body
  %inc21 = add nuw nsw i32 %i.041, 1
  %cmp = icmp slt i32 %inc21, %M
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !31

for.body4:                                        ; preds = %for.body4.lr.ph, %for.cond.cleanup7
  %j.039 = phi i32 [ 0, %for.body4.lr.ph ], [ %inc18, %for.cond.cleanup7 ]
  br i1 %cmp635, label %for.body8.lr.ph, label %for.cond.cleanup7

for.body8.lr.ph:                                  ; preds = %for.body4
  %add14 = add nsw i32 %j.039, %mul13
  %arrayidx15 = getelementptr inbounds i32, ptr %C, i32 %add14
  %arrayidx15.promoted = load i32, ptr %arrayidx15, align 4, !tbaa !3
  br label %for.body8

for.cond.cleanup7:                                ; preds = %for.body8, %for.body4
  %inc18 = add nuw nsw i32 %j.039, 1
  %cmp2 = icmp slt i32 %inc18, %N
  br i1 %cmp2, label %for.body4, label %for.cond.cleanup3, !llvm.loop !36

for.body8:                                        ; preds = %for.body8.lr.ph, %for.body8
  %add1637 = phi i32 [ %arrayidx15.promoted, %for.body8.lr.ph ], [ %add16, %for.body8 ]
  %k.036 = phi i32 [ 0, %for.body8.lr.ph ], [ %inc, %for.body8 ]
  %add = add nsw i32 %k.036, %mul
  %arrayidx = getelementptr inbounds i32, ptr %A, i32 %add
  %0 = load i32, ptr %arrayidx, align 4, !tbaa !3
  %mul9 = mul nsw i32 %k.036, %N
  %add10 = add nsw i32 %mul9, %j.039
  %arrayidx11 = getelementptr inbounds i32, ptr %B, i32 %add10
  %1 = load i32, ptr %arrayidx11, align 4, !tbaa !3
  %mul12 = mul nsw i32 %1, %0
  %add16 = add nsw i32 %mul12, %add1637
  store i32 %add16, ptr %arrayidx15, align 4, !tbaa !3
  %inc = add nuw nsw i32 %k.036, 1
  %cmp6 = icmp slt i32 %inc, %K
  br i1 %cmp6, label %for.body8, label %for.cond.cleanup7, !llvm.loop !39
}

; Function Attrs: mustprogress nofree nosync nounwind willreturn
define dso_local void @vectorized_matmul(ptr addrspace(4) noalias nocapture noundef readonly %A, ptr addrspace(4) noalias noundef %B, ptr addrspace(4) noalias noundef %C, i32 noundef %M, i32 noundef %N, i32 noundef %K) local_unnamed_addr #3 {
entry:
  %div = sdiv i32 %N, 16
  %mul = shl nsw i32 %div, 4
  %cmp103 = icmp sgt i32 %M, 0
  br i1 %cmp103, label %for.body.lr.ph, label %for.cond.cleanup

for.body.lr.ph:                                   ; preds = %entry
  %cmp2101 = icmp sgt i32 %N, 15
  %cmp698 = icmp sgt i32 %K, 0
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.cond.cleanup3, %entry
  %cmp29111 = icmp slt i32 %mul, %N
  br i1 %cmp29111, label %for.body31.lr.ph, label %for.cond.cleanup30

for.body31.lr.ph:                                 ; preds = %for.cond.cleanup
  %cmp40105 = icmp sgt i32 %K, 0
  %min.iters.check = icmp ult i32 %K, 8
  %ident.check.not = icmp ne i32 %N, 1
  %min.iters.check113 = icmp ult i32 %K, 64
  %n.vec = and i32 %K, -64
  %cmp.n = icmp eq i32 %n.vec, %K
  %n.vec.remaining = and i32 %K, 56
  %min.epilog.iters.check = icmp eq i32 %n.vec.remaining, 0
  %n.vec127 = and i32 %K, -8
  %cmp.n128 = icmp eq i32 %n.vec127, %K
  %brmerge = or i1 %min.iters.check, %ident.check.not
  br label %for.body31

for.body:                                         ; preds = %for.body.lr.ph, %for.cond.cleanup3
  %i.0104 = phi i32 [ 0, %for.body.lr.ph ], [ %inc26, %for.cond.cleanup3 ]
  br i1 %cmp2101, label %for.body4.lr.ph, label %for.cond.cleanup3

for.body4.lr.ph:                                  ; preds = %for.body
  %0 = tail call <16 x i32> @llvm.arc.vvcmpy.lo.acc.w.v512(<16 x i32> zeroinitializer, <16 x i32> zeroinitializer)
  %mul11 = mul nsw i32 %i.0104, %K
  %mul19 = mul nsw i32 %i.0104, %N
  br label %for.body4

for.cond.cleanup3:                                ; preds = %for.cond.cleanup7, %for.body
  %inc26 = add nuw nsw i32 %i.0104, 1
  %cmp = icmp slt i32 %inc26, %M
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !42

for.body4:                                        ; preds = %for.body4.lr.ph, %for.cond.cleanup7
  %j_vec.0102 = phi i32 [ 0, %for.body4.lr.ph ], [ %add23, %for.cond.cleanup7 ]
  br i1 %cmp698, label %for.body8.preheader, label %for.cond.cleanup7

for.body8.preheader:                              ; preds = %for.body4
  br label %for.body8

for.cond.cleanup7:                                ; preds = %for.body8, %for.body4
  %acc.sroa.0.0.lcssa = phi <16 x i32> [ %0, %for.body4 ], [ %4, %for.body8 ]
  %1 = tail call <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32> %acc.sroa.0.0.lcssa)
  %add20 = add nsw i32 %j_vec.0102, %mul19
  %arrayidx21 = getelementptr inbounds i32, ptr addrspace(4) %C, i32 %add20
  tail call void @llvm.arc.vvst.w.v512(<16 x i32> %1, ptr addrspace(4) %arrayidx21)
  %add23 = add nuw nsw i32 %j_vec.0102, 16
  %cmp2 = icmp slt i32 %add23, %mul
  br i1 %cmp2, label %for.body4, label %for.cond.cleanup3, !llvm.loop !43

for.body8:                                        ; preds = %for.body8.preheader, %for.body8
  %k.0100 = phi i32 [ %inc, %for.body8 ], [ 0, %for.body8.preheader ]
  %acc.sroa.0.099 = phi <16 x i32> [ %4, %for.body8 ], [ %0, %for.body8.preheader ]
  %mul9 = mul nsw i32 %k.0100, %N
  %add = add nsw i32 %mul9, %j_vec.0102
  %arrayidx = getelementptr inbounds i32, ptr addrspace(4) %B, i32 %add
  %2 = tail call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %arrayidx)
  %add12 = add nsw i32 %k.0100, %mul11
  %arrayidx13 = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %add12
  %3 = load i32, ptr addrspace(4) %arrayidx13, align 4, !tbaa !3
  %splat.splatinsert = insertelement <16 x i32> poison, i32 %3, i64 0
  %splat.splat = shufflevector <16 x i32> %splat.splatinsert, <16 x i32> poison, <16 x i32> zeroinitializer
  %4 = tail call <16 x i32> @llvm.arc.vvcmac.lo.acc.w.v512(<16 x i32> %acc.sroa.0.099, <16 x i32> %2, <16 x i32> %splat.splat)
  %inc = add nuw nsw i32 %k.0100, 1
  %cmp6 = icmp slt i32 %inc, %K
  br i1 %cmp6, label %for.body8, label %for.cond.cleanup7, !llvm.loop !44

for.cond.cleanup30:                               ; preds = %for.cond.cleanup35, %for.cond.cleanup
  ret void

for.body31:                                       ; preds = %for.body31.lr.ph, %for.cond.cleanup35
  %j.0112 = phi i32 [ %mul, %for.body31.lr.ph ], [ %inc61, %for.cond.cleanup35 ]
  br i1 %cmp103, label %for.body36.preheader, label %for.cond.cleanup35

for.body36.preheader:                             ; preds = %for.body31
  br label %for.body36

for.cond.cleanup35:                               ; preds = %for.cond.cleanup41, %for.body31
  %inc61 = add nsw i32 %j.0112, 1
  %cmp29 = icmp slt i32 %inc61, %N
  br i1 %cmp29, label %for.body31, label %for.cond.cleanup30, !llvm.loop !45

for.body36:                                       ; preds = %for.body36.preheader, %for.cond.cleanup41
  %i32.0110 = phi i32 [ %inc58, %for.cond.cleanup41 ], [ 0, %for.body36.preheader ]
  br i1 %cmp40105, label %iter.check, label %for.cond.cleanup41

iter.check:                                       ; preds = %for.body36
  %mul46 = mul nsw i32 %i32.0110, %K
  br i1 %brmerge, label %for.body42.preheader, label %vector.main.loop.iter.check

vector.main.loop.iter.check:                      ; preds = %iter.check
  br i1 %min.iters.check113, label %vec.epilog.ph, label %vector.body.preheader

vector.body.preheader:                            ; preds = %vector.main.loop.iter.check
  br label %vector.body

vector.body:                                      ; preds = %vector.body.preheader, %vector.body
  %index = phi i32 [ %index.next, %vector.body ], [ 0, %vector.body.preheader ]
  %vec.phi = phi <16 x i32> [ %19, %vector.body ], [ zeroinitializer, %vector.body.preheader ]
  %vec.phi114 = phi <16 x i32> [ %20, %vector.body ], [ zeroinitializer, %vector.body.preheader ]
  %vec.phi115 = phi <16 x i32> [ %21, %vector.body ], [ zeroinitializer, %vector.body.preheader ]
  %vec.phi116 = phi <16 x i32> [ %22, %vector.body ], [ zeroinitializer, %vector.body.preheader ]
  %5 = add nsw i32 %index, %j.0112
  %6 = getelementptr inbounds i32, ptr addrspace(4) %B, i32 %5
  %wide.load = load <16 x i32>, ptr addrspace(4) %6, align 4, !tbaa !3
  %7 = getelementptr inbounds i32, ptr addrspace(4) %6, i32 16
  %wide.load117 = load <16 x i32>, ptr addrspace(4) %7, align 4, !tbaa !3
  %8 = getelementptr inbounds i32, ptr addrspace(4) %6, i32 32
  %wide.load118 = load <16 x i32>, ptr addrspace(4) %8, align 4, !tbaa !3
  %9 = getelementptr inbounds i32, ptr addrspace(4) %6, i32 48
  %wide.load119 = load <16 x i32>, ptr addrspace(4) %9, align 4, !tbaa !3
  %10 = add nsw i32 %index, %mul46
  %11 = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %10
  %wide.load120 = load <16 x i32>, ptr addrspace(4) %11, align 4, !tbaa !3
  %12 = getelementptr inbounds i32, ptr addrspace(4) %11, i32 16
  %wide.load121 = load <16 x i32>, ptr addrspace(4) %12, align 4, !tbaa !3
  %13 = getelementptr inbounds i32, ptr addrspace(4) %11, i32 32
  %wide.load122 = load <16 x i32>, ptr addrspace(4) %13, align 4, !tbaa !3
  %14 = getelementptr inbounds i32, ptr addrspace(4) %11, i32 48
  %wide.load123 = load <16 x i32>, ptr addrspace(4) %14, align 4, !tbaa !3
  %15 = mul nsw <16 x i32> %wide.load120, %wide.load
  %16 = mul nsw <16 x i32> %wide.load121, %wide.load117
  %17 = mul nsw <16 x i32> %wide.load122, %wide.load118
  %18 = mul nsw <16 x i32> %wide.load123, %wide.load119
  %19 = add <16 x i32> %15, %vec.phi
  %20 = add <16 x i32> %16, %vec.phi114
  %21 = add <16 x i32> %17, %vec.phi115
  %22 = add <16 x i32> %18, %vec.phi116
  %index.next = add nuw i32 %index, 64
  %23 = icmp eq i32 %index.next, %n.vec
  br i1 %23, label %middle.block, label %vector.body, !llvm.loop !46

middle.block:                                     ; preds = %vector.body
  %bin.rdx = add <16 x i32> %20, %19
  %bin.rdx124 = add <16 x i32> %21, %bin.rdx
  %bin.rdx125 = add <16 x i32> %22, %bin.rdx124
  %24 = tail call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %bin.rdx125)
  br i1 %cmp.n, label %for.cond.cleanup41, label %vec.epilog.iter.check

vec.epilog.iter.check:                            ; preds = %middle.block
  br i1 %min.epilog.iters.check, label %for.body42.preheader, label %vec.epilog.ph

vec.epilog.ph:                                    ; preds = %vector.main.loop.iter.check, %vec.epilog.iter.check
  %bc.merge.rdx = phi i32 [ 0, %vector.main.loop.iter.check ], [ %24, %vec.epilog.iter.check ]
  %vec.epilog.resume.val = phi i32 [ 0, %vector.main.loop.iter.check ], [ %n.vec, %vec.epilog.iter.check ]
  %25 = insertelement <8 x i32> <i32 poison, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, i32 %bc.merge.rdx, i64 0
  br label %vec.epilog.vector.body

vec.epilog.vector.body:                           ; preds = %vec.epilog.vector.body, %vec.epilog.ph
  %index129 = phi i32 [ %vec.epilog.resume.val, %vec.epilog.ph ], [ %index.next133, %vec.epilog.vector.body ]
  %vec.phi130 = phi <8 x i32> [ %25, %vec.epilog.ph ], [ %31, %vec.epilog.vector.body ]
  %26 = add nsw i32 %index129, %j.0112
  %27 = getelementptr inbounds i32, ptr addrspace(4) %B, i32 %26
  %wide.load131 = load <8 x i32>, ptr addrspace(4) %27, align 4, !tbaa !3
  %28 = add nsw i32 %index129, %mul46
  %29 = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %28
  %wide.load132 = load <8 x i32>, ptr addrspace(4) %29, align 4, !tbaa !3
  %30 = mul nsw <8 x i32> %wide.load132, %wide.load131
  %31 = add <8 x i32> %30, %vec.phi130
  %index.next133 = add nuw i32 %index129, 8
  %32 = icmp eq i32 %index.next133, %n.vec127
  br i1 %32, label %vec.epilog.middle.block, label %vec.epilog.vector.body, !llvm.loop !47

vec.epilog.middle.block:                          ; preds = %vec.epilog.vector.body
  %33 = tail call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %31)
  br i1 %cmp.n128, label %for.cond.cleanup41, label %for.body42.preheader

for.body42.preheader:                             ; preds = %iter.check, %vec.epilog.iter.check, %vec.epilog.middle.block
  %k38.0107.ph = phi i32 [ 0, %iter.check ], [ %n.vec, %vec.epilog.iter.check ], [ %n.vec127, %vec.epilog.middle.block ]
  %acc37.0106.ph = phi i32 [ 0, %iter.check ], [ %24, %vec.epilog.iter.check ], [ %33, %vec.epilog.middle.block ]
  br label %for.body42

for.cond.cleanup41:                               ; preds = %for.body42, %middle.block, %vec.epilog.middle.block, %for.body36
  %acc37.0.lcssa = phi i32 [ 0, %for.body36 ], [ %24, %middle.block ], [ %33, %vec.epilog.middle.block ], [ %add50, %for.body42 ]
  %mul54 = mul nsw i32 %i32.0110, %N
  %add55 = add nsw i32 %mul54, %j.0112
  %arrayidx56 = getelementptr inbounds i32, ptr addrspace(4) %C, i32 %add55
  store i32 %acc37.0.lcssa, ptr addrspace(4) %arrayidx56, align 4, !tbaa !3
  %inc58 = add nuw nsw i32 %i32.0110, 1
  %cmp34 = icmp slt i32 %inc58, %M
  br i1 %cmp34, label %for.body36, label %for.cond.cleanup35, !llvm.loop !48

for.body42:                                       ; preds = %for.body42.preheader, %for.body42
  %k38.0107 = phi i32 [ %inc52, %for.body42 ], [ %k38.0107.ph, %for.body42.preheader ]
  %acc37.0106 = phi i32 [ %add50, %for.body42 ], [ %acc37.0106.ph, %for.body42.preheader ]
  %mul43 = mul nsw i32 %k38.0107, %N
  %add44 = add nsw i32 %mul43, %j.0112
  %arrayidx45 = getelementptr inbounds i32, ptr addrspace(4) %B, i32 %add44
  %34 = load i32, ptr addrspace(4) %arrayidx45, align 4, !tbaa !3
  %add47 = add nsw i32 %k38.0107, %mul46
  %arrayidx48 = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %add47
  %35 = load i32, ptr addrspace(4) %arrayidx48, align 4, !tbaa !3
  %mul49 = mul nsw i32 %35, %34
  %add50 = add nsw i32 %mul49, %acc37.0106
  %inc52 = add nuw nsw i32 %k38.0107, 1
  %cmp40 = icmp slt i32 %inc52, %K
  br i1 %cmp40, label %for.body42, label %for.cond.cleanup41, !llvm.loop !49
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @autovectorized_matmul(ptr addrspace(4) noalias nocapture noundef readonly %A, ptr addrspace(4) noalias nocapture noundef readonly %B, ptr addrspace(4) noalias nocapture noundef %C, i32 noundef %M, i32 noundef %N, i32 noundef %K) local_unnamed_addr #2 {
entry:
  %cmp40 = icmp sgt i32 %M, 0
  br i1 %cmp40, label %for.body.lr.ph, label %for.cond.cleanup

for.body.lr.ph:                                   ; preds = %entry
  %cmp238 = icmp sgt i32 %N, 0
  %cmp635 = icmp sgt i32 %K, 0
  %min.iters.check = icmp ult i32 %K, 8
  %ident.check.not = icmp ne i32 %N, 1
  %min.iters.check42 = icmp ult i32 %K, 64
  %n.vec = and i32 %K, -64
  %cmp.n = icmp eq i32 %n.vec, %K
  %n.vec.remaining = and i32 %K, 56
  %min.epilog.iters.check = icmp eq i32 %n.vec.remaining, 0
  %n.vec56 = and i32 %K, -8
  %cmp.n57 = icmp eq i32 %n.vec56, %K
  %brmerge = or i1 %min.iters.check, %ident.check.not
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.cond.cleanup3, %entry
  ret void

for.body:                                         ; preds = %for.body.lr.ph, %for.cond.cleanup3
  %i.041 = phi i32 [ 0, %for.body.lr.ph ], [ %inc21, %for.cond.cleanup3 ]
  br i1 %cmp238, label %for.body4.lr.ph, label %for.cond.cleanup3

for.body4.lr.ph:                                  ; preds = %for.body
  %mul = mul nsw i32 %i.041, %K
  %mul13 = mul nsw i32 %i.041, %N
  br label %for.body4

for.cond.cleanup3:                                ; preds = %for.cond.cleanup7, %for.body
  %inc21 = add nuw nsw i32 %i.041, 1
  %cmp = icmp slt i32 %inc21, %M
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !50

for.body4:                                        ; preds = %for.body4.lr.ph, %for.cond.cleanup7
  %j.039 = phi i32 [ 0, %for.body4.lr.ph ], [ %inc18, %for.cond.cleanup7 ]
  br i1 %cmp635, label %iter.check, label %for.cond.cleanup7

iter.check:                                       ; preds = %for.body4
  %add14 = add nsw i32 %j.039, %mul13
  %arrayidx15 = getelementptr inbounds i32, ptr addrspace(4) %C, i32 %add14
  %arrayidx15.promoted = load i32, ptr addrspace(4) %arrayidx15, align 4, !tbaa !3
  br i1 %brmerge, label %for.body8.preheader, label %vector.main.loop.iter.check

vector.main.loop.iter.check:                      ; preds = %iter.check
  br i1 %min.iters.check42, label %vec.epilog.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.main.loop.iter.check
  %0 = insertelement <16 x i32> <i32 poison, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, i32 %arrayidx15.promoted, i64 0
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi <16 x i32> [ %0, %vector.ph ], [ %15, %vector.body ]
  %vec.phi43 = phi <16 x i32> [ zeroinitializer, %vector.ph ], [ %16, %vector.body ]
  %vec.phi44 = phi <16 x i32> [ zeroinitializer, %vector.ph ], [ %17, %vector.body ]
  %vec.phi45 = phi <16 x i32> [ zeroinitializer, %vector.ph ], [ %18, %vector.body ]
  %1 = add nsw i32 %index, %mul
  %2 = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %1
  %wide.load = load <16 x i32>, ptr addrspace(4) %2, align 4, !tbaa !3
  %3 = getelementptr inbounds i32, ptr addrspace(4) %2, i32 16
  %wide.load46 = load <16 x i32>, ptr addrspace(4) %3, align 4, !tbaa !3
  %4 = getelementptr inbounds i32, ptr addrspace(4) %2, i32 32
  %wide.load47 = load <16 x i32>, ptr addrspace(4) %4, align 4, !tbaa !3
  %5 = getelementptr inbounds i32, ptr addrspace(4) %2, i32 48
  %wide.load48 = load <16 x i32>, ptr addrspace(4) %5, align 4, !tbaa !3
  %6 = add nsw i32 %index, %j.039
  %7 = getelementptr inbounds i32, ptr addrspace(4) %B, i32 %6
  %wide.load49 = load <16 x i32>, ptr addrspace(4) %7, align 4, !tbaa !3
  %8 = getelementptr inbounds i32, ptr addrspace(4) %7, i32 16
  %wide.load50 = load <16 x i32>, ptr addrspace(4) %8, align 4, !tbaa !3
  %9 = getelementptr inbounds i32, ptr addrspace(4) %7, i32 32
  %wide.load51 = load <16 x i32>, ptr addrspace(4) %9, align 4, !tbaa !3
  %10 = getelementptr inbounds i32, ptr addrspace(4) %7, i32 48
  %wide.load52 = load <16 x i32>, ptr addrspace(4) %10, align 4, !tbaa !3
  %11 = mul nsw <16 x i32> %wide.load49, %wide.load
  %12 = mul nsw <16 x i32> %wide.load50, %wide.load46
  %13 = mul nsw <16 x i32> %wide.load51, %wide.load47
  %14 = mul nsw <16 x i32> %wide.load52, %wide.load48
  %15 = add <16 x i32> %11, %vec.phi
  %16 = add <16 x i32> %12, %vec.phi43
  %17 = add <16 x i32> %13, %vec.phi44
  %18 = add <16 x i32> %14, %vec.phi45
  %index.next = add nuw i32 %index, 64
  %19 = icmp eq i32 %index.next, %n.vec
  br i1 %19, label %middle.block, label %vector.body, !llvm.loop !51

middle.block:                                     ; preds = %vector.body
  %bin.rdx = add <16 x i32> %16, %15
  %bin.rdx53 = add <16 x i32> %17, %bin.rdx
  %bin.rdx54 = add <16 x i32> %18, %bin.rdx53
  %20 = tail call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %bin.rdx54)
  br i1 %cmp.n, label %for.cond5.for.cond.cleanup7_crit_edge, label %vec.epilog.iter.check

vec.epilog.iter.check:                            ; preds = %middle.block
  br i1 %min.epilog.iters.check, label %for.body8.preheader, label %vec.epilog.ph

vec.epilog.ph:                                    ; preds = %vector.main.loop.iter.check, %vec.epilog.iter.check
  %bc.merge.rdx = phi i32 [ %arrayidx15.promoted, %vector.main.loop.iter.check ], [ %20, %vec.epilog.iter.check ]
  %vec.epilog.resume.val = phi i32 [ 0, %vector.main.loop.iter.check ], [ %n.vec, %vec.epilog.iter.check ]
  %21 = insertelement <8 x i32> <i32 poison, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, i32 %bc.merge.rdx, i64 0
  br label %vec.epilog.vector.body

vec.epilog.vector.body:                           ; preds = %vec.epilog.vector.body, %vec.epilog.ph
  %index58 = phi i32 [ %vec.epilog.resume.val, %vec.epilog.ph ], [ %index.next62, %vec.epilog.vector.body ]
  %vec.phi59 = phi <8 x i32> [ %21, %vec.epilog.ph ], [ %27, %vec.epilog.vector.body ]
  %22 = add nsw i32 %index58, %mul
  %23 = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %22
  %wide.load60 = load <8 x i32>, ptr addrspace(4) %23, align 4, !tbaa !3
  %24 = add nsw i32 %index58, %j.039
  %25 = getelementptr inbounds i32, ptr addrspace(4) %B, i32 %24
  %wide.load61 = load <8 x i32>, ptr addrspace(4) %25, align 4, !tbaa !3
  %26 = mul nsw <8 x i32> %wide.load61, %wide.load60
  %27 = add <8 x i32> %26, %vec.phi59
  %index.next62 = add nuw i32 %index58, 8
  %28 = icmp eq i32 %index.next62, %n.vec56
  br i1 %28, label %vec.epilog.middle.block, label %vec.epilog.vector.body, !llvm.loop !52

vec.epilog.middle.block:                          ; preds = %vec.epilog.vector.body
  %29 = tail call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %27)
  br i1 %cmp.n57, label %for.cond5.for.cond.cleanup7_crit_edge, label %for.body8.preheader

for.body8.preheader:                              ; preds = %iter.check, %vec.epilog.iter.check, %vec.epilog.middle.block
  %add1637.ph = phi i32 [ %arrayidx15.promoted, %iter.check ], [ %20, %vec.epilog.iter.check ], [ %29, %vec.epilog.middle.block ]
  %k.036.ph = phi i32 [ 0, %iter.check ], [ %n.vec, %vec.epilog.iter.check ], [ %n.vec56, %vec.epilog.middle.block ]
  br label %for.body8

for.cond5.for.cond.cleanup7_crit_edge:            ; preds = %for.body8, %vec.epilog.middle.block, %middle.block
  %add16.lcssa = phi i32 [ %20, %middle.block ], [ %29, %vec.epilog.middle.block ], [ %add16, %for.body8 ]
  store i32 %add16.lcssa, ptr addrspace(4) %arrayidx15, align 4, !tbaa !3
  br label %for.cond.cleanup7

for.cond.cleanup7:                                ; preds = %for.cond5.for.cond.cleanup7_crit_edge, %for.body4
  %inc18 = add nuw nsw i32 %j.039, 1
  %cmp2 = icmp slt i32 %inc18, %N
  br i1 %cmp2, label %for.body4, label %for.cond.cleanup3, !llvm.loop !53

for.body8:                                        ; preds = %for.body8.preheader, %for.body8
  %add1637 = phi i32 [ %add16, %for.body8 ], [ %add1637.ph, %for.body8.preheader ]
  %k.036 = phi i32 [ %inc, %for.body8 ], [ %k.036.ph, %for.body8.preheader ]
  %add = add nsw i32 %k.036, %mul
  %arrayidx = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %add
  %30 = load i32, ptr addrspace(4) %arrayidx, align 4, !tbaa !3
  %mul9 = mul nsw i32 %k.036, %N
  %add10 = add nsw i32 %mul9, %j.039
  %arrayidx11 = getelementptr inbounds i32, ptr addrspace(4) %B, i32 %add10
  %31 = load i32, ptr addrspace(4) %arrayidx11, align 4, !tbaa !3
  %mul12 = mul nsw i32 %31, %30
  %add16 = add nsw i32 %mul12, %add1637
  %inc = add nuw nsw i32 %k.036, 1
  %cmp6 = icmp slt i32 %inc, %K
  br i1 %cmp6, label %for.body8, label %for.cond5.for.cond.cleanup7_crit_edge, !llvm.loop !54
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <16 x i32> @llvm.arc.vvcmpy.lo.acc.w.v512(<16 x i32>, <16 x i32>) #4

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(read)
declare <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4)) #5

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <16 x i32> @llvm.arc.vvcmac.lo.acc.w.v512(<16 x i32>, <16 x i32>, <16 x i32>) #4

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(write)
declare void @llvm.arc.vvst.w.v512(<16 x i32>, ptr addrspace(4)) #6

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32>) #4

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #7

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.add.v16i32(<16 x i32>) #8

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.add.v8i32(<8 x i32>) #8

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: write) "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #1 = { nofree nounwind "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #2 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite) "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #3 = { mustprogress nofree nosync nounwind willreturn "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #4 = { mustprogress nocallback nofree nosync nounwind willreturn memory(none) }
attributes #5 = { mustprogress nocallback nofree nosync nounwind willreturn memory(read) }
attributes #6 = { mustprogress nocallback nofree nosync nounwind willreturn memory(write) }
attributes #7 = { nofree nounwind }
attributes #8 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

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
!15 = !{!16}
!16 = distinct !{!16, !17}
!17 = distinct !{!17, !"LVerDomain"}
!18 = !{!19}
!19 = distinct !{!19, !17}
!20 = distinct !{!20, !8, !9, !10}
!21 = !{!22}
!22 = distinct !{!22, !23}
!23 = distinct !{!23, !"LVerDomain"}
!24 = !{!25}
!25 = distinct !{!25, !23}
!26 = distinct !{!26, !8, !9, !10}
!27 = distinct !{!27, !8}
!28 = distinct !{!28, !8, !9}
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
!45 = distinct !{!45, !8}
!46 = distinct !{!46, !8, !9, !10}
!47 = distinct !{!47, !8, !9, !10}
!48 = distinct !{!48, !8}
!49 = distinct !{!49, !8, !9}
!50 = distinct !{!50, !8}
!51 = distinct !{!51, !8, !9, !10}
!52 = distinct !{!52, !8, !9, !10}
!53 = distinct !{!53, !8}
!54 = distinct !{!54, !8, !9}
