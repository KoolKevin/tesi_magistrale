; ModuleID = 'dotp.c'
source_filename = "dotp.c"
target datalayout = "e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-f64:32-v64:32-v128:32-a:0:32-v256:32-v512:32-n8:16:32"
target triple = "arc-pc-unknown-gnu"

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: read)
define dso_local i32 @dotp(ptr nocapture noundef readonly %a, ptr nocapture noundef readonly %b, i32 noundef %n) local_unnamed_addr #0 {
entry:
  %cmp6 = icmp sgt i32 %n, 0
  br i1 %cmp6, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:                               ; preds = %entry
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body, %entry
  %res.0.lcssa = phi i32 [ 0, %entry ], [ %add, %for.body ]
  ret i32 %res.0.lcssa

for.body:                                         ; preds = %for.body.preheader, %for.body
  %i.08 = phi i32 [ %inc, %for.body ], [ 0, %for.body.preheader ]
  %res.07 = phi i32 [ %add, %for.body ], [ 0, %for.body.preheader ]
  %arrayidx = getelementptr inbounds i32, ptr %a, i32 %i.08
  %0 = load i32, ptr %arrayidx, align 4, !tbaa !3
  %arrayidx1 = getelementptr inbounds i32, ptr %b, i32 %i.08
  %1 = load i32, ptr %arrayidx1, align 4, !tbaa !3
  %mul = mul nsw i32 %1, %0
  %add = add nsw i32 %mul, %res.07
  %inc = add nuw nsw i32 %i.08, 1
  %cmp = icmp slt i32 %inc, %n
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !7
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
  %acc.sroa.0.0.lcssa = phi <16 x i32> [ %0, %entry ], [ %23, %for.body ]
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
  %min.iters.check61 = icmp ult i32 %6, 16
  br i1 %min.iters.check61, label %vec.epilog.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.main.loop.iter.check
  %n.mod.vf = and i32 %n, 15
  %n.vec = sub nuw i32 %6, %n.mod.vf
  %7 = shufflevector <16 x i32> <i32 0, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>, <16 x i32> %5, <16 x i32> <i32 16, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi <16 x i32> [ %7, %vector.ph ], [ %11, %vector.body ]
  %offset.idx = add i32 %mul, %index
  %8 = getelementptr inbounds i32, ptr addrspace(4) %a, i32 %offset.idx
  %wide.load = load <16 x i32>, ptr addrspace(4) %8, align 4, !tbaa !3
  %9 = getelementptr inbounds i32, ptr addrspace(4) %b, i32 %offset.idx
  %wide.load62 = load <16 x i32>, ptr addrspace(4) %9, align 4, !tbaa !3
  %10 = mul nsw <16 x i32> %wide.load62, %wide.load
  %11 = add <16 x i32> %10, %vec.phi
  %index.next = add nuw i32 %index, 16
  %12 = icmp eq i32 %index.next, %n.vec
  br i1 %12, label %middle.block, label %vector.body, !llvm.loop !14

middle.block:                                     ; preds = %vector.body
  %13 = tail call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %11)
  %cmp.n = icmp eq i32 %n.mod.vf, 0
  br i1 %cmp.n, label %for.cond.cleanup28, label %vec.epilog.iter.check

vec.epilog.iter.check:                            ; preds = %middle.block
  %ind.end65 = add i32 %mul, %n.vec
  %min.epilog.iters.check = icmp ult i32 %n.mod.vf, 8
  br i1 %min.epilog.iters.check, label %for.body29.preheader, label %vec.epilog.ph

vec.epilog.ph:                                    ; preds = %vector.main.loop.iter.check, %vec.epilog.iter.check
  %bc.merge.rdx = phi i32 [ %vecext, %vector.main.loop.iter.check ], [ %13, %vec.epilog.iter.check ]
  %vec.epilog.resume.val = phi i32 [ 0, %vector.main.loop.iter.check ], [ %n.vec, %vec.epilog.iter.check ]
  %n.mod.vf63 = and i32 %n, 7
  %n.vec64 = sub i32 %6, %n.mod.vf63
  %ind.end = add i32 %mul, %n.vec64
  %14 = insertelement <8 x i32> <i32 poison, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, i32 %bc.merge.rdx, i64 0
  br label %vec.epilog.vector.body

