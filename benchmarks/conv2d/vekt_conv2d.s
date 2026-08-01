	.option	%reg
	.off	assume_short
	.file	"LLVMDialectModule"
	.globl	vekt_conv2d
	.type	vekt_conv2d,@function
	.size	vekt_conv2d, .Lfunc_end0-vekt_conv2d
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
	.ident	"LLVM 17.0.7/V-2024.06. (build 008) (LLVM 17.0.7) -arcv2hs -core4 -Xcode_density -Xatomic -Xll64 -Xunaligned -Xdiv_rem=radix4 -Xswap -Xbitscan -Xmpy_option=mpyd -Xshift_assist -Xbarrel_shifter -Xfpud_div -Xfpu_mac -Xtimer0 -Xrtc -Xstack_check -Xstu=4 -Xvdsp4 -Xvec_unit_rev_minor=1 -Xvec_width=512 -Xvec_mem_size=128k -Xvec_mem_bank_width=16 -Xvec_max_fetch_size=16 -Xvec_num_slots=3 -Xvec_super_with_scalar -Xvec_regs=32 -Xvec_fpu=32 -Xvec_fpu_math=3 -Xvec_fpu_2nd_mul -Xvec_fpu_types=2 -Xvec_num_rd_ports=6 -Xvec_num_acc=8 -Xvec_num_mpy=2 -Xvec_mpy32 -Xvec_num_alu=3 -Xvec_guard_bit_option=0 -Xvec_stack_check -Hvdsp_vector_c -O3 -fno-unroll-loops -fvectorize -fslp-vectorize -ffast-math"
	.align	8                               ; -- Begin function vekt_conv2d
vekt_conv2d:                            ; @vekt_conv2d
                                        ; @0x0
	.cfa_bf	vekt_conv2d
;  %bb.0:
	sub	%sp,%sp,344                     ; @0x0
	.cfa_push	344                     ; @0x4
	st	%r13,[%sp,0]                    ; @0x4
	.cfa_reg_offset	{%r13}, 0               ; @0x8
	std	%r14,[%sp,4]                    ; @0x8
	.cfa_reg_offset	{%r14}, 4               ; @0xc
	.cfa_reg_offset	{%r15}, 8               ; @0xc
	std	%r16,[%sp,12]                   ; @0xc
	.cfa_reg_offset	{%r16}, 12              ; @0x10
	.cfa_reg_offset	{%r17}, 16              ; @0x10
	std	%r18,[%sp,20]                   ; @0x10
	.cfa_reg_offset	{%r18}, 20              ; @0x14
	.cfa_reg_offset	{%r19}, 24              ; @0x14
	std	%r20,[%sp,28]                   ; @0x14
	.cfa_reg_offset	{%r20}, 28              ; @0x18
	.cfa_reg_offset	{%r21}, 32              ; @0x18
	std	%r22,[%sp,36]                   ; @0x18
	.cfa_reg_offset	{%r22}, 36              ; @0x1c
	.cfa_reg_offset	{%r23}, 40              ; @0x1c
	st	%r24,[%sp,44]                   ; @0x1c
	.cfa_reg_offset	{%r24}, 44              ; @0x20
	st	%fp,[%sp,48]                    ; @0x20
	.cfa_reg_offset	{%fp}, 48               ; @0x24
	st	%blink,[%sp,52]                 ; @0x24
	.cfa_reg_offset	{%blink}, 52            ; @0x28
	ld	%r30,[%sp,344]                  ; @0x28
	cmp	%r30,0                          ; @0x2c
	ble	.LBB0_33                        ; @0x30
;  %bb.1:                               ; %.lr.ph23
	ld	%blink,[%sp,348]                ; @0x34
	ldd	%r18,[%sp,404]                  ; @0x38
	mov_s	%r0,%blink                      ; @0x3c
	not	%r1,%blink                      ; @0x3e
	cmp_s	%blink,0                        ; @0x42
	mov.lt	%r0,%r1                         ; @0x44
	asr	%r1,%r0,31                      ; @0x48
	lsr_s	%r1,%r1,28                      ; @0x4c
	add_s	%r0,%r0,%r1                     ; @0x4e
	asr	%r11,%r0,4                      ; @0x50
	not	%r0,%r11                        ; @0x54
	ld	%r24,[%sp,400]                  ; @0x58
	ld	%r20,[%sp,392]                  ; @0x5c
	ld	%r21,[%sp,364]                  ; @0x60
	mov.lt	%r11,%r0                        ; @0x64
	asl	%r16,%r11,4                     ; @0x68
	cmp	%r11,1                          ; @0x6c
	blt	.LBB0_20                        ; @0x70
;  %bb.2:                               ; %.lr.ph23.split.us
	brlt	%r24,1,.LBB0_3                  ; @0x74
;  %bb.4:                               ; %.lr.ph23.split.us.split.us
	brlt	%r18,1,.LBB0_5                  ; @0x78
;  %bb.6:                               ; %.lr.ph.split.us.split.us.us.us.us.preheader
	add	%r15,%blink,0x3fffffff@u32      ; @0x7c
	mov_s	%r8,%r21                        ; @0x84
	mov_s	%r9,0                           ; @0x86
	add_s	%r15,%r15,%r18                  ; @0x88
.LBB0_8:                                ; %.lr.ph.split.us.split.us.us.us.us
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_10 Depth 2
                                        ;       Child Loop BB0_12 Depth 3
                                        ;         Child Loop BB0_13 Depth 4
                                        ; @0x8a
	mpy	%r5,%r9,%blink                  ; @0x8a
	mov_s	%r4,%r8                         ; @0x8e
	mov	%r14,0                          ; @0x90
.LBB0_10:                               ; %.lr.ph16.split.us.us.us.us.us.us
                                        ;   Parent Loop BB0_8 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB0_12 Depth 3
                                        ;         Child Loop BB0_13 Depth 4
                                        ; Label of block must be emitted
                                        ; @0x94 AlignLabel LoopTop Freq=156
	add	%r0,%r14,%r5                    ; @0x94
	add2	%r7,%r6,%r0                     ; @0x98
	mov_s	%r13,%r24                       ; @0x9c
.vvsbundle  "v1sc" 
 ;	 { 
	vvld.w	%vr0,%r7                        ; @0x9e
	mov_s	%r1,%r4                         ; @0x9e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvcadd.init.w	%vr16, %vr0, 0          ; @0xa4
	mov_s	%r12,%r20                       ; @0xa4
 ;	 }
.LBB0_12:                               ; %.lr.ph.us.us.us.us.us.us
                                        ;   Parent Loop BB0_8 Depth=1
                                        ;     Parent Loop BB0_10 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB0_13 Depth 4
                                        ; Label of block must be emitted
                                        ; @0xac AlignLabel LoopTop Freq=5021
	; Implicit def %r22                     ; @0xac
	mov	%lp_count,%r18                  ; @0xac
	mov_s	%r2,%r1                         ; @0xb0
	mov_s	%r0,%r12                        ; @0xb2
	lp	.LZD6                           ; @0xb4
