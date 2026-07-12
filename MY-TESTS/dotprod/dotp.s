	.option	%reg
	.off	assume_short
	.file	"dotp.c"
	.globl	dotp
	.type	dotp,@function
	.type	.Ldotp$local,@function
	.size	dotp, .Lfunc_end0-dotp
	.size	.Ldotp$local, .Lfunc_end0-dotp
	.globl	vectorized_dotp
	.type	vectorized_dotp,@function
	.type	.Lvectorized_dotp$local,@function
	.size	vectorized_dotp, .Lfunc_end1-vectorized_dotp
	.size	.Lvectorized_dotp$local, .Lfunc_end1-vectorized_dotp
	.globl	autovectorized_dotp
	.type	autovectorized_dotp,@function
	.type	.Lautovectorized_dotp$local,@function
	.size	autovectorized_dotp, .Lfunc_end2-autovectorized_dotp
	.size	.Lautovectorized_dotp$local, .Lfunc_end2-autovectorized_dotp
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
	.align	8                               ; -- Begin function dotp
dotp:                                   ; @dotp
                                        ; @0x0
.Ldotp$local:                           ; @0x0
	.cfa_bf	.Ldotp$local
;  %bb.0:                               ; %entry
	push_s	%blink                          ; @0x0
	.cfa_push	{%blink}                ; @0x2
	brlt	%r2,1,.LBB0_1                   ; @0x2
;  %bb.3:                               ; %for.body.lr.ph
	mov_s	%r11,0                          ; @0x6
	mov	%r58,0                          ; @0x8
	brlo	%r2,4,.LBB0_7                   ; @0xc
;  %bb.4:                               ; %vector.ph
	; Implicit def %r9                      ; @0x10
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr0, 0                        ; @0x10
	sub_s	%r3,%r2,4                       ; @0x10
 ;	 }
	lsr_s	%r3,%r3,2                       ; @0x16
	bmskn	%r11,%r2,1                      ; @0x18
	add	%lp_count,%r3,1                 ; @0x1c
	mov_s	%r12,%r1                        ; @0x20
	mov_s	%r3,%r0                         ; @0x22
	lp	.LZD1                           ; @0x24
.LBB0_5:                                ; %vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x28
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov.w	 %vr2, 0                        ; @0x28
	vvmov.w	 %vr1, 0                        ; @0x28
	ldd.ab	%r4,[%r3,16]                    ; @0x28
 ;	 }
	ldd.ab	%r6,[%r12,16]                   ; @0x34
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,0,%r4              ; @0x38
	ldd	%r8,[%r3,-8]                    ; @0x38
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,0,%r6              ; @0x42
	ldd	%r30,[%r12,-8]                  ; @0x42
 ;	 }
	vvmov1.vi.to.w	%vr1,1,%r5              ; @0x4c
	vvmov1.vi.to.w	%vr2,1,%r7              ; @0x52
	vvmov1.vi.to.w	%vr1,2,%r8              ; @0x58
	vvmov1.vi.to.w	%vr2,2,%r30             ; @0x5e
	vvmov1.vi.to.w	%vr1,3,%r9              ; @0x64
	vvmov1.vi.to.w	%vr2,3,%blink           ; @0x6a
	vvmpy.w	%vr1, %vr2, %vr1                ; @0x70
	vvadd.w	%vr0, %vr1, %vr0                ; @0x76
.LZD1:                                  ; @0x7c
	; ZD Loop End                           ; @0x7c
;  %bb.6:                               ; %middle.block
	vvmov2.x.from.w	%r4,%vr0,0              ; @0x7c
	vvmov2.x.from.w	%r6,%vr0,2              ; @0x82
	add	%r4,%r5,%r4                     ; @0x88
	add	%r4,%r6,%r4                     ; @0x8c
	add	%r58,%r7,%r4                    ; @0x90
	breq	%r11,%r2,.LBB0_2                ; @0x94
.LBB0_7:                                ; %for.body.preheader
                                        ; @0x98
	add	%r3,%r11,1                      ; @0x98
	max	%r2,%r2,%r3                     ; @0x9c
	; Implicit def %r3                      ; @0xa0
	add2	%r0,%r0,%r11                    ; @0xa0
	add2	%r1,%r1,%r11                    ; @0xa4
	sub	%lp_count,%r2,%r11              ; @0xa8
	lp	.LZD0                           ; @0xac
