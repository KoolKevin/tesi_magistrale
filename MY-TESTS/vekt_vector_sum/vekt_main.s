	.option	%reg
	.off	assume_short
	.file	"vekt_main.c"
	.size	.L.str.4, 30
	.type	.L.str.4,@object
	.size	.Lstr.14, 30
	.type	.Lstr.14,@object
	.size	.L.str, 5
	.type	.L.str,@object
	.size	.L.str.8, 15
	.type	.L.str.8,@object
	.size	.L.str.6, 23
	.type	.L.str.6,@object
	.size	.Lstr.13, 27
	.type	.Lstr.13,@object
	.size	.Lstr, 39
	.type	.Lstr,@object
	.size	.L.str.2, 40
	.type	.L.str.2,@object
	.size	.L.str.7, 51
	.type	.L.str.7,@object
	.size	.L.str.10, 55
	.type	.L.str.10,@object
	.globl	init_vector
	.type	init_vector,@function
	.type	.Linit_vector$local,@function
	.size	init_vector, .Lfunc_end0-init_vector
	.size	.Linit_vector$local, .Lfunc_end0-init_vector
	.globl	vekt_vec_sum_wrapper
	.type	vekt_vec_sum_wrapper,@function
	.type	.Lvekt_vec_sum_wrapper$local,@function
	.size	vekt_vec_sum_wrapper, .Lfunc_end1-vekt_vec_sum_wrapper
	.size	.Lvekt_vec_sum_wrapper$local, .Lfunc_end1-vekt_vec_sum_wrapper
	.globl	vec_sum
	.type	vec_sum,@function
	.type	.Lvec_sum$local,@function
	.size	vec_sum, .Lfunc_end2-vec_sum
	.size	.Lvec_sum$local, .Lfunc_end2-vec_sum
	.globl	vectorized_vec_sum
	.type	vectorized_vec_sum,@function
	.type	.Lvectorized_vec_sum$local,@function
	.size	vectorized_vec_sum, .Lfunc_end3-vectorized_vec_sum
	.size	.Lvectorized_vec_sum$local, .Lfunc_end3-vectorized_vec_sum
	.globl	main
	.type	main,@function
	.type	.Lmain$local,@function
	.size	main, .Lfunc_end4-main
	.size	.Lmain$local, .Lfunc_end4-main
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
.L.str.4:                               ; @0x0
	.asciz	"a[%d]=%d, b[%d]=%d, c[%d]=%d\n"
.Lstr.14:                               ; @0x1e
	.asciz	"Primi 5 elementi della somma:"
.L.str:                                 ; @0x3c
	.asciz	"\t%d\n"
.L.str.8:                               ; @0x41
	.asciz	"Speedup: %.2f\n"
.L.str.6:                               ; @0x50
	.asciz	"Vettorizzo su %d lane\n"
.Lstr.13:                               ; @0x67
	.asciz	"Versione vekt-vettorizzata"
.Lstr:                                  ; @0x82
	.asciz	"Errore nell'allocazione della memoria."
.L.str.2:                               ; @0xa9
	.asciz	"Tempo di esecuzione di vec_sum: %.2fms\n"
.L.str.7:                               ; @0xd1
	.asciz	"Tempo di esecuzione di vectorized_vec_sum: %.2fms\n"
.L.str.10:                              ; @0x104
	.asciz	"Tempo di esecuzione di autovectorized_vec_sum: %.2fms\n"
	.text
	.global	.CC_I
	.equ	.CC_I, 0
	.ident	"LLVM 17.0.7/V-2024.06. (build 008) (LLVM 17.0.7) -arcv2hs -core4 -Xcode_density -Xatomic -Xll64 -Xunaligned -Xdiv_rem=radix4 -Xswap -Xbitscan -Xmpy_option=mpyd -Xshift_assist -Xbarrel_shifter -Xfpud_div -Xfpu_mac -Xtimer0 -Xrtc -Xstack_check -Xstu=4 -Xvdsp4 -Xvec_unit_rev_minor=1 -Xvec_width=512 -Xvec_mem_size=128k -Xvec_mem_bank_width=16 -Xvec_max_fetch_size=16 -Xvec_num_slots=3 -Xvec_super_with_scalar -Xvec_regs=32 -Xvec_fpu=32 -Xvec_fpu_math=3 -Xvec_fpu_2nd_mul -Xvec_fpu_types=2 -Xvec_num_rd_ports=6 -Xvec_num_acc=8 -Xvec_num_mpy=2 -Xvec_mpy32 -Xvec_num_alu=3 -Xvec_guard_bit_option=0 -Xvec_stack_check -Hvdsp_vector_c -O1"
	.align	4                               ; -- Begin function init_vector
