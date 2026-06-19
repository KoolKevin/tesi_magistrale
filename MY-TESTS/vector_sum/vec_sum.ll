; ModuleID = 'vec_sum.c'
source_filename = "vec_sum.c"
target datalayout = "e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-f64:32-v64:32-v128:32-a:0:32-v256:32-v512:32-n8:16:32"
target triple = "arc-pc-unknown-gnu"

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @vec_sum(ptr nocapture noundef readonly %a, ptr nocapture noundef readonly %b, ptr nocapture noundef writeonly %c, i32 noundef %n) local_unnamed_addr #0 {
entry:
  %cmp7 = icmp sgt i32 %n, 0
  br i1 %cmp7, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:                               ; preds = %entry
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body, %entry
  ret void

for.body:                                         ; preds = %for.body.preheader, %for.body
  %i.08 = phi i32 [ %inc, %for.body ], [ 0, %for.body.preheader ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i32 %i.08
  %0 = load i32, ptr %arrayidx, align 4, !tbaa !3
  %arrayidx1 = getelementptr inbounds i32, ptr %b, i32 %i.08
  %1 = load i32, ptr %arrayidx1, align 4, !tbaa !3
  %add = add nsw i32 %1, %0
  %arrayidx2 = getelementptr inbounds i32, ptr %c, i32 %i.08
  store i32 %add, ptr %arrayidx2, align 4, !tbaa !3
  %inc = add nuw nsw i32 %i.08, 1
  %cmp = icmp slt i32 %inc, %n
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !7
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
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !13
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
  br i1 %16, label %middle.block, label %vector.body, !llvm.loop !14

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
  br i1 %21, label %vec.epilog.middle.block, label %vec.epilog.vector.body, !llvm.loop !17

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
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !18
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
!7 = distinct !{!7, !8, !9, !10}
!8 = !{!"llvm.loop.mustprogress"}
!9 = !{!"llvm.loop.vectorize.width", i32 1}
!10 = !{!"llvm.loop.vectorize.followup_all", !11}
!11 = distinct !{!11, !8, !12}
!12 = !{!"llvm.loop.isvectorized"}
!13 = distinct !{!13, !8}
!14 = distinct !{!14, !8, !15, !16}
!15 = !{!"llvm.loop.isvectorized", i32 1}
!16 = !{!"llvm.loop.unroll.runtime.disable"}
!17 = distinct !{!17, !8, !15, !16}
!18 = distinct !{!18, !8, !16, !15}
