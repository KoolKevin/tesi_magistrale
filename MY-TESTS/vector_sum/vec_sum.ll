; ModuleID = 'vec_sum.c'
source_filename = "vec_sum.c"
target datalayout = "e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-f64:32-v64:32-v128:32-a:0:32-v256:32-v512:32-n8:16:32"
target triple = "arc-pc-unknown-gnu"

; Function Attrs: noinline nounwind
define dso_local void @init_vector(ptr noundef %a, i32 noundef %dim, i32 noundef %value) #0 {
entry:
  %a.addr = alloca ptr, align 4
  %dim.addr = alloca i32, align 4
  %value.addr = alloca i32, align 4
  %i = alloca i32, align 4
  store ptr %a, ptr %a.addr, align 4
  store i32 %dim, ptr %dim.addr, align 4
  store i32 %value, ptr %value.addr, align 4
  store i32 0, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, ptr %i, align 4
  %1 = load i32, ptr %dim.addr, align 4
  %cmp = icmp slt i32 %0, %1
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %2 = load i32, ptr %value.addr, align 4
  %3 = load ptr, ptr %a.addr, align 4
  %4 = load i32, ptr %i, align 4
  %arrayidx = getelementptr inbounds i32, ptr %3, i32 %4
  store i32 %2, ptr %arrayidx, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %5 = load i32, ptr %i, align 4
  %inc = add nsw i32 %5, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !3

for.end:                                          ; preds = %for.cond
  ret void
}

; Function Attrs: noinline nounwind
define dso_local void @vec_sum(ptr noundef %a, ptr noundef %b, ptr noundef %c, i32 noundef %n) #0 {
entry:
  %a.addr = alloca ptr, align 4
  %b.addr = alloca ptr, align 4
  %c.addr = alloca ptr, align 4
  %n.addr = alloca i32, align 4
  %i = alloca i32, align 4
  store ptr %a, ptr %a.addr, align 4
  store ptr %b, ptr %b.addr, align 4
  store ptr %c, ptr %c.addr, align 4
  store i32 %n, ptr %n.addr, align 4
  store i32 0, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, ptr %i, align 4
  %1 = load i32, ptr %n.addr, align 4
  %cmp = icmp slt i32 %0, %1
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %2 = load ptr, ptr %a.addr, align 4
  %3 = load i32, ptr %i, align 4
  %arrayidx = getelementptr inbounds i32, ptr %2, i32 %3
  %4 = load i32, ptr %arrayidx, align 4
  %5 = load ptr, ptr %b.addr, align 4
  %6 = load i32, ptr %i, align 4
  %arrayidx1 = getelementptr inbounds i32, ptr %5, i32 %6
  %7 = load i32, ptr %arrayidx1, align 4
  %add = add nsw i32 %4, %7
  %8 = load ptr, ptr %c.addr, align 4
  %9 = load i32, ptr %i, align 4
  %arrayidx2 = getelementptr inbounds i32, ptr %8, i32 %9
  store i32 %add, ptr %arrayidx2, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %10 = load i32, ptr %i, align 4
  %inc = add nsw i32 %10, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  ret void
}

; Function Attrs: noinline nounwind
define dso_local void @vectorized_vec_sum(ptr addrspace(4) noalias noundef %a, ptr addrspace(4) noalias noundef %b, ptr addrspace(4) noalias noundef %c, i32 noundef %n) #0 {
entry:
  %v.addr.i = alloca <16 x i32>, align 4
  %x.addr.i9 = alloca ptr addrspace(4), align 4
  %x.addr.i8 = alloca <16 x i32>, align 4
  %y.addr.i = alloca <16 x i32>, align 4
  %x.addr.i7 = alloca ptr addrspace(4), align 4
  %x.addr.i = alloca ptr addrspace(4), align 4
  %a.addr = alloca ptr addrspace(4), align 4
  %b.addr = alloca ptr addrspace(4), align 4
  %c.addr = alloca ptr addrspace(4), align 4
  %n.addr = alloca i32, align 4
  %va = alloca <16 x i32>, align 4
  %vb = alloca <16 x i32>, align 4
  %vc = alloca <16 x i32>, align 4
  %lanes = alloca i32, align 4
  %num_vectors = alloca i32, align 4
  %i = alloca i32, align 4
  store ptr addrspace(4) %a, ptr %a.addr, align 4
  store ptr addrspace(4) %b, ptr %b.addr, align 4
  store ptr addrspace(4) %c, ptr %c.addr, align 4
  store i32 %n, ptr %n.addr, align 4
  store <16 x i32> zeroinitializer, ptr %va, align 4
  store <16 x i32> zeroinitializer, ptr %vb, align 4
  store <16 x i32> zeroinitializer, ptr %vc, align 4
  store i32 16, ptr %lanes, align 4
  %0 = load i32, ptr %n.addr, align 4
  %1 = load i32, ptr %lanes, align 4
  %div = sdiv i32 %0, %1
  store i32 %div, ptr %num_vectors, align 4
  store i32 0, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %2 = load i32, ptr %i, align 4
  %3 = load i32, ptr %num_vectors, align 4
  %cmp = icmp slt i32 %2, %3
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %4 = load ptr addrspace(4), ptr %a.addr, align 4
  %5 = load i32, ptr %i, align 4
  %6 = load i32, ptr %lanes, align 4
  %mul = mul nsw i32 %5, %6
  %arrayidx = getelementptr inbounds i32, ptr addrspace(4) %4, i32 %mul
  store ptr addrspace(4) %arrayidx, ptr %x.addr.i7, align 4
  %7 = load ptr addrspace(4), ptr %x.addr.i7, align 4
  %8 = call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %7)
  store <16 x i32> %8, ptr %va, align 4
  %9 = load ptr addrspace(4), ptr %b.addr, align 4
  %10 = load i32, ptr %i, align 4
  %11 = load i32, ptr %lanes, align 4
  %mul1 = mul nsw i32 %10, %11
  %arrayidx2 = getelementptr inbounds i32, ptr addrspace(4) %9, i32 %mul1
  store ptr addrspace(4) %arrayidx2, ptr %x.addr.i, align 4
  %12 = load ptr addrspace(4), ptr %x.addr.i, align 4
  %13 = call <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4) %12)
  store <16 x i32> %13, ptr %vb, align 4
  %14 = load <16 x i32>, ptr %va, align 4
  %15 = load <16 x i32>, ptr %vb, align 4
  store <16 x i32> %14, ptr %x.addr.i8, align 4
  store <16 x i32> %15, ptr %y.addr.i, align 4
  %16 = load <16 x i32>, ptr %x.addr.i8, align 4
  %17 = load <16 x i32>, ptr %y.addr.i, align 4
  %18 = call <16 x i32> @llvm.arc.vvadd.w.v512(<16 x i32> %16, <16 x i32> %17)
  store <16 x i32> %18, ptr %vc, align 4
  %19 = load <16 x i32>, ptr %vc, align 4
  %20 = load ptr addrspace(4), ptr %c.addr, align 4
  %21 = load i32, ptr %i, align 4
  %22 = load i32, ptr %lanes, align 4
  %mul5 = mul nsw i32 %21, %22
  %arrayidx6 = getelementptr inbounds i32, ptr addrspace(4) %20, i32 %mul5
  store <16 x i32> %19, ptr %v.addr.i, align 4
  store ptr addrspace(4) %arrayidx6, ptr %x.addr.i9, align 4
  %23 = load <16 x i32>, ptr %v.addr.i, align 4
  %24 = load ptr addrspace(4), ptr %x.addr.i9, align 4
  call void @llvm.arc.vvst.w.v512(<16 x i32> %23, ptr addrspace(4) %24)
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %25 = load i32, ptr %i, align 4
  %inc = add nsw i32 %25, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !10

