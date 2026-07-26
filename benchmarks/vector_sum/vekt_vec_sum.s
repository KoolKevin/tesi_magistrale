	.option	%reg
	.off	assume_short
	.file	"LLVMDialectModule"
	.globl	vekt_vec_sum
	.type	vekt_vec_sum,@function
	.size	vekt_vec_sum, .Lfunc_end0-vekt_vec_sum
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
	.align	8                               ; -- Begin function vekt_vec_sum
vekt_vec_sum:                           ; @vekt_vec_sum
                                        ; @0x0
	.cfa_bf	vekt_vec_sum
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
	mov	%r58,%r3                        ; @0x24
	mov_s	%r13,%r1                        ; @0x28
	not	%r0,%r58                        ; @0x2a
	mov	%r1,%r58                        ; @0x2e
	cmp	%r58,0                          ; @0x32
	mov.lt	%r1,%r0                         ; @0x36
	asr	%r0,%r1,31                      ; @0x3a
	lsr_s	%r0,%r0,28                      ; @0x3e
	add_s	%r0,%r1,%r0                     ; @0x40
	asr_s	%r0,%r0,4                       ; @0x42
	ld	%r11,[%sp,268]                  ; @0x44
	not_s	%r1,%r0                         ; @0x48
	mov.lt	%r0,%r1                         ; @0x4a
	asl	%r59,%r0,4                      ; @0x4e
	mov_s	%fp,%r6                         ; @0x52
	brlt	%r0,1,.LBB0_3                   ; @0x54
;  %bb.1:                               ; %.lr.ph.preheader
	; Implicit def %r8                      ; @0x58
	max	%r1,%r59,16                     ; @0x58
	add_s	%r1,%r1,-1                      ; @0x5c
	lsr_s	%r1,%r1,4                       ; @0x5e
	add	%lp_count,%r1,1                 ; @0x60
	mov_s	%r1,%r13                        ; @0x64
	mov_s	%r2,%fp                         ; @0x66
	mov_s	%r3,%r11                        ; @0x68
	lp	.LZD3                           ; @0x6a
.LBB0_2:                                ; %.lr.ph
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x6e
	vvld.av.w	%vr0,%r2,1              ; @0x6e
	vvld.av.w	%vr1,%r1,1              ; @0x74
	vvadd.w	%vr0, %vr1, %vr0                ; @0x7a
	vvst.av.w	%vr0,%r3,1              ; @0x80
.LZD3:                                  ; @0x86
	; ZD Loop End                           ; @0x86
.LBB0_3:                                ; %._crit_edge
                                        ; @0x86
	brge	%r59,%r58,.LBB0_18              ; @0x86
;  %bb.4:                               ; %iter.check
	sub	%r24,%r58,%r59                  ; @0x8a
	brhs	%r24,8,.LBB0_5                  ; @0x8e
.LBB0_16:                               ; %vec.epilog.scalar.ph.preheader
                                        ; @0x92
	; Implicit def %r1                      ; @0x92
	add	%r0,%r59,1                      ; @0x92
	max	%r0,%r58,%r0                    ; @0x96
	add2	%r13,%r13,%r59                  ; @0x9a
	add2	%fp,%fp,%r59                    ; @0x9e
	add2	%r11,%r11,%r59                  ; @0xa2
	sub	%lp_count,%r0,%r59              ; @0xa6
	lp	.LZD0                           ; @0xaa
.LBB0_17:                               ; %vec.epilog.scalar.ph
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0xae
	ld.ab	%r0,[%r13,4]                    ; @0xae
	ld.ab	%r1,[%fp,4]                     ; @0xb2
	add_s	%r0,%r1,%r0                     ; @0xb6
	st.ab	%r0,[%r11,4]                    ; @0xb8
.LZD0:                                  ; @0xbc
	; ZD Loop End                           ; @0xbc
