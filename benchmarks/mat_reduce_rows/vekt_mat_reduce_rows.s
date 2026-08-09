	.option	%reg
	.off	assume_short
	.file	"LLVMDialectModule"
	.globl	vekt_mat_reduce_rows
	.type	vekt_mat_reduce_rows,@function
	.size	vekt_mat_reduce_rows, .Lfunc_end0-vekt_mat_reduce_rows
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
	.ident	"LLVM 17.0.7/V-2024.06. (build 008) (LLVM 17.0.7) -arcv2hs -core4 -Xcode_density -Xatomic -Xll64 -Xunaligned -Xdiv_rem=radix4 -Xswap -Xbitscan -Xmpy_option=mpyd -Xshift_assist -Xbarrel_shifter -Xfpud_div -Xfpu_mac -Xtimer0 -Xrtc -Xstack_check -Xstu=4 -Xvdsp4 -Xvec_unit_rev_minor=1 -Xvec_width=512 -Xvec_mem_size=128k -Xvec_mem_bank_width=16 -Xvec_max_fetch_size=16 -Xvec_num_slots=3 -Xvec_super_with_scalar -Xvec_regs=32 -Xvec_fpu=32 -Xvec_fpu_math=3 -Xvec_fpu_2nd_mul -Xvec_fpu_types=2 -Xvec_num_rd_ports=6 -Xvec_num_acc=8 -Xvec_num_mpy=2 -Xvec_mpy32 -Xvec_num_alu=3 -Xvec_guard_bit_option=0 -Xvec_stack_check -Hvdsp_vector_c -O3 -fvectorize -fslp-vectorize -ffast-math"
	.align	8                               ; -- Begin function vekt_mat_reduce_rows
vekt_mat_reduce_rows:                   ; @vekt_mat_reduce_rows
                                        ; @0x0
	.cfa_bf	vekt_mat_reduce_rows
;  %bb.0:
	st.aw	%r13,[%sp,-168]                 ; @0x0
	.cfa_push	168                     ; @0x4
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
	not	%r0,%r6                         ; @0x24
	mov_s	%r1,%r6                         ; @0x28
	cmp_s	%r6,0                           ; @0x2a
	mov.lt	%r1,%r0                         ; @0x2c
	asr	%r0,%r1,31                      ; @0x30
	lsr_s	%r0,%r0,28                      ; @0x34
	add_s	%r0,%r1,%r0                     ; @0x36
	asr_s	%r15,%r0,4                      ; @0x38
	mov	%r58,%r5                        ; @0x3a
	not_s	%r0,%r15                        ; @0x3e
	mov.lt	%r15,%r0                        ; @0x40
	cmp	%r58,0                          ; @0x44
	ble	.LBB0_55                        ; @0x48
;  %bb.1:                               ; %.lr.ph11
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr16, 0                       ; @0x4c
	ld	%r17,[%sp,176]                  ; @0x4c
 ;	 }
	asl	%r16,%r15,4                     ; @0x54
.vvsbundle  "v1sc" 
 ;	 { 
	vvcadd.init.w	%vr16, %vr16, 0         ; @0x58
	mov_s	%r13,%r3                        ; @0x58
 ;	 }
	cmp	%r6,%r16                        ; @0x60
	ble	.LBB0_38                        ; @0x64
;  %bb.2:                               ; %.lr.ph11.split.us
	cmp_s	%r15,0                          ; @0x68
	st	%r17,[%sp,88]                   ; 4-byte Folded Spill
                                        ; @0x6a
	st	%r6,[%sp,84]                    ; 4-byte Folded Spill
                                        ; @0x6e
	st	%r13,[%sp,80]                   ; 4-byte Folded Spill
                                        ; @0x72
	st	%r7,[%sp,76]                    ; 4-byte Folded Spill
                                        ; @0x76
	st	%r16,[%sp,72]                   ; 4-byte Folded Spill
                                        ; @0x7a
	ble	.LBB0_21                        ; @0x7e
;  %bb.3:                               ; %.lr.ph11.split.us.split.us
.vvsbundle  "v2sc" 
 ;	 { 
	vvpinit.w	%p3, 0, 65532           ; @0x82
	vvci.w	%vr0                            ; @0x82
	sub	%r12,%r6,%r16                   ; @0x82
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov.w	 %vr1, 0                        ; @0x90
	vvpinit.w	%p4, 0, 65520           ; @0x90
	max	%r0,%r16,16                     ; @0x90
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvadd.w	%vr2, %vr0, 2                   ; @0x9e
	sub3	%r1,%r12,64/8                   ; @0x9e
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvpinit.w	%p1, 0, 15              ; @0xa8
	vvadd.w	%vr3, %vr0, 4                   ; @0xa8
	lsr_s	%r1,%r1,6                       ; @0xa8
 ;	 }
	add_s	%r1,%r1,1                       ; @0xb4
	add_s	%r0,%r0,-1                      ; @0xb6
.vvsbundle  "v2sc" 
 ;	 { 
	vvsel.w.p3	%vr0, %vr1, %vr2        ; 4-byte Folded Spill
                                        ; @0xb8
	vvpinit.w	%p2, 0, 3               ; @0xb8
	st	%r1,[%sp,92]                    ; @0xb8
 ;	 }
	bmskn	%r1,%r6,2                       ; @0xc8
	asl	%r11,%r15,6                     ; @0xcc
.vvsbundle  "v1sc" 
 ;	 { 
	vvsel.w.p4	%vr1, %vr1, %vr3        ; @0xd0
	bmskn	%r30,%r12,5                     ; @0xd0
 ;	 }
	lsr_s	%r0,%r0,4                       ; @0xda
	st	%r1,[%sp,108]                   ; 4-byte Folded Spill
                                        ; @0xdc
	sub	%r1,%r6,8                       ; @0xe0
	mov_s	%r24,%r16                       ; @0xe4
	mov_s	%fp,%r13                        ; @0xe6
	add	%r11,%r13,%r11                  ; @0xe8
	st	%r1,[%sp,104]                   ; 4-byte Folded Spill
                                        ; @0xec
	add	%r1,%r16,%r30                   ; @0xf0
	add	%blink,%r0,1                    ; @0xf4
	mov_s	%r15,0                          ; @0xf8
	mov	%r59,0                          ; @0xfa
	st	%r1,[%sp,164]                   ; 4-byte Folded Spill
                                        ; @0xfe
	st	%r12,[%sp,100]                  ; 4-byte Folded Spill
                                        ; @0x102
	st	%r30,[%sp,96]                   ; 4-byte Folded Spill
                                        ; @0x106
	st	%blink,[%sp,68]                 ; 4-byte Folded Spill
                                        ; @0x10a
.LBB0_5:                                ; %.lr.ph.us.us
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_6 Depth 2
                                        ;     Child Loop BB0_12 Depth 2
                                        ;     Child Loop BB0_17 Depth 2
                                        ;     Child Loop BB0_20 Depth 2
                                        ; @0x10e
	; Implicit def %r2                      ; @0x10e
.vvsbundle  "v1sc" 
 ;	 { 
	vvcmov.b	%vr17, %vr16                    ; @0x10e
	mov	%lp_count,%blink                ; @0x10e
 ;	 }
	mov_s	%r0,%fp                         ; @0x116
	lp	.LZD0                           ; @0x118
.LBB0_6:                                ;   Parent Loop BB0_5 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; Label of block must be emitted
                                        ; @0x11c AlignLabel LoopTop Freq=200
	vvld.av.w	%vr2,%r0,1              ; @0x11c
	vvadd.w	%vr17, %vr17, %vr2              ; @0x122