vec.epilog.vector.body:                           ; preds = %vec.epilog.vector.body, %vec.epilog.ph
  %index67 = phi i32 [ %vec.epilog.resume.val, %vec.epilog.ph ], [ %index.next72, %vec.epilog.vector.body ]
  %vec.phi68 = phi <8 x i32> [ %14, %vec.epilog.ph ], [ %18, %vec.epilog.vector.body ]
  %offset.idx69 = add i32 %mul, %index67
  %15 = getelementptr inbounds i32, ptr addrspace(4) %a, i32 %offset.idx69
  %wide.load70 = load <8 x i32>, ptr addrspace(4) %15, align 4, !tbaa !3
  %16 = getelementptr inbounds i32, ptr addrspace(4) %b, i32 %offset.idx69
  %wide.load71 = load <8 x i32>, ptr addrspace(4) %16, align 4, !tbaa !3
  %17 = mul nsw <8 x i32> %wide.load71, %wide.load70
  %18 = add <8 x i32> %17, %vec.phi68
  %index.next72 = add nuw i32 %index67, 8
  %19 = icmp eq i32 %index.next72, %n.vec64
  br i1 %19, label %vec.epilog.middle.block, label %vec.epilog.vector.body, !llvm.loop !17

vec.epilog.middle.block:                          ; preds = %vec.epilog.vector.body
  %20 = tail call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %18)
  %cmp.n66 = icmp eq i32 %n.mod.vf63, 0
  br i1 %cmp.n66, label %for.cond.cleanup28, label %for.body29.preheader

for.body29.preheader:                             ; preds = %iter.check, %vec.epilog.iter.check, %vec.epilog.middle.block
  %i25.059.ph = phi i32 [ %mul, %iter.check ], [ %ind.end65, %vec.epilog.iter.check ], [ %ind.end, %vec.epilog.middle.block ]
  %res.058.ph = phi i32 [ %vecext, %iter.check ], [ %13, %vec.epilog.iter.check ], [ %20, %vec.epilog.middle.block ]
  br label %for.body29

for.body:                                         ; preds = %for.body.preheader, %for.body
  %acc.sroa.0.056 = phi <16 x i32> [ %23, %for.body ], [ %0, %for.body.preheader ]
  %i.055 = phi i32 [ %add, %for.body ], [ 0, %for.body.preheader ]
  %arrayidx = getelementptr inbounds i32, ptr addrspace(4) %a, i32 %i.055
  %21 = tail call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %arrayidx)
  %arrayidx2 = getelementptr inbounds i32, ptr addrspace(4) %b, i32 %i.055
  %22 = tail call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %arrayidx2)
  %23 = tail call <16 x i32> @llvm.arc.vvcmac.lo.acc.w.v512(<16 x i32> %acc.sroa.0.056, <16 x i32> %21, <16 x i32> %22)
  %add = add nuw nsw i32 %i.055, 16
  %cmp = icmp slt i32 %add, %mul
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !18

for.cond.cleanup28:                               ; preds = %for.body29, %middle.block, %vec.epilog.middle.block, %for.cond.cleanup
  %res.0.lcssa = phi i32 [ %vecext, %for.cond.cleanup ], [ %13, %middle.block ], [ %20, %vec.epilog.middle.block ], [ %add33, %for.body29 ]
  ret i32 %res.0.lcssa

for.body29:                                       ; preds = %for.body29.preheader, %for.body29
  %i25.059 = phi i32 [ %inc, %for.body29 ], [ %i25.059.ph, %for.body29.preheader ]
  %res.058 = phi i32 [ %add33, %for.body29 ], [ %res.058.ph, %for.body29.preheader ]
  %arrayidx30 = getelementptr inbounds i32, ptr addrspace(4) %a, i32 %i25.059
  %24 = load i32, ptr addrspace(4) %arrayidx30, align 4, !tbaa !3
  %arrayidx31 = getelementptr inbounds i32, ptr addrspace(4) %b, i32 %i25.059
  %25 = load i32, ptr addrspace(4) %arrayidx31, align 4, !tbaa !3
  %mul32 = mul nsw i32 %25, %24
  %add33 = add nsw i32 %mul32, %res.058
  %inc = add nsw i32 %i25.059, 1
  %cmp27 = icmp slt i32 %inc, %n
  br i1 %cmp27, label %for.body29, label %for.cond.cleanup28, !llvm.loop !19
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
  %min.iters.check9 = icmp ult i32 %n, 16
  br i1 %min.iters.check9, label %vec.epilog.ph, label %vector.ph

