	.option	%reg
	.off	assume_short
	.file	"matmul.c"
	.globl	init_matrix
	.type	init_matrix,@function
	.type	.Linit_matrix$local,@function
	.size	init_matrix, .Lfunc_end0-init_matrix
	.size	.Linit_matrix$local, .Lfunc_end0-init_matrix
	.globl	matmul
	.type	matmul,@function
	.type	.Lmatmul$local,@function
	.size	matmul, .Lfunc_end1-matmul
	.size	.Lmatmul$local, .Lfunc_end1-matmul
	.globl	vectorized_matmul
	.type	vectorized_matmul,@function
	.type	.Lvectorized_matmul$local,@function
	.size	vectorized_matmul, .Lfunc_end2-vectorized_matmul
	.size	.Lvectorized_matmul$local, .Lfunc_end2-vectorized_matmul
	.globl	autovectorized_matmul
	.type	autovectorized_matmul,@function
	.type	.Lautovectorized_matmul$local,@function
	.size	autovectorized_matmul, .Lfunc_end3-autovectorized_matmul
	.size	.Lautovectorized_matmul$local, .Lfunc_end3-autovectorized_matmul
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
	.ident	"LLVM 17.0.7/V-2024.06. (build 008) (LLVM 17.0.7) -arcv2hs -core4 -Xcode_density -Xatomic -Xll64 -Xunaligned -Xdiv_rem=radix4 -Xswap -Xbitscan -Xmpy_option=mpyd -Xshift_assist -Xbarrel_shifter -Xfpud_div -Xfpu_mac -Xtimer0 -Xrtc -Xstack_check -Xstu=4 -Xvdsp4 -Xvec_unit_rev_minor=1 -Xvec_width=512 -Xvec_mem_size=128k -Xvec_mem_bank_width=16 -Xvec_max_fetch_size=16 -Xvec_num_slots=3 -Xvec_super_with_scalar -Xvec_regs=32 -Xvec_fpu=32 -Xvec_fpu_math=3 -Xvec_fpu_2nd_mul -Xvec_fpu_types=2 -Xvec_num_rd_ports=6 -Xvec_num_acc=8 -Xvec_num_mpy=2 -Xvec_mpy32 -Xvec_num_alu=3 -Xvec_guard_bit_option=0 -Xvec_stack_check -Hvdsp_vector_c -O1 -fvectorize -fslp-vectorize -ffast-math"
	.align	4                               ; -- Begin function init_matrix
init_matrix:                            ; @init_matrix
                                        ; @0x0
.Linit_matrix$local:                    ; @0x0
	.cfa_bf	.Linit_matrix$local
;  %bb.0:                               ; %entry
	.cfa_same	%r11                    ; @0x0
	.cfa_same	%r3                     ; @0x0
	sub_s	%sp,%sp,40                      ; @0x0
	.cfa_push	40                      ; @0x2
	st	%r14,[%sp,0]                    ; @0x2
	.cfa_reg_offset	{%r14}, 0               ; @0x6
	std	%r16,[%sp,4]                    ; @0x6
	.cfa_reg_offset	{%r16}, 4               ; @0xa
	.cfa_reg_offset	{%r17}, 8               ; @0xa
	std	%r18,[%sp,12]                   ; @0xa
	.cfa_reg_offset	{%r18}, 12              ; @0xe
	.cfa_reg_offset	{%r19}, 16              ; @0xe
	std	%r20,[%sp,20]                   ; @0xe
	.cfa_reg_offset	{%r20}, 20              ; @0x12
	.cfa_reg_offset	{%r21}, 24              ; @0x12
	std	%r22,[%sp,28]                   ; @0x12
	.cfa_reg_offset	{%r22}, 28              ; @0x16
	.cfa_reg_offset	{%r23}, 32              ; @0x16
	st	%blink,[%sp,36]                 ; @0x16
	.cfa_reg_offset	{%blink}, 36            ; @0x1a
	mpy_s	%r1,%r1,%r2                     ; @0x1a
	brlt	%r1,1,.LBB0_14                  ; @0x1c
;  %bb.1:                               ; %iter.check
	brhs	%r1,8,.LBB0_3                   ; @0x20
