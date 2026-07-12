; ModuleID = 'dotp.c'
source_filename = "dotp.c"
target datalayout = "e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-f64:32-v64:32-v128:32-a:0:32-v256:32-v512:32-n8:16:32"
target triple = "arc-pc-unknown-gnu"

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: read)
define dso_local i32 @dotp(ptr nocapture noundef readonly %a, ptr nocapture noundef readonly %b, i32 noundef %n) local_unnamed_addr #0 {
entry:
  %cmp6 = icmp sgt i32 %n, 0
  br i1 %cmp6, label %for.body.lr.ph, label %for.cond.cleanup

for.body.lr.ph:                                   ; preds = %entry
  %min.iters.check = icmp ult i32 %n, 4
  br i1 %min.iters.check, label %for.body.preheader, label %vector.ph

vector.ph:                                        ; preds = %for.body.lr.ph
  %n.vec = and i32 %n, -4
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %0 = phi <4 x i32> [ zeroinitializer, %vector.ph ], [ %6, %vector.body ]
  %1 = getelementptr inbounds i32, ptr %a, i32 %index
  %2 = getelementptr inbounds i32, ptr %b, i32 %index
  %3 = load <4 x i32>, ptr %1, align 4, !tbaa !3
  %4 = load <4 x i32>, ptr %2, align 4, !tbaa !3
  %5 = mul nsw <4 x i32> %4, %3
  %6 = add <4 x i32> %5, %0
  %index.next = add nuw i32 %index, 4
  %7 = icmp eq i32 %index.next, %n.vec
  br i1 %7, label %middle.block, label %vector.body, !llvm.loop !7

middle.block:                                     ; preds = %vector.body
  %8 = extractelement <4 x i32> %6, i64 0
  %9 = extractelement <4 x i32> %6, i64 1
  %bin.rdx = add i32 %9, %8
  %10 = extractelement <4 x i32> %6, i64 2
  %bin.rdx12 = add i32 %10, %bin.rdx
  %11 = extractelement <4 x i32> %6, i64 3
  %bin.rdx13 = add i32 %11, %bin.rdx12
  %cmp.n = icmp eq i32 %n.vec, %n
  br i1 %cmp.n, label %for.cond.cleanup, label %for.body.preheader

for.body.preheader:                               ; preds = %for.body.lr.ph, %middle.block
  %i.08.ph = phi i32 [ 0, %for.body.lr.ph ], [ %n.vec, %middle.block ]
  %res.07.ph = phi i32 [ 0, %for.body.lr.ph ], [ %bin.rdx13, %middle.block ]
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body, %middle.block, %entry
  %res.0.lcssa = phi i32 [ 0, %entry ], [ %bin.rdx13, %middle.block ], [ %add, %for.body ]
  ret i32 %res.0.lcssa

for.body:                                         ; preds = %for.body.preheader, %for.body
  %i.08 = phi i32 [ %inc, %for.body ], [ %i.08.ph, %for.body.preheader ]
  %res.07 = phi i32 [ %add, %for.body ], [ %res.07.ph, %for.body.preheader ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i32 %i.08
  %12 = load i32, ptr %arrayidx, align 4, !tbaa !3
  %arrayidx1 = getelementptr inbounds i32, ptr %b, i32 %i.08
  %13 = load i32, ptr %arrayidx1, align 4, !tbaa !3
  %mul = mul nsw i32 %13, %12
  %add = add nsw i32 %mul, %res.07
  %inc = add nuw nsw i32 %i.08, 1
  %cmp = icmp slt i32 %inc, %n
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !12
}

