	.option	%reg
	.off	assume_short
	.file	"main.c"
	.size	.L.str.5, 30
	.type	.L.str.5,@object
	.size	.Lstr.15, 30
	.type	.Lstr.15,@object
	.size	.L.str.9, 15
	.type	.L.str.9,@object
	.size	.L.str.1, 6
	.type	.L.str.1,@object
	.size	.L.str.7, 23
	.type	.L.str.7,@object
	.size	.Lstr.14, 26
	.type	.Lstr.14,@object
	.size	.Lstr, 39
	.type	.Lstr,@object
	.size	.L.str.3, 40
	.type	.L.str.3,@object
	.size	.L.str.8, 51
	.type	.L.str.8,@object
	.size	.L.str.11, 55
	.type	.L.str.11,@object
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
.L.str.5:                               ; @0x0
	.asciz	"a[%d]=%d, b[%d]=%d, c[%d]=%d\n"
.Lstr.15:                               ; @0x1e
	.asciz	"Primi 5 elementi della somma:"
.L.str.9:                               ; @0x3c
	.asciz	"Speedup: %.2f\n"
.L.str.1:                               ; @0x4b
	.asciz	"hello"
.L.str.7:                               ; @0x51
	.asciz	"Vettorizzo su %d lane\n"
.Lstr.14:                               ; @0x68
	.asciz	"Versione autovettorizzata"
.Lstr:                                  ; @0x82
	.asciz	"Errore nell'allocazione della memoria."
.L.str.3:                               ; @0xa9
	.asciz	"Tempo di esecuzione di vec_sum: %.2fms\n"
.L.str.8:                               ; @0xd1
	.asciz	"Tempo di esecuzione di vectorized_vec_sum: %.2fms\n"
.L.str.11:                              ; @0x104
	.asciz	"Tempo di esecuzione di autovectorized_vec_sum: %.2fms\n"
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
	sub3	%r56,%r56,12288/8               ; @0x1c
	mov_s	%r13,.L.str.9                   ; @0x20
	add_s	%r0,%r13,.L.str.1-.L.str.9      ; @0x26
	bl	puts                            ; @0x28
	add	%r1,%r56,0x2000@u32             ; @0x2c
	cmp_s	%r1,0                           ; @0x34
	beq	.LBB0_5                         ; @0x36
;  %bb.1:                               ; %entry
	add	%r0,%r56,0x1000@u32             ; @0x3a
	cmp_s	%r0,0                           ; @0x42
	add	%r2,%r56,0                      ; @0x44
	cmp.ne	%r2,0                           ; Predicate Case 4
                                        ; @0x48
	beq	.LBB0_5                         ; Predicate Case 4
                                        ; @0x4c
;  %bb.3:                               ; %vector.body.preheader
	; Implicit def %r3                      ; @0x50
.vvsbundle  "v1sc" 
 ;	 { 
	vvci.w	%vr0                            ; @0x50
	add2	%r0,%r0,192/4                   ; @0x50
 ;	 }
	add2	%r1,%r1,192/4                   ; @0x58
	mov	%lp_count,8                     ; @0x5c
	lp	.LZD0                           ; @0x60
.LBB0_4:                                ; %vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x64
.vvsbundle  " v3" 
 ;	 { 
	vvadd.w	%vr3, %vr0, 17                  ; @0x64
	vvadd.w	%vr2, %vr0, 33                  ; @0x64
	vvadd.w	%vr1, %vr0, 49                  ; @0x64
 ;	 }
.vvsbundle  " v3" 
 ;	 { 
	vvst.av.w	%vr1,%r1,-1             ; @0x70
	vvadd.w	%vr5, %vr0, 113                 ; @0x70
	vvadd.w	%vr4, %vr0, 1                   ; @0x70
 ;	 }
