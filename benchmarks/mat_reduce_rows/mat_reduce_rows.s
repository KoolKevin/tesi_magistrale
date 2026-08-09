	.option	%reg
	.off	assume_short
	.file	"mat_reduce_rows.c"
	.size	.Lstr.14, 2
	.type	.Lstr.14,@object
	.size	.L.str.4, 3
	.type	.L.str.4,@object
	.size	.L.str.5, 3
	.type	.L.str.5,@object
	.size	.Lstr.13, 3
	.type	.Lstr.13,@object
	.size	.L.str.6, 4
	.type	.L.str.6,@object
	.size	.Lstr.11, 2
	.type	.Lstr.11,@object
	.size	.Lstr, 32
	.type	.Lstr,@object
	.size	.Lstr.10, 37
	.type	.Lstr.10,@object
	.size	.L.str.1, 40
	.type	.L.str.1,@object
	.globl	init_matrix
	.type	init_matrix,@function
	.type	.Linit_matrix$local,@function
	.size	init_matrix, .Lfunc_end0-init_matrix
	.size	.Linit_matrix$local, .Lfunc_end0-init_matrix
	.globl	init_vector
	.type	init_vector,@function
	.type	.Linit_vector$local,@function
	.size	init_vector, .Lfunc_end1-init_vector
	.size	.Linit_vector$local, .Lfunc_end1-init_vector
	.globl	check_result
	.type	check_result,@function
	.type	.Lcheck_result$local,@function
	.size	check_result, .Lfunc_end2-check_result
	.size	.Lcheck_result$local, .Lfunc_end2-check_result
	.globl	copy_matrix
	.type	copy_matrix,@function
	.type	.Lcopy_matrix$local,@function
	.size	copy_matrix, .Lfunc_end3-copy_matrix
	.size	.Lcopy_matrix$local, .Lfunc_end3-copy_matrix
	.globl	print_matrix
	.type	print_matrix,@function
	.type	.Lprint_matrix$local,@function
	.size	print_matrix, .Lfunc_end4-print_matrix
	.size	.Lprint_matrix$local, .Lfunc_end4-print_matrix
	.globl	print_vector
	.type	print_vector,@function
	.type	.Lprint_vector$local,@function
	.size	print_vector, .Lfunc_end5-print_vector
	.size	.Lprint_vector$local, .Lfunc_end5-print_vector
	.globl	mat_reduce_rows
	.type	mat_reduce_rows,@function
	.type	.Lmat_reduce_rows$local,@function
	.size	mat_reduce_rows, .Lfunc_end6-mat_reduce_rows
	.size	.Lmat_reduce_rows$local, .Lfunc_end6-mat_reduce_rows
	.globl	vectorized_mat_reduce_rows
	.type	vectorized_mat_reduce_rows,@function
	.type	.Lvectorized_mat_reduce_rows$local,@function
	.size	vectorized_mat_reduce_rows, .Lfunc_end7-vectorized_mat_reduce_rows
	.size	.Lvectorized_mat_reduce_rows$local, .Lfunc_end7-vectorized_mat_reduce_rows
	.globl	autovectorized_mat_reduce_rows
	.type	autovectorized_mat_reduce_rows,@function
	.type	.Lautovectorized_mat_reduce_rows$local,@function
	.size	autovectorized_mat_reduce_rows, .Lfunc_end8-autovectorized_mat_reduce_rows
	.size	.Lautovectorized_mat_reduce_rows$local, .Lfunc_end8-autovectorized_mat_reduce_rows
	.globl	vekt_mat_reduce_rows_wrapper
	.type	vekt_mat_reduce_rows_wrapper,@function
	.type	.Lvekt_mat_reduce_rows_wrapper$local,@function
	.size	vekt_mat_reduce_rows_wrapper, .Lfunc_end9-vekt_mat_reduce_rows_wrapper
	.size	.Lvekt_mat_reduce_rows_wrapper$local, .Lfunc_end9-vekt_mat_reduce_rows_wrapper
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
	.align	2
.Lstr.14:                               ; @0x0
	.asciz	"]"
	.align	4
.L.str.4:                               ; @0x4
	.asciz	"\t["
	.align	4
.L.str.5:                               ; @0x8
	.asciz	"%d"
	.align	4
.Lstr.13:                               ; @0xc
	.asciz	"],"
	.align	4
.L.str.6:                               ; @0x10
	.asciz	"%d,"
	.align	2
.Lstr.11:                               ; @0x14
	.asciz	"["
	.align	4
.Lstr:                                  ; @0x18
	.asciz	"SUCCESSO! I vettori sono uguali"
	.align	4
.Lstr.10:                               ; @0x38
	.asciz	"ERRORE! I vettori non corrispondono!"
	.align	4
.L.str.1:                               ; @0x60
	.asciz	"\tElemento (%d) di A = %d mentre B = %d\n"
	.text
	.global	.CC_I
	.equ	.CC_I, 0
	.ident	"LLVM 17.0.7/V-2024.06. (build 008) (LLVM 17.0.7) -arcv2hs -core4 -Xcode_density -Xatomic -Xll64 -Xunaligned -Xdiv_rem=radix4 -Xswap -Xbitscan -Xmpy_option=mpyd -Xshift_assist -Xbarrel_shifter -Xfpud_div -Xfpu_mac -Xtimer0 -Xrtc -Xstack_check -Xstu=4 -Xvdsp4 -Xvec_unit_rev_minor=1 -Xvec_width=512 -Xvec_mem_size=128k -Xvec_mem_bank_width=16 -Xvec_max_fetch_size=16 -Xvec_num_slots=3 -Xvec_super_with_scalar -Xvec_regs=32 -Xvec_fpu=32 -Xvec_fpu_math=3 -Xvec_fpu_2nd_mul -Xvec_fpu_types=2 -Xvec_num_rd_ports=6 -Xvec_num_acc=8 -Xvec_num_mpy=2 -Xvec_mpy32 -Xvec_num_alu=3 -Xvec_guard_bit_option=0 -Xvec_stack_check -Hvdsp_vector_c -O3 -fvectorize -fslp-vectorize -ffast-math"
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
	vvmov2.x.from.w	%r4,%vr0,0              ; @0x2e
	sub3	%r12,%r1,64/8                   ; @0x2e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r6,%vr0,2              ; @0x38
	lsr_s	%r12,%r12,6                     ; @0x38
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r8,%vr0,4              ; @0x40
	bmskn	%r2,%r1,5                       ; @0x40
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r22,%vr0,6             ; @0x4a
	add	%lp_count,%r12,1                ; @0x4a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r20,%vr0,8             ; @0x54
	add	%r12,%r0,56                     ; @0x54
 ;	 }
	vvmov2.x.from.w	%r18,%vr0,10            ; @0x5e
	vvmov2.x.from.w	%r16,%vr0,12            ; @0x64
	vvmov2.x.from.w	%r14,%vr0,14            ; @0x6a
	lp	.LZD2                           ; @0x70
.LBB0_4:                                ; %vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x74
	std.ab	%r14,[%r12,64]                  ; @0x74
	std.ab	%r14,[%r12,64]                  ; @0x78
	std.ab	%r14,[%r12,64]                  ; @0x7c
	std.ab	%r14,[%r12,-200]                ; @0x80
	std.ab	%r16,[%r12,-8]                  ; @0x84
	std.ab	%r18,[%r12,-8]                  ; @0x88
	std.ab	%r20,[%r12,-8]                  ; @0x8c
	std.ab	%r22,[%r12,-8]                  ; @0x90
	std.ab	%r8,[%r12,-8]                   ; @0x94
	std.ab	%r6,[%r12,-8]                   ; @0x98
	std.ab	%r4,[%r12,112]                  ; @0x9c
	std.ab	%r16,[%r12,-8]                  ; @0xa0
	std.ab	%r18,[%r12,-8]                  ; @0xa4
	std.ab	%r20,[%r12,-8]                  ; @0xa8
	std.ab	%r22,[%r12,-8]                  ; @0xac
	std.ab	%r8,[%r12,-8]                   ; @0xb0
	std.ab	%r6,[%r12,-8]                   ; @0xb4
	std.ab	%r4,[%r12,112]                  ; @0xb8
	std.ab	%r16,[%r12,-8]                  ; @0xbc
	std.ab	%r18,[%r12,-8]                  ; @0xc0
	std.ab	%r20,[%r12,-8]                  ; @0xc4
	std.ab	%r22,[%r12,-8]                  ; @0xc8
	std.ab	%r8,[%r12,-8]                   ; @0xcc
	std.ab	%r6,[%r12,-8]                   ; @0xd0
	std.ab	%r4,[%r12,112]                  ; @0xd4
	std.ab	%r16,[%r12,-8]                  ; @0xd8
	std.ab	%r18,[%r12,-8]                  ; @0xdc
	std.ab	%r20,[%r12,-8]                  ; @0xe0
	std.ab	%r22,[%r12,-8]                  ; @0xe4
	std.ab	%r8,[%r12,-8]                   ; @0xe8
	std.ab	%r6,[%r12,-8]                   ; @0xec
	std.ab	%r4,[%r12,120]                  ; @0xf0
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
                                        ; -- Begin function init_vector
init_vector:                            ; @init_vector
                                        ; @0x16c
.Linit_vector$local:                    ; @0x16c
	.cfa_bf	.Linit_vector$local
;  %bb.0:                               ; %entry
	.cfa_same	%r2                     ; @0x16c
	std.aw	%r14,[%sp,-40]                  ; @0x16c
	.cfa_push	40                      ; @0x170
	.cfa_reg_offset	{%r14}, 0               ; @0x170
	.cfa_reg_offset	{%r15}, 4               ; @0x170
	std	%r16,[%sp,8]                    ; @0x170
	.cfa_reg_offset	{%r16}, 8               ; @0x174
	.cfa_reg_offset	{%r17}, 12              ; @0x174
	std	%r18,[%sp,16]                   ; @0x174
	.cfa_reg_offset	{%r18}, 16              ; @0x178
	.cfa_reg_offset	{%r19}, 20              ; @0x178
	std	%r20,[%sp,24]                   ; @0x178
	.cfa_reg_offset	{%r20}, 24              ; @0x17c
	.cfa_reg_offset	{%r21}, 28              ; @0x17c
	std	%r22,[%sp,32]                   ; @0x17c
	.cfa_reg_offset	{%r22}, 32              ; @0x180
	.cfa_reg_offset	{%r23}, 36              ; @0x180
	cmp_s	%r1,0                           ; @0x180
	ble	.LBB1_12                        ; @0x182
;  %bb.1:                               ; %iter.check
	cmp_s	%r1,8                           ; @0x186
	mov_s	%r3,0                           ; @0x188
	bcs	.LBB1_10                        ; @0x18a
;  %bb.2:                               ; %vector.main.loop.iter.check
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr0, %r2                      ; @0x18e
	cmp_s	%r1,64                          ; @0x18e
 ;	 }
	bcs	.LBB1_7                         ; @0x194
;  %bb.3:                               ; %vector.ph
	; Implicit def %r30                     ; @0x198
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r4,%vr0,0              ; @0x198
	sub3	%r12,%r1,64/8                   ; @0x198
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r6,%vr0,2              ; @0x1a2
	lsr_s	%r12,%r12,6                     ; @0x1a2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r8,%vr0,4              ; @0x1aa
	bmskn	%r3,%r1,5                       ; @0x1aa
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r22,%vr0,6             ; @0x1b4
	add	%lp_count,%r12,1                ; @0x1b4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r20,%vr0,8             ; @0x1be
	add	%r12,%r0,56                     ; @0x1be
 ;	 }
	vvmov2.x.from.w	%r18,%vr0,10            ; @0x1c8
	vvmov2.x.from.w	%r16,%vr0,12            ; @0x1ce
	vvmov2.x.from.w	%r14,%vr0,14            ; @0x1d4
	lp	.LZD5                           ; @0x1da
.LBB1_4:                                ; %vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x1de
	std.ab	%r14,[%r12,64]                  ; @0x1de
	std.ab	%r14,[%r12,64]                  ; @0x1e2
	std.ab	%r14,[%r12,64]                  ; @0x1e6
	std.ab	%r14,[%r12,-200]                ; @0x1ea
	std.ab	%r16,[%r12,-8]                  ; @0x1ee
	std.ab	%r18,[%r12,-8]                  ; @0x1f2
	std.ab	%r20,[%r12,-8]                  ; @0x1f6
	std.ab	%r22,[%r12,-8]                  ; @0x1fa
	std.ab	%r8,[%r12,-8]                   ; @0x1fe
	std.ab	%r6,[%r12,-8]                   ; @0x202
	std.ab	%r4,[%r12,112]                  ; @0x206
	std.ab	%r16,[%r12,-8]                  ; @0x20a
	std.ab	%r18,[%r12,-8]                  ; @0x20e
	std.ab	%r20,[%r12,-8]                  ; @0x212
	std.ab	%r22,[%r12,-8]                  ; @0x216
	std.ab	%r8,[%r12,-8]                   ; @0x21a
	std.ab	%r6,[%r12,-8]                   ; @0x21e
	std.ab	%r4,[%r12,112]                  ; @0x222
	std.ab	%r16,[%r12,-8]                  ; @0x226
	std.ab	%r18,[%r12,-8]                  ; @0x22a
	std.ab	%r20,[%r12,-8]                  ; @0x22e
	std.ab	%r22,[%r12,-8]                  ; @0x232
	std.ab	%r8,[%r12,-8]                   ; @0x236
	std.ab	%r6,[%r12,-8]                   ; @0x23a
	std.ab	%r4,[%r12,112]                  ; @0x23e
	std.ab	%r16,[%r12,-8]                  ; @0x242
	std.ab	%r18,[%r12,-8]                  ; @0x246
	std.ab	%r20,[%r12,-8]                  ; @0x24a
	std.ab	%r22,[%r12,-8]                  ; @0x24e
	std.ab	%r8,[%r12,-8]                   ; @0x252
	std.ab	%r6,[%r12,-8]                   ; @0x256
	std.ab	%r4,[%r12,120]                  ; @0x25a
.LZD5:                                  ; @0x25e
	; ZD Loop End                           ; @0x25e
;  %bb.5:                               ; %middle.block
	breq	%r3,%r1,.LBB1_12                ; @0x25e
;  %bb.6:                               ; %vec.epilog.iter.check
	tst	%r1,56                          ; @0x262
	beq_s	.LBB1_10                        ; @0x266
