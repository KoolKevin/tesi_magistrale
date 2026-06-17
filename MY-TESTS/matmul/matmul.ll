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

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @matmul(ptr nocapture noundef readonly %A, ptr nocapture noundef readonly %B, ptr nocapture noundef %C, i32 noundef %M, i32 noundef %K, i32 noundef %N) local_unnamed_addr #1 {
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
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !14

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
  br i1 %cmp2, label %for.body4, label %for.cond.cleanup3, !llvm.loop !19

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
  br i1 %cmp6, label %for.body8, label %for.cond.cleanup7, !llvm.loop !22
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define dso_local void @vectorized_matmul(ptr addrspace(4) noalias nocapture noundef %A, ptr addrspace(4) noalias nocapture noundef %B, ptr addrspace(4) noalias nocapture noundef %C, i32 noundef %M, i32 noundef %K, i32 noundef %N) local_unnamed_addr #2 {
entry:
  ret void
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @autovectorized_matmul(ptr addrspace(4) noalias nocapture noundef readonly %A, ptr addrspace(4) noalias nocapture noundef readonly %B, ptr addrspace(4) noalias nocapture noundef %C, i32 noundef %M, i32 noundef %K, i32 noundef %N) local_unnamed_addr #1 {
entry:
  %cmp40 = icmp sgt i32 %M, 0
  br i1 %cmp40, label %for.body.lr.ph, label %for.cond.cleanup

for.body.lr.ph:                                   ; preds = %entry
  %cmp238 = icmp sgt i32 %N, 0
  %cmp635 = icmp sgt i32 %K, 0
  %min.iters.check = icmp ugt i32 %K, 7
  %ident.check.not = icmp eq i32 %N, 1
  %or.cond = and i1 %min.iters.check, %ident.check.not
  %min.iters.check42 = icmp ult i32 %K, 16
  %n.vec = and i32 %K, -16
  %cmp.n = icmp eq i32 %n.vec, %K
  %n.vec.remaining = and i32 %K, 8
  %min.epilog.iters.check.not.not = icmp eq i32 %n.vec.remaining, 0
  %n.vec45 = and i32 %K, -8
  %cmp.n46 = icmp eq i32 %n.vec45, %K
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
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !25

for.body4:                                        ; preds = %for.body4.lr.ph, %for.cond.cleanup7
  %j.039 = phi i32 [ 0, %for.body4.lr.ph ], [ %inc18, %for.cond.cleanup7 ]
  br i1 %cmp635, label %iter.check, label %for.cond.cleanup7

iter.check:                                       ; preds = %for.body4
  %add14 = add nsw i32 %j.039, %mul13
  %arrayidx15 = getelementptr inbounds i32, ptr addrspace(4) %C, i32 %add14
  %arrayidx15.promoted = load i32, ptr addrspace(4) %arrayidx15, align 4, !tbaa !3
  br i1 %or.cond, label %vector.main.loop.iter.check, label %for.body8.preheader

vector.main.loop.iter.check:                      ; preds = %iter.check
  br i1 %min.iters.check42, label %vec.epilog.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.main.loop.iter.check
  %0 = insertelement <16 x i32> <i32 poison, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, i32 %arrayidx15.promoted, i64 0
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi <16 x i32> [ %0, %vector.ph ], [ %6, %vector.body ]
  %1 = add nsw i32 %index, %mul
  %2 = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %1
  %wide.load = load <16 x i32>, ptr addrspace(4) %2, align 4, !tbaa !3
  %3 = add nsw i32 %index, %j.039
  %4 = getelementptr inbounds i32, ptr addrspace(4) %B, i32 %3
  %wide.load43 = load <16 x i32>, ptr addrspace(4) %4, align 4, !tbaa !3
  %5 = mul nsw <16 x i32> %wide.load43, %wide.load
  %6 = add <16 x i32> %5, %vec.phi
  %index.next = add nuw i32 %index, 16
  %7 = icmp eq i32 %index.next, %n.vec
  br i1 %7, label %middle.block, label %vector.body, !llvm.loop !26

middle.block:                                     ; preds = %vector.body
  %8 = tail call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %6)
  br i1 %cmp.n, label %for.cond5.for.cond.cleanup7_crit_edge, label %vec.epilog.iter.check

vec.epilog.iter.check:                            ; preds = %middle.block
  br i1 %min.epilog.iters.check.not.not, label %for.body8.preheader, label %vec.epilog.ph

vec.epilog.ph:                                    ; preds = %vector.main.loop.iter.check, %vec.epilog.iter.check
  %bc.merge.rdx = phi i32 [ %arrayidx15.promoted, %vector.main.loop.iter.check ], [ %8, %vec.epilog.iter.check ]
  %vec.epilog.resume.val = phi i32 [ 0, %vector.main.loop.iter.check ], [ %n.vec, %vec.epilog.iter.check ]
  %9 = insertelement <8 x i32> <i32 poison, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, i32 %bc.merge.rdx, i64 0
  br label %vec.epilog.vector.body

