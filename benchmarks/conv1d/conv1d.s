	.option	%reg
	.off	assume_short
	.file	"conv1d.c"
	.size	.Lstr, 2
	.type	.Lstr,@object
	.size	.L.str.1, 3
	.type	.L.str.1,@object
	.size	.L.str.2, 4
	.type	.L.str.2,@object
	.globl	init_vector
	.type	init_vector,@function
	.type	.Linit_vector$local,@function
	.size	init_vector, .Lfunc_end0-init_vector
	.size	.Linit_vector$local, .Lfunc_end0-init_vector
	.globl	print_vector
	.type	print_vector,@function
	.type	.Lprint_vector$local,@function
	.size	print_vector, .Lfunc_end1-print_vector
	.size	.Lprint_vector$local, .Lfunc_end1-print_vector
	.globl	conv1d
	.type	conv1d,@function
	.type	.Lconv1d$local,@function
	.size	conv1d, .Lfunc_end2-conv1d
	.size	.Lconv1d$local, .Lfunc_end2-conv1d
	.globl	vectorized_conv1d
	.type	vectorized_conv1d,@function
	.type	.Lvectorized_conv1d$local,@function
	.size	vectorized_conv1d, .Lfunc_end3-vectorized_conv1d
	.size	.Lvectorized_conv1d$local, .Lfunc_end3-vectorized_conv1d
	.globl	autovectorized_conv1d
	.type	autovectorized_conv1d,@function
	.type	.Lautovectorized_conv1d$local,@function
	.size	autovectorized_conv1d, .Lfunc_end4-autovectorized_conv1d
	.size	.Lautovectorized_conv1d$local, .Lfunc_end4-autovectorized_conv1d
	.globl	vekt_conv1d_wrapper
	.type	vekt_conv1d_wrapper,@function
	.type	.Lvekt_conv1d_wrapper$local,@function
	.size	vekt_conv1d_wrapper, .Lfunc_end5-vekt_conv1d_wrapper
	.size	.Lvekt_conv1d_wrapper$local, .Lfunc_end5-vekt_conv1d_wrapper
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
	.align	2
.Lstr:                                  ; @0x0
	.asciz	"]"
	.align	4
.L.str.1:                               ; @0x4
	.asciz	"%d"
	.align	4
.L.str.2:                               ; @0x8
	.asciz	"%d,"
	.text
	.global	.CC_I
	.equ	.CC_I, 0
	.ident	"LLVM 17.0.7/V-2024.06. (build 008) (LLVM 17.0.7) -arcv2hs -core4 -Xcode_density -Xatomic -Xll64 -Xunaligned -Xdiv_rem=radix4 -Xswap -Xbitscan -Xmpy_option=mpyd -Xshift_assist -Xbarrel_shifter -Xfpud_div -Xfpu_mac -Xtimer0 -Xrtc -Xstack_check -Xstu=4 -Xvdsp4 -Xvec_unit_rev_minor=1 -Xvec_width=512 -Xvec_mem_size=128k -Xvec_mem_bank_width=16 -Xvec_max_fetch_size=16 -Xvec_num_slots=3 -Xvec_super_with_scalar -Xvec_regs=32 -Xvec_fpu=32 -Xvec_fpu_math=3 -Xvec_fpu_2nd_mul -Xvec_fpu_types=2 -Xvec_num_rd_ports=6 -Xvec_num_acc=8 -Xvec_num_mpy=2 -Xvec_mpy32 -Xvec_num_alu=3 -Xvec_guard_bit_option=0 -Xvec_stack_check -Hvdsp_vector_c -O3 -fvectorize -fslp-vectorize -ffast-math"
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
	vvmov2.x.from.w	%r4,%vr0,0              ; @0x2c
	sub3	%r12,%r1,64/8                   ; @0x2c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r6,%vr0,2              ; @0x36
	lsr_s	%r12,%r12,6                     ; @0x36
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r8,%vr0,4              ; @0x3e
	bmskn	%r3,%r1,5                       ; @0x3e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r22,%vr0,6             ; @0x48
	add	%lp_count,%r12,1                ; @0x48
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r20,%vr0,8             ; @0x52
	add	%r12,%r0,56                     ; @0x52
 ;	 }
	vvmov2.x.from.w	%r18,%vr0,10            ; @0x5c
	vvmov2.x.from.w	%r16,%vr0,12            ; @0x62
	vvmov2.x.from.w	%r14,%vr0,14            ; @0x68
	lp	.LZD2                           ; @0x6e
.LBB0_4:                                ; %vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x72
	std.ab	%r14,[%r12,64]                  ; @0x72
	std.ab	%r14,[%r12,64]                  ; @0x76
	std.ab	%r14,[%r12,64]                  ; @0x7a
	std.ab	%r14,[%r12,-200]                ; @0x7e
	std.ab	%r16,[%r12,-8]                  ; @0x82
	std.ab	%r18,[%r12,-8]                  ; @0x86
	std.ab	%r20,[%r12,-8]                  ; @0x8a
	std.ab	%r22,[%r12,-8]                  ; @0x8e
	std.ab	%r8,[%r12,-8]                   ; @0x92
	std.ab	%r6,[%r12,-8]                   ; @0x96
	std.ab	%r4,[%r12,112]                  ; @0x9a
	std.ab	%r16,[%r12,-8]                  ; @0x9e
	std.ab	%r18,[%r12,-8]                  ; @0xa2
	std.ab	%r20,[%r12,-8]                  ; @0xa6
	std.ab	%r22,[%r12,-8]                  ; @0xaa
	std.ab	%r8,[%r12,-8]                   ; @0xae
	std.ab	%r6,[%r12,-8]                   ; @0xb2
	std.ab	%r4,[%r12,112]                  ; @0xb6
	std.ab	%r16,[%r12,-8]                  ; @0xba
	std.ab	%r18,[%r12,-8]                  ; @0xbe
	std.ab	%r20,[%r12,-8]                  ; @0xc2
	std.ab	%r22,[%r12,-8]                  ; @0xc6
	std.ab	%r8,[%r12,-8]                   ; @0xca
	std.ab	%r6,[%r12,-8]                   ; @0xce
	std.ab	%r4,[%r12,112]                  ; @0xd2
	std.ab	%r16,[%r12,-8]                  ; @0xd6
	std.ab	%r18,[%r12,-8]                  ; @0xda
	std.ab	%r20,[%r12,-8]                  ; @0xde
	std.ab	%r22,[%r12,-8]                  ; @0xe2
	std.ab	%r8,[%r12,-8]                   ; @0xe6
	std.ab	%r6,[%r12,-8]                   ; @0xea
	std.ab	%r4,[%r12,120]                  ; @0xee
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
                                        ; -- Begin function print_vector
