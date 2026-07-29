; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-f64:32-v64:32-v128:32-a:0:32-v256:32-v512:32-n8:16:32"
target triple = "arc-pc-unknown-gnu"

@in = addrspace(4) global [1024 x i32] zeroinitializer, align 4
@out = addrspace(4) global [1022 x i32] zeroinitializer, align 4
@kernel = addrspace(4) global [3 x i32] zeroinitializer, align 4
@.str = private unnamed_addr constant [39 x i8] c"Tempo di esecuzione di conv1d: %.2fms\0A\00", align 1
@.str.2 = private unnamed_addr constant [23 x i8] c"Vettorizzo su %d lane\0A\00", align 1
@.str.3 = private unnamed_addr constant [50 x i8] c"Tempo di esecuzione di vectorized_conv1d: %.2fms\0A\00", align 1
@.str.4 = private unnamed_addr constant [15 x i8] c"Speedup: %.2f\0A\00", align 1
@.str.6 = private unnamed_addr constant [54 x i8] c"Tempo di esecuzione di autovectorized_conv1d: %.2fms\0A\00", align 1
@.str.8 = private unnamed_addr constant [44 x i8] c"Tempo di esecuzione di vekt_conv1d: %.2fms\0A\00", align 1
@str = private unnamed_addr constant [26 x i8] c"Versione autovettorizzata\00", align 1
@str.9 = private unnamed_addr constant [27 x i8] c"Versione vekt-vettorizzata\00", align 1