;  %bb.2:
	mov_s	%r2,0                           ; @0x24
	b_s	.LBB0_12                        ; @0x26
.LBB0_3:                                ; %vector.main.loop.iter.check
                                        ; @0x28
	vvmov.w	 %vr0, %r3                      ; @0x28
	vvmov2.x.from.w	%r4,%vr0,0              ; @0x2c
	vvmov2.x.from.w	%r6,%vr0,2              ; @0x32
	vvmov2.x.from.w	%r8,%vr0,4              ; @0x38
	vvmov2.x.from.w	%r22,%vr0,6             ; @0x3e
	brhs	%r1,16,.LBB0_5                  ; @0x44
;  %bb.4:
	mov_s	%r2,0                           ; @0x48
	b_s	.LBB0_9                         ; @0x4a
.LBB0_5:                                ; %vector.ph
                                        ; @0x4c
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r20,%vr0,14            ; @0x4c
	mov_s	%r12,0                          ; @0x4c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r18,%vr0,12            ; @0x54
	bmskn	%r2,%r1,3                       ; @0x54
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r16,%vr0,10            ; @0x5e
	mov_s	%r14,%r0                        ; @0x5e
 ;	 }
	vvmov2.x.from.w	%r30,%vr0,8             ; @0x66
.LBB0_6:                                ; %vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x6c
	std	%r20,[%r14,56]                  ; @0x6c
	std	%r18,[%r14,48]                  ; @0x70
	std	%r16,[%r14,40]                  ; @0x74
	std	%r30,[%r14,32]                  ; @0x78
	std	%r22,[%r14,24]                  ; @0x7c
	std	%r8,[%r14,16]                   ; @0x80
	std	%r6,[%r14,8]                    ; @0x84
	std	%r4,[%r14,0]                    ; @0x88
	add1	%r14,%r14,64/2                  ; @0x8c
	add_s	%r12,%r12,16                    ; @0x90
	brne	%r12,%r2,.LBB0_6                ; @0x92
;  %bb.7:                               ; %middle.block
	breq	%r1,%r2,.LBB0_14                ; @0x96
;  %bb.8:                               ; %vec.epilog.iter.check
	and	%r12,%r1,8                      ; @0x9a
	breq_s	%r12,0,.LBB0_12                 ; @0x9e
.LBB0_9:                                ; %vec.epilog.ph
                                        ; @0xa0
	add2	%r14,%r0,%r2                    ; @0xa0
	bmskn	%r12,%r1,2                      ; @0xa4
.LBB0_10:                               ; %vec.epilog.vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0xa8
	std	%r22,[%r14,24]                  ; @0xa8
	std	%r8,[%r14,16]                   ; @0xac
	std	%r6,[%r14,8]                    ; @0xb0
	std	%r4,[%r14,0]                    ; @0xb4
	add_s	%r14,%r14,32                    ; @0xb8
	add_s	%r2,%r2,8                       ; @0xba
	brne	%r2,%r12,.LBB0_10               ; @0xbc
;  %bb.11:                              ; %vec.epilog.middle.block
	mov_s	%r2,%r12                        ; @0xc0
	breq	%r1,%r12,.LBB0_14               ; @0xc2
.LBB0_12:                               ; %for.body.preheader
                                        ; @0xc6
	add2_s	%r0,%r0,%r2                     ; @0xc6
.LBB0_13:                               ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0xc8
	st_s	%r3,[%r0,0]                     ; @0xc8
	add_s	%r0,%r0,4                       ; @0xca
	add_s	%r2,%r2,1                       ; @0xcc
	brlt	%r2,%r1,.LBB0_13                ; @0xce
