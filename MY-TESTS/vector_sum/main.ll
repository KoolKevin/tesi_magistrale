; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-f64:32-v64:32-v128:32-a:0:32-v256:32-v512:32-n8:16:32"
target triple = "arc-pc-unknown-gnu"

@.str.1 = private unnamed_addr constant [40 x i8] c"Tempo di esecuzione di vec_sum: %.2fms\0A\00", align 1
@.str.3 = private unnamed_addr constant [30 x i8] c"a[%d]=%d, b[%d]=%d, c[%d]=%d\0A\00", align 1
@.str.5 = private unnamed_addr constant [23 x i8] c"Vettorizzo su %d lane\0A\00", align 1
@.str.6 = private unnamed_addr constant [51 x i8] c"Tempo di esecuzione di vectorized_vec_sum: %.2fms\0A\00", align 1
@.str.7 = private unnamed_addr constant [15 x i8] c"Speedup: %.2f\0A\00", align 1
@.str.9 = private unnamed_addr constant [55 x i8] c"Tempo di esecuzione di autovectorized_vec_sum: %.2fms\0A\00", align 1
@str = private unnamed_addr constant [39 x i8] c"Errore nell'allocazione della memoria.\00", align 1
@str.12 = private unnamed_addr constant [26 x i8] c"Versione autovettorizzata\00", align 1
@str.13 = private unnamed_addr constant [30 x i8] c"Primi 5 elementi della somma:\00", align 1

; Function Attrs: nounwind
define dso_local i32 @main() local_unnamed_addr #0 {
entry:
  %0 = alloca [4096 x i8], align 16, addrspace(4)
  %1 = alloca [4096 x i8], align 16, addrspace(4)
  %2 = alloca [4096 x i8], align 16, addrspace(4)
  %tobool = icmp ne ptr addrspace(4) %0, null
  %tobool1 = icmp ne ptr addrspace(4) %1, null
  %or.cond = and i1 %tobool, %tobool1
  %tobool3 = icmp ne ptr addrspace(4) %2, null
  %or.cond81 = and i1 %or.cond, %tobool3
  br i1 %or.cond81, label %vector.body, label %if.then

if.then:                                          ; preds = %entry
  %puts = call i32 @puts(ptr nonnull dereferenceable(1) @str)
  br label %cleanup

