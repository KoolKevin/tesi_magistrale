	.option	%reg
	.off	assume_short
	.file	"main.c"
	.size	.L.str.2, 15
	.type	.L.str.2,@object
	.size	.L.str.6, 15
	.type	.L.str.6,@object
	.size	.L.str.4, 23
	.type	.L.str.4,@object
	.size	.Lstr.9, 26
	.type	.Lstr.9,@object
	.size	.L.str.1, 29
	.type	.L.str.1,@object
	.size	.Lstr, 39
	.type	.Lstr,@object
	.size	.L.str.5, 40
	.type	.L.str.5,@object
	.size	.L.str.8, 47
	.type	.L.str.8,@object
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
.L.str.4:                               ; @0x1e
	.asciz	"Vettorizzo su %d lane\n"
.Lstr.9:                                ; @0x35
	.asciz	"Versione autovettorizzata"
.L.str.1:                               ; @0x4f
	.asciz	"Tempo di esecuzione: %.2fms\n"
.Lstr:                                  ; @0x6c
	.asciz	"Errore nell'allocazione della memoria."
.L.str.5:                               ; @0x93
	.asciz	"Tempo di esecuzione vectorized: %.2fms\n"
.L.str.8:                               ; @0xbb
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
	add	%r1,%r56,0x1000@u32             ; @0x20
	cmp_s	%r1,0                           ; @0x28
	add	%r0,%r56,0                      ; @0x2a
	mov_s	%r19,.Lstr.9                    ; Predicate Case 4
                                        ; @0x2e
	cmp.ne	%r0,0                           ; @0x34
	beq_s	.LBB0_4                         ; Predicate Case 4
                                        ; @0x38
;  %bb.2:                               ; %vector.body.preheader
	; Implicit def %r3                      ; @0x3a
.vvsbundle  "v1sc" 
 ;	 { 
	vvci.w	%vr0                            ; @0x3a
	add2	%r0,%r0,192/4                   ; @0x3a
 ;	 }
	add2	%r1,%r1,192/4                   ; @0x42
	mov	%lp_count,8                     ; @0x46
	lp	.LZD0                           ; @0x4a
.LBB0_3:                                ; %vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x4e
.vvsbundle  " v3" 
 ;	 { 
	vvadd.w	%vr3, %vr0, 16                  ; @0x4e
	vvadd.w	%vr2, %vr0, 32                  ; @0x4e
	vvadd.w	%vr1, %vr0, 48                  ; @0x4e
 ;	 }
.vvsbundle  " v3" 
 ;	 { 
	vvst.av.w	%vr1,%r1,-1             ; @0x5a
	vvadd.w	%vr5, %vr0, 96                  ; @0x5a
	vvadd.w	%vr4, %vr0, 112                 ; @0x5a
 ;	 }
.vvsbundle  " v3" 
 ;	 { 
	vvst.av.w	%vr1,%r0,-1             ; @0x6a
	vvadd.w	%vr6, %vr0, 64                  ; @0x6a
	vvadd.w	%vr1, %vr0, 80                  ; @0x6a
 ;	 }
	vvst.av.w	%vr2,%r1,-1             ; @0x7a
	vvst.av.w	%vr2,%r0,-1             ; @0x80
	vvst.av.w	%vr3,%r1,6              ; @0x86
	vvst.av.w	%vr3,%r0,6              ; @0x8c
	vvst.av.w	%vr4,%r1,-1             ; @0x92
	vvst.av.w	%vr4,%r0,-1             ; @0x98
	vvst.av.w	%vr5,%r1,-1             ; @0x9e
	vvst.av.w	%vr5,%r0,-1             ; @0xa4
	vvst.av.w	%vr1,%r1,-1             ; @0xaa
	vvst.av.w	%vr1,%r0,-1             ; @0xb0
	vvst.av.w	%vr6,%r1,-4             ; @0xb6
	vvst.av.w	%vr6,%r0,-4             ; @0xbc
	vvst.av.w	%vr0,%r1,11             ; @0xc2
.vvsbundle  " v2" 
 ;	 { 
	vvst.av.w	%vr0,%r0,11             ; @0xc8
	vvadd.w	%vr0, %vr0, 128                 ; @0xc8
 ;	 }
.LZD0:                                  ; @0xd2
	; ZD Loop End                           ; @0xd2
