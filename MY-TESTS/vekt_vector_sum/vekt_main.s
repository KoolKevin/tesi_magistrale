	.option	%reg
	.off	assume_short
	.file	"vekt_main.c"
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
	.ident	"LLVM 17.0.7/V-2024.06. (build 008) (LLVM 17.0.7) -arcv2hs -core4 -Xcode_density -Xatomic -Xll64 -Xunaligned -Xdiv_rem=radix4 -Xswap -Xbitscan -Xmpy_option=mpyd -Xshift_assist -Xbarrel_shifter -Xfpud_div -Xfpu_mac -Xtimer0 -Xrtc -Xstack_check -Xstu=4 -Xvdsp4 -Xvec_unit_rev_minor=1 -Xvec_width=512 -Xvec_mem_size=128k -Xvec_mem_bank_width=16 -Xvec_max_fetch_size=16 -Xvec_num_slots=3 -Xvec_super_with_scalar -Xvec_regs=32 -Xvec_fpu=32 -Xvec_fpu_math=3 -Xvec_fpu_2nd_mul -Xvec_fpu_types=2 -Xvec_num_rd_ports=6 -Xvec_num_acc=8 -Xvec_num_mpy=2 -Xvec_mpy32 -Xvec_num_alu=3 -Xvec_guard_bit_option=0 -Xvec_stack_check -Hvdsp_vector_c -O2"
	.align	8                               ; -- Begin function init_vector
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
	sub.f	%lp_count,%r1,0                 ; @0x0
	.cfa_remember_state                     ; @0x4
	jle	[%blink]                        ; @0x4
	.cfa_restore_state                      ; @0x8
;  %bb.1:                               ; %for.body.preheader
	; Implicit def %r3                      ; @0x8
	lp	.LZD0                           ; @0x8
.LBB0_2:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0xc
	st.ab	%r2,[%r0,4]                     ; @0xc
.LZD0:                                  ; @0x10
	; ZD Loop End                           ; @0x10
;  %bb.3:                               ; %for.cond.cleanup
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
	std.aw	%r22,[%sp,-12]                  ; @0x14
	.cfa_push	12                      ; @0x18
	.cfa_reg_offset	{%r22}, 0               ; @0x18
	.cfa_reg_offset	{%r23}, 4               ; @0x18
	st	%blink,[%sp,8]                  ; @0x18
	.cfa_reg_offset	{%blink}, 8             ; @0x1c
	sub_s	%sp,%sp,68                      ; @0x1c
	.cfa_push	68                      ; @0x1e
	asr	%r5,%r3,31                      ; @0x1e
	mov_s	%r4,%r3                         ; @0x22
	mov_s	%r8,%r2                         ; @0x24
	mov_s	%r22,%r1                        ; @0x26
	mov_s	%r9,%r2                         ; @0x28
	mov_s	%r23,%r1                        ; @0x2a
	mov_s	%r1,%r0                         ; @0x2c
	mov_s	%r2,0                           ; @0x2e
	mov_s	%r3,0                           ; @0x30
	mov_s	%r6,1                           ; @0x32
	mov_s	%r7,0                           ; @0x34
	st	%r4,[%sp,64]                    ; @0x36
	std	1,[%sp,56]                      ; @0x3a
	std	0,[%sp,40]                      ; @0x3e
	std	%r8,[%sp,32]                    ; @0x42
	std	1,[%sp,24]                      ; @0x46
	std	0,[%sp,8]                       ; @0x4a
	std	%r22,[%sp,0]                    ; @0x4e
	std	%r4,[%sp,48]                    ; @0x52
	std	%r4,[%sp,16]                    ; @0x56
	bl	vekt_vec_sum                    ; @0x5a
	add_s	%sp,%sp,68                      ; @0x5e
	.cfa_pop	68                              ; @0x60
	ld	%blink,[%sp,8]                  ; @0x60
	.cfa_restore	{%blink}                ; @0x64
	ldd.ab	%r22,[%sp,12]                   ; @0x64
	.cfa_restore	{%r23}                  ; @0x68
	.cfa_restore	{%r22}                  ; @0x68
	.cfa_pop	12                              ; @0x68
	j_s	[%blink]                        ; @0x68
	.cfa_ef
