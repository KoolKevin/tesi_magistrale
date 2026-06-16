	.option	%reg
	.off	assume_short
	.file	"vec_sum.c"
	.globl	vec_sum
	.type	vec_sum,@function
	.type	.Lvec_sum$local,@function
	.size	vec_sum, .Lfunc_end0-vec_sum
	.size	.Lvec_sum$local, .Lfunc_end0-vec_sum
	.globl	vectorized_vec_sum
	.type	vectorized_vec_sum,@function
	.type	.Lvectorized_vec_sum$local,@function
	.size	vectorized_vec_sum, .Lfunc_end1-vectorized_vec_sum
	.size	.Lvectorized_vec_sum$local, .Lfunc_end1-vectorized_vec_sum
	.globl	autovectorized_vec_sum
	.type	autovectorized_vec_sum,@function
	.type	.Lautovectorized_vec_sum$local,@function
	.size	autovectorized_vec_sum, .Lfunc_end2-autovectorized_vec_sum
	.size	.Lautovectorized_vec_sum$local, .Lfunc_end2-autovectorized_vec_sum
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
	.align	8                               ; -- Begin function vec_sum
vec_sum:                                ; @vec_sum
                                        ; @0x0
.Lvec_sum$local:                        ; @0x0
	.cfa_bf	.Lvec_sum$local
;  %bb.0:                               ; %entry
	st.aw	%r13,[%sp,-256]                 ; @0x0
	.cfa_push	256                     ; @0x4
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
	mov_s	%r11,%r3                        ; @0x24
	cmp_s	%r3,0                           ; @0x26
	ble	.LBB0_14                        ; @0x28
;  %bb.1:                               ; %iter.check
	mov_s	%r8,%r1                         ; @0x2c
	mov_s	%r13,%r0                        ; @0x2e
	cmp	%r11,8                          ; @0x30
	mov_s	%r1,0                           ; @0x34
	bcs	.LBB0_12                        ; @0x36
;  %bb.2:                               ; %vector.memcheck
	add2	%r0,%r2,%r11                    ; @0x3a
	add2	%r12,%r13,%r11                  ; @0x3e
	setlo	%r3,%r13,%r0                    ; @0x42
	setlo	%r12,%r2,%r12                   ; @0x46
	tst_s	%r12,%r3                        ; @0x4a
	bne	.LBB0_12                        ; @0x4c
;  %bb.3:                               ; %vector.memcheck
	add2	%r3,%r8,%r11                    ; @0x50
	setlo	%r0,%r8,%r0                     ; @0x54
	setlo	%r3,%r2,%r3                     ; @0x58
	tst_s	%r3,%r0                         ; @0x5c
	bne	.LBB0_12                        ; @0x5e
;  %bb.4:                               ; %vector.main.loop.iter.check
	cmp	%r11,64                         ; @0x62
	bcs	.LBB0_9                         ; @0x66
;  %bb.5:                               ; %vector.ph
	sub3	%r0,%r11,64/8                   ; @0x6a
	lsr_s	%r0,%r0,6                       ; @0x6e
	add2	%r24,%r8,192/4                  ; @0x70
	add2	%fp,%r13,192/4                  ; @0x74
	bmskn	%r1,%r11,5                      ; @0x78
	add	%lp_count,%r0,1                 ; @0x7c
	add	%r12,%r2,56                     ; @0x80
	st	%r1,[%sp,128]                   ; 4-byte Folded Spill
                                        ; @0x84
	; Implicit def %r1                      ; @0x88
	st	%r8,[%sp,140]                   ; 4-byte Folded Spill
                                        ; @0x88
	st	%r13,[%sp,136]                  ; 4-byte Folded Spill
                                        ; @0x8c
	st	%r2,[%sp,132]                   ; 4-byte Folded Spill
                                        ; @0x90
	lp	.LZD2                           ; @0x94