; Function Attrs: nounwind
define dso_local i32 @main() local_unnamed_addr #0 {
entry:
  store <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5>, ptr addrspace(4) @in, align 4, !tbaa !3
  store <16 x i32> <i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 16), align 4, !tbaa !3
  store <16 x i32> <i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 32), align 4, !tbaa !3
  store <16 x i32> <i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 48), align 4, !tbaa !3
  store <16 x i32> <i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 64), align 4, !tbaa !3
  store <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 80), align 4, !tbaa !3
  store <16 x i32> <i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 96), align 4, !tbaa !3
  store <16 x i32> <i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 112), align 4, !tbaa !3
  store <16 x i32> <i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 128), align 4, !tbaa !3
  store <16 x i32> <i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 144), align 4, !tbaa !3
  store <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 160), align 4, !tbaa !3
  store <16 x i32> <i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 176), align 4, !tbaa !3
  store <16 x i32> <i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 192), align 4, !tbaa !3
  store <16 x i32> <i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 208), align 4, !tbaa !3
  store <16 x i32> <i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 224), align 4, !tbaa !3
  store <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 240), align 4, !tbaa !3
  store <16 x i32> <i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 256), align 4, !tbaa !3
  store <16 x i32> <i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 272), align 4, !tbaa !3
  store <16 x i32> <i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 288), align 4, !tbaa !3
  store <16 x i32> <i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 304), align 4, !tbaa !3
  store <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 320), align 4, !tbaa !3
  store <16 x i32> <i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 336), align 4, !tbaa !3
  store <16 x i32> <i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 352), align 4, !tbaa !3
  store <16 x i32> <i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 368), align 4, !tbaa !3
  store <16 x i32> <i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 384), align 4, !tbaa !3
  store <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 400), align 4, !tbaa !3
  store <16 x i32> <i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 416), align 4, !tbaa !3
  store <16 x i32> <i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 432), align 4, !tbaa !3
  store <16 x i32> <i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 448), align 4, !tbaa !3
  store <16 x i32> <i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 464), align 4, !tbaa !3
  store <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 480), align 4, !tbaa !3
  store <16 x i32> <i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 496), align 4, !tbaa !3
  store <16 x i32> <i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 512), align 4, !tbaa !3
  store <16 x i32> <i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 528), align 4, !tbaa !3
  store <16 x i32> <i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 544), align 4, !tbaa !3
  store <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 560), align 4, !tbaa !3
  store <16 x i32> <i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 576), align 4, !tbaa !3
  store <16 x i32> <i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 592), align 4, !tbaa !3
  store <16 x i32> <i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 608), align 4, !tbaa !3
  store <16 x i32> <i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 624), align 4, !tbaa !3
  store <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 640), align 4, !tbaa !3
  store <16 x i32> <i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 656), align 4, !tbaa !3
  store <16 x i32> <i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 672), align 4, !tbaa !3
  store <16 x i32> <i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 688), align 4, !tbaa !3
  store <16 x i32> <i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 704), align 4, !tbaa !3
  store <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 720), align 4, !tbaa !3
  store <16 x i32> <i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 736), align 4, !tbaa !3
  store <16 x i32> <i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 752), align 4, !tbaa !3
  store <16 x i32> <i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 768), align 4, !tbaa !3
  store <16 x i32> <i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 784), align 4, !tbaa !3
  store <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 800), align 4, !tbaa !3
  store <16 x i32> <i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 816), align 4, !tbaa !3
  store <16 x i32> <i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 832), align 4, !tbaa !3
  store <16 x i32> <i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 848), align 4, !tbaa !3
  store <16 x i32> <i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 864), align 4, !tbaa !3
  store <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 880), align 4, !tbaa !3
  store <16 x i32> <i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 896), align 4, !tbaa !3
  store <16 x i32> <i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 912), align 4, !tbaa !3
  store <16 x i32> <i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 928), align 4, !tbaa !3
  store <16 x i32> <i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 944), align 4, !tbaa !3
  store <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 960), align 4, !tbaa !3
  store <16 x i32> <i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 976), align 4, !tbaa !3
  store <16 x i32> <i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 992), align 4, !tbaa !3
  store <16 x i32> <i32 8, i32 9, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 0, i32 1, i32 2, i32 3>, ptr addrspace(4) getelementptr inbounds ([1024 x i32], ptr addrspace(4) @in, i32 0, i32 1008), align 4, !tbaa !3
  tail call void @init_vector(ptr noundef addrspacecast (ptr addrspace(4) @out to ptr), i32 noundef 1022, i32 noundef 0) #4
  tail call void @init_vector(ptr noundef addrspacecast (ptr addrspace(4) @kernel to ptr), i32 noundef 3, i32 noundef 1) #4
  %call = tail call i32 @clock() #4
  tail call void @conv1d(i32 noundef 1022, i32 noundef 1024, i32 noundef 3, ptr noundef addrspacecast (ptr addrspace(4) @out to ptr), ptr noundef addrspacecast (ptr addrspace(4) @in to ptr), ptr noundef addrspacecast (ptr addrspace(4) @kernel to ptr)) #4
  %call1 = tail call i32 @clock() #4
  %sub = sub nsw i32 %call1, %call
  %conv = sitofp i32 %sub to double
  %call2 = tail call i32 @_timer_clocks_per_sec() #4
  %conv3 = uitofp i32 %call2 to double
  %0 = fmul fast double %conv, 1.000000e+03
  %mul = fdiv fast double %0, %conv3
  %call4 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, double noundef nofpclass(nan inf) %mul)
  tail call void @print_vector(ptr noundef addrspacecast (ptr addrspace(4) @out to ptr), i32 noundef 1022) #4
  %putchar = tail call i32 @putchar(i32 10)
  %call6 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef 16)
  tail call void @init_vector(ptr noundef addrspacecast (ptr addrspace(4) @out to ptr), i32 noundef 1022, i32 noundef 0) #4
  %call7 = tail call i32 @clock() #4
  tail call void @vectorized_conv1d(i32 noundef 1022, i32 noundef 1024, i32 noundef 3, ptr addrspace(4) noundef @out, ptr addrspace(4) noundef @in, ptr addrspace(4) noundef @kernel) #4
  %call8 = tail call i32 @clock() #4
  %sub9 = sub nsw i32 %call8, %call7
  %conv10 = sitofp i32 %sub9 to double
  %call11 = tail call i32 @_timer_clocks_per_sec() #4
  %conv12 = uitofp i32 %call11 to double
  %1 = fmul fast double %conv10, 1.000000e+03
  %mul14 = fdiv fast double %1, %conv12
  %call15 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, double noundef nofpclass(nan inf) %mul14)
  %div16 = fdiv fast double %mul, %mul14
  %call17 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.4, double noundef nofpclass(nan inf) %div16)
  tail call void @print_vector(ptr noundef addrspacecast (ptr addrspace(4) @out to ptr), i32 noundef 1022) #4
  %putchar59 = tail call i32 @putchar(i32 10)
  %puts = tail call i32 @puts(ptr nonnull dereferenceable(1) @str)
  tail call void @init_vector(ptr noundef addrspacecast (ptr addrspace(4) @out to ptr), i32 noundef 1022, i32 noundef 0) #4
  %call20 = tail call i32 @clock() #4
  tail call void @autovectorized_conv1d(i32 noundef 1022, i32 noundef 1024, i32 noundef 3, ptr addrspace(4) noundef @out, ptr addrspace(4) noundef @in, ptr addrspace(4) noundef @kernel) #4
  %call21 = tail call i32 @clock() #4
  %sub22 = sub nsw i32 %call21, %call20
  %conv23 = sitofp i32 %sub22 to double
  %call24 = tail call i32 @_timer_clocks_per_sec() #4
  %conv25 = uitofp i32 %call24 to double
  %2 = fmul fast double %conv23, 1.000000e+03
  %mul27 = fdiv fast double %2, %conv25
  %call28 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.6, double noundef nofpclass(nan inf) %mul27)
  %div29 = fdiv fast double %mul, %mul27
  %call30 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.4, double noundef nofpclass(nan inf) %div29)
  tail call void @print_vector(ptr noundef addrspacecast (ptr addrspace(4) @out to ptr), i32 noundef 1022) #4
  %putchar60 = tail call i32 @putchar(i32 10)
  %puts61 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.9)
  tail call void @init_vector(ptr noundef addrspacecast (ptr addrspace(4) @out to ptr), i32 noundef 1022, i32 noundef 0) #4
  %call33 = tail call i32 @clock() #4
  tail call void @vekt_conv1d_wrapper(i32 noundef 1022, i32 noundef 1024, i32 noundef 3, ptr noundef addrspacecast (ptr addrspace(4) @out to ptr), ptr noundef addrspacecast (ptr addrspace(4) @in to ptr), ptr noundef addrspacecast (ptr addrspace(4) @kernel to ptr)) #4
  %call34 = tail call i32 @clock() #4
  %sub35 = sub nsw i32 %call34, %call33
  %conv36 = sitofp i32 %sub35 to double
  %call37 = tail call i32 @_timer_clocks_per_sec() #4
  %conv38 = uitofp i32 %call37 to double
  %3 = fmul fast double %conv36, 1.000000e+03
  %mul40 = fdiv fast double %3, %conv38
  %call41 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.8, double noundef nofpclass(nan inf) %mul40)
  %div42 = fdiv fast double %mul, %mul40
  %call43 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.4, double noundef nofpclass(nan inf) %div42)
  tail call void @print_vector(ptr noundef addrspacecast (ptr addrspace(4) @out to ptr), i32 noundef 1022) #4
  ret i32 0
}

