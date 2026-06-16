; ModuleID = 'vec_sum.c'
source_filename = "vec_sum.c"
target datalayout = "e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-f64:32-v64:32-v128:32-a:0:32-v256:32-v512:32-n8:16:32"
target triple = "arc-pc-unknown-gnu"

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @vec_sum(ptr nocapture noundef readonly %a, ptr nocapture noundef readonly %b, ptr nocapture noundef writeonly %c, i32 noundef %n) local_unnamed_addr #0 {
entry:
  %cmp7 = icmp sgt i32 %n, 0
  br i1 %cmp7, label %iter.check, label %for.cond.cleanup

iter.check:                                       ; preds = %entry
  %min.iters.check = icmp ult i32 %n, 8
  br i1 %min.iters.check, label %for.body.preheader, label %vector.memcheck

vector.memcheck:                                  ; preds = %iter.check
  %0 = shl i32 %n, 2
  %scevgep = getelementptr i8, ptr %c, i32 %0
  %scevgep9 = getelementptr i8, ptr %a, i32 %0
  %scevgep10 = getelementptr i8, ptr %b, i32 %0
  %bound0 = icmp ugt ptr %scevgep9, %c
  %bound1 = icmp ugt ptr %scevgep, %a
  %found.conflict = and i1 %bound0, %bound1
  %bound011 = icmp ugt ptr %scevgep10, %c
  %bound112 = icmp ugt ptr %scevgep, %b
  %found.conflict13 = and i1 %bound011, %bound112
  %conflict.rdx = or i1 %found.conflict, %found.conflict13
  br i1 %conflict.rdx, label %for.body.preheader, label %vector.main.loop.iter.check

vector.main.loop.iter.check:                      ; preds = %vector.memcheck
  %min.iters.check14 = icmp ult i32 %n, 64
  br i1 %min.iters.check14, label %vec.epilog.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.main.loop.iter.check
  %n.vec = and i32 %n, -64
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %1 = getelementptr inbounds i32, ptr %a, i32 %index
  %wide.load = load <16 x i32>, ptr %1, align 4, !tbaa !3, !alias.scope !7
  %2 = getelementptr inbounds i32, ptr %1, i32 16
  %wide.load15 = load <16 x i32>, ptr %2, align 4, !tbaa !3, !alias.scope !7
  %3 = getelementptr inbounds i32, ptr %1, i32 32
  %wide.load16 = load <16 x i32>, ptr %3, align 4, !tbaa !3, !alias.scope !7
  %4 = getelementptr inbounds i32, ptr %1, i32 48
  %wide.load17 = load <16 x i32>, ptr %4, align 4, !tbaa !3, !alias.scope !7
  %5 = getelementptr inbounds i32, ptr %b, i32 %index
  %wide.load18 = load <16 x i32>, ptr %5, align 4, !tbaa !3, !alias.scope !10
  %6 = getelementptr inbounds i32, ptr %5, i32 16
  %wide.load19 = load <16 x i32>, ptr %6, align 4, !tbaa !3, !alias.scope !10
  %7 = getelementptr inbounds i32, ptr %5, i32 32
  %wide.load20 = load <16 x i32>, ptr %7, align 4, !tbaa !3, !alias.scope !10
  %8 = getelementptr inbounds i32, ptr %5, i32 48
  %wide.load21 = load <16 x i32>, ptr %8, align 4, !tbaa !3, !alias.scope !10
  %9 = add nsw <16 x i32> %wide.load18, %wide.load
  %10 = add nsw <16 x i32> %wide.load19, %wide.load15
  %11 = add nsw <16 x i32> %wide.load20, %wide.load16
  %12 = add nsw <16 x i32> %wide.load21, %wide.load17
  %13 = getelementptr inbounds i32, ptr %c, i32 %index
  store <16 x i32> %9, ptr %13, align 4, !tbaa !3, !alias.scope !12, !noalias !14
  %14 = getelementptr inbounds i32, ptr %13, i32 16
  store <16 x i32> %10, ptr %14, align 4, !tbaa !3, !alias.scope !12, !noalias !14
  %15 = getelementptr inbounds i32, ptr %13, i32 32
  store <16 x i32> %11, ptr %15, align 4, !tbaa !3, !alias.scope !12, !noalias !14
  %16 = getelementptr inbounds i32, ptr %13, i32 48
  store <16 x i32> %12, ptr %16, align 4, !tbaa !3, !alias.scope !12, !noalias !14
  %index.next = add nuw i32 %index, 64
  %17 = icmp eq i32 %index.next, %n.vec
  br i1 %17, label %middle.block, label %vector.body, !llvm.loop !15

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i32 %n.vec, %n
  br i1 %cmp.n, label %for.cond.cleanup, label %vec.epilog.iter.check

