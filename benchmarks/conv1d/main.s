	.option	%reg
	.off	assume_short
	.file	"main.c"
	.globl	in
	.size	in, 4096
	.type	in,@object
	.globl	kernel
	.size	kernel, 12
	.type	kernel,@object
	.size	.L.str.4, 15
	.type	.L.str.4,@object
	.globl	out
	.size	out, 4088
	.type	out,@object
	.size	.L.str.2, 23
	.type	.L.str.2,@object
	.size	.Lstr, 26
	.type	.Lstr,@object
	.size	.Lstr.9, 27
	.type	.Lstr.9,@object
	.size	.L.str, 39
	.type	.L.str,@object
	.size	.L.str.8, 44
	.type	.L.str.8,@object
	.size	.L.str.3, 50
	.type	.L.str.3,@object
	.size	.L.str.6, 54
	.type	.L.str.6,@object
	.globl	main
	.type	main,@function
	.type	.Lmain$local,@function
	.size	main, .Lfunc_end0-main
	.size	.Lmain$local, .Lfunc_end0-main
	.section	.ARC.attributes,"",@attributes
	.align	4
	.byte	65
.LabiStart0:                            ; @0x1
	.word	.LabiEnd0-.LabiStart0
	.asciz	"ARC"
.LabiStartList0:                        ; @0x9
	.byte	1
	.word	.LabiEnd0-.LabiStartList0
	.byte	20
	.byte	1                               ; version=1
	.byte	10
	.byte	1                               ; sda=1
	.byte	13
	.byte	1                               ; fshort-enums
	.byte	5
	.byte	4                               ; processor
	.byte	6
	.byte	4                               ; core
	.byte	16
	.asciz	"BITSCAN,BS,SWAP,DIV_REM,CD,FPUS,FPUD,FPUS_DIV,FPUD_DIV,SA,LL64,NORM"
	.byte	18
	.byte	8                               ; MPY_OPTION
.LabiEnd0:                              ; @0x5f
	.section	.vecmem_data,"aw",@progbits
	.align	4
in:                                     ; @0x0
	.skip	4096
	.align	4
kernel:                                 ; @0x1000
	.skip	12
	.align	4
out:                                    ; @0x100c
	.skip	4088
	.section	.rodata,"a",@progbits
	.align	4
.L.str.4:                               ; @0x0
	.asciz	"Speedup: %.2f\n"
	.align	4
.L.str.2:                               ; @0x10
	.asciz	"Vettorizzo su %d lane\n"
	.align	4
.Lstr:                                  ; @0x28
	.asciz	"Versione autovettorizzata"
	.align	4
.Lstr.9:                                ; @0x44
	.asciz	"Versione vekt-vettorizzata"
	.align	4
.L.str:                                 ; @0x60
	.asciz	"Tempo di esecuzione di conv1d: %.2fms\n"
	.align	4
.L.str.8:                               ; @0x88
	.asciz	"Tempo di esecuzione di vekt_conv1d: %.2fms\n"
	.align	4
.L.str.3:                               ; @0xb4
	.asciz	"Tempo di esecuzione di vectorized_conv1d: %.2fms\n"
	.align	4
.L.str.6:                               ; @0xe8
	.asciz	"Tempo di esecuzione di autovectorized_conv1d: %.2fms\n"
	.text
	.global	.CC_I
	.equ	.CC_I, 0
	.ident	"LLVM 17.0.7/V-2024.06. (build 008) (LLVM 17.0.7) -arcv2hs -core4 -Xcode_density -Xatomic -Xll64 -Xunaligned -Xdiv_rem=radix4 -Xswap -Xbitscan -Xmpy_option=mpyd -Xshift_assist -Xbarrel_shifter -Xfpud_div -Xfpu_mac -Xtimer0 -Xrtc -Xstack_check -Xstu=4 -Xvdsp4 -Xvec_unit_rev_minor=1 -Xvec_width=512 -Xvec_mem_size=128k -Xvec_mem_bank_width=16 -Xvec_max_fetch_size=16 -Xvec_num_slots=3 -Xvec_super_with_scalar -Xvec_regs=32 -Xvec_fpu=32 -Xvec_fpu_math=3 -Xvec_fpu_2nd_mul -Xvec_fpu_types=2 -Xvec_num_rd_ports=6 -Xvec_num_acc=8 -Xvec_num_mpy=2 -Xvec_mpy32 -Xvec_num_alu=3 -Xvec_guard_bit_option=0 -Xvec_stack_check -Hvdsp_vector_c -O3 -fvectorize -fslp-vectorize -ffast-math"
	.align	8                               ; -- Begin function main