.LBB0_13:                               ;   Parent Loop BB0_8 Depth=1
                                        ;     Parent Loop BB0_10 Depth=2
                                        ;       Parent Loop BB0_12 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
                                        ; Label of block must be emitted
                                        ; @0xb8 AlignLabel LoopTop Freq=160701
.vvsbundle  "v1sc" 
 ;	 { 
	vvld.ab.w	%vr0,%r2,4              ; @0xb8
	ld.ab	%r3,[%r0,4]                     ; @0xb8
 ;	 }
	vvcmac.lo.w	%vr16, %vr0, %r3        ; @0xc2
.LZD6:                                  ; @0xc8
	; ZD Loop End                           ; @0xc8
.LBB0_11:                               ;   in Loop: Header=BB0_12 Depth=3
                                        ; Label of block must be emitted
                                        ; @0xc8 AlignLabel Freq=5021
	add2_s	%r1,%r1,%r15                    ; @0xc8
	add2	%r12,%r12,%r19                  ; @0xca
	dbnz	%r13,.LBB0_12                   ; @0xce
;  %bb.9:                               ;   in Loop: Header=BB0_10 Depth=2
.vvsbundle  "v1sc" 
 ;	 { 
	vvst.w	%vr16,%r7                       ; @0xd2
	add1	%r4,%r4,64/2                    ; @0xd2
 ;	 }
	add_s	%r14,%r14,16                    ; @0xda
	brlt	%r14,%r16,.LBB0_10              ; @0xdc
;  %bb.7:                               ;   in Loop: Header=BB0_8 Depth=1
	add2	%r8,%r8,%r15                    ; @0xe0
	add_s	%r9,%r9,1                       ; @0xe4
	brlt	%r9,%r30,.LBB0_8                ; @0xe6
	b_s	.LBB0_20                        ; @0xea
.LBB0_3:                                ; %.lr.ph.split.us26.preheader
                                        ; @0xec
	max	%r2,%r16,16                     ; @0xec
	add_s	%r2,%r2,-1                      ; @0xf0
	lsr_s	%r2,%r2,4                       ; @0xf2
	mov	%r0,%r30                        ; @0xf4
	mov_s	%r1,%r6                         ; @0xf8
	add_s	%r2,%r2,1                       ; @0xfa
.LBB0_18:                               ; %.lr.ph.split.us26
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_19 Depth 2
                                        ; @0xfc
	; Implicit def %r9                      ; @0xfc
	mov	%lp_count,%r2                   ; @0xfc
	mov	%r3,%r1                         ; @0x100
	lp	.LZD10                          ; @0x104
.LBB0_19:                               ;   Parent Loop BB0_18 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; Label of block must be emitted
                                        ; @0x108 AlignLabel LoopTop Freq=150
	vvld.w	%vr0,%r3                        ; @0x108
	vvcadd.init.w	%vr16, %vr0, 0          ; @0x10c
	vvst.av.w	%vr16,%r3,1             ; @0x112
.LZD10:                                 ; @0x118
	; ZD Loop End                           ; @0x118
;  %bb.17:                              ;   in Loop: Header=BB0_18 Depth=1
	add2	%r1,%r1,%blink                  ; @0x118
	dbnz	%r0,.LBB0_18                    ; @0x11c
	b_s	.LBB0_20                        ; @0x120
.LBB0_5:                                ; %.lr.ph.split.us.split.us31.us.preheader
                                        ; @0x122
	max	%r2,%r16,16                     ; @0x122
	add_s	%r2,%r2,-1                      ; @0x126
	lsr_s	%r2,%r2,4                       ; @0x128
	mov	%r0,%r30                        ; @0x12a
	mov_s	%r1,%r6                         ; @0x12e
	add_s	%r2,%r2,1                       ; @0x130
.LBB0_15:                               ; %.lr.ph.split.us.split.us31.us
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_16 Depth 2
                                        ; @0x132
	; Implicit def %r9                      ; @0x132
	mov	%lp_count,%r2                   ; @0x132
	mov_s	%r3,%r1                         ; @0x136
	lp	.LZD8                           ; @0x138
.LBB0_16:                               ; %.lr.ph16.split.us21.us.us
                                        ;   Parent Loop BB0_15 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; @0x13c
	vvld.w	%vr0,%r3                        ; @0x13c
	vvcadd.init.w	%vr16, %vr0, 0          ; @0x140
	vvst.av.w	%vr16,%r3,1             ; @0x146
.LZD8:                                  ; @0x14c
	; ZD Loop End                           ; @0x14c
;  %bb.14:                              ;   in Loop: Header=BB0_15 Depth=1
	add2	%r1,%r1,%blink                  ; @0x14c
	dbnz	%r0,.LBB0_15                    ; @0x150
.LBB0_20:                               ; %.lr.ph42
                                        ; @0x154
	cmp	%r16,%blink                     ; @0x154
	bge	.LBB0_33                        ; @0x158
;  %bb.21:                              ; %.lr.ph42
	cmp_s	%r24,0                          ; @0x15c
	cmp.gt	%r18,0                          ; @0x15e
	ble	.LBB0_33                        ; Predicate Case 4
                                        ; @0x162
;  %bb.23:                              ; %.lr.ph42.split.us.split.us.split.us
	ld	%r22,[%sp,380]                  ; @0x166
	ld	%r4,[%sp,352]                   ; @0x16a
	asl	%r0,%r11,6                      ; @0x16e
	add	%r5,%r21,%r0                    ; @0x172
	brhs	%r18,8,.LBB0_24                 ; @0x176
;  %bb.25:                              ; %.lr.ph.split.us.split.us.us.us.us55.us.preheader
	mov_s	%r11,0                          ; @0x17a
.LBB0_26:                               ; %.lr.ph.split.us.split.us.us.us.us55.us
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_27 Depth 2
                                        ;       Child Loop BB0_28 Depth 3
                                        ;         Child Loop BB0_29 Depth 4
                                        ; @0x17c
	mpy	%r8,%r11,%r4                    ; @0x17c
	mov_s	%r7,%r5                         ; @0x180
	mov_s	%r2,%r16                        ; @0x182
.LBB0_27:                               ; %.lr.ph33.split.us.us.us.us.us.us.us.us
                                        ;   Parent Loop BB0_26 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB0_28 Depth 3
                                        ;         Child Loop BB0_29 Depth 4
                                        ; Label of block must be emitted
                                        ; @0x184 AlignLabel LoopTop Freq=241
	add	%r0,%r2,%r8                     ; @0x184
	add2	%r9,%r6,%r0                     ; @0x188
	mov_s	%r12,%r24                       ; @0x18c
	ld	%r58,[%r9,0]                    ; @0x18e
	mov_s	%r15,%r7                        ; @0x192
	mov	%r13,%r20                       ; @0x194
.LBB0_28:                               ; %iter.check.us.us.us
                                        ;   Parent Loop BB0_26 Depth=1
                                        ;     Parent Loop BB0_27 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB0_29 Depth 4
                                        ; Label of block must be emitted
                                        ; @0x198 AlignLabel LoopTop Freq=7713
	; Implicit def %r17                     ; @0x198
	mov	%lp_count,%r18                  ; @0x198
	mov_s	%r1,%r15                        ; @0x19c
	mov_s	%r14,%r13                       ; @0x19e
	lp	.LZD0                           ; @0x1a0