.Lfunc_end1:                            ; @0x6a

	.align	4                               ; -- End function
                                        ; -- Begin function vec_sum
vec_sum:                                ; @vec_sum
                                        ; @0x6c
.Lvec_sum$local:                        ; @0x6c
	.cfa_bf	.Lvec_sum$local
;  %bb.0:                               ; %entry
	.cfa_same	%r30                    ; @0x6c
	.cfa_same	%r11                    ; @0x6c
	.cfa_same	%r9                     ; @0x6c
	.cfa_same	%r8                     ; @0x6c
	.cfa_same	%r7                     ; @0x6c
	.cfa_same	%r6                     ; @0x6c
	.cfa_same	%r5                     ; @0x6c
	.cfa_same	%r4                     ; @0x6c
	sub.f	%lp_count,%r3,0                 ; @0x6c
	.cfa_remember_state                     ; @0x70
	jle	[%blink]                        ; @0x70
	.cfa_restore_state                      ; @0x74
;  %bb.1:                               ; %for.body.preheader
	; Implicit def %r12                     ; @0x74
	nop                                     ; inserted to benefit BPU
                                        ; @0x74
	lp	.LZD1                           ; @0x78
.LBB2_2:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x7c
	ld.ab	%r3,[%r0,4]                     ; @0x7c
	ld.ab	%r12,[%r1,4]                    ; @0x80
	add_s	%r3,%r12,%r3                    ; @0x84
	st.ab	%r3,[%r2,4]                     ; @0x86
.LZD1:                                  ; @0x8a
	; ZD Loop End                           ; @0x8a
;  %bb.3:                               ; %for.cond.cleanup
	j_s	[%blink]                        ; @0x8a
	.cfa_ef
.Lfunc_end2:                            ; @0x8c

	.align	4                               ; -- End function
                                        ; -- Begin function vectorized_vec_sum
vectorized_vec_sum:                     ; @vectorized_vec_sum
                                        ; @0x8c
.Lvectorized_vec_sum$local:             ; @0x8c
	.cfa_bf	.Lvectorized_vec_sum$local
;  %bb.0:                               ; %entry
	.cfa_same	%r30                    ; @0x8c
	.cfa_same	%r11                    ; @0x8c
	.cfa_same	%r9                     ; @0x8c
	.cfa_same	%r8                     ; @0x8c
	.cfa_same	%r7                     ; @0x8c
	.cfa_same	%r6                     ; @0x8c
	.cfa_same	%r5                     ; @0x8c
	.cfa_same	%r4                     ; @0x8c
	cmp	%r3,16                          ; widened to benefit BPU
                                        ; @0x8c
	.cfa_remember_state                     ; @0x90
	jlt	[%blink]                        ; @0x90
	.cfa_restore_state                      ; @0x94
;  %bb.1:                               ; %for.body.preheader
	asr	%r12,%r3,31                     ; @0x94
	lsr_s	%r12,%r12,28                    ; @0x98
	add_s	%r3,%r3,%r12                    ; @0x9a
	; Implicit def %r12                     ; @0x9c
	asr	%lp_count,%r3,4                 ; @0x9c
	lp	.LZD2                           ; @0xa0
.LBB3_2:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0xa4
	vvld.av.w	%vr0,%r1,1              ; @0xa4
	vvld.av.w	%vr1,%r0,1              ; @0xaa
	vvadd.w	%vr0, %vr1, %vr0                ; @0xb0
	vvst.av.w	%vr0,%r2,1              ; @0xb6
.LZD2:                                  ; @0xbc
	; ZD Loop End                           ; @0xbc
;  %bb.3:                               ; %for.cond.cleanup
	j_s	[%blink]                        ; @0xbc
	.cfa_ef
.Lfunc_end3:                            ; @0xbe

	.align	4                               ; -- End function
                                        ; -- Begin function main
main:                                   ; @main
                                        ; @0xc0
.Lmain$local:                           ; @0xc0
	.cfa_bf	.Lmain$local