.LBB0_18:                               ; %._crit_edge5
                                        ; @0xbc
	.cfa_remember_state                     ; @0xbc
	ld	%blink,[%sp,52]                 ; @0xbc
	.cfa_restore	{%blink}                ; @0xc0
	ld	%fp,[%sp,48]                    ; @0xc0
	.cfa_restore	{%fp}                   ; @0xc4
	ld	%r24,[%sp,44]                   ; @0xc4
	.cfa_restore	{%r24}                  ; @0xc8
	ldd	%r22,[%sp,36]                   ; @0xc8
	.cfa_restore	{%r23}                  ; @0xcc
	.cfa_restore	{%r22}                  ; @0xcc
	ldd	%r20,[%sp,28]                   ; @0xcc
	.cfa_restore	{%r21}                  ; @0xd0
	.cfa_restore	{%r20}                  ; @0xd0
	ldd	%r18,[%sp,20]                   ; @0xd0
	.cfa_restore	{%r19}                  ; @0xd4
	.cfa_restore	{%r18}                  ; @0xd4
	ldd	%r16,[%sp,12]                   ; @0xd4
	.cfa_restore	{%r17}                  ; @0xd8
	.cfa_restore	{%r16}                  ; @0xd8
	ldd	%r14,[%sp,4]                    ; @0xd8
	.cfa_restore	{%r15}                  ; @0xdc
	.cfa_restore	{%r14}                  ; @0xdc
	ld_s	%r13,[%sp,0]                    ; @0xdc
	.cfa_restore	{%r13}                  ; @0xde
	add	%sp,%sp,256                     ; @0xde
	.cfa_pop	256                             ; @0xe2
	j_s	[%blink]                        ; @0xe2
	.cfa_restore_state                      ; @0xe4
.LBB0_5:                                ; %vector.memcheck
                                        ; @0xe4
	asl_s	%r0,%r0,6                       ; @0xe4
	add2	%r3,%r11,%r58                   ; @0xe6
	add_s	%r1,%r13,%r0                    ; @0xea
	add	%r15,%r11,%r0                   ; @0xec
	add2	%r2,%r13,%r58                   ; @0xf0
	setlo	%r12,%r1,%r3                    ; @0xf4
	setlo	%r2,%r15,%r2                    ; @0xf8
	tst_s	%r2,%r12                        ; @0xfc
	bne_s	.LBB0_16                        ; @0xfe
;  %bb.6:                               ; %vector.memcheck
	add	%r2,%fp,%r0                     ; @0x100
	add2	%r12,%fp,%r58                   ; @0x104
	setlo	%r3,%r2,%r3                     ; @0x108
	setlo	%r12,%r15,%r12                  ; @0x10c
	tst_s	%r12,%r3                        ; @0x110
	bne_s	.LBB0_16                        ; @0x112
;  %bb.7:                               ; %vector.main.loop.iter.check
	cmp	%r24,64                         ; @0x114
	mov_s	%r3,0                           ; @0x118
	bcs	.LBB0_13                        ; @0x11a
;  %bb.8:                               ; %vector.ph
	sub3	%r3,%r24,64/8                   ; @0x11e
	st	%r0,[%sp,136]                   ; 4-byte Folded Spill
                                        ; @0x122
	bmskn	%r0,%r24,5                      ; @0x126
	lsr_s	%r3,%r3,6                       ; @0x12a
	add2	%r12,%r1,192/4                  ; @0x12c
	add2	%r1,%r2,192/4                   ; @0x130
	st	%r0,[%sp,140]                   ; 4-byte Folded Spill
                                        ; @0x134
	add	%lp_count,%r3,1                 ; @0x138
	; Implicit def %r3                      ; @0x13c
	add_s	%r0,%r15,56                     ; @0x13c
	lp	.LZD2                           ; @0x13e
