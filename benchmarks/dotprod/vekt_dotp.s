	.option	%reg
	.off	assume_short
	.file	"LLVMDialectModule"
	.globl	vekt_dotp
	.type	vekt_dotp,@function
	.size	vekt_dotp, .Lfunc_end0-vekt_dotp
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
	.align	8                               ; -- Begin function vekt_dotp
vekt_dotp:                              ; @vekt_dotp
                                        ; @0x0
	.cfa_bf	vekt_dotp
;  %bb.0:
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
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr0, 0                        ; @0x24
	mov	%r58,%r3                        ; @0x24
 ;	 }
	mov_s	%r11,%r1                        ; @0x2c
	not	%r0,%r58                        ; @0x2e
.vvsbundle  "v1sc" 
 ;	 { 
	vvcmpy.lo.w	%vr16, %vr0, 0          ; @0x32
	mov	%r1,%r58                        ; @0x32
 ;	 }
	cmp	%r58,0                          ; @0x3c
	mov.lt	%r1,%r0                         ; @0x40
	asr	%r0,%r1,31                      ; @0x44
	lsr_s	%r0,%r0,28                      ; @0x48
	add_s	%r0,%r1,%r0                     ; @0x4a
	asr_s	%r1,%r0,4                       ; @0x4c
	not_s	%r0,%r1                         ; @0x4e
	mov.lt	%r1,%r0                         ; @0x50
	asl	%r59,%r1,4                      ; @0x54
	mov_s	%r24,%r6                        ; @0x58
	brlt	%r1,1,.LBB0_3                   ; @0x5a
;  %bb.1:                               ; %.lr.ph.preheader
	; Implicit def %r12                     ; @0x5e
	max	%r0,%r59,16                     ; @0x5e
	add_s	%r0,%r0,-1                      ; @0x62
	lsr_s	%r0,%r0,4                       ; @0x64
	add	%lp_count,%r0,1                 ; @0x66
	mov_s	%r0,%r11                        ; @0x6a
	mov_s	%r2,%r24                        ; @0x6c
	lp	.LZD3                           ; @0x6e
.LBB0_2:                                ; %.lr.ph
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x72
	vvld.av.w	%vr0,%r2,1              ; @0x72
	vvld.av.w	%vr1,%r0,1              ; @0x78
	vvcmac.lo.w	%vr16, %vr1, %vr0       ; @0x7e
.LZD3:                                  ; @0x84
	; ZD Loop End                           ; @0x84
.LBB0_3:                                ; %._crit_edge
                                        ; @0x84
.vvsbundle  "v1sc" 
 ;	 { 
	vvc2add.w	%vr16                   ; @0x84
	cmp	%r58,%r59                       ; @0x84
 ;	 }
	vvshfleven.w	%vr16, %vr16            ; @0x8c
	vvc2add.w	%vr16                   ; @0x90
	vvshfleven.w	%vr16, %vr16            ; @0x94
	vvc2add.w	%vr16                   ; @0x98
	vvshfleven.w	%vr16, %vr16            ; @0x9c
	vvc2add.w	%vr16                   ; @0xa0
	vvmov1.x.from.w	%r0,%vr16,0             ; @0xa4
	ble	.LBB0_17                        ; @0xaa
;  %bb.4:                               ; %iter.check
	sub	%fp,%r58,%r59                   ; @0xae
	cmp	%fp,8                           ; @0xb2
	bcs	.LBB0_15                        ; @0xb6
;  %bb.5:                               ; %vector.main.loop.iter.check
	asl_s	%r12,%r1,6                      ; @0xba
	cmp	%fp,64                          ; @0xbc
	mov_s	%r2,0                           ; @0xc0
	bcs	.LBB0_12                        ; Predicate Case 2
                                        ; @0xc2
