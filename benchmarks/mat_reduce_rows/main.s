	.option	%reg
	.off	assume_short
	.file	"main.c"
	.globl	res
	.size	res, 32
	.type	res,@object
	.size	.L.str.4, 15
	.type	.L.str.4,@object
	.globl	a
	.size	a, 32768
	.type	a,@object
	.size	.L.str.2, 23
	.type	.L.str.2,@object
	.size	.Lstr, 26
	.type	.Lstr,@object
	.size	.Lstr.9, 27
	.type	.Lstr.9,@object
	.size	.L.str, 29
	.type	.L.str,@object
	.size	.L.str.8, 53
	.type	.L.str.8,@object
	.size	.L.str.3, 59
	.type	.L.str.3,@object
	.size	.L.str.6, 63
	.type	.L.str.6,@object
	.globl	main
	.type	main,@function
	.type	.Lmain$local,@function
	.size	main, .Lfunc_end0-main
	.size	.Lmain$local, .Lfunc_end0-main
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
	.section	.vecmem_data,"aw",@progbits
	.align	4
res:                                    ; @0x0
	.skip	32
	.align	4
a:                                      ; @0x20
	.skip	32768
	.section	.rodata,"a",@progbits
	.align	4
.L.str.4:                               ; @0x0
	.asciz	"Speedup: %.2f\n"
	.align	4
.L.str.2:                               ; @0x10
	.asciz	"Vettorizzo su %d lane\n"
	.align	4
.Lstr:                                  ; @0x28
	.asciz	"Versione autovettorizzata"
	.align	4
.Lstr.9:                                ; @0x44
	.asciz	"Versione vekt-vettorizzata"
	.align	4
.L.str:                                 ; @0x60
	.asciz	"Tempo di esecuzione: %.2fms\n"
	.align	4
.L.str.8:                               ; @0x80
	.asciz	"Tempo di esecuzione di vekt_mat_reduce_rows: %.2fms\n"
	.align	4
.L.str.3:                               ; @0xb8
	.asciz	"Tempo di esecuzione di vectorized_mat_reduce_rows: %.2fms\n"
	.align	4
.L.str.6:                               ; @0xf4
	.asciz	"Tempo di esecuzione di autovectorized_mat_reduce_rows: %.2fms\n"
	.text
	.global	.CC_I
	.equ	.CC_I, 0
	.ident	"LLVM 17.0.7/V-2024.06. (build 008) (LLVM 17.0.7) -arcv2hs -core4 -Xcode_density -Xatomic -Xll64 -Xunaligned -Xdiv_rem=radix4 -Xswap -Xbitscan -Xmpy_option=mpyd -Xshift_assist -Xbarrel_shifter -Xfpud_div -Xfpu_mac -Xtimer0 -Xrtc -Xstack_check -Xstu=4 -Xvdsp4 -Xvec_unit_rev_minor=1 -Xvec_width=512 -Xvec_mem_size=128k -Xvec_mem_bank_width=16 -Xvec_max_fetch_size=16 -Xvec_num_slots=3 -Xvec_super_with_scalar -Xvec_regs=32 -Xvec_fpu=32 -Xvec_fpu_math=3 -Xvec_fpu_2nd_mul -Xvec_fpu_types=2 -Xvec_num_rd_ports=6 -Xvec_num_acc=8 -Xvec_num_mpy=2 -Xvec_mpy32 -Xvec_num_alu=3 -Xvec_guard_bit_option=0 -Xvec_stack_check -Hvdsp_vector_c -O3 -fvectorize -fslp-vectorize -ffast-math"
	.align	8                               ; -- Begin function main
main:                                   ; @main
                                        ; @0x0
.Lmain$local:                           ; @0x0
	.cfa_bf	.Lmain$local
