	.option	%reg
	.off	assume_short
	.file	"vekt_main.c"
	.size	.L.str.2, 30
	.type	.L.str.2,@object
	.globl	a
	.size	a, 32768
	.type	a,@object
	.globl	b
	.size	b, 32768
	.type	b,@object
	.globl	c
	.size	c, 32768
	.type	c,@object
	.size	.Lstr.11, 30
	.type	.Lstr.11,@object
	.size	.L.str.6, 15
	.type	.L.str.6,@object
	.size	.L.str.4, 23
	.type	.L.str.4,@object
	.size	.Lstr.10, 27
	.type	.Lstr.10,@object
	.size	.L.str, 40
	.type	.L.str,@object
	.size	.L.str.5, 51
	.type	.L.str.5,@object
	.size	.L.str.8, 55
	.type	.L.str.8,@object
	.globl	init_vector
	.type	init_vector,@function
	.type	.Linit_vector$local,@function
	.size	init_vector, .Lfunc_end0-init_vector
	.size	.Linit_vector$local, .Lfunc_end0-init_vector
	.globl	vekt_vec_sum_wrapper
	.type	vekt_vec_sum_wrapper,@function
	.type	.Lvekt_vec_sum_wrapper$local,@function
	.size	vekt_vec_sum_wrapper, .Lfunc_end1-vekt_vec_sum_wrapper
	.size	.Lvekt_vec_sum_wrapper$local, .Lfunc_end1-vekt_vec_sum_wrapper
	.globl	vec_sum
	.type	vec_sum,@function
	.type	.Lvec_sum$local,@function
	.size	vec_sum, .Lfunc_end2-vec_sum
	.size	.Lvec_sum$local, .Lfunc_end2-vec_sum
	.globl	main
	.type	main,@function
	.type	.Lmain$local,@function
	.size	main, .Lfunc_end3-main
	.size	.Lmain$local, .Lfunc_end3-main
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
	.asciz	"a[%d]=%d, b[%d]=%d, c[%d]=%d\n"
.Lstr.11:                               ; @0x1e
	.asciz	"Primi 5 elementi della somma:"
.L.str.6:                               ; @0x3c
	.asciz	"Speedup: %.2f\n"
.L.str.4:                               ; @0x4b
	.asciz	"Vettorizzo su %d lane\n"
.Lstr.10:                               ; @0x62
	.asciz	"Versione vekt-vettorizzata"
.L.str:                                 ; @0x7d
	.asciz	"Tempo di esecuzione di vec_sum: %.2fms\n"
.L.str.5:                               ; @0xa5
	.asciz	"Tempo di esecuzione di vectorized_vec_sum: %.2fms\n"
.L.str.8:                               ; @0xd8
	.asciz	"Tempo di esecuzione di autovectorized_vec_sum: %.2fms\n"
	.section	.vecmem_data,"aw",@progbits
	.align	4
a:                                      ; @0x0
	.skip	32768
	.align	4
b:                                      ; @0x8000
	.skip	32768
	.align	4
c:                                      ; @0x10000
	.skip	32768
	.text
	.global	.CC_I
	.equ	.CC_I, 0
	.ident	"LLVM 17.0.7/V-2024.06. (build 008) (LLVM 17.0.7) -arcv2hs -core4 -Xcode_density -Xatomic -Xll64 -Xunaligned -Xdiv_rem=radix4 -Xswap -Xbitscan -Xmpy_option=mpyd -Xshift_assist -Xbarrel_shifter -Xfpud_div -Xfpu_mac -Xtimer0 -Xrtc -Xstack_check -Xstu=4 -Xvdsp4 -Xvec_unit_rev_minor=1 -Xvec_width=512 -Xvec_mem_size=128k -Xvec_mem_bank_width=16 -Xvec_max_fetch_size=16 -Xvec_num_slots=3 -Xvec_super_with_scalar -Xvec_regs=32 -Xvec_fpu=32 -Xvec_fpu_math=3 -Xvec_fpu_2nd_mul -Xvec_fpu_types=2 -Xvec_num_rd_ports=6 -Xvec_num_acc=8 -Xvec_num_mpy=2 -Xvec_mpy32 -Xvec_num_alu=3 -Xvec_guard_bit_option=0 -Xvec_stack_check -Hvdsp_vector_c -O2 -fvectorize -fslp-vectorize -ffast-math"
	.align	8                               ; -- Begin function init_vector
init_vector:                            ; @init_vector
                                        ; @0x0
.Linit_vector$local:                    ; @0x0
	.cfa_bf	.Linit_vector$local
;  %bb.0:                               ; %entry
	.cfa_same	%r2                     ; @0x0
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
	cmp_s	%r1,0                           ; @0x14
	ble	.LBB0_12                        ; @0x16
;  %bb.1:                               ; %iter.check
	cmp_s	%r1,8                           ; @0x1a
	mov_s	%r3,0                           ; @0x1c
	bcs	.LBB0_10                        ; @0x1e
;  %bb.2:                               ; %vector.main.loop.iter.check
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr0, %r2                      ; @0x22
	cmp_s	%r1,64                          ; @0x22
 ;	 }
	bcs	.LBB0_7                         ; @0x28
;  %bb.3:                               ; %vector.ph
	; Implicit def %r30                     ; @0x2c
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r4,%vr0,14             ; @0x2c
	sub3	%r12,%r1,64/8                   ; @0x2c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r6,%vr0,12             ; @0x36
	lsr_s	%r12,%r12,6                     ; @0x36
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r8,%vr0,10             ; @0x3e
	bmskn	%r3,%r1,5                       ; @0x3e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r22,%vr0,0             ; @0x48
	add	%lp_count,%r12,1                ; @0x48
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r20,%vr0,2             ; @0x52
	add	%r12,%r0,56                     ; @0x52
 ;	 }
	vvmov2.x.from.w	%r18,%vr0,4             ; @0x5c
	vvmov2.x.from.w	%r16,%vr0,6             ; @0x62
	vvmov2.x.from.w	%r14,%vr0,8             ; @0x68
	lp	.LZD2                           ; @0x6e