vector.ph:                                        ; preds = %vector.main.loop.iter.check
  %n.vec = and i32 %n, -16
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %vec.phi = phi <16 x i32> [ zeroinitializer, %vector.ph ], [ %3, %vector.body ]
  %0 = getelementptr inbounds i32, ptr addrspace(4) %a, i32 %index
  %wide.load = load <16 x i32>, ptr addrspace(4) %0, align 4, !tbaa !3
  %1 = getelementptr inbounds i32, ptr addrspace(4) %b, i32 %index
  %wide.load10 = load <16 x i32>, ptr addrspace(4) %1, align 4, !tbaa !3
  %2 = mul nsw <16 x i32> %wide.load10, %wide.load
  %3 = add <16 x i32> %2, %vec.phi
  %index.next = add nuw i32 %index, 16
  %4 = icmp eq i32 %index.next, %n.vec
  br i1 %4, label %middle.block, label %vector.body, !llvm.loop !20

middle.block:                                     ; preds = %vector.body
  %5 = tail call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %3)
  %cmp.n = icmp eq i32 %n.vec, %n
  br i1 %cmp.n, label %for.cond.cleanup, label %vec.epilog.iter.check

vec.epilog.iter.check:                            ; preds = %middle.block
  %n.vec.remaining = and i32 %n, 8
  %min.epilog.iters.check.not.not = icmp eq i32 %n.vec.remaining, 0
  br i1 %min.epilog.iters.check.not.not, label %for.body.preheader, label %vec.epilog.ph

vec.epilog.ph:                                    ; preds = %vector.main.loop.iter.check, %vec.epilog.iter.check
  %bc.merge.rdx = phi i32 [ 0, %vector.main.loop.iter.check ], [ %5, %vec.epilog.iter.check ]
  %vec.epilog.resume.val = phi i32 [ 0, %vector.main.loop.iter.check ], [ %n.vec, %vec.epilog.iter.check ]
  %n.vec12 = and i32 %n, -8
  %6 = insertelement <8 x i32> <i32 poison, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, i32 %bc.merge.rdx, i64 0
  br label %vec.epilog.vector.body

vec.epilog.vector.body:                           ; preds = %vec.epilog.vector.body, %vec.epilog.ph
  %index14 = phi i32 [ %vec.epilog.resume.val, %vec.epilog.ph ], [ %index.next18, %vec.epilog.vector.body ]
  %vec.phi15 = phi <8 x i32> [ %6, %vec.epilog.ph ], [ %10, %vec.epilog.vector.body ]
  %7 = getelementptr inbounds i32, ptr addrspace(4) %a, i32 %index14
  %wide.load16 = load <8 x i32>, ptr addrspace(4) %7, align 4, !tbaa !3
  %8 = getelementptr inbounds i32, ptr addrspace(4) %b, i32 %index14
  %wide.load17 = load <8 x i32>, ptr addrspace(4) %8, align 4, !tbaa !3
  %9 = mul nsw <8 x i32> %wide.load17, %wide.load16
  %10 = add <8 x i32> %9, %vec.phi15
  %index.next18 = add nuw i32 %index14, 8
  %11 = icmp eq i32 %index.next18, %n.vec12
  br i1 %11, label %vec.epilog.middle.block, label %vec.epilog.vector.body, !llvm.loop !21

vec.epilog.middle.block:                          ; preds = %vec.epilog.vector.body
  %12 = tail call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %10)
  %cmp.n13 = icmp eq i32 %n.vec12, %n
  br i1 %cmp.n13, label %for.cond.cleanup, label %for.body.preheader

