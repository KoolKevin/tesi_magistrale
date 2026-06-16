; ModuleID = 'dotp.c'
source_filename = "dotp.c"
target datalayout = "e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-f64:32-v64:32-v128:32-a:0:32-v256:32-v512:32-n8:16:32"
target triple = "arc-pc-unknown-gnu"

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: read)
define dso_local i32 @dotp(ptr nocapture noundef readonly %a, ptr nocapture noundef readonly %b, i32 noundef %n) local_unnamed_addr #0 {
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
  %0 = getelementptr inbounds i32, ptr %a, i32 %index
  %wide.load = load <16 x i32>, ptr %0, align 4, !tbaa !3
  %1 = getelementptr inbounds i32, ptr %0, i32 16
  %wide.load13 = load <16 x i32>, ptr %1, align 4, !tbaa !3
  %2 = getelementptr inbounds i32, ptr %0, i32 32
  %wide.load14 = load <16 x i32>, ptr %2, align 4, !tbaa !3
  %3 = getelementptr inbounds i32, ptr %0, i32 48
  %wide.load15 = load <16 x i32>, ptr %3, align 4, !tbaa !3
  %4 = getelementptr inbounds i32, ptr %b, i32 %index
  %wide.load16 = load <16 x i32>, ptr %4, align 4, !tbaa !3
  %5 = getelementptr inbounds i32, ptr %4, i32 16
  %wide.load17 = load <16 x i32>, ptr %5, align 4, !tbaa !3
  %6 = getelementptr inbounds i32, ptr %4, i32 32
  %wide.load18 = load <16 x i32>, ptr %6, align 4, !tbaa !3
  %7 = getelementptr inbounds i32, ptr %4, i32 48
  %wide.load19 = load <16 x i32>, ptr %7, align 4, !tbaa !3
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
  br i1 %16, label %middle.block, label %vector.body, !llvm.loop !7

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
  %19 = getelementptr inbounds i32, ptr %a, i32 %index25
  %wide.load27 = load <8 x i32>, ptr %19, align 4, !tbaa !3
  %20 = getelementptr inbounds i32, ptr %b, i32 %index25
  %wide.load28 = load <8 x i32>, ptr %20, align 4, !tbaa !3
  %21 = mul nsw <8 x i32> %wide.load28, %wide.load27
  %22 = add <8 x i32> %21, %vec.phi26
  %index.next29 = add nuw i32 %index25, 8
  %23 = icmp eq i32 %index.next29, %n.vec23
  br i1 %23, label %vec.epilog.middle.block, label %vec.epilog.vector.body, !llvm.loop !11

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
  %arrayidx = getelementptr inbounds i32, ptr %a, i32 %i.08
  %25 = load i32, ptr %arrayidx, align 4, !tbaa !3
  %arrayidx1 = getelementptr inbounds i32, ptr %b, i32 %i.08
  %26 = load i32, ptr %arrayidx1, align 4, !tbaa !3
  %mul = mul nsw i32 %26, %25
  %add = add nsw i32 %mul, %res.07
  %inc = add nuw nsw i32 %i.08, 1
  %cmp = icmp slt i32 %inc, %n
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !12
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define dso_local i32 @vectorized_dotp(ptr addrspace(4) noalias nocapture noundef readnone %a, ptr addrspace(4) noalias nocapture noundef readnone %b, i32 noundef %n) local_unnamed_addr #1 {
entry:
  ret i32 0
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
  br i1 %16, label %middle.block, label %vector.body, !llvm.loop !13

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
  br i1 %23, label %vec.epilog.middle.block, label %vec.epilog.vector.body, !llvm.loop !14

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
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !15
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.add.v16i32(<16 x i32>) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.add.v8i32(<8 x i32>) #2

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: read) "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #1 = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

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