.LBB0_4:                                ; %vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x72
	std.ab	%r4,[%r12,-8]                   ; @0x72
	std.ab	%r6,[%r12,72]                   ; @0x76
	std.ab	%r4,[%r12,-8]                   ; @0x7a
	std.ab	%r6,[%r12,72]                   ; @0x7e
	std.ab	%r4,[%r12,-8]                   ; @0x82
	std.ab	%r6,[%r12,72]                   ; @0x86
	std.ab	%r4,[%r12,-8]                   ; @0x8a
	std.ab	%r6,[%r12,-200]                 ; @0x8e
	std.ab	%r8,[%r12,64]                   ; @0x92
	std.ab	%r8,[%r12,64]                   ; @0x96
	std.ab	%r8,[%r12,64]                   ; @0x9a
	std.ab	%r8,[%r12,-200]                 ; @0x9e
	std.ab	%r14,[%r12,-8]                  ; @0xa2
	std.ab	%r16,[%r12,72]                  ; @0xa6
	std.ab	%r14,[%r12,-8]                  ; @0xaa
	std.ab	%r16,[%r12,72]                  ; @0xae
	std.ab	%r14,[%r12,-8]                  ; @0xb2
	std.ab	%r16,[%r12,72]                  ; @0xb6
	std.ab	%r14,[%r12,-8]                  ; @0xba
	std.ab	%r16,[%r12,-200]                ; @0xbe
	std.ab	%r18,[%r12,-8]                  ; @0xc2
	std.ab	%r20,[%r12,-8]                  ; @0xc6
	std.ab	%r22,[%r12,80]                  ; @0xca
	std.ab	%r18,[%r12,-8]                  ; @0xce
	std.ab	%r20,[%r12,-8]                  ; @0xd2
	std.ab	%r22,[%r12,80]                  ; @0xd6
	std.ab	%r18,[%r12,-8]                  ; @0xda
	std.ab	%r20,[%r12,-8]                  ; @0xde
	std.ab	%r22,[%r12,80]                  ; @0xe2
	std.ab	%r18,[%r12,-8]                  ; @0xe6
	std.ab	%r20,[%r12,-8]                  ; @0xea
	std.ab	%r22,[%r12,120]                 ; @0xee
.LZD2:                                  ; @0xf2
	; ZD Loop End                           ; @0xf2
;  %bb.5:                               ; %middle.block
	breq	%r3,%r1,.LBB0_12                ; @0xf2
;  %bb.6:                               ; %vec.epilog.iter.check
	tst	%r1,56                          ; @0xf6
	beq_s	.LBB0_10                        ; @0xfa
.LBB0_7:                                ; %vec.epilog.ph
                                        ; @0xfc
	; Implicit def %r30                     ; @0xfc
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r4,%vr0,0              ; @0xfc
	sub_s	%r15,%r1,%r3                    ; @0xfc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r6,%vr0,2              ; @0x104
	sub_s	%r15,%r15,8                     ; @0x104
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r8,%vr0,4              ; @0x10c
	lsr_s	%r15,%r15,3                     ; @0x10c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r22,%vr0,6             ; @0x114
	add2	%r12,%r0,%r3                    ; @0x114
 ;	 }
	bmskn	%r3,%r1,2                       ; @0x11e
	add	%lp_count,%r15,1                ; @0x122
	lp	.LZD1                           ; @0x126
.LBB0_8:                                ; %vec.epilog.vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x12a
	std	%r22,[%r12,24]                  ; @0x12a
	std	%r8,[%r12,16]                   ; @0x12e
	std	%r6,[%r12,8]                    ; @0x132
	std.ab	%r4,[%r12,32]                   ; @0x136
.LZD1:                                  ; @0x13a
	; ZD Loop End                           ; @0x13a
;  %bb.9:                               ; %vec.epilog.middle.block
	breq	%r3,%r1,.LBB0_12                ; @0x13a
.LBB0_10:                               ; %for.body.preheader
                                        ; @0x13e
	add_s	%r12,%r3,1                      ; @0x13e
	max	%r1,%r1,%r12                    ; @0x140
	add2_s	%r0,%r0,%r3                     ; @0x144
	sub	%lp_count,%r1,%r3               ; @0x146
	; Implicit def %r3                      ; @0x14a
	lp	.LZD0                           ; @0x14a
.LBB0_11:                               ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x14e
	st.ab	%r2,[%r0,4]                     ; @0x14e
.LZD0:                                  ; @0x152
	; ZD Loop End                           ; @0x152
.LBB0_12:                               ; %for.cond.cleanup
                                        ; @0x152
	ldd	%r22,[%sp,32]                   ; @0x152
	.cfa_restore	{%r23}                  ; @0x156
	.cfa_restore	{%r22}                  ; @0x156
	ldd	%r20,[%sp,24]                   ; @0x156
	.cfa_restore	{%r21}                  ; @0x15a
	.cfa_restore	{%r20}                  ; @0x15a
	ldd	%r18,[%sp,16]                   ; @0x15a
	.cfa_restore	{%r19}                  ; @0x15e
	.cfa_restore	{%r18}                  ; @0x15e
	ldd	%r16,[%sp,8]                    ; @0x15e
	.cfa_restore	{%r17}                  ; @0x162
	.cfa_restore	{%r16}                  ; @0x162
	ldd.ab	%r14,[%sp,40]                   ; @0x162
	.cfa_restore	{%r15}                  ; @0x166
	.cfa_restore	{%r14}                  ; @0x166
	.cfa_pop	40                              ; @0x166
	j_s	[%blink]                        ; @0x166
	.cfa_ef
.Lfunc_end0:                            ; @0x168

	.align	4                               ; -- End function
                                        ; -- Begin function vekt_vec_sum_wrapper
vekt_vec_sum_wrapper:                   ; @vekt_vec_sum_wrapper
                                        ; @0x168
.Lvekt_vec_sum_wrapper$local:           ; @0x168
	.cfa_bf	.Lvekt_vec_sum_wrapper$local
;  %bb.0:                               ; %entry
	std.aw	%r22,[%sp,-12]                  ; @0x168
	.cfa_push	12                      ; @0x16c
	.cfa_reg_offset	{%r22}, 0               ; @0x16c
	.cfa_reg_offset	{%r23}, 4               ; @0x16c
	st	%blink,[%sp,8]                  ; @0x16c
	.cfa_reg_offset	{%blink}, 8             ; @0x170
	sub_s	%sp,%sp,68                      ; @0x170
	.cfa_push	68                      ; @0x172
	asr	%r5,%r3,31                      ; @0x172
	mov_s	%r4,%r3                         ; @0x176
	mov_s	%r8,%r2                         ; @0x178
	mov_s	%r22,%r1                        ; @0x17a
	mov_s	%r9,%r2                         ; @0x17c
	mov_s	%r23,%r1                        ; @0x17e
	mov_s	%r1,%r0                         ; @0x180
	mov_s	%r2,0                           ; @0x182
	mov_s	%r3,0                           ; @0x184
	mov_s	%r6,1                           ; @0x186
	mov_s	%r7,0                           ; @0x188
	st	%r4,[%sp,64]                    ; @0x18a
	std	1,[%sp,56]                      ; @0x18e
	std	0,[%sp,40]                      ; @0x192
	std	%r8,[%sp,32]                    ; @0x196
	std	1,[%sp,24]                      ; @0x19a
	std	0,[%sp,8]                       ; @0x19e
	std	%r22,[%sp,0]                    ; @0x1a2
	std	%r4,[%sp,48]                    ; @0x1a6
	std	%r4,[%sp,16]                    ; @0x1aa
	bl	vekt_vec_sum                    ; @0x1ae
	add_s	%sp,%sp,68                      ; @0x1b2
	.cfa_pop	68                              ; @0x1b4
	ld	%blink,[%sp,8]                  ; @0x1b4
	.cfa_restore	{%blink}                ; @0x1b8
	ldd.ab	%r22,[%sp,12]                   ; @0x1b8
	.cfa_restore	{%r23}                  ; @0x1bc
	.cfa_restore	{%r22}                  ; @0x1bc
	.cfa_pop	12                              ; @0x1bc
	j_s	[%blink]                        ; @0x1bc
	.cfa_ef
