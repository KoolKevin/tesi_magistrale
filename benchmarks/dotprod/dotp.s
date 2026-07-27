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
	.globl	vekt_dotp_wrapper
	.type	vekt_dotp_wrapper,@function
	.type	.Lvekt_dotp_wrapper$local,@function
	.size	vekt_dotp_wrapper, .Lfunc_end3-vekt_dotp_wrapper
	.size	.Lvekt_dotp_wrapper$local, .Lfunc_end3-vekt_dotp_wrapper
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
	.ident	"LLVM 17.0.7/V-2024.06. (build 008) (LLVM 17.0.7) -arcv2hs -core4 -Xcode_density -Xatomic -Xll64 -Xunaligned -Xdiv_rem=radix4 -Xswap -Xbitscan -Xmpy_option=mpyd -Xshift_assist -Xbarrel_shifter -Xfpud_div -Xfpu_mac -Xtimer0 -Xrtc -Xstack_check -Xstu=4 -Xvdsp4 -Xvec_unit_rev_minor=1 -Xvec_width=512 -Xvec_mem_size=128k -Xvec_mem_bank_width=16 -Xvec_max_fetch_size=16 -Xvec_num_slots=3 -Xvec_super_with_scalar -Xvec_regs=32 -Xvec_fpu=32 -Xvec_fpu_math=3 -Xvec_fpu_2nd_mul -Xvec_fpu_types=2 -Xvec_num_rd_ports=6 -Xvec_num_acc=8 -Xvec_num_mpy=2 -Xvec_mpy32 -Xvec_num_alu=3 -Xvec_guard_bit_option=0 -Xvec_stack_check -Hvdsp_vector_c -O2 -fno-unroll-loops -fvectorize -fslp-vectorize -ffast-math"
	.align	8                               ; -- Begin function dotp
dotp:                                   ; @dotp
                                        ; @0x0
.Ldotp$local:                           ; @0x0
	.cfa_bf	.Ldotp$local
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
	sub.f	%lp_count,%r2,0                 ; @0x0
	mov	%r58,0                          ; @0x4
;  %bb.1:                               ; %for.body.preheader
	; Implicit def %r3                      ; @0x8
	lpgt	.LZD0                           ; @0x8
.LBB0_2:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0xc
	ld.ab	%r2,[%r0,4]                     ; @0xc
	ld.ab	%r3,[%r1,4]                     ; @0x10
	mac	0,%r3,%r2                       ; @0x14
.LZD0:                                  ; @0x18
	; ZD Loop End                           ; @0x18
.LBB0_3:                                ; %for.cond.cleanup
                                        ; @0x18
	mov	%r0,%r58                        ; @0x18
	j_s	[%blink]                        ; @0x1c
	.cfa_ef
.Lfunc_end0:                            ; @0x1e

	.align	4                               ; -- End function
                                        ; -- Begin function vectorized_dotp
vectorized_dotp:                        ; @vectorized_dotp
                                        ; @0x20
.Lvectorized_dotp$local:                ; @0x20
	.cfa_bf	.Lvectorized_dotp$local
;  %bb.0:                               ; %entry
	.cfa_same	%r30                    ; @0x20
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr0, 0                        ; @0x20
	mov_s	%r6,%r0                         ; @0x20
 ;	 }
	asr	%r0,%r2,31                      ; @0x26
.vvsbundle  "v1sc" 
 ;	 { 
	vvcmpy.lo.w	%vr16, %vr0, 0          ; @0x2a
	lsr_s	%r0,%r0,28                      ; @0x2a
 ;	 }
	mov_s	%r3,%r2                         ; @0x32
	cmp_s	%r2,16                          ; @0x34
	add_s	%r2,%r2,%r0                     ; @0x36
	mov_s	%r11,%r1                        ; @0x38
	bmskn	%r12,%r2,3                      ; @0x3a
	blt	.LBB1_3                         ; @0x3e
;  %bb.1:                               ; %for.body.preheader
	; Implicit def %r9                      ; @0x42
	max	%r0,%r12,16                     ; @0x42
	add_s	%r0,%r0,-1                      ; @0x46
	lsr_s	%r0,%r0,4                       ; @0x48
	add	%lp_count,%r0,1                 ; @0x4a
	mov_s	%r0,%r6                         ; @0x4e
	mov_s	%r1,%r11                        ; @0x50
	lp	.LZD4                           ; @0x52
