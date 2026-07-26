	.option	%reg
	.off	assume_short
	.file	"vec_sum.c"
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
	.globl	vectorized_vec_sum
	.type	vectorized_vec_sum,@function
	.type	.Lvectorized_vec_sum$local,@function
	.size	vectorized_vec_sum, .Lfunc_end2-vectorized_vec_sum
	.size	.Lvectorized_vec_sum$local, .Lfunc_end2-vectorized_vec_sum
	.globl	autovectorized_vec_sum
	.type	autovectorized_vec_sum,@function
	.type	.Lautovectorized_vec_sum$local,@function
	.size	autovectorized_vec_sum, .Lfunc_end3-autovectorized_vec_sum
	.size	.Lautovectorized_vec_sum$local, .Lfunc_end3-autovectorized_vec_sum
	.globl	vekt_vec_sum_wrapper
	.type	vekt_vec_sum_wrapper,@function
	.type	.Lvekt_vec_sum_wrapper$local,@function
	.size	vekt_vec_sum_wrapper, .Lfunc_end4-vekt_vec_sum_wrapper
	.size	.Lvekt_vec_sum_wrapper$local, .Lfunc_end4-vekt_vec_sum_wrapper
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
                                        ; -- Begin function vectorized_vec_sum
vectorized_vec_sum:                     ; @vectorized_vec_sum
                                        ; @0x184
.Lvectorized_vec_sum$local:             ; @0x184
	.cfa_bf	.Lvectorized_vec_sum$local
;  %bb.0:                               ; %entry
	.cfa_same	%r3                     ; @0x184
	mov_s	%r7,%r0                         ; @0x184
	asr	%r0,%r3,31                      ; @0x186
	lsr_s	%r0,%r0,28                      ; @0x18a
	add_s	%r0,%r3,%r0                     ; @0x18c
	mov_s	%r11,%r2                        ; @0x18e
	mov_s	%r6,%r1                         ; @0x190
	bmskn	%r30,%r0,3                      ; @0x192
	brlt	%r3,16,.LBB2_3                  ; @0x196
;  %bb.1:                               ; %for.body.preheader
	; Implicit def %r9                      ; @0x19a
	max	%r1,%r30,16                     ; @0x19a
	add_s	%r1,%r1,-1                      ; @0x19e
	lsr_s	%r1,%r1,4                       ; @0x1a0
	add	%lp_count,%r1,1                 ; @0x1a2
	mov_s	%r1,%r7                         ; @0x1a6
	mov_s	%r2,%r6                         ; @0x1a8
	mov_s	%r12,%r11                       ; @0x1aa
	lp	.LZD7                           ; @0x1ac
.LBB2_2:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x1b0
	vvld.av.w	%vr0,%r2,1              ; @0x1b0
	vvld.av.w	%vr1,%r1,1              ; @0x1b6
	vvadd.w	%vr0, %vr1, %vr0                ; @0x1bc
	vvst.av.w	%vr0,%r12,1             ; @0x1c2
.LZD7:                                  ; @0x1c8
	; ZD Loop End                           ; @0x1c8
.LBB2_3:                                ; %for.cond.cleanup
                                        ; @0x1c8
	cmp	%r3,%r30                        ; @0x1c8
	.cfa_remember_state                     ; @0x1cc
	nop                                     ; inserted to benefit BPU
                                        ; @0x1cc
	jle	[%blink]                        ; @0x1d0
	.cfa_restore_state                      ; @0x1d4
;  %bb.4:                               ; %iter.check
	sub	%r4,%r3,%r30                    ; @0x1d4
	cmp	%r4,8                           ; @0x1d8
	bcs	.LBB2_14                        ; @0x1dc
;  %bb.5:                               ; %vector.main.loop.iter.check
	asr_s	%r0,%r0,4                       ; @0x1e0
	asl	%r8,%r0,6                       ; @0x1e2
	cmp	%r4,64                          ; @0x1e6
	mov_s	%r9,0                           ; @0x1ea
	bcs	.LBB2_11                        ; @0x1ec