vec.epilog.iter.check:                            ; preds = %middle.block
  %n.vec.remaining = and i32 %n, 56
  %min.epilog.iters.check = icmp eq i32 %n.vec.remaining, 0
  br i1 %min.epilog.iters.check, label %for.body.preheader, label %vec.epilog.ph

vec.epilog.ph:                                    ; preds = %vector.main.loop.iter.check, %vec.epilog.iter.check
  %vec.epilog.resume.val = phi i32 [ %n.vec, %vec.epilog.iter.check ], [ 0, %vector.main.loop.iter.check ]
  %n.vec23 = and i32 %n, -8
  br label %vec.epilog.vector.body

vec.epilog.vector.body:                           ; preds = %vec.epilog.vector.body, %vec.epilog.ph
  %index25 = phi i32 [ %vec.epilog.resume.val, %vec.epilog.ph ], [ %index.next28, %vec.epilog.vector.body ]
  %18 = getelementptr inbounds i32, ptr %a, i32 %index25
  %wide.load26 = load <8 x i32>, ptr %18, align 4, !tbaa !3, !alias.scope !19
  %19 = getelementptr inbounds i32, ptr %b, i32 %index25
  %wide.load27 = load <8 x i32>, ptr %19, align 4, !tbaa !3, !alias.scope !22
  %20 = add nsw <8 x i32> %wide.load27, %wide.load26
  %21 = getelementptr inbounds i32, ptr %c, i32 %index25
  store <8 x i32> %20, ptr %21, align 4, !tbaa !3, !alias.scope !24, !noalias !26
  %index.next28 = add nuw i32 %index25, 8
  %22 = icmp eq i32 %index.next28, %n.vec23
  br i1 %22, label %vec.epilog.middle.block, label %vec.epilog.vector.body, !llvm.loop !27

vec.epilog.middle.block:                          ; preds = %vec.epilog.vector.body
  %cmp.n24 = icmp eq i32 %n.vec23, %n
  br i1 %cmp.n24, label %for.cond.cleanup, label %for.body.preheader

for.body.preheader:                               ; preds = %vector.memcheck, %iter.check, %vec.epilog.iter.check, %vec.epilog.middle.block
  %i.08.ph = phi i32 [ 0, %iter.check ], [ 0, %vector.memcheck ], [ %n.vec, %vec.epilog.iter.check ], [ %n.vec23, %vec.epilog.middle.block ]
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body, %middle.block, %vec.epilog.middle.block, %entry
  ret void

for.body:                                         ; preds = %for.body.preheader, %for.body
  %i.08 = phi i32 [ %inc, %for.body ], [ %i.08.ph, %for.body.preheader ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i32 %i.08
  %23 = load i32, ptr %arrayidx, align 4, !tbaa !3
  %arrayidx1 = getelementptr inbounds i32, ptr %b, i32 %i.08
  %24 = load i32, ptr %arrayidx1, align 4, !tbaa !3
  %add = add nsw i32 %24, %23
  %arrayidx2 = getelementptr inbounds i32, ptr %c, i32 %i.08
  store i32 %add, ptr %arrayidx2, align 4, !tbaa !3
  %inc = add nuw nsw i32 %i.08, 1
  %cmp = icmp slt i32 %inc, %n
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !28
}

; Function Attrs: mustprogress nofree nosync nounwind willreturn
define dso_local void @vectorized_vec_sum(ptr addrspace(4) noalias noundef %a, ptr addrspace(4) noalias noundef %b, ptr addrspace(4) noalias noundef %c, i32 noundef %n) local_unnamed_addr #1 {
entry:
  %div = sdiv i32 %n, 16
  %cmp14 = icmp sgt i32 %n, 15
  br i1 %cmp14, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:                               ; preds = %entry
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body, %entry
  ret void

