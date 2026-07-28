	.option	%reg
	.off	assume_short
	.file	"matmul.c"
	.size	.Lstr.10, 2
	.type	.Lstr.10,@object
	.size	.Lstr.11, 2
	.type	.Lstr.11,@object
	.size	.L.str.4, 3
	.type	.L.str.4,@object
	.size	.L.str.5, 3
	.type	.L.str.5,@object
	.size	.Lstr.12, 3
	.type	.Lstr.12,@object
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
	.globl	matmul
	.type	matmul,@function
	.type	.Lmatmul$local,@function
	.size	matmul, .Lfunc_end4-matmul
	.size	.Lmatmul$local, .Lfunc_end4-matmul
	.globl	vectorized_matmul
	.type	vectorized_matmul,@function
	.type	.Lvectorized_matmul$local,@function
	.size	vectorized_matmul, .Lfunc_end5-vectorized_matmul
	.size	.Lvectorized_matmul$local, .Lfunc_end5-vectorized_matmul
	.globl	autovectorized_matmul
	.type	autovectorized_matmul,@function
	.type	.Lautovectorized_matmul$local,@function
	.size	autovectorized_matmul, .Lfunc_end6-autovectorized_matmul
	.size	.Lautovectorized_matmul$local, .Lfunc_end6-autovectorized_matmul
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
.Lstr.10:                               ; @0x0
	.asciz	"["
.Lstr.11:                               ; @0x2
	.asciz	"]"
.L.str.4:                               ; @0x4
	.asciz	"\t["
.L.str.5:                               ; @0x7
	.asciz	"%d"
.Lstr.12:                               ; @0xa
	.asciz	"],"
.L.str.6:                               ; @0xd
	.asciz	"%d,"
.Lstr:                                  ; @0x11
	.asciz	"SUCCESSO! Le matrici sono uguali"
.Lstr.9:                                ; @0x32
	.asciz	"ERRORE! Le matrici non corrispondono!"
.L.str.1:                               ; @0x58
	.asciz	"\tElemento (%d, %d) di A = %d mentre B = %d\n"
	.text
	.global	.CC_I
	.equ	.CC_I, 0
	.ident	"LLVM 17.0.7/V-2024.06. (build 008) (LLVM 17.0.7) -arcv2hs -core4 -Xcode_density -Xatomic -Xll64 -Xunaligned -Xdiv_rem=radix4 -Xswap -Xbitscan -Xmpy_option=mpyd -Xshift_assist -Xbarrel_shifter -Xfpud_div -Xfpu_mac -Xtimer0 -Xrtc -Xstack_check -Xstu=4 -Xvdsp4 -Xvec_unit_rev_minor=1 -Xvec_width=512 -Xvec_mem_size=128k -Xvec_mem_bank_width=16 -Xvec_max_fetch_size=16 -Xvec_num_slots=3 -Xvec_super_with_scalar -Xvec_regs=32 -Xvec_fpu=32 -Xvec_fpu_math=3 -Xvec_fpu_2nd_mul -Xvec_fpu_types=2 -Xvec_num_rd_ports=6 -Xvec_num_acc=8 -Xvec_num_mpy=2 -Xvec_mpy32 -Xvec_num_alu=3 -Xvec_guard_bit_option=0 -Xvec_stack_check -Hvdsp_vector_c -O2 -fvectorize -fslp-vectorize -ffast-math"
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
	cmp_s	%r1,0                           ; @0x16
	ble	.LBB0_12                        ; @0x18
;  %bb.1:                               ; %iter.check
	cmp_s	%r1,8                           ; @0x1c
	mov_s	%r2,0                           ; @0x1e
	bcs	.LBB0_10                        ; @0x20
;  %bb.2:                               ; %vector.main.loop.iter.check
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr0, %r3                      ; @0x24
	cmp_s	%r1,64                          ; @0x24
 ;	 }
	bcs	.LBB0_7                         ; @0x2a
;  %bb.3:                               ; %vector.ph
	; Implicit def %r30                     ; @0x2e
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r4,%vr0,14             ; @0x2e
	sub3	%r12,%r1,64/8                   ; @0x2e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r6,%vr0,12             ; @0x38
	lsr_s	%r12,%r12,6                     ; @0x38
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r8,%vr0,10             ; @0x40
	bmskn	%r2,%r1,5                       ; @0x40
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r22,%vr0,0             ; @0x4a
	add	%lp_count,%r12,1                ; @0x4a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r20,%vr0,2             ; @0x54
	add	%r12,%r0,56                     ; @0x54
 ;	 }
	vvmov2.x.from.w	%r18,%vr0,4             ; @0x5e
	vvmov2.x.from.w	%r16,%vr0,6             ; @0x64
	vvmov2.x.from.w	%r14,%vr0,8             ; @0x6a
	lp	.LZD2                           ; @0x70
.LBB0_4:                                ; %vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x74
	std.ab	%r4,[%r12,-8]                   ; @0x74
	std.ab	%r6,[%r12,72]                   ; @0x78
	std.ab	%r4,[%r12,-8]                   ; @0x7c
	std.ab	%r6,[%r12,72]                   ; @0x80
	std.ab	%r4,[%r12,-8]                   ; @0x84
	std.ab	%r6,[%r12,72]                   ; @0x88
	std.ab	%r4,[%r12,-8]                   ; @0x8c
	std.ab	%r6,[%r12,-200]                 ; @0x90
	std.ab	%r8,[%r12,64]                   ; @0x94
	std.ab	%r8,[%r12,64]                   ; @0x98
	std.ab	%r8,[%r12,64]                   ; @0x9c
	std.ab	%r8,[%r12,-200]                 ; @0xa0
	std.ab	%r14,[%r12,-8]                  ; @0xa4
	std.ab	%r16,[%r12,72]                  ; @0xa8
	std.ab	%r14,[%r12,-8]                  ; @0xac
	std.ab	%r16,[%r12,72]                  ; @0xb0
	std.ab	%r14,[%r12,-8]                  ; @0xb4
	std.ab	%r16,[%r12,72]                  ; @0xb8
	std.ab	%r14,[%r12,-8]                  ; @0xbc
	std.ab	%r16,[%r12,-200]                ; @0xc0
	std.ab	%r18,[%r12,-8]                  ; @0xc4
	std.ab	%r20,[%r12,-8]                  ; @0xc8
	std.ab	%r22,[%r12,80]                  ; @0xcc
	std.ab	%r18,[%r12,-8]                  ; @0xd0
	std.ab	%r20,[%r12,-8]                  ; @0xd4
	std.ab	%r22,[%r12,80]                  ; @0xd8
	std.ab	%r18,[%r12,-8]                  ; @0xdc
	std.ab	%r20,[%r12,-8]                  ; @0xe0
	std.ab	%r22,[%r12,80]                  ; @0xe4
	std.ab	%r18,[%r12,-8]                  ; @0xe8
	std.ab	%r20,[%r12,-8]                  ; @0xec
	std.ab	%r22,[%r12,120]                 ; @0xf0
.LZD2:                                  ; @0xf4
	; ZD Loop End                           ; @0xf4
;  %bb.5:                               ; %middle.block
	breq	%r1,%r2,.LBB0_12                ; @0xf4
;  %bb.6:                               ; %vec.epilog.iter.check
	tst	%r1,56                          ; @0xf8
	beq_s	.LBB0_10                        ; @0xfc
.LBB0_7:                                ; %vec.epilog.ph
                                        ; @0xfe
	; Implicit def %r30                     ; @0xfe
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r4,%vr0,0              ; @0xfe
	sub_s	%r15,%r1,%r2                    ; @0xfe
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r6,%vr0,2              ; @0x106
	sub_s	%r15,%r15,8                     ; @0x106
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r8,%vr0,4              ; @0x10e
	lsr_s	%r15,%r15,3                     ; @0x10e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r22,%vr0,6             ; @0x116
	add2	%r12,%r0,%r2                    ; @0x116
 ;	 }
	bmskn	%r2,%r1,2                       ; @0x120
	add	%lp_count,%r15,1                ; @0x124
	lp	.LZD1                           ; @0x128
.LBB0_8:                                ; %vec.epilog.vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x12c
	std	%r22,[%r12,24]                  ; @0x12c
	std	%r8,[%r12,16]                   ; @0x130
	std	%r6,[%r12,8]                    ; @0x134
	std.ab	%r4,[%r12,32]                   ; @0x138
.LZD1:                                  ; @0x13c
	; ZD Loop End                           ; @0x13c
;  %bb.9:                               ; %vec.epilog.middle.block
	breq	%r1,%r2,.LBB0_12                ; @0x13c
.LBB0_10:                               ; %for.body.preheader
                                        ; @0x140
	add_s	%r12,%r2,1                      ; @0x140
	max	%r1,%r1,%r12                    ; @0x142
	add2_s	%r0,%r0,%r2                     ; @0x146
	sub	%lp_count,%r1,%r2               ; @0x148
	; Implicit def %r2                      ; @0x14c
	lp	.LZD0                           ; @0x14c
.LBB0_11:                               ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x150
	st.ab	%r3,[%r0,4]                     ; @0x150
.LZD0:                                  ; @0x154
	; ZD Loop End                           ; @0x154