.LBB0_9:                                ; %vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x142
	ldd	%r2,[%r12,-192]                 ; @0x142
	ldd	%r4,[%r1,-192]                  ; @0x146
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,0,%r2              ; @0x14a
	ldd	%r6,[%r12,-184]                 ; @0x14a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,0,%r4              ; @0x154
	ldd	%r8,[%r1,-184]                  ; @0x154
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,1,%r3              ; @0x15e
	ldd	%r2,[%r12,-176]                 ; @0x15e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,1,%r5              ; @0x168
	ldd	%r4,[%r1,-176]                  ; @0x168
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,2,%r6              ; @0x172
	ldd	%r30,[%r12,-168]                ; @0x172
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,2,%r8              ; @0x17c
	ldd	%r14,[%r1,-168]                 ; @0x17c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,3,%r7              ; @0x186
	ldd	%r20,[%r12,-128]                ; @0x186
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,3,%r9              ; @0x190
	ldd	%r22,[%r1,-128]                 ; @0x190
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,4,%r2              ; @0x19a
	ldd	%r6,[%r12,-160]                 ; @0x19a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,4,%r4              ; @0x1a4
	ldd	%r8,[%r1,-160]                  ; @0x1a4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,5,%r3              ; @0x1ae
	ldd	%r2,[%r12,-120]                 ; @0x1ae
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,5,%r5              ; @0x1b8
	ldd	%r4,[%r1,-120]                  ; @0x1b8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,6,%r30             ; @0x1c2
	ldd	%r16,[%r12,-152]                ; @0x1c2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,6,%r14             ; @0x1cc
	ldd	%r18,[%r1,-152]                 ; @0x1cc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,7,%blink           ; @0x1d6
	ldd	%r30,[%r12,-112]                ; @0x1d6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,7,%r15             ; @0x1e0
	ldd	%r14,[%r1,-112]                 ; @0x1e0
 ;	 }
	vvmov1.vi.to.w	%vr0,0,%r20             ; @0x1ea
	std	%r14,[%sp,104]                  ; 8-byte Folded Spill
                                        ; @0x1f0
	ldd	%r14,[%r12,-144]                ; @0x1f4
	vvmov1.vi.to.w	%vr1,0,%r22             ; @0x1f8
	std	%r14,[%sp,80]                   ; 8-byte Folded Spill
                                        ; @0x1fe
	ldd	%r14,[%r1,-144]                 ; @0x202
	vvmov1.vi.to.w	%vr2,8,%r6              ; @0x206
	std	%r14,[%sp,88]                   ; 8-byte Folded Spill
                                        ; @0x20c
	ldd	%r14,[%r12,-104]                ; @0x210
	vvmov1.vi.to.w	%vr3,8,%r8              ; @0x214
	std	%r14,[%sp,96]                   ; 8-byte Folded Spill
                                        ; @0x21a
	ldd	%r14,[%r1,-104]                 ; @0x21e
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,1,%r21             ; @0x222
	ldd	%r20,[%r12,-136]                ; @0x222
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,1,%r23             ; @0x22c
	ldd	%r22,[%r1,-136]                 ; @0x22c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,9,%r7              ; @0x236
	ldd	%r6,[%r12,-64]                  ; @0x236
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,9,%r9              ; @0x240
	ldd	%r8,[%r1,-64]                   ; @0x240
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,2,%r2              ; 8-byte Folded Spill
                                        ; @0x24a
	std	%r14,[%sp,120]                  ; @0x24a
 ;	 }
	std	%r8,[%sp,144]                   ; 8-byte Folded Spill
                                        ; @0x254
	ldd	%r8,[%r12,-96]                  ; @0x258
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,3,%r3              ; @0x25c
	ldd	%r2,[%r1,-96]                   ; @0x25c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,2,%r4              ; 8-byte Folded Spill
                                        ; @0x266
	std	%r8,[%sp,152]                   ; @0x266
 ;	 }
	std	%r2,[%sp,160]                   ; 8-byte Folded Spill
                                        ; @0x270
	ldd	%r2,[%r12,-56]                  ; @0x274
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,3,%r5              ; @0x278
	ldd	%r8,[%r1,-56]                   ; @0x278
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,10,%r16            ; 8-byte Folded Spill
                                        ; @0x282
	std	%r2,[%sp,56]                    ; @0x282
 ;	 }
	ldd	%r2,[%r12,-88]                  ; @0x28c
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,11,%r17            ; @0x290
	ldd	%r16,[%r1,-88]                  ; @0x290
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,10,%r18            ; 8-byte Folded Spill
                                        ; @0x29a
	std	%r2,[%sp,64]                    ; @0x29a
 ;	 }
	ldd	%r2,[%r12,-48]                  ; @0x2a4
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,11,%r19            ; 8-byte Folded Reload
                                        ; @0x2a8
	ldd	%r4,[%sp,104]                   ; @0x2a8
 ;	 }
	std	%r2,[%sp,72]                    ; 8-byte Folded Spill
                                        ; @0x2b2
	ldd	%r2,[%r1,-48]                   ; @0x2b6
	vvmov1.vi.to.w	%vr0,4,%r30             ; @0x2ba
	std	%r2,[%sp,128]                   ; 8-byte Folded Spill
                                        ; @0x2c0
	ldd	%r2,[%r12,-80]                  ; @0x2c4
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,5,%blink           ; 8-byte Folded Reload
                                        ; @0x2c8
	ldd	%r30,[%sp,72]                   ; @0x2c8
 ;	 }
	std	%r2,[%sp,112]                   ; 8-byte Folded Spill
                                        ; @0x2d2
	ldd	%r2,[%r1,-80]                   ; @0x2d6
	vvmov1.vi.to.w	%vr1,4,%r4              ; @0x2da
	std	%r2,[%sp,200]                   ; 8-byte Folded Spill
                                        ; @0x2e0
	ldd	%r2,[%r12,-40]                  ; @0x2e4
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,5,%r5              ; 8-byte Folded Reload
                                        ; @0x2e8
	ldd	%r4,[%sp,80]                    ; @0x2e8
 ;	 }
	std	%r2,[%sp,208]                   ; 8-byte Folded Spill
                                        ; @0x2f2
	ldd	%r2,[%r1,-40]                   ; @0x2f6
	vvmov1.vi.to.w	%vr2,12,%r4             ; @0x2fa
	std	%r2,[%sp,192]                   ; 8-byte Folded Spill
                                        ; @0x300
	ldd	%r2,[%r12,-72]                  ; @0x304
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,13,%r5             ; 8-byte Folded Reload
                                        ; @0x308
	ldd	%r4,[%sp,96]                    ; @0x308
 ;	 }
	std	%r2,[%sp,176]                   ; 8-byte Folded Spill
                                        ; @0x312
	ldd	%r2,[%r1,-72]                   ; @0x316
	ldd	%r14,[%r12,0]                   ; @0x31a
	std	%r2,[%sp,168]                   ; 8-byte Folded Spill
                                        ; @0x31e
	ldd	%r2,[%sp,88]                    ; 8-byte Folded Reload
                                        ; @0x322
	vvmov1.vi.to.w	%vr3,12,%r2             ; @0x326
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,13,%r3             ; @0x32c
	ldd	%r2,[%r1,0]                     ; @0x32c
 ;	 }
	vvmov1.vi.to.w	%vr0,6,%r4              ; @0x336
	std	%r2,[%sp,184]                   ; 8-byte Folded Spill
                                        ; @0x33c
	ldd	%r2,[%r12,-32]                  ; @0x340
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,7,%r5              ; 8-byte Folded Reload
                                        ; @0x344
	ldd	%r4,[%sp,120]                   ; @0x344
 ;	 }
	std	%r2,[%sp,216]                   ; 8-byte Folded Spill
                                        ; @0x34e
	ldd	%r2,[%r1,-32]                   ; @0x352
	vvmov1.vi.to.w	%vr1,6,%r4              ; @0x356
	std	%r2,[%sp,224]                   ; 8-byte Folded Spill
                                        ; @0x35c
	ldd	%r2,[%r12,8]                    ; @0x360
	vvmov1.vi.to.w	%vr1,7,%r5              ; @0x364
	std	%r2,[%sp,104]                   ; 8-byte Folded Spill
                                        ; @0x36a
	ldd	%r2,[%r1,8]                     ; @0x36e
	vvmov1.vi.to.w	%vr2,14,%r20            ; @0x372
	std	%r2,[%sp,96]                    ; 8-byte Folded Spill
                                        ; @0x378
	ldd	%r2,[%r12,-24]                  ; @0x37c
	vvmov1.vi.to.w	%vr2,15,%r21            ; @0x380
	std	%r2,[%sp,88]                    ; 8-byte Folded Spill
                                        ; @0x386
	ldd	%r2,[%r1,-24]                   ; @0x38a
	vvmov1.vi.to.w	%vr3,14,%r22            ; @0x38e
	std	%r2,[%sp,248]                   ; 8-byte Folded Spill
                                        ; @0x394
	ldd	%r2,[%r12,16]                   ; @0x398
	vvmov1.vi.to.w	%vr3,15,%r23            ; @0x39c
	std	%r2,[%sp,240]                   ; 8-byte Folded Spill
                                        ; @0x3a2
	ldd	%r2,[%r1,16]                    ; @0x3a6
