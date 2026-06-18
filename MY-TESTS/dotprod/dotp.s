	.option	%reg
	.off	assume_short
	.file	"dotp.c"
	.globl	dotp
	.type	dotp,@function
	.type	.Ldotp$local,@function
	.size	dotp, .Lfunc_end0-dotp
	.size	.Ldotp$local, .Lfunc_end0-dotp
	.globl	vectorized_dotp
	.type	vectorized_dotp,@function
	.type	.Lvectorized_dotp$local,@function
	.size	vectorized_dotp, .Lfunc_end1-vectorized_dotp
	.size	.Lvectorized_dotp$local, .Lfunc_end1-vectorized_dotp
	.globl	autovectorized_dotp
	.type	autovectorized_dotp,@function
	.type	.Lautovectorized_dotp$local,@function
	.size	autovectorized_dotp, .Lfunc_end2-autovectorized_dotp
	.size	.Lautovectorized_dotp$local, .Lfunc_end2-autovectorized_dotp
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
	.ident	"LLVM 17.0.7/V-2024.06. (build 008) (LLVM 17.0.7) -arcv2hs -core4 -Xcode_density -Xatomic -Xll64 -Xunaligned -Xdiv_rem=radix4 -Xswap -Xbitscan -Xmpy_option=mpyd -Xshift_assist -Xbarrel_shifter -Xfpud_div -Xfpu_mac -Xtimer0 -Xrtc -Xstack_check -Xstu=4 -Xvdsp4 -Xvec_unit_rev_minor=1 -Xvec_width=512 -Xvec_mem_size=128k -Xvec_mem_bank_width=16 -Xvec_max_fetch_size=16 -Xvec_num_slots=3 -Xvec_super_with_scalar -Xvec_regs=32 -Xvec_fpu=32 -Xvec_fpu_math=3 -Xvec_fpu_2nd_mul -Xvec_fpu_types=2 -Xvec_num_rd_ports=6 -Xvec_num_acc=8 -Xvec_num_mpy=2 -Xvec_mpy32 -Xvec_num_alu=3 -Xvec_guard_bit_option=0 -Xvec_stack_check -Hvdsp_vector_c -O1 -fvectorize -fslp-vectorize -ffast-math"
	.align	4                               ; -- Begin function dotp
dotp:                                   ; @dotp
                                        ; @0x0
.Ldotp$local:                           ; @0x0
	.cfa_bf	.Ldotp$local
;  %bb.0:                               ; %entry
	.cfa_same	%r30                    ; @0x0
	.cfa_same	%r9                     ; @0x0
	.cfa_same	%r7                     ; @0x0
	.cfa_same	%r6                     ; @0x0
	.cfa_same	%r5                     ; @0x0
	.cfa_same	%r4                     ; @0x0
	.cfa_same	%r2                     ; @0x0
	brlt	%r2,1,.LBB0_4                   ; @0x0
;  %bb.1:                               ; %for.body.preheader
	mov_s	%r12,0                          ; @0x4
	mov_s	%r8,0                           ; @0x6
.LBB0_2:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x8
	ld	%r11,[%r0,0]                    ; @0x8
	ld_s	%r3,[%r1,0]                     ; @0xc
	add_s	%r0,%r0,4                       ; @0xe
	mpy	%r3,%r3,%r11                    ; @0x10
	add_s	%r1,%r1,4                       ; @0x14
	add_s	%r12,%r12,1                     ; @0x16
	add	%r8,%r3,%r8                     ; @0x18
	brlt	%r12,%r2,.LBB0_2                ; @0x1c
;  %bb.3:                               ; %for.cond.cleanup
	mov_s	%r0,%r8                         ; @0x20
	.cfa_remember_state                     ; @0x22
	j_s	[%blink]                        ; @0x22
	.cfa_restore_state                      ; @0x24
.LBB0_4:                                ; @0x24
	mov_s	%r8,0                           ; @0x24
	mov_s	%r0,%r8                         ; @0x26
	j_s	[%blink]                        ; @0x28
	.cfa_ef
