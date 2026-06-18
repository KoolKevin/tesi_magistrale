	.option	%reg
	.off	assume_short
	.file	"main.c"
	.size	.L.str.3, 14
	.type	.L.str.3,@object
	.size	.Lstr.10, 42
	.type	.Lstr.10,@object
	.size	.L.str.7, 15
	.type	.L.str.7,@object
	.size	.Lstr.9, 26
	.type	.Lstr.9,@object
	.size	.L.str.1, 29
	.type	.L.str.1,@object
	.size	.Lstr, 39
	.type	.Lstr,@object
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
	.section	.rodata,"a",@progbits
.L.str.3:                               ; @0x0
	.asciz	"c[%d, %d]=%d\n"
.Lstr.10:                               ; @0xe
	.asciz	"Primi 5 elementi della matrice risultato:"
.L.str.7:                               ; @0x38
	.asciz	"Speedup: %.2f\n"
.Lstr.9:                                ; @0x47
	.asciz	"Versione autovettorizzata"
.L.str.1:                               ; @0x61
	.asciz	"Tempo di esecuzione: %.2fms\n"
.Lstr:                                  ; @0x7e
	.asciz	"Errore nell'allocazione della memoria."
.L.str.6:                               ; @0xa5
	.asciz	"Tempo di esecuzione di autovectorized_vec_sum: %.2fms\n"
	.text
	.global	.CC_I
	.equ	.CC_I, 0
	.ident	"LLVM 17.0.7/V-2024.06. (build 008) (LLVM 17.0.7) -arcv2hs -core4 -Xcode_density -Xatomic -Xll64 -Xunaligned -Xdiv_rem=radix4 -Xswap -Xbitscan -Xmpy_option=mpyd -Xshift_assist -Xbarrel_shifter -Xfpud_div -Xfpu_mac -Xtimer0 -Xrtc -Xstack_check -Xstu=4 -Xvdsp4 -Xvec_unit_rev_minor=1 -Xvec_width=512 -Xvec_mem_size=128k -Xvec_mem_bank_width=16 -Xvec_max_fetch_size=16 -Xvec_num_slots=3 -Xvec_super_with_scalar -Xvec_regs=32 -Xvec_fpu=32 -Xvec_fpu_math=3 -Xvec_fpu_2nd_mul -Xvec_fpu_types=2 -Xvec_num_rd_ports=6 -Xvec_num_acc=8 -Xvec_num_mpy=2 -Xvec_mpy32 -Xvec_num_alu=3 -Xvec_guard_bit_option=0 -Xvec_stack_check -Hvdsp_vector_c -O1 -fvectorize -fslp-vectorize -ffast-math"
	.align	4                               ; -- Begin function main
main:                                   ; @main
                                        ; @0x0
.Lmain$local:                           ; @0x0
	.cfa_bf	.Lmain$local
;  %bb.0:                               ; %entry
	sub_s	%sp,%sp,52                      ; @0x0
	.cfa_push	52                      ; @0x2
	st	%r13,[%sp,0]                    ; @0x2
	.cfa_reg_offset	{%r13}, 0               ; @0x6
	std	%r14,[%sp,4]                    ; @0x6
	.cfa_reg_offset	{%r14}, 4               ; @0xa
	.cfa_reg_offset	{%r15}, 8               ; @0xa
	std	%r16,[%sp,12]                   ; @0xa
	.cfa_reg_offset	{%r16}, 12              ; @0xe
	.cfa_reg_offset	{%r17}, 16              ; @0xe
	std	%r18,[%sp,20]                   ; @0xe
	.cfa_reg_offset	{%r18}, 20              ; @0x12
	.cfa_reg_offset	{%r19}, 24              ; @0x12
	std	%r20,[%sp,28]                   ; @0x12
	.cfa_reg_offset	{%r20}, 28              ; @0x16
	.cfa_reg_offset	{%r21}, 32              ; @0x16
	st	%r22,[%sp,36]                   ; @0x16
	.cfa_reg_offset	{%r22}, 36              ; @0x1a
	st	%blink,[%sp,40]                 ; @0x1a
	.cfa_reg_offset	{%blink}, 40            ; @0x1e
	sub2	%r56,%r56,4352/4                ; @0x1e
	add3	%r0,%r56,256/8                  ; @0x22
	cmp_s	%r0,0                           ; @0x26
	mov_s	%r22,.L.str.7                   ; @0x28
	beq_s	.LBB0_3                         ; @0x2e