.LBB1_7:                                ; %vec.epilog.ph
                                        ; @0x268
	; Implicit def %r30                     ; @0x268
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r4,%vr0,0              ; @0x268
	sub_s	%r15,%r1,%r3                    ; @0x268
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r6,%vr0,2              ; @0x270
	sub_s	%r15,%r15,8                     ; @0x270
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r8,%vr0,4              ; @0x278
	lsr_s	%r15,%r15,3                     ; @0x278
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r22,%vr0,6             ; @0x280
	add2	%r12,%r0,%r3                    ; @0x280
 ;	 }
	bmskn	%r3,%r1,2                       ; @0x28a
	add	%lp_count,%r15,1                ; @0x28e
	lp	.LZD4                           ; @0x292
.LBB1_8:                                ; %vec.epilog.vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x296
	std	%r22,[%r12,24]                  ; @0x296
	std	%r8,[%r12,16]                   ; @0x29a
	std	%r6,[%r12,8]                    ; @0x29e
	std.ab	%r4,[%r12,32]                   ; @0x2a2
.LZD4:                                  ; @0x2a6
	; ZD Loop End                           ; @0x2a6
;  %bb.9:                               ; %vec.epilog.middle.block
	breq	%r3,%r1,.LBB1_12                ; @0x2a6
.LBB1_10:                               ; %for.body.preheader
                                        ; @0x2aa
	add_s	%r12,%r3,1                      ; @0x2aa
	max	%r1,%r1,%r12                    ; @0x2ac
	add2_s	%r0,%r0,%r3                     ; @0x2b0
	sub	%lp_count,%r1,%r3               ; @0x2b2
	; Implicit def %r3                      ; @0x2b6
	lp	.LZD3                           ; @0x2b6
.LBB1_11:                               ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x2ba
	st.ab	%r2,[%r0,4]                     ; @0x2ba
.LZD3:                                  ; @0x2be
	; ZD Loop End                           ; @0x2be
.LBB1_12:                               ; %for.cond.cleanup
                                        ; @0x2be
	ldd	%r22,[%sp,32]                   ; @0x2be
	.cfa_restore	{%r23}                  ; @0x2c2
	.cfa_restore	{%r22}                  ; @0x2c2
	ldd	%r20,[%sp,24]                   ; @0x2c2
	.cfa_restore	{%r21}                  ; @0x2c6
	.cfa_restore	{%r20}                  ; @0x2c6
	ldd	%r18,[%sp,16]                   ; @0x2c6
	.cfa_restore	{%r19}                  ; @0x2ca
	.cfa_restore	{%r18}                  ; @0x2ca
	ldd	%r16,[%sp,8]                    ; @0x2ca
	.cfa_restore	{%r17}                  ; @0x2ce
	.cfa_restore	{%r16}                  ; @0x2ce
	ldd.ab	%r14,[%sp,40]                   ; @0x2ce
	.cfa_restore	{%r15}                  ; @0x2d2
	.cfa_restore	{%r14}                  ; @0x2d2
	.cfa_pop	40                              ; @0x2d2
	j_s	[%blink]                        ; @0x2d2
	.cfa_ef
.Lfunc_end1:                            ; @0x2d4

	.align	4                               ; -- End function
                                        ; -- Begin function check_result
check_result:                           ; @check_result
                                        ; @0x2d4
.Lcheck_result$local:                   ; @0x2d4
	.cfa_bf	.Lcheck_result$local
;  %bb.0:                               ; %entry
	st.aw	%r13,[%sp,-20]                  ; @0x2d4
	.cfa_push	20                      ; @0x2d8
	.cfa_reg_offset	{%r13}, 0               ; @0x2d8
	std	%r14,[%sp,4]                    ; @0x2d8
	.cfa_reg_offset	{%r14}, 4               ; @0x2dc
	.cfa_reg_offset	{%r15}, 8               ; @0x2dc
	st	%r16,[%sp,12]                   ; @0x2dc
	.cfa_reg_offset	{%r16}, 12              ; @0x2e0
	st	%blink,[%sp,16]                 ; @0x2e0
	.cfa_reg_offset	{%blink}, 16            ; @0x2e4
	sub.f	%lp_count,%r2,0                 ; @0x2e4
	mov_s	%r16,.Lstr                      ; @0x2e8
	ble_s	.LBB2_5                         ; @0x2ee
;  %bb.1:                               ; %for.body.preheader
	mov_s	%r13,%r1                        ; @0x2f0
	; Implicit def %r1                      ; @0x2f2
	mov_s	%r14,%r0                        ; @0x2f2
	mov_s	%r15,0                          ; @0x2f4
	lp	.LZD6                           ; @0x2f6
.LBB2_2:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x2fa
	ld.ab	%r0,[%r13,4]                    ; @0x2fa
	ld.ab	%r1,[%r14,4]                    ; @0x2fe
	brne	%r1,%r0,.LBB2_4                 ; @0x302
;  %bb.3:                               ; %for.inc
                                        ;   in Loop: Header=BB2_2 Depth=1
	add_s	%r15,%r15,1                     ; @0x306
.LZD6:                                  ; @0x308
	; ZD Loop End                           ; @0x308
.LBB2_5:                                ; %for.end
                                        ; @0x308
	mov	%r0,%r16                        ; widened to benefit BPU
                                        ; @0x308
	nop                                     ; inserted to benefit BPU
                                        ; @0x30c
	bl.d	puts                            ; @0x310
	nop                                     ; inserted to benefit BPU
                                        ; @0x314
	b	.LBB2_6                         ; widened to benefit BPU
                                        ; @0x318
.LBB2_4:                                ; %cleanup
                                        ; @0x31c
	add	%r0,%r16,.Lstr.10-.Lstr         ; @0x31c
	bl	puts                            ; @0x320
	ld	%r2,[%r14,-4]                   ; @0x324
	ld	%r3,[%r13,-4]                   ; @0x328
	add1	%r0,%r16,(.L.str.1-.Lstr)/2     ; @0x32c
	mov_s	%r1,%r15                        ; @0x330
	bl	printf                          ; @0x332
.LBB2_6:                                ; %return
                                        ; @0x336
	ld	%blink,[%sp,16]                 ; @0x336
	.cfa_restore	{%blink}                ; @0x33a
	ld	%r16,[%sp,12]                   ; @0x33a
	.cfa_restore	{%r16}                  ; @0x33e
	ldd	%r14,[%sp,4]                    ; @0x33e
	.cfa_restore	{%r15}                  ; @0x342
	.cfa_restore	{%r14}                  ; @0x342
	ld.ab	%r13,[%sp,20]                   ; @0x342
	.cfa_restore	{%r13}                  ; @0x346
	.cfa_pop	20                              ; @0x346
	j_s	[%blink]                        ; @0x346
	.cfa_ef
.Lfunc_end2:                            ; @0x348

	.align	4                               ; -- End function
                                        ; -- Begin function copy_matrix
copy_matrix:                            ; @copy_matrix
                                        ; @0x348
.Lcopy_matrix$local:                    ; @0x348
	.cfa_bf	.Lcopy_matrix$local
;  %bb.0:                               ; %entry
	st.aw	%r13,[%sp,-56]                  ; @0x348
	.cfa_push	56                      ; @0x34c
	.cfa_reg_offset	{%r13}, 0               ; @0x34c
	std	%r14,[%sp,4]                    ; @0x34c
	.cfa_reg_offset	{%r14}, 4               ; @0x350
	.cfa_reg_offset	{%r15}, 8               ; @0x350
	std	%r16,[%sp,12]                   ; @0x350
	.cfa_reg_offset	{%r16}, 12              ; @0x354
	.cfa_reg_offset	{%r17}, 16              ; @0x354
	std	%r18,[%sp,20]                   ; @0x354
	.cfa_reg_offset	{%r18}, 20              ; @0x358
	.cfa_reg_offset	{%r19}, 24              ; @0x358
	std	%r20,[%sp,28]                   ; @0x358
	.cfa_reg_offset	{%r20}, 28              ; @0x35c
	.cfa_reg_offset	{%r21}, 32              ; @0x35c
	std	%r22,[%sp,36]                   ; @0x35c
	.cfa_reg_offset	{%r22}, 36              ; @0x360
	.cfa_reg_offset	{%r23}, 40              ; @0x360
	st	%r24,[%sp,44]                   ; @0x360
	.cfa_reg_offset	{%r24}, 44              ; @0x364
	st	%fp,[%sp,48]                    ; @0x364
	.cfa_reg_offset	{%fp}, 48               ; @0x368
	st	%blink,[%sp,52]                 ; @0x368
	.cfa_reg_offset	{%blink}, 52            ; @0x36c
	mov_s	%r24,%r0                        ; @0x36c
	cmp_s	%r2,0                           ; @0x36e
	ble	.LBB3_38                        ; @0x370
;  %bb.1:                               ; %entry
	mov_s	%r6,%r3                         ; @0x374
	cmp_s	%r3,0                           ; @0x376
	ble	.LBB3_38                        ; @0x378
;  %bb.2:                               ; %for.body.lr.ph.split.us
	brhs	%r6,8,.LBB3_6                   ; @0x37c
;  %bb.3:                               ; %iter.check.us.preheader
	mov	%r0,%r24                        ; @0x380
.LBB3_4:                                ; %iter.check.us
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB3_5 Depth 2
                                        ; @0x384
	; Implicit def %r12                     ; @0x384
	mov	%lp_count,%r6                   ; @0x384
	lp	.LZD7                           ; @0x388
.LBB3_5:                                ; %for.body4.us.us
                                        ;   Parent Loop BB3_4 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; Label of block must be emitted
                                        ; @0x38c AlignLabel LoopTop Freq=255
	ld.ab	%r3,[%r1,4]                     ; @0x38c
	st.ab	%r3,[%r0,4]                     ; @0x390
.LZD7:                                  ; @0x394
	; ZD Loop End                           ; @0x394
;  %bb.37:                              ; %for.cond.cleanup3.us.loopexit.us
                                        ;   in Loop: Header=BB3_4 Depth=1
	dbnz	%r2,.LBB3_4                     ; @0x394
	b	.LBB3_38                        ; @0x398
.LBB3_6:                                ; %for.body.lr.ph.split.us.split
                                        ; @0x39c
	asl	%r16,%r6,2                      ; @0x39c
	cmp	%r6,63                          ; @0x3a0
	bmskn	%r11,%r6,2                      ; @0x3a4
	bhi	.LBB3_16                        ; @0x3a8
;  %bb.7:                               ; %iter.check.us39.preheader
	sub	%r0,%r6,8                       ; @0x3ac
	lsr_s	%r0,%r0,3                       ; @0x3b0
	mov_s	%r7,%r1                         ; @0x3b2
	mov_s	%r4,%r24                        ; @0x3b4
	add	%r8,%r0,1                       ; @0x3b6
	mov_s	%r14,0                          ; @0x3ba
	mov_s	%r13,0                          ; @0x3bc
.LBB3_8:                                ; %iter.check.us39
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB3_11 Depth 2
                                        ;     Child Loop BB3_13 Depth 2
                                        ; @0x3be
	mpy	%r0,%r16,%r13                   ; @0x3be
	add	%r3,%r16,%r0                    ; @0x3c2
	add	%r12,%r24,%r0                   ; @0x3c6
	add_s	%r15,%r1,%r3                    ; @0x3ca
	brhs	%r12,%r15,.LBB3_10              ; @0x3cc
;  %bb.9:                               ; %iter.check.us39
                                        ;   in Loop: Header=BB3_8 Depth=1
	add_s	%r12,%r1,%r0                    ; @0x3d0
	add_s	%r3,%r3,%r24                    ; @0x3d2
	mov_s	%r0,0                           ; @0x3d4
	brlo	%r12,%r3,.LBB3_12               ; @0x3d6
.LBB3_10:                               ; %vec.epilog.vector.body.us.preheader
                                        ;   in Loop: Header=BB3_8 Depth=1
                                        ; @0x3da
	; Implicit def %r9                      ; @0x3da
	mov	%lp_count,%r8                   ; @0x3da
	mov_s	%r0,%r7                         ; @0x3de
	mov_s	%r3,%r4                         ; @0x3e0
	lp	.LZD9                           ; @0x3e2
.LBB3_11:                               ; %vec.epilog.vector.body.us
                                        ;   Parent Loop BB3_8 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; @0x3e6
	ldd	%r22,[%r0,24]                   ; @0x3e6
	ldd	%r20,[%r0,16]                   ; @0x3ea
	ldd	%r18,[%r0,8]                    ; @0x3ee
	ldd.ab	%r30,[%r0,32]                   ; @0x3f2
	std	%r22,[%r3,24]                   ; @0x3f6
	std	%r20,[%r3,16]                   ; @0x3fa
	std	%r18,[%r3,8]                    ; @0x3fe
	std.ab	%r30,[%r3,32]                   ; @0x402
.LZD9:                                  ; @0x406
	; ZD Loop End                           ; @0x406
;  %bb.14:                              ; %vec.epilog.middle.block.us
                                        ;   in Loop: Header=BB3_8 Depth=1
	mov_s	%r0,%r11                        ; @0x406
	breq	%r11,%r6,.LBB3_15               ; @0x408
.LBB3_12:                               ; %for.body4.us.us42.preheader
                                        ;   in Loop: Header=BB3_8 Depth=1
                                        ; @0x40c
	; Implicit def %r9                      ; @0x40c
	add_s	%r3,%r0,1                       ; @0x40c
	add_s	%r12,%r0,%r14                   ; @0x40e
	max	%r3,%r6,%r3                     ; @0x410
	sub	%lp_count,%r3,%r0               ; @0x414
	add2	%r0,%r1,%r12                    ; @0x418
	add2	%r3,%r24,%r12                   ; @0x41c
	lp	.LZD10                          ; @0x420
.LBB3_13:                               ; %for.body4.us.us42
                                        ;   Parent Loop BB3_8 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; @0x424
	ld.ab	%r12,[%r0,4]                    ; @0x424
	st.ab	%r12,[%r3,4]                    ; @0x428
.LZD10:                                 ; @0x42c
	; ZD Loop End                           ; @0x42c
.LBB3_15:                               ; %for.cond.cleanup3.us.us49
                                        ;   in Loop: Header=BB3_8 Depth=1
                                        ; @0x42c
	add_s	%r13,%r13,1                     ; @0x42c
	add_s	%r14,%r14,%r6                   ; @0x42e
	add	%r7,%r7,%r16                    ; @0x430
	add	%r4,%r4,%r16                    ; @0x434
	brlt	%r13,%r2,.LBB3_8                ; @0x438
	b	.LBB3_38                        ; @0x43c