;  %bb.7:                               ; Predicate Case 2
                                        ; %vector.ph
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov.w	 %vr17, 0                       ; @0xc6
	vvmov.w	 %vr16, 0                       ; @0xc6
	sub3	%r1,%fp,64/8                    ; @0xc6
 ;	 }
	lsr_s	%r1,%r1,6                       ; @0xd2
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr16,0,%r0             ; @0xd4
	add	%lp_count,%r1,1                 ; @0xd4
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov.w	 %vr18, 0                       ; @0xde
	vvmov.w	 %vr19, 0                       ; @0xde
	add	%r1,%r24,%r12                   ; @0xde
 ;	 }
	add	%r2,%r11,%r12                   ; @0xea
	st	%r24,[%sp,108]                  ; 4-byte Folded Spill
                                        ; @0xee
	st	%r11,[%sp,104]                  ; 4-byte Folded Spill
                                        ; @0xf2
	add2	%r24,%r1,192/4                  ; @0xf6
	; Implicit def %r1                      ; @0xfa
	add2	%r11,%r2,192/4                  ; @0xfa
	bmskn	%r3,%fp,5                       ; @0xfe
	st	%r12,[%sp,112]                  ; 4-byte Folded Spill
                                        ; @0x102
	st	%r3,[%sp,116]                   ; 4-byte Folded Spill
                                        ; @0x106
	lp	.LZD2                           ; @0x10a