;  %bb.1:                               ; %entry
	add2	%r0,%r56,128/4                  ; @0x30
	cmp_s	%r0,0                           ; @0x34
	beq_s	.LBB0_3                         ; @0x36
;  %bb.2:                               ; %entry
	add	%r14,%r56,0                     ; @0x38
	cmp_s	%r14,0                          ; @0x3c
	beq_s	.LBB0_3                         ; @0x3e
;  %bb.4:                               ; %if.end
	add3	%r0,%r56,256/8                  ; @0x40
	mov_s	%r1,32                          ; @0x44
	mov_s	%r2,32                          ; @0x46
	mov_s	%r3,1                           ; @0x48
	bl	init_matrix                     ; @0x4a
	add2	%r0,%r56,128/4                  ; @0x4e
	mov_s	%r1,32                          ; @0x52
	mov_s	%r2,1                           ; @0x54
	mov_s	%r3,1                           ; @0x56
	bl	init_matrix                     ; @0x58
	add	%r0,%r56,0                      ; @0x5c
	mov_s	%r1,32                          ; @0x60
	mov_s	%r2,1                           ; @0x62
	mov_s	%r3,0                           ; @0x64
	mov_s	%r18,0                          ; @0x66
	bl	init_matrix                     ; @0x68
	bl	clock                           ; @0x6c
	mov_s	%r15,%r0                        ; @0x70
	add3	%r0,%r56,256/8                  ; @0x72
	add2	%r1,%r56,128/4                  ; @0x76
	mov_s	%r3,32                          ; @0x7a
	add	%r2,%r56,0                      ; @0x7c
	mov_s	%r4,1                           ; @0x80
	mov_s	%r5,%r3                         ; @0x82
	bl	matmul                          ; @0x84
	mov_s	%r19,0x408f4000@u32             ; @0x88
	bl	clock                           ; @0x8e
	sub_s	%r0,%r0,%r15                    ; @0x92
	fint2d	%r2,%r0                         ; @0x94
	fdmul	%r16,%r2,%r18                   ; @0x98
	bl	_timer_clocks_per_sec           ; @0x9c
	fuint2d	%r2,%r0                         ; @0xa0
	fddiv	%r2,%r16,%r2                    ; @0xa4
	add	%r0,%r22,.L.str.1-.L.str.7      ; @0xa8
	mov_s	%r1,%r2                         ; @0xac
	std	%r2,[%sp,44]                    ; 8-byte Folded Spill
                                        ; @0xae
	mov_s	%r2,%r3                         ; @0xb2
	bl	printf                          ; @0xb4
	sub	%r16,%r22,.L.str.7-.Lstr.10     ; @0xb8
	mov_s	%r0,%r16                        ; @0xbc
	bl	puts                            ; @0xbe
	sub	%r17,%r22,.L.str.7-.L.str.3     ; @0xc2
	add	%r13,%r56,0                     ; @0xc6
	mov_s	%r15,%r18                       ; @0xca
.LBB0_5:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0xcc
	ld_s	%r3,[%r13,0]                    ; @0xcc
	mov_s	%r0,%r17                        ; @0xce
	mov_s	%r1,%r15                        ; @0xd0
	mov_s	%r2,0                           ; @0xd2
	bl	printf                          ; @0xd4
	add_s	%r13,%r13,4                     ; @0xd8
	add_s	%r15,%r15,1                     ; @0xda
	brlo	%r15,5,.LBB0_5                  ; @0xdc