.LBB3_16:                               ; %for.body.lr.ph.split.us.split.split
                                        ; @0x440
	bmskn	%fp,%r6,5                       ; @0x440
	cmp	%fp,%r6                         ; @0x444
	bne_s	.LBB3_17                        ; @0x448
;  %bb.18:                              ; %iter.check.us55.preheader
	sub3	%r0,%r6,64/8                    ; @0x44a
	lsr_s	%r0,%r0,6                       ; @0x44e
	mov_s	%r8,%r1                         ; @0x450
	mov_s	%r14,%r24                       ; @0x452
	mov_s	%r13,0                          ; @0x454
	add	%r11,%r0,1                      ; @0x456
.LBB3_19:                               ; %iter.check.us55
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB3_24 Depth 2
                                        ;     Child Loop BB3_22 Depth 2
                                        ; @0x45a
	mpy	%r0,%r16,%r13                   ; @0x45a
	add	%r3,%r16,%r0                    ; @0x45e
	add	%r15,%r24,%r0                   ; @0x462
	add_s	%r12,%r1,%r3                    ; @0x466
	cmp_s	%r15,%r12                       ; @0x468
	add_s	%r0,%r1,%r0                     ; @0x46a
	add_s	%r3,%r3,%r24                    ; Predicate Case 4
                                        ; @0x46c
	cmp.cs	%r0,%r3                         ; Predicate Case 4
                                        ; @0x46e
	bcc	.LBB3_21                        ; Predicate Case 4
                                        ; @0x472
;  %bb.23:                              ; %for.body4.us.us58.preheader
                                        ;   in Loop: Header=BB3_19 Depth=1
	; Implicit def %r9                      ; @0x476
	mov	%lp_count,%r6                   ; @0x476
	mov_s	%r0,%r8                         ; @0x47a
	mov_s	%r3,%r14                        ; @0x47c
	lp	.LZD12                          ; @0x47e
.LBB3_24:                               ; %for.body4.us.us58
                                        ;   Parent Loop BB3_19 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; @0x482
	ld.ab	%r12,[%r0,4]                    ; @0x482
	st.ab	%r12,[%r3,4]                    ; @0x486
.LZD12:                                 ; @0x48a
	; ZD Loop End                           ; @0x48a
	nop                                     ; inserted to benefit BPU
                                        ; @0x48a
	nop                                     ; widened to benefit BPU
                                        ; inserted to benefit BPU
                                        ; @0x48e
	b	.LBB3_25                        ; @0x492
.LBB3_21:                               ; %vector.body.us.preheader
                                        ;   in Loop: Header=BB3_19 Depth=1
                                        ; @0x496
	; Implicit def %r9                      ; @0x496
	mov	%lp_count,%r11                  ; @0x496
	add	%r0,%r8,56                      ; @0x49a
	add	%r3,%r14,56                     ; @0x49e
	lp	.LZD11                          ; @0x4a2
.LBB3_22:                               ; %vector.body.us
                                        ;   Parent Loop BB3_19 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; @0x4a6
	ldd.ab	%r4,[%r0,-8]                    ; @0x4a6
	ldd.ab	%r22,[%r0,-8]                   ; @0x4aa
	std.ab	%r4,[%r3,-8]                    ; @0x4ae
	ldd.ab	%r4,[%r0,-8]                    ; @0x4b2
	std.ab	%r22,[%r3,-8]                   ; @0x4b6
	ldd.ab	%r22,[%r0,-8]                   ; @0x4ba
	std.ab	%r4,[%r3,-8]                    ; @0x4be
	ldd.ab	%r4,[%r0,-8]                    ; @0x4c2
	std.ab	%r22,[%r3,-8]                   ; @0x4c6
	ldd.ab	%r22,[%r0,-8]                   ; @0x4ca
	std.ab	%r4,[%r3,-8]                    ; @0x4ce
	ldd.ab	%r4,[%r0,-8]                    ; @0x4d2
	std.ab	%r22,[%r3,-8]                   ; @0x4d6
	ldd.ab	%r22,[%r0,120]                  ; @0x4da
	std.ab	%r4,[%r3,-8]                    ; @0x4de
	ldd.ab	%r4,[%r0,-8]                    ; @0x4e2
	std.ab	%r22,[%r3,120]                  ; @0x4e6
	ldd.ab	%r22,[%r0,-8]                   ; @0x4ea
	std.ab	%r4,[%r3,-8]                    ; @0x4ee
	ldd.ab	%r4,[%r0,-8]                    ; @0x4f2
	std.ab	%r22,[%r3,-8]                   ; @0x4f6
	ldd.ab	%r22,[%r0,-8]                   ; @0x4fa
	std.ab	%r4,[%r3,-8]                    ; @0x4fe
	ldd.ab	%r4,[%r0,-8]                    ; @0x502
	std.ab	%r22,[%r3,-8]                   ; @0x506
	ldd.ab	%r22,[%r0,-8]                   ; @0x50a
	std.ab	%r4,[%r3,-8]                    ; @0x50e
	ldd.ab	%r4,[%r0,-8]                    ; @0x512
	std.ab	%r22,[%r3,-8]                   ; @0x516
	ldd.ab	%r22,[%r0,120]                  ; @0x51a
	std.ab	%r4,[%r3,-8]                    ; @0x51e
	ldd.ab	%r4,[%r0,-8]                    ; @0x522
	std.ab	%r22,[%r3,120]                  ; @0x526
	ldd.ab	%r22,[%r0,-8]                   ; @0x52a
	std.ab	%r4,[%r3,-8]                    ; @0x52e
	ldd.ab	%r4,[%r0,-8]                    ; @0x532
	std.ab	%r22,[%r3,-8]                   ; @0x536
	ldd.ab	%r22,[%r0,-8]                   ; @0x53a
	std.ab	%r4,[%r3,-8]                    ; @0x53e
	ldd.ab	%r4,[%r0,-8]                    ; @0x542
	std.ab	%r22,[%r3,-8]                   ; @0x546
	ldd.ab	%r22,[%r0,-8]                   ; @0x54a
	std.ab	%r4,[%r3,-8]                    ; @0x54e
	ldd.ab	%r4,[%r0,-8]                    ; @0x552
	std.ab	%r22,[%r3,-8]                   ; @0x556
	ldd.ab	%r22,[%r0,120]                  ; @0x55a
	std.ab	%r4,[%r3,-8]                    ; @0x55e
	ldd.ab	%r4,[%r0,-8]                    ; @0x562
	std.ab	%r22,[%r3,120]                  ; @0x566
	ldd.ab	%r22,[%r0,-8]                   ; @0x56a
	std.ab	%r4,[%r3,-8]                    ; @0x56e
	ldd.ab	%r4,[%r0,-8]                    ; @0x572
	std.ab	%r22,[%r3,-8]                   ; @0x576
	ldd.ab	%r22,[%r0,-8]                   ; @0x57a
	std.ab	%r4,[%r3,-8]                    ; @0x57e
	ldd.ab	%r4,[%r0,-8]                    ; @0x582
	std.ab	%r22,[%r3,-8]                   ; @0x586
	ldd.ab	%r22,[%r0,-8]                   ; @0x58a
	std.ab	%r4,[%r3,-8]                    ; @0x58e
	ldd.ab	%r4,[%r0,-8]                    ; @0x592
	std.ab	%r22,[%r3,-8]                   ; @0x596
	ldd.ab	%r22,[%r0,120]                  ; @0x59a
	std.ab	%r4,[%r3,-8]                    ; @0x59e
	std.ab	%r22,[%r3,120]                  ; @0x5a2
.LZD11:                                 ; @0x5a6
	; ZD Loop End                           ; @0x5a6
.LBB3_25:                               ; %for.cond.cleanup3.us.us65
                                        ;   in Loop: Header=BB3_19 Depth=1
                                        ; @0x5a6
	add_s	%r13,%r13,1                     ; @0x5a6
	cmp_s	%r13,%r2                        ; @0x5a8
	add	%r8,%r8,%r16                    ; @0x5aa
	add_s	%r14,%r14,%r16                  ; @0x5ae
	blt	.LBB3_19                        ; @0x5b0
	b_s	.LBB3_38                        ; @0x5b4
.LBB3_17:                               ; %iter.check.preheader
                                        ; @0x5b6
	sub	%r0,%r6,%fp                     ; @0x5b6
	sub_s	%r0,%r0,8                       ; @0x5ba
	sub3	%r12,%r6,64/8                   ; @0x5bc
	bmskn	%r4,%r16,7                      ; @0x5c0
	lsr_s	%r0,%r0,3                       ; @0x5c4
	lsr_s	%r12,%r12,6                     ; @0x5c6
	mov_s	%blink,%r1                      ; @0x5c8
	mov_s	%r17,%r24                       ; @0x5ca
	add	%r7,%r1,%r4                     ; @0x5cc
	add	%r4,%r24,%r4                    ; @0x5d0
	add	%r5,%r0,1                       ; @0x5d4
	add	%r30,%r12,1                     ; @0x5d8
	mov_s	%r0,0                           ; @0x5dc
	mov_s	%r13,0                          ; @0x5de
.LBB3_27:                               ; %iter.check
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB3_30 Depth 2
                                        ;     Child Loop BB3_33 Depth 2
                                        ;     Child Loop BB3_36 Depth 2
                                        ; @0x5e0
	mpy	%r12,%r16,%r13                  ; @0x5e0
	add	%r14,%r16,%r12                  ; @0x5e4
	add	%r15,%r24,%r12                  ; @0x5e8
	add_s	%r3,%r1,%r14                    ; @0x5ec
	brhs	%r15,%r3,.LBB3_29               ; @0x5ee
;  %bb.28:                              ; %iter.check
                                        ;   in Loop: Header=BB3_27 Depth=1
	add_s	%r3,%r1,%r12                    ; @0x5f2
	add_s	%r14,%r14,%r24                  ; @0x5f4
	mov_s	%r12,0                          ; @0x5f6
	cmp_s	%r3,%r14                        ; @0x5f8
	bcs	.LBB3_35                        ; @0x5fa
.LBB3_29:                               ; %vector.body.preheader
                                        ;   in Loop: Header=BB3_27 Depth=1
                                        ; @0x5fe
	; Implicit def %r8                      ; @0x5fe
	mov	%lp_count,%r30                  ; @0x5fe
	add	%r12,%blink,56                  ; @0x602
	add	%r14,%r17,56                    ; @0x606
	lp	.LZD13                          ; @0x60a
.LBB3_30:                               ; %vector.body
                                        ;   Parent Loop BB3_27 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; @0x60e
	ldd.ab	%r22,[%r12,-8]                  ; @0x60e
	ldd.ab	%r20,[%r12,-8]                  ; @0x612
	std.ab	%r22,[%r14,-8]                  ; @0x616
	ldd.ab	%r22,[%r12,-8]                  ; @0x61a
	std.ab	%r20,[%r14,-8]                  ; @0x61e
	ldd.ab	%r20,[%r12,-8]                  ; @0x622
	std.ab	%r22,[%r14,-8]                  ; @0x626
	ldd.ab	%r22,[%r12,-8]                  ; @0x62a
	std.ab	%r20,[%r14,-8]                  ; @0x62e
	ldd.ab	%r20,[%r12,-8]                  ; @0x632
	std.ab	%r22,[%r14,-8]                  ; @0x636
	ldd.ab	%r22,[%r12,-8]                  ; @0x63a
	std.ab	%r20,[%r14,-8]                  ; @0x63e
	ldd.ab	%r20,[%r12,120]                 ; @0x642
	std.ab	%r22,[%r14,-8]                  ; @0x646
	ldd.ab	%r22,[%r12,-8]                  ; @0x64a
	std.ab	%r20,[%r14,120]                 ; @0x64e
	ldd.ab	%r20,[%r12,-8]                  ; @0x652
	std.ab	%r22,[%r14,-8]                  ; @0x656
	ldd.ab	%r22,[%r12,-8]                  ; @0x65a
	std.ab	%r20,[%r14,-8]                  ; @0x65e
	ldd.ab	%r20,[%r12,-8]                  ; @0x662
	std.ab	%r22,[%r14,-8]                  ; @0x666
	ldd.ab	%r22,[%r12,-8]                  ; @0x66a
	std.ab	%r20,[%r14,-8]                  ; @0x66e
	ldd.ab	%r20,[%r12,-8]                  ; @0x672
	std.ab	%r22,[%r14,-8]                  ; @0x676
	ldd.ab	%r22,[%r12,-8]                  ; @0x67a
	std.ab	%r20,[%r14,-8]                  ; @0x67e
	ldd.ab	%r20,[%r12,120]                 ; @0x682
	std.ab	%r22,[%r14,-8]                  ; @0x686
	ldd.ab	%r22,[%r12,-8]                  ; @0x68a
	std.ab	%r20,[%r14,120]                 ; @0x68e
	ldd.ab	%r20,[%r12,-8]                  ; @0x692
	std.ab	%r22,[%r14,-8]                  ; @0x696
	ldd.ab	%r22,[%r12,-8]                  ; @0x69a
	std.ab	%r20,[%r14,-8]                  ; @0x69e
	ldd.ab	%r20,[%r12,-8]                  ; @0x6a2
	std.ab	%r22,[%r14,-8]                  ; @0x6a6
	ldd.ab	%r22,[%r12,-8]                  ; @0x6aa
	std.ab	%r20,[%r14,-8]                  ; @0x6ae
	ldd.ab	%r20,[%r12,-8]                  ; @0x6b2
	std.ab	%r22,[%r14,-8]                  ; @0x6b6
	ldd.ab	%r22,[%r12,-8]                  ; @0x6ba
	std.ab	%r20,[%r14,-8]                  ; @0x6be
	ldd.ab	%r20,[%r12,120]                 ; @0x6c2
	std.ab	%r22,[%r14,-8]                  ; @0x6c6
	ldd.ab	%r22,[%r12,-8]                  ; @0x6ca
	std.ab	%r20,[%r14,120]                 ; @0x6ce
	ldd.ab	%r20,[%r12,-8]                  ; @0x6d2
	std.ab	%r22,[%r14,-8]                  ; @0x6d6
	ldd.ab	%r22,[%r12,-8]                  ; @0x6da
	std.ab	%r20,[%r14,-8]                  ; @0x6de
	ldd.ab	%r20,[%r12,-8]                  ; @0x6e2
	std.ab	%r22,[%r14,-8]                  ; @0x6e6
	ldd.ab	%r22,[%r12,-8]                  ; @0x6ea
	std.ab	%r20,[%r14,-8]                  ; @0x6ee
	ldd.ab	%r20,[%r12,-8]                  ; @0x6f2
	std.ab	%r22,[%r14,-8]                  ; @0x6f6
	ldd.ab	%r22,[%r12,-8]                  ; @0x6fa
	std.ab	%r20,[%r14,-8]                  ; @0x6fe
	ldd.ab	%r20,[%r12,120]                 ; @0x702
	std.ab	%r22,[%r14,-8]                  ; @0x706
	std.ab	%r20,[%r14,120]                 ; @0x70a