.LBB0_12:                               ; %for.cond.cleanup
                                        ; @0x154
	ldd	%r22,[%sp,32]                   ; @0x154
	.cfa_restore	{%r23}                  ; @0x158
	.cfa_restore	{%r22}                  ; @0x158
	ldd	%r20,[%sp,24]                   ; @0x158
	.cfa_restore	{%r21}                  ; @0x15c
	.cfa_restore	{%r20}                  ; @0x15c
	ldd	%r18,[%sp,16]                   ; @0x15c
	.cfa_restore	{%r19}                  ; @0x160
	.cfa_restore	{%r18}                  ; @0x160
	ldd	%r16,[%sp,8]                    ; @0x160
	.cfa_restore	{%r17}                  ; @0x164
	.cfa_restore	{%r16}                  ; @0x164
	ldd.ab	%r14,[%sp,40]                   ; @0x164
	.cfa_restore	{%r15}                  ; @0x168
	.cfa_restore	{%r14}                  ; @0x168
	.cfa_pop	40                              ; @0x168
	j_s	[%blink]                        ; @0x168
	.cfa_ef
.Lfunc_end0:                            ; @0x16a

	.align	4                               ; -- End function
                                        ; -- Begin function check_result
check_result:                           ; @check_result
                                        ; @0x16c
.Lcheck_result$local:                   ; @0x16c
	.cfa_bf	.Lcheck_result$local
;  %bb.0:                               ; %entry
	st.aw	%r13,[%sp,-24]                  ; @0x16c
	.cfa_push	24                      ; @0x170
	.cfa_reg_offset	{%r13}, 0               ; @0x170
	std	%r14,[%sp,4]                    ; @0x170
	.cfa_reg_offset	{%r14}, 4               ; @0x174
	.cfa_reg_offset	{%r15}, 8               ; @0x174
	std	%r16,[%sp,12]                   ; @0x174
	.cfa_reg_offset	{%r16}, 12              ; @0x178
	.cfa_reg_offset	{%r17}, 16              ; @0x178
	st	%blink,[%sp,20]                 ; @0x178
	.cfa_reg_offset	{%blink}, 20            ; @0x17c
	mov_s	%r11,%r2                        ; @0x17c
	mov_s	%r16,.Lstr.9                    ; @0x17e
	brlt	%r2,1,.LBB1_8                   ; @0x184
;  %bb.1:                               ; %for.body.lr.ph
	mov_s	%r17,0                          ; @0x188
.LBB1_2:                                ; %for.body
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB1_4 Depth 2
                                        ; @0x18a
	sub.f	%lp_count,%r3,0                 ; @0x18a
	ble_s	.LBB1_7                         ; @0x18e
;  %bb.3:                               ; %for.body4.lr.ph
                                        ;   in Loop: Header=BB1_2 Depth=1
	; Implicit def %r12                     ; @0x190
	mov_s	%r13,%r0                        ; @0x190
	mov_s	%r15,%r1                        ; @0x192
	mov_s	%r14,0                          ; @0x194
	lp	.LZD3                           ; @0x196
.LBB1_4:                                ; %for.body4
                                        ;   Parent Loop BB1_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; @0x19a
	ld.ab	%r12,[%r15,4]                   ; @0x19a
	ld.ab	%r2,[%r13,4]                    ; @0x19e
	brne	%r2,%r12,.LBB1_6                ; @0x1a2
;  %bb.5:                               ; %for.inc
                                        ;   in Loop: Header=BB1_4 Depth=2
	add_s	%r14,%r14,1                     ; @0x1a6
.LZD3:                                  ; @0x1a8
	; ZD Loop End                           ; @0x1a8
.LBB1_7:                                ; %for.inc16
                                        ;   in Loop: Header=BB1_2 Depth=1
                                        ; @0x1a8
	add2_s	%r0,%r0,%r3                     ; @0x1a8
	add2_s	%r1,%r1,%r3                     ; @0x1aa
	add_s	%r17,%r17,1                     ; @0x1ac
	brlt	%r17,%r11,.LBB1_2               ; @0x1ae
.LBB1_8:                                ; %for.end20
                                        ; @0x1b2
	sub	%r0,%r16,.Lstr.9-.Lstr          ; @0x1b2
	bl	puts                            ; @0x1b6
	b_s	.LBB1_9                         ; @0x1ba
.LBB1_6:                                ; %cleanup18
                                        ; @0x1bc
	mov	%r0,%r16                        ; widened to benefit BPU
                                        ; @0x1bc
	bl	puts                            ; @0x1c0
	ld	%r3,[%r13,-4]                   ; @0x1c4
	ld	%r4,[%r15,-4]                   ; @0x1c8
	mov_s	%r1,%r17                        ; @0x1cc
	mov_s	%r2,%r14                        ; @0x1ce
	add	%r0,%r16,.L.str.1-.Lstr.9       ; @0x1d0
	bl	printf                          ; @0x1d4
.LBB1_9:                                ; %return
                                        ; @0x1d8
	ld	%blink,[%sp,20]                 ; @0x1d8
	.cfa_restore	{%blink}                ; @0x1dc
	ldd	%r16,[%sp,12]                   ; @0x1dc
	.cfa_restore	{%r17}                  ; @0x1e0
	.cfa_restore	{%r16}                  ; @0x1e0
	ldd	%r14,[%sp,4]                    ; @0x1e0
	.cfa_restore	{%r15}                  ; @0x1e4
	.cfa_restore	{%r14}                  ; @0x1e4
	ld.ab	%r13,[%sp,24]                   ; @0x1e4
	.cfa_restore	{%r13}                  ; @0x1e8
	.cfa_pop	24                              ; @0x1e8
	j_s	[%blink]                        ; @0x1e8
	.cfa_ef
.Lfunc_end1:                            ; @0x1ea

	.align	4                               ; -- End function
                                        ; -- Begin function copy_matrix
copy_matrix:                            ; @copy_matrix
                                        ; @0x1ec
.Lcopy_matrix$local:                    ; @0x1ec
	.cfa_bf	.Lcopy_matrix$local
;  %bb.0:                               ; %entry
	st.aw	%r13,[%sp,-48]                  ; @0x1ec
	.cfa_push	48                      ; @0x1f0
	.cfa_reg_offset	{%r13}, 0               ; @0x1f0
	std	%r14,[%sp,4]                    ; @0x1f0
	.cfa_reg_offset	{%r14}, 4               ; @0x1f4
	.cfa_reg_offset	{%r15}, 8               ; @0x1f4
	std	%r16,[%sp,12]                   ; @0x1f4
	.cfa_reg_offset	{%r16}, 12              ; @0x1f8
	.cfa_reg_offset	{%r17}, 16              ; @0x1f8
	std	%r18,[%sp,20]                   ; @0x1f8
	.cfa_reg_offset	{%r18}, 20              ; @0x1fc
	.cfa_reg_offset	{%r19}, 24              ; @0x1fc
	std	%r20,[%sp,28]                   ; @0x1fc
	.cfa_reg_offset	{%r20}, 28              ; @0x200
	.cfa_reg_offset	{%r21}, 32              ; @0x200
	std	%r22,[%sp,36]                   ; @0x200
	.cfa_reg_offset	{%r22}, 36              ; @0x204
	.cfa_reg_offset	{%r23}, 40              ; @0x204
	st	%blink,[%sp,44]                 ; @0x204
	.cfa_reg_offset	{%blink}, 44            ; @0x208
	mov_s	%r11,%r2                        ; @0x208
	mov_s	%r5,%r0                         ; @0x20a
	cmp_s	%r2,0                           ; @0x20c
	ble	.LBB2_17                        ; @0x20e
;  %bb.1:                               ; %for.body.lr.ph
	mov_s	%r8,%r1                         ; @0x212
	mov_s	%r12,%r1                        ; @0x214
	sub3	%r1,%r3,64/8                    ; @0x216
	lsr_s	%r1,%r1,6                       ; @0x21a
	asl	%r30,%r3,2                      ; @0x21c
	mov_s	%blink,%r3                      ; @0x220
	mov_s	%r0,%r5                         ; @0x222
	add	%r9,%r1,1                       ; @0x224
	bmskn	%r6,%r3,2                       ; @0x228
	bmskn	%r7,%r3,5                       ; @0x22c
	sub	%r4,%r3,8                       ; @0x230
	mov_s	%r2,0                           ; @0x234
	mov_s	%r1,0                           ; @0x236
.LBB2_2:                                ; %for.body
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB2_8 Depth 2
                                        ;     Child Loop BB2_12 Depth 2
                                        ;     Child Loop BB2_15 Depth 2
                                        ; @0x238
	cmp_s	%blink,0                        ; @0x238
	ble	.LBB2_16                        ; @0x23a
;  %bb.3:                               ; %iter.check
                                        ;   in Loop: Header=BB2_2 Depth=1
	cmp	%blink,8                        ; @0x23e
	mov_s	%r3,0                           ; @0x242
	bcs	.LBB2_14                        ; @0x244
;  %bb.4:                               ; %vector.memcheck
                                        ;   in Loop: Header=BB2_2 Depth=1
	mpy	%r13,%r30,%r1                   ; @0x248
	add	%r3,%r30,%r13                   ; @0x24c
	add	%r14,%r5,%r13                   ; @0x250
	add	%r15,%r8,%r3                    ; @0x254
	brhs	%r14,%r15,.LBB2_6               ; @0x258
