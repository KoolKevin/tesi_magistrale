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
	.size	.Lstr.11, 30
	.type	.Lstr.11,@object
	.size	.L.str.6, 15
	.type	.L.str.6,@object
	.size	.L.str.4, 23
	.type	.L.str.4,@object
	.size	.Lstr.10, 27
	.type	.Lstr.10,@object
	.size	.L.str, 40
	.type	.L.str,@object
	.size	.L.str.5, 51
	.type	.L.str.5,@object
	.size	.L.str.8, 55
	.type	.L.str.8,@object
	.globl	init_vector
	.type	init_vector,@function
	.type	.Linit_vector$local,@function
	.size	init_vector, .Lfunc_end0-init_vector
	.size	.Linit_vector$local, .Lfunc_end0-init_vector
	.globl	vec_sum
	.type	vec_sum,@function
	.type	.Lvec_sum$local,@function
	.size	vec_sum, .Lfunc_end1-vec_sum
	.size	.Lvec_sum$local, .Lfunc_end1-vec_sum
	.globl	main
	.type	main,@function
	.type	.Lmain$local,@function
	.size	main, .Lfunc_end2-main
	.size	.Lmain$local, .Lfunc_end2-main
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
.Lstr.11:                               ; @0x1e
	.asciz	"Primi 5 elementi della somma:"
.L.str.6:                               ; @0x3c
	.asciz	"Speedup: %.2f\n"
.L.str.4:                               ; @0x4b
	.asciz	"Vettorizzo su %d lane\n"
.Lstr.10:                               ; @0x62
	.asciz	"Versione vekt-vettorizzata"
.L.str:                                 ; @0x7d
	.asciz	"Tempo di esecuzione di vec_sum: %.2fms\n"
.L.str.5:                               ; @0xa5
	.asciz	"Tempo di esecuzione di vectorized_vec_sum: %.2fms\n"
.L.str.8:                               ; @0xd8
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
	.ident	"LLVM 17.0.7/V-2024.06. (build 008) (LLVM 17.0.7) -arcv2hs -core4 -Xcode_density -Xatomic -Xll64 -Xunaligned -Xdiv_rem=radix4 -Xswap -Xbitscan -Xmpy_option=mpyd -Xshift_assist -Xbarrel_shifter -Xfpud_div -Xfpu_mac -Xtimer0 -Xrtc -Xstack_check -Xstu=4 -Xvdsp4 -Xvec_unit_rev_minor=1 -Xvec_width=512 -Xvec_mem_size=128k -Xvec_mem_bank_width=16 -Xvec_max_fetch_size=16 -Xvec_num_slots=3 -Xvec_super_with_scalar -Xvec_regs=32 -Xvec_fpu=32 -Xvec_fpu_math=3 -Xvec_fpu_2nd_mul -Xvec_fpu_types=2 -Xvec_num_rd_ports=6 -Xvec_num_acc=8 -Xvec_num_mpy=2 -Xvec_mpy32 -Xvec_num_alu=3 -Xvec_guard_bit_option=0 -Xvec_stack_check -Hvdsp_vector_c -O2 -fvectorize -fslp-vectorize -ffast-math"
	.align	8                               ; -- Begin function init_vector
init_vector:                            ; @init_vector
                                        ; @0x0
.Linit_vector$local:                    ; @0x0
	.cfa_bf	.Linit_vector$local
;  %bb.0:                               ; %entry
	.cfa_same	%r2                     ; @0x0
	std.aw	%r14,[%sp,-40]                  ; @0x0
	.cfa_push	40                      ; @0x4
	.cfa_reg_offset	{%r14}, 0               ; @0x4
	.cfa_reg_offset	{%r15}, 4               ; @0x4
	std	%r16,[%sp,8]                    ; @0x4
	.cfa_reg_offset	{%r16}, 8               ; @0x8
	.cfa_reg_offset	{%r17}, 12              ; @0x8
	std	%r18,[%sp,16]                   ; @0x8
	.cfa_reg_offset	{%r18}, 16              ; @0xc
	.cfa_reg_offset	{%r19}, 20              ; @0xc
	std	%r20,[%sp,24]                   ; @0xc
	.cfa_reg_offset	{%r20}, 24              ; @0x10
	.cfa_reg_offset	{%r21}, 28              ; @0x10
	std	%r22,[%sp,32]                   ; @0x10
	.cfa_reg_offset	{%r22}, 32              ; @0x14
	.cfa_reg_offset	{%r23}, 36              ; @0x14
	cmp_s	%r1,0                           ; @0x14
	ble	.LBB0_12                        ; @0x16
;  %bb.1:                               ; %iter.check
	cmp_s	%r1,8                           ; @0x1a
	mov_s	%r3,0                           ; @0x1c
	bcs	.LBB0_10                        ; @0x1e
;  %bb.2:                               ; %vector.main.loop.iter.check
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr0, %r2                      ; @0x22
	cmp_s	%r1,64                          ; @0x22
 ;	 }
	bcs	.LBB0_7                         ; @0x28
;  %bb.3:                               ; %vector.ph
	; Implicit def %r30                     ; @0x2c
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r4,%vr0,14             ; @0x2c
	sub3	%r12,%r1,64/8                   ; @0x2c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r6,%vr0,12             ; @0x36
	lsr_s	%r12,%r12,6                     ; @0x36
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r8,%vr0,10             ; @0x3e
	bmskn	%r3,%r1,5                       ; @0x3e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r22,%vr0,0             ; @0x48
	add	%lp_count,%r12,1                ; @0x48
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r20,%vr0,2             ; @0x52
	add	%r12,%r0,56                     ; @0x52
 ;	 }
	vvmov2.x.from.w	%r18,%vr0,4             ; @0x5c
	vvmov2.x.from.w	%r16,%vr0,6             ; @0x62
	vvmov2.x.from.w	%r14,%vr0,8             ; @0x68
	lp	.LZD2                           ; @0x6e