.vvsbundle  " v3" 
 ;	 { 
	vvst.av.w	%vr1,%r0,-1             ; @0x7e
	vvadd.w	%vr6, %vr0, 81                  ; @0x7e
	vvadd.w	%vr1, %vr0, 97                  ; @0x7e
 ;	 }
.vvsbundle  " v3" 
 ;	 { 
	vvst.av.w	%vr2,%r1,-1             ; @0x8e
	vvadd.w	%vr0, %vr0, 128                 ; @0x8e
	vvadd.w	%vr7, %vr0, 65                  ; @0x8e
 ;	 }
	vvst.av.w	%vr2,%r0,-1             ; @0x9e
	vvst.av.w	%vr3,%r1,-1             ; @0xa4
	vvst.av.w	%vr3,%r0,-1             ; @0xaa
	vvst.av.w	%vr4,%r1,7              ; @0xb0
	vvst.av.w	%vr4,%r0,7              ; @0xb6
	vvst.av.w	%vr5,%r1,-1             ; @0xbc
	vvst.av.w	%vr5,%r0,-1             ; @0xc2
	vvst.av.w	%vr1,%r1,-1             ; @0xc8
	vvst.av.w	%vr1,%r0,-1             ; @0xce
	vvst.av.w	%vr6,%r1,-1             ; @0xd4
	vvst.av.w	%vr6,%r0,-1             ; @0xda
	vvst.av.w	%vr7,%r1,7              ; @0xe0
	vvst.av.w	%vr7,%r0,7              ; @0xe6
.LZD0:                                  ; @0xec
	; ZD Loop End                           ; @0xec