.Lfunc_end1:                            ; @0x1be

	.align	4                               ; -- End function
                                        ; -- Begin function vec_sum
vec_sum:                                ; @vec_sum
                                        ; @0x1c0
.Lvec_sum$local:                        ; @0x1c0
	.cfa_bf	.Lvec_sum$local
;  %bb.0:                               ; %entry
	.cfa_same	%r30                    ; @0x1c0
	.cfa_same	%r11                    ; @0x1c0
	.cfa_same	%r9                     ; @0x1c0
	.cfa_same	%r8                     ; @0x1c0
	.cfa_same	%r7                     ; @0x1c0
	.cfa_same	%r6                     ; @0x1c0
	.cfa_same	%r5                     ; @0x1c0
	.cfa_same	%r4                     ; @0x1c0
	sub.f	%lp_count,%r3,0                 ; @0x1c0
	.cfa_remember_state                     ; @0x1c4
	jle	[%blink]                        ; @0x1c4
	.cfa_restore_state                      ; @0x1c8
;  %bb.1:                               ; %for.body.preheader
	; Implicit def %r12                     ; @0x1c8
	lp	.LZD3                           ; @0x1c8
.LBB2_2:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x1cc
	ld.ab	%r3,[%r0,4]                     ; @0x1cc
	ld.ab	%r12,[%r1,4]                    ; @0x1d0
	add_s	%r3,%r12,%r3                    ; @0x1d4
	st.ab	%r3,[%r2,4]                     ; @0x1d6
.LZD3:                                  ; @0x1da
	; ZD Loop End                           ; @0x1da
;  %bb.3:                               ; %for.cond.cleanup
	j_s	[%blink]                        ; @0x1da
	.cfa_ef
.Lfunc_end2:                            ; @0x1dc

	.align	4                               ; -- End function
                                        ; -- Begin function main
main:                                   ; @main
                                        ; @0x1dc
.Lmain$local:                           ; @0x1dc
	.cfa_bf	.Lmain$local
;  %bb.0:                               ; %entry
	st.aw	%r13,[%sp,-76]                  ; @0x1dc
	.cfa_push	76                      ; @0x1e0
	.cfa_reg_offset	{%r13}, 0               ; @0x1e0
	std	%r14,[%sp,4]                    ; @0x1e0
	.cfa_reg_offset	{%r14}, 4               ; @0x1e4
	.cfa_reg_offset	{%r15}, 8               ; @0x1e4
	std	%r16,[%sp,12]                   ; @0x1e4
	.cfa_reg_offset	{%r16}, 12              ; @0x1e8
	.cfa_reg_offset	{%r17}, 16              ; @0x1e8
	std	%r18,[%sp,20]                   ; @0x1e8
	.cfa_reg_offset	{%r18}, 20              ; @0x1ec
	.cfa_reg_offset	{%r19}, 24              ; @0x1ec
	std	%r20,[%sp,28]                   ; @0x1ec
	.cfa_reg_offset	{%r20}, 28              ; @0x1f0
	.cfa_reg_offset	{%r21}, 32              ; @0x1f0
	std	%r22,[%sp,36]                   ; @0x1f0
	.cfa_reg_offset	{%r22}, 36              ; @0x1f4
	.cfa_reg_offset	{%r23}, 40              ; @0x1f4
	st	%r24,[%sp,44]                   ; @0x1f4
	.cfa_reg_offset	{%r24}, 44              ; @0x1f8
	st	%fp,[%sp,48]                    ; @0x1f8
	.cfa_reg_offset	{%fp}, 48               ; @0x1fc
	st	%blink,[%sp,52]                 ; @0x1fc
	.cfa_reg_offset	{%blink}, 52            ; @0x200
	sub_s	%sp,%sp,68                      ; @0x200
	.cfa_push	68                      ; @0x202
	; Implicit def %r3                      ; @0x202
.vvsbundle  "v1sc" 
 ;	 { 
	vvci.w	%vr0                            ; @0x202
	mov_s	%r20,a                          ; @0x202
 ;	 }
	mov_s	%r22,b                          ; @0x20c
	add2	%r0,%r22,192/4                  ; @0x212
	add2	%r1,%r20,192/4                  ; @0x216
	mov	%lp_count,64                    ; @0x21a
	lp	.LZD8                           ; @0x21e
.LBB3_1:                                ; %vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x222
.vvsbundle  " v3" 
 ;	 { 
	vvadd.w	%vr3, %vr0, 17                  ; @0x222
	vvadd.w	%vr2, %vr0, 33                  ; @0x222
	vvadd.w	%vr1, %vr0, 49                  ; @0x222
 ;	 }
.vvsbundle  " v3" 
 ;	 { 
	vvst.av.w	%vr1,%r1,-1             ; @0x22e
	vvadd.w	%vr5, %vr0, 113                 ; @0x22e
	vvadd.w	%vr4, %vr0, 1                   ; @0x22e
 ;	 }
.vvsbundle  " v3" 
 ;	 { 
	vvst.av.w	%vr1,%r0,-1             ; @0x23c
	vvadd.w	%vr6, %vr0, 81                  ; @0x23c
	vvadd.w	%vr1, %vr0, 97                  ; @0x23c
 ;	 }