;  %bb.5:                               ; %vector.memcheck
                                        ;   in Loop: Header=BB2_2 Depth=1
	add_s	%r13,%r13,%r8                   ; @0x25c
	add	%r14,%r5,%r3                    ; @0x25e
	mov_s	%r3,0                           ; @0x262
	cmp_s	%r13,%r14                       ; @0x264
	bcs	.LBB2_14                        ; @0x266
.LBB2_6:                                ; %vector.main.loop.iter.check
                                        ;   in Loop: Header=BB2_2 Depth=1
                                        ; @0x26a
	cmp	%blink,64                       ; @0x26a
	mov_s	%r13,0                          ; @0x26e
	bcs	.LBB2_11                        ; @0x270
;  %bb.7:                               ; %vector.body.preheader
                                        ;   in Loop: Header=BB2_2 Depth=1
	; Implicit def %r15                     ; @0x274
	mov	%lp_count,%r9                   ; @0x274
	add	%r3,%r12,56                     ; @0x278
	add	%r13,%r0,56                     ; @0x27c
	lp	.LZD4                           ; @0x280
.LBB2_8:                                ; %vector.body
                                        ;   Parent Loop BB2_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; @0x284
	ldd.ab	%r22,[%r3,-8]                   ; @0x284
	ldd.ab	%r20,[%r3,-8]                   ; @0x288
	std.ab	%r22,[%r13,-8]                  ; @0x28c
	ldd.ab	%r22,[%r3,-8]                   ; @0x290
	std.ab	%r20,[%r13,-8]                  ; @0x294
	ldd.ab	%r20,[%r3,-8]                   ; @0x298
	std.ab	%r22,[%r13,-8]                  ; @0x29c
	ldd.ab	%r22,[%r3,-8]                   ; @0x2a0
	std.ab	%r20,[%r13,-8]                  ; @0x2a4
	ldd.ab	%r20,[%r3,-8]                   ; @0x2a8
	std.ab	%r22,[%r13,-8]                  ; @0x2ac
	ldd.ab	%r22,[%r3,-8]                   ; @0x2b0
	std.ab	%r20,[%r13,-8]                  ; @0x2b4
	ldd.ab	%r20,[%r3,120]                  ; @0x2b8
	std.ab	%r22,[%r13,-8]                  ; @0x2bc
	ldd.ab	%r22,[%r3,-8]                   ; @0x2c0
	std.ab	%r20,[%r13,120]                 ; @0x2c4
	ldd.ab	%r20,[%r3,-8]                   ; @0x2c8
	std.ab	%r22,[%r13,-8]                  ; @0x2cc
	ldd.ab	%r22,[%r3,-8]                   ; @0x2d0
	std.ab	%r20,[%r13,-8]                  ; @0x2d4
	ldd.ab	%r20,[%r3,-8]                   ; @0x2d8
	std.ab	%r22,[%r13,-8]                  ; @0x2dc
	ldd.ab	%r22,[%r3,-8]                   ; @0x2e0
	std.ab	%r20,[%r13,-8]                  ; @0x2e4
	ldd.ab	%r20,[%r3,-8]                   ; @0x2e8
	std.ab	%r22,[%r13,-8]                  ; @0x2ec
	ldd.ab	%r22,[%r3,-8]                   ; @0x2f0
	std.ab	%r20,[%r13,-8]                  ; @0x2f4
	ldd.ab	%r20,[%r3,120]                  ; @0x2f8
	std.ab	%r22,[%r13,-8]                  ; @0x2fc
	ldd.ab	%r22,[%r3,-8]                   ; @0x300
	std.ab	%r20,[%r13,120]                 ; @0x304
	ldd.ab	%r20,[%r3,-8]                   ; @0x308
	std.ab	%r22,[%r13,-8]                  ; @0x30c
	ldd.ab	%r22,[%r3,-8]                   ; @0x310
	std.ab	%r20,[%r13,-8]                  ; @0x314
	ldd.ab	%r20,[%r3,-8]                   ; @0x318
	std.ab	%r22,[%r13,-8]                  ; @0x31c
	ldd.ab	%r22,[%r3,-8]                   ; @0x320
	std.ab	%r20,[%r13,-8]                  ; @0x324
	ldd.ab	%r20,[%r3,-8]                   ; @0x328
	std.ab	%r22,[%r13,-8]                  ; @0x32c
	ldd.ab	%r22,[%r3,-8]                   ; @0x330
	std.ab	%r20,[%r13,-8]                  ; @0x334
	ldd.ab	%r20,[%r3,120]                  ; @0x338
	std.ab	%r22,[%r13,-8]                  ; @0x33c
	ldd.ab	%r22,[%r3,-8]                   ; @0x340
	std.ab	%r20,[%r13,120]                 ; @0x344
	ldd.ab	%r20,[%r3,-8]                   ; @0x348
	std.ab	%r22,[%r13,-8]                  ; @0x34c
	ldd.ab	%r22,[%r3,-8]                   ; @0x350
	std.ab	%r20,[%r13,-8]                  ; @0x354
	ldd.ab	%r20,[%r3,-8]                   ; @0x358
	std.ab	%r22,[%r13,-8]                  ; @0x35c
	ldd.ab	%r22,[%r3,-8]                   ; @0x360
	std.ab	%r20,[%r13,-8]                  ; @0x364
	ldd.ab	%r20,[%r3,-8]                   ; @0x368
	std.ab	%r22,[%r13,-8]                  ; @0x36c
	ldd.ab	%r22,[%r3,-8]                   ; @0x370
	std.ab	%r20,[%r13,-8]                  ; @0x374
	ldd.ab	%r20,[%r3,120]                  ; @0x378
	std.ab	%r22,[%r13,-8]                  ; @0x37c
	std.ab	%r20,[%r13,120]                 ; @0x380
.LZD4:                                  ; @0x384
	; ZD Loop End                           ; @0x384
;  %bb.9:                               ; %middle.block
                                        ;   in Loop: Header=BB2_2 Depth=1
	breq	%r7,%blink,.LBB2_16             ; @0x384
;  %bb.10:                              ; %vec.epilog.iter.check
                                        ;   in Loop: Header=BB2_2 Depth=1
	mov_s	%r13,%r7                        ; @0x388
	mov_s	%r3,%r7                         ; @0x38a
	tst	%blink,56                       ; @0x38c
	beq_s	.LBB2_14                        ; @0x390
.LBB2_11:                               ; %vec.epilog.vector.body.preheader
                                        ;   in Loop: Header=BB2_2 Depth=1
                                        ; @0x392
	; Implicit def %r15                     ; @0x392
	sub	%r3,%r4,%r13                    ; @0x392
	add_s	%r13,%r13,%r2                   ; @0x396
	lsr	%r14,%r3,3                      ; @0x398
	add2	%r3,%r8,%r13                    ; @0x39c
	add2	%r13,%r5,%r13                   ; @0x3a0
	add	%lp_count,%r14,1                ; @0x3a4
	lp	.LZD5                           ; @0x3a8
.LBB2_12:                               ; %vec.epilog.vector.body
                                        ;   Parent Loop BB2_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; @0x3ac
	ldd	%r22,[%r3,24]                   ; @0x3ac
	ldd	%r20,[%r3,16]                   ; @0x3b0
	ldd	%r18,[%r3,8]                    ; @0x3b4
	ldd.ab	%r16,[%r3,32]                   ; @0x3b8
	std	%r22,[%r13,24]                  ; @0x3bc
	std	%r20,[%r13,16]                  ; @0x3c0
	std	%r18,[%r13,8]                   ; @0x3c4
	std.ab	%r16,[%r13,32]                  ; @0x3c8
.LZD5:                                  ; @0x3cc
	; ZD Loop End                           ; @0x3cc
;  %bb.13:                              ; %vec.epilog.middle.block
                                        ;   in Loop: Header=BB2_2 Depth=1
	mov_s	%r3,%r6                         ; @0x3cc
	breq	%r6,%blink,.LBB2_16             ; @0x3ce
.LBB2_14:                               ; %for.body4.preheader
                                        ;   in Loop: Header=BB2_2 Depth=1
                                        ; @0x3d2
	; Implicit def %r15                     ; @0x3d2
	add_s	%r13,%r3,1                      ; @0x3d2
	add	%r14,%r3,%r2                    ; @0x3d4
	max	%r13,%blink,%r13                ; @0x3d8
	sub	%lp_count,%r13,%r3              ; @0x3dc
	add2	%r3,%r8,%r14                    ; @0x3e0
	add2	%r13,%r5,%r14                   ; @0x3e4
	lp	.LZD6                           ; @0x3e8
.LBB2_15:                               ; %for.body4
                                        ;   Parent Loop BB2_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; Label of block must be emitted
                                        ; @0x3ec AlignLabel LoopTop Freq=364
	ld.ab	%r14,[%r3,4]                    ; @0x3ec
	st.ab	%r14,[%r13,4]                   ; @0x3f0
.LZD6:                                  ; @0x3f4
	; ZD Loop End                           ; @0x3f4
.LBB2_16:                               ; %for.cond.cleanup3
                                        ;   in Loop: Header=BB2_2 Depth=1
                                        ; @0x3f4
	add_s	%r1,%r1,1                       ; @0x3f4
	cmp_s	%r1,%r11                        ; @0x3f6
	add_s	%r2,%r2,%blink                  ; @0x3f8
	add	%r12,%r12,%r30                  ; @0x3fa
	add	%r0,%r0,%r30                    ; @0x3fe
	blt	.LBB2_2                         ; @0x402