;  %bb.6:                               ; %for.cond.cleanup
	mov_s	%r0,10                          ; @0xe0
	bl	putchar                         ; @0xe2
	add	%r0,%r22,.Lstr.9-.L.str.7       ; @0xe6
	bl	puts                            ; @0xea
	add	%r0,%r56,0                      ; @0xee
	mov_s	%r1,32                          ; @0xf2
	mov_s	%r2,1                           ; @0xf4
	mov_s	%r3,0                           ; @0xf6
	bl	init_matrix                     ; @0xf8
	bl	clock                           ; @0xfc
	mov_s	%r15,%r0                        ; @0x100
	add3	%r0,%r56,256/8                  ; @0x102
	add2	%r1,%r56,128/4                  ; @0x106
	mov_s	%r3,32                          ; @0x10a
	add	%r2,%r56,0                      ; @0x10c
	mov_s	%r4,1                           ; @0x110
	mov_s	%r5,%r3                         ; @0x112
	bl	autovectorized_matmul           ; @0x114
	bl	clock                           ; @0x118
	sub_s	%r0,%r0,%r15                    ; @0x11c
	fint2d	%r2,%r0                         ; @0x11e
	fdmul	%r20,%r2,%r18                   ; @0x122
	bl	_timer_clocks_per_sec           ; @0x126
	fuint2d	%r2,%r0                         ; @0x12a
	fddiv	%r20,%r20,%r2                   ; @0x12e
	mov_s	%r0,.L.str.6                    ; @0x132
	mov_s	%r1,%r20                        ; @0x138
	mov_s	%r2,%r21                        ; @0x13a
	bl	printf                          ; @0x13c
	ldd	%r2,[%sp,44]                    ; 8-byte Folded Reload
                                        ; @0x140
	mov_s	%r0,%r22                        ; @0x144
	fddiv	%r2,%r2,%r20                    ; @0x146
	mov_s	%r1,%r2                         ; @0x14a
	mov_s	%r2,%r3                         ; @0x14c
	bl	printf                          ; @0x14e
	mov_s	%r0,%r16                        ; @0x152
	bl	puts                            ; @0x154
	mov_s	%r13,0                          ; @0x158
.LBB0_7:                                ; %for.body32
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x15a
	ld_s	%r3,[%r14,0]                    ; @0x15a
	mov_s	%r0,%r17                        ; @0x15c
	mov_s	%r1,%r18                        ; @0x15e
	mov_s	%r2,0                           ; @0x160
	bl	printf                          ; @0x162
	add_s	%r14,%r14,4                     ; @0x166
	add_s	%r18,%r18,1                     ; @0x168
	brlo	%r18,5,.LBB0_7                  ; @0x16a
	b_s	.LBB0_8                         ; @0x16e
.LBB0_3:                                ; %if.then
                                        ; @0x170
	add	%r22,%r22,.Lstr-.L.str.7        ; @0x170
	mov_s	%r0,%r22                        ; @0x174
	bl	puts                            ; @0x176
	mov_s	%r13,1                          ; @0x17a
.LBB0_8:                                ; %cleanup
                                        ; @0x17c
	mov_s	%r0,%r13                        ; @0x17c
	add2	%r56,%r56,4352/4                ; @0x17e
	ld	%blink,[%sp,40]                 ; @0x182
	.cfa_restore	{%blink}                ; @0x186
	ld	%r22,[%sp,36]                   ; @0x186
	.cfa_restore	{%r22}                  ; @0x18a
	ldd	%r20,[%sp,28]                   ; @0x18a
	.cfa_restore	{%r21}                  ; @0x18e
	.cfa_restore	{%r20}                  ; @0x18e
	ldd	%r18,[%sp,20]                   ; @0x18e
	.cfa_restore	{%r19}                  ; @0x192
	.cfa_restore	{%r18}                  ; @0x192
	ldd	%r16,[%sp,12]                   ; @0x192
	.cfa_restore	{%r17}                  ; @0x196
	.cfa_restore	{%r16}                  ; @0x196
	ldd	%r14,[%sp,4]                    ; @0x196
	.cfa_restore	{%r15}                  ; @0x19a
	.cfa_restore	{%r14}                  ; @0x19a
	ld_s	%r13,[%sp,0]                    ; @0x19a
	.cfa_restore	{%r13}                  ; @0x19c
	add_s	%sp,%sp,52                      ; @0x19c
	.cfa_pop	52                              ; @0x19e
	j_s	[%blink]                        ; @0x19e
	.cfa_ef
.Lfunc_end0:                            ; @0x1a0

	.reloc	_init_ad,0	;startup code to enable %status AD bit ; -- End function