.LBB0_8:                                ; %vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x10e
	ldd	%r2,[%r11,0]                    ; @0x10e
	ldd	%r4,[%r24,0]                    ; @0x112
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr6,0,%r2              ; @0x116
	ldd	%r6,[%r11,-64]                  ; @0x116
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr7,0,%r4              ; @0x120
	ldd	%r8,[%r24,-64]                  ; @0x120
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr4,0,%r6              ; @0x12a
	ldd	%r30,[%r11,-128]                ; @0x12a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr5,0,%r8              ; @0x134
	ldd	%r12,[%r24,-128]                ; @0x134
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,0,%r30             ; @0x13e
	ldd	%r14,[%r11,-192]                ; @0x13e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,0,%r12             ; @0x148
	ldd	%r16,[%r24,-192]                ; @0x148
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,0,%r14             ; @0x152
	ldd	%r18,[%r11,8]                   ; @0x152
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,0,%r16             ; @0x15c
	ldd	%r20,[%r24,8]                   ; @0x15c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr6,1,%r3              ; @0x166
	ldd	%r22,[%r11,-56]                 ; @0x166
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr7,1,%r5              ; @0x170
	ldd	%r2,[%r24,-56]                  ; @0x170
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr4,1,%r7              ; @0x17a
	ldd	%r4,[%r11,-120]                 ; @0x17a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr5,1,%r9              ; @0x184
	ldd	%r6,[%r24,-120]                 ; @0x184
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,1,%blink           ; @0x18e
	ldd	%r8,[%r11,-184]                 ; @0x18e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,1,%r13             ; @0x198
	ldd	%r30,[%r24,-184]                ; @0x198
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,1,%r15             ; @0x1a2
	ldd	%r12,[%r11,16]                  ; @0x1a2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,1,%r17             ; @0x1ac
	ldd	%r0,[%r24,16]                   ; @0x1ac
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr6,2,%r18             ; @0x1b6
	ldd	%r16,[%r11,-48]                 ; @0x1b6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr7,2,%r20             ; @0x1c0
	ldd	%r14,[%r24,-48]                 ; @0x1c0
 ;	 }
	vvmov1.vi.to.w	%vr4,2,%r22             ; @0x1ca
	std	%r14,[%sp,96]                   ; 8-byte Folded Spill
                                        ; @0x1d0
	ldd	%r14,[%r11,-112]                ; @0x1d4
	vvmov1.vi.to.w	%vr5,2,%r2              ; @0x1d8
	std	%r14,[%sp,88]                   ; 8-byte Folded Spill
                                        ; @0x1de
	ldd	%r14,[%r24,-112]                ; @0x1e2
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr6,3,%r19             ; @0x1e6
	ldd	%r18,[%r11,-176]                ; @0x1e6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr7,3,%r21             ; @0x1f0
	ldd	%r20,[%r24,-176]                ; @0x1f0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr4,3,%r23             ; @0x1fa
	ldd	%r22,[%r11,24]                  ; @0x1fa
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr5,3,%r3              ; @0x204
	ldd	%r2,[%r24,24]                   ; @0x204
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,2,%r4              ; 8-byte Folded Spill
                                        ; @0x20e
	std	%r14,[%sp,80]                   ; @0x20e
 ;	 }
	std	%r2,[%sp,120]                   ; 8-byte Folded Spill
                                        ; @0x218
	ldd	%r2,[%r11,-40]                  ; @0x21c
	vvmov1.vi.to.w	%vr2,3,%r5              ; @0x220
	std	%r2,[%sp,56]                    ; 8-byte Folded Spill
                                        ; @0x226
	ldd	%r2,[%r24,-40]                  ; @0x22a
	vvmov1.vi.to.w	%vr3,2,%r6              ; @0x22e
	std	%r2,[%sp,64]                    ; 8-byte Folded Spill
                                        ; @0x234
	ldd	%r2,[%r11,-104]                 ; @0x238
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,3,%r7              ; @0x23c
	ldd	%r4,[%r24,-104]                 ; @0x23c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,2,%r8              ; 8-byte Folded Spill
                                        ; @0x246
	std	%r2,[%sp,72]                    ; @0x246
 ;	 }
	ldd	%r6,[%r11,-168]                 ; @0x250
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,3,%r9              ; @0x254
	ldd	%r2,[%r24,-168]                 ; @0x254
 ;	 }
	vvmov1.vi.to.w	%vr1,2,%r30             ; @0x25e
	std	%r2,[%sp,176]                   ; 8-byte Folded Spill
                                        ; @0x264
	ldd	%r2,[%r11,32]                   ; @0x268
	vvmov1.vi.to.w	%vr1,3,%blink           ; @0x26c
	std	%r2,[%sp,232]                   ; 8-byte Folded Spill
                                        ; @0x272
	ldd	%r2,[%r24,32]                   ; @0x276
	vvmov1.vi.to.w	%vr6,4,%r12             ; @0x27a
	std	%r2,[%sp,248]                   ; 8-byte Folded Spill
                                        ; @0x280
	ldd	%r2,[%r11,-32]                  ; @0x284
	vvmov1.vi.to.w	%vr6,5,%r13             ; @0x288
	std	%r2,[%sp,240]                   ; 8-byte Folded Spill
                                        ; @0x28e
	ldd	%r2,[%r24,-32]                  ; @0x292
	vvmov1.vi.to.w	%vr7,4,%r0              ; @0x296
	std	%r2,[%sp,224]                   ; 8-byte Folded Spill
                                        ; @0x29c
	ldd	%r2,[%r11,-96]                  ; @0x2a0
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr7,5,%r1              ; 8-byte Folded Reload
                                        ; @0x2a4
	ldd	%r0,[%sp,96]                    ; @0x2a4
 ;	 }
	std	%r2,[%sp,216]                   ; 8-byte Folded Spill
                                        ; @0x2ae
	ldd	%r2,[%r24,-96]                  ; @0x2b2
	vvmov1.vi.to.w	%vr4,4,%r16             ; @0x2b6
	std	%r2,[%sp,200]                   ; 8-byte Folded Spill
                                        ; @0x2bc
	ldd	%r2,[%r11,-160]                 ; @0x2c0
	vvmov1.vi.to.w	%vr4,5,%r17             ; @0x2c4
	std	%r2,[%sp,192]                   ; 8-byte Folded Spill
                                        ; @0x2ca
	ldd	%r2,[%r24,-160]                 ; @0x2ce
	vvmov1.vi.to.w	%vr5,4,%r0              ; @0x2d2
	std	%r2,[%sp,168]                   ; 8-byte Folded Spill
                                        ; @0x2d8
	ldd	%r2,[%r11,40]                   ; @0x2dc
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr5,5,%r1              ; 8-byte Folded Reload
                                        ; @0x2e0
	ldd	%r0,[%sp,88]                    ; @0x2e0
 ;	 }
	std	%r2,[%sp,208]                   ; 8-byte Folded Spill
                                        ; @0x2ea
	ldd	%r2,[%r24,40]                   ; @0x2ee
	vvmov1.vi.to.w	%vr2,4,%r0              ; @0x2f2
	std	%r2,[%sp,96]                    ; 8-byte Folded Spill
                                        ; @0x2f8
	ldd	%r2,[%r11,-24]                  ; @0x2fc
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,5,%r1              ; 8-byte Folded Reload
                                        ; @0x300
	ldd	%r0,[%sp,80]                    ; @0x300
 ;	 }
	std	%r2,[%sp,184]                   ; 8-byte Folded Spill
                                        ; @0x30a
	ldd	%r2,[%r24,-24]                  ; @0x30e
	vvmov1.vi.to.w	%vr3,4,%r0              ; @0x312
	std	%r2,[%sp,88]                    ; 8-byte Folded Spill
                                        ; @0x318
	ldd	%r2,[%r11,-88]                  ; @0x31c
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,5,%r1              ; 8-byte Folded Reload
                                        ; @0x320
	ldd	%r0,[%sp,120]                   ; @0x320
 ;	 }
	std	%r2,[%sp,160]                   ; 8-byte Folded Spill
                                        ; @0x32a
	ldd	%r2,[%r24,-88]                  ; @0x32e
	vvmov1.vi.to.w	%vr0,4,%r18             ; @0x332
	std	%r2,[%sp,152]                   ; 8-byte Folded Spill
                                        ; @0x338
	ldd	%r2,[%r11,-152]                 ; @0x33c
	vvmov1.vi.to.w	%vr0,5,%r19             ; @0x340
	std	%r2,[%sp,136]                   ; 8-byte Folded Spill
                                        ; @0x346
	ldd	%r2,[%r24,-152]                 ; @0x34a
	vvmov1.vi.to.w	%vr1,4,%r20             ; @0x34e
	std	%r2,[%sp,128]                   ; 8-byte Folded Spill
                                        ; @0x354
	ldd	%r2,[%r11,48]                   ; @0x358
	vvmov1.vi.to.w	%vr1,5,%r21             ; @0x35c
	std	%r2,[%sp,80]                    ; 8-byte Folded Spill
                                        ; @0x362
	ldd	%r2,[%r24,48]                   ; @0x366
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr6,6,%r22             ; @0x36a
	ldd	%r20,[%r11,-16]                 ; @0x36a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr6,7,%r23             ; @0x374
	ldd	%r22,[%r24,-16]                 ; @0x374
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr7,6,%r0              ; @0x37e
	ldd	%r16,[%r11,-80]                 ; @0x37e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr7,7,%r1              ; 8-byte Folded Reload
                                        ; @0x388
	ldd	%r0,[%sp,56]                    ; @0x388
 ;	 }
	ldd	%r14,[%r24,-80]                 ; @0x392
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr4,6,%r0              ; @0x396
	ldd	%r12,[%r11,-144]                ; @0x396
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr4,7,%r1              ; 8-byte Folded Reload
                                        ; @0x3a0
	ldd	%r0,[%sp,64]                    ; @0x3a0
 ;	 }
	std	%r2,[%sp,144]                   ; 8-byte Folded Spill
                                        ; @0x3aa
	ldd	%r30,[%r24,-144]                ; @0x3ae
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr5,6,%r0              ; @0x3b2
	ldd	%r18,[%r11,56]                  ; @0x3b2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr5,7,%r1              ; @0x3bc
	ldd	%r2,[%r24,56]                   ; @0x3bc
 ;	 }
	ldd	%r0,[%sp,72]                    ; 8-byte Folded Reload
                                        ; @0x3c6
	std	%r2,[%sp,64]                    ; 8-byte Folded Spill
                                        ; @0x3ca
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,6,%r0              ; @0x3ce
	ldd	%r2,[%r11,-8]                   ; @0x3ce
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,7,%r1              ; @0x3d8
	ldd	%r8,[%r24,-8]                   ; @0x3d8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,6,%r4              ; 8-byte Folded Spill
                                        ; @0x3e2
	std	%r2,[%sp,56]                    ; @0x3e2
 ;	 }
	ldd	%r2,[%r11,-72]                  ; @0x3ec
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,7,%r5              ; 8-byte Folded Reload
                                        ; @0x3f0
	ldd	%r0,[%sp,176]                   ; @0x3f0
 ;	 }
	std	%r2,[%sp,72]                    ; 8-byte Folded Spill
                                        ; @0x3fa
	ldd	%r4,[%r11,-136]                 ; @0x3fe
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,6,%r6              ; @0x402
	mov_s	%r3,%r7                         ; @0x402
 ;	 }
	ldd	%r6,[%r24,-72]                  ; @0x40a
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,7,%r3              ; @0x40e
	ldd	%r2,[%r24,-136]                 ; @0x40e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,6,%r0              ; @0x418
	add3	%r11,%r11,256/8                 ; @0x418
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,7,%r1              ; 8-byte Folded Reload
                                        ; @0x422
	ldd	%r0,[%sp,232]                   ; @0x422
 ;	 }
	add3	%r24,%r24,256/8                 ; @0x42c
	vvmov1.vi.to.w	%vr6,8,%r0              ; @0x430
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr6,9,%r1              ; 8-byte Folded Reload
                                        ; @0x436
	ldd	%r0,[%sp,248]                   ; @0x436
 ;	 }
	vvmov1.vi.to.w	%vr7,8,%r0              ; @0x440
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr7,9,%r1              ; 8-byte Folded Reload
                                        ; @0x446
	ldd	%r0,[%sp,240]                   ; @0x446
 ;	 }
	vvmov1.vi.to.w	%vr4,8,%r0              ; @0x450
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr4,9,%r1              ; 8-byte Folded Reload
                                        ; @0x456
	ldd	%r0,[%sp,224]                   ; @0x456
 ;	 }
	vvmov1.vi.to.w	%vr5,8,%r0              ; @0x460
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr5,9,%r1              ; 8-byte Folded Reload
                                        ; @0x466
	ldd	%r0,[%sp,216]                   ; @0x466
 ;	 }
	vvmov1.vi.to.w	%vr2,8,%r0              ; @0x470
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,9,%r1              ; 8-byte Folded Reload
                                        ; @0x476
	ldd	%r0,[%sp,200]                   ; @0x476
 ;	 }
	vvmov1.vi.to.w	%vr3,8,%r0              ; @0x480
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,9,%r1              ; 8-byte Folded Reload
                                        ; @0x486
	ldd	%r0,[%sp,192]                   ; @0x486
 ;	 }
	vvmov1.vi.to.w	%vr0,8,%r0              ; @0x490
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,9,%r1              ; 8-byte Folded Reload
                                        ; @0x496
	ldd	%r0,[%sp,168]                   ; @0x496
 ;	 }
	vvmov1.vi.to.w	%vr1,8,%r0              ; @0x4a0
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,9,%r1              ; 8-byte Folded Reload
                                        ; @0x4a6
	ldd	%r0,[%sp,208]                   ; @0x4a6
 ;	 }
	vvmov1.vi.to.w	%vr6,10,%r0             ; @0x4b0
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr6,11,%r1             ; 8-byte Folded Reload
                                        ; @0x4b6
	ldd	%r0,[%sp,96]                    ; @0x4b6
 ;	 }
	vvmov1.vi.to.w	%vr7,10,%r0             ; @0x4c0
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr7,11,%r1             ; 8-byte Folded Reload
                                        ; @0x4c6
	ldd	%r0,[%sp,184]                   ; @0x4c6
 ;	 }
	vvmov1.vi.to.w	%vr4,10,%r0             ; @0x4d0
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr4,11,%r1             ; 8-byte Folded Reload
                                        ; @0x4d6
	ldd	%r0,[%sp,88]                    ; @0x4d6
 ;	 }
	vvmov1.vi.to.w	%vr4,12,%r20            ; @0x4e0
	vvmov1.vi.to.w	%vr5,10,%r0             ; @0x4e6
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr5,11,%r1             ; 8-byte Folded Reload
                                        ; @0x4ec
	ldd	%r0,[%sp,160]                   ; @0x4ec
 ;	 }
	vvmov1.vi.to.w	%vr5,12,%r22            ; @0x4f6
	vvmov1.vi.to.w	%vr2,10,%r0             ; @0x4fc
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,11,%r1             ; 8-byte Folded Reload
                                        ; @0x502
	ldd	%r0,[%sp,152]                   ; @0x502
 ;	 }
	vvmov1.vi.to.w	%vr4,13,%r21            ; @0x50c
	vvmov1.vi.to.w	%vr3,10,%r0             ; @0x512
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,11,%r1             ; 8-byte Folded Reload
                                        ; @0x518
	ldd	%r0,[%sp,136]                   ; @0x518
 ;	 }
	vvmov1.vi.to.w	%vr3,12,%r14            ; @0x522
	vvmov1.vi.to.w	%vr0,10,%r0             ; @0x528
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,11,%r1             ; 8-byte Folded Reload
                                        ; @0x52e
	ldd	%r0,[%sp,128]                   ; @0x52e
 ;	 }
	vvmov1.vi.to.w	%vr0,12,%r12            ; @0x538
	vvmov1.vi.to.w	%vr1,10,%r0             ; @0x53e
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,11,%r1             ; 8-byte Folded Reload
                                        ; @0x544
	ldd	%r0,[%sp,80]                    ; @0x544
 ;	 }
	vvmov1.vi.to.w	%vr1,12,%r30            ; @0x54e
	vvmov1.vi.to.w	%vr6,12,%r0             ; @0x554
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr6,13,%r1             ; 8-byte Folded Reload
                                        ; @0x55a
	ldd	%r0,[%sp,144]                   ; @0x55a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,13,%r15            ; 8-byte Folded Reload
                                        ; @0x564
	ldd	%r14,[%sp,56]                   ; @0x564
 ;	 }
	vvmov1.vi.to.w	%vr7,12,%r0             ; @0x56e
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,13,%r13            ; 8-byte Folded Reload
                                        ; @0x574
	ldd	%r12,[%sp,64]                   ; @0x574
 ;	 }
	vvmov1.vi.to.w	%vr7,13,%r1             ; @0x57e
	vvmov1.vi.to.w	%vr2,12,%r16            ; @0x584
	vvmov1.vi.to.w	%vr5,13,%r23            ; @0x58a
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,13,%blink          ; 8-byte Folded Reload
                                        ; @0x590
	ldd	%r30,[%sp,72]                   ; @0x590
 ;	 }
	vvmov1.vi.to.w	%vr2,13,%r17            ; @0x59a
	vvmov1.vi.to.w	%vr6,14,%r18            ; @0x5a0
	vvmov1.vi.to.w	%vr7,14,%r12            ; @0x5a6
	vvmov1.vi.to.w	%vr4,14,%r14            ; @0x5ac
	vvmov1.vi.to.w	%vr5,14,%r8             ; @0x5b2
	vvmov1.vi.to.w	%vr2,14,%r30            ; @0x5b8
	vvmov1.vi.to.w	%vr3,14,%r6             ; @0x5be
	vvmov1.vi.to.w	%vr0,14,%r4             ; @0x5c4
	vvmov1.vi.to.w	%vr1,14,%r2             ; @0x5ca
	vvmov1.vi.to.w	%vr6,15,%r19            ; @0x5d0
	vvmov1.vi.to.w	%vr7,15,%r13            ; @0x5d6
