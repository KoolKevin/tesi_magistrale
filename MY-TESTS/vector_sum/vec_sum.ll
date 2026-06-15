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
  %i.08 = phi i32 [ %inc, %for.body ], [ 0, %for.body.preheader ]       ; i = 0 || inc
  %arrayidx = getelementptr inbounds i32, ptr %a, i32 %i.08
  %0 = load i32, ptr %arrayidx, align 4, !tbaa !3                       ; a[i]
  %arrayidx1 = getelementptr inbounds i32, ptr %b, i32 %i.08
  %1 = load i32, ptr %arrayidx1, align 4, !tbaa !3                      ; b[i]
  %add = add nsw i32 %1, %0
  %arrayidx2 = getelementptr inbounds i32, ptr %c, i32 %i.08
  store i32 %add, ptr %arrayidx2, align 4, !tbaa !3                     ; c[i] = sum
  %inc = add nuw nsw i32 %i.08, 1
  %cmp = icmp slt i32 %inc, %n                                          ; i++
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !7
}

; Function Attrs: mustprogress nofree nosync nounwind willreturn
define dso_local void @vectorized_vec_sum(ptr addrspace(4) noalias noundef %a, ptr addrspace(4) noalias noundef %b, ptr addrspace(4) noalias noundef %c, i32 noundef %n) local_unnamed_addr #1 {
entry:
  %div = sdiv i32 %n, 16        ; num_vectors = n / lanes
  %cmp12 = icmp sgt i32 %n, 15  ; n > 15
  br i1 %cmp12, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:                               ; preds = %entry
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body, %entry
  ret void

for.body:                                         ; preds = %for.body.preheader, %for.body
  %i.013 = phi i32 [ %inc, %for.body ], [ 0, %for.body.preheader ]                  ; i = 0 || inc
  %add.ptr = getelementptr inbounds <16 x i32>, ptr addrspace(4) %a, i32 %i.013     ; puntatore a vNint_t per a[i]
  %0 = tail call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %add.ptr)        ; load del vettore a[i]
  %add.ptr4 = getelementptr inbounds <16 x i32>, ptr addrspace(4) %b, i32 %i.013    ; puntatore a vNint_t per b[i]
  %1 = tail call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %add.ptr4)       ; load del vettore b[i]
  %2 = tail call <16 x i32> @llvm.arc.vvadd.w.v512(<16 x i32> %0, <16 x i32> %1)    ; somma dei vettori
  %add.ptr7 = getelementptr inbounds <16 x i32>, ptr addrspace(4) %c, i32 %i.013    ; puntatore a vettore c[i]
  tail call void @llvm.arc.vvst.w.v512(<16 x i32> %2, ptr addrspace(4) %add.ptr7)   ; store del vettore
  %inc = add nuw nsw i32 %i.013, 1                                                  ; i++ -> nota che basta incrementare di 1 dato che le gep
                                                                                    ; hanno come tipo <16 x i32>
  %cmp = icmp slt i32 %inc, %div
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !9
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(read)
declare <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4)) #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare <16 x i32> @llvm.arc.vvadd.w.v512(<16 x i32>, <16 x i32>) #3

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(write)
declare void @llvm.arc.vvst.w.v512(<16 x i32>, ptr addrspace(4)) #4

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" }
attributes #1 = { mustprogress nofree nosync nounwind willreturn "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" }
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
!7 = distinct !{!7, !8}
!8 = !{!"llvm.loop.mustprogress"}
!9 = distinct !{!9, !8}