.LBB1_2:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x56
	vvld.av.w	%vr1,%r1,1              ; @0x56
	vvld.av.w	%vr2,%r0,1              ; @0x5c
	vvcmac.lo.w	%vr16, %vr2, %vr1       ; @0x62
.LZD4:                                  ; @0x68
	; ZD Loop End                           ; @0x68
.LBB1_3:                                ; %for.cond.cleanup
                                        ; @0x68
.vvsbundle  "v1sc" 
 ;	 { 
	vvc4add.w	%vr16                   ; @0x68
	cmp_s	%r3,%r12                        ; @0x68
 ;	 }
	vvc4pack.w	%vr16                   ; @0x6e
	vvc4add.w	%vr16                   ; @0x72
	vvc4pack.w	%vr16                   ; @0x76
	vvmov1.x.from.w	%r0,%vr16,0             ; @0x7a
	.cfa_remember_state                     ; @0x80
	jle	[%blink]                        ; @0x80
	.cfa_restore_state                      ; @0x84
;  %bb.4:                               ; %iter.check
	sub_s	%r1,%r3,%r12                    ; @0x84
	cmp_s	%r1,8                           ; @0x86
	bcs	.LBB1_14                        ; @0x88
;  %bb.5:                               ; %vector.main.loop.iter.check
	asr_s	%r2,%r2,4                       ; @0x8c
	asl	%r8,%r2,6                       ; @0x8e
	mov_s	%r9,0                           ; @0x92
	brlo	%r1,16,.LBB1_11                 ; @0x94
;  %bb.6:                               ; %vector.ph

	; Implicit def %r5                      ; implicit-def: $vra17
                                        ; @0x98
.vvsbundle  "v1sc" 
 ;	 { 
	vvpinit.w	%p1, 0, 65534           ; @0x98
	sub	%r0,%r1,16                      ; @0x98
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvpinit.w	%p2, 0, 1               ; @0xa2
	lsr_s	%r0,%r0,4                       ; @0xa2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvshfl.w.p1	%vr17, %vr0, %vr0       ; @0xaa
	bmsk	%r7,%r3,3                       ; @0xaa
 ;	 }
	add	%lp_count,%r0,1                 ; @0xb4
	add	%r0,%r11,%r8                    ; @0xb8
.vvsbundle  "v1sc" 
 ;	 { 
	vvshfl.w.p2	%vr17, %vr16, %vr0      ; @0xbc
	add	%r2,%r6,%r8                     ; @0xbc
 ;	 }
	sub	%r9,%r1,%r7                     ; @0xc6
	lp	.LZD3                           ; @0xca
.LBB1_7:                                ; %vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0xce
	vvld.av.w	%vr0,%r2,1              ; @0xce
	vvld.av.w	%vr1,%r0,1              ; @0xd4
	vvcmac.lo.uu.w	%vr17, %vr1, %vr0       ; @0xda
.LZD3:                                  ; @0xe0
	; ZD Loop End                           ; @0xe0
;  %bb.8:                               ; %middle.block
.vvsbundle  "v1sc" 
 ;	 { 
	vvc2add.w	%vr17                   ; @0xe0
	cmp_s	%r7,0                           ; @0xe0
 ;	 }
	vvshfleven.w	%vr16, %vr17            ; @0xe6
	vvc2add.w	%vr16                   ; @0xea
	vvshfleven.w	%vr16, %vr16            ; @0xee
	vvc2add.w	%vr16                   ; @0xf2
	vvshfleven.w	%vr16, %vr16            ; @0xf6
	vvc2add.w	%vr16                   ; @0xfa
	vvmov1.x.from.w	%r0,%vr16,0             ; @0xfe
	.cfa_remember_state                     ; @0x104
	jeq_s	[%blink]                        ; @0x104
	.cfa_restore_state                      ; @0x106
;  %bb.9:                               ; %vec.epilog.iter.check
	cmp	%r7,8                           ; @0x106
	add.cs	%r12,%r12,%r9                   ; @0x10a
	bcs	.LBB1_14                        ; Predicate Case 2
                                        ; @0x10e
