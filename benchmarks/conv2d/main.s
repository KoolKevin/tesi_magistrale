	.option	%reg
	.off	assume_short
	.file	"main.c"
	.globl	in
	.size	in, 10000
	.type	in,@object
	.size	.L.str.4, 15
	.type	.L.str.4,@object
	.globl	kernel
	.size	kernel, 36
	.type	kernel,@object
	.globl	out
	.size	out, 9216
	.type	out,@object
	.size	.L.str.2, 23
	.type	.L.str.2,@object
	.size	.Lstr, 26
	.type	.Lstr,@object
	.size	.Lstr.9, 27
	.type	.Lstr.9,@object
	.size	.L.str, 29
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
	.skip	10000
	.align	4
kernel:                                 ; @0x2710
	.skip	36
	.align	4
out:                                    ; @0x2734
	.skip	9216
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
	.asciz	"Tempo di esecuzione: %.2fms\n"
	.align	4
.L.str.8:                               ; @0x80
	.asciz	"Tempo di esecuzione di vekt_conv2d: %.2fms\n"
	.align	4
.L.str.3:                               ; @0xac
	.asciz	"Tempo di esecuzione di vectorized_conv2d: %.2fms\n"
	.align	4
.L.str.6:                               ; @0xe0
	.asciz	"Tempo di esecuzione di autovectorized_conv2d: %.2fms\n"
	.text
	.global	.CC_I
	.equ	.CC_I, 0
	.ident	"LLVM 17.0.7/V-2024.06. (build 008) (LLVM 17.0.7) -arcv2hs -core4 -Xcode_density -Xatomic -Xll64 -Xunaligned -Xdiv_rem=radix4 -Xswap -Xbitscan -Xmpy_option=mpyd -Xshift_assist -Xbarrel_shifter -Xfpud_div -Xfpu_mac -Xtimer0 -Xrtc -Xstack_check -Xstu=4 -Xvdsp4 -Xvec_unit_rev_minor=1 -Xvec_width=512 -Xvec_mem_size=128k -Xvec_mem_bank_width=16 -Xvec_max_fetch_size=16 -Xvec_num_slots=3 -Xvec_super_with_scalar -Xvec_regs=32 -Xvec_fpu=32 -Xvec_fpu_math=3 -Xvec_fpu_2nd_mul -Xvec_fpu_types=2 -Xvec_num_rd_ports=6 -Xvec_num_acc=8 -Xvec_num_mpy=2 -Xvec_mpy32 -Xvec_num_alu=3 -Xvec_guard_bit_option=0 -Xvec_stack_check -Hvdsp_vector_c -O3 -fno-unroll-loops -fvectorize -fslp-vectorize -ffast-math"
	.align	8                               ; -- Begin function main
main:                                   ; @main
                                        ; @0x0
.Lmain$local:                           ; @0x0
	.cfa_bf	.Lmain$local
;  %bb.0:                               ; %entry
	add3	%sp,%sp,-9264/8                 ; @0x0
	.cfa_push	9264                    ; @0x4
	st	%r13,[%sp,0]                    ; @0x4
	.cfa_reg_offset	{%r13}, 0               ; @0x8
	std	%r14,[%sp,4]                    ; @0x8
	.cfa_reg_offset	{%r14}, 4               ; @0xc
	.cfa_reg_offset	{%r15}, 8               ; @0xc
	std	%r16,[%sp,12]                   ; @0xc
	.cfa_reg_offset	{%r16}, 12              ; @0x10
	.cfa_reg_offset	{%r17}, 16              ; @0x10
	std	%r18,[%sp,20]                   ; @0x10
	.cfa_reg_offset	{%r18}, 20              ; @0x14
	.cfa_reg_offset	{%r19}, 24              ; @0x14
	std	%r20,[%sp,28]                   ; @0x14
	.cfa_reg_offset	{%r20}, 28              ; @0x18
	.cfa_reg_offset	{%r21}, 32              ; @0x18
	std	%r22,[%sp,36]                   ; @0x18
	.cfa_reg_offset	{%r22}, 36              ; @0x1c
	.cfa_reg_offset	{%r23}, 40              ; @0x1c
	st	%blink,[%sp,44]                 ; @0x1c
	.cfa_reg_offset	{%blink}, 44            ; @0x20
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov.w	 %vr1, 48                       ; @0x20
	vvci.w	%vr0                            ; @0x20
	mov_s	%r17,in                         ; @0x20
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvpinit.w	%p1, 0, 3               ; @0x2e
	mov_s	%r2,49                          ; @0x2e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,1,%r2              ; @0x36
	add2	%r1,%r17,192/4                  ; @0x36
 ;	 }
	mov_s	%r0,%r17                        ; @0x40
	mov_s	%r2,0                           ; @0x42