;  %bb.0:                               ; %entry
	st.aw	%r13,[%sp,-68]                  ; @0xc0
	.cfa_push	68                      ; @0xc4
	.cfa_reg_offset	{%r13}, 0               ; @0xc4
	std	%r14,[%sp,4]                    ; @0xc4
	.cfa_reg_offset	{%r14}, 4               ; @0xc8
	.cfa_reg_offset	{%r15}, 8               ; @0xc8
	std	%r16,[%sp,12]                   ; @0xc8
	.cfa_reg_offset	{%r16}, 12              ; @0xcc
	.cfa_reg_offset	{%r17}, 16              ; @0xcc
	std	%r18,[%sp,20]                   ; @0xcc
	.cfa_reg_offset	{%r18}, 20              ; @0xd0
	.cfa_reg_offset	{%r19}, 24              ; @0xd0
	std	%r20,[%sp,28]                   ; @0xd0
	.cfa_reg_offset	{%r20}, 28              ; @0xd4
	.cfa_reg_offset	{%r21}, 32              ; @0xd4
	std	%r22,[%sp,36]                   ; @0xd4
	.cfa_reg_offset	{%r22}, 36              ; @0xd8
	.cfa_reg_offset	{%r23}, 40              ; @0xd8
	st	%r24,[%sp,44]                   ; @0xd8
	.cfa_reg_offset	{%r24}, 44              ; @0xdc
	st	%fp,[%sp,48]                    ; @0xdc
	.cfa_reg_offset	{%fp}, 48               ; @0xe0
	st	%blink,[%sp,52]                 ; @0xe0
	.cfa_reg_offset	{%blink}, 52            ; @0xe4
	sub_s	%sp,%sp,68                      ; @0xe4
	.cfa_push	68                      ; @0xe6
	; Implicit def %r12                     ; @0xe6
	mov_s	%r14,b                          ; @0xe6
	mov_s	%r24,a                          ; @0xec
	mov	%lp_count,0x1000@u32            ; @0xf2
	mov_s	%r0,%r14                        ; @0xfa
	mov_s	%r1,%r24                        ; @0xfc
	mov_s	%r3,0                           ; @0xfe
	lp	.LZD8                           ; @0x100
.LBB4_1:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x104
	add_s	%r2,%r3,1                       ; @0x104
	add_s	%r3,%r3,2                       ; @0x106
	std.ab	%r2,[%r1,8]                     ; @0x108
	std.ab	%r2,[%r0,8]                     ; @0x10c
.LZD8:                                  ; @0x110
	; ZD Loop End                           ; @0x110
;  %bb.6:                               ; %for.body.i.preheader
	; Implicit def %r2                      ; @0x110
	mov_s	%r22,c                          ; @0x110
	mov	%lp_count,0x1000@u32            ; @0x116
	mov_s	%r0,%r22                        ; @0x11e
	lp	.LZD7                           ; @0x120
.LBB4_7:                                ; %for.body.i
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x124
	std.ab	-1,[%r0,8]                      ; @0x124
.LZD7:                                  ; @0x128
	; ZD Loop End                           ; @0x128
;  %bb.2:                               ; %init_vector.exit
	nop                                     ; inserted to benefit BPU
                                        ; @0x128
	nop                                     ; inserted to benefit BPU
                                        ; @0x12c
	bl	clock                           ; @0x130
	; Implicit def %r12                     ; @0x134
	mov_s	%r13,%r0                        ; @0x134
	mov	%lp_count,0x1000@u32            ; @0x136
	mov_s	%r0,%r24                        ; @0x13e
	mov_s	%r1,%r14                        ; @0x140
	mov_s	%r2,%r22                        ; @0x142
	lp	.LZD6                           ; @0x144
.LBB4_3:                                ; %for.body.i114
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x148
	ldd.ab	%r4,[%r0,8]                     ; @0x148
	ldd.ab	%r6,[%r1,8]                     ; @0x14c
	add	%r5,%r7,%r5                     ; @0x150
	add	%r4,%r6,%r4                     ; @0x154
	std.ab	%r4,[%r2,8]                     ; @0x158
.LZD6:                                  ; @0x15c
	; ZD Loop End                           ; @0x15c