for.end:                                          ; preds = %for.cond
  ret void
}

; Function Attrs: noinline nounwind
define dso_local void @autovectorized_vec_sum(ptr addrspace(4) noalias noundef %a, ptr addrspace(4) noalias noundef %b, ptr addrspace(4) noalias noundef %c, i32 noundef %n) #0 {
entry:
  %a.addr = alloca ptr addrspace(4), align 4
  %b.addr = alloca ptr addrspace(4), align 4
  %c.addr = alloca ptr addrspace(4), align 4
  %n.addr = alloca i32, align 4
  %i = alloca i32, align 4
  store ptr addrspace(4) %a, ptr %a.addr, align 4
  store ptr addrspace(4) %b, ptr %b.addr, align 4
  store ptr addrspace(4) %c, ptr %c.addr, align 4
  store i32 %n, ptr %n.addr, align 4
  store i32 0, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, ptr %i, align 4
  %1 = load i32, ptr %n.addr, align 4
  %cmp = icmp slt i32 %0, %1
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %2 = load ptr addrspace(4), ptr %a.addr, align 4
  %3 = load i32, ptr %i, align 4
  %arrayidx = getelementptr inbounds i32, ptr addrspace(4) %2, i32 %3
  %4 = load i32, ptr addrspace(4) %arrayidx, align 4
  %5 = load ptr addrspace(4), ptr %b.addr, align 4
  %6 = load i32, ptr %i, align 4
  %arrayidx1 = getelementptr inbounds i32, ptr addrspace(4) %5, i32 %6
  %7 = load i32, ptr addrspace(4) %arrayidx1, align 4
  %add = add nsw i32 %4, %7
  %8 = load ptr addrspace(4), ptr %c.addr, align 4
  %9 = load i32, ptr %i, align 4
  %arrayidx2 = getelementptr inbounds i32, ptr addrspace(4) %8, i32 %9
  store i32 %add, ptr addrspace(4) %arrayidx2, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %10 = load i32, ptr %i, align 4
  %inc = add nsw i32 %10, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !11

for.end:                                          ; preds = %for.cond
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(read)
declare <16 x i32> @llvm.arc.vvld.w.v512(ptr addrspace(4)) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare <16 x i32> @llvm.arc.vvadd.w.v512(<16 x i32>, <16 x i32>) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(write)
declare void @llvm.arc.vvst.w.v512(<16 x i32>, ptr addrspace(4)) #3

attributes #0 = { noinline nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(read) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(write) }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"ArcIntrinsicCheck", i32 28778521}
!1 = !{i32 1, !"wchar_size", i32 2}
!2 = !{!"clang version 17.0.7 (git@gitsnps.internal.synopsys.com:MetaWare/mwdt-llvm-project.git 3cb6cb7579aa39b9c4db2b6a06b7c2eb3174f977)"}
!3 = distinct !{!3, !4}
!4 = !{!"llvm.loop.mustprogress"}
!5 = distinct !{!5, !4, !6, !7}
!6 = !{!"llvm.loop.vectorize.width", i32 1}
!7 = !{!"llvm.loop.vectorize.followup_all", !8}
!8 = distinct !{!8, !4, !9}
!9 = !{!"llvm.loop.isvectorized"}
!10 = distinct !{!10, !4}
!11 = distinct !{!11, !4}