.LBB0_1:                                ; %iter.check
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_2 Depth 2
                                        ;     Child Loop BB0_4 Depth 2
                                        ; @0x44
	; Implicit def %r12                     ; @0x44
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	%vr2, %vr0                      ; @0x44
	mov	%lp_count,3                     ; @0x44
 ;	 }
	lp	.LZD0                           ; @0x4c
.LBB0_2:                                ; %vector.body
                                        ;   Parent Loop BB0_1 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; Label of block must be emitted
                                        ; @0x50 AlignLabel LoopTop Freq=1023
.vvsbundle  " v2" 
 ;	 { 
	vvadd.w	%vr2, %vr2, 16                  ; @0x50
	vvadd.w	%vr3, %vr2, %r2                 ; @0x50
 ;	 }
	vvrem.uu.w	%vr3, %vr3, 10          ; @0x58
	vvst.av.w	%vr3,%r0,1              ; @0x5c
.LZD0:                                  ; @0x62
	; ZD Loop End                           ; @0x62
;  %bb.3:                               ; %vec.epilog.ph
                                        ;   in Loop: Header=BB0_1 Depth=1
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	%vr2, %vr1                      ; @0x62
	mov_s	%r0,%r1                         ; @0x62
 ;	 }
	mov	%r3,1                           ; @0x68
.LBB0_4:                                ; %vec.epilog.vector.body
                                        ;   Parent Loop BB0_1 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; Label of block must be emitted
                                        ; @0x6c AlignLabel LoopTop Freq=1023
.vvsbundle  " v2" 
 ;	 { 
	vvadd.w	%vr2, %vr2, 2                   ; @0x6c
	vvadd.w	%vr3, %vr2, %r2                 ; @0x6c
 ;	 }
	vvrem.uu.w	%vr3, %vr3, 10          ; @0x74
	vvst.ab.w.p1	%vr3,%r0,8              ; @0x78
	dbnz	%r3,.LBB0_4                     ; @0x80
;  %bb.5:                               ; %for.cond.cleanup3
                                        ;   in Loop: Header=BB0_1 Depth=1
	add2	%r1,%r1,200/4                   ; @0x84
	add_s	%r2,%r2,1                       ; @0x88
	brlo	%r2,50,.LBB0_1                  ; @0x8a
