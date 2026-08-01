	.option	%reg
	.off	assume_short
	.file	"conv2d.c"
	.size	.L.str.4, 3
	.type	.L.str.4,@object
	.size	.Lstr.12, 3
	.type	.Lstr.12,@object
	.size	.Lstr.10, 2
	.type	.Lstr.10,@object
	.size	.Lstr.11, 2
	.type	.Lstr.11,@object
	.size	.L.str.5, 3
	.type	.L.str.5,@object
	.size	.L.str.6, 4
	.type	.L.str.6,@object
	.size	.Lstr, 33
	.type	.Lstr,@object
	.size	.Lstr.9, 38
	.type	.Lstr.9,@object
	.size	.L.str.1, 44
	.type	.L.str.1,@object
	.globl	init_matrix
	.type	init_matrix,@function
	.type	.Linit_matrix$local,@function
	.size	init_matrix, .Lfunc_end0-init_matrix
	.size	.Linit_matrix$local, .Lfunc_end0-init_matrix
	.globl	check_result
	.type	check_result,@function
	.type	.Lcheck_result$local,@function
	.size	check_result, .Lfunc_end1-check_result
	.size	.Lcheck_result$local, .Lfunc_end1-check_result
	.globl	copy_matrix
	.type	copy_matrix,@function
	.type	.Lcopy_matrix$local,@function
	.size	copy_matrix, .Lfunc_end2-copy_matrix
	.size	.Lcopy_matrix$local, .Lfunc_end2-copy_matrix
	.globl	print_matrix
	.type	print_matrix,@function
	.type	.Lprint_matrix$local,@function
	.size	print_matrix, .Lfunc_end3-print_matrix
	.size	.Lprint_matrix$local, .Lfunc_end3-print_matrix
	.globl	conv2d
	.type	conv2d,@function
	.type	.Lconv2d$local,@function
	.size	conv2d, .Lfunc_end4-conv2d
	.size	.Lconv2d$local, .Lfunc_end4-conv2d
	.globl	vectorized_conv2d
	.type	vectorized_conv2d,@function
	.type	.Lvectorized_conv2d$local,@function
	.size	vectorized_conv2d, .Lfunc_end5-vectorized_conv2d
	.size	.Lvectorized_conv2d$local, .Lfunc_end5-vectorized_conv2d
	.globl	autovectorized_conv2d
	.type	autovectorized_conv2d,@function
	.type	.Lautovectorized_conv2d$local,@function
	.size	autovectorized_conv2d, .Lfunc_end6-autovectorized_conv2d
	.size	.Lautovectorized_conv2d$local, .Lfunc_end6-autovectorized_conv2d
	.globl	vekt_conv2d_wrapper
	.type	vekt_conv2d_wrapper,@function
	.type	.Lvekt_conv2d_wrapper$local,@function
	.size	vekt_conv2d_wrapper, .Lfunc_end7-vekt_conv2d_wrapper
	.size	.Lvekt_conv2d_wrapper$local, .Lfunc_end7-vekt_conv2d_wrapper
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
	.align	4
.L.str.4:                               ; @0x0
	.asciz	"\t["
	.align	4
.Lstr.12:                               ; @0x4
	.asciz	"],"
	.align	2
.Lstr.10:                               ; @0x8
	.asciz	"["
	.align	2
.Lstr.11:                               ; @0xa
	.asciz	"]"
	.align	4
.L.str.5:                               ; @0xc
	.asciz	"%d"
	.align	4
.L.str.6:                               ; @0x10
	.asciz	"%d,"
	.align	4
.Lstr:                                  ; @0x14
	.asciz	"SUCCESSO! Le matrici sono uguali"
	.align	4
.Lstr.9:                                ; @0x38
	.asciz	"ERRORE! Le matrici non corrispondono!"
	.align	4
.L.str.1:                               ; @0x60
	.asciz	"\tElemento (%d, %d) di A = %d mentre B = %d\n"
	.text
	.global	.CC_I
	.equ	.CC_I, 0
	.ident	"LLVM 17.0.7/V-2024.06. (build 008) (LLVM 17.0.7) -arcv2hs -core4 -Xcode_density -Xatomic -Xll64 -Xunaligned -Xdiv_rem=radix4 -Xswap -Xbitscan -Xmpy_option=mpyd -Xshift_assist -Xbarrel_shifter -Xfpud_div -Xfpu_mac -Xtimer0 -Xrtc -Xstack_check -Xstu=4 -Xvdsp4 -Xvec_unit_rev_minor=1 -Xvec_width=512 -Xvec_mem_size=128k -Xvec_mem_bank_width=16 -Xvec_max_fetch_size=16 -Xvec_num_slots=3 -Xvec_super_with_scalar -Xvec_regs=32 -Xvec_fpu=32 -Xvec_fpu_math=3 -Xvec_fpu_2nd_mul -Xvec_fpu_types=2 -Xvec_num_rd_ports=6 -Xvec_num_acc=8 -Xvec_num_mpy=2 -Xvec_mpy32 -Xvec_num_alu=3 -Xvec_guard_bit_option=0 -Xvec_stack_check -Hvdsp_vector_c -O3 -fno-unroll-loops -fvectorize -fslp-vectorize -ffast-math"
	.align	8                               ; -- Begin function init_matrix
init_matrix:                            ; @init_matrix
                                        ; @0x0
.Linit_matrix$local:                    ; @0x0
	.cfa_bf	.Linit_matrix$local
;  %bb.0:                               ; %entry
	.cfa_same	%r3                     ; @0x0
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
	mpy_s	%r1,%r1,%r2                     ; @0x14
	brlt	%r1,1,.LBB0_12                  ; @0x16
;  %bb.1:                               ; %iter.check
	mov_s	%r2,0                           ; @0x1a
	brlo	%r1,8,.LBB0_10                  ; @0x1c
;  %bb.2:                               ; %vector.main.loop.iter.check
	vvmov.w	 %vr0, %r3                      ; @0x20
	brlo	%r1,16,.LBB0_7                  ; @0x24
;  %bb.3:                               ; %vector.ph
	; Implicit def %r30                     ; @0x28
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r4,%vr0,0              ; @0x28
	sub	%r12,%r1,16                     ; @0x28
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r6,%vr0,2              ; @0x32
	lsr_s	%r12,%r12,4                     ; @0x32
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r8,%vr0,4              ; @0x3a
	bmskn	%r2,%r1,3                       ; @0x3a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r22,%vr0,6             ; @0x44
	add	%lp_count,%r12,1                ; @0x44
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r20,%vr0,8             ; @0x4e
	mov_s	%r12,%r0                        ; @0x4e
 ;	 }
	vvmov2.x.from.w	%r18,%vr0,10            ; @0x56
	vvmov2.x.from.w	%r16,%vr0,12            ; @0x5c
	vvmov2.x.from.w	%r14,%vr0,14            ; @0x62
	lp	.LZD2                           ; @0x68
.LBB0_4:                                ; %vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x6c
	std	%r14,[%r12,56]                  ; @0x6c
	std	%r16,[%r12,48]                  ; @0x70
	std	%r18,[%r12,40]                  ; @0x74
	std	%r20,[%r12,32]                  ; @0x78
	std	%r22,[%r12,24]                  ; @0x7c
	std	%r8,[%r12,16]                   ; @0x80
	std	%r6,[%r12,8]                    ; @0x84
	std.ab	%r4,[%r12,64]                   ; @0x88
.LZD2:                                  ; @0x8c
	; ZD Loop End                           ; @0x8c
;  %bb.5:                               ; %middle.block
	breq	%r1,%r2,.LBB0_12                ; @0x8c
;  %bb.6:                               ; %vec.epilog.iter.check
	bbit0	%r1,3,.LBB0_10                  ; @0x90
.LBB0_7:                                ; %vec.epilog.ph
                                        ; @0x94
	; Implicit def %r30                     ; @0x94
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r4,%vr0,0              ; @0x94
	sub_s	%r15,%r1,%r2                    ; @0x94
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r6,%vr0,2              ; @0x9c
	sub_s	%r15,%r15,8                     ; @0x9c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r8,%vr0,4              ; @0xa4
	lsr_s	%r15,%r15,3                     ; @0xa4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r22,%vr0,6             ; @0xac
	add2	%r12,%r0,%r2                    ; @0xac
 ;	 }
	bmskn	%r2,%r1,2                       ; @0xb6
	add	%lp_count,%r15,1                ; @0xba
	lp	.LZD1                           ; @0xbe
.LBB0_8:                                ; %vec.epilog.vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0xc2
	std	%r22,[%r12,24]                  ; @0xc2
	std	%r8,[%r12,16]                   ; @0xc6
	std	%r6,[%r12,8]                    ; @0xca
	std.ab	%r4,[%r12,32]                   ; @0xce
.LZD1:                                  ; @0xd2
	; ZD Loop End                           ; @0xd2
;  %bb.9:                               ; %vec.epilog.middle.block
	breq	%r1,%r2,.LBB0_12                ; @0xd2
.LBB0_10:                               ; %for.body.preheader
                                        ; @0xd6
	add_s	%r12,%r2,1                      ; @0xd6
	max	%r1,%r1,%r12                    ; @0xd8
	add2_s	%r0,%r0,%r2                     ; @0xdc
	sub	%lp_count,%r1,%r2               ; @0xde
	; Implicit def %r2                      ; @0xe2
	lp	.LZD0                           ; @0xe2
.LBB0_11:                               ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0xe6
	st.ab	%r3,[%r0,4]                     ; @0xe6
.LZD0:                                  ; @0xea
	; ZD Loop End                           ; @0xea
.LBB0_12:                               ; %for.cond.cleanup
                                        ; @0xea
	ldd	%r22,[%sp,32]                   ; @0xea
	.cfa_restore	{%r23}                  ; @0xee
	.cfa_restore	{%r22}                  ; @0xee
	ldd	%r20,[%sp,24]                   ; @0xee
	.cfa_restore	{%r21}                  ; @0xf2
	.cfa_restore	{%r20}                  ; @0xf2
	ldd	%r18,[%sp,16]                   ; @0xf2
	.cfa_restore	{%r19}                  ; @0xf6
	.cfa_restore	{%r18}                  ; @0xf6
	ldd	%r16,[%sp,8]                    ; @0xf6
	.cfa_restore	{%r17}                  ; @0xfa
	.cfa_restore	{%r16}                  ; @0xfa
	ldd.ab	%r14,[%sp,40]                   ; @0xfa
	.cfa_restore	{%r15}                  ; @0xfe
	.cfa_restore	{%r14}                  ; @0xfe
	.cfa_pop	40                              ; @0xfe
	j_s	[%blink]                        ; @0xfe
	.cfa_ef
.Lfunc_end0:                            ; @0x100

	.align	4                               ; -- End function
                                        ; -- Begin function check_result
check_result:                           ; @check_result
                                        ; @0x100
.Lcheck_result$local:                   ; @0x100
	.cfa_bf	.Lcheck_result$local
;  %bb.0:                               ; %entry
	st.aw	%r13,[%sp,-24]                  ; @0x100
	.cfa_push	24                      ; @0x104
	.cfa_reg_offset	{%r13}, 0               ; @0x104
	std	%r14,[%sp,4]                    ; @0x104
	.cfa_reg_offset	{%r14}, 4               ; @0x108
	.cfa_reg_offset	{%r15}, 8               ; @0x108
	std	%r16,[%sp,12]                   ; @0x108
	.cfa_reg_offset	{%r16}, 12              ; @0x10c
	.cfa_reg_offset	{%r17}, 16              ; @0x10c
	st	%blink,[%sp,20]                 ; @0x10c
	.cfa_reg_offset	{%blink}, 20            ; @0x110
	cmp_s	%r2,0                           ; @0x110
	mov_s	%r11,%r2                        ; @0x112
	mov_s	%r16,.Lstr                      ; @0x114
	cmp.gt	%r3,0                           ; @0x11a
	ble	.LBB1_8                         ; Predicate Case 4
                                        ; @0x11e
;  %bb.2:                               ; %for.body4.lr.ph.us.preheader
	mov_s	%r17,0                          ; @0x122
.LBB1_4:                                ; %for.body4.lr.ph.us
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB1_5 Depth 2
                                        ; @0x124
	; Implicit def %r12                     ; @0x124
	mov	%lp_count,%r3                   ; @0x124
	mov_s	%r13,%r0                        ; @0x128
	mov_s	%r15,%r1                        ; @0x12a
	mov_s	%r14,0                          ; @0x12c
	lp	.LZD3                           ; @0x12e