.LZD13:                                 ; @0x70e
	; ZD Loop End                           ; @0x70e
;  %bb.31:                              ; %vec.epilog.iter.check
                                        ;   in Loop: Header=BB3_27 Depth=1
	mov_s	%r12,%fp                        ; @0x70e
	tst	%r6,56                          ; @0x710
	beq_s	.LBB3_35                        ; @0x714
;  %bb.32:                              ; %vec.epilog.vector.body.preheader
                                        ;   in Loop: Header=BB3_27 Depth=1
	; Implicit def %r8                      ; @0x716
	mov	%lp_count,%r5                   ; @0x716
	mov_s	%r12,%r7                        ; @0x71a
	mov_s	%r14,%r4                        ; @0x71c
	lp	.LZD14                          ; @0x71e
.LBB3_33:                               ; %vec.epilog.vector.body
                                        ;   Parent Loop BB3_27 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; @0x722
	ldd	%r22,[%r12,24]                  ; @0x722
	ldd	%r20,[%r12,16]                  ; @0x726
	ldd	%r18,[%r12,8]                   ; @0x72a
	ldd.ab	%r8,[%r12,32]                   ; @0x72e
	std	%r22,[%r14,24]                  ; @0x732
	std	%r20,[%r14,16]                  ; @0x736
	std	%r18,[%r14,8]                   ; @0x73a
	std.ab	%r8,[%r14,32]                   ; @0x73e
.LZD14:                                 ; @0x742
	; ZD Loop End                           ; @0x742
;  %bb.34:                              ; %vec.epilog.middle.block
                                        ;   in Loop: Header=BB3_27 Depth=1
	mov_s	%r12,%r11                       ; @0x742
	breq	%r11,%r6,.LBB3_26               ; @0x744
.LBB3_35:                               ; %for.body4.us.preheader
                                        ;   in Loop: Header=BB3_27 Depth=1
                                        ; @0x748
	; Implicit def %r8                      ; @0x748
	add_s	%r3,%r12,1                      ; @0x748
	add_s	%r15,%r12,%r0                   ; @0x74a
	max	%r3,%r6,%r3                     ; @0x74c
	sub	%lp_count,%r3,%r12              ; @0x750
	add2	%r12,%r1,%r15                   ; @0x754
	add2	%r14,%r24,%r15                  ; @0x758
	lp	.LZD15                          ; @0x75c
.LBB3_36:                               ; %for.body4.us
                                        ;   Parent Loop BB3_27 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; @0x760
	ld.ab	%r3,[%r12,4]                    ; @0x760
	st.ab	%r3,[%r14,4]                    ; @0x764
.LZD15:                                 ; @0x768
	; ZD Loop End                           ; @0x768
.LBB3_26:                               ; %for.cond.cleanup3.us
                                        ;   in Loop: Header=BB3_27 Depth=1
                                        ; @0x768
	add_s	%r13,%r13,1                     ; @0x768
	cmp_s	%r13,%r2                        ; @0x76a
	add_s	%r0,%r0,%r6                     ; @0x76c
	add	%r7,%r7,%r16                    ; @0x76e
	add	%r4,%r4,%r16                    ; @0x772
	add	%blink,%blink,%r16              ; @0x776
	add	%r17,%r17,%r16                  ; @0x77a
	blt	.LBB3_27                        ; @0x77e
.LBB3_38:                               ; %for.cond.cleanup
                                        ; @0x782
	mov_s	%r0,%r24                        ; @0x782
	ld	%blink,[%sp,52]                 ; @0x784
	.cfa_restore	{%blink}                ; @0x788
	ld	%fp,[%sp,48]                    ; @0x788
	.cfa_restore	{%fp}                   ; @0x78c
	ld	%r24,[%sp,44]                   ; @0x78c
	.cfa_restore	{%r24}                  ; @0x790
	ldd	%r22,[%sp,36]                   ; @0x790
	.cfa_restore	{%r23}                  ; @0x794
	.cfa_restore	{%r22}                  ; @0x794
	ldd	%r20,[%sp,28]                   ; @0x794
	.cfa_restore	{%r21}                  ; @0x798
	.cfa_restore	{%r20}                  ; @0x798
	ldd	%r18,[%sp,20]                   ; @0x798
	.cfa_restore	{%r19}                  ; @0x79c
	.cfa_restore	{%r18}                  ; @0x79c
	ldd	%r16,[%sp,12]                   ; @0x79c
	.cfa_restore	{%r17}                  ; @0x7a0
	.cfa_restore	{%r16}                  ; @0x7a0
	ldd	%r14,[%sp,4]                    ; @0x7a0
	.cfa_restore	{%r15}                  ; @0x7a4
	.cfa_restore	{%r14}                  ; @0x7a4
	ld.ab	%r13,[%sp,56]                   ; @0x7a4
	.cfa_restore	{%r13}                  ; @0x7a8
	.cfa_pop	56                              ; @0x7a8
	j_s	[%blink]                        ; @0x7a8
	.cfa_ef
.Lfunc_end3:                            ; @0x7aa

	.align	4                               ; -- End function
                                        ; -- Begin function print_matrix
print_matrix:                           ; @print_matrix
                                        ; @0x7ac
.Lprint_matrix$local:                   ; @0x7ac
	.cfa_bf	.Lprint_matrix$local
;  %bb.0:                               ; %entry
	st.aw	%r13,[%sp,-44]                  ; @0x7ac
	.cfa_push	44                      ; @0x7b0
	.cfa_reg_offset	{%r13}, 0               ; @0x7b0
	std	%r14,[%sp,4]                    ; @0x7b0
	.cfa_reg_offset	{%r14}, 4               ; @0x7b4
	.cfa_reg_offset	{%r15}, 8               ; @0x7b4
	std	%r16,[%sp,12]                   ; @0x7b4
	.cfa_reg_offset	{%r16}, 12              ; @0x7b8
	.cfa_reg_offset	{%r17}, 16              ; @0x7b8
	std	%r18,[%sp,20]                   ; @0x7b8
	.cfa_reg_offset	{%r18}, 20              ; @0x7bc
	.cfa_reg_offset	{%r19}, 24              ; @0x7bc
	std	%r20,[%sp,28]                   ; @0x7bc
	.cfa_reg_offset	{%r20}, 28              ; @0x7c0
	.cfa_reg_offset	{%r21}, 32              ; @0x7c0
	st	%r22,[%sp,36]                   ; @0x7c0
	.cfa_reg_offset	{%r22}, 36              ; @0x7c4
	st	%blink,[%sp,40]                 ; @0x7c4
	.cfa_reg_offset	{%blink}, 40            ; @0x7c8
	mov_s	%r18,.Lstr.14                   ; @0x7c8
	mov_s	%r15,%r0                        ; @0x7ce
	add	%r0,%r18,.Lstr.11-.Lstr.14      ; @0x7d0
	mov_s	%r22,%r2                        ; @0x7d4
	mov_s	%r17,%r1                        ; @0x7d6
	bl	puts                            ; @0x7d8
	brlt	%r17,1,.LBB4_10                 ; @0x7dc
;  %bb.1:                               ; %for.body.lr.ph
	add	%r19,%r18,.L.str.4-.Lstr.14     ; @0x7e0
	add	%r16,%r18,.Lstr.13-.Lstr.14     ; @0x7e4
	brlt	%r22,1,.LBB4_9                  ; @0x7e8
;  %bb.2:
	sub	%r13,%r22,1                     ; @0x7ec
	add	%r20,%r18,.L.str.5-.Lstr.14     ; @0x7f0
	add	%r21,%r18,.L.str.6-.Lstr.14     ; @0x7f4
.LBB4_8:                                ; %for.body5.lr.ph.us
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB4_3 Depth 2
                                        ; @0x7f8
	mov_s	%r0,%r19                        ; @0x7f8
	bl	printf                          ; @0x7fa
	mov_s	%r14,0                          ; @0x7fe
.LBB4_3:                                ; %for.body5.us
                                        ;   Parent Loop BB4_8 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; Label of block must be emitted
                                        ; @0x800 AlignLabel LoopTop Freq=409
	ld.ab	%r1,[%r15,4]                    ; @0x800
	cmp_s	%r14,%r13                       ; @0x804
	mov_s	%r0,%r20                        ; @0x806
	mov_s.ne	%r0,%r21                        ; Predicate Case 2
                                        ; @0x808
	bl	printf                          ; Predicate Case 1
                                        ; @0x80a
	add_s	%r14,%r14,1                     ; @0x80e
	brlt	%r14,%r22,.LBB4_3               ; @0x810
;  %bb.7:                               ; %for.cond.cleanup4.us
                                        ;   in Loop: Header=BB4_8 Depth=1
	mov_s	%r0,%r16                        ; @0x814
	bl	puts                            ; @0x816
	dbnz	%r17,.LBB4_8                    ; @0x81a
	b_s	.LBB4_10                        ; @0x81e
.LBB4_9:                                ; %for.cond.cleanup4
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x820
	mov	%r0,%r19                        ; widened to benefit BPU
                                        ; @0x820
	bl	printf                          ; @0x824
	mov	%r0,%r16                        ; widened to benefit BPU
                                        ; @0x828
	bl	puts                            ; @0x82c
	dbnz	%r17,.LBB4_9                    ; @0x830
.LBB4_10:                               ; %for.cond.cleanup
                                        ; @0x834
	mov_s	%r0,%r18                        ; @0x834
	bl	puts                            ; @0x836
	ld	%blink,[%sp,40]                 ; @0x83a
	.cfa_restore	{%blink}                ; @0x83e
	ld	%r22,[%sp,36]                   ; @0x83e
	.cfa_restore	{%r22}                  ; @0x842
	ldd	%r20,[%sp,28]                   ; @0x842
	.cfa_restore	{%r21}                  ; @0x846
	.cfa_restore	{%r20}                  ; @0x846
	ldd	%r18,[%sp,20]                   ; @0x846
	.cfa_restore	{%r19}                  ; @0x84a
	.cfa_restore	{%r18}                  ; @0x84a
	ldd	%r16,[%sp,12]                   ; @0x84a
	.cfa_restore	{%r17}                  ; @0x84e
	.cfa_restore	{%r16}                  ; @0x84e
	ldd	%r14,[%sp,4]                    ; @0x84e
	.cfa_restore	{%r15}                  ; @0x852
	.cfa_restore	{%r14}                  ; @0x852
	ld.ab	%r13,[%sp,44]                   ; @0x852
	.cfa_restore	{%r13}                  ; @0x856
	.cfa_pop	44                              ; @0x856
	j_s	[%blink]                        ; @0x856
	.cfa_ef
.Lfunc_end4:                            ; @0x858

	.align	4                               ; -- End function
                                        ; -- Begin function print_vector
print_vector:                           ; @print_vector
                                        ; @0x858
.Lprint_vector$local:                   ; @0x858
	.cfa_bf	.Lprint_vector$local
;  %bb.0:                               ; %entry
	st.aw	%r13,[%sp,-32]                  ; @0x858
	.cfa_push	32                      ; @0x85c
	.cfa_reg_offset	{%r13}, 0               ; @0x85c
	std	%r14,[%sp,4]                    ; @0x85c
	.cfa_reg_offset	{%r14}, 4               ; @0x860
	.cfa_reg_offset	{%r15}, 8               ; @0x860
	std	%r16,[%sp,12]                   ; @0x860
	.cfa_reg_offset	{%r16}, 12              ; @0x864
	.cfa_reg_offset	{%r17}, 16              ; @0x864
	std	%r18,[%sp,20]                   ; @0x864
	.cfa_reg_offset	{%r18}, 20              ; @0x868
	.cfa_reg_offset	{%r19}, 24              ; @0x868
	st	%blink,[%sp,28]                 ; @0x868
	.cfa_reg_offset	{%blink}, 28            ; @0x86c
	mov_s	%r13,%r0                        ; @0x86c
	mov_s	%r0,91                          ; @0x86e
	mov_s	%r19,%r1                        ; @0x870
	bl	putchar                         ; @0x872
	mov_s	%r17,.Lstr.14                   ; @0x876
	brlt	%r19,1,.LBB5_6                  ; @0x87c
;  %bb.1:                               ; %for.body.lr.ph
	sub	%r15,%r19,1                     ; @0x880
	add	%r16,%r17,.L.str.5-.Lstr.14     ; @0x884
	add	%r18,%r17,.L.str.6-.Lstr.14     ; @0x888
	mov_s	%r14,0                          ; @0x88c
.LBB5_2:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x88e
	ld.ab	%r1,[%r13,4]                    ; @0x88e
	cmp_s	%r14,%r15                       ; @0x892
	mov_s	%r0,%r16                        ; @0x894
	mov_s.ne	%r0,%r18                        ; Predicate Case 2
                                        ; @0x896
	bl	printf                          ; Predicate Case 1
                                        ; @0x898
	add_s	%r14,%r14,1                     ; @0x89c
	brlt	%r14,%r19,.LBB5_2               ; @0x89e
.LBB5_6:                                ; %for.cond.cleanup
                                        ; @0x8a2
	mov_s	%r0,%r17                        ; @0x8a2
	bl	puts                            ; @0x8a4
	ld	%blink,[%sp,28]                 ; @0x8a8
	.cfa_restore	{%blink}                ; @0x8ac
	ldd	%r18,[%sp,20]                   ; @0x8ac
	.cfa_restore	{%r19}                  ; @0x8b0
	.cfa_restore	{%r18}                  ; @0x8b0
	ldd	%r16,[%sp,12]                   ; @0x8b0
	.cfa_restore	{%r17}                  ; @0x8b4
	.cfa_restore	{%r16}                  ; @0x8b4
	ldd	%r14,[%sp,4]                    ; @0x8b4
	.cfa_restore	{%r15}                  ; @0x8b8
	.cfa_restore	{%r14}                  ; @0x8b8
	ld.ab	%r13,[%sp,32]                   ; @0x8b8
	.cfa_restore	{%r13}                  ; @0x8bc
	.cfa_pop	32                              ; @0x8bc
	j_s	[%blink]                        ; @0x8bc
	.cfa_ef