.LBB0_8:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0xb0
	ld.ab	%r2,[%r0,4]                     ; @0xb0
	ld.ab	%r3,[%r1,4]                     ; @0xb4
	mac	0,%r3,%r2                       ; @0xb8
.LZD0:                                  ; @0xbc
	; ZD Loop End                           ; @0xbc
	nop                                     ; inserted to benefit BPU
                                        ; @0xbc
	b_s	.LBB0_2                         ; @0xc0
.LBB0_1:                                ; @0xc2
	mov	%r58,0                          ; @0xc2
.LBB0_2:                                ; %for.cond.cleanup
                                        ; @0xc6
	mov	%r0,%r58                        ; @0xc6
	pop_s	%blink                          ; @0xca
	.cfa_restore	{%blink}                ; @0xcc
	.cfa_pop	4                               ; @0xcc
	j_s	[%blink]                        ; @0xcc
	.cfa_ef
.Lfunc_end0:                            ; @0xce

	.align	4                               ; -- End function
                                        ; -- Begin function vectorized_dotp
vectorized_dotp:                        ; @vectorized_dotp
                                        ; @0xd0
.Lvectorized_dotp$local:                ; @0xd0
	.cfa_bf	.Lvectorized_dotp$local
;  %bb.0:                               ; %entry
	.cfa_same	%r30                    ; @0xd0
	.cfa_same	%r5                     ; @0xd0
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr0, 0                        ; @0xd0
	mov_s	%r6,%r0                         ; @0xd0
 ;	 }
	asr	%r0,%r2,31                      ; @0xd6
.vvsbundle  "v1sc" 
 ;	 { 
	vvcmpy.lo.w	%vr16, %vr0, 0          ; @0xda
	lsr_s	%r0,%r0,28                      ; @0xda
 ;	 }
	mov_s	%r3,%r2                         ; @0xe2
	cmp_s	%r2,16                          ; @0xe4
	add_s	%r2,%r2,%r0                     ; @0xe6
	mov_s	%r11,%r1                        ; @0xe8
	bmskn	%r12,%r2,3                      ; @0xea
	blt	.LBB1_3                         ; @0xee
;  %bb.1:                               ; %for.body.preheader
	; Implicit def %r9                      ; @0xf2
	max	%r0,%r12,16                     ; @0xf2
	add_s	%r0,%r0,-1                      ; @0xf6
	lsr_s	%r0,%r0,4                       ; @0xf8
	add	%lp_count,%r0,1                 ; @0xfa
	mov_s	%r0,%r6                         ; @0xfe
	mov_s	%r1,%r11                        ; @0x100
	lp	.LZD5                           ; @0x102
.LBB1_2:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x106
	vvld.av.w	%vr1,%r1,1              ; @0x106
	vvld.av.w	%vr2,%r0,1              ; @0x10c
	vvcmac.lo.w	%vr16, %vr2, %vr1       ; @0x112
.LZD5:                                  ; @0x118
	; ZD Loop End                           ; @0x118
.LBB1_3:                                ; %for.cond.cleanup
                                        ; @0x118
.vvsbundle  "v1sc" 
 ;	 { 
	vvc4add.w	%vr16                   ; @0x118
	cmp_s	%r3,%r12                        ; @0x118
 ;	 }
	vvc4pack.w	%vr16                   ; @0x11e
	vvc4add.w	%vr16                   ; @0x122
	vvc4pack.w	%vr16                   ; @0x126
	vvmov1.x.from.w	%r0,%vr16,0             ; @0x12a
	.cfa_remember_state                     ; @0x130
	jle	[%blink]                        ; @0x130
	.cfa_restore_state                      ; @0x134
;  %bb.4:                               ; %iter.check
	sub_s	%r1,%r3,%r12                    ; @0x134
	cmp_s	%r1,8                           ; @0x136
	bcs	.LBB1_14                        ; @0x138
;  %bb.5:                               ; %vector.main.loop.iter.check
	asr_s	%r2,%r2,4                       ; @0x13c
	asl	%r8,%r2,6                       ; @0x13e
	cmp_s	%r1,64                          ; @0x142
	mov_s	%r9,0                           ; @0x144
	bcs	.LBB1_11                        ; @0x146