.LBB1_5:                                ; %for.body4.us
                                        ;   Parent Loop BB1_4 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; @0x132
	ld.ab	%r12,[%r15,4]                   ; @0x132
	ld.ab	%r2,[%r13,4]                    ; @0x136
	brne	%r2,%r12,.LBB1_7                ; @0x13a
;  %bb.6:                               ; %for.inc.us
                                        ;   in Loop: Header=BB1_5 Depth=2
	add_s	%r14,%r14,1                     ; @0x13e
.LZD3:                                  ; @0x140
	; ZD Loop End                           ; @0x140
;  %bb.3:                               ; %for.inc16.us
                                        ;   in Loop: Header=BB1_4 Depth=1
	add2_s	%r0,%r0,%r3                     ; @0x140
	add2_s	%r1,%r1,%r3                     ; @0x142
	add_s	%r17,%r17,1                     ; @0x144
	brlt	%r17,%r11,.LBB1_4               ; @0x146
.LBB1_8:                                ; %for.end20
                                        ; @0x14a
	mov_s	%r0,%r16                        ; @0x14a
	bl	puts                            ; @0x14c
	b	.LBB1_9                         ; widened to benefit BPU
                                        ; @0x150
.LBB1_7:                                ; %cleanup18
                                        ; @0x154
	add	%r0,%r16,.Lstr.9-.Lstr          ; @0x154
	bl	puts                            ; @0x158
	ld	%r3,[%r13,-4]                   ; @0x15c
	ld	%r4,[%r15,-4]                   ; @0x160
	add1	%r0,%r16,(.L.str.1-.Lstr)/2     ; @0x164
	mov_s	%r1,%r17                        ; @0x168
	mov_s	%r2,%r14                        ; @0x16a
	bl	printf                          ; @0x16c
.LBB1_9:                                ; %return
                                        ; @0x170
	ld	%blink,[%sp,20]                 ; @0x170
	.cfa_restore	{%blink}                ; @0x174
	ldd	%r16,[%sp,12]                   ; @0x174
	.cfa_restore	{%r17}                  ; @0x178
	.cfa_restore	{%r16}                  ; @0x178
	ldd	%r14,[%sp,4]                    ; @0x178
	.cfa_restore	{%r15}                  ; @0x17c
	.cfa_restore	{%r14}                  ; @0x17c
	ld.ab	%r13,[%sp,24]                   ; @0x17c
	.cfa_restore	{%r13}                  ; @0x180
	.cfa_pop	24                              ; @0x180
	j_s	[%blink]                        ; @0x180
	.cfa_ef
.Lfunc_end1:                            ; @0x182

	.align	4                               ; -- End function
                                        ; -- Begin function copy_matrix
copy_matrix:                            ; @copy_matrix
                                        ; @0x184
.Lcopy_matrix$local:                    ; @0x184
	.cfa_bf	.Lcopy_matrix$local
;  %bb.0:                               ; %entry
	st.aw	%r13,[%sp,-72]                  ; @0x184
	.cfa_push	72                      ; @0x188
	.cfa_reg_offset	{%r13}, 0               ; @0x188
	std	%r14,[%sp,4]                    ; @0x188
	.cfa_reg_offset	{%r14}, 4               ; @0x18c
	.cfa_reg_offset	{%r15}, 8               ; @0x18c
	std	%r16,[%sp,12]                   ; @0x18c
	.cfa_reg_offset	{%r16}, 12              ; @0x190
	.cfa_reg_offset	{%r17}, 16              ; @0x190
	std	%r18,[%sp,20]                   ; @0x190
	.cfa_reg_offset	{%r18}, 20              ; @0x194
	.cfa_reg_offset	{%r19}, 24              ; @0x194
	std	%r20,[%sp,28]                   ; @0x194
	.cfa_reg_offset	{%r20}, 28              ; @0x198
	.cfa_reg_offset	{%r21}, 32              ; @0x198
	std	%r22,[%sp,36]                   ; @0x198
	.cfa_reg_offset	{%r22}, 36              ; @0x19c
	.cfa_reg_offset	{%r23}, 40              ; @0x19c
	st	%r24,[%sp,44]                   ; @0x19c
	.cfa_reg_offset	{%r24}, 44              ; @0x1a0
	st	%fp,[%sp,48]                    ; @0x1a0
	.cfa_reg_offset	{%fp}, 48               ; @0x1a4
	st	%blink,[%sp,52]                 ; @0x1a4
	.cfa_reg_offset	{%blink}, 52            ; @0x1a8
	mov	%r58,%r0                        ; @0x1a8
	cmp_s	%r2,0                           ; @0x1ac
	ble	.LBB2_38                        ; @0x1ae
;  %bb.1:                               ; %entry
	mov_s	%r24,%r3                        ; @0x1b2
	cmp	%r3,0                           ; @0x1b4
	ble	.LBB2_38                        ; @0x1b8
;  %bb.2:                               ; %for.body.lr.ph.split.us
	brhs	%r24,8,.LBB2_6                  ; @0x1bc
;  %bb.3:                               ; %iter.check.us.preheader
	mov	%r0,%r58                        ; @0x1c0
.LBB2_4:                                ; %iter.check.us
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB2_5 Depth 2
                                        ; @0x1c4
	; Implicit def %r11                     ; @0x1c4
	mov	%lp_count,%r24                  ; @0x1c4
	lp	.LZD4                           ; @0x1c8
.LBB2_5:                                ; %for.body4.us.us
                                        ;   Parent Loop BB2_4 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; Label of block must be emitted
                                        ; @0x1cc AlignLabel LoopTop Freq=255
	ld.ab	%r3,[%r1,4]                     ; @0x1cc
	st.ab	%r3,[%r0,4]                     ; @0x1d0
.LZD4:                                  ; @0x1d4
	; ZD Loop End                           ; @0x1d4
;  %bb.37:                              ; %for.cond.cleanup3.us.loopexit.us
                                        ;   in Loop: Header=BB2_4 Depth=1
	dbnz	%r2,.LBB2_4                     ; @0x1d4
	b	.LBB2_38                        ; @0x1d8
.LBB2_6:                                ; %for.body.lr.ph.split.us.split
                                        ; @0x1dc
	asl	%fp,%r24,2                      ; @0x1dc
	bmskn	%r30,%r24,2                     ; @0x1e0
	brhs	%r24,16,.LBB2_16                ; @0x1e4
;  %bb.7:                               ; %iter.check.us36.preheader
	mov_s	%r8,%r1                         ; @0x1e8
	mov	%r7,%r58                        ; @0x1ea
	mov_s	%r13,0                          ; @0x1ee
	mov_s	%r12,0                          ; @0x1f0
.LBB2_8:                                ; %iter.check.us36
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB2_11 Depth 2
                                        ;     Child Loop BB2_14 Depth 2
                                        ; @0x1f2
	mpy	%r0,%fp,%r12                    ; @0x1f2
	add	%r3,%fp,%r0                     ; @0x1f6
	add	%r14,%r58,%r0                   ; @0x1fa
	add_s	%r15,%r1,%r3                    ; @0x1fe
	brhs	%r14,%r15,.LBB2_10              ; @0x200
;  %bb.9:                               ; %iter.check.us36
                                        ;   in Loop: Header=BB2_8 Depth=1
	add_s	%r15,%r1,%r0                    ; @0x204
	add	%r3,%r58,%r3                    ; @0x206
	mov_s	%r0,0                           ; @0x20a
	brlo	%r15,%r3,.LBB2_13               ; @0x20c
.LBB2_10:                               ; %vec.epilog.vector.body.us.preheader
                                        ;   in Loop: Header=BB2_8 Depth=1
                                        ; @0x210
	mov_s	%r0,%r8                         ; @0x210
	mov_s	%r3,%r7                         ; @0x212
	mov_s	%r14,1                          ; @0x214
.LBB2_11:                               ; %vec.epilog.vector.body.us
                                        ;   Parent Loop BB2_8 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; @0x216
	ldd	%r4,[%r0,24]                    ; @0x216
	ldd	%r22,[%r0,16]                   ; @0x21a
	ldd	%r20,[%r0,8]                    ; @0x21e
	ldd.ab	%r18,[%r0,32]                   ; @0x222
	std	%r4,[%r3,24]                    ; @0x226
	std	%r22,[%r3,16]                   ; @0x22a
	std	%r20,[%r3,8]                    ; @0x22e
	std.ab	%r18,[%r3,32]                   ; @0x232
	dbnz	%r14,.LBB2_11                   ; @0x236
;  %bb.12:                              ; %vec.epilog.middle.block.us
                                        ;   in Loop: Header=BB2_8 Depth=1
	mov	%r0,%r30                        ; @0x23a
	breq	%r30,%r24,.LBB2_15              ; @0x23e
.LBB2_13:                               ; %for.body4.us.us39.preheader
                                        ;   in Loop: Header=BB2_8 Depth=1
                                        ; @0x242
	; Implicit def %r6                      ; @0x242
	add_s	%r3,%r0,1                       ; @0x242
	add_s	%r15,%r0,%r13                   ; @0x244
	max	%r3,%r24,%r3                    ; @0x246
	sub	%lp_count,%r3,%r0               ; @0x24a
	add2	%r0,%r1,%r15                    ; @0x24e
	add2	%r3,%r58,%r15                   ; @0x252
	lp	.LZD7                           ; @0x256
.LBB2_14:                               ; %for.body4.us.us39
                                        ;   Parent Loop BB2_8 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; @0x25a
	ld.ab	%r15,[%r0,4]                    ; @0x25a
	st.ab	%r15,[%r3,4]                    ; @0x25e
.LZD7:                                  ; @0x262
	; ZD Loop End                           ; @0x262
.LBB2_15:                               ; %for.cond.cleanup3.us.us46
                                        ;   in Loop: Header=BB2_8 Depth=1
                                        ; @0x262
	add_s	%r12,%r12,1                     ; @0x262
	add_s	%r13,%r13,%r24                  ; @0x264
	add	%r8,%r8,%fp                     ; @0x266
	add	%r7,%r7,%fp                     ; @0x26a
	brlt	%r12,%r2,.LBB2_8                ; @0x26e
	b	.LBB2_38                        ; @0x272
.LBB2_16:                               ; %for.body.lr.ph.split.us.split.split
                                        ; @0x276
	bmskn	%blink,%r24,3                   ; @0x276
	brne	%blink,%r24,.LBB2_17            ; @0x27a
;  %bb.18:                              ; %iter.check.us52.preheader
	sub	%r0,%r24,16                     ; @0x27e
	lsr_s	%r0,%r0,4                       ; @0x282
	mov_s	%r11,%r1                        ; @0x284
	mov	%r14,%r58                       ; @0x286
	mov_s	%r12,0                          ; @0x28a
	add	%r59,%r0,1                      ; @0x28c
.LBB2_19:                               ; %iter.check.us52
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB2_24 Depth 2
                                        ;     Child Loop BB2_22 Depth 2
                                        ; @0x290
	mpy	%r0,%fp,%r12                    ; @0x290
	add	%r3,%fp,%r0                     ; @0x294
	add	%r15,%r58,%r0                   ; @0x298
	add_s	%r13,%r1,%r3                    ; @0x29c
	cmp_s	%r15,%r13                       ; @0x29e
	add_s	%r0,%r1,%r0                     ; @0x2a0
	add	%r3,%r58,%r3                    ; Predicate Case 4
                                        ; @0x2a2
	cmp.cs	%r0,%r3                         ; Predicate Case 4
                                        ; @0x2a6
	bcc	.LBB2_21                        ; Predicate Case 4
                                        ; @0x2aa
;  %bb.23:                              ; %for.body4.us.us55.preheader
                                        ;   in Loop: Header=BB2_19 Depth=1
	; Implicit def %r6                      ; @0x2ae
	mov	%lp_count,%r24                  ; @0x2ae
	mov_s	%r0,%r11                        ; @0x2b2
	mov_s	%r3,%r14                        ; @0x2b4
	lp	.LZD9                           ; @0x2b6
.LBB2_24:                               ; %for.body4.us.us55
                                        ;   Parent Loop BB2_19 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; @0x2ba
	ld.ab	%r15,[%r0,4]                    ; @0x2ba
	st.ab	%r15,[%r3,4]                    ; @0x2be
.LZD9:                                  ; @0x2c2
	; ZD Loop End                           ; @0x2c2
	nop                                     ; inserted to benefit BPU
                                        ; @0x2c2
	nop                                     ; widened to benefit BPU
                                        ; inserted to benefit BPU
                                        ; @0x2c6
	b	.LBB2_25                        ; @0x2ca
