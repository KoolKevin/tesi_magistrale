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
	st.aw	%r13,[%sp,-248]                 ; @0x0
	.cfa_push	248                     ; @0x4
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
	st	%r24,[%sp,44]                   ; @0x18
	.cfa_reg_offset	{%r24}, 44              ; @0x1c
	st	%fp,[%sp,48]                    ; @0x1c
	.cfa_reg_offset	{%fp}, 48               ; @0x20
	st	%blink,[%sp,52]                 ; @0x20
	.cfa_reg_offset	{%blink}, 52            ; @0x24
	mov_s	%r13,%r2                        ; @0x24
	cmp_s	%r2,0                           ; @0x26
	mov_s	%r2,0                           ; @0x28
	ble	.LBB0_13                        ; @0x2a
;  %bb.1:                               ; %iter.check
	mov	%r58,%r1                        ; @0x2e
	mov_s	%fp,%r0                         ; @0x32
	cmp_s	%r13,8                          ; @0x34
	mov_s	%r11,0                          ; @0x36
	bcs	.LBB0_11                        ; Predicate Case 2
                                        ; @0x38
;  %bb.3:                               ; Predicate Case 2
                                        ; %vector.main.loop.iter.check
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr0, 0                        ; @0x3c
	cmp_s	%r13,64                         ; @0x3c
 ;	 }
	mov_s	%r11,0                          ; @0x42
	bcs	.LBB0_8                         ; @0x44
;  %bb.4:                               ; %vector.ph
.vvsbundle  "v3sc" 
 ;	 { 
	vvmov.w	 %vr16, 0                       ; @0x48
	vvmov.w	 %vr18, 0                       ; @0x48
	vvmov.w	 %vr17, 0                       ; @0x48
	sub3	%r0,%r13,64/8                   ; @0x48
 ;	 }
	; Implicit def %r1                      ; @0x58
	lsr_s	%r0,%r0,6                       ; @0x58
	add2	%r24,%r58,192/4                 ; @0x5a
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr19, 0                       ; @0x5e
	add2	%r12,%fp,192/4                  ; @0x5e
 ;	 }
	bmskn	%r11,%r13,5                     ; @0x66
	add	%lp_count,%r0,1                 ; @0x6a
	lp	.LZD2                           ; @0x6e