main:                                   ; @main
                                        ; @0x0
.Lmain$local:                           ; @0x0
	.cfa_bf	.Lmain$local
;  %bb.0:                               ; %entry
	st.aw	%r13,[%sp,-48]                  ; @0x0
	.cfa_push	48                      ; @0x4
	.cfa_reg_offset	{%r13}, 0               ; @0x4
	std	%r14,[%sp,4]                    ; @0x4
	.cfa_reg_offset	{%r14}, 4               ; @0x8
	.cfa_reg_offset	{%r15}, 8               ; @0x8
	std	%r16,[%sp,12]                   ; @0x8
	.cfa_reg_offset	{%r16}, 12              ; @0xc
	.cfa_reg_offset	{%r17}, 16              ; @0xc
	std	%r18,[%sp,20]                   ; @0xc
	.cfa_reg_offset	{%r18}, 20              ; @0x10
	.cfa_reg_offset	{%r19}, 24              ; @0x10
	std	%r20,[%sp,28]                   ; @0x10
	.cfa_reg_offset	{%r20}, 28              ; @0x14
	.cfa_reg_offset	{%r21}, 32              ; @0x14
	std	%r22,[%sp,36]                   ; @0x14
	.cfa_reg_offset	{%r22}, 36              ; @0x18
	.cfa_reg_offset	{%r23}, 40              ; @0x18
	st	%blink,[%sp,44]                 ; @0x18
	.cfa_reg_offset	{%blink}, 44            ; @0x1c
	mov_s	%r11,4                          ; @0x1c
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr4,0,%r11             ; @0x1e
	mov_s	%r1,6                           ; @0x1e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,0,%r1              ; @0x26
	mov_s	%r2,8                           ; @0x26
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,0,%r2              ; @0x2e
	mov_s	%r16,0                          ; @0x2e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,0,%r16             ; @0x36
	mov_s	%r3,2                           ; @0x36
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,0,%r3              ; @0x3e
	mov_s	%r8,5                           ; @0x3e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr4,1,%r8              ; @0x46
	mov_s	%r14,7                          ; @0x46
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,1,%r14             ; @0x4e
	mov_s	%r13,9                          ; @0x4e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,1,%r13             ; @0x56
	mov_s	%r0,1                           ; @0x56
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr4,2,%r1              ; @0x5e
	mov_s	%r12,3                          ; @0x5e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,1,%r0              ; @0x66
	mov_s	%r18,kernel                     ; @0x66
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,1,%r12             ; @0x72
	mov_s	%r15,in                         ; @0x72
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,2,%r16             ; @0x7e
	add	%r19,%r18,out-kernel            ; @0x7e
 ;	 }
	vvmov1.vi.to.w	%vr4,3,%r14             ; @0x88
	vvmov1.vi.to.w	%vr2,2,%r11             ; @0x8e
	vvmov1.vi.to.w	%vr3,3,%r0              ; @0x94
	vvmov1.vi.to.w	%vr4,4,%r2              ; @0x9a
	vvmov1.vi.to.w	%vr1,2,%r2              ; @0xa0
	vvmov1.vi.to.w	%vr2,3,%r8              ; @0xa6
	vvmov1.vi.to.w	%vr3,4,%r3              ; @0xac
	vvmov1.vi.to.w	%vr4,5,%r13             ; @0xb2
	vvmov1.vi.to.w	%vr0,2,%r3              ; @0xb8
	vvmov1.vi.to.w	%vr1,3,%r13             ; @0xbe
	vvmov1.vi.to.w	%vr2,4,%r1              ; @0xc4
	vvmov1.vi.to.w	%vr3,5,%r12             ; @0xca
	vvmov1.vi.to.w	%vr4,6,%r16             ; @0xd0
	vvmov1.vi.to.w	%vr0,3,%r12             ; @0xd6
	vvmov1.vi.to.w	%vr1,4,%r16             ; @0xdc
	vvmov1.vi.to.w	%vr2,5,%r14             ; @0xe2
	vvmov1.vi.to.w	%vr3,6,%r11             ; @0xe8
	vvmov1.vi.to.w	%vr4,7,%r0              ; @0xee
	vvmov1.vi.to.w	%vr0,4,%r11             ; @0xf4
	vvmov1.vi.to.w	%vr1,5,%r0              ; @0xfa
	vvmov1.vi.to.w	%vr2,6,%r2              ; @0x100
	vvmov1.vi.to.w	%vr3,7,%r8              ; @0x106
	vvmov1.vi.to.w	%vr4,8,%r3              ; @0x10c
	vvmov1.vi.to.w	%vr0,5,%r8              ; @0x112
	vvmov1.vi.to.w	%vr1,6,%r3              ; @0x118
	vvmov1.vi.to.w	%vr2,7,%r13             ; @0x11e
	vvmov1.vi.to.w	%vr3,8,%r1              ; @0x124
	vvmov1.vi.to.w	%vr4,9,%r12             ; @0x12a
	vvmov1.vi.to.w	%vr0,6,%r1              ; @0x130
	vvmov1.vi.to.w	%vr1,7,%r12             ; @0x136
	vvmov1.vi.to.w	%vr2,8,%r16             ; @0x13c
	vvmov1.vi.to.w	%vr3,9,%r14             ; @0x142
	vvmov1.vi.to.w	%vr4,10,%r11            ; @0x148
	vvmov1.vi.to.w	%vr0,7,%r14             ; @0x14e
	vvmov1.vi.to.w	%vr1,8,%r11             ; @0x154
	vvmov1.vi.to.w	%vr2,9,%r0              ; @0x15a
	vvmov1.vi.to.w	%vr3,10,%r2             ; @0x160
	vvmov1.vi.to.w	%vr4,11,%r8             ; @0x166
	vvmov1.vi.to.w	%vr0,8,%r2              ; @0x16c
	vvmov1.vi.to.w	%vr1,9,%r8              ; @0x172
	vvmov1.vi.to.w	%vr2,10,%r3             ; @0x178
	vvmov1.vi.to.w	%vr3,11,%r13            ; @0x17e
	vvmov1.vi.to.w	%vr4,12,%r1             ; @0x184
	vvmov1.vi.to.w	%vr0,9,%r13             ; @0x18a
	vvmov1.vi.to.w	%vr1,10,%r1             ; @0x190
	vvmov1.vi.to.w	%vr2,11,%r12            ; @0x196
	vvmov1.vi.to.w	%vr3,12,%r16            ; @0x19c
	vvmov1.vi.to.w	%vr4,13,%r14            ; @0x1a2
	vvmov1.vi.to.w	%vr0,10,%r16            ; @0x1a8
	vvmov1.vi.to.w	%vr1,11,%r14            ; @0x1ae
	vvmov1.vi.to.w	%vr2,12,%r11            ; @0x1b4
	vvmov1.vi.to.w	%vr3,13,%r0             ; @0x1ba
	vvmov1.vi.to.w	%vr4,14,%r2             ; @0x1c0
	vvmov1.vi.to.w	%vr0,11,%r0             ; @0x1c6
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,12,%r2             ; @0x1cc
	mov_s	%r2,0                           ; @0x1cc
 ;	 }
	vvmov1.vi.to.w	%vr2,13,%r8             ; @0x1d4
	vvmov1.vi.to.w	%vr4,15,%r13            ; @0x1da