.LZD0:                                  ; @0x126
	; ZD Loop End                           ; @0x126
;  %bb.7:                               ; %iter.check103
                                        ;   in Loop: Header=BB0_5 Depth=1
.vvsbundle  "v1sc" 
 ;	 { 
	vvc2add.w	%vr17                   ; @0x126
	cmp_s	%r12,8                          ; @0x126
 ;	 }
	mov_s	%r0,%r16                        ; @0x12c
	vvshfleven.w	%vr17, %vr17            ; Predicate Case 2
                                        ; @0x12e
	vvc2add.w	%vr17                   ; @0x132
	vvshfleven.w	%vr17, %vr17            ; @0x136
	vvc2add.w	%vr17                   ; @0x13a
	vvshfleven.w	%vr17, %vr17            ; @0x13e
	vvc2add.w	%vr17                   ; @0x142
	vvmov1.x.from.w	%r14,%vr17,0            ; @0x146
	bcs	.LBB0_19                        ; @0x14c
;  %bb.9:                               ; Predicate Case 2
                                        ; %vector.main.loop.iter.check105
                                        ;   in Loop: Header=BB0_5 Depth=1
	cmp_s	%r12,64                         ; @0x150
	mov_s	%r1,0                           ; @0x152
	bcs	.LBB0_16                        ; Predicate Case 2
                                        ; @0x154
;  %bb.11:                              ; Predicate Case 2
                                        ; %vector.ph106
                                        ;   in Loop: Header=BB0_5 Depth=1
.vvsbundle  "v3sc" 
 ;	 { 
	vvmov.w	 %vr4, 0                        ; 4-byte Folded Reload
                                        ; @0x158
	vvmov.w	 %vr3, 0                        ; @0x158
	vvmov.w	 %vr2, 0                        ; @0x158
	ld_s	%r0,[%sp,92]                    ; @0x158
 ;	 }
	; Implicit def %r1                      ; @0x166
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov.w	 %vr5, 0                        ; @0x166
	vvmov1.vi.to.w	%vr2,0,%r14             ; @0x166
	add2	%r14,%r11,192/4                 ; @0x166
 ;	 }
	mov	%lp_count,%r0                   ; @0x172
	lp	.LZD1                           ; @0x176
.LBB0_12:                               ; %vector.body110
                                        ;   Parent Loop BB0_5 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; @0x17a
	ldd	%r2,[%r14,0]                    ; @0x17a
	ldd	%r0,[%r14,-64]                  ; @0x17e
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr9,0,%r2              ; @0x182
	ldd	%r4,[%r14,-128]                 ; @0x182
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr8,0,%r0              ; @0x18c
	ldd	%r6,[%r14,-192]                 ; @0x18c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr7,0,%r4              ; @0x196
	ldd	%r8,[%r14,8]                    ; @0x196
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr6,0,%r6              ; @0x1a0
	ldd	%r12,[%r14,-56]                 ; @0x1a0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr9,1,%r3              ; @0x1aa
	ldd	%r16,[%r14,-120]                ; @0x1aa
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr8,1,%r1              ; @0x1b4
	ldd	%r20,[%r14,-184]                ; @0x1b4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr7,1,%r5              ; @0x1be
	ldd	%r0,[%r14,16]                   ; @0x1be
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr6,1,%r7              ; @0x1c8
	ldd	%r6,[%r14,-48]                  ; @0x1c8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr9,2,%r8              ; @0x1d2
	ldd	%r22,[%r14,-112]                ; @0x1d2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr8,2,%r12             ; @0x1dc
	ldd	%r2,[%r14,-176]                 ; @0x1dc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr7,2,%r16             ; @0x1e6
	ldd	%r30,[%r14,24]                  ; @0x1e6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr6,2,%r20             ; @0x1f0
	ldd	%r4,[%r14,-40]                  ; @0x1f0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr9,3,%r9              ; @0x1fa
	ldd	%r8,[%r14,-104]                 ; @0x1fa
 ;	 }
	vvmov1.vi.to.w	%vr8,3,%r13             ; @0x204
	std	%r8,[%sp,56]                    ; 8-byte Folded Spill
                                        ; @0x20a
	ldd	%r8,[%r14,-168]                 ; @0x20e
	vvmov1.vi.to.w	%vr7,3,%r17             ; @0x212
	std	%r8,[%sp,120]                   ; 8-byte Folded Spill
                                        ; @0x218
	ldd	%r8,[%r14,32]                   ; @0x21c
	vvmov1.vi.to.w	%vr6,3,%r21             ; @0x220
	std	%r8,[%sp,144]                   ; 8-byte Folded Spill
                                        ; @0x226
	ldd	%r8,[%r14,-32]                  ; @0x22a
	vvmov1.vi.to.w	%vr9,4,%r0              ; @0x22e
	std	%r8,[%sp,152]                   ; 8-byte Folded Spill
                                        ; @0x234
	ldd	%r8,[%r14,-96]                  ; @0x238
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr8,4,%r6              ; @0x23c
	ldd	%r20,[%r14,-160]                ; @0x23c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr7,4,%r22             ; 8-byte Folded Spill
                                        ; @0x246
	std	%r8,[%sp,128]                   ; @0x246
 ;	 }
	ldd	%r8,[%r14,40]                   ; @0x250
	vvmov1.vi.to.w	%vr6,4,%r2              ; @0x254
	std	%r8,[%sp,136]                   ; 8-byte Folded Spill
                                        ; @0x25a
	ldd	%r8,[%r14,-24]                  ; @0x25e
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr9,5,%r1              ; @0x262
	ldd	%r18,[%r14,-88]                 ; @0x262
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr8,5,%r7              ; @0x26c
	ldd	%r12,[%r14,-152]                ; @0x26c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr7,5,%r23             ; @0x276
	ldd	%r22,[%r14,48]                  ; @0x276
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr6,5,%r3              ; @0x280
	ldd	%r16,[%r14,-16]                 ; @0x280
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr9,6,%r30             ; 8-byte Folded Reload
                                        ; @0x28a
	ldd	%r2,[%sp,56]                    ; @0x28a
 ;	 }
	ldd	%r6,[%r14,-80]                  ; @0x294
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr9,7,%blink           ; @0x298
	ldd	%r0,[%r14,-144]                 ; @0x298
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr8,6,%r4              ; 8-byte Folded Spill
                                        ; @0x2a2
	std	%r8,[%sp,112]                   ; @0x2a2
 ;	 }
	ldd	%r8,[%r14,56]                   ; @0x2ac
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr8,7,%r5              ; @0x2b0
	ldd	%r30,[%r14,-8]                  ; @0x2b0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr7,6,%r2              ; @0x2ba
	ldd	%r4,[%r14,-72]                  ; @0x2ba
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr7,7,%r3              ; @0x2c4
	ldd	%r2,[%r14,-136]                 ; @0x2c4
 ;	 }
	add3	%r14,%r14,256/8                 ; @0x2ce
	std	%r2,[%sp,56]                    ; 8-byte Folded Spill
                                        ; @0x2d2
	ldd	%r2,[%sp,120]                   ; 8-byte Folded Reload
                                        ; @0x2d6
	vvmov1.vi.to.w	%vr6,6,%r2              ; @0x2da
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr6,7,%r3              ; 8-byte Folded Reload
                                        ; @0x2e0
	ldd	%r2,[%sp,144]                   ; @0x2e0
 ;	 }
	vvmov1.vi.to.w	%vr6,8,%r20             ; @0x2ea
	vvmov1.vi.to.w	%vr9,8,%r2              ; @0x2f0
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr9,9,%r3              ; 8-byte Folded Reload
                                        ; @0x2f6
	ldd	%r2,[%sp,152]                   ; @0x2f6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr6,9,%r21             ; 8-byte Folded Reload
                                        ; @0x300
	ldd	%r20,[%sp,112]                  ; @0x300
 ;	 }
	vvmov1.vi.to.w	%vr8,8,%r2              ; @0x30a
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr8,9,%r3              ; 8-byte Folded Reload
                                        ; @0x310
	ldd	%r2,[%sp,128]                   ; @0x310
 ;	 }
	vvmov1.vi.to.w	%vr8,10,%r20            ; @0x31a
	vvmov1.vi.to.w	%vr7,8,%r2              ; @0x320
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr7,9,%r3              ; 8-byte Folded Reload
                                        ; @0x326
	ldd	%r2,[%sp,136]                   ; @0x326
 ;	 }
	vvmov1.vi.to.w	%vr7,10,%r18            ; @0x330
	vvmov1.vi.to.w	%vr9,10,%r2             ; @0x336
	vvmov1.vi.to.w	%vr6,10,%r12            ; @0x33c
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr9,11,%r3             ; 8-byte Folded Reload
                                        ; @0x342
	ldd	%r2,[%sp,56]                    ; @0x342
 ;	 }
	vvmov1.vi.to.w	%vr8,11,%r21            ; @0x34c
	vvmov1.vi.to.w	%vr7,11,%r19            ; @0x352
	vvmov1.vi.to.w	%vr6,11,%r13            ; @0x358
	vvmov1.vi.to.w	%vr9,12,%r22            ; @0x35e
	vvmov1.vi.to.w	%vr8,12,%r16            ; @0x364
	vvmov1.vi.to.w	%vr7,12,%r6             ; @0x36a
	vvmov1.vi.to.w	%vr6,12,%r0             ; @0x370
	vvmov1.vi.to.w	%vr9,13,%r23            ; @0x376
	vvmov1.vi.to.w	%vr8,13,%r17            ; @0x37c
	vvmov1.vi.to.w	%vr7,13,%r7             ; @0x382
	vvmov1.vi.to.w	%vr6,13,%r1             ; @0x388
	vvmov1.vi.to.w	%vr9,14,%r8             ; @0x38e
	vvmov1.vi.to.w	%vr8,14,%r30            ; @0x394
	vvmov1.vi.to.w	%vr7,14,%r4             ; @0x39a
	vvmov1.vi.to.w	%vr6,14,%r2             ; @0x3a0
	vvmov1.vi.to.w	%vr9,15,%r9             ; @0x3a6