.LBB1_11:                               ; Predicate Case 2
                                        ; %vec.epilog.ph
                                        ; @0x112
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov.w	 %vr1, 0                        ; @0x112
	vvmov.w	 %vr0, 0                        ; @0x112
	bmsk	%r7,%r3,2                       ; @0x112
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvpinit.w	%p1, 0, 255             ; @0x11e
	vvmov1.vi.to.w	%vr0,0,%r0              ; @0x11e
	add2	%r8,%r8,%r9                     ; @0x11e
 ;	 }
	add	%r9,%r9,%r7                     ; @0x12c
	add	%r9,%r9,%r12                    ; @0x130
	sub	%r0,%r3,%r9                     ; @0x134
	sub_s	%r0,%r0,8                       ; @0x138
	lsr_s	%r0,%r0,3                       ; @0x13a
	sub	%r2,%r1,%r7                     ; @0x13c
	add	%lp_count,%r0,1                 ; @0x140
	add	%r0,%r11,%r8                    ; @0x144
	add	%r1,%r6,%r8                     ; @0x148
	; Implicit def %r8                      ; @0x14c
	add_s	%r12,%r12,%r2                   ; @0x14c
	lp	.LZD2                           ; @0x14e
.LBB1_12:                               ; %vec.epilog.vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x152
	vvld.ab.w.p1	%vr2,%r1,32             ; @0x152
	vvld.ab.w.p1	%vr3,%r0,32             ; @0x15a
	vvmpy.w	%vr2, %vr3, %vr2                ; @0x162
	vvadd.w	%vr0, %vr2, %vr0                ; @0x168
.LZD2:                                  ; @0x16e
	; ZD Loop End                           ; @0x16e
;  %bb.13:                              ; %vec.epilog.middle.block
.vvsbundle  "v2sc" 
 ;	 { 
	vvpinit.w	%p1, 0, 65520           ; @0x16e
	vvci.w	%vr2                            ; @0x16e
	cmp_s	%r7,0                           ; @0x16e
 ;	 }
	vvpinit.w	%p2, 0, 15              ; @0x17a
.vvsbundle  " v3" 
 ;	 { 
	vvadd.w	%vr2, %vr2, 2                   ; @0x180
	vvpinit.w	%p3, 0, 65532           ; @0x180
	vvadd.w	%vr3, %vr2, 4                   ; @0x180
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvpinit.w	%p4, 0, 3               ; @0x18e
	vvsel.w.p1	%vr3, %vr1, %vr3        ; @0x18e
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvsel.w.p3	%vr1, %vr1, %vr2        ; @0x19a
	vvshfl.w.p2	%vr3, %vr0, %vr3        ; @0x19a
 ;	 }
	vvadd.w	%vr0, %vr0, %vr3                ; @0x1a4
	vvshfl.w.p4	%vr1, %vr0, %vr1        ; @0x1a8
	vvadd.w	%vr0, %vr0, %vr1                ; @0x1ae
	vvmov1.from.w	%r0,%vr0,1              ; @0x1b2
	vvadd.w	%vr0, %vr0, %r0                 ; @0x1b8
	vvmov1.x.from.w	%r0,%vr0,0              ; @0x1bc
	.cfa_remember_state                     ; @0x1c2
	jeq_s	[%blink]                        ; @0x1c2
	.cfa_restore_state                      ; @0x1c4
.LBB1_14:                               ; %for.body29.preheader
                                        ; @0x1c4
	add_s	%r1,%r12,1                      ; @0x1c4
	max	%r1,%r3,%r1                     ; @0x1c6
	add2	%r6,%r6,%r12                    ; @0x1ca
	add2	%r11,%r11,%r12                  ; @0x1ce
	sub	%lp_count,%r1,%r12              ; @0x1d2
	; Implicit def %r1                      ; @0x1d6
	mov	%r58,%r0                        ; @0x1d6
	lp	.LZD1                           ; @0x1da
.LBB1_15:                               ; %for.body29
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x1de
	ld.ab	%r0,[%r6,4]                     ; @0x1de
	ld.ab	%r1,[%r11,4]                    ; @0x1e2
	mac	%r0,%r1,%r0                     ; @0x1e6
.LZD1:                                  ; @0x1ea
	; ZD Loop End                           ; @0x1ea
;  %bb.16:                              ; %for.cond.cleanup28
	j_s	[%blink]                        ; @0x1ea
	.cfa_ef
.Lfunc_end1:                            ; @0x1ec

	.align	4                               ; -- End function
                                        ; -- Begin function autovectorized_dotp
autovectorized_dotp:                    ; @autovectorized_dotp
                                        ; @0x1ec