.LBB2_21:                               ; %vector.body.us.preheader
                                        ;   in Loop: Header=BB2_19 Depth=1
                                        ; @0x2ce
	; Implicit def %r6                      ; @0x2ce
	mov	%lp_count,%r59                  ; @0x2ce
	mov_s	%r0,%r11                        ; @0x2d2
	mov_s	%r3,%r14                        ; @0x2d4
	lp	.LZD8                           ; @0x2d6
.LBB2_22:                               ; %vector.body.us
                                        ;   Parent Loop BB2_19 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; @0x2da
	ldd	%r4,[%r0,56]                    ; @0x2da
	ldd	%r22,[%r0,48]                   ; @0x2de
	ldd	%r20,[%r0,40]                   ; @0x2e2
	ldd	%r18,[%r0,32]                   ; @0x2e6
	ldd	%r30,[%r0,24]                   ; @0x2ea
	ldd	%r6,[%r0,16]                    ; @0x2ee
	ldd	%r16,[%r0,8]                    ; @0x2f2
	ldd.ab	%r8,[%r0,64]                    ; @0x2f6
	std	%r4,[%r3,56]                    ; @0x2fa
	std	%r22,[%r3,48]                   ; @0x2fe
	std	%r20,[%r3,40]                   ; @0x302
	std	%r18,[%r3,32]                   ; @0x306
	std	%r30,[%r3,24]                   ; @0x30a
	std	%r6,[%r3,16]                    ; @0x30e
	std	%r16,[%r3,8]                    ; @0x312
	std.ab	%r8,[%r3,64]                    ; @0x316
.LZD8:                                  ; @0x31a
	; ZD Loop End                           ; @0x31a
.LBB2_25:                               ; %for.cond.cleanup3.us.us62
                                        ;   in Loop: Header=BB2_19 Depth=1
                                        ; @0x31a
	add_s	%r12,%r12,1                     ; @0x31a
	add	%r11,%r11,%fp                   ; @0x31c
	add_s	%r14,%r14,%fp                   ; @0x320
	brlt	%r12,%r2,.LBB2_19               ; @0x322
	b_s	.LBB2_38                        ; @0x326
.LBB2_17:                               ; %iter.check.preheader
                                        ; @0x328
	sub	%r0,%r24,%blink                 ; @0x328
	sub_s	%r0,%r0,8                       ; @0x32c
	sub	%r12,%r24,16                    ; @0x32e
	lsr	%r3,%r0,3                       ; @0x332
	bmskn	%r4,%fp,5                       ; @0x336
	lsr_s	%r12,%r12,4                     ; @0x33a
	add_s	%r3,%r3,1                       ; @0x33c
	mov_s	%r16,%r1                        ; @0x33e
	mov	%r9,%r58                        ; @0x340
	add	%r0,%r1,%r4                     ; @0x344
	add	%r13,%r58,%r4                   ; @0x348
	st	%r3,[%sp,56]                    ; 4-byte Folded Spill
                                        ; @0x34c
	add_s	%r3,%r12,1                      ; @0x350
	mov_s	%r8,0                           ; @0x352
	mov_s	%r11,0                          ; @0x354
	st	%r3,[%sp,60]                    ; 4-byte Folded Spill
                                        ; @0x356
	st	%r58,[%sp,64]                   ; 4-byte Folded Spill
                                        ; @0x35a
.LBB2_27:                               ; %iter.check
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB2_30 Depth 2
                                        ;     Child Loop BB2_33 Depth 2
                                        ;     Child Loop BB2_36 Depth 2
                                        ; @0x35e
	mpy	%r12,%fp,%r11                   ; @0x35e
	add	%r14,%fp,%r12                   ; @0x362
	add	%r15,%r58,%r12                  ; @0x366
	add_s	%r3,%r1,%r14                    ; @0x36a
	brhs	%r15,%r3,.LBB2_29               ; @0x36c
;  %bb.28:                              ; %iter.check
                                        ;   in Loop: Header=BB2_27 Depth=1
	add_s	%r3,%r1,%r12                    ; @0x370
	add	%r14,%r58,%r14                  ; @0x372
	mov_s	%r12,0                          ; @0x376
	brlo	%r3,%r14,.LBB2_35               ; @0x378
.LBB2_29:                               ; %vector.body.preheader
                                        ;   in Loop: Header=BB2_27 Depth=1
                                        ; @0x37c
	; Implicit def %r4                      ; @0x37c
	ld_s	%r12,[%sp,60]                   ; 4-byte Folded Reload
                                        ; @0x37c
	st	%r13,[%sp,68]                   ; 4-byte Folded Spill
                                        ; @0x37e
	mov_s	%r13,%r0                        ; @0x382
	mov_s	%r3,%blink                      ; @0x384
	mov	%r0,%r30                        ; @0x386
	mov	%lp_count,%r12                  ; @0x38a
	mov_s	%r15,%r16                       ; @0x38e
	mov_s	%r12,%r16                       ; @0x390
	mov_s	%r14,%r9                        ; @0x392
	lp	.LZD10                          ; @0x394
.LBB2_30:                               ; %vector.body
                                        ;   Parent Loop BB2_27 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; @0x398
	ldd	%r16,[%r12,56]                  ; @0x398
	ldd	%r18,[%r12,48]                  ; @0x39c
	ldd	%r20,[%r12,40]                  ; @0x3a0
	ldd	%r22,[%r12,32]                  ; @0x3a4
	ldd	%r58,[%r12,24]                  ; @0x3a8
	ldd	%r6,[%r12,16]                   ; @0x3ac
	ldd	%r4,[%r12,8]                    ; @0x3b0
	ldd.ab	%r30,[%r12,64]                  ; @0x3b4
	std	%r16,[%r14,56]                  ; @0x3b8
	std	%r18,[%r14,48]                  ; @0x3bc
	std	%r20,[%r14,40]                  ; @0x3c0
	std	%r22,[%r14,32]                  ; @0x3c4
	std	%r58,[%r14,24]                  ; @0x3c8
	std	%r6,[%r14,16]                   ; @0x3cc
	std	%r4,[%r14,8]                    ; @0x3d0
	std.ab	%r30,[%r14,64]                  ; @0x3d4
.LZD10:                                 ; @0x3d8
	; ZD Loop End                           ; @0x3d8
;  %bb.31:                              ; %vec.epilog.iter.check
                                        ;   in Loop: Header=BB2_27 Depth=1
	ld	%r58,[%sp,64]                   ; 4-byte Folded Reload
                                        ; @0x3d8
	mov	%r30,%r0                        ; @0x3dc
	mov_s	%r0,%r13                        ; @0x3e0
	ld_s	%r13,[%sp,68]                   ; 4-byte Folded Reload
                                        ; @0x3e2
	mov_s	%blink,%r3                      ; @0x3e4
	mov_s	%r12,%r3                        ; @0x3e6
	mov_s	%r16,%r15                       ; @0x3e8
	bbit0	%r24,3,.LBB2_35                 ; @0x3ea
;  %bb.32:                              ; %vec.epilog.vector.body.preheader
                                        ;   in Loop: Header=BB2_27 Depth=1
	; Implicit def %r7                      ; @0x3ee
	ld_s	%r3,[%sp,56]                    ; 4-byte Folded Reload
                                        ; @0x3ee
	mov_s	%r12,%r0                        ; @0x3f0
	mov	%lp_count,%r3                   ; @0x3f2
	mov_s	%r14,%r13                       ; @0x3f6
	lp	.LZD11                          ; @0x3f8
.LBB2_33:                               ; %vec.epilog.vector.body
                                        ;   Parent Loop BB2_27 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; @0x3fc
	ldd	%r4,[%r12,24]                   ; @0x3fc
	ldd	%r6,[%r12,16]                   ; @0x400
	ldd	%r22,[%r12,8]                   ; @0x404
	ldd.ab	%r20,[%r12,32]                  ; @0x408
	std	%r4,[%r14,24]                   ; @0x40c
	std	%r6,[%r14,16]                   ; @0x410
	std	%r22,[%r14,8]                   ; @0x414
	std.ab	%r20,[%r14,32]                  ; @0x418
.LZD11:                                 ; @0x41c
	; ZD Loop End                           ; @0x41c
;  %bb.34:                              ; %vec.epilog.middle.block
                                        ;   in Loop: Header=BB2_27 Depth=1
	mov	%r12,%r30                       ; @0x41c
	breq	%r30,%r24,.LBB2_26              ; @0x420
.LBB2_35:                               ; %for.body4.us.preheader
                                        ;   in Loop: Header=BB2_27 Depth=1
                                        ; @0x424
	; Implicit def %r7                      ; @0x424
	add_s	%r3,%r12,1                      ; @0x424
	add	%r15,%r12,%r8                   ; @0x426
	max	%r3,%r24,%r3                    ; @0x42a
	sub	%lp_count,%r3,%r12              ; @0x42e
	add2	%r12,%r1,%r15                   ; @0x432
	add2	%r14,%r58,%r15                  ; @0x436
	lp	.LZD12                          ; @0x43a
.LBB2_36:                               ; %for.body4.us
                                        ;   Parent Loop BB2_27 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; @0x43e
	ld.ab	%r3,[%r12,4]                    ; @0x43e
	st.ab	%r3,[%r14,4]                    ; @0x442
.LZD12:                                 ; @0x446
	; ZD Loop End                           ; @0x446
.LBB2_26:                               ; %for.cond.cleanup3.us
                                        ;   in Loop: Header=BB2_27 Depth=1
                                        ; @0x446
	add_s	%r11,%r11,1                     ; @0x446
	add	%r8,%r8,%r24                    ; @0x448
	add_s	%r0,%r0,%fp                     ; @0x44c
	add_s	%r13,%r13,%fp                   ; @0x44e
	add	%r16,%r16,%fp                   ; @0x450
	add	%r9,%r9,%fp                     ; @0x454
	cmp	%r11,%r2                        ; @0x458
	blt	.LBB2_27                        ; @0x45c
.LBB2_38:                               ; %for.cond.cleanup
                                        ; @0x460
	mov	%r0,%r58                        ; @0x460
	ld	%blink,[%sp,52]                 ; @0x464
	.cfa_restore	{%blink}                ; @0x468
	ld	%fp,[%sp,48]                    ; @0x468
	.cfa_restore	{%fp}                   ; @0x46c
	ld	%r24,[%sp,44]                   ; @0x46c
	.cfa_restore	{%r24}                  ; @0x470
	ldd	%r22,[%sp,36]                   ; @0x470
	.cfa_restore	{%r23}                  ; @0x474
	.cfa_restore	{%r22}                  ; @0x474
	ldd	%r20,[%sp,28]                   ; @0x474
	.cfa_restore	{%r21}                  ; @0x478
	.cfa_restore	{%r20}                  ; @0x478
	ldd	%r18,[%sp,20]                   ; @0x478
	.cfa_restore	{%r19}                  ; @0x47c
	.cfa_restore	{%r18}                  ; @0x47c
	ldd	%r16,[%sp,12]                   ; @0x47c
	.cfa_restore	{%r17}                  ; @0x480
	.cfa_restore	{%r16}                  ; @0x480
	ldd	%r14,[%sp,4]                    ; @0x480
	.cfa_restore	{%r15}                  ; @0x484
	.cfa_restore	{%r14}                  ; @0x484
	ld.ab	%r13,[%sp,72]                   ; @0x484
	.cfa_restore	{%r13}                  ; @0x488
	.cfa_pop	72                              ; @0x488
	j_s	[%blink]                        ; @0x488
	.cfa_ef
.Lfunc_end2:                            ; @0x48a

	.align	4                               ; -- End function
                                        ; -- Begin function print_matrix
print_matrix:                           ; @print_matrix
                                        ; @0x48c
.Lprint_matrix$local:                   ; @0x48c
	.cfa_bf	.Lprint_matrix$local