.LBB0_14:                               ; %for.cond.cleanup
                                        ; @0xd2
	ld	%blink,[%sp,36]                 ; @0xd2
	.cfa_restore	{%blink}                ; @0xd6
	ldd	%r22,[%sp,28]                   ; @0xd6
	.cfa_restore	{%r23}                  ; @0xda
	.cfa_restore	{%r22}                  ; @0xda
	ldd	%r20,[%sp,20]                   ; @0xda
	.cfa_restore	{%r21}                  ; @0xde
	.cfa_restore	{%r20}                  ; @0xde
	ldd	%r18,[%sp,12]                   ; @0xde
	.cfa_restore	{%r19}                  ; @0xe2
	.cfa_restore	{%r18}                  ; @0xe2
	ldd	%r16,[%sp,4]                    ; @0xe2
	.cfa_restore	{%r17}                  ; @0xe6
	.cfa_restore	{%r16}                  ; @0xe6
	ld_s	%r14,[%sp,0]                    ; @0xe6
	.cfa_restore	{%r14}                  ; @0xe8
	add_s	%sp,%sp,40                      ; @0xe8
	.cfa_pop	40                              ; @0xea
	j_s	[%blink]                        ; @0xea
	.cfa_ef
.Lfunc_end0:                            ; @0xec

	.align	4                               ; -- End function
                                        ; -- Begin function matmul
matmul:                                 ; @matmul
                                        ; @0xec
.Lmatmul$local:                         ; @0xec
	.cfa_bf	.Lmatmul$local
;  %bb.0:                               ; %entry
	.cfa_same	%r5                     ; @0xec
	.cfa_same	%r4                     ; @0xec
	.cfa_same	%r3                     ; @0xec
	.cfa_same	%r2                     ; @0xec
	.cfa_same	%r1                     ; @0xec
	sub_s	%sp,%sp,16                      ; @0xec
	.cfa_push	16                      ; @0xee
	st	%r13,[%sp,0]                    ; @0xee
	.cfa_reg_offset	{%r13}, 0               ; @0xf2
	std	%r14,[%sp,4]                    ; @0xf2
	.cfa_reg_offset	{%r14}, 4               ; @0xf6
	.cfa_reg_offset	{%r15}, 8               ; @0xf6
	st	%blink,[%sp,12]                 ; @0xf6
	.cfa_reg_offset	{%blink}, 12            ; @0xfa
	brlt	%r3,1,.LBB1_9                   ; @0xfa
;  %bb.1:                               ; %for.body.lr.ph
	mov_s	%r11,0                          ; @0xfe
.LBB1_2:                                ; %for.body
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB1_4 Depth 2
                                        ;       Child Loop BB1_6 Depth 3
                                        ; @0x100
	brlt	%r4,1,.LBB1_8                   ; @0x100
;  %bb.3:                               ; %for.body4.lr.ph
                                        ;   in Loop: Header=BB1_2 Depth=1
	mpy	%r8,%r11,%r4                    ; @0x104
	mov_s	%r9,%r1                         ; @0x108
	mov_s	%r6,0                           ; @0x10a
.LBB1_4:                                ; %for.body4
                                        ;   Parent Loop BB1_2 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB1_6 Depth 3
                                        ; Label of block must be emitted
                                        ; @0x10c AlignLabel LoopTop Freq=426
	brlt	%r5,1,.LBB1_7                   ; @0x10c
;  %bb.5:                               ; %for.body8.lr.ph
                                        ;   in Loop: Header=BB1_4 Depth=2
	add	%r12,%r6,%r8                    ; @0x110
	add2	%r7,%r2,%r12                    ; @0x114
	mov_s	%blink,%r0                      ; @0x118
	ld	%r30,[%r7,0]                    ; @0x11a
	mov_s	%r12,%r9                        ; @0x11e
	mov	%r13,0                          ; @0x120
.LBB1_6:                                ; %for.body8
                                        ;   Parent Loop BB1_2 Depth=1
                                        ;     Parent Loop BB1_4 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
                                        ; Label of block must be emitted
                                        ; @0x124 AlignLabel LoopTop Freq=8533
	ld	%r14,[%blink,0]                 ; @0x124
	ld_s	%r15,[%r12,0]                   ; @0x128
	add2	%r12,%r12,%r4                   ; @0x12a
	mpy_s	%r14,%r14,%r15                  ; @0x12e
	add_s	%blink,%blink,4                 ; @0x130
	add_s	%r13,%r13,1                     ; @0x132
	add	%r30,%r14,%r30                  ; @0x134
	st	%r30,[%r7,0]                    ; @0x138
	brlt	%r13,%r5,.LBB1_6                ; @0x13c