.LBB0_5:                                ; %vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x72
	ldd	%r0,[%r12,0]                    ; @0x72
	ldd	%r4,[%r24,0]                    ; @0x76
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr7,0,%r0              ; @0x7a
	ldd	%r6,[%r12,-64]                  ; @0x7a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr8,0,%r4              ; @0x84
	ldd	%r8,[%r24,-64]                  ; @0x84
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr5,0,%r6              ; @0x8e
	ldd	%r30,[%r12,-128]                ; @0x8e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr6,0,%r8              ; @0x98
	ldd	%r14,[%r24,-128]                ; @0x98
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,0,%r30             ; @0xa2
	ldd	%r16,[%r12,-192]                ; @0xa2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr4,0,%r14             ; @0xac
	ldd	%r18,[%r24,-192]                ; @0xac
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,0,%r16             ; @0xb6
	ldd	%r2,[%r12,8]                    ; @0xb6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,0,%r18             ; @0xc0
	ldd	%r22,[%r24,8]                   ; @0xc0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr7,1,%r1              ; @0xca
	ldd	%r20,[%r12,-56]                 ; @0xca
 ;	 }
	vvmov1.vi.to.w	%vr8,1,%r5              ; @0xd4
	std	%r20,[%sp,120]                  ; 8-byte Folded Spill
                                        ; @0xda
	ldd	%r20,[%r24,-56]                 ; @0xde
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr5,1,%r7              ; @0xe2
	ldd	%r4,[%r12,-120]                 ; @0xe2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr6,1,%r9              ; @0xec
	ldd	%r6,[%r24,-120]                 ; @0xec
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,1,%blink           ; @0xf6
	ldd	%r8,[%r12,-184]                 ; @0xf6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr4,1,%r15             ; @0x100
	ldd	%r0,[%r24,-184]                 ; @0x100
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,1,%r17             ; @0x10a
	ldd	%r14,[%r12,16]                  ; @0x10a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,1,%r19             ; @0x114
	ldd	%r18,[%r24,16]                  ; @0x114
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr7,2,%r2              ; @0x11e
	mov_s	%blink,%r3                      ; @0x11e
 ;	 }
	ldd	%r16,[%r12,-48]                 ; @0x126
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr8,2,%r22             ; @0x12a
	ldd	%r2,[%r24,-48]                  ; @0x12a
 ;	 }
	std	%r0,[%sp,128]                   ; 8-byte Folded Spill
                                        ; @0x134
	std	%r2,[%sp,112]                   ; 8-byte Folded Spill
                                        ; @0x138
	ldd	%r0,[%sp,120]                   ; 8-byte Folded Reload
                                        ; @0x13c
	ldd	%r2,[%r12,-112]                 ; @0x140
	vvmov1.vi.to.w	%vr5,2,%r0              ; @0x144
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr6,2,%r20             ; 8-byte Folded Spill
                                        ; @0x14a
	std	%r2,[%sp,104]                   ; @0x14a
 ;	 }
	ldd	%r2,[%r24,-112]                 ; @0x154
	vvmov1.vi.to.w	%vr7,3,%blink           ; @0x158
	std	%r2,[%sp,96]                    ; 8-byte Folded Spill
                                        ; @0x15e
	ldd	%r2,[%r12,-176]                 ; @0x162
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr8,3,%r23             ; @0x166
	ldd	%r22,[%r24,-176]                ; @0x166
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr5,3,%r1              ; 8-byte Folded Spill
                                        ; @0x170
	std	%r2,[%sp,80]                    ; @0x170
 ;	 }
	ldd	%r2,[%r12,24]                   ; @0x17a
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr6,3,%r21             ; 8-byte Folded Reload
                                        ; @0x17e
	ldd	%r20,[%sp,80]                   ; @0x17e
 ;	 }
	std	%r2,[%sp,64]                    ; 8-byte Folded Spill
                                        ; @0x188
	ldd	%r2,[%r24,24]                   ; @0x18c
	vvmov1.vi.to.w	%vr3,2,%r4              ; @0x190
	std	%r2,[%sp,136]                   ; 8-byte Folded Spill
                                        ; @0x196
	ldd	%r2,[%r12,-40]                  ; @0x19a
	vvmov1.vi.to.w	%vr3,3,%r5              ; @0x19e
	std	%r2,[%sp,56]                    ; 8-byte Folded Spill
                                        ; @0x1a4
	ldd	%r2,[%r24,-40]                  ; @0x1a8
	vvmov1.vi.to.w	%vr4,2,%r6              ; @0x1ac
	std	%r2,[%sp,72]                    ; 8-byte Folded Spill
                                        ; @0x1b2
	ldd	%r2,[%r12,-104]                 ; @0x1b6
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr4,3,%r7              ; @0x1ba
	ldd	%r4,[%r24,-104]                 ; @0x1ba
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,2,%r8              ; 8-byte Folded Spill
                                        ; @0x1c4
	std	%r2,[%sp,88]                    ; @0x1c4
 ;	 }
	ldd	%r0,[%r12,-168]                 ; @0x1ce
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,3,%r9              ; @0x1d2
	ldd	%r2,[%r24,-168]                 ; @0x1d2
 ;	 }
	ldd	%r6,[%sp,128]                   ; 8-byte Folded Reload
                                        ; @0x1dc
	std	%r2,[%sp,224]                   ; 8-byte Folded Spill
                                        ; @0x1e0
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,2,%r6              ; @0x1e4
	ldd	%r2,[%r12,32]                   ; @0x1e4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,3,%r7              ; 8-byte Folded Reload
                                        ; @0x1ee
	ldd	%r6,[%sp,112]                   ; @0x1ee
 ;	 }
	std	%r2,[%sp,120]                   ; 8-byte Folded Spill
                                        ; @0x1f8
	ldd	%r2,[%r24,32]                   ; @0x1fc
	vvmov1.vi.to.w	%vr7,4,%r14             ; @0x200
	std	%r2,[%sp,128]                   ; 8-byte Folded Spill
                                        ; @0x206
	ldd	%r2,[%r12,-32]                  ; @0x20a
	vvmov1.vi.to.w	%vr7,5,%r15             ; @0x20e
	std	%r2,[%sp,240]                   ; 8-byte Folded Spill
                                        ; @0x214
	ldd	%r2,[%r24,-32]                  ; @0x218
	vvmov1.vi.to.w	%vr8,4,%r18             ; @0x21c
	std	%r2,[%sp,232]                   ; 8-byte Folded Spill
                                        ; @0x222
	ldd	%r2,[%r12,-96]                  ; @0x226
	vvmov1.vi.to.w	%vr8,5,%r19             ; @0x22a
	std	%r2,[%sp,216]                   ; 8-byte Folded Spill
                                        ; @0x230
	ldd	%r2,[%r24,-96]                  ; @0x234
	vvmov1.vi.to.w	%vr5,4,%r16             ; @0x238
	std	%r2,[%sp,200]                   ; 8-byte Folded Spill
                                        ; @0x23e
	ldd	%r2,[%r12,-160]                 ; @0x242
	vvmov1.vi.to.w	%vr5,5,%r17             ; @0x246
	std	%r2,[%sp,192]                   ; 8-byte Folded Spill
                                        ; @0x24c
	ldd	%r2,[%r24,-160]                 ; @0x250
	vvmov1.vi.to.w	%vr6,4,%r6              ; @0x254
	std	%r2,[%sp,176]                   ; 8-byte Folded Spill
                                        ; @0x25a
	ldd	%r2,[%r12,40]                   ; @0x25e
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr6,5,%r7              ; 8-byte Folded Reload
                                        ; @0x262
	ldd	%r6,[%sp,104]                   ; @0x262
 ;	 }
	std	%r2,[%sp,208]                   ; 8-byte Folded Spill
                                        ; @0x26c
	ldd	%r2,[%r24,40]                   ; @0x270
	vvmov1.vi.to.w	%vr3,4,%r6              ; @0x274
	std	%r2,[%sp,112]                   ; 8-byte Folded Spill
                                        ; @0x27a
	ldd	%r2,[%r12,-24]                  ; @0x27e
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,5,%r7              ; 8-byte Folded Reload
                                        ; @0x282
	ldd	%r6,[%sp,96]                    ; @0x282
 ;	 }
	std	%r2,[%sp,184]                   ; 8-byte Folded Spill
                                        ; @0x28c
	ldd	%r2,[%r24,-24]                  ; @0x290
	vvmov1.vi.to.w	%vr4,4,%r6              ; @0x294
	std	%r2,[%sp,104]                   ; 8-byte Folded Spill
                                        ; @0x29a
	ldd	%r2,[%r12,-88]                  ; @0x29e
	vvmov1.vi.to.w	%vr4,5,%r7              ; @0x2a2
	std	%r2,[%sp,168]                   ; 8-byte Folded Spill
                                        ; @0x2a8
	ldd	%r2,[%r24,-88]                  ; @0x2ac
	vvmov1.vi.to.w	%vr1,4,%r20             ; @0x2b0
	std	%r2,[%sp,160]                   ; 8-byte Folded Spill
                                        ; @0x2b6
	ldd	%r2,[%r12,-152]                 ; @0x2ba
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,5,%r21             ; 8-byte Folded Reload
                                        ; @0x2be
	ldd	%r20,[%sp,136]                  ; @0x2be
 ;	 }
	std	%r2,[%sp,152]                   ; 8-byte Folded Spill
                                        ; @0x2c8
	ldd	%r2,[%r24,-152]                 ; @0x2cc
	vvmov1.vi.to.w	%vr2,4,%r22             ; @0x2d0
	std	%r2,[%sp,144]                   ; 8-byte Folded Spill
                                        ; @0x2d6
	ldd	%r2,[%r12,48]                   ; @0x2da
	vvmov1.vi.to.w	%vr2,5,%r23             ; @0x2de
	std	%r2,[%sp,96]                    ; 8-byte Folded Spill
                                        ; @0x2e4
	ldd	%r2,[%r24,48]                   ; @0x2e8
	ldd	%r22,[%r12,-16]                 ; @0x2ec
	std	%r2,[%sp,80]                    ; 8-byte Folded Spill
                                        ; @0x2f0
	ldd	%r2,[%sp,64]                    ; 8-byte Folded Reload
                                        ; @0x2f4
	vvmov1.vi.to.w	%vr7,6,%r2              ; @0x2f8
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr7,7,%r3              ; @0x2fe
	ldd	%r2,[%r24,-16]                  ; @0x2fe
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr8,6,%r20             ; @0x308
	ldd	%r18,[%r12,-80]                 ; @0x308
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr8,7,%r21             ; 8-byte Folded Reload
                                        ; @0x312
	ldd	%r20,[%sp,56]                   ; @0x312
 ;	 }
	std	%r2,[%sp,64]                    ; 8-byte Folded Spill
                                        ; @0x31c
	ldd	%r2,[%sp,72]                    ; 8-byte Folded Reload
                                        ; @0x320
	ldd	%r16,[%r24,-80]                 ; @0x324
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr5,6,%r20             ; @0x328
	ldd	%r14,[%r12,-144]                ; @0x328
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr5,7,%r21             ; @0x332
	ldd	%r30,[%r24,-144]                ; @0x332
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr6,6,%r2              ; @0x33c
	ldd	%r20,[%r12,56]                  ; @0x33c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr6,7,%r3              ; @0x346
	ldd	%r2,[%r24,56]                   ; @0x346
 ;	 }
	ldd	%r6,[%r12,-8]                   ; @0x350
	std	%r2,[%sp,72]                    ; 8-byte Folded Spill
                                        ; @0x354
	ldd	%r2,[%sp,88]                    ; 8-byte Folded Reload
                                        ; @0x358
	std	%r6,[%sp,56]                    ; 8-byte Folded Spill
                                        ; @0x35c
	vvmov1.vi.to.w	%vr3,6,%r2              ; @0x360
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,7,%r3              ; @0x366
	ldd	%r8,[%r24,-8]                   ; @0x366
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr4,6,%r4              ; @0x370
	ldd	%r2,[%r12,-72]                  ; @0x370
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr4,7,%r5              ; @0x37a
	ldd	%r4,[%r12,-136]                 ; @0x37a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,6,%r0              ; 8-byte Folded Spill
                                        ; @0x384
	std	%r2,[%sp,88]                    ; @0x384
 ;	 }
	ldd	%r2,[%sp,224]                   ; 8-byte Folded Reload
                                        ; @0x38e
	ldd	%r6,[%r24,-72]                  ; @0x392
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,7,%r1              ; @0x396
	ldd	%r0,[%r24,-136]                 ; @0x396
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,6,%r2              ; @0x3a0
	add3	%r12,%r12,256/8                 ; @0x3a0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,7,%r3              ; 8-byte Folded Reload
                                        ; @0x3aa
	ldd	%r2,[%sp,120]                   ; @0x3aa
 ;	 }
	add3	%r24,%r24,256/8                 ; @0x3b4
	vvmov1.vi.to.w	%vr7,8,%r2              ; @0x3b8
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr7,9,%r3              ; 8-byte Folded Reload
                                        ; @0x3be
	ldd	%r2,[%sp,128]                   ; @0x3be
 ;	 }
	vvmov1.vi.to.w	%vr8,8,%r2              ; @0x3c8
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr8,9,%r3              ; 8-byte Folded Reload
                                        ; @0x3ce
	ldd	%r2,[%sp,240]                   ; @0x3ce
 ;	 }
	vvmov1.vi.to.w	%vr5,8,%r2              ; @0x3d8
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr5,9,%r3              ; 8-byte Folded Reload
                                        ; @0x3de
	ldd	%r2,[%sp,232]                   ; @0x3de
 ;	 }
	vvmov1.vi.to.w	%vr6,8,%r2              ; @0x3e8
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr6,9,%r3              ; 8-byte Folded Reload
                                        ; @0x3ee
	ldd	%r2,[%sp,216]                   ; @0x3ee
 ;	 }
	vvmov1.vi.to.w	%vr3,8,%r2              ; @0x3f8
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,9,%r3              ; 8-byte Folded Reload
                                        ; @0x3fe
	ldd	%r2,[%sp,200]                   ; @0x3fe
 ;	 }
	vvmov1.vi.to.w	%vr4,8,%r2              ; @0x408
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr4,9,%r3              ; 8-byte Folded Reload
                                        ; @0x40e
	ldd	%r2,[%sp,192]                   ; @0x40e
 ;	 }
	vvmov1.vi.to.w	%vr1,8,%r2              ; @0x418
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,9,%r3              ; 8-byte Folded Reload
                                        ; @0x41e
	ldd	%r2,[%sp,176]                   ; @0x41e
 ;	 }
	vvmov1.vi.to.w	%vr2,8,%r2              ; @0x428
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,9,%r3              ; 8-byte Folded Reload
                                        ; @0x42e
	ldd	%r2,[%sp,208]                   ; @0x42e
 ;	 }
	vvmov1.vi.to.w	%vr7,10,%r2             ; @0x438
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr7,11,%r3             ; 8-byte Folded Reload
                                        ; @0x43e
	ldd	%r2,[%sp,112]                   ; @0x43e
 ;	 }
	vvmov1.vi.to.w	%vr8,10,%r2             ; @0x448
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr8,11,%r3             ; 8-byte Folded Reload
                                        ; @0x44e
	ldd	%r2,[%sp,184]                   ; @0x44e
 ;	 }
	vvmov1.vi.to.w	%vr5,10,%r2             ; @0x458
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr5,11,%r3             ; 8-byte Folded Reload
                                        ; @0x45e
	ldd	%r2,[%sp,104]                   ; @0x45e
 ;	 }
	vvmov1.vi.to.w	%vr5,12,%r22            ; @0x468
	vvmov1.vi.to.w	%vr6,10,%r2             ; @0x46e
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr6,11,%r3             ; 8-byte Folded Reload
                                        ; @0x474
	ldd	%r2,[%sp,168]                   ; @0x474
 ;	 }
	vvmov1.vi.to.w	%vr5,13,%r23            ; @0x47e
	vvmov1.vi.to.w	%vr3,10,%r2             ; @0x484
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,11,%r3             ; 8-byte Folded Reload
                                        ; @0x48a
	ldd	%r2,[%sp,160]                   ; @0x48a
 ;	 }
	vvmov1.vi.to.w	%vr3,12,%r18            ; @0x494
	vvmov1.vi.to.w	%vr4,10,%r2             ; @0x49a
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr4,11,%r3             ; 8-byte Folded Reload
                                        ; @0x4a0
	ldd	%r2,[%sp,152]                   ; @0x4a0
 ;	 }
	vvmov1.vi.to.w	%vr4,12,%r16            ; @0x4aa
	vvmov1.vi.to.w	%vr1,10,%r2             ; @0x4b0
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,11,%r3             ; 8-byte Folded Reload
                                        ; @0x4b6
	ldd	%r2,[%sp,144]                   ; @0x4b6
 ;	 }
	vvmov1.vi.to.w	%vr1,12,%r14            ; @0x4c0
	vvmov1.vi.to.w	%vr2,10,%r2             ; @0x4c6
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,11,%r3             ; 8-byte Folded Reload
                                        ; @0x4cc
	ldd	%r2,[%sp,96]                    ; @0x4cc
 ;	 }
	vvmov1.vi.to.w	%vr2,12,%r30            ; @0x4d6
	vvmov1.vi.to.w	%vr7,12,%r2             ; @0x4dc
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr7,13,%r3             ; 8-byte Folded Reload
                                        ; @0x4e2
	ldd	%r2,[%sp,80]                    ; @0x4e2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr4,13,%r17            ; 8-byte Folded Reload
                                        ; @0x4ec
	ldd	%r16,[%sp,56]                   ; @0x4ec
 ;	 }
	vvmov1.vi.to.w	%vr8,12,%r2             ; @0x4f6
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr8,13,%r3             ; 8-byte Folded Reload
                                        ; @0x4fc
	ldd	%r2,[%sp,64]                    ; @0x4fc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,13,%r15            ; 8-byte Folded Reload
                                        ; @0x506
	ldd	%r14,[%sp,72]                   ; @0x506
 ;	 }
	vvmov1.vi.to.w	%vr6,12,%r2             ; @0x510
	vvmov1.vi.to.w	%vr6,13,%r3             ; @0x516
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,13,%blink          ; 8-byte Folded Reload
                                        ; @0x51c
	ldd	%r30,[%sp,88]                   ; @0x51c
 ;	 }
	vvmov1.vi.to.w	%vr3,13,%r19            ; @0x526
	vvmov1.vi.to.w	%vr7,14,%r20            ; @0x52c
	vvmov1.vi.to.w	%vr8,14,%r14            ; @0x532
	vvmov1.vi.to.w	%vr5,14,%r16            ; @0x538
	vvmov1.vi.to.w	%vr6,14,%r8             ; @0x53e
	vvmov1.vi.to.w	%vr3,14,%r30            ; @0x544
	vvmov1.vi.to.w	%vr4,14,%r6             ; @0x54a
	vvmov1.vi.to.w	%vr1,14,%r4             ; @0x550
	vvmov1.vi.to.w	%vr2,14,%r0             ; @0x556
	vvmov1.vi.to.w	%vr7,15,%r21            ; @0x55c
	vvmov1.vi.to.w	%vr8,15,%r15            ; @0x562
