	.option	%reg
	.off	assume_short
	.file	"main.c"
	.size	.L.str.2, 30
	.type	.L.str.2,@object
	.globl	a
	.size	a, 32768
	.type	a,@object
	.globl	b
	.size	b, 32768
	.type	b,@object
	.globl	c
	.size	c, 32768
	.type	c,@object
	.size	.Lstr.14, 30
	.type	.Lstr.14,@object
	.size	.L.str.6, 15
	.type	.L.str.6,@object
	.size	.L.str.8, 55
	.type	.L.str.8,@object
	.size	.L.str.4, 23
	.type	.L.str.4,@object
	.size	.Lstr.11, 26
	.type	.Lstr.11,@object
	.size	.Lstr.13, 27
	.type	.Lstr.13,@object
	.size	.L.str, 40
	.type	.L.str,@object
	.size	.L.str.5, 51
	.type	.L.str.5,@object
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
	.section	.rodata,"a",@progbits
.L.str.2:                               ; @0x0
	.asciz	"a[%d]=%d, b[%d]=%d, c[%d]=%d\n"
.Lstr.14:                               ; @0x1e
	.asciz	"Primi 5 elementi della somma:"
.L.str.6:                               ; @0x3c
	.asciz	"Speedup: %.2f\n"
.L.str.8:                               ; @0x4b
	.asciz	"Tempo di esecuzione di autovectorized_vec_sum: %.2fms\n"
.L.str.4:                               ; @0x82
	.asciz	"Vettorizzo su %d lane\n"
.Lstr.11:                               ; @0x99
	.asciz	"Versione autovettorizzata"
.Lstr.13:                               ; @0xb3
	.asciz	"Versione vekt-vettorizzata"
.L.str:                                 ; @0xce
	.asciz	"Tempo di esecuzione di vec_sum: %.2fms\n"
.L.str.5:                               ; @0xf6
	.asciz	"Tempo di esecuzione di vectorized_vec_sum: %.2fms\n"
	.section	.vecmem_data,"aw",@progbits
	.align	4
a:                                      ; @0x0
	.skip	32768
	.align	4
b:                                      ; @0x8000
	.skip	32768
	.align	4
c:                                      ; @0x10000
	.skip	32768
	.text
	.global	.CC_I
	.equ	.CC_I, 0
	.ident	"LLVM 17.0.7/V-2024.06. (build 008) (LLVM 17.0.7) -arcv2hs -core4 -Xcode_density -Xatomic -Xll64 -Xunaligned -Xdiv_rem=radix4 -Xswap -Xbitscan -Xmpy_option=mpyd -Xshift_assist -Xbarrel_shifter -Xfpud_div -Xfpu_mac -Xtimer0 -Xrtc -Xstack_check -Xstu=4 -Xvdsp4 -Xvec_unit_rev_minor=1 -Xvec_width=512 -Xvec_mem_size=128k -Xvec_mem_bank_width=16 -Xvec_max_fetch_size=16 -Xvec_num_slots=3 -Xvec_super_with_scalar -Xvec_regs=32 -Xvec_fpu=32 -Xvec_fpu_math=3 -Xvec_fpu_2nd_mul -Xvec_fpu_types=2 -Xvec_num_rd_ports=6 -Xvec_num_acc=8 -Xvec_num_mpy=2 -Xvec_mpy32 -Xvec_num_alu=3 -Xvec_guard_bit_option=0 -Xvec_stack_check -Hvdsp_vector_c -O2 -fvectorize -fslp-vectorize -ffast-math"
	.align	8                               ; -- Begin function main
main:                                   ; @main
                                        ; @0x0
.Lmain$local:                           ; @0x0
	.cfa_bf	.Lmain$local
;  %bb.0:                               ; %entry
	st.aw	%r13,[%sp,-60]                  ; @0x0
	.cfa_push	60                      ; @0x4
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
	st	%r24,[%sp,44]                   ; @0x18
	.cfa_reg_offset	{%r24}, 44              ; @0x1c
	st	%fp,[%sp,48]                    ; @0x1c
	.cfa_reg_offset	{%fp}, 48               ; @0x20
	st	%blink,[%sp,52]                 ; @0x20
	.cfa_reg_offset	{%blink}, 52            ; @0x24
	; Implicit def %r3                      ; @0x24