;  %bb.6:                               ; %vector.ph
	; Implicit def %r5                      ; @0x1f0
	sub3	%r0,%r4,64/8                    ; @0x1f0
	lsr_s	%r0,%r0,6                       ; @0x1f4
	add	%r1,%r7,%r8                     ; @0x1f6
	add	%r2,%r6,%r8                     ; @0x1fa
	add	%r12,%r11,%r8                   ; @0x1fe
	add	%lp_count,%r0,1                 ; @0x202
	add2	%r1,%r1,192/4                   ; @0x206
	add2	%r0,%r2,192/4                   ; @0x20a
	add2	%r2,%r12,192/4                  ; @0x20e
	bmskn	%r9,%r4,5                       ; @0x212
	lp	.LZD6                           ; @0x216
.LBB2_7:                                ; %vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x21a
	vvld.av.w	%vr0,%r1,-1             ; @0x21a
	vvld.av.w	%vr1,%r0,-1             ; @0x220
.vvsbundle  " v2" 
 ;	 { 
	vvld.av.w	%vr2,%r1,-1             ; @0x226
	vvadd.w	%vr0, %vr1, %vr0                ; @0x226
 ;	 }
	vvld.av.w	%vr1,%r0,-1             ; @0x230
.vvsbundle  " v2" 
 ;	 { 
	vvld.av.w	%vr3,%r1,-1             ; @0x236
	vvadd.w	%vr1, %vr1, %vr2                ; @0x236
 ;	 }
	vvld.av.w	%vr2,%r0,-1             ; @0x23e
.vvsbundle  " v2" 
 ;	 { 
	vvst.av.w	%vr0,%r2,-1             ; @0x244
	vvadd.w	%vr0, %vr2, %vr3                ; @0x244
 ;	 }
	vvst.av.w	%vr1,%r2,-1             ; @0x24e
	vvld.av.w	%vr1,%r1,7              ; @0x254
	vvld.av.w	%vr2,%r0,7              ; @0x25a
.vvsbundle  " v2" 
 ;	 { 
	vvst.av.w	%vr0,%r2,-1             ; @0x260
	vvadd.w	%vr0, %vr2, %vr1                ; @0x260
 ;	 }
	vvst.av.w	%vr0,%r2,7              ; @0x26a
.LZD6:                                  ; @0x270
	; ZD Loop End                           ; @0x270
;  %bb.8:                               ; %middle.block
	cmp	%r4,%r9                         ; @0x270
	.cfa_remember_state                     ; @0x274
	nop                                     ; inserted to benefit BPU
                                        ; @0x274
	jeq_s	[%blink]                        ; @0x278
	.cfa_restore_state                      ; @0x27a
;  %bb.9:                               ; %vec.epilog.iter.check
	tst	%r4,56                          ; @0x27a
	add.eq	%r30,%r30,%r9                   ; @0x27e
	beq_s	.LBB2_14                        ; Predicate Case 2
                                        ; @0x282
.LBB2_11:                               ; Predicate Case 2
                                        ; %vec.epilog.ph
                                        ; @0x284
.vvsbundle  "v1sc" 
 ;	 { 
	vvpinit.w	%p1, 0, 255             ; @0x284
	bmsk	%r5,%r3,2                       ; @0x284
 ;	 }
	add2	%r0,%r8,%r9                     ; @0x28e
	; Implicit def %r8                      ; @0x292
	add	%r9,%r9,%r5                     ; @0x292
	add	%r9,%r9,%r30                    ; @0x296
	sub	%r1,%r3,%r9                     ; @0x29a
	sub_s	%r1,%r1,8                       ; @0x29e
	lsr_s	%r1,%r1,3                       ; @0x2a0
	sub	%r12,%r4,%r5                    ; @0x2a2
	add	%lp_count,%r1,1                 ; @0x2a6
	add	%r1,%r11,%r0                    ; @0x2aa
	add	%r2,%r6,%r0                     ; @0x2ae
	add_s	%r0,%r0,%r7                     ; @0x2b2
	add	%r30,%r30,%r12                  ; @0x2b4
	lp	.LZD5                           ; @0x2b8