;  %bb.4:                               ; %vec_sum.exit
	nop                                     ; inserted to benefit BPU
                                        ; @0x15c
	bl	clock                           ; @0x160
	sub_s	%r0,%r0,%r13                    ; @0x164
	fint2d	%r16,%r0                        ; @0x166
	bl	_timer_clocks_per_sec           ; @0x16a
	fuint2d	%r2,%r0                         ; @0x16e
	fddiv	%r2,%r16,%r2                    ; @0x172
	mov_s	%r17,0x408f4000@u32             ; @0x176
	mov_s	%r16,0                          ; @0x17c
	mov_s	%r23,.L.str.5                   ; @0x17e
	sub	%r0,%r23,.L.str.5-.L.str        ; @0x184
	fdmul	%r20,%r2,%r16                   ; @0x188
	mov_s	%r1,%r20                        ; @0x18c
	mov_s	%r2,%r21                        ; @0x18e
	bl	printf                          ; @0x190
	mov_s	%r15,.L.str.6                   ; @0x194
	sub	%r13,%r15,.L.str.6-.Lstr.12     ; @0x19a
	mov_s	%r0,%r13                        ; @0x19e
	bl	puts                            ; @0x1a0
	ld_s	%r2,[%r24,0]                    ; @0x1a4
	ld	%r4,[%r14,0]                    ; @0x1a6
	ld	%r6,[%r22,0]                    ; @0x1aa
	sub	%fp,%r15,.L.str.6-.L.str.2      ; @0x1ae
	mov_s	%r0,%fp                         ; @0x1b2
	mov_s	%r1,0                           ; @0x1b4
	mov_s	%r3,0                           ; @0x1b6
	mov_s	%r5,0                           ; @0x1b8
	bl	printf                          ; @0x1ba
	ld_s	%r2,[%r24,4]                    ; @0x1be
	ld	%r4,[%r14,4]                    ; @0x1c0
	ld	%r6,[%r22,4]                    ; @0x1c4
	mov_s	%r0,%fp                         ; @0x1c8
	mov_s	%r1,1                           ; @0x1ca
	mov_s	%r3,1                           ; @0x1cc
	mov_s	%r5,1                           ; @0x1ce
	bl	printf                          ; @0x1d0
	ld_s	%r2,[%r24,8]                    ; @0x1d4
	ld	%r4,[%r14,8]                    ; @0x1d6
	ld	%r6,[%r22,8]                    ; @0x1da
	mov_s	%r0,%fp                         ; @0x1de
	mov_s	%r1,2                           ; @0x1e0
	mov_s	%r3,2                           ; @0x1e2
	mov_s	%r5,2                           ; @0x1e4
	bl	printf                          ; @0x1e6
	ld_s	%r2,[%r24,12]                   ; @0x1ea
	ld	%r4,[%r14,12]                   ; @0x1ec
	ld	%r6,[%r22,12]                   ; @0x1f0
	mov_s	%r0,%fp                         ; @0x1f4
	mov_s	%r1,3                           ; @0x1f6
	mov_s	%r3,3                           ; @0x1f8
	mov_s	%r5,3                           ; @0x1fa
	bl	printf                          ; @0x1fc
	ld_s	%r2,[%r24,16]                   ; @0x200
	ld	%r4,[%r14,16]                   ; @0x202
	ld	%r6,[%r22,16]                   ; @0x206
	mov_s	%r0,%fp                         ; @0x20a
	mov_s	%r1,4                           ; @0x20c
	mov_s	%r3,4                           ; @0x20e
	mov_s	%r5,4                           ; @0x210
	bl	printf                          ; @0x212
	mov_s	%r0,10                          ; @0x216
	bl	putchar                         ; @0x218
	add_s	%r0,%r15,.L.str.4-.L.str.6      ; @0x21c
	mov_s	%r1,16                          ; @0x21e
	bl	printf                          ; @0x220
	; Implicit def %r2                      ; @0x224
	mov	%lp_count,0x1000@u32            ; @0x224
	mov_s	%r0,%r22                        ; @0x22c
	lp	.LZD5                           ; @0x22e
.LBB4_5:                                ; %for.body.i118
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x232
	std.ab	-1,[%r0,8]                      ; @0x232
.LZD5:                                  ; @0x236
	; ZD Loop End                           ; @0x236
;  %bb.8:                               ; %init_vector.exit123
	nop_s                                   ; inserted to benefit BPU
                                        ; @0x236
	bl	clock                           ; @0x238
	; Implicit def %r12                     ; @0x23c
	mov_s	%r15,%r0                        ; @0x23c
	mov	%lp_count,256                   ; @0x23e
	mov_s	%r0,%r22                        ; @0x242
	mov_s	%r1,%r14                        ; @0x244
	mov_s	%r2,%r24                        ; @0x246
	lp	.LZD4                           ; @0x248
