	.option	%reg
	.off	assume_short
	.file	"main.c"
	.size	.L.str.4, 15
	.type	.L.str.4,@object
	.size	.L.str.1, 6
	.type	.L.str.1,@object
	.size	.L.str.8, 15
	.type	.L.str.8,@object
	.size	.Lstr.9, 26
	.type	.Lstr.9,@object
	.size	.L.str.3, 29
	.type	.L.str.3,@object
	.size	.Lstr, 39
	.type	.Lstr,@object
	.size	.L.str.7, 47
	.type	.L.str.7,@object
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
.L.str.4:                               ; @0x0
	.asciz	"Risultato: %d\n"
.L.str.1:                               ; @0xf
	.asciz	"hello"
.L.str.8:                               ; @0x15
	.asciz	"Speedup: %.2f\n"
.Lstr.9:                                ; @0x24
	.asciz	"Versione autovettorizzata"
.L.str.3:                               ; @0x3e
	.asciz	"Tempo di esecuzione: %.2fms\n"
.Lstr:                                  ; @0x5b
	.asciz	"Errore nell'allocazione della memoria."
.L.str.7:                               ; @0x82
	.asciz	"Tempo di esecuzione di autovectorized: %.2fms\n"
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
	sub_s	%sp,%sp,48                      ; @0x0
	.cfa_push	48                      ; @0x2
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
	std	%r22,[%sp,36]                   ; @0x16
	.cfa_reg_offset	{%r22}, 36              ; @0x1a
	.cfa_reg_offset	{%r23}, 40              ; @0x1a
	st	%blink,[%sp,44]                 ; @0x1a
	.cfa_reg_offset	{%blink}, 44            ; @0x1e
	sub3	%r56,%r56,8192/8                ; @0x1e
	mov_s	%r16,.L.str.3                   ; @0x22
	sub	%r0,%r16,.L.str.3-.L.str.1      ; @0x28
	bl	puts                            ; @0x2c
	add	%r0,%r56,0x1000@u32             ; @0x30
	cmp	%r0,0                           ; @0x38
	beq	.LBB0_6                         ; @0x3c
;  %bb.1:                               ; %entry
	add	%r1,%r56,0                      ; @0x40
	cmp	%r1,0                           ; @0x44
	beq	.LBB0_6                         ; @0x48
;  %bb.2:                               ; %vector.body.preheader
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr0, 1                        ; @0x4c
	mov_s	%r1,0                           ; @0x4c
 ;	 }
	add	%r2,%r56,0                      ; @0x52
.LBB0_3:                                ; %vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x56
.vvsbundle  "v1sc" 
 ;	 { 
	vvst.av.w	%vr0,%r2,1              ; @0x56
	add_s	%r1,%r1,16                      ; @0x56
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvst.av.w	%vr0,%r0,1              ; @0x5e
	cmp	%r1,1024                        ; @0x5e
 ;	 }
	bne_s	.LBB0_3                         ; @0x68