;  %bb.0:                               ; %entry
	st.aw	%r13,[%sp,-40]                  ; @0x48c
	.cfa_push	40                      ; @0x490
	.cfa_reg_offset	{%r13}, 0               ; @0x490
	std	%r14,[%sp,4]                    ; @0x490
	.cfa_reg_offset	{%r14}, 4               ; @0x494
	.cfa_reg_offset	{%r15}, 8               ; @0x494
	std	%r16,[%sp,12]                   ; @0x494
	.cfa_reg_offset	{%r16}, 12              ; @0x498
	.cfa_reg_offset	{%r17}, 16              ; @0x498
	std	%r18,[%sp,20]                   ; @0x498
	.cfa_reg_offset	{%r18}, 20              ; @0x49c
	.cfa_reg_offset	{%r19}, 24              ; @0x49c
	std	%r20,[%sp,28]                   ; @0x49c
	.cfa_reg_offset	{%r20}, 28              ; @0x4a0
	.cfa_reg_offset	{%r21}, 32              ; @0x4a0
	st	%blink,[%sp,36]                 ; @0x4a0
	.cfa_reg_offset	{%blink}, 36            ; @0x4a4
	mov_s	%r17,.L.str.4                   ; @0x4a4
	mov_s	%r14,%r0                        ; @0x4aa
	add	%r0,%r17,.Lstr.10-.L.str.4      ; @0x4ac
	mov_s	%r21,%r2                        ; @0x4b0
	mov_s	%r16,%r1                        ; @0x4b2
	bl	puts                            ; @0x4b4
	brlt	%r16,1,.LBB3_10                 ; @0x4b8
;  %bb.1:                               ; %for.body.lr.ph
	add	%r18,%r17,.Lstr.12-.L.str.4     ; @0x4bc
	brlt	%r21,1,.LBB3_9                  ; @0x4c0
;  %bb.2:
	sub	%r13,%r21,1                     ; @0x4c4
	add	%r19,%r17,.L.str.5-.L.str.4     ; @0x4c8
	add	%r20,%r17,.L.str.6-.L.str.4     ; @0x4cc
.LBB3_8:                                ; %for.body5.lr.ph.us
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB3_3 Depth 2
                                        ; @0x4d0
	mov_s	%r0,%r17                        ; @0x4d0
	bl	printf                          ; @0x4d2
	mov_s	%r15,0                          ; @0x4d6
.LBB3_3:                                ; %for.body5.us
                                        ;   Parent Loop BB3_8 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; Label of block must be emitted
                                        ; @0x4d8 AlignLabel LoopTop Freq=409
	ld.ab	%r1,[%r14,4]                    ; @0x4d8
	cmp_s	%r15,%r13                       ; @0x4dc
	mov_s	%r0,%r19                        ; @0x4de
	mov_s.ne	%r0,%r20                        ; Predicate Case 2
                                        ; @0x4e0
	bl	printf                          ; Predicate Case 1
                                        ; @0x4e2
	add_s	%r15,%r15,1                     ; @0x4e6
	brlt	%r15,%r21,.LBB3_3               ; @0x4e8
;  %bb.7:                               ; %for.cond.cleanup4.us
                                        ;   in Loop: Header=BB3_8 Depth=1
	mov_s	%r0,%r18                        ; @0x4ec
	bl	puts                            ; @0x4ee
	dbnz	%r16,.LBB3_8                    ; @0x4f2
	b_s	.LBB3_10                        ; @0x4f6
.LBB3_9:                                ; %for.cond.cleanup4
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x4f8
	mov	%r0,%r17                        ; widened to benefit BPU
                                        ; @0x4f8
	bl	printf                          ; @0x4fc
	mov	%r0,%r18                        ; widened to benefit BPU
                                        ; @0x500
	bl	puts                            ; @0x504
	dbnz	%r16,.LBB3_9                    ; @0x508
.LBB3_10:                               ; %for.cond.cleanup
                                        ; @0x50c
	add	%r0,%r17,.Lstr.11-.L.str.4      ; @0x50c
	bl	puts                            ; @0x510
	ld	%blink,[%sp,36]                 ; @0x514
	.cfa_restore	{%blink}                ; @0x518
	ldd	%r20,[%sp,28]                   ; @0x518
	.cfa_restore	{%r21}                  ; @0x51c
	.cfa_restore	{%r20}                  ; @0x51c
	ldd	%r18,[%sp,20]                   ; @0x51c
	.cfa_restore	{%r19}                  ; @0x520
	.cfa_restore	{%r18}                  ; @0x520
	ldd	%r16,[%sp,12]                   ; @0x520
	.cfa_restore	{%r17}                  ; @0x524
	.cfa_restore	{%r16}                  ; @0x524
	ldd	%r14,[%sp,4]                    ; @0x524
	.cfa_restore	{%r15}                  ; @0x528
	.cfa_restore	{%r14}                  ; @0x528
	ld.ab	%r13,[%sp,40]                   ; @0x528
	.cfa_restore	{%r13}                  ; @0x52c
	.cfa_pop	40                              ; @0x52c
	j_s	[%blink]                        ; @0x52c
	.cfa_ef
.Lfunc_end3:                            ; @0x52e

	.align	4                               ; -- End function
                                        ; -- Begin function conv2d
conv2d:                                 ; @conv2d
                                        ; @0x530
.Lconv2d$local:                         ; @0x530
	.cfa_bf	.Lconv2d$local
;  %bb.0:                               ; %entry
	.cfa_same	%r7                     ; @0x530
	.cfa_same	%r5                     ; @0x530
	.cfa_same	%r4                     ; @0x530
	.cfa_same	%r3                     ; @0x530
	st.aw	%r13,[%sp,-20]                  ; @0x530
	.cfa_push	20                      ; @0x534
	.cfa_reg_offset	{%r13}, 0               ; @0x534
	std	%r14,[%sp,4]                    ; @0x534
	.cfa_reg_offset	{%r14}, 4               ; @0x538
	.cfa_reg_offset	{%r15}, 8               ; @0x538
	st	%r16,[%sp,12]                   ; @0x538
	.cfa_reg_offset	{%r16}, 12              ; @0x53c
	st	%blink,[%sp,16]                 ; @0x53c
	.cfa_reg_offset	{%blink}, 16            ; @0x540
	mov_s	%r11,%r0                        ; @0x540
	brlt	%r0,1,.LBB4_11                  ; @0x542
;  %bb.1:                               ; %entry
	cmp_s	%r1,0                           ; @0x546
	mov_s	%r9,%r1                         ; @0x548
	cmp.gt	%r4,0                           ; @0x54a
	ble	.LBB4_11                        ; Predicate Case 4
                                        ; @0x54e
;  %bb.3:                               ; %for.body4.lr.ph.split.us.split.us.us.us.us.preheader
	mov_s	%r8,0                           ; @0x552
.LBB4_5:                                ; %for.body4.lr.ph.split.us.split.us.us.us.us
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB4_7 Depth 2
                                        ;       Child Loop BB4_9 Depth 3
                                        ;         Child Loop BB4_10 Depth 4
                                        ; @0x554
	mpy	%r30,%r8,%r9                    ; @0x554
	mov_s	%blink,%r6                      ; @0x558
	mov_s	%r16,0                          ; @0x55a
.LBB4_7:                                ; %for.body8.lr.ph.split.us.us.us.us.us.us
                                        ;   Parent Loop BB4_5 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB4_9 Depth 3
                                        ;         Child Loop BB4_10 Depth 4
                                        ; Label of block must be emitted
                                        ; @0x55c AlignLabel LoopTop Freq=819
	add	%r13,%r16,%r30                  ; @0x55c
	add2	%r13,%r5,%r13                   ; @0x560
	mov_s	%r1,%r4                         ; @0x564
	ld	%r58,[%r13,0]                   ; @0x566
	mov_s	%r12,%blink                     ; @0x56a
	mov	%r0,%r7                         ; @0x56c
.LBB4_9:                                ; %for.body12.lr.ph.us.us.us.us.us.us
                                        ;   Parent Loop BB4_5 Depth=1
                                        ;     Parent Loop BB4_7 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB4_10 Depth 4
                                        ; Label of block must be emitted
                                        ; @0x570 AlignLabel LoopTop Freq=26214
	; Implicit def %r15                     ; @0x570
	mov	%lp_count,%r4                   ; @0x570
	mov	%r14,%r12                       ; @0x574
	lp	.LZD15                          ; @0x578
.LBB4_10:                               ; %for.body12.us.us.us.us.us.us
                                        ;   Parent Loop BB4_5 Depth=1
                                        ;     Parent Loop BB4_7 Depth=2
                                        ;       Parent Loop BB4_9 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
                                        ; Label of block must be emitted
                                        ; @0x57c AlignLabel LoopTop Freq=838860
	ld.ab	%r15,[%r14,4]                   ; @0x57c
	ld.ab	%r2,[%r0,4]                     ; @0x580
	mac	%r2,%r2,%r15                    ; @0x584
	st	%r2,[%r13,0]                    ; @0x588
.LZD15:                                 ; @0x58c
	; ZD Loop End                           ; @0x58c
.LBB4_8:                                ; %for.cond.cleanup11.us.us.us.us.us.us
                                        ;   in Loop: Header=BB4_9 Depth=3
                                        ; Label of block must be emitted
                                        ; @0x58c AlignLabel Freq=26214
	add2_s	%r12,%r12,%r3                   ; @0x58c
	dbnz	%r1,.LBB4_9                     ; @0x58e
;  %bb.6:                               ; %for.cond.cleanup7.us.us.us.us.us
                                        ;   in Loop: Header=BB4_7 Depth=2
	add_s	%r16,%r16,1                     ; @0x592
	add_s	%blink,%blink,4                 ; @0x594
	brlt	%r16,%r9,.LBB4_7                ; @0x596
;  %bb.4:                               ; %for.cond.cleanup3.us.us.us
                                        ;   in Loop: Header=BB4_5 Depth=1
	add2	%r6,%r6,%r3                     ; @0x59a
	add_s	%r8,%r8,1                       ; @0x59e
	brlt	%r8,%r11,.LBB4_5                ; @0x5a0
.LBB4_11:                               ; %for.cond.cleanup
                                        ; @0x5a4
	ld	%blink,[%sp,16]                 ; @0x5a4
	.cfa_restore	{%blink}                ; @0x5a8
	ld	%r16,[%sp,12]                   ; @0x5a8
	.cfa_restore	{%r16}                  ; @0x5ac
	ldd	%r14,[%sp,4]                    ; @0x5ac
	.cfa_restore	{%r15}                  ; @0x5b0
	.cfa_restore	{%r14}                  ; @0x5b0
	ld.ab	%r13,[%sp,20]                   ; @0x5b0
	.cfa_restore	{%r13}                  ; @0x5b4
	.cfa_pop	20                              ; @0x5b4
	j_s	[%blink]                        ; @0x5b4
	.cfa_ef
.Lfunc_end4:                            ; @0x5b6

	.align	4                               ; -- End function
                                        ; -- Begin function vectorized_conv2d
vectorized_conv2d:                      ; @vectorized_conv2d
                                        ; @0x5b8
.Lvectorized_conv2d$local:              ; @0x5b8
	.cfa_bf	.Lvectorized_conv2d$local
;  %bb.0:                               ; %entry
	.cfa_same	%r5                     ; @0x5b8
	.cfa_same	%r4                     ; @0x5b8
	st.aw	%r13,[%sp,-76]                  ; @0x5b8
	.cfa_push	76                      ; @0x5bc
	.cfa_reg_offset	{%r13}, 0               ; @0x5bc
	std	%r14,[%sp,4]                    ; @0x5bc
	.cfa_reg_offset	{%r14}, 4               ; @0x5c0
	.cfa_reg_offset	{%r15}, 8               ; @0x5c0
	std	%r16,[%sp,12]                   ; @0x5c0
	.cfa_reg_offset	{%r16}, 12              ; @0x5c4
	.cfa_reg_offset	{%r17}, 16              ; @0x5c4
	std	%r18,[%sp,20]                   ; @0x5c4
	.cfa_reg_offset	{%r18}, 20              ; @0x5c8
	.cfa_reg_offset	{%r19}, 24              ; @0x5c8
	std	%r20,[%sp,28]                   ; @0x5c8
	.cfa_reg_offset	{%r20}, 28              ; @0x5cc
	.cfa_reg_offset	{%r21}, 32              ; @0x5cc
	std	%r22,[%sp,36]                   ; @0x5cc
	.cfa_reg_offset	{%r22}, 36              ; @0x5d0
	.cfa_reg_offset	{%r23}, 40              ; @0x5d0
	st	%r24,[%sp,44]                   ; @0x5d0
	.cfa_reg_offset	{%r24}, 44              ; @0x5d4
	st	%fp,[%sp,48]                    ; @0x5d4
	.cfa_reg_offset	{%fp}, 48               ; @0x5d8
	st	%blink,[%sp,52]                 ; @0x5d8
	.cfa_reg_offset	{%blink}, 52            ; @0x5dc
	cmp_s	%r0,0                           ; @0x5dc
	ble	.LBB5_27                        ; @0x5de
