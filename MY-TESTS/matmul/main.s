	.option	%reg
	.off	assume_short
	.file	"main.c"
	.globl	a
	.size	a, 4356
	.type	a,@object
	.globl	b
	.size	b, 4356
	.type	b,@object
	.globl	c
	.size	c, 4356
	.type	c,@object
	.size	.L.str.4, 15
	.type	.L.str.4,@object
	.size	.L.str.2, 23
	.type	.L.str.2,@object
	.size	.Lstr, 26
	.type	.Lstr,@object
	.size	.L.str, 29
	.type	.L.str,@object
	.size	.L.str.3, 51
	.type	.L.str.3,@object
	.size	.L.str.6, 55
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
a:                                      ; @0x0
	.skip	4356
	.align	4
b:                                      ; @0x1104
	.skip	4356
	.align	4
c:                                      ; @0x2208
	.skip	4356
	.section	.rodata,"a",@progbits
.L.str.4:                               ; @0x0
	.asciz	"Speedup: %.2f\n"
.L.str.2:                               ; @0xf
	.asciz	"Vettorizzo su %d lane\n"
.Lstr:                                  ; @0x26
	.asciz	"Versione autovettorizzata"
.L.str:                                 ; @0x40
	.asciz	"Tempo di esecuzione: %.2fms\n"
.L.str.3:                               ; @0x5d
	.asciz	"Tempo di esecuzione di vectorized_vec_sum: %.2fms\n"
.L.str.6:                               ; @0x90
	.asciz	"Tempo di esecuzione di autovectorized_vec_sum: %.2fms\n"
	.text
	.global	.CC_I
	.equ	.CC_I, 0
	.ident	"LLVM 17.0.7/V-2024.06. (build 008) (LLVM 17.0.7) -arcv2hs -core4 -Xcode_density -Xatomic -Xll64 -Xunaligned -Xdiv_rem=radix4 -Xswap -Xbitscan -Xmpy_option=mpyd -Xshift_assist -Xbarrel_shifter -Xfpud_div -Xfpu_mac -Xtimer0 -Xrtc -Xstack_check -Xstu=4 -Xvdsp4 -Xvec_unit_rev_minor=1 -Xvec_width=512 -Xvec_mem_size=128k -Xvec_mem_bank_width=16 -Xvec_max_fetch_size=16 -Xvec_num_slots=3 -Xvec_super_with_scalar -Xvec_regs=32 -Xvec_fpu=32 -Xvec_fpu_math=3 -Xvec_fpu_2nd_mul -Xvec_fpu_types=2 -Xvec_num_rd_ports=6 -Xvec_num_acc=8 -Xvec_num_mpy=2 -Xvec_mpy32 -Xvec_num_alu=3 -Xvec_guard_bit_option=0 -Xvec_stack_check -Hvdsp_vector_c -O2 -fvectorize -fslp-vectorize -ffast-math"
	.align	8                               ; -- Begin function main
main:                                   ; @main
                                        ; @0x0
.Lmain$local:                           ; @0x0
	.cfa_bf	.Lmain$local