;  %bb.4:                               ; %for.cond.cleanup
	bl	clock                           ; @0x6a
	mov_s	%r13,%r0                        ; @0x6e
	add	%r0,%r56,0x1000@u32             ; @0x70
	add	%r1,%r56,0                      ; @0x78
	mov	%r2,1024                        ; @0x7c
	bl	dotp                            ; @0x80
	mov_s	%r17,%r0                        ; @0x84
	mov_s	%r15,0x408f4000@u32             ; @0x86
	mov_s	%r14,0                          ; @0x8c
	bl	clock                           ; @0x8e
	sub_s	%r0,%r0,%r13                    ; @0x92
	fint2d	%r2,%r0                         ; @0x94
	fdmul	%r18,%r2,%r14                   ; @0x98
	bl	_timer_clocks_per_sec           ; @0x9c
	fuint2d	%r2,%r0                         ; @0xa0
	fddiv	%r20,%r18,%r2                   ; @0xa4
	mov_s	%r0,%r16                        ; @0xa8
	mov_s	%r1,%r20                        ; @0xaa
	mov_s	%r2,%r21                        ; @0xac
	bl	printf                          ; @0xae
	sub	%r18,%r16,.L.str.3-.L.str.4     ; @0xb2
	mov_s	%r0,%r18                        ; @0xb6
	mov_s	%r1,%r17                        ; @0xb8
	bl	printf                          ; @0xba
	mov_s	%r0,10                          ; @0xbe
	bl	putchar                         ; @0xc0
	mov_s	%r0,10                          ; @0xc4
	bl	putchar                         ; @0xc6
	sub	%r0,%r16,.L.str.3-.Lstr.9       ; @0xca
	bl	puts                            ; @0xce
	bl	clock                           ; @0xd2
	mov_s	%r13,%r0                        ; @0xd6
	add	%r0,%r56,0x1000@u32             ; @0xd8
	add	%r1,%r56,0                      ; @0xe0
	mov	%r2,1024                        ; @0xe4
	bl	autovectorized_dotp             ; @0xe8
	mov_s	%r17,%r0                        ; @0xec
	bl	clock                           ; @0xee
	sub_s	%r0,%r0,%r13                    ; @0xf2
	fint2d	%r2,%r0                         ; @0xf4
	fdmul	%r22,%r2,%r14                   ; @0xf8
	bl	_timer_clocks_per_sec           ; @0xfc
	fuint2d	%r2,%r0                         ; @0x100
	fddiv	%r22,%r22,%r2                   ; @0x104
	add1	%r0,%r16,(.L.str.7-.L.str.3)/2  ; @0x108
	mov_s	%r1,%r22                        ; @0x10c
	mov_s	%r2,%r23                        ; @0x10e
	bl	printf                          ; @0x110
	fddiv	%r2,%r20,%r22                   ; @0x114
	sub	%r0,%r16,.L.str.3-.L.str.8      ; @0x118
	mov_s	%r1,%r2                         ; @0x11c
	mov_s	%r2,%r3                         ; @0x11e
	bl	printf                          ; @0x120
	mov_s	%r0,%r18                        ; @0x124
	mov_s	%r1,%r17                        ; @0x126
	bl	printf                          ; @0x128
	b_s	.LBB0_5                         ; @0x12c
.LBB0_6:                                ; %if.then
                                        ; @0x12e
	add	%r0,%r16,.Lstr-.L.str.3         ; @0x12e
	bl	puts                            ; @0x132
	mov_s	%r14,1                          ; @0x136
.LBB0_5:                                ; %cleanup
                                        ; @0x138
	mov_s	%r0,%r14                        ; @0x138
	add3	%r56,%r56,8192/8                ; @0x13a
	ld	%blink,[%sp,44]                 ; @0x13e
	.cfa_restore	{%blink}                ; @0x142
	ldd	%r22,[%sp,36]                   ; @0x142
	.cfa_restore	{%r23}                  ; @0x146
	.cfa_restore	{%r22}                  ; @0x146
	ldd	%r20,[%sp,28]                   ; @0x146
	.cfa_restore	{%r21}                  ; @0x14a
	.cfa_restore	{%r20}                  ; @0x14a
	ldd	%r18,[%sp,20]                   ; @0x14a
	.cfa_restore	{%r19}                  ; @0x14e
	.cfa_restore	{%r18}                  ; @0x14e
	ldd	%r16,[%sp,12]                   ; @0x14e
	.cfa_restore	{%r17}                  ; @0x152
	.cfa_restore	{%r16}                  ; @0x152
	ldd	%r14,[%sp,4]                    ; @0x152
	.cfa_restore	{%r15}                  ; @0x156
	.cfa_restore	{%r14}                  ; @0x156
	ld_s	%r13,[%sp,0]                    ; @0x156
	.cfa_restore	{%r13}                  ; @0x158
	add_s	%sp,%sp,48                      ; @0x158
	.cfa_pop	48                              ; @0x15a
	j_s	[%blink]                        ; @0x15a
	.cfa_ef
.Lfunc_end0:                            ; @0x15c

	.reloc	_init_ad,0	;startup code to enable %status AD bit ; -- End function