;  %bb.1:                               ; %for.body.lr.ph
	mov_s	%blink,%r1                      ; @0x5e2
	asr_s	%r1,%r1,31                      ; @0x5e4
	lsr_s	%r1,%r1,28                      ; @0x5e6
	add	%r8,%blink,%r1                  ; @0x5e8
	mov	%r30,%r7                        ; @0x5ec
	mov_s	%r9,%r3                         ; @0x5f0
	bmskn	%r20,%r8,3                      ; @0x5f2
	brlt	%blink,16,.LBB5_15              ; @0x5f6
;  %bb.2:                               ; %for.body.lr.ph.split.us
	brlt	%r4,1,.LBB5_3                   ; @0x5fa
;  %bb.4:                               ; %for.body4.lr.ph.split.us.split.us.us.us.us.preheader
	mov_s	%r11,%r6                        ; @0x5fe
	mov_s	%r16,0                          ; @0x600
.LBB5_6:                                ; %for.body4.lr.ph.split.us.split.us.us.us.us
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB5_8 Depth 2
                                        ;       Child Loop BB5_10 Depth 3
                                        ;         Child Loop BB5_11 Depth 4
                                        ; @0x602
	mpy	%r17,%r16,%blink                ; @0x602
	mov_s	%r7,%r11                        ; @0x606
	mov	%r14,0                          ; @0x608
.LBB5_8:                                ; %for.body10.lr.ph.split.us.us.us.us.us.us
                                        ;   Parent Loop BB5_6 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB5_10 Depth 3
                                        ;         Child Loop BB5_11 Depth 4
                                        ; Label of block must be emitted
                                        ; @0x60c AlignLabel LoopTop Freq=200
	add	%r2,%r14,%r17                   ; @0x60c
	add2	%r2,%r5,%r2                     ; @0x610
	mov	%r13,%r4                        ; @0x614
.vvsbundle  "v1sc" 
 ;	 { 
	vvld.w	%vr0,%r2                        ; @0x618
	mov	%r3,%r30                        ; @0x618
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvcadd.init.w	%vr16, %vr0, 0          ; @0x620
	mov_s	%r1,%r7                         ; @0x620
 ;	 }
.LBB5_10:                               ; %for.body14.lr.ph.us.us.us.us.us.us
                                        ;   Parent Loop BB5_6 Depth=1
                                        ;     Parent Loop BB5_8 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB5_11 Depth 4
                                        ; Label of block must be emitted
                                        ; @0x628 AlignLabel LoopTop Freq=6425
	; Implicit def %r18                     ; @0x628
	mov	%lp_count,%r4                   ; @0x628
	mov	%r12,%r1                        ; @0x62c
	lp	.LZD23                          ; @0x630
.LBB5_11:                               ; %for.body14.us.us.us.us.us.us
                                        ;   Parent Loop BB5_6 Depth=1
                                        ;     Parent Loop BB5_8 Depth=2
                                        ;       Parent Loop BB5_10 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
                                        ; Label of block must be emitted
                                        ; @0x634 AlignLabel LoopTop Freq=205603
.vvsbundle  "v1sc" 
 ;	 { 
	vvld.ab.w	%vr0,%r12,4             ; @0x634
	ld.ab	%r15,[%r3,4]                    ; @0x634
 ;	 }
	vvcmac.lo.w	%vr16, %vr0, %r15       ; @0x63e
.LZD23:                                 ; @0x644
	; ZD Loop End                           ; @0x644
.LBB5_9:                                ; %for.cond.cleanup13.us.us.us.us.us.us
                                        ;   in Loop: Header=BB5_10 Depth=3
                                        ; Label of block must be emitted
                                        ; @0x644 AlignLabel Freq=6425
	add2	%r1,%r1,%r9                     ; @0x644
	dbnz	%r13,.LBB5_10                   ; @0x648
;  %bb.7:                               ; %for.cond.cleanup9.us.us.us.us.us
                                        ;   in Loop: Header=BB5_8 Depth=2
.vvsbundle  "v1sc" 
 ;	 { 
	vvst.w	%vr16,%r2                       ; @0x64c
	add1	%r7,%r7,64/2                    ; @0x64c
 ;	 }
	add_s	%r14,%r14,16                    ; @0x654
	brlt	%r14,%r20,.LBB5_8               ; @0x656
;  %bb.5:                               ; %for.cond.cleanup3.us.us.us
                                        ;   in Loop: Header=BB5_6 Depth=1
	add2	%r11,%r11,%r9                   ; @0x65a
	add_s	%r16,%r16,1                     ; @0x65e
	brlt	%r16,%r0,.LBB5_6                ; @0x660
	b_s	.LBB5_15                        ; @0x664
.LBB5_3:                                ; %for.body4.lr.ph.split.us161.preheader
                                        ; @0x666
	max	%r2,%r20,16                     ; @0x666
	add_s	%r2,%r2,-1                      ; @0x66a
	lsr_s	%r2,%r2,4                       ; @0x66c
	mov_s	%r12,%r0                        ; @0x66e
	mov_s	%r1,%r5                         ; @0x670
	add_s	%r2,%r2,1                       ; @0x672
.LBB5_13:                               ; %for.body4.lr.ph.split.us161
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB5_14 Depth 2
                                        ; @0x674
	; Implicit def %r7                      ; @0x674
	mov	%lp_count,%r2                   ; @0x674
	mov	%r3,%r1                         ; @0x678
	lp	.LZD25                          ; @0x67c
.LBB5_14:                               ; %for.cond.cleanup9.us157
                                        ;   Parent Loop BB5_13 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; Label of block must be emitted
                                        ; @0x680 AlignLabel LoopTop Freq=120
	vvld.w	%vr0,%r3                        ; @0x680
	vvcadd.init.w	%vr16, %vr0, 0          ; @0x684
	vvst.av.w	%vr16,%r3,1             ; @0x68a
.LZD25:                                 ; @0x690
	; ZD Loop End                           ; @0x690
;  %bb.12:                              ; %for.cond.cleanup3.us
                                        ;   in Loop: Header=BB5_13 Depth=1
	add2	%r1,%r1,%blink                  ; @0x690
	dbnz	%r12,.LBB5_13                   ; @0x694
.LBB5_15:                               ; %for.cond.cleanup
                                        ; @0x698
	cmp	%r20,%blink                     ; @0x698
	bge	.LBB5_27                        ; @0x69c
;  %bb.16:                              ; %for.body45.lr.ph
	cmp_s	%r4,0                           ; @0x6a0
	ble	.LBB5_27                        ; @0x6a2
;  %bb.17:                              ; %for.body45.lr.ph.split.us.split.us.split.us
	asr	%r1,%r8,4                       ; @0x6a6
	asl	%r16,%r1,6                      ; @0x6aa
	max	%r24,%r4,1                      ; @0x6ae
	add	%r16,%r6,%r16                   ; @0x6b2
	brhs	%r4,8,.LBB5_18                  ; @0x6b6
;  %bb.19:                              ; %for.body49.lr.ph.split.us.split.us.us.us.us.us.preheader
	mov_s	%r8,0                           ; @0x6ba
.LBB5_20:                               ; %for.body49.lr.ph.split.us.split.us.us.us.us.us
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB5_21 Depth 2
                                        ;       Child Loop BB5_22 Depth 3
                                        ;         Child Loop BB5_23 Depth 4
                                        ; @0x6bc
	mpy	%r11,%r8,%blink                 ; @0x6bc
	mov_s	%r17,%r16                       ; @0x6c0
	mov_s	%r7,%r20                        ; @0x6c2
.LBB5_21:                               ; %for.body54.lr.ph.split.us.us.us.us.us.us.us.us
                                        ;   Parent Loop BB5_20 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB5_22 Depth 3
                                        ;         Child Loop BB5_23 Depth 4
                                        ; Label of block must be emitted
                                        ; @0x6c4 AlignLabel LoopTop Freq=154
	add	%r1,%r7,%r11                    ; @0x6c4
	add2	%r6,%r5,%r1                     ; @0x6c8
	mov_s	%r15,%r24                       ; @0x6cc
	ld	%r58,[%r6,0]                    ; @0x6ce
	mov_s	%r14,%r17                       ; @0x6d2
	mov	%r2,%r30                        ; @0x6d4
.LBB5_22:                               ; %iter.check.us.us.us
                                        ;   Parent Loop BB5_20 Depth=1
                                        ;     Parent Loop BB5_21 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB5_23 Depth 4
                                        ; Label of block must be emitted
                                        ; @0x6d8 AlignLabel LoopTop Freq=4956
	; Implicit def %r12                     ; @0x6d8
	mov	%lp_count,%r24                  ; @0x6d8
	mov_s	%r1,%r14                        ; @0x6dc
	mov_s	%r13,%r2                        ; @0x6de
	lp	.LZD17                          ; @0x6e0
.LBB5_23:                               ; %for.body59.us.us.us.us.us.us.us.us.us
                                        ;   Parent Loop BB5_20 Depth=1
                                        ;     Parent Loop BB5_21 Depth=2
                                        ;       Parent Loop BB5_22 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
                                        ; Label of block must be emitted
                                        ; @0x6e4 AlignLabel LoopTop Freq=158608
	ld.ab	%r3,[%r1,4]                     ; @0x6e4
	ld.ab	%r12,[%r13,4]                   ; @0x6e8
	mac	%r3,%r12,%r3                    ; @0x6ec
.LZD17:                                 ; @0x6f0
	; ZD Loop End                           ; @0x6f0
.LBB5_24:                               ; %for.cond.cleanup58.us.us.us.us.us.us.us.us.us
                                        ;   in Loop: Header=BB5_22 Depth=3
                                        ; Label of block must be emitted
                                        ; @0x6f0 AlignLabel Freq=4956
	add2	%r14,%r14,%r9                   ; @0x6f0
	add2	%r2,%r2,%r4                     ; @0x6f4
	dbnz	%r15,.LBB5_22                   ; @0x6f8
;  %bb.25:                              ; %for.cond.cleanup53.us.us.us.us.us.split.us.us.us
                                        ;   in Loop: Header=BB5_21 Depth=2
	add_s	%r7,%r7,1                       ; @0x6fc
	add_s	%r17,%r17,4                     ; @0x6fe
	st	%r3,[%r6,0]                     ; @0x700
	brlt	%r7,%blink,.LBB5_21             ; @0x704
;  %bb.26:                              ; %for.cond.cleanup48.us.us.us.split.us.us
                                        ;   in Loop: Header=BB5_20 Depth=1
	add2	%r16,%r16,%r9                   ; @0x708
	add_s	%r8,%r8,1                       ; @0x70c
	brlt	%r8,%r0,.LBB5_20                ; @0x70e
	b_s	.LBB5_27                        ; @0x712
.LBB5_18:                               ; %for.body49.lr.ph.split.us.split.us.us.us.us.preheader
                                        ; @0x714
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov.w	 %vr1, 0                        ; @0x714
	vvci.w	%vr0                            ; @0x714
	and	%fp,%r4,0x7ffffff0@u32          ; @0x714
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvpinit.w	%p2, 0, 65532           ; @0x724
	sub	%r1,%fp,16                      ; @0x724
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvpinit.w	%p3, 0, 65520           ; @0x72e
	and	%r8,%r4,0x7ffffff8@u32          ; @0x72e
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvadd.w	%vr3, %vr0, 4                   ; @0x73c
	vvadd.w	%vr2, %vr0, 2                   ; @0x73c
	lsr_s	%r1,%r1,4                       ; @0x73c
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvsel.w.p2	%vr0, %vr1, %vr2        ; @0x748
	vvpinit.w	%p1, 0, 255             ; @0x748
	sub	%r22,%r8,8                      ; @0x748
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvsel.w.p3	%vr1, %vr1, %vr3        ; @0x758
	vvpinit.w	%p2, 0, 15              ; @0x758
	add	%r21,%r1,1                      ; @0x758
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvpinit.w	%p3, 0, 3               ; @0x768
	mov_s	%r17,%r20                       ; @0x768
 ;	 }
	mov_s	%r1,0                           ; @0x770
	st	%r0,[%sp,60]                    ; 4-byte Folded Spill
                                        ; @0x772
	st	%r20,[%sp,56]                   ; 4-byte Folded Spill
                                        ; @0x776