init_vector:                            ; @init_vector
                                        ; @0x0
.Linit_vector$local:                    ; @0x0
	.cfa_bf	.Linit_vector$local
;  %bb.0:                               ; %entry
	.cfa_same	%r30                    ; @0x0
	.cfa_same	%r12                    ; @0x0
	.cfa_same	%r11                    ; @0x0
	.cfa_same	%r9                     ; @0x0
	.cfa_same	%r8                     ; @0x0
	.cfa_same	%r7                     ; @0x0
	.cfa_same	%r6                     ; @0x0
	.cfa_same	%r5                     ; @0x0
	.cfa_same	%r4                     ; @0x0
	.cfa_same	%r2                     ; @0x0
	.cfa_same	%r1                     ; @0x0
	brlt	%r1,1,.LBB0_3                   ; @0x0
;  %bb.1:                               ; %for.body.preheader
	mov_s	%r3,0                           ; @0x4
.LBB0_2:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x6
	st_s	%r2,[%r0,0]                     ; @0x6
	add_s	%r0,%r0,4                       ; @0x8
	add_s	%r3,%r3,1                       ; @0xa
	brlt	%r3,%r1,.LBB0_2                 ; @0xc
.LBB0_3:                                ; %for.cond.cleanup
                                        ; @0x10
	j_s	[%blink]                        ; @0x10
	.cfa_ef
.Lfunc_end0:                            ; @0x12

	.align	4                               ; -- End function
                                        ; -- Begin function vekt_vec_sum_wrapper
vekt_vec_sum_wrapper:                   ; @vekt_vec_sum_wrapper
                                        ; @0x14
.Lvekt_vec_sum_wrapper$local:           ; @0x14
	.cfa_bf	.Lvekt_vec_sum_wrapper$local
;  %bb.0:                               ; %entry
	push_s	%blink                          ; @0x14
	.cfa_push	{%blink}                ; @0x16
	sub_s	%sp,%sp,32                      ; @0x16
	.cfa_push	32                      ; @0x18
	mov_s	%r4,%r2                         ; @0x18
	mov_s	%r2,1                           ; @0x1a
	mov_s	%r5,%r4                         ; @0x1c
	mov_s	%r6,%r1                         ; @0x1e
	std	%r4,[%sp,8]                     ; @0x20
	mov_s	%r4,%r3                         ; @0x24
	mov_s	%r5,%r2                         ; @0x26
	std	%r2,[%sp,24]                    ; @0x28
	mov_s	%r8,0                           ; @0x2c
	mov_s	%r9,%r3                         ; @0x2e
	std	%r4,[%sp,0]                     ; @0x30
	mov_s	%r1,%r0                         ; @0x34
	mov_s	%r2,0                           ; @0x36
	mov_s	%r4,1                           ; @0x38
	mov_s	%r5,%r6                         ; @0x3a
	mov_s	%r7,0                           ; @0x3c
	std	%r8,[%sp,16]                    ; @0x3e
	bl	vekt_vec_sum                    ; @0x42
	add_s	%sp,%sp,32                      ; @0x46
	.cfa_pop	32                              ; @0x48
	ld	%blink,[%sp,0]                  ; @0x48
	.cfa_restore	{%blink}                ; @0x4c
	add_s	%sp,%sp,4                       ; @0x4c
	.cfa_pop	4                               ; @0x4e
	j_s	[%blink]                        ; @0x4e
	.cfa_ef
.Lfunc_end1:                            ; @0x50

	.align	4                               ; -- End function
                                        ; -- Begin function vec_sum
vec_sum:                                ; @vec_sum
                                        ; @0x50
.Lvec_sum$local:                        ; @0x50
	.cfa_bf	.Lvec_sum$local