.vvsbundle  " v3" 
 ;	 { 
	vvst.av.w	%vr2,%r1,-1             ; @0x24c
	vvadd.w	%vr0, %vr0, 128                 ; @0x24c
	vvadd.w	%vr7, %vr0, 65                  ; @0x24c
 ;	 }
	vvst.av.w	%vr2,%r0,-1             ; @0x25c
	vvst.av.w	%vr3,%r1,-1             ; @0x262
	vvst.av.w	%vr3,%r0,-1             ; @0x268
	vvst.av.w	%vr4,%r1,7              ; @0x26e
	vvst.av.w	%vr4,%r0,7              ; @0x274
	vvst.av.w	%vr5,%r1,-1             ; @0x27a
	vvst.av.w	%vr5,%r0,-1             ; @0x280
	vvst.av.w	%vr1,%r1,-1             ; @0x286
	vvst.av.w	%vr1,%r0,-1             ; @0x28c
	vvst.av.w	%vr6,%r1,-1             ; @0x292
	vvst.av.w	%vr6,%r0,-1             ; @0x298
	vvst.av.w	%vr7,%r1,7              ; @0x29e
	vvst.av.w	%vr7,%r0,7              ; @0x2a4
.LZD8:                                  ; @0x2aa
	; ZD Loop End                           ; @0x2aa
;  %bb.2:                               ; %vector.body140.preheader
	; Implicit def %r2                      ; @0x2aa
	mov_s	%r14,c                          ; @0x2aa
	mov	%lp_count,64                    ; @0x2b0
	add_s	%r0,%r14,56                     ; @0x2b4
	lp	.LZD7                           ; @0x2b6
.LBB3_3:                                ; %vector.body140
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x2ba
	std.ab	-1,[%r0,-8]                     ; @0x2ba
	std.ab	-1,[%r0,-8]                     ; @0x2be
	std.ab	-1,[%r0,-8]                     ; @0x2c2
	std.ab	-1,[%r0,-8]                     ; @0x2c6
	std.ab	-1,[%r0,-8]                     ; @0x2ca
	std.ab	-1,[%r0,-8]                     ; @0x2ce
	std.ab	-1,[%r0,-8]                     ; @0x2d2
	std.ab	-1,[%r0,120]                    ; @0x2d6
	std.ab	-1,[%r0,-8]                     ; @0x2da
	std.ab	-1,[%r0,-8]                     ; @0x2de
	std.ab	-1,[%r0,-8]                     ; @0x2e2
	std.ab	-1,[%r0,-8]                     ; @0x2e6
	std.ab	-1,[%r0,-8]                     ; @0x2ea
	std.ab	-1,[%r0,-8]                     ; @0x2ee
	std.ab	-1,[%r0,-8]                     ; @0x2f2
	std.ab	-1,[%r0,120]                    ; @0x2f6
	std.ab	-1,[%r0,-8]                     ; @0x2fa
	std.ab	-1,[%r0,-8]                     ; @0x2fe
	std.ab	-1,[%r0,-8]                     ; @0x302
	std.ab	-1,[%r0,-8]                     ; @0x306
	std.ab	-1,[%r0,-8]                     ; @0x30a
	std.ab	-1,[%r0,-8]                     ; @0x30e
	std.ab	-1,[%r0,-8]                     ; @0x312
	std.ab	-1,[%r0,120]                    ; @0x316
	std.ab	-1,[%r0,-8]                     ; @0x31a
	std.ab	-1,[%r0,-8]                     ; @0x31e
	std.ab	-1,[%r0,-8]                     ; @0x322
	std.ab	-1,[%r0,-8]                     ; @0x326
	std.ab	-1,[%r0,-8]                     ; @0x32a
	std.ab	-1,[%r0,-8]                     ; @0x32e
	std.ab	-1,[%r0,-8]                     ; @0x332
	std.ab	-1,[%r0,120]                    ; @0x336
	std.ab	-1,[%r0,-8]                     ; @0x33a
	std.ab	-1,[%r0,-8]                     ; @0x33e
	std.ab	-1,[%r0,-8]                     ; @0x342
	std.ab	-1,[%r0,-8]                     ; @0x346
	std.ab	-1,[%r0,-8]                     ; @0x34a
	std.ab	-1,[%r0,-8]                     ; @0x34e
	std.ab	-1,[%r0,-8]                     ; @0x352
	std.ab	-1,[%r0,120]                    ; @0x356
	std.ab	-1,[%r0,-8]                     ; @0x35a
	std.ab	-1,[%r0,-8]                     ; @0x35e
	std.ab	-1,[%r0,-8]                     ; @0x362
	std.ab	-1,[%r0,-8]                     ; @0x366
	std.ab	-1,[%r0,-8]                     ; @0x36a
	std.ab	-1,[%r0,-8]                     ; @0x36e
	std.ab	-1,[%r0,-8]                     ; @0x372
	std.ab	-1,[%r0,120]                    ; @0x376
	std.ab	-1,[%r0,-8]                     ; @0x37a
	std.ab	-1,[%r0,-8]                     ; @0x37e
	std.ab	-1,[%r0,-8]                     ; @0x382
	std.ab	-1,[%r0,-8]                     ; @0x386
	std.ab	-1,[%r0,-8]                     ; @0x38a
	std.ab	-1,[%r0,-8]                     ; @0x38e
	std.ab	-1,[%r0,-8]                     ; @0x392
	std.ab	-1,[%r0,120]                    ; @0x396
	std.ab	-1,[%r0,-8]                     ; @0x39a
	std.ab	-1,[%r0,-8]                     ; @0x39e
	std.ab	-1,[%r0,-8]                     ; @0x3a2
	std.ab	-1,[%r0,-8]                     ; @0x3a6
	std.ab	-1,[%r0,-8]                     ; @0x3aa
	std.ab	-1,[%r0,-8]                     ; @0x3ae
	std.ab	-1,[%r0,-8]                     ; @0x3b2
	std.ab	-1,[%r0,120]                    ; @0x3b6
.LZD7:                                  ; @0x3ba
	; ZD Loop End                           ; @0x3ba
;  %bb.4:                               ; %init_vector.exit
	nop                                     ; inserted to benefit BPU
                                        ; @0x3ba
	nop_s                                   ; inserted to benefit BPU
                                        ; @0x3be
	bl	clock                           ; @0x3c0
	; Implicit def %r12                     ; @0x3c4
	mov_s	%r13,%r0                        ; @0x3c4
	mov	%lp_count,1024                  ; @0x3c6
	mov_s	%r0,%r14                        ; @0x3ca
	mov_s	%r1,%r22                        ; @0x3cc
	mov_s	%r2,%r20                        ; @0x3ce
	lp	.LZD6                           ; @0x3d0