.vvsbundle  "v1sc" 
 ;	 { 
	vvci.w	%vr0                            ; @0x24
	mov_s	%r13,a                          ; @0x24
 ;	 }
	mov_s	%r18,b                          ; @0x2e
	add2	%r0,%r18,192/4                  ; @0x34
	add2	%r1,%r13,192/4                  ; @0x38
	mov	%lp_count,64                    ; @0x3c
	lp	.LZD0                           ; @0x40
.LBB0_1:                                ; %vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x44
.vvsbundle  " v3" 
 ;	 { 
	vvadd.w	%vr3, %vr0, 17                  ; @0x44
	vvadd.w	%vr2, %vr0, 33                  ; @0x44
	vvadd.w	%vr1, %vr0, 49                  ; @0x44
 ;	 }
.vvsbundle  " v3" 
 ;	 { 
	vvst.av.w	%vr1,%r1,-1             ; @0x50
	vvadd.w	%vr5, %vr0, 113                 ; @0x50
	vvadd.w	%vr4, %vr0, 1                   ; @0x50
 ;	 }
.vvsbundle  " v3" 
 ;	 { 
	vvst.av.w	%vr1,%r0,-1             ; @0x5e
	vvadd.w	%vr6, %vr0, 81                  ; @0x5e
	vvadd.w	%vr1, %vr0, 97                  ; @0x5e
 ;	 }
.vvsbundle  " v3" 
 ;	 { 
	vvst.av.w	%vr2,%r1,-1             ; @0x6e
	vvadd.w	%vr0, %vr0, 128                 ; @0x6e
	vvadd.w	%vr7, %vr0, 65                  ; @0x6e
 ;	 }
	vvst.av.w	%vr2,%r0,-1             ; @0x7e
	vvst.av.w	%vr3,%r1,-1             ; @0x84
	vvst.av.w	%vr3,%r0,-1             ; @0x8a
	vvst.av.w	%vr4,%r1,7              ; @0x90
	vvst.av.w	%vr4,%r0,7              ; @0x96
	vvst.av.w	%vr5,%r1,-1             ; @0x9c
	vvst.av.w	%vr5,%r0,-1             ; @0xa2
	vvst.av.w	%vr1,%r1,-1             ; @0xa8
	vvst.av.w	%vr1,%r0,-1             ; @0xae
	vvst.av.w	%vr6,%r1,-1             ; @0xb4
	vvst.av.w	%vr6,%r0,-1             ; @0xba
	vvst.av.w	%vr7,%r1,7              ; @0xc0
	vvst.av.w	%vr7,%r0,7              ; @0xc6
.LZD0:                                  ; @0xcc
	; ZD Loop End                           ; @0xcc