;  %bb.0:                               ; %entry
	st.aw	%r13,[%sp,-76]                  ; @0x0
	.cfa_push	76                      ; @0x4
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
	st	%r20,[%sp,28]                   ; @0x10
	.cfa_reg_offset	{%r20}, 28              ; @0x14
	std	%r22,[%sp,32]                   ; @0x14
	.cfa_reg_offset	{%r22}, 32              ; @0x18
	.cfa_reg_offset	{%r23}, 36              ; @0x18
	st	%blink,[%sp,40]                 ; @0x18
	.cfa_reg_offset	{%blink}, 40            ; @0x1c
	mov_s	%r15,res                        ; @0x1c
	add	%r20,%r15,a-res                 ; @0x22
	mov_s	%r0,%r20                        ; @0x26
	mov_s	%r1,8                           ; @0x28
	mov	%r2,1024                        ; @0x2a
	mov_s	%r3,1                           ; @0x2e
	bl	init_matrix                     ; @0x30
	mov_s	%r0,%r15                        ; @0x34
	mov_s	%r1,8                           ; @0x36
	mov	%r2,0                           ; widened to benefit BPU
                                        ; @0x38
	bl	init_vector                     ; @0x3c
	bl	clock                           ; @0x40
	mov_s	%r14,%r0                        ; @0x44
	mov_s	%r0,%r20                        ; @0x46
	mov_s	%r1,%r15                        ; @0x48
	mov_s	%r2,8                           ; @0x4a
	mov	%r3,1024                        ; @0x4c
	bl	mat_reduce_rows                 ; @0x50
	mov_s	%r16,0                          ; @0x54
	mov_s	%r17,0x408f4000@u32             ; @0x56
	bl	clock                           ; @0x5c
	sub_s	%r0,%r0,%r14                    ; @0x60
	fint2d	%r2,%r0                         ; @0x62
	fdmul	%r18,%r2,%r16                   ; @0x66
	bl	_timer_clocks_per_sec           ; @0x6a
	fuint2d	%r2,%r0                         ; @0x6e
	fddiv	%r18,%r18,%r2                   ; @0x72
	mov_s	%r13,.L.str.4                   ; @0x76
	add1	%r0,%r13,(.L.str-.L.str.4)/2    ; @0x7c
	mov_s	%r1,%r18                        ; @0x80
	mov_s	%r2,%r19                        ; @0x82
	bl	printf                          ; @0x84
	mov_s	%r0,%r15                        ; @0x88
	mov_s	%r1,8                           ; @0x8a
	bl	print_vector                    ; @0x8c
	vvpinit.w	%p1, 0, 255             ; @0x90
	vvld.w.p1	%vr0,%r15               ; @0x96
	vvmov2.x.from.w	%r2,%vr0,0              ; @0x9c
	vvmov2.x.from.w	%r0,%vr0,2              ; @0xa2
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r4,%vr0,4              ; @0xa8
	st	%r3,[%sp,48]                    ; @0xa8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r6,%vr0,6              ; @0xb2
	std	%r0,[%sp,52]                    ; @0xb2
 ;	 }
	mov_s	%r0,10                          ; @0xbc
	std	%r4,[%sp,60]                    ; @0xbe
	std	%r6,[%sp,68]                    ; @0xc2
	st	%r2,[%sp,44]                    ; @0xc6
	bl	putchar                         ; @0xca
	add_s	%r0,%r13,.L.str.2-.L.str.4      ; @0xce
	mov_s	%r1,16                          ; @0xd0
	bl	printf                          ; @0xd2
	mov_s	%r0,%r15                        ; @0xd6
	mov_s	%r1,8                           ; @0xd8
	mov_s	%r2,0                           ; @0xda
	bl	init_vector                     ; @0xdc
	bl	clock                           ; @0xe0
	mov_s	%r14,%r0                        ; @0xe4
	mov_s	%r0,%r20                        ; @0xe6
	mov_s	%r1,%r15                        ; @0xe8
	mov_s	%r2,8                           ; @0xea
	mov	%r3,1024                        ; @0xec
	bl.d	vectorized_mat_reduce_rows      ; @0xf0
	nop                                     ; inserted to benefit BPU
                                        ; @0xf4
	bl	clock                           ; @0xf8
	sub_s	%r0,%r0,%r14                    ; @0xfc
	fint2d	%r2,%r0                         ; @0xfe
	fdmul	%r22,%r2,%r16                   ; @0x102
	bl	_timer_clocks_per_sec           ; @0x106
	fuint2d	%r2,%r0                         ; @0x10a
	fddiv	%r22,%r22,%r2                   ; @0x10e
	add2	%r0,%r13,(.L.str.3-.L.str.4)/4  ; @0x112
	mov_s	%r1,%r22                        ; @0x116
	mov_s	%r2,%r23                        ; @0x118
	bl	printf                          ; @0x11a
	fddiv	%r2,%r18,%r22                   ; @0x11e
	mov_s	%r0,%r13                        ; @0x122
	mov_s	%r1,%r2                         ; @0x124
	mov_s	%r2,%r3                         ; @0x126
	bl	printf                          ; @0x128
	mov_s	%r0,%r15                        ; @0x12c
	mov_s	%r1,8                           ; @0x12e
	bl	print_vector                    ; @0x130
	mov_s	%r1,%r15                        ; @0x134
	add_s	%r0,%sp,44                      ; @0x136
	mov_s	%r2,8                           ; @0x138
	bl	check_result                    ; @0x13a
	mov_s	%r0,10                          ; @0x13e
	bl	putchar                         ; @0x140
	add	%r0,%r13,.Lstr-.L.str.4         ; widened to benefit BPU
                                        ; @0x144
	bl	puts                            ; @0x148
	mov_s	%r0,%r15                        ; @0x14c
	mov_s	%r1,8                           ; @0x14e
	mov	%r2,0                           ; widened to benefit BPU
                                        ; @0x150
	bl	init_vector                     ; @0x154
	bl	clock                           ; @0x158
	mov_s	%r14,%r0                        ; @0x15c
	mov_s	%r0,%r20                        ; @0x15e
	mov_s	%r1,%r15                        ; @0x160
	mov_s	%r2,8                           ; @0x162
	mov	%r3,1024                        ; @0x164
	bl.d	autovectorized_mat_reduce_rows  ; @0x168
	nop                                     ; inserted to benefit BPU
                                        ; @0x16c
	bl	clock                           ; @0x170
	sub_s	%r0,%r0,%r14                    ; @0x174
	fint2d	%r2,%r0                         ; @0x176
	fdmul	%r22,%r2,%r16                   ; @0x17a
	bl	_timer_clocks_per_sec           ; @0x17e
	fuint2d	%r2,%r0                         ; @0x182
	fddiv	%r22,%r22,%r2                   ; @0x186
	add2	%r0,%r13,(.L.str.6-.L.str.4)/4  ; @0x18a
	mov_s	%r1,%r22                        ; @0x18e
	mov_s	%r2,%r23                        ; @0x190
	bl	printf                          ; @0x192
	fddiv	%r2,%r18,%r22                   ; @0x196
	mov_s	%r0,%r13                        ; @0x19a
	mov_s	%r1,%r2                         ; @0x19c
	mov_s	%r2,%r3                         ; @0x19e
	bl	printf                          ; @0x1a0
	mov_s	%r0,%r15                        ; @0x1a4
	mov_s	%r1,8                           ; @0x1a6
	bl	print_vector                    ; @0x1a8
	mov_s	%r1,%r15                        ; @0x1ac
	add_s	%r0,%sp,44                      ; @0x1ae
	mov_s	%r2,8                           ; @0x1b0
	bl	check_result                    ; @0x1b2
	mov_s	%r0,10                          ; @0x1b6
	bl	putchar                         ; @0x1b8
	add1	%r0,%r13,(.Lstr.9-.L.str.4)/2   ; @0x1bc
	bl	puts                            ; @0x1c0
	mov_s	%r0,%r15                        ; @0x1c4
	mov_s	%r1,8                           ; @0x1c6
	mov	%r2,0                           ; widened to benefit BPU
                                        ; @0x1c8
	bl	init_vector                     ; @0x1cc
	bl	clock                           ; @0x1d0
	mov_s	%r14,%r0                        ; @0x1d4
	mov_s	%r0,%r20                        ; @0x1d6
	mov_s	%r1,%r15                        ; @0x1d8
	mov_s	%r2,8                           ; @0x1da
	mov	%r3,1024                        ; @0x1dc
	bl.d	vekt_mat_reduce_rows_wrapper    ; @0x1e0
	nop                                     ; inserted to benefit BPU
                                        ; @0x1e4
	bl	clock                           ; @0x1e8
	sub_s	%r0,%r0,%r14                    ; @0x1ec
	fint2d	%r2,%r0                         ; @0x1ee
	fdmul	%r16,%r2,%r16                   ; @0x1f2
	bl	_timer_clocks_per_sec           ; @0x1f6
	fuint2d	%r2,%r0                         ; @0x1fa
	fddiv	%r16,%r16,%r2                   ; @0x1fe
	add2	%r0,%r13,(.L.str.8-.L.str.4)/4  ; @0x202
	mov_s	%r1,%r16                        ; @0x206
	mov_s	%r2,%r17                        ; @0x208
	bl	printf                          ; @0x20a
	fddiv	%r2,%r18,%r16                   ; @0x20e
	mov_s	%r0,%r13                        ; @0x212
	mov_s	%r1,%r2                         ; @0x214
	mov_s	%r2,%r3                         ; @0x216
	bl	printf                          ; @0x218
	mov_s	%r0,%r15                        ; @0x21c
	mov_s	%r1,8                           ; @0x21e
	bl	print_vector                    ; @0x220
	mov_s	%r1,%r15                        ; @0x224
	add_s	%r0,%sp,44                      ; @0x226
	mov_s	%r2,8                           ; @0x228
	bl	check_result                    ; @0x22a
	mov_s	%r0,10                          ; @0x22e
	bl	putchar                         ; @0x230
	mov_s	%r0,0                           ; @0x234
	ld	%blink,[%sp,40]                 ; @0x236
	.cfa_restore	{%blink}                ; @0x23a
	ldd	%r22,[%sp,32]                   ; @0x23a
	.cfa_restore	{%r23}                  ; @0x23e
	.cfa_restore	{%r22}                  ; @0x23e
	ld	%r20,[%sp,28]                   ; @0x23e
	.cfa_restore	{%r20}                  ; @0x242
	ldd	%r18,[%sp,20]                   ; @0x242
	.cfa_restore	{%r19}                  ; @0x246
	.cfa_restore	{%r18}                  ; @0x246
	ldd	%r16,[%sp,12]                   ; @0x246
	.cfa_restore	{%r17}                  ; @0x24a
	.cfa_restore	{%r16}                  ; @0x24a
	ldd	%r14,[%sp,4]                    ; @0x24a
	.cfa_restore	{%r15}                  ; @0x24e
	.cfa_restore	{%r14}                  ; @0x24e
	ld.ab	%r13,[%sp,76]                   ; @0x24e
	.cfa_restore	{%r13}                  ; @0x252
	.cfa_pop	76                              ; @0x252
	j_s	[%blink]                        ; @0x252
	.cfa_ef
.Lfunc_end0:                            ; @0x254

	.reloc	_init_ad,0	;startup code to enable %status AD bit ; -- End function