; Function Attrs: mustprogress nofree nosync nounwind willreturn memory(read)
define dso_local i32 @vectorized_dotp(ptr addrspace(4) noalias noundef %a, ptr addrspace(4) noalias noundef %b, i32 noundef %n) local_unnamed_addr #1 {
entry:
  %0 = tail call <16 x i32> @llvm.arc.vvcmpy.lo.acc.w.v512(<16 x i32> zeroinitializer, <16 x i32> zeroinitializer)
  %div = sdiv i32 %n, 16
  %mul = shl nsw i32 %div, 4
  %cmp54 = icmp sgt i32 %n, 15
  br i1 %cmp54, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:                               ; preds = %entry
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body, %entry
  %acc.sroa.0.0.lcssa = phi <16 x i32> [ %0, %entry ], [ %35, %for.body ]
  %1 = tail call <16 x i32> @llvm.arc.vvc4add.acc.w.v512(<16 x i32> %acc.sroa.0.0.lcssa)
  %2 = tail call <16 x i32> @llvm.arc.vvc4pack.acc.w.v512(<16 x i32> %1)
  %3 = tail call <16 x i32> @llvm.arc.vvc4add.acc.w.v512(<16 x i32> %2)
  %4 = tail call <16 x i32> @llvm.arc.vvc4pack.acc.w.v512(<16 x i32> %3)
  %5 = tail call <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32> %4)
  %vecext = extractelement <16 x i32> %5, i64 0
  %cmp2757 = icmp slt i32 %mul, %n
  br i1 %cmp2757, label %iter.check, label %for.cond.cleanup28

iter.check:                                       ; preds = %for.cond.cleanup
  %6 = sub i32 %n, %mul
  %min.iters.check = icmp ult i32 %6, 8
  br i1 %min.iters.check, label %for.body29.preheader, label %vector.main.loop.iter.check

vector.main.loop.iter.check:                      ; preds = %iter.check
  %min.iters.check61 = icmp ult i32 %6, 64
  br i1 %min.iters.check61, label %vec.epilog.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.main.loop.iter.check
  %n.vec = and i32 %6, -64
  %7 = shufflevector <16 x i32> <i32 0, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>, <16 x i32> %5, <16 x i32> <i32 16, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi <16 x i32> [ %7, %vector.ph ], [ %20, %vector.body ]
  %vec.phi62 = phi <16 x i32> [ zeroinitializer, %vector.ph ], [ %21, %vector.body ]
  %vec.phi63 = phi <16 x i32> [ zeroinitializer, %vector.ph ], [ %22, %vector.body ]
  %vec.phi64 = phi <16 x i32> [ zeroinitializer, %vector.ph ], [ %23, %vector.body ]
  %offset.idx = add i32 %mul, %index
  %8 = getelementptr inbounds i32, ptr addrspace(4) %a, i32 %offset.idx
  %wide.load = load <16 x i32>, ptr addrspace(4) %8, align 4, !tbaa !3
  %9 = getelementptr inbounds i32, ptr addrspace(4) %8, i32 16
  %wide.load65 = load <16 x i32>, ptr addrspace(4) %9, align 4, !tbaa !3
  %10 = getelementptr inbounds i32, ptr addrspace(4) %8, i32 32
  %wide.load66 = load <16 x i32>, ptr addrspace(4) %10, align 4, !tbaa !3
  %11 = getelementptr inbounds i32, ptr addrspace(4) %8, i32 48
  %wide.load67 = load <16 x i32>, ptr addrspace(4) %11, align 4, !tbaa !3
  %12 = getelementptr inbounds i32, ptr addrspace(4) %b, i32 %offset.idx
  %wide.load68 = load <16 x i32>, ptr addrspace(4) %12, align 4, !tbaa !3
  %13 = getelementptr inbounds i32, ptr addrspace(4) %12, i32 16
  %wide.load69 = load <16 x i32>, ptr addrspace(4) %13, align 4, !tbaa !3
  %14 = getelementptr inbounds i32, ptr addrspace(4) %12, i32 32
  %wide.load70 = load <16 x i32>, ptr addrspace(4) %14, align 4, !tbaa !3
  %15 = getelementptr inbounds i32, ptr addrspace(4) %12, i32 48
  %wide.load71 = load <16 x i32>, ptr addrspace(4) %15, align 4, !tbaa !3
  %16 = mul nsw <16 x i32> %wide.load68, %wide.load
  %17 = mul nsw <16 x i32> %wide.load69, %wide.load65
  %18 = mul nsw <16 x i32> %wide.load70, %wide.load66
  %19 = mul nsw <16 x i32> %wide.load71, %wide.load67
  %20 = add <16 x i32> %16, %vec.phi
  %21 = add <16 x i32> %17, %vec.phi62
  %22 = add <16 x i32> %18, %vec.phi63
  %23 = add <16 x i32> %19, %vec.phi64
  %index.next = add nuw i32 %index, 64
  %24 = icmp eq i32 %index.next, %n.vec
  br i1 %24, label %middle.block, label %vector.body, !llvm.loop !13