.vvsbundle  " v2" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,0,%r6              ; @0x3aa
	vvadd.w	%vr4, %vr3, %vr2                ; @0x3aa
 ;	 }
	std	%r2,[%sp,120]                   ; 8-byte Folded Spill
                                        ; @0x3b4
	ldd	%r2,[%r12,-16]                  ; @0x3b8
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,1,%r7              ; 8-byte Folded Reload
                                        ; @0x3bc
	ldd	%r6,[%sp,144]                   ; @0x3bc
 ;	 }
	ldd	%r4,[%r1,-16]                   ; @0x3c6
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r2,%vr4,14             ; 8-byte Folded Spill
                                        ; @0x3ca
	std	%r2,[%sp,80]                    ; @0x3ca
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov2.x.from.w	%r4,%vr4,12             ; 8-byte Folded Spill
                                        ; @0x3d4
	vvmov1.vi.to.w	%vr3,0,%r6              ; @0x3d4
	std	%r4,[%sp,232]                   ; @0x3d4
 ;	 }
	ldd	%r22,[%r12,24]                  ; @0x3e2
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,1,%r7              ; 8-byte Folded Reload
                                        ; @0x3e6
	ldd	%r6,[%sp,152]                   ; @0x3e6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r2,%vr4,10             ; @0x3f0
	std.ab	%r2,[%r0,-8]                    ; @0x3f0
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov2.x.from.w	%r4,%vr4,8              ; @0x3fa
	vvmov1.vi.to.w	%vr0,8,%r6              ; @0x3fa
	std.ab	%r4,[%r0,-8]                    ; @0x3fa
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,9,%r7              ; 8-byte Folded Reload
                                        ; @0x408
	ldd	%r6,[%sp,160]                   ; @0x408
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r2,%vr4,6              ; @0x412
	std.ab	%r2,[%r0,-8]                    ; @0x412
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov2.x.from.w	%r4,%vr4,4              ; @0x41c
	vvmov1.vi.to.w	%vr1,8,%r6              ; @0x41c
	std.ab	%r4,[%r0,-8]                    ; @0x41c
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov2.x.from.w	%r2,%vr4,2              ; @0x42a
	vvmov1.vi.to.w	%vr1,9,%r7              ; @0x42a
	std.ab	%r2,[%r0,-8]                    ; @0x42a
 ;	 }
	ldd	%r6,[%sp,56]                    ; 8-byte Folded Reload
                                        ; @0x438
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r4,%vr4,0              ; @0x43c
	std.ab	%r4,[%r0,-8]                    ; @0x43c
 ;	 }
	vvmov1.vi.to.w	%vr2,2,%r6              ; @0x446
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,3,%r7              ; @0x44c
	std.ab	%r2,[%r0,-8]                    ; @0x44c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,2,%r8              ; 8-byte Folded Reload
                                        ; @0x456
	ldd	%r2,[%sp,64]                    ; @0x456
 ;	 }
	std.ab	%r4,[%r0,120]                   ; @0x460
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,3,%r9              ; @0x464
	ldd	%r8,[%r1,24]                    ; @0x464
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,10,%r2             ; @0x46e
	ldd	%r6,[%r12,-8]                   ; @0x46e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,11,%r3             ; @0x478
	ldd	%r4,[%r1,-8]                    ; @0x478
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,10,%r16            ; @0x482
	mov_s	%r3,%r17                        ; @0x482
 ;	 }
	ldd	%r16,[%r12,32]                  ; @0x48a
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,11,%r3             ; @0x48e
	ldd	%r18,[%r1,32]                   ; @0x48e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,4,%r30             ; @0x498
	ldd	%r2,[%r12,40]                   ; @0x498
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,5,%blink           ; 8-byte Folded Reload
                                        ; @0x4a2
	ldd	%r30,[%sp,128]                  ; @0x4a2
 ;	 }
	std	%r2,[%sp,56]                    ; 8-byte Folded Spill
                                        ; @0x4ac
	ldd	%r2,[%r1,40]                    ; @0x4b0
	vvmov1.vi.to.w	%vr3,4,%r30             ; @0x4b4
	std	%r2,[%sp,64]                    ; 8-byte Folded Spill
                                        ; @0x4ba
	ldd	%r2,[%r12,48]                   ; @0x4be
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,5,%blink           ; @0x4c2
	ldd	%r30,[%r1,48]                   ; @0x4c2
 ;	 }
	std	%r2,[%sp,72]                    ; 8-byte Folded Spill
                                        ; @0x4cc
	ldd	%r2,[%sp,112]                   ; 8-byte Folded Reload
                                        ; @0x4d0
	ldd	%r20,[%r12,56]                  ; @0x4d4
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,12,%r2             ; 8-byte Folded Spill
                                        ; @0x4d8
	std	%r30,[%sp,128]                  ; @0x4d8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,13,%r3             ; @0x4e2
	ldd	%r2,[%r1,56]                    ; @0x4e2
 ;	 }
	add3	%r12,%r12,256/8                 ; @0x4ec
	std	%r2,[%sp,112]                   ; 8-byte Folded Spill
                                        ; @0x4f0
	ldd	%r2,[%sp,200]                   ; 8-byte Folded Reload
                                        ; @0x4f4
	vvmov1.vi.to.w	%vr1,12,%r2             ; @0x4f8
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,13,%r3             ; 8-byte Folded Reload
                                        ; @0x4fe
	ldd	%r2,[%sp,208]                   ; @0x4fe
 ;	 }
	add3	%r1,%r1,256/8                   ; @0x508
	vvmov1.vi.to.w	%vr2,6,%r2              ; @0x50c
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,7,%r3              ; 8-byte Folded Reload
                                        ; @0x512
	ldd	%r2,[%sp,192]                   ; @0x512
 ;	 }
	vvmov1.vi.to.w	%vr3,6,%r2              ; @0x51c
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,7,%r3              ; 8-byte Folded Reload
                                        ; @0x522
	ldd	%r2,[%sp,176]                   ; @0x522
 ;	 }
	vvmov1.vi.to.w	%vr0,14,%r2             ; @0x52c
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,15,%r3             ; 8-byte Folded Reload
                                        ; @0x532
	ldd	%r2,[%sp,168]                   ; @0x532
 ;	 }
	vvmov1.vi.to.w	%vr1,14,%r2             ; @0x53c
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,15,%r3             ; 8-byte Folded Reload
                                        ; @0x542
	ldd	%r2,[%sp,184]                   ; @0x542
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,0,%r14             ; @0x54c
	vvadd.w	%vr4, %vr1, %vr0                ; @0x54c
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvmov2.x.from.w	%r30,%vr4,14            ; @0x556
	vvmov1.vi.to.w	%vr0,1,%r15             ; @0x556
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvmov2.x.from.w	%r14,%vr4,12            ; @0x560
	vvmov1.vi.to.w	%vr1,0,%r2              ; @0x560
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,1,%r3              ; 8-byte Folded Reload
                                        ; @0x56a
	ldd	%r2,[%sp,216]                   ; @0x56a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r30,%vr4,10            ; @0x574
	std.ab	%r30,[%r0,-8]                   ; @0x574
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov2.x.from.w	%r14,%vr4,8             ; @0x57e
	vvmov1.vi.to.w	%vr2,8,%r2              ; @0x57e
	std.ab	%r14,[%r0,-8]                   ; @0x57e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,9,%r3              ; 8-byte Folded Reload
                                        ; @0x58c
	ldd	%r2,[%sp,224]                   ; @0x58c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r30,%vr4,6             ; @0x596
	std.ab	%r30,[%r0,-8]                   ; @0x596
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov2.x.from.w	%r14,%vr4,4             ; @0x5a0
	vvmov1.vi.to.w	%vr3,8,%r2              ; @0x5a0
	std.ab	%r14,[%r0,-8]                   ; @0x5a0
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov2.x.from.w	%r30,%vr4,2             ; @0x5ae
	vvmov1.vi.to.w	%vr3,9,%r3              ; @0x5ae
	std.ab	%r30,[%r0,-8]                   ; @0x5ae
 ;	 }
	ldd	%r2,[%sp,104]                   ; 8-byte Folded Reload
                                        ; @0x5bc
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r14,%vr4,0             ; @0x5c0
	std.ab	%r14,[%r0,-8]                   ; @0x5c0
 ;	 }
	vvmov1.vi.to.w	%vr0,2,%r2              ; @0x5ca
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,3,%r3              ; @0x5d0
	std.ab	%r30,[%r0,-8]                   ; @0x5d0
 ;	 }
	ldd	%r30,[%sp,96]                   ; 8-byte Folded Reload
                                        ; @0x5da
	ldd	%r2,[%sp,248]                   ; 8-byte Folded Reload
                                        ; @0x5de
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,2,%r30             ; @0x5e2
	std.ab	%r14,[%r0,120]                  ; @0x5e2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,3,%blink           ; 8-byte Folded Reload
                                        ; @0x5ec
	ldd	%r30,[%sp,88]                   ; @0x5ec
 ;	 }
	vvmov1.vi.to.w	%vr3,10,%r2             ; @0x5f6
	vvmov1.vi.to.w	%vr2,10,%r30            ; @0x5fc
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,11,%r3             ; 8-byte Folded Reload
                                        ; @0x602
	ldd	%r2,[%sp,80]                    ; @0x602
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,11,%blink          ; 8-byte Folded Reload
                                        ; @0x60c
	ldd	%r30,[%sp,240]                  ; @0x60c
 ;	 }
	vvmov1.vi.to.w	%vr2,12,%r2             ; @0x616
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,13,%r3             ; 8-byte Folded Reload
                                        ; @0x61c
	ldd	%r2,[%sp,232]                   ; @0x61c
 ;	 }
	vvmov1.vi.to.w	%vr0,4,%r30             ; @0x626
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,5,%blink           ; 8-byte Folded Reload
                                        ; @0x62c
	ldd	%r30,[%sp,120]                  ; @0x62c
 ;	 }
	vvmov1.vi.to.w	%vr3,12,%r2             ; @0x636
	vvmov1.vi.to.w	%vr3,13,%r3             ; @0x63c
	vvmov1.vi.to.w	%vr1,4,%r30             ; @0x642
	vvmov1.vi.to.w	%vr2,14,%r6             ; @0x648
	vvmov1.vi.to.w	%vr3,14,%r4             ; @0x64e
	vvmov1.vi.to.w	%vr1,5,%blink           ; @0x654
	vvmov1.vi.to.w	%vr0,6,%r22             ; @0x65a
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,15,%r7             ; 8-byte Folded Reload
                                        ; @0x660
	ldd	%r6,[%sp,64]                    ; @0x660
 ;	 }
	vvmov1.vi.to.w	%vr3,15,%r5             ; @0x66a