for.body:                                         ; preds = %for.body.preheader, %for.body
  %i.015 = phi i32 [ %inc, %for.body ], [ 0, %for.body.preheader ]
  %mul = shl nsw i32 %i.015, 4
  %arrayidx = getelementptr inbounds i32, ptr addrspace(4) %a, i32 %mul
  %0 = tail call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %arrayidx)
  %arrayidx2 = getelementptr inbounds i32, ptr addrspace(4) %b, i32 %mul
  %1 = tail call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %arrayidx2)
  %2 = tail call <16 x i32> @llvm.arc.vvadd.w.v512(<16 x i32> %0, <16 x i32> %1)
  %arrayidx6 = getelementptr inbounds i32, ptr addrspace(4) %c, i32 %mul
  tail call void @llvm.arc.vvst.w.v512(<16 x i32> %2, ptr addrspace(4) %arrayidx6)
  %inc = add nuw nsw i32 %i.015, 1
  %cmp = icmp slt i32 %inc, %div
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !29
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @autovectorized_vec_sum(ptr addrspace(4) noalias nocapture noundef readonly %a, ptr addrspace(4) noalias nocapture noundef readonly %b, ptr addrspace(4) noalias nocapture noundef writeonly %c, i32 noundef %n) local_unnamed_addr #0 {
entry:
  %cmp7 = icmp sgt i32 %n, 0
  br i1 %cmp7, label %iter.check, label %for.cond.cleanup

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
  %0 = getelementptr inbounds i32, ptr addrspace(4) %a, i32 %index
  %wide.load = load <16 x i32>, ptr addrspace(4) %0, align 4, !tbaa !3
  %1 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 16
  %wide.load10 = load <16 x i32>, ptr addrspace(4) %1, align 4, !tbaa !3
  %2 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 32
  %wide.load11 = load <16 x i32>, ptr addrspace(4) %2, align 4, !tbaa !3
  %3 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 48
  %wide.load12 = load <16 x i32>, ptr addrspace(4) %3, align 4, !tbaa !3
  %4 = getelementptr inbounds i32, ptr addrspace(4) %b, i32 %index
  %wide.load13 = load <16 x i32>, ptr addrspace(4) %4, align 4, !tbaa !3
  %5 = getelementptr inbounds i32, ptr addrspace(4) %4, i32 16
  %wide.load14 = load <16 x i32>, ptr addrspace(4) %5, align 4, !tbaa !3
  %6 = getelementptr inbounds i32, ptr addrspace(4) %4, i32 32
  %wide.load15 = load <16 x i32>, ptr addrspace(4) %6, align 4, !tbaa !3
  %7 = getelementptr inbounds i32, ptr addrspace(4) %4, i32 48
  %wide.load16 = load <16 x i32>, ptr addrspace(4) %7, align 4, !tbaa !3
  %8 = add nsw <16 x i32> %wide.load13, %wide.load
  %9 = add nsw <16 x i32> %wide.load14, %wide.load10
  %10 = add nsw <16 x i32> %wide.load15, %wide.load11
  %11 = add nsw <16 x i32> %wide.load16, %wide.load12
  %12 = getelementptr inbounds i32, ptr addrspace(4) %c, i32 %index
  store <16 x i32> %8, ptr addrspace(4) %12, align 4, !tbaa !3
  %13 = getelementptr inbounds i32, ptr addrspace(4) %12, i32 16
  store <16 x i32> %9, ptr addrspace(4) %13, align 4, !tbaa !3
  %14 = getelementptr inbounds i32, ptr addrspace(4) %12, i32 32
  store <16 x i32> %10, ptr addrspace(4) %14, align 4, !tbaa !3
  %15 = getelementptr inbounds i32, ptr addrspace(4) %12, i32 48
  store <16 x i32> %11, ptr addrspace(4) %15, align 4, !tbaa !3
  %index.next = add nuw i32 %index, 64
  %16 = icmp eq i32 %index.next, %n.vec
  br i1 %16, label %middle.block, label %vector.body, !llvm.loop !30

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i32 %n.vec, %n
  br i1 %cmp.n, label %for.cond.cleanup, label %vec.epilog.iter.check

vec.epilog.iter.check:                            ; preds = %middle.block
  %n.vec.remaining = and i32 %n, 56
  %min.epilog.iters.check = icmp eq i32 %n.vec.remaining, 0
  br i1 %min.epilog.iters.check, label %for.body.preheader, label %vec.epilog.ph

vec.epilog.ph:                                    ; preds = %vector.main.loop.iter.check, %vec.epilog.iter.check
  %vec.epilog.resume.val = phi i32 [ %n.vec, %vec.epilog.iter.check ], [ 0, %vector.main.loop.iter.check ]
  %n.vec18 = and i32 %n, -8
  br label %vec.epilog.vector.body