.vvsbundle  " v2" 
 ;	 { 
	vvadd.w	%vr5, %vr9, %vr5                ; @0x3ac
	vvmov1.vi.to.w	%vr8,15,%blink          ; @0x3ac
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvadd.w	%vr4, %vr8, %vr4                ; @0x3b6
	vvmov1.vi.to.w	%vr7,15,%r5             ; @0x3b6
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvadd.w	%vr3, %vr7, %vr3                ; @0x3c0
	vvmov1.vi.to.w	%vr6,15,%r3             ; @0x3c0
 ;	 }
	vvadd.w	%vr2, %vr6, %vr2                ; @0x3ca
.LZD1:                                  ; @0x3d0
	; ZD Loop End                           ; @0x3d0
;  %bb.13:                              ; %middle.block100
                                        ;   in Loop: Header=BB0_5 Depth=1
.vvsbundle  "v1sc" 
 ;	 { 
	vvadd.w	%vr2, %vr3, %vr2                ; 4-byte Folded Reload
                                        ; @0x3d0
	ld_s	%r12,[%sp,100]                  ; @0x3d0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvadd.w	%vr2, %vr4, %vr2                ; 4-byte Folded Reload
                                        ; @0x3d8
	ld	%r30,[%sp,96]                   ; @0x3d8
 ;	 }
	vvadd.w	%vr17, %vr5, %vr2               ; @0x3e2
	vvc2add.w	%vr17                   ; @0x3e8
	vvshfleven.w	%vr17, %vr17            ; @0x3ec
	vvc2add.w	%vr17                   ; @0x3f0
	vvshfleven.w	%vr17, %vr17            ; @0x3f4
	vvc2add.w	%vr17                   ; @0x3f8
	vvshfleven.w	%vr17, %vr17            ; @0x3fc
	vvc2add.w	%vr17                   ; @0x400
	vvmov1.x.from.w	%r14,%vr17,0            ; @0x404
	brne	%r12,%r30,.LBB0_15              ; @0x40a
;  %bb.14:                              ;   in Loop: Header=BB0_5 Depth=1
	ld	%r17,[%sp,88]                   ; 4-byte Folded Reload
                                        ; @0x40e
	ld	%r6,[%sp,84]                    ; 4-byte Folded Reload
                                        ; @0x412
	ld_s	%r13,[%sp,80]                   ; 4-byte Folded Reload
                                        ; @0x416
	ld	%r7,[%sp,76]                    ; 4-byte Folded Reload
                                        ; @0x418
	ld	%r16,[%sp,72]                   ; 4-byte Folded Reload
                                        ; @0x41c
	ld	%blink,[%sp,68]                 ; 4-byte Folded Reload
                                        ; @0x420
	b_s	.LBB0_4                         ; @0x424
.LBB0_15:                               ; %vec.epilog.iter.check128
                                        ;   in Loop: Header=BB0_5 Depth=1
                                        ; @0x426
	ld	%r0,[%sp,164]                   ; 4-byte Folded Reload
                                        ; @0x426
	ld	%r17,[%sp,88]                   ; 4-byte Folded Reload
                                        ; @0x42a
	ld	%r6,[%sp,84]                    ; 4-byte Folded Reload
                                        ; @0x42e
	ld_s	%r13,[%sp,80]                   ; 4-byte Folded Reload
                                        ; @0x432
	ld	%r7,[%sp,76]                    ; 4-byte Folded Reload
                                        ; @0x434
	ld	%r16,[%sp,72]                   ; 4-byte Folded Reload
                                        ; @0x438
	ld	%blink,[%sp,68]                 ; 4-byte Folded Reload
                                        ; @0x43c
	mov	%r1,%r30                        ; @0x440
	tst	%r12,56                         ; @0x444
	beq_s	.LBB0_19                        ; @0x448
.LBB0_16:                               ; %vec.epilog.ph129
                                        ;   in Loop: Header=BB0_5 Depth=1
                                        ; @0x44a
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr2, 0                        ; 4-byte Folded Reload
                                        ; @0x44a
	ld_s	%r2,[%sp,104]                   ; @0x44a
 ;	 }
	add	%r0,%r16,%r1                    ; @0x450
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,0,%r14             ; @0x454
	add_s	%r1,%r1,%r24                    ; @0x454
 ;	 }
	sub_s	%r0,%r2,%r0                     ; @0x45c
	lsr_s	%r0,%r0,3                       ; @0x45e
	add2	%r14,%r13,%r1                   ; @0x460
	; Implicit def %r1                      ; @0x464
	add	%lp_count,%r0,1                 ; @0x464
	lp	.LZD2                           ; @0x468