.LBB0_6:                                ; %vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x98
	ldd	%r8,[%fp,-192]                  ; @0x98
	ldd	%r4,[%r24,-192]                 ; @0x9c
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,0,%r8              ; @0xa0
	ldd	%r6,[%fp,-184]                  ; @0xa0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,0,%r4              ; @0xaa
	ldd	%r30,[%r24,-184]                ; @0xaa
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,1,%r9              ; @0xb4
	ldd	%r18,[%fp,-176]                 ; @0xb4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,1,%r5              ; @0xbe
	ldd	%r4,[%r24,-176]                 ; @0xbe
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,2,%r6              ; @0xc8
	ldd	%r14,[%fp,-168]                 ; @0xc8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,2,%r30             ; @0xd2
	ldd	%r16,[%r24,-168]                ; @0xd2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,3,%r7              ; @0xdc
	ldd	%r22,[%fp,-128]                 ; @0xdc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,3,%blink           ; @0xe6
	ldd	%r8,[%r24,-128]                 ; @0xe6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,4,%r18             ; @0xf0
	ldd	%r6,[%fp,-160]                  ; @0xf0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,4,%r4              ; @0xfa
	ldd	%r2,[%r24,-160]                 ; @0xfa
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,5,%r19             ; @0x104
	ldd	%r30,[%fp,-120]                 ; @0x104
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,5,%r5              ; @0x10e
	ldd	%r4,[%r24,-120]                 ; @0x10e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,6,%r14             ; @0x118
	ldd	%r18,[%fp,-152]                 ; @0x118
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,6,%r16             ; @0x122
	ldd	%r20,[%r24,-152]                ; @0x122
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,7,%r15             ; @0x12c
	ldd	%r14,[%fp,-112]                 ; @0x12c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,7,%r17             ; @0x136
	ldd	%r0,[%r24,-112]                 ; @0x136
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,0,%r22             ; @0x140
	ldd	%r16,[%fp,-144]                 ; @0x140
 ;	 }
	vvmov1.vi.to.w	%vr1,0,%r8              ; @0x14a
	std	%r16,[%sp,80]                   ; 8-byte Folded Spill
                                        ; @0x150
	ldd	%r16,[%r24,-144]                ; @0x154
	vvmov1.vi.to.w	%vr2,8,%r6              ; @0x158
	std	%r16,[%sp,88]                   ; 8-byte Folded Spill
                                        ; @0x15e
	ldd	%r16,[%fp,-104]                 ; @0x162
	vvmov1.vi.to.w	%vr3,8,%r2              ; @0x166
	std	%r16,[%sp,104]                  ; 8-byte Folded Spill
                                        ; @0x16c
	ldd	%r16,[%r24,-104]                ; @0x170
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,1,%r23             ; @0x174
	ldd	%r22,[%fp,-136]                 ; @0x174
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,1,%r9              ; @0x17e
	ldd	%r8,[%r24,-136]                 ; @0x17e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,9,%r7              ; @0x188
	ldd	%r6,[%fp,-64]                   ; @0x188
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,9,%r3              ; @0x192
	ldd	%r2,[%r24,-64]                  ; @0x192
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,2,%r30             ; 8-byte Folded Spill
                                        ; @0x19c
	std	%r8,[%sp,112]                   ; @0x19c
 ;	 }
	std	%r2,[%sp,144]                   ; 8-byte Folded Spill
                                        ; @0x1a6
	ldd	%r2,[%fp,-96]                   ; @0x1aa
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,3,%blink           ; @0x1ae
	ldd	%r30,[%r24,-96]                 ; @0x1ae
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,2,%r4              ; 8-byte Folded Spill
                                        ; @0x1b8
	std	%r2,[%sp,56]                    ; @0x1b8
 ;	 }
	ldd	%r2,[%fp,-56]                   ; @0x1c2
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,3,%r5              ; 8-byte Folded Spill
                                        ; @0x1c6
	std	%r16,[%sp,96]                   ; @0x1c6
 ;	 }
	std	%r2,[%sp,64]                    ; 8-byte Folded Spill
                                        ; @0x1d0
	ldd	%r2,[%r24,-56]                  ; @0x1d4
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,10,%r18            ; @0x1d8
	ldd	%r8,[%fp,-88]                   ; @0x1d8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,11,%r19            ; 8-byte Folded Spill
                                        ; @0x1e2
	std	%r2,[%sp,72]                    ; @0x1e2
 ;	 }
	ldd	%r18,[%r24,-88]                 ; @0x1ec
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,10,%r20            ; @0x1f0
	ldd	%r2,[%fp,-48]                   ; @0x1f0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,11,%r21            ; @0x1fa
	ldd	%r20,[%r24,-48]                 ; @0x1fa
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,4,%r14             ; 8-byte Folded Spill
                                        ; @0x204
	std	%r2,[%sp,120]                   ; @0x204
 ;	 }
	ldd	%r2,[%fp,-80]                   ; @0x20e
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,5,%r15             ; 8-byte Folded Reload
                                        ; @0x212
	ldd	%r14,[%sp,144]                  ; @0x212
 ;	 }
	std	%r2,[%sp,152]                   ; 8-byte Folded Spill
                                        ; @0x21c
	ldd	%r2,[%r24,-80]                  ; @0x220
	vvmov1.vi.to.w	%vr1,4,%r0              ; @0x224
	std	%r2,[%sp,160]                   ; 8-byte Folded Spill
                                        ; @0x22a
	ldd	%r2,[%fp,-40]                   ; @0x22e
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,5,%r1              ; 8-byte Folded Reload
                                        ; @0x232
	ldd	%r0,[%sp,80]                    ; @0x232
 ;	 }
	std	%r2,[%sp,208]                   ; 8-byte Folded Spill
                                        ; @0x23c
	ldd	%r2,[%r24,-40]                  ; @0x240
	vvmov1.vi.to.w	%vr2,12,%r0             ; @0x244
	std	%r2,[%sp,200]                   ; 8-byte Folded Spill
                                        ; @0x24a
	ldd	%r2,[%fp,-72]                   ; @0x24e
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,13,%r1             ; 8-byte Folded Reload
                                        ; @0x252
	ldd	%r0,[%sp,88]                    ; @0x252
 ;	 }
	std	%r2,[%sp,184]                   ; 8-byte Folded Spill
                                        ; @0x25c
	ldd	%r2,[%r24,-72]                  ; @0x260
	vvmov1.vi.to.w	%vr3,12,%r0             ; @0x264
	std	%r2,[%sp,176]                   ; 8-byte Folded Spill
                                        ; @0x26a
	ldd	%r2,[%fp,0]                     ; @0x26e
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,13,%r1             ; 8-byte Folded Reload
                                        ; @0x272
	ldd	%r0,[%sp,104]                   ; @0x272
 ;	 }
	std	%r2,[%sp,192]                   ; 8-byte Folded Spill
                                        ; @0x27c
	ldd	%r2,[%r24,0]                    ; @0x280
	vvmov1.vi.to.w	%vr0,6,%r0              ; @0x284
	std	%r2,[%sp,216]                   ; 8-byte Folded Spill
                                        ; @0x28a
	ldd	%r2,[%fp,-32]                   ; @0x28e
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,7,%r1              ; 8-byte Folded Reload
                                        ; @0x292
	ldd	%r0,[%sp,96]                    ; @0x292
 ;	 }
	std	%r2,[%sp,168]                   ; 8-byte Folded Spill
                                        ; @0x29c
	ldd	%r2,[%r24,-32]                  ; @0x2a0
	vvmov1.vi.to.w	%vr1,6,%r0              ; @0x2a4
	std	%r2,[%sp,224]                   ; 8-byte Folded Spill
                                        ; @0x2aa
	ldd	%r2,[%fp,8]                     ; @0x2ae
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,7,%r1              ; 8-byte Folded Reload
                                        ; @0x2b2
	ldd	%r0,[%sp,112]                   ; @0x2b2
 ;	 }
	std	%r2,[%sp,104]                   ; 8-byte Folded Spill
                                        ; @0x2bc
	ldd	%r2,[%r24,8]                    ; @0x2c0
	vvmov1.vi.to.w	%vr2,14,%r22            ; @0x2c4
	std	%r2,[%sp,96]                    ; 8-byte Folded Spill
                                        ; @0x2ca
	ldd	%r2,[%fp,-24]                   ; @0x2ce
	vvmov1.vi.to.w	%vr2,15,%r23            ; @0x2d2
	std	%r2,[%sp,88]                    ; 8-byte Folded Spill
                                        ; @0x2d8
	ldd	%r2,[%r24,-24]                  ; @0x2dc
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,14,%r0             ; @0x2e0
	ldd	%r22,[%fp,16]                   ; @0x2e0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,15,%r1             ; 8-byte Folded Spill
                                        ; @0x2ea
	std	%r2,[%sp,80]                    ; @0x2ea
 ;	 }
	ldd	%r2,[%r24,16]                   ; @0x2f4
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,0,%r6              ; 8-byte Folded Reload
                                        ; @0x2f8
	vvadd.w	%vr4, %vr3, %vr2                ; @0x2f8
	ldd	%r0,[%sp,56]                    ; @0x2f8
 ;	 }
	std	%r2,[%sp,112]                   ; 8-byte Folded Spill
                                        ; @0x306
	ldd	%r2,[%fp,-16]                   ; @0x30a
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,1,%r7              ; @0x30e
	ldd	%r4,[%r24,-16]                  ; @0x30e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r2,%vr4,14             ; 8-byte Folded Spill
                                        ; @0x318
	std	%r2,[%sp,248]                   ; @0x318
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,0,%r14             ; 8-byte Folded Spill
                                        ; @0x322
	vvmov2.x.from.w	%r4,%vr4,12             ; @0x322
	std	%r4,[%sp,240]                   ; @0x322
 ;	 }
	ldd	%r6,[%fp,24]                    ; @0x330
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,1,%r15             ; @0x334
	vvmov2.x.from.w	%r2,%vr4,10             ; @0x334
	std.ab	%r2,[%r12,-8]                   ; @0x334
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov2.x.from.w	%r4,%vr4,8              ; @0x342
	vvmov1.vi.to.w	%vr0,8,%r0              ; @0x342
	std.ab	%r4,[%r12,-8]                   ; @0x342
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov2.x.from.w	%r2,%vr4,6              ; @0x350
	vvmov1.vi.to.w	%vr0,9,%r1              ; @0x350
	std.ab	%r2,[%r12,-8]                   ; @0x350
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,8,%r30             ; 8-byte Folded Reload
                                        ; @0x35e
	ldd	%r0,[%sp,64]                    ; @0x35e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r4,%vr4,4              ; @0x368
	std.ab	%r4,[%r12,-8]                   ; @0x368
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov2.x.from.w	%r2,%vr4,2              ; @0x372
	vvmov1.vi.to.w	%vr1,9,%blink           ; @0x372
	std.ab	%r2,[%r12,-8]                   ; @0x372
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov2.x.from.w	%r4,%vr4,0              ; @0x380
	vvmov1.vi.to.w	%vr2,2,%r0              ; @0x380
	std.ab	%r4,[%r12,-8]                   ; @0x380
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,3,%r1              ; 8-byte Folded Reload
                                        ; @0x38e
	ldd	%r0,[%sp,72]                    ; @0x38e
 ;	 }
	std.ab	%r2,[%r12,-8]                   ; @0x398
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,2,%r0              ; 8-byte Folded Spill
                                        ; @0x39c
	std	%r6,[%sp,232]                   ; @0x39c
 ;	 }
	std.ab	%r4,[%r12,120]                  ; @0x3a6
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,3,%r1              ; @0x3aa
	ldd	%r6,[%r24,24]                   ; @0x3aa
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,10,%r8             ; @0x3b4
	ldd	%r4,[%fp,-8]                    ; @0x3b4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,11,%r9             ; @0x3be
	ldd	%r8,[%r24,-8]                   ; @0x3be
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,10,%r18            ; @0x3c8
	mov_s	%r3,%r19                        ; @0x3c8
 ;	 }
	ldd	%r18,[%fp,32]                   ; @0x3d0
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,11,%r3             ; @0x3d4
	ldd	%r14,[%r24,32]                  ; @0x3d4
 ;	 }
	ldd	%r0,[%sp,120]                   ; 8-byte Folded Reload
                                        ; @0x3de
	ldd	%r2,[%fp,40]                    ; @0x3e2
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,4,%r0              ; 8-byte Folded Reload
                                        ; @0x3e6
	ldd	%r30,[%sp,160]                  ; @0x3e6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,5,%r1              ; 8-byte Folded Spill
                                        ; @0x3f0
	std	%r2,[%sp,56]                    ; @0x3f0
 ;	 }
	ldd	%r2,[%r24,40]                   ; @0x3fa
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,4,%r20             ; 8-byte Folded Reload
                                        ; @0x3fe
	ldd	%r0,[%sp,168]                   ; @0x3fe
 ;	 }
	std	%r2,[%sp,64]                    ; 8-byte Folded Spill
                                        ; @0x408
	ldd	%r2,[%fp,48]                    ; @0x40c
	vvmov1.vi.to.w	%vr3,5,%r21             ; @0x410
	std	%r2,[%sp,72]                    ; 8-byte Folded Spill
                                        ; @0x416
	ldd	%r2,[%r24,48]                   ; @0x41a
	ldd	%r20,[%fp,56]                   ; @0x41e
	std	%r2,[%sp,120]                   ; 8-byte Folded Spill
                                        ; @0x422
	ldd	%r2,[%sp,152]                   ; 8-byte Folded Reload
                                        ; @0x426
	vvmov1.vi.to.w	%vr0,12,%r2             ; @0x42a
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,13,%r3             ; 8-byte Folded Reload
                                        ; @0x430
	ldd	%r2,[%sp,200]                   ; @0x430
 ;	 }
	ldd	%r16,[%r24,56]                  ; @0x43a
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,6,%r2              ; @0x43e
	add3	%r24,%r24,256/8                 ; @0x43e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,7,%r3              ; 8-byte Folded Reload
                                        ; @0x448
	ldd	%r2,[%sp,184]                   ; @0x448
 ;	 }
	vvmov1.vi.to.w	%vr1,12,%r30            ; @0x452
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,14,%r2             ; @0x458
	add3	%fp,%fp,256/8                   ; @0x458
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,15,%r3             ; 8-byte Folded Reload
                                        ; @0x462
	ldd	%r2,[%sp,176]                   ; @0x462
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,13,%blink          ; 8-byte Folded Reload
                                        ; @0x46c
	ldd	%r30,[%sp,208]                  ; @0x46c
 ;	 }
	vvmov1.vi.to.w	%vr1,14,%r2             ; @0x476
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,15,%r3             ; 8-byte Folded Reload
                                        ; @0x47c
	ldd	%r2,[%sp,192]                   ; @0x47c
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvadd.w	%vr4, %vr1, %vr0                ; @0x486
	vvmov1.vi.to.w	%vr2,6,%r30             ; @0x486
 ;	 }
	vvmov1.vi.to.w	%vr0,0,%r2              ; @0x490
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,7,%blink           ; 8-byte Folded Reload
                                        ; @0x496
	ldd	%r30,[%sp,216]                  ; @0x496
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvmov2.x.from.w	%r2,%vr4,14             ; @0x4a0
	vvmov1.vi.to.w	%vr0,1,%r3              ; @0x4a0
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,0,%r30             ; @0x4aa
	vvmov2.x.from.w	%r58,%vr4,12            ; @0x4aa
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,1,%blink           ; @0x4b4
	vvmov2.x.from.w	%r2,%vr4,10             ; @0x4b4
	std.ab	%r2,[%r12,-8]                   ; @0x4b4
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov2.x.from.w	%r30,%vr4,8             ; @0x4c2
	vvmov1.vi.to.w	%vr2,8,%r0              ; @0x4c2
	std.ab	%r58,[%r12,-8]                  ; @0x4c2
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov2.x.from.w	%r2,%vr4,6              ; @0x4d0
	vvmov1.vi.to.w	%vr2,9,%r1              ; @0x4d0
	std.ab	%r2,[%r12,-8]                   ; @0x4d0
 ;	 }
	ldd	%r0,[%sp,224]                   ; 8-byte Folded Reload
                                        ; @0x4de
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r30,%vr4,4             ; @0x4e2
	std.ab	%r30,[%r12,-8]                  ; @0x4e2
 ;	 }
	vvmov1.vi.to.w	%vr3,8,%r0              ; @0x4ec
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov2.x.from.w	%r58,%vr4,2             ; @0x4f2
	vvmov1.vi.to.w	%vr3,9,%r1              ; @0x4f2
	std.ab	%r2,[%r12,-8]                   ; @0x4f2
 ;	 }
	ldd	%r2,[%sp,104]                   ; 8-byte Folded Reload
                                        ; @0x500
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r30,%vr4,0             ; @0x504
	std.ab	%r30,[%r12,-8]                  ; @0x504
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,2,%r2              ; 8-byte Folded Reload
                                        ; @0x50e
	ldd	%r0,[%sp,64]                    ; @0x50e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,3,%r3              ; 8-byte Folded Reload
                                        ; @0x518
	ldd	%r2,[%sp,96]                    ; @0x518
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,4,%r22             ; @0x522
	std.ab	%r58,[%r12,-8]                  ; @0x522
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,2,%r2              ; @0x52c
	std.ab	%r30,[%r12,120]                 ; @0x52c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,3,%r3              ; 8-byte Folded Reload
                                        ; @0x536
	ldd	%r2,[%sp,88]                    ; @0x536
 ;	 }
	vvmov1.vi.to.w	%vr0,5,%r23             ; @0x540
	vvmov1.vi.to.w	%vr2,10,%r2             ; @0x546
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,11,%r3             ; 8-byte Folded Reload
                                        ; @0x54c
	ldd	%r2,[%sp,80]                    ; @0x54c
 ;	 }
	vvmov1.vi.to.w	%vr3,10,%r2             ; @0x556
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,11,%r3             ; 8-byte Folded Reload
                                        ; @0x55c
	ldd	%r2,[%sp,112]                   ; @0x55c
 ;	 }
	vvmov1.vi.to.w	%vr1,4,%r2              ; @0x566
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,5,%r3              ; 8-byte Folded Reload
                                        ; @0x56c
	ldd	%r2,[%sp,248]                   ; @0x56c
 ;	 }
	vvmov1.vi.to.w	%vr1,6,%r6              ; @0x576
	vvmov1.vi.to.w	%vr2,12,%r2             ; @0x57c
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,13,%r3             ; 8-byte Folded Reload
                                        ; @0x582
	ldd	%r2,[%sp,240]                   ; @0x582
 ;	 }
	vvmov1.vi.to.w	%vr2,14,%r4             ; @0x58c
	vvmov1.vi.to.w	%vr3,12,%r2             ; @0x592
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,13,%r3             ; 8-byte Folded Reload
                                        ; @0x598
	ldd	%r2,[%sp,232]                   ; @0x598
 ;	 }
	vvmov1.vi.to.w	%vr3,14,%r8             ; @0x5a2
	vvmov1.vi.to.w	%vr0,6,%r2              ; @0x5a8
	vvmov1.vi.to.w	%vr2,15,%r5             ; @0x5ae
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,15,%r9             ; 8-byte Folded Reload
                                        ; @0x5b4
	ldd	%r8,[%sp,120]                   ; @0x5b4
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvadd.w	%vr2, %vr3, %vr2                ; @0x5be
	vvmov1.vi.to.w	%vr0,7,%r3              ; @0x5be
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,7,%r7              ; 8-byte Folded Reload
                                        ; @0x5c8
	ldd	%r6,[%sp,56]                    ; @0x5c8
 ;	 }
	vvmov1.vi.to.w	%vr0,8,%r18             ; @0x5d2