for.body.preheader:                               ; preds = %iter.check, %vec.epilog.iter.check, %vec.epilog.middle.block
  %i.08.ph = phi i32 [ 0, %iter.check ], [ %n.vec, %vec.epilog.iter.check ], [ %n.vec12, %vec.epilog.middle.block ]
  %res.07.ph = phi i32 [ 0, %iter.check ], [ %5, %vec.epilog.iter.check ], [ %12, %vec.epilog.middle.block ]
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body, %middle.block, %vec.epilog.middle.block, %entry
  %res.0.lcssa = phi i32 [ 0, %entry ], [ %5, %middle.block ], [ %12, %vec.epilog.middle.block ], [ %add, %for.body ]
  ret i32 %res.0.lcssa

for.body:                                         ; preds = %for.body.preheader, %for.body
  %i.08 = phi i32 [ %inc, %for.body ], [ %i.08.ph, %for.body.preheader ]
  %res.07 = phi i32 [ %add, %for.body ], [ %res.07.ph, %for.body.preheader ]
  %arrayidx = getelementptr inbounds i32, ptr addrspace(4) %a, i32 %i.08
  %13 = load i32, ptr addrspace(4) %arrayidx, align 4, !tbaa !3
  %arrayidx1 = getelementptr inbounds i32, ptr addrspace(4) %b, i32 %i.08
  %14 = load i32, ptr addrspace(4) %arrayidx1, align 4, !tbaa !3
  %mul = mul nsw i32 %14, %13
  %add = add nsw i32 %mul, %res.07
  %inc = add nuw nsw i32 %i.08, 1
  %cmp = icmp slt i32 %inc, %n
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !22
}

; Function Attrs: nounwind
define dso_local i32 @vekt_dotp_wrapper(ptr noundef %a, ptr noundef %b, i32 noundef %n) local_unnamed_addr #2 {
entry:
  %call = tail call i32 @vekt_dotp(ptr noundef %a, ptr noundef %a, i32 noundef 0, i32 noundef %n, i32 noundef 1, ptr noundef %b, ptr noundef %b, i32 noundef 0, i32 noundef %n, i32 noundef 1, i32 noundef %n) #7
  ret i32 %call
}

declare i32 @vekt_dotp(ptr noundef, ptr noundef, i32 noundef, i32 noundef, i32 noundef, ptr noundef, ptr noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef) local_unnamed_addr #3

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <16 x i32> @llvm.arc.vvcmpy.lo.acc.w.v512(<16 x i32>, <16 x i32>) #4

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(read)
declare <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4)) #5

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <16 x i32> @llvm.arc.vvcmac.lo.acc.w.v512(<16 x i32>, <16 x i32>, <16 x i32>) #4

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <16 x i32> @llvm.arc.vvc4add.acc.w.v512(<16 x i32>) #4

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <16 x i32> @llvm.arc.vvc4pack.acc.w.v512(<16 x i32>) #4

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <16 x i32> @llvm.arc.acc.to.vec.w.v512(<16 x i32>) #4

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.add.v16i32(<16 x i32>) #6

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.vector.reduce.add.v8i32(<8 x i32>) #6

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: read) "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #1 = { mustprogress nofree nosync nounwind willreturn memory(read) "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #2 = { nounwind "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #3 = { "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #4 = { mustprogress nocallback nofree nosync nounwind willreturn memory(none) }
attributes #5 = { mustprogress nocallback nofree nosync nounwind willreturn memory(read) }
attributes #6 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #7 = { nounwind }

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
!10 = !{!"llvm.loop.vectorize.width", i32 1}
!11 = !{!"llvm.loop.vectorize.followup_all", !12}
!12 = distinct !{!12, !8, !9, !9, !13}
!13 = !{!"llvm.loop.isvectorized"}
!14 = distinct !{!14, !8, !9, !9, !15, !16}
!15 = !{!"llvm.loop.isvectorized", i32 1}
!16 = !{!"llvm.loop.unroll.runtime.disable"}
!17 = distinct !{!17, !8, !9, !9, !15, !16}
!18 = distinct !{!18, !8, !9, !9}
!19 = distinct !{!19, !8, !9, !9, !15}
!20 = distinct !{!20, !8, !9, !9, !15, !16}
!21 = distinct !{!21, !8, !9, !9, !15, !16}
!22 = distinct !{!22, !8, !9, !9, !15}