print_vector:                           ; @print_vector
                                        ; @0x168
.Lprint_vector$local:                   ; @0x168
	.cfa_bf	.Lprint_vector$local
;  %bb.0:                               ; %entry
	st.aw	%r13,[%sp,-32]                  ; @0x168
	.cfa_push	32                      ; @0x16c
	.cfa_reg_offset	{%r13}, 0               ; @0x16c
	std	%r14,[%sp,4]                    ; @0x16c
	.cfa_reg_offset	{%r14}, 4               ; @0x170
	.cfa_reg_offset	{%r15}, 8               ; @0x170
	std	%r16,[%sp,12]                   ; @0x170
	.cfa_reg_offset	{%r16}, 12              ; @0x174
	.cfa_reg_offset	{%r17}, 16              ; @0x174
	std	%r18,[%sp,20]                   ; @0x174
	.cfa_reg_offset	{%r18}, 20              ; @0x178
	.cfa_reg_offset	{%r19}, 24              ; @0x178
	st	%blink,[%sp,28]                 ; @0x178
	.cfa_reg_offset	{%blink}, 28            ; @0x17c
	mov_s	%r13,%r0                        ; @0x17c
	mov_s	%r0,91                          ; @0x17e
	mov_s	%r19,%r1                        ; @0x180
	bl	putchar                         ; @0x182
	mov_s	%r16,.Lstr                      ; @0x186
	brlt	%r19,1,.LBB1_6                  ; @0x18c
;  %bb.1:                               ; %for.body.lr.ph
	sub	%r14,%r19,1                     ; @0x190
	add	%r17,%r16,.L.str.1-.Lstr        ; @0x194
	add	%r18,%r16,.L.str.2-.Lstr        ; @0x198
	mov_s	%r15,0                          ; @0x19c
.LBB1_2:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x19e
	ld.ab	%r1,[%r13,4]                    ; @0x19e
	cmp_s	%r15,%r14                       ; @0x1a2
	mov_s	%r0,%r17                        ; @0x1a4
	mov_s.ne	%r0,%r18                        ; Predicate Case 2
                                        ; @0x1a6
	bl	printf                          ; Predicate Case 1
                                        ; @0x1a8
	add_s	%r15,%r15,1                     ; @0x1ac
	brlt	%r15,%r19,.LBB1_2               ; @0x1ae
.LBB1_6:                                ; %for.cond.cleanup
                                        ; @0x1b2
	mov_s	%r0,%r16                        ; @0x1b2
	bl	puts                            ; @0x1b4
	ld	%blink,[%sp,28]                 ; @0x1b8
	.cfa_restore	{%blink}                ; @0x1bc
	ldd	%r18,[%sp,20]                   ; @0x1bc
	.cfa_restore	{%r19}                  ; @0x1c0
	.cfa_restore	{%r18}                  ; @0x1c0
	ldd	%r16,[%sp,12]                   ; @0x1c0
	.cfa_restore	{%r17}                  ; @0x1c4
	.cfa_restore	{%r16}                  ; @0x1c4
	ldd	%r14,[%sp,4]                    ; @0x1c4
	.cfa_restore	{%r15}                  ; @0x1c8
	.cfa_restore	{%r14}                  ; @0x1c8
	ld.ab	%r13,[%sp,32]                   ; @0x1c8
	.cfa_restore	{%r13}                  ; @0x1cc
	.cfa_pop	32                              ; @0x1cc
	j_s	[%blink]                        ; @0x1cc
	.cfa_ef
.Lfunc_end1:                            ; @0x1ce

	.align	4                               ; -- End function
                                        ; -- Begin function conv1d
conv1d:                                 ; @conv1d
                                        ; @0x1d0
.Lconv1d$local:                         ; @0x1d0
	.cfa_bf	.Lconv1d$local
;  %bb.0:                               ; %entry
	.cfa_same	%r30                    ; @0x1d0
	.cfa_same	%r7                     ; @0x1d0
	.cfa_same	%r5                     ; @0x1d0
	.cfa_same	%r3                     ; @0x1d0
	cmp_s	%r0,0                           ; @0x1d0
	.cfa_remember_state                     ; @0x1d2
	jle	[%blink]                        ; @0x1d2
	.cfa_restore_state                      ; @0x1d6
;  %bb.1:                               ; %entry
	mov_s	%r11,%r2                        ; @0x1d6
	cmp_s	%r2,0                           ; @0x1d8
	.cfa_remember_state                     ; @0x1da
	jle	[%blink]                        ; @0x1da
	.cfa_restore_state                      ; @0x1de
;  %bb.2:                               ; %for.body4.lr.ph.us.preheader
	mov_s	%r8,0                           ; @0x1de
.LBB2_4:                                ; %for.body4.lr.ph.us
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB2_5 Depth 2
                                        ; @0x1e0
	; Implicit def %r6                      ; @0x1e0
	add2	%r9,%r3,%r8                     ; @0x1e0
	mov	%lp_count,%r11                  ; @0x1e4
	ld	%r58,[%r9,0]                    ; @0x1e8
	mov_s	%r2,%r4                         ; @0x1ec
	mov_s	%r1,%r5                         ; @0x1ee
	lp	.LZD3                           ; @0x1f0
.LBB2_5:                                ; %for.body4.us
                                        ;   Parent Loop BB2_4 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; Label of block must be emitted
                                        ; @0x1f4 AlignLabel LoopTop Freq=1023
	ld.ab	%r6,[%r2,4]                     ; @0x1f4
	ld.ab	%r12,[%r1,4]                    ; @0x1f8
	mac	%r12,%r12,%r6                   ; @0x1fc
	st	%r12,[%r9,0]                    ; @0x200
.LZD3:                                  ; @0x204
	; ZD Loop End                           ; @0x204
;  %bb.3:                               ; %for.cond.cleanup3.us
                                        ;   in Loop: Header=BB2_4 Depth=1
	add_s	%r4,%r4,4                       ; @0x204
	add_s	%r8,%r8,1                       ; @0x206
	dbnz	%r0,.LBB2_4                     ; @0x208
;  %bb.6:                               ; %for.cond.cleanup
	j_s	[%blink]                        ; @0x20c
	.cfa_ef
.Lfunc_end2:                            ; @0x20e

	.align	4                               ; -- End function
                                        ; -- Begin function vectorized_conv1d
vectorized_conv1d:                      ; @vectorized_conv1d
                                        ; @0x210
.Lvectorized_conv1d$local:              ; @0x210
	.cfa_bf	.Lvectorized_conv1d$local