;  %bb.6:                               ; %vector.ph

	; Implicit def %r4                      ; implicit-def: $vra17
                                        ; @0x14a
.vvsbundle  "v1sc" 
 ;	 { 
	vvpinit.w	%p1, 0, 65534           ; @0x14a
	sub3	%r0,%r1,64/8                    ; @0x14a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvpinit.w	%p2, 0, 1               ; @0x154
	lsr_s	%r0,%r0,6                       ; @0x154
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvshfl.w.p1	%vr17, %vr0, %vr0       ; @0x15c
	add	%lp_count,%r0,1                 ; @0x15c
 ;	 }
	add	%r2,%r11,%r8                    ; @0x166
	add	%r7,%r6,%r8                     ; @0x16a
.vvsbundle  "v1sc" 
 ;	 { 
	vvshfl.w.p2	%vr17, %vr16, %vr0      ; @0x16e
	bmskn	%r9,%r1,5                       ; @0x16e
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov.w	 %vr18, 0                       ; @0x178
	vvmov.w	 %vr19, 0                       ; @0x178
	add2	%r0,%r2,192/4                   ; @0x178
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr16, 0                       ; @0x184
	add2	%r2,%r7,192/4                   ; @0x184
 ;	 }
	lp	.LZD4                           ; @0x18c
.LBB1_7:                                ; %vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x190
	vvld.av.w	%vr0,%r2,-1             ; @0x190
	vvld.av.w	%vr1,%r0,-1             ; @0x196
.vvsbundle  " v2" 
 ;	 { 
	vvld.av.w	%vr2,%r2,-1             ; @0x19c
	vvcmac.lo.uu.w	%vr16, %vr1, %vr0       ; @0x19c
 ;	 }
	vvld.av.w	%vr0,%r0,-1             ; @0x1a6
.vvsbundle  " v2" 
 ;	 { 
	vvld.av.w	%vr1,%r2,-1             ; @0x1ac
	vvcmac.lo.uu.w	%vr18, %vr0, %vr2       ; @0x1ac
 ;	 }
	vvld.av.w	%vr0,%r0,-1             ; @0x1b6
.vvsbundle  " v2" 
 ;	 { 
	vvld.av.w	%vr2,%r2,7              ; @0x1bc
	vvcmac.lo.uu.w	%vr19, %vr0, %vr1       ; @0x1bc
 ;	 }
	vvld.av.w	%vr0,%r0,7              ; @0x1c6
	vvcmac.lo.uu.w	%vr17, %vr0, %vr2       ; @0x1cc
.LZD4:                                  ; @0x1d2
	; ZD Loop End                           ; @0x1d2
;  %bb.8:                               ; %middle.block
.vvsbundle  "v1sc" 
 ;	 { 
	vvadd.w	%vr0, %vr19, %vr17              ; @0x1d2
	cmp_s	%r1,%r9                         ; @0x1d2
 ;	 }
	vvadd.w	%vr0, %vr18, %vr0               ; @0x1da
	vvadd.w	%vr16, %vr16, %vr0              ; @0x1e0
	vvc2add.w	%vr16                   ; @0x1e4
	vvshfleven.w	%vr16, %vr16            ; @0x1e8
	vvc2add.w	%vr16                   ; @0x1ec
	vvshfleven.w	%vr16, %vr16            ; @0x1f0
	vvc2add.w	%vr16                   ; @0x1f4
	vvshfleven.w	%vr16, %vr16            ; @0x1f8
	vvc2add.w	%vr16                   ; @0x1fc
	vvmov1.x.from.w	%r0,%vr16,0             ; @0x200
	.cfa_remember_state                     ; @0x206
	jeq_s	[%blink]                        ; @0x206
	.cfa_restore_state                      ; @0x208
;  %bb.9:                               ; %vec.epilog.iter.check
	tst	%r1,56                          ; @0x208
	add.eq	%r12,%r12,%r9                   ; @0x20c
	beq_s	.LBB1_14                        ; Predicate Case 2
                                        ; @0x210
