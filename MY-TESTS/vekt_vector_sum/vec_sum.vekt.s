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
	.cfa_same	%r4                     ; @0x0
	.cfa_same	%r1                     ; @0x0
	sub_s	%sp,%sp,44                      ; @0x0
	.cfa_push	44                      ; @0x2
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
	st	%r20,[%sp,28]                   ; @0x12
	.cfa_reg_offset	{%r20}, 28              ; @0x16
	st	%blink,[%sp,32]                 ; @0x16
	.cfa_reg_offset	{%blink}, 32            ; @0x1a
	ld	%r7,[%sp,108]                   ; @0x1a
	cmp_s	%r7,0                           ; @0x1e
	ble	.LBB0_99                        ; @0x20
;  %bb.1:                               ; %.lr.ph.preheader
.vvsbundle  "v1sc" 
 ;	 { 
	vvci.w	%vr0                            ; @0x24
	ld	%r11,[%sp,92]                   ; @0x24
 ;	 }
	ld	%r8,[%sp,60]                    ; @0x2c
	ld	%r9,[%sp,80]                    ; @0x30
	ld	%r6,[%sp,48]                    ; @0x34
	mov_s	%r20,0x800@u32                  ; @0x38
	asl	%r18,%r20,2                     ; @0x3e
	asl	%r19,%r20,3                     ; @0x42
	asr	%r12,%r7,31                     ; @0x46
	mov_s	%r3,0                           ; @0x4a
	mov	%r5,64                          ; @0x4c
	mov	%r30,128                        ; @0x50
	mov	%blink,256                      ; @0x54
	mov	%r16,512                        ; @0x58
	mov	%r17,1024                       ; @0x5c
	asl	%r13,%r20                       ; @0x60
	mov_s	%r2,0                           ; @0x64
.LBB0_2:                                ; %.lr.ph
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x66
	sub	%r14,%r4,%r3                    ; @0x66
	vvmov.w	 %vr1, %r14                     ; @0x6a
	vvpcmp.gt.w	%p1,%vr1,%vr0           ; @0x6e
	vvpeven.h	%p1, %p1                ; @0x74
	vvpmovps	%r14, %p1, 0                    ; @0x78
	st	%r14,[%sp,42]                   ; @0x7e
	ldh	%r15,[%sp,42]                   ; @0x82
	add2	%r14,%r1,%r3                    ; @0x86
	and	%r0,%r15,1                      ; @0x8a
	breq_s	%r0,0,.LBB0_4                   ; @0x8e
;  %bb.3:                               ; %cond.load
                                        ;   in Loop: Header=BB0_2 Depth=1
	ld_s	%r0,[%r14,0]                    ; @0x90
	vvmov.w	 %vr1, %r0                      ; @0x92
.LBB0_4:                                ; %else
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0x96
	sexh_s	%r15,%r15                       ; @0x96
	and	%r0,%r15,2                      ; @0x98
	breq_s	%r0,0,.LBB0_6                   ; @0x9c
;  %bb.5:                               ; %cond.load1
                                        ;   in Loop: Header=BB0_2 Depth=1
	ld_s	%r0,[%r14,4]                    ; @0x9e
	vvmov1.vi.to.w	%vr1,1,%r0              ; @0xa0
.LBB0_6:                                ; %else2
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0xa6
	and	%r0,%r15,4                      ; @0xa6
	breq_s	%r0,0,.LBB0_8                   ; @0xaa
;  %bb.7:                               ; %cond.load4
                                        ;   in Loop: Header=BB0_2 Depth=1
	ld_s	%r0,[%r14,8]                    ; @0xac
	vvmov1.vi.to.w	%vr1,2,%r0              ; @0xae
.LBB0_8:                                ; %else5
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0xb4
	and	%r0,%r15,8                      ; @0xb4
	breq_s	%r0,0,.LBB0_10                  ; @0xb8
;  %bb.9:                               ; %cond.load7
                                        ;   in Loop: Header=BB0_2 Depth=1
	ld_s	%r0,[%r14,12]                   ; @0xba
	vvmov1.vi.to.w	%vr1,3,%r0              ; @0xbc
.LBB0_10:                               ; %else8
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0xc2
	and	%r0,%r15,16                     ; @0xc2
	breq_s	%r0,0,.LBB0_12                  ; @0xc6
;  %bb.11:                              ; %cond.load10
                                        ;   in Loop: Header=BB0_2 Depth=1
	ld_s	%r0,[%r14,16]                   ; @0xc8
	vvmov1.vi.to.w	%vr1,4,%r0              ; @0xca