.vvsbundle  " v2" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,8,%r14             ; @0x5d8
	vvmov2.x.from.w	%r2,%vr2,14             ; @0x5d8
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,9,%r19             ; @0x5e2
	vvmov2.x.from.w	%r4,%vr2,12             ; @0x5e2
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,9,%r15             ; @0x5ec
	vvmov2.x.from.w	%r2,%vr2,10             ; @0x5ec
	std.ab	%r2,[%r12,-8]                   ; @0x5ec
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,10,%r6             ; @0x5fa
	vvmov2.x.from.w	%r4,%vr2,8              ; @0x5fa
	std.ab	%r4,[%r12,-8]                   ; @0x5fa
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,10,%r0             ; @0x608
	vvmov2.x.from.w	%r2,%vr2,6              ; @0x608
	std.ab	%r2,[%r12,-8]                   ; @0x608
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov2.x.from.w	%r4,%vr2,4              ; @0x616
	vvmov1.vi.to.w	%vr0,11,%r7             ; @0x616
	std.ab	%r4,[%r12,-8]                   ; @0x616
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,11,%r1             ; 8-byte Folded Reload
                                        ; @0x624
	ldd	%r6,[%sp,72]                    ; @0x624
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r2,%vr2,2              ; @0x62e
	std.ab	%r2,[%r12,-8]                   ; @0x62e
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov2.x.from.w	%r4,%vr2,0              ; @0x638
	vvmov1.vi.to.w	%vr0,12,%r6             ; @0x638
	std.ab	%r4,[%r12,-8]                   ; @0x638
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,12,%r8             ; @0x646
	std.ab	%r2,[%r12,-8]                   ; @0x646
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,13,%r7             ; @0x650
	std.ab	%r4,[%r12,120]                  ; @0x650
 ;	 }
	vvmov1.vi.to.w	%vr1,13,%r9             ; @0x65a
	vvmov1.vi.to.w	%vr0,14,%r20            ; @0x660
	vvmov1.vi.to.w	%vr1,14,%r16            ; @0x666
	vvmov1.vi.to.w	%vr0,15,%r21            ; @0x66c
	vvmov1.vi.to.w	%vr1,15,%r17            ; @0x672
	vvadd.w	%vr0, %vr1, %vr0                ; @0x678
	vvmov2.x.from.w	%r2,%vr0,14             ; @0x67e
	vvmov2.x.from.w	%r4,%vr0,12             ; @0x684
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r2,%vr0,10             ; @0x68a
	std.ab	%r2,[%r12,-8]                   ; @0x68a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r4,%vr0,8              ; @0x694
	std.ab	%r4,[%r12,-8]                   ; @0x694
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r2,%vr0,6              ; @0x69e
	std.ab	%r2,[%r12,-8]                   ; @0x69e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r4,%vr0,4              ; @0x6a8
	std.ab	%r4,[%r12,-8]                   ; @0x6a8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r2,%vr0,2              ; @0x6b2
	std.ab	%r2,[%r12,-8]                   ; @0x6b2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r6,%vr0,0              ; @0x6bc
	std.ab	%r4,[%r12,-8]                   ; @0x6bc
 ;	 }
	std.ab	%r2,[%r12,-8]                   ; @0x6c6
	std.ab	%r6,[%r12,120]                  ; @0x6ca