;  %bb.0:                               ; %entry
	.cfa_same	%r5                     ; @0x210
	.cfa_same	%r4                     ; @0x210
	.cfa_same	%r3                     ; @0x210
	st.aw	%r13,[%sp,-20]                  ; @0x210
	.cfa_push	20                      ; @0x214
	.cfa_reg_offset	{%r13}, 0               ; @0x214
	std	%r14,[%sp,4]                    ; @0x214
	.cfa_reg_offset	{%r14}, 4               ; @0x218
	.cfa_reg_offset	{%r15}, 8               ; @0x218
	st	%r16,[%sp,12]                   ; @0x218
	.cfa_reg_offset	{%r16}, 12              ; @0x21c
	st	%blink,[%sp,16]                 ; @0x21c
	.cfa_reg_offset	{%blink}, 16            ; @0x220
	mov_s	%r11,%r0                        ; @0x220
	asr_s	%r0,%r0,31                      ; @0x222
	lsr_s	%r0,%r0,28                      ; @0x224
	add	%r8,%r11,%r0                    ; @0x226
	mov_s	%blink,%r2                      ; @0x22a
	bmskn	%r16,%r8,3                      ; @0x22c
	brlt	%r11,16,.LBB3_8                 ; @0x230
;  %bb.1:                               ; %for.body.lr.ph
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr0, 0                        ; @0x234
	max	%r0,%r16,16                     ; @0x234
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvcmpy.lo.w	%vr16, %vr0, 0          ; @0x23c
	add_s	%r0,%r0,-1                      ; @0x23c
 ;	 }
	lsr_s	%r0,%r0,4                       ; @0x244
	add_s	%r2,%r0,1                       ; @0x246
	brlt	%blink,1,.LBB3_6                ; @0x248
;  %bb.2:                               ; %for.body4.lr.ph.us.preheader
	mov_s	%r0,%r4                         ; @0x24c
	mov_s	%r1,0                           ; @0x24e
.LBB3_4:                                ; %for.body4.lr.ph.us
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB3_5 Depth 2
                                        ; @0x250
	; Implicit def %r6                      ; @0x250
.vvsbundle  "v1sc" 
 ;	 { 
	vvcmov.b	%vr17, %vr16                    ; @0x250
	mov	%lp_count,%blink                ; @0x250
 ;	 }
	mov_s	%r13,%r5                        ; @0x258
	mov_s	%r12,%r0                        ; @0x25a
	lp	.LZD10                          ; @0x25c
.LBB3_5:                                ; %for.body4.us
                                        ;   Parent Loop BB3_4 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; Label of block must be emitted
                                        ; @0x260 AlignLabel LoopTop Freq=325
.vvsbundle  "v1sc" 
 ;	 { 
	vvld.ab.w	%vr0,%r12,4             ; @0x260
	ld.ab	%r14,[%r13,4]                   ; @0x260
 ;	 }
	vvcmac.lo.w	%vr17, %vr0, %r14       ; @0x26a
.LZD10:                                 ; @0x270
	; ZD Loop End                           ; @0x270
;  %bb.3:                               ; %for.cond.cleanup3.us
                                        ;   in Loop: Header=BB3_4 Depth=1
	add2	%r12,%r3,%r1                    ; @0x270
	add1	%r0,%r0,64/2                    ; @0x274
.vvsbundle  "v1sc" 
 ;	 { 
	vvst.w	%vr17,%r12                      ; @0x278
	add_s	%r1,%r1,16                      ; @0x278
 ;	 }
	dbnz	%r2,.LBB3_4                     ; @0x27e
	b_s	.LBB3_8                         ; @0x282
.LBB3_6:                                ; %for.body.lr.ph.split
                                        ; @0x284
	mov	%lp_count,%r2                   ; @0x284
	; Implicit def %r2                      ; @0x288
	mov_s	%r0,%r3                         ; @0x288
	lp	.LZD12                          ; @0x28a
.LBB3_7:                                ; %for.cond.cleanup3
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x28e
	vvst.av.w	%vr16,%r0,1             ; @0x28e
.LZD12:                                 ; @0x294
	; ZD Loop End                           ; @0x294
.LBB3_8:                                ; %for.cond.cleanup
                                        ; @0x294
	cmp	%r11,%r16                       ; @0x294
	cmp.gt	%blink,0                        ; @0x298
	ble	.LBB3_28                        ; Predicate Case 4
                                        ; @0x29c
;  %bb.10:                              ; %for.body20.lr.ph.split.us
	asr	%r0,%r8,4                       ; @0x2a0
	asl_s	%r12,%r0,6                      ; @0x2a4
	add_s	%r12,%r12,%r4                   ; @0x2a6
	brhs	%blink,8,.LBB3_11               ; @0x2a8
;  %bb.12:                              ; %iter.check.us.preheader
	sub	%r1,%r11,%r16                   ; @0x2ac
.LBB3_13:                               ; %iter.check.us
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB3_14 Depth 2
                                        ; @0x2b0
	; Implicit def %r8                      ; @0x2b0
	add2	%r2,%r3,%r16                    ; @0x2b0
	mov	%lp_count,%blink                ; @0x2b4
	ld	%r58,[%r2,0]                    ; @0x2b8
	mov_s	%r0,%r12                        ; @0x2bc
	mov_s	%r13,%r5                        ; @0x2be
	lp	.LZD5                           ; @0x2c0
.LBB3_14:                               ; %for.body25.us.us
                                        ;   Parent Loop BB3_13 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; Label of block must be emitted
                                        ; @0x2c4 AlignLabel LoopTop Freq=390
	ld.ab	%r14,[%r0,4]                    ; @0x2c4
	ld.ab	%r15,[%r13,4]                   ; @0x2c8
	mac	%r14,%r15,%r14                  ; @0x2cc
.LZD5:                                  ; @0x2d0
	; ZD Loop End                           ; @0x2d0
;  %bb.27:                              ; %for.cond.cleanup24.us.loopexit.us
                                        ;   in Loop: Header=BB3_13 Depth=1
	add_s	%r12,%r12,4                     ; @0x2d0
	add_s	%r16,%r16,1                     ; @0x2d2
	st_s	%r14,[%r2,0]                    ; @0x2d4
	dbnz	%r1,.LBB3_13                    ; @0x2d6
	b_s	.LBB3_28                        ; @0x2da
.LBB3_11:                               ; %iter.check.preheader
                                        ; @0x2dc
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov.w	 %vr1, 0                        ; @0x2dc
	vvci.w	%vr0                            ; @0x2dc
	sub3	%r0,%blink,64/8                 ; @0x2dc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvpinit.w	%p2, 0, 65532           ; @0x2e8
	lsr_s	%r0,%r0,6                       ; @0x2e8
 ;	 }