vector.body:                                      ; preds = %entry
  store <16 x i32> <i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 16>, ptr addrspace(4) %0, align 16, !tbaa !3
  %3 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 16
  store <16 x i32> <i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31, i32 32>, ptr addrspace(4) %3, align 16, !tbaa !3
  %4 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 32
  store <16 x i32> <i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47, i32 48>, ptr addrspace(4) %4, align 16, !tbaa !3
  %5 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 48
  store <16 x i32> <i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55, i32 56, i32 57, i32 58, i32 59, i32 60, i32 61, i32 62, i32 63, i32 64>, ptr addrspace(4) %5, align 16, !tbaa !3
  store <16 x i32> <i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 16>, ptr addrspace(4) %1, align 16, !tbaa !3
  %6 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 16
  store <16 x i32> <i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31, i32 32>, ptr addrspace(4) %6, align 16, !tbaa !3
  %7 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 32
  store <16 x i32> <i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47, i32 48>, ptr addrspace(4) %7, align 16, !tbaa !3
  %8 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 48
  store <16 x i32> <i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55, i32 56, i32 57, i32 58, i32 59, i32 60, i32 61, i32 62, i32 63, i32 64>, ptr addrspace(4) %8, align 16, !tbaa !3
  %9 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 64
  store <16 x i32> <i32 65, i32 66, i32 67, i32 68, i32 69, i32 70, i32 71, i32 72, i32 73, i32 74, i32 75, i32 76, i32 77, i32 78, i32 79, i32 80>, ptr addrspace(4) %9, align 16, !tbaa !3
  %10 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 80
  store <16 x i32> <i32 81, i32 82, i32 83, i32 84, i32 85, i32 86, i32 87, i32 88, i32 89, i32 90, i32 91, i32 92, i32 93, i32 94, i32 95, i32 96>, ptr addrspace(4) %10, align 16, !tbaa !3
  %11 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 96
  store <16 x i32> <i32 97, i32 98, i32 99, i32 100, i32 101, i32 102, i32 103, i32 104, i32 105, i32 106, i32 107, i32 108, i32 109, i32 110, i32 111, i32 112>, ptr addrspace(4) %11, align 16, !tbaa !3
  %12 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 112
  store <16 x i32> <i32 113, i32 114, i32 115, i32 116, i32 117, i32 118, i32 119, i32 120, i32 121, i32 122, i32 123, i32 124, i32 125, i32 126, i32 127, i32 128>, ptr addrspace(4) %12, align 16, !tbaa !3
  %13 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 64
  store <16 x i32> <i32 65, i32 66, i32 67, i32 68, i32 69, i32 70, i32 71, i32 72, i32 73, i32 74, i32 75, i32 76, i32 77, i32 78, i32 79, i32 80>, ptr addrspace(4) %13, align 16, !tbaa !3
  %14 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 80
  store <16 x i32> <i32 81, i32 82, i32 83, i32 84, i32 85, i32 86, i32 87, i32 88, i32 89, i32 90, i32 91, i32 92, i32 93, i32 94, i32 95, i32 96>, ptr addrspace(4) %14, align 16, !tbaa !3
  %15 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 96
  store <16 x i32> <i32 97, i32 98, i32 99, i32 100, i32 101, i32 102, i32 103, i32 104, i32 105, i32 106, i32 107, i32 108, i32 109, i32 110, i32 111, i32 112>, ptr addrspace(4) %15, align 16, !tbaa !3
  %16 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 112
  store <16 x i32> <i32 113, i32 114, i32 115, i32 116, i32 117, i32 118, i32 119, i32 120, i32 121, i32 122, i32 123, i32 124, i32 125, i32 126, i32 127, i32 128>, ptr addrspace(4) %16, align 16, !tbaa !3
  %17 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 128
  store <16 x i32> <i32 129, i32 130, i32 131, i32 132, i32 133, i32 134, i32 135, i32 136, i32 137, i32 138, i32 139, i32 140, i32 141, i32 142, i32 143, i32 144>, ptr addrspace(4) %17, align 16, !tbaa !3
  %18 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 144
  store <16 x i32> <i32 145, i32 146, i32 147, i32 148, i32 149, i32 150, i32 151, i32 152, i32 153, i32 154, i32 155, i32 156, i32 157, i32 158, i32 159, i32 160>, ptr addrspace(4) %18, align 16, !tbaa !3
  %19 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 160
  store <16 x i32> <i32 161, i32 162, i32 163, i32 164, i32 165, i32 166, i32 167, i32 168, i32 169, i32 170, i32 171, i32 172, i32 173, i32 174, i32 175, i32 176>, ptr addrspace(4) %19, align 16, !tbaa !3
  %20 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 176
  store <16 x i32> <i32 177, i32 178, i32 179, i32 180, i32 181, i32 182, i32 183, i32 184, i32 185, i32 186, i32 187, i32 188, i32 189, i32 190, i32 191, i32 192>, ptr addrspace(4) %20, align 16, !tbaa !3
  %21 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 128
  store <16 x i32> <i32 129, i32 130, i32 131, i32 132, i32 133, i32 134, i32 135, i32 136, i32 137, i32 138, i32 139, i32 140, i32 141, i32 142, i32 143, i32 144>, ptr addrspace(4) %21, align 16, !tbaa !3
  %22 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 144
  store <16 x i32> <i32 145, i32 146, i32 147, i32 148, i32 149, i32 150, i32 151, i32 152, i32 153, i32 154, i32 155, i32 156, i32 157, i32 158, i32 159, i32 160>, ptr addrspace(4) %22, align 16, !tbaa !3
  %23 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 160
  store <16 x i32> <i32 161, i32 162, i32 163, i32 164, i32 165, i32 166, i32 167, i32 168, i32 169, i32 170, i32 171, i32 172, i32 173, i32 174, i32 175, i32 176>, ptr addrspace(4) %23, align 16, !tbaa !3
  %24 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 176
  store <16 x i32> <i32 177, i32 178, i32 179, i32 180, i32 181, i32 182, i32 183, i32 184, i32 185, i32 186, i32 187, i32 188, i32 189, i32 190, i32 191, i32 192>, ptr addrspace(4) %24, align 16, !tbaa !3
  %25 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 192
  store <16 x i32> <i32 193, i32 194, i32 195, i32 196, i32 197, i32 198, i32 199, i32 200, i32 201, i32 202, i32 203, i32 204, i32 205, i32 206, i32 207, i32 208>, ptr addrspace(4) %25, align 16, !tbaa !3
  %26 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 208
  store <16 x i32> <i32 209, i32 210, i32 211, i32 212, i32 213, i32 214, i32 215, i32 216, i32 217, i32 218, i32 219, i32 220, i32 221, i32 222, i32 223, i32 224>, ptr addrspace(4) %26, align 16, !tbaa !3
  %27 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 224
  store <16 x i32> <i32 225, i32 226, i32 227, i32 228, i32 229, i32 230, i32 231, i32 232, i32 233, i32 234, i32 235, i32 236, i32 237, i32 238, i32 239, i32 240>, ptr addrspace(4) %27, align 16, !tbaa !3
  %28 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 240
  store <16 x i32> <i32 241, i32 242, i32 243, i32 244, i32 245, i32 246, i32 247, i32 248, i32 249, i32 250, i32 251, i32 252, i32 253, i32 254, i32 255, i32 256>, ptr addrspace(4) %28, align 16, !tbaa !3
  %29 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 192
  store <16 x i32> <i32 193, i32 194, i32 195, i32 196, i32 197, i32 198, i32 199, i32 200, i32 201, i32 202, i32 203, i32 204, i32 205, i32 206, i32 207, i32 208>, ptr addrspace(4) %29, align 16, !tbaa !3
  %30 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 208
  store <16 x i32> <i32 209, i32 210, i32 211, i32 212, i32 213, i32 214, i32 215, i32 216, i32 217, i32 218, i32 219, i32 220, i32 221, i32 222, i32 223, i32 224>, ptr addrspace(4) %30, align 16, !tbaa !3
  %31 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 224
  store <16 x i32> <i32 225, i32 226, i32 227, i32 228, i32 229, i32 230, i32 231, i32 232, i32 233, i32 234, i32 235, i32 236, i32 237, i32 238, i32 239, i32 240>, ptr addrspace(4) %31, align 16, !tbaa !3
  %32 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 240
  store <16 x i32> <i32 241, i32 242, i32 243, i32 244, i32 245, i32 246, i32 247, i32 248, i32 249, i32 250, i32 251, i32 252, i32 253, i32 254, i32 255, i32 256>, ptr addrspace(4) %32, align 16, !tbaa !3
  %33 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 256
  store <16 x i32> <i32 257, i32 258, i32 259, i32 260, i32 261, i32 262, i32 263, i32 264, i32 265, i32 266, i32 267, i32 268, i32 269, i32 270, i32 271, i32 272>, ptr addrspace(4) %33, align 16, !tbaa !3
  %34 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 272
  store <16 x i32> <i32 273, i32 274, i32 275, i32 276, i32 277, i32 278, i32 279, i32 280, i32 281, i32 282, i32 283, i32 284, i32 285, i32 286, i32 287, i32 288>, ptr addrspace(4) %34, align 16, !tbaa !3
  %35 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 288
  store <16 x i32> <i32 289, i32 290, i32 291, i32 292, i32 293, i32 294, i32 295, i32 296, i32 297, i32 298, i32 299, i32 300, i32 301, i32 302, i32 303, i32 304>, ptr addrspace(4) %35, align 16, !tbaa !3
  %36 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 304
  store <16 x i32> <i32 305, i32 306, i32 307, i32 308, i32 309, i32 310, i32 311, i32 312, i32 313, i32 314, i32 315, i32 316, i32 317, i32 318, i32 319, i32 320>, ptr addrspace(4) %36, align 16, !tbaa !3
  %37 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 256
  store <16 x i32> <i32 257, i32 258, i32 259, i32 260, i32 261, i32 262, i32 263, i32 264, i32 265, i32 266, i32 267, i32 268, i32 269, i32 270, i32 271, i32 272>, ptr addrspace(4) %37, align 16, !tbaa !3
  %38 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 272
  store <16 x i32> <i32 273, i32 274, i32 275, i32 276, i32 277, i32 278, i32 279, i32 280, i32 281, i32 282, i32 283, i32 284, i32 285, i32 286, i32 287, i32 288>, ptr addrspace(4) %38, align 16, !tbaa !3
  %39 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 288
  store <16 x i32> <i32 289, i32 290, i32 291, i32 292, i32 293, i32 294, i32 295, i32 296, i32 297, i32 298, i32 299, i32 300, i32 301, i32 302, i32 303, i32 304>, ptr addrspace(4) %39, align 16, !tbaa !3
  %40 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 304
  store <16 x i32> <i32 305, i32 306, i32 307, i32 308, i32 309, i32 310, i32 311, i32 312, i32 313, i32 314, i32 315, i32 316, i32 317, i32 318, i32 319, i32 320>, ptr addrspace(4) %40, align 16, !tbaa !3
  %41 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 320
  store <16 x i32> <i32 321, i32 322, i32 323, i32 324, i32 325, i32 326, i32 327, i32 328, i32 329, i32 330, i32 331, i32 332, i32 333, i32 334, i32 335, i32 336>, ptr addrspace(4) %41, align 16, !tbaa !3
  %42 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 336
  store <16 x i32> <i32 337, i32 338, i32 339, i32 340, i32 341, i32 342, i32 343, i32 344, i32 345, i32 346, i32 347, i32 348, i32 349, i32 350, i32 351, i32 352>, ptr addrspace(4) %42, align 16, !tbaa !3
  %43 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 352
  store <16 x i32> <i32 353, i32 354, i32 355, i32 356, i32 357, i32 358, i32 359, i32 360, i32 361, i32 362, i32 363, i32 364, i32 365, i32 366, i32 367, i32 368>, ptr addrspace(4) %43, align 16, !tbaa !3
  %44 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 368
  store <16 x i32> <i32 369, i32 370, i32 371, i32 372, i32 373, i32 374, i32 375, i32 376, i32 377, i32 378, i32 379, i32 380, i32 381, i32 382, i32 383, i32 384>, ptr addrspace(4) %44, align 16, !tbaa !3
  %45 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 320
  store <16 x i32> <i32 321, i32 322, i32 323, i32 324, i32 325, i32 326, i32 327, i32 328, i32 329, i32 330, i32 331, i32 332, i32 333, i32 334, i32 335, i32 336>, ptr addrspace(4) %45, align 16, !tbaa !3
  %46 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 336
  store <16 x i32> <i32 337, i32 338, i32 339, i32 340, i32 341, i32 342, i32 343, i32 344, i32 345, i32 346, i32 347, i32 348, i32 349, i32 350, i32 351, i32 352>, ptr addrspace(4) %46, align 16, !tbaa !3
  %47 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 352
  store <16 x i32> <i32 353, i32 354, i32 355, i32 356, i32 357, i32 358, i32 359, i32 360, i32 361, i32 362, i32 363, i32 364, i32 365, i32 366, i32 367, i32 368>, ptr addrspace(4) %47, align 16, !tbaa !3
  %48 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 368
  store <16 x i32> <i32 369, i32 370, i32 371, i32 372, i32 373, i32 374, i32 375, i32 376, i32 377, i32 378, i32 379, i32 380, i32 381, i32 382, i32 383, i32 384>, ptr addrspace(4) %48, align 16, !tbaa !3
  %49 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 384
  store <16 x i32> <i32 385, i32 386, i32 387, i32 388, i32 389, i32 390, i32 391, i32 392, i32 393, i32 394, i32 395, i32 396, i32 397, i32 398, i32 399, i32 400>, ptr addrspace(4) %49, align 16, !tbaa !3
  %50 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 400
  store <16 x i32> <i32 401, i32 402, i32 403, i32 404, i32 405, i32 406, i32 407, i32 408, i32 409, i32 410, i32 411, i32 412, i32 413, i32 414, i32 415, i32 416>, ptr addrspace(4) %50, align 16, !tbaa !3
  %51 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 416
  store <16 x i32> <i32 417, i32 418, i32 419, i32 420, i32 421, i32 422, i32 423, i32 424, i32 425, i32 426, i32 427, i32 428, i32 429, i32 430, i32 431, i32 432>, ptr addrspace(4) %51, align 16, !tbaa !3
  %52 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 432
  store <16 x i32> <i32 433, i32 434, i32 435, i32 436, i32 437, i32 438, i32 439, i32 440, i32 441, i32 442, i32 443, i32 444, i32 445, i32 446, i32 447, i32 448>, ptr addrspace(4) %52, align 16, !tbaa !3
  %53 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 384
  store <16 x i32> <i32 385, i32 386, i32 387, i32 388, i32 389, i32 390, i32 391, i32 392, i32 393, i32 394, i32 395, i32 396, i32 397, i32 398, i32 399, i32 400>, ptr addrspace(4) %53, align 16, !tbaa !3
  %54 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 400
  store <16 x i32> <i32 401, i32 402, i32 403, i32 404, i32 405, i32 406, i32 407, i32 408, i32 409, i32 410, i32 411, i32 412, i32 413, i32 414, i32 415, i32 416>, ptr addrspace(4) %54, align 16, !tbaa !3
  %55 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 416
  store <16 x i32> <i32 417, i32 418, i32 419, i32 420, i32 421, i32 422, i32 423, i32 424, i32 425, i32 426, i32 427, i32 428, i32 429, i32 430, i32 431, i32 432>, ptr addrspace(4) %55, align 16, !tbaa !3
  %56 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 432
  store <16 x i32> <i32 433, i32 434, i32 435, i32 436, i32 437, i32 438, i32 439, i32 440, i32 441, i32 442, i32 443, i32 444, i32 445, i32 446, i32 447, i32 448>, ptr addrspace(4) %56, align 16, !tbaa !3
  %57 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 448
  store <16 x i32> <i32 449, i32 450, i32 451, i32 452, i32 453, i32 454, i32 455, i32 456, i32 457, i32 458, i32 459, i32 460, i32 461, i32 462, i32 463, i32 464>, ptr addrspace(4) %57, align 16, !tbaa !3
  %58 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 464
  store <16 x i32> <i32 465, i32 466, i32 467, i32 468, i32 469, i32 470, i32 471, i32 472, i32 473, i32 474, i32 475, i32 476, i32 477, i32 478, i32 479, i32 480>, ptr addrspace(4) %58, align 16, !tbaa !3
  %59 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 480
  store <16 x i32> <i32 481, i32 482, i32 483, i32 484, i32 485, i32 486, i32 487, i32 488, i32 489, i32 490, i32 491, i32 492, i32 493, i32 494, i32 495, i32 496>, ptr addrspace(4) %59, align 16, !tbaa !3
  %60 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 496
  store <16 x i32> <i32 497, i32 498, i32 499, i32 500, i32 501, i32 502, i32 503, i32 504, i32 505, i32 506, i32 507, i32 508, i32 509, i32 510, i32 511, i32 512>, ptr addrspace(4) %60, align 16, !tbaa !3
  %61 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 448
  store <16 x i32> <i32 449, i32 450, i32 451, i32 452, i32 453, i32 454, i32 455, i32 456, i32 457, i32 458, i32 459, i32 460, i32 461, i32 462, i32 463, i32 464>, ptr addrspace(4) %61, align 16, !tbaa !3
  %62 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 464
  store <16 x i32> <i32 465, i32 466, i32 467, i32 468, i32 469, i32 470, i32 471, i32 472, i32 473, i32 474, i32 475, i32 476, i32 477, i32 478, i32 479, i32 480>, ptr addrspace(4) %62, align 16, !tbaa !3
  %63 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 480
  store <16 x i32> <i32 481, i32 482, i32 483, i32 484, i32 485, i32 486, i32 487, i32 488, i32 489, i32 490, i32 491, i32 492, i32 493, i32 494, i32 495, i32 496>, ptr addrspace(4) %63, align 16, !tbaa !3
  %64 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 496
  store <16 x i32> <i32 497, i32 498, i32 499, i32 500, i32 501, i32 502, i32 503, i32 504, i32 505, i32 506, i32 507, i32 508, i32 509, i32 510, i32 511, i32 512>, ptr addrspace(4) %64, align 16, !tbaa !3
  %65 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 512
  store <16 x i32> <i32 513, i32 514, i32 515, i32 516, i32 517, i32 518, i32 519, i32 520, i32 521, i32 522, i32 523, i32 524, i32 525, i32 526, i32 527, i32 528>, ptr addrspace(4) %65, align 16, !tbaa !3
  %66 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 528
  store <16 x i32> <i32 529, i32 530, i32 531, i32 532, i32 533, i32 534, i32 535, i32 536, i32 537, i32 538, i32 539, i32 540, i32 541, i32 542, i32 543, i32 544>, ptr addrspace(4) %66, align 16, !tbaa !3
  %67 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 544
  store <16 x i32> <i32 545, i32 546, i32 547, i32 548, i32 549, i32 550, i32 551, i32 552, i32 553, i32 554, i32 555, i32 556, i32 557, i32 558, i32 559, i32 560>, ptr addrspace(4) %67, align 16, !tbaa !3
  %68 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 560
  store <16 x i32> <i32 561, i32 562, i32 563, i32 564, i32 565, i32 566, i32 567, i32 568, i32 569, i32 570, i32 571, i32 572, i32 573, i32 574, i32 575, i32 576>, ptr addrspace(4) %68, align 16, !tbaa !3
  %69 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 512
  store <16 x i32> <i32 513, i32 514, i32 515, i32 516, i32 517, i32 518, i32 519, i32 520, i32 521, i32 522, i32 523, i32 524, i32 525, i32 526, i32 527, i32 528>, ptr addrspace(4) %69, align 16, !tbaa !3
  %70 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 528
  store <16 x i32> <i32 529, i32 530, i32 531, i32 532, i32 533, i32 534, i32 535, i32 536, i32 537, i32 538, i32 539, i32 540, i32 541, i32 542, i32 543, i32 544>, ptr addrspace(4) %70, align 16, !tbaa !3
  %71 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 544
  store <16 x i32> <i32 545, i32 546, i32 547, i32 548, i32 549, i32 550, i32 551, i32 552, i32 553, i32 554, i32 555, i32 556, i32 557, i32 558, i32 559, i32 560>, ptr addrspace(4) %71, align 16, !tbaa !3
  %72 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 560
  store <16 x i32> <i32 561, i32 562, i32 563, i32 564, i32 565, i32 566, i32 567, i32 568, i32 569, i32 570, i32 571, i32 572, i32 573, i32 574, i32 575, i32 576>, ptr addrspace(4) %72, align 16, !tbaa !3
  %73 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 576
  store <16 x i32> <i32 577, i32 578, i32 579, i32 580, i32 581, i32 582, i32 583, i32 584, i32 585, i32 586, i32 587, i32 588, i32 589, i32 590, i32 591, i32 592>, ptr addrspace(4) %73, align 16, !tbaa !3
  %74 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 592
  store <16 x i32> <i32 593, i32 594, i32 595, i32 596, i32 597, i32 598, i32 599, i32 600, i32 601, i32 602, i32 603, i32 604, i32 605, i32 606, i32 607, i32 608>, ptr addrspace(4) %74, align 16, !tbaa !3
  %75 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 608
  store <16 x i32> <i32 609, i32 610, i32 611, i32 612, i32 613, i32 614, i32 615, i32 616, i32 617, i32 618, i32 619, i32 620, i32 621, i32 622, i32 623, i32 624>, ptr addrspace(4) %75, align 16, !tbaa !3
  %76 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 624
  store <16 x i32> <i32 625, i32 626, i32 627, i32 628, i32 629, i32 630, i32 631, i32 632, i32 633, i32 634, i32 635, i32 636, i32 637, i32 638, i32 639, i32 640>, ptr addrspace(4) %76, align 16, !tbaa !3
  %77 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 576
  store <16 x i32> <i32 577, i32 578, i32 579, i32 580, i32 581, i32 582, i32 583, i32 584, i32 585, i32 586, i32 587, i32 588, i32 589, i32 590, i32 591, i32 592>, ptr addrspace(4) %77, align 16, !tbaa !3
  %78 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 592
  store <16 x i32> <i32 593, i32 594, i32 595, i32 596, i32 597, i32 598, i32 599, i32 600, i32 601, i32 602, i32 603, i32 604, i32 605, i32 606, i32 607, i32 608>, ptr addrspace(4) %78, align 16, !tbaa !3
  %79 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 608
  store <16 x i32> <i32 609, i32 610, i32 611, i32 612, i32 613, i32 614, i32 615, i32 616, i32 617, i32 618, i32 619, i32 620, i32 621, i32 622, i32 623, i32 624>, ptr addrspace(4) %79, align 16, !tbaa !3
  %80 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 624
  store <16 x i32> <i32 625, i32 626, i32 627, i32 628, i32 629, i32 630, i32 631, i32 632, i32 633, i32 634, i32 635, i32 636, i32 637, i32 638, i32 639, i32 640>, ptr addrspace(4) %80, align 16, !tbaa !3
  %81 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 640
  store <16 x i32> <i32 641, i32 642, i32 643, i32 644, i32 645, i32 646, i32 647, i32 648, i32 649, i32 650, i32 651, i32 652, i32 653, i32 654, i32 655, i32 656>, ptr addrspace(4) %81, align 16, !tbaa !3
  %82 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 656
  store <16 x i32> <i32 657, i32 658, i32 659, i32 660, i32 661, i32 662, i32 663, i32 664, i32 665, i32 666, i32 667, i32 668, i32 669, i32 670, i32 671, i32 672>, ptr addrspace(4) %82, align 16, !tbaa !3
  %83 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 672
  store <16 x i32> <i32 673, i32 674, i32 675, i32 676, i32 677, i32 678, i32 679, i32 680, i32 681, i32 682, i32 683, i32 684, i32 685, i32 686, i32 687, i32 688>, ptr addrspace(4) %83, align 16, !tbaa !3
  %84 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 688
  store <16 x i32> <i32 689, i32 690, i32 691, i32 692, i32 693, i32 694, i32 695, i32 696, i32 697, i32 698, i32 699, i32 700, i32 701, i32 702, i32 703, i32 704>, ptr addrspace(4) %84, align 16, !tbaa !3
  %85 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 640
  store <16 x i32> <i32 641, i32 642, i32 643, i32 644, i32 645, i32 646, i32 647, i32 648, i32 649, i32 650, i32 651, i32 652, i32 653, i32 654, i32 655, i32 656>, ptr addrspace(4) %85, align 16, !tbaa !3
  %86 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 656
  store <16 x i32> <i32 657, i32 658, i32 659, i32 660, i32 661, i32 662, i32 663, i32 664, i32 665, i32 666, i32 667, i32 668, i32 669, i32 670, i32 671, i32 672>, ptr addrspace(4) %86, align 16, !tbaa !3
  %87 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 672
  store <16 x i32> <i32 673, i32 674, i32 675, i32 676, i32 677, i32 678, i32 679, i32 680, i32 681, i32 682, i32 683, i32 684, i32 685, i32 686, i32 687, i32 688>, ptr addrspace(4) %87, align 16, !tbaa !3
  %88 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 688
  store <16 x i32> <i32 689, i32 690, i32 691, i32 692, i32 693, i32 694, i32 695, i32 696, i32 697, i32 698, i32 699, i32 700, i32 701, i32 702, i32 703, i32 704>, ptr addrspace(4) %88, align 16, !tbaa !3
  %89 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 704
  store <16 x i32> <i32 705, i32 706, i32 707, i32 708, i32 709, i32 710, i32 711, i32 712, i32 713, i32 714, i32 715, i32 716, i32 717, i32 718, i32 719, i32 720>, ptr addrspace(4) %89, align 16, !tbaa !3
  %90 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 720
  store <16 x i32> <i32 721, i32 722, i32 723, i32 724, i32 725, i32 726, i32 727, i32 728, i32 729, i32 730, i32 731, i32 732, i32 733, i32 734, i32 735, i32 736>, ptr addrspace(4) %90, align 16, !tbaa !3
  %91 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 736
  store <16 x i32> <i32 737, i32 738, i32 739, i32 740, i32 741, i32 742, i32 743, i32 744, i32 745, i32 746, i32 747, i32 748, i32 749, i32 750, i32 751, i32 752>, ptr addrspace(4) %91, align 16, !tbaa !3
  %92 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 752
  store <16 x i32> <i32 753, i32 754, i32 755, i32 756, i32 757, i32 758, i32 759, i32 760, i32 761, i32 762, i32 763, i32 764, i32 765, i32 766, i32 767, i32 768>, ptr addrspace(4) %92, align 16, !tbaa !3
  %93 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 704
  store <16 x i32> <i32 705, i32 706, i32 707, i32 708, i32 709, i32 710, i32 711, i32 712, i32 713, i32 714, i32 715, i32 716, i32 717, i32 718, i32 719, i32 720>, ptr addrspace(4) %93, align 16, !tbaa !3
  %94 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 720
  store <16 x i32> <i32 721, i32 722, i32 723, i32 724, i32 725, i32 726, i32 727, i32 728, i32 729, i32 730, i32 731, i32 732, i32 733, i32 734, i32 735, i32 736>, ptr addrspace(4) %94, align 16, !tbaa !3
  %95 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 736
  store <16 x i32> <i32 737, i32 738, i32 739, i32 740, i32 741, i32 742, i32 743, i32 744, i32 745, i32 746, i32 747, i32 748, i32 749, i32 750, i32 751, i32 752>, ptr addrspace(4) %95, align 16, !tbaa !3
  %96 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 752
  store <16 x i32> <i32 753, i32 754, i32 755, i32 756, i32 757, i32 758, i32 759, i32 760, i32 761, i32 762, i32 763, i32 764, i32 765, i32 766, i32 767, i32 768>, ptr addrspace(4) %96, align 16, !tbaa !3
  %97 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 768
  store <16 x i32> <i32 769, i32 770, i32 771, i32 772, i32 773, i32 774, i32 775, i32 776, i32 777, i32 778, i32 779, i32 780, i32 781, i32 782, i32 783, i32 784>, ptr addrspace(4) %97, align 16, !tbaa !3
  %98 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 784
  store <16 x i32> <i32 785, i32 786, i32 787, i32 788, i32 789, i32 790, i32 791, i32 792, i32 793, i32 794, i32 795, i32 796, i32 797, i32 798, i32 799, i32 800>, ptr addrspace(4) %98, align 16, !tbaa !3
  %99 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 800
  store <16 x i32> <i32 801, i32 802, i32 803, i32 804, i32 805, i32 806, i32 807, i32 808, i32 809, i32 810, i32 811, i32 812, i32 813, i32 814, i32 815, i32 816>, ptr addrspace(4) %99, align 16, !tbaa !3
  %100 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 816
  store <16 x i32> <i32 817, i32 818, i32 819, i32 820, i32 821, i32 822, i32 823, i32 824, i32 825, i32 826, i32 827, i32 828, i32 829, i32 830, i32 831, i32 832>, ptr addrspace(4) %100, align 16, !tbaa !3
  %101 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 768
  store <16 x i32> <i32 769, i32 770, i32 771, i32 772, i32 773, i32 774, i32 775, i32 776, i32 777, i32 778, i32 779, i32 780, i32 781, i32 782, i32 783, i32 784>, ptr addrspace(4) %101, align 16, !tbaa !3
  %102 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 784
  store <16 x i32> <i32 785, i32 786, i32 787, i32 788, i32 789, i32 790, i32 791, i32 792, i32 793, i32 794, i32 795, i32 796, i32 797, i32 798, i32 799, i32 800>, ptr addrspace(4) %102, align 16, !tbaa !3
  %103 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 800
  store <16 x i32> <i32 801, i32 802, i32 803, i32 804, i32 805, i32 806, i32 807, i32 808, i32 809, i32 810, i32 811, i32 812, i32 813, i32 814, i32 815, i32 816>, ptr addrspace(4) %103, align 16, !tbaa !3
  %104 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 816
  store <16 x i32> <i32 817, i32 818, i32 819, i32 820, i32 821, i32 822, i32 823, i32 824, i32 825, i32 826, i32 827, i32 828, i32 829, i32 830, i32 831, i32 832>, ptr addrspace(4) %104, align 16, !tbaa !3
  %105 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 832
  store <16 x i32> <i32 833, i32 834, i32 835, i32 836, i32 837, i32 838, i32 839, i32 840, i32 841, i32 842, i32 843, i32 844, i32 845, i32 846, i32 847, i32 848>, ptr addrspace(4) %105, align 16, !tbaa !3
  %106 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 848
  store <16 x i32> <i32 849, i32 850, i32 851, i32 852, i32 853, i32 854, i32 855, i32 856, i32 857, i32 858, i32 859, i32 860, i32 861, i32 862, i32 863, i32 864>, ptr addrspace(4) %106, align 16, !tbaa !3
  %107 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 864
  store <16 x i32> <i32 865, i32 866, i32 867, i32 868, i32 869, i32 870, i32 871, i32 872, i32 873, i32 874, i32 875, i32 876, i32 877, i32 878, i32 879, i32 880>, ptr addrspace(4) %107, align 16, !tbaa !3
  %108 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 880
  store <16 x i32> <i32 881, i32 882, i32 883, i32 884, i32 885, i32 886, i32 887, i32 888, i32 889, i32 890, i32 891, i32 892, i32 893, i32 894, i32 895, i32 896>, ptr addrspace(4) %108, align 16, !tbaa !3
  %109 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 832
  store <16 x i32> <i32 833, i32 834, i32 835, i32 836, i32 837, i32 838, i32 839, i32 840, i32 841, i32 842, i32 843, i32 844, i32 845, i32 846, i32 847, i32 848>, ptr addrspace(4) %109, align 16, !tbaa !3
  %110 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 848
  store <16 x i32> <i32 849, i32 850, i32 851, i32 852, i32 853, i32 854, i32 855, i32 856, i32 857, i32 858, i32 859, i32 860, i32 861, i32 862, i32 863, i32 864>, ptr addrspace(4) %110, align 16, !tbaa !3
  %111 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 864
  store <16 x i32> <i32 865, i32 866, i32 867, i32 868, i32 869, i32 870, i32 871, i32 872, i32 873, i32 874, i32 875, i32 876, i32 877, i32 878, i32 879, i32 880>, ptr addrspace(4) %111, align 16, !tbaa !3
  %112 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 880
  store <16 x i32> <i32 881, i32 882, i32 883, i32 884, i32 885, i32 886, i32 887, i32 888, i32 889, i32 890, i32 891, i32 892, i32 893, i32 894, i32 895, i32 896>, ptr addrspace(4) %112, align 16, !tbaa !3
  %113 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 896
  store <16 x i32> <i32 897, i32 898, i32 899, i32 900, i32 901, i32 902, i32 903, i32 904, i32 905, i32 906, i32 907, i32 908, i32 909, i32 910, i32 911, i32 912>, ptr addrspace(4) %113, align 16, !tbaa !3
  %114 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 912
  store <16 x i32> <i32 913, i32 914, i32 915, i32 916, i32 917, i32 918, i32 919, i32 920, i32 921, i32 922, i32 923, i32 924, i32 925, i32 926, i32 927, i32 928>, ptr addrspace(4) %114, align 16, !tbaa !3
  %115 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 928
  store <16 x i32> <i32 929, i32 930, i32 931, i32 932, i32 933, i32 934, i32 935, i32 936, i32 937, i32 938, i32 939, i32 940, i32 941, i32 942, i32 943, i32 944>, ptr addrspace(4) %115, align 16, !tbaa !3
  %116 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 944
  store <16 x i32> <i32 945, i32 946, i32 947, i32 948, i32 949, i32 950, i32 951, i32 952, i32 953, i32 954, i32 955, i32 956, i32 957, i32 958, i32 959, i32 960>, ptr addrspace(4) %116, align 16, !tbaa !3
  %117 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 896
  store <16 x i32> <i32 897, i32 898, i32 899, i32 900, i32 901, i32 902, i32 903, i32 904, i32 905, i32 906, i32 907, i32 908, i32 909, i32 910, i32 911, i32 912>, ptr addrspace(4) %117, align 16, !tbaa !3
  %118 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 912
  store <16 x i32> <i32 913, i32 914, i32 915, i32 916, i32 917, i32 918, i32 919, i32 920, i32 921, i32 922, i32 923, i32 924, i32 925, i32 926, i32 927, i32 928>, ptr addrspace(4) %118, align 16, !tbaa !3
  %119 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 928
  store <16 x i32> <i32 929, i32 930, i32 931, i32 932, i32 933, i32 934, i32 935, i32 936, i32 937, i32 938, i32 939, i32 940, i32 941, i32 942, i32 943, i32 944>, ptr addrspace(4) %119, align 16, !tbaa !3
  %120 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 944
  store <16 x i32> <i32 945, i32 946, i32 947, i32 948, i32 949, i32 950, i32 951, i32 952, i32 953, i32 954, i32 955, i32 956, i32 957, i32 958, i32 959, i32 960>, ptr addrspace(4) %120, align 16, !tbaa !3
  %121 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 960
  store <16 x i32> <i32 961, i32 962, i32 963, i32 964, i32 965, i32 966, i32 967, i32 968, i32 969, i32 970, i32 971, i32 972, i32 973, i32 974, i32 975, i32 976>, ptr addrspace(4) %121, align 16, !tbaa !3
  %122 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 976
  store <16 x i32> <i32 977, i32 978, i32 979, i32 980, i32 981, i32 982, i32 983, i32 984, i32 985, i32 986, i32 987, i32 988, i32 989, i32 990, i32 991, i32 992>, ptr addrspace(4) %122, align 16, !tbaa !3
  %123 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 992
  store <16 x i32> <i32 993, i32 994, i32 995, i32 996, i32 997, i32 998, i32 999, i32 1000, i32 1001, i32 1002, i32 1003, i32 1004, i32 1005, i32 1006, i32 1007, i32 1008>, ptr addrspace(4) %123, align 16, !tbaa !3
  %124 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 1008
  store <16 x i32> <i32 1009, i32 1010, i32 1011, i32 1012, i32 1013, i32 1014, i32 1015, i32 1016, i32 1017, i32 1018, i32 1019, i32 1020, i32 1021, i32 1022, i32 1023, i32 1024>, ptr addrspace(4) %124, align 16, !tbaa !3
  %125 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 960
  store <16 x i32> <i32 961, i32 962, i32 963, i32 964, i32 965, i32 966, i32 967, i32 968, i32 969, i32 970, i32 971, i32 972, i32 973, i32 974, i32 975, i32 976>, ptr addrspace(4) %125, align 16, !tbaa !3
  %126 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 976
  store <16 x i32> <i32 977, i32 978, i32 979, i32 980, i32 981, i32 982, i32 983, i32 984, i32 985, i32 986, i32 987, i32 988, i32 989, i32 990, i32 991, i32 992>, ptr addrspace(4) %126, align 16, !tbaa !3
  %127 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 992
  store <16 x i32> <i32 993, i32 994, i32 995, i32 996, i32 997, i32 998, i32 999, i32 1000, i32 1001, i32 1002, i32 1003, i32 1004, i32 1005, i32 1006, i32 1007, i32 1008>, ptr addrspace(4) %127, align 16, !tbaa !3
  %128 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 1008
  store <16 x i32> <i32 1009, i32 1010, i32 1011, i32 1012, i32 1013, i32 1014, i32 1015, i32 1016, i32 1017, i32 1018, i32 1019, i32 1020, i32 1021, i32 1022, i32 1023, i32 1024>, ptr addrspace(4) %128, align 16, !tbaa !3
  %call6 = call i32 @clock() #4
  %129 = addrspacecast ptr addrspace(4) %0 to ptr
  %130 = addrspacecast ptr addrspace(4) %1 to ptr
  %131 = addrspacecast ptr addrspace(4) %2 to ptr
  call void @vec_sum(ptr noundef %129, ptr noundef %130, ptr noundef %131, i32 noundef 1024) #4
  %call7 = call i32 @clock() #4
  %sub = sub nsw i32 %call7, %call6
  %conv = sitofp i32 %sub to double
  %call8 = call i32 @_timer_clocks_per_sec() #4
  %conv9 = uitofp i32 %call8 to double
  %132 = fmul fast double %conv, 1.000000e+03
  %mul = fdiv fast double %132, %conv9
  %call10 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.1, double noundef nofpclass(nan inf) %mul)
  %puts138 = call i32 @puts(ptr nonnull dereferenceable(1) @str.13)
  %133 = load i32, ptr addrspace(4) %0, align 16, !tbaa !3
  %134 = load i32, ptr addrspace(4) %1, align 16, !tbaa !3
  %135 = load i32, ptr addrspace(4) %2, align 16, !tbaa !3
  %call21 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, i32 noundef 0, i32 noundef %133, i32 noundef 0, i32 noundef %134, i32 noundef 0, i32 noundef %135)
  %arrayidx18.1 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 1
  %136 = load i32, ptr addrspace(4) %arrayidx18.1, align 4, !tbaa !3
  %arrayidx19.1 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 1
  %137 = load i32, ptr addrspace(4) %arrayidx19.1, align 4, !tbaa !3
  %arrayidx20.1 = getelementptr inbounds i32, ptr addrspace(4) %2, i32 1
  %138 = load i32, ptr addrspace(4) %arrayidx20.1, align 4, !tbaa !3
  %call21.1 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, i32 noundef 1, i32 noundef %136, i32 noundef 1, i32 noundef %137, i32 noundef 1, i32 noundef %138)
  %arrayidx18.2 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 2
  %139 = load i32, ptr addrspace(4) %arrayidx18.2, align 8, !tbaa !3
  %arrayidx19.2 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 2
  %140 = load i32, ptr addrspace(4) %arrayidx19.2, align 8, !tbaa !3
  %arrayidx20.2 = getelementptr inbounds i32, ptr addrspace(4) %2, i32 2
  %141 = load i32, ptr addrspace(4) %arrayidx20.2, align 8, !tbaa !3
  %call21.2 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, i32 noundef 2, i32 noundef %139, i32 noundef 2, i32 noundef %140, i32 noundef 2, i32 noundef %141)
  %arrayidx18.3 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 3
  %142 = load i32, ptr addrspace(4) %arrayidx18.3, align 4, !tbaa !3
  %arrayidx19.3 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 3
  %143 = load i32, ptr addrspace(4) %arrayidx19.3, align 4, !tbaa !3
  %arrayidx20.3 = getelementptr inbounds i32, ptr addrspace(4) %2, i32 3
  %144 = load i32, ptr addrspace(4) %arrayidx20.3, align 4, !tbaa !3
  %call21.3 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, i32 noundef 3, i32 noundef %142, i32 noundef 3, i32 noundef %143, i32 noundef 3, i32 noundef %144)
  %arrayidx18.4 = getelementptr inbounds i32, ptr addrspace(4) %0, i32 4
  %145 = load i32, ptr addrspace(4) %arrayidx18.4, align 16, !tbaa !3
  %arrayidx19.4 = getelementptr inbounds i32, ptr addrspace(4) %1, i32 4
  %146 = load i32, ptr addrspace(4) %arrayidx19.4, align 16, !tbaa !3
  %arrayidx20.4 = getelementptr inbounds i32, ptr addrspace(4) %2, i32 4
  %147 = load i32, ptr addrspace(4) %arrayidx20.4, align 16, !tbaa !3
  %call21.4 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, i32 noundef 4, i32 noundef %145, i32 noundef 4, i32 noundef %146, i32 noundef 4, i32 noundef %147)
  %putchar = call i32 @putchar(i32 10)
  %call26 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, i32 noundef 16)
  %call27 = call i32 @clock() #4
  call void @vectorized_vec_sum(ptr addrspace(4) noundef nonnull %0, ptr addrspace(4) noundef nonnull %1, ptr addrspace(4) noundef nonnull %2, i32 noundef 1024) #4
  %call28 = call i32 @clock() #4
  %sub29 = sub nsw i32 %call28, %call27
  %conv30 = sitofp i32 %sub29 to double
  %call31 = call i32 @_timer_clocks_per_sec() #4
  %conv32 = uitofp i32 %call31 to double
  %148 = fmul fast double %conv30, 1.000000e+03
  %mul34 = fdiv fast double %148, %conv32
  %call35 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.6, double noundef nofpclass(nan inf) %mul34)
  %div36 = fdiv fast double %mul, %mul34
  %call37 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.7, double noundef nofpclass(nan inf) %div36)
  %puts139 = call i32 @puts(ptr nonnull dereferenceable(1) @str.13)
  %149 = load i32, ptr addrspace(4) %0, align 16, !tbaa !3
  %150 = load i32, ptr addrspace(4) %1, align 16, !tbaa !3
  %151 = load i32, ptr addrspace(4) %2, align 16, !tbaa !3
  %call48 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, i32 noundef 0, i32 noundef %149, i32 noundef 0, i32 noundef %150, i32 noundef 0, i32 noundef %151)
  %152 = load i32, ptr addrspace(4) %arrayidx18.1, align 4, !tbaa !3
  %153 = load i32, ptr addrspace(4) %arrayidx19.1, align 4, !tbaa !3
  %154 = load i32, ptr addrspace(4) %arrayidx20.1, align 4, !tbaa !3
  %call48.1 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, i32 noundef 1, i32 noundef %152, i32 noundef 1, i32 noundef %153, i32 noundef 1, i32 noundef %154)
  %155 = load i32, ptr addrspace(4) %arrayidx18.2, align 8, !tbaa !3
  %156 = load i32, ptr addrspace(4) %arrayidx19.2, align 8, !tbaa !3
  %157 = load i32, ptr addrspace(4) %arrayidx20.2, align 8, !tbaa !3
  %call48.2 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, i32 noundef 2, i32 noundef %155, i32 noundef 2, i32 noundef %156, i32 noundef 2, i32 noundef %157)
  %158 = load i32, ptr addrspace(4) %arrayidx18.3, align 4, !tbaa !3
  %159 = load i32, ptr addrspace(4) %arrayidx19.3, align 4, !tbaa !3
  %160 = load i32, ptr addrspace(4) %arrayidx20.3, align 4, !tbaa !3
  %call48.3 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, i32 noundef 3, i32 noundef %158, i32 noundef 3, i32 noundef %159, i32 noundef 3, i32 noundef %160)
  %161 = load i32, ptr addrspace(4) %arrayidx18.4, align 16, !tbaa !3
  %162 = load i32, ptr addrspace(4) %arrayidx19.4, align 16, !tbaa !3
  %163 = load i32, ptr addrspace(4) %arrayidx20.4, align 16, !tbaa !3
  %call48.4 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, i32 noundef 4, i32 noundef %161, i32 noundef 4, i32 noundef %162, i32 noundef 4, i32 noundef %163)
  %putchar140 = call i32 @putchar(i32 10)
  %puts141 = call i32 @puts(ptr nonnull dereferenceable(1) @str.12)
  %call54 = call i32 @clock() #4
  call void @autovectorized_vec_sum(ptr addrspace(4) noundef nonnull %0, ptr addrspace(4) noundef nonnull %1, ptr addrspace(4) noundef nonnull %2, i32 noundef 1024) #4
  %call55 = call i32 @clock() #4
  %sub56 = sub nsw i32 %call55, %call54
  %conv57 = sitofp i32 %sub56 to double
  %call58 = call i32 @_timer_clocks_per_sec() #4
  %conv59 = uitofp i32 %call58 to double
  %164 = fmul fast double %conv57, 1.000000e+03
  %mul61 = fdiv fast double %164, %conv59
  %call62 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.9, double noundef nofpclass(nan inf) %mul61)
  %div63 = fdiv fast double %mul, %mul61
  %call64 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.7, double noundef nofpclass(nan inf) %div63)
  %puts142 = call i32 @puts(ptr nonnull dereferenceable(1) @str.13)
  %165 = load i32, ptr addrspace(4) %0, align 16, !tbaa !3
  %166 = load i32, ptr addrspace(4) %1, align 16, !tbaa !3
  %167 = load i32, ptr addrspace(4) %2, align 16, !tbaa !3
  %call75 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, i32 noundef 0, i32 noundef %165, i32 noundef 0, i32 noundef %166, i32 noundef 0, i32 noundef %167)
  %168 = load i32, ptr addrspace(4) %arrayidx18.1, align 4, !tbaa !3
  %169 = load i32, ptr addrspace(4) %arrayidx19.1, align 4, !tbaa !3
  %170 = load i32, ptr addrspace(4) %arrayidx20.1, align 4, !tbaa !3
  %call75.1 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, i32 noundef 1, i32 noundef %168, i32 noundef 1, i32 noundef %169, i32 noundef 1, i32 noundef %170)
  %171 = load i32, ptr addrspace(4) %arrayidx18.2, align 8, !tbaa !3
  %172 = load i32, ptr addrspace(4) %arrayidx19.2, align 8, !tbaa !3
  %173 = load i32, ptr addrspace(4) %arrayidx20.2, align 8, !tbaa !3
  %call75.2 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, i32 noundef 2, i32 noundef %171, i32 noundef 2, i32 noundef %172, i32 noundef 2, i32 noundef %173)
  %174 = load i32, ptr addrspace(4) %arrayidx18.3, align 4, !tbaa !3
  %175 = load i32, ptr addrspace(4) %arrayidx19.3, align 4, !tbaa !3
  %176 = load i32, ptr addrspace(4) %arrayidx20.3, align 4, !tbaa !3
  %call75.3 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, i32 noundef 3, i32 noundef %174, i32 noundef 3, i32 noundef %175, i32 noundef 3, i32 noundef %176)
  %177 = load i32, ptr addrspace(4) %arrayidx18.4, align 16, !tbaa !3
  %178 = load i32, ptr addrspace(4) %arrayidx19.4, align 16, !tbaa !3
  %179 = load i32, ptr addrspace(4) %arrayidx20.4, align 16, !tbaa !3
  %call75.4 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, i32 noundef 4, i32 noundef %177, i32 noundef 4, i32 noundef %178, i32 noundef 4, i32 noundef %179)
  br label %cleanup