;  %bb.0:                               ; %entry
	.cfa_same	%r30                    ; @0x50
	.cfa_same	%r9                     ; @0x50
	.cfa_same	%r7                     ; @0x50
	.cfa_same	%r6                     ; @0x50
	.cfa_same	%r5                     ; @0x50
	.cfa_same	%r4                     ; @0x50
	.cfa_same	%r3                     ; @0x50
	brlt	%r3,1,.LBB2_3                   ; @0x50
;  %bb.1:                               ; %for.body.preheader
	mov_s	%r8,0                           ; @0x54
.LBB2_2:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x56
	ld	%r11,[%r0,0]                    ; @0x56
	ld_s	%r12,[%r1,0]                    ; @0x5a
	add_s	%r0,%r0,4                       ; @0x5c
	add	%r11,%r12,%r11                  ; @0x5e
	st	%r11,[%r2,0]                    ; @0x62
	add_s	%r1,%r1,4                       ; @0x66
	add_s	%r2,%r2,4                       ; @0x68
	add_s	%r8,%r8,1                       ; @0x6a
	brlt	%r8,%r3,.LBB2_2                 ; @0x6c
.LBB2_3:                                ; %for.cond.cleanup
                                        ; @0x70
	j_s	[%blink]                        ; @0x70
	.cfa_ef
.Lfunc_end2:                            ; @0x72

	.align	4                               ; -- End function
                                        ; -- Begin function vectorized_vec_sum
vectorized_vec_sum:                     ; @vectorized_vec_sum
                                        ; @0x74
.Lvectorized_vec_sum$local:             ; @0x74
	.cfa_bf	.Lvectorized_vec_sum$local
;  %bb.0:                               ; %entry
	sub_s	%sp,%sp,44                      ; @0x74
	.cfa_push	44                      ; @0x76
	st	%r13,[%sp,0]                    ; @0x76
	.cfa_reg_offset	{%r13}, 0               ; @0x7a
	std	%r14,[%sp,4]                    ; @0x7a
	.cfa_reg_offset	{%r14}, 4               ; @0x7e
	.cfa_reg_offset	{%r15}, 8               ; @0x7e
	std	%r16,[%sp,12]                   ; @0x7e
	.cfa_reg_offset	{%r16}, 12              ; @0x82
	.cfa_reg_offset	{%r17}, 16              ; @0x82
	std	%r18,[%sp,20]                   ; @0x82
	.cfa_reg_offset	{%r18}, 20              ; @0x86
	.cfa_reg_offset	{%r19}, 24              ; @0x86
	std	%r20,[%sp,28]                   ; @0x86
	.cfa_reg_offset	{%r20}, 28              ; @0x8a
	.cfa_reg_offset	{%r21}, 32              ; @0x8a
	st	%r22,[%sp,36]                   ; @0x8a
	.cfa_reg_offset	{%r22}, 36              ; @0x8e
	st	%blink,[%sp,40]                 ; @0x8e
	.cfa_reg_offset	{%blink}, 40            ; @0x92
	mov_s	%r18,%r0                        ; @0x92
	asr	%r0,%r3,31                      ; @0x94
	lsr_s	%r0,%r0,28                      ; @0x98
	add	%r19,%r3,%r0                    ; @0x9a
	asr	%r21,%r19,4                     ; @0x9e
	mov_s	%r20,%r3                        ; @0xa2
	mov_s	%r16,%r2                        ; @0xa4
	mov_s	%r17,%r1                        ; @0xa6
	brlt	%r3,16,.LBB3_3                  ; @0xa8
;  %bb.1:                               ; %for.body.preheader
	mov_s	%r22,0                          ; @0xac
	mov_s	%r13,%r16                       ; @0xae
	mov_s	%r14,%r17                       ; @0xb0
	mov_s	%r15,%r18                       ; @0xb2
.LBB3_2:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0xb4
.vvsbundle  "v1sc" 
 ;	 { 
	vvld.w	%vr0,%r14                       ; @0xb4
	mov_s	%r0,.L.str                      ; @0xb4
 ;	 }
	vvld.w	%vr1,%r15                       ; @0xbe
	vvadd.w	%vr0, %vr1, %vr0                ; @0xc2
	vvst.w	%vr0,%r13                       ; @0xc8
	ld_s	%r1,[%r13,0]                    ; @0xcc
	bl	printf                          ; @0xce
	add1	%r13,%r13,64/2                  ; @0xd2
	add1	%r14,%r14,64/2                  ; @0xd6
	add1	%r15,%r15,64/2                  ; @0xda
	add_s	%r22,%r22,1                     ; @0xde
	brlt	%r22,%r21,.LBB3_2               ; @0xe0
