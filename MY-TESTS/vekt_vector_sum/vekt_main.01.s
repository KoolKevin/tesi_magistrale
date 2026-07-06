	.option	%reg
	.off	assume_short
	.file	"vekt_main.c"
	.globl	a
	.size	a, 32768
	.type	a,@object
	.globl	b
	.size	b, 32768
	.type	b,@object
	.globl	c
	.size	c, 32768
	.type	c,@object
	.size	.L.str.2, 30
	.type	.L.str.2,@object
	.size	.Lstr.12, 30
	.type	.Lstr.12,@object
	.size	.L.str.6, 15
	.type	.L.str.6,@object
	.size	.L.str.4, 23
	.type	.L.str.4,@object
	.size	.Lstr.11, 27
	.type	.Lstr.11,@object
	.size	.L.str.8, 30
	.type	.L.str.8,@object
	.size	.L.str, 40
	.type	.L.str,@object
	.size	.L.str.5, 51
	.type	.L.str.5,@object
	.size	.L.str.9, 55
	.type	.L.str.9,@object
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
	.section	.rodata,"a",@progbits
.L.str.2:                               ; @0x0
	.asciz	"a[%d]=%d, b[%d]=%d, c[%d]=%d\n"
.Lstr.12:                               ; @0x1e
	.asciz	"Primi 5 elementi della somma:"
.L.str.6:                               ; @0x3c
	.asciz	"Speedup: %.2f\n"
.L.str.4:                               ; @0x4b
	.asciz	"Vettorizzo su %d lane\n"
.Lstr.11:                               ; @0x62
	.asciz	"Versione vekt-vettorizzata"
.L.str.8:                               ; @0x7d
	.asciz	"\tpuntatori array: %p, %p, %p\n"
.L.str:                                 ; @0x9b
	.asciz	"Tempo di esecuzione di vec_sum: %.2fms\n"
.L.str.5:                               ; @0xc3
	.asciz	"Tempo di esecuzione di vectorized_vec_sum: %.2fms\n"
.L.str.9:                               ; @0xf6
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
	sub_s	%sp,%sp,68                      ; @0x16
	.cfa_push	68                      ; @0x18
	mov_s	%r4,%r3                         ; @0x18
	mov_s	%r6,%r1                         ; @0x1a
	st	%r3,[%sp,64]                    ; @0x1c
	mov_s	%r3,%r2                         ; @0x20
	mov_s	%r7,%r1                         ; @0x22
	asr	%r5,%r4,31                      ; @0x24
	std	%r2,[%sp,32]                    ; @0x28
	std	%r6,[%sp,0]                     ; @0x2c
	mov_s	%r1,%r0                         ; @0x30
	mov_s	%r2,0                           ; @0x32
	mov_s	%r3,0                           ; @0x34
	mov_s	%r6,1                           ; @0x36
	mov_s	%r7,0                           ; @0x38
	std	1,[%sp,56]                      ; @0x3a
	std	0,[%sp,40]                      ; @0x3e
	std	1,[%sp,24]                      ; @0x42
	std	0,[%sp,8]                       ; @0x46
	std	%r4,[%sp,48]                    ; @0x4a
	std	%r4,[%sp,16]                    ; @0x4e
	bl	vekt_vec_sum                    ; @0x52
	add_s	%sp,%sp,68                      ; @0x56
	.cfa_pop	68                              ; @0x58
	ld	%blink,[%sp,0]                  ; @0x58
	.cfa_restore	{%blink}                ; @0x5c
	add_s	%sp,%sp,4                       ; @0x5c
	.cfa_pop	4                               ; @0x5e
	j_s	[%blink]                        ; @0x5e
	.cfa_ef
.Lfunc_end1:                            ; @0x60

	.align	4                               ; -- End function
                                        ; -- Begin function vec_sum
vec_sum:                                ; @vec_sum
                                        ; @0x60
.Lvec_sum$local:                        ; @0x60
	.cfa_bf	.Lvec_sum$local