.LBB5_29:                               ; %for.body49.lr.ph.split.us.split.us.us.us.us
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB5_31 Depth 2
                                        ;       Child Loop BB5_33 Depth 3
                                        ;         Child Loop BB5_36 Depth 4
                                        ;         Child Loop BB5_40 Depth 4
                                        ;         Child Loop BB5_43 Depth 4
                                        ; @0x77a
	mpy	%r18,%r1,%blink                 ; @0x77a
	mov_s	%r19,%r16                       ; @0x77e
	st	%r17,[%sp,68]                   ; 4-byte Folded Spill
                                        ; @0x780
	st	%r16,[%sp,72]                   ; 4-byte Folded Spill
                                        ; @0x784
	st	%r1,[%sp,64]                    ; 4-byte Folded Spill
                                        ; @0x788
.LBB5_31:                               ; %for.body54.lr.ph.split.us.us.us.us.us.us
                                        ;   Parent Loop BB5_29 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB5_33 Depth 3
                                        ;         Child Loop BB5_36 Depth 4
                                        ;         Child Loop BB5_40 Depth 4
                                        ;         Child Loop BB5_43 Depth 4
                                        ; Label of block must be emitted
                                        ; @0x78c AlignLabel LoopTop Freq=154
	add	%r0,%r20,%r18                   ; @0x78c
	add2	%r23,%r5,%r0                    ; @0x790
	mov_s	%r12,%r24                       ; @0x794
	ld_s	%r0,[%r23,0]                    ; @0x796
	mov_s	%r15,%r17                       ; @0x798
	mov	%r7,%r30                        ; @0x79a
	mov_s	%r1,%r19                        ; @0x79e
	mov	%r14,0                          ; @0x7a0
.LBB5_33:                               ; %iter.check
                                        ;   Parent Loop BB5_29 Depth=1
                                        ;     Parent Loop BB5_31 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB5_36 Depth 4
                                        ;         Child Loop BB5_40 Depth 4
                                        ;         Child Loop BB5_43 Depth 4
                                        ; Label of block must be emitted
                                        ; @0x7a4 AlignLabel LoopTop Freq=4956
	brhs	%r4,16,.LBB5_35                 ; @0x7a4
;  %bb.34:                              ;   in Loop: Header=BB5_33 Depth=3
	mov	%r3,0                           ; @0x7a8
.LBB5_39:                               ; %vec.epilog.ph
                                        ;   in Loop: Header=BB5_33 Depth=3
                                        ; Label of block must be emitted
                                        ; @0x7ac AlignLabel Freq=3097
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr2, 0                        ; @0x7ac
	sub	%r2,%r22,%r3                    ; @0x7ac
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,0,%r0              ; @0x7b4
	add_s	%r13,%r3,%r14                   ; @0x7b4
 ;	 }
	add_s	%r3,%r3,%r15                    ; @0x7bc
	lsr_s	%r2,%r2,3                       ; @0x7be
	add2	%r0,%r30,%r13                   ; @0x7c0
	add2	%r11,%r6,%r3                    ; @0x7c4
	; Implicit def %r3                      ; @0x7c8
	add	%lp_count,%r2,1                 ; @0x7c8
	lp	.LZD20                          ; @0x7cc
.LBB5_40:                               ; %vec.epilog.vector.body
                                        ;   Parent Loop BB5_29 Depth=1
                                        ;     Parent Loop BB5_31 Depth=2
                                        ;       Parent Loop BB5_33 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
                                        ; Label of block must be emitted
                                        ; @0x7d0 AlignLabel LoopTop Freq=99130
	vvld.ab.w.p1	%vr3,%r11,32            ; @0x7d0
	vvld.ab.w.p1	%vr4,%r0,32             ; @0x7d8
	vvmpy.w	%vr3, %vr4, %vr3                ; @0x7e0
	vvadd.w	%vr2, %vr3, %vr2                ; @0x7e6
.LZD20:                                 ; @0x7ec
	; ZD Loop End                           ; @0x7ec
.LBB5_41:                               ; %vec.epilog.middle.block
                                        ;   in Loop: Header=BB5_33 Depth=3
                                        ; Label of block must be emitted
                                        ; @0x7ec AlignLabel Freq=3097

	mov_s	%r2,%r8                         ; implicit-def: $vr3
                                        ; @0x7ec
	vvshfl.w.p2	%vr3, %vr2, %vr1        ; @0x7ee
	vvadd.w	%vr2, %vr2, %vr3                ; @0x7f4
	vvshfl.w.p3	%vr3, %vr2, %vr0        ; @0x7f8
	vvadd.w	%vr2, %vr2, %vr3                ; @0x7fe
	vvmov1.from.w	%r0,%vr2,1              ; @0x802
	vvadd.w	%vr2, %vr2, %r0                 ; @0x808
	vvmov1.x.from.w	%r0,%vr2,0              ; @0x80c
	brne	%r8,%r4,.LBB5_42                ; @0x812
	b_s	.LBB5_32                        ; @0x816
.LBB5_35:                               ; %vector.ph
                                        ;   in Loop: Header=BB5_33 Depth=3
                                        ; Label of block must be emitted
                                        ; @0x818 AlignLabel Freq=2478
	; Implicit def %r11                     ; @0x818
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr16, 0                       ; @0x818
	mov	%lp_count,%r21                  ; @0x818
 ;	 }
	mov	%r2,%r1                         ; @0x820
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr16,0,%r0             ; @0x824
	mov_s	%r0,%r7                         ; @0x824
 ;	 }
	lp	.LZD19                          ; @0x82c
.LBB5_36:                               ; %vector.body
                                        ;   Parent Loop BB5_29 Depth=1
                                        ;     Parent Loop BB5_31 Depth=2
                                        ;       Parent Loop BB5_33 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
                                        ; Label of block must be emitted
                                        ; @0x830 AlignLabel LoopTop Freq=79304
	vvld.av.w	%vr2,%r2,1              ; @0x830
	vvld.av.w	%vr3,%r0,1              ; @0x836
	vvcmac.lo.uu.w	%vr16, %vr3, %vr2       ; @0x83c
.LZD19:                                 ; @0x842
	; ZD Loop End                           ; @0x842
.LBB5_37:                               ; %middle.block
                                        ;   in Loop: Header=BB5_33 Depth=3
                                        ; Label of block must be emitted
                                        ; @0x842 AlignLabel Freq=2478
	vvc2add.w	%vr16                   ; @0x842
	vvshfleven.w	%vr16, %vr16            ; @0x846
	vvc2add.w	%vr16                   ; @0x84a
	vvshfleven.w	%vr16, %vr16            ; @0x84e
	vvc2add.w	%vr16                   ; @0x852
	vvshfleven.w	%vr16, %vr16            ; @0x856
	vvc2add.w	%vr16                   ; @0x85a
	vvmov1.x.from.w	%r0,%vr16,0             ; @0x85e
	breq	%fp,%r4,.LBB5_32                ; @0x864
;  %bb.38:                              ; %vec.epilog.iter.check
                                        ;   in Loop: Header=BB5_33 Depth=3
	mov_s	%r3,%fp                         ; @0x868
	mov_s	%r2,%fp                         ; @0x86a
	bbit1	%r4,3,.LBB5_39                  ; @0x86c
.LBB5_42:                               ; %for.body59.us.us.us.us.us.us.preheader
                                        ;   in Loop: Header=BB5_33 Depth=3
                                        ; Label of block must be emitted
                                        ; @0x870 AlignLabel Freq=2168
	add_s	%r3,%r2,1                       ; @0x870
	max	%r3,%r4,%r3                     ; @0x872
	add_s	%r13,%r2,%r15                   ; @0x876
	add	%r11,%r2,%r14                   ; @0x878
	sub	%lp_count,%r3,%r2               ; @0x87c
	add2	%r2,%r6,%r13                    ; @0x880
	add2	%r3,%r30,%r11                   ; @0x884
	; Implicit def %r11                     ; @0x888
	mov	%r58,%r0                        ; @0x888
	lp	.LZD21                          ; @0x88c
.LBB5_43:                               ; %for.body59.us.us.us.us.us.us
                                        ;   Parent Loop BB5_29 Depth=1
                                        ;     Parent Loop BB5_31 Depth=2
                                        ;       Parent Loop BB5_33 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
                                        ; Label of block must be emitted
                                        ; @0x890 AlignLabel LoopTop Freq=69391
	ld.ab	%r0,[%r2,4]                     ; @0x890
	ld.ab	%r13,[%r3,4]                    ; @0x894
	mac	%r0,%r13,%r0                    ; @0x898
.LZD21:                                 ; @0x89c
	; ZD Loop End                           ; @0x89c
.LBB5_32:                               ; %for.cond.cleanup58.us.us.us.us.us.us
                                        ;   in Loop: Header=BB5_33 Depth=3
                                        ; Label of block must be emitted
                                        ; @0x89c AlignLabel Freq=4956
	add2	%r7,%r7,%r4                     ; @0x89c
	add2	%r1,%r1,%r9                     ; @0x8a0
	add_s	%r14,%r14,%r4                   ; @0x8a4
	add_s	%r15,%r15,%r9                   ; @0x8a6
	dbnz	%r12,.LBB5_33                   ; @0x8a8
;  %bb.30:                              ; %for.cond.cleanup53.us.us.us.us.us
                                        ;   in Loop: Header=BB5_31 Depth=2
	add_s	%r20,%r20,1                     ; @0x8ac
	cmp	%r20,%blink                     ; @0x8ae
	add_s	%r17,%r17,1                     ; @0x8b2
	add_s	%r19,%r19,4                     ; @0x8b4
	st	%r0,[%r23,0]                    ; @0x8b6
	blt	.LBB5_31                        ; @0x8ba
;  %bb.28:                              ; %for.cond.cleanup48.us.us.us
                                        ;   in Loop: Header=BB5_29 Depth=1
	ld_s	%r1,[%sp,64]                    ; 4-byte Folded Reload
                                        ; @0x8be
	ld	%r16,[%sp,72]                   ; 4-byte Folded Reload
                                        ; @0x8c0
	ld	%r20,[%sp,56]                   ; 4-byte Folded Reload
                                        ; @0x8c4
	ld_s	%r0,[%sp,60]                    ; 4-byte Folded Reload
                                        ; @0x8c8
	ld	%r17,[%sp,68]                   ; 4-byte Folded Reload
                                        ; @0x8ca
	add_s	%r1,%r1,1                       ; @0x8ce
	add2	%r16,%r16,%r9                   ; @0x8d0
	cmp_s	%r1,%r0                         ; @0x8d4
	add	%r17,%r17,%r9                   ; @0x8d6
	blt	.LBB5_29                        ; @0x8da
.LBB5_27:                               ; %for.cond.cleanup44
                                        ; @0x8de
	ld	%blink,[%sp,52]                 ; @0x8de
	.cfa_restore	{%blink}                ; @0x8e2
	ld	%fp,[%sp,48]                    ; @0x8e2
	.cfa_restore	{%fp}                   ; @0x8e6
	ld	%r24,[%sp,44]                   ; @0x8e6
	.cfa_restore	{%r24}                  ; @0x8ea
	ldd	%r22,[%sp,36]                   ; @0x8ea
	.cfa_restore	{%r23}                  ; @0x8ee
	.cfa_restore	{%r22}                  ; @0x8ee
	ldd	%r20,[%sp,28]                   ; @0x8ee
	.cfa_restore	{%r21}                  ; @0x8f2
	.cfa_restore	{%r20}                  ; @0x8f2
	ldd	%r18,[%sp,20]                   ; @0x8f2
	.cfa_restore	{%r19}                  ; @0x8f6
	.cfa_restore	{%r18}                  ; @0x8f6
	ldd	%r16,[%sp,12]                   ; @0x8f6
	.cfa_restore	{%r17}                  ; @0x8fa
	.cfa_restore	{%r16}                  ; @0x8fa
	ldd	%r14,[%sp,4]                    ; @0x8fa
	.cfa_restore	{%r15}                  ; @0x8fe
	.cfa_restore	{%r14}                  ; @0x8fe
	ld.ab	%r13,[%sp,76]                   ; @0x8fe
	.cfa_restore	{%r13}                  ; @0x902
	.cfa_pop	76                              ; @0x902
	j_s	[%blink]                        ; @0x902
	.cfa_ef
.Lfunc_end5:                            ; @0x904

	.align	4                               ; -- End function
                                        ; -- Begin function autovectorized_conv2d
autovectorized_conv2d:                  ; @autovectorized_conv2d
                                        ; @0x904