.LBB3_3:                                ; %for.cond.cleanup
                                        ; @0xe4
	bmskn	%r0,%r19,3                      ; @0xe4
	sub	%r1,%r20,%r0                    ; @0xe8
	brlt	%r1,1,.LBB3_6                   ; @0xec
;  %bb.4:                               ; %for.body15.preheader
	asl	%r1,%r21,6                      ; @0xf0
	add	%r18,%r18,%r1                   ; @0xf4
	add	%r17,%r17,%r1                   ; @0xf8
	add	%r16,%r16,%r1                   ; @0xfc
.LBB3_5:                                ; %for.body15
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x100
	ld_s	%r1,[%r18,0]                    ; @0x100
	ld_s	%r2,[%r17,0]                    ; @0x102
	add_s	%r18,%r18,4                     ; @0x104
	add_s	%r17,%r17,4                     ; @0x106
	add_s	%r0,%r0,1                       ; @0x108
	add_s	%r1,%r2,%r1                     ; @0x10a
	st	%r1,[%r16,0]                    ; @0x10c
	add_s	%r16,%r16,4                     ; @0x110
	brlt	%r0,%r20,.LBB3_5                ; @0x112
.LBB3_6:                                ; %for.cond.cleanup14
                                        ; @0x116
	ld	%blink,[%sp,40]                 ; @0x116
	.cfa_restore	{%blink}                ; @0x11a
	ld	%r22,[%sp,36]                   ; @0x11a
	.cfa_restore	{%r22}                  ; @0x11e
	ldd	%r20,[%sp,28]                   ; @0x11e
	.cfa_restore	{%r21}                  ; @0x122
	.cfa_restore	{%r20}                  ; @0x122
	ldd	%r18,[%sp,20]                   ; @0x122
	.cfa_restore	{%r19}                  ; @0x126
	.cfa_restore	{%r18}                  ; @0x126
	ldd	%r16,[%sp,12]                   ; @0x126
	.cfa_restore	{%r17}                  ; @0x12a
	.cfa_restore	{%r16}                  ; @0x12a
	ldd	%r14,[%sp,4]                    ; @0x12a
	.cfa_restore	{%r15}                  ; @0x12e
	.cfa_restore	{%r14}                  ; @0x12e
	ld_s	%r13,[%sp,0]                    ; @0x12e
	.cfa_restore	{%r13}                  ; @0x130
	add_s	%sp,%sp,44                      ; @0x130
	.cfa_pop	44                              ; @0x132
	j_s	[%blink]                        ; @0x132
	.cfa_ef
.Lfunc_end3:                            ; @0x134

	.align	4                               ; -- End function
                                        ; -- Begin function main
main:                                   ; @main
                                        ; @0x134
.Lmain$local:                           ; @0x134
	.cfa_bf	.Lmain$local
;  %bb.0:                               ; %entry
	sub_s	%sp,%sp,68                      ; @0x134
	.cfa_push	68                      ; @0x136
	st	%r13,[%sp,0]                    ; @0x136
	.cfa_reg_offset	{%r13}, 0               ; @0x13a
	std	%r14,[%sp,4]                    ; @0x13a
	.cfa_reg_offset	{%r14}, 4               ; @0x13e
	.cfa_reg_offset	{%r15}, 8               ; @0x13e
	std	%r16,[%sp,12]                   ; @0x13e
	.cfa_reg_offset	{%r16}, 12              ; @0x142
	.cfa_reg_offset	{%r17}, 16              ; @0x142
	std	%r18,[%sp,20]                   ; @0x142
	.cfa_reg_offset	{%r18}, 20              ; @0x146
	.cfa_reg_offset	{%r19}, 24              ; @0x146
	std	%r20,[%sp,28]                   ; @0x146
	.cfa_reg_offset	{%r20}, 28              ; @0x14a
	.cfa_reg_offset	{%r21}, 32              ; @0x14a
	std	%r22,[%sp,36]                   ; @0x14a
	.cfa_reg_offset	{%r22}, 36              ; @0x14e
	.cfa_reg_offset	{%r23}, 40              ; @0x14e
	st	%r24,[%sp,44]                   ; @0x14e
	.cfa_reg_offset	{%r24}, 44              ; @0x152
	st	%fp,[%sp,48]                    ; @0x152
	.cfa_reg_offset	{%fp}, 48               ; @0x156
	st	%blink,[%sp,52]                 ; @0x156
	.cfa_reg_offset	{%blink}, 52            ; @0x15a
	sub_s	%sp,%sp,32                      ; @0x15a
	.cfa_push	32                      ; @0x15c
	sub3	%r56,%r56,12288/8               ; @0x15c
	add	%r0,%r56,0x2000@u32             ; @0x160
	cmp_s	%r0,0                           ; @0x168
	mov_s	%r17,.L.str                     ; @0x16a
	beq	.LBB4_22                        ; @0x170