;  %bb.0:                               ; %entry
	.cfa_same	%r30                    ; @0x60
	.cfa_same	%r9                     ; @0x60
	.cfa_same	%r7                     ; @0x60
	.cfa_same	%r6                     ; @0x60
	.cfa_same	%r5                     ; @0x60
	.cfa_same	%r4                     ; @0x60
	.cfa_same	%r3                     ; @0x60
	brlt	%r3,1,.LBB2_3                   ; @0x60
;  %bb.1:                               ; %for.body.preheader
	mov_s	%r8,0                           ; @0x64
.LBB2_2:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x66
	ld	%r11,[%r0,0]                    ; @0x66
	ld_s	%r12,[%r1,0]                    ; @0x6a
	add_s	%r0,%r0,4                       ; @0x6c
	add	%r11,%r12,%r11                  ; @0x6e
	st	%r11,[%r2,0]                    ; @0x72
	add_s	%r1,%r1,4                       ; @0x76
	add_s	%r2,%r2,4                       ; @0x78
	add_s	%r8,%r8,1                       ; @0x7a
	brlt	%r8,%r3,.LBB2_2                 ; @0x7c
.LBB2_3:                                ; %for.cond.cleanup
                                        ; @0x80
	j_s	[%blink]                        ; @0x80
	.cfa_ef
.Lfunc_end2:                            ; @0x82

	.align	4                               ; -- End function
                                        ; -- Begin function vectorized_vec_sum
vectorized_vec_sum:                     ; @vectorized_vec_sum
                                        ; @0x84
.Lvectorized_vec_sum$local:             ; @0x84
	.cfa_bf	.Lvectorized_vec_sum$local
;  %bb.0:                               ; %entry
	.cfa_same	%r30                    ; @0x84
	.cfa_same	%r11                    ; @0x84
	.cfa_same	%r9                     ; @0x84
	.cfa_same	%r8                     ; @0x84
	.cfa_same	%r7                     ; @0x84
	.cfa_same	%r6                     ; @0x84
	.cfa_same	%r5                     ; @0x84
	.cfa_same	%r4                     ; @0x84
	brlt	%r3,16,.LBB3_3                  ; @0x84
;  %bb.1:                               ; %for.body.preheader
	asr	%r12,%r3,31                     ; @0x88
	lsr_s	%r12,%r12,28                    ; @0x8c
	add_s	%r3,%r3,%r12                    ; @0x8e
	asr_s	%r3,%r3,4                       ; @0x90
	mov_s	%r12,0                          ; @0x92
.LBB3_2:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x94
.vvsbundle  "v1sc" 
 ;	 { 
	vvld.w	%vr0,%r1                        ; @0x94
	add1	%r1,%r1,64/2                    ; @0x94
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvld.w	%vr1,%r0                        ; @0x9c
	add1	%r0,%r0,64/2                    ; @0x9c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvadd.w	%vr0, %vr1, %vr0                ; @0xa4
	add_s	%r12,%r12,1                     ; @0xa4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvst.w	%vr0,%r2                        ; @0xac
	add1	%r2,%r2,64/2                    ; @0xac
 ;	 }
	brlt	%r12,%r3,.LBB3_2                ; @0xb4
.LBB3_3:                                ; %for.cond.cleanup
                                        ; @0xb8
	j_s	[%blink]                        ; @0xb8
	.cfa_ef
.Lfunc_end3:                            ; @0xba

	.align	4                               ; -- End function
                                        ; -- Begin function main
main:                                   ; @main
                                        ; @0xbc
.Lmain$local:                           ; @0xbc
	.cfa_bf	.Lmain$local