.Lfunc_end5:                            ; @0x8be

	.align	4                               ; -- End function
                                        ; -- Begin function mat_reduce_rows
mat_reduce_rows:                        ; @mat_reduce_rows
                                        ; @0x8c0
.Lmat_reduce_rows$local:                ; @0x8c0
	.cfa_bf	.Lmat_reduce_rows$local
;  %bb.0:                               ; %entry
	std.aw	%r22,[%sp,-8]                   ; @0x8c0
	.cfa_push	8                       ; @0x8c4
	.cfa_reg_offset	{%r22}, 0               ; @0x8c4
	.cfa_reg_offset	{%r23}, 4               ; @0x8c4
	cmp	%r2,1                           ; @0x8c4
	blt	.LBB6_21                        ; @0x8c8
;  %bb.1:                               ; %for.body.lr.ph
	brlt	%r3,1,.LBB6_14                  ; @0x8cc
;  %bb.2:                               ; %for.body.lr.ph.split.us
	brne	%r3,1,.LBB6_5                   ; @0x8d0
;  %bb.3:                               ; %for.body4.lr.ph.us.us.preheader
	; Implicit def %r12                     ; @0x8d4
	mov	%lp_count,%r2                   ; @0x8d4
	lp	.LZD18                          ; @0x8d8
.LBB6_4:                                ; %for.cond.cleanup3.us.loopexit.us
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x8dc
	ld.ab	%r2,[%r0,4]                     ; @0x8dc
	st.ab	%r2,[%r1,4]                     ; @0x8e0
.LZD18:                                 ; @0x8e4
	; ZD Loop End                           ; @0x8e4
	nop                                     ; inserted to benefit BPU
                                        ; @0x8e4
	nop                                     ; widened to benefit BPU
                                        ; inserted to benefit BPU
                                        ; @0x8e8
	b	.LBB6_21                        ; @0x8ec
.LBB6_14:                               ; %for.body.lr.ph.split
                                        ; @0x8f0
	mov_s	%r0,0                           ; @0x8f0
	brlo	%r2,4,.LBB6_18                  ; @0x8f2
;  %bb.15:                              ; %vector.ph
	; Implicit def %r8                      ; @0x8f6
	sub_s	%r3,%r2,4                       ; @0x8f6
	lsr_s	%r3,%r3,2                       ; @0x8f8
	bmskn	%r0,%r2,1                       ; @0x8fa
	add	%lp_count,%r3,1                 ; @0x8fe
	mov_s	%r3,%r1                         ; @0x902
	lp	.LZD25                          ; @0x904
.LBB6_16:                               ; %vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x908
	std	0,[%r3,8]                       ; @0x908
	std.ab	0,[%r3,16]                      ; @0x90c
.LZD25:                                 ; @0x910
	; ZD Loop End                           ; @0x910
;  %bb.17:                              ; %middle.block
	breq	%r0,%r2,.LBB6_21                ; @0x910
.LBB6_18:                               ; %for.cond.cleanup3.preheader
                                        ; @0x914
	add_s	%r3,%r0,1                       ; @0x914
	add2_s	%r1,%r1,%r0                     ; @0x916
	max	%r2,%r2,%r3                     ; @0x918
	; Implicit def %r3                      ; @0x91c
	sub	%lp_count,%r2,%r0               ; @0x91c
	lp	.LZD24                          ; @0x920
.LBB6_19:                               ; %for.cond.cleanup3
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x924
	st.ab	0,[%r1,4]                       ; @0x924
.LZD24:                                 ; @0x928
	; ZD Loop End                           ; @0x928
	nop                                     ; inserted to benefit BPU
                                        ; @0x928
	nop                                     ; widened to benefit BPU
                                        ; inserted to benefit BPU
                                        ; @0x92c
	b	.LBB6_21                        ; @0x930
.LBB6_5:                                ; %for.body.lr.ph.split.us.split
                                        ; @0x934
	sub_s	%r12,%r3,2                      ; @0x934
	lsr_s	%r12,%r12,1                     ; @0x936
	asl	%r8,%r3,2                       ; @0x938
	bclr	%r9,%r3,0                       ; @0x93c
	add	%r11,%r12,1                     ; @0x940
	mov_s	%r7,0                           ; @0x944
	brne	%r9,%r3,.LBB6_6                 ; @0x946
.LBB6_7:                                ; %for.body4.lr.ph.us.us40
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB6_8 Depth 2
                                        ; @0x94a
	; Implicit def %r5                      ; @0x94a
	mov	%lp_count,%r11                  ; @0x94a
	mov_s	%r12,%r0                        ; @0x94e
	mov_s	%r9,0                           ; @0x950
	mov_s	%r3,0                           ; @0x952
	lp	.LZD19                          ; @0x954
.LBB6_8:                                ; %vector.body34.us
                                        ;   Parent Loop BB6_7 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; @0x958
	ldd.ab	%r4,[%r12,8]                    ; @0x958
	add_s	%r3,%r3,%r5                     ; @0x95c
	add	%r9,%r9,%r4                     ; @0x95e
.LZD19:                                 ; @0x962
	; ZD Loop End                           ; @0x962
;  %bb.20:                              ; %middle.block26.us
                                        ;   in Loop: Header=BB6_7 Depth=1
	add2	%r12,%r1,%r7                    ; @0x962
	add_s	%r3,%r3,%r9                     ; @0x966
	add_s	%r0,%r0,%r8                     ; @0x968
	add_s	%r7,%r7,1                       ; @0x96a
	st_s	%r3,[%r12,0]                    ; @0x96c
	dbnz	%r2,.LBB6_7                     ; @0x96e
	b_s	.LBB6_21                        ; @0x972
.LBB6_6:                                ; %for.body4.lr.ph.us.preheader
                                        ; @0x974
	add	%r12,%r9,1                      ; @0x974
	bmskn	%r6,%r8,2                       ; @0x978
	max	%r3,%r3,%r12                    ; @0x97c
	add	%r6,%r0,%r6                     ; @0x980
	sub	%r9,%r3,%r9                     ; @0x984
.LBB6_10:                               ; %for.body4.lr.ph.us
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB6_11 Depth 2
                                        ;     Child Loop BB6_13 Depth 2
                                        ; @0x988
	; Implicit def %r22                     ; @0x988
	mov	%lp_count,%r11                  ; @0x988
	mov_s	%r12,%r0                        ; @0x98c
	mov_s	%r4,0                           ; @0x98e
	mov_s	%r3,0                           ; @0x990
	lp	.LZD21                          ; @0x992
.LBB6_11:                               ; %vector.body34
                                        ;   Parent Loop BB6_10 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; @0x996
	ldd.ab	%r22,[%r12,8]                   ; @0x996
	add_s	%r3,%r3,%r23                    ; @0x99a
	add	%r4,%r4,%r22                    ; @0x99c
.LZD21:                                 ; @0x9a0
	; ZD Loop End                           ; @0x9a0
;  %bb.12:                              ; %middle.block26
                                        ;   in Loop: Header=BB6_10 Depth=1
	; Implicit def %r30                     ; @0x9a0
	add	%r4,%r3,%r4                     ; @0x9a0
	mov	%lp_count,%r9                   ; @0x9a4
	mov_s	%r12,%r6                        ; @0x9a8
	lp	.LZD22                          ; @0x9aa
.LBB6_13:                               ; %for.body4.us
                                        ;   Parent Loop BB6_10 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; @0x9ae
	ld.ab	%r3,[%r12,4]                    ; @0x9ae
	add	%r4,%r3,%r4                     ; @0x9b2
.LZD22:                                 ; @0x9b6
	; ZD Loop End                           ; @0x9b6
;  %bb.9:                               ; %for.cond.cleanup3.us
                                        ;   in Loop: Header=BB6_10 Depth=1
	add2	%r12,%r1,%r7                    ; @0x9b6
	add	%r6,%r6,%r8                     ; @0x9ba
	add_s	%r0,%r0,%r8                     ; @0x9be
	add_s	%r7,%r7,1                       ; @0x9c0
	st	%r4,[%r12,0]                    ; @0x9c2
	dbnz	%r2,.LBB6_10                    ; @0x9c6
.LBB6_21:                               ; %for.cond.cleanup
                                        ; @0x9ca
	ldd.ab	%r22,[%sp,8]                    ; @0x9ca
	.cfa_restore	{%r23}                  ; @0x9ce
	.cfa_restore	{%r22}                  ; @0x9ce
	.cfa_pop	8                               ; @0x9ce
	j_s	[%blink]                        ; @0x9ce
	.cfa_ef
.Lfunc_end6:                            ; @0x9d0

	.align	4                               ; -- End function
                                        ; -- Begin function vectorized_mat_reduce_rows
vectorized_mat_reduce_rows:             ; @vectorized_mat_reduce_rows
                                        ; @0x9d0
.Lvectorized_mat_reduce_rows$local:     ; @0x9d0
	.cfa_bf	.Lvectorized_mat_reduce_rows$local
;  %bb.0:                               ; %entry
	st.aw	%r13,[%sp,-36]                  ; @0x9d0
	.cfa_push	36                      ; @0x9d4
	.cfa_reg_offset	{%r13}, 0               ; @0x9d4
	std	%r14,[%sp,4]                    ; @0x9d4
	.cfa_reg_offset	{%r14}, 4               ; @0x9d8
	.cfa_reg_offset	{%r15}, 8               ; @0x9d8
	std	%r16,[%sp,12]                   ; @0x9d8
	.cfa_reg_offset	{%r16}, 12              ; @0x9dc
	.cfa_reg_offset	{%r17}, 16              ; @0x9dc
	std	%r18,[%sp,20]                   ; @0x9dc
	.cfa_reg_offset	{%r18}, 20              ; @0x9e0
	.cfa_reg_offset	{%r19}, 24              ; @0x9e0
	st	%r20,[%sp,28]                   ; @0x9e0
	.cfa_reg_offset	{%r20}, 28              ; @0x9e4
	st	%blink,[%sp,32]                 ; @0x9e4
	.cfa_reg_offset	{%blink}, 32            ; @0x9e8
	cmp_s	%r2,0                           ; @0x9e8
	ble	.LBB7_52                        ; @0x9ea
;  %bb.1:                               ; %for.body.lr.ph
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr16, 0                       ; @0x9ee
	mov_s	%r8,%r3                         ; @0x9ee
 ;	 }
	asr_s	%r3,%r3,31                      ; @0x9f4
.vvsbundle  "v1sc" 
 ;	 { 
	vvcadd.init.w	%vr16, %vr16, 0         ; @0x9f6
	lsr_s	%r3,%r3,28                      ; @0x9f6
 ;	 }
	add_s	%r3,%r3,%r8                     ; @0x9fe
	asr_s	%r12,%r3,4                      ; @0xa00
	cmp	%r8,16                          ; @0xa02
	bmskn	%r11,%r3,3                      ; @0xa06
	blt	.LBB7_23                        ; @0xa0a
;  %bb.2:                               ; %for.body.lr.ph.split.us
	cmp	%r8,%r11                        ; @0xa0e
	ble	.LBB7_3                         ; @0xa12
;  %bb.4:                               ; %for.body.lr.ph.split.us.split.us

.vvsbundle  "v2sc"                      ; implicit-def: $vr1
 ;	 { 
	vvci.w	%vr2                            ; @0xa16
	vvpinit.w	%p1, 0, 65534           ; @0xa16
	sub	%r9,%r8,%r11                    ; @0xa16
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvpinit.w	%p3, 0, 65532           ; @0xa24
	vvmov.w	 %vr0, 0                        ; @0xa24
	max	%r3,%r11,16                     ; @0xa24
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvpinit.w	%p4, 0, 65520           ; @0xa32
	sub3	%r15,%r9,64/8                   ; @0xa32
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvadd.w	%vr3, %vr2, 2                   ; @0xa3c
	vvshfl.w.p1	%vr1, %vr0, %vr0        ; @0xa3c
	add_s	%r3,%r3,-1                      ; @0xa3c
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvpinit.w	%p1, 0, 255             ; @0xa48
	vvadd.w	%vr4, %vr2, 4                   ; @0xa48
	asl	%r17,%r12,6                     ; @0xa48
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvsel.w.p3	%vr2, %vr0, %vr3        ; @0xa56
	vvpinit.w	%p2, 0, 15              ; @0xa56
	bmskn	%r6,%r9,5                       ; @0xa56
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvsel.w.p4	%vr3, %vr0, %vr4        ; @0xa66
	vvpinit.w	%p3, 0, 3               ; @0xa66
	lsr_s	%r15,%r15,6                     ; @0xa66
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvpinit.w	%p4, 0, 1               ; @0xa74
	lsr_s	%r3,%r3,4                       ; @0xa74
 ;	 }
	mov_s	%r7,%r11                        ; @0xa7c
	mov_s	%r18,%r0                        ; @0xa7e
	add	%r17,%r0,%r17                   ; @0xa80
	add	%r4,%r15,1                      ; @0xa84
	bmskn	%r5,%r8,2                       ; @0xa88
	sub	%r30,%r8,8                      ; @0xa8c
	add	%blink,%r11,%r6                 ; @0xa90
	add	%r16,%r3,1                      ; @0xa94
	mov_s	%r19,0                          ; @0xa98
	mov_s	%r20,0                          ; @0xa9a
.LBB7_6:                                ; %for.body4.lr.ph.us.us
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB7_7 Depth 2
                                        ;     Child Loop BB7_12 Depth 2
                                        ;     Child Loop BB7_16 Depth 2
                                        ;     Child Loop BB7_19 Depth 2
                                        ; @0xa9c
	; Implicit def %r13                     ; @0xa9c
.vvsbundle  "v1sc" 
 ;	 { 
	vvcmov.b	%vr17, %vr16                    ; @0xa9c
	mov	%lp_count,%r16                  ; @0xa9c
 ;	 }
	mov	%r3,%r18                        ; @0xaa4
	lp	.LZD26                          ; @0xaa8
.LBB7_7:                                ; %for.body4.us.us
                                        ;   Parent Loop BB7_6 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; Label of block must be emitted
                                        ; @0xaac AlignLabel LoopTop Freq=160
	vvld.av.w	%vr4,%r3,1              ; @0xaac
	vvcadd.w	%vr17, %vr4, %vr0               ; @0xab2
.LZD26:                                 ; @0xab8
	; ZD Loop End                           ; @0xab8