middle.block:                                     ; preds = %vector.body
  %bin.rdx = add <16 x i32> %21, %20
  %bin.rdx72 = add <16 x i32> %22, %bin.rdx
  %bin.rdx73 = add <16 x i32> %23, %bin.rdx72
  %25 = tail call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %bin.rdx73)
  %cmp.n = icmp eq i32 %6, %n.vec
  br i1 %cmp.n, label %for.cond.cleanup28, label %vec.epilog.iter.check

vec.epilog.iter.check:                            ; preds = %middle.block
  %ind.end76 = add i32 %mul, %n.vec
  %n.vec.remaining = and i32 %6, 56
  %min.epilog.iters.check = icmp eq i32 %n.vec.remaining, 0
  br i1 %min.epilog.iters.check, label %for.body29.preheader, label %vec.epilog.ph

vec.epilog.ph:                                    ; preds = %vector.main.loop.iter.check, %vec.epilog.iter.check
  %bc.merge.rdx = phi i32 [ %vecext, %vector.main.loop.iter.check ], [ %25, %vec.epilog.iter.check ]
  %vec.epilog.resume.val = phi i32 [ 0, %vector.main.loop.iter.check ], [ %n.vec, %vec.epilog.iter.check ]
  %n.mod.vf74 = and i32 %n, 7
  %n.vec75 = sub nuw i32 %6, %n.mod.vf74
  %ind.end = add i32 %mul, %n.vec75
  %26 = insertelement <8 x i32> <i32 poison, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, i32 %bc.merge.rdx, i64 0
  br label %vec.epilog.vector.body

vec.epilog.vector.body:                           ; preds = %vec.epilog.vector.body, %vec.epilog.ph
  %index78 = phi i32 [ %vec.epilog.resume.val, %vec.epilog.ph ], [ %index.next83, %vec.epilog.vector.body ]
  %vec.phi79 = phi <8 x i32> [ %26, %vec.epilog.ph ], [ %30, %vec.epilog.vector.body ]
  %offset.idx80 = add i32 %mul, %index78
  %27 = getelementptr inbounds i32, ptr addrspace(4) %a, i32 %offset.idx80
  %wide.load81 = load <8 x i32>, ptr addrspace(4) %27, align 4, !tbaa !3
  %28 = getelementptr inbounds i32, ptr addrspace(4) %b, i32 %offset.idx80
  %wide.load82 = load <8 x i32>, ptr addrspace(4) %28, align 4, !tbaa !3
  %29 = mul nsw <8 x i32> %wide.load82, %wide.load81
  %30 = add <8 x i32> %29, %vec.phi79
  %index.next83 = add nuw i32 %index78, 8
  %31 = icmp eq i32 %index.next83, %n.vec75
  br i1 %31, label %vec.epilog.middle.block, label %vec.epilog.vector.body, !llvm.loop !15

vec.epilog.middle.block:                          ; preds = %vec.epilog.vector.body
  %32 = tail call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %30)
  %cmp.n77 = icmp eq i32 %n.mod.vf74, 0
  br i1 %cmp.n77, label %for.cond.cleanup28, label %for.body29.preheader

for.body29.preheader:                             ; preds = %iter.check, %vec.epilog.iter.check, %vec.epilog.middle.block
  %i25.059.ph = phi i32 [ %mul, %iter.check ], [ %ind.end76, %vec.epilog.iter.check ], [ %ind.end, %vec.epilog.middle.block ]
  %res.058.ph = phi i32 [ %vecext, %iter.check ], [ %25, %vec.epilog.iter.check ], [ %32, %vec.epilog.middle.block ]
  br label %for.body29