;  %bb.0:                               ; %entry
	sub_s	%sp,%sp,68                      ; @0xbc
	.cfa_push	68                      ; @0xbe
	st	%r13,[%sp,0]                    ; @0xbe
	.cfa_reg_offset	{%r13}, 0               ; @0xc2
	std	%r14,[%sp,4]                    ; @0xc2
	.cfa_reg_offset	{%r14}, 4               ; @0xc6
	.cfa_reg_offset	{%r15}, 8               ; @0xc6
	std	%r16,[%sp,12]                   ; @0xc6
	.cfa_reg_offset	{%r16}, 12              ; @0xca
	.cfa_reg_offset	{%r17}, 16              ; @0xca
	std	%r18,[%sp,20]                   ; @0xca
	.cfa_reg_offset	{%r18}, 20              ; @0xce
	.cfa_reg_offset	{%r19}, 24              ; @0xce
	std	%r20,[%sp,28]                   ; @0xce
	.cfa_reg_offset	{%r20}, 28              ; @0xd2
	.cfa_reg_offset	{%r21}, 32              ; @0xd2
	std	%r22,[%sp,36]                   ; @0xd2
	.cfa_reg_offset	{%r22}, 36              ; @0xd6
	.cfa_reg_offset	{%r23}, 40              ; @0xd6
	st	%r24,[%sp,44]                   ; @0xd6
	.cfa_reg_offset	{%r24}, 44              ; @0xda
	st	%fp,[%sp,48]                    ; @0xda
	.cfa_reg_offset	{%fp}, 48               ; @0xde
	st	%blink,[%sp,52]                 ; @0xde
	.cfa_reg_offset	{%blink}, 52            ; @0xe2
	sub_s	%sp,%sp,68                      ; @0xe2
	.cfa_push	68                      ; @0xe4
	mov_s	%r18,b                          ; @0xe4
	mov_s	%r24,a                          ; @0xea
	mov_s	%r15,0                          ; @0xf0
	mov_s	%r22,0x2000@u32                 ; @0xf2
	mov_s	%r0,%r24                        ; @0xf8
	mov_s	%r1,%r18                        ; @0xfa
	mov_s	%r2,0                           ; @0xfc
.LBB4_1:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0xfe
	add_s	%r2,%r2,1                       ; @0xfe
	st_s	%r2,[%r1,0]                     ; @0x100
	st_s	%r2,[%r0,0]                     ; @0x102
	add_s	%r0,%r0,4                       ; @0x104
	add_s	%r1,%r1,4                       ; @0x106
	brlo	%r2,%r22,.LBB4_1                ; @0x108
;  %bb.2:                               ; %for.body.i.preheader
	mov_s	%r20,c                          ; @0x10c
	mov_s	%r0,%r20                        ; @0x112
	mov_s	%r1,0                           ; @0x114
.LBB4_3:                                ; %for.body.i
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x116
	st	-1,[%r0,0]                      ; @0x116
	add_s	%r0,%r0,4                       ; @0x11a
	add_s	%r1,%r1,1                       ; @0x11c
	brlo	%r1,%r22,.LBB4_3                ; @0x11e
;  %bb.4:                               ; %init_vector.exit
	bl	clock                           ; @0x122
	mov_s	%r16,%r0                        ; @0x126
	mov_s	%r0,%r24                        ; @0x128
	mov_s	%r1,%r18                        ; @0x12a
	mov_s	%r2,%r20                        ; @0x12c
.LBB4_5:                                ; %for.body.i114
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x12e
	ld_s	%r3,[%r0,0]                     ; @0x12e
	ld_s	%r12,[%r1,0]                    ; @0x130
	add_s	%r0,%r0,4                       ; @0x132
	add_s	%r3,%r12,%r3                    ; @0x134
	st_s	%r3,[%r2,0]                     ; @0x136
	add_s	%r1,%r1,4                       ; @0x138
	add_s	%r2,%r2,4                       ; @0x13a
	add_s	%r15,%r15,1                     ; @0x13c
	brlo	%r15,%r22,.LBB4_5               ; @0x13e
