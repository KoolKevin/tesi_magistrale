; ModuleID = 'matmul.c'
source_filename = "matmul.c"
target datalayout = "e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-f64:32-v64:32-v128:32-a:0:32-v256:32-v512:32-n8:16:32"
target triple = "arc-pc-unknown-gnu"

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

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @matmul(ptr nocapture noundef readonly %A, ptr nocapture noundef readonly %B, ptr nocapture noundef %C, i32 noundef %M, i32 noundef %N, i32 noundef %K) local_unnamed_addr #1 {
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
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !13

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
  br i1 %cmp2, label %for.body4, label %for.cond.cleanup3, !llvm.loop !18

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
  br i1 %cmp6, label %for.body8, label %for.cond.cleanup7, !llvm.loop !21
}

; Function Attrs: mustprogress nofree nosync nounwind willreturn
define dso_local void @vectorized_matmul(ptr addrspace(4) noalias nocapture noundef readonly %A, ptr addrspace(4) noalias noundef %B, ptr addrspace(4) noalias noundef %C, i32 noundef %M, i32 noundef %N, i32 noundef %K) local_unnamed_addr #2 {
entry:
  %cmp30 = icmp sgt i32 %M, 0
  br i1 %cmp30, label %for.body.lr.ph, label %for.cond.cleanup

for.body.lr.ph:                                   ; preds = %entry
  %0 = tail call <16 x i32> @llvm.arc.vvcmpy.lo.acc.w.v512(<16 x i32> zeroinitializer, <16 x i32> zeroinitializer)
  %cmp227 = icmp sgt i32 %K, 0
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.cond.cleanup3, %entry
  ret void

for.body:                                         ; preds = %for.body.lr.ph, %for.cond.cleanup3
  %i.031 = phi i32 [ 0, %for.body.lr.ph ], [ %inc16, %for.cond.cleanup3 ]
  br i1 %cmp227, label %for.body4.lr.ph, label %for.cond.cleanup3

for.body4.lr.ph:                                  ; preds = %for.body
  %mul6 = mul nsw i32 %i.031, %K
  br label %for.body4

for.cond.cleanup3:                                ; preds = %for.body4, %for.body
  %acc.sroa.0.0.lcssa = phi <16 x i32> [ %0, %for.body ], [ %4, %for.body4 ]
  %1 = tail call <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32> %acc.sroa.0.0.lcssa)
  %mul13 = mul nsw i32 %i.031, %N
  %arrayidx14 = getelementptr inbounds i32, ptr addrspace(4) %C, i32 %mul13
  tail call void @llvm.arc.vvst.w.v512(<16 x i32> %1, ptr addrspace(4) %arrayidx14)
  %inc16 = add nuw nsw i32 %i.031, 1
  %cmp = icmp slt i32 %inc16, %M
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !24

for.body4:                                        ; preds = %for.body4.lr.ph, %for.body4
  %acc.sroa.0.029 = phi <16 x i32> [ %0, %for.body4.lr.ph ], [ %4, %for.body4 ]
  %k.028 = phi i32 [ 0, %for.body4.lr.ph ], [ %inc, %for.body4 ]
  %mul = mul nsw i32 %k.028, %N
  %arrayidx = getelementptr inbounds i32, ptr addrspace(4) %B, i32 %mul
  %2 = tail call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %arrayidx)
  %add = add nsw i32 %k.028, %mul6
  %arrayidx7 = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %add
  %3 = load i32, ptr addrspace(4) %arrayidx7, align 4, !tbaa !3
  %splat.splatinsert = insertelement <16 x i32> poison, i32 %3, i64 0
  %splat.splat = shufflevector <16 x i32> %splat.splatinsert, <16 x i32> poison, <16 x i32> zeroinitializer
  %4 = tail call <16 x i32> @llvm.arc.vvcmac.lo.acc.w.v512(<16 x i32> %acc.sroa.0.029, <16 x i32> %2, <16 x i32> %splat.splat)
  %inc = add nuw nsw i32 %k.028, 1
  %cmp2 = icmp slt i32 %inc, %K
  br i1 %cmp2, label %for.body4, label %for.cond.cleanup3, !llvm.loop !25
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @autovectorized_matmul(ptr addrspace(4) noalias nocapture noundef readonly %A, ptr addrspace(4) noalias nocapture noundef readonly %B, ptr addrspace(4) noalias nocapture noundef %C, i32 noundef %M, i32 noundef %N, i32 noundef %K) local_unnamed_addr #1 {
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
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !26

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
  br i1 %19, label %middle.block, label %vector.body, !llvm.loop !27

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
  br i1 %28, label %vec.epilog.middle.block, label %vec.epilog.vector.body, !llvm.loop !28

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
  br i1 %cmp2, label %for.body4, label %for.cond.cleanup3, !llvm.loop !29

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
  br i1 %cmp6, label %for.body8, label %for.cond5.for.cond.cleanup7_crit_edge, !llvm.loop !30
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <16 x i32> @llvm.arc.vvcmpy.lo.acc.w.v512(<16 x i32>, <16 x i32>) #3

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(read)
declare <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4)) #4

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <16 x i32> @llvm.arc.vvcmac.lo.acc.w.v512(<16 x i32>, <16 x i32>, <16 x i32>) #3

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(write)
declare void @llvm.arc.vvst.w.v512(<16 x i32>, ptr addrspace(4)) #5

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32>) #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.add.v16i32(<16 x i32>) #6

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.add.v8i32(<8 x i32>) #6

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: write) "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #1 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite) "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #2 = { mustprogress nofree nosync nounwind willreturn "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #3 = { mustprogress nocallback nofree nosync nounwind willreturn memory(none) }
attributes #4 = { mustprogress nocallback nofree nosync nounwind willreturn memory(read) }
attributes #5 = { mustprogress nocallback nofree nosync nounwind willreturn memory(write) }
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
!13 = distinct !{!13, !8, !14, !15}
!14 = !{!"llvm.loop.vectorize.width", i32 1}
!15 = !{!"llvm.loop.vectorize.followup_all", !16}
!16 = distinct !{!16, !8, !17}
!17 = !{!"llvm.loop.isvectorized"}
!18 = distinct !{!18, !8, !14, !19}
!19 = !{!"llvm.loop.vectorize.followup_all", !20}
!20 = distinct !{!20, !8, !17}
!21 = distinct !{!21, !8, !14, !22}
!22 = !{!"llvm.loop.vectorize.followup_all", !23}
!23 = distinct !{!23, !8, !17}
!24 = distinct !{!24, !8}
!25 = distinct !{!25, !8}
!26 = distinct !{!26, !8}
!27 = distinct !{!27, !8, !9, !10}
!28 = distinct !{!28, !8, !9, !10}
!29 = distinct !{!29, !8}
!30 = distinct !{!30, !8, !9}