.Lautovectorized_conv2d$local:          ; @0x904
	.cfa_bf	.Lautovectorized_conv2d$local
;  %bb.0:                               ; %entry
	.cfa_same	%r5                     ; @0x904
	.cfa_same	%r4                     ; @0x904
	st.aw	%r13,[%sp,-68]                  ; @0x904
	.cfa_push	68                      ; @0x908
	.cfa_reg_offset	{%r13}, 0               ; @0x908
	std	%r14,[%sp,4]                    ; @0x908
	.cfa_reg_offset	{%r14}, 4               ; @0x90c
	.cfa_reg_offset	{%r15}, 8               ; @0x90c
	std	%r16,[%sp,12]                   ; @0x90c
	.cfa_reg_offset	{%r16}, 12              ; @0x910
	.cfa_reg_offset	{%r17}, 16              ; @0x910
	std	%r18,[%sp,20]                   ; @0x910
	.cfa_reg_offset	{%r18}, 20              ; @0x914
	.cfa_reg_offset	{%r19}, 24              ; @0x914
	std	%r20,[%sp,28]                   ; @0x914
	.cfa_reg_offset	{%r20}, 28              ; @0x918
	.cfa_reg_offset	{%r21}, 32              ; @0x918
	std	%r22,[%sp,36]                   ; @0x918
	.cfa_reg_offset	{%r22}, 36              ; @0x91c
	.cfa_reg_offset	{%r23}, 40              ; @0x91c
	st	%r24,[%sp,44]                   ; @0x91c
	.cfa_reg_offset	{%r24}, 44              ; @0x920
	st	%fp,[%sp,48]                    ; @0x920
	.cfa_reg_offset	{%fp}, 48               ; @0x924
	st	%blink,[%sp,52]                 ; @0x924
	.cfa_reg_offset	{%blink}, 52            ; @0x928
	cmp_s	%r0,0                           ; @0x928
	ble	.LBB6_13                        ; @0x92a
;  %bb.1:                               ; %entry
	cmp_s	%r1,0                           ; @0x92e
	mov_s	%r9,%r1                         ; @0x930
	cmp.gt	%r4,0                           ; @0x932
	ble	.LBB6_13                        ; Predicate Case 4
                                        ; @0x936
;  %bb.3:                               ; %for.body.lr.ph.split.us.split.us.split.us
	mov_s	%r16,%r7                        ; @0x93a
	mov_s	%fp,%r3                         ; @0x93c
	brhs	%r4,8,.LBB6_4                   ; @0x93e
;  %bb.5:                               ; %for.body4.lr.ph.split.us.split.us.us.us.us.us.preheader
	mov_s	%r8,0                           ; @0x942
.LBB6_6:                                ; %for.body4.lr.ph.split.us.split.us.us.us.us.us
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB6_7 Depth 2
                                        ;       Child Loop BB6_8 Depth 3
                                        ;         Child Loop BB6_9 Depth 4
                                        ; @0x944
	mpy	%r30,%r8,%r9                    ; @0x944
	mov_s	%r11,%r6                        ; @0x948
	mov_s	%r12,0                          ; @0x94a
.LBB6_7:                                ; %for.body8.lr.ph.split.us.us.us.us.us.us.us.us
                                        ;   Parent Loop BB6_6 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB6_8 Depth 3
                                        ;         Child Loop BB6_9 Depth 4
                                        ; Label of block must be emitted
                                        ; @0x94c AlignLabel LoopTop Freq=390
	add	%r1,%r12,%r30                   ; @0x94c
	add2	%blink,%r5,%r1                  ; @0x950
	mov_s	%r15,%r4                        ; @0x954
	ld	%r58,[%blink,0]                 ; @0x956
	mov_s	%r14,%r11                       ; @0x95a
	mov	%r13,%r16                       ; @0x95c
.LBB6_8:                                ; %iter.check.us.us.us
                                        ;   Parent Loop BB6_6 Depth=1
                                        ;     Parent Loop BB6_7 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB6_9 Depth 4
                                        ; Label of block must be emitted
                                        ; @0x960 AlignLabel LoopTop Freq=12483
	; Implicit def %r3                      ; @0x960
	mov	%lp_count,%r4                   ; @0x960
	mov	%r1,%r14                        ; @0x964
	lp	.LZD27                          ; @0x968
.LBB6_9:                                ; %for.body12.us.us.us.us.us.us.us.us.us
                                        ;   Parent Loop BB6_6 Depth=1
                                        ;     Parent Loop BB6_7 Depth=2
                                        ;       Parent Loop BB6_8 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
                                        ; Label of block must be emitted
                                        ; @0x96c AlignLabel LoopTop Freq=399457
	ld.ab	%r3,[%r1,4]                     ; @0x96c
	ld.ab	%r2,[%r13,4]                    ; @0x970
	mac	%r3,%r2,%r3                     ; @0x974
.LZD27:                                 ; @0x978
	; ZD Loop End                           ; @0x978
.LBB6_10:                               ; %for.cond.cleanup11.us.us.us.us.us.us.loopexit.us.us.us
                                        ;   in Loop: Header=BB6_8 Depth=3
                                        ; Label of block must be emitted
                                        ; @0x978 AlignLabel Freq=12483
	add2	%r14,%r14,%fp                   ; @0x978
	dbnz	%r15,.LBB6_8                    ; @0x97c
;  %bb.11:                              ; %for.cond.cleanup7.us.us.us.us.us.split.us.us.us
                                        ;   in Loop: Header=BB6_7 Depth=2
	add_s	%r12,%r12,1                     ; @0x980
	add_s	%r11,%r11,4                     ; @0x982
	st	%r3,[%blink,0]                  ; @0x984
	brlt	%r12,%r9,.LBB6_7                ; @0x988
;  %bb.12:                              ; %for.cond.cleanup3.us.us.us.split.us.us
                                        ;   in Loop: Header=BB6_6 Depth=1
	add2	%r6,%r6,%fp                     ; @0x98c
	add_s	%r8,%r8,1                       ; @0x990
	brlt	%r8,%r0,.LBB6_6                 ; @0x992
	b_s	.LBB6_13                        ; @0x996
.LBB6_4:                                ; %for.body4.lr.ph.split.us.split.us.us.us.us.preheader
                                        ; @0x998
.vvsbundle  "v2sc" 
 ;	 { 
	vvpinit.w	%p3, 0, 65532           ; @0x998
	vvci.w	%vr0                            ; @0x998
	sub	%r1,%r4,16                      ; @0x998
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov.w	 %vr1, 0                        ; @0x9a6
	vvpinit.w	%p4, 0, 65520           ; @0x9a6
	lsr_s	%r1,%r1,4                       ; @0x9a6
 ;	 }
.vvsbundle  "v3sc" 
 ;	 { 
	vvpinit.w	%p1, 0, 255             ; @0x9b2
	vvadd.w	%vr3, %vr0, 4                   ; @0x9b2
	vvadd.w	%vr2, %vr0, 2                   ; @0x9b2
	mov_s	%r18,%r6                        ; @0x9b2
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvsel.w.p3	%vr0, %vr1, %vr2        ; @0x9c2
	vvpinit.w	%p2, 0, 15              ; @0x9c2
	bmskn	%r24,%r4,2                      ; @0x9c2
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvsel.w.p4	%vr1, %vr1, %vr3        ; @0x9d2
	vvpinit.w	%p3, 0, 3               ; @0x9d2
	bmskn	%r23,%r4,3                      ; @0x9d2
 ;	 }
	sub	%r22,%r4,8                      ; @0x9e2
	add	%r20,%r1,1                      ; @0x9e6
	mov_s	%r17,0                          ; @0x9ea
	mov_s	%blink,0                        ; @0x9ec
	st	%r0,[%sp,56]                    ; 4-byte Folded Spill
                                        ; @0x9ee
.LBB6_15:                               ; %for.body4.lr.ph.split.us.split.us.us.us.us
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB6_17 Depth 2
                                        ;       Child Loop BB6_19 Depth 3
                                        ;         Child Loop BB6_22 Depth 4
                                        ;         Child Loop BB6_26 Depth 4
                                        ;         Child Loop BB6_29 Depth 4
                                        ; @0x9f2
	mpy	%r30,%blink,%r9                 ; @0x9f2
	mov_s	%r19,0                          ; @0x9f6
	st	%r17,[%sp,60]                   ; 4-byte Folded Spill
                                        ; @0x9f8
	st	%r18,[%sp,64]                   ; 4-byte Folded Spill
                                        ; @0x9fc
.LBB6_17:                               ; %for.body8.lr.ph.split.us.us.us.us.us.us
                                        ;   Parent Loop BB6_15 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB6_19 Depth 3
                                        ;         Child Loop BB6_22 Depth 4
                                        ;         Child Loop BB6_26 Depth 4
                                        ;         Child Loop BB6_29 Depth 4
                                        ; Label of block must be emitted
                                        ; @0xa00 AlignLabel LoopTop Freq=390
	add	%r0,%r19,%r30                   ; @0xa00
	add2	%r21,%r5,%r0                    ; @0xa04
	mov_s	%r13,%r4                        ; @0xa08
	ld_s	%r0,[%r21,0]                    ; @0xa0a
	mov_s	%r14,%r17                       ; @0xa0c
	mov_s	%r7,%r16                        ; @0xa0e
	mov_s	%r1,%r18                        ; @0xa10
	mov_s	%r2,0                           ; @0xa12
.LBB6_19:                               ; %iter.check
                                        ;   Parent Loop BB6_15 Depth=1
                                        ;     Parent Loop BB6_17 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB6_22 Depth 4
                                        ;         Child Loop BB6_26 Depth 4
                                        ;         Child Loop BB6_29 Depth 4
                                        ; Label of block must be emitted
                                        ; @0xa14 AlignLabel LoopTop Freq=12483
	brhs	%r4,16,.LBB6_21                 ; @0xa14
;  %bb.20:                              ;   in Loop: Header=BB6_19 Depth=3
	mov	%r3,0                           ; @0xa18
.LBB6_25:                               ; %vec.epilog.ph
                                        ;   in Loop: Header=BB6_19 Depth=3
                                        ; Label of block must be emitted
                                        ; @0xa1c AlignLabel Freq=7801
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr2, 0                        ; @0xa1c
	sub	%r12,%r22,%r3                   ; @0xa1c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,0,%r0              ; @0xa24
	add	%r11,%r3,%r2                    ; @0xa24
 ;	 }
	add_s	%r3,%r3,%r14                    ; @0xa2e
	lsr	%r8,%r12,3                      ; @0xa30
	add2	%r0,%r16,%r11                   ; @0xa34
	; Implicit def %r11                     ; @0xa38
	add2	%r12,%r6,%r3                    ; @0xa38
	add	%lp_count,%r8,1                 ; @0xa3c
	lp	.LZD30                          ; @0xa40
.LBB6_26:                               ; %vec.epilog.vector.body
                                        ;   Parent Loop BB6_15 Depth=1
                                        ;     Parent Loop BB6_17 Depth=2
                                        ;       Parent Loop BB6_19 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
                                        ; Label of block must be emitted
                                        ; @0xa44 AlignLabel LoopTop Freq=249660
	vvld.ab.w.p1	%vr3,%r12,32            ; @0xa44
	vvld.ab.w.p1	%vr4,%r0,32             ; @0xa4c
	vvmpy.w	%vr3, %vr4, %vr3                ; @0xa54
	vvadd.w	%vr2, %vr3, %vr2                ; @0xa5a
.LZD30:                                 ; @0xa60
	; ZD Loop End                           ; @0xa60
.LBB6_27:                               ; %vec.epilog.middle.block
                                        ;   in Loop: Header=BB6_19 Depth=3
                                        ; Label of block must be emitted
                                        ; @0xa60 AlignLabel Freq=7801

	mov_s	%r12,%r24                       ; implicit-def: $vr3
                                        ; @0xa60
	vvshfl.w.p2	%vr3, %vr2, %vr1        ; @0xa62
	vvadd.w	%vr2, %vr2, %vr3                ; @0xa68
	vvshfl.w.p3	%vr3, %vr2, %vr0        ; @0xa6c
	vvadd.w	%vr2, %vr2, %vr3                ; @0xa72
	vvmov1.from.w	%r0,%vr2,1              ; @0xa76
	vvadd.w	%vr2, %vr2, %r0                 ; @0xa7c
	vvmov1.x.from.w	%r0,%vr2,0              ; @0xa80
	brne	%r24,%r4,.LBB6_28               ; @0xa86
	b_s	.LBB6_18                        ; @0xa8a