.LBB0_29:                               ;   Parent Loop BB0_26 Depth=1
                                        ;     Parent Loop BB0_27 Depth=2
                                        ;       Parent Loop BB0_28 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
                                        ; Label of block must be emitted
                                        ; @0x1a4 AlignLabel LoopTop Freq=246837
	ld.ab	%r0,[%r1,4]                     ; @0x1a4
	ld.ab	%r3,[%r14,4]                    ; @0x1a8
	mac	%r0,%r3,%r0                     ; @0x1ac
.LZD0:                                  ; @0x1b0
	; ZD Loop End                           ; @0x1b0
.LBB0_30:                               ; %.loopexit.us.us.us
                                        ;   in Loop: Header=BB0_28 Depth=3
                                        ; Label of block must be emitted
                                        ; @0x1b0 AlignLabel Freq=7713
	add2	%r15,%r15,%r22                  ; @0x1b0
	add2	%r13,%r13,%r19                  ; @0x1b4
	dbnz	%r12,.LBB0_28                   ; @0x1b8
;  %bb.31:                              ; %.split.us.us.us
                                        ;   in Loop: Header=BB0_27 Depth=2
	add_s	%r2,%r2,1                       ; @0x1bc
	add_s	%r7,%r7,4                       ; @0x1be
	st	%r0,[%r9,0]                     ; @0x1c0
	brlt	%r2,%blink,.LBB0_27             ; @0x1c4
;  %bb.32:                              ; %.split128.us.us
                                        ;   in Loop: Header=BB0_26 Depth=1
	add2	%r5,%r5,%r22                    ; @0x1c8
	add_s	%r11,%r11,1                     ; @0x1cc
	brlt	%r11,%r30,.LBB0_26              ; @0x1ce
	b	.LBB0_33                        ; @0x1d2
.LBB0_24:                               ; %.lr.ph.split.us.split.us.us.us.us55.preheader
                                        ; @0x1d6
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov.w	 %vr1, 0                        ; @0x1d6
	vvci.w	%vr0                            ; @0x1d6
	sub3	%r0,%r18,64/8                   ; @0x1d6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvpinit.w	%p2, 0, 65532           ; @0x1e2
	lsr_s	%r0,%r0,6                       ; @0x1e2
 ;	 }
.vvsbundle  "v3sc" 
 ;	 { 
	vvadd.w	%vr3, %vr0, 4                   ; @0x1ea
	vvadd.w	%vr2, %vr0, 2                   ; @0x1ea
	vvpinit.w	%p3, 0, 65520           ; @0x1ea
	add_s	%r0,%r0,1                       ; @0x1ea
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvsel.w.p2	%vr0, %vr1, %vr2        ; @0x1fa
	vvpinit.w	%p1, 0, 15              ; @0x1fa
	bmskn	%r2,%r18,2                      ; @0x1fa
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvsel.w.p3	%vr1, %vr1, %vr3        ; 4-byte Folded Spill
                                        ; @0x20a
	vvpinit.w	%p2, 0, 3               ; @0x20a
	st	%r0,[%sp,196]                   ; @0x20a
 ;	 }
	sub	%r0,%r18,8                      ; @0x21a
	mov_s	%fp,%r16                        ; @0x21e
	bmskn	%r11,%r18,5                     ; @0x220
	st	%r0,[%sp,200]                   ; 4-byte Folded Spill
                                        ; @0x224
	mov	%r0,0                           ; @0x228
	st	%r2,[%sp,204]                   ; 4-byte Folded Spill
                                        ; @0x22c
	st	%r6,[%sp,168]                   ; 4-byte Folded Spill
                                        ; @0x230
	st	%r30,[%sp,144]                  ; 4-byte Folded Spill
                                        ; @0x234
	st	%blink,[%sp,164]                ; 4-byte Folded Spill
                                        ; @0x238
	st	%r24,[%sp,160]                  ; 4-byte Folded Spill
                                        ; @0x23c
	st	%r20,[%sp,120]                  ; 4-byte Folded Spill
                                        ; @0x240
	st	%r16,[%sp,140]                  ; 4-byte Folded Spill
                                        ; @0x244
	st	%r21,[%sp,116]                  ; 4-byte Folded Spill
                                        ; @0x248
	st	%r22,[%sp,112]                  ; 4-byte Folded Spill
                                        ; @0x24c
	st	%r4,[%sp,136]                   ; 4-byte Folded Spill
                                        ; @0x250
	st	%r19,[%sp,108]                  ; 4-byte Folded Spill
                                        ; @0x254
	st	%r11,[%sp,192]                  ; 4-byte Folded Spill
                                        ; @0x258
.LBB0_35:                               ; %.lr.ph.split.us.split.us.us.us.us55
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_37 Depth 2
                                        ;       Child Loop BB0_39 Depth 3
                                        ;         Child Loop BB0_42 Depth 4
                                        ;         Child Loop BB0_47 Depth 4
                                        ;         Child Loop BB0_50 Depth 4
                                        ; @0x25c
	st	%r0,[%sp,148]                   ; 4-byte Folded Spill
                                        ; @0x25c
	mpy	%r0,%r0,%r4                     ; @0x260
	st	%fp,[%sp,152]                   ; 4-byte Folded Spill
                                        ; @0x264
	st	%r5,[%sp,156]                   ; 4-byte Folded Spill
                                        ; @0x268
	st	%r0,[%sp,172]                   ; 4-byte Folded Spill
                                        ; @0x26c
.LBB0_37:                               ; %.lr.ph33.split.us.us.us.us.us.us
                                        ;   Parent Loop BB0_35 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB0_39 Depth 3
                                        ;         Child Loop BB0_42 Depth 4
                                        ;         Child Loop BB0_47 Depth 4
                                        ;         Child Loop BB0_50 Depth 4
                                        ; Label of block must be emitted
                                        ; @0x270 AlignLabel LoopTop Freq=241
	ld	%r0,[%sp,172]                   ; 4-byte Folded Reload
                                        ; @0x270
	ld	%r1,[%sp,168]                   ; 4-byte Folded Reload
                                        ; @0x274
	add_s	%r0,%r0,%r16                    ; @0x278
	add2	%r0,%r1,%r0                     ; @0x27a
	mov_s	%r13,%r24                       ; @0x27e
	ld_s	%r1,[%r0,0]                     ; @0x280
	mov_s	%blink,%r20                     ; @0x282
	mov	%r30,%r5                        ; @0x284
	mov	%r24,0                          ; @0x288
	st	%fp,[%sp,188]                   ; 4-byte Folded Spill
                                        ; @0x28c
	st	%r5,[%sp,184]                   ; 4-byte Folded Spill
                                        ; @0x290
	st	%r16,[%sp,180]                  ; 4-byte Folded Spill
                                        ; @0x294
	st	%r0,[%sp,176]                   ; 4-byte Folded Spill
                                        ; @0x298