.vvsbundle  " v2" 
 ;	 { 
	vvcmac.lo.uu.w	%vr19, %vr8, %vr7       ; @0x568
	vvmov1.vi.to.w	%vr5,15,%r17            ; @0x568
 ;	 }
	vvmov1.vi.to.w	%vr6,15,%r9             ; @0x572
.vvsbundle  " v2" 
 ;	 { 
	vvcmac.lo.uu.w	%vr16, %vr6, %vr5       ; @0x578
	vvmov1.vi.to.w	%vr3,15,%blink          ; @0x578
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvnop                                   ; @0x582
	vvmov1.vi.to.w	%vr4,15,%r7             ; @0x582
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvcmac.lo.uu.w	%vr18, %vr4, %vr3       ; @0x58a
	vvmov1.vi.to.w	%vr1,15,%r5             ; @0x58a
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvnop                                   ; @0x594
	vvmov1.vi.to.w	%vr2,15,%r1             ; @0x594
 ;	 }
	vvcmac.lo.uu.w	%vr17, %vr2, %vr1       ; @0x59c
.LZD2:                                  ; @0x5a2
	; ZD Loop End                           ; @0x5a2
;  %bb.6:                               ; %middle.block
.vvsbundle  "v1sc" 
 ;	 { 
	vvadd.w	%vr1, %vr18, %vr17              ; @0x5a2
	cmp	%r11,%r13                       ; @0x5a2
 ;	 }
	vvadd.w	%vr1, %vr16, %vr1               ; @0x5ac
	vvadd.w	%vr16, %vr19, %vr1              ; @0x5b2
	vvc2add.w	%vr16                   ; @0x5b8
	vvshfleven.w	%vr16, %vr16            ; @0x5bc
	vvc2add.w	%vr16                   ; @0x5c0
	vvshfleven.w	%vr16, %vr16            ; @0x5c4
	vvc2add.w	%vr16                   ; @0x5c8
	vvshfleven.w	%vr16, %vr16            ; @0x5cc
	vvc2add.w	%vr16                   ; @0x5d0
	vvmov1.x.from.w	%r2,%vr16,0             ; @0x5d4
	beq_s	.LBB0_13                        ; @0x5da
