	.option	%reg
	.off	assume_short
	.file	"main.c"
	.size	.L.str.2, 15
	.type	.L.str.2,@object
	.size	.L.str.6, 15
	.type	.L.str.6,@object
	.size	.L.str.8, 47
	.type	.L.str.8,@object
	.size	.L.str.4, 23
	.type	.L.str.4,@object
	.size	.Lstr.10, 26
	.type	.Lstr.10,@object
	.size	.Lstr.11, 27
	.type	.Lstr.11,@object
	.size	.L.str.1, 29
	.type	.L.str.1,@object
	.size	.Lstr, 39
	.type	.Lstr,@object
	.size	.L.str.5, 40
	.type	.L.str.5,@object
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
.L.str.2:                               ; @0x0
	.asciz	"Risultato: %d\n"
.L.str.6:                               ; @0xf
	.asciz	"Speedup: %.2f\n"
.L.str.8:                               ; @0x1e
	.asciz	"Tempo di esecuzione di autovectorized: %.2fms\n"
.L.str.4:                               ; @0x4d
	.asciz	"Vettorizzo su %d lane\n"
.Lstr.10:                               ; @0x64
	.asciz	"Versione autovettorizzata"
.Lstr.11:                               ; @0x7e
	.asciz	"Versione vekt-vettorizzata"
.L.str.1:                               ; @0x99
	.asciz	"Tempo di esecuzione: %.2fms\n"
.Lstr:                                  ; @0xb6
	.asciz	"Errore nell'allocazione della memoria."
.L.str.5:                               ; @0xdd
	.asciz	"Tempo di esecuzione vectorized: %.2fms\n"
	.text
	.global	.CC_I
	.equ	.CC_I, 0
	.ident	"LLVM 17.0.7/V-2024.06. (build 008) (LLVM 17.0.7) -arcv2hs -core4 -Xcode_density -Xatomic -Xll64 -Xunaligned -Xdiv_rem=radix4 -Xswap -Xbitscan -Xmpy_option=mpyd -Xshift_assist -Xbarrel_shifter -Xfpud_div -Xfpu_mac -Xtimer0 -Xrtc -Xstack_check -Xstu=4 -Xvdsp4 -Xvec_unit_rev_minor=1 -Xvec_width=512 -Xvec_mem_size=128k -Xvec_mem_bank_width=16 -Xvec_max_fetch_size=16 -Xvec_num_slots=3 -Xvec_super_with_scalar -Xvec_regs=32 -Xvec_fpu=32 -Xvec_fpu_math=3 -Xvec_fpu_2nd_mul -Xvec_fpu_types=2 -Xvec_num_rd_ports=6 -Xvec_num_acc=8 -Xvec_num_mpy=2 -Xvec_mpy32 -Xvec_num_alu=3 -Xvec_guard_bit_option=0 -Xvec_stack_check -Hvdsp_vector_c -O2 -fno-unroll-loops -fvectorize -fslp-vectorize -ffast-math"
	.align	8                               ; -- Begin function main
main:                                   ; @main
                                        ; @0x0
.Lmain$local:                           ; @0x0
	.cfa_bf	.Lmain$local
;  %bb.0:                               ; %entry
	st.aw	%r13,[%sp,-48]                  ; @0x0
	.cfa_push	48                      ; @0x4
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
	st	%blink,[%sp,44]                 ; @0x18
	.cfa_reg_offset	{%blink}, 44            ; @0x1c
	sub3	%r56,%r56,8192/8                ; @0x1c
	add	%r0,%r56,0x1000@u32             ; @0x20
	cmp_s	%r0,0                           ; @0x28
	add	%r1,%r56,0                      ; @0x2a
	mov_s	%r17,.L.str.1                   ; Predicate Case 4
                                        ; @0x2e
	cmp.ne	%r1,0                           ; @0x34
	beq_s	.LBB0_4                         ; Predicate Case 4
                                        ; @0x38
;  %bb.2:                               ; %vector.body.preheader
	; Implicit def %r3                      ; @0x3a
.vvsbundle  "v1sc" 
 ;	 { 
	vvci.w	%vr0                            ; @0x3a
	mov	%lp_count,64                    ; @0x3a
 ;	 }
	add	%r1,%r56,0                      ; @0x42
	lp	.LZD0                           ; @0x46
.LBB0_3:                                ; %vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x4a
	vvst.av.w	%vr0,%r1,1              ; @0x4a
.vvsbundle  " v2" 
 ;	 { 
	vvst.av.w	%vr0,%r0,1              ; @0x50
	vvadd.w	%vr0, %vr0, 16                  ; @0x50
 ;	 }