.LBB1_7:                                ; %for.cond.cleanup7
                                        ;   in Loop: Header=BB1_4 Depth=2
                                        ; Label of block must be emitted
                                        ; @0x140 AlignLabel Freq=426
	add_s	%r9,%r9,4                       ; @0x140
	add_s	%r6,%r6,1                       ; @0x142
	brlt	%r6,%r4,.LBB1_4                 ; @0x144
.LBB1_8:                                ; %for.cond.cleanup3
                                        ;   in Loop: Header=BB1_2 Depth=1
                                        ; @0x148
	add2	%r0,%r0,%r5                     ; @0x148
	add_s	%r11,%r11,1                     ; @0x14c
	brlt	%r11,%r3,.LBB1_2                ; @0x14e
.LBB1_9:                                ; %for.cond.cleanup
                                        ; @0x152
	ld	%blink,[%sp,12]                 ; @0x152
	.cfa_restore	{%blink}                ; @0x156
	ldd	%r14,[%sp,4]                    ; @0x156
	.cfa_restore	{%r15}                  ; @0x15a
	.cfa_restore	{%r14}                  ; @0x15a
	ld_s	%r13,[%sp,0]                    ; @0x15a
	.cfa_restore	{%r13}                  ; @0x15c
	add_s	%sp,%sp,16                      ; @0x15c
	.cfa_pop	16                              ; @0x15e
	j_s	[%blink]                        ; @0x15e
	.cfa_ef
.Lfunc_end1:                            ; @0x160

	.align	4                               ; -- End function
                                        ; -- Begin function vectorized_matmul
vectorized_matmul:                      ; @vectorized_matmul
                                        ; @0x160
.Lvectorized_matmul$local:              ; @0x160
	.cfa_bf	.Lvectorized_matmul$local
;  %bb.0:                               ; %entry
	.cfa_same	%r30                    ; @0x160
	.cfa_same	%r12                    ; @0x160
	.cfa_same	%r11                    ; @0x160
	.cfa_same	%r9                     ; @0x160
	.cfa_same	%r8                     ; @0x160
	.cfa_same	%r7                     ; @0x160
	.cfa_same	%r6                     ; @0x160
	.cfa_same	%r5                     ; @0x160
	.cfa_same	%r4                     ; @0x160
	.cfa_same	%r3                     ; @0x160
	.cfa_same	%r2                     ; @0x160
	.cfa_same	%r1                     ; @0x160
	.cfa_same	%r0                     ; @0x160
	j_s	[%blink]                        ; @0x160
	.cfa_ef
.Lfunc_end2:                            ; @0x162

	.align	4                               ; -- End function
                                        ; -- Begin function autovectorized_matmul
autovectorized_matmul:                  ; @autovectorized_matmul
                                        ; @0x164
.Lautovectorized_matmul$local:          ; @0x164
	.cfa_bf	.Lautovectorized_matmul$local
;  %bb.0:                               ; %entry
	.cfa_same	%r5                     ; @0x164
	.cfa_same	%r4                     ; @0x164
	.cfa_same	%r3                     ; @0x164
	.cfa_same	%r2                     ; @0x164
	.cfa_same	%r1                     ; @0x164
	.cfa_same	%r0                     ; @0x164
	sub_s	%sp,%sp,40                      ; @0x164
	.cfa_push	40                      ; @0x166
	st	%r13,[%sp,0]                    ; @0x166
	.cfa_reg_offset	{%r13}, 0               ; @0x16a
	std	%r14,[%sp,4]                    ; @0x16a
	.cfa_reg_offset	{%r14}, 4               ; @0x16e
	.cfa_reg_offset	{%r15}, 8               ; @0x16e
	std	%r16,[%sp,12]                   ; @0x16e
	.cfa_reg_offset	{%r16}, 12              ; @0x172
	.cfa_reg_offset	{%r17}, 16              ; @0x172
	std	%r18,[%sp,20]                   ; @0x172
	.cfa_reg_offset	{%r18}, 20              ; @0x176
	.cfa_reg_offset	{%r19}, 24              ; @0x176
	std	%r20,[%sp,28]                   ; @0x176
	.cfa_reg_offset	{%r20}, 28              ; @0x17a
	.cfa_reg_offset	{%r21}, 32              ; @0x17a
	st	%blink,[%sp,36]                 ; @0x17a
	.cfa_reg_offset	{%blink}, 36            ; @0x17e
	cmp_s	%r3,0                           ; @0x17e
	ble	.LBB3_8                         ; @0x180