.vvsbundle  " v3" 
 ;	 { 
	vvadd.w	%vr3, %vr0, 4                   ; @0x2f0
	vvadd.w	%vr2, %vr0, 2                   ; @0x2f0
	vvpinit.w	%p3, 0, 65520           ; @0x2f0
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvsel.w.p2	%vr0, %vr1, %vr2        ; @0x2fe
	vvpinit.w	%p1, 0, 255             ; @0x2fe
	bmskn	%r7,%blink,2                    ; @0x2fe
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvsel.w.p3	%vr1, %vr1, %vr3        ; @0x30e
	vvpinit.w	%p2, 0, 15              ; @0x30e
	bmskn	%r8,%blink,5                    ; @0x30e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvpinit.w	%p3, 0, 3               ; @0x31e
	add	%r9,%r0,1                       ; @0x31e
 ;	 }
	sub	%r6,%blink,8                    ; @0x328
.LBB3_16:                               ; %iter.check
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB3_19 Depth 2
                                        ;     Child Loop BB3_23 Depth 2
                                        ;     Child Loop BB3_26 Depth 2
                                        ; @0x32c
	add2	%r30,%r3,%r16                   ; @0x32c
	cmp	%blink,64                       ; @0x330
	ld	%r1,[%r30,0]                    ; @0x334
	mov_s	%r0,0                           ; @0x338
	bcs	.LBB3_22                        ; Predicate Case 2
                                        ; @0x33a
;  %bb.18:                              ; Predicate Case 2
                                        ; %vector.ph
                                        ;   in Loop: Header=BB3_16 Depth=1
.vvsbundle  "v3sc" 
 ;	 { 
	vvmov.w	 %vr18, 0                       ; @0x33e
	vvmov.w	 %vr19, 0                       ; @0x33e
	vvmov.w	 %vr16, 0                       ; @0x33e
	add2	%r2,%r12,192/4                  ; @0x33e
 ;	 }
	; Implicit def %r13                     ; @0x34e
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr17, 0                       ; @0x34e
	mov	%lp_count,%r9                   ; @0x34e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr16,0,%r1             ; @0x356
	add2	%r1,%r5,192/4                   ; @0x356
 ;	 }
	lp	.LZD7                           ; @0x360
.LBB3_19:                               ; %vector.body
                                        ;   Parent Loop BB3_16 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; Label of block must be emitted
                                        ; @0x364 AlignLabel LoopTop Freq=195
	vvld.av.w	%vr2,%r2,-1             ; @0x364
	vvld.av.w	%vr3,%r1,-1             ; @0x36a
.vvsbundle  " v2" 
 ;	 { 
	vvld.av.w	%vr4,%r2,-1             ; @0x370
	vvcmac.lo.uu.w	%vr17, %vr3, %vr2       ; @0x370
 ;	 }
	vvld.av.w	%vr2,%r1,-1             ; @0x37a
.vvsbundle  " v2" 
 ;	 { 
	vvld.av.w	%vr3,%r2,-1             ; @0x380
	vvcmac.lo.uu.w	%vr18, %vr2, %vr4       ; @0x380
 ;	 }
	vvld.av.w	%vr2,%r1,-1             ; @0x38a
.vvsbundle  " v2" 
 ;	 { 
	vvld.av.w	%vr4,%r2,7              ; @0x390
	vvcmac.lo.uu.w	%vr19, %vr2, %vr3       ; @0x390
 ;	 }
	vvld.av.w	%vr2,%r1,7              ; @0x39a
	vvcmac.lo.uu.w	%vr16, %vr2, %vr4       ; @0x3a0
.LZD7:                                  ; @0x3a6
	; ZD Loop End                           ; @0x3a6
;  %bb.20:                              ; %middle.block
                                        ;   in Loop: Header=BB3_16 Depth=1
	vvadd.w	%vr2, %vr19, %vr16              ; @0x3a6
	vvadd.w	%vr2, %vr18, %vr2               ; @0x3ac
	vvadd.w	%vr16, %vr17, %vr2              ; @0x3b2
	vvc2add.w	%vr16                   ; @0x3b8
	vvshfleven.w	%vr16, %vr16            ; @0x3bc
	vvc2add.w	%vr16                   ; @0x3c0
	vvshfleven.w	%vr16, %vr16            ; @0x3c4
	vvc2add.w	%vr16                   ; @0x3c8
	vvshfleven.w	%vr16, %vr16            ; @0x3cc
	vvc2add.w	%vr16                   ; @0x3d0
	vvmov1.x.from.w	%r1,%vr16,0             ; @0x3d4
	breq	%r8,%blink,.LBB3_15             ; @0x3da
;  %bb.21:                              ; %vec.epilog.iter.check
                                        ;   in Loop: Header=BB3_16 Depth=1
	mov_s	%r0,%r8                         ; @0x3de
	mov_s	%r13,%r8                        ; @0x3e0
	tst	%blink,56                       ; @0x3e2
	beq	.LBB3_25                        ; @0x3e6
.LBB3_22:                               ; %vec.epilog.ph
                                        ;   in Loop: Header=BB3_16 Depth=1
                                        ; @0x3ea
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr2, 0                        ; @0x3ea
	sub	%r2,%r6,%r0                     ; @0x3ea
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,0,%r1              ; @0x3f2
	add	%r13,%r0,%r16                   ; @0x3f2
 ;	 }
	lsr	%r14,%r2,3                      ; @0x3fc
	add2	%r1,%r5,%r0                     ; @0x400
	add2	%r2,%r4,%r13                    ; @0x404
	; Implicit def %r13                     ; @0x408
	add	%lp_count,%r14,1                ; @0x408
	lp	.LZD8                           ; @0x40c
.LBB3_23:                               ; %vec.epilog.vector.body
                                        ;   Parent Loop BB3_16 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; Label of block must be emitted
                                        ; @0x410 AlignLabel LoopTop Freq=255
	vvld.ab.w.p1	%vr3,%r2,32             ; @0x410
	vvld.ab.w.p1	%vr4,%r1,32             ; @0x418
	vvmpy.w	%vr3, %vr4, %vr3                ; @0x420
	vvadd.w	%vr2, %vr3, %vr2                ; @0x426
.LZD8:                                  ; @0x42c
	; ZD Loop End                           ; @0x42c
