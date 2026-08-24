; ModuleID = 'vec_sum.omp.ll'
source_filename = "LLVMDialectModule"

%struct.ident_t = type { i32, i32, i32, i32, ptr }

@0 = private unnamed_addr constant [23 x i8] c";unknown;unknown;0;0;;\00", align 1
@1 = private unnamed_addr constant %struct.ident_t { i32 0, i32 2, i32 0, i32 22, ptr @0 }, align 8
@2 = private unnamed_addr constant %struct.ident_t { i32 0, i32 66, i32 0, i32 22, ptr @0 }, align 8

; Function Attrs: nounwind
define void @vec_sum_omp(ptr %0, ptr %1, ptr %2, i64 %3, i32 %4) local_unnamed_addr #0 {
entry:
  %structArg = alloca { ptr, ptr, ptr, ptr }, align 8
  %.reloaded = alloca i64, align 8
  %omp_global_thread_num = tail call i32 @__kmpc_global_thread_num(ptr nonnull @1)
  tail call void @__kmpc_push_num_threads(ptr nonnull @1, i32 %omp_global_thread_num, i32 %4)
  store i64 %3, ptr %.reloaded, align 8
  store ptr %.reloaded, ptr %structArg, align 8
  %gep_ = getelementptr inbounds nuw i8, ptr %structArg, i64 8
  store ptr %0, ptr %gep_, align 8
  %gep_6 = getelementptr inbounds nuw i8, ptr %structArg, i64 16
  store ptr %1, ptr %gep_6, align 8
  %gep_7 = getelementptr inbounds nuw i8, ptr %structArg, i64 24
  store ptr %2, ptr %gep_7, align 8
  call void (ptr, i32, ptr, ...) @__kmpc_fork_call(ptr nonnull @1, i32 1, ptr nonnull @vec_sum_omp..omp_par, ptr nonnull %structArg)
  ret void
}

; Function Attrs: nounwind
define internal void @vec_sum_omp..omp_par(ptr noalias nocapture readnone %tid.addr, ptr noalias nocapture readnone %zero.addr, ptr nocapture readonly %0) #0 {
omp.par.entry:
  %loadgep_.reloaded = load ptr, ptr %0, align 8
  %gep_ = getelementptr i8, ptr %0, i64 8
  %loadgep_ = load ptr, ptr %gep_, align 8
  %loadgep_5 = ptrtoint ptr %loadgep_ to i64
  %gep_1 = getelementptr i8, ptr %0, i64 16
  %loadgep_2 = load ptr, ptr %gep_1, align 8
  %loadgep_26 = ptrtoint ptr %loadgep_2 to i64
  %gep_3 = getelementptr i8, ptr %0, i64 24
  %loadgep_4 = load ptr, ptr %gep_3, align 8
  %loadgep_43 = ptrtoint ptr %loadgep_4 to i64
  %p.lastiter = alloca i32, align 4
  %p.lowerbound = alloca i64, align 8
  %p.upperbound = alloca i64, align 8
  %p.stride = alloca i64, align 8
  %1 = load i64, ptr %loadgep_.reloaded, align 4
  %.inv = icmp sgt i64 %1, 0
  store i64 0, ptr %p.lowerbound, align 8
  %2 = tail call i64 @llvm.usub.sat.i64(i64 %1, i64 1)
  %3 = select i1 %.inv, i64 %2, i64 -1
  store i64 %3, ptr %p.upperbound, align 8
  store i64 1, ptr %p.stride, align 8
  %omp_global_thread_num4 = tail call i32 @__kmpc_global_thread_num(ptr nonnull @1)
  call void @__kmpc_for_static_init_8u(ptr nonnull @1, i32 %omp_global_thread_num4, i32 34, ptr nonnull %p.lastiter, ptr nonnull %p.lowerbound, ptr nonnull %p.upperbound, ptr nonnull %p.stride, i64 1, i64 0)
  %4 = load i64, ptr %p.lowerbound, align 8
  %5 = load i64, ptr %p.upperbound, align 8
  %reass.sub = sub i64 %5, %4
  %6 = add i64 %reass.sub, 1
  %omp_loop.cmp1.not = icmp eq i64 %6, 0
  br i1 %omp_loop.cmp1.not, label %omp_loop.exit, label %omp_loop.body.preheader

omp_loop.body.preheader:                          ; preds = %omp.par.entry
  %min.iters.check = icmp ult i64 %6, 8
  br i1 %min.iters.check, label %omp_loop.body.preheader9, label %vector.memcheck