.LBB0_4:                                ; %vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x72
	std.ab	%r4,[%r12,-8]                   ; @0x72
	std.ab	%r6,[%r12,72]                   ; @0x76
	std.ab	%r4,[%r12,-8]                   ; @0x7a
	std.ab	%r6,[%r12,72]                   ; @0x7e
	std.ab	%r4,[%r12,-8]                   ; @0x82
	std.ab	%r6,[%r12,72]                   ; @0x86
	std.ab	%r4,[%r12,-8]                   ; @0x8a
	std.ab	%r6,[%r12,-200]                 ; @0x8e
	std.ab	%r8,[%r12,64]                   ; @0x92
	std.ab	%r8,[%r12,64]                   ; @0x96
	std.ab	%r8,[%r12,64]                   ; @0x9a
	std.ab	%r8,[%r12,-200]                 ; @0x9e
	std.ab	%r14,[%r12,-8]                  ; @0xa2
	std.ab	%r16,[%r12,72]                  ; @0xa6
	std.ab	%r14,[%r12,-8]                  ; @0xaa
	std.ab	%r16,[%r12,72]                  ; @0xae
	std.ab	%r14,[%r12,-8]                  ; @0xb2
	std.ab	%r16,[%r12,72]                  ; @0xb6
	std.ab	%r14,[%r12,-8]                  ; @0xba
	std.ab	%r16,[%r12,-200]                ; @0xbe
	std.ab	%r18,[%r12,-8]                  ; @0xc2
	std.ab	%r20,[%r12,-8]                  ; @0xc6
	std.ab	%r22,[%r12,80]                  ; @0xca
	std.ab	%r18,[%r12,-8]                  ; @0xce
	std.ab	%r20,[%r12,-8]                  ; @0xd2
	std.ab	%r22,[%r12,80]                  ; @0xd6
	std.ab	%r18,[%r12,-8]                  ; @0xda
	std.ab	%r20,[%r12,-8]                  ; @0xde
	std.ab	%r22,[%r12,80]                  ; @0xe2
	std.ab	%r18,[%r12,-8]                  ; @0xe6
	std.ab	%r20,[%r12,-8]                  ; @0xea
	std.ab	%r22,[%r12,120]                 ; @0xee
.LZD2:                                  ; @0xf2
	; ZD Loop End                           ; @0xf2
;  %bb.5:                               ; %middle.block
	breq	%r3,%r1,.LBB0_12                ; @0xf2
;  %bb.6:                               ; %vec.epilog.iter.check
	tst	%r1,56                          ; @0xf6
	beq_s	.LBB0_10                        ; @0xfa
.LBB0_7:                                ; %vec.epilog.ph
                                        ; @0xfc
	; Implicit def %r30                     ; @0xfc
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r4,%vr0,0              ; @0xfc
	sub_s	%r15,%r1,%r3                    ; @0xfc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r6,%vr0,2              ; @0x104
	sub_s	%r15,%r15,8                     ; @0x104
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r8,%vr0,4              ; @0x10c
	lsr_s	%r15,%r15,3                     ; @0x10c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r22,%vr0,6             ; @0x114
	add2	%r12,%r0,%r3                    ; @0x114
 ;	 }
	bmskn	%r3,%r1,2                       ; @0x11e
	add	%lp_count,%r15,1                ; @0x122
	lp	.LZD1                           ; @0x126
.LBB0_8:                                ; %vec.epilog.vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x12a
	std	%r22,[%r12,24]                  ; @0x12a
	std	%r8,[%r12,16]                   ; @0x12e
	std	%r6,[%r12,8]                    ; @0x132
	std.ab	%r4,[%r12,32]                   ; @0x136
.LZD1:                                  ; @0x13a
	; ZD Loop End                           ; @0x13a
;  %bb.9:                               ; %vec.epilog.middle.block
	breq	%r3,%r1,.LBB0_12                ; @0x13a
.LBB0_10:                               ; %for.body.preheader
                                        ; @0x13e
	add_s	%r12,%r3,1                      ; @0x13e
	max	%r1,%r1,%r12                    ; @0x140
	add2_s	%r0,%r0,%r3                     ; @0x144
	sub	%lp_count,%r1,%r3               ; @0x146
	; Implicit def %r3                      ; @0x14a
	lp	.LZD0                           ; @0x14a
.LBB0_11:                               ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x14e
	st.ab	%r2,[%r0,4]                     ; @0x14e
.LZD0:                                  ; @0x152
	; ZD Loop End                           ; @0x152
.LBB0_12:                               ; %for.cond.cleanup
                                        ; @0x152
	ldd	%r22,[%sp,32]                   ; @0x152
	.cfa_restore	{%r23}                  ; @0x156
	.cfa_restore	{%r22}                  ; @0x156
	ldd	%r20,[%sp,24]                   ; @0x156
	.cfa_restore	{%r21}                  ; @0x15a
	.cfa_restore	{%r20}                  ; @0x15a
	ldd	%r18,[%sp,16]                   ; @0x15a
	.cfa_restore	{%r19}                  ; @0x15e
	.cfa_restore	{%r18}                  ; @0x15e
	ldd	%r16,[%sp,8]                    ; @0x15e
	.cfa_restore	{%r17}                  ; @0x162
	.cfa_restore	{%r16}                  ; @0x162
	ldd.ab	%r14,[%sp,40]                   ; @0x162
	.cfa_restore	{%r15}                  ; @0x166
	.cfa_restore	{%r14}                  ; @0x166
	.cfa_pop	40                              ; @0x166
	j_s	[%blink]                        ; @0x166
	.cfa_ef
.Lfunc_end0:                            ; @0x168

	.align	4                               ; -- End function
                                        ; -- Begin function vec_sum
vec_sum:                                ; @vec_sum
                                        ; @0x168
.Lvec_sum$local:                        ; @0x168
	.cfa_bf	.Lvec_sum$local
;  %bb.0:                               ; %entry
	.cfa_same	%r30                    ; @0x168
	.cfa_same	%r11                    ; @0x168
	.cfa_same	%r9                     ; @0x168
	.cfa_same	%r8                     ; @0x168
	.cfa_same	%r7                     ; @0x168
	.cfa_same	%r6                     ; @0x168
	.cfa_same	%r5                     ; @0x168
	.cfa_same	%r4                     ; @0x168
	sub.f	%lp_count,%r3,0                 ; @0x168
	.cfa_remember_state                     ; @0x16c
	jle	[%blink]                        ; @0x16c
	.cfa_restore_state                      ; @0x170