.vvsbundle  " v2" 
 ;	 { 
	vvadd.w	%vr2, %vr3, %vr2                ; @0x670
	vvmov1.vi.to.w	%vr1,6,%r8              ; @0x670
 ;	 }
	vvmov1.vi.to.w	%vr0,7,%r23             ; @0x67a
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,7,%r9              ; 8-byte Folded Reload
                                        ; @0x680
	ldd	%r8,[%sp,56]                    ; @0x680
 ;	 }
	vvmov1.vi.to.w	%vr0,8,%r16             ; @0x68a
.vvsbundle  " v2" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,8,%r18             ; @0x690
	vvmov2.x.from.w	%r2,%vr2,14             ; @0x690
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,9,%r17             ; @0x69a
	vvmov2.x.from.w	%r4,%vr2,12             ; @0x69a
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,9,%r19             ; @0x6a4
	vvmov2.x.from.w	%r2,%vr2,10             ; @0x6a4
	std.ab	%r2,[%r0,-8]                    ; @0x6a4
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,10,%r8             ; @0x6b2
	vvmov2.x.from.w	%r4,%vr2,8              ; @0x6b2
	std.ab	%r4,[%r0,-8]                    ; @0x6b2
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,10,%r6             ; @0x6c0
	vvmov2.x.from.w	%r2,%vr2,6              ; @0x6c0
	std.ab	%r2,[%r0,-8]                    ; @0x6c0
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,11,%r9             ; @0x6ce
	vvmov2.x.from.w	%r4,%vr2,4              ; @0x6ce
	std.ab	%r4,[%r0,-8]                    ; @0x6ce
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov2.x.from.w	%r2,%vr2,2              ; @0x6dc
	vvmov1.vi.to.w	%vr1,11,%r7             ; @0x6dc
	std.ab	%r2,[%r0,-8]                    ; @0x6dc
 ;	 }
	ldd	%r6,[%sp,72]                    ; 8-byte Folded Reload
                                        ; @0x6ea
	ldd	%r8,[%sp,128]                   ; 8-byte Folded Reload
                                        ; @0x6ee
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov2.x.from.w	%r4,%vr2,0              ; @0x6f2
	vvmov1.vi.to.w	%vr0,12,%r6             ; @0x6f2
	std.ab	%r4,[%r0,-8]                    ; @0x6f2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,12,%r8             ; @0x700
	std.ab	%r2,[%r0,-8]                    ; @0x700
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,13,%r7             ; 8-byte Folded Reload
                                        ; @0x70a
	ldd	%r2,[%sp,112]                   ; @0x70a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,13,%r9             ; @0x714
	std.ab	%r4,[%r0,120]                   ; @0x714
 ;	 }
	vvmov1.vi.to.w	%vr0,14,%r20            ; @0x71e
	vvmov1.vi.to.w	%vr1,14,%r2             ; @0x724
	vvmov1.vi.to.w	%vr0,15,%r21            ; @0x72a
	vvmov1.vi.to.w	%vr1,15,%r3             ; @0x730
	vvadd.w	%vr0, %vr1, %vr0                ; @0x736
	vvmov2.x.from.w	%r2,%vr0,14             ; @0x73c
	vvmov2.x.from.w	%r4,%vr0,12             ; @0x742
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r2,%vr0,10             ; @0x748
	std.ab	%r2,[%r0,-8]                    ; @0x748
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r4,%vr0,8              ; @0x752
	std.ab	%r4,[%r0,-8]                    ; @0x752
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r2,%vr0,6              ; @0x75c
	std.ab	%r2,[%r0,-8]                    ; @0x75c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r4,%vr0,4              ; @0x766
	std.ab	%r4,[%r0,-8]                    ; @0x766
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r2,%vr0,2              ; @0x770
	std.ab	%r2,[%r0,-8]                    ; @0x770
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r6,%vr0,0              ; @0x77a
	std.ab	%r4,[%r0,-8]                    ; @0x77a
 ;	 }
	std.ab	%r2,[%r0,-8]                    ; @0x784
	std.ab	%r6,[%r0,120]                   ; @0x788