.LBB1_11:                               ; Predicate Case 2
                                        ; %vec.epilog.ph
                                        ; @0x212
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov.w	 %vr1, 0                        ; @0x212
	vvmov.w	 %vr0, 0                        ; @0x212
	bmsk	%r7,%r3,2                       ; @0x212
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvpinit.w	%p1, 0, 255             ; @0x21e
	vvmov1.vi.to.w	%vr0,0,%r0              ; @0x21e
	add2	%r8,%r8,%r9                     ; @0x21e
 ;	 }
	add	%r9,%r9,%r7                     ; @0x22c
	add	%r9,%r9,%r12                    ; @0x230
	sub	%r0,%r3,%r9                     ; @0x234
	sub_s	%r0,%r0,8                       ; @0x238
	lsr_s	%r0,%r0,3                       ; @0x23a
	sub	%r2,%r1,%r7                     ; @0x23c
	add	%lp_count,%r0,1                 ; @0x240
	add	%r0,%r11,%r8                    ; @0x244
	add	%r1,%r6,%r8                     ; @0x248
	; Implicit def %r8                      ; @0x24c
	add_s	%r12,%r12,%r2                   ; @0x24c
	lp	.LZD3                           ; @0x24e
.LBB1_12:                               ; %vec.epilog.vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x252
	vvld.ab.w.p1	%vr2,%r1,32             ; @0x252
	vvld.ab.w.p1	%vr3,%r0,32             ; @0x25a
	vvmpy.w	%vr2, %vr3, %vr2                ; @0x262
	vvadd.w	%vr0, %vr2, %vr0                ; @0x268
.LZD3:                                  ; @0x26e
	; ZD Loop End                           ; @0x26e
;  %bb.13:                              ; %vec.epilog.middle.block
.vvsbundle  "v2sc" 
 ;	 { 
	vvpinit.w	%p1, 0, 65520           ; @0x26e
	vvci.w	%vr2                            ; @0x26e
	cmp_s	%r7,0                           ; @0x26e
 ;	 }
	vvpinit.w	%p2, 0, 15              ; @0x27a
.vvsbundle  " v3" 
 ;	 { 
	vvadd.w	%vr2, %vr2, 2                   ; @0x280
	vvpinit.w	%p3, 0, 65532           ; @0x280
	vvadd.w	%vr3, %vr2, 4                   ; @0x280
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvpinit.w	%p4, 0, 3               ; @0x28e
	vvsel.w.p1	%vr3, %vr1, %vr3        ; @0x28e
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvsel.w.p3	%vr1, %vr1, %vr2        ; @0x29a
	vvshfl.w.p2	%vr3, %vr0, %vr3        ; @0x29a
 ;	 }
	vvadd.w	%vr0, %vr0, %vr3                ; @0x2a4
	vvshfl.w.p4	%vr1, %vr0, %vr1        ; @0x2a8
	vvadd.w	%vr0, %vr0, %vr1                ; @0x2ae
	vvmov1.from.w	%r0,%vr0,1              ; @0x2b2
	vvadd.w	%vr0, %vr0, %r0                 ; @0x2b8
	vvmov1.x.from.w	%r0,%vr0,0              ; @0x2bc
	.cfa_remember_state                     ; @0x2c2
	jeq_s	[%blink]                        ; @0x2c2
	.cfa_restore_state                      ; @0x2c4
.LBB1_14:                               ; %for.body29.preheader
                                        ; @0x2c4
	add_s	%r1,%r12,1                      ; @0x2c4
	max	%r1,%r3,%r1                     ; @0x2c6
	add2	%r6,%r6,%r12                    ; @0x2ca
	add2	%r11,%r11,%r12                  ; @0x2ce
	sub	%lp_count,%r1,%r12              ; @0x2d2
	; Implicit def %r1                      ; @0x2d6
	mov	%r58,%r0                        ; @0x2d6
	lp	.LZD2                           ; @0x2da
.LBB1_15:                               ; %for.body29
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x2de
	ld.ab	%r0,[%r6,4]                     ; @0x2de
	ld.ab	%r1,[%r11,4]                    ; @0x2e2
	mac	%r0,%r1,%r0                     ; @0x2e6
.LZD2:                                  ; @0x2ea
	; ZD Loop End                           ; @0x2ea
;  %bb.16:                              ; %for.cond.cleanup28
	j_s	[%blink]                        ; @0x2ea
	.cfa_ef
.Lfunc_end1:                            ; @0x2ec

	.align	4                               ; -- End function
                                        ; -- Begin function autovectorized_dotp
autovectorized_dotp:                    ; @autovectorized_dotp
                                        ; @0x2ec