.LZD2:                                  ; @0x6ce
	; ZD Loop End                           ; @0x6ce
;  %bb.7:                               ; %middle.block
	ld	%r1,[%sp,128]                   ; 4-byte Folded Reload
                                        ; @0x6ce
	ld	%r8,[%sp,140]                   ; 4-byte Folded Reload
                                        ; @0x6d2
	ld	%r13,[%sp,136]                  ; 4-byte Folded Reload
                                        ; @0x6d6
	ld	%r2,[%sp,132]                   ; 4-byte Folded Reload
                                        ; @0x6da
	cmp_s	%r1,%r11                        ; @0x6de
	beq_s	.LBB0_14                        ; @0x6e0
;  %bb.8:                               ; %vec.epilog.iter.check
	tst	%r11,56                         ; @0x6e2
	beq_s	.LBB0_12                        ; @0x6e6
.LBB0_9:                                ; %vec.epilog.ph
                                        ; @0x6e8
	; Implicit def %r6                      ; @0x6e8
	sub	%r0,%r11,%r1                    ; @0x6e8
	sub_s	%r0,%r0,8                       ; @0x6ec
	lsr_s	%r0,%r0,3                       ; @0x6ee
	add2	%r9,%r2,%r1                     ; @0x6f0
	add2	%r12,%r8,%r1                    ; @0x6f4
	add2	%r3,%r13,%r1                    ; @0x6f8
	add	%lp_count,%r0,1                 ; @0x6fc
	bmskn	%r1,%r11,2                      ; @0x700
	lp	.LZD1                           ; @0x704