;  %bb.24:                              ; %vec.epilog.middle.block
                                        ;   in Loop: Header=BB3_16 Depth=1

	mov_s	%r13,%r7                        ; implicit-def: $vr3
                                        ; @0x42c
	vvshfl.w.p2	%vr3, %vr2, %vr1        ; @0x42e
	vvadd.w	%vr2, %vr2, %vr3                ; @0x434
	vvshfl.w.p3	%vr3, %vr2, %vr0        ; @0x438
	vvadd.w	%vr2, %vr2, %vr3                ; @0x43e
	vvmov1.from.w	%r0,%vr2,1              ; @0x442
	vvadd.w	%vr2, %vr2, %r0                 ; @0x448
	vvmov1.x.from.w	%r1,%vr2,0              ; @0x44c
	breq	%r7,%blink,.LBB3_15             ; @0x452
.LBB3_25:                               ; %for.body25.us.preheader
                                        ;   in Loop: Header=BB3_16 Depth=1
                                        ; @0x456
	add_s	%r0,%r13,1                      ; @0x456
	max	%r0,%blink,%r0                  ; @0x458
	add	%r14,%r13,%r16                  ; @0x45c
	add2	%r2,%r5,%r13                    ; @0x460
	sub	%lp_count,%r0,%r13              ; @0x464
	add2	%r13,%r4,%r14                   ; @0x468
	mov	%r58,%r1                        ; @0x46c
	; Implicit def %r1                      ; @0x470
	lp	.LZD9                           ; @0x470
.LBB3_26:                               ; %for.body25.us
                                        ;   Parent Loop BB3_16 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; Label of block must be emitted
                                        ; @0x474 AlignLabel LoopTop Freq=164
	ld.ab	%r0,[%r13,4]                    ; @0x474
	ld.ab	%r1,[%r2,4]                     ; @0x478
	mac	%r1,%r1,%r0                     ; @0x47c
.LZD9:                                  ; @0x480
	; ZD Loop End                           ; @0x480
.LBB3_15:                               ; %for.cond.cleanup24.us
                                        ;   in Loop: Header=BB3_16 Depth=1
                                        ; @0x480
	add_s	%r16,%r16,1                     ; @0x480
	cmp	%r16,%r11                       ; @0x482
	add_s	%r12,%r12,4                     ; @0x486
	st	%r1,[%r30,0]                    ; @0x488
	blt	.LBB3_16                        ; @0x48c
.LBB3_28:                               ; %for.cond.cleanup19
                                        ; @0x490
	ld	%blink,[%sp,16]                 ; @0x490
	.cfa_restore	{%blink}                ; @0x494
	ld	%r16,[%sp,12]                   ; @0x494
	.cfa_restore	{%r16}                  ; @0x498
	ldd	%r14,[%sp,4]                    ; @0x498
	.cfa_restore	{%r15}                  ; @0x49c
	.cfa_restore	{%r14}                  ; @0x49c
	ld.ab	%r13,[%sp,20]                   ; @0x49c
	.cfa_restore	{%r13}                  ; @0x4a0
	.cfa_pop	20                              ; @0x4a0
	j_s	[%blink]                        ; @0x4a0
	.cfa_ef
.Lfunc_end3:                            ; @0x4a2

	.align	4                               ; -- End function
                                        ; -- Begin function autovectorized_conv1d
autovectorized_conv1d:                  ; @autovectorized_conv1d
                                        ; @0x4a4
.Lautovectorized_conv1d$local:          ; @0x4a4
	.cfa_bf	.Lautovectorized_conv1d$local
;  %bb.0:                               ; %entry
	.cfa_same	%r5                     ; @0x4a4
	.cfa_same	%r3                     ; @0x4a4
	st.aw	%r13,[%sp,-24]                  ; @0x4a4
	.cfa_push	24                      ; @0x4a8
	.cfa_reg_offset	{%r13}, 0               ; @0x4a8
	std	%r14,[%sp,4]                    ; @0x4a8
	.cfa_reg_offset	{%r14}, 4               ; @0x4ac
	.cfa_reg_offset	{%r15}, 8               ; @0x4ac
	std	%r16,[%sp,12]                   ; @0x4ac
	.cfa_reg_offset	{%r16}, 12              ; @0x4b0
	.cfa_reg_offset	{%r17}, 16              ; @0x4b0
	st	%blink,[%sp,20]                 ; @0x4b0
	.cfa_reg_offset	{%blink}, 20            ; @0x4b4
	cmp_s	%r0,0                           ; @0x4b4
	mov_s	%r16,%r0                        ; @0x4b6
	cmp.gt	%r2,0                           ; @0x4b8
	ble	.LBB4_31                        ; Predicate Case 4
                                        ; @0x4bc
;  %bb.2:                               ; %for.body.lr.ph.split.us
	brhs	%r2,8,.LBB4_6                   ; @0x4c0
;  %bb.3:                               ; %iter.check.us.preheader
	mov_s	%r1,0                           ; @0x4c4
.LBB4_4:                                ; %iter.check.us
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB4_5 Depth 2
                                        ; @0x4c6
	; Implicit def %r11                     ; @0x4c6
	add2	%r12,%r3,%r1                    ; @0x4c6
	mov	%lp_count,%r2                   ; @0x4ca
	ld	%r58,[%r12,0]                   ; @0x4ce
	mov_s	%r15,%r4                        ; @0x4d2
	mov	%r14,%r5                        ; @0x4d4
	lp	.LZD13                          ; @0x4d8
.LBB4_5:                                ; %for.body4.us.us
                                        ;   Parent Loop BB4_4 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; Label of block must be emitted
                                        ; @0x4dc AlignLabel LoopTop Freq=385
	ld.ab	%r13,[%r15,4]                   ; @0x4dc
	ld.ab	%r0,[%r14,4]                    ; @0x4e0
	mac	%r13,%r0,%r13                   ; @0x4e4
.LZD13:                                 ; @0x4e8
	; ZD Loop End                           ; @0x4e8
;  %bb.30:                              ; %for.cond.cleanup3.us.loopexit.us
                                        ;   in Loop: Header=BB4_4 Depth=1
	add_s	%r4,%r4,4                       ; @0x4e8
	add_s	%r1,%r1,1                       ; @0x4ea
	st_s	%r13,[%r12,0]                   ; @0x4ec
	dbnz	%r16,.LBB4_4                    ; @0x4ee
	b	.LBB4_31                        ; @0x4f2
.LBB4_6:                                ; %for.body.lr.ph.split.us.split
                                        ; @0x4f6
	cmp_s	%r2,63                          ; @0x4f6
	bmskn	%r9,%r2,2                       ; @0x4f8
	bhi	.LBB4_14                        ; @0x4fc