.LBB0_39:                               ; %iter.check
                                        ;   Parent Loop BB0_35 Depth=1
                                        ;     Parent Loop BB0_37 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB0_42 Depth 4
                                        ;         Child Loop BB0_47 Depth 4
                                        ;         Child Loop BB0_50 Depth 4
                                        ; Label of block must be emitted
                                        ; @0x29c AlignLabel LoopTop Freq=7713
	cmp	%r18,64                         ; @0x29c
	mov_s	%r2,0                           ; @0x2a0
	bcs	.LBB0_46                        ; Predicate Case 2
                                        ; @0x2a2
;  %bb.41:                              ; Predicate Case 2
                                        ; %vector.ph
                                        ;   in Loop: Header=BB0_39 Depth=3
.vvsbundle  "v3sc" 
 ;	 { 
	vvmov.w	 %vr18, 0                       ; 4-byte Folded Reload
                                        ; @0x2a6
	vvmov.w	 %vr19, 0                       ; @0x2a6
	vvmov.w	 %vr16, 0                       ; @0x2a6
	ld	%r0,[%sp,196]                   ; @0x2a6
 ;	 }
	; Implicit def %r2                      ; @0x2b6
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr17, 0                       ; @0x2b6
	add2	%r11,%blink,192/4               ; @0x2b6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr16,0,%r1             ; @0x2be
	add2	%r59,%r30,192/4                 ; @0x2be
 ;	 }
	mov	%r58,%r18                       ; @0x2c8
	mov	%lp_count,%r0                   ; @0x2cc
	st	%r13,[%sp,124]                  ; 4-byte Folded Spill
                                        ; @0x2d0
	std	%r30,[%sp,128]                  ; 8-byte Folded Spill
                                        ; @0x2d4
	lp	.LZD2                           ; @0x2d8