.LBB3_5:                                ; %vector.body147
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x3d4
.vvsbundle  "v3sc" 
 ;	 { 
	vvmov.w	 %vr2, 0                        ; @0x3d4
	vvmov.w	 %vr1, 0                        ; @0x3d4
	vvmov.w	 %vr0, 0                        ; @0x3d4
	ldd.ab	%r4,[%r2,32]                    ; @0x3d4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr3, 0                        ; @0x3e4
	ldd.ab	%r6,[%r1,32]                    ; @0x3e4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,0,%r4              ; @0x3ec
	ldd	%r8,[%r1,-16]                   ; @0x3ec
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,0,%r6              ; @0x3f6
	ldd	%r30,[%r2,-16]                  ; @0x3f6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,1,%r5              ; @0x400
	ldd	%r16,[%r2,-24]                  ; @0x400
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,1,%r7              ; @0x40a
	ldd	%r4,[%r1,-24]                   ; @0x40a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,0,%r8              ; @0x414
	ldd	%r6,[%r1,-8]                    ; @0x414
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,0,%r30             ; @0x41e
	ldd	%r18,[%r2,-8]                   ; @0x41e
 ;	 }
	vvmov1.vi.to.w	%vr0,2,%r16             ; @0x428
	vvmov1.vi.to.w	%vr1,2,%r4              ; @0x42e
	vvmov1.vi.to.w	%vr2,1,%r9              ; @0x434
	vvmov1.vi.to.w	%vr3,1,%blink           ; @0x43a
	vvmov1.vi.to.w	%vr0,3,%r17             ; @0x440
	vvmov1.vi.to.w	%vr1,3,%r5              ; @0x446
.vvsbundle  " v2" 
 ;	 { 
	vvadd.w	%vr0, %vr1, %vr0                ; @0x44c
	vvmov1.vi.to.w	%vr2,2,%r6              ; @0x44c
 ;	 }
	vvmov1.vi.to.w	%vr3,2,%r18             ; @0x456
	vvmov1.vi.to.w	%vr2,3,%r7              ; @0x45c
.vvsbundle  " v2" 
 ;	 { 
	vvmov2.x.from.w	%r4,%vr0,2              ; @0x462
	vvmov1.vi.to.w	%vr3,3,%r19             ; @0x462
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvadd.w	%vr0, %vr2, %vr3                ; @0x46c
	vvmov2.x.from.w	%r6,%vr0,0              ; @0x46c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r8,%vr0,0              ; @0x476
	std	%r4,[%r0,8]                     ; @0x476
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov2.x.from.w	%r4,%vr0,2              ; @0x480
	std.ab	%r6,[%r0,32]                    ; @0x480
 ;	 }
	std	%r8,[%r0,-16]                   ; @0x48a
	std	%r4,[%r0,-8]                    ; @0x48e
.LZD6:                                  ; @0x492
	; ZD Loop End                           ; @0x492
;  %bb.6:                               ; %vec_sum.exit
	mov_s	%r19,0x408f4000@u32             ; @0x492
	mov_s	%r18,0                          ; @0x498
	bl	clock                           ; @0x49a
	sub_s	%r0,%r0,%r13                    ; @0x49e
	fint2d	%r2,%r0                         ; @0x4a0
	fdmul	%r16,%r2,%r18                   ; @0x4a4
	bl	_timer_clocks_per_sec           ; @0x4a8
	fuint2d	%r2,%r0                         ; @0x4ac
	fddiv	%r2,%r16,%r2                    ; @0x4b0
	mov_s	%fp,.L.str.5                    ; @0x4b4
	sub	%r0,%fp,.L.str.5-.L.str         ; @0x4ba
	mov_s	%r1,%r2                         ; @0x4be
	std	%r2,[%sp,124]                   ; 8-byte Folded Spill
                                        ; @0x4c0
	mov_s	%r2,%r3                         ; @0x4c4
	bl	printf                          ; @0x4c6
	mov_s	%r24,.L.str.6                   ; @0x4ca
	sub	%r13,%r24,.L.str.6-.Lstr.11     ; @0x4d0
	mov_s	%r0,%r13                        ; @0x4d4
	bl	puts                            ; @0x4d6
	ld_s	%r2,[%r20,0]                    ; @0x4da
	ld	%r4,[%r22,0]                    ; @0x4dc
	ld	%r6,[%r14,0]                    ; @0x4e0
	sub	%r21,%r24,.L.str.6-.L.str.2     ; @0x4e4
	mov_s	%r0,%r21                        ; @0x4e8
	mov_s	%r1,0                           ; @0x4ea
	mov_s	%r3,0                           ; @0x4ec
	mov_s	%r5,0                           ; @0x4ee
	bl	printf                          ; @0x4f0
	ld_s	%r2,[%r20,4]                    ; @0x4f4
	ld	%r4,[%r22,4]                    ; @0x4f6
	ld	%r6,[%r14,4]                    ; @0x4fa
	mov_s	%r0,%r21                        ; @0x4fe
	mov_s	%r1,1                           ; @0x500
	mov_s	%r3,1                           ; @0x502
	mov_s	%r5,1                           ; @0x504
	bl	printf                          ; @0x506
	ld_s	%r2,[%r20,8]                    ; @0x50a
	ld	%r4,[%r22,8]                    ; @0x50c
	ld	%r6,[%r14,8]                    ; @0x510
	mov_s	%r0,%r21                        ; @0x514
	mov_s	%r1,2                           ; @0x516
	mov_s	%r3,2                           ; @0x518
	mov_s	%r5,2                           ; @0x51a
	bl	printf                          ; @0x51c
	ld_s	%r2,[%r20,12]                   ; @0x520
	ld	%r4,[%r22,12]                   ; @0x522
	ld	%r6,[%r14,12]                   ; @0x526
	mov_s	%r0,%r21                        ; @0x52a
	mov_s	%r1,3                           ; @0x52c
	mov_s	%r3,3                           ; @0x52e
	mov_s	%r5,3                           ; @0x530
	bl	printf                          ; @0x532
	ld_s	%r2,[%r20,16]                   ; @0x536
	ld	%r4,[%r22,16]                   ; @0x538
	ld	%r6,[%r14,16]                   ; @0x53c
	mov_s	%r0,%r21                        ; @0x540
	mov_s	%r1,4                           ; @0x542
	mov_s	%r3,4                           ; @0x544
	mov_s	%r5,4                           ; @0x546
	bl	printf                          ; @0x548
	mov	%r0,10                          ; widened to benefit BPU
                                        ; @0x54c
	bl	putchar                         ; @0x550
	add	%r0,%r24,.L.str.4-.L.str.6      ; @0x554
	mov_s	%r1,16                          ; @0x558
	bl	printf                          ; @0x55a
	; Implicit def %r2                      ; @0x55e
	mov	%lp_count,64                    ; @0x55e
	add_s	%r0,%r14,56                     ; @0x562
	lp	.LZD5                           ; @0x564