;  %bb.8:                               ; %iter.check166
                                        ;   in Loop: Header=BB7_6 Depth=1
.vvsbundle  "v1sc" 
 ;	 { 
	vvc4add.w	%vr17                   ; @0xab8
	cmp	%r9,8                           ; @0xab8
 ;	 }
	mov_s	%r12,%r11                       ; @0xac0
	vvc4pack.w	%vr17                   ; Predicate Case 2
                                        ; @0xac2
	vvc4add.w	%vr17                   ; @0xac6
	vvc4pack.w	%vr17                   ; @0xaca
	vvmov1.x.from.w	%r13,%vr17,0            ; @0xace
	bcs	.LBB7_18                        ; @0xad4
;  %bb.10:                              ; Predicate Case 2
                                        ; %vector.main.loop.iter.check168
                                        ;   in Loop: Header=BB7_6 Depth=1
	cmp	%r9,64                          ; @0xad8
	mov_s	%r3,0                           ; @0xadc
	bcs	.LBB7_15                        ; @0xade
;  %bb.11:                              ; %vector.ph169
                                        ;   in Loop: Header=BB7_6 Depth=1
.vvsbundle  "v3sc" 
 ;	 { 
	vvmov.w	 %vr6, 0                        ; @0xae2
	vvmov.w	 %vr5, 0                        ; @0xae2
	vvmov.w	%vr4, %vr1                      ; @0xae2
	add2	%r13,%r17,192/4                 ; @0xae2
 ;	 }
	; Implicit def %r12                     ; @0xaf2
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov.w	 %vr7, 0                        ; @0xaf2
	vvshfl.w.p4	%vr4, %vr17, %vr0       ; @0xaf2
	mov	%lp_count,%r4                   ; @0xaf2
 ;	 }
	lp	.LZD27                          ; @0xb00
.LBB7_12:                               ; %vector.body173
                                        ;   Parent Loop BB7_6 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; @0xb04
	vvld.av.w	%vr8,%r13,-1            ; @0xb04
.vvsbundle  " v2" 
 ;	 { 
	vvld.av.w	%vr9,%r13,-1            ; @0xb0a
	vvadd.w	%vr7, %vr8, %vr7                ; @0xb0a
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvld.av.w	%vr8,%r13,-1            ; @0xb14
	vvadd.w	%vr6, %vr9, %vr6                ; @0xb14
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvld.av.w	%vr9,%r13,7             ; @0xb1e
	vvadd.w	%vr5, %vr8, %vr5                ; @0xb1e
 ;	 }
	vvadd.w	%vr4, %vr9, %vr4                ; @0xb28
.LZD27:                                 ; @0xb2e
	; ZD Loop End                           ; @0xb2e
;  %bb.13:                              ; %middle.block163
                                        ;   in Loop: Header=BB7_6 Depth=1
	vvadd.w	%vr4, %vr5, %vr4                ; @0xb2e
	vvadd.w	%vr4, %vr6, %vr4                ; @0xb34
	vvadd.w	%vr17, %vr7, %vr4               ; @0xb3a
	vvc2add.w	%vr17                   ; @0xb40
	vvshfleven.w	%vr17, %vr17            ; @0xb44
	vvc2add.w	%vr17                   ; @0xb48
	vvshfleven.w	%vr17, %vr17            ; @0xb4c
	vvc2add.w	%vr17                   ; @0xb50
	vvshfleven.w	%vr17, %vr17            ; @0xb54
	vvc2add.w	%vr17                   ; @0xb58
	vvmov1.x.from.w	%r13,%vr17,0            ; @0xb5c
	breq	%r9,%r6,.LBB7_5                 ; @0xb62
;  %bb.14:                              ; %vec.epilog.iter.check191
                                        ;   in Loop: Header=BB7_6 Depth=1
	mov_s	%r3,%r6                         ; @0xb66
	mov_s	%r12,%blink                     ; @0xb68
	tst	%r9,56                          ; @0xb6a
	beq_s	.LBB7_18                        ; @0xb6e
.LBB7_15:                               ; %vec.epilog.ph192
                                        ;   in Loop: Header=BB7_6 Depth=1
                                        ; @0xb70
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr4, 0                        ; @0xb70
	add	%r12,%r11,%r3                   ; @0xb70
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr4,0,%r13             ; @0xb78
	add_s	%r3,%r3,%r7                     ; @0xb78
 ;	 }
	sub	%r13,%r30,%r12                  ; @0xb80
	add2	%r12,%r0,%r3                    ; @0xb84
	lsr_s	%r13,%r13,3                     ; @0xb88
	add	%lp_count,%r13,1                ; @0xb8a
	; Implicit def %r13                     ; @0xb8e
	lp	.LZD28                          ; @0xb8e
.LBB7_16:                               ; %vec.epilog.vector.body202
                                        ;   Parent Loop BB7_6 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; @0xb92
	vvld.ab.w.p1	%vr5,%r12,32            ; @0xb92
	vvadd.w	%vr4, %vr5, %vr4                ; @0xb9a
.LZD28:                                 ; @0xba0
	; ZD Loop End                           ; @0xba0
;  %bb.17:                              ; %vec.epilog.middle.block189
                                        ;   in Loop: Header=BB7_6 Depth=1

	mov_s	%r12,%r5                        ; implicit-def: $vr5
                                        ; @0xba0
.vvsbundle  "v1sc" 
 ;	 { 
	vvshfl.w.p2	%vr5, %vr4, %vr3        ; @0xba2
	bmsk.f	0,%r8,2                         ; @0xba2
 ;	 }
	vvadd.w	%vr4, %vr4, %vr5                ; @0xbac
	vvshfl.w.p3	%vr5, %vr4, %vr2        ; @0xbb0
	vvadd.w	%vr4, %vr4, %vr5                ; @0xbb6
	vvmov1.from.w	%r3,%vr4,1              ; @0xbba
	vvadd.w	%vr4, %vr4, %r3                 ; @0xbc0
	vvmov1.x.from.w	%r13,%vr4,0             ; @0xbc4
	beq_s	.LBB7_5                         ; @0xbca
.LBB7_18:                               ; %for.body32.us.us.preheader
                                        ;   in Loop: Header=BB7_6 Depth=1
                                        ; @0xbcc
	add	%r3,%r12,1                      ; @0xbcc
	add	%r14,%r12,%r19                  ; @0xbd0
	max	%r15,%r8,%r3                    ; @0xbd4
	add2	%r3,%r0,%r14                    ; @0xbd8
	; Implicit def %r14                     ; @0xbdc
	sub	%lp_count,%r15,%r12             ; @0xbdc
	lp	.LZD29                          ; @0xbe0
.LBB7_19:                               ; %for.body32.us.us
                                        ;   Parent Loop BB7_6 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; Label of block must be emitted
                                        ; @0xbe4 AlignLabel LoopTop Freq=120
	ld.ab	%r12,[%r3,4]                    ; @0xbe4
	add_s	%r13,%r12,%r13                  ; @0xbe8
.LZD29:                                 ; @0xbea
	; ZD Loop End                           ; @0xbea
.LBB7_5:                                ; %for.cond.cleanup31.us.us
                                        ;   in Loop: Header=BB7_6 Depth=1
                                        ; @0xbea
	add2	%r3,%r1,%r20                    ; @0xbea
	add2	%r17,%r17,%r8                   ; @0xbee
	add2	%r18,%r18,%r8                   ; @0xbf2
	add	%r19,%r19,%r8                   ; @0xbf6
	add	%r7,%r7,%r8                     ; @0xbfa
	add_s	%r20,%r20,1                     ; @0xbfe
	st_s	%r13,[%r3,0]                    ; @0xc00
	dbnz	%r2,.LBB7_6                     ; @0xc02
	b	.LBB7_52                        ; @0xc06
.LBB7_23:                               ; %for.body.lr.ph.split
                                        ; @0xc0a
	vvc4add.w	%vr16                   ; @0xc0a
	vvc4pack.w	%vr16                   ; @0xc0e
	vvc4add.w	%vr16                   ; @0xc12
	vvc4pack.w	%vr16                   ; @0xc16
	vvmov1.x.from.w	%r9,%vr16,0             ; @0xc1a
	brge	%r11,%r8,.LBB7_40               ; @0xc20
;  %bb.24:                              ; %for.body.lr.ph.split.split.us
	sub	%r16,%r8,%r11                   ; @0xc24
	asl_s	%r15,%r12,6                     ; @0xc28
	cmp	%r16,8                          ; @0xc2a
	add_s	%r15,%r0,%r15                   ; @0xc2e
	bcc	.LBB7_25                        ; @0xc30
;  %bb.26:                              ; %iter.check126.us.preheader
	mov_s	%r0,0                           ; @0xc34
.LBB7_27:                               ; %iter.check126.us
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB7_28 Depth 2
                                        ; @0xc36
	; Implicit def %r6                      ; @0xc36
	mov	%lp_count,%r16                  ; @0xc36
	mov_s	%r12,%r15                       ; @0xc3a
	mov_s	%r3,%r9                         ; @0xc3c
	lp	.LZD33                          ; @0xc3e
.LBB7_28:                               ; %for.body32.us81.us
                                        ;   Parent Loop BB7_27 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; @0xc42
	ld.ab	%r14,[%r12,4]                   ; @0xc42
	add_s	%r3,%r14,%r3                    ; @0xc46
.LZD33:                                 ; @0xc48
	; ZD Loop End                           ; @0xc48
;  %bb.51:                              ; %for.cond.cleanup31.us76.us
                                        ;   in Loop: Header=BB7_27 Depth=1
	add2	%r12,%r1,%r0                    ; @0xc48
	add2	%r15,%r15,%r8                   ; @0xc4c
	add_s	%r0,%r0,1                       ; @0xc50
	st_s	%r3,[%r12,0]                    ; @0xc52
	dbnz	%r2,.LBB7_27                    ; @0xc54
	b	.LBB7_52                        ; @0xc58
.LBB7_3:                                ; %for.body4.lr.ph.us.preheader
                                        ; @0xc5c
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr0, 0                        ; @0xc5c
	max	%r12,%r11,16                    ; @0xc5c
 ;	 }
	add_s	%r12,%r12,-1                    ; @0xc64
	lsr_s	%r12,%r12,4                     ; @0xc66
	mov_s	%r3,0                           ; @0xc68
	add_s	%r12,%r12,1                     ; @0xc6a
.LBB7_21:                               ; %for.body4.lr.ph.us
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB7_22 Depth 2
                                        ; @0xc6c
	; Implicit def %r9                      ; @0xc6c
.vvsbundle  "v1sc" 
 ;	 { 
	vvcmov.b	%vr17, %vr16                    ; @0xc6c
	mov	%lp_count,%r12                  ; @0xc6c
 ;	 }
	mov	%r15,%r0                        ; @0xc74
	lp	.LZD31                          ; @0xc78
.LBB7_22:                               ; %for.body4.us
                                        ;   Parent Loop BB7_21 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; Label of block must be emitted
                                        ; @0xc7c AlignLabel LoopTop Freq=160
	vvld.av.w	%vr1,%r15,1             ; @0xc7c
	vvcadd.w	%vr17, %vr1, %vr0               ; @0xc82
.LZD31:                                 ; @0xc88
	; ZD Loop End                           ; @0xc88
;  %bb.20:                              ; %for.cond.cleanup31.us
                                        ;   in Loop: Header=BB7_21 Depth=1
.vvsbundle  "v1sc" 
 ;	 { 
	vvc4add.w	%vr17                   ; @0xc88
	add2	%r15,%r1,%r3                    ; @0xc88
 ;	 }
	add2	%r0,%r0,%r8                     ; @0xc90
	add_s	%r3,%r3,1                       ; @0xc94
	vvc4pack.w	%vr17                   ; @0xc96
	vvc4add.w	%vr17                   ; @0xc9a
	vvc4pack.w	%vr17                   ; @0xc9e
	vvmov1.x.from.w	%r14,%vr17,0            ; @0xca2
	st_s	%r14,[%r15,0]                   ; @0xca8
	dbnz	%r2,.LBB7_21                    ; @0xcaa
	b	.LBB7_52                        ; @0xcae
.LBB7_40:                               ; %iter.check
                                        ; @0xcb2
	mov_s	%r0,0                           ; @0xcb2
	brlo	%r2,8,.LBB7_49                  ; @0xcb4
;  %bb.41:                              ; %vector.main.loop.iter.check
	cmp_s	%r2,64                          ; @0xcb8
	bcs	.LBB7_46                        ; @0xcba
;  %bb.42:                              ; %vector.ph
	; Implicit def %r11                     ; @0xcbe
.vvsbundle  "v1sc" 
 ;	 { 
	vvrep.w	%vr0, %vr16, 0                  ; @0xcbe
	sub3	%r3,%r2,64/8                    ; @0xcbe
 ;	 }
	lsr_s	%r3,%r3,6                       ; @0xcc8
	add	%lp_count,%r3,1                 ; @0xcca
	add2	%r3,%r1,192/4                   ; @0xcce
	bmskn	%r0,%r2,5                       ; @0xcd2
	lp	.LZD41                          ; @0xcd6
.LBB7_43:                               ; %vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0xcda
	vvst.av.w	%vr0,%r3,-1             ; @0xcda
	vvst.av.w	%vr0,%r3,-1             ; @0xce0
	vvst.av.w	%vr0,%r3,-1             ; @0xce6
	vvst.av.w	%vr0,%r3,7              ; @0xcec
.LZD41:                                 ; @0xcf2
	; ZD Loop End                           ; @0xcf2
;  %bb.44:                              ; %middle.block
	cmp_s	%r0,%r2                         ; @0xcf2
	beq	.LBB7_52                        ; @0xcf4
;  %bb.45:                              ; %vec.epilog.iter.check
	tst	%r2,56                          ; @0xcf8
	beq_s	.LBB7_49                        ; @0xcfc
.LBB7_46:                               ; %vec.epilog.ph
                                        ; @0xcfe
	; Implicit def %r11                     ; @0xcfe
.vvsbundle  "v2sc" 
 ;	 { 
	vvpinit.w	%p1, 0, 255             ; @0xcfe
	vvrep.w	%vr0, %vr16, 0                  ; @0xcfe
	sub_s	%r12,%r2,%r0                    ; @0xcfe
 ;	 }
	sub_s	%r12,%r12,8                     ; @0xd0a
	lsr_s	%r12,%r12,3                     ; @0xd0c
	add2	%r3,%r1,%r0                     ; @0xd0e
	bmskn	%r0,%r2,2                       ; @0xd12
	add	%lp_count,%r12,1                ; @0xd16
	lp	.LZD40                          ; @0xd1a