;  %bb.7:                               ; %vec.epilog.iter.check
	tst	%r13,56                         ; @0x5dc
	beq_s	.LBB0_11                        ; @0x5e0
.LBB0_8:                                ; %vec.epilog.ph
                                        ; @0x5e2
	; Implicit def %r1                      ; @0x5e2
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,0,%r2              ; @0x5e2
	sub	%r0,%r13,%r11                   ; @0x5e2
 ;	 }
	sub_s	%r0,%r0,8                       ; @0x5ec
	lsr_s	%r0,%r0,3                       ; @0x5ee
	add2	%r2,%r58,%r11                   ; @0x5f0
	add2	%r12,%fp,%r11                   ; @0x5f4
	add	%lp_count,%r0,1                 ; @0x5f8
	bmskn	%r11,%r13,2                     ; @0x5fc
	lp	.LZD1                           ; @0x600
.LBB0_9:                                ; %vec.epilog.vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x604
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov.w	 %vr2, 0                        ; @0x604
	vvmov.w	 %vr1, 0                        ; @0x604
	ldd.ab	%r0,[%r12,32]                   ; @0x604
 ;	 }
	ldd.ab	%r4,[%r2,32]                    ; @0x610
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,0,%r0              ; @0x614
	ldd	%r6,[%r12,-24]                  ; @0x614
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,0,%r4              ; @0x61e
	ldd	%r8,[%r2,-24]                   ; @0x61e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,1,%r1              ; @0x628
	ldd	%r30,[%r12,-16]                 ; @0x628
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,1,%r5              ; @0x632
	ldd	%r4,[%r2,-16]                   ; @0x632
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,2,%r6              ; @0x63c
	ldd	%r14,[%r12,-8]                  ; @0x63c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,2,%r8              ; @0x646
	ldd	%r0,[%r2,-8]                    ; @0x646
 ;	 }
	vvmov1.vi.to.w	%vr1,3,%r7              ; @0x650
	vvmov1.vi.to.w	%vr2,3,%r9              ; @0x656
	vvmov1.vi.to.w	%vr1,4,%r30             ; @0x65c
	vvmov1.vi.to.w	%vr2,4,%r4              ; @0x662
	vvmov1.vi.to.w	%vr1,5,%blink           ; @0x668
	vvmov1.vi.to.w	%vr2,5,%r5              ; @0x66e
	vvmov1.vi.to.w	%vr1,6,%r14             ; @0x674
	vvmov1.vi.to.w	%vr2,6,%r0              ; @0x67a
	vvmov1.vi.to.w	%vr1,7,%r15             ; @0x680
	vvmov1.vi.to.w	%vr2,7,%r1              ; @0x686
	vvmpy.w	%vr1, %vr2, %vr1                ; @0x68c
	vvadd.w	%vr0, %vr1, %vr0                ; @0x692
