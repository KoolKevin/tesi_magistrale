	.option	%reg
	.off	assume_short
	.file	"main.c"
	.size	.L.str.4, 15
	.type	.L.str.4,@object
	.size	.L.str.8, 15
	.type	.L.str.8,@object
	.size	.L.str.1, 6
	.type	.L.str.1,@object
	.size	.L.str.6, 23
	.type	.L.str.6,@object
	.size	.Lstr.11, 26
	.type	.Lstr.11,@object
	.size	.L.str.3, 29
	.type	.L.str.3,@object
	.size	.Lstr, 39
	.type	.Lstr,@object
	.size	.L.str.7, 40
	.type	.L.str.7,@object
	.size	.L.str.10, 47
	.type	.L.str.10,@object
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
.L.str.8:                               ; @0xf
	.asciz	"Speedup: %.2f\n"
.L.str.1:                               ; @0x1e
	.asciz	"hello"
.L.str.6:                               ; @0x24
	.asciz	"Vettorizzo su %d lane\n"
.Lstr.11:                               ; @0x3b
	.asciz	"Versione autovettorizzata"
.L.str.3:                               ; @0x55
	.asciz	"Tempo di esecuzione: %.2fms\n"
.Lstr:                                  ; @0x72
	.asciz	"Errore nell'allocazione della memoria."
.L.str.7:                               ; @0x99
	.asciz	"Tempo di esecuzione vectorized: %.2fms\n"
.L.str.10:                              ; @0xc1
	.asciz	"Tempo di esecuzione di autovectorized: %.2fms\n"
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
	mov_s	%r19,.Lstr.11                   ; @0x20
	sub	%r0,%r19,.Lstr.11-.L.str.1      ; @0x26
	bl	puts                            ; @0x2a
	add	%r1,%r56,0x1000@u32             ; @0x2e
	cmp_s	%r1,0                           ; @0x36
	add	%r0,%r56,0                      ; @0x38
	cmp.ne	%r0,0                           ; Predicate Case 4
                                        ; @0x3c
	beq_s	.LBB0_4                         ; Predicate Case 4
                                        ; @0x40
;  %bb.2:                               ; %vector.body.preheader
	; Implicit def %r3                      ; @0x42
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr0, 1                        ; @0x42
	add2	%r0,%r0,192/4                   ; @0x42
 ;	 }
	add2	%r1,%r1,192/4                   ; @0x4a
	mov	%lp_count,8                     ; @0x4e
	lp	.LZD0                           ; @0x52
.LBB0_3:                                ; %vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x56
	vvst.av.w	%vr0,%r1,-1             ; @0x56
	vvst.av.w	%vr0,%r0,-1             ; @0x5c
	vvst.av.w	%vr0,%r1,-1             ; @0x62
	vvst.av.w	%vr0,%r0,-1             ; @0x68
	vvst.av.w	%vr0,%r1,-1             ; @0x6e
	vvst.av.w	%vr0,%r0,-1             ; @0x74
	vvst.av.w	%vr0,%r1,7              ; @0x7a
	vvst.av.w	%vr0,%r0,7              ; @0x80
	vvst.av.w	%vr0,%r1,-1             ; @0x86
	vvst.av.w	%vr0,%r0,-1             ; @0x8c
	vvst.av.w	%vr0,%r1,-1             ; @0x92
	vvst.av.w	%vr0,%r0,-1             ; @0x98
	vvst.av.w	%vr0,%r1,-1             ; @0x9e
	vvst.av.w	%vr0,%r0,-1             ; @0xa4
	vvst.av.w	%vr0,%r1,7              ; @0xaa
	vvst.av.w	%vr0,%r0,7              ; @0xb0
.LZD0:                                  ; @0xb6
	; ZD Loop End                           ; @0xb6
