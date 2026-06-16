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
	.ident	"LLVM 17.0.7/V-2024.06. (build 008) (LLVM 17.0.7) -arcv2hs -core4 -Xcode_density -Xatomic -Xll64 -Xunaligned -Xdiv_rem=radix4 -Xswap -Xbitscan -Xmpy_option=mpyd -Xshift_assist -Xbarrel_shifter -Xfpud_div -Xfpu_mac -Xtimer0 -Xrtc -Xstack_check -Xstu=4 -Xvdsp4 -Xvec_unit_rev_minor=1 -Xvec_width=512 -Xvec_mem_size=128k -Xvec_mem_bank_width=16 -Xvec_max_fetch_size=16 -Xvec_num_slots=3 -Xvec_super_with_scalar -Xvec_regs=32 -Xvec_fpu=32 -Xvec_fpu_math=3 -Xvec_fpu_2nd_mul -Xvec_fpu_types=2 -Xvec_num_rd_ports=6 -Xvec_num_acc=8 -Xvec_num_mpy=2 -Xvec_mpy32 -Xvec_num_alu=3 -Xvec_guard_bit_option=0 -Xvec_stack_check -Hvdsp_vector_c -O2"
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
	add	%r0,%r56,0x2000@u32             ; @0x2c
	cmp_s	%r0,0                           ; @0x34
	beq	.LBB0_5                         ; @0x36
;  %bb.1:                               ; %entry
	add	%r1,%r56,0x1000@u32             ; @0x3a
	cmp_s	%r1,0                           ; @0x42
	add	%r1,%r56,0                      ; @0x44
	cmp.ne	%r1,0                           ; Predicate Case 4
                                        ; @0x48
	beq	.LBB0_5                         ; Predicate Case 4
                                        ; @0x4c
;  %bb.3:                               ; %for.body.preheader
	; Implicit def %r12                     ; @0x50
	mov	%lp_count,512                   ; @0x50
	mov_s	%r3,0                           ; @0x54
	add	%r1,%r56,0x1000@u32             ; @0x56
	lp	.LZD0                           ; @0x5e
.LBB0_4:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x62
	add_s	%r2,%r3,1                       ; @0x62
	add_s	%r3,%r3,2                       ; @0x64
	std.ab	%r2,[%r0,8]                     ; @0x66
	std.ab	%r2,[%r1,8]                     ; @0x6a
.LZD0:                                  ; @0x6e
	; ZD Loop End                           ; @0x6e