;  %bb.1:                               ; %entry
	add	%r24,%r56,0x1000@u32            ; @0x174
	cmp_s	%r24,0                          ; @0x17c
	beq	.LBB4_22                        ; @0x17e
;  %bb.2:                               ; %entry
	add	%r22,%r56,0                     ; @0x182
	cmp_s	%r22,0                          ; @0x186
	beq	.LBB4_22                        ; @0x188
;  %bb.3:                               ; %for.body.preheader
	mov_s	%r14,0                          ; @0x18c
	add	%r1,%r56,0x1000@u32             ; @0x18e
	mov_s	%r2,0                           ; @0x196
.LBB4_4:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x198
	add_s	%r2,%r2,1                       ; @0x198
	st_s	%r2,[%r1,0]                     ; @0x19a
	st_s	%r2,[%r0,0]                     ; @0x19c
	add_s	%r0,%r0,4                       ; @0x19e
	add_s	%r1,%r1,4                       ; @0x1a0
	cmp	%r2,1024                        ; @0x1a2
	blo_s	.LBB4_4                         ; @0x1a6
;  %bb.5:                               ; %for.body.i.preheader
	add	%r0,%r56,0                      ; @0x1a8
	mov_s	%r1,0                           ; @0x1ac
.LBB4_6:                                ; %for.body.i
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x1ae
	add_s	%r1,%r1,1                       ; @0x1ae
	st	0,[%r0,0]                       ; @0x1b0
	add_s	%r0,%r0,4                       ; @0x1b4
	cmp	%r1,1024                        ; @0x1b6
	blo_s	.LBB4_6                         ; @0x1ba
;  %bb.7:                               ; %init_vector.exit
	add	%r13,%r56,0x2000@u32            ; @0x1bc
	bl	clock                           ; @0x1c4
	mov_s	%r16,%r0                        ; @0x1c8
	add	%r0,%r56,0x1000@u32             ; @0x1ca
	add	%r1,%r56,0                      ; @0x1d2
.LBB4_8:                                ; %for.body.i146
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x1d6
	ld_s	%r2,[%r13,0]                    ; @0x1d6
	ld_s	%r3,[%r0,0]                     ; @0x1d8
	add_s	%r14,%r14,1                     ; @0x1da
	add_s	%r13,%r13,4                     ; @0x1dc
	add_s	%r0,%r0,4                       ; @0x1de
	add_s	%r2,%r3,%r2                     ; @0x1e0
	st_s	%r2,[%r1,0]                     ; @0x1e2
	add_s	%r1,%r1,4                       ; @0x1e4
	cmp	%r14,1024                       ; @0x1e6
	blo_s	.LBB4_8                         ; @0x1ea
