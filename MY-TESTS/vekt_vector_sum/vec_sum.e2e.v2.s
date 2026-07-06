	.option	%reg
	.off	assume_short
	.file	"LLVMDialectModule"
	.globl	vekt_vec_sum
	.type	vekt_vec_sum,@function
	.size	vekt_vec_sum, .Lfunc_end0-vekt_vec_sum
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
	.ident	"LLVM 17.0.7/V-2024.06. (build 008) (LLVM 17.0.7) -arcv2hs -core4 -Xcode_density -Xatomic -Xll64 -Xunaligned -Xdiv_rem=radix4 -Xswap -Xbitscan -Xmpy_option=mpyd -Xshift_assist -Xbarrel_shifter -Xfpud_div -Xfpu_mac -Xtimer0 -Xrtc -Xstack_check -Xstu=4 -Xvdsp4 -Xvec_unit_rev_minor=1 -Xvec_width=512 -Xvec_mem_size=128k -Xvec_mem_bank_width=16 -Xvec_max_fetch_size=16 -Xvec_num_slots=3 -Xvec_super_with_scalar -Xvec_regs=32 -Xvec_fpu=32 -Xvec_fpu_math=3 -Xvec_fpu_2nd_mul -Xvec_fpu_types=2 -Xvec_num_rd_ports=6 -Xvec_num_acc=8 -Xvec_num_mpy=2 -Xvec_mpy32 -Xvec_num_alu=3 -Xvec_guard_bit_option=0 -Xvec_stack_check -Hvdsp_vector_c -O2"
	.align	8                               ; -- Begin function vekt_vec_sum
vekt_vec_sum:                           ; @vekt_vec_sum
                                        ; @0x0
	.cfa_bf	vekt_vec_sum
;  %bb.0:
	.cfa_same	%r30                    ; @0x0
	.cfa_same	%r9                     ; @0x0
	.cfa_same	%r7                     ; @0x0
	.cfa_same	%r6                     ; @0x0
	.cfa_same	%r5                     ; @0x0
	.cfa_same	%r4                     ; @0x0
	.cfa_same	%r1                     ; @0x0
	ld_s	%r0,[%sp,64]                    ; @0x0
	cmp_s	%r0,0                           ; @0x2
	.cfa_remember_state                     ; @0x4
	jle	[%blink]                        ; @0x4
	.cfa_restore_state                      ; @0x8
;  %bb.1:                               ; %.lr.ph.preheader
	; Implicit def %r2                      ; @0x8
	ld	%r11,[%sp,36]                   ; @0x8
	ld	%r8,[%sp,4]                     ; @0xc
	add_s	%r0,%r0,-1                      ; @0x10
	lsr	%r3,%r0,4                       ; @0x12
	add	%lp_count,%r3,1                 ; @0x16
	mov_s	%r3,0                           ; @0x1a
	lp	.LZD0                           ; @0x1c
.LBB0_2:                                ; %.lr.ph
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x20
	add2	%r12,%r1,%r3                    ; @0x20
	add2	%r0,%r8,%r3                     ; @0x24
.vvsbundle  "v1sc" 
 ;	 { 
	vvld.w	%vr0,%r12                       ; @0x28
	add2	%r2,%r11,%r3                    ; @0x28
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvld.w	%vr1,%r0                        ; @0x30
	add_s	%r3,%r3,16                      ; @0x30
 ;	 }
	vvadd.w	%vr0, %vr1, %vr0                ; @0x36
	vvst.w	%vr0,%r2                        ; @0x3c
.LZD0:                                  ; @0x40
	; ZD Loop End                           ; @0x40
;  %bb.3:                               ; %._crit_edge
	j_s	[%blink]                        ; @0x40
	.cfa_ef
.Lfunc_end0:                            ; @0x42

	.reloc	_init_ad,0	;startup code to enable %status AD bit ; -- End function