;  %bb.6:                               ; %vec_sum.exit
	bl	clock                           ; @0x142
	sub	%r0,%r0,%r16                    ; @0x146
	fint2d	%r14,%r0                        ; @0x14a
	bl	_timer_clocks_per_sec           ; @0x14e
	fuint2d	%r2,%r0                         ; @0x152
	fddiv	%r2,%r14,%r2                    ; @0x156
	mov_s	%r17,0x408f4000@u32             ; @0x15a
	mov_s	%r16,0                          ; @0x160
	mov_s	%r21,.L.str.5                   ; @0x162
	sub	%r0,%r21,.L.str.5-.L.str        ; @0x168
	fdmul	%r2,%r2,%r16                    ; @0x16c
	mov_s	%r1,%r2                         ; @0x170
	std	%r2,[%sp,124]                   ; 8-byte Folded Spill
                                        ; @0x172
	mov_s	%r2,%r3                         ; @0x176
	bl	printf                          ; @0x178
	mov_s	%r23,.L.str.6                   ; @0x17c
	sub	%r19,%r23,.L.str.6-.Lstr.12     ; @0x182
	mov_s	%r0,%r19                        ; @0x186
	bl	puts                            ; @0x188
	sub	%fp,%r23,.L.str.6-.L.str.2      ; @0x18c
	mov_s	%r15,%r24                       ; @0x190
	mov_s	%r14,%r18                       ; @0x192
	mov_s	%r13,%r20                       ; @0x194
.LBB4_7:                                ; %for.body13
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x196
	ld	%r6,[%r13,0]                    ; @0x196
	ld	%r4,[%r14,0]                    ; @0x19a
	ld_s	%r2,[%r15,0]                    ; @0x19e
	mov_s	%r0,%fp                         ; @0x1a0
	mov_s	%r1,%r16                        ; @0x1a2
	mov_s	%r3,%r16                        ; @0x1a4
	mov_s	%r5,%r16                        ; @0x1a6
	bl	printf                          ; @0x1a8
	add_s	%r15,%r15,4                     ; @0x1ac
	add_s	%r14,%r14,4                     ; @0x1ae
	add_s	%r13,%r13,4                     ; @0x1b0
	add_s	%r16,%r16,1                     ; @0x1b2
	brlo	%r16,5,.LBB4_7                  ; @0x1b4
;  %bb.8:                               ; %for.cond.cleanup12
	mov_s	%r0,10                          ; @0x1b8
	bl	putchar                         ; @0x1ba
	add	%r0,%r23,.L.str.4-.L.str.6      ; @0x1be
	mov_s	%r1,16                          ; @0x1c2
	bl	printf                          ; @0x1c4
	mov_s	%r15,0                          ; @0x1c8
	mov_s	%r0,%r20                        ; @0x1ca
	mov_s	%r1,0                           ; @0x1cc
.LBB4_9:                                ; %for.body.i118
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x1ce
	st	-1,[%r0,0]                      ; @0x1ce
	add_s	%r0,%r0,4                       ; @0x1d2
	add_s	%r1,%r1,1                       ; @0x1d4
	brlo	%r1,%r22,.LBB4_9                ; @0x1d6
;  %bb.10:                              ; %init_vector.exit123
	bl	clock                           ; @0x1da
	mov_s	%r16,%r0                        ; @0x1de
	mov_s	%r0,%r24                        ; @0x1e0
	mov_s	%r1,%r18                        ; @0x1e2
	mov_s	%r2,%r20                        ; @0x1e4
.LBB4_11:                               ; %for.body.i124
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x1e6
.vvsbundle  "v1sc" 
 ;	 { 
	vvld.w	%vr0,%r1                        ; @0x1e6
	add1	%r1,%r1,64/2                    ; @0x1e6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvld.w	%vr1,%r0                        ; @0x1ee
	add1	%r0,%r0,64/2                    ; @0x1ee
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvadd.w	%vr0, %vr1, %vr0                ; @0x1f6
	add_s	%r15,%r15,1                     ; @0x1f6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvst.w	%vr0,%r2                        ; @0x1fe
	add1	%r2,%r2,64/2                    ; @0x1fe
 ;	 }
	cmp	%r15,512                        ; @0x206
	bcs	.LBB4_11                        ; @0x20a