.vvsbundle  " v2" 
 ;	 { 
	vvcmac.lo.uu.w	%vr18, %vr7, %vr6       ; @0x5dc
	vvmov1.vi.to.w	%vr4,15,%r15            ; @0x5dc
 ;	 }
	vvmov1.vi.to.w	%vr5,15,%r9             ; @0x5e6
.vvsbundle  " v2" 
 ;	 { 
	vvcmac.lo.uu.w	%vr19, %vr5, %vr4       ; @0x5ec
	vvmov1.vi.to.w	%vr2,15,%blink          ; @0x5ec
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvnop                                   ; @0x5f6
	vvmov1.vi.to.w	%vr3,15,%r7             ; @0x5f6
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvcmac.lo.uu.w	%vr17, %vr3, %vr2       ; @0x5fe
	vvmov1.vi.to.w	%vr0,15,%r5             ; @0x5fe
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvnop                                   ; @0x608
	vvmov1.vi.to.w	%vr1,15,%r3             ; @0x608
 ;	 }
	vvcmac.lo.uu.w	%vr16, %vr1, %vr0       ; @0x610
.LZD2:                                  ; @0x616
	; ZD Loop End                           ; @0x616
;  %bb.9:                               ; %middle.block
.vvsbundle  "v1sc" 
 ;	 { 
	vvadd.w	%vr0, %vr17, %vr16              ; 4-byte Folded Reload
                                        ; @0x616
	ld_s	%r2,[%sp,116]                   ; @0x616
 ;	 }
	vvadd.w	%vr0, %vr19, %vr0               ; @0x61e