.LBB2_17:                               ; %for.cond.cleanup
                                        ; @0x406
	mov_s	%r0,%r5                         ; @0x406
	ld	%blink,[%sp,44]                 ; @0x408
	.cfa_restore	{%blink}                ; @0x40c
	ldd	%r22,[%sp,36]                   ; @0x40c
	.cfa_restore	{%r23}                  ; @0x410
	.cfa_restore	{%r22}                  ; @0x410
	ldd	%r20,[%sp,28]                   ; @0x410
	.cfa_restore	{%r21}                  ; @0x414
	.cfa_restore	{%r20}                  ; @0x414
	ldd	%r18,[%sp,20]                   ; @0x414
	.cfa_restore	{%r19}                  ; @0x418
	.cfa_restore	{%r18}                  ; @0x418
	ldd	%r16,[%sp,12]                   ; @0x418
	.cfa_restore	{%r17}                  ; @0x41c
	.cfa_restore	{%r16}                  ; @0x41c
	ldd	%r14,[%sp,4]                    ; @0x41c
	.cfa_restore	{%r15}                  ; @0x420
	.cfa_restore	{%r14}                  ; @0x420
	ld.ab	%r13,[%sp,48]                   ; @0x420
	.cfa_restore	{%r13}                  ; @0x424
	.cfa_pop	48                              ; @0x424
	j_s	[%blink]                        ; @0x424
	.cfa_ef
.Lfunc_end2:                            ; @0x426

	.align	4                               ; -- End function
                                        ; -- Begin function print_matrix
print_matrix:                           ; @print_matrix
                                        ; @0x428
.Lprint_matrix$local:                   ; @0x428
	.cfa_bf	.Lprint_matrix$local
;  %bb.0:                               ; %entry
	st.aw	%r13,[%sp,-48]                  ; @0x428
	.cfa_push	48                      ; @0x42c
	.cfa_reg_offset	{%r13}, 0               ; @0x42c
	std	%r14,[%sp,4]                    ; @0x42c
	.cfa_reg_offset	{%r14}, 4               ; @0x430
	.cfa_reg_offset	{%r15}, 8               ; @0x430
	std	%r16,[%sp,12]                   ; @0x430
	.cfa_reg_offset	{%r16}, 12              ; @0x434
	.cfa_reg_offset	{%r17}, 16              ; @0x434
	std	%r18,[%sp,20]                   ; @0x434
	.cfa_reg_offset	{%r18}, 20              ; @0x438
	.cfa_reg_offset	{%r19}, 24              ; @0x438
	std	%r20,[%sp,28]                   ; @0x438
	.cfa_reg_offset	{%r20}, 28              ; @0x43c
	.cfa_reg_offset	{%r21}, 32              ; @0x43c
	std	%r22,[%sp,36]                   ; @0x43c
	.cfa_reg_offset	{%r22}, 36              ; @0x440
	.cfa_reg_offset	{%r23}, 40              ; @0x440
	st	%blink,[%sp,44]                 ; @0x440
	.cfa_reg_offset	{%blink}, 44            ; @0x444
	mov_s	%r18,.Lstr.10                   ; @0x444
	mov_s	%r19,%r0                        ; @0x44a
	mov_s	%r0,%r18                        ; @0x44c
	mov_s	%r23,%r2                        ; @0x44e
	mov_s	%r22,%r1                        ; @0x450
	bl	puts                            ; @0x452
	brlt	%r22,1,.LBB3_7                  ; @0x456
;  %bb.1:                               ; %for.body.lr.ph
	sub	%r14,%r23,1                     ; @0x45a
	add	%r20,%r18,.L.str.4-.Lstr.10     ; @0x45e
	add	%r21,%r18,.L.str.5-.Lstr.10     ; @0x462
	add	%r17,%r18,.L.str.6-.Lstr.10     ; @0x466
	add	%r16,%r18,.Lstr.12-.Lstr.10     ; @0x46a
.LBB3_2:                                ; %for.body
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB3_4 Depth 2
                                        ; @0x46e
	mov_s	%r0,%r20                        ; @0x46e
	bl	printf                          ; @0x470
	brlt	%r23,1,.LBB3_6                  ; @0x474
;  %bb.3:                               ; %for.body5.lr.ph
                                        ;   in Loop: Header=BB3_2 Depth=1
	mov_s	%r13,%r19                       ; @0x478
	mov_s	%r15,0                          ; @0x47a
.LBB3_4:                                ; %for.body5
                                        ;   Parent Loop BB3_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; Label of block must be emitted
                                        ; @0x47c AlignLabel LoopTop Freq=426
	ld.ab	%r1,[%r13,4]                    ; @0x47c
	cmp_s	%r15,%r14                       ; @0x480
	mov_s	%r0,%r21                        ; @0x482
	mov_s.ne	%r0,%r17                        ; Predicate Case 2
                                        ; @0x484
	bl	printf                          ; Predicate Case 1
                                        ; @0x486
	add_s	%r15,%r15,1                     ; @0x48a
	brlt	%r15,%r23,.LBB3_4               ; @0x48c
.LBB3_6:                                ; %for.cond.cleanup4
                                        ;   in Loop: Header=BB3_2 Depth=1
                                        ; @0x490
	mov_s	%r0,%r16                        ; @0x490
	bl	puts                            ; @0x492
	add2	%r19,%r19,%r23                  ; @0x496
	dbnz	%r22,.LBB3_2                    ; @0x49a
.LBB3_7:                                ; %for.cond.cleanup
                                        ; @0x49e
	add	%r0,%r18,.Lstr.11-.Lstr.10      ; @0x49e
	bl	puts                            ; @0x4a2
	ld	%blink,[%sp,44]                 ; @0x4a6
	.cfa_restore	{%blink}                ; @0x4aa
	ldd	%r22,[%sp,36]                   ; @0x4aa
	.cfa_restore	{%r23}                  ; @0x4ae
	.cfa_restore	{%r22}                  ; @0x4ae
	ldd	%r20,[%sp,28]                   ; @0x4ae
	.cfa_restore	{%r21}                  ; @0x4b2
	.cfa_restore	{%r20}                  ; @0x4b2
	ldd	%r18,[%sp,20]                   ; @0x4b2
	.cfa_restore	{%r19}                  ; @0x4b6
	.cfa_restore	{%r18}                  ; @0x4b6
	ldd	%r16,[%sp,12]                   ; @0x4b6
	.cfa_restore	{%r17}                  ; @0x4ba
	.cfa_restore	{%r16}                  ; @0x4ba
	ldd	%r14,[%sp,4]                    ; @0x4ba
	.cfa_restore	{%r15}                  ; @0x4be
	.cfa_restore	{%r14}                  ; @0x4be
	ld.ab	%r13,[%sp,48]                   ; @0x4be
	.cfa_restore	{%r13}                  ; @0x4c2
	.cfa_pop	48                              ; @0x4c2
	j_s	[%blink]                        ; @0x4c2
	.cfa_ef
.Lfunc_end3:                            ; @0x4c4

	.align	4                               ; -- End function
                                        ; -- Begin function matmul
matmul:                                 ; @matmul
                                        ; @0x4c4
.Lmatmul$local:                         ; @0x4c4
	.cfa_bf	.Lmatmul$local
;  %bb.0:                               ; %entry
	.cfa_same	%r5                     ; @0x4c4
	.cfa_same	%r4                     ; @0x4c4
	.cfa_same	%r2                     ; @0x4c4
	.cfa_same	%r1                     ; @0x4c4
	st.aw	%r13,[%sp,-12]                  ; @0x4c4
	.cfa_push	12                      ; @0x4c8
	.cfa_reg_offset	{%r13}, 0               ; @0x4c8
	st	%r14,[%sp,4]                    ; @0x4c8
	.cfa_reg_offset	{%r14}, 4               ; @0x4cc
	st	%blink,[%sp,8]                  ; @0x4cc
	.cfa_reg_offset	{%blink}, 8             ; @0x4d0
	mov_s	%r11,%r3                        ; @0x4d0
	brlt	%r3,1,.LBB4_7                   ; @0x4d2
;  %bb.1:                               ; %for.body.lr.ph
	asl	%r30,%r4,2                      ; @0x4d6
	mov_s	%r8,0                           ; @0x4da
.LBB4_2:                                ; %for.body
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB4_4 Depth 2
                                        ;       Child Loop BB4_9 Depth 3
                                        ; @0x4dc
	brlt	%r4,1,.LBB4_6                   ; @0x4dc
;  %bb.3:                               ; %for.body4.lr.ph
                                        ;   in Loop: Header=BB4_2 Depth=1
	mpy	%r9,%r8,%r4                     ; @0x4e0
	mov_s	%r6,%r1                         ; @0x4e4
	mov_s	%r7,0                           ; @0x4e6
.LBB4_4:                                ; %for.body4
                                        ;   Parent Loop BB4_2 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB4_9 Depth 3
                                        ; Label of block must be emitted
                                        ; @0x4e8 AlignLabel LoopTop Freq=426
	sub.f	%lp_count,%r5,0                 ; @0x4e8
	ble	.LBB4_5                         ; @0x4ec