.Lfunc_end0:                            ; @0x2a

	.align	4                               ; -- End function
                                        ; -- Begin function vectorized_dotp
vectorized_dotp:                        ; @vectorized_dotp
                                        ; @0x2c
.Lvectorized_dotp$local:                ; @0x2c
	.cfa_bf	.Lvectorized_dotp$local
;  %bb.0:                               ; %entry
	.cfa_same	%r30                    ; @0x2c
	.cfa_same	%r12                    ; @0x2c
	.cfa_same	%r11                    ; @0x2c
	.cfa_same	%r9                     ; @0x2c
	.cfa_same	%r8                     ; @0x2c
	.cfa_same	%r7                     ; @0x2c
	.cfa_same	%r6                     ; @0x2c
	.cfa_same	%r5                     ; @0x2c
	.cfa_same	%r4                     ; @0x2c
	.cfa_same	%r3                     ; @0x2c
	.cfa_same	%r2                     ; @0x2c
	.cfa_same	%r1                     ; @0x2c
	mov_s	%r0,0                           ; @0x2c
	j_s	[%blink]                        ; @0x2e
	.cfa_ef
.Lfunc_end1:                            ; @0x30

	.align	4                               ; -- End function
                                        ; -- Begin function autovectorized_dotp
autovectorized_dotp:                    ; @autovectorized_dotp
                                        ; @0x30
.Lautovectorized_dotp$local:            ; @0x30
	.cfa_bf	.Lautovectorized_dotp$local
;  %bb.0:                               ; %entry
	.cfa_same	%r30                    ; @0x30
	.cfa_same	%r7                     ; @0x30
	.cfa_same	%r5                     ; @0x30
	.cfa_same	%r4                     ; @0x30
	.cfa_same	%r2                     ; @0x30
	mov_s	%r9,0                           ; @0x30
	cmp_s	%r2,0                           ; @0x32
	ble	.LBB2_14                        ; @0x34
;  %bb.1:                               ; %iter.check
	brhs	%r2,8,.LBB2_3                   ; @0x38
;  %bb.2:
	mov_s	%r6,0                           ; @0x3c
	b_s	.LBB2_12                        ; @0x3e
.LBB2_3:                                ; %vector.main.loop.iter.check
                                        ; @0x40
	vvmov.w	 %vr0, 0                        ; @0x40
	brhs	%r2,16,.LBB2_5                  ; @0x44
;  %bb.4:
	mov_s	%r6,0                           ; @0x48
	b_s	.LBB2_9                         ; @0x4a
.LBB2_5:                                ; %vector.ph
                                        ; @0x4c
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov.w	 %vr16, 0                       ; @0x4c
	bmskn	%r6,%r2,3                       ; @0x4c
 ;	 }
	mov_s	%r11,%r1                        ; @0x54
	mov_s	%r8,%r0                         ; @0x56
.LBB2_6:                                ; %vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x58
.vvsbundle  "v1sc" 
 ;	 { 
	vvld.av.w	%vr1,%r8,1              ; @0x58
	add	%r9,%r9,16                      ; @0x58
 ;	 }
	vvld.av.w	%vr2,%r11,1             ; @0x62
	vvcmac.lo.uu.w	%vr16, %vr2, %vr1       ; @0x68
	brne	%r9,%r6,.LBB2_6                 ; @0x6e
;  %bb.7:                               ; %middle.block
	vvc2add.w	%vr16                   ; @0x72
	vvshfleven.w	%vr16, %vr16            ; @0x76
	vvc2add.w	%vr16                   ; @0x7a
	vvshfleven.w	%vr16, %vr16            ; @0x7e
	vvc2add.w	%vr16                   ; @0x82
	vvshfleven.w	%vr16, %vr16            ; @0x86
	vvc2add.w	%vr16                   ; @0x8a
	vvmov1.x.from.w	%r9,%vr16,0             ; @0x8e
	breq	%r6,%r2,.LBB2_14                ; @0x94