;  %bb.12:                              ; %vectorized_vec_sum.exit
	bl	clock                           ; @0x20e
	sub	%r0,%r0,%r16                    ; @0x212
	fint2d	%r14,%r0                        ; @0x216
	bl	_timer_clocks_per_sec           ; @0x21a
	fuint2d	%r2,%r0                         ; @0x21e
	fddiv	%r2,%r14,%r2                    ; @0x222
	mov_s	%r16,0                          ; @0x226
	mov_s	%r0,%r21                        ; @0x228
	fdmul	%r14,%r2,%r16                   ; @0x22a
	mov_s	%r1,%r14                        ; @0x22e
	mov_s	%r2,%r15                        ; @0x230
	bl	printf                          ; @0x232
	ldd	%r2,[%sp,124]                   ; 8-byte Folded Reload
                                        ; @0x236
	mov_s	%r0,%r23                        ; @0x23a
	fddiv	%r2,%r2,%r14                    ; @0x23c
	mov_s	%r1,%r2                         ; @0x240
	mov_s	%r2,%r3                         ; @0x242
	bl	printf                          ; @0x244
	mov_s	%r0,%r19                        ; @0x248
	bl	puts                            ; @0x24a
	mov_s	%r15,%r24                       ; @0x24e
	mov_s	%r14,%r18                       ; @0x250
	mov_s	%r13,%r20                       ; @0x252
.LBB4_13:                               ; %for.body40
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x254
	ld	%r6,[%r13,0]                    ; @0x254
	ld	%r4,[%r14,0]                    ; @0x258
	ld_s	%r2,[%r15,0]                    ; @0x25c
	mov_s	%r0,%fp                         ; @0x25e
	mov_s	%r1,%r16                        ; @0x260
	mov_s	%r3,%r16                        ; @0x262
	mov_s	%r5,%r16                        ; @0x264
	bl	printf                          ; @0x266
	add_s	%r15,%r15,4                     ; @0x26a
	add_s	%r14,%r14,4                     ; @0x26c
	add_s	%r13,%r13,4                     ; @0x26e
	add_s	%r16,%r16,1                     ; @0x270
	brlo	%r16,5,.LBB4_13                 ; @0x272
;  %bb.14:                              ; %for.cond.cleanup39
	mov_s	%r0,10                          ; @0x276
	st	%r19,[%sp,132]                  ; 4-byte Folded Spill
                                        ; @0x278
	bl	putchar                         ; @0x27c
	add	%r0,%r23,.Lstr.11-.L.str.6      ; @0x280
	bl	puts                            ; @0x284
	sub1	%r0,%r21,(.L.str.5-.L.str.8)/2  ; @0x288
	mov_s	%r1,%r24                        ; @0x28c
	mov_s	%r2,%r18                        ; @0x28e
	mov_s	%r3,%r20                        ; @0x290
	mov_s	%r13,%r21                       ; @0x292
	bl	printf                          ; @0x294
	mov_s	%r23,0                          ; @0x298
	mov_s	%r0,%r20                        ; @0x29a
	mov_s	%r1,0                           ; @0x29c
.LBB4_15:                               ; %for.body.i129
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x29e
	st	-1,[%r0,0]                      ; @0x29e
	add_s	%r0,%r0,4                       ; @0x2a2
	add_s	%r1,%r1,1                       ; @0x2a4
	brlo	%r1,%r22,.LBB4_15               ; @0x2a6