.LBB0_17:                               ; %vec.epilog.vector.body139
                                        ;   Parent Loop BB0_5 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; @0x46c
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr3, 0                        ; @0x46c
	ldd.ab	%r2,[%r14,32]                   ; @0x46c
 ;	 }
	ldd	%r0,[%r14,-24]                  ; @0x474
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,0,%r2              ; @0x478
	ldd	%r4,[%r14,-16]                  ; @0x478
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,1,%r3              ; @0x482
	ldd	%r8,[%r14,-8]                   ; @0x482
 ;	 }
	vvmov1.vi.to.w	%vr3,2,%r0              ; @0x48c
	vvmov1.vi.to.w	%vr3,3,%r1              ; @0x492
	vvmov1.vi.to.w	%vr3,4,%r4              ; @0x498
	vvmov1.vi.to.w	%vr3,5,%r5              ; @0x49e
	vvmov1.vi.to.w	%vr3,6,%r8              ; @0x4a4
	vvmov1.vi.to.w	%vr3,7,%r9              ; @0x4aa
	vvadd.w	%vr2, %vr3, %vr2                ; @0x4b0
.LZD2:                                  ; @0x4b6
	; ZD Loop End                           ; @0x4b6
;  %bb.18:                              ; %vec.epilog.middle.block126
                                        ;   in Loop: Header=BB0_5 Depth=1

	ld_s	%r0,[%sp,108]                   ; implicit-def: $vr3
                                        ; 4-byte Folded Reload
                                        ; @0x4b6
.vvsbundle  "v1sc" 
 ;	 { 
	vvshfl.w.p1	%vr3, %vr2, %vr1        ; @0x4b8
	bmsk.f	0,%r6,2                         ; @0x4b8
 ;	 }
	vvadd.w	%vr2, %vr2, %vr3                ; @0x4c2
	vvshfl.w.p2	%vr3, %vr2, %vr0        ; @0x4c6
	vvadd.w	%vr2, %vr2, %vr3                ; @0x4cc
	vvmov1.from.w	%r1,%vr2,1              ; @0x4d0
	vvadd.w	%vr2, %vr2, %r1                 ; @0x4d6
	vvmov1.x.from.w	%r14,%vr2,0             ; @0x4da
	beq_s	.LBB0_4                         ; @0x4e0
.LBB0_19:                               ; %vec.epilog.scalar.ph127.preheader
                                        ;   in Loop: Header=BB0_5 Depth=1
                                        ; @0x4e2
	add_s	%r1,%r0,1                       ; @0x4e2
	add	%r2,%r0,%r15                    ; @0x4e4
	max	%r3,%r6,%r1                     ; @0x4e8
	add2	%r1,%r13,%r2                    ; @0x4ec
	; Implicit def %r2                      ; @0x4f0
	sub	%lp_count,%r3,%r0               ; @0x4f0
	lp	.LZD3                           ; @0x4f4
.LBB0_20:                               ; %vec.epilog.scalar.ph127
                                        ;   Parent Loop BB0_5 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; Label of block must be emitted
                                        ; @0x4f8 AlignLabel LoopTop Freq=150
	ld.ab	%r0,[%r1,4]                     ; @0x4f8
	add_s	%r14,%r0,%r14                   ; @0x4fc
.LZD3:                                  ; @0x4fe
	; ZD Loop End                           ; @0x4fe
.LBB0_4:                                ; %.loopexit
                                        ;   in Loop: Header=BB0_5 Depth=1
                                        ; @0x4fe
	add2	%r0,%r17,%r59                   ; @0x4fe
	add2	%r11,%r11,%r7                   ; @0x502
	add2	%fp,%fp,%r6                     ; @0x506
	add_s	%r15,%r15,%r7                   ; @0x50a
	add	%r24,%r24,%r7                   ; @0x50c
	add	%r59,%r59,1                     ; @0x510
	st_s	%r14,[%r0,0]                    ; @0x514
	dbnz	%r58,.LBB0_5                    ; @0x516
	b	.LBB0_55                        ; @0x51a
.LBB0_38:                               ; %.lr.ph11.split
                                        ; @0x51e
	brlt	%r15,1,.LBB0_43                 ; @0x51e
;  %bb.39:                              ; %.lr.ph.us14.preheader
	max	%r1,%r16,16                     ; @0x522
	add_s	%r1,%r1,-1                      ; @0x526
	lsr_s	%r1,%r1,4                       ; @0x528
	mov_s	%r0,0                           ; @0x52a
	add_s	%r1,%r1,1                       ; @0x52c
.LBB0_41:                               ; %.lr.ph.us14
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_42 Depth 2
                                        ; @0x52e
	; Implicit def %r12                     ; @0x52e
.vvsbundle  "v1sc" 
 ;	 { 
	vvcmov.b	%vr17, %vr16                    ; @0x52e
	mov	%lp_count,%r1                   ; @0x52e
 ;	 }
	mov_s	%r2,%r13                        ; @0x536
	lp	.LZD11                          ; @0x538
.LBB0_42:                               ;   Parent Loop BB0_41 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; Label of block must be emitted
                                        ; @0x53c AlignLabel LoopTop Freq=200
	vvld.av.w	%vr0,%r2,1              ; @0x53c
	vvadd.w	%vr17, %vr17, %vr0              ; @0x542
.LZD11:                                 ; @0x546
	; ZD Loop End                           ; @0x546
;  %bb.40:                              ;   in Loop: Header=BB0_41 Depth=1
.vvsbundle  "v1sc" 
 ;	 { 
	vvc2add.w	%vr17                   ; @0x546
	add2	%r2,%r17,%r0                    ; @0x546
 ;	 }
	add2	%r13,%r13,%r6                   ; @0x54e
	add_s	%r0,%r0,1                       ; @0x552
	vvshfleven.w	%vr17, %vr17            ; @0x554
	vvc2add.w	%vr17                   ; @0x558
	vvshfleven.w	%vr17, %vr17            ; @0x55c
	vvc2add.w	%vr17                   ; @0x560
	vvshfleven.w	%vr17, %vr17            ; @0x564
	vvc2add.w	%vr17                   ; @0x568
	vvmov1.x.from.w	%r3,%vr17,0             ; @0x56c
	st_s	%r3,[%r2,0]                     ; @0x572
	dbnz	%r58,.LBB0_41                   ; @0x574
	b	.LBB0_55                        ; @0x578
.LBB0_21:                               ; %.lr.ph11.split.us.split
                                        ; @0x57c
.vvsbundle  "v1sc" 
 ;	 { 
	vvc2add.w	%vr16                   ; @0x57c
	sub	%r24,%r6,%r16                   ; @0x57c
 ;	 }
	cmp	%r24,8                          ; @0x584
	vvshfleven.w	%vr16, %vr16            ; @0x588
	vvc2add.w	%vr16                   ; @0x58c
	vvshfleven.w	%vr16, %vr16            ; @0x590
	vvc2add.w	%vr16                   ; @0x594
	vvshfleven.w	%vr16, %vr16            ; @0x598
	vvc2add.w	%vr16                   ; @0x59c
	vvmov1.x.from.w	%fp,%vr16,0             ; @0x5a0
	bcc	.LBB0_22                        ; @0x5a6
;  %bb.23:                              ; %iter.check63.us.preheader
	asl_s	%r1,%r15,6                      ; @0x5aa
	mov_s	%r0,0                           ; @0x5ac
	add_s	%r3,%r13,%r1                    ; @0x5ae