;  %bb.1:                               ; %for.body.preheader
	; Implicit def %r12                     ; @0x170
	lp	.LZD3                           ; @0x170
.LBB1_2:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x174
	ld.ab	%r3,[%r0,4]                     ; @0x174
	ld.ab	%r12,[%r1,4]                    ; @0x178
	add_s	%r3,%r12,%r3                    ; @0x17c
	st.ab	%r3,[%r2,4]                     ; @0x17e
.LZD3:                                  ; @0x182
	; ZD Loop End                           ; @0x182
;  %bb.3:                               ; %for.cond.cleanup
	j_s	[%blink]                        ; @0x182
	.cfa_ef
.Lfunc_end1:                            ; @0x184

	.align	4                               ; -- End function
                                        ; -- Begin function main
main:                                   ; @main
                                        ; @0x184
.Lmain$local:                           ; @0x184
	.cfa_bf	.Lmain$local
;  %bb.0:                               ; %entry
	st.aw	%r13,[%sp,-60]                  ; @0x184
	.cfa_push	60                      ; @0x188
	.cfa_reg_offset	{%r13}, 0               ; @0x188
	std	%r14,[%sp,4]                    ; @0x188
	.cfa_reg_offset	{%r14}, 4               ; @0x18c
	.cfa_reg_offset	{%r15}, 8               ; @0x18c
	std	%r16,[%sp,12]                   ; @0x18c
	.cfa_reg_offset	{%r16}, 12              ; @0x190
	.cfa_reg_offset	{%r17}, 16              ; @0x190
	std	%r18,[%sp,20]                   ; @0x190
	.cfa_reg_offset	{%r18}, 20              ; @0x194
	.cfa_reg_offset	{%r19}, 24              ; @0x194
	std	%r20,[%sp,28]                   ; @0x194
	.cfa_reg_offset	{%r20}, 28              ; @0x198
	.cfa_reg_offset	{%r21}, 32              ; @0x198
	std	%r22,[%sp,36]                   ; @0x198
	.cfa_reg_offset	{%r22}, 36              ; @0x19c
	.cfa_reg_offset	{%r23}, 40              ; @0x19c
	st	%r24,[%sp,44]                   ; @0x19c
	.cfa_reg_offset	{%r24}, 44              ; @0x1a0
	st	%blink,[%sp,48]                 ; @0x1a0
	.cfa_reg_offset	{%blink}, 48            ; @0x1a4
	; Implicit def %r3                      ; @0x1a4
.vvsbundle  "v1sc" 
 ;	 { 
	vvci.w	%vr0                            ; @0x1a4
	mov_s	%r14,a                          ; @0x1a4
 ;	 }
	mov_s	%r17,b                          ; @0x1ae
	add2	%r0,%r17,192/4                  ; @0x1b4
	add2	%r1,%r14,192/4                  ; @0x1b8
	mov	%lp_count,64                    ; @0x1bc
	lp	.LZD8                           ; @0x1c0
.LBB2_1:                                ; %vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x1c4
.vvsbundle  " v3" 
 ;	 { 
	vvadd.w	%vr3, %vr0, 17                  ; @0x1c4
	vvadd.w	%vr2, %vr0, 33                  ; @0x1c4
	vvadd.w	%vr1, %vr0, 49                  ; @0x1c4
 ;	 }
.vvsbundle  " v3" 
 ;	 { 
	vvst.av.w	%vr1,%r1,-1             ; @0x1d0
	vvadd.w	%vr5, %vr0, 113                 ; @0x1d0
	vvadd.w	%vr4, %vr0, 1                   ; @0x1d0
 ;	 }
.vvsbundle  " v3" 
 ;	 { 
	vvst.av.w	%vr1,%r0,-1             ; @0x1de
	vvadd.w	%vr6, %vr0, 81                  ; @0x1de
	vvadd.w	%vr1, %vr0, 97                  ; @0x1de
 ;	 }
.vvsbundle  " v3" 
 ;	 { 
	vvst.av.w	%vr2,%r1,-1             ; @0x1ee
	vvadd.w	%vr0, %vr0, 128                 ; @0x1ee
	vvadd.w	%vr7, %vr0, 65                  ; @0x1ee
 ;	 }
	vvst.av.w	%vr2,%r0,-1             ; @0x1fe
	vvst.av.w	%vr3,%r1,-1             ; @0x204
	vvst.av.w	%vr3,%r0,-1             ; @0x20a
	vvst.av.w	%vr4,%r1,7              ; @0x210
	vvst.av.w	%vr4,%r0,7              ; @0x216
	vvst.av.w	%vr5,%r1,-1             ; @0x21c
	vvst.av.w	%vr5,%r0,-1             ; @0x222
	vvst.av.w	%vr1,%r1,-1             ; @0x228
	vvst.av.w	%vr1,%r0,-1             ; @0x22e
	vvst.av.w	%vr6,%r1,-1             ; @0x234
	vvst.av.w	%vr6,%r0,-1             ; @0x23a
	vvst.av.w	%vr7,%r1,7              ; @0x240
	vvst.av.w	%vr7,%r0,7              ; @0x246
.LZD8:                                  ; @0x24c
	; ZD Loop End                           ; @0x24c
;  %bb.2:                               ; %vector.body140.preheader
	; Implicit def %r2                      ; @0x24c
	mov_s	%r18,c                          ; @0x24c
	mov	%lp_count,64                    ; @0x252
	add	%r0,%r18,56                     ; @0x256
	lp	.LZD7                           ; @0x25a