.LBB7_47:                               ; %vec.epilog.vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0xd1e
	vvst.ab.w.p1	%vr0,%r3,32             ; @0xd1e
.LZD40:                                 ; @0xd26
	; ZD Loop End                           ; @0xd26
;  %bb.48:                              ; %vec.epilog.middle.block
	cmp_s	%r0,%r2                         ; @0xd26
	beq_s	.LBB7_52                        ; @0xd28
.LBB7_49:                               ; %for.cond.cleanup31.preheader
                                        ; @0xd2a
	add_s	%r3,%r0,1                       ; @0xd2a
	add2_s	%r1,%r1,%r0                     ; @0xd2c
	max	%r2,%r2,%r3                     ; @0xd2e
	sub	%lp_count,%r2,%r0               ; @0xd32
	; Implicit def %r2                      ; @0xd36
	lp	.LZD39                          ; @0xd36
.LBB7_50:                               ; %for.cond.cleanup31
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0xd3a
	st.ab	%r9,[%r1,4]                     ; @0xd3a
.LZD39:                                 ; @0xd3e
	; ZD Loop End                           ; @0xd3e
	nop_s                                   ; inserted to benefit BPU
                                        ; @0xd3e
	b_s	.LBB7_52                        ; @0xd40
.LBB7_25:                               ; %iter.check126.preheader
                                        ; @0xd42

.vvsbundle  "v3sc"                      ; implicit-def: $vr0
 ;	 { 
	vvci.w	%vr1                            ; @0xd42
	vvmov.w	 %vr2, 0                        ; @0xd42
	vvpinit.w	%p1, 0, 65534           ; @0xd42
	mov_s	%r17,%r11                       ; @0xd42
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvpinit.w	%p2, 0, 1               ; @0xd52
	sub3	%r3,%r16,64/8                   ; @0xd52
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvpinit.w	%p4, 0, 65532           ; @0xd5c
	vvshfl.w.p1	%vr0, %vr2, %vr2        ; @0xd5c
	bmsk	%r6,%r8,2                       ; @0xd5c
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvadd.w	%vr3, %vr1, 2                   ; @0xd6c
	vvpinit.w	%p5, 0, 65520           ; @0xd6c
	lsr_s	%r3,%r3,6                       ; @0xd6c
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvpinit.w	%p1, 0, 255             ; @0xd78
	vvadd.w	%vr4, %vr1, 4                   ; @0xd78
	bmskn	%blink,%r16,5                   ; @0xd78
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvpinit.w	%p2, 0, 15              ; @0xd86
	vvshfl.w.p2	%vr0, %vr16, %vr2       ; @0xd86
	sub	%r5,%r16,%r6                    ; @0xd86
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvsel.w.p4	%vr1, %vr2, %vr3        ; @0xd96
	vvpinit.w	%p3, 0, 3               ; @0xd96
	add	%r7,%r3,1                       ; @0xd96
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvsel.w.p5	%vr2, %vr2, %vr4        ; @0xda6
	add	%r4,%r11,1                      ; @0xda6
 ;	 }
	sub	%r30,%r8,8                      ; @0xdb0
	mov_s	%r20,0                          ; @0xdb4
.LBB7_30:                               ; %iter.check126
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB7_32 Depth 2
                                        ;     Child Loop BB7_36 Depth 2
                                        ;     Child Loop BB7_39 Depth 2
                                        ; @0xdb6
	mov_s	%r13,%r9                        ; @0xdb6
	cmp	%r16,64                         ; @0xdb8
	mov_s	%r12,0                          ; @0xdbc
	bcs	.LBB7_35                        ; @0xdbe
;  %bb.31:                              ; %vector.body133.preheader
                                        ;   in Loop: Header=BB7_30 Depth=1
.vvsbundle  "v3sc" 
 ;	 { 
	vvmov.w	 %vr5, 0                        ; @0xdc2
	vvmov.w	 %vr4, 0                        ; @0xdc2
	vvmov.w	%vr3, %vr0                      ; @0xdc2
	add2	%r13,%r15,192/4                 ; @0xdc2
 ;	 }
	; Implicit def %r12                     ; @0xdd2
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr6, 0                        ; @0xdd2
	mov	%lp_count,%r7                   ; @0xdd2
 ;	 }
	lp	.LZD35                          ; @0xdda
.LBB7_32:                               ; %vector.body133
                                        ;   Parent Loop BB7_30 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; @0xdde
	vvld.av.w	%vr7,%r13,-1            ; @0xdde
.vvsbundle  " v2" 
 ;	 { 
	vvld.av.w	%vr8,%r13,-1            ; @0xde4
	vvadd.w	%vr6, %vr7, %vr6                ; @0xde4
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvld.av.w	%vr7,%r13,-1            ; @0xdee
	vvadd.w	%vr5, %vr8, %vr5                ; @0xdee
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvld.av.w	%vr8,%r13,7             ; @0xdf8
	vvadd.w	%vr4, %vr7, %vr4                ; @0xdf8
 ;	 }
	vvadd.w	%vr3, %vr8, %vr3                ; @0xe02
.LZD35:                                 ; @0xe08
	; ZD Loop End                           ; @0xe08
;  %bb.33:                              ; %middle.block123
                                        ;   in Loop: Header=BB7_30 Depth=1
	vvadd.w	%vr3, %vr4, %vr3                ; @0xe08
	vvadd.w	%vr3, %vr5, %vr3                ; @0xe0e
	vvadd.w	%vr16, %vr6, %vr3               ; @0xe14
	vvc2add.w	%vr16                   ; @0xe1a
	vvshfleven.w	%vr16, %vr16            ; @0xe1e
	vvc2add.w	%vr16                   ; @0xe22
	vvshfleven.w	%vr16, %vr16            ; @0xe26
	vvc2add.w	%vr16                   ; @0xe2a
	vvshfleven.w	%vr16, %vr16            ; @0xe2e
	vvc2add.w	%vr16                   ; @0xe32
	vvmov1.x.from.w	%r13,%vr16,0            ; @0xe36
	breq	%r16,%blink,.LBB7_29            ; @0xe3c
;  %bb.34:                              ; %vec.epilog.iter.check146
                                        ;   in Loop: Header=BB7_30 Depth=1
	mov_s	%r12,%blink                     ; @0xe40
	mov_s	%r3,%blink                      ; @0xe42
	tst	%r16,56                         ; @0xe44
	beq_s	.LBB7_38                        ; @0xe48
.LBB7_35:                               ; %vec.epilog.ph147
                                        ;   in Loop: Header=BB7_30 Depth=1
                                        ; @0xe4a
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr3, 0                        ; @0xe4a
	add	%r3,%r11,%r12                   ; @0xe4a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,0,%r13             ; @0xe52
	add_s	%r12,%r12,%r17                  ; @0xe52
 ;	 }
	sub	%r13,%r30,%r3                   ; @0xe5a
	add2	%r3,%r0,%r12                    ; @0xe5e
	lsr_s	%r13,%r13,3                     ; @0xe62
	add	%lp_count,%r13,1                ; @0xe64
	; Implicit def %r13                     ; @0xe68
	lp	.LZD36                          ; @0xe68
.LBB7_36:                               ; %vec.epilog.vector.body156
                                        ;   Parent Loop BB7_30 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; @0xe6c
	vvld.ab.w.p1	%vr4,%r3,32             ; @0xe6c
	vvadd.w	%vr3, %vr4, %vr3                ; @0xe74
.LZD36:                                 ; @0xe7a
	; ZD Loop End                           ; @0xe7a
;  %bb.37:                              ; %vec.epilog.middle.block144
                                        ;   in Loop: Header=BB7_30 Depth=1

	mov_s	%r3,%r5                         ; implicit-def: $vr4
                                        ; @0xe7a
	vvshfl.w.p2	%vr4, %vr3, %vr2        ; @0xe7c
	vvadd.w	%vr3, %vr3, %vr4                ; @0xe82
	vvshfl.w.p3	%vr4, %vr3, %vr1        ; @0xe86
	vvadd.w	%vr3, %vr3, %vr4                ; @0xe8c
	vvmov1.from.w	%r12,%vr3,1             ; @0xe90
	vvadd.w	%vr3, %vr3, %r12                ; @0xe96
	vvmov1.x.from.w	%r13,%vr3,0             ; @0xe9a
	breq	%r6,0,.LBB7_29                  ; @0xea0
.LBB7_38:                               ; %vec.epilog.scalar.ph145
                                        ;   in Loop: Header=BB7_30 Depth=1
                                        ; @0xea4
	add	%r19,%r4,%r3                    ; @0xea4
	add	%r18,%r3,%r17                   ; @0xea8
	add	%r12,%r11,%r3                   ; @0xeac
	max	%r14,%r8,%r19                   ; @0xeb0
	add2	%r3,%r0,%r18                    ; @0xeb4
	sub	%lp_count,%r14,%r12             ; @0xeb8
	; Implicit def %r14                     ; @0xebc
	lp	.LZD37                          ; @0xebc
.LBB7_39:                               ; %for.body32.us81
                                        ;   Parent Loop BB7_30 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; @0xec0
	ld.ab	%r12,[%r3,4]                    ; @0xec0
	add_s	%r13,%r12,%r13                  ; @0xec4
.LZD37:                                 ; @0xec6
	; ZD Loop End                           ; @0xec6
.LBB7_29:                               ; %for.cond.cleanup31.us76
                                        ;   in Loop: Header=BB7_30 Depth=1
                                        ; @0xec6
	add2	%r3,%r1,%r20                    ; @0xec6
	add2	%r15,%r15,%r8                   ; @0xeca
	add	%r17,%r17,%r8                   ; @0xece
	add_s	%r20,%r20,1                     ; @0xed2
	st_s	%r13,[%r3,0]                    ; @0xed4
	dbnz	%r2,.LBB7_30                    ; @0xed6
.LBB7_52:                               ; %for.cond.cleanup
                                        ; @0xeda
	ld	%blink,[%sp,32]                 ; @0xeda
	.cfa_restore	{%blink}                ; @0xede
	ld	%r20,[%sp,28]                   ; @0xede
	.cfa_restore	{%r20}                  ; @0xee2
	ldd	%r18,[%sp,20]                   ; @0xee2
	.cfa_restore	{%r19}                  ; @0xee6
	.cfa_restore	{%r18}                  ; @0xee6
	ldd	%r16,[%sp,12]                   ; @0xee6
	.cfa_restore	{%r17}                  ; @0xeea
	.cfa_restore	{%r16}                  ; @0xeea
	ldd	%r14,[%sp,4]                    ; @0xeea
	.cfa_restore	{%r15}                  ; @0xeee
	.cfa_restore	{%r14}                  ; @0xeee
	ld.ab	%r13,[%sp,36]                   ; @0xeee
	.cfa_restore	{%r13}                  ; @0xef2
	.cfa_pop	36                              ; @0xef2
	j_s	[%blink]                        ; @0xef2
	.cfa_ef
.Lfunc_end7:                            ; @0xef4

	.align	4                               ; -- End function
                                        ; -- Begin function autovectorized_mat_reduce_rows
autovectorized_mat_reduce_rows:         ; @autovectorized_mat_reduce_rows
                                        ; @0xef4
.Lautovectorized_mat_reduce_rows$local: ; @0xef4
	.cfa_bf	.Lautovectorized_mat_reduce_rows$local
;  %bb.0:                               ; %entry
	st.aw	%r13,[%sp,-12]                  ; @0xef4
	.cfa_push	12                      ; @0xef8
	.cfa_reg_offset	{%r13}, 0               ; @0xef8
	st	%r14,[%sp,4]                    ; @0xef8
	.cfa_reg_offset	{%r14}, 4               ; @0xefc
	st	%blink,[%sp,8]                  ; @0xefc
	.cfa_reg_offset	{%blink}, 8             ; @0xf00
	cmp_s	%r2,0                           ; @0xf00
	ble	.LBB8_30                        ; @0xf02
;  %bb.1:                               ; %for.body.lr.ph
	mov_s	%r7,%r3                         ; @0xf06
	brlt	%r3,1,.LBB8_18                  ; @0xf08
;  %bb.2:                               ; %for.body.lr.ph.split.us
	brhs	%r7,8,.LBB8_3                   ; @0xf0c
;  %bb.4:                               ; %iter.check35.us.preheader
	mov_s	%r11,0                          ; @0xf10
.LBB8_5:                                ; %iter.check35.us
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB8_6 Depth 2
                                        ; @0xf12
	; Implicit def %r8                      ; @0xf12
	mov	%lp_count,%r7                   ; @0xf12
	mov_s	%r12,0                          ; @0xf16
	lp	.LZD42                          ; @0xf18
.LBB8_6:                                ; %for.body4.us.us
                                        ;   Parent Loop BB8_5 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; Label of block must be emitted
                                        ; @0xf1c AlignLabel LoopTop Freq=200
	ld.ab	%r3,[%r0,4]                     ; @0xf1c
	add_s	%r12,%r3,%r12                   ; @0xf20
.LZD42:                                 ; @0xf22
	; ZD Loop End                           ; @0xf22
;  %bb.29:                              ; %for.cond.cleanup3.us.loopexit.us
                                        ;   in Loop: Header=BB8_5 Depth=1
	add2	%r3,%r1,%r11                    ; @0xf22
	add_s	%r11,%r11,1                     ; @0xf26
	st_s	%r12,[%r3,0]                    ; @0xf28
	dbnz	%r2,.LBB8_5                     ; @0xf2a
	b	.LBB8_30                        ; @0xf2e
.LBB8_18:                               ; %iter.check
                                        ; @0xf32
	mov_s	%r0,0                           ; @0xf32
	brlo	%r2,8,.LBB8_27                  ; @0xf34
;  %bb.19:                              ; %vector.main.loop.iter.check
	cmp_s	%r2,64                          ; @0xf38
	bcs	.LBB8_24                        ; @0xf3a
;  %bb.20:                              ; %vector.ph
	; Implicit def %r11                     ; @0xf3e
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr0, 0                        ; @0xf3e
	sub3	%r3,%r2,64/8                    ; @0xf3e
 ;	 }
	lsr_s	%r3,%r3,6                       ; @0xf46
	add	%lp_count,%r3,1                 ; @0xf48
	add2	%r3,%r1,192/4                   ; @0xf4c
	bmskn	%r0,%r2,5                       ; @0xf50
	lp	.LZD50                          ; @0xf54