.LZD0:                                  ; @0x58
	; ZD Loop End                           ; @0x58
;  %bb.5:                               ; %for.cond.cleanup
	nop                                     ; inserted to benefit BPU
                                        ; @0x58
	nop                                     ; inserted to benefit BPU
                                        ; @0x5c
	bl	clock                           ; @0x60
	mov_s	%r13,%r0                        ; @0x64
	add	%r0,%r56,0x1000@u32             ; @0x66
	add	%r1,%r56,0                      ; @0x6e
	mov	%r2,1024                        ; @0x72
	bl	dotp                            ; @0x76
	mov_s	%r16,%r0                        ; @0x7a
	mov_s	%r15,0x408f4000@u32             ; @0x7c
	mov_s	%r14,0                          ; @0x82
	bl	clock                           ; @0x84
	sub_s	%r0,%r0,%r13                    ; @0x88
	fint2d	%r2,%r0                         ; @0x8a
	fdmul	%r18,%r2,%r14                   ; @0x8e
	bl	_timer_clocks_per_sec           ; @0x92
	fuint2d	%r2,%r0                         ; @0x96
	fddiv	%r20,%r18,%r2                   ; @0x9a
	mov_s	%r0,%r17                        ; @0x9e
	mov_s	%r1,%r20                        ; @0xa0
	mov_s	%r2,%r21                        ; @0xa2
	bl	printf                          ; @0xa4
	mov_s	%r19,.L.str.8                   ; @0xa8
	mov_s	%r1,%r16                        ; @0xae
	sub	%r16,%r19,.L.str.8-.L.str.2     ; @0xb0
	mov_s	%r0,%r16                        ; @0xb4
	bl	printf                          ; @0xb6
	mov_s	%r0,10                          ; @0xba
	bl	putchar                         ; @0xbc
	add	%r0,%r19,.L.str.4-.L.str.8      ; @0xc0
	mov_s	%r1,16                          ; @0xc4
	bl	printf                          ; @0xc6
	bl	clock                           ; @0xca
	mov_s	%r13,%r0                        ; @0xce
	add	%r0,%r56,0x1000@u32             ; @0xd0
	add	%r1,%r56,0                      ; @0xd8
	mov	%r2,1024                        ; @0xdc
	bl	vectorized_dotp                 ; @0xe0
	mov	%r18,%r0                        ; widened to benefit BPU
                                        ; @0xe4
	bl	clock                           ; @0xe8
	sub_s	%r0,%r0,%r13                    ; @0xec
	fint2d	%r2,%r0                         ; @0xee
	fdmul	%r22,%r2,%r14                   ; @0xf2
	bl	_timer_clocks_per_sec           ; @0xf6
	fuint2d	%r2,%r0                         ; @0xfa
	fddiv	%r22,%r22,%r2                   ; @0xfe
	add1	%r0,%r17,(.L.str.5-.L.str.1)/2  ; @0x102
	mov_s	%r1,%r22                        ; @0x106
	mov_s	%r2,%r23                        ; @0x108
	bl	printf                          ; @0x10a
	fddiv	%r2,%r20,%r22                   ; @0x10e
	sub	%r17,%r19,.L.str.8-.L.str.6     ; @0x112
	mov_s	%r0,%r17                        ; @0x116
	mov_s	%r1,%r2                         ; @0x118
	mov_s	%r2,%r3                         ; @0x11a
	bl	printf                          ; @0x11c
	mov_s	%r0,%r16                        ; @0x120
	mov_s	%r1,%r18                        ; @0x122
	bl	printf                          ; @0x124
	mov_s	%r0,10                          ; @0x128
	bl	putchar                         ; @0x12a
	mov_s	%r0,%r19                        ; @0x12e
	add	%r0,%r0,.Lstr.10-.L.str.8       ; @0x130
	bl	puts                            ; @0x134
	bl	clock                           ; @0x138
	mov_s	%r13,%r0                        ; @0x13c
	add	%r0,%r56,0x1000@u32             ; @0x13e
	add	%r1,%r56,0                      ; @0x146
	mov	%r2,1024                        ; @0x14a
	bl	autovectorized_dotp             ; @0x14e
	mov_s	%r18,%r0                        ; @0x152
	bl	clock                           ; @0x154
	sub_s	%r0,%r0,%r13                    ; @0x158
	fint2d	%r2,%r0                         ; @0x15a
	fdmul	%r22,%r2,%r14                   ; @0x15e
	bl	_timer_clocks_per_sec           ; @0x162
	fuint2d	%r2,%r0                         ; @0x166
	fddiv	%r22,%r22,%r2                   ; @0x16a
	mov_s	%r0,%r19                        ; @0x16e
	mov_s	%r1,%r22                        ; @0x170
	mov_s	%r2,%r23                        ; @0x172
	bl	printf                          ; @0x174
	fddiv	%r2,%r20,%r22                   ; @0x178
	mov_s	%r0,%r17                        ; @0x17c
	mov_s	%r1,%r2                         ; @0x17e
	mov_s	%r2,%r3                         ; @0x180
	bl	printf                          ; @0x182
	mov_s	%r0,%r16                        ; @0x186
	mov_s	%r1,%r18                        ; @0x188
	bl	printf                          ; @0x18a
	mov_s	%r0,10                          ; @0x18e
	bl	putchar                         ; @0x190
	add1	%r0,%r19,(.Lstr.11-.L.str.8)/2  ; @0x194
	bl.d	puts                            ; @0x198
	nop                                     ; inserted to benefit BPU
                                        ; @0x19c
	bl	clock                           ; @0x1a0
	mov_s	%r13,%r0                        ; @0x1a4
	add	%r0,%r56,0x1000@u32             ; @0x1a6
	add	%r1,%r56,0                      ; @0x1ae
	mov	%r2,1024                        ; @0x1b2
	bl	vekt_dotp_wrapper               ; @0x1b6
	mov_s	%r18,%r0                        ; @0x1ba
	bl	clock                           ; @0x1bc
	sub_s	%r0,%r0,%r13                    ; @0x1c0
	fint2d	%r2,%r0                         ; @0x1c2
	fdmul	%r22,%r2,%r14                   ; @0x1c6
	bl	_timer_clocks_per_sec           ; @0x1ca
	fuint2d	%r2,%r0                         ; @0x1ce
	fddiv	%r22,%r22,%r2                   ; @0x1d2
	mov_s	%r0,%r19                        ; @0x1d6
	mov_s	%r1,%r22                        ; @0x1d8
	mov_s	%r2,%r23                        ; @0x1da
	bl	printf                          ; @0x1dc
	fddiv	%r2,%r20,%r22                   ; @0x1e0
	mov_s	%r0,%r17                        ; @0x1e4
	mov_s	%r1,%r2                         ; @0x1e6
	mov_s	%r2,%r3                         ; @0x1e8
	bl	printf                          ; @0x1ea
	mov_s	%r0,%r16                        ; @0x1ee
	mov_s	%r1,%r18                        ; @0x1f0
	bl	printf                          ; @0x1f2
	mov_s	%r0,10                          ; @0x1f6
	bl.d	putchar                         ; @0x1f8
	nop                                     ; inserted to benefit BPU
                                        ; @0x1fc
	b	.LBB0_6                         ; widened to benefit BPU
                                        ; @0x200