.vvsbundle  " v2" 
 ;	 { 
	vvst.aa.w	%vr4,%r15,3776          ; @0x1e0
	vvmov1.vi.to.w	%vr3,14,%r3             ; @0x1e0
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvst.aa.w	%vr4,%r15,3456          ; @0x1ea
	vvmov1.vi.to.w	%vr0,12,%r3             ; @0x1ea
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvst.aa.w	%vr4,%r15,1216          ; @0x1f4
	vvmov1.vi.to.w	%vr1,13,%r13            ; @0x1f4
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvst.aa.w	%vr4,%r15,896           ; @0x1fe
	vvmov1.vi.to.w	%vr3,15,%r12            ; @0x1fe
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvst.aa.w	%vr4,%r15,3136          ; @0x208
	vvmov1.vi.to.w	%vr2,14,%r1             ; @0x208
	mov	%r1,1022                        ; @0x208
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvst.aa.w	%vr4,%r15,2816          ; @0x216
	vvmov1.vi.to.w	%vr0,13,%r12            ; @0x216
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvst.aa.w	%vr4,%r15,576           ; @0x220
	vvmov1.vi.to.w	%vr2,15,%r14            ; @0x220
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvst.aa.w	%vr4,%r15,2496          ; @0x22a
	vvmov1.vi.to.w	%vr1,14,%r16            ; @0x22a
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvst.aa.w	%vr4,%r15,2176          ; @0x234
	vvmov1.vi.to.w	%vr1,15,%r0             ; @0x234
	mov_s	%r0,%r19                        ; @0x234
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvst.aa.w	%vr4,%r15,1856          ; @0x240
	vvmov1.vi.to.w	%vr0,14,%r11            ; @0x240
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvst.aa.w	%vr4,%r15,1536          ; @0x24a
	vvmov1.vi.to.w	%vr0,15,%r8             ; @0x24a
 ;	 }
	vvst.aa.w	%vr4,%r15,256           ; @0x254
	vvst.aa.w	%vr3,%r15,4032          ; @0x25a
	vvst.aa.w	%vr3,%r15,3712          ; @0x260
	vvst.aa.w	%vr3,%r15,3392          ; @0x266
	vvst.aa.w	%vr3,%r15,3072          ; @0x26c
	vvst.aa.w	%vr3,%r15,2752          ; @0x272
	vvst.aa.w	%vr3,%r15,2432          ; @0x278
	vvst.aa.w	%vr3,%r15,2112          ; @0x27e
	vvst.aa.w	%vr3,%r15,1792          ; @0x284
	vvst.aa.w	%vr3,%r15,1472          ; @0x28a
	vvst.aa.w	%vr3,%r15,1152          ; @0x290
	vvst.aa.w	%vr3,%r15,832           ; @0x296
	vvst.aa.w	%vr3,%r15,512           ; @0x29c
	vvst.aa.w	%vr3,%r15,192           ; @0x2a2
	vvst.aa.w	%vr2,%r15,3968          ; @0x2a8
	vvst.aa.w	%vr2,%r15,3648          ; @0x2ae
	vvst.aa.w	%vr2,%r15,3328          ; @0x2b4
	vvst.aa.w	%vr2,%r15,3008          ; @0x2ba
	vvst.aa.w	%vr2,%r15,2688          ; @0x2c0
	vvst.aa.w	%vr2,%r15,2368          ; @0x2c6
	vvst.aa.w	%vr2,%r15,2048          ; @0x2cc
	vvst.aa.w	%vr2,%r15,1728          ; @0x2d2
	vvst.aa.w	%vr2,%r15,1408          ; @0x2d8
	vvst.aa.w	%vr2,%r15,1088          ; @0x2de
	vvst.aa.w	%vr2,%r15,768           ; @0x2e4
	vvst.aa.w	%vr2,%r15,448           ; @0x2ea
	vvst.aa.w	%vr2,%r15,128           ; @0x2f0
	vvst.aa.w	%vr1,%r15,3904          ; @0x2f6
	vvst.aa.w	%vr1,%r15,3584          ; @0x2fc
	vvst.aa.w	%vr1,%r15,3264          ; @0x302
	vvst.aa.w	%vr1,%r15,2944          ; @0x308
	vvst.aa.w	%vr1,%r15,2624          ; @0x30e
	vvst.aa.w	%vr1,%r15,2304          ; @0x314
	vvst.aa.w	%vr1,%r15,1984          ; @0x31a
	vvst.aa.w	%vr1,%r15,1664          ; @0x320
	vvst.aa.w	%vr1,%r15,1344          ; @0x326
	vvst.aa.w	%vr1,%r15,1024          ; @0x32c
	vvst.aa.w	%vr1,%r15,704           ; @0x332
	vvst.aa.w	%vr1,%r15,384           ; @0x338
	vvst.aa.w	%vr1,%r15,64            ; @0x33e
	vvst.aa.w	%vr0,%r15,3840          ; @0x344
	vvst.aa.w	%vr0,%r15,3520          ; @0x34a
	vvst.aa.w	%vr0,%r15,3200          ; @0x350
	vvst.aa.w	%vr0,%r15,2880          ; @0x356
	vvst.aa.w	%vr0,%r15,2560          ; @0x35c
	vvst.aa.w	%vr0,%r15,2240          ; @0x362
	vvst.aa.w	%vr0,%r15,1920          ; @0x368
	vvst.aa.w	%vr0,%r15,1600          ; @0x36e
	vvst.aa.w	%vr0,%r15,1280          ; @0x374
	vvst.aa.w	%vr0,%r15,960           ; @0x37a
	vvst.aa.w	%vr0,%r15,640           ; @0x380
	vvst.aa.w	%vr0,%r15,320           ; @0x386
	vvst.w	%vr0,%r15                       ; @0x38c
	bl	init_vector                     ; @0x390
	mov_s	%r0,%r18                        ; @0x394
	mov_s	%r1,3                           ; @0x396
	mov	%r2,1                           ; widened to benefit BPU
                                        ; @0x398
	bl	init_vector                     ; @0x39c
	bl	clock                           ; @0x3a0
	mov_s	%r14,%r0                        ; @0x3a4
	mov_s	%r3,%r19                        ; @0x3a6
	mov_s	%r4,%r15                        ; @0x3a8
	mov_s	%r5,%r18                        ; @0x3aa
	mov	%r0,1022                        ; @0x3ac
	mov	%r1,1024                        ; @0x3b0
	mov_s	%r2,3                           ; @0x3b4
	bl	conv1d                          ; @0x3b6
	mov_s	%r17,0x408f4000@u32             ; @0x3ba
	bl	clock                           ; @0x3c0
	sub_s	%r0,%r0,%r14                    ; @0x3c4
	fint2d	%r2,%r0                         ; @0x3c6
	fdmul	%r20,%r2,%r16                   ; @0x3ca
	bl	_timer_clocks_per_sec           ; @0x3ce
	fuint2d	%r2,%r0                         ; @0x3d2
	fddiv	%r20,%r20,%r2                   ; @0x3d6
	mov_s	%r13,.L.str.4                   ; @0x3da
	add1	%r0,%r13,(.L.str-.L.str.4)/2    ; @0x3e0
	mov_s	%r1,%r20                        ; @0x3e4
	mov_s	%r2,%r21                        ; @0x3e6
	bl	printf                          ; @0x3e8
	mov_s	%r0,%r19                        ; @0x3ec
	mov	%r1,1022                        ; @0x3ee
	bl	print_vector                    ; @0x3f2
	mov_s	%r0,10                          ; @0x3f6
	bl	putchar                         ; @0x3f8
	add_s	%r0,%r13,.L.str.2-.L.str.4      ; @0x3fc
	mov_s	%r1,16                          ; @0x3fe
	bl	printf                          ; @0x400
	mov_s	%r0,%r19                        ; @0x404
	mov	%r1,1022                        ; @0x406
	mov_s	%r2,0                           ; @0x40a
	bl	init_vector                     ; @0x40c
	bl	clock                           ; @0x410
	mov_s	%r14,%r0                        ; @0x414
	mov_s	%r3,%r19                        ; @0x416
	mov_s	%r4,%r15                        ; @0x418
	mov_s	%r5,%r18                        ; @0x41a
	mov	%r0,1022                        ; @0x41c
	mov	%r1,1024                        ; @0x420
	mov_s	%r2,3                           ; @0x424
	bl	vectorized_conv1d               ; @0x426
	bl	clock                           ; @0x42a
	sub_s	%r0,%r0,%r14                    ; @0x42e
	fint2d	%r2,%r0                         ; @0x430
	fdmul	%r22,%r2,%r16                   ; @0x434
	bl	_timer_clocks_per_sec           ; @0x438
	fuint2d	%r2,%r0                         ; @0x43c
	fddiv	%r22,%r22,%r2                   ; @0x440
	add2	%r0,%r13,(.L.str.3-.L.str.4)/4  ; @0x444
	mov_s	%r1,%r22                        ; @0x448
	mov_s	%r2,%r23                        ; @0x44a
	bl	printf                          ; @0x44c
	fddiv	%r2,%r20,%r22                   ; @0x450
	mov_s	%r0,%r13                        ; @0x454
	mov_s	%r1,%r2                         ; @0x456
	mov_s	%r2,%r3                         ; @0x458
	bl	printf                          ; @0x45a
	mov_s	%r0,%r19                        ; @0x45e
	mov	%r1,1022                        ; @0x460
	bl	print_vector                    ; @0x464
	mov_s	%r0,10                          ; @0x468
	bl	putchar                         ; @0x46a
	add_s	%r0,%r13,.Lstr-.L.str.4         ; @0x46e
	bl	puts                            ; @0x470
	mov_s	%r0,%r19                        ; @0x474
	mov	%r1,1022                        ; @0x476
	mov_s	%r2,0                           ; @0x47a
	bl	init_vector                     ; @0x47c
	bl	clock                           ; @0x480
	mov_s	%r14,%r0                        ; @0x484
	mov_s	%r3,%r19                        ; @0x486
	mov_s	%r4,%r15                        ; @0x488
	mov_s	%r5,%r18                        ; @0x48a
	mov	%r0,1022                        ; @0x48c
	mov	%r1,1024                        ; @0x490
	mov_s	%r2,3                           ; @0x494
	bl	autovectorized_conv1d           ; @0x496
	bl	clock                           ; @0x49a
	sub_s	%r0,%r0,%r14                    ; @0x49e
	fint2d	%r2,%r0                         ; @0x4a0
	fdmul	%r22,%r2,%r16                   ; @0x4a4
	bl	_timer_clocks_per_sec           ; @0x4a8
	fuint2d	%r2,%r0                         ; @0x4ac
	fddiv	%r22,%r22,%r2                   ; @0x4b0
	add2	%r0,%r13,(.L.str.6-.L.str.4)/4  ; @0x4b4
	mov_s	%r1,%r22                        ; @0x4b8
	mov_s	%r2,%r23                        ; @0x4ba
	bl	printf                          ; @0x4bc
	fddiv	%r2,%r20,%r22                   ; @0x4c0
	mov_s	%r0,%r13                        ; @0x4c4
	mov_s	%r1,%r2                         ; @0x4c6
	mov_s	%r2,%r3                         ; @0x4c8
	bl	printf                          ; @0x4ca
	mov_s	%r0,%r19                        ; @0x4ce
	mov	%r1,1022                        ; @0x4d0
	bl	print_vector                    ; @0x4d4
	mov_s	%r0,10                          ; @0x4d8
	bl	putchar                         ; @0x4da
	add1	%r0,%r13,(.Lstr.9-.L.str.4)/2   ; @0x4de
	bl	puts                            ; @0x4e2
	mov_s	%r0,%r19                        ; @0x4e6
	mov	%r1,1022                        ; @0x4e8
	mov_s	%r2,0                           ; @0x4ec
	bl	init_vector                     ; @0x4ee
	bl	clock                           ; @0x4f2
	mov_s	%r14,%r0                        ; @0x4f6
	mov_s	%r3,%r19                        ; @0x4f8
	mov_s	%r4,%r15                        ; @0x4fa
	mov_s	%r5,%r18                        ; @0x4fc
	mov	%r0,1022                        ; @0x4fe
	mov	%r1,1024                        ; @0x502
	mov_s	%r2,3                           ; @0x506
	bl.d	vekt_conv1d_wrapper             ; @0x508
	nop                                     ; inserted to benefit BPU
                                        ; @0x50c
	bl	clock                           ; @0x510
	sub_s	%r0,%r0,%r14                    ; @0x514
	fint2d	%r2,%r0                         ; @0x516
	fdmul	%r14,%r2,%r16                   ; @0x51a
	bl	_timer_clocks_per_sec           ; @0x51e
	fuint2d	%r2,%r0                         ; @0x522
	fddiv	%r14,%r14,%r2                   ; @0x526
	add2	%r0,%r13,(.L.str.8-.L.str.4)/4  ; @0x52a
	mov_s	%r1,%r14                        ; @0x52e
	mov_s	%r2,%r15                        ; @0x530
	bl	printf                          ; @0x532
	fddiv	%r2,%r20,%r14                   ; @0x536
	mov_s	%r0,%r13                        ; @0x53a
	mov_s	%r1,%r2                         ; @0x53c
	mov_s	%r2,%r3                         ; @0x53e
	bl	printf                          ; @0x540
	mov_s	%r0,%r19                        ; @0x544
	mov	%r1,1022                        ; @0x546
	bl	print_vector                    ; @0x54a
	mov_s	%r0,0                           ; @0x54e
	ld	%blink,[%sp,44]                 ; @0x550
	.cfa_restore	{%blink}                ; @0x554
	ldd	%r22,[%sp,36]                   ; @0x554
	.cfa_restore	{%r23}                  ; @0x558
	.cfa_restore	{%r22}                  ; @0x558
	ldd	%r20,[%sp,28]                   ; @0x558
	.cfa_restore	{%r21}                  ; @0x55c
	.cfa_restore	{%r20}                  ; @0x55c
	ldd	%r18,[%sp,20]                   ; @0x55c
	.cfa_restore	{%r19}                  ; @0x560
	.cfa_restore	{%r18}                  ; @0x560
	ldd	%r16,[%sp,12]                   ; @0x560
	.cfa_restore	{%r17}                  ; @0x564
	.cfa_restore	{%r16}                  ; @0x564
	ldd	%r14,[%sp,4]                    ; @0x564
	.cfa_restore	{%r15}                  ; @0x568
	.cfa_restore	{%r14}                  ; @0x568
	ld.ab	%r13,[%sp,48]                   ; @0x568
	.cfa_restore	{%r13}                  ; @0x56c
	.cfa_pop	48                              ; @0x56c
	j_s	[%blink]                        ; @0x56c
	.cfa_ef
.Lfunc_end0:                            ; @0x56e

	.reloc	_init_ad,0	;startup code to enable %status AD bit ; -- End function