;  %bb.1:                               ; %for.body.lr.ph
.vvsbundle  "v3sc" 
 ;	 { 
	vvmov.w	 %vr1, 0                        ; @0x184
	vvpinit.w	%p2, 0, 65532           ; @0x184
	vvci.w	%vr2                            ; @0x184
	mov_s	%r6,0                           ; @0x184
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvpinit.w	%p1, 0, 255             ; @0x194
	seths	%r12,%r5,8                      ; @0x194
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvadd.w	%vr2, %vr2, 4                   ; @0x19e
	vvadd.w	%vr0, %vr2, 2                   ; @0x19e
	seteq	%r15,%r4,1                      ; @0x19e
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvpinit.w	%p2, 0, 65520           ; @0x1aa
	vvsel.w.p2	%vr0, %vr1, %vr0        ; @0x1aa
	and	%r11,%r12,%r15                  ; @0x1aa
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvpinit.w	%p3, 0, 3               ; @0x1ba
	bmskn	%r17,%r5,2                      ; @0x1ba
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvpinit.w	%p2, 0, 15              ; @0x1c4
	vvsel.w.p2	%vr1, %vr1, %vr2        ; @0x1c4
	and	%r8,%r5,8                       ; @0x1c4
 ;	 }
	bmskn	%r9,%r5,3                       ; @0x1d4
	mov_s	%r7,%r0                         ; @0x1d8
	mov	%r30,0                          ; @0x1da
.LBB3_2:                                ; %for.body
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB3_4 Depth 2
                                        ;       Child Loop BB3_12 Depth 3
                                        ;       Child Loop BB3_16 Depth 3
                                        ;       Child Loop BB3_19 Depth 3
                                        ; @0x1de
	cmp_s	%r4,0                           ; @0x1de
	ble	.LBB3_7                         ; @0x1e0
;  %bb.3:                               ; %for.body4.lr.ph
                                        ;   in Loop: Header=BB3_2 Depth=1
	mpy	%blink,%r30,%r4                 ; @0x1e4
	mov_s	%r18,%r1                        ; @0x1e8
	mov_s	%r19,0                          ; @0x1ea
.LBB3_4:                                ; %for.body4
                                        ;   Parent Loop BB3_2 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB3_12 Depth 3
                                        ;       Child Loop BB3_16 Depth 3
                                        ;       Child Loop BB3_19 Depth 3
                                        ; Label of block must be emitted
                                        ; @0x1ec AlignLabel LoopTop Freq=426
	cmp_s	%r5,0                           ; @0x1ec
	ble	.LBB3_21                        ; @0x1ee
;  %bb.5:                               ; %iter.check
                                        ;   in Loop: Header=BB3_4 Depth=2
	add	%r12,%r19,%blink                ; @0x1f2
	add2	%r16,%r2,%r12                   ; @0x1f6
	ld	%r21,[%r16,0]                   ; @0x1fa
	breq	%r11,0,.LBB3_6                  ; @0x1fe
;  %bb.9:                               ; %vector.main.loop.iter.check
                                        ;   in Loop: Header=BB3_4 Depth=2
	brhs	%r5,16,.LBB3_11                 ; @0x202
;  %bb.10:                              ;   in Loop: Header=BB3_4 Depth=2
	mov_s	%r13,0                          ; @0x206
	b	.LBB3_15                        ; @0x208
.LBB3_6:                                ;   in Loop: Header=BB3_4 Depth=2
                                        ; Label of block must be emitted
                                        ; @0x20c AlignLabel Freq=133
	mov_s	%r12,0                          ; @0x20c
	b_s	.LBB3_18                        ; @0x20e