;  %bb.6:                               ; %for.cond.cleanup
	mov_s	%r16,kernel                     ; @0x8e
	mov_s	%r0,%r16                        ; @0x94
	mov_s	%r1,3                           ; @0x96
	mov_s	%r2,3                           ; @0x98
	mov_s	%r3,1                           ; @0x9a
	bl	init_matrix                     ; @0x9c
	add	%r13,%r16,out-kernel            ; @0xa0
	mov_s	%r0,%r13                        ; @0xa4
	mov_s	%r1,48                          ; @0xa6
	mov_s	%r2,48                          ; @0xa8
	mov_s	%r3,0                           ; @0xaa
	bl	init_matrix                     ; @0xac
	bl	clock                           ; @0xb0
	mov_s	%r14,%r0                        ; @0xb4
	mov_s	%r5,%r13                        ; @0xb6
	mov_s	%r6,%r17                        ; @0xb8
	mov_s	%r7,%r16                        ; @0xba
	mov_s	%r0,48                          ; @0xbc
	mov_s	%r1,48                          ; @0xbe
	mov_s	%r2,50                          ; @0xc0
	mov_s	%r3,50                          ; @0xc2
	mov_s	%r4,3                           ; @0xc4
	bl	conv2d                          ; @0xc6
	mov_s	%r18,0                          ; @0xca
	mov_s	%r19,0x408f4000@u32             ; @0xcc
	bl	clock                           ; @0xd2
	sub_s	%r0,%r0,%r14                    ; @0xd6
	fint2d	%r2,%r0                         ; @0xd8
	fdmul	%r14,%r2,%r18                   ; @0xdc
	bl	_timer_clocks_per_sec           ; @0xe0
	fuint2d	%r2,%r0                         ; @0xe4
	fddiv	%r20,%r14,%r2                   ; @0xe8
	mov_s	%r15,.L.str.4                   ; @0xec
	add1	%r0,%r15,(.L.str-.L.str.4)/2    ; @0xf2
	mov_s	%r1,%r20                        ; @0xf6
	mov_s	%r2,%r21                        ; @0xf8
	bl	printf                          ; @0xfa
	mov_s	%r0,%r13                        ; @0xfe
	mov_s	%r1,48                          ; @0x100
	mov_s	%r2,48                          ; @0x102
	bl	print_matrix                    ; @0x104
	mov_s	%r1,%r13                        ; @0x108
	add_s	%r0,%sp,48                      ; @0x10a
	mov_s	%r2,48                          ; @0x10c
	mov_s	%r3,48                          ; @0x10e
	bl	copy_matrix                     ; @0x110
	mov	%r0,10                          ; widened to benefit BPU
                                        ; @0x114
	bl	putchar                         ; @0x118
	add_s	%r0,%r15,.L.str.2-.L.str.4      ; @0x11c
	mov_s	%r1,16                          ; @0x11e
	bl	printf                          ; @0x120
	mov_s	%r0,%r13                        ; @0x124
	mov_s	%r1,48                          ; @0x126
	mov_s	%r2,48                          ; @0x128
	mov_s	%r3,0                           ; @0x12a
	bl	init_matrix                     ; @0x12c
	bl	clock                           ; @0x130
	mov_s	%r14,%r0                        ; @0x134
	mov_s	%r5,%r13                        ; @0x136
	mov_s	%r6,%r17                        ; @0x138
	mov_s	%r7,%r16                        ; @0x13a
	mov_s	%r0,48                          ; @0x13c
	mov_s	%r1,48                          ; @0x13e
	mov_s	%r2,50                          ; @0x140
	mov_s	%r3,50                          ; @0x142
	mov_s	%r4,3                           ; @0x144
	bl	vectorized_conv2d               ; @0x146
	bl	clock                           ; @0x14a
	sub_s	%r0,%r0,%r14                    ; @0x14e
	fint2d	%r2,%r0                         ; @0x150
	fdmul	%r22,%r2,%r18                   ; @0x154
	bl	_timer_clocks_per_sec           ; @0x158
	fuint2d	%r2,%r0                         ; @0x15c
	fddiv	%r22,%r22,%r2                   ; @0x160
	add2	%r0,%r15,(.L.str.3-.L.str.4)/4  ; @0x164
	mov_s	%r1,%r22                        ; @0x168
	mov_s	%r2,%r23                        ; @0x16a
	bl	printf                          ; @0x16c
	fddiv	%r2,%r20,%r22                   ; @0x170
	mov_s	%r0,%r15                        ; @0x174
	mov_s	%r1,%r2                         ; @0x176
	mov_s	%r2,%r3                         ; @0x178
	bl	printf                          ; @0x17a
	mov_s	%r0,%r13                        ; @0x17e
	mov_s	%r1,48                          ; @0x180
	mov_s	%r2,48                          ; @0x182
	bl	print_matrix                    ; @0x184
	mov_s	%r1,%r13                        ; @0x188
	add_s	%r0,%sp,48                      ; @0x18a
	mov_s	%r2,48                          ; @0x18c
	mov_s	%r3,48                          ; @0x18e
	bl	check_result                    ; @0x190
	mov	%r0,10                          ; widened to benefit BPU
                                        ; @0x194
	bl	putchar                         ; @0x198
	add	%r0,%r15,.Lstr-.L.str.4         ; widened to benefit BPU
                                        ; @0x19c
	bl	puts                            ; @0x1a0
	mov_s	%r0,%r13                        ; @0x1a4
	mov_s	%r1,48                          ; @0x1a6
	mov_s	%r2,48                          ; @0x1a8
	mov_s	%r3,0                           ; @0x1aa
	bl	init_matrix                     ; @0x1ac
	bl	clock                           ; @0x1b0
	mov_s	%r14,%r0                        ; @0x1b4
	mov_s	%r5,%r13                        ; @0x1b6
	mov_s	%r6,%r17                        ; @0x1b8
	mov_s	%r7,%r16                        ; @0x1ba
	mov_s	%r0,48                          ; @0x1bc
	mov_s	%r1,48                          ; @0x1be
	mov_s	%r2,50                          ; @0x1c0
	mov_s	%r3,50                          ; @0x1c2
	mov_s	%r4,3                           ; @0x1c4
	bl	autovectorized_conv2d           ; @0x1c6
	bl	clock                           ; @0x1ca
	sub_s	%r0,%r0,%r14                    ; @0x1ce
	fint2d	%r2,%r0                         ; @0x1d0
	fdmul	%r22,%r2,%r18                   ; @0x1d4
	bl	_timer_clocks_per_sec           ; @0x1d8
	fuint2d	%r2,%r0                         ; @0x1dc
	fddiv	%r22,%r22,%r2                   ; @0x1e0
	add2	%r0,%r15,(.L.str.6-.L.str.4)/4  ; @0x1e4
	mov_s	%r1,%r22                        ; @0x1e8
	mov_s	%r2,%r23                        ; @0x1ea
	bl	printf                          ; @0x1ec
	fddiv	%r2,%r20,%r22                   ; @0x1f0
	mov_s	%r0,%r15                        ; @0x1f4
	mov_s	%r1,%r2                         ; @0x1f6
	mov_s	%r2,%r3                         ; @0x1f8
	bl	printf                          ; @0x1fa
	mov_s	%r0,%r13                        ; @0x1fe
	mov_s	%r1,48                          ; @0x200
	mov_s	%r2,48                          ; @0x202
	bl	print_matrix                    ; @0x204
	mov_s	%r0,10                          ; @0x208
	bl	putchar                         ; @0x20a
	add1	%r0,%r15,(.Lstr.9-.L.str.4)/2   ; @0x20e
	bl	puts                            ; @0x212
	mov_s	%r0,%r13                        ; @0x216
	mov_s	%r1,48                          ; @0x218
	mov_s	%r2,48                          ; @0x21a
	mov_s	%r3,0                           ; @0x21c
	bl	init_matrix                     ; @0x21e
	bl	clock                           ; @0x222
	mov_s	%r14,%r0                        ; @0x226
	mov_s	%r5,%r13                        ; @0x228
	mov_s	%r6,%r17                        ; @0x22a
	mov_s	%r7,%r16                        ; @0x22c
	mov_s	%r0,48                          ; @0x22e
	mov_s	%r1,48                          ; @0x230
	mov_s	%r2,50                          ; @0x232
	mov_s	%r3,50                          ; @0x234
	mov_s	%r4,3                           ; @0x236
	bl.d	vekt_conv2d_wrapper             ; @0x238
	nop                                     ; inserted to benefit BPU
                                        ; @0x23c
	bl	clock                           ; @0x240
	sub_s	%r0,%r0,%r14                    ; @0x244
	fint2d	%r2,%r0                         ; @0x246
	fdmul	%r16,%r2,%r18                   ; @0x24a
	bl	_timer_clocks_per_sec           ; @0x24e
	fuint2d	%r2,%r0                         ; @0x252
	fddiv	%r16,%r16,%r2                   ; @0x256
	add2	%r0,%r15,(.L.str.8-.L.str.4)/4  ; @0x25a
	mov_s	%r1,%r16                        ; @0x25e
	mov_s	%r2,%r17                        ; @0x260
	bl	printf                          ; @0x262
	fddiv	%r2,%r20,%r16                   ; @0x266
	mov_s	%r0,%r15                        ; @0x26a
	mov_s	%r1,%r2                         ; @0x26c
	mov_s	%r2,%r3                         ; @0x26e
	bl	printf                          ; @0x270
	mov_s	%r0,%r13                        ; @0x274
	mov_s	%r1,48                          ; @0x276
	mov_s	%r2,48                          ; @0x278
	bl	print_matrix                    ; @0x27a
	mov_s	%r1,%r13                        ; @0x27e
	add_s	%r0,%sp,48                      ; @0x280
	mov_s	%r2,48                          ; @0x282
	mov_s	%r3,48                          ; @0x284
	bl	check_result                    ; @0x286
	mov_s	%r0,10                          ; @0x28a
	bl	putchar                         ; @0x28c
	mov_s	%r0,0                           ; @0x290
	ld	%blink,[%sp,44]                 ; @0x292
	.cfa_restore	{%blink}                ; @0x296
	ldd	%r22,[%sp,36]                   ; @0x296
	.cfa_restore	{%r23}                  ; @0x29a
	.cfa_restore	{%r22}                  ; @0x29a
	ldd	%r20,[%sp,28]                   ; @0x29a
	.cfa_restore	{%r21}                  ; @0x29e
	.cfa_restore	{%r20}                  ; @0x29e
	ldd	%r18,[%sp,20]                   ; @0x29e
	.cfa_restore	{%r19}                  ; @0x2a2
	.cfa_restore	{%r18}                  ; @0x2a2
	ldd	%r16,[%sp,12]                   ; @0x2a2
	.cfa_restore	{%r17}                  ; @0x2a6
	.cfa_restore	{%r16}                  ; @0x2a6
	ldd	%r14,[%sp,4]                    ; @0x2a6
	.cfa_restore	{%r15}                  ; @0x2aa
	.cfa_restore	{%r14}                  ; @0x2aa
	ld_s	%r13,[%sp,0]                    ; @0x2aa
	.cfa_restore	{%r13}                  ; @0x2ac
	add3	%sp,%sp,9264/8                  ; @0x2ac
	.cfa_pop	9264                            ; @0x2b0
	j_s	[%blink]                        ; @0x2b0
	.cfa_ef
.Lfunc_end0:                            ; @0x2b2

	.reloc	_init_ad,0	;startup code to enable %status AD bit ; -- End function