;  %bb.2:                               ; %for.cond.cleanup
	mov_s	%r19,c                          ; @0xcc
	mov_s	%r24,0x2000@u32                 ; @0xd2
	mov_s	%r0,%r19                        ; @0xd8
	mov_s	%r1,%r24                        ; @0xda
	mov_s	%r2,-1                          ; @0xdc
	bl	init_vector                     ; @0xde
	bl	clock                           ; @0xe2
	mov_s	%r14,%r0                        ; @0xe6
	mov_s	%r0,%r13                        ; @0xe8
	mov_s	%r1,%r18                        ; @0xea
	mov_s	%r2,%r19                        ; @0xec
	mov_s	%r3,%r24                        ; @0xee
	bl	vec_sum                         ; @0xf0
	mov_s	%r21,0x408f4000@u32             ; @0xf4
	mov_s	%r20,0                          ; @0xfa
	bl	clock                           ; @0xfc
	sub_s	%r0,%r0,%r14                    ; @0x100
	fint2d	%r2,%r0                         ; @0x102
	fdmul	%r14,%r2,%r20                   ; @0x106
	bl	_timer_clocks_per_sec           ; @0x10a
	fuint2d	%r2,%r0                         ; @0x10e
	fddiv	%r22,%r14,%r2                   ; @0x112
	mov_s	%fp,.L.str                      ; @0x116
	mov_s	%r0,%fp                         ; @0x11c
	mov_s	%r1,%r22                        ; @0x11e
	mov_s	%r2,%r23                        ; @0x120
	bl	printf                          ; @0x122
	mov_s	%r16,.L.str.6                   ; @0x126
	sub	%r0,%r16,.L.str.6-.Lstr.14      ; @0x12c
	sub	%r1,%r16,.L.str.6-.Lstr.14      ; @0x130
	st	%r1,[%sp,56]                    ; 4-byte Folded Spill
                                        ; @0x134
	bl	puts                            ; @0x138
	ld_s	%r2,[%r13,0]                    ; @0x13c
	ld	%r4,[%r18,0]                    ; @0x13e
	ld	%r6,[%r19,0]                    ; @0x142
	sub	%r17,%r16,.L.str.6-.L.str.2     ; @0x146
	mov_s	%r0,%r17                        ; @0x14a
	mov_s	%r1,0                           ; @0x14c
	mov_s	%r3,0                           ; @0x14e
	mov_s	%r5,0                           ; @0x150
	bl	printf                          ; @0x152
	ld_s	%r2,[%r13,4]                    ; @0x156
	ld	%r4,[%r18,4]                    ; @0x158
	ld	%r6,[%r19,4]                    ; @0x15c
	mov_s	%r0,%r17                        ; @0x160
	mov_s	%r1,1                           ; @0x162
	mov_s	%r3,1                           ; @0x164
	mov_s	%r5,1                           ; @0x166
	bl	printf                          ; @0x168
	ld_s	%r2,[%r13,8]                    ; @0x16c
	ld	%r4,[%r18,8]                    ; @0x16e
	ld	%r6,[%r19,8]                    ; @0x172
	mov_s	%r0,%r17                        ; @0x176
	mov_s	%r1,2                           ; @0x178
	mov_s	%r3,2                           ; @0x17a
	mov_s	%r5,2                           ; @0x17c
	bl	printf                          ; @0x17e
	ld_s	%r2,[%r13,12]                   ; @0x182
	ld	%r4,[%r18,12]                   ; @0x184
	ld	%r6,[%r19,12]                   ; @0x188
	mov_s	%r0,%r17                        ; @0x18c
	mov_s	%r1,3                           ; @0x18e
	mov_s	%r3,3                           ; @0x190
	mov_s	%r5,3                           ; @0x192
	bl	printf                          ; @0x194
	ld_s	%r2,[%r13,16]                   ; @0x198
	ld	%r4,[%r18,16]                   ; @0x19a
	ld	%r6,[%r19,16]                   ; @0x19e
	mov_s	%r0,%r17                        ; @0x1a2
	mov_s	%r1,4                           ; @0x1a4
	mov_s	%r3,4                           ; @0x1a6
	mov_s	%r5,4                           ; @0x1a8
	bl	printf                          ; @0x1aa
	mov_s	%r0,10                          ; @0x1ae
	bl	putchar                         ; @0x1b0
	mov_s	%r0,%r16                        ; @0x1b4
	mov_s	%r1,16                          ; @0x1b6
	add	%r0,%r0,.L.str.4-.L.str.6       ; @0x1b8
	bl	printf                          ; @0x1bc
	mov_s	%r0,%r19                        ; @0x1c0
	mov_s	%r1,%r24                        ; @0x1c2
	mov_s	%r2,-1                          ; @0x1c4
	bl	init_vector                     ; @0x1c6
	bl	clock                           ; @0x1ca
	mov_s	%r15,%r0                        ; @0x1ce
	mov_s	%r0,%r13                        ; @0x1d0
	mov_s	%r1,%r18                        ; @0x1d2
	mov_s	%r2,%r19                        ; @0x1d4
	mov_s	%r3,%r24                        ; @0x1d6
	bl.d	vectorized_vec_sum              ; @0x1d8
	nop                                     ; inserted to benefit BPU
                                        ; @0x1dc
	bl	clock                           ; @0x1e0
	sub_s	%r0,%r0,%r15                    ; @0x1e4
	fint2d	%r2,%r0                         ; @0x1e6
	fdmul	%r14,%r2,%r20                   ; @0x1ea
	bl	_timer_clocks_per_sec           ; @0x1ee
	fuint2d	%r2,%r0                         ; @0x1f2
	fddiv	%r14,%r14,%r2                   ; @0x1f6
	add	%r0,%fp,.L.str.5-.L.str         ; @0x1fa
	mov_s	%r1,%r14                        ; @0x1fe
	mov_s	%r2,%r15                        ; @0x200
	bl	printf                          ; @0x202
	fddiv	%r2,%r22,%r14                   ; @0x206
	mov_s	%r0,%r16                        ; @0x20a
	mov_s	%r1,%r2                         ; @0x20c
	mov_s	%r2,%r3                         ; @0x20e
	bl	printf                          ; @0x210
	sub	%r0,%r16,.L.str.6-.Lstr.14      ; @0x214
	bl	puts                            ; @0x218
	ld_s	%r2,[%r13,0]                    ; @0x21c
	ld	%r4,[%r18,0]                    ; @0x21e
	ld	%r6,[%r19,0]                    ; @0x222
	mov_s	%r0,%r17                        ; @0x226
	mov_s	%r1,0                           ; @0x228
	mov_s	%r3,0                           ; @0x22a
	mov_s	%r5,0                           ; @0x22c
	bl	printf                          ; @0x22e
	ld_s	%r2,[%r13,4]                    ; @0x232
	ld	%r4,[%r18,4]                    ; @0x234
	ld	%r6,[%r19,4]                    ; @0x238
	mov_s	%r0,%r17                        ; @0x23c
	mov_s	%r1,1                           ; @0x23e
	mov_s	%r3,1                           ; @0x240
	mov_s	%r5,1                           ; @0x242
	bl	printf                          ; @0x244
	ld_s	%r2,[%r13,8]                    ; @0x248
	ld	%r4,[%r18,8]                    ; @0x24a
	ld	%r6,[%r19,8]                    ; @0x24e
	mov_s	%r0,%r17                        ; @0x252
	mov_s	%r1,2                           ; @0x254
	mov_s	%r3,2                           ; @0x256
	mov_s	%r5,2                           ; @0x258
	bl	printf                          ; @0x25a
	ld_s	%r2,[%r13,12]                   ; @0x25e
	ld	%r4,[%r18,12]                   ; @0x260
	ld	%r6,[%r19,12]                   ; @0x264
	mov_s	%r0,%r17                        ; @0x268
	mov_s	%r1,3                           ; @0x26a
	mov_s	%r3,3                           ; @0x26c
	mov_s	%r5,3                           ; @0x26e
	bl	printf                          ; @0x270
	ld_s	%r2,[%r13,16]                   ; @0x274
	ld	%r4,[%r18,16]                   ; @0x276
	ld	%r6,[%r19,16]                   ; @0x27a
	mov_s	%r0,%r17                        ; @0x27e
	mov_s	%r1,4                           ; @0x280
	mov_s	%r3,4                           ; @0x282
	mov_s	%r5,4                           ; @0x284
	bl	printf                          ; @0x286
	mov_s	%r0,10                          ; @0x28a
	bl	putchar                         ; @0x28c
	sub	%r0,%fp,.L.str-.Lstr.11         ; @0x290
	bl	puts                            ; @0x294
	mov_s	%r0,%r19                        ; @0x298
	mov_s	%r1,%r24                        ; @0x29a
	mov_s	%r2,-1                          ; @0x29c
	bl	init_vector                     ; @0x29e
	bl	clock                           ; @0x2a2
	mov_s	%r15,%r0                        ; @0x2a6
	mov_s	%r0,%r13                        ; @0x2a8
	mov_s	%r1,%r18                        ; @0x2aa
	mov_s	%r2,%r19                        ; @0x2ac
	mov_s	%r3,%r24                        ; @0x2ae
	bl.d	autovectorized_vec_sum          ; @0x2b0
	nop                                     ; inserted to benefit BPU
                                        ; @0x2b4
	bl	clock                           ; @0x2b8
	sub_s	%r0,%r0,%r15                    ; @0x2bc
	fint2d	%r2,%r0                         ; @0x2be
	fdmul	%r14,%r2,%r20                   ; @0x2c2
	bl	_timer_clocks_per_sec           ; @0x2c6
	fuint2d	%r2,%r0                         ; @0x2ca
	fddiv	%r14,%r14,%r2                   ; @0x2ce
	add	%fp,%r16,.L.str.8-.L.str.6      ; @0x2d2
	mov_s	%r0,%fp                         ; @0x2d6
	mov_s	%r1,%r14                        ; @0x2d8
	mov_s	%r2,%r15                        ; @0x2da
	bl	printf                          ; @0x2dc
	fddiv	%r2,%r22,%r14                   ; @0x2e0
	mov_s	%r0,%r16                        ; @0x2e4
	mov_s	%r1,%r2                         ; @0x2e6
	mov_s	%r2,%r3                         ; @0x2e8
	bl	printf                          ; @0x2ea
	sub	%r0,%r16,.L.str.6-.Lstr.14      ; @0x2ee
	bl	puts                            ; @0x2f2
	ld_s	%r2,[%r13,0]                    ; @0x2f6
	ld	%r4,[%r18,0]                    ; @0x2f8
	ld	%r6,[%r19,0]                    ; @0x2fc
	mov_s	%r0,%r17                        ; @0x300
	mov_s	%r1,0                           ; @0x302
	mov_s	%r3,0                           ; @0x304
	mov_s	%r5,0                           ; @0x306
	bl	printf                          ; @0x308
	ld_s	%r2,[%r13,4]                    ; @0x30c
	ld	%r4,[%r18,4]                    ; @0x30e
	ld	%r6,[%r19,4]                    ; @0x312
	mov_s	%r0,%r17                        ; @0x316
	mov_s	%r1,1                           ; @0x318
	mov_s	%r3,1                           ; @0x31a
	mov_s	%r5,1                           ; @0x31c
	bl	printf                          ; @0x31e
	ld_s	%r2,[%r13,8]                    ; @0x322
	ld	%r4,[%r18,8]                    ; @0x324
	ld	%r6,[%r19,8]                    ; @0x328
	mov_s	%r0,%r17                        ; @0x32c
	mov_s	%r1,2                           ; @0x32e
	mov_s	%r3,2                           ; @0x330
	mov_s	%r5,2                           ; @0x332
	bl	printf                          ; @0x334
	ld_s	%r2,[%r13,12]                   ; @0x338
	ld	%r4,[%r18,12]                   ; @0x33a
	ld	%r6,[%r19,12]                   ; @0x33e
	mov_s	%r0,%r17                        ; @0x342
	mov_s	%r1,3                           ; @0x344
	mov_s	%r3,3                           ; @0x346
	mov_s	%r5,3                           ; @0x348
	bl	printf                          ; @0x34a
	ld_s	%r2,[%r13,16]                   ; @0x34e
	ld	%r4,[%r18,16]                   ; @0x350
	ld	%r6,[%r19,16]                   ; @0x354
	mov_s	%r0,%r17                        ; @0x358
	mov_s	%r1,4                           ; @0x35a
	mov_s	%r3,4                           ; @0x35c
	mov_s	%r5,4                           ; @0x35e
	bl	printf                          ; @0x360
	mov	%r0,10                          ; widened to benefit BPU
                                        ; @0x364
	bl	putchar                         ; @0x368
	mov_s	%r0,.Lstr.13                    ; @0x36c
	bl	puts                            ; @0x372
	mov_s	%r0,%r19                        ; @0x376
	mov_s	%r1,%r24                        ; @0x378
	mov_s	%r2,-1                          ; @0x37a
	bl	init_vector                     ; @0x37c
	bl	clock                           ; @0x380
	mov_s	%r14,%r0                        ; @0x384
	mov_s	%r0,%r13                        ; @0x386
	mov_s	%r1,%r18                        ; @0x388
	mov_s	%r2,%r19                        ; @0x38a
	mov_s	%r3,%r24                        ; @0x38c
	bl	vekt_vec_sum_wrapper            ; @0x38e
	bl	clock                           ; @0x392
	sub_s	%r0,%r0,%r14                    ; @0x396
	fint2d	%r2,%r0                         ; @0x398
	fdmul	%r14,%r2,%r20                   ; @0x39c
	bl	_timer_clocks_per_sec           ; @0x3a0
	fuint2d	%r2,%r0                         ; @0x3a4
	fddiv	%r14,%r14,%r2                   ; @0x3a8
	mov_s	%r0,%fp                         ; @0x3ac
	mov_s	%r1,%r14                        ; @0x3ae
	mov_s	%r2,%r15                        ; @0x3b0
	bl	printf                          ; @0x3b2
	fddiv	%r2,%r22,%r14                   ; @0x3b6
	mov_s	%r0,%r16                        ; @0x3ba
	mov_s	%r1,%r2                         ; @0x3bc
	mov_s	%r2,%r3                         ; @0x3be
	bl	printf                          ; @0x3c0
	ld	%r0,[%sp,56]                    ; 4-byte Folded Reload
                                        ; widened to benefit BPU
                                        ; @0x3c4
	bl	puts                            ; @0x3c8
	ld_s	%r2,[%r13,0]                    ; @0x3cc
	ld	%r4,[%r18,0]                    ; @0x3ce
	ld	%r6,[%r19,0]                    ; @0x3d2
	mov_s	%r0,%r17                        ; @0x3d6
	mov_s	%r1,0                           ; @0x3d8
	mov_s	%r3,0                           ; @0x3da
	mov_s	%r5,0                           ; @0x3dc
	bl	printf                          ; @0x3de
	ld_s	%r2,[%r13,4]                    ; @0x3e2
	ld	%r4,[%r18,4]                    ; @0x3e4
	ld	%r6,[%r19,4]                    ; @0x3e8
	mov_s	%r0,%r17                        ; @0x3ec
	mov_s	%r1,1                           ; @0x3ee
	mov_s	%r3,1                           ; @0x3f0
	mov_s	%r5,1                           ; @0x3f2
	bl	printf                          ; @0x3f4
	ld_s	%r2,[%r13,8]                    ; @0x3f8
	ld	%r4,[%r18,8]                    ; @0x3fa
	ld	%r6,[%r19,8]                    ; @0x3fe
	mov_s	%r0,%r17                        ; @0x402
	mov_s	%r1,2                           ; @0x404
	mov_s	%r3,2                           ; @0x406
	mov_s	%r5,2                           ; @0x408
	bl	printf                          ; @0x40a
	ld_s	%r2,[%r13,12]                   ; @0x40e
	ld	%r4,[%r18,12]                   ; @0x410
	ld	%r6,[%r19,12]                   ; @0x414
	mov_s	%r0,%r17                        ; @0x418
	mov_s	%r1,3                           ; @0x41a
	mov_s	%r3,3                           ; @0x41c
	mov_s	%r5,3                           ; @0x41e
	bl	printf                          ; @0x420
	ld_s	%r2,[%r13,16]                   ; @0x424
	ld	%r4,[%r18,16]                   ; @0x426
	ld	%r6,[%r19,16]                   ; @0x42a
	mov_s	%r0,%r17                        ; @0x42e
	mov_s	%r1,4                           ; @0x430
	mov_s	%r3,4                           ; @0x432
	mov_s	%r5,4                           ; @0x434
	bl	printf                          ; @0x436
	mov_s	%r0,0                           ; @0x43a
	ld	%blink,[%sp,52]                 ; @0x43c
	.cfa_restore	{%blink}                ; @0x440
	ld	%fp,[%sp,48]                    ; @0x440
	.cfa_restore	{%fp}                   ; @0x444
	ld	%r24,[%sp,44]                   ; @0x444
	.cfa_restore	{%r24}                  ; @0x448
	ldd	%r22,[%sp,36]                   ; @0x448
	.cfa_restore	{%r23}                  ; @0x44c
	.cfa_restore	{%r22}                  ; @0x44c
	ldd	%r20,[%sp,28]                   ; @0x44c
	.cfa_restore	{%r21}                  ; @0x450
	.cfa_restore	{%r20}                  ; @0x450
	ldd	%r18,[%sp,20]                   ; @0x450
	.cfa_restore	{%r19}                  ; @0x454
	.cfa_restore	{%r18}                  ; @0x454
	ldd	%r16,[%sp,12]                   ; @0x454
	.cfa_restore	{%r17}                  ; @0x458
	.cfa_restore	{%r16}                  ; @0x458
	ldd	%r14,[%sp,4]                    ; @0x458
	.cfa_restore	{%r15}                  ; @0x45c
	.cfa_restore	{%r14}                  ; @0x45c
	ld.ab	%r13,[%sp,60]                   ; @0x45c
	.cfa_restore	{%r13}                  ; @0x460
	.cfa_pop	60                              ; @0x460
	j_s	[%blink]                        ; @0x460
	.cfa_ef
.Lfunc_end0:                            ; @0x462

	.reloc	_init_ad,0	;startup code to enable %status AD bit ; -- End function