.LBB2_12:                               ; %vec.epilog.vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x2bc
	vvld.ab.w.p1	%vr0,%r0,32             ; @0x2bc
	vvld.ab.w.p1	%vr1,%r2,32             ; @0x2c4
	vvadd.w	%vr0, %vr1, %vr0                ; @0x2cc
	vvst.ab.w.p1	%vr0,%r1,32             ; @0x2d2
.LZD5:                                  ; @0x2da
	; ZD Loop End                           ; @0x2da
;  %bb.13:                              ; %vec.epilog.middle.block
	cmp	%r5,0                           ; widened to benefit BPU
                                        ; @0x2da
	.cfa_remember_state                     ; @0x2de
	nop_s                                   ; inserted to benefit BPU
                                        ; @0x2de
	jeq_s	[%blink]                        ; @0x2e0
	.cfa_restore_state                      ; @0x2e2
.LBB2_14:                               ; %for.body9.preheader
                                        ; @0x2e2
	; Implicit def %r1                      ; @0x2e2
	add	%r0,%r30,1                      ; @0x2e2
	max	%r0,%r3,%r0                     ; @0x2e6
	add2	%r7,%r7,%r30                    ; @0x2ea
	add2	%r6,%r6,%r30                    ; @0x2ee
	add2	%r11,%r11,%r30                  ; @0x2f2
	sub	%lp_count,%r0,%r30              ; @0x2f6
	lp	.LZD4                           ; @0x2fa
.LBB2_15:                               ; %for.body9
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x2fe
	ld.ab	%r0,[%r7,4]                     ; @0x2fe
	ld.ab	%r1,[%r6,4]                     ; @0x302
	add_s	%r0,%r1,%r0                     ; @0x306
	st.ab	%r0,[%r11,4]                    ; @0x308
.LZD4:                                  ; @0x30c
	; ZD Loop End                           ; @0x30c
;  %bb.16:                              ; %for.cond.cleanup8
	j_s	[%blink]                        ; @0x30c
	.cfa_ef
.Lfunc_end2:                            ; @0x30e

	.align	4                               ; -- End function
                                        ; -- Begin function autovectorized_vec_sum
autovectorized_vec_sum:                 ; @autovectorized_vec_sum
                                        ; @0x310
.Lautovectorized_vec_sum$local:         ; @0x310
	.cfa_bf	.Lautovectorized_vec_sum$local
;  %bb.0:                               ; %entry
	.cfa_same	%r30                    ; @0x310
	.cfa_same	%r5                     ; @0x310
	.cfa_same	%r4                     ; @0x310
	mov_s	%r11,%r3                        ; @0x310
	cmp_s	%r3,0                           ; @0x312
	.cfa_remember_state                     ; @0x314
	jle	[%blink]                        ; @0x314
	.cfa_restore_state                      ; @0x318
;  %bb.1:                               ; %iter.check
	cmp	%r11,8                          ; @0x318
	mov_s	%r8,0                           ; @0x31c
	bcs	.LBB3_10                        ; @0x31e
;  %bb.2:                               ; %vector.main.loop.iter.check
	cmp	%r11,64                         ; @0x322
	bcs	.LBB3_7                         ; @0x326
;  %bb.3:                               ; %vector.ph
	; Implicit def %r7                      ; @0x32a
	add	%r3,%r3,-64                     ; @0x32a
	lsr_s	%r3,%r3,6                       ; @0x32e
	add	%lp_count,%r3,1                 ; @0x330
	add2	%r9,%r1,192/4                   ; @0x334
	add2	%r12,%r0,192/4                  ; @0x338
	add2	%r3,%r2,192/4                   ; @0x33c
	bmskn	%r8,%r11,5                      ; @0x340
	lp	.LZD10                          ; @0x344
.LBB3_4:                                ; %vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x348
	vvld.av.w	%vr0,%r12,-1            ; @0x348
	vvld.av.w	%vr1,%r9,-1             ; @0x34e