vector.memcheck:                                  ; preds = %omp_loop.body.preheader
  %7 = sub i64 %loadgep_43, %loadgep_5
  %diff.check = icmp ult i64 %7, 4
  %8 = sub i64 %loadgep_43, %loadgep_26
  %diff.check7 = icmp ult i64 %8, 4
  %conflict.rdx = or i1 %diff.check, %diff.check7
  br i1 %conflict.rdx, label %omp_loop.body.preheader9, label %vector.ph

vector.ph:                                        ; preds = %vector.memcheck
  %n.vec = and i64 %6, -4
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %9 = add i64 %index, %4
  %10 = getelementptr i8, ptr %loadgep_, i64 %9
  %11 = getelementptr i8, ptr %loadgep_2, i64 %9
  %12 = getelementptr i8, ptr %loadgep_4, i64 %9
  %wide.load = load <4 x i8>, ptr %10, align 1
  %wide.load8 = load <4 x i8>, ptr %11, align 1
  %13 = add <4 x i8> %wide.load8, %wide.load
  store <4 x i8> %13, ptr %12, align 1
  %index.next = add nuw i64 %index, 4
  %14 = icmp eq i64 %index.next, %n.vec
  br i1 %14, label %middle.block, label %vector.body, !llvm.loop !1

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %6, %n.vec
  br i1 %cmp.n, label %omp_loop.exit, label %omp_loop.body.preheader9

omp_loop.body.preheader9:                         ; preds = %vector.memcheck, %omp_loop.body.preheader, %middle.block
  %omp_loop.iv2.ph = phi i64 [ 0, %omp_loop.body.preheader ], [ 0, %vector.memcheck ], [ %n.vec, %middle.block ]
  br label %omp_loop.body

omp_loop.exit:                                    ; preds = %omp_loop.body, %middle.block, %omp.par.entry
  call void @__kmpc_for_static_fini(ptr nonnull @1, i32 %omp_global_thread_num4)
  %omp_global_thread_num5 = call i32 @__kmpc_global_thread_num(ptr nonnull @1)
  call void @__kmpc_barrier(ptr nonnull @2, i32 %omp_global_thread_num5)
  ret void

omp_loop.body:                                    ; preds = %omp_loop.body.preheader9, %omp_loop.body
  %omp_loop.iv2 = phi i64 [ %omp_loop.next, %omp_loop.body ], [ %omp_loop.iv2.ph, %omp_loop.body.preheader9 ]
  %15 = add i64 %omp_loop.iv2, %4
  %16 = getelementptr i8, ptr %loadgep_, i64 %15
  %17 = getelementptr i8, ptr %loadgep_2, i64 %15
  %18 = getelementptr i8, ptr %loadgep_4, i64 %15
  %19 = load i8, ptr %16, align 1
  %20 = load i8, ptr %17, align 1
  %21 = add i8 %20, %19
  store i8 %21, ptr %18, align 1
  %omp_loop.next = add nuw i64 %omp_loop.iv2, 1
  %omp_loop.cmp = icmp ult i64 %omp_loop.next, %6
  br i1 %omp_loop.cmp, label %omp_loop.body, label %omp_loop.exit, !llvm.loop !4
}

; Function Attrs: nounwind
declare i32 @__kmpc_global_thread_num(ptr) local_unnamed_addr #0

; Function Attrs: nounwind
declare void @__kmpc_push_num_threads(ptr, i32, i32) local_unnamed_addr #0

; Function Attrs: nounwind
declare void @__kmpc_for_static_init_8u(ptr, i32, i32, ptr, ptr, ptr, ptr, i64, i64) local_unnamed_addr #0

; Function Attrs: nounwind
declare void @__kmpc_for_static_fini(ptr, i32) local_unnamed_addr #0

; Function Attrs: convergent nounwind
declare void @__kmpc_barrier(ptr, i32) local_unnamed_addr #1

; Function Attrs: nounwind
declare !callback !5 void @__kmpc_fork_call(ptr, i32, ptr, ...) local_unnamed_addr #0

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.usub.sat.i64(i64, i64) #2

attributes #0 = { nounwind }
attributes #1 = { convergent nounwind }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
!1 = distinct !{!1, !2, !3}
!2 = !{!"llvm.loop.isvectorized", i32 1}
!3 = !{!"llvm.loop.unroll.runtime.disable"}
!4 = distinct !{!4, !2}
!5 = !{!6}
!6 = !{i64 2, i64 -1, i64 -1, i1 true}