;  %bb.7:                               ; %iter.check.us51.preheader
.vvsbundle  "v2sc" 
 ;	 { 
	vvpinit.w	%p2, 0, 65532           ; @0x500
	vvci.w	%vr0                            ; @0x500
	add	%r0,%r9,1                       ; @0x500
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov.w	 %vr1, 0                        ; @0x50e
	vvpinit.w	%p3, 0, 65520           ; @0x50e
	asl_s	%r1,%r2,2                       ; @0x50e
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvadd.w	%vr3, %vr0, 4                   ; @0x51a
	vvadd.w	%vr2, %vr0, 2                   ; @0x51a
	sub	%r12,%r2,8                      ; @0x51a
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvsel.w.p2	%vr0, %vr1, %vr2        ; @0x528
	vvpinit.w	%p1, 0, 255             ; @0x528
	bmskn	%r8,%r1,4                       ; @0x528
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvsel.w.p3	%vr1, %vr1, %vr3        ; @0x538
	vvpinit.w	%p2, 0, 15              ; @0x538
	max	%r0,%r2,%r0                     ; @0x538
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvpinit.w	%p3, 0, 3               ; @0x548
	lsr_s	%r12,%r12,3                     ; @0x548
 ;	 }
	sub	%r11,%r0,%r9                    ; @0x550
	add	%r13,%r4,%r8                    ; @0x554
	add	%r8,%r5,%r8                     ; @0x558
	add	%r6,%r12,1                      ; @0x55c
	mov_s	%r1,0                           ; @0x560
.LBB4_8:                                ; %iter.check.us51
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB4_9 Depth 2
                                        ;     Child Loop BB4_13 Depth 2
                                        ; @0x562
	; Implicit def %r12                     ; @0x562
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr2, 0                        ; @0x562
	add2	%r7,%r3,%r1                     ; @0x562
 ;	 }
	mov	%lp_count,%r6                   ; @0x56a
	ld_s	%r0,[%r7,0]                     ; @0x56e
	mov	%r14,%r4                        ; @0x570
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,0,%r0              ; @0x574
	mov_s	%r15,%r5                        ; @0x574
 ;	 }
	lp	.LZD15                          ; @0x57c
.LBB4_9:                                ; %vec.epilog.vector.body.us
                                        ;   Parent Loop BB4_8 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; Label of block must be emitted
                                        ; @0x580 AlignLabel LoopTop Freq=192
	vvld.ab.w.p1	%vr3,%r14,32            ; @0x580
	vvld.ab.w.p1	%vr4,%r15,32            ; @0x588
	vvmpy.w	%vr3, %vr4, %vr3                ; @0x590
	vvadd.w	%vr2, %vr3, %vr2                ; @0x596
.LZD15:                                 ; @0x59c
	; ZD Loop End                           ; @0x59c
;  %bb.10:                              ; %vec.epilog.middle.block.us
                                        ;   in Loop: Header=BB4_8 Depth=1

	vvshfl.w.p2	%vr3, %vr2, %vr1        ; implicit-def: $vr3
                                        ; @0x59c
	vvadd.w	%vr2, %vr2, %vr3                ; @0x5a2
	vvshfl.w.p3	%vr3, %vr2, %vr0        ; @0x5a6
	vvadd.w	%vr2, %vr2, %vr3                ; @0x5ac
	vvmov1.from.w	%r0,%vr2,1              ; @0x5b0
	vvadd.w	%vr2, %vr2, %r0                 ; @0x5b6
	vvmov1.x.from.w	%r15,%vr2,0             ; @0x5ba
	breq	%r9,%r2,.LBB4_11                ; @0x5c0
;  %bb.12:                              ; %for.body4.us.us55.preheader
                                        ;   in Loop: Header=BB4_8 Depth=1
	; Implicit def %r30                     ; @0x5c4
	mov	%lp_count,%r11                  ; @0x5c4
	mov	%r58,%r15                       ; @0x5c8
	mov_s	%r12,%r13                       ; @0x5cc
	mov_s	%r14,%r8                        ; @0x5ce
	lp	.LZD16                          ; @0x5d0
.LBB4_13:                               ; %for.body4.us.us55
                                        ;   Parent Loop BB4_8 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; @0x5d4
	ld.ab	%r0,[%r12,4]                    ; @0x5d4
	ld.ab	%r15,[%r14,4]                   ; @0x5d8
	mac	%r15,%r15,%r0                   ; @0x5dc
.LZD16:                                 ; @0x5e0
	; ZD Loop End                           ; @0x5e0
.LBB4_11:                               ; %for.cond.cleanup3.us.us65
                                        ;   in Loop: Header=BB4_8 Depth=1
                                        ; @0x5e0
	add_s	%r13,%r13,4                     ; @0x5e0
	add_s	%r4,%r4,4                       ; @0x5e2
	add_s	%r1,%r1,1                       ; @0x5e4
	st	%r15,[%r7,0]                    ; @0x5e6
	dbnz	%r16,.LBB4_8                    ; @0x5ea
	b	.LBB4_31                        ; @0x5ee
.LBB4_14:                               ; %for.body.lr.ph.split.us.split.split
                                        ; @0x5f2
	bmskn	%r11,%r2,5                      ; @0x5f2
	cmp	%r11,%r2                        ; @0x5f6
	bne_s	.LBB4_15                        ; @0x5fa
;  %bb.16:                              ; %iter.check.us74.preheader
	add	%r2,%r2,-64                     ; @0x5fc
	lsr_s	%r2,%r2,6                       ; @0x600
	mov_s	%r1,0                           ; @0x602
	add	%r11,%r2,1                      ; @0x604
.LBB4_17:                               ; %iter.check.us74
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB4_18 Depth 2
                                        ; @0x608
	; Implicit def %r8                      ; @0x608
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr16, 0                       ; @0x608
	add2	%r12,%r3,%r1                    ; @0x608
 ;	 }
.vvsbundle  "v3sc" 
 ;	 { 
	vvmov.w	 %vr17, 0                       ; @0x610
	vvmov.w	 %vr18, 0                       ; @0x610
	vvmov.w	 %vr19, 0                       ; @0x610
	add2	%r2,%r4,192/4                   ; @0x610
 ;	 }
	ld_s	%r0,[%r12,0]                    ; @0x620
	add2	%r13,%r5,192/4                  ; @0x622
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr16,0,%r0             ; @0x626
	mov	%lp_count,%r11                  ; @0x626
 ;	 }
	lp	.LZD18                          ; @0x630
.LBB4_18:                               ; %vector.body.us
                                        ;   Parent Loop BB4_17 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; @0x634
	vvld.av.w	%vr0,%r2,-1             ; @0x634
	vvld.av.w	%vr1,%r13,-1            ; @0x63a