;  %bb.9:                               ; %vec_sum.exit
	bl	clock                           ; @0x1ec
	sub	%r0,%r0,%r16                    ; @0x1f0
	fint2d	%r14,%r0                        ; @0x1f4
	bl	_timer_clocks_per_sec           ; @0x1f8
	fuint2d	%r2,%r0                         ; @0x1fc
	fddiv	%r2,%r14,%r2                    ; @0x200
	mov_s	%r19,0x408f4000@u32             ; @0x204
	mov_s	%r18,0                          ; @0x20a
	mov_s	%r0,.L.str.2                    ; @0x20c
	fdmul	%r20,%r2,%r18                   ; @0x212
	mov_s	%r1,%r20                        ; @0x216
	mov_s	%r2,%r21                        ; @0x218
	bl	printf                          ; @0x21a
	sub	%r23,%r17,.L.str-.Lstr.14       ; @0x21e
	mov_s	%r0,%r23                        ; @0x222
	bl	puts                            ; @0x224
	add	%r14,%r56,0x2000@u32            ; @0x228
	sub	%fp,%r17,.L.str-.L.str.4        ; @0x230
	add	%r13,%r56,0x1000@u32            ; @0x234
	add	%r15,%r56,0                     ; @0x23c
.LBB4_10:                               ; %for.body17
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x240
	ld	%r6,[%r15,0]                    ; @0x240
	ld	%r4,[%r13,0]                    ; @0x244
	ld_s	%r2,[%r14,0]                    ; @0x248
	mov_s	%r0,%fp                         ; @0x24a
	mov_s	%r1,%r18                        ; @0x24c
	mov_s	%r3,%r18                        ; @0x24e
	mov_s	%r5,%r18                        ; @0x250
	bl	printf                          ; @0x252
	add_s	%r14,%r14,4                     ; @0x256
	add_s	%r13,%r13,4                     ; @0x258
	add_s	%r15,%r15,4                     ; @0x25a
	add_s	%r18,%r18,1                     ; @0x25c
	brlo	%r18,5,.LBB4_10                 ; @0x25e
;  %bb.11:                              ; %for.cond.cleanup16
	mov_s	%r0,10                          ; @0x262
	bl	putchar                         ; @0x264
	add	%r0,%r17,.L.str.6-.L.str        ; @0x268
	mov_s	%r1,16                          ; @0x26c
	bl	printf                          ; @0x26e
	mov_s	%r14,0                          ; @0x272
	add	%r0,%r56,0                      ; @0x274
	mov_s	%r1,0                           ; @0x278
.LBB4_12:                               ; %for.body.i150
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x27a
	add_s	%r1,%r1,1                       ; @0x27a
	st	0,[%r0,0]                       ; @0x27c
	add_s	%r0,%r0,4                       ; @0x280
	cmp	%r1,1024                        ; @0x282
	blo_s	.LBB4_12                        ; @0x286
;  %bb.13:                              ; %init_vector.exit155
	bl	clock                           ; @0x288
	mov_s	%r16,%r0                        ; @0x28c
	add	%r18,%r56,0x2000@u32            ; @0x28e
	add	%r15,%r56,0                     ; @0x296
	mov_s	%r13,0                          ; @0x29a
.LBB4_14:                               ; %for.body.i156
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x29c
	add	%r0,%r24,%r14                   ; @0x29c
.vvsbundle  "v1sc" 
 ;	 { 
	vvld.w	%vr0,%r0                        ; @0x2a0
	add	%r0,%r18,%r14                   ; @0x2a0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvld.w	%vr1,%r0                        ; @0x2a8
	mov_s	%r0,%r17                        ; @0x2a8
 ;	 }
	vvadd.w	%vr0, %vr1, %vr0                ; @0x2ae
	vvst.w	%vr0,%r15                       ; @0x2b4
	ld_s	%r1,[%r15,0]                    ; @0x2b8
	bl	printf                          ; @0x2ba
	add1	%r14,%r14,64/2                  ; @0x2be
	add1	%r15,%r15,64/2                  ; @0x2c2
	add_s	%r13,%r13,1                     ; @0x2c6
	cmp_s	%r13,64                         ; @0x2c8
	bcs	.LBB4_14                        ; @0x2ca