.LBB3_11:                               ; %vector.ph
                                        ;   in Loop: Header=BB3_4 Depth=2
                                        ; @0x210
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr16, 0                       ; @0x210
	mov_s	%r12,0                          ; @0x210
 ;	 }
	mov_s	%r13,%r7                        ; @0x216
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr16,0,%r21            ; @0x218
	mov_s	%r15,%r18                       ; @0x218
 ;	 }
.LBB3_12:                               ; %vector.body
                                        ;   Parent Loop BB3_2 Depth=1
                                        ;     Parent Loop BB3_4 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
                                        ; Label of block must be emitted
                                        ; @0x220 AlignLabel LoopTop Freq=2133
.vvsbundle  "v1sc" 
 ;	 { 
	vvld.av.w	%vr2,%r13,1             ; @0x220
	add_s	%r12,%r12,16                    ; @0x220
 ;	 }
	vvld.av.w	%vr3,%r15,1             ; @0x228
	vvcmac.lo.uu.w	%vr16, %vr3, %vr2       ; @0x22e
	brne	%r12,%r9,.LBB3_12               ; @0x234
;  %bb.13:                              ; %middle.block
                                        ;   in Loop: Header=BB3_4 Depth=2
	vvc2add.w	%vr16                   ; @0x238
	vvshfleven.w	%vr16, %vr16            ; @0x23c
	vvc2add.w	%vr16                   ; @0x240
	vvshfleven.w	%vr16, %vr16            ; @0x244
	vvc2add.w	%vr16                   ; @0x248
	vvshfleven.w	%vr16, %vr16            ; @0x24c
	vvc2add.w	%vr16                   ; @0x250
	vvmov1.x.from.w	%r21,%vr16,0            ; @0x254
	breq	%r9,%r5,.LBB3_20                ; @0x25a
;  %bb.14:                              ; %vec.epilog.iter.check
                                        ;   in Loop: Header=BB3_4 Depth=2
	mov_s	%r13,%r9                        ; @0x25e
	mov_s	%r12,%r9                        ; @0x260
	breq	%r8,0,.LBB3_18                  ; @0x262
.LBB3_15:                               ; %vec.epilog.ph
                                        ;   in Loop: Header=BB3_4 Depth=2
                                        ; @0x266
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr2, 0                        ; @0x266
	add	%r12,%r6,%r13                   ; @0x266
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,0,%r21             ; @0x26e
	add	%r14,%r13,%r19                  ; @0x26e
 ;	 }
	add2	%r12,%r0,%r12                   ; @0x278
	add2	%r15,%r1,%r14                   ; @0x27c
.LBB3_16:                               ; %vec.epilog.vector.body
                                        ;   Parent Loop BB3_2 Depth=1
                                        ;     Parent Loop BB3_4 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
                                        ; Label of block must be emitted
                                        ; @0x280 AlignLabel LoopTop Freq=2666
.vvsbundle  "v1sc" 
 ;	 { 
	vvld.ab.w.p1	%vr3,%r12,32            ; @0x280
	add_s	%r13,%r13,8                     ; @0x280
 ;	 }
	vvld.ab.w.p1	%vr4,%r15,32            ; @0x28a
	vvmpy.w	%vr3, %vr4, %vr3                ; @0x292
	vvadd.w	%vr2, %vr3, %vr2                ; @0x298
	brne	%r13,%r17,.LBB3_16              ; @0x29e
;  %bb.17:                              ; %vec.epilog.middle.block
                                        ;   in Loop: Header=BB3_4 Depth=2

	vvshfl.w.p2	%vr3, %vr2, %vr1        ; implicit-def: $vr3
                                        ; @0x2a2
	vvadd.w	%vr2, %vr2, %vr3                ; @0x2a8
	vvshfl.w.p3	%vr3, %vr2, %vr0        ; @0x2ac
	vvadd.w	%vr2, %vr2, %vr3                ; @0x2b2
	vvmov1.from.w	%r12,%vr2,1             ; @0x2b6
.vvsbundle  "v1sc" 
 ;	 { 
	vvadd.w	%vr2, %vr2, %r12                ; @0x2bc
	mov_s	%r12,%r17                       ; @0x2bc
 ;	 }
	vvmov1.x.from.w	%r21,%vr2,0             ; @0x2c2
	breq	%r17,%r5,.LBB3_20               ; @0x2c8