.LBB2_3:                                ; %vector.body140
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x25e
	std.ab	-1,[%r0,-8]                     ; @0x25e
	std.ab	-1,[%r0,-8]                     ; @0x262
	std.ab	-1,[%r0,-8]                     ; @0x266
	std.ab	-1,[%r0,-8]                     ; @0x26a
	std.ab	-1,[%r0,-8]                     ; @0x26e
	std.ab	-1,[%r0,-8]                     ; @0x272
	std.ab	-1,[%r0,-8]                     ; @0x276
	std.ab	-1,[%r0,120]                    ; @0x27a
	std.ab	-1,[%r0,-8]                     ; @0x27e
	std.ab	-1,[%r0,-8]                     ; @0x282
	std.ab	-1,[%r0,-8]                     ; @0x286
	std.ab	-1,[%r0,-8]                     ; @0x28a
	std.ab	-1,[%r0,-8]                     ; @0x28e
	std.ab	-1,[%r0,-8]                     ; @0x292
	std.ab	-1,[%r0,-8]                     ; @0x296
	std.ab	-1,[%r0,120]                    ; @0x29a
	std.ab	-1,[%r0,-8]                     ; @0x29e
	std.ab	-1,[%r0,-8]                     ; @0x2a2
	std.ab	-1,[%r0,-8]                     ; @0x2a6
	std.ab	-1,[%r0,-8]                     ; @0x2aa
	std.ab	-1,[%r0,-8]                     ; @0x2ae
	std.ab	-1,[%r0,-8]                     ; @0x2b2
	std.ab	-1,[%r0,-8]                     ; @0x2b6
	std.ab	-1,[%r0,120]                    ; @0x2ba
	std.ab	-1,[%r0,-8]                     ; @0x2be
	std.ab	-1,[%r0,-8]                     ; @0x2c2
	std.ab	-1,[%r0,-8]                     ; @0x2c6
	std.ab	-1,[%r0,-8]                     ; @0x2ca
	std.ab	-1,[%r0,-8]                     ; @0x2ce
	std.ab	-1,[%r0,-8]                     ; @0x2d2
	std.ab	-1,[%r0,-8]                     ; @0x2d6
	std.ab	-1,[%r0,120]                    ; @0x2da
	std.ab	-1,[%r0,-8]                     ; @0x2de
	std.ab	-1,[%r0,-8]                     ; @0x2e2
	std.ab	-1,[%r0,-8]                     ; @0x2e6
	std.ab	-1,[%r0,-8]                     ; @0x2ea
	std.ab	-1,[%r0,-8]                     ; @0x2ee
	std.ab	-1,[%r0,-8]                     ; @0x2f2
	std.ab	-1,[%r0,-8]                     ; @0x2f6
	std.ab	-1,[%r0,120]                    ; @0x2fa
	std.ab	-1,[%r0,-8]                     ; @0x2fe
	std.ab	-1,[%r0,-8]                     ; @0x302
	std.ab	-1,[%r0,-8]                     ; @0x306
	std.ab	-1,[%r0,-8]                     ; @0x30a
	std.ab	-1,[%r0,-8]                     ; @0x30e
	std.ab	-1,[%r0,-8]                     ; @0x312
	std.ab	-1,[%r0,-8]                     ; @0x316
	std.ab	-1,[%r0,120]                    ; @0x31a
	std.ab	-1,[%r0,-8]                     ; @0x31e
	std.ab	-1,[%r0,-8]                     ; @0x322
	std.ab	-1,[%r0,-8]                     ; @0x326
	std.ab	-1,[%r0,-8]                     ; @0x32a
	std.ab	-1,[%r0,-8]                     ; @0x32e
	std.ab	-1,[%r0,-8]                     ; @0x332
	std.ab	-1,[%r0,-8]                     ; @0x336
	std.ab	-1,[%r0,120]                    ; @0x33a
	std.ab	-1,[%r0,-8]                     ; @0x33e
	std.ab	-1,[%r0,-8]                     ; @0x342
	std.ab	-1,[%r0,-8]                     ; @0x346
	std.ab	-1,[%r0,-8]                     ; @0x34a
	std.ab	-1,[%r0,-8]                     ; @0x34e
	std.ab	-1,[%r0,-8]                     ; @0x352
	std.ab	-1,[%r0,-8]                     ; @0x356
	std.ab	-1,[%r0,120]                    ; @0x35a
.LZD7:                                  ; @0x35e
	; ZD Loop End                           ; @0x35e
;  %bb.4:                               ; %init_vector.exit
	nop_s                                   ; inserted to benefit BPU
                                        ; @0x35e
	bl	clock                           ; @0x360
	; Implicit def %r12                     ; @0x364
	mov_s	%r13,%r0                        ; @0x364
	mov	%lp_count,1024                  ; @0x366
	mov_s	%r0,%r18                        ; @0x36a
	mov_s	%r1,%r17                        ; @0x36c
	mov_s	%r2,%r14                        ; @0x36e
	lp	.LZD6                           ; @0x370
.LBB2_5:                                ; %vector.body147
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x374
.vvsbundle  "v3sc" 
 ;	 { 
	vvmov.w	 %vr2, 0                        ; @0x374
	vvmov.w	 %vr1, 0                        ; @0x374
	vvmov.w	 %vr0, 0                        ; @0x374
	ldd.ab	%r4,[%r2,32]                    ; @0x374
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr3, 0                        ; @0x384
	ldd.ab	%r6,[%r1,32]                    ; @0x384
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,0,%r4              ; @0x38c
	ldd	%r8,[%r1,-16]                   ; @0x38c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,0,%r6              ; @0x396
	ldd	%r30,[%r2,-16]                  ; @0x396
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,1,%r5              ; @0x3a0
	ldd	%r20,[%r2,-24]                  ; @0x3a0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,1,%r7              ; @0x3aa
	ldd	%r4,[%r1,-24]                   ; @0x3aa
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,0,%r8              ; @0x3b4
	ldd	%r6,[%r1,-8]                    ; @0x3b4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,0,%r30             ; @0x3be
	ldd	%r22,[%r2,-8]                   ; @0x3be
 ;	 }
	vvmov1.vi.to.w	%vr0,2,%r20             ; @0x3c8
	vvmov1.vi.to.w	%vr1,2,%r4              ; @0x3ce
	vvmov1.vi.to.w	%vr2,1,%r9              ; @0x3d4
	vvmov1.vi.to.w	%vr3,1,%blink           ; @0x3da
	vvmov1.vi.to.w	%vr0,3,%r21             ; @0x3e0
	vvmov1.vi.to.w	%vr1,3,%r5              ; @0x3e6