.LZD2:                                  ; @0x78c
	; ZD Loop End                           ; @0x78c
;  %bb.10:                              ; %middle.block
	ld	%r3,[%sp,140]                   ; 4-byte Folded Reload
                                        ; @0x78c
	cmp	%r24,%r3                        ; @0x790
	beq	.LBB0_18                        ; @0x794
;  %bb.11:                              ; %vec.epilog.iter.check
	tst	%r24,56                         ; @0x798
	add.eq	%r59,%r59,%r3                   ; @0x79c
	beq	.LBB0_16                        ; Predicate Case 2
                                        ; @0x7a0
;  %bb.12:                              ; Predicate Case 2
	ld	%r0,[%sp,136]                   ; 4-byte Folded Reload
                                        ; @0x7a4
.LBB0_13:                               ; %vec.epilog.ph
                                        ; @0x7a8
	bmsk	%r5,%r58,2                      ; @0x7a8
	add	%r1,%r3,%r5                     ; @0x7ac
	add	%r1,%r1,%r59                    ; @0x7b0
	sub	%r1,%r58,%r1                    ; @0x7b4
	sub_s	%r1,%r1,8                       ; @0x7b8
	add2_s	%r0,%r0,%r3                     ; @0x7ba
	; Implicit def %r3                      ; @0x7bc
	lsr_s	%r1,%r1,3                       ; @0x7bc
	sub	%r2,%r24,%r5                    ; @0x7be
	add	%lp_count,%r1,1                 ; @0x7c2
	add	%r1,%r11,%r0                    ; @0x7c6
	add	%r12,%fp,%r0                    ; @0x7ca
	add_s	%r0,%r13,%r0                    ; @0x7ce
	add	%r59,%r59,%r2                   ; @0x7d0
	lp	.LZD1                           ; @0x7d4