;  %bb.6:                               ; %for.cond.cleanup
	nop_s                                   ; inserted to benefit BPU
                                        ; @0x6e
	bl	clock                           ; @0x70
	mov_s	%r14,%r0                        ; @0x74
	add	%r0,%r56,0x2000@u32             ; @0x76
	add	%r1,%r56,0x1000@u32             ; @0x7e
	add	%r2,%r56,0                      ; @0x86
	mov	%r3,1024                        ; @0x8a
	bl	vec_sum                         ; @0x8e
	bl	clock                           ; @0x92
	sub_s	%r0,%r0,%r14                    ; @0x96
	fint2d	%r14,%r0                        ; @0x98
	bl	_timer_clocks_per_sec           ; @0x9c
	fuint2d	%r2,%r0                         ; @0xa0
	fddiv	%r2,%r14,%r2                    ; @0xa4
	mov_s	%r17,0x408f4000@u32             ; @0xa8
	mov_s	%r16,0                          ; @0xae
	mov_s	%r19,.L.str.8                   ; @0xb0
	sub	%r0,%r19,.L.str.8-.L.str.3      ; @0xb6
	fdmul	%r20,%r2,%r16                   ; @0xba
	mov_s	%r1,%r20                        ; @0xbe
	mov_s	%r2,%r21                        ; @0xc0
	bl	printf                          ; @0xc2
	sub	%r18,%r13,.L.str.9-.Lstr.15     ; @0xc6
	mov_s	%r0,%r18                        ; @0xca
	bl	puts                            ; @0xcc
	ld	%r4,[%r56,4096]                 ; @0xd0
	ld	%r6,[%r56,0]                    ; @0xd8
	ld	%r2,[%r56,8192]                 ; @0xdc
	sub	%r14,%r13,.L.str.9-.L.str.5     ; @0xe4
	mov_s	%r0,%r14                        ; @0xe8
	mov_s	%r1,0                           ; @0xea
	mov_s	%r3,0                           ; @0xec
	mov_s	%r5,0                           ; @0xee
	bl	printf                          ; @0xf0
	ld	%r4,[%r56,4100]                 ; @0xf4
	ld	%r6,[%r56,4]                    ; @0xfc
	ld	%r2,[%r56,8196]                 ; @0x100
	mov_s	%r0,%r14                        ; @0x108
	mov_s	%r1,1                           ; @0x10a
	mov_s	%r3,1                           ; @0x10c
	mov_s	%r5,1                           ; @0x10e
	bl	printf                          ; @0x110
	ld	%r4,[%r56,4104]                 ; @0x114
	ld	%r6,[%r56,8]                    ; @0x11c
	ld	%r2,[%r56,8200]                 ; @0x120
	mov_s	%r0,%r14                        ; @0x128
	mov_s	%r1,2                           ; @0x12a
	mov_s	%r3,2                           ; @0x12c
	mov_s	%r5,2                           ; @0x12e
	bl	printf                          ; @0x130
	ld	%r4,[%r56,4108]                 ; @0x134
	ld	%r6,[%r56,12]                   ; @0x13c
	ld	%r2,[%r56,8204]                 ; @0x140
	mov_s	%r0,%r14                        ; @0x148
	mov_s	%r1,3                           ; @0x14a
	mov_s	%r3,3                           ; @0x14c
	mov_s	%r5,3                           ; @0x14e
	bl	printf                          ; @0x150
	ld	%r4,[%r56,4112]                 ; @0x154
	ld	%r6,[%r56,16]                   ; @0x15c
	ld	%r2,[%r56,8208]                 ; @0x160
	mov_s	%r0,%r14                        ; @0x168
	mov_s	%r1,4                           ; @0x16a
	mov_s	%r3,4                           ; @0x16c
	mov_s	%r5,4                           ; @0x16e
	bl	printf                          ; @0x170
	mov	%r0,10                          ; widened to benefit BPU
                                        ; @0x174
	bl	putchar                         ; @0x178
	add_s	%r0,%r13,.L.str.7-.L.str.9      ; @0x17c
	mov_s	%r1,16                          ; @0x17e
	bl.d	printf                          ; @0x180
	nop                                     ; inserted to benefit BPU
                                        ; @0x184
	bl	clock                           ; @0x188
	mov_s	%r15,%r0                        ; @0x18c
	add	%r0,%r56,0x2000@u32             ; @0x18e
	add	%r1,%r56,0x1000@u32             ; @0x196
	add	%r2,%r56,0                      ; @0x19e
	mov	%r3,1024                        ; @0x1a2
	bl	vectorized_vec_sum              ; @0x1a6
	bl	clock                           ; @0x1aa
	sub_s	%r0,%r0,%r15                    ; @0x1ae
	fint2d	%r22,%r0                        ; @0x1b0
	bl	_timer_clocks_per_sec           ; @0x1b4
	fuint2d	%r2,%r0                         ; @0x1b8
	fddiv	%r2,%r22,%r2                    ; @0x1bc
	mov_s	%r0,%r19                        ; @0x1c0
	fdmul	%r22,%r2,%r16                   ; @0x1c2
	mov_s	%r1,%r22                        ; @0x1c6
	mov_s	%r2,%r23                        ; @0x1c8
	bl	printf                          ; @0x1ca
	fddiv	%r2,%r20,%r22                   ; @0x1ce
	mov_s	%r0,%r13                        ; @0x1d2
	mov_s	%r1,%r2                         ; @0x1d4
	mov_s	%r2,%r3                         ; @0x1d6
	bl	printf                          ; @0x1d8
	mov	%r0,%r18                        ; widened to benefit BPU
                                        ; @0x1dc
	bl	puts                            ; @0x1e0
	ld	%r4,[%r56,4096]                 ; @0x1e4
	ld	%r6,[%r56,0]                    ; @0x1ec
	ld	%r2,[%r56,8192]                 ; @0x1f0
	mov_s	%r0,%r14                        ; @0x1f8
	mov_s	%r1,0                           ; @0x1fa
	mov_s	%r3,0                           ; @0x1fc
	mov_s	%r5,0                           ; @0x1fe
	bl	printf                          ; @0x200
	ld	%r4,[%r56,4100]                 ; @0x204
	ld	%r6,[%r56,4]                    ; @0x20c
	ld	%r2,[%r56,8196]                 ; @0x210
	mov_s	%r0,%r14                        ; @0x218
	mov_s	%r1,1                           ; @0x21a
	mov_s	%r3,1                           ; @0x21c
	mov_s	%r5,1                           ; @0x21e
	bl	printf                          ; @0x220
	ld	%r4,[%r56,4104]                 ; @0x224
	ld	%r6,[%r56,8]                    ; @0x22c
	ld	%r2,[%r56,8200]                 ; @0x230
	mov_s	%r0,%r14                        ; @0x238
	mov_s	%r1,2                           ; @0x23a
	mov_s	%r3,2                           ; @0x23c
	mov_s	%r5,2                           ; @0x23e
	bl	printf                          ; @0x240
	ld	%r4,[%r56,4108]                 ; @0x244
	ld	%r6,[%r56,12]                   ; @0x24c
	ld	%r2,[%r56,8204]                 ; @0x250
	mov_s	%r0,%r14                        ; @0x258
	mov_s	%r1,3                           ; @0x25a
	mov_s	%r3,3                           ; @0x25c
	mov_s	%r5,3                           ; @0x25e
	bl	printf                          ; @0x260
	ld	%r4,[%r56,4112]                 ; @0x264
	ld	%r6,[%r56,16]                   ; @0x26c
	ld	%r2,[%r56,8208]                 ; @0x270
	mov_s	%r0,%r14                        ; @0x278
	mov_s	%r1,4                           ; @0x27a
	mov_s	%r3,4                           ; @0x27c
	mov_s	%r5,4                           ; @0x27e
	bl	printf                          ; @0x280
	add	%r0,%r13,.Lstr.14-.L.str.9      ; widened to benefit BPU
                                        ; @0x284
	bl.d	puts                            ; @0x288
	nop                                     ; inserted to benefit BPU
                                        ; @0x28c
	bl	clock                           ; @0x290
	mov_s	%r15,%r0                        ; @0x294
	add	%r0,%r56,0x2000@u32             ; @0x296
	add	%r1,%r56,0x1000@u32             ; @0x29e
	add	%r2,%r56,0                      ; @0x2a6
	mov	%r3,1024                        ; @0x2aa
	bl	autovectorized_vec_sum          ; @0x2ae
	bl	clock                           ; @0x2b2
	sub_s	%r0,%r0,%r15                    ; @0x2b6
	fint2d	%r22,%r0                        ; @0x2b8
	bl	_timer_clocks_per_sec           ; @0x2bc
	fuint2d	%r2,%r0                         ; @0x2c0
	fddiv	%r2,%r22,%r2                    ; @0x2c4
	add	%r0,%r19,.L.str.11-.L.str.8     ; @0x2c8
	fdmul	%r22,%r2,%r16                   ; @0x2cc
	mov_s	%r1,%r22                        ; @0x2d0
	mov_s	%r2,%r23                        ; @0x2d2
	bl	printf                          ; @0x2d4
	fddiv	%r2,%r20,%r22                   ; @0x2d8
	mov_s	%r0,%r13                        ; @0x2dc
	mov_s	%r1,%r2                         ; @0x2de
	mov_s	%r2,%r3                         ; @0x2e0
	bl	printf                          ; @0x2e2
	mov_s	%r0,%r18                        ; @0x2e6
	bl	puts                            ; @0x2e8
	ld	%r4,[%r56,4096]                 ; @0x2ec
	ld	%r6,[%r56,0]                    ; @0x2f4
	ld	%r2,[%r56,8192]                 ; @0x2f8
	mov_s	%r0,%r14                        ; @0x300
	mov_s	%r1,0                           ; @0x302
	mov_s	%r3,0                           ; @0x304
	mov_s	%r5,0                           ; @0x306
	bl	printf                          ; @0x308
	ld	%r4,[%r56,4100]                 ; @0x30c
	ld	%r6,[%r56,4]                    ; @0x314
	ld	%r2,[%r56,8196]                 ; @0x318
	mov_s	%r0,%r14                        ; @0x320
	mov_s	%r1,1                           ; @0x322
	mov_s	%r3,1                           ; @0x324
	mov_s	%r5,1                           ; @0x326
	bl	printf                          ; @0x328
	ld	%r4,[%r56,4104]                 ; @0x32c
	ld	%r6,[%r56,8]                    ; @0x334
	ld	%r2,[%r56,8200]                 ; @0x338
	mov_s	%r0,%r14                        ; @0x340
	mov_s	%r1,2                           ; @0x342
	mov_s	%r3,2                           ; @0x344
	mov_s	%r5,2                           ; @0x346
	bl	printf                          ; @0x348
	ld	%r4,[%r56,4108]                 ; @0x34c
	ld	%r6,[%r56,12]                   ; @0x354
	ld	%r2,[%r56,8204]                 ; @0x358
	mov_s	%r0,%r14                        ; @0x360
	mov_s	%r1,3                           ; @0x362
	mov_s	%r3,3                           ; @0x364
	mov_s	%r5,3                           ; @0x366
	bl	printf                          ; @0x368
	ld	%r4,[%r56,4112]                 ; @0x36c
	ld	%r6,[%r56,16]                   ; @0x374
	ld	%r2,[%r56,8208]                 ; @0x378
	mov_s	%r0,%r14                        ; @0x380
	mov_s	%r1,4                           ; @0x382
	mov_s	%r3,4                           ; @0x384
	mov_s	%r5,4                           ; @0x386
	bl.d	printf                          ; @0x388
	nop                                     ; inserted to benefit BPU
                                        ; @0x38c
	b	.LBB0_7                         ; widened to benefit BPU
                                        ; @0x390