;  %bb.5:                               ; %for.cond.cleanup
	nop                                     ; inserted to benefit BPU
                                        ; @0xd2
	nop_s                                   ; inserted to benefit BPU
                                        ; @0xd6
	bl	clock                           ; @0xd8
	mov_s	%r13,%r0                        ; @0xdc
	add	%r0,%r56,0x1000@u32             ; @0xde
	add	%r1,%r56,0                      ; @0xe6
	mov	%r2,1024                        ; @0xea
	bl	dotp                            ; @0xee
	mov_s	%r16,%r0                        ; @0xf2
	mov_s	%r15,0x408f4000@u32             ; @0xf4
	mov_s	%r14,0                          ; @0xfa
	bl	clock                           ; @0xfc
	sub_s	%r0,%r0,%r13                    ; @0x100
	fint2d	%r2,%r0                         ; @0x102
	fdmul	%r20,%r2,%r14                   ; @0x106
	bl	_timer_clocks_per_sec           ; @0x10a
	fuint2d	%r2,%r0                         ; @0x10e
	fddiv	%r20,%r20,%r2                   ; @0x112
	add	%r0,%r19,.L.str.1-.Lstr.9       ; @0x116
	mov_s	%r1,%r20                        ; @0x11a
	mov_s	%r2,%r21                        ; @0x11c
	bl	printf                          ; @0x11e
	mov_s	%r1,%r16                        ; @0x122
	sub	%r16,%r19,.Lstr.9-.L.str.2      ; @0x124
	mov_s	%r0,%r16                        ; @0x128
	bl	printf                          ; @0x12a
	mov_s	%r0,10                          ; @0x12e
	bl	putchar                         ; @0x130
	sub	%r0,%r19,.Lstr.9-.L.str.4       ; @0x134
	mov	%r1,16                          ; widened to benefit BPU
                                        ; @0x138
	bl	printf                          ; @0x13c
	bl	clock                           ; @0x140
	mov_s	%r13,%r0                        ; @0x144
	add	%r0,%r56,0x1000@u32             ; @0x146
	add	%r1,%r56,0                      ; @0x14e
	mov	%r2,1024                        ; @0x152
	bl	vectorized_dotp                 ; @0x156
	mov_s	%r17,%r0                        ; @0x15a
	bl	clock                           ; @0x15c
	sub_s	%r0,%r0,%r13                    ; @0x160
	fint2d	%r2,%r0                         ; @0x162
	fdmul	%r22,%r2,%r14                   ; @0x166
	bl	_timer_clocks_per_sec           ; @0x16a
	fuint2d	%r2,%r0                         ; @0x16e
	fddiv	%r22,%r22,%r2                   ; @0x172
	mov_s	%r0,%r19                        ; @0x176
	add	%r0,%r0,.L.str.5-.Lstr.9        ; @0x178
	mov_s	%r1,%r22                        ; @0x17c
	mov_s	%r2,%r23                        ; @0x17e
	bl	printf                          ; @0x180
	fddiv	%r2,%r20,%r22                   ; @0x184
	sub	%r18,%r19,.Lstr.9-.L.str.6      ; @0x188
	mov_s	%r0,%r18                        ; @0x18c
	mov_s	%r1,%r2                         ; @0x18e
	mov_s	%r2,%r3                         ; @0x190
	bl	printf                          ; @0x192
	mov_s	%r0,%r16                        ; @0x196
	mov_s	%r1,%r17                        ; @0x198
	bl	printf                          ; @0x19a
	mov_s	%r0,10                          ; @0x19e
	bl	putchar                         ; @0x1a0
	mov	%r0,%r19                        ; widened to benefit BPU
                                        ; @0x1a4
	bl.d	puts                            ; @0x1a8
	nop                                     ; inserted to benefit BPU
                                        ; @0x1ac
	bl	clock                           ; @0x1b0
	mov_s	%r13,%r0                        ; @0x1b4
	add	%r0,%r56,0x1000@u32             ; @0x1b6
	add	%r1,%r56,0                      ; @0x1be
	mov	%r2,1024                        ; @0x1c2
	bl	autovectorized_dotp             ; @0x1c6
	mov_s	%r17,%r0                        ; @0x1ca
	bl	clock                           ; @0x1cc
	sub_s	%r0,%r0,%r13                    ; @0x1d0
	fint2d	%r2,%r0                         ; @0x1d2
	fdmul	%r22,%r2,%r14                   ; @0x1d6
	bl	_timer_clocks_per_sec           ; @0x1da
	fuint2d	%r2,%r0                         ; @0x1de
	fddiv	%r22,%r22,%r2                   ; @0x1e2
	mov_s	%r0,.L.str.8                    ; @0x1e6
	mov_s	%r1,%r22                        ; @0x1ec
	mov_s	%r2,%r23                        ; @0x1ee
	bl	printf                          ; @0x1f0
	fddiv	%r2,%r20,%r22                   ; @0x1f4
	mov_s	%r0,%r18                        ; @0x1f8
	mov_s	%r1,%r2                         ; @0x1fa
	mov_s	%r2,%r3                         ; @0x1fc
	bl	printf                          ; @0x1fe
	mov_s	%r0,%r16                        ; @0x202
	mov_s	%r1,%r17                        ; @0x204
	bl	printf                          ; @0x206
	b_s	.LBB0_6                         ; @0x20a
.LBB0_4:                                ; %if.then
                                        ; @0x20c
	add	%r0,%r19,.Lstr-.Lstr.9          ; @0x20c
	bl	puts                            ; @0x210
	mov_s	%r14,1                          ; @0x214
.LBB0_6:                                ; %cleanup
                                        ; @0x216
	mov_s	%r0,%r14                        ; @0x216
	add3	%r56,%r56,8192/8                ; @0x218
	ld	%blink,[%sp,44]                 ; @0x21c
	.cfa_restore	{%blink}                ; @0x220
	ldd	%r22,[%sp,36]                   ; @0x220
	.cfa_restore	{%r23}                  ; @0x224
	.cfa_restore	{%r22}                  ; @0x224
	ldd	%r20,[%sp,28]                   ; @0x224
	.cfa_restore	{%r21}                  ; @0x228
	.cfa_restore	{%r20}                  ; @0x228
	ldd	%r18,[%sp,20]                   ; @0x228
	.cfa_restore	{%r19}                  ; @0x22c
	.cfa_restore	{%r18}                  ; @0x22c
	ldd	%r16,[%sp,12]                   ; @0x22c
	.cfa_restore	{%r17}                  ; @0x230
	.cfa_restore	{%r16}                  ; @0x230
	ldd	%r14,[%sp,4]                    ; @0x230
	.cfa_restore	{%r15}                  ; @0x234
	.cfa_restore	{%r14}                  ; @0x234
	ld.ab	%r13,[%sp,48]                   ; @0x234
	.cfa_restore	{%r13}                  ; @0x238
	.cfa_pop	48                              ; @0x238
	j_s	[%blink]                        ; @0x238
	.cfa_ef
.Lfunc_end0:                            ; @0x23a

	.reloc	_init_ad,0	;startup code to enable %status AD bit ; -- End function