.LBB0_10:                               ; %vec.epilog.vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x708
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov.w	 %vr1, 0                        ; @0x708
	vvmov.w	 %vr0, 0                        ; @0x708
	ldd.ab	%r4,[%r3,32]                    ; @0x708
 ;	 }
	ldd.ab	%r6,[%r12,32]                   ; @0x714
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,0,%r4              ; @0x718
	ldd	%r30,[%r3,-24]                  ; @0x718
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,0,%r6              ; @0x722
	ldd	%r14,[%r12,-24]                 ; @0x722
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,1,%r5              ; @0x72c
	ldd	%r16,[%r3,-16]                  ; @0x72c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,1,%r7              ; @0x736
	ldd	%r6,[%r12,-16]                  ; @0x736
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,2,%r30             ; @0x740
	ldd	%r18,[%r3,-8]                   ; @0x740
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,2,%r14             ; @0x74a
	ldd	%r4,[%r12,-8]                   ; @0x74a
 ;	 }
	vvmov1.vi.to.w	%vr0,3,%blink           ; @0x754
	vvmov1.vi.to.w	%vr1,3,%r15             ; @0x75a
	vvmov1.vi.to.w	%vr0,4,%r16             ; @0x760
	vvmov1.vi.to.w	%vr1,4,%r6              ; @0x766
	vvmov1.vi.to.w	%vr0,5,%r17             ; @0x76c
	vvmov1.vi.to.w	%vr1,5,%r7              ; @0x772
	vvmov1.vi.to.w	%vr0,6,%r18             ; @0x778
	vvmov1.vi.to.w	%vr1,6,%r4              ; @0x77e
	vvmov1.vi.to.w	%vr0,7,%r19             ; @0x784
	vvmov1.vi.to.w	%vr1,7,%r5              ; @0x78a
	vvadd.w	%vr0, %vr1, %vr0                ; @0x790
	vvmov2.x.from.w	%r4,%vr0,6              ; @0x796
	vvmov2.x.from.w	%r6,%vr0,2              ; @0x79c
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r30,%vr0,4             ; @0x7a2
	std	%r4,[%r9,24]                    ; @0x7a2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r4,%vr0,0              ; @0x7ac
	std	%r6,[%r9,8]                     ; @0x7ac
 ;	 }
	std	%r30,[%r9,16]                   ; @0x7b6
	std.ab	%r4,[%r9,32]                    ; @0x7ba