for.body:                                         ; preds = %for.body.preheader, %for.body
  %acc.sroa.0.056 = phi <16 x i32> [ %35, %for.body ], [ %0, %for.body.preheader ]
  %i.055 = phi i32 [ %add, %for.body ], [ 0, %for.body.preheader ]
  %arrayidx = getelementptr inbounds i32, ptr addrspace(4) %a, i32 %i.055
  %33 = tail call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %arrayidx)
  %arrayidx2 = getelementptr inbounds i32, ptr addrspace(4) %b, i32 %i.055
  %34 = tail call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %arrayidx2)
  %35 = tail call <16 x i32> @llvm.arc.vvcmac.lo.acc.w.v512(<16 x i32> %acc.sroa.0.056, <16 x i32> %33, <16 x i32> %34)
  %add = add nuw nsw i32 %i.055, 16
  %cmp = icmp slt i32 %add, %mul
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !16

for.cond.cleanup28:                               ; preds = %for.body29, %middle.block, %vec.epilog.middle.block, %for.cond.cleanup
  %res.0.lcssa = phi i32 [ %vecext, %for.cond.cleanup ], [ %25, %middle.block ], [ %32, %vec.epilog.middle.block ], [ %add33, %for.body29 ]
  ret i32 %res.0.lcssa

for.body29:                                       ; preds = %for.body29.preheader, %for.body29
  %i25.059 = phi i32 [ %inc, %for.body29 ], [ %i25.059.ph, %for.body29.preheader ]
  %res.058 = phi i32 [ %add33, %for.body29 ], [ %res.058.ph, %for.body29.preheader ]
  %arrayidx30 = getelementptr inbounds i32, ptr addrspace(4) %a, i32 %i25.059
  %36 = load i32, ptr addrspace(4) %arrayidx30, align 4, !tbaa !3
  %arrayidx31 = getelementptr inbounds i32, ptr addrspace(4) %b, i32 %i25.059
  %37 = load i32, ptr addrspace(4) %arrayidx31, align 4, !tbaa !3
  %mul32 = mul nsw i32 %37, %36
  %add33 = add nsw i32 %mul32, %res.058
  %inc = add nsw i32 %i25.059, 1
  %cmp27 = icmp slt i32 %inc, %n
  br i1 %cmp27, label %for.body29, label %for.cond.cleanup28, !llvm.loop !17
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: read)
define dso_local i32 @autovectorized_dotp(ptr addrspace(4) noalias nocapture noundef readonly %a, ptr addrspace(4) noalias nocapture noundef readonly %b, i32 noundef %n) local_unnamed_addr #0 {
entry:
  %cmp6 = icmp sgt i32 %n, 0
  br i1 %cmp6, label %iter.check, label %for.cond.cleanup

iter.check:                                       ; preds = %entry
  %min.iters.check = icmp ult i32 %n, 8
  br i1 %min.iters.check, label %for.body.preheader, label %vector.main.loop.iter.check