.Lautovectorized_dotp$local:            ; @0x1ec
	.cfa_bf	.Lautovectorized_dotp$local
;  %bb.0:                               ; %entry
	.cfa_same	%r30                    ; @0x1ec
	.cfa_same	%r7                     ; @0x1ec
	.cfa_same	%r6                     ; @0x1ec
	.cfa_same	%r5                     ; @0x1ec
	.cfa_same	%r4                     ; @0x1ec
	mov_s	%r3,%r2                         ; @0x1ec
	cmp_s	%r2,0                           ; @0x1ee
	mov_s	%r2,0                           ; @0x1f0
	ble	.LBB2_13                        ; @0x1f2
;  %bb.1:                               ; %iter.check
	cmp_s	%r3,8                           ; @0x1f6
	mov_s	%r11,0                          ; @0x1f8
	bcs	.LBB2_11                        ; Predicate Case 2
                                        ; @0x1fa
;  %bb.3:                               ; Predicate Case 2
                                        ; %vector.main.loop.iter.check
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr0, 0                        ; @0x1fe
	mov_s	%r11,0                          ; @0x1fe
 ;	 }
	brlo	%r3,16,.LBB2_8                  ; @0x204
;  %bb.4:                               ; %vector.ph
	; Implicit def %r9                      ; @0x208
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr16, 0                       ; @0x208
	sub	%r2,%r3,16                      ; @0x208
 ;	 }
	lsr_s	%r2,%r2,4                       ; @0x210
	bmskn	%r11,%r3,3                      ; @0x212
	add	%lp_count,%r2,1                 ; @0x216
	mov_s	%r2,%r1                         ; @0x21a
	mov_s	%r12,%r0                        ; @0x21c
	lp	.LZD7                           ; @0x21e
.LBB2_5:                                ; %vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x222
	vvld.av.w	%vr1,%r12,1             ; @0x222
	vvld.av.w	%vr2,%r2,1              ; @0x228
	vvcmac.lo.uu.w	%vr16, %vr2, %vr1       ; @0x22e
.LZD7:                                  ; @0x234
	; ZD Loop End                           ; @0x234
;  %bb.6:                               ; %middle.block
.vvsbundle  "v1sc" 
 ;	 { 
	vvc2add.w	%vr16                   ; @0x234
	cmp	%r11,%r3                        ; @0x234
 ;	 }
	vvshfleven.w	%vr16, %vr16            ; @0x23c
	vvc2add.w	%vr16                   ; @0x240
	vvshfleven.w	%vr16, %vr16            ; @0x244
	vvc2add.w	%vr16                   ; @0x248
	vvshfleven.w	%vr16, %vr16            ; @0x24c
	vvc2add.w	%vr16                   ; @0x250
	vvmov1.x.from.w	%r2,%vr16,0             ; @0x254
	beq_s	.LBB2_13                        ; @0x25a
;  %bb.7:                               ; %vec.epilog.iter.check
	bbit0	%r3,3,.LBB2_11                  ; @0x25c
.LBB2_8:                                ; %vec.epilog.ph
                                        ; @0x260
	; Implicit def %r9                      ; @0x260
.vvsbundle  "v2sc" 
 ;	 { 
	vvpinit.w	%p1, 0, 255             ; @0x260
	vvmov.w	 %vr1, 0                        ; @0x260
	sub	%r12,%r3,%r11                   ; @0x260
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,0,%r2              ; @0x26e
	sub_s	%r12,%r12,8                     ; @0x26e
 ;	 }
	lsr	%r8,%r12,3                      ; @0x276
	add2	%r2,%r1,%r11                    ; @0x27a
	add2	%r12,%r0,%r11                   ; @0x27e
	add	%lp_count,%r8,1                 ; @0x282
	bmskn	%r11,%r3,2                      ; @0x286
	lp	.LZD6                           ; @0x28a
.LBB2_9:                                ; %vec.epilog.vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x28e
	vvld.ab.w.p1	%vr2,%r12,32            ; @0x28e
	vvld.ab.w.p1	%vr3,%r2,32             ; @0x296
	vvmpy.w	%vr2, %vr3, %vr2                ; @0x29e
	vvadd.w	%vr1, %vr2, %vr1                ; @0x2a4
.LZD6:                                  ; @0x2aa
	; ZD Loop End                           ; @0x2aa