.Lautovectorized_dotp$local:            ; @0x2ec
	.cfa_bf	.Lautovectorized_dotp$local
;  %bb.0:                               ; %entry
	.cfa_same	%r30                    ; @0x2ec
	.cfa_same	%r7                     ; @0x2ec
	.cfa_same	%r6                     ; @0x2ec
	.cfa_same	%r5                     ; @0x2ec
	.cfa_same	%r4                     ; @0x2ec
	mov_s	%r3,%r2                         ; @0x2ec
	cmp_s	%r2,0                           ; @0x2ee
	mov_s	%r2,0                           ; @0x2f0
	ble	.LBB2_13                        ; @0x2f2
;  %bb.1:                               ; %iter.check
	cmp_s	%r3,8                           ; @0x2f6
	mov_s	%r11,0                          ; @0x2f8
	bcs	.LBB2_11                        ; Predicate Case 2
                                        ; @0x2fa
;  %bb.3:                               ; Predicate Case 2
                                        ; %vector.main.loop.iter.check
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr0, 0                        ; @0x2fe
	cmp_s	%r3,64                          ; @0x2fe
 ;	 }
	mov_s	%r11,0                          ; @0x304
	bcs	.LBB2_8                         ; @0x306
;  %bb.4:                               ; %vector.ph
.vvsbundle  "v3sc" 
 ;	 { 
	vvmov.w	 %vr16, 0                       ; @0x30a
	vvmov.w	 %vr18, 0                       ; @0x30a
	vvmov.w	 %vr17, 0                       ; @0x30a
	sub3	%r2,%r3,64/8                    ; @0x30a
 ;	 }
	; Implicit def %r9                      ; @0x31a
	lsr_s	%r2,%r2,6                       ; @0x31a
	add	%lp_count,%r2,1                 ; @0x31c
	add2	%r2,%r1,192/4                   ; @0x320
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr19, 0                       ; @0x324
	add2	%r12,%r0,192/4                  ; @0x324
 ;	 }
	bmskn	%r11,%r3,5                      ; @0x32c
	lp	.LZD8                           ; @0x330
.LBB2_5:                                ; %vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x334
	vvld.av.w	%vr1,%r12,-1            ; @0x334
	vvld.av.w	%vr2,%r2,-1             ; @0x33a
.vvsbundle  " v2" 
 ;	 { 
	vvld.av.w	%vr3,%r12,-1            ; @0x340
	vvcmac.lo.uu.w	%vr19, %vr2, %vr1       ; @0x340
 ;	 }
	vvld.av.w	%vr1,%r2,-1             ; @0x34a
.vvsbundle  " v2" 
 ;	 { 
	vvld.av.w	%vr2,%r12,-1            ; @0x350
	vvcmac.lo.uu.w	%vr16, %vr1, %vr3       ; @0x350
 ;	 }
	vvld.av.w	%vr1,%r2,-1             ; @0x35a
.vvsbundle  " v2" 
 ;	 { 
	vvld.av.w	%vr3,%r12,7             ; @0x360
	vvcmac.lo.uu.w	%vr18, %vr1, %vr2       ; @0x360
 ;	 }
	vvld.av.w	%vr1,%r2,7              ; @0x36a
	vvcmac.lo.uu.w	%vr17, %vr1, %vr3       ; @0x370
.LZD8:                                  ; @0x376
	; ZD Loop End                           ; @0x376
;  %bb.6:                               ; %middle.block
.vvsbundle  "v1sc" 
 ;	 { 
	vvadd.w	%vr1, %vr18, %vr17              ; @0x376
	cmp	%r11,%r3                        ; @0x376
 ;	 }
	vvadd.w	%vr1, %vr16, %vr1               ; @0x380
	vvadd.w	%vr16, %vr19, %vr1              ; @0x386
	vvc2add.w	%vr16                   ; @0x38c
	vvshfleven.w	%vr16, %vr16            ; @0x390
	vvc2add.w	%vr16                   ; @0x394
	vvshfleven.w	%vr16, %vr16            ; @0x398
	vvc2add.w	%vr16                   ; @0x39c
	vvshfleven.w	%vr16, %vr16            ; @0x3a0
	vvc2add.w	%vr16                   ; @0x3a4
	vvmov1.x.from.w	%r2,%vr16,0             ; @0x3a8
	beq_s	.LBB2_13                        ; @0x3ae