.vvsbundle  " v2" 
 ;	 { 
	vvadd.w	%vr0, %vr1, %vr0                ; @0x3ec
	vvmov1.vi.to.w	%vr2,2,%r6              ; @0x3ec
 ;	 }
	vvmov1.vi.to.w	%vr3,2,%r22             ; @0x3f6
	vvmov1.vi.to.w	%vr2,3,%r7              ; @0x3fc
.vvsbundle  " v2" 
 ;	 { 
	vvmov2.x.from.w	%r4,%vr0,2              ; @0x402
	vvmov1.vi.to.w	%vr3,3,%r23             ; @0x402
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvadd.w	%vr0, %vr2, %vr3                ; @0x40c
	vvmov2.x.from.w	%r6,%vr0,0              ; @0x40c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r8,%vr0,0              ; @0x416
	std	%r4,[%r0,8]                     ; @0x416
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r4,%vr0,2              ; @0x420
	std.ab	%r6,[%r0,32]                    ; @0x420
 ;	 }
	std	%r8,[%r0,-16]                   ; @0x42a
	std	%r4,[%r0,-8]                    ; @0x42e
.LZD6:                                  ; @0x432
	; ZD Loop End                           ; @0x432
;  %bb.6:                               ; %vec_sum.exit
	mov_s	%r23,0x408f4000@u32             ; @0x432
	mov_s	%r22,0                          ; @0x438
	bl	clock                           ; @0x43a
	sub_s	%r0,%r0,%r13                    ; @0x43e
	fint2d	%r2,%r0                         ; @0x440
	fdmul	%r20,%r2,%r22                   ; @0x444
	bl	_timer_clocks_per_sec           ; @0x448
	fuint2d	%r2,%r0                         ; @0x44c
	fddiv	%r20,%r20,%r2                   ; @0x450
	mov_s	%r19,.L.str.5                   ; @0x454
	sub	%r0,%r19,.L.str.5-.L.str        ; @0x45a
	mov_s	%r1,%r20                        ; @0x45e
	mov_s	%r2,%r21                        ; @0x460
	bl	printf                          ; @0x462
	mov_s	%r24,.L.str.6                   ; @0x466
	sub	%r16,%r24,.L.str.6-.Lstr.11     ; @0x46c
	mov_s	%r0,%r16                        ; @0x470
	bl	puts                            ; @0x472
	ld_s	%r2,[%r14,0]                    ; @0x476
	ld	%r4,[%r17,0]                    ; @0x478
	ld	%r6,[%r18,0]                    ; @0x47c
	sub	%r13,%r24,.L.str.6-.L.str.2     ; @0x480
	mov_s	%r0,%r13                        ; @0x484
	mov_s	%r1,0                           ; @0x486
	mov_s	%r3,0                           ; @0x488
	mov_s	%r5,0                           ; @0x48a
	bl	printf                          ; @0x48c
	ld_s	%r2,[%r14,4]                    ; @0x490
	ld	%r4,[%r17,4]                    ; @0x492
	ld	%r6,[%r18,4]                    ; @0x496
	mov_s	%r0,%r13                        ; @0x49a
	mov_s	%r1,1                           ; @0x49c
	mov_s	%r3,1                           ; @0x49e
	mov_s	%r5,1                           ; @0x4a0
	bl	printf                          ; @0x4a2
	ld_s	%r2,[%r14,8]                    ; @0x4a6
	ld	%r4,[%r17,8]                    ; @0x4a8
	ld	%r6,[%r18,8]                    ; @0x4ac
	mov_s	%r0,%r13                        ; @0x4b0
	mov_s	%r1,2                           ; @0x4b2
	mov_s	%r3,2                           ; @0x4b4
	mov_s	%r5,2                           ; @0x4b6
	bl	printf                          ; @0x4b8
	ld_s	%r2,[%r14,12]                   ; @0x4bc
	ld	%r4,[%r17,12]                   ; @0x4be
	ld	%r6,[%r18,12]                   ; @0x4c2
	mov_s	%r0,%r13                        ; @0x4c6
	mov_s	%r1,3                           ; @0x4c8
	mov_s	%r3,3                           ; @0x4ca
	mov_s	%r5,3                           ; @0x4cc
	bl	printf                          ; @0x4ce
	ld_s	%r2,[%r14,16]                   ; @0x4d2
	ld	%r4,[%r17,16]                   ; @0x4d4
	ld	%r6,[%r18,16]                   ; @0x4d8
	mov_s	%r0,%r13                        ; @0x4dc
	mov_s	%r1,4                           ; @0x4de
	mov_s	%r3,4                           ; @0x4e0
	mov_s	%r5,4                           ; @0x4e2
	bl	printf                          ; @0x4e4
	mov_s	%r0,10                          ; @0x4e8
	bl	putchar                         ; @0x4ea
	add	%r0,%r24,.L.str.4-.L.str.6      ; @0x4ee
	mov_s	%r1,16                          ; @0x4f2
	bl	printf                          ; @0x4f4
	; Implicit def %r2                      ; @0x4f8
	mov	%lp_count,64                    ; @0x4f8
	add	%r0,%r18,56                     ; @0x4fc
	lp	.LZD5                           ; @0x500