.LBB0_12:                               ; %else11
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0xd0
	and	%r0,%r15,32                     ; @0xd0
	breq_s	%r0,0,.LBB0_14                  ; @0xd4
;  %bb.13:                              ; %cond.load13
                                        ;   in Loop: Header=BB0_2 Depth=1
	ld_s	%r0,[%r14,20]                   ; @0xd6
	vvmov1.vi.to.w	%vr1,5,%r0              ; @0xd8
.LBB0_14:                               ; %else14
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0xde
	and	%r0,%r15,%r5                    ; @0xde
	breq_s	%r0,0,.LBB0_16                  ; @0xe2
;  %bb.15:                              ; %cond.load16
                                        ;   in Loop: Header=BB0_2 Depth=1
	ld_s	%r0,[%r14,24]                   ; @0xe4
	vvmov1.vi.to.w	%vr1,6,%r0              ; @0xe6
.LBB0_16:                               ; %else17
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0xec
	and	%r0,%r15,%r30                   ; @0xec
	breq_s	%r0,0,.LBB0_18                  ; @0xf0
;  %bb.17:                              ; %cond.load19
                                        ;   in Loop: Header=BB0_2 Depth=1
	ld_s	%r0,[%r14,28]                   ; @0xf2
	vvmov1.vi.to.w	%vr1,7,%r0              ; @0xf4
.LBB0_18:                               ; %else20
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0xfa
	and	%r0,%r15,%blink                 ; @0xfa
	breq_s	%r0,0,.LBB0_20                  ; @0xfe
;  %bb.19:                              ; %cond.load22
                                        ;   in Loop: Header=BB0_2 Depth=1
	ld_s	%r0,[%r14,32]                   ; @0x100
	vvmov1.vi.to.w	%vr1,8,%r0              ; @0x102
.LBB0_20:                               ; %else23
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0x108
	and	%r0,%r15,%r16                   ; @0x108
	breq_s	%r0,0,.LBB0_22                  ; @0x10c
;  %bb.21:                              ; %cond.load25
                                        ;   in Loop: Header=BB0_2 Depth=1
	ld_s	%r0,[%r14,36]                   ; @0x10e
	vvmov1.vi.to.w	%vr1,9,%r0              ; @0x110
.LBB0_22:                               ; %else26
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0x116
	and	%r0,%r15,%r17                   ; @0x116
	breq_s	%r0,0,.LBB0_24                  ; @0x11a
;  %bb.23:                              ; %cond.load28
                                        ;   in Loop: Header=BB0_2 Depth=1
	ld_s	%r0,[%r14,40]                   ; @0x11c
	vvmov1.vi.to.w	%vr1,10,%r0             ; @0x11e
.LBB0_24:                               ; %else29
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0x124
	and	%r0,%r15,%r20                   ; @0x124
	breq_s	%r0,0,.LBB0_26                  ; @0x128
;  %bb.25:                              ; %cond.load31
                                        ;   in Loop: Header=BB0_2 Depth=1
	ld_s	%r0,[%r14,44]                   ; @0x12a
	vvmov1.vi.to.w	%vr1,11,%r0             ; @0x12c
.LBB0_26:                               ; %else32
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0x132
	and	%r0,%r15,%r13                   ; @0x132
	breq_s	%r0,0,.LBB0_28                  ; @0x136
;  %bb.27:                              ; %cond.load34
                                        ;   in Loop: Header=BB0_2 Depth=1
	ld_s	%r0,[%r14,48]                   ; @0x138
	vvmov1.vi.to.w	%vr1,12,%r0             ; @0x13a
.LBB0_28:                               ; %else35
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0x140
	and	%r0,%r15,%r18                   ; @0x140
	breq_s	%r0,0,.LBB0_30                  ; @0x144
;  %bb.29:                              ; %cond.load37
                                        ;   in Loop: Header=BB0_2 Depth=1
	ld_s	%r0,[%r14,52]                   ; @0x146
	vvmov1.vi.to.w	%vr1,13,%r0             ; @0x148
.LBB0_30:                               ; %else38
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0x14e
	and	%r0,%r15,%r19                   ; @0x14e
	breq_s	%r0,0,.LBB0_32                  ; @0x152
;  %bb.31:                              ; %cond.load40
                                        ;   in Loop: Header=BB0_2 Depth=1
	ld_s	%r0,[%r14,56]                   ; @0x154
	vvmov1.vi.to.w	%vr1,14,%r0             ; @0x156