vec.epilog.vector.body:                           ; preds = %vec.epilog.vector.body, %vec.epilog.ph
  %index20 = phi i32 [ %vec.epilog.resume.val, %vec.epilog.ph ], [ %index.next23, %vec.epilog.vector.body ]
  %17 = getelementptr inbounds i32, ptr addrspace(4) %a, i32 %index20
  %wide.load21 = load <8 x i32>, ptr addrspace(4) %17, align 4, !tbaa !3
  %18 = getelementptr inbounds i32, ptr addrspace(4) %b, i32 %index20
  %wide.load22 = load <8 x i32>, ptr addrspace(4) %18, align 4, !tbaa !3
  %19 = add nsw <8 x i32> %wide.load22, %wide.load21
  %20 = getelementptr inbounds i32, ptr addrspace(4) %c, i32 %index20
  store <8 x i32> %19, ptr addrspace(4) %20, align 4, !tbaa !3
  %index.next23 = add nuw i32 %index20, 8
  %21 = icmp eq i32 %index.next23, %n.vec18
  br i1 %21, label %vec.epilog.middle.block, label %vec.epilog.vector.body, !llvm.loop !31

vec.epilog.middle.block:                          ; preds = %vec.epilog.vector.body
  %cmp.n19 = icmp eq i32 %n.vec18, %n
  br i1 %cmp.n19, label %for.cond.cleanup, label %for.body.preheader

for.body.preheader:                               ; preds = %iter.check, %vec.epilog.iter.check, %vec.epilog.middle.block
  %i.08.ph = phi i32 [ 0, %iter.check ], [ %n.vec, %vec.epilog.iter.check ], [ %n.vec18, %vec.epilog.middle.block ]
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body, %middle.block, %vec.epilog.middle.block, %entry
  ret void

for.body:                                         ; preds = %for.body.preheader, %for.body
  %i.08 = phi i32 [ %inc, %for.body ], [ %i.08.ph, %for.body.preheader ]
  %arrayidx = getelementptr inbounds i32, ptr addrspace(4) %a, i32 %i.08
  %22 = load i32, ptr addrspace(4) %arrayidx, align 4, !tbaa !3
  %arrayidx1 = getelementptr inbounds i32, ptr addrspace(4) %b, i32 %i.08
  %23 = load i32, ptr addrspace(4) %arrayidx1, align 4, !tbaa !3
  %add = add nsw i32 %23, %22
  %arrayidx2 = getelementptr inbounds i32, ptr addrspace(4) %c, i32 %i.08
  store i32 %add, ptr addrspace(4) %arrayidx2, align 4, !tbaa !3
  %inc = add nuw nsw i32 %i.08, 1
  %cmp = icmp slt i32 %inc, %n
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !32
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(read)
declare <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4)) #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <16 x i32> @llvm.arc.vvadd.w.v512(<16 x i32>, <16 x i32>) #3

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(write)
declare void @llvm.arc.vvst.w.v512(<16 x i32>, ptr addrspace(4)) #4

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite) "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #1 = { mustprogress nofree nosync nounwind willreturn "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #2 = { mustprogress nocallback nofree nosync nounwind willreturn memory(read) }
attributes #3 = { mustprogress nocallback nofree nosync nounwind willreturn memory(none) }
attributes #4 = { mustprogress nocallback nofree nosync nounwind willreturn memory(write) }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"ArcIntrinsicCheck", i32 28778521}
!1 = !{i32 1, !"wchar_size", i32 2}
!2 = !{!"clang version 17.0.7 (git@gitsnps.internal.synopsys.com:MetaWare/mwdt-llvm-project.git 3cb6cb7579aa39b9c4db2b6a06b7c2eb3174f977)"}
!3 = !{!4, !4, i64 0}
!4 = !{!"int", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C/C++ TBAA"}
!7 = !{!8}
!8 = distinct !{!8, !9}
!9 = distinct !{!9, !"LVerDomain"}
!10 = !{!11}
!11 = distinct !{!11, !9}
!12 = !{!13}
!13 = distinct !{!13, !9}
!14 = !{!8, !11}
!15 = distinct !{!15, !16, !17, !18}
!16 = !{!"llvm.loop.mustprogress"}
!17 = !{!"llvm.loop.isvectorized", i32 1}
!18 = !{!"llvm.loop.unroll.runtime.disable"}
!19 = !{!20}
!20 = distinct !{!20, !21}
!21 = distinct !{!21, !"LVerDomain"}
!22 = !{!23}
!23 = distinct !{!23, !21}
!24 = !{!25}
!25 = distinct !{!25, !21}
!26 = !{!20, !23}
!27 = distinct !{!27, !16, !17, !18}
!28 = distinct !{!28, !16, !17}
!29 = distinct !{!29, !16}
!30 = distinct !{!30, !16, !17, !18}
!31 = distinct !{!31, !16, !17, !18}
!32 = distinct !{!32, !16, !18, !17}