.LBB2_7:                                ; %vector.body154
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x504
	std.ab	-1,[%r0,-8]                     ; @0x504
	std.ab	-1,[%r0,-8]                     ; @0x508
	std.ab	-1,[%r0,-8]                     ; @0x50c
	std.ab	-1,[%r0,-8]                     ; @0x510
	std.ab	-1,[%r0,-8]                     ; @0x514
	std.ab	-1,[%r0,-8]                     ; @0x518
	std.ab	-1,[%r0,-8]                     ; @0x51c
	std.ab	-1,[%r0,120]                    ; @0x520
	std.ab	-1,[%r0,-8]                     ; @0x524
	std.ab	-1,[%r0,-8]                     ; @0x528
	std.ab	-1,[%r0,-8]                     ; @0x52c
	std.ab	-1,[%r0,-8]                     ; @0x530
	std.ab	-1,[%r0,-8]                     ; @0x534
	std.ab	-1,[%r0,-8]                     ; @0x538
	std.ab	-1,[%r0,-8]                     ; @0x53c
	std.ab	-1,[%r0,120]                    ; @0x540
	std.ab	-1,[%r0,-8]                     ; @0x544
	std.ab	-1,[%r0,-8]                     ; @0x548
	std.ab	-1,[%r0,-8]                     ; @0x54c
	std.ab	-1,[%r0,-8]                     ; @0x550
	std.ab	-1,[%r0,-8]                     ; @0x554
	std.ab	-1,[%r0,-8]                     ; @0x558
	std.ab	-1,[%r0,-8]                     ; @0x55c
	std.ab	-1,[%r0,120]                    ; @0x560
	std.ab	-1,[%r0,-8]                     ; @0x564
	std.ab	-1,[%r0,-8]                     ; @0x568
	std.ab	-1,[%r0,-8]                     ; @0x56c
	std.ab	-1,[%r0,-8]                     ; @0x570
	std.ab	-1,[%r0,-8]                     ; @0x574
	std.ab	-1,[%r0,-8]                     ; @0x578
	std.ab	-1,[%r0,-8]                     ; @0x57c
	std.ab	-1,[%r0,120]                    ; @0x580
	std.ab	-1,[%r0,-8]                     ; @0x584
	std.ab	-1,[%r0,-8]                     ; @0x588
	std.ab	-1,[%r0,-8]                     ; @0x58c
	std.ab	-1,[%r0,-8]                     ; @0x590
	std.ab	-1,[%r0,-8]                     ; @0x594
	std.ab	-1,[%r0,-8]                     ; @0x598
	std.ab	-1,[%r0,-8]                     ; @0x59c
	std.ab	-1,[%r0,120]                    ; @0x5a0
	std.ab	-1,[%r0,-8]                     ; @0x5a4
	std.ab	-1,[%r0,-8]                     ; @0x5a8
	std.ab	-1,[%r0,-8]                     ; @0x5ac
	std.ab	-1,[%r0,-8]                     ; @0x5b0
	std.ab	-1,[%r0,-8]                     ; @0x5b4
	std.ab	-1,[%r0,-8]                     ; @0x5b8
	std.ab	-1,[%r0,-8]                     ; @0x5bc
	std.ab	-1,[%r0,120]                    ; @0x5c0
	std.ab	-1,[%r0,-8]                     ; @0x5c4
	std.ab	-1,[%r0,-8]                     ; @0x5c8
	std.ab	-1,[%r0,-8]                     ; @0x5cc
	std.ab	-1,[%r0,-8]                     ; @0x5d0
	std.ab	-1,[%r0,-8]                     ; @0x5d4
	std.ab	-1,[%r0,-8]                     ; @0x5d8
	std.ab	-1,[%r0,-8]                     ; @0x5dc
	std.ab	-1,[%r0,120]                    ; @0x5e0
	std.ab	-1,[%r0,-8]                     ; @0x5e4
	std.ab	-1,[%r0,-8]                     ; @0x5e8
	std.ab	-1,[%r0,-8]                     ; @0x5ec
	std.ab	-1,[%r0,-8]                     ; @0x5f0
	std.ab	-1,[%r0,-8]                     ; @0x5f4
	std.ab	-1,[%r0,-8]                     ; @0x5f8
	std.ab	-1,[%r0,-8]                     ; @0x5fc
	std.ab	-1,[%r0,120]                    ; @0x600
.LZD5:                                  ; @0x604
	; ZD Loop End                           ; @0x604
;  %bb.8:                               ; %init_vector.exit122
	nop                                     ; inserted to benefit BPU
                                        ; @0x604
	bl	clock                           ; @0x608
	mov_s	%r3,0                           ; @0x60c
	bset_s	%r3,%r3,13                      ; @0x60e
	mov_s	%r15,%r0                        ; @0x610
	mov_s	%r0,%r14                        ; @0x612
	mov_s	%r1,%r17                        ; @0x614
	mov_s	%r2,%r18                        ; @0x616
	bl	vectorized_vec_sum              ; @0x618
	mov	%r22,0                          ; widened to benefit BPU
                                        ; @0x61c
	bl	clock                           ; @0x620
	sub_s	%r0,%r0,%r15                    ; @0x624
	fint2d	%r2,%r0                         ; @0x626
	std	%r22,[%sp,52]                   ; 8-byte Folded Spill
                                        ; @0x62a
	fdmul	%r22,%r2,%r22                   ; @0x62e
	bl	_timer_clocks_per_sec           ; @0x632
	fuint2d	%r2,%r0                         ; @0x636
	fddiv	%r22,%r22,%r2                   ; @0x63a
	mov_s	%r0,%r19                        ; @0x63e
	mov_s	%r1,%r22                        ; @0x640
	mov_s	%r2,%r23                        ; @0x642
	bl	printf                          ; @0x644
	fddiv	%r2,%r20,%r22                   ; @0x648
	mov_s	%r0,%r24                        ; @0x64c
	mov_s	%r1,%r2                         ; @0x64e
	mov_s	%r2,%r3                         ; @0x650
	bl	printf                          ; @0x652
	mov_s	%r0,%r16                        ; @0x656
	bl	puts                            ; @0x658
	ld_s	%r2,[%r14,0]                    ; @0x65c
	ld	%r4,[%r17,0]                    ; @0x65e
	ld	%r6,[%r18,0]                    ; @0x662
	mov_s	%r0,%r13                        ; @0x666
	mov_s	%r1,0                           ; @0x668
	mov_s	%r3,0                           ; @0x66a
	mov_s	%r5,0                           ; @0x66c
	bl	printf                          ; @0x66e
	ld_s	%r2,[%r14,4]                    ; @0x672
	ld	%r4,[%r17,4]                    ; @0x674
	ld	%r6,[%r18,4]                    ; @0x678
	mov_s	%r0,%r13                        ; @0x67c
	mov_s	%r1,1                           ; @0x67e
	mov_s	%r3,1                           ; @0x680
	mov_s	%r5,1                           ; @0x682
	bl	printf                          ; @0x684
	ld_s	%r2,[%r14,8]                    ; @0x688
	ld	%r4,[%r17,8]                    ; @0x68a
	ld	%r6,[%r18,8]                    ; @0x68e
	mov_s	%r0,%r13                        ; @0x692
	mov_s	%r1,2                           ; @0x694
	mov_s	%r3,2                           ; @0x696
	mov_s	%r5,2                           ; @0x698
	bl	printf                          ; @0x69a
	ld_s	%r2,[%r14,12]                   ; @0x69e
	ld	%r4,[%r17,12]                   ; @0x6a0
	ld	%r6,[%r18,12]                   ; @0x6a4
	mov_s	%r0,%r13                        ; @0x6a8
	mov_s	%r1,3                           ; @0x6aa
	mov_s	%r3,3                           ; @0x6ac
	mov_s	%r5,3                           ; @0x6ae
	bl	printf                          ; @0x6b0
	ld_s	%r2,[%r14,16]                   ; @0x6b4
	ld	%r4,[%r17,16]                   ; @0x6b6
	ld	%r6,[%r18,16]                   ; @0x6ba
	mov_s	%r0,%r13                        ; @0x6be
	mov_s	%r1,4                           ; @0x6c0
	mov_s	%r3,4                           ; @0x6c2
	mov_s	%r5,4                           ; @0x6c4
	bl	printf                          ; @0x6c6
	mov_s	%r0,10                          ; @0x6ca
	bl	putchar                         ; @0x6cc
	add	%r0,%r24,.Lstr.10-.L.str.6      ; @0x6d0
	bl	puts                            ; @0x6d4
	; Implicit def %r2                      ; @0x6d8
	mov	%lp_count,64                    ; @0x6d8
	add	%r0,%r18,56                     ; @0x6dc
	lp	.LZD4                           ; @0x6e0