.LBB0_42:                               ; %vector.body
                                        ;   Parent Loop BB0_35 Depth=1
                                        ;     Parent Loop BB0_37 Depth=2
                                        ;       Parent Loop BB0_39 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
                                        ; Label of block must be emitted
                                        ; @0x2dc AlignLabel LoopTop Freq=123418
	ldd	%r2,[%r59,0]                    ; @0x2dc
	ldd	%r0,[%r11,0]                    ; @0x2e0
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr8,0,%r2              ; @0x2e4
	ldd	%r4,[%r59,-64]                  ; @0x2e4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr9,0,%r0              ; @0x2ee
	ldd	%r6,[%r11,-64]                  ; @0x2ee
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr6,0,%r4              ; @0x2f8
	ldd	%r8,[%r59,-128]                 ; @0x2f8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr7,0,%r6              ; @0x302
	ldd	%r12,[%r11,-128]                ; @0x302
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr4,0,%r8              ; @0x30c
	ldd	%r14,[%r59,-192]                ; @0x30c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr5,0,%r12             ; @0x316
	ldd	%r16,[%r11,-192]                ; @0x316
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,0,%r14             ; @0x320
	ldd	%r18,[%r59,8]                   ; @0x320
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,0,%r16             ; @0x32a
	ldd	%r20,[%r11,8]                   ; @0x32a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr8,1,%r3              ; @0x334
	ldd	%r22,[%r59,-56]                 ; @0x334
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr9,1,%r1              ; @0x33e
	ldd	%r2,[%r11,-56]                  ; @0x33e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr6,1,%r5              ; @0x348
	ldd	%r0,[%r59,-120]                 ; @0x348
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr7,1,%r7              ; @0x352
	ldd	%r4,[%r11,-120]                 ; @0x352
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr4,1,%r9              ; @0x35c
	ldd	%r6,[%r59,-184]                 ; @0x35c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr5,1,%r13             ; @0x366
	ldd	%r8,[%r11,-184]                 ; @0x366
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,1,%r15             ; @0x370
	ldd	%r12,[%r59,16]                  ; @0x370
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,1,%r17             ; @0x37a
	ldd	%r30,[%r11,16]                  ; @0x37a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr8,2,%r18             ; @0x384
	ldd	%r16,[%r59,-48]                 ; @0x384
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr9,2,%r20             ; @0x38e
	ldd	%r14,[%r11,-48]                 ; @0x38e
 ;	 }
	vvmov1.vi.to.w	%vr6,2,%r22             ; @0x398
	std	%r14,[%sp,96]                   ; 8-byte Folded Spill
                                        ; @0x39e
	ldd	%r14,[%r59,-112]                ; @0x3a2
	vvmov1.vi.to.w	%vr7,2,%r2              ; @0x3a6
	std	%r14,[%sp,88]                   ; 8-byte Folded Spill
                                        ; @0x3ac
	ldd	%r14,[%r11,-112]                ; @0x3b0
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr8,3,%r19             ; @0x3b4
	ldd	%r18,[%r59,-176]                ; @0x3b4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr9,3,%r21             ; @0x3be
	ldd	%r20,[%r11,-176]                ; @0x3be
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr6,3,%r23             ; @0x3c8
	ldd	%r22,[%r59,24]                  ; @0x3c8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr7,3,%r3              ; @0x3d2
	ldd	%r2,[%r11,24]                   ; @0x3d2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr4,2,%r0              ; 8-byte Folded Spill
                                        ; @0x3dc
	std	%r14,[%sp,80]                   ; @0x3dc
 ;	 }
	std	%r2,[%sp,208]                   ; 8-byte Folded Spill
                                        ; @0x3e6
	ldd	%r2,[%r59,-40]                  ; @0x3ea
	vvmov1.vi.to.w	%vr4,3,%r1              ; @0x3ee
	std	%r2,[%sp,56]                    ; 8-byte Folded Spill
                                        ; @0x3f4
	ldd	%r2,[%r11,-40]                  ; @0x3f8
	vvmov1.vi.to.w	%vr5,2,%r4              ; @0x3fc
	std	%r2,[%sp,64]                    ; 8-byte Folded Spill
                                        ; @0x402
	ldd	%r2,[%r59,-104]                 ; @0x406
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr5,3,%r5              ; @0x40a
	ldd	%r0,[%r11,-104]                 ; @0x40a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,2,%r6              ; 8-byte Folded Spill
                                        ; @0x414
	std	%r2,[%sp,72]                    ; @0x414
 ;	 }
	ldd	%r4,[%r59,-168]                 ; @0x41e
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,3,%r7              ; @0x422
	ldd	%r2,[%r11,-168]                 ; @0x422
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,2,%r8              ; 8-byte Folded Reload
                                        ; @0x42c
	ldd	%r6,[%sp,96]                    ; @0x42c
 ;	 }
	std	%r2,[%sp,264]                   ; 8-byte Folded Spill
                                        ; @0x436
	ldd	%r2,[%r59,32]                   ; @0x43a
	vvmov1.vi.to.w	%vr3,3,%r9              ; @0x43e
	std	%r2,[%sp,320]                   ; 8-byte Folded Spill
                                        ; @0x444
	ldd	%r2,[%r11,32]                   ; @0x448
	vvmov1.vi.to.w	%vr8,4,%r12             ; @0x44c
	std	%r2,[%sp,336]                   ; 8-byte Folded Spill
                                        ; @0x452
	ldd	%r2,[%r59,-32]                  ; @0x456
	vvmov1.vi.to.w	%vr8,5,%r13             ; @0x45a
	std	%r2,[%sp,328]                   ; 8-byte Folded Spill
                                        ; @0x460
	ldd	%r2,[%r11,-32]                  ; @0x464
	vvmov1.vi.to.w	%vr9,4,%r30             ; @0x468
	std	%r2,[%sp,312]                   ; 8-byte Folded Spill
                                        ; @0x46e
	ldd	%r2,[%r59,-96]                  ; @0x472
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr9,5,%blink           ; 8-byte Folded Reload
                                        ; @0x476
	ldd	%r30,[%sp,88]                   ; @0x476
 ;	 }
	std	%r2,[%sp,304]                   ; 8-byte Folded Spill
                                        ; @0x480
	ldd	%r2,[%r11,-96]                  ; @0x484
	vvmov1.vi.to.w	%vr6,4,%r16             ; @0x488
	std	%r2,[%sp,288]                   ; 8-byte Folded Spill
                                        ; @0x48e
	ldd	%r2,[%r59,-160]                 ; @0x492
	vvmov1.vi.to.w	%vr6,5,%r17             ; @0x496
	std	%r2,[%sp,280]                   ; 8-byte Folded Spill
                                        ; @0x49c
	ldd	%r2,[%r11,-160]                 ; @0x4a0
	vvmov1.vi.to.w	%vr7,4,%r6              ; @0x4a4
	std	%r2,[%sp,256]                   ; 8-byte Folded Spill
                                        ; @0x4aa
	ldd	%r2,[%r59,40]                   ; @0x4ae
	vvmov1.vi.to.w	%vr7,5,%r7              ; @0x4b2
	std	%r2,[%sp,296]                   ; 8-byte Folded Spill
                                        ; @0x4b8
	ldd	%r2,[%r11,40]                   ; @0x4bc
	vvmov1.vi.to.w	%vr4,4,%r30             ; @0x4c0
	std	%r2,[%sp,96]                    ; 8-byte Folded Spill
                                        ; @0x4c6
	ldd	%r2,[%r59,-24]                  ; @0x4ca
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr4,5,%blink           ; 8-byte Folded Reload
                                        ; @0x4ce
	ldd	%r30,[%sp,80]                   ; @0x4ce
 ;	 }
	std	%r2,[%sp,272]                   ; 8-byte Folded Spill
                                        ; @0x4d8
	ldd	%r2,[%r11,-24]                  ; @0x4dc
	vvmov1.vi.to.w	%vr5,4,%r30             ; @0x4e0
	std	%r2,[%sp,88]                    ; 8-byte Folded Spill
                                        ; @0x4e6
	ldd	%r2,[%r59,-88]                  ; @0x4ea
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr5,5,%blink           ; 8-byte Folded Reload
                                        ; @0x4ee
	ldd	%r30,[%sp,208]                  ; @0x4ee
 ;	 }
	std	%r2,[%sp,248]                   ; 8-byte Folded Spill
                                        ; @0x4f8
	ldd	%r2,[%r11,-88]                  ; @0x4fc
	vvmov1.vi.to.w	%vr2,4,%r18             ; @0x500
	std	%r2,[%sp,240]                   ; 8-byte Folded Spill
                                        ; @0x506
	ldd	%r2,[%r59,-152]                 ; @0x50a
	vvmov1.vi.to.w	%vr2,5,%r19             ; @0x50e
	std	%r2,[%sp,224]                   ; 8-byte Folded Spill
                                        ; @0x514
	ldd	%r2,[%r11,-152]                 ; @0x518
	vvmov1.vi.to.w	%vr3,4,%r20             ; @0x51c
	std	%r2,[%sp,216]                   ; 8-byte Folded Spill
                                        ; @0x522
	ldd	%r2,[%r59,48]                   ; @0x526
	vvmov1.vi.to.w	%vr3,5,%r21             ; @0x52a
	std	%r2,[%sp,80]                    ; 8-byte Folded Spill
                                        ; @0x530
	ldd	%r2,[%r11,48]                   ; @0x534
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr8,6,%r22             ; @0x538
	ldd	%r20,[%r59,-16]                 ; @0x538
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr8,7,%r23             ; @0x542
	ldd	%r22,[%r11,-16]                 ; @0x542
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr9,6,%r30             ; @0x54c
	ldd	%r16,[%r59,-80]                 ; @0x54c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr9,7,%blink           ; 8-byte Folded Reload
                                        ; @0x556
	ldd	%r30,[%sp,56]                   ; @0x556
 ;	 }
	ldd	%r14,[%r11,-80]                 ; @0x560
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr6,6,%r30             ; @0x564
	ldd	%r12,[%r59,-144]                ; @0x564
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr6,7,%blink           ; 8-byte Folded Reload
                                        ; @0x56e
	ldd	%r30,[%sp,64]                   ; @0x56e
 ;	 }
	std	%r2,[%sp,232]                   ; 8-byte Folded Spill
                                        ; @0x578
	ldd	%r8,[%r11,-144]                 ; @0x57c
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr7,6,%r30             ; @0x580
	ldd	%r18,[%r59,56]                  ; @0x580
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr7,7,%blink           ; @0x58a
	ldd	%r2,[%r11,56]                   ; @0x58a
 ;	 }
	ldd	%r30,[%sp,72]                   ; 8-byte Folded Reload
                                        ; @0x594
	std	%r2,[%sp,64]                    ; 8-byte Folded Spill
                                        ; @0x598
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr4,6,%r30             ; @0x59c
	ldd	%r2,[%r59,-8]                   ; @0x59c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr4,7,%blink           ; @0x5a6
	ldd	%r6,[%r11,-8]                   ; @0x5a6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr5,6,%r0              ; 8-byte Folded Spill
                                        ; @0x5b0
	std	%r2,[%sp,56]                    ; @0x5b0
 ;	 }
	ldd	%r2,[%r59,-72]                  ; @0x5ba
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr5,7,%r1              ; 8-byte Folded Reload
                                        ; @0x5be
	ldd	%r30,[%sp,264]                  ; @0x5be
 ;	 }
	std	%r2,[%sp,72]                    ; 8-byte Folded Spill
                                        ; @0x5c8
	ldd	%r0,[%r59,-136]                 ; @0x5cc
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,6,%r4              ; @0x5d0
	mov_s	%r3,%r5                         ; @0x5d0
 ;	 }
	ldd	%r4,[%r11,-72]                  ; @0x5d8
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,7,%r3              ; @0x5dc
	ldd	%r2,[%r11,-136]                 ; @0x5dc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,6,%r30             ; @0x5e6
	add3	%r59,%r59,256/8                 ; @0x5e6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,7,%blink           ; 8-byte Folded Reload
                                        ; @0x5f0
	ldd	%r30,[%sp,320]                  ; @0x5f0
 ;	 }
	add3	%r11,%r11,256/8                 ; @0x5fa
	vvmov1.vi.to.w	%vr8,8,%r30             ; @0x5fe
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr8,9,%blink           ; 8-byte Folded Reload
                                        ; @0x604
	ldd	%r30,[%sp,336]                  ; @0x604
 ;	 }
	vvmov1.vi.to.w	%vr9,8,%r30             ; @0x60e
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr9,9,%blink           ; 8-byte Folded Reload
                                        ; @0x614
	ldd	%r30,[%sp,328]                  ; @0x614
 ;	 }
	vvmov1.vi.to.w	%vr6,8,%r30             ; @0x61e
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr6,9,%blink           ; 8-byte Folded Reload
                                        ; @0x624
	ldd	%r30,[%sp,312]                  ; @0x624
 ;	 }
	vvmov1.vi.to.w	%vr7,8,%r30             ; @0x62e
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr7,9,%blink           ; 8-byte Folded Reload
                                        ; @0x634
	ldd	%r30,[%sp,304]                  ; @0x634
 ;	 }
	vvmov1.vi.to.w	%vr4,8,%r30             ; @0x63e
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr4,9,%blink           ; 8-byte Folded Reload
                                        ; @0x644
	ldd	%r30,[%sp,288]                  ; @0x644
 ;	 }
	vvmov1.vi.to.w	%vr5,8,%r30             ; @0x64e
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr5,9,%blink           ; 8-byte Folded Reload
                                        ; @0x654
	ldd	%r30,[%sp,280]                  ; @0x654
 ;	 }
	vvmov1.vi.to.w	%vr2,8,%r30             ; @0x65e
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,9,%blink           ; 8-byte Folded Reload
                                        ; @0x664
	ldd	%r30,[%sp,256]                  ; @0x664
 ;	 }
	vvmov1.vi.to.w	%vr3,8,%r30             ; @0x66e
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,9,%blink           ; 8-byte Folded Reload
                                        ; @0x674
	ldd	%r30,[%sp,296]                  ; @0x674
 ;	 }
	vvmov1.vi.to.w	%vr8,10,%r30            ; @0x67e
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr8,11,%blink          ; 8-byte Folded Reload
                                        ; @0x684
	ldd	%r30,[%sp,96]                   ; @0x684
 ;	 }
	vvmov1.vi.to.w	%vr9,10,%r30            ; @0x68e
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr9,11,%blink          ; 8-byte Folded Reload
                                        ; @0x694
	ldd	%r30,[%sp,272]                  ; @0x694
 ;	 }
	vvmov1.vi.to.w	%vr6,10,%r30            ; @0x69e
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr6,11,%blink          ; 8-byte Folded Reload
                                        ; @0x6a4
	ldd	%r30,[%sp,88]                   ; @0x6a4
 ;	 }
	vvmov1.vi.to.w	%vr6,12,%r20            ; @0x6ae
	vvmov1.vi.to.w	%vr7,10,%r30            ; @0x6b4
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr7,11,%blink          ; 8-byte Folded Reload
                                        ; @0x6ba
	ldd	%r30,[%sp,248]                  ; @0x6ba
 ;	 }
	vvmov1.vi.to.w	%vr7,12,%r22            ; @0x6c4
	vvmov1.vi.to.w	%vr4,10,%r30            ; @0x6ca
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr4,11,%blink          ; 8-byte Folded Reload
                                        ; @0x6d0
	ldd	%r30,[%sp,240]                  ; @0x6d0
 ;	 }
	vvmov1.vi.to.w	%vr6,13,%r21            ; @0x6da
	vvmov1.vi.to.w	%vr5,10,%r30            ; @0x6e0
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr5,11,%blink          ; 8-byte Folded Reload
                                        ; @0x6e6
	ldd	%r30,[%sp,224]                  ; @0x6e6
 ;	 }
	vvmov1.vi.to.w	%vr5,12,%r14            ; @0x6f0
	vvmov1.vi.to.w	%vr2,10,%r30            ; @0x6f6
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,11,%blink          ; 8-byte Folded Reload
                                        ; @0x6fc
	ldd	%r30,[%sp,216]                  ; @0x6fc
 ;	 }
	vvmov1.vi.to.w	%vr2,12,%r12            ; @0x706
	vvmov1.vi.to.w	%vr3,10,%r30            ; @0x70c
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,11,%blink          ; 8-byte Folded Reload
                                        ; @0x712
	ldd	%r30,[%sp,80]                   ; @0x712
 ;	 }
	vvmov1.vi.to.w	%vr3,12,%r8             ; @0x71c
	vvmov1.vi.to.w	%vr8,12,%r30            ; @0x722
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr8,13,%blink          ; 8-byte Folded Reload
                                        ; @0x728
	ldd	%r30,[%sp,232]                  ; @0x728
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr5,13,%r15            ; 8-byte Folded Reload
                                        ; @0x732
	ldd	%r14,[%sp,56]                   ; @0x732
 ;	 }
	vvmov1.vi.to.w	%vr9,12,%r30            ; @0x73c
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,13,%r13            ; 8-byte Folded Reload
                                        ; @0x742
	ldd	%r12,[%sp,64]                   ; @0x742
 ;	 }
	vvmov1.vi.to.w	%vr9,13,%blink          ; @0x74c
	vvmov1.vi.to.w	%vr4,12,%r16            ; @0x752
	vvmov1.vi.to.w	%vr7,13,%r23            ; @0x758
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,13,%r9             ; 8-byte Folded Reload
                                        ; @0x75e
	ldd	%r8,[%sp,72]                    ; @0x75e
 ;	 }
	vvmov1.vi.to.w	%vr4,13,%r17            ; @0x768
	vvmov1.vi.to.w	%vr8,14,%r18            ; @0x76e
	vvmov1.vi.to.w	%vr9,14,%r12            ; @0x774
	vvmov1.vi.to.w	%vr6,14,%r14            ; @0x77a
	vvmov1.vi.to.w	%vr7,14,%r6             ; @0x780
	vvmov1.vi.to.w	%vr4,14,%r8             ; @0x786
	vvmov1.vi.to.w	%vr5,14,%r4             ; @0x78c
	vvmov1.vi.to.w	%vr2,14,%r0             ; @0x792
	vvmov1.vi.to.w	%vr3,14,%r2             ; @0x798
	vvmov1.vi.to.w	%vr8,15,%r19            ; @0x79e
	vvmov1.vi.to.w	%vr9,15,%r13            ; @0x7a4
