	.option	%reg
	.off	assume_short
	.file	"vectorized_vec_sum.c"
	.globl	vectorized_vec_sum
	.type	vectorized_vec_sum,@function
	.type	.Lvectorized_vec_sum$local,@function
	.size	vectorized_vec_sum, .Lfunc_end0-vectorized_vec_sum
	.size	.Lvectorized_vec_sum$local, .Lfunc_end0-vectorized_vec_sum
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
	.text
	.global	.CC_I
	.equ	.CC_I, 0
	.ident	"LLVM 17.0.7/V-2024.06. (build 008) (LLVM 17.0.7) -arcv2hs -core4 -Xcode_density -Xatomic -Xll64 -Xunaligned -Xdiv_rem=radix4 -Xswap -Xbitscan -Xmpy_option=mpyd -Xshift_assist -Xbarrel_shifter -Xfpud_div -Xfpu_mac -Xtimer0 -Xrtc -Xstack_check -Xstu=4 -Xvdsp4 -Xvec_unit_rev_minor=1 -Xvec_width=512 -Xvec_mem_size=128k -Xvec_mem_bank_width=16 -Xvec_max_fetch_size=16 -Xvec_num_slots=3 -Xvec_super_with_scalar -Xvec_regs=32 -Xvec_fpu=32 -Xvec_fpu_math=3 -Xvec_fpu_2nd_mul -Xvec_fpu_types=2 -Xvec_num_rd_ports=6 -Xvec_num_acc=8 -Xvec_num_mpy=2 -Xvec_mpy32 -Xvec_num_alu=3 -Xvec_guard_bit_option=0 -Xvec_stack_check -Hvdsp_vector_c -O2 -fvectorize -fslp-vectorize -ffast-math"
	.align	8                               ; -- Begin function vectorized_vec_sum
vectorized_vec_sum:                     ; @vectorized_vec_sum
                                        ; @0x0
.Lvectorized_vec_sum$local:             ; @0x0
	.cfa_bf	.Lvectorized_vec_sum$local
;  %bb.0:                               ; %entry
	.cfa_same	%r30                    ; @0x0
	.cfa_same	%r11                    ; @0x0
	.cfa_same	%r9                     ; @0x0
	.cfa_same	%r8                     ; @0x0
	.cfa_same	%r7                     ; @0x0
	.cfa_same	%r6                     ; @0x0
	.cfa_same	%r5                     ; @0x0
	.cfa_same	%r4                     ; @0x0
	cmp_s	%r3,16                          ; @0x0
	.cfa_remember_state                     ; @0x2
	jlt	[%blink]                        ; @0x2
	.cfa_restore_state                      ; @0x6
;  %bb.1:                               ; %for.body.preheader
	asr	%r12,%r3,31                     ; @0x6
	lsr_s	%r12,%r12,28                    ; @0xa
	add_s	%r3,%r3,%r12                    ; @0xc
	; Implicit def %r12                     ; @0xe
	asr	%lp_count,%r3,4                 ; @0xe
	lp	.LZD0                           ; @0x12
.LBB0_2:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x16
	vvld.av.w	%vr0,%r1,1              ; @0x16
	vvld.av.w	%vr1,%r0,1              ; @0x1c
	vvadd.w	%vr0, %vr1, %vr0                ; @0x22
	vvst.av.w	%vr0,%r2,1              ; @0x28
.LZD0:                                  ; @0x2e
	; ZD Loop End                           ; @0x2e
;  %bb.3:                               ; %for.cond.cleanup
	j_s	[%blink]                        ; @0x2e
	.cfa_ef
.Lfunc_end0:                            ; @0x30

	.reloc	_init_ad,0	;startup code to enable %status AD bit ; -- End function