;  %bb.15:                              ; %vectorized_vec_sum.exit
	bl	clock                           ; @0x2ce
	sub	%r0,%r0,%r16                    ; @0x2d2
	fint2d	%r14,%r0                        ; @0x2d6
	bl	_timer_clocks_per_sec           ; @0x2da
	fuint2d	%r2,%r0                         ; @0x2de
	fddiv	%r2,%r14,%r2                    ; @0x2e2
	mov_s	%r18,0                          ; @0x2e6
	mov_s	%r0,.L.str.7                    ; @0x2e8
	fdmul	%r14,%r2,%r18                   ; @0x2ee
	mov_s	%r1,%r14                        ; @0x2f2
	mov_s	%r2,%r15                        ; @0x2f4
	bl	printf                          ; @0x2f6
	fddiv	%r2,%r20,%r14                   ; @0x2fa
	add	%r0,%r17,.L.str.8-.L.str        ; @0x2fe
	st	%r0,[%sp,88]                    ; 4-byte Folded Spill
                                        ; @0x302
	mov_s	%r1,%r2                         ; @0x306
	mov_s	%r2,%r3                         ; @0x308
	bl	printf                          ; @0x30a
	mov_s	%r0,%r23                        ; @0x30e
	bl	puts                            ; @0x310
	add	%r14,%r56,0x2000@u32            ; @0x314
	add	%r13,%r56,0x1000@u32            ; @0x31c
	add	%r15,%r56,0                     ; @0x324
.LBB4_16:                               ; %for.body44
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x328
	ld	%r6,[%r15,0]                    ; @0x328
	ld	%r4,[%r13,0]                    ; @0x32c
	ld_s	%r2,[%r14,0]                    ; @0x330
	mov_s	%r0,%fp                         ; @0x332
	mov_s	%r1,%r18                        ; @0x334
	mov_s	%r3,%r18                        ; @0x336
	mov_s	%r5,%r18                        ; @0x338
	bl	printf                          ; @0x33a
	add_s	%r14,%r14,4                     ; @0x33e
	add_s	%r13,%r13,4                     ; @0x340
	add_s	%r15,%r15,4                     ; @0x342
	add_s	%r18,%r18,1                     ; @0x344
	brlo	%r18,5,.LBB4_16                 ; @0x346
;  %bb.17:                              ; %for.cond.cleanup43
	mov_s	%r0,10                          ; @0x34a
	mov_s	%r15,%r23                       ; @0x34c
	std	%r20,[%sp,92]                   ; 8-byte Folded Spill
                                        ; @0x34e
	bl	putchar                         ; @0x352
	add	%r0,%r17,.Lstr.13-.L.str        ; @0x356
	bl	puts                            ; @0x35a
	mov_s	%r0,0                           ; @0x35e
	add	%r1,%r56,0                      ; @0x360
.LBB4_18:                               ; %for.body.i161
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x364
	add_s	%r0,%r0,1                       ; @0x364
	st	0,[%r1,0]                       ; @0x366
	add_s	%r1,%r1,4                       ; @0x36a
	cmp	%r0,1024                        ; @0x36c
	blo_s	.LBB4_18                        ; @0x370
;  %bb.19:                              ; %init_vector.exit166
	bl	clock                           ; @0x372
	mov	%r3,1024                        ; @0x376
	mov_s	%r2,1                           ; @0x37a
	mov_s	%r13,%r0                        ; @0x37c
	mov_s	%r0,%r3                         ; @0x37e
	mov_s	%r1,%r2                         ; @0x380
	std	%r2,[%sp,24]                    ; @0x382
	mov_s	%r16,0                          ; @0x386
	mov_s	%r17,%r3                        ; @0x388
	mov_s	%r23,%r22                       ; @0x38a
	std	%r0,[%sp,0]                     ; @0x38c
	add	%r0,%r56,0x2000@u32             ; @0x390
	add	%r1,%r56,0x2000@u32             ; @0x398
	mov_s	%r2,0                           ; @0x3a0
	mov_s	%r4,1                           ; @0x3a2
	add	%r5,%r56,0x1000@u32             ; @0x3a4
	add	%r6,%r56,0x1000@u32             ; @0x3ac
	mov_s	%r7,0                           ; @0x3b4
	std	%r16,[%sp,16]                   ; @0x3b6
	std	%r22,[%sp,8]                    ; @0x3ba
	add	%r14,%r56,0x2000@u32            ; @0x3be
	bl	vekt_vec_sum                    ; @0x3c6
	bl	clock                           ; @0x3ca
	sub_s	%r0,%r0,%r13                    ; @0x3ce
	fint2d	%r20,%r0                        ; @0x3d0
	bl	_timer_clocks_per_sec           ; @0x3d4
	fuint2d	%r2,%r0                         ; @0x3d8
	fddiv	%r2,%r20,%r2                    ; @0x3dc
	mov_s	%r17,%r19                       ; @0x3e0
	mov_s	%r0,.L.str.10                   ; @0x3e2
	fdmul	%r18,%r2,%r16                   ; @0x3e8
	mov_s	%r1,%r18                        ; @0x3ec
	mov_s	%r2,%r19                        ; @0x3ee
	bl	printf                          ; @0x3f0
	ldd	%r2,[%sp,92]                    ; 8-byte Folded Reload
                                        ; @0x3f4
	ld_s	%r0,[%sp,88]                    ; 4-byte Folded Reload
                                        ; @0x3f8
	fddiv	%r2,%r2,%r18                    ; @0x3fa
	mov_s	%r1,%r2                         ; @0x3fe
	mov_s	%r2,%r3                         ; @0x400
	bl	printf                          ; @0x402
	mov_s	%r0,%r15                        ; @0x406
	bl	puts                            ; @0x408
	mov_s	%r13,%r16                       ; @0x40c