.vvsbundle  " v2" 
 ;	 { 
	vvld.av.w	%vr2,%r2,-1             ; @0x640
	vvcmac.lo.uu.w	%vr17, %vr1, %vr0       ; @0x640
 ;	 }
	vvld.av.w	%vr0,%r13,-1            ; @0x64a
.vvsbundle  " v2" 
 ;	 { 
	vvld.av.w	%vr1,%r2,-1             ; @0x650
	vvcmac.lo.uu.w	%vr18, %vr0, %vr2       ; @0x650
 ;	 }
	vvld.av.w	%vr0,%r13,-1            ; @0x65a
.vvsbundle  " v2" 
 ;	 { 
	vvld.av.w	%vr2,%r2,7              ; @0x660
	vvcmac.lo.uu.w	%vr19, %vr0, %vr1       ; @0x660
 ;	 }
	vvld.av.w	%vr0,%r13,7             ; @0x66a
	vvcmac.lo.uu.w	%vr16, %vr0, %vr2       ; @0x670
.LZD18:                                 ; @0x676
	; ZD Loop End                           ; @0x676
;  %bb.19:                              ; %middle.block.us
                                        ;   in Loop: Header=BB4_17 Depth=1
.vvsbundle  "v1sc" 
 ;	 { 
	vvadd.w	%vr0, %vr19, %vr16              ; @0x676
	add_s	%r4,%r4,4                       ; @0x676
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvadd.w	%vr0, %vr18, %vr0               ; @0x67e
	add_s	%r1,%r1,1                       ; @0x67e
 ;	 }
	vvadd.w	%vr16, %vr17, %vr0              ; @0x686
	vvc2add.w	%vr16                   ; @0x68c
	vvshfleven.w	%vr16, %vr16            ; @0x690
	vvc2add.w	%vr16                   ; @0x694
	vvshfleven.w	%vr16, %vr16            ; @0x698
	vvc2add.w	%vr16                   ; @0x69c
	vvshfleven.w	%vr16, %vr16            ; @0x6a0
	vvc2add.w	%vr16                   ; @0x6a4
	vvmov1.x.from.w	%r0,%vr16,0             ; @0x6a8
	st_s	%r0,[%r12,0]                    ; @0x6ae
	dbnz	%r16,.LBB4_17                   ; @0x6b0
	b_s	.LBB4_31                        ; @0x6b4
.LBB4_15:                               ; %iter.check.preheader
                                        ; @0x6b6
.vvsbundle  "v2sc" 
 ;	 { 
	vvpinit.w	%p3, 0, 65532           ; @0x6b6
	vvci.w	%vr0                            ; @0x6b6
	sub	%r0,%r2,%r11                    ; @0x6b6
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov.w	 %vr1, 0                        ; @0x6c4
	vvpinit.w	%p4, 0, 65520           ; @0x6c4
	asl_s	%r1,%r2,2                       ; @0x6c4
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvadd.w	%vr3, %vr0, 4                   ; @0x6d0
	vvadd.w	%vr2, %vr0, 2                   ; @0x6d0
	sub_s	%r0,%r0,8                       ; @0x6d0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvpinit.w	%p1, 0, 255             ; @0x6dc
	sub3	%r15,%r2,64/8                   ; @0x6dc
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvsel.w.p3	%vr0, %vr1, %vr2        ; @0x6e6
	vvpinit.w	%p2, 0, 15              ; @0x6e6
	bmskn	%r30,%r1,7                      ; @0x6e6
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvsel.w.p4	%vr1, %vr1, %vr3        ; @0x6f6
	vvpinit.w	%p3, 0, 3               ; @0x6f6
	lsr_s	%r0,%r0,3                       ; @0x6f6
 ;	 }
	lsr_s	%r15,%r15,6                     ; @0x704
	mov_s	%r17,%r4                        ; @0x706
	add	%r8,%r5,%r30                    ; @0x708
	add	%r30,%r4,%r30                   ; @0x70c
	add	%r6,%r0,1                       ; @0x710
	add	%r7,%r15,1                      ; @0x714
	mov_s	%r1,0                           ; @0x718
.LBB4_21:                               ; %iter.check
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB4_22 Depth 2
                                        ;     Child Loop BB4_26 Depth 2
                                        ;     Child Loop BB4_29 Depth 2
                                        ; @0x71a
	; Implicit def %r12                     ; @0x71a
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr16, 0                       ; @0x71a
	add2	%blink,%r3,%r1                  ; @0x71a
 ;	 }
.vvsbundle  "v3sc" 
 ;	 { 
	vvmov.w	 %vr17, 0                       ; @0x722
	vvmov.w	 %vr18, 0                       ; @0x722
	vvmov.w	 %vr19, 0                       ; @0x722
	add2	%r13,%r5,192/4                  ; @0x722
 ;	 }
	ld_s	%r0,[%blink,0]                  ; @0x732
	add2	%r14,%r17,192/4                 ; @0x734
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr16,0,%r0             ; @0x738
	mov	%lp_count,%r7                   ; @0x738
 ;	 }
	lp	.LZD20                          ; @0x742
.LBB4_22:                               ; %vector.body
                                        ;   Parent Loop BB4_21 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; @0x746
	vvld.av.w	%vr2,%r14,-1            ; @0x746
	vvld.av.w	%vr3,%r13,-1            ; @0x74c
.vvsbundle  " v2" 
 ;	 { 
	vvld.av.w	%vr4,%r14,-1            ; @0x752
	vvcmac.lo.uu.w	%vr17, %vr3, %vr2       ; @0x752
 ;	 }
	vvld.av.w	%vr2,%r13,-1            ; @0x75c
.vvsbundle  " v2" 
 ;	 { 
	vvld.av.w	%vr3,%r14,-1            ; @0x762
	vvcmac.lo.uu.w	%vr18, %vr2, %vr4       ; @0x762
 ;	 }
	vvld.av.w	%vr2,%r13,-1            ; @0x76c
.vvsbundle  " v2" 
 ;	 { 
	vvld.av.w	%vr4,%r14,7             ; @0x772
	vvcmac.lo.uu.w	%vr19, %vr2, %vr3       ; @0x772
 ;	 }
	vvld.av.w	%vr2,%r13,7             ; @0x77c
	vvcmac.lo.uu.w	%vr16, %vr2, %vr4       ; @0x782
.LZD20:                                 ; @0x788
	; ZD Loop End                           ; @0x788
;  %bb.23:                              ; %middle.block
                                        ;   in Loop: Header=BB4_21 Depth=1