.LZD1:                                  ; @0x698
	; ZD Loop End                           ; @0x698
;  %bb.10:                              ; %vec.epilog.middle.block
.vvsbundle  " v3" 
 ;	 { 
	vvmov.w	 %vr2, 0                        ; @0x698
	vvpinit.w	%p1, 0, 65520           ; @0x698
	vvci.w	%vr1                            ; @0x698
 ;	 }
	vvpinit.w	%p2, 0, 15              ; @0x6a6
.vvsbundle  " v3" 
 ;	 { 
	vvadd.w	%vr1, %vr1, 2                   ; @0x6ac
	vvpinit.w	%p3, 0, 65532           ; @0x6ac
	vvadd.w	%vr3, %vr1, 4                   ; @0x6ac
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvpinit.w	%p4, 0, 3               ; @0x6ba
	vvsel.w.p1	%vr3, %vr2, %vr3        ; @0x6ba
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvsel.w.p3	%vr1, %vr2, %vr1        ; @0x6c6
	vvshfl.w.p2	%vr3, %vr0, %vr3        ; @0x6c6
 ;	 }
	vvadd.w	%vr0, %vr0, %vr3                ; @0x6d0
	vvshfl.w.p4	%vr1, %vr0, %vr1        ; @0x6d4
	vvadd.w	%vr0, %vr0, %vr1                ; @0x6da
	vvmov1.from.w	%r0,%vr0,1              ; @0x6de
	vvadd.w	%vr0, %vr0, %r0                 ; @0x6e4
	vvmov1.x.from.w	%r2,%vr0,0              ; @0x6e8
	breq	%r11,%r13,.LBB0_13              ; @0x6ee