.LBB2_9:                                ; %vector.body161
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x6e4
	std.ab	-1,[%r0,-8]                     ; @0x6e4
	std.ab	-1,[%r0,-8]                     ; @0x6e8
	std.ab	-1,[%r0,-8]                     ; @0x6ec
	std.ab	-1,[%r0,-8]                     ; @0x6f0
	std.ab	-1,[%r0,-8]                     ; @0x6f4
	std.ab	-1,[%r0,-8]                     ; @0x6f8
	std.ab	-1,[%r0,-8]                     ; @0x6fc
	std.ab	-1,[%r0,120]                    ; @0x700
	std.ab	-1,[%r0,-8]                     ; @0x704
	std.ab	-1,[%r0,-8]                     ; @0x708
	std.ab	-1,[%r0,-8]                     ; @0x70c
	std.ab	-1,[%r0,-8]                     ; @0x710
	std.ab	-1,[%r0,-8]                     ; @0x714
	std.ab	-1,[%r0,-8]                     ; @0x718
	std.ab	-1,[%r0,-8]                     ; @0x71c
	std.ab	-1,[%r0,120]                    ; @0x720
	std.ab	-1,[%r0,-8]                     ; @0x724
	std.ab	-1,[%r0,-8]                     ; @0x728
	std.ab	-1,[%r0,-8]                     ; @0x72c
	std.ab	-1,[%r0,-8]                     ; @0x730
	std.ab	-1,[%r0,-8]                     ; @0x734
	std.ab	-1,[%r0,-8]                     ; @0x738
	std.ab	-1,[%r0,-8]                     ; @0x73c
	std.ab	-1,[%r0,120]                    ; @0x740
	std.ab	-1,[%r0,-8]                     ; @0x744
	std.ab	-1,[%r0,-8]                     ; @0x748
	std.ab	-1,[%r0,-8]                     ; @0x74c
	std.ab	-1,[%r0,-8]                     ; @0x750
	std.ab	-1,[%r0,-8]                     ; @0x754
	std.ab	-1,[%r0,-8]                     ; @0x758
	std.ab	-1,[%r0,-8]                     ; @0x75c
	std.ab	-1,[%r0,120]                    ; @0x760
	std.ab	-1,[%r0,-8]                     ; @0x764
	std.ab	-1,[%r0,-8]                     ; @0x768
	std.ab	-1,[%r0,-8]                     ; @0x76c
	std.ab	-1,[%r0,-8]                     ; @0x770
	std.ab	-1,[%r0,-8]                     ; @0x774
	std.ab	-1,[%r0,-8]                     ; @0x778
	std.ab	-1,[%r0,-8]                     ; @0x77c
	std.ab	-1,[%r0,120]                    ; @0x780
	std.ab	-1,[%r0,-8]                     ; @0x784
	std.ab	-1,[%r0,-8]                     ; @0x788
	std.ab	-1,[%r0,-8]                     ; @0x78c
	std.ab	-1,[%r0,-8]                     ; @0x790
	std.ab	-1,[%r0,-8]                     ; @0x794
	std.ab	-1,[%r0,-8]                     ; @0x798
	std.ab	-1,[%r0,-8]                     ; @0x79c
	std.ab	-1,[%r0,120]                    ; @0x7a0
	std.ab	-1,[%r0,-8]                     ; @0x7a4
	std.ab	-1,[%r0,-8]                     ; @0x7a8
	std.ab	-1,[%r0,-8]                     ; @0x7ac
	std.ab	-1,[%r0,-8]                     ; @0x7b0
	std.ab	-1,[%r0,-8]                     ; @0x7b4
	std.ab	-1,[%r0,-8]                     ; @0x7b8
	std.ab	-1,[%r0,-8]                     ; @0x7bc
	std.ab	-1,[%r0,120]                    ; @0x7c0
	std.ab	-1,[%r0,-8]                     ; @0x7c4
	std.ab	-1,[%r0,-8]                     ; @0x7c8
	std.ab	-1,[%r0,-8]                     ; @0x7cc
	std.ab	-1,[%r0,-8]                     ; @0x7d0
	std.ab	-1,[%r0,-8]                     ; @0x7d4
	std.ab	-1,[%r0,-8]                     ; @0x7d8
	std.ab	-1,[%r0,-8]                     ; @0x7dc
	std.ab	-1,[%r0,120]                    ; @0x7e0