.vvsbundle  "v1sc" 
 ;	 { 
	vvadd.w	%vr16, %vr18, %vr0              ; @0x624
	cmp	%fp,%r2                         ; @0x624
 ;	 }
	vvc2add.w	%vr16                   ; @0x62e
	vvshfleven.w	%vr16, %vr16            ; @0x632
	vvc2add.w	%vr16                   ; @0x636
	vvshfleven.w	%vr16, %vr16            ; @0x63a
	vvc2add.w	%vr16                   ; @0x63e
	vvshfleven.w	%vr16, %vr16            ; @0x642
	vvc2add.w	%vr16                   ; @0x646
	vvmov1.x.from.w	%r0,%vr16,0             ; @0x64a
	beq_s	.LBB0_17                        ; @0x650
;  %bb.10:                              ; %vec.epilog.iter.check
	tst	%fp,56                          ; @0x652
	beq_s	.LBB0_18                        ; @0x656
;  %bb.11:
	ld_s	%r12,[%sp,112]                  ; 4-byte Folded Reload
                                        ; @0x658
	ld	%r24,[%sp,108]                  ; 4-byte Folded Reload
                                        ; @0x65a
	ld	%r11,[%sp,104]                  ; 4-byte Folded Reload
                                        ; @0x65e
.LBB0_12:                               ; %vec.epilog.ph
                                        ; @0x662
	; Implicit def %r3                      ; @0x662
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr0, 0                        ; @0x662
	bmsk	%r1,%r58,2                      ; @0x662
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,0,%r0              ; @0x66a
	add_s	%r0,%r2,%r1                     ; @0x66a
 ;	 }
	add	%r0,%r0,%r59                    ; @0x672
	sub	%r0,%r58,%r0                    ; @0x676
	sub_s	%r0,%r0,8                       ; @0x67a
	add2_s	%r12,%r12,%r2                   ; @0x67c
	lsr_s	%r0,%r0,3                       ; @0x67e
	sub	%r2,%fp,%r1                     ; @0x680
	add	%lp_count,%r0,1                 ; @0x684
	add	%r0,%r24,%r12                   ; @0x688
	add_s	%r12,%r12,%r11                  ; @0x68c
	add	%r59,%r59,%r2                   ; @0x68e
	lp	.LZD1                           ; @0x692