.LBB3_7:                                ; %vector.body154
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x568
	std.ab	-1,[%r0,-8]                     ; @0x568
	std.ab	-1,[%r0,-8]                     ; @0x56c
	std.ab	-1,[%r0,-8]                     ; @0x570
	std.ab	-1,[%r0,-8]                     ; @0x574
	std.ab	-1,[%r0,-8]                     ; @0x578
	std.ab	-1,[%r0,-8]                     ; @0x57c
	std.ab	-1,[%r0,-8]                     ; @0x580
	std.ab	-1,[%r0,120]                    ; @0x584
	std.ab	-1,[%r0,-8]                     ; @0x588
	std.ab	-1,[%r0,-8]                     ; @0x58c
	std.ab	-1,[%r0,-8]                     ; @0x590
	std.ab	-1,[%r0,-8]                     ; @0x594
	std.ab	-1,[%r0,-8]                     ; @0x598
	std.ab	-1,[%r0,-8]                     ; @0x59c
	std.ab	-1,[%r0,-8]                     ; @0x5a0
	std.ab	-1,[%r0,120]                    ; @0x5a4
	std.ab	-1,[%r0,-8]                     ; @0x5a8
	std.ab	-1,[%r0,-8]                     ; @0x5ac
	std.ab	-1,[%r0,-8]                     ; @0x5b0
	std.ab	-1,[%r0,-8]                     ; @0x5b4
	std.ab	-1,[%r0,-8]                     ; @0x5b8
	std.ab	-1,[%r0,-8]                     ; @0x5bc
	std.ab	-1,[%r0,-8]                     ; @0x5c0
	std.ab	-1,[%r0,120]                    ; @0x5c4
	std.ab	-1,[%r0,-8]                     ; @0x5c8
	std.ab	-1,[%r0,-8]                     ; @0x5cc
	std.ab	-1,[%r0,-8]                     ; @0x5d0
	std.ab	-1,[%r0,-8]                     ; @0x5d4
	std.ab	-1,[%r0,-8]                     ; @0x5d8
	std.ab	-1,[%r0,-8]                     ; @0x5dc
	std.ab	-1,[%r0,-8]                     ; @0x5e0
	std.ab	-1,[%r0,120]                    ; @0x5e4
	std.ab	-1,[%r0,-8]                     ; @0x5e8
	std.ab	-1,[%r0,-8]                     ; @0x5ec
	std.ab	-1,[%r0,-8]                     ; @0x5f0
	std.ab	-1,[%r0,-8]                     ; @0x5f4
	std.ab	-1,[%r0,-8]                     ; @0x5f8
	std.ab	-1,[%r0,-8]                     ; @0x5fc
	std.ab	-1,[%r0,-8]                     ; @0x600
	std.ab	-1,[%r0,120]                    ; @0x604
	std.ab	-1,[%r0,-8]                     ; @0x608
	std.ab	-1,[%r0,-8]                     ; @0x60c
	std.ab	-1,[%r0,-8]                     ; @0x610
	std.ab	-1,[%r0,-8]                     ; @0x614
	std.ab	-1,[%r0,-8]                     ; @0x618
	std.ab	-1,[%r0,-8]                     ; @0x61c
	std.ab	-1,[%r0,-8]                     ; @0x620
	std.ab	-1,[%r0,120]                    ; @0x624
	std.ab	-1,[%r0,-8]                     ; @0x628
	std.ab	-1,[%r0,-8]                     ; @0x62c
	std.ab	-1,[%r0,-8]                     ; @0x630
	std.ab	-1,[%r0,-8]                     ; @0x634
	std.ab	-1,[%r0,-8]                     ; @0x638
	std.ab	-1,[%r0,-8]                     ; @0x63c
	std.ab	-1,[%r0,-8]                     ; @0x640
	std.ab	-1,[%r0,120]                    ; @0x644
	std.ab	-1,[%r0,-8]                     ; @0x648
	std.ab	-1,[%r0,-8]                     ; @0x64c
	std.ab	-1,[%r0,-8]                     ; @0x650
	std.ab	-1,[%r0,-8]                     ; @0x654
	std.ab	-1,[%r0,-8]                     ; @0x658
	std.ab	-1,[%r0,-8]                     ; @0x65c
	std.ab	-1,[%r0,-8]                     ; @0x660
	std.ab	-1,[%r0,120]                    ; @0x664
.LZD5:                                  ; @0x668
	; ZD Loop End                           ; @0x668
;  %bb.8:                               ; %init_vector.exit122
	nop                                     ; inserted to benefit BPU
                                        ; @0x668
	nop                                     ; inserted to benefit BPU
                                        ; @0x66c
	bl	clock                           ; @0x670
	mov_s	%r4,0x2000@u32                  ; @0x674
	mov_s	%r15,%r0                        ; @0x67a
	mov_s	%r0,%r20                        ; @0x67c
	mov_s	%r1,%r22                        ; @0x67e
	mov_s	%r2,%r14                        ; @0x680
	mov_s	%r3,%r4                         ; @0x682
	std	%r4,[%sp,132]                   ; 8-byte Folded Spill
                                        ; @0x684
	bl	vectorized_vec_sum              ; @0x688
	mov	%r18,0                          ; widened to benefit BPU
                                        ; @0x68c
	bl	clock                           ; @0x690
	sub_s	%r0,%r0,%r15                    ; @0x694
	fint2d	%r2,%r0                         ; @0x696
	fdmul	%r16,%r2,%r18                   ; @0x69a
	bl	_timer_clocks_per_sec           ; @0x69e
	fuint2d	%r2,%r0                         ; @0x6a2
	fddiv	%r16,%r16,%r2                   ; @0x6a6
	mov_s	%r0,%fp                         ; @0x6aa
	mov_s	%r1,%r16                        ; @0x6ac
	mov_s	%r2,%r17                        ; @0x6ae
	bl	printf                          ; @0x6b0
	ldd	%r2,[%sp,124]                   ; 8-byte Folded Reload
                                        ; @0x6b4
	mov_s	%r0,%r24                        ; @0x6b8
	fddiv	%r2,%r2,%r16                    ; @0x6ba
	mov_s	%r1,%r2                         ; @0x6be
	mov_s	%r2,%r3                         ; @0x6c0
	bl	printf                          ; @0x6c2
	mov_s	%r0,%r13                        ; @0x6c6
	st	%r13,[%sp,140]                  ; 4-byte Folded Spill
                                        ; @0x6c8
	bl	puts                            ; @0x6cc
	ld_s	%r2,[%r20,0]                    ; @0x6d0
	ld	%r4,[%r22,0]                    ; @0x6d2
	ld	%r6,[%r14,0]                    ; @0x6d6
	mov_s	%r0,%r21                        ; @0x6da
	mov_s	%r1,0                           ; @0x6dc
	mov_s	%r3,0                           ; @0x6de
	mov_s	%r5,0                           ; @0x6e0
	bl	printf                          ; @0x6e2
	ld_s	%r2,[%r20,4]                    ; @0x6e6
	ld	%r4,[%r22,4]                    ; @0x6e8
	ld	%r6,[%r14,4]                    ; @0x6ec
	mov_s	%r0,%r21                        ; @0x6f0
	mov_s	%r1,1                           ; @0x6f2
	mov_s	%r3,1                           ; @0x6f4
	mov_s	%r5,1                           ; @0x6f6
	bl	printf                          ; @0x6f8
	ld_s	%r2,[%r20,8]                    ; @0x6fc
	ld	%r4,[%r22,8]                    ; @0x6fe
	ld	%r6,[%r14,8]                    ; @0x702
	mov_s	%r0,%r21                        ; @0x706
	mov_s	%r1,2                           ; @0x708
	mov_s	%r3,2                           ; @0x70a
	mov_s	%r5,2                           ; @0x70c
	bl	printf                          ; @0x70e
	ld_s	%r2,[%r20,12]                   ; @0x712
	ld	%r4,[%r22,12]                   ; @0x714
	ld	%r6,[%r14,12]                   ; @0x718
	mov_s	%r0,%r21                        ; @0x71c
	mov_s	%r1,3                           ; @0x71e
	mov_s	%r3,3                           ; @0x720
	mov_s	%r5,3                           ; @0x722
	bl	printf                          ; @0x724
	ld_s	%r2,[%r20,16]                   ; @0x728
	ld	%r4,[%r22,16]                   ; @0x72a
	ld	%r6,[%r14,16]                   ; @0x72e
	mov_s	%r0,%r21                        ; @0x732
	mov_s	%r1,4                           ; @0x734
	mov_s	%r3,4                           ; @0x736
	mov_s	%r5,4                           ; @0x738
	bl	printf                          ; @0x73a
	mov_s	%r0,10                          ; @0x73e
	bl	putchar                         ; @0x740
	add	%r0,%r24,.Lstr.10-.L.str.6      ; @0x744
	bl	puts                            ; @0x748
	; Implicit def %r2                      ; @0x74c
	mov	%lp_count,64                    ; @0x74c
	add_s	%r0,%r14,56                     ; @0x750
	lp	.LZD4                           ; @0x752