;  %bb.0:                               ; %entry
	add2	%sp,%sp,-4408/4                 ; @0x0
	.cfa_push	4408                    ; @0x4
	st	%r13,[%sp,0]                    ; @0x4
	.cfa_reg_offset	{%r13}, 0               ; @0x8
	std	%r14,[%sp,4]                    ; @0x8
	.cfa_reg_offset	{%r14}, 4               ; @0xc
	.cfa_reg_offset	{%r15}, 8               ; @0xc
	std	%r16,[%sp,12]                   ; @0xc
	.cfa_reg_offset	{%r16}, 12              ; @0x10
	.cfa_reg_offset	{%r17}, 16              ; @0x10
	std	%r18,[%sp,20]                   ; @0x10
	.cfa_reg_offset	{%r18}, 20              ; @0x14
	.cfa_reg_offset	{%r19}, 24              ; @0x14
	std	%r20,[%sp,28]                   ; @0x14
	.cfa_reg_offset	{%r20}, 28              ; @0x18
	.cfa_reg_offset	{%r21}, 32              ; @0x18
	std	%r22,[%sp,36]                   ; @0x18
	.cfa_reg_offset	{%r22}, 36              ; @0x1c
	.cfa_reg_offset	{%r23}, 40              ; @0x1c
	st	%r24,[%sp,44]                   ; @0x1c
	.cfa_reg_offset	{%r24}, 44              ; @0x20
	st	%blink,[%sp,48]                 ; @0x20
	.cfa_reg_offset	{%blink}, 48            ; @0x24
	mov_s	%r23,a                          ; @0x24
	mov_s	%r0,%r23                        ; @0x2a
	mov_s	%r1,33                          ; @0x2c
	mov_s	%r2,33                          ; @0x2e
	mov_s	%r3,1                           ; @0x30
	bl	init_matrix                     ; @0x32
	mov_s	%r24,b                          ; @0x36
	mov_s	%r0,%r24                        ; @0x3c
	mov_s	%r1,33                          ; @0x3e
	mov_s	%r2,33                          ; @0x40
	mov_s	%r3,1                           ; @0x42
	bl	init_matrix                     ; @0x44
	mov_s	%r15,c                          ; @0x48
	mov_s	%r0,%r15                        ; @0x4e
	mov_s	%r1,33                          ; @0x50
	mov_s	%r2,33                          ; @0x52
	mov_s	%r3,0                           ; @0x54
	bl	init_matrix                     ; @0x56
	bl	clock                           ; @0x5a
	mov_s	%r3,33                          ; @0x5e
	mov_s	%r13,%r0                        ; @0x60
	mov_s	%r0,%r23                        ; @0x62
	mov_s	%r1,%r24                        ; @0x64
	mov_s	%r2,%r15                        ; @0x66
	mov_s	%r4,%r3                         ; @0x68
	mov_s	%r5,%r3                         ; @0x6a
	bl	matmul                          ; @0x6c
	mov_s	%r18,0                          ; @0x70
	mov_s	%r19,0x408f4000@u32             ; @0x72
	bl	clock                           ; @0x78
	sub_s	%r0,%r0,%r13                    ; @0x7c
	fint2d	%r2,%r0                         ; @0x7e
	fdmul	%r20,%r2,%r18                   ; @0x82
	bl	_timer_clocks_per_sec           ; @0x86
	fuint2d	%r2,%r0                         ; @0x8a
	fddiv	%r20,%r20,%r2                   ; @0x8e
	mov_s	%r22,.L.str                     ; @0x92
	mov_s	%r0,%r22                        ; @0x98
	mov_s	%r1,%r20                        ; @0x9a
	mov_s	%r2,%r21                        ; @0x9c
	bl	printf                          ; @0x9e
	mov_s	%r0,%r15                        ; @0xa2
	mov_s	%r1,33                          ; @0xa4
	mov_s	%r2,33                          ; @0xa6
	bl	print_matrix                    ; @0xa8
	mov_s	%r1,%r15                        ; @0xac
	add_s	%r0,%sp,52                      ; @0xae
	mov_s	%r2,33                          ; @0xb0
	mov_s	%r3,33                          ; @0xb2
	bl	copy_matrix                     ; @0xb4
	mov_s	%r0,10                          ; @0xb8
	bl	putchar                         ; @0xba
	sub	%r0,%r22,.L.str-.L.str.2        ; @0xbe
	mov_s	%r1,16                          ; @0xc2
	bl	printf                          ; @0xc4
	mov_s	%r0,%r15                        ; @0xc8
	mov_s	%r1,33                          ; @0xca
	mov_s	%r2,33                          ; @0xcc
	mov_s	%r3,0                           ; @0xce
	bl.d	init_matrix                     ; @0xd0
	nop                                     ; inserted to benefit BPU
                                        ; @0xd4
	bl	clock                           ; @0xd8
	mov_s	%r3,33                          ; @0xdc
	mov_s	%r13,%r0                        ; @0xde
	mov_s	%r0,%r23                        ; @0xe0
	mov_s	%r1,%r24                        ; @0xe2
	mov_s	%r2,%r15                        ; @0xe4
	mov_s	%r4,%r3                         ; @0xe6
	mov	%r5,%r3                         ; widened to benefit BPU
                                        ; @0xe8
	bl	vectorized_matmul               ; @0xec
	bl	clock                           ; @0xf0
	sub_s	%r0,%r0,%r13                    ; @0xf4
	fint2d	%r2,%r0                         ; @0xf6
	fdmul	%r16,%r2,%r18                   ; @0xfa
	bl	_timer_clocks_per_sec           ; @0xfe
	fuint2d	%r2,%r0                         ; @0x102
	fddiv	%r16,%r16,%r2                   ; @0x106
	add	%r0,%r22,.L.str.3-.L.str        ; @0x10a
	mov_s	%r1,%r16                        ; @0x10e
	mov_s	%r2,%r17                        ; @0x110
	bl	printf                          ; @0x112
	fddiv	%r2,%r20,%r16                   ; @0x116
	sub1	%r13,%r22,(.L.str-.L.str.4)/2   ; @0x11a
	mov_s	%r0,%r13                        ; @0x11e
	mov_s	%r1,%r2                         ; @0x120
	mov_s	%r2,%r3                         ; @0x122
	bl	printf                          ; @0x124
	mov_s	%r0,%r15                        ; @0x128
	mov_s	%r1,33                          ; @0x12a
	mov_s	%r2,33                          ; @0x12c
	bl	print_matrix                    ; @0x12e
	mov_s	%r1,%r15                        ; @0x132
	add_s	%r0,%sp,52                      ; @0x134
	mov_s	%r2,33                          ; @0x136
	mov_s	%r3,33                          ; @0x138
	bl	check_result                    ; @0x13a
	mov_s	%r0,10                          ; @0x13e
	bl	putchar                         ; @0x140
	sub	%r0,%r22,.L.str-.Lstr           ; @0x144
	bl	puts                            ; @0x148
	mov_s	%r0,%r15                        ; @0x14c
	mov_s	%r1,33                          ; @0x14e
	mov_s	%r2,33                          ; @0x150
	mov_s	%r3,0                           ; @0x152
	bl	init_matrix                     ; @0x154
	bl	clock                           ; @0x158
	mov_s	%r3,33                          ; @0x15c
	mov_s	%r14,%r0                        ; @0x15e
	mov_s	%r0,%r23                        ; @0x160
	mov_s	%r1,%r24                        ; @0x162
	mov_s	%r2,%r15                        ; @0x164
	mov_s	%r4,%r3                         ; @0x166
	mov	%r5,%r3                         ; widened to benefit BPU
                                        ; @0x168
	bl	autovectorized_matmul           ; @0x16c
	bl	clock                           ; @0x170
	sub_s	%r0,%r0,%r14                    ; @0x174
	fint2d	%r2,%r0                         ; @0x176
	fdmul	%r16,%r2,%r18                   ; @0x17a
	bl	_timer_clocks_per_sec           ; @0x17e
	fuint2d	%r2,%r0                         ; @0x182
	fddiv	%r16,%r16,%r2                   ; @0x186
	add1	%r0,%r22,(.L.str.6-.L.str)/2    ; @0x18a
	mov_s	%r1,%r16                        ; @0x18e
	mov_s	%r2,%r17                        ; @0x190
	bl	printf                          ; @0x192
	fddiv	%r2,%r20,%r16                   ; @0x196
	mov_s	%r0,%r13                        ; @0x19a
	mov_s	%r1,%r2                         ; @0x19c
	mov_s	%r2,%r3                         ; @0x19e
	bl	printf                          ; @0x1a0
	mov_s	%r0,%r15                        ; @0x1a4
	mov_s	%r1,33                          ; @0x1a6
	mov_s	%r2,33                          ; @0x1a8
	bl	print_matrix                    ; @0x1aa
	mov_s	%r0,0                           ; @0x1ae
	ld	%blink,[%sp,48]                 ; @0x1b0
	.cfa_restore	{%blink}                ; @0x1b4
	ld	%r24,[%sp,44]                   ; @0x1b4
	.cfa_restore	{%r24}                  ; @0x1b8
	ldd	%r22,[%sp,36]                   ; @0x1b8
	.cfa_restore	{%r23}                  ; @0x1bc
	.cfa_restore	{%r22}                  ; @0x1bc
	ldd	%r20,[%sp,28]                   ; @0x1bc
	.cfa_restore	{%r21}                  ; @0x1c0
	.cfa_restore	{%r20}                  ; @0x1c0
	ldd	%r18,[%sp,20]                   ; @0x1c0
	.cfa_restore	{%r19}                  ; @0x1c4
	.cfa_restore	{%r18}                  ; @0x1c4
	ldd	%r16,[%sp,12]                   ; @0x1c4
	.cfa_restore	{%r17}                  ; @0x1c8
	.cfa_restore	{%r16}                  ; @0x1c8
	ldd	%r14,[%sp,4]                    ; @0x1c8
	.cfa_restore	{%r15}                  ; @0x1cc
	.cfa_restore	{%r14}                  ; @0x1cc
	ld_s	%r13,[%sp,0]                    ; @0x1cc
	.cfa_restore	{%r13}                  ; @0x1ce
	add2	%sp,%sp,4408/4                  ; @0x1ce
	.cfa_pop	4408                            ; @0x1d2
	j_s	[%blink]                        ; @0x1d2
	.cfa_ef
.Lfunc_end0:                            ; @0x1d4

	.reloc	_init_ad,0	;startup code to enable %status AD bit ; -- End function