.LBB4_9:                                ; %for.body.i124
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x24c
	vvld.av.w	%vr0,%r1,1              ; @0x24c
	vvld.av.w	%vr1,%r2,1              ; @0x252
.vvsbundle  " v2" 
 ;	 { 
	vvld.av.w	%vr1,%r1,1              ; @0x258
	vvadd.w	%vr0, %vr1, %vr0                ; @0x258
 ;	 }
	vvld.av.w	%vr2,%r2,1              ; @0x262
.vvsbundle  " v2" 
 ;	 { 
	vvst.av.w	%vr0,%r0,1              ; @0x268
	vvadd.w	%vr0, %vr2, %vr1                ; @0x268
 ;	 }
	vvst.av.w	%vr0,%r0,1              ; @0x272
.LZD4:                                  ; @0x278
	; ZD Loop End                           ; @0x278
;  %bb.10:                              ; %vectorized_vec_sum.exit
	nop                                     ; inserted to benefit BPU
                                        ; @0x278
	nop                                     ; inserted to benefit BPU
                                        ; @0x27c
	bl	clock                           ; @0x280
	sub_s	%r0,%r0,%r15                    ; @0x284
	fint2d	%r18,%r0                        ; @0x286
	bl	_timer_clocks_per_sec           ; @0x28a
	fuint2d	%r2,%r0                         ; @0x28e
	fddiv	%r2,%r18,%r2                    ; @0x292
	mov_s	%r16,0                          ; @0x296
	mov_s	%r0,%r23                        ; @0x298
	fdmul	%r18,%r2,%r16                   ; @0x29a
	mov_s	%r1,%r18                        ; @0x29e
	mov_s	%r2,%r19                        ; @0x2a0
	bl	printf                          ; @0x2a2
	fddiv	%r2,%r20,%r18                   ; @0x2a6
	mov_s	%r15,.L.str.6                   ; @0x2aa
	mov_s	%r0,%r15                        ; @0x2b0
	std	%r20,[%sp,128]                  ; 8-byte Folded Spill
                                        ; @0x2b2
	mov_s	%r1,%r2                         ; @0x2b6
	mov_s	%r2,%r3                         ; @0x2b8
	bl	printf                          ; @0x2ba
	mov_s	%r0,%r13                        ; @0x2be
	st	%r13,[%sp,124]                  ; 4-byte Folded Spill
                                        ; @0x2c0
	bl	puts                            ; @0x2c4
	ld_s	%r2,[%r24,0]                    ; @0x2c8
	ld	%r4,[%r14,0]                    ; @0x2ca
	ld	%r6,[%r22,0]                    ; @0x2ce
	mov_s	%r0,%fp                         ; @0x2d2
	mov_s	%r1,0                           ; @0x2d4
	mov_s	%r3,0                           ; @0x2d6
	mov_s	%r5,0                           ; @0x2d8
	bl	printf                          ; @0x2da
	ld_s	%r2,[%r24,4]                    ; @0x2de
	ld	%r4,[%r14,4]                    ; @0x2e0
	ld	%r6,[%r22,4]                    ; @0x2e4
	mov_s	%r0,%fp                         ; @0x2e8
	mov_s	%r1,1                           ; @0x2ea
	mov_s	%r3,1                           ; @0x2ec
	mov_s	%r5,1                           ; @0x2ee
	bl	printf                          ; @0x2f0
	ld_s	%r2,[%r24,8]                    ; @0x2f4
	ld	%r4,[%r14,8]                    ; @0x2f6
	ld	%r6,[%r22,8]                    ; @0x2fa
	mov_s	%r0,%fp                         ; @0x2fe
	mov_s	%r1,2                           ; @0x300
	mov_s	%r3,2                           ; @0x302
	mov_s	%r5,2                           ; @0x304
	bl	printf                          ; @0x306
	ld_s	%r2,[%r24,12]                   ; @0x30a
	ld	%r4,[%r14,12]                   ; @0x30c
	ld	%r6,[%r22,12]                   ; @0x310
	mov_s	%r0,%fp                         ; @0x314
	mov_s	%r1,3                           ; @0x316
	mov_s	%r3,3                           ; @0x318
	mov_s	%r5,3                           ; @0x31a
	bl	printf                          ; @0x31c
	ld_s	%r2,[%r24,16]                   ; @0x320
	ld	%r4,[%r14,16]                   ; @0x322
	ld	%r6,[%r22,16]                   ; @0x326
	mov_s	%r0,%fp                         ; @0x32a
	mov_s	%r1,4                           ; @0x32c
	mov_s	%r3,4                           ; @0x32e
	mov_s	%r5,4                           ; @0x330
	bl	printf                          ; @0x332
	mov_s	%r0,10                          ; @0x336
	bl	putchar                         ; @0x338
	add	%r0,%r15,.Lstr.11-.L.str.6      ; widened to benefit BPU
                                        ; @0x33c
	bl	puts                            ; @0x340
	sub1	%r0,%r23,(.L.str.5-.L.str.8)/2  ; @0x344
	mov_s	%r1,%r24                        ; @0x348
	mov_s	%r2,%r14                        ; @0x34a
	mov_s	%r3,%r22                        ; @0x34c
	bl	printf                          ; @0x34e
	; Implicit def %r2                      ; @0x352
	mov	%lp_count,0x1000@u32            ; @0x352
	mov_s	%r0,%r22                        ; @0x35a
	lp	.LZD3                           ; @0x35c