.LBB0_11:                               ; %for.body.preheader
                                        ; @0x6f2
	; Implicit def %r1                      ; @0x6f2
	add	%r0,%r11,1                      ; @0x6f2
	max	%r0,%r13,%r0                    ; @0x6f6
	add2	%r13,%fp,%r11                   ; @0x6fa
	add2	%r24,%r58,%r11                  ; @0x6fe
	sub	%lp_count,%r0,%r11              ; @0x702
	mov	%r58,%r2                        ; @0x706
	lp	.LZD0                           ; @0x70a
.LBB0_12:                               ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x70e
	ld.ab	%r0,[%r13,4]                    ; @0x70e
	ld.ab	%r1,[%r24,4]                    ; @0x712
	mac	%r2,%r1,%r0                     ; @0x716
.LZD0:                                  ; @0x71a
	; ZD Loop End                           ; @0x71a
.LBB0_13:                               ; %for.cond.cleanup
                                        ; @0x71a
	mov_s	%r0,%r2                         ; @0x71a
	ld	%blink,[%sp,52]                 ; @0x71c
	.cfa_restore	{%blink}                ; @0x720
	ld	%fp,[%sp,48]                    ; @0x720
	.cfa_restore	{%fp}                   ; @0x724
	ld	%r24,[%sp,44]                   ; @0x724
	.cfa_restore	{%r24}                  ; @0x728
	ldd	%r22,[%sp,36]                   ; @0x728
	.cfa_restore	{%r23}                  ; @0x72c
	.cfa_restore	{%r22}                  ; @0x72c
	ldd	%r20,[%sp,28]                   ; @0x72c
	.cfa_restore	{%r21}                  ; @0x730
	.cfa_restore	{%r20}                  ; @0x730
	ldd	%r18,[%sp,20]                   ; @0x730
	.cfa_restore	{%r19}                  ; @0x734
	.cfa_restore	{%r18}                  ; @0x734
	ldd	%r16,[%sp,12]                   ; @0x734
	.cfa_restore	{%r17}                  ; @0x738
	.cfa_restore	{%r16}                  ; @0x738
	ldd	%r14,[%sp,4]                    ; @0x738
	.cfa_restore	{%r15}                  ; @0x73c
	.cfa_restore	{%r14}                  ; @0x73c
	ld.ab	%r13,[%sp,248]                  ; @0x73c
	.cfa_restore	{%r13}                  ; @0x740
	.cfa_pop	248                             ; @0x740
	j_s	[%blink]                        ; @0x740
	.cfa_ef