;  %bb.16:                              ; %init_vector.exit134
	bl	clock                           ; @0x2aa
	mov_s	%r16,%r0                        ; @0x2ae
	mov_s	%r21,%r20                       ; @0x2b0
	mov_s	%r19,%r18                       ; @0x2b2
	mov_s	%r0,%r24                        ; @0x2b4
	mov_s	%r1,%r24                        ; @0x2b6
	mov_s	%r2,0                           ; @0x2b8
	mov_s	%r3,0                           ; @0x2ba
	mov_s	%r4,%r22                        ; @0x2bc
	mov_s	%r5,0                           ; @0x2be
	mov_s	%r6,1                           ; @0x2c0
	mov_s	%r7,0                           ; @0x2c2
	st	%r22,[%sp,64]                   ; @0x2c4
	std	1,[%sp,56]                      ; @0x2c8
	std	%r22,[%sp,48]                   ; @0x2cc
	std	0,[%sp,40]                      ; @0x2d0
	std	%r20,[%sp,32]                   ; @0x2d4
	std	1,[%sp,24]                      ; @0x2d8
	std	%r22,[%sp,16]                   ; @0x2dc
	std	0,[%sp,8]                       ; @0x2e0
	std	%r18,[%sp,0]                    ; @0x2e4
	bl	vekt_vec_sum                    ; @0x2e8
	bl	clock                           ; @0x2ec
	sub	%r0,%r0,%r16                    ; @0x2f0
	fint2d	%r14,%r0                        ; @0x2f4
	bl	_timer_clocks_per_sec           ; @0x2f8
	fuint2d	%r2,%r0                         ; @0x2fc
	fddiv	%r2,%r14,%r2                    ; @0x300
	mov_s	%r16,%r23                       ; @0x304
	add_s	%r0,%r13,.L.str.9-.L.str.5      ; @0x306
	fdmul	%r14,%r2,%r16                   ; @0x308
	mov_s	%r1,%r14                        ; @0x30c
	mov_s	%r2,%r15                        ; @0x30e
	bl	printf                          ; @0x310
	ldd	%r2,[%sp,124]                   ; 8-byte Folded Reload
                                        ; @0x314
	mov_s	%r0,.L.str.6                    ; @0x318
	fddiv	%r2,%r2,%r14                    ; @0x31e
	mov_s	%r1,%r2                         ; @0x322
	mov_s	%r2,%r3                         ; @0x324
	bl	printf                          ; @0x326
	ld	%r0,[%sp,132]                   ; 4-byte Folded Reload
                                        ; @0x32a
	bl	puts                            ; @0x32e
.LBB4_17:                               ; %for.body68
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x332
	ld	%r6,[%r20,0]                    ; @0x332
	ld	%r4,[%r18,0]                    ; @0x336
	ld_s	%r2,[%r24,0]                    ; @0x33a
	mov_s	%r0,%fp                         ; @0x33c
	mov_s	%r1,%r23                        ; @0x33e
	mov_s	%r3,%r23                        ; @0x340
	mov_s	%r5,%r23                        ; @0x342
	bl	printf                          ; @0x344
	add_s	%r24,%r24,4                     ; @0x348
	add_s	%r18,%r18,4                     ; @0x34a
	add_s	%r20,%r20,4                     ; @0x34c
	add_s	%r23,%r23,1                     ; @0x34e
	brlo	%r23,5,.LBB4_17                 ; @0x350
;  %bb.18:                              ; %for.cond.cleanup67
	mov_s	%r0,0                           ; @0x354
	add_s	%sp,%sp,68                      ; @0x356
	.cfa_pop	68                              ; @0x358
	ld	%blink,[%sp,52]                 ; @0x358
	.cfa_restore	{%blink}                ; @0x35c
	ld	%fp,[%sp,48]                    ; @0x35c
	.cfa_restore	{%fp}                   ; @0x360
	ld	%r24,[%sp,44]                   ; @0x360
	.cfa_restore	{%r24}                  ; @0x364
	ldd	%r22,[%sp,36]                   ; @0x364
	.cfa_restore	{%r23}                  ; @0x368
	.cfa_restore	{%r22}                  ; @0x368
	ldd	%r20,[%sp,28]                   ; @0x368
	.cfa_restore	{%r21}                  ; @0x36c
	.cfa_restore	{%r20}                  ; @0x36c
	ldd	%r18,[%sp,20]                   ; @0x36c
	.cfa_restore	{%r19}                  ; @0x370
	.cfa_restore	{%r18}                  ; @0x370
	ldd	%r16,[%sp,12]                   ; @0x370
	.cfa_restore	{%r17}                  ; @0x374
	.cfa_restore	{%r16}                  ; @0x374
	ldd	%r14,[%sp,4]                    ; @0x374
	.cfa_restore	{%r15}                  ; @0x378
	.cfa_restore	{%r14}                  ; @0x378
	ld_s	%r13,[%sp,0]                    ; @0x378
	.cfa_restore	{%r13}                  ; @0x37a
	add_s	%sp,%sp,68                      ; @0x37a
	.cfa_pop	68                              ; @0x37c
	j_s	[%blink]                        ; @0x37c
	.cfa_ef
.Lfunc_end4:                            ; @0x37e

	.reloc	_init_ad,0	;startup code to enable %status AD bit ; -- End function