vector.main.loop.iter.check:                      ; preds = %iter.check
  %min.iters.check9 = icmp ult i32 %n, 64
  br i1 %min.iters.check9, label %vec.epilog.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.main.loop.iter.check
  %n.vec = and i32 %n, -64
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi <16 x i32> [ zeroinitializer, %vector.ph ], [ %12, %vector.body ]
  %vec.phi10 = phi <16 x i32> [ zeroinitializer, %vector.ph ], [ %13, %vector.body ]
  %vec.phi11 = phi <16 x i32> [ zeroinitializer, %vector.ph ], [ %14, %vector.body ]
  %vec.phi12 = phi <16 x i32> [ zeroinitializer, %vector.ph ], [ %15, %vector.body ]
  %0 = getelementptr inbounds i32, ptr addrspace(4) %a, i32 %index
  %wide.load = load <16 x i32>, ptr addrspace(4) %0, align 4, !tbaa !3
  %1 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 16
  %wide.load13 = load <16 x i32>, ptr addrspace(4) %1, align 4, !tbaa !3
  %2 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 32
  %wide.load14 = load <16 x i32>, ptr addrspace(4) %2, align 4, !tbaa !3
  %3 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 48
  %wide.load15 = load <16 x i32>, ptr addrspace(4) %3, align 4, !tbaa !3
  %4 = getelementptr inbounds i32, ptr addrspace(4) %b, i32 %index
  %wide.load16 = load <16 x i32>, ptr addrspace(4) %4, align 4, !tbaa !3
  %5 = getelementptr inbounds i32, ptr addrspace(4) %4, i32 16
  %wide.load17 = load <16 x i32>, ptr addrspace(4) %5, align 4, !tbaa !3
  %6 = getelementptr inbounds i32, ptr addrspace(4) %4, i32 32
  %wide.load18 = load <16 x i32>, ptr addrspace(4) %6, align 4, !tbaa !3
  %7 = getelementptr inbounds i32, ptr addrspace(4) %4, i32 48
  %wide.load19 = load <16 x i32>, ptr addrspace(4) %7, align 4, !tbaa !3
  %8 = mul nsw <16 x i32> %wide.load16, %wide.load
  %9 = mul nsw <16 x i32> %wide.load17, %wide.load13
  %10 = mul nsw <16 x i32> %wide.load18, %wide.load14
  %11 = mul nsw <16 x i32> %wide.load19, %wide.load15
  %12 = add <16 x i32> %8, %vec.phi
  %13 = add <16 x i32> %9, %vec.phi10
  %14 = add <16 x i32> %10, %vec.phi11
  %15 = add <16 x i32> %11, %vec.phi12
  %index.next = add nuw i32 %index, 64
  %16 = icmp eq i32 %index.next, %n.vec
  br i1 %16, label %middle.block, label %vector.body, !llvm.loop !18

middle.block:                                     ; preds = %vector.body
  %bin.rdx = add <16 x i32> %13, %12
  %bin.rdx20 = add <16 x i32> %14, %bin.rdx
  %bin.rdx21 = add <16 x i32> %15, %bin.rdx20
  %17 = tail call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %bin.rdx21)
  %cmp.n = icmp eq i32 %n.vec, %n
  br i1 %cmp.n, label %for.cond.cleanup, label %vec.epilog.iter.check

vec.epilog.iter.check:                            ; preds = %middle.block
  %n.vec.remaining = and i32 %n, 56
  %min.epilog.iters.check = icmp eq i32 %n.vec.remaining, 0
  br i1 %min.epilog.iters.check, label %for.body.preheader, label %vec.epilog.ph

vec.epilog.ph:                                    ; preds = %vector.main.loop.iter.check, %vec.epilog.iter.check
  %bc.merge.rdx = phi i32 [ 0, %vector.main.loop.iter.check ], [ %17, %vec.epilog.iter.check ]
  %vec.epilog.resume.val = phi i32 [ 0, %vector.main.loop.iter.check ], [ %n.vec, %vec.epilog.iter.check ]
  %n.vec23 = and i32 %n, -8
  %18 = insertelement <8 x i32> <i32 poison, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, i32 %bc.merge.rdx, i64 0
  br label %vec.epilog.vector.body

vec.epilog.vector.body:                           ; preds = %vec.epilog.vector.body, %vec.epilog.ph
  %index25 = phi i32 [ %vec.epilog.resume.val, %vec.epilog.ph ], [ %index.next29, %vec.epilog.vector.body ]
  %vec.phi26 = phi <8 x i32> [ %18, %vec.epilog.ph ], [ %22, %vec.epilog.vector.body ]
  %19 = getelementptr inbounds i32, ptr addrspace(4) %a, i32 %index25
  %wide.load27 = load <8 x i32>, ptr addrspace(4) %19, align 4, !tbaa !3
  %20 = getelementptr inbounds i32, ptr addrspace(4) %b, i32 %index25
  %wide.load28 = load <8 x i32>, ptr addrspace(4) %20, align 4, !tbaa !3
  %21 = mul nsw <8 x i32> %wide.load28, %wide.load27
  %22 = add <8 x i32> %21, %vec.phi26
  %index.next29 = add nuw i32 %index25, 8
  %23 = icmp eq i32 %index.next29, %n.vec23
  br i1 %23, label %vec.epilog.middle.block, label %vec.epilog.vector.body, !llvm.loop !19