.LBB0_5:                                ; %if.then
                                        ; @0x394
	add	%r13,%r13,.Lstr-.L.str.9        ; @0x394
	mov_s	%r0,%r13                        ; @0x398
	bl	puts                            ; @0x39a
	mov_s	%r16,1                          ; @0x39e
.LBB0_7:                                ; %cleanup
                                        ; @0x3a0
	mov_s	%r0,%r16                        ; @0x3a0
	add3	%r56,%r56,12288/8               ; @0x3a2
	ld	%blink,[%sp,44]                 ; @0x3a6
	.cfa_restore	{%blink}                ; @0x3aa
	ldd	%r22,[%sp,36]                   ; @0x3aa
	.cfa_restore	{%r23}                  ; @0x3ae
	.cfa_restore	{%r22}                  ; @0x3ae
	ldd	%r20,[%sp,28]                   ; @0x3ae
	.cfa_restore	{%r21}                  ; @0x3b2
	.cfa_restore	{%r20}                  ; @0x3b2
	ldd	%r18,[%sp,20]                   ; @0x3b2
	.cfa_restore	{%r19}                  ; @0x3b6
	.cfa_restore	{%r18}                  ; @0x3b6
	ldd	%r16,[%sp,12]                   ; @0x3b6
	.cfa_restore	{%r17}                  ; @0x3ba
	.cfa_restore	{%r16}                  ; @0x3ba
	ldd	%r14,[%sp,4]                    ; @0x3ba
	.cfa_restore	{%r15}                  ; @0x3be
	.cfa_restore	{%r14}                  ; @0x3be
	ld.ab	%r13,[%sp,48]                   ; @0x3be
	.cfa_restore	{%r13}                  ; @0x3c2
	.cfa_pop	48                              ; @0x3c2
	j_s	[%blink]                        ; @0x3c2
	.cfa_ef
.Lfunc_end0:                            ; @0x3c4

	.reloc	_init_ad,0	;startup code to enable %status AD bit ; -- End function