vec.epilog.vector.body:                           ; preds = %vec.epilog.vector.body, %vec.epilog.ph
  %index47 = phi i32 [ %vec.epilog.resume.val, %vec.epilog.ph ], [ %index.next51, %vec.epilog.vector.body ]
  %vec.phi48 = phi <8 x i32> [ %9, %vec.epilog.ph ], [ %15, %vec.epilog.vector.body ]
  %10 = add nsw i32 %index47, %mul
  %11 = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %10
  %wide.load49 = load <8 x i32>, ptr addrspace(4) %11, align 4, !tbaa !3
  %12 = add nsw i32 %index47, %j.039
  %13 = getelementptr inbounds i32, ptr addrspace(4) %B, i32 %12
  %wide.load50 = load <8 x i32>, ptr addrspace(4) %13, align 4, !tbaa !3
  %14 = mul nsw <8 x i32> %wide.load50, %wide.load49
  %15 = add <8 x i32> %14, %vec.phi48
  %index.next51 = add nuw i32 %index47, 8
  %16 = icmp eq i32 %index.next51, %n.vec45
  br i1 %16, label %vec.epilog.middle.block, label %vec.epilog.vector.body, !llvm.loop !27

vec.epilog.middle.block:                          ; preds = %vec.epilog.vector.body
  %17 = tail call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %15)
  br i1 %cmp.n46, label %for.cond5.for.cond.cleanup7_crit_edge, label %for.body8.preheader

for.body8.preheader:                              ; preds = %iter.check, %vec.epilog.iter.check, %vec.epilog.middle.block
  %add1637.ph = phi i32 [ %arrayidx15.promoted, %iter.check ], [ %8, %vec.epilog.iter.check ], [ %17, %vec.epilog.middle.block ]
  %k.036.ph = phi i32 [ 0, %iter.check ], [ %n.vec, %vec.epilog.iter.check ], [ %n.vec45, %vec.epilog.middle.block ]
  br label %for.body8

for.cond5.for.cond.cleanup7_crit_edge:            ; preds = %for.body8, %vec.epilog.middle.block, %middle.block
  %add16.lcssa = phi i32 [ %8, %middle.block ], [ %17, %vec.epilog.middle.block ], [ %add16, %for.body8 ]
  store i32 %add16.lcssa, ptr addrspace(4) %arrayidx15, align 4, !tbaa !3
  br label %for.cond.cleanup7

for.cond.cleanup7:                                ; preds = %for.cond5.for.cond.cleanup7_crit_edge, %for.body4
  %inc18 = add nuw nsw i32 %j.039, 1
  %cmp2 = icmp slt i32 %inc18, %N
  br i1 %cmp2, label %for.body4, label %for.cond.cleanup3, !llvm.loop !28

for.body8:                                        ; preds = %for.body8.preheader, %for.body8
  %add1637 = phi i32 [ %add16, %for.body8 ], [ %add1637.ph, %for.body8.preheader ]
  %k.036 = phi i32 [ %inc, %for.body8 ], [ %k.036.ph, %for.body8.preheader ]
  %add = add nsw i32 %k.036, %mul
  %arrayidx = getelementptr inbounds i32, ptr addrspace(4) %A, i32 %add
  %18 = load i32, ptr addrspace(4) %arrayidx, align 4, !tbaa !3
  %mul9 = mul nsw i32 %k.036, %N
  %add10 = add nsw i32 %mul9, %j.039
  %arrayidx11 = getelementptr inbounds i32, ptr addrspace(4) %B, i32 %add10
  %19 = load i32, ptr addrspace(4) %arrayidx11, align 4, !tbaa !3
  %mul12 = mul nsw i32 %19, %18
  %add16 = add nsw i32 %mul12, %add1637
  %inc = add nuw nsw i32 %k.036, 1
  %cmp6 = icmp slt i32 %inc, %K
  br i1 %cmp6, label %for.body8, label %for.cond5.for.cond.cleanup7_crit_edge, !llvm.loop !29
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.add.v16i32(<16 x i32>) #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.add.v8i32(<8 x i32>) #3

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: write) "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #1 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite) "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #2 = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #3 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

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
!14 = distinct !{!14, !8, !9, !9, !15, !16}
!15 = !{!"llvm.loop.vectorize.width", i32 1}
!16 = !{!"llvm.loop.vectorize.followup_all", !17}
!17 = distinct !{!17, !8, !9, !9, !18}
!18 = !{!"llvm.loop.isvectorized"}
!19 = distinct !{!19, !8, !9, !9, !15, !20}
!20 = !{!"llvm.loop.vectorize.followup_all", !21}
!21 = distinct !{!21, !8, !9, !9, !18}
!22 = distinct !{!22, !8, !9, !9, !15, !23}
!23 = !{!"llvm.loop.vectorize.followup_all", !24}
!24 = distinct !{!24, !8, !9, !9, !18}
!25 = distinct !{!25, !8, !9, !9}
!26 = distinct !{!26, !8, !9, !9, !10, !11}
!27 = distinct !{!27, !8, !9, !9, !10, !11}
!28 = distinct !{!28, !8, !9, !9}
!29 = distinct !{!29, !8, !9, !9, !10}
