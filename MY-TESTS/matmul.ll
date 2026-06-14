; ModuleID = 'matmul.c'
source_filename = "matmul.c"
target datalayout = "e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-f64:32-v64:32-v128:32-a:0:32-v256:32-v512:32-n8:16:32"
target triple = "arc-pc-unknown-gnu"

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @matmul(ptr nocapture noundef readonly %A, ptr nocapture noundef readonly %B, ptr nocapture noundef %C, i32 noundef %M, i32 noundef %K, i32 noundef %N) local_unnamed_addr #0 {
entry:
  %mul = mul nsw i32 %N, %M
  %cmp50 = icmp sgt i32 %mul, 0
  br i1 %cmp50, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:                               ; preds = %entry
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body, %entry
  %cmp357 = icmp sgt i32 %M, 0
  br i1 %cmp357, label %for.body5.lr.ph, label %for.cond.cleanup4

for.body5.lr.ph:                                  ; preds = %for.cond.cleanup
  %cmp755 = icmp sgt i32 %N, 0
  %cmp1152 = icmp sgt i32 %K, 0
  br label %for.body5

for.body:                                         ; preds = %for.body.preheader, %for.body
  %i.051 = phi i32 [ %inc, %for.body ], [ 0, %for.body.preheader ]
  %arrayidx = getelementptr inbounds i32, ptr %C, i32 %i.051
  store i32 0, ptr %arrayidx, align 4, !tbaa !3
  %inc = add nuw nsw i32 %i.051, 1
  %cmp = icmp slt i32 %inc, %mul
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !7

for.cond.cleanup4:                                ; preds = %for.cond.cleanup8, %for.cond.cleanup
  ret void

for.body5:                                        ; preds = %for.body5.lr.ph, %for.cond.cleanup8
  %i1.058 = phi i32 [ 0, %for.body5.lr.ph ], [ %inc31, %for.cond.cleanup8 ]
  br i1 %cmp755, label %for.body9.lr.ph, label %for.cond.cleanup8

for.body9.lr.ph:                                  ; preds = %for.body5
  %mul14 = mul nsw i32 %i1.058, %K
  %mul20 = mul nsw i32 %i1.058, %N
  br label %for.body9

for.cond.cleanup8:                                ; preds = %for.cond.cleanup12, %for.body5
  %inc31 = add nuw nsw i32 %i1.058, 1
  %cmp3 = icmp slt i32 %inc31, %M
  br i1 %cmp3, label %for.body5, label %for.cond.cleanup4, !llvm.loop !9

for.body9:                                        ; preds = %for.body9.lr.ph, %for.cond.cleanup12
  %j.056 = phi i32 [ 0, %for.body9.lr.ph ], [ %inc28, %for.cond.cleanup12 ]
  br i1 %cmp1152, label %for.body13.lr.ph, label %for.cond.cleanup12

for.body13.lr.ph:                                 ; preds = %for.body9
  %add21 = add nsw i32 %j.056, %mul20
  %arrayidx22 = getelementptr inbounds i32, ptr %C, i32 %add21
  %arrayidx22.promoted = load i32, ptr %arrayidx22, align 4, !tbaa !3
  br label %for.body13

for.cond.cleanup12:                               ; preds = %for.body13, %for.body9
  %inc28 = add nuw nsw i32 %j.056, 1
  %cmp7 = icmp slt i32 %inc28, %N
  br i1 %cmp7, label %for.body9, label %for.cond.cleanup8, !llvm.loop !10

for.body13:                                       ; preds = %for.body13.lr.ph, %for.body13
  %add2354 = phi i32 [ %arrayidx22.promoted, %for.body13.lr.ph ], [ %add23, %for.body13 ]
  %k.053 = phi i32 [ 0, %for.body13.lr.ph ], [ %inc25, %for.body13 ]
  %add = add nsw i32 %k.053, %mul14
  %arrayidx15 = getelementptr inbounds i32, ptr %A, i32 %add
  %0 = load i32, ptr %arrayidx15, align 4, !tbaa !3
  %mul16 = mul nsw i32 %k.053, %N
  %add17 = add nsw i32 %mul16, %j.056
  %arrayidx18 = getelementptr inbounds i32, ptr %B, i32 %add17
  %1 = load i32, ptr %arrayidx18, align 4, !tbaa !3
  %mul19 = mul nsw i32 %1, %0
  %add23 = add nsw i32 %mul19, %add2354
  store i32 %add23, ptr %arrayidx22, align 4, !tbaa !3
  %inc25 = add nuw nsw i32 %k.053, 1
  %cmp11 = icmp slt i32 %inc25, %K
  br i1 %cmp11, label %for.body13, label %for.cond.cleanup12, !llvm.loop !11
}

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vfpu2" }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"ArcIntrinsicCheck", i32 28778521}
!1 = !{i32 1, !"wchar_size", i32 2}
!2 = !{!"clang version 17.0.7 (git@gitsnps.internal.synopsys.com:MetaWare/mwdt-llvm-project.git 3cb6cb7579aa39b9c4db2b6a06b7c2eb3174f977)"}
!3 = !{!4, !4, i64 0}
!4 = !{!"int", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C/C++ TBAA"}
!7 = distinct !{!7, !8}
!8 = !{!"llvm.loop.mustprogress"}
!9 = distinct !{!9, !8}
!10 = distinct !{!10, !8}
!11 = distinct !{!11, !8}