.LBB4_20:                               ; %for.body71
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x40e
	ld	%r6,[%r22,0]                    ; @0x40e
	ld	%r4,[%r24,0]                    ; @0x412
	ld_s	%r2,[%r14,0]                    ; @0x416
	mov_s	%r0,%fp                         ; @0x418
	mov_s	%r1,%r13                        ; @0x41a
	mov_s	%r3,%r13                        ; @0x41c
	mov_s	%r5,%r13                        ; @0x41e
	bl	printf                          ; @0x420
	add_s	%r14,%r14,4                     ; @0x424
	add_s	%r24,%r24,4                     ; @0x426
	add_s	%r22,%r22,4                     ; @0x428
	add_s	%r13,%r13,1                     ; @0x42a
	brlo	%r13,5,.LBB4_20                 ; @0x42c
	b_s	.LBB4_21                        ; @0x430
.LBB4_22:                               ; %if.then
                                        ; @0x432
	add	%r17,%r17,.Lstr-.L.str          ; @0x432
	mov_s	%r0,%r17                        ; @0x436
	bl	puts                            ; @0x438
	mov_s	%r16,1                          ; @0x43c
.LBB4_21:                               ; %cleanup
                                        ; @0x43e
	mov_s	%r0,%r16                        ; @0x43e
	add3	%r56,%r56,12288/8               ; @0x440
	add_s	%sp,%sp,32                      ; @0x444
	.cfa_pop	32                              ; @0x446
	ld	%blink,[%sp,52]                 ; @0x446
	.cfa_restore	{%blink}                ; @0x44a
	ld	%fp,[%sp,48]                    ; @0x44a
	.cfa_restore	{%fp}                   ; @0x44e
	ld	%r24,[%sp,44]                   ; @0x44e
	.cfa_restore	{%r24}                  ; @0x452
	ldd	%r22,[%sp,36]                   ; @0x452
	.cfa_restore	{%r23}                  ; @0x456
	.cfa_restore	{%r22}                  ; @0x456
	ldd	%r20,[%sp,28]                   ; @0x456
	.cfa_restore	{%r21}                  ; @0x45a
	.cfa_restore	{%r20}                  ; @0x45a
	ldd	%r18,[%sp,20]                   ; @0x45a
	.cfa_restore	{%r19}                  ; @0x45e
	.cfa_restore	{%r18}                  ; @0x45e
	ldd	%r16,[%sp,12]                   ; @0x45e
	.cfa_restore	{%r17}                  ; @0x462
	.cfa_restore	{%r16}                  ; @0x462
	ldd	%r14,[%sp,4]                    ; @0x462
	.cfa_restore	{%r15}                  ; @0x466
	.cfa_restore	{%r14}                  ; @0x466
	ld_s	%r13,[%sp,0]                    ; @0x466
	.cfa_restore	{%r13}                  ; @0x468
	add_s	%sp,%sp,68                      ; @0x468
	.cfa_pop	68                              ; @0x46a
	j_s	[%blink]                        ; @0x46a
	.cfa_ef
.Lfunc_end4:                            ; @0x46c

	.reloc	_init_ad,0	;startup code to enable %status AD bit ; -- End function