;  %bb.10:                              ; %vec.epilog.middle.block
.vvsbundle  " v2" 
 ;	 { 
	vvpinit.w	%p1, 0, 65520           ; @0x2aa
	vvci.w	%vr2                            ; @0x2aa
 ;	 }
	vvpinit.w	%p2, 0, 15              ; @0x2b4
.vvsbundle  " v3" 
 ;	 { 
	vvadd.w	%vr2, %vr2, 2                   ; @0x2ba
	vvpinit.w	%p3, 0, 65532           ; @0x2ba
	vvadd.w	%vr3, %vr2, 4                   ; @0x2ba
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvpinit.w	%p4, 0, 3               ; @0x2c8
	vvsel.w.p1	%vr3, %vr0, %vr3        ; @0x2c8
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvsel.w.p3	%vr0, %vr0, %vr2        ; @0x2d4
	vvshfl.w.p2	%vr3, %vr1, %vr3        ; @0x2d4
 ;	 }
	vvadd.w	%vr1, %vr1, %vr3                ; @0x2de
	vvshfl.w.p4	%vr0, %vr1, %vr0        ; @0x2e2
	vvadd.w	%vr0, %vr1, %vr0                ; @0x2e8
	vvmov1.from.w	%r2,%vr0,1              ; @0x2ee
	vvadd.w	%vr0, %vr0, %r2                 ; @0x2f4
	vvmov1.x.from.w	%r2,%vr0,0              ; @0x2f8
	breq	%r11,%r3,.LBB2_13               ; @0x2fe
.LBB2_11:                               ; %for.body.preheader
                                        ; @0x302
	add	%r12,%r11,1                     ; @0x302
	max	%r3,%r3,%r12                    ; @0x306
	add2	%r0,%r0,%r11                    ; @0x30a
	add2	%r1,%r1,%r11                    ; @0x30e
	sub	%lp_count,%r3,%r11              ; @0x312
	; Implicit def %r3                      ; @0x316
	mov	%r58,%r2                        ; @0x316
	lp	.LZD5                           ; @0x31a
.LBB2_12:                               ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x31e
	ld.ab	%r2,[%r0,4]                     ; @0x31e
	ld.ab	%r3,[%r1,4]                     ; @0x322
	mac	%r2,%r3,%r2                     ; @0x326
.LZD5:                                  ; @0x32a
	; ZD Loop End                           ; @0x32a
.LBB2_13:                               ; %for.cond.cleanup
                                        ; @0x32a
	mov_s	%r0,%r2                         ; @0x32a
	j_s	[%blink]                        ; @0x32c
	.cfa_ef
.Lfunc_end2:                            ; @0x32e

	.align	4                               ; -- End function
                                        ; -- Begin function vekt_dotp_wrapper
vekt_dotp_wrapper:                      ; @vekt_dotp_wrapper
                                        ; @0x330
.Lvekt_dotp_wrapper$local:              ; @0x330
	.cfa_bf	.Lvekt_dotp_wrapper$local
;  %bb.0:                               ; %entry
	push_s	%blink                          ; @0x330
	.cfa_push	{%blink}                ; @0x332
	sub_s	%sp,%sp,12                      ; @0x332
	.cfa_push	12                      ; @0x334
	mov_s	%r5,%r1                         ; @0x334
	mov_s	%r4,1                           ; @0x336
	mov_s	%r8,%r2                         ; @0x338
	mov_s	%r1,%r0                         ; @0x33a
	mov_s	%r3,%r2                         ; @0x33c
	mov_s	%r6,%r5                         ; @0x33e
	mov_s	%r9,%r4                         ; @0x340
	mov_s	%r2,0                           ; @0x342
	mov_s	%r7,0                           ; @0x344
	st	%r8,[%sp,8]                     ; @0x346
	std	%r8,[%sp,0]                     ; @0x34a
	bl	vekt_dotp                       ; @0x34e
	ld.aw	%blink,[%sp,12]                 ; @0x352
	.cfa_pop	12                              ; @0x356
	.cfa_restore	{%blink}                ; @0x356
	add_s	%sp,%sp,4                       ; @0x356
	.cfa_pop	4                               ; @0x358
	j_s	[%blink]                        ; @0x358
	.cfa_ef
.Lfunc_end3:                            ; @0x35a

	.reloc	_init_ad,0	;startup code to enable %status AD bit ; -- End function