;  %bb.8:                               ; %for.body8.lr.ph
                                        ;   in Loop: Header=BB4_4 Depth=2
	; Implicit def %r14                     ; @0x4f0
	add	%r3,%r7,%r9                     ; @0x4f0
	add2	%blink,%r2,%r3                  ; @0x4f4
	mov_s	%r12,%r0                        ; @0x4f8
	ld	%r58,[%blink,0]                 ; @0x4fa
	mov_s	%r3,%r6                         ; @0x4fe
	lp	.LZD8                           ; @0x500
.LBB4_9:                                ; %for.body8
                                        ;   Parent Loop BB4_2 Depth=1
                                        ;     Parent Loop BB4_4 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
                                        ; Label of block must be emitted
                                        ; @0x504 AlignLabel LoopTop Freq=8533
	ld.ab	%r13,[%r12,4]                   ; @0x504
	ld.ab	%r14,[%r3,%r30]                 ; @0x508
	mac	%r13,%r14,%r13                  ; @0x50c
	st	%r13,[%blink,0]                 ; @0x510
.LZD8:                                  ; @0x514
	; ZD Loop End                           ; @0x514
.LBB4_5:                                ; %for.cond.cleanup7
                                        ;   in Loop: Header=BB4_4 Depth=2
                                        ; Label of block must be emitted
                                        ; @0x514 AlignLabel Freq=426
	add_s	%r7,%r7,1                       ; @0x514
	add_s	%r6,%r6,4                       ; @0x516
	brlt	%r7,%r4,.LBB4_4                 ; @0x518
.LBB4_6:                                ; %for.cond.cleanup3
                                        ;   in Loop: Header=BB4_2 Depth=1
                                        ; @0x51c
	add2	%r0,%r0,%r5                     ; @0x51c
	add_s	%r8,%r8,1                       ; @0x520
	brlt	%r8,%r11,.LBB4_2                ; @0x522
.LBB4_7:                                ; %for.cond.cleanup
                                        ; @0x526
	ld	%blink,[%sp,8]                  ; @0x526
	.cfa_restore	{%blink}                ; @0x52a
	ld_s	%r14,[%sp,4]                    ; @0x52a
	.cfa_restore	{%r14}                  ; @0x52c
	ld.ab	%r13,[%sp,12]                   ; @0x52c
	.cfa_restore	{%r13}                  ; @0x530
	.cfa_pop	12                              ; @0x530
	j_s	[%blink]                        ; @0x530
	.cfa_ef
.Lfunc_end4:                            ; @0x532

	.align	4                               ; -- End function
                                        ; -- Begin function vectorized_matmul
vectorized_matmul:                      ; @vectorized_matmul
                                        ; @0x534
.Lvectorized_matmul$local:              ; @0x534
	.cfa_bf	.Lvectorized_matmul$local
;  %bb.0:                               ; %entry
	.cfa_same	%r5                     ; @0x534
	.cfa_same	%r4                     ; @0x534
	.cfa_same	%r2                     ; @0x534
	.cfa_same	%r0                     ; @0x534
	st.aw	%r13,[%sp,-44]                  ; @0x534
	.cfa_push	44                      ; @0x538
	.cfa_reg_offset	{%r13}, 0               ; @0x538
	std	%r14,[%sp,4]                    ; @0x538
	.cfa_reg_offset	{%r14}, 4               ; @0x53c
	.cfa_reg_offset	{%r15}, 8               ; @0x53c
	std	%r16,[%sp,12]                   ; @0x53c
	.cfa_reg_offset	{%r16}, 12              ; @0x540
	.cfa_reg_offset	{%r17}, 16              ; @0x540
	std	%r18,[%sp,20]                   ; @0x540
	.cfa_reg_offset	{%r18}, 20              ; @0x544
	.cfa_reg_offset	{%r19}, 24              ; @0x544
	std	%r20,[%sp,28]                   ; @0x544
	.cfa_reg_offset	{%r20}, 28              ; @0x548
	.cfa_reg_offset	{%r21}, 32              ; @0x548
	st	%r22,[%sp,36]                   ; @0x548
	.cfa_reg_offset	{%r22}, 36              ; @0x54c
	st	%blink,[%sp,40]                 ; @0x54c
	.cfa_reg_offset	{%blink}, 40            ; @0x550
	mov_s	%r11,%r1                        ; @0x550
	asr	%r1,%r4,31                      ; @0x552
	lsr_s	%r1,%r1,28                      ; @0x556
	add	%r8,%r4,%r1                     ; @0x558
	mov_s	%r17,%r3                        ; @0x55c
	bmskn	%r18,%r8,3                      ; @0x55e
	brlt	%r3,1,.LBB5_7                   ; @0x562
;  %bb.1:                               ; %for.body.lr.ph
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr0, 0                        ; @0x566
	mov_s	%r6,%r0                         ; @0x566
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvcmpy.lo.w	%vr16, %vr0, 0          ; @0x56c
	mov_s	%r9,0                           ; @0x56c
 ;	 }
.LBB5_2:                                ; %for.body
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB5_4 Depth 2
                                        ;       Child Loop BB5_15 Depth 3
                                        ; @0x574
	brlt	%r4,16,.LBB5_6                  ; @0x574
;  %bb.3:                               ; %for.body4.lr.ph
                                        ;   in Loop: Header=BB5_2 Depth=1
	mpy	%r12,%r9,%r4                    ; @0x578
	mov_s	%r1,%r11                        ; @0x57c
	mov_s	%r13,0                          ; @0x57e
.LBB5_4:                                ; %for.body4
                                        ;   Parent Loop BB5_2 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB5_15 Depth 3
                                        ; Label of block must be emitted
                                        ; @0x580 AlignLabel LoopTop Freq=319
.vvsbundle  "v1sc" 
 ;	 { 
	vvcmov.b	%vr17, %vr16                    ; @0x580
	sub.f	%lp_count,%r5,0                 ; @0x580
 ;	 }
	ble	.LBB5_5                         ; @0x588
;  %bb.14:                              ; %for.body8.preheader
                                        ;   in Loop: Header=BB5_4 Depth=2
	; Implicit def %r30                     ; @0x58c
.vvsbundle  "v1sc" 
 ;	 { 
	vvcmov.b	%vr17, %vr16                    ; @0x58c
	mov_s	%r3,%r1                         ; @0x58c
 ;	 }
	mov_s	%r15,%r6                        ; @0x592
	lp	.LZD12                          ; @0x594
.LBB5_15:                               ; %for.body8
                                        ;   Parent Loop BB5_2 Depth=1
                                        ;     Parent Loop BB5_4 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
                                        ; Label of block must be emitted
                                        ; @0x598 AlignLabel LoopTop Freq=6399
.vvsbundle  "v1sc" 
 ;	 { 
	vvld.w	%vr0,%r3                        ; @0x598
	ld.ab	%r14,[%r15,4]                   ; @0x598
 ;	 }
	add2	%r3,%r3,%r4                     ; @0x5a0
	vvcmac.lo.w	%vr17, %vr0, %r14       ; @0x5a4
.LZD12:                                 ; @0x5aa
	; ZD Loop End                           ; @0x5aa
.LBB5_5:                                ; %for.cond.cleanup7
                                        ;   in Loop: Header=BB5_4 Depth=2
                                        ; Label of block must be emitted
                                        ; @0x5aa AlignLabel Freq=319
	add_s	%r3,%r13,%r12                   ; @0x5aa
	add2	%r3,%r2,%r3                     ; @0x5ac
	add1	%r1,%r1,64/2                    ; @0x5b0
.vvsbundle  "v1sc" 
 ;	 { 
	vvst.w	%vr17,%r3                       ; @0x5b4
	add_s	%r13,%r13,16                    ; @0x5b4
 ;	 }
	brlt	%r13,%r18,.LBB5_4               ; @0x5ba
.LBB5_6:                                ; %for.cond.cleanup3
                                        ;   in Loop: Header=BB5_2 Depth=1
                                        ; @0x5be
	add2	%r6,%r6,%r5                     ; @0x5be
	add_s	%r9,%r9,1                       ; @0x5c2
	brlt	%r9,%r17,.LBB5_2                ; @0x5c4
.LBB5_7:                                ; %for.cond.cleanup
                                        ; @0x5c8
	cmp	%r18,%r4                        ; @0x5c8
	bge	.LBB5_18                        ; @0x5cc
;  %bb.8:                               ; %for.body31.lr.ph
.vvsbundle  "v2sc" 
 ;	 { 
	vvpinit.w	%p2, 0, 65532           ; @0x5d0
	vvci.w	%vr0                            ; @0x5d0
	asr	%r1,%r8,4                       ; @0x5d0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvpinit.w	%p3, 0, 65520           ; @0x5de
	sub3	%r3,%r5,64/8                    ; @0x5de
 ;	 }
.vvsbundle  "v3sc" 
 ;	 { 
	vvadd.w	%vr3, %vr0, 4                   ; @0x5e8
	vvadd.w	%vr2, %vr0, 2                   ; @0x5e8
	vvmov.w	 %vr1, 0                        ; @0x5e8
	asl	%r8,%r1,6                       ; @0x5e8
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvsel.w.p2	%vr0, %vr1, %vr2        ; @0x5f8
	vvpinit.w	%p1, 0, 255             ; @0x5f8
	lsr_s	%r3,%r3,6                       ; @0x5f8
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvsel.w.p3	%vr1, %vr1, %vr3        ; @0x606
	vvpinit.w	%p2, 0, 15              ; @0x606
	asl	%r1,%r4,2                       ; @0x606
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvpinit.w	%p3, 0, 3               ; @0x616
	add	%r8,%r11,%r8                    ; @0x616
 ;	 }
	setne	%r9,%r4,1                       ; @0x620
	setlo	%r6,%r5,8                       ; @0x624
	add	%r7,%r3,1                       ; @0x628
	bmskn	%r30,%r5,2                      ; @0x62c
	bmskn	%blink,%r5,5                    ; @0x630
	sub	%r16,%r5,8                      ; @0x634