.LBB0_24:                               ; %iter.check63.us
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_25 Depth 2
                                        ; @0x5b0
	; Implicit def %r11                     ; @0x5b0
	mov	%lp_count,%r24                  ; @0x5b0
	mov_s	%r2,%r3                         ; @0x5b4
	mov_s	%r1,%fp                         ; @0x5b6
	lp	.LZD5                           ; @0x5b8
.LBB0_25:                               ;   Parent Loop BB0_24 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; @0x5bc
	ld.ab	%r12,[%r2,4]                    ; @0x5bc
	add_s	%r1,%r12,%r1                    ; @0x5c0
.LZD5:                                  ; @0x5c2
	; ZD Loop End                           ; @0x5c2
;  %bb.54:                              ; %.loopexit146.us
                                        ;   in Loop: Header=BB0_24 Depth=1
	add2	%r2,%r17,%r0                    ; @0x5c2
	add2	%r3,%r3,%r7                     ; @0x5c6
	add_s	%r0,%r0,1                       ; @0x5ca
	st_s	%r1,[%r2,0]                     ; @0x5cc
	dbnz	%r58,.LBB0_24                   ; @0x5ce
	b	.LBB0_55                        ; @0x5d2
.LBB0_43:                               ; %iter.check
                                        ; @0x5d6
.vvsbundle  "v1sc" 
 ;	 { 
	vvc2add.w	%vr16                   ; @0x5d6
	cmp	%r58,8                          ; @0x5d6
 ;	 }
	mov_s	%r1,0                           ; @0x5de
	vvshfleven.w	%vr16, %vr16            ; @0x5e0
	vvc2add.w	%vr16                   ; @0x5e4
	vvshfleven.w	%vr16, %vr16            ; @0x5e8
	vvc2add.w	%vr16                   ; @0x5ec
	vvshfleven.w	%vr16, %vr16            ; @0x5f0
	vvc2add.w	%vr16                   ; @0x5f4
	vvmov1.x.from.w	%r0,%vr16,0             ; @0x5f8
	bcs	.LBB0_52                        ; @0x5fe
;  %bb.44:                              ; %vector.main.loop.iter.check
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr0, %r0                      ; @0x602
	cmp	%r58,64                         ; @0x602
 ;	 }
	bcs	.LBB0_49                        ; @0x60a
;  %bb.45:                              ; %vector.ph
	; Implicit def %r8                      ; @0x60e
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r6,%vr0,2              ; @0x60e
	sub3	%r2,%r58,64/8                   ; @0x60e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r22,%vr0,4             ; @0x618
	lsr_s	%r2,%r2,6                       ; @0x618
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r2,%vr0,0              ; @0x620
	add	%lp_count,%r2,1                 ; @0x620
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r20,%vr0,6             ; @0x62a
	mov_s	%r13,%r17                       ; @0x62a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r18,%vr0,8             ; @0x632
	add	%r12,%r17,56                    ; @0x632
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r16,%vr0,10            ; @0x63c
	bmskn	%r1,%r58,5                      ; @0x63c
 ;	 }
	vvmov2.x.from.w	%r14,%vr0,12            ; @0x646
	vvmov2.x.from.w	%r30,%vr0,14            ; @0x64c
	lp	.LZD15                          ; @0x652
.LBB0_46:                               ; %vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x656
	std.ab	%r30,[%r12,64]                  ; @0x656
	std.ab	%r30,[%r12,64]                  ; @0x65a
	std.ab	%r30,[%r12,64]                  ; @0x65e
	std.ab	%r30,[%r12,-200]                ; @0x662
	std.ab	%r14,[%r12,-8]                  ; @0x666
	std.ab	%r16,[%r12,-8]                  ; @0x66a
	std.ab	%r18,[%r12,-8]                  ; @0x66e
	std.ab	%r20,[%r12,-8]                  ; @0x672
	std.ab	%r22,[%r12,-8]                  ; @0x676
	std.ab	%r6,[%r12,-8]                   ; @0x67a
	std.ab	%r2,[%r12,112]                  ; @0x67e
	std.ab	%r14,[%r12,-8]                  ; @0x682
	std.ab	%r16,[%r12,-8]                  ; @0x686
	std.ab	%r18,[%r12,-8]                  ; @0x68a
	std.ab	%r20,[%r12,-8]                  ; @0x68e
	std.ab	%r22,[%r12,-8]                  ; @0x692
	std.ab	%r6,[%r12,-8]                   ; @0x696
	std.ab	%r2,[%r12,112]                  ; @0x69a
	std.ab	%r14,[%r12,-8]                  ; @0x69e
	std.ab	%r16,[%r12,-8]                  ; @0x6a2
	std.ab	%r18,[%r12,-8]                  ; @0x6a6
	std.ab	%r20,[%r12,-8]                  ; @0x6aa
	std.ab	%r22,[%r12,-8]                  ; @0x6ae
	std.ab	%r6,[%r12,-8]                   ; @0x6b2
	std.ab	%r2,[%r12,112]                  ; @0x6b6
	std.ab	%r14,[%r12,-8]                  ; @0x6ba
	std.ab	%r16,[%r12,-8]                  ; @0x6be
	std.ab	%r18,[%r12,-8]                  ; @0x6c2
	std.ab	%r20,[%r12,-8]                  ; @0x6c6
	std.ab	%r22,[%r12,-8]                  ; @0x6ca
	std.ab	%r6,[%r12,-8]                   ; @0x6ce
	std.ab	%r2,[%r12,120]                  ; @0x6d2
.LZD15:                                 ; @0x6d6
	; ZD Loop End                           ; @0x6d6
;  %bb.47:                              ; %middle.block
	cmp	%r1,%r58                        ; @0x6d6
	beq	.LBB0_55                        ; @0x6da
;  %bb.48:                              ; %vec.epilog.iter.check
	mov_s	%r17,%r13                       ; @0x6de
	tst	%r58,56                         ; @0x6e0
	beq_s	.LBB0_52                        ; @0x6e4
.LBB0_49:                               ; %vec.epilog.ph
                                        ; @0x6e6
	; Implicit def %r12                     ; @0x6e6
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r4,%vr0,0              ; @0x6e6
	sub	%r3,%r58,%r1                    ; @0x6e6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r6,%vr0,2              ; @0x6f0
	sub_s	%r3,%r3,8                       ; @0x6f0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r8,%vr0,4              ; @0x6f8
	lsr_s	%r3,%r3,3                       ; @0x6f8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r30,%vr0,6             ; @0x700
	add2	%r2,%r17,%r1                    ; @0x700
 ;	 }
	bmskn	%r1,%r58,2                      ; @0x70a
	add	%lp_count,%r3,1                 ; @0x70e
	lp	.LZD14                          ; @0x712
.LBB0_50:                               ; %vec.epilog.vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x716
	std	%r30,[%r2,24]                   ; @0x716
	std	%r8,[%r2,16]                    ; @0x71a
	std	%r6,[%r2,8]                     ; @0x71e
	std.ab	%r4,[%r2,32]                    ; @0x722
.LZD14:                                 ; @0x726
	; ZD Loop End                           ; @0x726
;  %bb.51:                              ; %vec.epilog.middle.block
	cmp	%r1,%r58                        ; @0x726
	beq	.LBB0_55                        ; @0x72a