.vvsbundle  " v2" 
 ;	 { 
	vvcmac.lo.uu.w	%vr17, %vr9, %vr8       ; @0x7aa
	vvmov1.vi.to.w	%vr6,15,%r15            ; @0x7aa
 ;	 }
	vvmov1.vi.to.w	%vr7,15,%r7             ; @0x7b4
.vvsbundle  " v2" 
 ;	 { 
	vvcmac.lo.uu.w	%vr18, %vr7, %vr6       ; @0x7ba
	vvmov1.vi.to.w	%vr4,15,%r9             ; @0x7ba
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvnop                                   ; @0x7c4
	vvmov1.vi.to.w	%vr5,15,%r5             ; @0x7c4
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvcmac.lo.uu.w	%vr19, %vr5, %vr4       ; @0x7cc
	vvmov1.vi.to.w	%vr2,15,%r1             ; @0x7cc
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvnop                                   ; @0x7d6
	vvmov1.vi.to.w	%vr3,15,%r3             ; @0x7d6
 ;	 }
	vvcmac.lo.uu.w	%vr16, %vr3, %vr2       ; @0x7de
.LZD2:                                  ; @0x7e4
	; ZD Loop End                           ; @0x7e4
.LBB0_43:                               ; %middle.block
                                        ;   in Loop: Header=BB0_39 Depth=3
                                        ; Label of block must be emitted
                                        ; @0x7e4 AlignLabel Freq=3856