.vvsbundle  "v1sc" 
 ;	 { 
	vvadd.w	%vr2, %vr19, %vr16              ; @0x788
	tst	%r2,56                          ; @0x788
 ;	 }
	vvadd.w	%vr2, %vr18, %vr2               ; @0x792
	vvadd.w	%vr16, %vr17, %vr2              ; @0x798
	vvc2add.w	%vr16                   ; @0x79e
	vvshfleven.w	%vr16, %vr16            ; @0x7a2
	vvc2add.w	%vr16                   ; @0x7a6
	vvshfleven.w	%vr16, %vr16            ; @0x7aa
	vvc2add.w	%vr16                   ; @0x7ae
	vvshfleven.w	%vr16, %vr16            ; @0x7b2
	vvc2add.w	%vr16                   ; @0x7b6
	vvmov1.x.from.w	%r13,%vr16,0            ; @0x7ba
	beq_s	.LBB4_24                        ; @0x7c0
;  %bb.25:                              ; %vec.epilog.ph
                                        ;   in Loop: Header=BB4_21 Depth=1
	; Implicit def %r12                     ; @0x7c2
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr2, 0                        ; @0x7c2
	mov	%lp_count,%r6                   ; @0x7c2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,0,%r13             ; @0x7ca
	mov_s	%r13,%r8                        ; @0x7ca
 ;	 }
	mov	%r14,%r30                       ; @0x7d2
	lp	.LZD21                          ; @0x7d6
.LBB4_26:                               ; %vec.epilog.vector.body
                                        ;   Parent Loop BB4_21 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; @0x7da
	vvld.ab.w.p1	%vr3,%r14,32            ; @0x7da
	vvld.ab.w.p1	%vr4,%r13,32            ; @0x7e2
	vvmpy.w	%vr3, %vr4, %vr3                ; @0x7ea
	vvadd.w	%vr2, %vr3, %vr2                ; @0x7f0
.LZD21:                                 ; @0x7f6
	; ZD Loop End                           ; @0x7f6
;  %bb.27:                              ; %vec.epilog.middle.block
                                        ;   in Loop: Header=BB4_21 Depth=1

	mov_s	%r15,%r9                        ; implicit-def: $vr3
                                        ; @0x7f6
	vvshfl.w.p2	%vr3, %vr2, %vr1        ; @0x7f8
	vvadd.w	%vr2, %vr2, %vr3                ; @0x7fe
	vvshfl.w.p3	%vr3, %vr2, %vr0        ; @0x802
	vvadd.w	%vr2, %vr2, %vr3                ; @0x808
	vvmov1.from.w	%r0,%vr2,1              ; @0x80c
	vvadd.w	%vr2, %vr2, %r0                 ; @0x812
	vvmov1.x.from.w	%r13,%vr2,0             ; @0x816
	brne	%r9,%r2,.LBB4_28                ; @0x81c
	b_s	.LBB4_20                        ; @0x820
.LBB4_24:                               ;   in Loop: Header=BB4_21 Depth=1
                                        ; @0x822
	mov_s	%r15,%r11                       ; @0x822
.LBB4_28:                               ; %for.body4.us.preheader
                                        ;   in Loop: Header=BB4_21 Depth=1
                                        ; @0x824
	add_s	%r0,%r15,1                      ; @0x824
	max	%r0,%r2,%r0                     ; @0x826
	add_s	%r12,%r15,%r1                   ; @0x82a
	add2	%r14,%r5,%r15                   ; @0x82c
	sub	%lp_count,%r0,%r15              ; @0x830
	add2	%r15,%r4,%r12                   ; @0x834
	; Implicit def %r12                     ; @0x838
	mov	%r58,%r13                       ; @0x838
	lp	.LZD22                          ; @0x83c
.LBB4_29:                               ; %for.body4.us
                                        ;   Parent Loop BB4_21 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; @0x840
	ld.ab	%r0,[%r15,4]                    ; @0x840
	ld.ab	%r12,[%r14,4]                   ; @0x844
	mac	%r13,%r12,%r0                   ; @0x848
.LZD22:                                 ; @0x84c
	; ZD Loop End                           ; @0x84c
.LBB4_20:                               ; %for.cond.cleanup3.us
                                        ;   in Loop: Header=BB4_21 Depth=1
                                        ; @0x84c
	add_s	%r1,%r1,1                       ; @0x84c
	cmp_s	%r1,%r16                        ; @0x84e
	add	%r30,%r30,4                     ; @0x850
	add_s	%r17,%r17,4                     ; @0x854
	st	%r13,[%blink,0]                 ; @0x856
	blt	.LBB4_21                        ; @0x85a
.LBB4_31:                               ; %for.cond.cleanup
                                        ; @0x85e
	ld	%blink,[%sp,20]                 ; @0x85e
	.cfa_restore	{%blink}                ; @0x862
	ldd	%r16,[%sp,12]                   ; @0x862
	.cfa_restore	{%r17}                  ; @0x866
	.cfa_restore	{%r16}                  ; @0x866
	ldd	%r14,[%sp,4]                    ; @0x866
	.cfa_restore	{%r15}                  ; @0x86a
	.cfa_restore	{%r14}                  ; @0x86a
	ld.ab	%r13,[%sp,24]                   ; @0x86a
	.cfa_restore	{%r13}                  ; @0x86e
	.cfa_pop	24                              ; @0x86e
	j_s	[%blink]                        ; @0x86e
	.cfa_ef
.Lfunc_end4:                            ; @0x870

	.align	4                               ; -- End function
                                        ; -- Begin function vekt_conv1d_wrapper
vekt_conv1d_wrapper:                    ; @vekt_conv1d_wrapper
                                        ; @0x870
.Lvekt_conv1d_wrapper$local:            ; @0x870
	.cfa_bf	.Lvekt_conv1d_wrapper$local
;  %bb.0:                               ; %entry
	.cfa_same	%r30                    ; @0x870
	.cfa_same	%r12                    ; @0x870
	.cfa_same	%r11                    ; @0x870
	.cfa_same	%r9                     ; @0x870
	.cfa_same	%r8                     ; @0x870
	.cfa_same	%r7                     ; @0x870
	.cfa_same	%r6                     ; @0x870
	.cfa_same	%r5                     ; @0x870
	.cfa_same	%r4                     ; @0x870
	.cfa_same	%r3                     ; @0x870
	.cfa_same	%r2                     ; @0x870
	.cfa_same	%r1                     ; @0x870
	.cfa_same	%r0                     ; @0x870
	j_s	[%blink]                        ; @0x870
	.cfa_ef
.Lfunc_end5:                            ; @0x872

	.reloc	_init_ad,0	;startup code to enable %status AD bit ; -- End function