cleanup:                                          ; preds = %vector.body, %if.then
  %retval.0 = phi i32 [ 1, %if.then ], [ 0, %vector.body ]
  ret i32 %retval.0
}

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #1

declare i32 @clock() local_unnamed_addr #2

declare void @vec_sum(ptr noundef, ptr noundef, ptr noundef, i32 noundef) local_unnamed_addr #2

declare i32 @_timer_clocks_per_sec() local_unnamed_addr #2

declare void @vectorized_vec_sum(ptr addrspace(4) noundef, ptr addrspace(4) noundef, ptr addrspace(4) noundef, i32 noundef) local_unnamed_addr #2

declare void @autovectorized_vec_sum(ptr addrspace(4) noundef, ptr addrspace(4) noundef, ptr addrspace(4) noundef, i32 noundef) local_unnamed_addr #2

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #3

; Function Attrs: nofree nounwind
declare noundef i32 @putchar(i32 noundef) local_unnamed_addr #3

attributes #0 = { nounwind "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #1 = { nofree nounwind "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
attributes #2 = { "approx-func-fp-math"="true" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="av2hs" "target-features"="+av2hs,+bs,+cd,+divrem,+fpu-mac,+fpud,+fpud-div,+fpus-div,+ll64,+mpy,+mpy16,+norm,+sa,+swap,+vdsp,+vdsp512gb0,+vdsp_vector_c,+vfpu2" "unsafe-fp-math"="true" }
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