.vvsbundle  "v1sc" 
 ;	 { 
	vvadd.w	%vr2, %vr19, %vr16              ; 4-byte Folded Reload
                                        ; @0x7e4
	ld	%r11,[%sp,192]                  ; @0x7e4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvadd.w	%vr2, %vr18, %vr2               ; @0x7ee
	mov	%r18,%r58                       ; @0x7ee
 ;	 }
	vvadd.w	%vr16, %vr17, %vr2              ; @0x7f8
	vvc2add.w	%vr16                   ; @0x7fe
	vvshfleven.w	%vr16, %vr16            ; @0x802
	vvc2add.w	%vr16                   ; @0x806
	vvshfleven.w	%vr16, %vr16            ; @0x80a
	vvc2add.w	%vr16                   ; @0x80e
	vvshfleven.w	%vr16, %vr16            ; @0x812
	vvc2add.w	%vr16                   ; @0x816
	vvmov1.x.from.w	%r1,%vr16,0             ; @0x81a
	brne	%r11,%r58,.LBB0_45              ; @0x820
;  %bb.44:                              ;   in Loop: Header=BB0_39 Depth=3
	ld	%r19,[%sp,108]                  ; 4-byte Folded Reload
                                        ; @0x824
	ld	%r20,[%sp,120]                  ; 4-byte Folded Reload
                                        ; @0x828
	ld	%r21,[%sp,116]                  ; 4-byte Folded Reload
                                        ; @0x82c
	ld	%r22,[%sp,112]                  ; 4-byte Folded Reload
                                        ; @0x830
	ldd	%r30,[%sp,128]                  ; 8-byte Folded Reload
                                        ; @0x834
	ld_s	%r13,[%sp,124]                  ; 4-byte Folded Reload
                                        ; @0x838
	b_s	.LBB0_38                        ; @0x83a
.LBB0_45:                               ; %vec.epilog.iter.check
                                        ;   in Loop: Header=BB0_39 Depth=3
                                        ; Label of block must be emitted
                                        ; @0x83c AlignLabel Freq=1928
	ld	%r19,[%sp,108]                  ; 4-byte Folded Reload
                                        ; @0x83c
	ld	%r20,[%sp,120]                  ; 4-byte Folded Reload
                                        ; @0x840
	ld	%r21,[%sp,116]                  ; 4-byte Folded Reload
                                        ; @0x844
	ld	%r22,[%sp,112]                  ; 4-byte Folded Reload
                                        ; @0x848
	ldd	%r30,[%sp,128]                  ; 8-byte Folded Reload
                                        ; @0x84c
	ld_s	%r13,[%sp,124]                  ; 4-byte Folded Reload
                                        ; @0x850
	mov_s	%r2,%r11                        ; @0x852
	mov_s	%r0,%r11                        ; @0x854
	tst	%r18,56                         ; @0x856
	beq_s	.LBB0_49                        ; @0x85a
.LBB0_46:                               ; %vec.epilog.ph
                                        ;   in Loop: Header=BB0_39 Depth=3
                                        ; Label of block must be emitted
                                        ; @0x85c AlignLabel Freq=5062
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr2, 0                        ; 4-byte Folded Reload
                                        ; @0x85c
	ld	%r0,[%sp,200]                   ; @0x85c
 ;	 }
	sub_s	%r0,%r0,%r2                     ; @0x864
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,0,%r1              ; @0x866
	add	%r3,%r2,%r24                    ; @0x866
 ;	 }
	add_s	%r2,%r2,%fp                     ; @0x870
	lsr_s	%r0,%r0,3                       ; @0x872
	add2	%r1,%r20,%r3                    ; @0x874
	; Implicit def %r3                      ; @0x878
	add2	%r12,%r21,%r2                   ; @0x878
	add	%lp_count,%r0,1                 ; @0x87c
	lp	.LZD3                           ; @0x880
.LBB0_47:                               ; %vec.epilog.vector.body
                                        ;   Parent Loop BB0_35 Depth=1
                                        ;     Parent Loop BB0_37 Depth=2
                                        ;       Parent Loop BB0_39 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
                                        ; Label of block must be emitted
                                        ; @0x884 AlignLabel LoopTop Freq=161986
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov.w	 %vr4, 0                        ; @0x884
	vvmov.w	 %vr3, 0                        ; @0x884
	ldd.ab	%r2,[%r12,32]                   ; @0x884
 ;	 }
	ldd.ab	%r4,[%r1,32]                    ; @0x890
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,0,%r2              ; @0x894
	ldd	%r6,[%r12,-24]                  ; @0x894
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr4,0,%r4              ; @0x89e
	ldd	%r8,[%r1,-24]                   ; @0x89e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,1,%r3              ; @0x8a8
	ldd	%r14,[%r12,-16]                 ; @0x8a8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr4,1,%r5              ; @0x8b2
	ldd	%r4,[%r1,-16]                   ; @0x8b2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,2,%r6              ; @0x8bc
	ldd	%r16,[%r12,-8]                  ; @0x8bc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr4,2,%r8              ; @0x8c6
	ldd	%r2,[%r1,-8]                    ; @0x8c6
 ;	 }
	vvmov1.vi.to.w	%vr3,3,%r7              ; @0x8d0
	vvmov1.vi.to.w	%vr4,3,%r9              ; @0x8d6
	vvmov1.vi.to.w	%vr3,4,%r14             ; @0x8dc
	vvmov1.vi.to.w	%vr4,4,%r4              ; @0x8e2
	vvmov1.vi.to.w	%vr3,5,%r15             ; @0x8e8
	vvmov1.vi.to.w	%vr4,5,%r5              ; @0x8ee
	vvmov1.vi.to.w	%vr3,6,%r16             ; @0x8f4
	vvmov1.vi.to.w	%vr4,6,%r2              ; @0x8fa
	vvmov1.vi.to.w	%vr3,7,%r17             ; @0x900
	vvmov1.vi.to.w	%vr4,7,%r3              ; @0x906
	vvmpy.w	%vr3, %vr4, %vr3                ; @0x90c
	vvadd.w	%vr2, %vr3, %vr2                ; @0x912