.LZD1:                                  ; @0x7be
	; ZD Loop End                           ; @0x7be
;  %bb.11:                              ; %vec.epilog.middle.block
	breq	%r1,%r11,.LBB0_14               ; @0x7be
.LBB0_12:                               ; %for.body.preheader
                                        ; @0x7c2
	add_s	%r0,%r1,1                       ; @0x7c2
	max	%r0,%r11,%r0                    ; @0x7c4
	add2	%r24,%r13,%r1                   ; @0x7c8
	add2	%r13,%r8,%r1                    ; @0x7cc
	add2_s	%r2,%r2,%r1                     ; @0x7d0
	sub	%lp_count,%r0,%r1               ; @0x7d2
	; Implicit def %r1                      ; @0x7d6
	lp	.LZD0                           ; @0x7d6
.LBB0_13:                               ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x7da
	ld.ab	%r0,[%r24,4]                    ; @0x7da
	ld.ab	%r1,[%r13,4]                    ; @0x7de
	add_s	%r0,%r1,%r0                     ; @0x7e2
	st.ab	%r0,[%r2,4]                     ; @0x7e4
.LZD0:                                  ; @0x7e8
	; ZD Loop End                           ; @0x7e8
.LBB0_14:                               ; %for.cond.cleanup
                                        ; @0x7e8
	ld	%blink,[%sp,52]                 ; @0x7e8
	.cfa_restore	{%blink}                ; @0x7ec
	ld	%fp,[%sp,48]                    ; @0x7ec
	.cfa_restore	{%fp}                   ; @0x7f0
	ld	%r24,[%sp,44]                   ; @0x7f0
	.cfa_restore	{%r24}                  ; @0x7f4
	ldd	%r22,[%sp,36]                   ; @0x7f4
	.cfa_restore	{%r23}                  ; @0x7f8
	.cfa_restore	{%r22}                  ; @0x7f8
	ldd	%r20,[%sp,28]                   ; @0x7f8
	.cfa_restore	{%r21}                  ; @0x7fc
	.cfa_restore	{%r20}                  ; @0x7fc
	ldd	%r18,[%sp,20]                   ; @0x7fc
	.cfa_restore	{%r19}                  ; @0x800
	.cfa_restore	{%r18}                  ; @0x800
	ldd	%r16,[%sp,12]                   ; @0x800
	.cfa_restore	{%r17}                  ; @0x804
	.cfa_restore	{%r16}                  ; @0x804
	ldd	%r14,[%sp,4]                    ; @0x804
	.cfa_restore	{%r15}                  ; @0x808
	.cfa_restore	{%r14}                  ; @0x808
	ld_s	%r13,[%sp,0]                    ; @0x808
	.cfa_restore	{%r13}                  ; @0x80a
	add	%sp,%sp,256                     ; @0x80a
	.cfa_pop	256                             ; @0x80e
	j_s	[%blink]                        ; @0x80e
	.cfa_ef