.LBB6_21:                               ; %vector.ph
                                        ;   in Loop: Header=BB6_19 Depth=3
                                        ; Label of block must be emitted
                                        ; @0xa8c AlignLabel Freq=6241
	; Implicit def %r11                     ; @0xa8c
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr16, 0                       ; @0xa8c
	mov	%lp_count,%r20                  ; @0xa8c
 ;	 }
	mov	%r3,%r1                         ; @0xa94
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr16,0,%r0             ; @0xa98
	mov_s	%r0,%r7                         ; @0xa98
 ;	 }
	lp	.LZD29                          ; @0xaa0
.LBB6_22:                               ; %vector.body
                                        ;   Parent Loop BB6_15 Depth=1
                                        ;     Parent Loop BB6_17 Depth=2
                                        ;       Parent Loop BB6_19 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
                                        ; Label of block must be emitted
                                        ; @0xaa4 AlignLabel LoopTop Freq=199728
	vvld.av.w	%vr2,%r3,1              ; @0xaa4
	vvld.av.w	%vr3,%r0,1              ; @0xaaa
	vvcmac.lo.uu.w	%vr16, %vr3, %vr2       ; @0xab0
.LZD29:                                 ; @0xab6
	; ZD Loop End                           ; @0xab6
.LBB6_23:                               ; %middle.block
                                        ;   in Loop: Header=BB6_19 Depth=3
                                        ; Label of block must be emitted
                                        ; @0xab6 AlignLabel Freq=6241
	vvc2add.w	%vr16                   ; @0xab6
	vvshfleven.w	%vr16, %vr16            ; @0xaba
	vvc2add.w	%vr16                   ; @0xabe
	vvshfleven.w	%vr16, %vr16            ; @0xac2
	vvc2add.w	%vr16                   ; @0xac6
	vvshfleven.w	%vr16, %vr16            ; @0xaca
	vvc2add.w	%vr16                   ; @0xace
	vvmov1.x.from.w	%r0,%vr16,0             ; @0xad2
	breq	%r23,%r4,.LBB6_18               ; @0xad8
;  %bb.24:                              ; %vec.epilog.iter.check
                                        ;   in Loop: Header=BB6_19 Depth=3
	mov_s	%r3,%r23                        ; @0xadc
	mov_s	%r12,%r23                       ; @0xade
	bbit1	%r4,3,.LBB6_25                  ; @0xae0
.LBB6_28:                               ; %for.body12.us.us.us.us.us.us.preheader
                                        ;   in Loop: Header=BB6_19 Depth=3
                                        ; Label of block must be emitted
                                        ; @0xae4 AlignLabel Freq=5461
	add_s	%r3,%r12,1                      ; @0xae4
	max	%r3,%r4,%r3                     ; @0xae6
	add_s	%r15,%r12,%r14                  ; @0xaea
	add	%r11,%r12,%r2                   ; @0xaec
	sub	%lp_count,%r3,%r12              ; @0xaf0
	add2	%r12,%r6,%r15                   ; @0xaf4
	add2	%r3,%r16,%r11                   ; @0xaf8
	; Implicit def %r11                     ; @0xafc
	mov	%r58,%r0                        ; @0xafc
	lp	.LZD31                          ; @0xb00
.LBB6_29:                               ; %for.body12.us.us.us.us.us.us
                                        ;   Parent Loop BB6_15 Depth=1
                                        ;     Parent Loop BB6_17 Depth=2
                                        ;       Parent Loop BB6_19 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
                                        ; Label of block must be emitted
                                        ; @0xb04 AlignLabel LoopTop Freq=174762
	ld.ab	%r0,[%r12,4]                    ; @0xb04
	ld.ab	%r15,[%r3,4]                    ; @0xb08
	mac	%r0,%r15,%r0                    ; @0xb0c
.LZD31:                                 ; @0xb10
	; ZD Loop End                           ; @0xb10
.LBB6_18:                               ; %for.cond.cleanup11.us.us.us.us.us.us
                                        ;   in Loop: Header=BB6_19 Depth=3
                                        ; Label of block must be emitted
                                        ; @0xb10 AlignLabel Freq=12483
	add2	%r7,%r7,%r4                     ; @0xb10
	add2	%r1,%r1,%fp                     ; @0xb14
	add_s	%r2,%r2,%r4                     ; @0xb18
	add_s	%r14,%r14,%fp                   ; @0xb1a
	dbnz	%r13,.LBB6_19                   ; @0xb1c
;  %bb.16:                              ; %for.cond.cleanup7.us.us.us.us.us
                                        ;   in Loop: Header=BB6_17 Depth=2
	add_s	%r19,%r19,1                     ; @0xb20
	cmp	%r19,%r9                        ; @0xb22
	add_s	%r17,%r17,1                     ; @0xb26
	add_s	%r18,%r18,4                     ; @0xb28
	st	%r0,[%r21,0]                    ; @0xb2a
	blt	.LBB6_17                        ; @0xb2e
;  %bb.14:                              ; %for.cond.cleanup3.us.us.us
                                        ;   in Loop: Header=BB6_15 Depth=1
	ld	%r18,[%sp,64]                   ; 4-byte Folded Reload
                                        ; @0xb32
	ld_s	%r0,[%sp,56]                    ; 4-byte Folded Reload
                                        ; @0xb36
	ld	%r17,[%sp,60]                   ; 4-byte Folded Reload
                                        ; @0xb38
	add_s	%blink,%blink,1                 ; @0xb3c
	add2	%r18,%r18,%fp                   ; @0xb3e
	cmp	%blink,%r0                      ; @0xb42
	add	%r17,%r17,%fp                   ; @0xb46
	blt	.LBB6_15                        ; @0xb4a
.LBB6_13:                               ; %for.cond.cleanup
                                        ; @0xb4e
	ld	%blink,[%sp,52]                 ; @0xb4e
	.cfa_restore	{%blink}                ; @0xb52
	ld	%fp,[%sp,48]                    ; @0xb52
	.cfa_restore	{%fp}                   ; @0xb56
	ld	%r24,[%sp,44]                   ; @0xb56
	.cfa_restore	{%r24}                  ; @0xb5a
	ldd	%r22,[%sp,36]                   ; @0xb5a
	.cfa_restore	{%r23}                  ; @0xb5e
	.cfa_restore	{%r22}                  ; @0xb5e
	ldd	%r20,[%sp,28]                   ; @0xb5e
	.cfa_restore	{%r21}                  ; @0xb62
	.cfa_restore	{%r20}                  ; @0xb62
	ldd	%r18,[%sp,20]                   ; @0xb62
	.cfa_restore	{%r19}                  ; @0xb66
	.cfa_restore	{%r18}                  ; @0xb66
	ldd	%r16,[%sp,12]                   ; @0xb66
	.cfa_restore	{%r17}                  ; @0xb6a
	.cfa_restore	{%r16}                  ; @0xb6a
	ldd	%r14,[%sp,4]                    ; @0xb6a
	.cfa_restore	{%r15}                  ; @0xb6e
	.cfa_restore	{%r14}                  ; @0xb6e
	ld.ab	%r13,[%sp,68]                   ; @0xb6e
	.cfa_restore	{%r13}                  ; @0xb72
	.cfa_pop	68                              ; @0xb72
	j_s	[%blink]                        ; @0xb72
	.cfa_ef
.Lfunc_end6:                            ; @0xb74

	.align	4                               ; -- End function
                                        ; -- Begin function vekt_conv2d_wrapper
vekt_conv2d_wrapper:                    ; @vekt_conv2d_wrapper
                                        ; @0xb74
.Lvekt_conv2d_wrapper$local:            ; @0xb74
	.cfa_bf	.Lvekt_conv2d_wrapper$local
;  %bb.0:                               ; %entry
	st.aw	%r13,[%sp,-48]                  ; @0xb74
	.cfa_push	48                      ; @0xb78
	.cfa_reg_offset	{%r13}, 0               ; @0xb78
	std	%r14,[%sp,4]                    ; @0xb78
	.cfa_reg_offset	{%r14}, 4               ; @0xb7c
	.cfa_reg_offset	{%r15}, 8               ; @0xb7c
	std	%r16,[%sp,12]                   ; @0xb7c
	.cfa_reg_offset	{%r16}, 12              ; @0xb80
	.cfa_reg_offset	{%r17}, 16              ; @0xb80
	std	%r18,[%sp,20]                   ; @0xb80
	.cfa_reg_offset	{%r18}, 20              ; @0xb84
	.cfa_reg_offset	{%r19}, 24              ; @0xb84
	std	%r20,[%sp,28]                   ; @0xb84
	.cfa_reg_offset	{%r20}, 28              ; @0xb88
	.cfa_reg_offset	{%r21}, 32              ; @0xb88
	std	%r22,[%sp,36]                   ; @0xb88
	.cfa_reg_offset	{%r22}, 36              ; @0xb8c
	.cfa_reg_offset	{%r23}, 40              ; @0xb8c
	st	%blink,[%sp,44]                 ; @0xb8c
	.cfa_reg_offset	{%blink}, 44            ; @0xb90
	sub_s	%sp,%sp,72                      ; @0xb90
	.cfa_push	72                      ; @0xb92
	mov_s	%r14,%r7                        ; @0xb92
	mov_s	%r7,0                           ; @0xb94
	mov	%r58,%r6                        ; @0xb96
	mov_s	%r20,%r4                        ; @0xb9a
	mov_s	%r21,1                          ; @0xb9c
	mov_s	%r15,%r7                        ; @0xb9e
	mov_s	%r16,%r3                        ; @0xba0
	mov_s	%r13,%r2                        ; @0xba2
	mov_s	%r8,%r1                         ; @0xba4
	mov_s	%r18,%r0                        ; @0xba6
	mov_s	%r17,%r3                        ; @0xba8
	mov	%r59,%r58                       ; @0xbaa
	mov_s	%r19,%r1                        ; @0xbae
	mov	%r30,%r4                        ; @0xbb0
	mov_s	%blink,%r20                     ; @0xbb4
	mov_s	%r23,%r14                       ; @0xbb6
	mov_s	%r6,%r5                         ; @0xbb8
	mov_s	%r22,%r21                       ; @0xbba
	mov_s	%r9,%r21                        ; @0xbbc
	mov_s	%r12,%r15                       ; @0xbbe
	std	%r20,[%sp,64]                   ; @0xbc0
	std	%r30,[%sp,56]                   ; @0xbc4
	std	%r14,[%sp,48]                   ; @0xbc8
	std	%r22,[%sp,40]                   ; @0xbcc
	std	%r16,[%sp,32]                   ; @0xbd0
	std	%r12,[%sp,24]                   ; @0xbd4
	std	%r58,[%sp,16]                   ; @0xbd8
	std	%r8,[%sp,8]                     ; @0xbdc
	std	%r18,[%sp,0]                    ; @0xbe0
	bl	vekt_conv2d                     ; @0xbe4
	add_s	%sp,%sp,72                      ; @0xbe8
	.cfa_pop	72                              ; @0xbea
	ld	%blink,[%sp,44]                 ; @0xbea
	.cfa_restore	{%blink}                ; @0xbee
	ldd	%r22,[%sp,36]                   ; @0xbee
	.cfa_restore	{%r23}                  ; @0xbf2
	.cfa_restore	{%r22}                  ; @0xbf2
	ldd	%r20,[%sp,28]                   ; @0xbf2
	.cfa_restore	{%r21}                  ; @0xbf6
	.cfa_restore	{%r20}                  ; @0xbf6
	ldd	%r18,[%sp,20]                   ; @0xbf6
	.cfa_restore	{%r19}                  ; @0xbfa
	.cfa_restore	{%r18}                  ; @0xbfa
	ldd	%r16,[%sp,12]                   ; @0xbfa
	.cfa_restore	{%r17}                  ; @0xbfe
	.cfa_restore	{%r16}                  ; @0xbfe
	ldd	%r14,[%sp,4]                    ; @0xbfe
	.cfa_restore	{%r15}                  ; @0xc02
	.cfa_restore	{%r14}                  ; @0xc02
	ld.ab	%r13,[%sp,48]                   ; @0xc02
	.cfa_restore	{%r13}                  ; @0xc06
	.cfa_pop	48                              ; @0xc06
	j_s	[%blink]                        ; @0xc06
	.cfa_ef
.Lfunc_end7:                            ; @0xc08

	.reloc	_init_ad,0	;startup code to enable %status AD bit ; -- End function