.LBB8_21:                               ; %vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0xf58
	vvst.av.w	%vr0,%r3,-1             ; @0xf58
	vvst.av.w	%vr0,%r3,-1             ; @0xf5e
	vvst.av.w	%vr0,%r3,-1             ; @0xf64
	vvst.av.w	%vr0,%r3,7              ; @0xf6a
.LZD50:                                 ; @0xf70
	; ZD Loop End                           ; @0xf70
;  %bb.22:                              ; %middle.block
	cmp_s	%r0,%r2                         ; @0xf70
	beq_s	.LBB8_30                        ; @0xf72
;  %bb.23:                              ; %vec.epilog.iter.check
	tst	%r2,56                          ; @0xf74
	beq_s	.LBB8_27                        ; @0xf78
.LBB8_24:                               ; %vec.epilog.ph
                                        ; @0xf7a
	; Implicit def %r11                     ; @0xf7a
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov.w	 %vr0, 0                        ; @0xf7a
	vvpinit.w	%p1, 0, 255             ; @0xf7a
	sub_s	%r12,%r2,%r0                    ; @0xf7a
 ;	 }
	sub_s	%r12,%r12,8                     ; @0xf86
	lsr_s	%r12,%r12,3                     ; @0xf88
	add2	%r3,%r1,%r0                     ; @0xf8a
	bmskn	%r0,%r2,2                       ; @0xf8e
	add	%lp_count,%r12,1                ; @0xf92
	lp	.LZD49                          ; @0xf96
.LBB8_25:                               ; %vec.epilog.vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0xf9a
	vvst.ab.w.p1	%vr0,%r3,32             ; @0xf9a
.LZD49:                                 ; @0xfa2
	; ZD Loop End                           ; @0xfa2
;  %bb.26:                              ; %vec.epilog.middle.block
	cmp_s	%r0,%r2                         ; @0xfa2
	beq_s	.LBB8_30                        ; @0xfa4
.LBB8_27:                               ; %for.cond.cleanup3.preheader
                                        ; @0xfa6
	add_s	%r3,%r0,1                       ; @0xfa6
	add2_s	%r1,%r1,%r0                     ; @0xfa8
	max	%r2,%r2,%r3                     ; @0xfaa
	sub	%lp_count,%r2,%r0               ; @0xfae
	; Implicit def %r2                      ; @0xfb2
	lp	.LZD48                          ; @0xfb2
.LBB8_28:                               ; %for.cond.cleanup3
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0xfb6
	st.ab	0,[%r1,4]                       ; @0xfb6
.LZD48:                                 ; @0xfba
	; ZD Loop End                           ; @0xfba
	nop                                     ; inserted to benefit BPU
                                        ; @0xfba
	nop_s                                   ; widened to benefit BPU
                                        ; inserted to benefit BPU
                                        ; @0xfbe
	b	.LBB8_30                        ; @0xfc0
.LBB8_3:                                ; %iter.check35.preheader
                                        ; @0xfc4
.vvsbundle  "v2sc" 
 ;	 { 
	vvmov.w	 %vr1, 0                        ; @0xfc4
	vvci.w	%vr0                            ; @0xfc4
	sub3	%r3,%r7,64/8                    ; @0xfc4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvpinit.w	%p2, 0, 65532           ; @0xfd0
	lsr_s	%r3,%r3,6                       ; @0xfd0
 ;	 }
.vvsbundle  "v3sc" 
 ;	 { 
	vvadd.w	%vr3, %vr0, 4                   ; @0xfd8
	vvadd.w	%vr2, %vr0, 2                   ; @0xfd8
	vvpinit.w	%p3, 0, 65520           ; @0xfd8
	mov_s	%r4,%r0                         ; @0xfd8
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvsel.w.p2	%vr0, %vr1, %vr2        ; @0xfe8
	vvpinit.w	%p1, 0, 255             ; @0xfe8
	bmskn	%r11,%r7,2                      ; @0xfe8
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvsel.w.p3	%vr1, %vr1, %vr3        ; @0xff8
	vvpinit.w	%p2, 0, 15              ; @0xff8
	bmskn	%r8,%r7,5                       ; @0xff8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvpinit.w	%p3, 0, 3               ; @0x1008
	add	%r9,%r3,1                       ; @0x1008
 ;	 }
	sub	%r6,%r7,8                       ; @0x1012
	mov_s	%r5,0                           ; @0x1016
	mov	%r30,0                          ; @0x1018
.LBB8_8:                                ; %iter.check35
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB8_10 Depth 2
                                        ;     Child Loop BB8_14 Depth 2
                                        ;     Child Loop BB8_17 Depth 2
                                        ; @0x101c
	cmp	%r7,64                          ; @0x101c
	mov_s	%r3,0                           ; @0x1020
	mov_s	%r12,0                          ; @0x1022
	bcs	.LBB8_13                        ; @0x1024
;  %bb.9:                               ; %vector.body42.preheader
                                        ;   in Loop: Header=BB8_8 Depth=1
.vvsbundle  "v3sc" 
 ;	 { 
	vvmov.w	 %vr4, 0                        ; @0x1028
	vvmov.w	 %vr3, 0                        ; @0x1028
	vvmov.w	 %vr2, 0                        ; @0x1028
	add2	%r3,%r4,192/4                   ; @0x1028
 ;	 }
	; Implicit def %blink                   ; @0x1038
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr5, 0                        ; @0x1038
	mov	%lp_count,%r9                   ; @0x1038
 ;	 }
	lp	.LZD44                          ; @0x1040
.LBB8_10:                               ; %vector.body42
                                        ;   Parent Loop BB8_8 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; @0x1044
	vvld.av.w	%vr6,%r3,-1             ; @0x1044
.vvsbundle  " v2" 
 ;	 { 
	vvld.av.w	%vr7,%r3,-1             ; @0x104a
	vvadd.w	%vr5, %vr6, %vr5                ; @0x104a
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvld.av.w	%vr6,%r3,-1             ; @0x1054
	vvadd.w	%vr4, %vr7, %vr4                ; @0x1054
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvld.av.w	%vr7,%r3,7              ; @0x105e
	vvadd.w	%vr3, %vr6, %vr3                ; @0x105e
 ;	 }
	vvadd.w	%vr2, %vr7, %vr2                ; @0x1068
.LZD44:                                 ; @0x106e
	; ZD Loop End                           ; @0x106e
;  %bb.11:                              ; %middle.block32
                                        ;   in Loop: Header=BB8_8 Depth=1
	vvadd.w	%vr2, %vr3, %vr2                ; @0x106e
	vvadd.w	%vr2, %vr4, %vr2                ; @0x1074
	vvadd.w	%vr16, %vr5, %vr2               ; @0x107a
	vvc2add.w	%vr16                   ; @0x1080
	vvshfleven.w	%vr16, %vr16            ; @0x1084
	vvc2add.w	%vr16                   ; @0x1088
	vvshfleven.w	%vr16, %vr16            ; @0x108c
	vvc2add.w	%vr16                   ; @0x1090
	vvshfleven.w	%vr16, %vr16            ; @0x1094
	vvc2add.w	%vr16                   ; @0x1098
	vvmov1.x.from.w	%r3,%vr16,0             ; @0x109c
	breq	%r8,%r7,.LBB8_7                 ; @0x10a2
;  %bb.12:                              ; %vec.epilog.iter.check55
                                        ;   in Loop: Header=BB8_8 Depth=1
	mov_s	%r12,%r8                        ; @0x10a6
	mov_s	%blink,%r8                      ; @0x10a8
	tst	%r7,56                          ; @0x10aa
	beq_s	.LBB8_16                        ; @0x10ae
.LBB8_13:                               ; %vec.epilog.ph56
                                        ;   in Loop: Header=BB8_8 Depth=1
                                        ; @0x10b0
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr2, 0                        ; @0x10b0
	sub	%blink,%r6,%r12                 ; @0x10b0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,0,%r3              ; @0x10b8
	add_s	%r12,%r12,%r5                   ; @0x10b8
 ;	 }
	lsr	%blink,%blink,3                 ; @0x10c0
	add2	%r3,%r0,%r12                    ; @0x10c4
	add	%lp_count,%blink,1              ; @0x10c8
	; Implicit def %blink                   ; @0x10cc
	lp	.LZD45                          ; @0x10cc
.LBB8_14:                               ; %vec.epilog.vector.body64
                                        ;   Parent Loop BB8_8 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; Label of block must be emitted
                                        ; @0x10d0 AlignLabel LoopTop Freq=131
	vvld.ab.w.p1	%vr3,%r3,32             ; @0x10d0
	vvadd.w	%vr2, %vr3, %vr2                ; @0x10d8
.LZD45:                                 ; @0x10de
	; ZD Loop End                           ; @0x10de
;  %bb.15:                              ; %vec.epilog.middle.block53
                                        ;   in Loop: Header=BB8_8 Depth=1

	mov_s	%blink,%r11                     ; implicit-def: $vr3
                                        ; @0x10de
	vvshfl.w.p2	%vr3, %vr2, %vr1        ; @0x10e0
	vvadd.w	%vr2, %vr2, %vr3                ; @0x10e6
	vvshfl.w.p3	%vr3, %vr2, %vr0        ; @0x10ea
	vvadd.w	%vr2, %vr2, %vr3                ; @0x10f0
	vvmov1.from.w	%r3,%vr2,1              ; @0x10f4
	vvadd.w	%vr2, %vr2, %r3                 ; @0x10fa
	vvmov1.x.from.w	%r3,%vr2,0              ; @0x10fe
	breq	%r11,%r7,.LBB8_7                ; @0x1104
.LBB8_16:                               ; %for.body4.us.preheader
                                        ;   in Loop: Header=BB8_8 Depth=1
                                        ; @0x1108
	add	%r12,%blink,1                   ; @0x1108
	add	%r13,%blink,%r5                 ; @0x110c
	max	%r14,%r7,%r12                   ; @0x1110
	add2	%r12,%r0,%r13                   ; @0x1114
	; Implicit def %r13                     ; @0x1118
	sub	%lp_count,%r14,%blink           ; @0x1118
	lp	.LZD46                          ; @0x111c
.LBB8_17:                               ; %for.body4.us
                                        ;   Parent Loop BB8_8 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
                                        ; @0x1120
	ld.ab	%r14,[%r12,4]                   ; @0x1120
	add_s	%r3,%r14,%r3                    ; @0x1124
.LZD46:                                 ; @0x1126
	; ZD Loop End                           ; @0x1126
.LBB8_7:                                ; %for.cond.cleanup3.us
                                        ;   in Loop: Header=BB8_8 Depth=1
                                        ; @0x1126
	add2	%r12,%r1,%r30                   ; @0x1126
	add2	%r4,%r4,%r7                     ; @0x112a
	add	%r5,%r5,%r7                     ; @0x112e
	add	%r30,%r30,1                     ; @0x1132
	st_s	%r3,[%r12,0]                    ; @0x1136
	dbnz	%r2,.LBB8_8                     ; @0x1138
.LBB8_30:                               ; %for.cond.cleanup
                                        ; @0x113c
	ld	%blink,[%sp,8]                  ; @0x113c
	.cfa_restore	{%blink}                ; @0x1140
	ld_s	%r14,[%sp,4]                    ; @0x1140
	.cfa_restore	{%r14}                  ; @0x1142
	ld.ab	%r13,[%sp,12]                   ; @0x1142
	.cfa_restore	{%r13}                  ; @0x1146
	.cfa_pop	12                              ; @0x1146
	j_s	[%blink]                        ; @0x1146
	.cfa_ef
.Lfunc_end8:                            ; @0x1148

	.align	4                               ; -- End function
                                        ; -- Begin function vekt_mat_reduce_rows_wrapper
vekt_mat_reduce_rows_wrapper:           ; @vekt_mat_reduce_rows_wrapper
                                        ; @0x1148
.Lvekt_mat_reduce_rows_wrapper$local:   ; @0x1148
	.cfa_bf	.Lvekt_mat_reduce_rows_wrapper$local
;  %bb.0:                               ; %entry
	std.aw	%r20,[%sp,-20]                  ; @0x1148
	.cfa_push	20                      ; @0x114c
	.cfa_reg_offset	{%r20}, 0               ; @0x114c
	.cfa_reg_offset	{%r21}, 4               ; @0x114c
	std	%r22,[%sp,8]                    ; @0x114c
	.cfa_reg_offset	{%r22}, 8               ; @0x1150
	.cfa_reg_offset	{%r23}, 12              ; @0x1150
	st	%blink,[%sp,16]                 ; @0x1150
	.cfa_reg_offset	{%blink}, 16            ; @0x1154
	sub_s	%sp,%sp,24                      ; @0x1154
	.cfa_push	24                      ; @0x1156
	mov_s	%r6,%r3                         ; @0x1156
	mov_s	%r8,%r2                         ; @0x1158
	mov_s	%r2,%r0                         ; @0x115a
	mov_s	%r9,1                           ; @0x115c
	mov_s	%r4,0                           ; @0x115e
	mov_s	%r22,%r1                        ; @0x1160
	mov_s	%r21,%r1                        ; @0x1162
	mov_s	%r0,%r8                         ; @0x1164
	mov_s	%r1,%r3                         ; @0x1166
	mov_s	%r3,%r2                         ; @0x1168
	mov_s	%r5,%r8                         ; @0x116a
	mov_s	%r7,%r6                         ; @0x116c
	mov_s	%r20,%r9                        ; @0x116e
	mov_s	%r23,%r4                        ; @0x1170
	std	%r8,[%sp,16]                    ; @0x1172
	std	%r22,[%sp,8]                    ; @0x1176
	std	%r20,[%sp,0]                    ; @0x117a
	bl	vekt_mat_reduce_rows            ; @0x117e
	add_s	%sp,%sp,24                      ; @0x1182
	.cfa_pop	24                              ; @0x1184
	ld	%blink,[%sp,16]                 ; @0x1184
	.cfa_restore	{%blink}                ; @0x1188
	ldd	%r22,[%sp,8]                    ; @0x1188
	.cfa_restore	{%r23}                  ; @0x118c
	.cfa_restore	{%r22}                  ; @0x118c
	ldd.ab	%r20,[%sp,20]                   ; @0x118c
	.cfa_restore	{%r21}                  ; @0x1190
	.cfa_restore	{%r20}                  ; @0x1190
	.cfa_pop	20                              ; @0x1190
	j_s	[%blink]                        ; @0x1190
	.cfa_ef
.Lfunc_end9:                            ; @0x1192

	.reloc	_init_ad,0	;startup code to enable %status AD bit ; -- End function