.LBB3_9:                                ; %vector.body161
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x756
	std.ab	-1,[%r0,-8]                     ; @0x756
	std.ab	-1,[%r0,-8]                     ; @0x75a
	std.ab	-1,[%r0,-8]                     ; @0x75e
	std.ab	-1,[%r0,-8]                     ; @0x762
	std.ab	-1,[%r0,-8]                     ; @0x766
	std.ab	-1,[%r0,-8]                     ; @0x76a
	std.ab	-1,[%r0,-8]                     ; @0x76e
	std.ab	-1,[%r0,120]                    ; @0x772
	std.ab	-1,[%r0,-8]                     ; @0x776
	std.ab	-1,[%r0,-8]                     ; @0x77a
	std.ab	-1,[%r0,-8]                     ; @0x77e
	std.ab	-1,[%r0,-8]                     ; @0x782
	std.ab	-1,[%r0,-8]                     ; @0x786
	std.ab	-1,[%r0,-8]                     ; @0x78a
	std.ab	-1,[%r0,-8]                     ; @0x78e
	std.ab	-1,[%r0,120]                    ; @0x792
	std.ab	-1,[%r0,-8]                     ; @0x796
	std.ab	-1,[%r0,-8]                     ; @0x79a
	std.ab	-1,[%r0,-8]                     ; @0x79e
	std.ab	-1,[%r0,-8]                     ; @0x7a2
	std.ab	-1,[%r0,-8]                     ; @0x7a6
	std.ab	-1,[%r0,-8]                     ; @0x7aa
	std.ab	-1,[%r0,-8]                     ; @0x7ae
	std.ab	-1,[%r0,120]                    ; @0x7b2
	std.ab	-1,[%r0,-8]                     ; @0x7b6
	std.ab	-1,[%r0,-8]                     ; @0x7ba
	std.ab	-1,[%r0,-8]                     ; @0x7be
	std.ab	-1,[%r0,-8]                     ; @0x7c2
	std.ab	-1,[%r0,-8]                     ; @0x7c6
	std.ab	-1,[%r0,-8]                     ; @0x7ca
	std.ab	-1,[%r0,-8]                     ; @0x7ce
	std.ab	-1,[%r0,120]                    ; @0x7d2
	std.ab	-1,[%r0,-8]                     ; @0x7d6
	std.ab	-1,[%r0,-8]                     ; @0x7da
	std.ab	-1,[%r0,-8]                     ; @0x7de
	std.ab	-1,[%r0,-8]                     ; @0x7e2
	std.ab	-1,[%r0,-8]                     ; @0x7e6
	std.ab	-1,[%r0,-8]                     ; @0x7ea
	std.ab	-1,[%r0,-8]                     ; @0x7ee
	std.ab	-1,[%r0,120]                    ; @0x7f2
	std.ab	-1,[%r0,-8]                     ; @0x7f6
	std.ab	-1,[%r0,-8]                     ; @0x7fa
	std.ab	-1,[%r0,-8]                     ; @0x7fe
	std.ab	-1,[%r0,-8]                     ; @0x802
	std.ab	-1,[%r0,-8]                     ; @0x806
	std.ab	-1,[%r0,-8]                     ; @0x80a
	std.ab	-1,[%r0,-8]                     ; @0x80e
	std.ab	-1,[%r0,120]                    ; @0x812
	std.ab	-1,[%r0,-8]                     ; @0x816
	std.ab	-1,[%r0,-8]                     ; @0x81a
	std.ab	-1,[%r0,-8]                     ; @0x81e
	std.ab	-1,[%r0,-8]                     ; @0x822
	std.ab	-1,[%r0,-8]                     ; @0x826
	std.ab	-1,[%r0,-8]                     ; @0x82a
	std.ab	-1,[%r0,-8]                     ; @0x82e
	std.ab	-1,[%r0,120]                    ; @0x832
	std.ab	-1,[%r0,-8]                     ; @0x836
	std.ab	-1,[%r0,-8]                     ; @0x83a
	std.ab	-1,[%r0,-8]                     ; @0x83e
	std.ab	-1,[%r0,-8]                     ; @0x842
	std.ab	-1,[%r0,-8]                     ; @0x846
	std.ab	-1,[%r0,-8]                     ; @0x84a
	std.ab	-1,[%r0,-8]                     ; @0x84e
	std.ab	-1,[%r0,120]                    ; @0x852
.LZD4:                                  ; @0x856
	; ZD Loop End                           ; @0x856