.LZD3:                                  ; @0x918
	; ZD Loop End                           ; @0x918
.LBB0_48:                               ; %vec.epilog.middle.block
                                        ;   in Loop: Header=BB0_39 Depth=3
                                        ; Label of block must be emitted
                                        ; @0x918 AlignLabel Freq=5062

	ld	%r1,[%sp,204]                   ; implicit-def: $vr3
                                        ; 4-byte Folded Reload
                                        ; @0x918
	vvshfl.w.p1	%vr3, %vr2, %vr1        ; @0x91c
	mov_s	%r0,%r1                         ; @0x922
	cmp_s	%r1,%r18                        ; @0x924
	vvadd.w	%vr2, %vr2, %vr3                ; @0x926
	vvshfl.w.p2	%vr3, %vr2, %vr0        ; @0x92a
	vvadd.w	%vr2, %vr2, %vr3                ; @0x930
	vvmov1.from.w	%r1,%vr2,1              ; @0x934
	vvadd.w	%vr2, %vr2, %r1                 ; @0x93a
	vvmov1.x.from.w	%r1,%vr2,0              ; @0x93e
	beq	.LBB0_38                        ; @0x944
.LBB0_49:                               ; %vec.epilog.scalar.ph.preheader
                                        ;   in Loop: Header=BB0_39 Depth=3
                                        ; Label of block must be emitted
                                        ; @0x948 AlignLabel Freq=3254
	add	%r2,%r0,1                       ; @0x948
	max	%r2,%r18,%r2                    ; @0x94c
	add	%r3,%r0,%fp                     ; @0x950
	add	%r12,%r0,%r24                   ; @0x954
	sub	%lp_count,%r2,%r0               ; @0x958
	add2	%r0,%r21,%r3                    ; @0x95c
	add2	%r2,%r20,%r12                   ; @0x960
	; Implicit def %r12                     ; @0x964
	mov	%r58,%r1                        ; @0x964
	lp	.LZD4                           ; @0x968
.LBB0_50:                               ; %vec.epilog.scalar.ph
                                        ;   Parent Loop BB0_35 Depth=1
                                        ;     Parent Loop BB0_37 Depth=2
                                        ;       Parent Loop BB0_39 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
                                        ; Label of block must be emitted
                                        ; @0x96c AlignLabel LoopTop Freq=104134
	ld.ab	%r1,[%r0,4]                     ; @0x96c
	ld.ab	%r3,[%r2,4]                     ; @0x970
	mac	%r1,%r3,%r1                     ; @0x974
.LZD4:                                  ; @0x978
	; ZD Loop End                           ; @0x978
.LBB0_38:                               ; %.loopexit
                                        ;   in Loop: Header=BB0_39 Depth=3
                                        ; Label of block must be emitted
                                        ; @0x978 AlignLabel Freq=7713
	add2	%blink,%blink,%r19              ; @0x978
	add2	%r30,%r30,%r22                  ; @0x97c
	add	%r24,%r24,%r19                  ; @0x980
	add	%fp,%fp,%r22                    ; @0x984
	dbnz	%r13,.LBB0_39                   ; @0x988
;  %bb.36:                              ; %.split
                                        ;   in Loop: Header=BB0_37 Depth=2
	ld	%r16,[%sp,180]                  ; 4-byte Folded Reload
                                        ; @0x98c
	ld	%r24,[%sp,160]                  ; 4-byte Folded Reload
                                        ; @0x990
	ld	%blink,[%sp,164]                ; 4-byte Folded Reload
                                        ; @0x994
	ld	%fp,[%sp,188]                   ; 4-byte Folded Reload
                                        ; @0x998
	ld	%r5,[%sp,184]                   ; 4-byte Folded Reload
                                        ; @0x99c
	add_s	%r16,%r16,1                     ; @0x9a0
	ld	%r0,[%sp,176]                   ; 4-byte Folded Reload
                                        ; @0x9a2
	cmp	%r16,%blink                     ; @0x9a6
	add_s	%fp,%fp,1                       ; @0x9aa
	add_s	%r5,%r5,4                       ; @0x9ac
	st_s	%r1,[%r0,0]                     ; @0x9ae
	blt	.LBB0_37                        ; @0x9b0
;  %bb.34:                              ; %.split128
                                        ;   in Loop: Header=BB0_35 Depth=1
	ld	%r0,[%sp,148]                   ; 4-byte Folded Reload
                                        ; @0x9b4
	ld	%r5,[%sp,156]                   ; 4-byte Folded Reload
                                        ; @0x9b8
	ld	%r16,[%sp,140]                  ; 4-byte Folded Reload
                                        ; @0x9bc
	ld	%r4,[%sp,136]                   ; 4-byte Folded Reload
                                        ; @0x9c0
	ld	%r30,[%sp,144]                  ; 4-byte Folded Reload
                                        ; @0x9c4
	ld	%fp,[%sp,152]                   ; 4-byte Folded Reload
                                        ; @0x9c8
	add_s	%r0,%r0,1                       ; @0x9cc
	add2	%r5,%r5,%r22                    ; @0x9ce
	cmp	%r0,%r30                        ; @0x9d2
	add	%fp,%fp,%r22                    ; @0x9d6
	blt	.LBB0_35                        ; @0x9da
.LBB0_33:                               ; %._crit_edge43
                                        ; @0x9de
	ld	%blink,[%sp,52]                 ; @0x9de
	.cfa_restore	{%blink}                ; @0x9e2
	ld	%fp,[%sp,48]                    ; @0x9e2
	.cfa_restore	{%fp}                   ; @0x9e6
	ld	%r24,[%sp,44]                   ; @0x9e6
	.cfa_restore	{%r24}                  ; @0x9ea
	ldd	%r22,[%sp,36]                   ; @0x9ea
	.cfa_restore	{%r23}                  ; @0x9ee
	.cfa_restore	{%r22}                  ; @0x9ee
	ldd	%r20,[%sp,28]                   ; @0x9ee
	.cfa_restore	{%r21}                  ; @0x9f2
	.cfa_restore	{%r20}                  ; @0x9f2
	ldd	%r18,[%sp,20]                   ; @0x9f2
	.cfa_restore	{%r19}                  ; @0x9f6
	.cfa_restore	{%r18}                  ; @0x9f6
	ldd	%r16,[%sp,12]                   ; @0x9f6
	.cfa_restore	{%r17}                  ; @0x9fa
	.cfa_restore	{%r16}                  ; @0x9fa
	ldd	%r14,[%sp,4]                    ; @0x9fa
	.cfa_restore	{%r15}                  ; @0x9fe
	.cfa_restore	{%r14}                  ; @0x9fe
	ld_s	%r13,[%sp,0]                    ; @0x9fe
	.cfa_restore	{%r13}                  ; @0xa00
	add	%sp,%sp,344                     ; @0xa00
	.cfa_pop	344                             ; @0xa04
	j_s	[%blink]                        ; @0xa04
	.cfa_ef
.Lfunc_end0:                            ; @0xa06

	.reloc	_init_ad,0	;startup code to enable %status AD bit ; -- End function