.LBB0_52:                               ; %vec.epilog.scalar.ph.preheader
                                        ; @0x72e
	add_s	%r3,%r1,1                       ; @0x72e
	add2	%r2,%r17,%r1                    ; @0x730
	max	%r3,%r58,%r3                    ; @0x734
	sub	%lp_count,%r3,%r1               ; @0x738
	; Implicit def %r3                      ; @0x73c
	lp	.LZD13                          ; @0x73c
.LBB0_53:                               ; %vec.epilog.scalar.ph
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x740
	st.ab	%r0,[%r2,4]                     ; @0x740
.LZD13:                                 ; @0x744
	; ZD Loop End                           ; @0x744
	nop                                     ; inserted to benefit BPU
                                        ; @0x744
	b	.LBB0_55                        ; @0x748
.LBB0_22:                               ; %iter.check63.preheader
                                        ; @0x74c

.vvsbundle  "v3sc"                      ; implicit-def: $vr0
 ;	 { 
	vvci.w	%vr1                            ; @0x74c
	vvmov.w	 %vr2, 0                        ; @0x74c
	vvpinit.w	%p1, 0, 1               ; @0x74c
	mov_s	%r0,%r16                        ; @0x74c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvpinit.w	%p2, 0, 65534           ; @0x75c
	sub3	%r1,%r24,64/8                   ; @0x75c
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvpinit.w	%p3, 0, 65532           ; @0x766
	vvshfl.w.p1	%vr0, %vr16, %vr2       ; @0x766
	bmsk	%r2,%r6,2                       ; @0x766
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvadd.w	%vr3, %vr1, 2                   ; @0x776
	vvpinit.w	%p4, 0, 65520           ; @0x776
	asl	%r59,%r15,6                     ; @0x776
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvpinit.w	%p1, 0, 15              ; @0x784
	vvadd.w	%vr4, %vr1, 4                   ; @0x784
	lsr_s	%r1,%r1,6                       ; @0x784
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvpinit.w	%p2, 0, 3               ; @0x790
	vvshfl.w.p2	%vr0, %vr2, %vr1        ; @0x790
	add_s	%r1,%r1,1                       ; @0x790
 ;	 }
	bmskn	%r14,%r24,5                     ; @0x79e
.vvsbundle  "v2sc" 
 ;	 { 
	vvsel.w.p4	%vr2, %vr2, %vr4        ; 4-byte Folded Spill
                                        ; @0x7a2
	vvsel.w.p3	%vr1, %vr2, %vr3        ; @0x7a2
	st	%r1,[%sp,68]                    ; @0x7a2
 ;	 }
	add	%r1,%r16,1                      ; @0x7b0
	add	%r59,%r13,%r59                  ; @0x7b4
	st	%r2,[%sp,108]                   ; 4-byte Folded Spill
                                        ; @0x7b8
	sub	%r2,%r24,%r2                    ; @0x7bc
	st	%r1,[%sp,96]                    ; 4-byte Folded Spill
                                        ; @0x7c0
	sub	%r1,%r6,8                       ; @0x7c4
	mov_s	%r11,0                          ; @0x7c8
	st	%r2,[%sp,104]                   ; 4-byte Folded Spill
                                        ; @0x7ca
	st	%r1,[%sp,100]                   ; 4-byte Folded Spill
                                        ; @0x7ce
	st	%r14,[%sp,92]                   ; 4-byte Folded Spill
                                        ; @0x7d2
.LBB0_27:                               ; %iter.check63
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_29 Depth 2
                                        ;     Child Loop BB0_34 Depth 2
                                        ;     Child Loop BB0_37 Depth 2
                                        ; @0x7d6
	mov_s	%r1,%fp                         ; @0x7d6
	cmp	%r24,64                         ; @0x7d8
	mov_s	%r3,0                           ; @0x7dc
	bcs	.LBB0_33                        ; @0x7de
;  %bb.28:                              ; %vector.body70.preheader
                                        ;   in Loop: Header=BB0_27 Depth=1
.vvsbundle  "v3sc" 
 ;	 { 
	vvmov.w	 %vr5, 0                        ; 4-byte Folded Reload
                                        ; @0x7e2
	vvmov.w	 %vr4, 0                        ; @0x7e2
	vvmov.w	%vr3, %vr0                      ; @0x7e2
	ld_s	%r1,[%sp,68]                    ; @0x7e2
 ;	 }
	; Implicit def %r3                      ; @0x7f0
	vvmov.w	 %vr6, 0                        ; @0x7f0
	mov	%lp_count,%r1                   ; @0x7f4
	add2	%r1,%r59,192/4                  ; @0x7f8
	lp	.LZD7                           ; @0x7fc