.LBB0_32:                               ; %else41
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0x15c
	brge	%r15,0,.LBB0_34                 ; @0x15c
;  %bb.33:                              ; %cond.load43
                                        ;   in Loop: Header=BB0_2 Depth=1
	ld_s	%r0,[%r14,60]                   ; @0x160
	vvmov1.vi.to.w	%vr1,15,%r0             ; @0x162
.LBB0_34:                               ; %else44
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0x168
	sub	%r0,%r8,%r3                     ; @0x168
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr2, %r0                      ; @0x16c
	add2	%r14,%r6,%r3                    ; @0x16c
 ;	 }
	vvpcmp.gt.w	%p1,%vr2,%vr0           ; @0x174
	vvpeven.h	%p1, %p1                ; @0x17a
	vvpmovps	%r0, %p1, 0                     ; @0x17e
	st	%r0,[%sp,40]                    ; @0x184
	ldh	%r15,[%sp,40]                   ; @0x188
	and	%r0,%r15,1                      ; @0x18c
	breq_s	%r0,0,.LBB0_36                  ; @0x190
;  %bb.35:                              ; %cond.load47
                                        ;   in Loop: Header=BB0_2 Depth=1
	ld_s	%r0,[%r14,0]                    ; @0x192
	vvmov.w	 %vr2, %r0                      ; @0x194
.LBB0_36:                               ; %else48
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0x198
	sexh_s	%r15,%r15                       ; @0x198
	and	%r0,%r15,2                      ; @0x19a
	breq_s	%r0,0,.LBB0_38                  ; @0x19e
;  %bb.37:                              ; %cond.load50
                                        ;   in Loop: Header=BB0_2 Depth=1
	ld_s	%r0,[%r14,4]                    ; @0x1a0
	vvmov1.vi.to.w	%vr2,1,%r0              ; @0x1a2
.LBB0_38:                               ; %else51
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0x1a8
	and	%r0,%r15,4                      ; @0x1a8
	breq_s	%r0,0,.LBB0_40                  ; @0x1ac
;  %bb.39:                              ; %cond.load53
                                        ;   in Loop: Header=BB0_2 Depth=1
	ld_s	%r0,[%r14,8]                    ; @0x1ae
	vvmov1.vi.to.w	%vr2,2,%r0              ; @0x1b0
.LBB0_40:                               ; %else54
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0x1b6
	and	%r0,%r15,8                      ; @0x1b6
	breq_s	%r0,0,.LBB0_42                  ; @0x1ba
;  %bb.41:                              ; %cond.load56
                                        ;   in Loop: Header=BB0_2 Depth=1
	ld_s	%r0,[%r14,12]                   ; @0x1bc
	vvmov1.vi.to.w	%vr2,3,%r0              ; @0x1be
.LBB0_42:                               ; %else57
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0x1c4
	and	%r0,%r15,16                     ; @0x1c4
	breq_s	%r0,0,.LBB0_44                  ; @0x1c8
;  %bb.43:                              ; %cond.load59
                                        ;   in Loop: Header=BB0_2 Depth=1
	ld_s	%r0,[%r14,16]                   ; @0x1ca
	vvmov1.vi.to.w	%vr2,4,%r0              ; @0x1cc
.LBB0_44:                               ; %else60
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0x1d2
	and	%r0,%r15,32                     ; @0x1d2
	breq_s	%r0,0,.LBB0_46                  ; @0x1d6
;  %bb.45:                              ; %cond.load62
                                        ;   in Loop: Header=BB0_2 Depth=1
	ld_s	%r0,[%r14,20]                   ; @0x1d8
	vvmov1.vi.to.w	%vr2,5,%r0              ; @0x1da
.LBB0_46:                               ; %else63
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0x1e0
	and	%r0,%r15,%r5                    ; @0x1e0
	breq_s	%r0,0,.LBB0_48                  ; @0x1e4
;  %bb.47:                              ; %cond.load65
                                        ;   in Loop: Header=BB0_2 Depth=1
	ld_s	%r0,[%r14,24]                   ; @0x1e6
	vvmov1.vi.to.w	%vr2,6,%r0              ; @0x1e8
.LBB0_48:                               ; %else66
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0x1ee
	and	%r0,%r15,%r30                   ; @0x1ee
	breq_s	%r0,0,.LBB0_50                  ; @0x1f2