.Lfunc_end0:                            ; @0x810

	.align	4                               ; -- End function
                                        ; -- Begin function vectorized_vec_sum
vectorized_vec_sum:                     ; @vectorized_vec_sum
                                        ; @0x810
.Lvectorized_vec_sum$local:             ; @0x810
	.cfa_bf	.Lvectorized_vec_sum$local
;  %bb.0:                               ; %entry
	.cfa_same	%r30                    ; @0x810
	.cfa_same	%r11                    ; @0x810
	.cfa_same	%r9                     ; @0x810
	.cfa_same	%r8                     ; @0x810
	.cfa_same	%r7                     ; @0x810
	.cfa_same	%r6                     ; @0x810
	.cfa_same	%r5                     ; @0x810
	.cfa_same	%r4                     ; @0x810
	cmp_s	%r3,16                          ; @0x810
	.cfa_remember_state                     ; @0x812
	jlt	[%blink]                        ; @0x812
	.cfa_restore_state                      ; @0x816
;  %bb.1:                               ; %for.body.preheader
	asr	%r12,%r3,31                     ; @0x816
	lsr_s	%r12,%r12,28                    ; @0x81a
	add_s	%r3,%r3,%r12                    ; @0x81c
	; Implicit def %r12                     ; @0x81e
	asr	%lp_count,%r3,4                 ; @0x81e
	lp	.LZD3                           ; @0x822
.LBB1_2:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x826
	vvld.av.w	%vr0,%r1,1              ; @0x826
	vvld.av.w	%vr1,%r0,1              ; @0x82c
	vvadd.w	%vr0, %vr1, %vr0                ; @0x832
	vvst.av.w	%vr0,%r2,1              ; @0x838
.LZD3:                                  ; @0x83e
	; ZD Loop End                           ; @0x83e
;  %bb.3:                               ; %for.cond.cleanup
	j_s	[%blink]                        ; @0x83e
	.cfa_ef
.Lfunc_end1:                            ; @0x840

	.align	4                               ; -- End function
                                        ; -- Begin function autovectorized_vec_sum
autovectorized_vec_sum:                 ; @autovectorized_vec_sum
                                        ; @0x840
.Lautovectorized_vec_sum$local:         ; @0x840
	.cfa_bf	.Lautovectorized_vec_sum$local
;  %bb.0:                               ; %entry
	.cfa_same	%r30                    ; @0x840
	.cfa_same	%r5                     ; @0x840
	.cfa_same	%r4                     ; @0x840
	mov_s	%r11,%r3                        ; @0x840
	cmp_s	%r3,0                           ; @0x842
	.cfa_remember_state                     ; @0x844
	jle	[%blink]                        ; @0x844
	.cfa_restore_state                      ; @0x848
;  %bb.1:                               ; %iter.check
	cmp	%r11,8                          ; @0x848
	mov_s	%r8,0                           ; @0x84c
	bcs	.LBB2_10                        ; @0x84e
;  %bb.2:                               ; %vector.main.loop.iter.check
	cmp	%r11,64                         ; @0x852
	bcs	.LBB2_7                         ; @0x856