.LZD4:                                  ; @0x7e4
	; ZD Loop End                           ; @0x7e4
;  %bb.10:                              ; %init_vector.exit128
	nop                                     ; inserted to benefit BPU
                                        ; @0x7e4
	bl	clock                           ; @0x7e8
	mov_s	%r3,0                           ; @0x7ec
	bset_s	%r3,%r3,13                      ; @0x7ee
	mov_s	%r15,%r0                        ; @0x7f0
	mov_s	%r0,%r14                        ; @0x7f2
	mov_s	%r1,%r17                        ; @0x7f4
	mov_s	%r2,%r18                        ; @0x7f6
	bl	vekt_vec_sum                    ; @0x7f8
	ld	%r23,[%sp,56]                   ; 8-byte Folded Reload
                                        ; @0x7fc
	mov_s	%r22,0                          ; @0x800
	bl	clock                           ; @0x802
	sub_s	%r0,%r0,%r15                    ; @0x806
	fint2d	%r2,%r0                         ; @0x808
	fdmul	%r22,%r2,%r22                   ; @0x80c
	bl	_timer_clocks_per_sec           ; @0x810
	fuint2d	%r2,%r0                         ; @0x814
	fddiv	%r22,%r22,%r2                   ; @0x818
	add	%r0,%r19,.L.str.8-.L.str.5      ; @0x81c
	mov_s	%r1,%r22                        ; @0x820
	mov_s	%r2,%r23                        ; @0x822
	bl	printf                          ; @0x824
	fddiv	%r2,%r20,%r22                   ; @0x828
	mov_s	%r0,%r24                        ; @0x82c
	mov_s	%r1,%r2                         ; @0x82e
	mov_s	%r2,%r3                         ; @0x830
	bl	printf                          ; @0x832
	mov_s	%r0,%r16                        ; @0x836
	bl	puts                            ; @0x838
	ld_s	%r2,[%r14,0]                    ; @0x83c
	ld	%r4,[%r17,0]                    ; @0x83e
	ld	%r6,[%r18,0]                    ; @0x842
	mov_s	%r0,%r13                        ; @0x846
	mov_s	%r1,0                           ; @0x848
	mov_s	%r3,0                           ; @0x84a
	mov_s	%r5,0                           ; @0x84c
	bl	printf                          ; @0x84e
	ld_s	%r2,[%r14,4]                    ; @0x852
	ld	%r4,[%r17,4]                    ; @0x854
	ld	%r6,[%r18,4]                    ; @0x858
	mov_s	%r0,%r13                        ; @0x85c
	mov_s	%r1,1                           ; @0x85e
	mov_s	%r3,1                           ; @0x860
	mov_s	%r5,1                           ; @0x862
	bl	printf                          ; @0x864
	ld_s	%r2,[%r14,8]                    ; @0x868
	ld	%r4,[%r17,8]                    ; @0x86a
	ld	%r6,[%r18,8]                    ; @0x86e
	mov_s	%r0,%r13                        ; @0x872
	mov_s	%r1,2                           ; @0x874
	mov_s	%r3,2                           ; @0x876
	mov_s	%r5,2                           ; @0x878
	bl	printf                          ; @0x87a
	ld_s	%r2,[%r14,12]                   ; @0x87e
	ld	%r4,[%r17,12]                   ; @0x880
	ld	%r6,[%r18,12]                   ; @0x884
	mov_s	%r0,%r13                        ; @0x888
	mov_s	%r1,3                           ; @0x88a
	mov_s	%r3,3                           ; @0x88c
	mov_s	%r5,3                           ; @0x88e
	bl	printf                          ; @0x890
	ld_s	%r2,[%r14,16]                   ; @0x894
	ld	%r4,[%r17,16]                   ; @0x896
	ld	%r6,[%r18,16]                   ; @0x89a
	mov_s	%r0,%r13                        ; @0x89e
	mov_s	%r1,4                           ; @0x8a0
	mov_s	%r3,4                           ; @0x8a2
	mov_s	%r5,4                           ; @0x8a4
	bl	printf                          ; @0x8a6
	mov_s	%r0,0                           ; @0x8aa
	ld	%blink,[%sp,48]                 ; @0x8ac
	.cfa_restore	{%blink}                ; @0x8b0
	ld	%r24,[%sp,44]                   ; @0x8b0
	.cfa_restore	{%r24}                  ; @0x8b4
	ldd	%r22,[%sp,36]                   ; @0x8b4
	.cfa_restore	{%r23}                  ; @0x8b8
	.cfa_restore	{%r22}                  ; @0x8b8
	ldd	%r20,[%sp,28]                   ; @0x8b8
	.cfa_restore	{%r21}                  ; @0x8bc
	.cfa_restore	{%r20}                  ; @0x8bc
	ldd	%r18,[%sp,20]                   ; @0x8bc
	.cfa_restore	{%r19}                  ; @0x8c0
	.cfa_restore	{%r18}                  ; @0x8c0
	ldd	%r16,[%sp,12]                   ; @0x8c0
	.cfa_restore	{%r17}                  ; @0x8c4
	.cfa_restore	{%r16}                  ; @0x8c4
	ldd	%r14,[%sp,4]                    ; @0x8c4
	.cfa_restore	{%r15}                  ; @0x8c8
	.cfa_restore	{%r14}                  ; @0x8c8
	ld.ab	%r13,[%sp,60]                   ; @0x8c8
	.cfa_restore	{%r13}                  ; @0x8cc
	.cfa_pop	60                              ; @0x8cc
	j_s	[%blink]                        ; @0x8cc
	.cfa_ef
.Lfunc_end2:                            ; @0x8ce

	.reloc	_init_ad,0	;startup code to enable %status AD bit ; -- End function