.LBB4_11:                               ; %for.body.i129
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x360
	std.ab	-1,[%r0,8]                      ; @0x360
.LZD3:                                  ; @0x364
	; ZD Loop End                           ; @0x364
;  %bb.12:                              ; %init_vector.exit134
	nop                                     ; inserted to benefit BPU
                                        ; @0x364
	bl	clock                           ; @0x368
	mov_s	%r18,0x2000@u32                 ; @0x36c
	mov_s	%r2,0                           ; @0x372
	mov_s	%r13,%r0                        ; @0x374
	mov_s	%r23,%r22                       ; @0x376
	mov_s	%r15,%r14                       ; @0x378
	mov_s	%r0,%r24                        ; @0x37a
	mov_s	%r1,%r24                        ; @0x37c
	mov_s	%r4,%r18                        ; @0x37e
	mov_s	%r19,%r2                        ; @0x380
	mov_s	%r3,0                           ; @0x382
	mov_s	%r5,0                           ; @0x384
	mov_s	%r6,1                           ; @0x386
	mov_s	%r7,0                           ; @0x388
	st	%r18,[%sp,64]                   ; @0x38a
	std	1,[%sp,56]                      ; @0x38e
	std	%r18,[%sp,48]                   ; @0x392
	std	0,[%sp,40]                      ; @0x396
	std	%r22,[%sp,32]                   ; @0x39a
	std	1,[%sp,24]                      ; @0x39e
	std	%r18,[%sp,16]                   ; @0x3a2
	std	0,[%sp,8]                       ; @0x3a6
	std	%r14,[%sp,0]                    ; @0x3aa
	bl	vekt_vec_sum                    ; @0x3ae
	bl	clock                           ; @0x3b2
	sub_s	%r0,%r0,%r13                    ; @0x3b6
	fint2d	%r20,%r0                        ; @0x3b8
	bl	_timer_clocks_per_sec           ; @0x3bc
	fuint2d	%r2,%r0                         ; @0x3c0
	fddiv	%r2,%r20,%r2                    ; @0x3c4
	mov_s	%r16,%r19                       ; @0x3c8
	mov_s	%r0,.L.str.9                    ; @0x3ca
	fdmul	%r16,%r2,%r16                   ; @0x3d0
	mov_s	%r1,%r16                        ; @0x3d4
	mov_s	%r2,%r17                        ; @0x3d6
	bl	printf                          ; @0x3d8
	ldd	%r2,[%sp,128]                   ; 8-byte Folded Reload
                                        ; @0x3dc
	mov_s	%r0,.L.str.6                    ; @0x3e0
	fddiv	%r2,%r2,%r16                    ; @0x3e6
	mov_s	%r1,%r2                         ; @0x3ea
	mov_s	%r2,%r3                         ; @0x3ec
	bl	printf                          ; @0x3ee
	ld_s	%r0,[%sp,124]                   ; 4-byte Folded Reload
                                        ; @0x3f2
	bl	puts                            ; @0x3f4
	ld_s	%r2,[%r24,0]                    ; @0x3f8
	ld	%r4,[%r14,0]                    ; @0x3fa
	ld	%r6,[%r22,0]                    ; @0x3fe
	mov_s	%r0,%fp                         ; @0x402
	mov_s	%r1,0                           ; @0x404
	mov_s	%r3,0                           ; @0x406
	mov_s	%r5,0                           ; @0x408
	bl	printf                          ; @0x40a
	ld_s	%r2,[%r24,4]                    ; @0x40e
	ld	%r4,[%r14,4]                    ; @0x410
	ld	%r6,[%r22,4]                    ; @0x414
	mov_s	%r0,%fp                         ; @0x418
	mov_s	%r1,1                           ; @0x41a
	mov_s	%r3,1                           ; @0x41c
	mov_s	%r5,1                           ; @0x41e
	bl	printf                          ; @0x420
	ld_s	%r2,[%r24,8]                    ; @0x424
	ld	%r4,[%r14,8]                    ; @0x426
	ld	%r6,[%r22,8]                    ; @0x42a
	mov_s	%r0,%fp                         ; @0x42e
	mov_s	%r1,2                           ; @0x430
	mov_s	%r3,2                           ; @0x432
	mov_s	%r5,2                           ; @0x434
	bl	printf                          ; @0x436
	ld_s	%r2,[%r24,12]                   ; @0x43a
	ld	%r4,[%r14,12]                   ; @0x43c
	ld	%r6,[%r22,12]                   ; @0x440
	mov_s	%r0,%fp                         ; @0x444
	mov_s	%r1,3                           ; @0x446
	mov_s	%r3,3                           ; @0x448
	mov_s	%r5,3                           ; @0x44a
	bl	printf                          ; @0x44c
	ld_s	%r2,[%r24,16]                   ; @0x450
	ld	%r4,[%r14,16]                   ; @0x452
	ld	%r6,[%r22,16]                   ; @0x456
	mov_s	%r0,%fp                         ; @0x45a
	mov_s	%r1,4                           ; @0x45c
	mov_s	%r3,4                           ; @0x45e
	mov_s	%r5,4                           ; @0x460
	bl	printf                          ; @0x462
	mov_s	%r0,0                           ; @0x466
	add_s	%sp,%sp,68                      ; @0x468
	.cfa_pop	68                              ; @0x46a
	ld	%blink,[%sp,52]                 ; @0x46a
	.cfa_restore	{%blink}                ; @0x46e
	ld	%fp,[%sp,48]                    ; @0x46e
	.cfa_restore	{%fp}                   ; @0x472
	ld	%r24,[%sp,44]                   ; @0x472
	.cfa_restore	{%r24}                  ; @0x476
	ldd	%r22,[%sp,36]                   ; @0x476
	.cfa_restore	{%r23}                  ; @0x47a
	.cfa_restore	{%r22}                  ; @0x47a
	ldd	%r20,[%sp,28]                   ; @0x47a
	.cfa_restore	{%r21}                  ; @0x47e
	.cfa_restore	{%r20}                  ; @0x47e
	ldd	%r18,[%sp,20]                   ; @0x47e
	.cfa_restore	{%r19}                  ; @0x482
	.cfa_restore	{%r18}                  ; @0x482
	ldd	%r16,[%sp,12]                   ; @0x482
	.cfa_restore	{%r17}                  ; @0x486
	.cfa_restore	{%r16}                  ; @0x486
	ldd	%r14,[%sp,4]                    ; @0x486
	.cfa_restore	{%r15}                  ; @0x48a
	.cfa_restore	{%r14}                  ; @0x48a
	ld.ab	%r13,[%sp,68]                   ; @0x48a
	.cfa_restore	{%r13}                  ; @0x48e
	.cfa_pop	68                              ; @0x48e
	j_s	[%blink]                        ; @0x48e
	.cfa_ef
.Lfunc_end4:                            ; @0x490

	.reloc	_init_ad,0	;startup code to enable %status AD bit ; -- End function