;  %bb.7:                               ; %vec.epilog.iter.check
	tst	%r3,56                          ; @0x3b0
	beq_s	.LBB2_11                        ; @0x3b4
.LBB2_8:                                ; %vec.epilog.ph
                                        ; @0x3b6
	; Implicit def %r9                      ; @0x3b6
.vvsbundle  "v2sc" 
 ;	 { 
	vvpinit.w	%p1, 0, 255             ; @0x3b6
	vvmov.w	 %vr1, 0                        ; @0x3b6
	sub	%r12,%r3,%r11                   ; @0x3b6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,0,%r2              ; @0x3c4
	sub_s	%r12,%r12,8                     ; @0x3c4
 ;	 }
	lsr	%r8,%r12,3                      ; @0x3cc
	add2	%r2,%r1,%r11                    ; @0x3d0
	add2	%r12,%r0,%r11                   ; @0x3d4
	add	%lp_count,%r8,1                 ; @0x3d8
	bmskn	%r11,%r3,2                      ; @0x3dc
	lp	.LZD7                           ; @0x3e0
.LBB2_9:                                ; %vec.epilog.vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x3e4
	vvld.ab.w.p1	%vr2,%r12,32            ; @0x3e4
	vvld.ab.w.p1	%vr3,%r2,32             ; @0x3ec
	vvmpy.w	%vr2, %vr3, %vr2                ; @0x3f4
	vvadd.w	%vr1, %vr2, %vr1                ; @0x3fa
.LZD7:                                  ; @0x400
	; ZD Loop End                           ; @0x400
;  %bb.10:                              ; %vec.epilog.middle.block
.vvsbundle  " v2" 
 ;	 { 
	vvpinit.w	%p1, 0, 65520           ; @0x400
	vvci.w	%vr2                            ; @0x400
 ;	 }
	vvpinit.w	%p2, 0, 15              ; @0x40a
.vvsbundle  " v3" 
 ;	 { 
	vvadd.w	%vr2, %vr2, 2                   ; @0x410
	vvpinit.w	%p3, 0, 65532           ; @0x410
	vvadd.w	%vr3, %vr2, 4                   ; @0x410
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvpinit.w	%p4, 0, 3               ; @0x41e
	vvsel.w.p1	%vr3, %vr0, %vr3        ; @0x41e
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvsel.w.p3	%vr0, %vr0, %vr2        ; @0x42a
	vvshfl.w.p2	%vr3, %vr1, %vr3        ; @0x42a
 ;	 }
	vvadd.w	%vr1, %vr1, %vr3                ; @0x434
	vvshfl.w.p4	%vr0, %vr1, %vr0        ; @0x438
	vvadd.w	%vr0, %vr1, %vr0                ; @0x43e
	vvmov1.from.w	%r2,%vr0,1              ; @0x444
	vvadd.w	%vr0, %vr0, %r2                 ; @0x44a
	vvmov1.x.from.w	%r2,%vr0,0              ; @0x44e
	breq	%r11,%r3,.LBB2_13               ; @0x454
.LBB2_11:                               ; %for.body.preheader
                                        ; @0x458
	add	%r12,%r11,1                     ; @0x458
	max	%r3,%r3,%r12                    ; @0x45c
	add2	%r0,%r0,%r11                    ; @0x460
	add2	%r1,%r1,%r11                    ; @0x464
	sub	%lp_count,%r3,%r11              ; @0x468
	; Implicit def %r3                      ; @0x46c
	mov	%r58,%r2                        ; @0x46c
	lp	.LZD6                           ; @0x470
.LBB2_12:                               ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x474
	ld.ab	%r2,[%r0,4]                     ; @0x474
	ld.ab	%r3,[%r1,4]                     ; @0x478
	mac	%r2,%r3,%r2                     ; @0x47c
.LZD6:                                  ; @0x480
	; ZD Loop End                           ; @0x480
.LBB2_13:                               ; %for.cond.cleanup
                                        ; @0x480
	mov_s	%r0,%r2                         ; @0x480
	j_s	[%blink]                        ; @0x482
	.cfa_ef
.Lfunc_end2:                            ; @0x484

	.reloc	_init_ad,0	;startup code to enable %status AD bit ; -- End function