;  %bb.49:                              ; %cond.load68
                                        ;   in Loop: Header=BB0_2 Depth=1
	ld_s	%r0,[%r14,28]                   ; @0x1f4
	vvmov1.vi.to.w	%vr2,7,%r0              ; @0x1f6
.LBB0_50:                               ; %else69
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0x1fc
	and	%r0,%r15,%blink                 ; @0x1fc
	breq_s	%r0,0,.LBB0_52                  ; @0x200
;  %bb.51:                              ; %cond.load71
                                        ;   in Loop: Header=BB0_2 Depth=1
	ld_s	%r0,[%r14,32]                   ; @0x202
	vvmov1.vi.to.w	%vr2,8,%r0              ; @0x204
.LBB0_52:                               ; %else72
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0x20a
	and	%r0,%r15,%r16                   ; @0x20a
	breq_s	%r0,0,.LBB0_54                  ; @0x20e
;  %bb.53:                              ; %cond.load74
                                        ;   in Loop: Header=BB0_2 Depth=1
	ld_s	%r0,[%r14,36]                   ; @0x210
	vvmov1.vi.to.w	%vr2,9,%r0              ; @0x212
.LBB0_54:                               ; %else75
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0x218
	and	%r0,%r15,%r17                   ; @0x218
	breq_s	%r0,0,.LBB0_56                  ; @0x21c
;  %bb.55:                              ; %cond.load77
                                        ;   in Loop: Header=BB0_2 Depth=1
	ld_s	%r0,[%r14,40]                   ; @0x21e
	vvmov1.vi.to.w	%vr2,10,%r0             ; @0x220
.LBB0_56:                               ; %else78
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0x226
	and	%r0,%r15,%r20                   ; @0x226
	breq_s	%r0,0,.LBB0_58                  ; @0x22a
;  %bb.57:                              ; %cond.load80
                                        ;   in Loop: Header=BB0_2 Depth=1
	ld_s	%r0,[%r14,44]                   ; @0x22c
	vvmov1.vi.to.w	%vr2,11,%r0             ; @0x22e
.LBB0_58:                               ; %else81
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0x234
	and	%r0,%r15,%r13                   ; @0x234
	breq_s	%r0,0,.LBB0_60                  ; @0x238
;  %bb.59:                              ; %cond.load83
                                        ;   in Loop: Header=BB0_2 Depth=1
	ld_s	%r0,[%r14,48]                   ; @0x23a
	vvmov1.vi.to.w	%vr2,12,%r0             ; @0x23c
.LBB0_60:                               ; %else84
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0x242
	and	%r0,%r15,%r18                   ; @0x242
	breq_s	%r0,0,.LBB0_62                  ; @0x246
;  %bb.61:                              ; %cond.load86
                                        ;   in Loop: Header=BB0_2 Depth=1
	ld_s	%r0,[%r14,52]                   ; @0x248
	vvmov1.vi.to.w	%vr2,13,%r0             ; @0x24a
.LBB0_62:                               ; %else87
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0x250
	and	%r0,%r15,%r19                   ; @0x250
	breq_s	%r0,0,.LBB0_64                  ; @0x254
;  %bb.63:                              ; %cond.load89
                                        ;   in Loop: Header=BB0_2 Depth=1
	ld_s	%r0,[%r14,56]                   ; @0x256
	vvmov1.vi.to.w	%vr2,14,%r0             ; @0x258
.LBB0_64:                               ; %else90
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0x25e
	brge	%r15,0,.LBB0_66                 ; @0x25e
;  %bb.65:                              ; %cond.load92
                                        ;   in Loop: Header=BB0_2 Depth=1
	ld_s	%r0,[%r14,60]                   ; @0x262
	vvmov1.vi.to.w	%vr2,15,%r0             ; @0x264
.LBB0_66:                               ; %else93
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0x26a
.vvsbundle  "v1sc" 
 ;	 { 
	vvadd.w	%vr1, %vr2, %vr1                ; @0x26a
	sub	%r0,%r11,%r3                    ; @0x26a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr2, %r0                      ; @0x274
	add2	%r14,%r9,%r3                    ; @0x274
 ;	 }
	vvpcmp.gt.w	%p1,%vr2,%vr0           ; @0x27c
	vvpeven.h	%p1, %p1                ; @0x282
	vvpmovps	%r0, %p1, 0                     ; @0x286
	st	%r0,[%sp,38]                    ; @0x28c
	ldh	%r15,[%sp,38]                   ; @0x290
	and	%r0,%r15,1                      ; @0x294
	breq_s	%r0,0,.LBB0_68                  ; @0x298