declare void @init_vector(ptr noundef, i32 noundef, i32 noundef) local_unnamed_addr #1

declare i32 @clock() local_unnamed_addr #1

declare void @conv1d(i32 noundef, i32 noundef, i32 noundef, ptr noundef, ptr noundef, ptr noundef) local_unnamed_addr #1

declare i32 @_timer_clocks_per_sec() local_unnamed_addr #1

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #2

declare void @print_vector(ptr noundef, i32 noundef) local_unnamed_addr #1

declare void @vectorized_conv1d(i32 noundef, i32 noundef, i32 noundef, ptr addrspace(4) noundef, ptr addrspace(4) noundef, ptr addrspace(4) noundef) local_unnamed_addr #1

declare void @autovectorized_conv1d(i32 noundef, i32 noundef, i32 noundef, ptr addrspace(4) noundef, ptr addrspace(4) noundef, ptr addrspace(4) noundef) local_unnamed_addr #1

declare void @vekt_conv1d_wrapper(i32 noundef, i32 noundef, i32 noundef, ptr noundef, ptr noundef, ptr noundef) local_unnamed_addr #1

; Function Attrs: nofree nounwind
declare noundef i32 @putchar(i32 noundef) local_unnamed_addr #3

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #3

attributes #0 = { nounwind "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #1 = { "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #2 = { nofree nounwind "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #3 = { nofree nounwind }
attributes #4 = { nounwind }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"ArcIntrinsicCheck", i32 28778521}
!1 = !{i32 1, !"wchar_size", i32 2}
!2 = !{!"clang version 17.0.7 (git@gitsnps.internal.synopsys.com:MetaWare/mwdt-llvm-project.git 3cb6cb7579aa39b9c4db2b6a06b7c2eb3174f977)"}
!3 = !{!4, !4, i64 0}
!4 = !{!"int", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C/C++ TBAA"}