.LBB3_18:                               ; %for.body8.preheader
                                        ;   in Loop: Header=BB3_4 Depth=2
                                        ; Label of block must be emitted
                                        ; @0x2cc AlignLabel Freq=191
	mpy	%r14,%r12,%r4                   ; @0x2cc
	add	%r13,%r6,%r12                   ; @0x2d0
	add2	%r13,%r0,%r13                   ; @0x2d4
	add	%r14,%r14,%r19                  ; @0x2d8
	add2	%r14,%r1,%r14                   ; @0x2dc
.LBB3_19:                               ; %for.body8
                                        ;   Parent Loop BB3_2 Depth=1
                                        ;     Parent Loop BB3_4 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
                                        ; Label of block must be emitted
                                        ; @0x2e0 AlignLabel LoopTop Freq=6133
	add2	%r20,%r14,%r4                   ; @0x2e0
	ld_s	%r14,[%r14,0]                   ; @0x2e4
	ld_s	%r15,[%r13,0]                   ; @0x2e6
	add_s	%r13,%r13,4                     ; @0x2e8
	add_s	%r12,%r12,1                     ; @0x2ea
	mpy_s	%r14,%r14,%r15                  ; @0x2ec
	add	%r21,%r14,%r21                  ; @0x2ee
	mov_s	%r14,%r20                       ; @0x2f2
	brlt	%r12,%r5,.LBB3_19               ; @0x2f4
.LBB3_20:                               ; %for.cond5.for.cond.cleanup7_crit_edge
                                        ;   in Loop: Header=BB3_4 Depth=2
                                        ; Label of block must be emitted
                                        ; @0x2f8 AlignLabel Freq=266
	st	%r21,[%r16,0]                   ; @0x2f8
.LBB3_21:                               ; %for.cond.cleanup7
                                        ;   in Loop: Header=BB3_4 Depth=2
                                        ; Label of block must be emitted
                                        ; @0x2fc AlignLabel Freq=426
	add_s	%r19,%r19,1                     ; @0x2fc
	add_s	%r18,%r18,4                     ; @0x2fe
	cmp	%r19,%r4                        ; @0x300
	blt	.LBB3_4                         ; @0x304
.LBB3_7:                                ; %for.cond.cleanup3
                                        ;   in Loop: Header=BB3_2 Depth=1
                                        ; @0x308
	add2	%r7,%r7,%r5                     ; @0x308
	add	%r30,%r30,1                     ; @0x30c
	add	%r6,%r6,%r5                     ; @0x310
	cmp	%r30,%r3                        ; @0x314
	blt	.LBB3_2                         ; @0x318
.LBB3_8:                                ; %for.cond.cleanup
                                        ; @0x31c
	ld	%blink,[%sp,36]                 ; @0x31c
	.cfa_restore	{%blink}                ; @0x320
	ldd	%r20,[%sp,28]                   ; @0x320
	.cfa_restore	{%r21}                  ; @0x324
	.cfa_restore	{%r20}                  ; @0x324
	ldd	%r18,[%sp,20]                   ; @0x324
	.cfa_restore	{%r19}                  ; @0x328
	.cfa_restore	{%r18}                  ; @0x328
	ldd	%r16,[%sp,12]                   ; @0x328
	.cfa_restore	{%r17}                  ; @0x32c
	.cfa_restore	{%r16}                  ; @0x32c
	ldd	%r14,[%sp,4]                    ; @0x32c
	.cfa_restore	{%r15}                  ; @0x330
	.cfa_restore	{%r14}                  ; @0x330
	ld_s	%r13,[%sp,0]                    ; @0x330
	.cfa_restore	{%r13}                  ; @0x332
	add_s	%sp,%sp,40                      ; @0x332
	.cfa_pop	40                              ; @0x334
	j_s	[%blink]                        ; @0x334
	.cfa_ef
.Lfunc_end3:                            ; @0x336

	.reloc	_init_ad,0	;startup code to enable %status AD bit ; -- End function