;  %bb.8:                               ; %vec.epilog.iter.check
	and	%r3,%r2,8                       ; @0x98
	breq	%r3,0,.LBB2_12                  ; @0x9c
.LBB2_9:                                ; %vec.epilog.ph
                                        ; @0xa0
.vvsbundle  "v2sc" 
 ;	 { 
	vvpinit.w	%p1, 0, 255             ; @0xa0
	vvmov.w	 %vr1, 0                        ; @0xa0
	add2	%r8,%r1,%r6                     ; @0xa0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,0,%r9              ; @0xae
	add2	%r3,%r0,%r6                     ; @0xae
 ;	 }
	bmskn	%r11,%r2,2                      ; @0xb8
.LBB2_10:                               ; %vec.epilog.vector.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0xbc
.vvsbundle  "v1sc" 
 ;	 { 
	vvld.ab.w.p1	%vr2,%r3,32             ; @0xbc
	add	%r6,%r6,8                       ; @0xbc
 ;	 }
	vvld.ab.w.p1	%vr3,%r8,32             ; @0xc8
	vvmpy.w	%vr2, %vr3, %vr2                ; @0xd0
	vvadd.w	%vr1, %vr2, %vr1                ; @0xd6
	brne	%r6,%r11,.LBB2_10               ; @0xdc
;  %bb.11:                              ; %vec.epilog.middle.block
.vvsbundle  "v2sc" 
 ;	 { 
	vvpinit.w	%p1, 0, 65532           ; @0xe0
	vvci.w	%vr2                            ; @0xe0
	mov_s	%r6,%r11                        ; @0xe0
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvadd.w	%vr2, %vr2, 4                   ; @0xec
	vvadd.w	%vr3, %vr2, 2                   ; @0xec
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvpinit.w	%p1, 0, 65520           ; @0xf4
	vvsel.w.p1	%vr3, %vr0, %vr3        ; @0xf4
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvpinit.w	%p1, 0, 15              ; @0x100
	vvsel.w.p1	%vr0, %vr0, %vr2        ; @0x100
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvpinit.w	%p1, 0, 3               ; @0x10c
	vvshfl.w.p1	%vr0, %vr1, %vr0        ; @0x10c
 ;	 }
	vvadd.w	%vr0, %vr1, %vr0                ; @0x118
	vvshfl.w.p1	%vr1, %vr0, %vr3        ; @0x11e
	vvadd.w	%vr0, %vr0, %vr1                ; @0x124
	vvmov1.from.w	%r3,%vr0,1              ; @0x128
	vvadd.w	%vr0, %vr0, %r3                 ; @0x12e
	vvmov1.x.from.w	%r9,%vr0,0              ; @0x132
	breq	%r11,%r2,.LBB2_14               ; @0x138
.LBB2_12:                               ; %for.body.preheader
                                        ; @0x13c
	add2	%r0,%r0,%r6                     ; @0x13c
	add2	%r1,%r1,%r6                     ; @0x140
.LBB2_13:                               ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
                                        ; @0x144
	ld_s	%r3,[%r0,0]                     ; @0x144
	ld_s	%r12,[%r1,0]                    ; @0x146
	add_s	%r0,%r0,4                       ; @0x148
	add_s	%r1,%r1,4                       ; @0x14a
	add_s	%r6,%r6,1                       ; @0x14c
	mpy_s	%r3,%r3,%r12                    ; @0x14e
	add	%r9,%r3,%r9                     ; @0x150
	brlt	%r6,%r2,.LBB2_13                ; @0x154
.LBB2_14:                               ; %for.cond.cleanup
                                        ; @0x158
	mov_s	%r0,%r9                         ; @0x158
	j_s	[%blink]                        ; @0x15a
	.cfa_ef
.Lfunc_end2:                            ; @0x15c

	.reloc	_init_ad,0	;startup code to enable %status AD bit ; -- End function