vec.epilog.middle.block:                          ; preds = %vec.epilog.vector.body
  %24 = tail call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %22)
  %cmp.n24 = icmp eq i32 %n.vec23, %n
  br i1 %cmp.n24, label %for.cond.cleanup, label %for.body.preheader

for.body.preheader:                               ; preds = %iter.check, %vec.epilog.iter.check, %vec.epilog.middle.block
  %i.08.ph = phi i32 [ 0, %iter.check ], [ %n.vec, %vec.epilog.iter.check ], [ %n.vec23, %vec.epilog.middle.block ]
  %res.07.ph = phi i32 [ 0, %iter.check ], [ %17, %vec.epilog.iter.check ], [ %24, %vec.epilog.middle.block ]
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body, %middle.block, %vec.epilog.middle.block, %entry
  %res.0.lcssa = phi i32 [ 0, %entry ], [ %17, %middle.block ], [ %24, %vec.epilog.middle.block ], [ %add, %for.body ]
  ret i32 %res.0.lcssa

for.body:                                         ; preds = %for.body.preheader, %for.body
  %i.08 = phi i32 [ %inc, %for.body ], [ %i.08.ph, %for.body.preheader ]
  %res.07 = phi i32 [ %add, %for.body ], [ %res.07.ph, %for.body.preheader ]
  %arrayidx = getelementptr inbounds i32, ptr addrspace(4) %a, i32 %i.08
  %25 = load i32, ptr addrspace(4) %arrayidx, align 4, !tbaa !3
  %arrayidx1 = getelementptr inbounds i32, ptr addrspace(4) %b, i32 %i.08
  %26 = load i32, ptr addrspace(4) %arrayidx1, align 4, !tbaa !3
  %mul = mul nsw i32 %26, %25
  %add = add nsw i32 %mul, %res.07
  %inc = add nuw nsw i32 %i.08, 1
  %cmp = icmp slt i32 %inc, %n
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !20
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <16 x i32> @llvm.arc.vvcmpy.lo.acc.w.v512(<16 x i32>, <16 x i32>) #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(read)
declare <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4)) #3

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <16 x i32> @llvm.arc.vvcmac.lo.acc.w.v512(<16 x i32>, <16 x i32>, <16 x i32>) #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <16 x i32> @llvm.arc.vvc4add.acc.w.v512(<16 x i32>) #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <16 x i32> @llvm.arc.vvc4pack.acc.w.v512(<16 x i32>) #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32>) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.add.v16i32(<16 x i32>) #4

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.add.v8i32(<8 x i32>) #4

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: read) "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #1 = { mustprogress nofree nosync nounwind willreturn memory(read) "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #2 = { mustprogress nocallback nofree nosync nounwind willreturn memory(none) }
attributes #3 = { mustprogress nocallback nofree nosync nounwind willreturn memory(read) }
attributes #4 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"ArcIntrinsicCheck", i32 28778521}
!1 = !{i32 1, !"wchar_size", i32 2}
!2 = !{!"clang version 17.0.7 (git@gitsnps.internal.synopsys.com:MetaWare/mwdt-llvm-project.git 3cb6cb7579aa39b9c4db2b6a06b7c2eb3174f977)"}
!3 = !{!4, !4, i64 0}
!4 = !{!"int", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C/C++ TBAA"}
!7 = distinct !{!7, !8, !11}
!8 = distinct !{!8, !9, !10}
!9 = !{!"llvm.loop.mustprogress"}
!10 = !{!"llvm.loop.isvectorized"}
!11 = !{!"llvm.loop.unroll.runtime.disable"}
!12 = distinct !{!12, !8}
!13 = distinct !{!13, !9, !14, !11}
!14 = !{!"llvm.loop.isvectorized", i32 1}
!15 = distinct !{!15, !9, !14, !11}
!16 = distinct !{!16, !9}
!17 = distinct !{!17, !9, !11, !14}
!18 = distinct !{!18, !9, !14, !11}
!19 = distinct !{!19, !9, !14, !11}
!20 = distinct !{!20, !9, !11, !14}