.LBB0_4:                                ; %if.then
                                        ; @0x204
	add	%r0,%r17,.Lstr-.L.str.1         ; @0x204
	bl	puts                            ; @0x208
	mov_s	%r14,1                          ; @0x20c
.LBB0_6:                                ; %cleanup
                                        ; @0x20e
	mov_s	%r0,%r14                        ; @0x20e
	add3	%r56,%r56,8192/8                ; @0x210
	ld	%blink,[%sp,44]                 ; @0x214
	.cfa_restore	{%blink}                ; @0x218
	ldd	%r22,[%sp,36]                   ; @0x218
	.cfa_restore	{%r23}                  ; @0x21c
	.cfa_restore	{%r22}                  ; @0x21c
	ldd	%r20,[%sp,28]                   ; @0x21c
	.cfa_restore	{%r21}                  ; @0x220
	.cfa_restore	{%r20}                  ; @0x220
	ldd	%r18,[%sp,20]                   ; @0x220
	.cfa_restore	{%r19}                  ; @0x224
	.cfa_restore	{%r18}                  ; @0x224
	ldd	%r16,[%sp,12]                   ; @0x224
	.cfa_restore	{%r17}                  ; @0x228
	.cfa_restore	{%r16}                  ; @0x228
	ldd	%r14,[%sp,4]                    ; @0x228
	.cfa_restore	{%r15}                  ; @0x22c
	.cfa_restore	{%r14}                  ; @0x22c
	ld.ab	%r13,[%sp,48]                   ; @0x22c
	.cfa_restore	{%r13}                  ; @0x230
	.cfa_pop	48                              ; @0x230
	j_s	[%blink]                        ; @0x230
	.cfa_ef
.Lfunc_end0:                            ; @0x232

	.reloc	_init_ad,0	;startup code to enable %status AD bit ; -- End function