;  %bb.67:                              ; %cond.store
                                        ;   in Loop: Header=BB0_2 Depth=1
	vvmov1.x.from.w	%r0,%vr1,0              ; @0x29a
	st_s	%r0,[%r14,0]                    ; @0x2a0
.LBB0_68:                               ; %else96
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0x2a2
	sexh_s	%r15,%r15                       ; @0x2a2
	and	%r0,%r15,2                      ; @0x2a4
	breq_s	%r0,0,.LBB0_70                  ; @0x2a8
;  %bb.69:                              ; %cond.store97
                                        ;   in Loop: Header=BB0_2 Depth=1
	vvmov1.x.from.w	%r0,%vr1,1              ; @0x2aa
	st_s	%r0,[%r14,4]                    ; @0x2b0
.LBB0_70:                               ; %else98
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0x2b2
	and	%r0,%r15,4                      ; @0x2b2
	breq_s	%r0,0,.LBB0_72                  ; @0x2b6
;  %bb.71:                              ; %cond.store99
                                        ;   in Loop: Header=BB0_2 Depth=1
	vvmov1.x.from.w	%r0,%vr1,2              ; @0x2b8
	st_s	%r0,[%r14,8]                    ; @0x2be
.LBB0_72:                               ; %else100
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0x2c0
	and	%r0,%r15,8                      ; @0x2c0
	breq_s	%r0,0,.LBB0_74                  ; @0x2c4
;  %bb.73:                              ; %cond.store101
                                        ;   in Loop: Header=BB0_2 Depth=1
	vvmov1.x.from.w	%r0,%vr1,3              ; @0x2c6
	st_s	%r0,[%r14,12]                   ; @0x2cc
.LBB0_74:                               ; %else102
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0x2ce
	and	%r0,%r15,16                     ; @0x2ce
	breq_s	%r0,0,.LBB0_76                  ; @0x2d2
;  %bb.75:                              ; %cond.store103
                                        ;   in Loop: Header=BB0_2 Depth=1
	vvmov1.x.from.w	%r0,%vr1,4              ; @0x2d4
	st_s	%r0,[%r14,16]                   ; @0x2da
.LBB0_76:                               ; %else104
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0x2dc
	and	%r0,%r15,32                     ; @0x2dc
	breq_s	%r0,0,.LBB0_78                  ; @0x2e0
;  %bb.77:                              ; %cond.store105
                                        ;   in Loop: Header=BB0_2 Depth=1
	vvmov1.x.from.w	%r0,%vr1,5              ; @0x2e2
	st_s	%r0,[%r14,20]                   ; @0x2e8
.LBB0_78:                               ; %else106
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0x2ea
	and	%r0,%r15,%r5                    ; @0x2ea
	breq_s	%r0,0,.LBB0_80                  ; @0x2ee
;  %bb.79:                              ; %cond.store107
                                        ;   in Loop: Header=BB0_2 Depth=1
	vvmov1.x.from.w	%r0,%vr1,6              ; @0x2f0
	st_s	%r0,[%r14,24]                   ; @0x2f6
.LBB0_80:                               ; %else108
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0x2f8
	and	%r0,%r15,%r30                   ; @0x2f8
	breq_s	%r0,0,.LBB0_82                  ; @0x2fc
;  %bb.81:                              ; %cond.store109
                                        ;   in Loop: Header=BB0_2 Depth=1
	vvmov1.x.from.w	%r0,%vr1,7              ; @0x2fe
	st_s	%r0,[%r14,28]                   ; @0x304
.LBB0_82:                               ; %else110
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0x306
	and	%r0,%r15,%blink                 ; @0x306
	breq_s	%r0,0,.LBB0_84                  ; @0x30a
;  %bb.83:                              ; %cond.store111
                                        ;   in Loop: Header=BB0_2 Depth=1
	vvmov1.x.from.w	%r0,%vr1,8              ; @0x30c
	st_s	%r0,[%r14,32]                   ; @0x312
.LBB0_84:                               ; %else112
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0x314
	and	%r0,%r15,%r16                   ; @0x314
	breq_s	%r0,0,.LBB0_86                  ; @0x318
;  %bb.85:                              ; %cond.store113
                                        ;   in Loop: Header=BB0_2 Depth=1
	vvmov1.x.from.w	%r0,%vr1,9              ; @0x31a
	st_s	%r0,[%r14,36]                   ; @0x320