.LBB5_9:                                ; %for.body31
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB5_11 Depth 2
                                        ;       Child Loop BB5_20 Depth 3
                                        ;       Child Loop BB5_24 Depth 3
                                        ;       Child Loop BB5_27 Depth 3
                                        ; @0x638
	cmp_s	%r17,0                          ; @0x638
	ble	.LBB5_17                        ; @0x63a
;  %bb.10:                              ; %for.body36.preheader
                                        ;   in Loop: Header=BB5_9 Depth=1
	mov_s	%r19,%r0                        ; @0x63e
	mov_s	%r21,0                          ; @0x640
	mov_s	%r22,0                          ; @0x642
.LBB5_11:                               ; %for.body36
                                        ;   Parent Loop BB5_9 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB5_20 Depth 3
                                        ;       Child Loop BB5_24 Depth 3
                                        ;       Child Loop BB5_27 Depth 3
                                        ; Label of block must be emitted
                                        ; @0x644 AlignLabel LoopTop Freq=319
	cmp_s	%r5,0                           ; @0x644
	mov_s	%r3,0                           ; @0x646
	ble	.LBB5_16                        ; @0x648
;  %bb.12:                              ; %iter.check
                                        ;   in Loop: Header=BB5_11 Depth=2
	or.f	0,%r6,%r9                       ; @0x64c
	mov_s	%r12,0                          ; @0x650
	bne_s	.LBB5_26                        ; @0x652
;  %bb.13:                              ; %vector.main.loop.iter.check
                                        ;   in Loop: Header=BB5_11 Depth=2
	cmp	%r5,64                          ; @0x654
	mov	%r14,0                          ; @0x658
	bcs	.LBB5_23                        ; @0x65c
;  %bb.19:                              ; %vector.body.preheader
                                        ;   in Loop: Header=BB5_11 Depth=2
.vvsbundle  "v3sc" 
 ;	 { 
	vvmov.w	 %vr16, 0                       ; @0x660
	vvmov.w	 %vr18, 0                       ; @0x660
	vvmov.w	 %vr17, 0                       ; @0x660
	add2	%r3,%r19,192/4                  ; @0x660
 ;	 }
	; Implicit def %r14                     ; @0x670
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr19, 0                       ; @0x670
	add2	%r12,%r8,192/4                  ; @0x670
 ;	 }
	mov	%lp_count,%r7                   ; @0x678
	lp	.LZD9                           ; @0x67c
.LBB5_20:                               ; %vector.body
                                        ;   Parent Loop BB5_9 Depth=1
                                        ;     Parent Loop BB5_11 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
                                        ; Label of block must be emitted
                                        ; @0x680 AlignLabel LoopTop Freq=1599
	vvld.av.w	%vr2,%r12,-1            ; @0x680
	vvld.av.w	%vr3,%r3,-1             ; @0x686
.vvsbundle  " v2" 
 ;	 { 
	vvld.av.w	%vr4,%r12,-1            ; @0x68c
	vvcmac.lo.uu.w	%vr19, %vr3, %vr2       ; @0x68c
 ;	 }
	vvld.av.w	%vr2,%r3,-1             ; @0x696
.vvsbundle  " v2" 
 ;	 { 
	vvld.av.w	%vr3,%r12,-1            ; @0x69c
	vvcmac.lo.uu.w	%vr16, %vr2, %vr4       ; @0x69c
 ;	 }
	vvld.av.w	%vr2,%r3,-1             ; @0x6a6
.vvsbundle  " v2" 
 ;	 { 
	vvld.av.w	%vr4,%r12,7             ; @0x6ac
	vvcmac.lo.uu.w	%vr18, %vr2, %vr3       ; @0x6ac
 ;	 }
	vvld.av.w	%vr2,%r3,7              ; @0x6b6
	vvcmac.lo.uu.w	%vr17, %vr2, %vr4       ; @0x6bc
.LZD9:                                  ; @0x6c2
	; ZD Loop End                           ; @0x6c2
;  %bb.21:                              ; %middle.block
                                        ;   in Loop: Header=BB5_11 Depth=2
	vvadd.w	%vr2, %vr18, %vr17              ; @0x6c2
	vvadd.w	%vr2, %vr16, %vr2               ; @0x6c8
	vvadd.w	%vr16, %vr19, %vr2              ; @0x6ce
	vvc2add.w	%vr16                   ; @0x6d4
	vvshfleven.w	%vr16, %vr16            ; @0x6d8
	vvc2add.w	%vr16                   ; @0x6dc
	vvshfleven.w	%vr16, %vr16            ; @0x6e0
	vvc2add.w	%vr16                   ; @0x6e4
	vvshfleven.w	%vr16, %vr16            ; @0x6e8
	vvc2add.w	%vr16                   ; @0x6ec
	vvmov1.x.from.w	%r3,%vr16,0             ; @0x6f0
	breq	%blink,%r5,.LBB5_16             ; @0x6f6
;  %bb.22:                              ; %vec.epilog.iter.check
                                        ;   in Loop: Header=BB5_11 Depth=2
	mov_s	%r14,%blink                     ; @0x6fa
	mov_s	%r12,%blink                     ; @0x6fc
	tst	%r5,56                          ; @0x6fe
	beq_s	.LBB5_26                        ; @0x702
.LBB5_23:                               ; %vec.epilog.ph
                                        ;   in Loop: Header=BB5_11 Depth=2
                                        ; @0x704
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr2, 0                        ; @0x704
	sub	%r20,%r16,%r14                  ; @0x704
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,0,%r3              ; @0x70c
	add	%r12,%r14,%r21                  ; @0x70c
 ;	 }
	add_s	%r14,%r14,%r18                  ; @0x716
	lsr	%r20,%r20,3                     ; @0x718
	add2	%r3,%r0,%r12                    ; @0x71c
	add2	%r12,%r11,%r14                  ; @0x720
	; Implicit def %r14                     ; @0x724
	add	%lp_count,%r20,1                ; @0x724
	lp	.LZD10                          ; @0x728
.LBB5_24:                               ; %vec.epilog.vector.body
                                        ;   Parent Loop BB5_9 Depth=1
                                        ;     Parent Loop BB5_11 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
                                        ; Label of block must be emitted
                                        ; @0x72c AlignLabel LoopTop Freq=2099
	vvld.ab.w.p1	%vr3,%r12,32            ; @0x72c
	vvld.ab.w.p1	%vr4,%r3,32             ; @0x734
	vvmpy.w	%vr3, %vr4, %vr3                ; @0x73c
	vvadd.w	%vr2, %vr3, %vr2                ; @0x742
.LZD10:                                 ; @0x748
	; ZD Loop End                           ; @0x748
;  %bb.25:                              ; %vec.epilog.middle.block
                                        ;   in Loop: Header=BB5_11 Depth=2

	mov	%r12,%r30                       ; implicit-def: $vr3
                                        ; @0x748
	vvshfl.w.p2	%vr3, %vr2, %vr1        ; @0x74c
	vvadd.w	%vr2, %vr2, %vr3                ; @0x752
	vvshfl.w.p3	%vr3, %vr2, %vr0        ; @0x756
	vvadd.w	%vr2, %vr2, %vr3                ; @0x75c
	vvmov1.from.w	%r3,%vr2,1              ; @0x760
	vvadd.w	%vr2, %vr2, %r3                 ; @0x766
	vvmov1.x.from.w	%r3,%vr2,0              ; @0x76a
	breq	%r30,%r5,.LBB5_16               ; @0x770
.LBB5_26:                               ; %for.body42.preheader
                                        ;   in Loop: Header=BB5_11 Depth=2
                                        ; Label of block must be emitted
                                        ; @0x774 AlignLabel Freq=142
	mpy	%r20,%r12,%r4                   ; @0x774
	add	%r14,%r12,1                     ; @0x778
	add	%r15,%r12,%r21                  ; @0x77c
	max	%r13,%r5,%r14                   ; @0x780
	add	%r20,%r18,%r20                  ; @0x784
	add2	%r14,%r0,%r15                   ; @0x788
	sub	%lp_count,%r13,%r12             ; @0x78c
	; Implicit def %r13                     ; @0x790
	add2	%r12,%r11,%r20                  ; @0x790
	mov	%r58,%r3                        ; @0x794
	lp	.LZD11                          ; @0x798
.LBB5_27:                               ; %for.body42
                                        ;   Parent Loop BB5_9 Depth=1
                                        ;     Parent Loop BB5_11 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
                                        ; Label of block must be emitted
                                        ; @0x79c AlignLabel LoopTop Freq=4549
	ld.ab	%r3,[%r12,%r1]                  ; @0x79c
	ld.ab	%r13,[%r14,4]                   ; @0x7a0
	mac	%r3,%r13,%r3                    ; @0x7a4
.LZD11:                                 ; @0x7a8
	; ZD Loop End                           ; @0x7a8