.LBB0_13:                               ; %vec.epilog.vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x696
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov.w	 %vr2, 0                        ; @0x696
	vvmov.w	 %vr1, 0                        ; @0x696
	ldd.ab	%r2,[%r12,32]                   ; @0x696
 ;	 }
	ldd.ab	%r4,[%r0,32]                    ; @0x6a2
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,0,%r2              ; @0x6a6
	ldd	%r6,[%r12,-24]                  ; @0x6a6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,0,%r4              ; @0x6b0
	ldd	%r8,[%r0,-24]                   ; @0x6b0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,1,%r3              ; @0x6ba
	ldd	%r30,[%r12,-16]                 ; @0x6ba
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,1,%r5              ; @0x6c4
	ldd	%r4,[%r0,-16]                   ; @0x6c4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,2,%r6              ; @0x6ce
	ldd	%r14,[%r12,-8]                  ; @0x6ce
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,2,%r8              ; @0x6d8
	ldd	%r2,[%r0,-8]                    ; @0x6d8
 ;	 }
	vvmov1.vi.to.w	%vr1,3,%r7              ; @0x6e2
	vvmov1.vi.to.w	%vr2,3,%r9              ; @0x6e8
	vvmov1.vi.to.w	%vr1,4,%r30             ; @0x6ee
	vvmov1.vi.to.w	%vr2,4,%r4              ; @0x6f4
	vvmov1.vi.to.w	%vr1,5,%blink           ; @0x6fa
	vvmov1.vi.to.w	%vr2,5,%r5              ; @0x700
	vvmov1.vi.to.w	%vr1,6,%r14             ; @0x706
	vvmov1.vi.to.w	%vr2,6,%r2              ; @0x70c
	vvmov1.vi.to.w	%vr1,7,%r15             ; @0x712
	vvmov1.vi.to.w	%vr2,7,%r3              ; @0x718
	vvmpy.w	%vr1, %vr2, %vr1                ; @0x71e
	vvadd.w	%vr0, %vr1, %vr0                ; @0x724