.vvsbundle  " v2" 
 ;	 { 
	vvld.av.w	%vr2,%r12,-1            ; @0x354
	vvadd.w	%vr0, %vr1, %vr0                ; @0x354
 ;	 }
	vvld.av.w	%vr1,%r9,-1             ; @0x35e
.vvsbundle  " v2" 
 ;	 { 
	vvld.av.w	%vr3,%r12,-1            ; @0x364
	vvadd.w	%vr1, %vr1, %vr2                ; @0x364
 ;	 }
	vvld.av.w	%vr2,%r9,-1             ; @0x36c
.vvsbundle  " v2" 
 ;	 { 
	vvst.av.w	%vr0,%r3,-1             ; @0x372
	vvadd.w	%vr0, %vr2, %vr3                ; @0x372
 ;	 }
	vvst.av.w	%vr1,%r3,-1             ; @0x37c
	vvld.av.w	%vr1,%r12,7             ; @0x382
	vvld.av.w	%vr2,%r9,7              ; @0x388
.vvsbundle  " v2" 
 ;	 { 
	vvst.av.w	%vr0,%r3,-1             ; @0x38e
	vvadd.w	%vr0, %vr2, %vr1                ; @0x38e
 ;	 }
	vvst.av.w	%vr0,%r3,7              ; @0x398
.LZD10:                                 ; @0x39e
	; ZD Loop End                           ; @0x39e
;  %bb.5:                               ; %middle.block
	cmp	%r8,%r11                        ; @0x39e
	.cfa_remember_state                     ; @0x3a2
	jeq_s	[%blink]                        ; @0x3a2
	.cfa_restore_state                      ; @0x3a4
;  %bb.6:                               ; %vec.epilog.iter.check
	tst	%r11,56                         ; @0x3a4
	beq_s	.LBB3_10                        ; @0x3a8
.LBB3_7:                                ; %vec.epilog.ph
                                        ; @0x3aa
	; Implicit def %r7                      ; @0x3aa
.vvsbundle  "v1sc" 
 ;	 { 
	vvpinit.w	%p1, 0, 255             ; @0x3aa
	sub	%r3,%r11,%r8                    ; @0x3aa
 ;	 }
	sub_s	%r3,%r3,8                       ; @0x3b4
	lsr	%r6,%r3,3                       ; @0x3b6
	add2	%r9,%r2,%r8                     ; @0x3ba
	add2	%r12,%r1,%r8                    ; @0x3be
	add2	%r3,%r0,%r8                     ; @0x3c2
	add	%lp_count,%r6,1                 ; @0x3c6
	bmskn	%r8,%r11,2                      ; @0x3ca
	lp	.LZD9                           ; @0x3ce
.LBB3_8:                                ; %vec.epilog.vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x3d2
	vvld.ab.w.p1	%vr0,%r3,32             ; @0x3d2
	vvld.ab.w.p1	%vr1,%r12,32            ; @0x3da
	vvadd.w	%vr0, %vr1, %vr0                ; @0x3e2
	vvst.ab.w.p1	%vr0,%r9,32             ; @0x3e8
.LZD9:                                  ; @0x3f0
	; ZD Loop End                           ; @0x3f0
;  %bb.9:                               ; %vec.epilog.middle.block
	cmp	%r8,%r11                        ; @0x3f0
	.cfa_remember_state                     ; @0x3f4
	nop                                     ; inserted to benefit BPU
                                        ; @0x3f4
	jeq_s	[%blink]                        ; @0x3f8
	.cfa_restore_state                      ; @0x3fa
.LBB3_10:                               ; %for.body.preheader
                                        ; @0x3fa
	; Implicit def %r12                     ; @0x3fa
	add	%r3,%r8,1                       ; @0x3fa
	max	%r3,%r11,%r3                    ; @0x3fe
	add2	%r0,%r0,%r8                     ; @0x402
	add2	%r1,%r1,%r8                     ; @0x406
	add2	%r2,%r2,%r8                     ; @0x40a
	sub	%lp_count,%r3,%r8               ; @0x40e
	lp	.LZD8                           ; @0x412