.LBB0_29:                               ; %vector.body70
                                        ;   Parent Loop BB0_27 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; @0x800
	ldd	%r2,[%r1,0]                     ; @0x800
	ldd	%r4,[%r1,-64]                   ; @0x804
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr10,0,%r2             ; @0x808
	ldd	%r6,[%r1,-128]                  ; @0x808
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr9,0,%r4              ; @0x812
	ldd	%r8,[%r1,-192]                  ; @0x812
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr8,0,%r6              ; @0x81c
	ldd	%r30,[%r1,8]                    ; @0x81c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr7,0,%r8              ; @0x826
	ldd	%r14,[%r1,-56]                  ; @0x826
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr10,1,%r3             ; @0x830
	ldd	%r16,[%r1,-120]                 ; @0x830
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr9,1,%r5              ; @0x83a
	ldd	%r20,[%r1,-184]                 ; @0x83a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr8,1,%r7              ; @0x844
	ldd	%r4,[%r1,16]                    ; @0x844
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr7,1,%r9              ; @0x84e
	ldd	%r8,[%r1,-48]                   ; @0x84e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr10,2,%r30            ; @0x858
	ldd	%r22,[%r1,-112]                 ; @0x858
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr9,2,%r14             ; @0x862
	ldd	%r2,[%r1,-176]                  ; @0x862
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr8,2,%r16             ; @0x86c
	ldd	%r12,[%r1,24]                   ; @0x86c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr7,2,%r20             ; @0x876
	ldd	%r6,[%r1,-40]                   ; @0x876
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr10,3,%blink          ; @0x880
	ldd	%r30,[%r1,-104]                 ; @0x880
 ;	 }
	vvmov1.vi.to.w	%vr9,3,%r15             ; @0x88a
	std	%r30,[%sp,56]                   ; 8-byte Folded Spill
                                        ; @0x890
	ldd	%r30,[%r1,-168]                 ; @0x894
	vvmov1.vi.to.w	%vr8,3,%r17             ; @0x898
	std	%r30,[%sp,120]                  ; 8-byte Folded Spill
                                        ; @0x89e
	ldd	%r30,[%r1,32]                   ; @0x8a2
	vvmov1.vi.to.w	%vr7,3,%r21             ; @0x8a6
	std	%r30,[%sp,144]                  ; 8-byte Folded Spill
                                        ; @0x8ac
	ldd	%r30,[%r1,-32]                  ; @0x8b0
	vvmov1.vi.to.w	%vr10,4,%r4             ; @0x8b4
	std	%r30,[%sp,152]                  ; 8-byte Folded Spill
                                        ; @0x8ba
	ldd	%r30,[%r1,-96]                  ; @0x8be
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr9,4,%r8              ; @0x8c2
	ldd	%r20,[%r1,-160]                 ; @0x8c2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr8,4,%r22             ; 8-byte Folded Spill
                                        ; @0x8cc
	std	%r30,[%sp,128]                  ; @0x8cc
 ;	 }
	ldd	%r30,[%r1,40]                   ; @0x8d6
	vvmov1.vi.to.w	%vr7,4,%r2              ; @0x8da
	std	%r30,[%sp,136]                  ; 8-byte Folded Spill
                                        ; @0x8e0
	ldd	%r30,[%r1,-24]                  ; @0x8e4
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr10,5,%r5             ; @0x8e8
	ldd	%r18,[%r1,-88]                  ; @0x8e8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr9,5,%r9              ; @0x8f2
	ldd	%r14,[%r1,-152]                 ; @0x8f2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr8,5,%r23             ; @0x8fc
	ldd	%r22,[%r1,48]                   ; @0x8fc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr7,5,%r3              ; @0x906
	ldd	%r16,[%r1,-16]                  ; @0x906
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr10,6,%r12            ; 8-byte Folded Reload
                                        ; @0x910
	ldd	%r2,[%sp,56]                    ; @0x910
 ;	 }
	ldd	%r8,[%r1,-80]                   ; @0x91a
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr10,7,%r13            ; @0x91e
	ldd	%r4,[%r1,-144]                  ; @0x91e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr9,6,%r6              ; 8-byte Folded Spill
                                        ; @0x928
	std	%r30,[%sp,112]                  ; @0x928
 ;	 }
	ldd	%r30,[%r1,56]                   ; @0x932
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr9,7,%r7              ; @0x936
	ldd	%r12,[%r1,-8]                   ; @0x936
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr8,6,%r2              ; @0x940
	ldd	%r6,[%r1,-72]                   ; @0x940
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr8,7,%r3              ; @0x94a
	ldd	%r2,[%r1,-136]                  ; @0x94a
 ;	 }
	add3	%r1,%r1,256/8                   ; @0x954
	std	%r2,[%sp,56]                    ; 8-byte Folded Spill
                                        ; @0x958
	ldd	%r2,[%sp,120]                   ; 8-byte Folded Reload
                                        ; @0x95c
	vvmov1.vi.to.w	%vr7,6,%r2              ; @0x960
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr7,7,%r3              ; 8-byte Folded Reload
                                        ; @0x966
	ldd	%r2,[%sp,144]                   ; @0x966
 ;	 }
	vvmov1.vi.to.w	%vr7,8,%r20             ; @0x970
	vvmov1.vi.to.w	%vr10,8,%r2             ; @0x976
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr10,9,%r3             ; 8-byte Folded Reload
                                        ; @0x97c
	ldd	%r2,[%sp,152]                   ; @0x97c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr7,9,%r21             ; 8-byte Folded Reload
                                        ; @0x986
	ldd	%r20,[%sp,112]                  ; @0x986
 ;	 }
	vvmov1.vi.to.w	%vr9,8,%r2              ; @0x990
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr9,9,%r3              ; 8-byte Folded Reload
                                        ; @0x996
	ldd	%r2,[%sp,128]                   ; @0x996
 ;	 }
	vvmov1.vi.to.w	%vr9,10,%r20            ; @0x9a0
	vvmov1.vi.to.w	%vr8,8,%r2              ; @0x9a6
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr8,9,%r3              ; 8-byte Folded Reload
                                        ; @0x9ac
	ldd	%r2,[%sp,136]                   ; @0x9ac
 ;	 }
	vvmov1.vi.to.w	%vr8,10,%r18            ; @0x9b6
	vvmov1.vi.to.w	%vr10,10,%r2            ; @0x9bc
	vvmov1.vi.to.w	%vr7,10,%r14            ; @0x9c2
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr10,11,%r3            ; 8-byte Folded Reload
                                        ; @0x9c8
	ldd	%r2,[%sp,56]                    ; @0x9c8
 ;	 }
	vvmov1.vi.to.w	%vr9,11,%r21            ; @0x9d2
	vvmov1.vi.to.w	%vr8,11,%r19            ; @0x9d8
	vvmov1.vi.to.w	%vr7,11,%r15            ; @0x9de
	vvmov1.vi.to.w	%vr10,12,%r22           ; @0x9e4
	vvmov1.vi.to.w	%vr9,12,%r16            ; @0x9ea
	vvmov1.vi.to.w	%vr8,12,%r8             ; @0x9f0
	vvmov1.vi.to.w	%vr7,12,%r4             ; @0x9f6
	vvmov1.vi.to.w	%vr10,13,%r23           ; @0x9fc
	vvmov1.vi.to.w	%vr9,13,%r17            ; @0xa02
	vvmov1.vi.to.w	%vr8,13,%r9             ; @0xa08
	vvmov1.vi.to.w	%vr7,13,%r5             ; @0xa0e
	vvmov1.vi.to.w	%vr10,14,%r30           ; @0xa14
	vvmov1.vi.to.w	%vr9,14,%r12            ; @0xa1a
	vvmov1.vi.to.w	%vr8,14,%r6             ; @0xa20
	vvmov1.vi.to.w	%vr7,14,%r2             ; @0xa26
	vvmov1.vi.to.w	%vr10,15,%blink         ; @0xa2c
.vvsbundle  " v2" 
 ;	 { 
	vvadd.w	%vr6, %vr10, %vr6               ; @0xa32
	vvmov1.vi.to.w	%vr9,15,%r13            ; @0xa32
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvadd.w	%vr5, %vr9, %vr5                ; @0xa3c
	vvmov1.vi.to.w	%vr8,15,%r7             ; @0xa3c
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvadd.w	%vr4, %vr8, %vr4                ; @0xa46
	vvmov1.vi.to.w	%vr7,15,%r3             ; @0xa46
 ;	 }
	vvadd.w	%vr3, %vr7, %vr3                ; @0xa50
.LZD7:                                  ; @0xa56
	; ZD Loop End                           ; @0xa56
;  %bb.30:                              ; %middle.block60
                                        ;   in Loop: Header=BB0_27 Depth=1
.vvsbundle  "v1sc" 
 ;	 { 
	vvadd.w	%vr3, %vr4, %vr3                ; 4-byte Folded Reload
                                        ; @0xa56
	ld_s	%r14,[%sp,92]                   ; @0xa56
 ;	 }
	vvadd.w	%vr3, %vr5, %vr3                ; @0xa5e
	vvadd.w	%vr16, %vr6, %vr3               ; @0xa64
	vvc2add.w	%vr16                   ; @0xa6a
	vvshfleven.w	%vr16, %vr16            ; @0xa6e
	vvc2add.w	%vr16                   ; @0xa72
	vvshfleven.w	%vr16, %vr16            ; @0xa76
	vvc2add.w	%vr16                   ; @0xa7a
	vvshfleven.w	%vr16, %vr16            ; @0xa7e
	vvc2add.w	%vr16                   ; @0xa82
	vvmov1.x.from.w	%r1,%vr16,0             ; @0xa86
	brne	%r24,%r14,.LBB0_32              ; @0xa8c
;  %bb.31:                              ;   in Loop: Header=BB0_27 Depth=1
	ld	%r17,[%sp,88]                   ; 4-byte Folded Reload
                                        ; @0xa90
	ld	%r6,[%sp,84]                    ; 4-byte Folded Reload
                                        ; @0xa94
	ld_s	%r13,[%sp,80]                   ; 4-byte Folded Reload
                                        ; @0xa98
	ld	%r7,[%sp,76]                    ; 4-byte Folded Reload
                                        ; @0xa9a
	ld	%r16,[%sp,72]                   ; 4-byte Folded Reload
                                        ; @0xa9e
	b_s	.LBB0_26                        ; @0xaa2