.Lfunc_end0:                            ; @0x742

	.align	4                               ; -- End function
                                        ; -- Begin function vectorized_dotp
vectorized_dotp:                        ; @vectorized_dotp
                                        ; @0x744
.Lvectorized_dotp$local:                ; @0x744
	.cfa_bf	.Lvectorized_dotp$local
;  %bb.0:                               ; %entry
	.cfa_same	%r30                    ; @0x744
	.cfa_same	%r12                    ; @0x744
	.cfa_same	%r11                    ; @0x744
	.cfa_same	%r9                     ; @0x744
	.cfa_same	%r8                     ; @0x744
	.cfa_same	%r7                     ; @0x744
	.cfa_same	%r6                     ; @0x744
	.cfa_same	%r5                     ; @0x744
	.cfa_same	%r4                     ; @0x744
	.cfa_same	%r3                     ; @0x744
	.cfa_same	%r2                     ; @0x744
	.cfa_same	%r1                     ; @0x744
	mov_s	%r0,0                           ; @0x744
	j_s	[%blink]                        ; @0x746
	.cfa_ef
.Lfunc_end1:                            ; @0x748

	.align	4                               ; -- End function
                                        ; -- Begin function autovectorized_dotp
autovectorized_dotp:                    ; @autovectorized_dotp
                                        ; @0x748
.Lautovectorized_dotp$local:            ; @0x748
	.cfa_bf	.Lautovectorized_dotp$local
;  %bb.0:                               ; %entry
	.cfa_same	%r30                    ; @0x748
	.cfa_same	%r7                     ; @0x748
	.cfa_same	%r6                     ; @0x748
	.cfa_same	%r5                     ; @0x748
	.cfa_same	%r4                     ; @0x748
	mov_s	%r3,%r2                         ; @0x748
	cmp_s	%r2,0                           ; @0x74a
	mov_s	%r2,0                           ; @0x74c
	ble	.LBB2_13                        ; @0x74e
;  %bb.1:                               ; %iter.check
	cmp_s	%r3,8                           ; @0x752
	mov_s	%r11,0                          ; @0x754
	bcs	.LBB2_11                        ; Predicate Case 2
                                        ; @0x756
;  %bb.3:                               ; Predicate Case 2
                                        ; %vector.main.loop.iter.check
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr0, 0                        ; @0x75a
	cmp_s	%r3,64                          ; @0x75a
 ;	 }
	mov_s	%r11,0                          ; @0x760
	bcs	.LBB2_8                         ; @0x762
;  %bb.4:                               ; %vector.ph
.vvsbundle  "v3sc" 
 ;	 { 
	vvmov.w	 %vr16, 0                       ; @0x766
	vvmov.w	 %vr18, 0                       ; @0x766
	vvmov.w	 %vr17, 0                       ; @0x766
	sub3	%r2,%r3,64/8                    ; @0x766
 ;	 }
	; Implicit def %r9                      ; @0x776
	lsr_s	%r2,%r2,6                       ; @0x776
	add	%lp_count,%r2,1                 ; @0x778
	add2	%r2,%r1,192/4                   ; @0x77c
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr19, 0                       ; @0x780
	add2	%r12,%r0,192/4                  ; @0x780
 ;	 }
	bmskn	%r11,%r3,5                      ; @0x788
	lp	.LZD5                           ; @0x78c
.LBB2_5:                                ; %vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x790
	vvld.av.w	%vr1,%r12,-1            ; @0x790
	vvld.av.w	%vr2,%r2,-1             ; @0x796
.vvsbundle  " v2" 
 ;	 { 
	vvld.av.w	%vr3,%r12,-1            ; @0x79c
	vvcmac.lo.uu.w	%vr19, %vr2, %vr1       ; @0x79c
 ;	 }
	vvld.av.w	%vr1,%r2,-1             ; @0x7a6
.vvsbundle  " v2" 
 ;	 { 
	vvld.av.w	%vr2,%r12,-1            ; @0x7ac
	vvcmac.lo.uu.w	%vr16, %vr1, %vr3       ; @0x7ac
 ;	 }
	vvld.av.w	%vr1,%r2,-1             ; @0x7b6
.vvsbundle  " v2" 
 ;	 { 
	vvld.av.w	%vr3,%r12,7             ; @0x7bc
	vvcmac.lo.uu.w	%vr18, %vr1, %vr2       ; @0x7bc
 ;	 }
	vvld.av.w	%vr1,%r2,7              ; @0x7c6
	vvcmac.lo.uu.w	%vr17, %vr1, %vr3       ; @0x7cc
.LZD5:                                  ; @0x7d2
	; ZD Loop End                           ; @0x7d2