.LZD1:                                  ; @0x72a
	; ZD Loop End                           ; @0x72a
;  %bb.14:                              ; %vec.epilog.middle.block
.vvsbundle  " v3" 
 ;	 { 
	vvmov.w	 %vr2, 0                        ; @0x72a
	vvpinit.w	%p1, 0, 65520           ; @0x72a
	vvci.w	%vr1                            ; @0x72a
 ;	 }
	vvpinit.w	%p2, 0, 15              ; @0x738
.vvsbundle  " v3" 
 ;	 { 
	vvadd.w	%vr1, %vr1, 2                   ; @0x73e
	vvpinit.w	%p3, 0, 65532           ; @0x73e
	vvadd.w	%vr3, %vr1, 4                   ; @0x73e
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvpinit.w	%p4, 0, 3               ; @0x74c
	vvsel.w.p1	%vr3, %vr2, %vr3        ; @0x74c
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvsel.w.p3	%vr1, %vr2, %vr1        ; @0x758
	vvshfl.w.p2	%vr3, %vr0, %vr3        ; @0x758
 ;	 }
	vvadd.w	%vr0, %vr0, %vr3                ; @0x762
	vvshfl.w.p4	%vr1, %vr0, %vr1        ; @0x766
	vvadd.w	%vr0, %vr0, %vr1                ; @0x76c
	vvmov1.from.w	%r0,%vr0,1              ; @0x770
	vvadd.w	%vr0, %vr0, %r0                 ; @0x776
	vvmov1.x.from.w	%r0,%vr0,0              ; @0x77a
	brne_s	%r1,0,.LBB0_15                  ; @0x780
	b_s	.LBB0_17                        ; @0x782