.LBB0_32:                               ; %vec.epilog.iter.check83
                                        ;   in Loop: Header=BB0_27 Depth=1
                                        ; @0xaa4
	ld	%r17,[%sp,88]                   ; 4-byte Folded Reload
                                        ; @0xaa4
	ld	%r6,[%sp,84]                    ; 4-byte Folded Reload
                                        ; @0xaa8
	ld_s	%r13,[%sp,80]                   ; 4-byte Folded Reload
                                        ; @0xaac
	ld	%r7,[%sp,76]                    ; 4-byte Folded Reload
                                        ; @0xaae
	ld	%r16,[%sp,72]                   ; 4-byte Folded Reload
                                        ; @0xab2
	mov_s	%r3,%r14                        ; @0xab6
	mov_s	%r2,%r14                        ; @0xab8
	tst	%r24,56                         ; @0xaba
	beq_s	.LBB0_36                        ; @0xabe
.LBB0_33:                               ; %vec.epilog.ph84
                                        ;   in Loop: Header=BB0_27 Depth=1
                                        ; @0xac0
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr3, 0                        ; @0xac0
	add	%r2,%r16,%r3                    ; @0xac0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,0,%r1              ; 4-byte Folded Reload
                                        ; @0xac8
	ld_s	%r1,[%sp,100]                   ; @0xac8
 ;	 }
	add_s	%r3,%r3,%r0                     ; @0xad0
	sub_s	%r2,%r1,%r2                     ; @0xad2
	lsr_s	%r2,%r2,3                       ; @0xad4
	add2	%r1,%r13,%r3                    ; @0xad6
	; Implicit def %r3                      ; @0xada
	add	%lp_count,%r2,1                 ; @0xada
	lp	.LZD8                           ; @0xade
.LBB0_34:                               ; %vec.epilog.vector.body93
                                        ;   Parent Loop BB0_27 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; @0xae2
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr4, 0                        ; @0xae2
	ldd.ab	%r2,[%r1,32]                    ; @0xae2
 ;	 }
	ldd	%r4,[%r1,-24]                   ; @0xaea
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr4,0,%r2              ; @0xaee
	ldd	%r30,[%r1,-16]                  ; @0xaee
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr4,1,%r3              ; @0xaf8
	ldd	%r8,[%r1,-8]                    ; @0xaf8
 ;	 }
	vvmov1.vi.to.w	%vr4,2,%r4              ; @0xb02
	vvmov1.vi.to.w	%vr4,3,%r5              ; @0xb08
	vvmov1.vi.to.w	%vr4,4,%r30             ; @0xb0e
	vvmov1.vi.to.w	%vr4,5,%blink           ; @0xb14
	vvmov1.vi.to.w	%vr4,6,%r8              ; @0xb1a
	vvmov1.vi.to.w	%vr4,7,%r9              ; @0xb20
	vvadd.w	%vr3, %vr4, %vr3                ; @0xb26
.LZD8:                                  ; @0xb2c
	; ZD Loop End                           ; @0xb2c
;  %bb.35:                              ; %vec.epilog.middle.block81
                                        ;   in Loop: Header=BB0_27 Depth=1

	ld_s	%r1,[%sp,108]                   ; implicit-def: $vr4
                                        ; 4-byte Folded Reload
                                        ; @0xb2c
.vvsbundle  "v1sc" 
 ;	 { 
	vvshfl.w.p1	%vr4, %vr3, %vr2        ; 4-byte Folded Reload
                                        ; @0xb2e
	ld_s	%r2,[%sp,104]                   ; @0xb2e
 ;	 }
	cmp_s	%r1,0                           ; @0xb36
	vvadd.w	%vr3, %vr3, %vr4                ; @0xb38
	vvshfl.w.p2	%vr4, %vr3, %vr1        ; @0xb3c
	vvadd.w	%vr3, %vr3, %vr4                ; @0xb42
	vvmov1.from.w	%r1,%vr3,1              ; @0xb46
	vvadd.w	%vr3, %vr3, %r1                 ; @0xb4c
	vvmov1.x.from.w	%r1,%vr3,0              ; @0xb50
	beq_s	.LBB0_26                        ; @0xb56
.LBB0_36:                               ; %vec.epilog.scalar.ph82
                                        ;   in Loop: Header=BB0_27 Depth=1
                                        ; @0xb58
	ld_s	%r3,[%sp,96]                    ; 4-byte Folded Reload
                                        ; @0xb58
	add_s	%r12,%r2,%r0                    ; @0xb5a
	add_s	%r3,%r3,%r2                     ; @0xb5c
	add	%r15,%r16,%r2                   ; @0xb5e
	max	%r3,%r6,%r3                     ; @0xb62
	add2	%r2,%r13,%r12                   ; @0xb66
	; Implicit def %r12                     ; @0xb6a
	sub	%lp_count,%r3,%r15              ; @0xb6a
	lp	.LZD9                           ; @0xb6e
.LBB0_37:                               ;   Parent Loop BB0_27 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; @0xb72
	ld.ab	%r3,[%r2,4]                     ; @0xb72
	add_s	%r1,%r3,%r1                     ; @0xb76
.LZD9:                                  ; @0xb78
	; ZD Loop End                           ; @0xb78
.LBB0_26:                               ; %.loopexit146
                                        ;   in Loop: Header=BB0_27 Depth=1
                                        ; @0xb78
	add2	%r2,%r17,%r11                   ; @0xb78
	add2	%r59,%r59,%r7                   ; @0xb7c
	add_s	%r0,%r0,%r7                     ; @0xb80
	add_s	%r11,%r11,1                     ; @0xb82
	st_s	%r1,[%r2,0]                     ; @0xb84
	dbnz	%r58,.LBB0_27                   ; @0xb86
.LBB0_55:                               ; %._crit_edge12
                                        ; @0xb8a
	ld	%blink,[%sp,52]                 ; @0xb8a
	.cfa_restore	{%blink}                ; @0xb8e
	ld	%fp,[%sp,48]                    ; @0xb8e
	.cfa_restore	{%fp}                   ; @0xb92
	ld	%r24,[%sp,44]                   ; @0xb92
	.cfa_restore	{%r24}                  ; @0xb96
	ldd	%r22,[%sp,36]                   ; @0xb96
	.cfa_restore	{%r23}                  ; @0xb9a
	.cfa_restore	{%r22}                  ; @0xb9a
	ldd	%r20,[%sp,28]                   ; @0xb9a
	.cfa_restore	{%r21}                  ; @0xb9e
	.cfa_restore	{%r20}                  ; @0xb9e
	ldd	%r18,[%sp,20]                   ; @0xb9e
	.cfa_restore	{%r19}                  ; @0xba2
	.cfa_restore	{%r18}                  ; @0xba2
	ldd	%r16,[%sp,12]                   ; @0xba2
	.cfa_restore	{%r17}                  ; @0xba6
	.cfa_restore	{%r16}                  ; @0xba6
	ldd	%r14,[%sp,4]                    ; @0xba6
	.cfa_restore	{%r15}                  ; @0xbaa
	.cfa_restore	{%r14}                  ; @0xbaa
	ld.ab	%r13,[%sp,168]                  ; @0xbaa
	.cfa_restore	{%r13}                  ; @0xbae
	.cfa_pop	168                             ; @0xbae
	j_s	[%blink]                        ; @0xbae
	.cfa_ef
.Lfunc_end0:                            ; @0xbb0

	.reloc	_init_ad,0	;startup code to enable %status AD bit ; -- End function