;  %bb.6:                               ; %middle.block
.vvsbundle  "v1sc" 
 ;	 { 
	vvadd.w	%vr1, %vr18, %vr17              ; @0x7d2
	cmp	%r11,%r3                        ; @0x7d2
 ;	 }
	vvadd.w	%vr1, %vr16, %vr1               ; @0x7dc
	vvadd.w	%vr16, %vr19, %vr1              ; @0x7e2
	vvc2add.w	%vr16                   ; @0x7e8
	vvshfleven.w	%vr16, %vr16            ; @0x7ec
	vvc2add.w	%vr16                   ; @0x7f0
	vvshfleven.w	%vr16, %vr16            ; @0x7f4
	vvc2add.w	%vr16                   ; @0x7f8
	vvshfleven.w	%vr16, %vr16            ; @0x7fc
	vvc2add.w	%vr16                   ; @0x800
	vvmov1.x.from.w	%r2,%vr16,0             ; @0x804
	beq_s	.LBB2_13                        ; @0x80a
;  %bb.7:                               ; %vec.epilog.iter.check
	tst	%r3,56                          ; @0x80c
	beq_s	.LBB2_11                        ; @0x810
.LBB2_8:                                ; %vec.epilog.ph
                                        ; @0x812
	; Implicit def %r9                      ; @0x812
.vvsbundle  "v2sc" 
 ;	 { 
	vvpinit.w	%p1, 0, 255             ; @0x812
	vvmov.w	 %vr1, 0                        ; @0x812
	sub	%r12,%r3,%r11                   ; @0x812
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,0,%r2              ; @0x820
	sub_s	%r12,%r12,8                     ; @0x820
 ;	 }
	lsr	%r8,%r12,3                      ; @0x828
	add2	%r2,%r1,%r11                    ; @0x82c
	add2	%r12,%r0,%r11                   ; @0x830
	add	%lp_count,%r8,1                 ; @0x834
	bmskn	%r11,%r3,2                      ; @0x838
	lp	.LZD4                           ; @0x83c
.LBB2_9:                                ; %vec.epilog.vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x840
	vvld.ab.w.p1	%vr2,%r12,32            ; @0x840
	vvld.ab.w.p1	%vr3,%r2,32             ; @0x848
	vvmpy.w	%vr2, %vr3, %vr2                ; @0x850
	vvadd.w	%vr1, %vr2, %vr1                ; @0x856
.LZD4:                                  ; @0x85c
	; ZD Loop End                           ; @0x85c
;  %bb.10:                              ; %vec.epilog.middle.block
.vvsbundle  " v2" 
 ;	 { 
	vvpinit.w	%p1, 0, 65520           ; @0x85c
	vvci.w	%vr2                            ; @0x85c
 ;	 }
	vvpinit.w	%p2, 0, 15              ; @0x866
.vvsbundle  " v3" 
 ;	 { 
	vvadd.w	%vr2, %vr2, 2                   ; @0x86c
	vvpinit.w	%p3, 0, 65532           ; @0x86c
	vvadd.w	%vr3, %vr2, 4                   ; @0x86c
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvpinit.w	%p4, 0, 3               ; @0x87a
	vvsel.w.p1	%vr3, %vr0, %vr3        ; @0x87a
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvsel.w.p3	%vr0, %vr0, %vr2        ; @0x886
	vvshfl.w.p2	%vr3, %vr1, %vr3        ; @0x886
 ;	 }
	vvadd.w	%vr1, %vr1, %vr3                ; @0x890
	vvshfl.w.p4	%vr0, %vr1, %vr0        ; @0x894
	vvadd.w	%vr0, %vr1, %vr0                ; @0x89a
	vvmov1.from.w	%r2,%vr0,1              ; @0x8a0
	vvadd.w	%vr0, %vr0, %r2                 ; @0x8a6
	vvmov1.x.from.w	%r2,%vr0,0              ; @0x8aa
	breq	%r11,%r3,.LBB2_13               ; @0x8b0
.LBB2_11:                               ; %for.body.preheader
                                        ; @0x8b4
	add	%r12,%r11,1                     ; @0x8b4
	max	%r3,%r3,%r12                    ; @0x8b8
	add2	%r0,%r0,%r11                    ; @0x8bc
	add2	%r1,%r1,%r11                    ; @0x8c0
	sub	%lp_count,%r3,%r11              ; @0x8c4
	; Implicit def %r3                      ; @0x8c8
	mov	%r58,%r2                        ; @0x8c8
	lp	.LZD3                           ; @0x8cc
.LBB2_12:                               ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x8d0
	ld.ab	%r2,[%r0,4]                     ; @0x8d0
	ld.ab	%r3,[%r1,4]                     ; @0x8d4
	mac	%r2,%r3,%r2                     ; @0x8d8
.LZD3:                                  ; @0x8dc
	; ZD Loop End                           ; @0x8dc
.LBB2_13:                               ; %for.cond.cleanup
                                        ; @0x8dc
	mov_s	%r0,%r2                         ; @0x8dc
	j_s	[%blink]                        ; @0x8de
	.cfa_ef
.Lfunc_end2:                            ; @0x8e0

	.reloc	_init_ad,0	;startup code to enable %status AD bit ; -- End function