;  %bb.6:                               ; %for.cond.cleanup
	nop                                     ; inserted to benefit BPU
                                        ; @0xec
	bl	clock                           ; @0xf0
	mov_s	%r14,%r0                        ; @0xf4
	add	%r0,%r56,0x2000@u32             ; @0xf6
	add	%r1,%r56,0x1000@u32             ; @0xfe
	add	%r2,%r56,0                      ; @0x106
	mov	%r3,1024                        ; @0x10a
	bl	vec_sum                         ; @0x10e
	mov_s	%r17,0x408f4000@u32             ; @0x112
	mov_s	%r16,0                          ; @0x118
	bl	clock                           ; @0x11a
	sub_s	%r0,%r0,%r14                    ; @0x11e
	fint2d	%r2,%r0                         ; @0x120
	fdmul	%r14,%r2,%r16                   ; @0x124
	bl	_timer_clocks_per_sec           ; @0x128
	fuint2d	%r2,%r0                         ; @0x12c
	fddiv	%r20,%r14,%r2                   ; @0x130
	mov_s	%r19,.L.str.8                   ; @0x134
	sub	%r0,%r19,.L.str.8-.L.str.3      ; @0x13a
	mov_s	%r1,%r20                        ; @0x13e
	mov_s	%r2,%r21                        ; @0x140
	bl	printf                          ; @0x142
	sub	%r18,%r13,.L.str.9-.Lstr.15     ; @0x146
	mov_s	%r0,%r18                        ; @0x14a
	bl	puts                            ; @0x14c
	ld	%r4,[%r56,4096]                 ; @0x150
	ld	%r6,[%r56,0]                    ; @0x158
	ld	%r2,[%r56,8192]                 ; @0x15c
	sub	%r14,%r13,.L.str.9-.L.str.5     ; @0x164
	mov_s	%r0,%r14                        ; @0x168
	mov_s	%r1,0                           ; @0x16a
	mov_s	%r3,0                           ; @0x16c
	mov_s	%r5,0                           ; @0x16e
	bl	printf                          ; @0x170
	ld	%r4,[%r56,4100]                 ; @0x174
	ld	%r6,[%r56,4]                    ; @0x17c
	ld	%r2,[%r56,8196]                 ; @0x180
	mov_s	%r0,%r14                        ; @0x188
	mov_s	%r1,1                           ; @0x18a
	mov_s	%r3,1                           ; @0x18c
	mov_s	%r5,1                           ; @0x18e
	bl	printf                          ; @0x190
	ld	%r4,[%r56,4104]                 ; @0x194
	ld	%r6,[%r56,8]                    ; @0x19c
	ld	%r2,[%r56,8200]                 ; @0x1a0
	mov_s	%r0,%r14                        ; @0x1a8
	mov_s	%r1,2                           ; @0x1aa
	mov_s	%r3,2                           ; @0x1ac
	mov_s	%r5,2                           ; @0x1ae
	bl	printf                          ; @0x1b0
	ld	%r4,[%r56,4108]                 ; @0x1b4
	ld	%r6,[%r56,12]                   ; @0x1bc
	ld	%r2,[%r56,8204]                 ; @0x1c0
	mov_s	%r0,%r14                        ; @0x1c8
	mov_s	%r1,3                           ; @0x1ca
	mov_s	%r3,3                           ; @0x1cc
	mov_s	%r5,3                           ; @0x1ce
	bl	printf                          ; @0x1d0
	ld	%r4,[%r56,4112]                 ; @0x1d4
	ld	%r6,[%r56,16]                   ; @0x1dc
	ld	%r2,[%r56,8208]                 ; @0x1e0
	mov_s	%r0,%r14                        ; @0x1e8
	mov_s	%r1,4                           ; @0x1ea
	mov_s	%r3,4                           ; @0x1ec
	mov_s	%r5,4                           ; @0x1ee
	bl	printf                          ; @0x1f0
	mov	%r0,10                          ; widened to benefit BPU
                                        ; @0x1f4
	bl	putchar                         ; @0x1f8
	add_s	%r0,%r13,.L.str.7-.L.str.9      ; @0x1fc
	mov_s	%r1,16                          ; @0x1fe
	bl.d	printf                          ; @0x200
	nop                                     ; inserted to benefit BPU
                                        ; @0x204
	bl	clock                           ; @0x208
	mov_s	%r15,%r0                        ; @0x20c
	add	%r0,%r56,0x2000@u32             ; @0x20e
	add	%r1,%r56,0x1000@u32             ; @0x216
	add	%r2,%r56,0                      ; @0x21e
	mov	%r3,1024                        ; @0x222
	bl	vectorized_vec_sum              ; @0x226
	bl	clock                           ; @0x22a
	sub_s	%r0,%r0,%r15                    ; @0x22e
	fint2d	%r2,%r0                         ; @0x230
	fdmul	%r22,%r2,%r16                   ; @0x234
	bl	_timer_clocks_per_sec           ; @0x238
	fuint2d	%r2,%r0                         ; @0x23c
	fddiv	%r22,%r22,%r2                   ; @0x240
	mov_s	%r0,%r19                        ; @0x244
	mov_s	%r1,%r22                        ; @0x246
	mov_s	%r2,%r23                        ; @0x248
	bl	printf                          ; @0x24a
	fddiv	%r2,%r20,%r22                   ; @0x24e
	mov_s	%r0,%r13                        ; @0x252
	mov_s	%r1,%r2                         ; @0x254
	mov_s	%r2,%r3                         ; @0x256
	bl	printf                          ; @0x258
	mov	%r0,%r18                        ; widened to benefit BPU
                                        ; @0x25c
	bl	puts                            ; @0x260
	ld	%r4,[%r56,4096]                 ; @0x264
	ld	%r6,[%r56,0]                    ; @0x26c
	ld	%r2,[%r56,8192]                 ; @0x270
	mov_s	%r0,%r14                        ; @0x278
	mov_s	%r1,0                           ; @0x27a
	mov_s	%r3,0                           ; @0x27c
	mov_s	%r5,0                           ; @0x27e
	bl	printf                          ; @0x280
	ld	%r4,[%r56,4100]                 ; @0x284
	ld	%r6,[%r56,4]                    ; @0x28c
	ld	%r2,[%r56,8196]                 ; @0x290
	mov_s	%r0,%r14                        ; @0x298
	mov_s	%r1,1                           ; @0x29a
	mov_s	%r3,1                           ; @0x29c
	mov_s	%r5,1                           ; @0x29e
	bl	printf                          ; @0x2a0
	ld	%r4,[%r56,4104]                 ; @0x2a4
	ld	%r6,[%r56,8]                    ; @0x2ac
	ld	%r2,[%r56,8200]                 ; @0x2b0
	mov_s	%r0,%r14                        ; @0x2b8
	mov_s	%r1,2                           ; @0x2ba
	mov_s	%r3,2                           ; @0x2bc
	mov_s	%r5,2                           ; @0x2be
	bl	printf                          ; @0x2c0
	ld	%r4,[%r56,4108]                 ; @0x2c4
	ld	%r6,[%r56,12]                   ; @0x2cc
	ld	%r2,[%r56,8204]                 ; @0x2d0
	mov_s	%r0,%r14                        ; @0x2d8
	mov_s	%r1,3                           ; @0x2da
	mov_s	%r3,3                           ; @0x2dc
	mov_s	%r5,3                           ; @0x2de
	bl	printf                          ; @0x2e0
	ld	%r4,[%r56,4112]                 ; @0x2e4
	ld	%r6,[%r56,16]                   ; @0x2ec
	ld	%r2,[%r56,8208]                 ; @0x2f0
	mov_s	%r0,%r14                        ; @0x2f8
	mov_s	%r1,4                           ; @0x2fa
	mov_s	%r3,4                           ; @0x2fc
	mov_s	%r5,4                           ; @0x2fe
	bl	printf                          ; @0x300
	add	%r0,%r13,.Lstr.14-.L.str.9      ; widened to benefit BPU
                                        ; @0x304
	bl.d	puts                            ; @0x308
	nop                                     ; inserted to benefit BPU
                                        ; @0x30c
	bl	clock                           ; @0x310
	mov_s	%r15,%r0                        ; @0x314
	add	%r0,%r56,0x2000@u32             ; @0x316
	add	%r1,%r56,0x1000@u32             ; @0x31e
	add	%r2,%r56,0                      ; @0x326
	mov	%r3,1024                        ; @0x32a
	bl	autovectorized_vec_sum          ; @0x32e
	bl	clock                           ; @0x332
	sub_s	%r0,%r0,%r15                    ; @0x336
	fint2d	%r2,%r0                         ; @0x338
	fdmul	%r22,%r2,%r16                   ; @0x33c
	bl	_timer_clocks_per_sec           ; @0x340
	fuint2d	%r2,%r0                         ; @0x344
	fddiv	%r22,%r22,%r2                   ; @0x348
	add	%r0,%r19,.L.str.11-.L.str.8     ; @0x34c
	mov_s	%r1,%r22                        ; @0x350
	mov_s	%r2,%r23                        ; @0x352
	bl	printf                          ; @0x354
	fddiv	%r2,%r20,%r22                   ; @0x358
	mov_s	%r0,%r13                        ; @0x35c
	mov_s	%r1,%r2                         ; @0x35e
	mov_s	%r2,%r3                         ; @0x360
	bl	printf                          ; @0x362
	mov_s	%r0,%r18                        ; @0x366
	bl	puts                            ; @0x368
	ld	%r4,[%r56,4096]                 ; @0x36c
	ld	%r6,[%r56,0]                    ; @0x374
	ld	%r2,[%r56,8192]                 ; @0x378
	mov_s	%r0,%r14                        ; @0x380
	mov_s	%r1,0                           ; @0x382
	mov_s	%r3,0                           ; @0x384
	mov_s	%r5,0                           ; @0x386
	bl	printf                          ; @0x388
	ld	%r4,[%r56,4100]                 ; @0x38c
	ld	%r6,[%r56,4]                    ; @0x394
	ld	%r2,[%r56,8196]                 ; @0x398
	mov_s	%r0,%r14                        ; @0x3a0
	mov_s	%r1,1                           ; @0x3a2
	mov_s	%r3,1                           ; @0x3a4
	mov_s	%r5,1                           ; @0x3a6
	bl	printf                          ; @0x3a8
	ld	%r4,[%r56,4104]                 ; @0x3ac
	ld	%r6,[%r56,8]                    ; @0x3b4
	ld	%r2,[%r56,8200]                 ; @0x3b8
	mov_s	%r0,%r14                        ; @0x3c0
	mov_s	%r1,2                           ; @0x3c2
	mov_s	%r3,2                           ; @0x3c4
	mov_s	%r5,2                           ; @0x3c6
	bl	printf                          ; @0x3c8
	ld	%r4,[%r56,4108]                 ; @0x3cc
	ld	%r6,[%r56,12]                   ; @0x3d4
	ld	%r2,[%r56,8204]                 ; @0x3d8
	mov_s	%r0,%r14                        ; @0x3e0
	mov_s	%r1,3                           ; @0x3e2
	mov_s	%r3,3                           ; @0x3e4
	mov_s	%r5,3                           ; @0x3e6
	bl	printf                          ; @0x3e8
	ld	%r4,[%r56,4112]                 ; @0x3ec
	ld	%r6,[%r56,16]                   ; @0x3f4
	ld	%r2,[%r56,8208]                 ; @0x3f8
	mov_s	%r0,%r14                        ; @0x400
	mov_s	%r1,4                           ; @0x402
	mov_s	%r3,4                           ; @0x404
	mov_s	%r5,4                           ; @0x406
	bl.d	printf                          ; @0x408
	nop                                     ; inserted to benefit BPU
                                        ; @0x40c
	b	.LBB0_7                         ; widened to benefit BPU
                                        ; @0x410