;  %bb.5:                               ; %for.cond.cleanup
	nop_s                                   ; inserted to benefit BPU
                                        ; @0xb6
	bl	clock                           ; @0xb8
	mov_s	%r13,%r0                        ; @0xbc
	add	%r0,%r56,0x1000@u32             ; @0xbe
	add	%r1,%r56,0                      ; @0xc6
	mov	%r2,1024                        ; @0xca
	bl	dotp                            ; @0xce
	mov_s	%r16,%r0                        ; @0xd2
	mov_s	%r15,0x408f4000@u32             ; @0xd4
	mov_s	%r14,0                          ; @0xda
	bl	clock                           ; @0xdc
	sub_s	%r0,%r0,%r13                    ; @0xe0
	fint2d	%r2,%r0                         ; @0xe2
	fdmul	%r20,%r2,%r14                   ; @0xe6
	bl	_timer_clocks_per_sec           ; @0xea
	fuint2d	%r2,%r0                         ; @0xee
	fddiv	%r20,%r20,%r2                   ; @0xf2
	add	%r0,%r19,.L.str.3-.Lstr.11      ; @0xf6
	mov_s	%r1,%r20                        ; @0xfa
	mov_s	%r2,%r21                        ; @0xfc
	bl	printf                          ; @0xfe
	mov_s	%r1,%r16                        ; @0x102
	sub	%r16,%r19,.Lstr.11-.L.str.4     ; @0x104
	mov_s	%r0,%r16                        ; @0x108
	bl	printf                          ; @0x10a
	mov_s	%r0,10                          ; @0x10e
	bl	putchar                         ; @0x110
	sub	%r0,%r19,.Lstr.11-.L.str.6      ; @0x114
	mov	%r1,16                          ; widened to benefit BPU
                                        ; @0x118
	bl	printf                          ; @0x11c
	bl	clock                           ; @0x120
	mov_s	%r13,%r0                        ; @0x124
	add	%r0,%r56,0x1000@u32             ; @0x126
	add	%r1,%r56,0                      ; @0x12e
	mov	%r2,1024                        ; @0x132
	bl	vectorized_dotp                 ; @0x136
	mov_s	%r17,%r0                        ; @0x13a
	bl	clock                           ; @0x13c
	sub_s	%r0,%r0,%r13                    ; @0x140
	fint2d	%r2,%r0                         ; @0x142
	fdmul	%r22,%r2,%r14                   ; @0x146
	bl	_timer_clocks_per_sec           ; @0x14a
	fuint2d	%r2,%r0                         ; @0x14e
	fddiv	%r22,%r22,%r2                   ; @0x152
	mov_s	%r0,%r19                        ; @0x156
	add	%r0,%r0,.L.str.7-.Lstr.11       ; @0x158
	mov_s	%r1,%r22                        ; @0x15c
	mov_s	%r2,%r23                        ; @0x15e
	bl	printf                          ; @0x160
	fddiv	%r2,%r20,%r22                   ; @0x164
	sub	%r18,%r19,.Lstr.11-.L.str.8     ; @0x168
	mov_s	%r0,%r18                        ; @0x16c
	mov_s	%r1,%r2                         ; @0x16e
	mov_s	%r2,%r3                         ; @0x170
	bl	printf                          ; @0x172
	mov_s	%r0,%r16                        ; @0x176
	mov_s	%r1,%r17                        ; @0x178
	bl	printf                          ; @0x17a
	mov_s	%r0,%r19                        ; @0x17e
	bl.d	puts                            ; @0x180
	nop                                     ; inserted to benefit BPU
                                        ; @0x184
	bl	clock                           ; @0x188
	mov_s	%r13,%r0                        ; @0x18c
	add	%r0,%r56,0x1000@u32             ; @0x18e
	add	%r1,%r56,0                      ; @0x196
	mov	%r2,1024                        ; @0x19a
	bl	autovectorized_dotp             ; @0x19e
	mov_s	%r17,%r0                        ; @0x1a2
	bl	clock                           ; @0x1a4
	sub_s	%r0,%r0,%r13                    ; @0x1a8
	fint2d	%r2,%r0                         ; @0x1aa
	fdmul	%r22,%r2,%r14                   ; @0x1ae
	bl	_timer_clocks_per_sec           ; @0x1b2
	fuint2d	%r2,%r0                         ; @0x1b6
	fddiv	%r22,%r22,%r2                   ; @0x1ba
	mov_s	%r0,.L.str.10                   ; @0x1be
	mov_s	%r1,%r22                        ; @0x1c4
	mov_s	%r2,%r23                        ; @0x1c6
	bl	printf                          ; @0x1c8
	fddiv	%r2,%r20,%r22                   ; @0x1cc
	mov_s	%r0,%r18                        ; @0x1d0
	mov_s	%r1,%r2                         ; @0x1d2
	mov_s	%r2,%r3                         ; @0x1d4
	bl	printf                          ; @0x1d6
	mov_s	%r0,%r16                        ; @0x1da
	mov_s	%r1,%r17                        ; @0x1dc
	bl	printf                          ; @0x1de
	b_s	.LBB0_6                         ; @0x1e2
.LBB0_4:                                ; %if.then
                                        ; @0x1e4
	add	%r0,%r19,.Lstr-.Lstr.11         ; @0x1e4
	bl	puts                            ; @0x1e8
	mov_s	%r14,1                          ; @0x1ec
.LBB0_6:                                ; %cleanup
                                        ; @0x1ee
	mov_s	%r0,%r14                        ; @0x1ee
	add3	%r56,%r56,8192/8                ; @0x1f0
	ld	%blink,[%sp,44]                 ; @0x1f4
	.cfa_restore	{%blink}                ; @0x1f8
	ldd	%r22,[%sp,36]                   ; @0x1f8
	.cfa_restore	{%r23}                  ; @0x1fc
	.cfa_restore	{%r22}                  ; @0x1fc
	ldd	%r20,[%sp,28]                   ; @0x1fc
	.cfa_restore	{%r21}                  ; @0x200
	.cfa_restore	{%r20}                  ; @0x200
	ldd	%r18,[%sp,20]                   ; @0x200
	.cfa_restore	{%r19}                  ; @0x204
	.cfa_restore	{%r18}                  ; @0x204
	ldd	%r16,[%sp,12]                   ; @0x204
	.cfa_restore	{%r17}                  ; @0x208
	.cfa_restore	{%r16}                  ; @0x208
	ldd	%r14,[%sp,4]                    ; @0x208
	.cfa_restore	{%r15}                  ; @0x20c
	.cfa_restore	{%r14}                  ; @0x20c
	ld.ab	%r13,[%sp,48]                   ; @0x20c
	.cfa_restore	{%r13}                  ; @0x210
	.cfa_pop	48                              ; @0x210
	j_s	[%blink]                        ; @0x210
	.cfa_ef
.Lfunc_end0:                            ; @0x212

	.reloc	_init_ad,0	;startup code to enable %status AD bit ; -- End function
