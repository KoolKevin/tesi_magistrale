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
	.ident	"LLVM 17.0.7/V-2024.06. (build 008) (LLVM 17.0.7) -arcv2hs -core4 -Xcode_density -Xatomic -Xll64 -Xunaligned -Xdiv_rem=radix4 -Xswap -Xbitscan -Xmpy_option=mpyd -Xshift_assist -Xbarrel_shifter -Xfpud_div -Xfpu_mac -Xtimer0 -Xrtc -Xstack_check -Xstu=4 -Xvdsp4 -Xvec_unit_rev_minor=1 -Xvec_width=512 -Xvec_mem_size=128k -Xvec_mem_bank_width=16 -Xvec_max_fetch_size=16 -Xvec_num_slots=3 -Xvec_super_with_scalar -Xvec_regs=32 -Xvec_fpu=32 -Xvec_fpu_math=3 -Xvec_fpu_2nd_mul -Xvec_fpu_types=2 -Xvec_num_rd_ports=6 -Xvec_num_acc=8 -Xvec_num_mpy=2 -Xvec_mpy32 -Xvec_num_alu=3 -Xvec_guard_bit_option=0 -Xvec_stack_check -Hvdsp_vector_c -O1"
	.align	4                               ; -- Begin function vekt_vec_sum
vekt_vec_sum:                           ; @vekt_vec_sum
                                        ; @0x0
	.cfa_bf	vekt_vec_sum
;  %bb.0:
	.cfa_same	%r30                    ; @0x0
	.cfa_same	%r7                     ; @0x0
	.cfa_same	%r5                     ; @0x0
	.cfa_same	%r4                     ; @0x0
	.cfa_same	%r1                     ; @0x0
	ld	%r11,[%sp,64]                   ; @0x0
	brlt	%r11,1,.LBB0_3                  ; @0x4
;  %bb.1:                               ; %.lr.ph.preheader
	ld	%r8,[%sp,36]                    ; @0x8
	ld	%r9,[%sp,4]                     ; @0xc
	asr	%r6,%r11,31                     ; @0x10
	mov_s	%r12,0                          ; @0x14
	mov_s	%r2,0                           ; @0x16
.LBB0_2:                                ; %.lr.ph
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x18
	add2	%r3,%r1,%r12                    ; @0x18
.vvsbundle  "v1sc" 
 ;	 { 
	vvld.w	%vr0,%r3                        ; @0x1c
	add2	%r3,%r9,%r12                    ; @0x1c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvld.w	%vr1,%r3                        ; @0x24
	add2	%r3,%r8,%r12                    ; @0x24
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvadd.w	%vr0, %vr1, %vr0                ; @0x2c
	add.f	%r12,%r12,16                    ; @0x2c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvst.w	%vr0,%r3                        ; @0x36
	adc.f	%r2,%r2,0                       ; @0x36
 ;	 }
	setlo	%r3,%r12,%r11                   ; @0x3e
	setlt	%r0,%r2,%r6                     ; @0x42
	cmp_s	%r2,%r6                         ; @0x46
	mov.eq	%r0,%r3                         ; @0x48
	brne_s	%r0,0,.LBB0_2                   ; @0x4c
.LBB0_3:                                ; %._crit_edge
                                        ; @0x4e
	j_s	[%blink]                        ; @0x4e
	.cfa_ef
.Lfunc_end0:                            ; @0x50

	.reloc	_init_ad,0	;startup code to enable %status AD bit ; -- End function