.LBB5_16:                               ; %for.cond.cleanup41
                                        ;   in Loop: Header=BB5_11 Depth=2
                                        ; Label of block must be emitted
                                        ; @0x7a8 AlignLabel Freq=319
	mpy	%r12,%r22,%r4                   ; @0x7a8
	add_s	%r22,%r22,1                     ; @0x7ac
	add2	%r19,%r19,%r5                   ; @0x7ae
	cmp	%r22,%r17                       ; @0x7b2
	add_s	%r12,%r12,%r18                  ; @0x7b6
	add2	%r12,%r2,%r12                   ; @0x7b8
	add	%r21,%r21,%r5                   ; @0x7bc
	st_s	%r3,[%r12,0]                    ; @0x7c0
	blt	.LBB5_11                        ; @0x7c2
.LBB5_17:                               ; %for.cond.cleanup35
                                        ;   in Loop: Header=BB5_9 Depth=1
                                        ; @0x7c6
	add_s	%r18,%r18,1                     ; @0x7c6
	add_s	%r8,%r8,4                       ; @0x7c8
	cmp	%r18,%r4                        ; @0x7ca
	blt	.LBB5_9                         ; @0x7ce
.LBB5_18:                               ; %for.cond.cleanup30
                                        ; @0x7d2
	ld	%blink,[%sp,40]                 ; @0x7d2
	.cfa_restore	{%blink}                ; @0x7d6
	ld	%r22,[%sp,36]                   ; @0x7d6
	.cfa_restore	{%r22}                  ; @0x7da
	ldd	%r20,[%sp,28]                   ; @0x7da
	.cfa_restore	{%r21}                  ; @0x7de
	.cfa_restore	{%r20}                  ; @0x7de
	ldd	%r18,[%sp,20]                   ; @0x7de
	.cfa_restore	{%r19}                  ; @0x7e2
	.cfa_restore	{%r18}                  ; @0x7e2
	ldd	%r16,[%sp,12]                   ; @0x7e2
	.cfa_restore	{%r17}                  ; @0x7e6
	.cfa_restore	{%r16}                  ; @0x7e6
	ldd	%r14,[%sp,4]                    ; @0x7e6
	.cfa_restore	{%r15}                  ; @0x7ea
	.cfa_restore	{%r14}                  ; @0x7ea
	ld.ab	%r13,[%sp,44]                   ; @0x7ea
	.cfa_restore	{%r13}                  ; @0x7ee
	.cfa_pop	44                              ; @0x7ee
	j_s	[%blink]                        ; @0x7ee
	.cfa_ef
.Lfunc_end5:                            ; @0x7f0

	.align	4                               ; -- End function
                                        ; -- Begin function autovectorized_matmul
autovectorized_matmul:                  ; @autovectorized_matmul
                                        ; @0x7f0
.Lautovectorized_matmul$local:          ; @0x7f0
	.cfa_bf	.Lautovectorized_matmul$local
;  %bb.0:                               ; %entry
	.cfa_same	%r5                     ; @0x7f0
	.cfa_same	%r4                     ; @0x7f0
	.cfa_same	%r2                     ; @0x7f0
	.cfa_same	%r1                     ; @0x7f0
	.cfa_same	%r0                     ; @0x7f0
	st.aw	%r13,[%sp,-56]                  ; @0x7f0
	.cfa_push	56                      ; @0x7f4
	.cfa_reg_offset	{%r13}, 0               ; @0x7f4
	std	%r14,[%sp,4]                    ; @0x7f4
	.cfa_reg_offset	{%r14}, 4               ; @0x7f8
	.cfa_reg_offset	{%r15}, 8               ; @0x7f8
	std	%r16,[%sp,12]                   ; @0x7f8
	.cfa_reg_offset	{%r16}, 12              ; @0x7fc
	.cfa_reg_offset	{%r17}, 16              ; @0x7fc
	std	%r18,[%sp,20]                   ; @0x7fc
	.cfa_reg_offset	{%r18}, 20              ; @0x800
	.cfa_reg_offset	{%r19}, 24              ; @0x800
	std	%r20,[%sp,28]                   ; @0x800
	.cfa_reg_offset	{%r20}, 28              ; @0x804
	.cfa_reg_offset	{%r21}, 32              ; @0x804
	std	%r22,[%sp,36]                   ; @0x804
	.cfa_reg_offset	{%r22}, 36              ; @0x808
	.cfa_reg_offset	{%r23}, 40              ; @0x808
	st	%r24,[%sp,44]                   ; @0x808
	.cfa_reg_offset	{%r24}, 44              ; @0x80c
	st	%fp,[%sp,48]                    ; @0x80c
	.cfa_reg_offset	{%fp}, 48               ; @0x810
	st	%blink,[%sp,52]                 ; @0x810
	.cfa_reg_offset	{%blink}, 52            ; @0x814
	mov_s	%r11,%r3                        ; @0x814
	cmp_s	%r3,0                           ; @0x816
	ble	.LBB6_8                         ; @0x818
;  %bb.1:                               ; %for.body.lr.ph
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov.w	 %vr1, 0                        ; @0x81c
	vvci.w	%vr0                            ; @0x81c
	sub3	%r3,%r5,64/8                    ; @0x81c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvpinit.w	%p2, 0, 65532           ; @0x828
	lsr	%r12,%r3,6                      ; @0x828
 ;	 }
.vvsbundle  "v3sc" 
 ;	 { 
	vvadd.w	%vr3, %vr0, 4                   ; @0x832
	vvadd.w	%vr2, %vr0, 2                   ; @0x832
	vvpinit.w	%p3, 0, 65520           ; @0x832
	mov_s	%r8,%r0                         ; @0x832
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvsel.w.p2	%vr0, %vr1, %vr2        ; @0x842
	vvpinit.w	%p1, 0, 255             ; @0x842
	asl	%r3,%r4,2                       ; @0x842
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvsel.w.p3	%vr1, %vr1, %vr3        ; @0x852
	vvpinit.w	%p2, 0, 15              ; @0x852
	setne	%r9,%r4,1                       ; @0x852
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvpinit.w	%p3, 0, 3               ; @0x862
	setlo	%r17,%r5,8                      ; @0x862
 ;	 }
	add	%r6,%r12,1                      ; @0x86c
	bmskn	%r7,%r5,2                       ; @0x870
	bmskn	%r30,%r5,5                      ; @0x874
	sub	%blink,%r5,8                    ; @0x878
	mov_s	%r19,0                          ; @0x87c
	mov_s	%r16,0                          ; @0x87e
.LBB6_2:                                ; %for.body
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB6_4 Depth 2
                                        ;       Child Loop BB6_12 Depth 3
                                        ;       Child Loop BB6_16 Depth 3
                                        ;       Child Loop BB6_19 Depth 3
                                        ; @0x880
	cmp_s	%r4,0                           ; @0x880
	ble	.LBB6_7                         ; @0x882
;  %bb.3:                               ; %for.body4.lr.ph
                                        ;   in Loop: Header=BB6_2 Depth=1
	mpy	%r18,%r16,%r4                   ; @0x886
	mov_s	%r21,%r1                        ; @0x88a
	mov	%fp,0                           ; @0x88c
.LBB6_4:                                ; %for.body4
                                        ;   Parent Loop BB6_2 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB6_12 Depth 3
                                        ;       Child Loop BB6_16 Depth 3
                                        ;       Child Loop BB6_19 Depth 3
                                        ; Label of block must be emitted
                                        ; @0x890 AlignLabel LoopTop Freq=426
	cmp_s	%r5,0                           ; @0x890
	ble	.LBB6_21                        ; @0x892
;  %bb.5:                               ; %iter.check
                                        ;   in Loop: Header=BB6_4 Depth=2
	add	%r13,%fp,%r18                   ; @0x896
	add2	%r20,%r2,%r13                   ; @0x89a
	or.f	0,%r17,%r9                      ; @0x89e
	ld	%r13,[%r20,0]                   ; @0x8a2
	mov_s	%r15,0                          ; @0x8a6
	bne_s	.LBB6_18                        ; Predicate Case 2
                                        ; @0x8a8
;  %bb.9:                               ; Predicate Case 2
                                        ; %vector.main.loop.iter.check
                                        ;   in Loop: Header=BB6_4 Depth=2
	cmp	%r5,64                          ; @0x8aa
	mov	%r14,0                          ; @0x8ae
	bcs	.LBB6_15                        ; Predicate Case 2
                                        ; @0x8b2
;  %bb.11:                              ; Predicate Case 2
                                        ; %vector.ph
                                        ;   in Loop: Header=BB6_4 Depth=2
.vvsbundle  "v3sc" 
 ;	 { 
	vvmov.w	 %vr18, 0                       ; @0x8b6
	vvmov.w	 %vr19, 0                       ; @0x8b6
	vvmov.w	 %vr16, 0                       ; @0x8b6
	add2	%r14,%r21,192/4                 ; @0x8b6
 ;	 }
	; Implicit def %r15                     ; @0x8c6
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr17, 0                       ; @0x8c6
	mov	%lp_count,%r6                   ; @0x8c6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr16,0,%r13            ; @0x8ce
	add2	%r13,%r8,192/4                  ; @0x8ce
 ;	 }
	lp	.LZD13                          ; @0x8d8