.LBB0_5:                                ; %if.then
                                        ; @0x414
	add	%r13,%r13,.Lstr-.L.str.9        ; @0x414
	mov_s	%r0,%r13                        ; @0x418
	bl	puts                            ; @0x41a
	mov_s	%r16,1                          ; @0x41e
.LBB0_7:                                ; %cleanup
                                        ; @0x420
	mov_s	%r0,%r16                        ; @0x420
	add3	%r56,%r56,12288/8               ; @0x422
	ld	%blink,[%sp,44]                 ; @0x426
	.cfa_restore	{%blink}                ; @0x42a
	ldd	%r22,[%sp,36]                   ; @0x42a
	.cfa_restore	{%r23}                  ; @0x42e
	.cfa_restore	{%r22}                  ; @0x42e
	ldd	%r20,[%sp,28]                   ; @0x42e
	.cfa_restore	{%r21}                  ; @0x432
	.cfa_restore	{%r20}                  ; @0x432
	ldd	%r18,[%sp,20]                   ; @0x432
	.cfa_restore	{%r19}                  ; @0x436
	.cfa_restore	{%r18}                  ; @0x436
	ldd	%r16,[%sp,12]                   ; @0x436
	.cfa_restore	{%r17}                  ; @0x43a
	.cfa_restore	{%r16}                  ; @0x43a
	ldd	%r14,[%sp,4]                    ; @0x43a
	.cfa_restore	{%r15}                  ; @0x43e
	.cfa_restore	{%r14}                  ; @0x43e
	ld.ab	%r13,[%sp,48]                   ; @0x43e
	.cfa_restore	{%r13}                  ; @0x442
	.cfa_pop	48                              ; @0x442
	j_s	[%blink]                        ; @0x442
	.cfa_ef
.Lfunc_end0:                            ; @0x444

	.reloc	_init_ad,0	;startup code to enable %status AD bit ; -- End function