.LBB0_18:                               ; @0x784
	ld	%r24,[%sp,108]                  ; 4-byte Folded Reload
                                        ; @0x784
	ld	%r11,[%sp,104]                  ; 4-byte Folded Reload
                                        ; @0x788
	add	%r59,%r59,%r2                   ; @0x78c
.LBB0_15:                               ; %vec.epilog.scalar.ph.preheader
                                        ; @0x790
	add	%r1,%r59,1                      ; @0x790
	max	%r1,%r58,%r1                    ; @0x794
	add2	%r11,%r11,%r59                  ; @0x798
	add2	%r24,%r24,%r59                  ; @0x79c
	sub	%lp_count,%r1,%r59              ; @0x7a0
	; Implicit def %r1                      ; @0x7a4
	mov	%r58,%r0                        ; @0x7a4
	lp	.LZD0                           ; @0x7a8
.LBB0_16:                               ; %vec.epilog.scalar.ph
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x7ac
	ld.ab	%r0,[%r11,4]                    ; @0x7ac
	ld.ab	%r1,[%r24,4]                    ; @0x7b0
	mac	%r0,%r1,%r0                     ; @0x7b4
.LZD0:                                  ; @0x7b8
	; ZD Loop End                           ; @0x7b8
.LBB0_17:                               ; %._crit_edge7
                                        ; @0x7b8
	ld	%blink,[%sp,52]                 ; @0x7b8
	.cfa_restore	{%blink}                ; @0x7bc
	ld	%fp,[%sp,48]                    ; @0x7bc
	.cfa_restore	{%fp}                   ; @0x7c0
	ld	%r24,[%sp,44]                   ; @0x7c0
	.cfa_restore	{%r24}                  ; @0x7c4
	ldd	%r22,[%sp,36]                   ; @0x7c4
	.cfa_restore	{%r23}                  ; @0x7c8
	.cfa_restore	{%r22}                  ; @0x7c8
	ldd	%r20,[%sp,28]                   ; @0x7c8
	.cfa_restore	{%r21}                  ; @0x7cc
	.cfa_restore	{%r20}                  ; @0x7cc
	ldd	%r18,[%sp,20]                   ; @0x7cc
	.cfa_restore	{%r19}                  ; @0x7d0
	.cfa_restore	{%r18}                  ; @0x7d0
	ldd	%r16,[%sp,12]                   ; @0x7d0
	.cfa_restore	{%r17}                  ; @0x7d4
	.cfa_restore	{%r16}                  ; @0x7d4
	ldd	%r14,[%sp,4]                    ; @0x7d4
	.cfa_restore	{%r15}                  ; @0x7d8
	.cfa_restore	{%r14}                  ; @0x7d8
	ld_s	%r13,[%sp,0]                    ; @0x7d8
	.cfa_restore	{%r13}                  ; @0x7da
	add	%sp,%sp,256                     ; @0x7da
	.cfa_pop	256                             ; @0x7de
	j_s	[%blink]                        ; @0x7de
	.cfa_ef
.Lfunc_end0:                            ; @0x7e0

	.reloc	_init_ad,0	;startup code to enable %status AD bit ; -- End function