.LBB6_12:                               ; %vector.body
                                        ;   Parent Loop BB6_2 Depth=1
                                        ;     Parent Loop BB6_4 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
                                        ; Label of block must be emitted
                                        ; @0x8dc AlignLabel LoopTop Freq=2133
	vvld.av.w	%vr2,%r13,-1            ; @0x8dc
	vvld.av.w	%vr3,%r14,-1            ; @0x8e2
.vvsbundle  " v2" 
 ;	 { 
	vvld.av.w	%vr4,%r13,-1            ; @0x8e8
	vvcmac.lo.uu.w	%vr17, %vr3, %vr2       ; @0x8e8
 ;	 }
	vvld.av.w	%vr2,%r14,-1            ; @0x8f2
.vvsbundle  " v2" 
 ;	 { 
	vvld.av.w	%vr3,%r13,-1            ; @0x8f8
	vvcmac.lo.uu.w	%vr18, %vr2, %vr4       ; @0x8f8
 ;	 }
	vvld.av.w	%vr2,%r14,-1            ; @0x902
.vvsbundle  " v2" 
 ;	 { 
	vvld.av.w	%vr4,%r13,7             ; @0x908
	vvcmac.lo.uu.w	%vr19, %vr2, %vr3       ; @0x908
 ;	 }
	vvld.av.w	%vr2,%r14,7             ; @0x912
	vvcmac.lo.uu.w	%vr16, %vr2, %vr4       ; @0x918
.LZD13:                                 ; @0x91e
	; ZD Loop End                           ; @0x91e
;  %bb.13:                              ; %middle.block
                                        ;   in Loop: Header=BB6_4 Depth=2
	vvadd.w	%vr2, %vr19, %vr16              ; @0x91e
	vvadd.w	%vr2, %vr18, %vr2               ; @0x924
	vvadd.w	%vr16, %vr17, %vr2              ; @0x92a
	vvc2add.w	%vr16                   ; @0x930
	vvshfleven.w	%vr16, %vr16            ; @0x934
	vvc2add.w	%vr16                   ; @0x938
	vvshfleven.w	%vr16, %vr16            ; @0x93c
	vvc2add.w	%vr16                   ; @0x940
	vvshfleven.w	%vr16, %vr16            ; @0x944
	vvc2add.w	%vr16                   ; @0x948
	vvmov1.x.from.w	%r13,%vr16,0            ; @0x94c
	breq	%r30,%r5,.LBB6_20               ; @0x952
;  %bb.14:                              ; %vec.epilog.iter.check
                                        ;   in Loop: Header=BB6_4 Depth=2
	mov	%r14,%r30                       ; @0x956
	mov	%r15,%r30                       ; @0x95a
	tst	%r5,56                          ; @0x95e
	beq_s	.LBB6_18                        ; @0x962
.LBB6_15:                               ; %vec.epilog.ph
                                        ;   in Loop: Header=BB6_4 Depth=2
                                        ; @0x964
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr2, 0                        ; @0x964
	sub	%r22,%blink,%r14                ; @0x964
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,0,%r13             ; @0x96c
	add	%r15,%r19,%r14                  ; @0x96c
 ;	 }
	add_s	%r14,%r14,%fp                   ; @0x976
	lsr	%r22,%r22,3                     ; @0x978
	add2	%r13,%r0,%r15                   ; @0x97c
	; Implicit def %r15                     ; @0x980
	add2	%r14,%r1,%r14                   ; @0x980
	add	%lp_count,%r22,1                ; @0x984
	lp	.LZD14                          ; @0x988
.LBB6_16:                               ; %vec.epilog.vector.body
                                        ;   Parent Loop BB6_2 Depth=1
                                        ;     Parent Loop BB6_4 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
                                        ; Label of block must be emitted
                                        ; @0x98c AlignLabel LoopTop Freq=2799
	vvld.ab.w.p1	%vr3,%r13,32            ; @0x98c
	vvld.ab.w.p1	%vr4,%r14,32            ; @0x994
	vvmpy.w	%vr3, %vr4, %vr3                ; @0x99c
	vvadd.w	%vr2, %vr3, %vr2                ; @0x9a2
.LZD14:                                 ; @0x9a8
	; ZD Loop End                           ; @0x9a8
;  %bb.17:                              ; %vec.epilog.middle.block
                                        ;   in Loop: Header=BB6_4 Depth=2

	mov	%r15,%r7                        ; implicit-def: $vr3
                                        ; widened to benefit BPU
                                        ; @0x9a8
	vvshfl.w.p2	%vr3, %vr2, %vr1        ; @0x9ac
	vvadd.w	%vr2, %vr2, %vr3                ; @0x9b2
	vvshfl.w.p3	%vr3, %vr2, %vr0        ; @0x9b6
	vvadd.w	%vr2, %vr2, %vr3                ; @0x9bc
	vvmov1.from.w	%r13,%vr2,1             ; @0x9c0
	vvadd.w	%vr2, %vr2, %r13                ; @0x9c6
	vvmov1.x.from.w	%r13,%vr2,0             ; @0x9ca
	breq	%r7,%r5,.LBB6_20                ; @0x9d0
.LBB6_18:                               ; %for.body8.preheader
                                        ;   in Loop: Header=BB6_4 Depth=2
                                        ; Label of block must be emitted
                                        ; @0x9d4 AlignLabel Freq=189
	mpy	%r22,%r15,%r4                   ; @0x9d4
	add	%r14,%r15,1                     ; widened to benefit BPU
                                        ; @0x9d8
	add	%r23,%r19,%r15                  ; @0x9dc
	max	%r24,%r5,%r14                   ; @0x9e0
	add	%r22,%fp,%r22                   ; @0x9e4
	add2	%r14,%r0,%r23                   ; @0x9e8
	sub	%lp_count,%r24,%r15             ; @0x9ec
	add2	%r15,%r1,%r22                   ; @0x9f0
	mov	%r58,%r13                       ; @0x9f4
	; Implicit def %r13                     ; @0x9f8
	lp	.LZD15                          ; @0x9f8
.LBB6_19:                               ; %for.body8
                                        ;   Parent Loop BB6_2 Depth=1
                                        ;     Parent Loop BB6_4 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
                                        ; Label of block must be emitted
                                        ; @0x9fc AlignLabel LoopTop Freq=6066
	ld.ab	%r13,[%r14,4]                   ; @0x9fc
	ld.ab	%r12,[%r15,%r3]                 ; @0xa00
	mac	%r13,%r12,%r13                  ; @0xa04
.LZD15:                                 ; @0xa08
	; ZD Loop End                           ; @0xa08
.LBB6_20:                               ; %for.cond5.for.cond.cleanup7_crit_edge
                                        ;   in Loop: Header=BB6_4 Depth=2
                                        ; Label of block must be emitted
                                        ; @0xa08 AlignLabel Freq=266
	st	%r13,[%r20,0]                   ; @0xa08
.LBB6_21:                               ; %for.cond.cleanup7
                                        ;   in Loop: Header=BB6_4 Depth=2
                                        ; Label of block must be emitted
                                        ; @0xa0c AlignLabel Freq=426
	add_s	%fp,%fp,1                       ; @0xa0c
	add_s	%r21,%r21,4                     ; @0xa0e
	cmp	%fp,%r4                         ; @0xa10
	blt	.LBB6_4                         ; @0xa14
.LBB6_7:                                ; %for.cond.cleanup3
                                        ;   in Loop: Header=BB6_2 Depth=1
                                        ; @0xa18
	add_s	%r16,%r16,1                     ; @0xa18
	add2	%r8,%r8,%r5                     ; @0xa1a
	cmp	%r16,%r11                       ; @0xa1e
	add	%r19,%r19,%r5                   ; @0xa22
	blt	.LBB6_2                         ; @0xa26
.LBB6_8:                                ; %for.cond.cleanup
                                        ; @0xa2a
	ld	%blink,[%sp,52]                 ; @0xa2a
	.cfa_restore	{%blink}                ; @0xa2e
	ld	%fp,[%sp,48]                    ; @0xa2e
	.cfa_restore	{%fp}                   ; @0xa32
	ld	%r24,[%sp,44]                   ; @0xa32
	.cfa_restore	{%r24}                  ; @0xa36
	ldd	%r22,[%sp,36]                   ; @0xa36
	.cfa_restore	{%r23}                  ; @0xa3a
	.cfa_restore	{%r22}                  ; @0xa3a
	ldd	%r20,[%sp,28]                   ; @0xa3a
	.cfa_restore	{%r21}                  ; @0xa3e
	.cfa_restore	{%r20}                  ; @0xa3e
	ldd	%r18,[%sp,20]                   ; @0xa3e
	.cfa_restore	{%r19}                  ; @0xa42
	.cfa_restore	{%r18}                  ; @0xa42
	ldd	%r16,[%sp,12]                   ; @0xa42
	.cfa_restore	{%r17}                  ; @0xa46
	.cfa_restore	{%r16}                  ; @0xa46
	ldd	%r14,[%sp,4]                    ; @0xa46
	.cfa_restore	{%r15}                  ; @0xa4a
	.cfa_restore	{%r14}                  ; @0xa4a
	ld.ab	%r13,[%sp,56]                   ; @0xa4a
	.cfa_restore	{%r13}                  ; @0xa4e
	.cfa_pop	56                              ; @0xa4e
	j_s	[%blink]                        ; @0xa4e
	.cfa_ef
.Lfunc_end6:                            ; @0xa50

	.reloc	_init_ad,0	;startup code to enable %status AD bit ; -- End function