;  %bb.3:                               ; %vector.ph
	; Implicit def %r7                      ; @0x85a
	add	%r3,%r3,-64                     ; @0x85a
	lsr_s	%r3,%r3,6                       ; @0x85e
	add	%lp_count,%r3,1                 ; @0x860
	add2	%r9,%r1,192/4                   ; @0x864
	add2	%r12,%r0,192/4                  ; @0x868
	add2	%r3,%r2,192/4                   ; @0x86c
	bmskn	%r8,%r11,5                      ; @0x870
	lp	.LZD6                           ; @0x874
.LBB2_4:                                ; %vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x878
	vvld.av.w	%vr0,%r12,-1            ; @0x878
	vvld.av.w	%vr1,%r9,-1             ; @0x87e
.vvsbundle  " v2" 
 ;	 { 
	vvld.av.w	%vr2,%r12,-1            ; @0x884
	vvadd.w	%vr0, %vr1, %vr0                ; @0x884
 ;	 }
	vvld.av.w	%vr1,%r9,-1             ; @0x88e
.vvsbundle  " v2" 
 ;	 { 
	vvld.av.w	%vr3,%r12,-1            ; @0x894
	vvadd.w	%vr1, %vr1, %vr2                ; @0x894
 ;	 }
	vvld.av.w	%vr2,%r9,-1             ; @0x89c
.vvsbundle  " v2" 
 ;	 { 
	vvst.av.w	%vr0,%r3,-1             ; @0x8a2
	vvadd.w	%vr0, %vr2, %vr3                ; @0x8a2
 ;	 }
	vvst.av.w	%vr1,%r3,-1             ; @0x8ac
	vvld.av.w	%vr1,%r12,7             ; @0x8b2
	vvld.av.w	%vr2,%r9,7              ; @0x8b8
.vvsbundle  " v2" 
 ;	 { 
	vvst.av.w	%vr0,%r3,-1             ; @0x8be
	vvadd.w	%vr0, %vr2, %vr1                ; @0x8be
 ;	 }
	vvst.av.w	%vr0,%r3,7              ; @0x8c8
.LZD6:                                  ; @0x8ce
	; ZD Loop End                           ; @0x8ce
;  %bb.5:                               ; %middle.block
	cmp	%r8,%r11                        ; @0x8ce
	.cfa_remember_state                     ; @0x8d2
	jeq_s	[%blink]                        ; @0x8d2
	.cfa_restore_state                      ; @0x8d4
;  %bb.6:                               ; %vec.epilog.iter.check
	tst	%r11,56                         ; @0x8d4
	beq_s	.LBB2_10                        ; @0x8d8
.LBB2_7:                                ; %vec.epilog.ph
                                        ; @0x8da
	; Implicit def %r7                      ; @0x8da
.vvsbundle  "v1sc" 
 ;	 { 
	vvpinit.w	%p1, 0, 255             ; @0x8da
	sub	%r3,%r11,%r8                    ; @0x8da
 ;	 }
	sub_s	%r3,%r3,8                       ; @0x8e4
	lsr	%r6,%r3,3                       ; @0x8e6
	add2	%r9,%r2,%r8                     ; @0x8ea
	add2	%r12,%r1,%r8                    ; @0x8ee
	add2	%r3,%r0,%r8                     ; @0x8f2
	add	%lp_count,%r6,1                 ; @0x8f6
	bmskn	%r8,%r11,2                      ; @0x8fa
	lp	.LZD5                           ; @0x8fe
.LBB2_8:                                ; %vec.epilog.vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x902
	vvld.ab.w.p1	%vr0,%r3,32             ; @0x902
	vvld.ab.w.p1	%vr1,%r12,32            ; @0x90a
	vvadd.w	%vr0, %vr1, %vr0                ; @0x912
	vvst.ab.w.p1	%vr0,%r9,32             ; @0x918
.LZD5:                                  ; @0x920
	; ZD Loop End                           ; @0x920
;  %bb.9:                               ; %vec.epilog.middle.block
	cmp	%r8,%r11                        ; @0x920
	.cfa_remember_state                     ; @0x924
	nop                                     ; inserted to benefit BPU
                                        ; @0x924
	jeq_s	[%blink]                        ; @0x928
	.cfa_restore_state                      ; @0x92a
.LBB2_10:                               ; %for.body.preheader
                                        ; @0x92a
	; Implicit def %r12                     ; @0x92a
	add	%r3,%r8,1                       ; @0x92a
	max	%r3,%r11,%r3                    ; @0x92e
	add2	%r0,%r0,%r8                     ; @0x932
	add2	%r1,%r1,%r8                     ; @0x936
	add2	%r2,%r2,%r8                     ; @0x93a
	sub	%lp_count,%r3,%r8               ; @0x93e
	lp	.LZD4                           ; @0x942
.LBB2_11:                               ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x946
	ld.ab	%r3,[%r0,4]                     ; @0x946
	ld.ab	%r12,[%r1,4]                    ; @0x94a
	add_s	%r3,%r12,%r3                    ; @0x94e
	st.ab	%r3,[%r2,4]                     ; @0x950
.LZD4:                                  ; @0x954
	; ZD Loop End                           ; @0x954
;  %bb.12:                              ; %for.cond.cleanup
	j_s	[%blink]                        ; @0x954
	.cfa_ef
.Lfunc_end2:                            ; @0x956

	.reloc	_init_ad,0	;startup code to enable %status AD bit ; -- End function