;  %bb.10:                              ; %init_vector.exit128
	nop_s                                   ; inserted to benefit BPU
                                        ; @0x856
	bl	clock                           ; @0x858
	ld	%r16,[%sp,132]                  ; 8-byte Folded Reload
                                        ; @0x85c
	mov_s	%r2,0                           ; @0x860
	mov_s	%r13,%r0                        ; @0x862
	mov_s	%r15,%r14                       ; @0x864
	mov_s	%r23,%r22                       ; @0x866
	mov_s	%r0,%r20                        ; @0x868
	mov_s	%r1,%r20                        ; @0x86a
	mov_s	%r4,%r16                        ; @0x86c
	mov_s	%r17,%r2                        ; @0x86e
	mov_s	%r3,0                           ; @0x870
	mov_s	%r5,0                           ; @0x872
	mov_s	%r6,1                           ; @0x874
	mov_s	%r7,0                           ; @0x876
	st	%r16,[%sp,64]                   ; @0x878
	std	1,[%sp,56]                      ; @0x87c
	std	%r16,[%sp,48]                   ; @0x880
	std	0,[%sp,40]                      ; @0x884
	std	%r14,[%sp,32]                   ; @0x888
	std	1,[%sp,24]                      ; @0x88c
	std	%r16,[%sp,16]                   ; @0x890
	std	0,[%sp,8]                       ; @0x894
	std	%r22,[%sp,0]                    ; @0x898
	bl	vekt_vec_sum                    ; @0x89c
	mov_s	%r18,%r17                       ; @0x8a0
	bl	clock                           ; @0x8a2
	sub_s	%r0,%r0,%r13                    ; @0x8a6
	fint2d	%r2,%r0                         ; @0x8a8
	fdmul	%r16,%r2,%r18                   ; @0x8ac
	bl	_timer_clocks_per_sec           ; @0x8b0
	fuint2d	%r2,%r0                         ; @0x8b4
	fddiv	%r16,%r16,%r2                   ; @0x8b8
	add	%r0,%fp,.L.str.8-.L.str.5       ; @0x8bc
	mov_s	%r1,%r16                        ; @0x8c0
	mov_s	%r2,%r17                        ; @0x8c2
	bl	printf                          ; @0x8c4
	ldd	%r2,[%sp,124]                   ; 8-byte Folded Reload
                                        ; @0x8c8
	mov_s	%r0,%r24                        ; @0x8cc
	fddiv	%r2,%r2,%r16                    ; @0x8ce
	mov_s	%r1,%r2                         ; @0x8d2
	mov_s	%r2,%r3                         ; @0x8d4
	bl	printf                          ; @0x8d6
	ld	%r0,[%sp,140]                   ; 4-byte Folded Reload
                                        ; @0x8da
	bl	puts                            ; @0x8de
	ld_s	%r2,[%r20,0]                    ; @0x8e2
	ld	%r4,[%r22,0]                    ; @0x8e4
	ld	%r6,[%r14,0]                    ; @0x8e8
	mov_s	%r0,%r21                        ; @0x8ec
	mov_s	%r1,0                           ; @0x8ee
	mov_s	%r3,0                           ; @0x8f0
	mov_s	%r5,0                           ; @0x8f2
	bl	printf                          ; @0x8f4
	ld_s	%r2,[%r20,4]                    ; @0x8f8
	ld	%r4,[%r22,4]                    ; @0x8fa
	ld	%r6,[%r14,4]                    ; @0x8fe
	mov_s	%r0,%r21                        ; @0x902
	mov_s	%r1,1                           ; @0x904
	mov_s	%r3,1                           ; @0x906
	mov_s	%r5,1                           ; @0x908
	bl	printf                          ; @0x90a
	ld_s	%r2,[%r20,8]                    ; @0x90e
	ld	%r4,[%r22,8]                    ; @0x910
	ld	%r6,[%r14,8]                    ; @0x914
	mov_s	%r0,%r21                        ; @0x918
	mov_s	%r1,2                           ; @0x91a
	mov_s	%r3,2                           ; @0x91c
	mov_s	%r5,2                           ; @0x91e
	bl	printf                          ; @0x920
	ld_s	%r2,[%r20,12]                   ; @0x924
	ld	%r4,[%r22,12]                   ; @0x926
	ld	%r6,[%r14,12]                   ; @0x92a
	mov_s	%r0,%r21                        ; @0x92e
	mov_s	%r1,3                           ; @0x930
	mov_s	%r3,3                           ; @0x932
	mov_s	%r5,3                           ; @0x934
	bl	printf                          ; @0x936
	ld_s	%r2,[%r20,16]                   ; @0x93a
	ld	%r4,[%r22,16]                   ; @0x93c
	ld	%r6,[%r14,16]                   ; @0x940
	mov_s	%r0,%r21                        ; @0x944
	mov_s	%r1,4                           ; @0x946
	mov_s	%r3,4                           ; @0x948
	mov_s	%r5,4                           ; @0x94a
	bl	printf                          ; @0x94c
	mov_s	%r0,0                           ; @0x950
	add_s	%sp,%sp,68                      ; @0x952
	.cfa_pop	68                              ; @0x954
	ld	%blink,[%sp,52]                 ; @0x954
	.cfa_restore	{%blink}                ; @0x958
	ld	%fp,[%sp,48]                    ; @0x958
	.cfa_restore	{%fp}                   ; @0x95c
	ld	%r24,[%sp,44]                   ; @0x95c
	.cfa_restore	{%r24}                  ; @0x960
	ldd	%r22,[%sp,36]                   ; @0x960
	.cfa_restore	{%r23}                  ; @0x964
	.cfa_restore	{%r22}                  ; @0x964
	ldd	%r20,[%sp,28]                   ; @0x964
	.cfa_restore	{%r21}                  ; @0x968
	.cfa_restore	{%r20}                  ; @0x968
	ldd	%r18,[%sp,20]                   ; @0x968
	.cfa_restore	{%r19}                  ; @0x96c
	.cfa_restore	{%r18}                  ; @0x96c
	ldd	%r16,[%sp,12]                   ; @0x96c
	.cfa_restore	{%r17}                  ; @0x970
	.cfa_restore	{%r16}                  ; @0x970
	ldd	%r14,[%sp,4]                    ; @0x970
	.cfa_restore	{%r15}                  ; @0x974
	.cfa_restore	{%r14}                  ; @0x974
	ld.ab	%r13,[%sp,76]                   ; @0x974
	.cfa_restore	{%r13}                  ; @0x978
	.cfa_pop	76                              ; @0x978
	j_s	[%blink]                        ; @0x978
	.cfa_ef
.Lfunc_end3:                            ; @0x97a

	.reloc	_init_ad,0	;startup code to enable %status AD bit ; -- End function