.LBB0_14:                               ; %vec.epilog.vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x7d8
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov.w	 %vr1, 0                        ; @0x7d8
	vvmov.w	 %vr0, 0                        ; @0x7d8
	ldd.ab	%r2,[%r0,32]                    ; @0x7d8
 ;	 }
	ldd.ab	%r6,[%r12,32]                   ; @0x7e4
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,0,%r2              ; @0x7e8
	ldd	%r8,[%r0,-24]                   ; @0x7e8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,0,%r6              ; @0x7f2
	ldd	%r30,[%r12,-24]                 ; @0x7f2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,1,%r3              ; @0x7fc
	ldd	%r14,[%r0,-16]                  ; @0x7fc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,1,%r7              ; @0x806
	ldd	%r6,[%r12,-16]                  ; @0x806
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,2,%r8              ; @0x810
	ldd	%r16,[%r0,-8]                   ; @0x810
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,2,%r30             ; @0x81a
	ldd	%r2,[%r12,-8]                   ; @0x81a
 ;	 }
	vvmov1.vi.to.w	%vr0,3,%r9              ; @0x824
	vvmov1.vi.to.w	%vr1,3,%blink           ; @0x82a
	vvmov1.vi.to.w	%vr0,4,%r14             ; @0x830
	vvmov1.vi.to.w	%vr1,4,%r6              ; @0x836
	vvmov1.vi.to.w	%vr0,5,%r15             ; @0x83c
	vvmov1.vi.to.w	%vr1,5,%r7              ; @0x842
	vvmov1.vi.to.w	%vr0,6,%r16             ; @0x848
	vvmov1.vi.to.w	%vr1,6,%r2              ; @0x84e
	vvmov1.vi.to.w	%vr0,7,%r17             ; @0x854
	vvmov1.vi.to.w	%vr1,7,%r3              ; @0x85a
	vvadd.w	%vr0, %vr1, %vr0                ; @0x860
	vvmov2.x.from.w	%r2,%vr0,6              ; @0x866
	vvmov2.x.from.w	%r6,%vr0,2              ; @0x86c
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r8,%vr0,4              ; @0x872
	std	%r2,[%r1,24]                    ; @0x872
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r2,%vr0,0              ; @0x87c
	std	%r6,[%r1,8]                     ; @0x87c
 ;	 }
	std	%r8,[%r1,16]                    ; @0x886
	std.ab	%r2,[%r1,32]                    ; @0x88a
.LZD1:                                  ; @0x88e
	; ZD Loop End                           ; @0x88e
;  %bb.15:                              ; %vec.epilog.middle.block
	cmp_s	%r5,0                           ; @0x88e
	bne	.LBB0_16                        ; @0x890
	b	.LBB0_18                        ; @0x894
	.cfa_ef
.Lfunc_end0:                            ; @0x898

	.reloc	_init_ad,0	;startup code to enable %status AD bit ; -- End function