.LBB3_11:                               ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x416
	ld.ab	%r3,[%r0,4]                     ; @0x416
	ld.ab	%r12,[%r1,4]                    ; @0x41a
	add_s	%r3,%r12,%r3                    ; @0x41e
	st.ab	%r3,[%r2,4]                     ; @0x420
.LZD8:                                  ; @0x424
	; ZD Loop End                           ; @0x424
;  %bb.12:                              ; %for.cond.cleanup
	j_s	[%blink]                        ; @0x424
	.cfa_ef
.Lfunc_end3:                            ; @0x426

	.align	4                               ; -- End function
                                        ; -- Begin function vekt_vec_sum_wrapper
vekt_vec_sum_wrapper:                   ; @vekt_vec_sum_wrapper
                                        ; @0x428
.Lvekt_vec_sum_wrapper$local:           ; @0x428
	.cfa_bf	.Lvekt_vec_sum_wrapper$local
;  %bb.0:                               ; %entry
	std.aw	%r18,[%sp,-28]                  ; @0x428
	.cfa_push	28                      ; @0x42c
	.cfa_reg_offset	{%r18}, 0               ; @0x42c
	.cfa_reg_offset	{%r19}, 4               ; @0x42c
	std	%r20,[%sp,8]                    ; @0x42c
	.cfa_reg_offset	{%r20}, 8               ; @0x430
	.cfa_reg_offset	{%r21}, 12              ; @0x430
	std	%r22,[%sp,16]                   ; @0x430
	.cfa_reg_offset	{%r22}, 16              ; @0x434
	.cfa_reg_offset	{%r23}, 20              ; @0x434
	st	%blink,[%sp,24]                 ; @0x434
	.cfa_reg_offset	{%blink}, 24            ; @0x438
	sub_s	%sp,%sp,32                      ; @0x438
	.cfa_push	32                      ; @0x43a
	mov_s	%r9,%r3                         ; @0x43a
	mov_s	%r22,%r2                        ; @0x43c
	mov_s	%r5,%r1                         ; @0x43e
	mov_s	%r23,%r2                        ; @0x440
	mov_s	%r4,1                           ; @0x442
	mov_s	%r2,0                           ; @0x444
	mov_s	%r21,%r3                        ; @0x446
	mov_s	%r18,%r9                        ; @0x448
	mov_s	%r1,%r0                         ; @0x44a
	mov_s	%r6,%r5                         ; @0x44c
	mov_s	%r8,%r4                         ; @0x44e
	mov_s	%r19,%r4                        ; @0x450
	mov_s	%r20,%r2                        ; @0x452
	mov_s	%r7,0                           ; @0x454
	std	%r8,[%sp,24]                    ; @0x456
	std	%r20,[%sp,16]                   ; @0x45a
	std	%r22,[%sp,8]                    ; @0x45e
	std	%r18,[%sp,0]                    ; @0x462
	bl	vekt_vec_sum                    ; @0x466
	add_s	%sp,%sp,32                      ; @0x46a
	.cfa_pop	32                              ; @0x46c
	ld	%blink,[%sp,24]                 ; @0x46c
	.cfa_restore	{%blink}                ; @0x470
	ldd	%r22,[%sp,16]                   ; @0x470
	.cfa_restore	{%r23}                  ; @0x474
	.cfa_restore	{%r22}                  ; @0x474
	ldd	%r20,[%sp,8]                    ; @0x474
	.cfa_restore	{%r21}                  ; @0x478
	.cfa_restore	{%r20}                  ; @0x478
	ldd.ab	%r18,[%sp,28]                   ; @0x478
	.cfa_restore	{%r19}                  ; @0x47c
	.cfa_restore	{%r18}                  ; @0x47c
	.cfa_pop	28                              ; @0x47c
	j_s	[%blink]                        ; @0x47c
	.cfa_ef
.Lfunc_end4:                            ; @0x47e

	.reloc	_init_ad,0	;startup code to enable %status AD bit ; -- End function