.LBB0_86:                               ; %else114
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0x322
	and	%r0,%r15,%r17                   ; @0x322
	breq_s	%r0,0,.LBB0_88                  ; @0x326
;  %bb.87:                              ; %cond.store115
                                        ;   in Loop: Header=BB0_2 Depth=1
	vvmov1.x.from.w	%r0,%vr1,10             ; @0x328
	st_s	%r0,[%r14,40]                   ; @0x32e
.LBB0_88:                               ; %else116
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0x330
	and	%r0,%r15,%r20                   ; @0x330
	breq_s	%r0,0,.LBB0_90                  ; @0x334
;  %bb.89:                              ; %cond.store117
                                        ;   in Loop: Header=BB0_2 Depth=1
	vvmov1.x.from.w	%r0,%vr1,11             ; @0x336
	st_s	%r0,[%r14,44]                   ; @0x33c
.LBB0_90:                               ; %else118
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0x33e
	and	%r0,%r15,%r13                   ; @0x33e
	breq_s	%r0,0,.LBB0_92                  ; @0x342
;  %bb.91:                              ; %cond.store119
                                        ;   in Loop: Header=BB0_2 Depth=1
	vvmov1.x.from.w	%r0,%vr1,12             ; @0x344
	st_s	%r0,[%r14,48]                   ; @0x34a
.LBB0_92:                               ; %else120
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0x34c
	and	%r0,%r15,%r18                   ; @0x34c
	breq_s	%r0,0,.LBB0_94                  ; @0x350
;  %bb.93:                              ; %cond.store121
                                        ;   in Loop: Header=BB0_2 Depth=1
	vvmov1.x.from.w	%r0,%vr1,13             ; @0x352
	st_s	%r0,[%r14,52]                   ; @0x358
.LBB0_94:                               ; %else122
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0x35a
	and	%r0,%r15,%r19                   ; @0x35a
	breq_s	%r0,0,.LBB0_96                  ; @0x35e
;  %bb.95:                              ; %cond.store123
                                        ;   in Loop: Header=BB0_2 Depth=1
	vvmov1.x.from.w	%r0,%vr1,14             ; @0x360
	st_s	%r0,[%r14,56]                   ; @0x366
.LBB0_96:                               ; %else124
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0x368
	brge	%r15,0,.LBB0_98                 ; @0x368
;  %bb.97:                              ; %cond.store125
                                        ;   in Loop: Header=BB0_2 Depth=1
	vvmov1.x.from.w	%r0,%vr1,15             ; @0x36c
	st_s	%r0,[%r14,60]                   ; @0x372
.LBB0_98:                               ; %else126
                                        ;   in Loop: Header=BB0_2 Depth=1
                                        ; @0x374
	add.f	%r3,%r3,16                      ; @0x374
	adc.f	%r2,%r2,0                       ; @0x378
	setlo	%r0,%r3,%r7                     ; @0x37c
	setlt	%r14,%r2,%r12                   ; @0x380
	cmp_s	%r2,%r12                        ; @0x384
	mov.eq	%r14,%r0                        ; @0x386
	cmp_s	%r14,0                          ; @0x38a
	bne	.LBB0_2                         ; @0x38c
.LBB0_99:                               ; %._crit_edge
                                        ; @0x390
	ld	%blink,[%sp,32]                 ; @0x390
	.cfa_restore	{%blink}                ; @0x394
	ld	%r20,[%sp,28]                   ; @0x394
	.cfa_restore	{%r20}                  ; @0x398
	ldd	%r18,[%sp,20]                   ; @0x398
	.cfa_restore	{%r19}                  ; @0x39c
	.cfa_restore	{%r18}                  ; @0x39c
	ldd	%r16,[%sp,12]                   ; @0x39c
	.cfa_restore	{%r17}                  ; @0x3a0
	.cfa_restore	{%r16}                  ; @0x3a0
	ldd	%r14,[%sp,4]                    ; @0x3a0
	.cfa_restore	{%r15}                  ; @0x3a4
	.cfa_restore	{%r14}                  ; @0x3a4
	ld_s	%r13,[%sp,0]                    ; @0x3a4
	.cfa_restore	{%r13}                  ; @0x3a6
	add_s	%sp,%sp,44                      ; @0x3a6
	.cfa_pop	44                              ; @0x3a8
	j_s	[%blink]                        ; @0x3a8
	.cfa_ef
.Lfunc_end0:                            ; @0x3aa

	.reloc	_init_ad,0	;startup code to enable %status AD bit ; -- End function
