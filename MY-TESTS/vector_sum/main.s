	.option	%reg
	.off	assume_short
	.file	"main.c"
	.size	.L.str.3, 30
	.type	.L.str.3,@object
	.size	.Lstr.13, 30
	.type	.Lstr.13,@object
	.size	.L.str.7, 15
	.type	.L.str.7,@object
	.size	.L.str.5, 23
	.type	.L.str.5,@object
	.size	.Lstr.12, 26
	.type	.Lstr.12,@object
	.size	.Lstr, 39
	.type	.Lstr,@object
	.size	.L.str.1, 40
	.type	.L.str.1,@object
	.size	.L.str.6, 51
	.type	.L.str.6,@object
	.size	.L.str.9, 55
	.type	.L.str.9,@object
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
	.align	4
.L.str.3:                               ; @0x0
	.asciz	"a[%d]=%d, b[%d]=%d, c[%d]=%d\n"
	.align	4
.Lstr.13:                               ; @0x20
	.asciz	"Primi 5 elementi della somma:"
	.align	4
.L.str.7:                               ; @0x40
	.asciz	"Speedup: %.2f\n"
	.align	4
.L.str.5:                               ; @0x50
	.asciz	"Vettorizzo su %d lane\n"
	.align	4
.Lstr.12:                               ; @0x68
	.asciz	"Versione autovettorizzata"
	.align	4
.Lstr:                                  ; @0x84
	.asciz	"Errore nell'allocazione della memoria."
	.align	4
.L.str.1:                               ; @0xac
	.asciz	"Tempo di esecuzione di vec_sum: %.2fms\n"
	.align	4
.L.str.6:                               ; @0xd4
	.asciz	"Tempo di esecuzione di vectorized_vec_sum: %.2fms\n"
	.align	4
.L.str.9:                               ; @0x108
	.asciz	"Tempo di esecuzione di autovectorized_vec_sum: %.2fms\n"
	.text
	.global	.CC_I
	.equ	.CC_I, 0
	.ident	"LLVM 17.0.7/V-2024.06. (build 008) (LLVM 17.0.7) -arcv2hs -core4 -Xcode_density -Xatomic -Xll64 -Xunaligned -Xdiv_rem=radix4 -Xswap -Xbitscan -Xmpy_option=mpyd -Xshift_assist -Xbarrel_shifter -Xfpud_div -Xfpu_mac -Xtimer0 -Xrtc -Xstack_check -Xstu=4 -Xvdsp4 -Xvec_unit_rev_minor=1 -Xvec_width=512 -Xvec_mem_size=128k -Xvec_mem_bank_width=16 -Xvec_max_fetch_size=16 -Xvec_num_slots=3 -Xvec_super_with_scalar -Xvec_regs=32 -Xvec_fpu=32 -Xvec_fpu_math=3 -Xvec_fpu_2nd_mul -Xvec_fpu_types=2 -Xvec_num_rd_ports=6 -Xvec_num_acc=8 -Xvec_num_mpy=2 -Xvec_mpy32 -Xvec_num_alu=3 -Xvec_guard_bit_option=0 -Xvec_stack_check -Hvdsp_vector_c -O3 -fvectorize -fslp-vectorize -ffast-math"
	.align	8                               ; -- Begin function main
main:                                   ; @main
                                        ; @0x0
.Lmain$local:                           ; @0x0
	.cfa_bf	.Lmain$local
;  %bb.0:                               ; %entry
	add1	%sp,%sp,-2276/2                 ; @0x0
	.cfa_push	2276                    ; @0x4
	st	%r13,[%sp,0]                    ; @0x4
	.cfa_reg_offset	{%r13}, 0               ; @0x8
	std	%r14,[%sp,4]                    ; @0x8
	.cfa_reg_offset	{%r14}, 4               ; @0xc
	.cfa_reg_offset	{%r15}, 8               ; @0xc
	st	%r16,[%sp,12]                   ; @0xc
	.cfa_reg_offset	{%r16}, 12              ; @0x10
	std	%r18,[%sp,16]                   ; @0x10
	.cfa_reg_offset	{%r18}, 16              ; @0x14
	.cfa_reg_offset	{%r19}, 20              ; @0x14
	std	%r20,[%sp,24]                   ; @0x14
	.cfa_reg_offset	{%r20}, 24              ; @0x18
	.cfa_reg_offset	{%r21}, 28              ; @0x18
	st	%blink,[%sp,32]                 ; @0x18
	.cfa_reg_offset	{%blink}, 32            ; @0x1c
	sub3	%r56,%r56,12288/8               ; @0x1c
	add	%r0,%r56,0x2000@u32             ; @0x20
	mov_s	%r16,.L.str.3                   ; @0x28
	cmp_s	%r0,0                           ; @0x2e
	beq	.LBB0_3                         ; @0x30
;  %bb.1:                               ; %entry
	add	%r1,%r56,0x1000@u32             ; @0x34
	cmp_s	%r1,0                           ; @0x3c
	add	%r2,%r56,0                      ; @0x3e
	cmp.ne	%r2,0                           ; Predicate Case 4
                                        ; @0x42
	beq	.LBB0_3                         ; Predicate Case 4
                                        ; @0x46
;  %bb.5:                               ; %vector.body
.vvsbundle  "v1sc" 
 ;	 { 
	vvci.w	%vr0                            ; @0x4a
	add	%r2,%sp,0x424@u32               ; @0x4a
 ;	 }
.vvsbundle  " v3" 
 ;	 { 
	vvadd.w	%vr18, %vr0, 17                 ; @0x56
	vvadd.w	%vr17, %vr0, 33                 ; @0x56
	vvadd.w	%vr16, %vr0, 49                 ; @0x56
 ;	 }
.vvsbundle  " v3" 
 ;	 { 
	vvadd.w	%vr21, %vr0, 97                 ; @0x62
	vvadd.w	%vr19, %vr0, 113                ; @0x62
	vvadd.w	%vr9, %vr0, 1                   ; @0x62
 ;	 }
.vvsbundle  " v3" 
 ;	 { 
	vvst.w	%vr9,%r1                        ; @0x72
	vvadd.w	%vr22, %vr0, 65                 ; @0x72
	vvadd.w	%vr20, %vr0, 81                 ; @0x72
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvadd.w	%vr26, %vr0, 161                ; @0x82
	vvadd.w	%vr23, %vr0, 177                ; @0x82
 ;	 }
	vvst.aa.w	%vr9,%r56,8192          ; @0x8e
.vvsbundle  " v2" 
 ;	 { 
	vvadd.w	%vr25, %vr0, 129                ; @0x94
	vvadd.w	%vr24, %vr0, 145                ; @0x94
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvadd.w	%vr29, %vr0, 209                ; @0xa0
	vvadd.w	%vr28, %vr0, 193                ; @0xa0
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvadd.w	%vr30, %vr0, 225                ; @0xac
	vvadd.w	%vr1, %vr0, 241                 ; @0xac
 ;	 }
.vvsbundle  " v3" 
 ;	 { 
	vvadd.w	%vr3, %vr0, 273                 ; @0xb8
	vvadd.w	%vr2, %vr0, 257                 ; @0xb8
	vvmov1.x.from.w	%r25,%vr1,0             ; @0xb8
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvadd.w	%vr5, %vr0, 305                 ; @0xc8
	vvadd.w	%vr4, %vr0, 289                 ; @0xc8
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvadd.w	%vr6, %vr0, 369                 ; @0xd4
	vvmov1.x.from.w	%r25,%vr1,1             ; @0xd4
	st	%r25,[%sp,228]                  ; @0xd4
 ;	 }
	vvadd.w	%vr7, %vr0, 353                 ; @0xe2
.vvsbundle  "v2sc" 
 ;	 { 
	vvadd.w	%vr9, %vr0, 337                 ; @0xe8
	vvmov1.x.from.w	%r25,%vr1,2             ; @0xe8
	st	%r25,[%sp,232]                  ; @0xe8
 ;	 }
	vvadd.w	%vr8, %vr0, 321                 ; @0xf6
.vvsbundle  "v2sc" 
 ;	 { 
	vvadd.w	%vr10, %vr0, 433                ; @0xfc
	vvmov1.x.from.w	%r25,%vr1,3             ; @0xfc
	st	%r25,[%sp,236]                  ; @0xfc
 ;	 }
	vvadd.w	%vr11, %vr0, 417                ; @0x10a
.vvsbundle  "v2sc" 
 ;	 { 
	vvadd.w	%vr13, %vr0, 385                ; @0x110
	vvmov1.x.from.w	%r25,%vr1,4             ; @0x110
	st	%r25,[%sp,240]                  ; @0x110
 ;	 }
	vvadd.w	%vr12, %vr0, 401                ; @0x11e
.vvsbundle  "v2sc" 
 ;	 { 
	vvadd.w	%vr27, %vr0, 497                ; @0x124
	vvmov1.x.from.w	%r25,%vr1,5             ; @0x124
	st	%r25,[%sp,244]                  ; @0x124
 ;	 }
	vvadd.w	%vr14, %vr0, 481                ; @0x132
.vvsbundle  "v2sc" 
 ;	 { 
	vvadd.w	%vr31, %vr0, 449                ; @0x138
	vvmov1.x.from.w	%r25,%vr1,6             ; @0x138
	st	%r25,[%sp,248]                  ; @0x138
 ;	 }
	vvadd.w	%vr15, %vr0, 465                ; @0x146
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr1,7             ; @0x14c
	st	%r25,[%sp,252]                  ; @0x14c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr1,8             ; @0x156
	st	%r25,[%sp,256]                  ; @0x156
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr1,9             ; @0x160
	st	%r25,[%sp,260]                  ; @0x160
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr1,10            ; @0x16a
	st	%r25,[%sp,264]                  ; @0x16a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr1,11            ; @0x174
	st	%r25,[%sp,268]                  ; @0x174
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr1,12            ; @0x17e
	st	%r25,[%sp,272]                  ; @0x17e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr1,13            ; @0x188
	st	%r25,[%sp,276]                  ; @0x188
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr1,14            ; @0x192
	st	%r25,[%sp,280]                  ; @0x192
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr1,15            ; @0x19c
	st	%r25,[%sp,284]                  ; @0x19c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr2,0             ; @0x1a6
	st	%r25,[%sp,288]                  ; @0x1a6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr2,1             ; @0x1b0
	st	%r25,[%sp,100]                  ; @0x1b0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr2,2             ; @0x1ba
	st	%r25,[%sp,104]                  ; @0x1ba
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr2,3             ; @0x1c4
	st	%r25,[%sp,108]                  ; @0x1c4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr2,4             ; @0x1ce
	st	%r25,[%sp,112]                  ; @0x1ce
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr2,5             ; @0x1d8
	st	%r25,[%sp,116]                  ; @0x1d8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr2,6             ; @0x1e2
	st	%r25,[%sp,120]                  ; @0x1e2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr2,7             ; @0x1ec
	st	%r25,[%sp,124]                  ; @0x1ec
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr2,8             ; @0x1f6
	st	%r25,[%sp,128]                  ; @0x1f6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr2,9             ; @0x200
	st	%r25,[%sp,132]                  ; @0x200
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr2,10            ; @0x20a
	st	%r25,[%sp,136]                  ; @0x20a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr2,11            ; @0x214
	st	%r25,[%sp,140]                  ; @0x214
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr2,12            ; @0x21e
	st	%r25,[%sp,144]                  ; @0x21e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr2,13            ; @0x228
	st	%r25,[%sp,148]                  ; @0x228
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr2,14            ; @0x232
	st	%r25,[%sp,152]                  ; @0x232
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr2,15            ; @0x23c
	st	%r25,[%sp,156]                  ; @0x23c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr13,0            ; @0x246
	st	%r25,[%sp,160]                  ; @0x246
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr13,1            ; @0x250
	st	%r25,[%sp,36]                   ; @0x250
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr13,2            ; @0x25a
	st	%r25,[%sp,40]                   ; @0x25a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr13,3            ; @0x264
	st	%r25,[%sp,44]                   ; @0x264
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr13,4            ; @0x26e
	st	%r25,[%sp,48]                   ; @0x26e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr13,5            ; @0x278
	st	%r25,[%sp,52]                   ; @0x278
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr13,6            ; @0x282
	st	%r25,[%sp,56]                   ; @0x282
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr13,7            ; @0x28c
	st	%r25,[%sp,60]                   ; @0x28c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr13,8            ; @0x296
	st	%r25,[%sp,64]                   ; @0x296
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr13,9            ; @0x2a0
	st	%r25,[%sp,68]                   ; @0x2a0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr13,10           ; @0x2aa
	st	%r25,[%sp,72]                   ; @0x2aa
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr13,11           ; @0x2b4
	st	%r25,[%sp,76]                   ; @0x2b4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr13,12           ; @0x2be
	st	%r25,[%sp,80]                   ; @0x2be
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr13,13           ; @0x2c8
	st	%r25,[%sp,84]                   ; @0x2c8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr13,14           ; @0x2d2
	st	%r25,[%sp,88]                   ; @0x2d2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr13,15           ; @0x2dc
	st	%r25,[%sp,92]                   ; @0x2dc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,0            ; @0x2e6
	st	%r25,[%sp,96]                   ; @0x2e6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,1            ; @0x2f0
	st	%r25,[%sp,164]                  ; @0x2f0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,2            ; @0x2fa
	st	%r25,[%sp,168]                  ; @0x2fa
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,3            ; @0x304
	st	%r25,[%sp,172]                  ; @0x304
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,4            ; @0x30e
	st	%r25,[%sp,176]                  ; @0x30e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,5            ; @0x318
	st	%r25,[%sp,180]                  ; @0x318
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,6            ; @0x322
	st	%r25,[%sp,184]                  ; @0x322
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,7            ; @0x32c
	st	%r25,[%sp,188]                  ; @0x32c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,8            ; @0x336
	st	%r25,[%sp,192]                  ; @0x336
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,9            ; @0x340
	st	%r25,[%sp,196]                  ; @0x340
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,10           ; @0x34a
	st	%r25,[%sp,200]                  ; @0x34a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,11           ; @0x354
	st	%r25,[%sp,204]                  ; @0x354
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,12           ; @0x35e
	st	%r25,[%sp,208]                  ; @0x35e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,13           ; @0x368
	st	%r25,[%sp,212]                  ; @0x368
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,14           ; @0x372
	st	%r25,[%sp,216]                  ; @0x372
 ;	 }
.vvsbundle  "v2sc" 
 ;	 { 
	vvadd.w	%vr31, %vr0, 561                ; @0x37c
	vvmov1.x.from.w	%r25,%vr31,15           ; @0x37c
	st	%r25,[%sp,220]                  ; @0x37c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,0            ; @0x38a
	st	%r25,[%sp,224]                  ; @0x38a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,1            ; @0x394
	st	%r25,[%sp,548]                  ; @0x394
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,2            ; @0x39e
	st	%r25,[%sp,552]                  ; @0x39e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,3            ; @0x3a8
	st	%r25,[%sp,556]                  ; @0x3a8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,4            ; @0x3b2
	st	%r25,[%sp,560]                  ; @0x3b2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,5            ; @0x3bc
	st	%r25,[%sp,564]                  ; @0x3bc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,6            ; @0x3c6
	st	%r25,[%sp,568]                  ; @0x3c6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,7            ; @0x3d0
	st	%r25,[%sp,572]                  ; @0x3d0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,8            ; @0x3da
	st	%r25,[%sp,576]                  ; @0x3da
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,9            ; @0x3e4
	st	%r25,[%sp,580]                  ; @0x3e4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,10           ; @0x3ee
	st	%r25,[%sp,584]                  ; @0x3ee
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,11           ; @0x3f8
	st	%r25,[%sp,588]                  ; @0x3f8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,12           ; @0x402
	st	%r25,[%sp,592]                  ; @0x402
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,13           ; @0x40c
	st	%r25,[%sp,596]                  ; @0x40c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,14           ; @0x416
	st	%r25,[%sp,600]                  ; @0x416
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,15           ; @0x420
	st	%r25,[%sp,604]                  ; @0x420
 ;	 }
	st	%r25,[%sp,608]                  ; @0x42a
	vvst.aa.w	%vr16,%r1,192           ; @0x42e
	vvadd.w	%vr31, %vr0, 545                ; @0x434
	vvmov1.x.from.w	%r25,%vr31,0            ; @0x43a
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,1            ; @0x440
	st	%r25,[%sp,420]                  ; @0x440
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,2            ; @0x44a
	st	%r25,[%sp,424]                  ; @0x44a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,3            ; @0x454
	st	%r25,[%sp,428]                  ; @0x454
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,4            ; @0x45e
	st	%r25,[%sp,432]                  ; @0x45e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,5            ; @0x468
	st	%r25,[%sp,436]                  ; @0x468
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,6            ; @0x472
	st	%r25,[%sp,440]                  ; @0x472
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,7            ; @0x47c
	st	%r25,[%sp,444]                  ; @0x47c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,8            ; @0x486
	st	%r25,[%sp,448]                  ; @0x486
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,9            ; @0x490
	st	%r25,[%sp,452]                  ; @0x490
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,10           ; @0x49a
	st	%r25,[%sp,456]                  ; @0x49a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,11           ; @0x4a4
	st	%r25,[%sp,460]                  ; @0x4a4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,12           ; @0x4ae
	st	%r25,[%sp,464]                  ; @0x4ae
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,13           ; @0x4b8
	st	%r25,[%sp,468]                  ; @0x4b8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,14           ; @0x4c2
	st	%r25,[%sp,472]                  ; @0x4c2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,15           ; @0x4cc
	st	%r25,[%sp,476]                  ; @0x4cc
 ;	 }
	st	%r25,[%sp,480]                  ; @0x4d6
	vvst.aa.w	%vr17,%r1,128           ; @0x4da
	vvadd.w	%vr31, %vr0, 529                ; @0x4e0
	vvmov1.x.from.w	%r25,%vr31,0            ; @0x4e6
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,1            ; @0x4ec
	st	%r25,[%sp,356]                  ; @0x4ec
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,2            ; @0x4f6
	st	%r25,[%sp,360]                  ; @0x4f6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,3            ; @0x500
	st	%r25,[%sp,364]                  ; @0x500
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,4            ; @0x50a
	st	%r25,[%sp,368]                  ; @0x50a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,5            ; @0x514
	st	%r25,[%sp,372]                  ; @0x514
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,6            ; @0x51e
	st	%r25,[%sp,376]                  ; @0x51e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,7            ; @0x528
	st	%r25,[%sp,380]                  ; @0x528
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,8            ; @0x532
	st	%r25,[%sp,384]                  ; @0x532
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,9            ; @0x53c
	st	%r25,[%sp,388]                  ; @0x53c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,10           ; @0x546
	st	%r25,[%sp,392]                  ; @0x546
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,11           ; @0x550
	st	%r25,[%sp,396]                  ; @0x550
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,12           ; @0x55a
	st	%r25,[%sp,400]                  ; @0x55a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,13           ; @0x564
	st	%r25,[%sp,404]                  ; @0x564
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,14           ; @0x56e
	st	%r25,[%sp,408]                  ; @0x56e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,15           ; @0x578
	st	%r25,[%sp,412]                  ; @0x578
 ;	 }
	st	%r25,[%sp,416]                  ; @0x582
	vvst.aa.w	%vr18,%r1,64            ; @0x586
	vvadd.w	%vr31, %vr0, 513                ; @0x58c
	vvmov1.x.from.w	%r25,%vr31,0            ; @0x592
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,1            ; @0x598
	st	%r25,[%sp,292]                  ; @0x598
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,2            ; @0x5a2
	st	%r25,[%sp,296]                  ; @0x5a2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,3            ; @0x5ac
	st	%r25,[%sp,300]                  ; @0x5ac
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,4            ; @0x5b6
	st	%r25,[%sp,304]                  ; @0x5b6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,5            ; @0x5c0
	st	%r25,[%sp,308]                  ; @0x5c0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,6            ; @0x5ca
	st	%r25,[%sp,312]                  ; @0x5ca
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,7            ; @0x5d4
	st	%r25,[%sp,316]                  ; @0x5d4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,8            ; @0x5de
	st	%r25,[%sp,320]                  ; @0x5de
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,9            ; @0x5e8
	st	%r25,[%sp,324]                  ; @0x5e8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,10           ; @0x5f2
	st	%r25,[%sp,328]                  ; @0x5f2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,11           ; @0x5fc
	st	%r25,[%sp,332]                  ; @0x5fc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,12           ; @0x606
	st	%r25,[%sp,336]                  ; @0x606
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,13           ; @0x610
	st	%r25,[%sp,340]                  ; @0x610
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,14           ; @0x61a
	st	%r25,[%sp,344]                  ; @0x61a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,15           ; @0x624
	st	%r25,[%sp,348]                  ; @0x624
 ;	 }
	st	%r25,[%sp,352]                  ; @0x62e
	vvst.aa.w	%vr19,%r1,448           ; @0x632
	vvadd.w	%vr31, %vr0, 625                ; @0x638
	vvmov1.x.from.w	%r25,%vr31,0            ; @0x63e
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,1            ; @0x644
	st	%r25,[%sp,804]                  ; @0x644
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,2            ; @0x64e
	st	%r25,[%sp,808]                  ; @0x64e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,3            ; @0x658
	st	%r25,[%sp,812]                  ; @0x658
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,4            ; @0x662
	st	%r25,[%sp,816]                  ; @0x662
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,5            ; @0x66c
	st	%r25,[%sp,820]                  ; @0x66c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,6            ; @0x676
	st	%r25,[%sp,824]                  ; @0x676
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,7            ; @0x680
	st	%r25,[%sp,828]                  ; @0x680
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,8            ; @0x68a
	st	%r25,[%sp,832]                  ; @0x68a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,9            ; @0x694
	st	%r25,[%sp,836]                  ; @0x694
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,10           ; @0x69e
	st	%r25,[%sp,840]                  ; @0x69e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,11           ; @0x6a8
	st	%r25,[%sp,844]                  ; @0x6a8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,12           ; @0x6b2
	st	%r25,[%sp,848]                  ; @0x6b2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,13           ; @0x6bc
	st	%r25,[%sp,852]                  ; @0x6bc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,14           ; @0x6c6
	st	%r25,[%sp,856]                  ; @0x6c6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,15           ; @0x6d0
	st	%r25,[%sp,860]                  ; @0x6d0
 ;	 }
	st	%r25,[%sp,864]                  ; @0x6da
	vvst.aa.w	%vr21,%r1,384           ; @0x6de
	vvadd.w	%vr31, %vr0, 609                ; @0x6e4
	vvmov1.x.from.w	%r25,%vr31,0            ; @0x6ea
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,1            ; @0x6f0
	st	%r25,[%sp,676]                  ; @0x6f0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,2            ; @0x6fa
	st	%r25,[%sp,680]                  ; @0x6fa
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,3            ; @0x704
	st	%r25,[%sp,684]                  ; @0x704
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,4            ; @0x70e
	st	%r25,[%sp,688]                  ; @0x70e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,5            ; @0x718
	st	%r25,[%sp,692]                  ; @0x718
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,6            ; @0x722
	st	%r25,[%sp,696]                  ; @0x722
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,7            ; @0x72c
	st	%r25,[%sp,700]                  ; @0x72c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,8            ; @0x736
	st	%r25,[%sp,704]                  ; @0x736
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,9            ; @0x740
	st	%r25,[%sp,708]                  ; @0x740
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,10           ; @0x74a
	st	%r25,[%sp,712]                  ; @0x74a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,11           ; @0x754
	st	%r25,[%sp,716]                  ; @0x754
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,12           ; @0x75e
	st	%r25,[%sp,720]                  ; @0x75e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,13           ; @0x768
	st	%r25,[%sp,724]                  ; @0x768
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,14           ; @0x772
	st	%r25,[%sp,728]                  ; @0x772
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,15           ; @0x77c
	st	%r25,[%sp,732]                  ; @0x77c
 ;	 }
	st	%r25,[%sp,736]                  ; @0x786
	vvst.aa.w	%vr20,%r1,320           ; @0x78a
	vvadd.w	%vr31, %vr0, 593                ; @0x790
	vvmov1.x.from.w	%r25,%vr31,0            ; @0x796
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,1            ; @0x79c
	st	%r25,[%sp,612]                  ; @0x79c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,2            ; @0x7a6
	st	%r25,[%sp,616]                  ; @0x7a6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,3            ; @0x7b0
	st	%r25,[%sp,620]                  ; @0x7b0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,4            ; @0x7ba
	st	%r25,[%sp,624]                  ; @0x7ba
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,5            ; @0x7c4
	st	%r25,[%sp,628]                  ; @0x7c4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,6            ; @0x7ce
	st	%r25,[%sp,632]                  ; @0x7ce
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,7            ; @0x7d8
	st	%r25,[%sp,636]                  ; @0x7d8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,8            ; @0x7e2
	st	%r25,[%sp,640]                  ; @0x7e2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,9            ; @0x7ec
	st	%r25,[%sp,644]                  ; @0x7ec
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,10           ; @0x7f6
	st	%r25,[%sp,648]                  ; @0x7f6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,11           ; @0x800
	st	%r25,[%sp,652]                  ; @0x800
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,12           ; @0x80a
	st	%r25,[%sp,656]                  ; @0x80a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,13           ; @0x814
	st	%r25,[%sp,660]                  ; @0x814
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,14           ; @0x81e
	st	%r25,[%sp,664]                  ; @0x81e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,15           ; @0x828
	st	%r25,[%sp,668]                  ; @0x828
 ;	 }
	st	%r25,[%sp,672]                  ; @0x832
	vvst.aa.w	%vr22,%r1,256           ; @0x836
	vvadd.w	%vr31, %vr0, 577                ; @0x83c
	vvmov1.x.from.w	%r25,%vr31,0            ; @0x842
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,1            ; @0x848
	st	%r25,[%sp,484]                  ; @0x848
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,2            ; @0x852
	st	%r25,[%sp,488]                  ; @0x852
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,3            ; @0x85c
	st	%r25,[%sp,492]                  ; @0x85c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,4            ; @0x866
	st	%r25,[%sp,496]                  ; @0x866
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,5            ; @0x870
	st	%r25,[%sp,500]                  ; @0x870
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,6            ; @0x87a
	st	%r25,[%sp,504]                  ; @0x87a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,7            ; @0x884
	st	%r25,[%sp,508]                  ; @0x884
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,8            ; @0x88e
	st	%r25,[%sp,512]                  ; @0x88e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,9            ; @0x898
	st	%r25,[%sp,516]                  ; @0x898
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,10           ; @0x8a2
	st	%r25,[%sp,520]                  ; @0x8a2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,11           ; @0x8ac
	st	%r25,[%sp,524]                  ; @0x8ac
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,12           ; @0x8b6
	st	%r25,[%sp,528]                  ; @0x8b6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,13           ; @0x8c0
	st	%r25,[%sp,532]                  ; @0x8c0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,14           ; @0x8ca
	st	%r25,[%sp,536]                  ; @0x8ca
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,15           ; @0x8d4
	st	%r25,[%sp,540]                  ; @0x8d4
 ;	 }
	st	%r25,[%sp,544]                  ; @0x8de
	vvst.aa.w	%vr23,%r1,704           ; @0x8e2
	vvadd.w	%vr31, %vr0, 689                ; @0x8e8
	vvmov1.x.from.w	%r25,%vr31,0            ; @0x8ee
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,1            ; @0x8f4
	st	%r25,[%r2,0]                    ; @0x8f4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,2            ; @0x8fe
	st	%r25,[%r2,4]                    ; @0x8fe
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,3            ; @0x908
	st	%r25,[%r2,8]                    ; @0x908
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,4            ; @0x912
	st	%r25,[%r2,12]                   ; @0x912
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,5            ; @0x91c
	st	%r25,[%r2,16]                   ; @0x91c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,6            ; @0x926
	st	%r25,[%r2,20]                   ; @0x926
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,7            ; @0x930
	st	%r25,[%r2,24]                   ; @0x930
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,8            ; @0x93a
	st	%r25,[%r2,28]                   ; @0x93a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,9            ; @0x944
	st	%r25,[%r2,32]                   ; @0x944
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,10           ; @0x94e
	st	%r25,[%r2,36]                   ; @0x94e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,11           ; @0x958
	st	%r25,[%r2,40]                   ; @0x958
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,12           ; @0x962
	st	%r25,[%r2,44]                   ; @0x962
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,13           ; @0x96c
	st	%r25,[%r2,48]                   ; @0x96c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,14           ; @0x976
	st	%r25,[%r2,52]                   ; @0x976
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,15           ; @0x980
	st	%r25,[%r2,56]                   ; @0x980
 ;	 }
	st	%r25,[%r2,60]                   ; @0x98a
	vvst.aa.w	%vr26,%r1,640           ; @0x98e
	vvadd.w	%vr31, %vr0, 673                ; @0x994
	vvmov1.x.from.w	%r25,%vr31,0            ; @0x99a
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,1            ; @0x9a0
	st	%r25,[%sp,932]                  ; @0x9a0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,2            ; @0x9aa
	st	%r25,[%sp,936]                  ; @0x9aa
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,3            ; @0x9b4
	st	%r25,[%sp,940]                  ; @0x9b4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,4            ; @0x9be
	st	%r25,[%sp,944]                  ; @0x9be
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,5            ; @0x9c8
	st	%r25,[%sp,948]                  ; @0x9c8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,6            ; @0x9d2
	st	%r25,[%sp,952]                  ; @0x9d2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,7            ; @0x9dc
	st	%r25,[%sp,956]                  ; @0x9dc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,8            ; @0x9e6
	st	%r25,[%sp,960]                  ; @0x9e6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,9            ; @0x9f0
	st	%r25,[%sp,964]                  ; @0x9f0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,10           ; @0x9fa
	st	%r25,[%sp,968]                  ; @0x9fa
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,11           ; @0xa04
	st	%r25,[%sp,972]                  ; @0xa04
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,12           ; @0xa0e
	st	%r25,[%sp,976]                  ; @0xa0e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,13           ; @0xa18
	st	%r25,[%sp,980]                  ; @0xa18
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,14           ; @0xa22
	st	%r25,[%sp,984]                  ; @0xa22
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,15           ; @0xa2c
	st	%r25,[%sp,988]                  ; @0xa2c
 ;	 }
	st	%r25,[%sp,992]                  ; @0xa36
	vvst.aa.w	%vr24,%r1,576           ; @0xa3a
	vvadd.w	%vr31, %vr0, 657                ; @0xa40
	vvmov1.x.from.w	%r25,%vr31,0            ; @0xa46
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,1            ; @0xa4c
	st	%r25,[%sp,868]                  ; @0xa4c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,2            ; @0xa56
	st	%r25,[%sp,872]                  ; @0xa56
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,3            ; @0xa60
	st	%r25,[%sp,876]                  ; @0xa60
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,4            ; @0xa6a
	st	%r25,[%sp,880]                  ; @0xa6a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,5            ; @0xa74
	st	%r25,[%sp,884]                  ; @0xa74
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,6            ; @0xa7e
	st	%r25,[%sp,888]                  ; @0xa7e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,7            ; @0xa88
	st	%r25,[%sp,892]                  ; @0xa88
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,8            ; @0xa92
	st	%r25,[%sp,896]                  ; @0xa92
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,9            ; @0xa9c
	st	%r25,[%sp,900]                  ; @0xa9c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,10           ; @0xaa6
	st	%r25,[%sp,904]                  ; @0xaa6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,11           ; @0xab0
	st	%r25,[%sp,908]                  ; @0xab0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,12           ; @0xaba
	st	%r25,[%sp,912]                  ; @0xaba
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,13           ; @0xac4
	st	%r25,[%sp,916]                  ; @0xac4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,14           ; @0xace
	st	%r25,[%sp,920]                  ; @0xace
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,15           ; @0xad8
	st	%r25,[%sp,924]                  ; @0xad8
 ;	 }
	st	%r25,[%sp,928]                  ; @0xae2
	vvst.aa.w	%vr25,%r1,512           ; @0xae6
	vvadd.w	%vr31, %vr0, 641                ; @0xaec
	vvmov1.x.from.w	%r25,%vr31,0            ; @0xaf2
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,1            ; @0xaf8
	st	%r25,[%sp,740]                  ; @0xaf8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,2            ; @0xb02
	st	%r25,[%sp,744]                  ; @0xb02
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,3            ; @0xb0c
	st	%r25,[%sp,748]                  ; @0xb0c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,4            ; @0xb16
	st	%r25,[%sp,752]                  ; @0xb16
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,5            ; @0xb20
	st	%r25,[%sp,756]                  ; @0xb20
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,6            ; @0xb2a
	st	%r25,[%sp,760]                  ; @0xb2a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,7            ; @0xb34
	st	%r25,[%sp,764]                  ; @0xb34
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,8            ; @0xb3e
	st	%r25,[%sp,768]                  ; @0xb3e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,9            ; @0xb48
	st	%r25,[%sp,772]                  ; @0xb48
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,10           ; @0xb52
	st	%r25,[%sp,776]                  ; @0xb52
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,11           ; @0xb5c
	st	%r25,[%sp,780]                  ; @0xb5c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,12           ; @0xb66
	st	%r25,[%sp,784]                  ; @0xb66
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,13           ; @0xb70
	st	%r25,[%sp,788]                  ; @0xb70
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,14           ; @0xb7a
	st	%r25,[%sp,792]                  ; @0xb7a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,15           ; @0xb84
	st	%r25,[%sp,796]                  ; @0xb84
 ;	 }
	st	%r25,[%sp,800]                  ; @0xb8e
	vvst.aa.w	%vr28,%r1,768           ; @0xb92
	vvadd.w	%vr31, %vr0, 753                ; @0xb98
	vvmov1.x.from.w	%r25,%vr31,0            ; @0xb9e
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,1            ; @0xba4
	st	%r25,[%r2,256]                  ; @0xba4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,2            ; @0xbae
	st	%r25,[%r2,260]                  ; @0xbae
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,3            ; @0xbb8
	st	%r25,[%r2,264]                  ; @0xbb8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,4            ; @0xbc2
	st	%r25,[%r2,268]                  ; @0xbc2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,5            ; @0xbcc
	st	%r25,[%r2,272]                  ; @0xbcc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,6            ; @0xbd6
	st	%r25,[%r2,276]                  ; @0xbd6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,7            ; @0xbe0
	st	%r25,[%r2,280]                  ; @0xbe0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,8            ; @0xbea
	st	%r25,[%r2,284]                  ; @0xbea
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,9            ; @0xbf4
	st	%r25,[%r2,288]                  ; @0xbf4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,10           ; @0xbfe
	st	%r25,[%r2,292]                  ; @0xbfe
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,11           ; @0xc08
	st	%r25,[%r2,296]                  ; @0xc08
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,12           ; @0xc12
	st	%r25,[%r2,300]                  ; @0xc12
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,13           ; @0xc1c
	st	%r25,[%r2,304]                  ; @0xc1c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,14           ; @0xc26
	st	%r25,[%r2,308]                  ; @0xc26
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,15           ; @0xc30
	st	%r25,[%r2,312]                  ; @0xc30
 ;	 }
	st	%r25,[%r2,316]                  ; @0xc3a
	vvst.aa.w	%vr29,%r1,832           ; @0xc3e
	vvadd.w	%vr31, %vr0, 737                ; @0xc44
	vvmov1.x.from.w	%r25,%vr31,0            ; @0xc4a
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,1            ; @0xc50
	st	%r25,[%r2,128]                  ; @0xc50
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,2            ; @0xc5a
	st	%r25,[%r2,132]                  ; @0xc5a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,3            ; @0xc64
	st	%r25,[%r2,136]                  ; @0xc64
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,4            ; @0xc6e
	st	%r25,[%r2,140]                  ; @0xc6e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,5            ; @0xc78
	st	%r25,[%r2,144]                  ; @0xc78
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,6            ; @0xc82
	st	%r25,[%r2,148]                  ; @0xc82
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,7            ; @0xc8c
	st	%r25,[%r2,152]                  ; @0xc8c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,8            ; @0xc96
	st	%r25,[%r2,156]                  ; @0xc96
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,9            ; @0xca0
	st	%r25,[%r2,160]                  ; @0xca0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,10           ; @0xcaa
	st	%r25,[%r2,164]                  ; @0xcaa
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,11           ; @0xcb4
	st	%r25,[%r2,168]                  ; @0xcb4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,12           ; @0xcbe
	st	%r25,[%r2,172]                  ; @0xcbe
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,13           ; @0xcc8
	st	%r25,[%r2,176]                  ; @0xcc8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,14           ; @0xcd2
	st	%r25,[%r2,180]                  ; @0xcd2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,15           ; @0xcdc
	st	%r25,[%r2,184]                  ; @0xcdc
 ;	 }
	st	%r25,[%r2,188]                  ; @0xce6
	vvst.aa.w	%vr30,%r1,896           ; @0xcea
	vvadd.w	%vr31, %vr0, 721                ; @0xcf0
	vvmov1.x.from.w	%r25,%vr31,0            ; @0xcf6
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,1            ; @0xcfc
	st	%r25,[%r2,64]                   ; @0xcfc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,2            ; @0xd06
	st	%r25,[%r2,68]                   ; @0xd06
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,3            ; @0xd10
	st	%r25,[%r2,72]                   ; @0xd10
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,4            ; @0xd1a
	st	%r25,[%r2,76]                   ; @0xd1a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,5            ; @0xd24
	st	%r25,[%r2,80]                   ; @0xd24
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,6            ; @0xd2e
	st	%r25,[%r2,84]                   ; @0xd2e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,7            ; @0xd38
	st	%r25,[%r2,88]                   ; @0xd38
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,8            ; @0xd42
	st	%r25,[%r2,92]                   ; @0xd42
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,9            ; @0xd4c
	st	%r25,[%r2,96]                   ; @0xd4c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,10           ; @0xd56
	st	%r25,[%r2,100]                  ; @0xd56
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,11           ; @0xd60
	st	%r25,[%r2,104]                  ; @0xd60
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,12           ; @0xd6a
	st	%r25,[%r2,108]                  ; @0xd6a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,13           ; @0xd74
	st	%r25,[%r2,112]                  ; @0xd74
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,14           ; @0xd7e
	st	%r25,[%r2,116]                  ; @0xd7e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,15           ; @0xd88
	st	%r25,[%r2,120]                  ; @0xd88
 ;	 }
	st	%r25,[%r2,124]                  ; @0xd92
	vvst.aa.w	%vr1,%r1,960            ; @0xd96
	vvadd.w	%vr31, %vr0, 705                ; @0xd9c
	vvmov1.x.from.w	%r25,%vr31,0            ; @0xda2
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,1            ; @0xda8
	st	%r25,[%sp,996]                  ; @0xda8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,2            ; @0xdb2
	st	%r25,[%sp,1000]                 ; @0xdb2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,3            ; @0xdbc
	st	%r25,[%sp,1004]                 ; @0xdbc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,4            ; @0xdc6
	st	%r25,[%sp,1008]                 ; @0xdc6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,5            ; @0xdd0
	st	%r25,[%sp,1012]                 ; @0xdd0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,6            ; @0xdda
	st	%r25,[%sp,1016]                 ; @0xdda
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,7            ; @0xde4
	st	%r25,[%sp,1020]                 ; @0xde4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,8            ; @0xdee
	st	%r25,[%r2,-36]                  ; @0xdee
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,9            ; @0xdf8
	st	%r25,[%r2,-32]                  ; @0xdf8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,10           ; @0xe02
	st	%r25,[%r2,-28]                  ; @0xe02
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,11           ; @0xe0c
	st	%r25,[%r2,-24]                  ; @0xe0c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,12           ; @0xe16
	st	%r25,[%r2,-20]                  ; @0xe16
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,13           ; @0xe20
	st	%r25,[%r2,-16]                  ; @0xe20
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,14           ; @0xe2a
	st	%r25,[%r2,-12]                  ; @0xe2a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,15           ; @0xe34
	st	%r25,[%r2,-8]                   ; @0xe34
 ;	 }
	st	%r25,[%r2,-4]                   ; @0xe3e
	vvst.aa.w	%vr2,%r1,1024           ; @0xe42
	vvadd.w	%vr31, %vr0, 817                ; @0xe48
	vvmov1.x.from.w	%r25,%vr31,0            ; @0xe4e
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,1            ; @0xe54
	st	%r25,[%r2,512]                  ; @0xe54
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,2            ; @0xe5e
	st	%r25,[%r2,516]                  ; @0xe5e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,3            ; @0xe68
	st	%r25,[%r2,520]                  ; @0xe68
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,4            ; @0xe72
	st	%r25,[%r2,524]                  ; @0xe72
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,5            ; @0xe7c
	st	%r25,[%r2,528]                  ; @0xe7c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,6            ; @0xe86
	st	%r25,[%r2,532]                  ; @0xe86
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,7            ; @0xe90
	st	%r25,[%r2,536]                  ; @0xe90
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,8            ; @0xe9a
	st	%r25,[%r2,540]                  ; @0xe9a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,9            ; @0xea4
	st	%r25,[%r2,544]                  ; @0xea4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,10           ; @0xeae
	st	%r25,[%r2,548]                  ; @0xeae
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,11           ; @0xeb8
	st	%r25,[%r2,552]                  ; @0xeb8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,12           ; @0xec2
	st	%r25,[%r2,556]                  ; @0xec2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,13           ; @0xecc
	st	%r25,[%r2,560]                  ; @0xecc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,14           ; @0xed6
	st	%r25,[%r2,564]                  ; @0xed6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,15           ; @0xee0
	st	%r25,[%r2,568]                  ; @0xee0
 ;	 }
	st	%r25,[%r2,572]                  ; @0xeea
	vvst.aa.w	%vr3,%r1,1088           ; @0xeee
	vvadd.w	%vr31, %vr0, 801                ; @0xef4
	vvmov1.x.from.w	%r25,%vr31,0            ; @0xefa
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,1            ; @0xf00
	st	%r25,[%r2,384]                  ; @0xf00
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,2            ; @0xf0a
	st	%r25,[%r2,388]                  ; @0xf0a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,3            ; @0xf14
	st	%r25,[%r2,392]                  ; @0xf14
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,4            ; @0xf1e
	st	%r25,[%r2,396]                  ; @0xf1e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,5            ; @0xf28
	st	%r25,[%r2,400]                  ; @0xf28
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,6            ; @0xf32
	st	%r25,[%r2,404]                  ; @0xf32
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,7            ; @0xf3c
	st	%r25,[%r2,408]                  ; @0xf3c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,8            ; @0xf46
	st	%r25,[%r2,412]                  ; @0xf46
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,9            ; @0xf50
	st	%r25,[%r2,416]                  ; @0xf50
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,10           ; @0xf5a
	st	%r25,[%r2,420]                  ; @0xf5a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,11           ; @0xf64
	st	%r25,[%r2,424]                  ; @0xf64
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,12           ; @0xf6e
	st	%r25,[%r2,428]                  ; @0xf6e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,13           ; @0xf78
	st	%r25,[%r2,432]                  ; @0xf78
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,14           ; @0xf82
	st	%r25,[%r2,436]                  ; @0xf82
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,15           ; @0xf8c
	st	%r25,[%r2,440]                  ; @0xf8c
 ;	 }
	st	%r25,[%r2,444]                  ; @0xf96
	vvst.aa.w	%vr4,%r1,1152           ; @0xf9a
	vvadd.w	%vr31, %vr0, 785                ; @0xfa0
	vvmov1.x.from.w	%r25,%vr31,0            ; @0xfa6
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,1            ; @0xfac
	st	%r25,[%r2,320]                  ; @0xfac
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,2            ; @0xfb6
	st	%r25,[%r2,324]                  ; @0xfb6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,3            ; @0xfc0
	st	%r25,[%r2,328]                  ; @0xfc0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,4            ; @0xfca
	st	%r25,[%r2,332]                  ; @0xfca
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,5            ; @0xfd4
	st	%r25,[%r2,336]                  ; @0xfd4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,6            ; @0xfde
	st	%r25,[%r2,340]                  ; @0xfde
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,7            ; @0xfe8
	st	%r25,[%r2,344]                  ; @0xfe8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,8            ; @0xff2
	st	%r25,[%r2,348]                  ; @0xff2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,9            ; @0xffc
	st	%r25,[%r2,352]                  ; @0xffc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,10           ; @0x1006
	st	%r25,[%r2,356]                  ; @0x1006
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,11           ; @0x1010
	st	%r25,[%r2,360]                  ; @0x1010
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,12           ; @0x101a
	st	%r25,[%r2,364]                  ; @0x101a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,13           ; @0x1024
	st	%r25,[%r2,368]                  ; @0x1024
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,14           ; @0x102e
	st	%r25,[%r2,372]                  ; @0x102e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,15           ; @0x1038
	st	%r25,[%r2,376]                  ; @0x1038
 ;	 }
	st	%r25,[%r2,380]                  ; @0x1042
	vvst.aa.w	%vr5,%r1,1216           ; @0x1046
	vvadd.w	%vr31, %vr0, 769                ; @0x104c
	vvmov1.x.from.w	%r25,%vr31,0            ; @0x1052
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,1            ; @0x1058
	st	%r25,[%r2,192]                  ; @0x1058
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,2            ; @0x1062
	st	%r25,[%r2,196]                  ; @0x1062
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,3            ; @0x106c
	st	%r25,[%r2,200]                  ; @0x106c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,4            ; @0x1076
	st	%r25,[%r2,204]                  ; @0x1076
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,5            ; @0x1080
	st	%r25,[%r2,208]                  ; @0x1080
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,6            ; @0x108a
	st	%r25,[%r2,212]                  ; @0x108a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,7            ; @0x1094
	st	%r25,[%r2,216]                  ; @0x1094
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,8            ; @0x109e
	st	%r25,[%r2,220]                  ; @0x109e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,9            ; @0x10a8
	st	%r25,[%r2,224]                  ; @0x10a8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,10           ; @0x10b2
	st	%r25,[%r2,228]                  ; @0x10b2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,11           ; @0x10bc
	st	%r25,[%r2,232]                  ; @0x10bc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,12           ; @0x10c6
	st	%r25,[%r2,236]                  ; @0x10c6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,13           ; @0x10d0
	st	%r25,[%r2,240]                  ; @0x10d0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,14           ; @0x10da
	st	%r25,[%r2,244]                  ; @0x10da
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,15           ; @0x10e4
	st	%r25,[%r2,248]                  ; @0x10e4
 ;	 }
	st	%r25,[%r2,252]                  ; @0x10ee
	vvst.aa.w	%vr6,%r1,1472           ; @0x10f2
	vvadd.w	%vr31, %vr0, 881                ; @0x10f8
	vvmov1.x.from.w	%r25,%vr31,0            ; @0x10fe
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,1            ; @0x1104
	st	%r25,[%r2,704]                  ; @0x1104
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,2            ; @0x110e
	st	%r25,[%r2,708]                  ; @0x110e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,3            ; @0x1118
	st	%r25,[%r2,712]                  ; @0x1118
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,4            ; @0x1122
	st	%r25,[%r2,716]                  ; @0x1122
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,5            ; @0x112c
	st	%r25,[%r2,720]                  ; @0x112c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,6            ; @0x1136
	st	%r25,[%r2,724]                  ; @0x1136
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,7            ; @0x1140
	st	%r25,[%r2,728]                  ; @0x1140
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,8            ; @0x114a
	st	%r25,[%r2,732]                  ; @0x114a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,9            ; @0x1154
	st	%r25,[%r2,736]                  ; @0x1154
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,10           ; @0x115e
	st	%r25,[%r2,740]                  ; @0x115e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,11           ; @0x1168
	st	%r25,[%r2,744]                  ; @0x1168
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,12           ; @0x1172
	st	%r25,[%r2,748]                  ; @0x1172
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,13           ; @0x117c
	st	%r25,[%r2,752]                  ; @0x117c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,14           ; @0x1186
	st	%r25,[%r2,756]                  ; @0x1186
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,15           ; @0x1190
	st	%r25,[%r2,760]                  ; @0x1190
 ;	 }
	st	%r25,[%r2,764]                  ; @0x119a
	vvst.aa.w	%vr7,%r1,1408           ; @0x119e
	vvadd.w	%vr31, %vr0, 865                ; @0x11a4
	vvmov1.x.from.w	%r25,%vr31,0            ; @0x11aa
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,1            ; @0x11b0
	st	%r25,[%r2,640]                  ; @0x11b0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,2            ; @0x11ba
	st	%r25,[%r2,644]                  ; @0x11ba
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,3            ; @0x11c4
	st	%r25,[%r2,648]                  ; @0x11c4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,4            ; @0x11ce
	st	%r25,[%r2,652]                  ; @0x11ce
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,5            ; @0x11d8
	st	%r25,[%r2,656]                  ; @0x11d8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,6            ; @0x11e2
	st	%r25,[%r2,660]                  ; @0x11e2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,7            ; @0x11ec
	st	%r25,[%r2,664]                  ; @0x11ec
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,8            ; @0x11f6
	st	%r25,[%r2,668]                  ; @0x11f6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,9            ; @0x1200
	st	%r25,[%r2,672]                  ; @0x1200
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,10           ; @0x120a
	st	%r25,[%r2,676]                  ; @0x120a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,11           ; @0x1214
	st	%r25,[%r2,680]                  ; @0x1214
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,12           ; @0x121e
	st	%r25,[%r2,684]                  ; @0x121e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,13           ; @0x1228
	st	%r25,[%r2,688]                  ; @0x1228
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,14           ; @0x1232
	st	%r25,[%r2,692]                  ; @0x1232
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,15           ; @0x123c
	st	%r25,[%r2,696]                  ; @0x123c
 ;	 }
	st	%r25,[%r2,700]                  ; @0x1246
	vvst.aa.w	%vr9,%r1,1344           ; @0x124a
	vvadd.w	%vr31, %vr0, 849                ; @0x1250
	vvmov1.x.from.w	%r25,%vr31,0            ; @0x1256
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,1            ; @0x125c
	st	%r25,[%r2,576]                  ; @0x125c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,2            ; @0x1266
	st	%r25,[%r2,580]                  ; @0x1266
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,3            ; @0x1270
	st	%r25,[%r2,584]                  ; @0x1270
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,4            ; @0x127a
	st	%r25,[%r2,588]                  ; @0x127a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,5            ; @0x1284
	st	%r25,[%r2,592]                  ; @0x1284
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,6            ; @0x128e
	st	%r25,[%r2,596]                  ; @0x128e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,7            ; @0x1298
	st	%r25,[%r2,600]                  ; @0x1298
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,8            ; @0x12a2
	st	%r25,[%r2,604]                  ; @0x12a2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,9            ; @0x12ac
	st	%r25,[%r2,608]                  ; @0x12ac
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,10           ; @0x12b6
	st	%r25,[%r2,612]                  ; @0x12b6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,11           ; @0x12c0
	st	%r25,[%r2,616]                  ; @0x12c0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,12           ; @0x12ca
	st	%r25,[%r2,620]                  ; @0x12ca
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,13           ; @0x12d4
	st	%r25,[%r2,624]                  ; @0x12d4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,14           ; @0x12de
	st	%r25,[%r2,628]                  ; @0x12de
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,15           ; @0x12e8
	st	%r25,[%r2,632]                  ; @0x12e8
 ;	 }
	st	%r25,[%r2,636]                  ; @0x12f2
	vvst.aa.w	%vr8,%r1,1280           ; @0x12f6
	vvadd.w	%vr31, %vr0, 833                ; @0x12fc
	vvmov1.x.from.w	%r25,%vr31,0            ; @0x1302
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,1            ; @0x1308
	st	%r25,[%r2,448]                  ; @0x1308
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,2            ; @0x1312
	st	%r25,[%r2,452]                  ; @0x1312
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,3            ; @0x131c
	st	%r25,[%r2,456]                  ; @0x131c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,4            ; @0x1326
	st	%r25,[%r2,460]                  ; @0x1326
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,5            ; @0x1330
	st	%r25,[%r2,464]                  ; @0x1330
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,6            ; @0x133a
	st	%r25,[%r2,468]                  ; @0x133a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,7            ; @0x1344
	st	%r25,[%r2,472]                  ; @0x1344
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,8            ; @0x134e
	st	%r25,[%r2,476]                  ; @0x134e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,9            ; @0x1358
	st	%r25,[%r2,480]                  ; @0x1358
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,10           ; @0x1362
	st	%r25,[%r2,484]                  ; @0x1362
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,11           ; @0x136c
	st	%r25,[%r2,488]                  ; @0x136c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,12           ; @0x1376
	st	%r25,[%r2,492]                  ; @0x1376
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,13           ; @0x1380
	st	%r25,[%r2,496]                  ; @0x1380
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,14           ; @0x138a
	st	%r25,[%r2,500]                  ; @0x138a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,15           ; @0x1394
	st	%r25,[%r2,504]                  ; @0x1394
 ;	 }
	st	%r25,[%r2,508]                  ; @0x139e
	vvst.aa.w	%vr10,%r1,1728          ; @0x13a2
	vvadd.w	%vr31, %vr0, 945                ; @0x13a8
	vvmov1.x.from.w	%r25,%vr31,0            ; @0x13ae
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,1            ; @0x13b4
	st	%r25,[%r2,960]                  ; @0x13b4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,2            ; @0x13be
	st	%r25,[%r2,964]                  ; @0x13be
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,3            ; @0x13c8
	st	%r25,[%r2,968]                  ; @0x13c8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,4            ; @0x13d2
	st	%r25,[%r2,972]                  ; @0x13d2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,5            ; @0x13dc
	st	%r25,[%r2,976]                  ; @0x13dc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,6            ; @0x13e6
	st	%r25,[%r2,980]                  ; @0x13e6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,7            ; @0x13f0
	st	%r25,[%r2,984]                  ; @0x13f0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,8            ; @0x13fa
	st	%r25,[%r2,988]                  ; @0x13fa
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,9            ; @0x1404
	st	%r25,[%r2,992]                  ; @0x1404
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,10           ; @0x140e
	st	%r25,[%r2,996]                  ; @0x140e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,11           ; @0x1418
	st	%r25,[%r2,1000]                 ; @0x1418
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,12           ; @0x1422
	st	%r25,[%r2,1004]                 ; @0x1422
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,13           ; @0x142c
	st	%r25,[%r2,1008]                 ; @0x142c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,14           ; @0x1436
	st	%r25,[%r2,1012]                 ; @0x1436
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,15           ; @0x1440
	st	%r25,[%r2,1016]                 ; @0x1440
 ;	 }
	st	%r25,[%r2,1020]                 ; @0x144a
	vvst.aa.w	%vr11,%r1,1664          ; @0x144e
	vvadd.w	%vr31, %vr0, 929                ; @0x1454
	vvmov1.x.from.w	%r25,%vr31,0            ; @0x145a
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,1            ; @0x1460
	st	%r25,[%r2,896]                  ; @0x1460
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,2            ; @0x146a
	st	%r25,[%r2,900]                  ; @0x146a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,3            ; @0x1474
	st	%r25,[%r2,904]                  ; @0x1474
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,4            ; @0x147e
	st	%r25,[%r2,908]                  ; @0x147e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,5            ; @0x1488
	st	%r25,[%r2,912]                  ; @0x1488
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,6            ; @0x1492
	st	%r25,[%r2,916]                  ; @0x1492
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,7            ; @0x149c
	st	%r25,[%r2,920]                  ; @0x149c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,8            ; @0x14a6
	st	%r25,[%r2,924]                  ; @0x14a6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,9            ; @0x14b0
	st	%r25,[%r2,928]                  ; @0x14b0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,10           ; @0x14ba
	st	%r25,[%r2,932]                  ; @0x14ba
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,11           ; @0x14c4
	st	%r25,[%r2,936]                  ; @0x14c4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,12           ; @0x14ce
	st	%r25,[%r2,940]                  ; @0x14ce
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,13           ; @0x14d8
	st	%r25,[%r2,944]                  ; @0x14d8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,14           ; @0x14e2
	st	%r25,[%r2,948]                  ; @0x14e2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,15           ; @0x14ec
	st	%r25,[%r2,952]                  ; @0x14ec
 ;	 }
	st	%r25,[%r2,956]                  ; @0x14f6
	vvst.aa.w	%vr12,%r1,1600          ; @0x14fa
	vvadd.w	%vr31, %vr0, 913                ; @0x1500
	vvmov1.x.from.w	%r25,%vr31,0            ; @0x1506
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,1            ; @0x150c
	st	%r25,[%r2,832]                  ; @0x150c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,2            ; @0x1516
	st	%r25,[%r2,836]                  ; @0x1516
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,3            ; @0x1520
	st	%r25,[%r2,840]                  ; @0x1520
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,4            ; @0x152a
	st	%r25,[%r2,844]                  ; @0x152a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,5            ; @0x1534
	st	%r25,[%r2,848]                  ; @0x1534
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,6            ; @0x153e
	st	%r25,[%r2,852]                  ; @0x153e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,7            ; @0x1548
	st	%r25,[%r2,856]                  ; @0x1548
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,8            ; @0x1552
	st	%r25,[%r2,860]                  ; @0x1552
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,9            ; @0x155c
	st	%r25,[%r2,864]                  ; @0x155c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,10           ; @0x1566
	st	%r25,[%r2,868]                  ; @0x1566
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,11           ; @0x1570
	st	%r25,[%r2,872]                  ; @0x1570
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,12           ; @0x157a
	st	%r25,[%r2,876]                  ; @0x157a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,13           ; @0x1584
	st	%r25,[%r2,880]                  ; @0x1584
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,14           ; @0x158e
	st	%r25,[%r2,884]                  ; @0x158e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,15           ; @0x1598
	st	%r25,[%r2,888]                  ; @0x1598
 ;	 }
	st	%r25,[%r2,892]                  ; @0x15a2
.vvsbundle  " v2" 
 ;	 { 
	vvst.aa.w	%vr13,%r1,1536          ; @0x15a6
	vvmov.w	%vr13, %vr27                    ; @0x15a6
 ;	 }
	vvadd.w	%vr31, %vr0, 897                ; @0x15b0
	vvmov1.x.from.w	%r25,%vr31,0            ; @0x15b6
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,1            ; @0x15bc
	st	%r25,[%r2,768]                  ; @0x15bc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,2            ; @0x15c6
	st	%r25,[%r2,772]                  ; @0x15c6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,3            ; @0x15d0
	st	%r25,[%r2,776]                  ; @0x15d0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,4            ; @0x15da
	st	%r25,[%r2,780]                  ; @0x15da
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,5            ; @0x15e4
	st	%r25,[%r2,784]                  ; @0x15e4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,6            ; @0x15ee
	st	%r25,[%r2,788]                  ; @0x15ee
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,7            ; @0x15f8
	st	%r25,[%r2,792]                  ; @0x15f8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,8            ; @0x1602
	st	%r25,[%r2,796]                  ; @0x1602
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,9            ; @0x160c
	st	%r25,[%r2,800]                  ; @0x160c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,10           ; @0x1616
	st	%r25,[%r2,804]                  ; @0x1616
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,11           ; @0x1620
	st	%r25,[%r2,808]                  ; @0x1620
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,12           ; @0x162a
	st	%r25,[%r2,812]                  ; @0x162a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,13           ; @0x1634
	st	%r25,[%r2,816]                  ; @0x1634
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,14           ; @0x163e
	st	%r25,[%r2,820]                  ; @0x163e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,15           ; @0x1648
	st	%r25,[%r2,824]                  ; @0x1648
 ;	 }
	st	%r25,[%r2,828]                  ; @0x1652
.vvsbundle  "v1sc" 
 ;	 { 
	vvst.aa.w	%vr27,%r1,1984          ; @0x1656
	add	%r2,%r2,1152                    ; @0x1656
 ;	 }
	vvadd.w	%vr31, %vr0, 961                ; @0x1660
	vvmov1.x.from.w	%r25,%vr31,0            ; @0x1666
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,1            ; @0x166c
	st	%r25,[%r2,0]                    ; @0x166c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,2            ; @0x1676
	st	%r25,[%r2,4]                    ; @0x1676
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,3            ; @0x1680
	st	%r25,[%r2,8]                    ; @0x1680
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,4            ; @0x168a
	st	%r25,[%r2,12]                   ; @0x168a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,5            ; @0x1694
	st	%r25,[%r2,16]                   ; @0x1694
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,6            ; @0x169e
	st	%r25,[%r2,20]                   ; @0x169e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,7            ; @0x16a8
	st	%r25,[%r2,24]                   ; @0x16a8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,8            ; @0x16b2
	st	%r25,[%r2,28]                   ; @0x16b2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,9            ; @0x16bc
	st	%r25,[%r2,32]                   ; @0x16bc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,10           ; @0x16c6
	st	%r25,[%r2,36]                   ; @0x16c6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,11           ; @0x16d0
	st	%r25,[%r2,40]                   ; @0x16d0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,12           ; @0x16da
	st	%r25,[%r2,44]                   ; @0x16da
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,13           ; @0x16e4
	st	%r25,[%r2,48]                   ; @0x16e4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,14           ; @0x16ee
	st	%r25,[%r2,52]                   ; @0x16ee
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,15           ; @0x16f8
	st	%r25,[%r2,56]                   ; @0x16f8
 ;	 }
	st	%r25,[%r2,60]                   ; @0x1702
	vvst.aa.w	%vr14,%r1,1920          ; @0x1706
	vvadd.w	%vr31, %vr0, 977                ; @0x170c
	vvmov1.x.from.w	%r25,%vr31,0            ; @0x1712
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,1            ; @0x1718
	st	%r25,[%r2,-128]                 ; @0x1718
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,2            ; @0x1722
	st	%r25,[%r2,-124]                 ; @0x1722
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,3            ; @0x172c
	st	%r25,[%r2,-120]                 ; @0x172c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,4            ; @0x1736
	st	%r25,[%r2,-116]                 ; @0x1736
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,5            ; @0x1740
	st	%r25,[%r2,-112]                 ; @0x1740
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,6            ; @0x174a
	st	%r25,[%r2,-108]                 ; @0x174a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,7            ; @0x1754
	st	%r25,[%r2,-104]                 ; @0x1754
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,8            ; @0x175e
	st	%r25,[%r2,-100]                 ; @0x175e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,9            ; @0x1768
	st	%r25,[%r2,-96]                  ; @0x1768
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,10           ; @0x1772
	st	%r25,[%r2,-92]                  ; @0x1772
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,11           ; @0x177c
	st	%r25,[%r2,-88]                  ; @0x177c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,12           ; @0x1786
	st	%r25,[%r2,-84]                  ; @0x1786
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,13           ; @0x1790
	st	%r25,[%r2,-80]                  ; @0x1790
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,14           ; @0x179a
	st	%r25,[%r2,-76]                  ; @0x179a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,15           ; @0x17a4
	st	%r25,[%r2,-72]                  ; @0x17a4
 ;	 }
	st	%r25,[%r2,-68]                  ; @0x17ae
	vvst.aa.w	%vr15,%r1,1856          ; @0x17b2
.vvsbundle  " v2" 
 ;	 { 
	vvadd.w	%vr0, %vr0, 1009                ; @0x17b8
	vvadd.w	%vr31, %vr0, 993                ; @0x17b8
 ;	 }
	vvmov1.x.from.w	%r25,%vr31,0            ; @0x17c4
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,1            ; @0x17ca
	st	%r25,[%r2,-64]                  ; @0x17ca
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,2            ; @0x17d4
	st	%r25,[%r2,-60]                  ; @0x17d4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,3            ; @0x17de
	st	%r25,[%r2,-56]                  ; @0x17de
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,4            ; @0x17e8
	st	%r25,[%r2,-52]                  ; @0x17e8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,5            ; @0x17f2
	st	%r25,[%r2,-48]                  ; @0x17f2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,6            ; @0x17fc
	st	%r25,[%r2,-44]                  ; @0x17fc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,7            ; @0x1806
	st	%r25,[%r2,-40]                  ; @0x1806
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,8            ; @0x1810
	st	%r25,[%r2,-36]                  ; @0x1810
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,9            ; @0x181a
	st	%r25,[%r2,-32]                  ; @0x181a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,10           ; @0x1824
	st	%r25,[%r2,-28]                  ; @0x1824
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,11           ; @0x182e
	st	%r25,[%r2,-24]                  ; @0x182e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,12           ; @0x1838
	st	%r25,[%r2,-20]                  ; @0x1838
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,13           ; @0x1842
	st	%r25,[%r2,-16]                  ; @0x1842
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,14           ; @0x184c
	st	%r25,[%r2,-12]                  ; @0x184c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.x.from.w	%r25,%vr31,15           ; @0x1856
	st	%r25,[%r2,-8]                   ; @0x1856
 ;	 }
	st	%r25,[%r2,-4]                   ; @0x1860
	ld	%r25,[%sp,164]                  ; @0x1864
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr31,0,%r25            ; @0x1868
	ld	%r25,[%sp,168]                  ; @0x1868
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr31,1,%r25            ; @0x1872
	ld	%r25,[%sp,172]                  ; @0x1872
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr31,2,%r25            ; @0x187c
	ld	%r25,[%sp,176]                  ; @0x187c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr31,3,%r25            ; @0x1886
	ld	%r25,[%sp,180]                  ; @0x1886
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr31,4,%r25            ; @0x1890
	ld	%r25,[%sp,184]                  ; @0x1890
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr31,5,%r25            ; @0x189a
	ld	%r25,[%sp,188]                  ; @0x189a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr31,6,%r25            ; @0x18a4
	ld	%r25,[%sp,192]                  ; @0x18a4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr31,7,%r25            ; @0x18ae
	ld	%r25,[%sp,196]                  ; @0x18ae
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr31,8,%r25            ; @0x18b8
	ld	%r25,[%sp,200]                  ; @0x18b8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr31,9,%r25            ; @0x18c2
	ld	%r25,[%sp,204]                  ; @0x18c2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr31,10,%r25           ; @0x18cc
	ld	%r25,[%sp,208]                  ; @0x18cc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr31,11,%r25           ; @0x18d6
	ld	%r25,[%sp,212]                  ; @0x18d6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr31,12,%r25           ; @0x18e0
	ld	%r25,[%sp,216]                  ; @0x18e0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr31,13,%r25           ; @0x18ea
	ld	%r25,[%sp,220]                  ; @0x18ea
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr31,14,%r25           ; @0x18f4
	ld	%r25,[%sp,224]                  ; @0x18f4
 ;	 }
	vvst.aa.w	%vr16,%r0,192           ; @0x18fe
.vvsbundle  " v2" 
 ;	 { 
	vvst.aa.w	%vr17,%r0,128           ; @0x1904
	vvmov1.vi.to.w	%vr31,15,%r25           ; @0x1904
 ;	 }
	vvst.aa.w	%vr18,%r0,64            ; @0x190e
	vvst.aa.w	%vr31,%r1,1792          ; @0x1914
	vvst.aa.w	%vr19,%r0,448           ; @0x191a
	vvst.aa.w	%vr21,%r0,384           ; @0x1920
	vvst.aa.w	%vr20,%r0,320           ; @0x1926
	vvst.aa.w	%vr22,%r0,256           ; @0x192c
	vvst.aa.w	%vr23,%r0,704           ; @0x1932
	vvst.aa.w	%vr26,%r0,640           ; @0x1938
	vvst.aa.w	%vr24,%r0,576           ; @0x193e
	vvst.aa.w	%vr25,%r0,512           ; @0x1944
	vvst.aa.w	%vr28,%r0,768           ; @0x194a
	vvst.aa.w	%vr29,%r0,832           ; @0x1950
	vvst.aa.w	%vr30,%r0,896           ; @0x1956
	ld	%r25,[%sp,228]                  ; @0x195c
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,0,%r25             ; @0x1960
	ld	%r25,[%sp,232]                  ; @0x1960
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,1,%r25             ; @0x196a
	ld	%r25,[%sp,236]                  ; @0x196a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,2,%r25             ; @0x1974
	ld	%r25,[%sp,240]                  ; @0x1974
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,3,%r25             ; @0x197e
	ld	%r25,[%sp,244]                  ; @0x197e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,4,%r25             ; @0x1988
	ld	%r25,[%sp,248]                  ; @0x1988
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,5,%r25             ; @0x1992
	ld	%r25,[%sp,252]                  ; @0x1992
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,6,%r25             ; @0x199c
	ld	%r25,[%sp,256]                  ; @0x199c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,7,%r25             ; @0x19a6
	ld	%r25,[%sp,260]                  ; @0x19a6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,8,%r25             ; @0x19b0
	ld	%r25,[%sp,264]                  ; @0x19b0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,9,%r25             ; @0x19ba
	ld	%r25,[%sp,268]                  ; @0x19ba
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,10,%r25            ; @0x19c4
	ld	%r25,[%sp,272]                  ; @0x19c4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,11,%r25            ; @0x19ce
	ld	%r25,[%sp,276]                  ; @0x19ce
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,12,%r25            ; @0x19d8
	ld	%r25,[%sp,280]                  ; @0x19d8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,13,%r25            ; @0x19e2
	ld	%r25,[%sp,284]                  ; @0x19e2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,14,%r25            ; @0x19ec
	ld	%r25,[%sp,288]                  ; @0x19ec
 ;	 }
	vvmov1.vi.to.w	%vr2,15,%r25            ; @0x19f6
	vvst.aa.w	%vr2,%r0,960            ; @0x19fc
	ld	%r25,[%sp,100]                  ; @0x1a02
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,0,%r25             ; @0x1a06
	ld	%r25,[%sp,104]                  ; @0x1a06
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,1,%r25             ; @0x1a10
	ld	%r25,[%sp,108]                  ; @0x1a10
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,2,%r25             ; @0x1a1a
	ld	%r25,[%sp,112]                  ; @0x1a1a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,3,%r25             ; @0x1a24
	ld	%r25,[%sp,116]                  ; @0x1a24
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,4,%r25             ; @0x1a2e
	ld	%r25,[%sp,120]                  ; @0x1a2e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,5,%r25             ; @0x1a38
	ld	%r25,[%sp,124]                  ; @0x1a38
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,6,%r25             ; @0x1a42
	ld	%r25,[%sp,128]                  ; @0x1a42
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,7,%r25             ; @0x1a4c
	ld	%r25,[%sp,132]                  ; @0x1a4c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,8,%r25             ; @0x1a56
	ld	%r25,[%sp,136]                  ; @0x1a56
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,9,%r25             ; @0x1a60
	ld	%r25,[%sp,140]                  ; @0x1a60
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,10,%r25            ; @0x1a6a
	ld	%r25,[%sp,144]                  ; @0x1a6a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,11,%r25            ; @0x1a74
	ld	%r25,[%sp,148]                  ; @0x1a74
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,12,%r25            ; @0x1a7e
	ld	%r25,[%sp,152]                  ; @0x1a7e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,13,%r25            ; @0x1a88
	ld	%r25,[%sp,156]                  ; @0x1a88
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,14,%r25            ; @0x1a92
	ld	%r25,[%sp,160]                  ; @0x1a92
 ;	 }
	vvst.aa.w	%vr3,%r0,1088           ; @0x1a9c
.vvsbundle  " v2" 
 ;	 { 
	vvst.aa.w	%vr4,%r0,1152           ; @0x1aa2
	vvmov1.vi.to.w	%vr2,15,%r25            ; @0x1aa2
 ;	 }
	vvst.aa.w	%vr2,%r0,1024           ; @0x1aac
	vvst.aa.w	%vr5,%r0,1216           ; @0x1ab2
	vvst.aa.w	%vr6,%r0,1472           ; @0x1ab8
	vvst.aa.w	%vr7,%r0,1408           ; @0x1abe
	vvst.aa.w	%vr9,%r0,1344           ; @0x1ac4
	vvst.aa.w	%vr8,%r0,1280           ; @0x1aca
	vvst.aa.w	%vr10,%r0,1728          ; @0x1ad0
	vvst.aa.w	%vr11,%r0,1664          ; @0x1ad6
	vvst.aa.w	%vr12,%r0,1600          ; @0x1adc
	ld	%r25,[%sp,36]                   ; @0x1ae2
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,0,%r25             ; @0x1ae6
	ld	%r25,[%sp,40]                   ; @0x1ae6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,1,%r25             ; @0x1af0
	ld	%r25,[%sp,44]                   ; @0x1af0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,2,%r25             ; @0x1afa
	ld	%r25,[%sp,48]                   ; @0x1afa
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,3,%r25             ; @0x1b04
	ld	%r25,[%sp,52]                   ; @0x1b04
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,4,%r25             ; @0x1b0e
	ld	%r25,[%sp,56]                   ; @0x1b0e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,5,%r25             ; @0x1b18
	ld	%r25,[%sp,60]                   ; @0x1b18
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,6,%r25             ; @0x1b22
	ld	%r25,[%sp,64]                   ; @0x1b22
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,7,%r25             ; @0x1b2c
	ld	%r25,[%sp,68]                   ; @0x1b2c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,8,%r25             ; @0x1b36
	ld	%r25,[%sp,72]                   ; @0x1b36
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,9,%r25             ; @0x1b40
	ld	%r25,[%sp,76]                   ; @0x1b40
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,10,%r25            ; @0x1b4a
	ld	%r25,[%sp,80]                   ; @0x1b4a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,11,%r25            ; @0x1b54
	ld	%r25,[%sp,84]                   ; @0x1b54
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,12,%r25            ; @0x1b5e
	ld	%r25,[%sp,88]                   ; @0x1b5e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,13,%r25            ; @0x1b68
	ld	%r25,[%sp,92]                   ; @0x1b68
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,14,%r25            ; @0x1b72
	ld	%r25,[%sp,96]                   ; @0x1b72
 ;	 }
	vvst.aa.w	%vr13,%r0,1984          ; @0x1b7c
.vvsbundle  " v2" 
 ;	 { 
	vvst.aa.w	%vr14,%r0,1920          ; @0x1b82
	vvmov1.vi.to.w	%vr2,15,%r25            ; @0x1b82
 ;	 }
	vvst.aa.w	%vr2,%r0,1536           ; @0x1b8c
	vvst.aa.w	%vr15,%r0,1856          ; @0x1b92
	vvst.aa.w	%vr31,%r0,1792          ; @0x1b98
	ld	%r25,[%sp,548]                  ; @0x1b9e
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,0,%r25             ; @0x1ba2
	ld	%r25,[%sp,552]                  ; @0x1ba2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,1,%r25             ; @0x1bac
	ld	%r25,[%sp,556]                  ; @0x1bac
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,2,%r25             ; @0x1bb6
	ld	%r25,[%sp,560]                  ; @0x1bb6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,3,%r25             ; @0x1bc0
	ld	%r25,[%sp,564]                  ; @0x1bc0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,4,%r25             ; @0x1bca
	ld	%r25,[%sp,568]                  ; @0x1bca
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,5,%r25             ; @0x1bd4
	ld	%r25,[%sp,572]                  ; @0x1bd4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,6,%r25             ; @0x1bde
	ld	%r25,[%sp,576]                  ; @0x1bde
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,7,%r25             ; @0x1be8
	ld	%r25,[%sp,580]                  ; @0x1be8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,8,%r25             ; @0x1bf2
	ld	%r25,[%sp,584]                  ; @0x1bf2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,9,%r25             ; @0x1bfc
	ld	%r25,[%sp,588]                  ; @0x1bfc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,10,%r25            ; @0x1c06
	ld	%r25,[%sp,592]                  ; @0x1c06
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,11,%r25            ; @0x1c10
	ld	%r25,[%sp,596]                  ; @0x1c10
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,12,%r25            ; @0x1c1a
	ld	%r25,[%sp,600]                  ; @0x1c1a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,13,%r25            ; @0x1c24
	ld	%r25,[%sp,604]                  ; @0x1c24
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,14,%r25            ; @0x1c2e
	ld	%r25,[%sp,608]                  ; @0x1c2e
 ;	 }
	vvmov1.vi.to.w	%vr1,15,%r25            ; @0x1c38
	vvst.aa.w	%vr1,%r0,2240           ; @0x1c3e
	vvst.aa.w	%vr1,%r1,2240           ; @0x1c44
	ld	%r25,[%sp,420]                  ; @0x1c4a
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,0,%r25             ; @0x1c4e
	ld	%r25,[%sp,424]                  ; @0x1c4e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,1,%r25             ; @0x1c58
	ld	%r25,[%sp,428]                  ; @0x1c58
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,2,%r25             ; @0x1c62
	ld	%r25,[%sp,432]                  ; @0x1c62
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,3,%r25             ; @0x1c6c
	ld	%r25,[%sp,436]                  ; @0x1c6c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,4,%r25             ; @0x1c76
	ld	%r25,[%sp,440]                  ; @0x1c76
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,5,%r25             ; @0x1c80
	ld	%r25,[%sp,444]                  ; @0x1c80
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,6,%r25             ; @0x1c8a
	ld	%r25,[%sp,448]                  ; @0x1c8a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,7,%r25             ; @0x1c94
	ld	%r25,[%sp,452]                  ; @0x1c94
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,8,%r25             ; @0x1c9e
	ld	%r25,[%sp,456]                  ; @0x1c9e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,9,%r25             ; @0x1ca8
	ld	%r25,[%sp,460]                  ; @0x1ca8
 ;	 }
	vvmov1.vi.to.w	%vr1,10,%r25            ; @0x1cb2
	ld	%r25,[%sp,464]                  ; @0x1cb8
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,11,%r25            ; @0x1cbc
	ld	%r25,[%sp,468]                  ; @0x1cbc
 ;	 }
	add	%r2,%sp,0x428@u32               ; @0x1cc6
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,12,%r25            ; @0x1cce
	ld	%r25,[%sp,472]                  ; @0x1cce
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,13,%r25            ; @0x1cd8
	ld	%r25,[%sp,476]                  ; @0x1cd8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,14,%r25            ; @0x1ce2
	ld	%r25,[%sp,480]                  ; @0x1ce2
 ;	 }
	vvmov1.vi.to.w	%vr1,15,%r25            ; @0x1cec
	vvst.aa.w	%vr1,%r1,2176           ; @0x1cf2
	ld	%r25,[%sp,356]                  ; @0x1cf8
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,0,%r25             ; @0x1cfc
	ld	%r25,[%sp,360]                  ; @0x1cfc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,1,%r25             ; @0x1d06
	ld	%r25,[%sp,364]                  ; @0x1d06
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,2,%r25             ; @0x1d10
	ld	%r25,[%sp,368]                  ; @0x1d10
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,3,%r25             ; @0x1d1a
	ld	%r25,[%sp,372]                  ; @0x1d1a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,4,%r25             ; @0x1d24
	ld	%r25,[%sp,376]                  ; @0x1d24
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,5,%r25             ; @0x1d2e
	ld	%r25,[%sp,380]                  ; @0x1d2e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,6,%r25             ; @0x1d38
	ld	%r25,[%sp,384]                  ; @0x1d38
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,7,%r25             ; @0x1d42
	ld	%r25,[%sp,388]                  ; @0x1d42
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,8,%r25             ; @0x1d4c
	ld	%r25,[%sp,392]                  ; @0x1d4c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,9,%r25             ; @0x1d56
	ld	%r25,[%sp,396]                  ; @0x1d56
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,10,%r25            ; @0x1d60
	ld	%r25,[%sp,400]                  ; @0x1d60
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,11,%r25            ; @0x1d6a
	ld	%r25,[%sp,404]                  ; @0x1d6a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,12,%r25            ; @0x1d74
	ld	%r25,[%sp,408]                  ; @0x1d74
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,13,%r25            ; @0x1d7e
	ld	%r25,[%sp,412]                  ; @0x1d7e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,14,%r25            ; @0x1d88
	ld	%r25,[%sp,416]                  ; @0x1d88
 ;	 }
	vvmov1.vi.to.w	%vr2,15,%r25            ; @0x1d92
	vvst.aa.w	%vr2,%r1,2112           ; @0x1d98
	ld	%r25,[%sp,292]                  ; @0x1d9e
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,0,%r25             ; @0x1da2
	ld	%r25,[%sp,296]                  ; @0x1da2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,1,%r25             ; @0x1dac
	ld	%r25,[%sp,300]                  ; @0x1dac
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,2,%r25             ; @0x1db6
	ld	%r25,[%sp,304]                  ; @0x1db6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,3,%r25             ; @0x1dc0
	ld	%r25,[%sp,308]                  ; @0x1dc0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,4,%r25             ; @0x1dca
	ld	%r25,[%sp,312]                  ; @0x1dca
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,5,%r25             ; @0x1dd4
	ld	%r25,[%sp,316]                  ; @0x1dd4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,6,%r25             ; @0x1dde
	ld	%r25,[%sp,320]                  ; @0x1dde
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,7,%r25             ; @0x1de8
	ld	%r25,[%sp,324]                  ; @0x1de8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,8,%r25             ; @0x1df2
	ld	%r25,[%sp,328]                  ; @0x1df2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,9,%r25             ; @0x1dfc
	ld	%r25,[%sp,332]                  ; @0x1dfc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,10,%r25            ; @0x1e06
	ld	%r25,[%sp,336]                  ; @0x1e06
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,11,%r25            ; @0x1e10
	ld	%r25,[%sp,340]                  ; @0x1e10
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,12,%r25            ; @0x1e1a
	ld	%r25,[%sp,344]                  ; @0x1e1a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,13,%r25            ; @0x1e24
	ld	%r25,[%sp,348]                  ; @0x1e24
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,14,%r25            ; @0x1e2e
	ld	%r25,[%sp,352]                  ; @0x1e2e
 ;	 }
	vvst.aa.w	%vr1,%r0,2176           ; @0x1e38
.vvsbundle  " v2" 
 ;	 { 
	vvst.aa.w	%vr2,%r0,2112           ; @0x1e3e
	vvmov1.vi.to.w	%vr3,15,%r25            ; @0x1e3e
 ;	 }
	vvst.aa.w	%vr3,%r1,2048           ; @0x1e48
	vvst.aa.w	%vr3,%r0,2048           ; @0x1e4e
	ld	%r25,[%sp,804]                  ; @0x1e54
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,0,%r25             ; @0x1e58
	ld	%r25,[%sp,808]                  ; @0x1e58
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,1,%r25             ; @0x1e62
	ld	%r25,[%sp,812]                  ; @0x1e62
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,2,%r25             ; @0x1e6c
	ld	%r25,[%sp,816]                  ; @0x1e6c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,3,%r25             ; @0x1e76
	ld	%r25,[%sp,820]                  ; @0x1e76
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,4,%r25             ; @0x1e80
	ld	%r25,[%sp,824]                  ; @0x1e80
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,5,%r25             ; @0x1e8a
	ld	%r25,[%sp,828]                  ; @0x1e8a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,6,%r25             ; @0x1e94
	ld	%r25,[%sp,832]                  ; @0x1e94
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,7,%r25             ; @0x1e9e
	ld	%r25,[%sp,836]                  ; @0x1e9e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,8,%r25             ; @0x1ea8
	ld	%r25,[%sp,840]                  ; @0x1ea8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,9,%r25             ; @0x1eb2
	ld	%r25,[%sp,844]                  ; @0x1eb2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,10,%r25            ; @0x1ebc
	ld	%r25,[%sp,848]                  ; @0x1ebc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,11,%r25            ; @0x1ec6
	ld	%r25,[%sp,852]                  ; @0x1ec6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,12,%r25            ; @0x1ed0
	ld	%r25,[%sp,856]                  ; @0x1ed0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,13,%r25            ; @0x1eda
	ld	%r25,[%sp,860]                  ; @0x1eda
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,14,%r25            ; @0x1ee4
	ld	%r25,[%sp,864]                  ; @0x1ee4
 ;	 }
	vvmov1.vi.to.w	%vr1,15,%r25            ; @0x1eee
	vvst.aa.w	%vr1,%r0,2496           ; @0x1ef4
	vvst.aa.w	%vr1,%r1,2496           ; @0x1efa
	ld	%r25,[%sp,676]                  ; @0x1f00
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,0,%r25             ; @0x1f04
	ld	%r25,[%sp,680]                  ; @0x1f04
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,1,%r25             ; @0x1f0e
	ld	%r25,[%sp,684]                  ; @0x1f0e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,2,%r25             ; @0x1f18
	ld	%r25,[%sp,688]                  ; @0x1f18
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,3,%r25             ; @0x1f22
	ld	%r25,[%sp,692]                  ; @0x1f22
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,4,%r25             ; @0x1f2c
	ld	%r25,[%sp,696]                  ; @0x1f2c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,5,%r25             ; @0x1f36
	ld	%r25,[%sp,700]                  ; @0x1f36
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,6,%r25             ; @0x1f40
	ld	%r25,[%sp,704]                  ; @0x1f40
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,7,%r25             ; @0x1f4a
	ld	%r25,[%sp,708]                  ; @0x1f4a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,8,%r25             ; @0x1f54
	ld	%r25,[%sp,712]                  ; @0x1f54
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,9,%r25             ; @0x1f5e
	ld	%r25,[%sp,716]                  ; @0x1f5e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,10,%r25            ; @0x1f68
	ld	%r25,[%sp,720]                  ; @0x1f68
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,11,%r25            ; @0x1f72
	ld	%r25,[%sp,724]                  ; @0x1f72
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,12,%r25            ; @0x1f7c
	ld	%r25,[%sp,728]                  ; @0x1f7c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,13,%r25            ; @0x1f86
	ld	%r25,[%sp,732]                  ; @0x1f86
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,14,%r25            ; @0x1f90
	ld	%r25,[%sp,736]                  ; @0x1f90
 ;	 }
	vvmov1.vi.to.w	%vr1,15,%r25            ; @0x1f9a
	vvst.aa.w	%vr1,%r1,2432           ; @0x1fa0
	ld	%r25,[%sp,612]                  ; @0x1fa6
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,0,%r25             ; @0x1faa
	ld	%r25,[%sp,616]                  ; @0x1faa
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,1,%r25             ; @0x1fb4
	ld	%r25,[%sp,620]                  ; @0x1fb4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,2,%r25             ; @0x1fbe
	ld	%r25,[%sp,624]                  ; @0x1fbe
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,3,%r25             ; @0x1fc8
	ld	%r25,[%sp,628]                  ; @0x1fc8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,4,%r25             ; @0x1fd2
	ld	%r25,[%sp,632]                  ; @0x1fd2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,5,%r25             ; @0x1fdc
	ld	%r25,[%sp,636]                  ; @0x1fdc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,6,%r25             ; @0x1fe6
	ld	%r25,[%sp,640]                  ; @0x1fe6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,7,%r25             ; @0x1ff0
	ld	%r25,[%sp,644]                  ; @0x1ff0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,8,%r25             ; @0x1ffa
	ld	%r25,[%sp,648]                  ; @0x1ffa
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,9,%r25             ; @0x2004
	ld	%r25,[%sp,652]                  ; @0x2004
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,10,%r25            ; @0x200e
	ld	%r25,[%sp,656]                  ; @0x200e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,11,%r25            ; @0x2018
	ld	%r25,[%sp,660]                  ; @0x2018
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,12,%r25            ; @0x2022
	ld	%r25,[%sp,664]                  ; @0x2022
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,13,%r25            ; @0x202c
	ld	%r25,[%sp,668]                  ; @0x202c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,14,%r25            ; @0x2036
	ld	%r25,[%sp,672]                  ; @0x2036
 ;	 }
	vvmov1.vi.to.w	%vr2,15,%r25            ; @0x2040
	vvst.aa.w	%vr2,%r1,2368           ; @0x2046
	ld	%r25,[%sp,484]                  ; @0x204c
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,0,%r25             ; @0x2050
	ld	%r25,[%sp,488]                  ; @0x2050
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,1,%r25             ; @0x205a
	ld	%r25,[%sp,492]                  ; @0x205a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,2,%r25             ; @0x2064
	ld	%r25,[%sp,496]                  ; @0x2064
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,3,%r25             ; @0x206e
	ld	%r25,[%sp,500]                  ; @0x206e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,4,%r25             ; @0x2078
	ld	%r25,[%sp,504]                  ; @0x2078
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,5,%r25             ; @0x2082
	ld	%r25,[%sp,508]                  ; @0x2082
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,6,%r25             ; @0x208c
	ld	%r25,[%sp,512]                  ; @0x208c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,7,%r25             ; @0x2096
	ld	%r25,[%sp,516]                  ; @0x2096
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,8,%r25             ; @0x20a0
	ld	%r25,[%sp,520]                  ; @0x20a0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,9,%r25             ; @0x20aa
	ld	%r25,[%sp,524]                  ; @0x20aa
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,10,%r25            ; @0x20b4
	ld	%r25,[%sp,528]                  ; @0x20b4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,11,%r25            ; @0x20be
	ld	%r25,[%sp,532]                  ; @0x20be
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,12,%r25            ; @0x20c8
	ld	%r25,[%sp,536]                  ; @0x20c8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,13,%r25            ; @0x20d2
	ld	%r25,[%sp,540]                  ; @0x20d2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,14,%r25            ; @0x20dc
	ld	%r25,[%sp,544]                  ; @0x20dc
 ;	 }
	vvst.aa.w	%vr1,%r0,2432           ; @0x20e6
.vvsbundle  " v2" 
 ;	 { 
	vvst.aa.w	%vr2,%r0,2368           ; @0x20ec
	vvmov1.vi.to.w	%vr3,15,%r25            ; @0x20ec
 ;	 }
	vvst.aa.w	%vr3,%r1,2304           ; @0x20f6
	vvst.aa.w	%vr3,%r0,2304           ; @0x20fc
	ld	%r25,[%r2,-4]                   ; @0x2102
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,0,%r25             ; @0x2106
	ld	%r25,[%r2,0]                    ; @0x2106
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,1,%r25             ; @0x2110
	ld	%r25,[%r2,4]                    ; @0x2110
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,2,%r25             ; @0x211a
	ld	%r25,[%r2,8]                    ; @0x211a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,3,%r25             ; @0x2124
	ld	%r25,[%r2,12]                   ; @0x2124
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,4,%r25             ; @0x212e
	ld	%r25,[%r2,16]                   ; @0x212e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,5,%r25             ; @0x2138
	ld	%r25,[%r2,20]                   ; @0x2138
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,6,%r25             ; @0x2142
	ld	%r25,[%r2,24]                   ; @0x2142
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,7,%r25             ; @0x214c
	ld	%r25,[%r2,28]                   ; @0x214c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,8,%r25             ; @0x2156
	ld	%r25,[%r2,32]                   ; @0x2156
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,9,%r25             ; @0x2160
	ld	%r25,[%r2,36]                   ; @0x2160
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,10,%r25            ; @0x216a
	ld	%r25,[%r2,40]                   ; @0x216a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,11,%r25            ; @0x2174
	ld	%r25,[%r2,44]                   ; @0x2174
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,12,%r25            ; @0x217e
	ld	%r25,[%r2,48]                   ; @0x217e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,13,%r25            ; @0x2188
	ld	%r25,[%r2,52]                   ; @0x2188
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,14,%r25            ; @0x2192
	ld	%r25,[%r2,56]                   ; @0x2192
 ;	 }
	vvmov1.vi.to.w	%vr1,15,%r25            ; @0x219c
	vvst.aa.w	%vr1,%r0,2752           ; @0x21a2
	vvst.aa.w	%vr1,%r1,2752           ; @0x21a8
	ld	%r25,[%sp,932]                  ; @0x21ae
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,0,%r25             ; @0x21b2
	ld	%r25,[%sp,936]                  ; @0x21b2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,1,%r25             ; @0x21bc
	ld	%r25,[%sp,940]                  ; @0x21bc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,2,%r25             ; @0x21c6
	ld	%r25,[%sp,944]                  ; @0x21c6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,3,%r25             ; @0x21d0
	ld	%r25,[%sp,948]                  ; @0x21d0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,4,%r25             ; @0x21da
	ld	%r25,[%sp,952]                  ; @0x21da
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,5,%r25             ; @0x21e4
	ld	%r25,[%sp,956]                  ; @0x21e4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,6,%r25             ; @0x21ee
	ld	%r25,[%sp,960]                  ; @0x21ee
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,7,%r25             ; @0x21f8
	ld	%r25,[%sp,964]                  ; @0x21f8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,8,%r25             ; @0x2202
	ld	%r25,[%sp,968]                  ; @0x2202
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,9,%r25             ; @0x220c
	ld	%r25,[%sp,972]                  ; @0x220c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,10,%r25            ; @0x2216
	ld	%r25,[%sp,976]                  ; @0x2216
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,11,%r25            ; @0x2220
	ld	%r25,[%sp,980]                  ; @0x2220
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,12,%r25            ; @0x222a
	ld	%r25,[%sp,984]                  ; @0x222a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,13,%r25            ; @0x2234
	ld	%r25,[%sp,988]                  ; @0x2234
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,14,%r25            ; @0x223e
	ld	%r25,[%sp,992]                  ; @0x223e
 ;	 }
	vvmov1.vi.to.w	%vr1,15,%r25            ; @0x2248
	vvst.aa.w	%vr1,%r1,2688           ; @0x224e
	ld	%r25,[%sp,868]                  ; @0x2254
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,0,%r25             ; @0x2258
	ld	%r25,[%sp,872]                  ; @0x2258
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,1,%r25             ; @0x2262
	ld	%r25,[%sp,876]                  ; @0x2262
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,2,%r25             ; @0x226c
	ld	%r25,[%sp,880]                  ; @0x226c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,3,%r25             ; @0x2276
	ld	%r25,[%sp,884]                  ; @0x2276
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,4,%r25             ; @0x2280
	ld	%r25,[%sp,888]                  ; @0x2280
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,5,%r25             ; @0x228a
	ld	%r25,[%sp,892]                  ; @0x228a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,6,%r25             ; @0x2294
	ld	%r25,[%sp,896]                  ; @0x2294
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,7,%r25             ; @0x229e
	ld	%r25,[%sp,900]                  ; @0x229e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,8,%r25             ; @0x22a8
	ld	%r25,[%sp,904]                  ; @0x22a8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,9,%r25             ; @0x22b2
	ld	%r25,[%sp,908]                  ; @0x22b2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,10,%r25            ; @0x22bc
	ld	%r25,[%sp,912]                  ; @0x22bc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,11,%r25            ; @0x22c6
	ld	%r25,[%sp,916]                  ; @0x22c6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,12,%r25            ; @0x22d0
	ld	%r25,[%sp,920]                  ; @0x22d0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,13,%r25            ; @0x22da
	ld	%r25,[%sp,924]                  ; @0x22da
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,14,%r25            ; @0x22e4
	ld	%r25,[%sp,928]                  ; @0x22e4
 ;	 }
	vvmov1.vi.to.w	%vr2,15,%r25            ; @0x22ee
	vvst.aa.w	%vr2,%r1,2624           ; @0x22f4
	ld	%r25,[%sp,740]                  ; @0x22fa
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,0,%r25             ; @0x22fe
	ld	%r25,[%sp,744]                  ; @0x22fe
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,1,%r25             ; @0x2308
	ld	%r25,[%sp,748]                  ; @0x2308
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,2,%r25             ; @0x2312
	ld	%r25,[%sp,752]                  ; @0x2312
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,3,%r25             ; @0x231c
	ld	%r25,[%sp,756]                  ; @0x231c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,4,%r25             ; @0x2326
	ld	%r25,[%sp,760]                  ; @0x2326
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,5,%r25             ; @0x2330
	ld	%r25,[%sp,764]                  ; @0x2330
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,6,%r25             ; @0x233a
	ld	%r25,[%sp,768]                  ; @0x233a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,7,%r25             ; @0x2344
	ld	%r25,[%sp,772]                  ; @0x2344
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,8,%r25             ; @0x234e
	ld	%r25,[%sp,776]                  ; @0x234e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,9,%r25             ; @0x2358
	ld	%r25,[%sp,780]                  ; @0x2358
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,10,%r25            ; @0x2362
	ld	%r25,[%sp,784]                  ; @0x2362
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,11,%r25            ; @0x236c
	ld	%r25,[%sp,788]                  ; @0x236c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,12,%r25            ; @0x2376
	ld	%r25,[%sp,792]                  ; @0x2376
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,13,%r25            ; @0x2380
	ld	%r25,[%sp,796]                  ; @0x2380
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,14,%r25            ; @0x238a
	ld	%r25,[%sp,800]                  ; @0x238a
 ;	 }
	vvst.aa.w	%vr1,%r0,2688           ; @0x2394
.vvsbundle  " v2" 
 ;	 { 
	vvst.aa.w	%vr2,%r0,2624           ; @0x239a
	vvmov1.vi.to.w	%vr3,15,%r25            ; @0x239a
 ;	 }
	vvst.aa.w	%vr3,%r1,2560           ; @0x23a4
	vvst.aa.w	%vr3,%r0,2560           ; @0x23aa
	ld	%r25,[%r2,252]                  ; @0x23b0
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,0,%r25             ; @0x23b4
	ld	%r25,[%r2,256]                  ; @0x23b4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,1,%r25             ; @0x23be
	ld	%r25,[%r2,260]                  ; @0x23be
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,2,%r25             ; @0x23c8
	ld	%r25,[%r2,264]                  ; @0x23c8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,3,%r25             ; @0x23d2
	ld	%r25,[%r2,268]                  ; @0x23d2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,4,%r25             ; @0x23dc
	ld	%r25,[%r2,272]                  ; @0x23dc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,5,%r25             ; @0x23e6
	ld	%r25,[%r2,276]                  ; @0x23e6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,6,%r25             ; @0x23f0
	ld	%r25,[%r2,280]                  ; @0x23f0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,7,%r25             ; @0x23fa
	ld	%r25,[%r2,284]                  ; @0x23fa
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,8,%r25             ; @0x2404
	ld	%r25,[%r2,288]                  ; @0x2404
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,9,%r25             ; @0x240e
	ld	%r25,[%r2,292]                  ; @0x240e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,10,%r25            ; @0x2418
	ld	%r25,[%r2,296]                  ; @0x2418
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,11,%r25            ; @0x2422
	ld	%r25,[%r2,300]                  ; @0x2422
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,12,%r25            ; @0x242c
	ld	%r25,[%r2,304]                  ; @0x242c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,13,%r25            ; @0x2436
	ld	%r25,[%r2,308]                  ; @0x2436
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,14,%r25            ; @0x2440
	ld	%r25,[%r2,312]                  ; @0x2440
 ;	 }
	vvmov1.vi.to.w	%vr1,15,%r25            ; @0x244a
	vvst.aa.w	%vr1,%r0,3008           ; @0x2450
	vvst.aa.w	%vr1,%r1,3008           ; @0x2456
	ld	%r25,[%r2,124]                  ; @0x245c
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,0,%r25             ; @0x2460
	ld	%r25,[%r2,128]                  ; @0x2460
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,1,%r25             ; @0x246a
	ld	%r25,[%r2,132]                  ; @0x246a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,2,%r25             ; @0x2474
	ld	%r25,[%r2,136]                  ; @0x2474
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,3,%r25             ; @0x247e
	ld	%r25,[%r2,140]                  ; @0x247e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,4,%r25             ; @0x2488
	ld	%r25,[%r2,144]                  ; @0x2488
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,5,%r25             ; @0x2492
	ld	%r25,[%r2,148]                  ; @0x2492
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,6,%r25             ; @0x249c
	ld	%r25,[%r2,152]                  ; @0x249c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,7,%r25             ; @0x24a6
	ld	%r25,[%r2,156]                  ; @0x24a6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,8,%r25             ; @0x24b0
	ld	%r25,[%r2,160]                  ; @0x24b0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,9,%r25             ; @0x24ba
	ld	%r25,[%r2,164]                  ; @0x24ba
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,10,%r25            ; @0x24c4
	ld	%r25,[%r2,168]                  ; @0x24c4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,11,%r25            ; @0x24ce
	ld	%r25,[%r2,172]                  ; @0x24ce
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,12,%r25            ; @0x24d8
	ld	%r25,[%r2,176]                  ; @0x24d8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,13,%r25            ; @0x24e2
	ld	%r25,[%r2,180]                  ; @0x24e2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,14,%r25            ; @0x24ec
	ld	%r25,[%r2,184]                  ; @0x24ec
 ;	 }
	vvmov1.vi.to.w	%vr1,15,%r25            ; @0x24f6
	vvst.aa.w	%vr1,%r1,2944           ; @0x24fc
	ld	%r25,[%r2,60]                   ; @0x2502
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,0,%r25             ; @0x2506
	ld	%r25,[%r2,64]                   ; @0x2506
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,1,%r25             ; @0x2510
	ld	%r25,[%r2,68]                   ; @0x2510
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,2,%r25             ; @0x251a
	ld	%r25,[%r2,72]                   ; @0x251a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,3,%r25             ; @0x2524
	ld	%r25,[%r2,76]                   ; @0x2524
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,4,%r25             ; @0x252e
	ld	%r25,[%r2,80]                   ; @0x252e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,5,%r25             ; @0x2538
	ld	%r25,[%r2,84]                   ; @0x2538
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,6,%r25             ; @0x2542
	ld	%r25,[%r2,88]                   ; @0x2542
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,7,%r25             ; @0x254c
	ld	%r25,[%r2,92]                   ; @0x254c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,8,%r25             ; @0x2556
	ld	%r25,[%r2,96]                   ; @0x2556
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,9,%r25             ; @0x2560
	ld	%r25,[%r2,100]                  ; @0x2560
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,10,%r25            ; @0x256a
	ld	%r25,[%r2,104]                  ; @0x256a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,11,%r25            ; @0x2574
	ld	%r25,[%r2,108]                  ; @0x2574
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,12,%r25            ; @0x257e
	ld	%r25,[%r2,112]                  ; @0x257e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,13,%r25            ; @0x2588
	ld	%r25,[%r2,116]                  ; @0x2588
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,14,%r25            ; @0x2592
	ld	%r25,[%r2,120]                  ; @0x2592
 ;	 }
	vvmov1.vi.to.w	%vr2,15,%r25            ; @0x259c
	vvst.aa.w	%vr2,%r1,2880           ; @0x25a2
	ld	%r25,[%sp,996]                  ; @0x25a8
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,0,%r25             ; @0x25ac
	ld	%r25,[%sp,1000]                 ; @0x25ac
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,1,%r25             ; @0x25b6
	ld	%r25,[%sp,1004]                 ; @0x25b6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,2,%r25             ; @0x25c0
	ld	%r25,[%sp,1008]                 ; @0x25c0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,3,%r25             ; @0x25ca
	ld	%r25,[%sp,1012]                 ; @0x25ca
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,4,%r25             ; @0x25d4
	ld	%r25,[%sp,1016]                 ; @0x25d4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,5,%r25             ; @0x25de
	ld	%r25,[%sp,1020]                 ; @0x25de
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,6,%r25             ; @0x25e8
	ld	%r25,[%r2,-40]                  ; @0x25e8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,7,%r25             ; @0x25f2
	ld	%r25,[%r2,-36]                  ; @0x25f2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,8,%r25             ; @0x25fc
	ld	%r25,[%r2,-32]                  ; @0x25fc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,9,%r25             ; @0x2606
	ld	%r25,[%r2,-28]                  ; @0x2606
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,10,%r25            ; @0x2610
	ld	%r25,[%r2,-24]                  ; @0x2610
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,11,%r25            ; @0x261a
	ld	%r25,[%r2,-20]                  ; @0x261a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,12,%r25            ; @0x2624
	ld	%r25,[%r2,-16]                  ; @0x2624
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,13,%r25            ; @0x262e
	ld	%r25,[%r2,-12]                  ; @0x262e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,14,%r25            ; @0x2638
	ld	%r25,[%r2,-8]                   ; @0x2638
 ;	 }
	vvst.aa.w	%vr1,%r0,2944           ; @0x2642
.vvsbundle  " v2" 
 ;	 { 
	vvst.aa.w	%vr2,%r0,2880           ; @0x2648
	vvmov1.vi.to.w	%vr3,15,%r25            ; @0x2648
 ;	 }
	vvst.aa.w	%vr3,%r1,2816           ; @0x2652
	vvst.aa.w	%vr3,%r0,2816           ; @0x2658
	ld	%r25,[%r2,508]                  ; @0x265e
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,0,%r25             ; @0x2662
	ld	%r25,[%r2,512]                  ; @0x2662
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,1,%r25             ; @0x266c
	ld	%r25,[%r2,516]                  ; @0x266c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,2,%r25             ; @0x2676
	ld	%r25,[%r2,520]                  ; @0x2676
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,3,%r25             ; @0x2680
	ld	%r25,[%r2,524]                  ; @0x2680
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,4,%r25             ; @0x268a
	ld	%r25,[%r2,528]                  ; @0x268a
 ;	 }
	vvmov1.vi.to.w	%vr1,5,%r25             ; @0x2694
	ld	%r25,[%r2,532]                  ; @0x269a
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,6,%r25             ; @0x269e
	ld	%r25,[%r2,536]                  ; @0x269e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,7,%r25             ; @0x26a8
	ld	%r25,[%r2,540]                  ; @0x26a8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,8,%r25             ; @0x26b2
	ld	%r25,[%r2,544]                  ; @0x26b2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,9,%r25             ; @0x26bc
	ld	%r25,[%r2,548]                  ; @0x26bc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,10,%r25            ; @0x26c6
	ld	%r25,[%r2,552]                  ; @0x26c6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,11,%r25            ; @0x26d0
	ld	%r25,[%r2,556]                  ; @0x26d0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,12,%r25            ; @0x26da
	ld	%r25,[%r2,560]                  ; @0x26da
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,13,%r25            ; @0x26e4
	ld	%r25,[%r2,564]                  ; @0x26e4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,14,%r25            ; @0x26ee
	ld	%r25,[%r2,568]                  ; @0x26ee
 ;	 }
	vvmov1.vi.to.w	%vr1,15,%r25            ; @0x26f8
	vvst.aa.w	%vr1,%r0,3264           ; @0x26fe
	vvst.aa.w	%vr1,%r1,3264           ; @0x2704
	ld	%r25,[%r2,380]                  ; @0x270a
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,0,%r25             ; @0x270e
	ld	%r25,[%r2,384]                  ; @0x270e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,1,%r25             ; @0x2718
	ld	%r25,[%r2,388]                  ; @0x2718
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,2,%r25             ; @0x2722
	ld	%r25,[%r2,392]                  ; @0x2722
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,3,%r25             ; @0x272c
	ld	%r25,[%r2,396]                  ; @0x272c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,4,%r25             ; @0x2736
	ld	%r25,[%r2,400]                  ; @0x2736
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,5,%r25             ; @0x2740
	ld	%r25,[%r2,404]                  ; @0x2740
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,6,%r25             ; @0x274a
	ld	%r25,[%r2,408]                  ; @0x274a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,7,%r25             ; @0x2754
	ld	%r25,[%r2,412]                  ; @0x2754
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,8,%r25             ; @0x275e
	ld	%r25,[%r2,416]                  ; @0x275e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,9,%r25             ; @0x2768
	ld	%r25,[%r2,420]                  ; @0x2768
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,10,%r25            ; @0x2772
	ld	%r25,[%r2,424]                  ; @0x2772
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,11,%r25            ; @0x277c
	ld	%r25,[%r2,428]                  ; @0x277c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,12,%r25            ; @0x2786
	ld	%r25,[%r2,432]                  ; @0x2786
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,13,%r25            ; @0x2790
	ld	%r25,[%r2,436]                  ; @0x2790
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,14,%r25            ; @0x279a
	ld	%r25,[%r2,440]                  ; @0x279a
 ;	 }
	vvmov1.vi.to.w	%vr1,15,%r25            ; @0x27a4
	vvst.aa.w	%vr1,%r1,3200           ; @0x27aa
	ld	%r25,[%r2,316]                  ; @0x27b0
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,0,%r25             ; @0x27b4
	ld	%r25,[%r2,320]                  ; @0x27b4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,1,%r25             ; @0x27be
	ld	%r25,[%r2,324]                  ; @0x27be
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,2,%r25             ; @0x27c8
	ld	%r25,[%r2,328]                  ; @0x27c8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,3,%r25             ; @0x27d2
	ld	%r25,[%r2,332]                  ; @0x27d2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,4,%r25             ; @0x27dc
	ld	%r25,[%r2,336]                  ; @0x27dc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,5,%r25             ; @0x27e6
	ld	%r25,[%r2,340]                  ; @0x27e6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,6,%r25             ; @0x27f0
	ld	%r25,[%r2,344]                  ; @0x27f0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,7,%r25             ; @0x27fa
	ld	%r25,[%r2,348]                  ; @0x27fa
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,8,%r25             ; @0x2804
	ld	%r25,[%r2,352]                  ; @0x2804
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,9,%r25             ; @0x280e
	ld	%r25,[%r2,356]                  ; @0x280e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,10,%r25            ; @0x2818
	ld	%r25,[%r2,360]                  ; @0x2818
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,11,%r25            ; @0x2822
	ld	%r25,[%r2,364]                  ; @0x2822
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,12,%r25            ; @0x282c
	ld	%r25,[%r2,368]                  ; @0x282c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,13,%r25            ; @0x2836
	ld	%r25,[%r2,372]                  ; @0x2836
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,14,%r25            ; @0x2840
	ld	%r25,[%r2,376]                  ; @0x2840
 ;	 }
	vvmov1.vi.to.w	%vr2,15,%r25            ; @0x284a
	vvst.aa.w	%vr2,%r1,3136           ; @0x2850
	ld	%r25,[%r2,188]                  ; @0x2856
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,0,%r25             ; @0x285a
	ld	%r25,[%r2,192]                  ; @0x285a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,1,%r25             ; @0x2864
	ld	%r25,[%r2,196]                  ; @0x2864
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,2,%r25             ; @0x286e
	ld	%r25,[%r2,200]                  ; @0x286e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,3,%r25             ; @0x2878
	ld	%r25,[%r2,204]                  ; @0x2878
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,4,%r25             ; @0x2882
	ld	%r25,[%r2,208]                  ; @0x2882
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,5,%r25             ; @0x288c
	ld	%r25,[%r2,212]                  ; @0x288c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,6,%r25             ; @0x2896
	ld	%r25,[%r2,216]                  ; @0x2896
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,7,%r25             ; @0x28a0
	ld	%r25,[%r2,220]                  ; @0x28a0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,8,%r25             ; @0x28aa
	ld	%r25,[%r2,224]                  ; @0x28aa
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,9,%r25             ; @0x28b4
	ld	%r25,[%r2,228]                  ; @0x28b4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,10,%r25            ; @0x28be
	ld	%r25,[%r2,232]                  ; @0x28be
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,11,%r25            ; @0x28c8
	ld	%r25,[%r2,236]                  ; @0x28c8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,12,%r25            ; @0x28d2
	ld	%r25,[%r2,240]                  ; @0x28d2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,13,%r25            ; @0x28dc
	ld	%r25,[%r2,244]                  ; @0x28dc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,14,%r25            ; @0x28e6
	ld	%r25,[%r2,248]                  ; @0x28e6
 ;	 }
	vvst.aa.w	%vr1,%r0,3200           ; @0x28f0
.vvsbundle  " v2" 
 ;	 { 
	vvst.aa.w	%vr2,%r0,3136           ; @0x28f6
	vvmov1.vi.to.w	%vr3,15,%r25            ; @0x28f6
 ;	 }
	vvst.aa.w	%vr3,%r1,3072           ; @0x2900
	vvst.aa.w	%vr3,%r0,3072           ; @0x2906
	ld	%r25,[%r2,700]                  ; @0x290c
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,0,%r25             ; @0x2910
	ld	%r25,[%r2,704]                  ; @0x2910
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,1,%r25             ; @0x291a
	ld	%r25,[%r2,708]                  ; @0x291a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,2,%r25             ; @0x2924
	ld	%r25,[%r2,712]                  ; @0x2924
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,3,%r25             ; @0x292e
	ld	%r25,[%r2,716]                  ; @0x292e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,4,%r25             ; @0x2938
	ld	%r25,[%r2,720]                  ; @0x2938
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,5,%r25             ; @0x2942
	ld	%r25,[%r2,724]                  ; @0x2942
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,6,%r25             ; @0x294c
	ld	%r25,[%r2,728]                  ; @0x294c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,7,%r25             ; @0x2956
	ld	%r25,[%r2,732]                  ; @0x2956
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,8,%r25             ; @0x2960
	ld	%r25,[%r2,736]                  ; @0x2960
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,9,%r25             ; @0x296a
	ld	%r25,[%r2,740]                  ; @0x296a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,10,%r25            ; @0x2974
	ld	%r25,[%r2,744]                  ; @0x2974
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,11,%r25            ; @0x297e
	ld	%r25,[%r2,748]                  ; @0x297e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,12,%r25            ; @0x2988
	ld	%r25,[%r2,752]                  ; @0x2988
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,13,%r25            ; @0x2992
	ld	%r25,[%r2,756]                  ; @0x2992
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,14,%r25            ; @0x299c
	ld	%r25,[%r2,760]                  ; @0x299c
 ;	 }
	vvmov1.vi.to.w	%vr1,15,%r25            ; @0x29a6
	vvst.aa.w	%vr1,%r0,3520           ; @0x29ac
	vvst.aa.w	%vr1,%r1,3520           ; @0x29b2
	ld	%r25,[%r2,636]                  ; @0x29b8
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,0,%r25             ; @0x29bc
	ld	%r25,[%r2,640]                  ; @0x29bc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,1,%r25             ; @0x29c6
	ld	%r25,[%r2,644]                  ; @0x29c6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,2,%r25             ; @0x29d0
	ld	%r25,[%r2,648]                  ; @0x29d0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,3,%r25             ; @0x29da
	ld	%r25,[%r2,652]                  ; @0x29da
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,4,%r25             ; @0x29e4
	ld	%r25,[%r2,656]                  ; @0x29e4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,5,%r25             ; @0x29ee
	ld	%r25,[%r2,660]                  ; @0x29ee
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,6,%r25             ; @0x29f8
	ld	%r25,[%r2,664]                  ; @0x29f8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,7,%r25             ; @0x2a02
	ld	%r25,[%r2,668]                  ; @0x2a02
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,8,%r25             ; @0x2a0c
	ld	%r25,[%r2,672]                  ; @0x2a0c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,9,%r25             ; @0x2a16
	ld	%r25,[%r2,676]                  ; @0x2a16
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,10,%r25            ; @0x2a20
	ld	%r25,[%r2,680]                  ; @0x2a20
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,11,%r25            ; @0x2a2a
	ld	%r25,[%r2,684]                  ; @0x2a2a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,12,%r25            ; @0x2a34
	ld	%r25,[%r2,688]                  ; @0x2a34
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,13,%r25            ; @0x2a3e
	ld	%r25,[%r2,692]                  ; @0x2a3e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,14,%r25            ; @0x2a48
	ld	%r25,[%r2,696]                  ; @0x2a48
 ;	 }
	vvmov1.vi.to.w	%vr3,15,%r25            ; @0x2a52
	vvst.aa.w	%vr3,%r1,3456           ; @0x2a58
	ld	%r25,[%r2,572]                  ; @0x2a5e
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,0,%r25             ; @0x2a62
	ld	%r25,[%r2,576]                  ; @0x2a62
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,1,%r25             ; @0x2a6c
	ld	%r25,[%r2,580]                  ; @0x2a6c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,2,%r25             ; @0x2a76
	ld	%r25,[%r2,584]                  ; @0x2a76
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,3,%r25             ; @0x2a80
	ld	%r25,[%r2,588]                  ; @0x2a80
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,4,%r25             ; @0x2a8a
	ld	%r25,[%r2,592]                  ; @0x2a8a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,5,%r25             ; @0x2a94
	ld	%r25,[%r2,596]                  ; @0x2a94
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,6,%r25             ; @0x2a9e
	ld	%r25,[%r2,600]                  ; @0x2a9e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,7,%r25             ; @0x2aa8
	ld	%r25,[%r2,604]                  ; @0x2aa8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,8,%r25             ; @0x2ab2
	ld	%r25,[%r2,608]                  ; @0x2ab2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,9,%r25             ; @0x2abc
	ld	%r25,[%r2,612]                  ; @0x2abc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,10,%r25            ; @0x2ac6
	ld	%r25,[%r2,616]                  ; @0x2ac6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,11,%r25            ; @0x2ad0
	ld	%r25,[%r2,620]                  ; @0x2ad0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,12,%r25            ; @0x2ada
	ld	%r25,[%r2,624]                  ; @0x2ada
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,13,%r25            ; @0x2ae4
	ld	%r25,[%r2,628]                  ; @0x2ae4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,14,%r25            ; @0x2aee
	ld	%r25,[%r2,632]                  ; @0x2aee
 ;	 }
	vvmov1.vi.to.w	%vr2,15,%r25            ; @0x2af8
	vvst.aa.w	%vr2,%r1,3392           ; @0x2afe
	ld	%r25,[%r2,444]                  ; @0x2b04
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,0,%r25             ; @0x2b08
	ld	%r25,[%r2,448]                  ; @0x2b08
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,1,%r25             ; @0x2b12
	ld	%r25,[%r2,452]                  ; @0x2b12
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,2,%r25             ; @0x2b1c
	ld	%r25,[%r2,456]                  ; @0x2b1c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,3,%r25             ; @0x2b26
	ld	%r25,[%r2,460]                  ; @0x2b26
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,4,%r25             ; @0x2b30
	ld	%r25,[%r2,464]                  ; @0x2b30
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,5,%r25             ; @0x2b3a
	ld	%r25,[%r2,468]                  ; @0x2b3a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,6,%r25             ; @0x2b44
	ld	%r25,[%r2,472]                  ; @0x2b44
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,7,%r25             ; @0x2b4e
	ld	%r25,[%r2,476]                  ; @0x2b4e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,8,%r25             ; @0x2b58
	ld	%r25,[%r2,480]                  ; @0x2b58
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,9,%r25             ; @0x2b62
	ld	%r25,[%r2,484]                  ; @0x2b62
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,10,%r25            ; @0x2b6c
	ld	%r25,[%r2,488]                  ; @0x2b6c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,11,%r25            ; @0x2b76
	ld	%r25,[%r2,492]                  ; @0x2b76
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,12,%r25            ; @0x2b80
	ld	%r25,[%r2,496]                  ; @0x2b80
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,13,%r25            ; @0x2b8a
	ld	%r25,[%r2,500]                  ; @0x2b8a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,14,%r25            ; @0x2b94
	ld	%r25,[%r2,504]                  ; @0x2b94
 ;	 }
	vvst.aa.w	%vr3,%r0,3456           ; @0x2b9e
.vvsbundle  " v2" 
 ;	 { 
	vvst.aa.w	%vr2,%r0,3392           ; @0x2ba4
	vvmov1.vi.to.w	%vr1,15,%r25            ; @0x2ba4
 ;	 }
	vvst.aa.w	%vr1,%r1,3328           ; @0x2bae
	vvst.aa.w	%vr1,%r0,3328           ; @0x2bb4
	ld	%r25,[%r2,956]                  ; @0x2bba
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,0,%r25             ; @0x2bbe
	ld	%r25,[%r2,960]                  ; @0x2bbe
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,1,%r25             ; @0x2bc8
	ld	%r25,[%r2,964]                  ; @0x2bc8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,2,%r25             ; @0x2bd2
	ld	%r25,[%r2,968]                  ; @0x2bd2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,3,%r25             ; @0x2bdc
	ld	%r25,[%r2,972]                  ; @0x2bdc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,4,%r25             ; @0x2be6
	ld	%r25,[%r2,976]                  ; @0x2be6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,5,%r25             ; @0x2bf0
	ld	%r25,[%r2,980]                  ; @0x2bf0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,6,%r25             ; @0x2bfa
	ld	%r25,[%r2,984]                  ; @0x2bfa
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,7,%r25             ; @0x2c04
	ld	%r25,[%r2,988]                  ; @0x2c04
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,8,%r25             ; @0x2c0e
	ld	%r25,[%r2,992]                  ; @0x2c0e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,9,%r25             ; @0x2c18
	ld	%r25,[%r2,996]                  ; @0x2c18
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,10,%r25            ; @0x2c22
	ld	%r25,[%r2,1000]                 ; @0x2c22
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,11,%r25            ; @0x2c2c
	ld	%r25,[%r2,1004]                 ; @0x2c2c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,12,%r25            ; @0x2c36
	ld	%r25,[%r2,1008]                 ; @0x2c36
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,13,%r25            ; @0x2c40
	ld	%r25,[%r2,1012]                 ; @0x2c40
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,14,%r25            ; @0x2c4a
	ld	%r25,[%r2,1016]                 ; @0x2c4a
 ;	 }
	vvmov1.vi.to.w	%vr1,15,%r25            ; @0x2c54
	vvst.aa.w	%vr1,%r0,3776           ; @0x2c5a
	vvst.aa.w	%vr1,%r1,3776           ; @0x2c60
	ld	%r25,[%r2,892]                  ; @0x2c66
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,0,%r25             ; @0x2c6a
	ld	%r25,[%r2,896]                  ; @0x2c6a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,1,%r25             ; @0x2c74
	ld	%r25,[%r2,900]                  ; @0x2c74
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,2,%r25             ; @0x2c7e
	ld	%r25,[%r2,904]                  ; @0x2c7e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,3,%r25             ; @0x2c88
	ld	%r25,[%r2,908]                  ; @0x2c88
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,4,%r25             ; @0x2c92
	ld	%r25,[%r2,912]                  ; @0x2c92
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,5,%r25             ; @0x2c9c
	ld	%r25,[%r2,916]                  ; @0x2c9c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,6,%r25             ; @0x2ca6
	ld	%r25,[%r2,920]                  ; @0x2ca6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,7,%r25             ; @0x2cb0
	ld	%r25,[%r2,924]                  ; @0x2cb0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,8,%r25             ; @0x2cba
	ld	%r25,[%r2,928]                  ; @0x2cba
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,9,%r25             ; @0x2cc4
	ld	%r25,[%r2,932]                  ; @0x2cc4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,10,%r25            ; @0x2cce
	ld	%r25,[%r2,936]                  ; @0x2cce
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,11,%r25            ; @0x2cd8
	ld	%r25,[%r2,940]                  ; @0x2cd8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,12,%r25            ; @0x2ce2
	ld	%r25,[%r2,944]                  ; @0x2ce2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,13,%r25            ; @0x2cec
	ld	%r25,[%r2,948]                  ; @0x2cec
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr3,14,%r25            ; @0x2cf6
	ld	%r25,[%r2,952]                  ; @0x2cf6
 ;	 }
	vvmov1.vi.to.w	%vr3,15,%r25            ; @0x2d00
	vvst.aa.w	%vr3,%r1,3712           ; @0x2d06
	ld	%r25,[%r2,828]                  ; @0x2d0c
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,0,%r25             ; @0x2d10
	ld	%r25,[%r2,832]                  ; @0x2d10
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,1,%r25             ; @0x2d1a
	ld	%r25,[%r2,836]                  ; @0x2d1a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,2,%r25             ; @0x2d24
	ld	%r25,[%r2,840]                  ; @0x2d24
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,3,%r25             ; @0x2d2e
	ld	%r25,[%r2,844]                  ; @0x2d2e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,4,%r25             ; @0x2d38
	ld	%r25,[%r2,848]                  ; @0x2d38
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,5,%r25             ; @0x2d42
	ld	%r25,[%r2,852]                  ; @0x2d42
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,6,%r25             ; @0x2d4c
	ld	%r25,[%r2,856]                  ; @0x2d4c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,7,%r25             ; @0x2d56
	ld	%r25,[%r2,860]                  ; @0x2d56
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,8,%r25             ; @0x2d60
	ld	%r25,[%r2,864]                  ; @0x2d60
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,9,%r25             ; @0x2d6a
	ld	%r25,[%r2,868]                  ; @0x2d6a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,10,%r25            ; @0x2d74
	ld	%r25,[%r2,872]                  ; @0x2d74
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,11,%r25            ; @0x2d7e
	ld	%r25,[%r2,876]                  ; @0x2d7e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,12,%r25            ; @0x2d88
	ld	%r25,[%r2,880]                  ; @0x2d88
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,13,%r25            ; @0x2d92
	ld	%r25,[%r2,884]                  ; @0x2d92
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,14,%r25            ; @0x2d9c
	ld	%r25,[%r2,888]                  ; @0x2d9c
 ;	 }
	vvmov1.vi.to.w	%vr2,15,%r25            ; @0x2da6
	vvst.aa.w	%vr2,%r1,3648           ; @0x2dac
	ld	%r25,[%r2,764]                  ; @0x2db2
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,0,%r25             ; @0x2db6
	ld	%r25,[%r2,768]                  ; @0x2db6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,1,%r25             ; @0x2dc0
	ld	%r25,[%r2,772]                  ; @0x2dc0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,2,%r25             ; @0x2dca
	ld	%r25,[%r2,776]                  ; @0x2dca
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,3,%r25             ; @0x2dd4
	ld	%r25,[%r2,780]                  ; @0x2dd4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,4,%r25             ; @0x2dde
	ld	%r25,[%r2,784]                  ; @0x2dde
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,5,%r25             ; @0x2de8
	ld	%r25,[%r2,788]                  ; @0x2de8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,6,%r25             ; @0x2df2
	ld	%r25,[%r2,792]                  ; @0x2df2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,7,%r25             ; @0x2dfc
	ld	%r25,[%r2,796]                  ; @0x2dfc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,8,%r25             ; @0x2e06
	ld	%r25,[%r2,800]                  ; @0x2e06
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,9,%r25             ; @0x2e10
	ld	%r25,[%r2,804]                  ; @0x2e10
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,10,%r25            ; @0x2e1a
	ld	%r25,[%r2,808]                  ; @0x2e1a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,11,%r25            ; @0x2e24
	ld	%r25,[%r2,812]                  ; @0x2e24
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,12,%r25            ; @0x2e2e
	ld	%r25,[%r2,816]                  ; @0x2e2e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,13,%r25            ; @0x2e38
	ld	%r25,[%r2,820]                  ; @0x2e38
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,14,%r25            ; @0x2e42
	ld	%r25,[%r2,824]                  ; @0x2e42
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvst.aa.w	%vr3,%r0,3712           ; @0x2e4c
	add	%r2,%sp,0x868@u32               ; @0x2e4c
 ;	 }
.vvsbundle  " v2" 
 ;	 { 
	vvst.aa.w	%vr2,%r0,3648           ; @0x2e5a
	vvmov1.vi.to.w	%vr1,15,%r25            ; @0x2e5a
 ;	 }
	vvst.aa.w	%vr1,%r1,3584           ; @0x2e64
	vvst.aa.w	%vr1,%r0,3584           ; @0x2e6a
	vvst.aa.w	%vr0,%r0,4032           ; @0x2e70
	vvst.aa.w	%vr0,%r1,4032           ; @0x2e76
	ld	%r25,[%r2,-4]                   ; @0x2e7c
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,0,%r25             ; @0x2e80
	ld	%r25,[%r2,0]                    ; @0x2e80
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,1,%r25             ; @0x2e8a
	ld	%r25,[%r2,4]                    ; @0x2e8a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,2,%r25             ; @0x2e94
	ld	%r25,[%r2,8]                    ; @0x2e94
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,3,%r25             ; @0x2e9e
	ld	%r25,[%r2,12]                   ; @0x2e9e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,4,%r25             ; @0x2ea8
	ld	%r25,[%r2,16]                   ; @0x2ea8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,5,%r25             ; @0x2eb2
	ld	%r25,[%r2,20]                   ; @0x2eb2
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,6,%r25             ; @0x2ebc
	ld	%r25,[%r2,24]                   ; @0x2ebc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,7,%r25             ; @0x2ec6
	ld	%r25,[%r2,28]                   ; @0x2ec6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,8,%r25             ; @0x2ed0
	ld	%r25,[%r2,32]                   ; @0x2ed0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,9,%r25             ; @0x2eda
	ld	%r25,[%r2,36]                   ; @0x2eda
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,10,%r25            ; @0x2ee4
	ld	%r25,[%r2,40]                   ; @0x2ee4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,11,%r25            ; @0x2eee
	ld	%r25,[%r2,44]                   ; @0x2eee
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,12,%r25            ; @0x2ef8
	ld	%r25,[%r2,48]                   ; @0x2ef8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,13,%r25            ; @0x2f02
	ld	%r25,[%r2,52]                   ; @0x2f02
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr1,14,%r25            ; @0x2f0c
	ld	%r25,[%r2,56]                   ; @0x2f0c
 ;	 }
	vvmov1.vi.to.w	%vr1,15,%r25            ; @0x2f16
	vvst.aa.w	%vr1,%r1,3968           ; @0x2f1c
	ld	%r25,[%r2,-68]                  ; @0x2f22
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,0,%r25             ; @0x2f26
	ld	%r25,[%r2,-64]                  ; @0x2f26
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,1,%r25             ; @0x2f30
	ld	%r25,[%r2,-60]                  ; @0x2f30
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,2,%r25             ; @0x2f3a
	ld	%r25,[%r2,-56]                  ; @0x2f3a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,3,%r25             ; @0x2f44
	ld	%r25,[%r2,-52]                  ; @0x2f44
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,4,%r25             ; @0x2f4e
	ld	%r25,[%r2,-48]                  ; @0x2f4e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,5,%r25             ; @0x2f58
	ld	%r25,[%r2,-44]                  ; @0x2f58
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,6,%r25             ; @0x2f62
	ld	%r25,[%r2,-40]                  ; @0x2f62
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,7,%r25             ; @0x2f6c
	ld	%r25,[%r2,-36]                  ; @0x2f6c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,8,%r25             ; @0x2f76
	ld	%r25,[%r2,-32]                  ; @0x2f76
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,9,%r25             ; @0x2f80
	ld	%r25,[%r2,-28]                  ; @0x2f80
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,10,%r25            ; @0x2f8a
	ld	%r25,[%r2,-24]                  ; @0x2f8a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,11,%r25            ; @0x2f94
	ld	%r25,[%r2,-20]                  ; @0x2f94
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,12,%r25            ; @0x2f9e
	ld	%r25,[%r2,-16]                  ; @0x2f9e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,13,%r25            ; @0x2fa8
	ld	%r25,[%r2,-12]                  ; @0x2fa8
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr2,14,%r25            ; @0x2fb2
	ld	%r25,[%r2,-8]                   ; @0x2fb2
 ;	 }
	vvmov1.vi.to.w	%vr2,15,%r25            ; @0x2fbc
	vvst.aa.w	%vr2,%r1,3904           ; @0x2fc2
	ld	%r25,[%r2,60]                   ; @0x2fc8
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,0,%r25             ; @0x2fcc
	ld	%r25,[%r2,64]                   ; @0x2fcc
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,1,%r25             ; @0x2fd6
	ld	%r25,[%r2,68]                   ; @0x2fd6
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,2,%r25             ; @0x2fe0
	ld	%r25,[%r2,72]                   ; @0x2fe0
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,3,%r25             ; @0x2fea
	ld	%r25,[%r2,76]                   ; @0x2fea
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,4,%r25             ; @0x2ff4
	ld	%r25,[%r2,80]                   ; @0x2ff4
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,5,%r25             ; @0x2ffe
	ld	%r25,[%r2,84]                   ; @0x2ffe
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,6,%r25             ; @0x3008
	ld	%r25,[%r2,88]                   ; @0x3008
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,7,%r25             ; @0x3012
	ld	%r25,[%r2,92]                   ; @0x3012
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,8,%r25             ; @0x301c
	ld	%r25,[%r2,96]                   ; @0x301c
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,9,%r25             ; @0x3026
	ld	%r25,[%r2,100]                  ; @0x3026
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,10,%r25            ; @0x3030
	ld	%r25,[%r2,104]                  ; @0x3030
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,11,%r25            ; @0x303a
	ld	%r25,[%r2,108]                  ; @0x303a
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,12,%r25            ; @0x3044
	ld	%r25,[%r2,112]                  ; @0x3044
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,13,%r25            ; @0x304e
	ld	%r25,[%r2,116]                  ; @0x304e
 ;	 }
.vvsbundle  "v1sc" 
 ;	 { 
	vvmov1.vi.to.w	%vr0,14,%r25            ; @0x3058
	ld	%r25,[%r2,120]                  ; @0x3058
 ;	 }
	vvst.aa.w	%vr1,%r0,3968           ; @0x3062
.vvsbundle  " v2" 
 ;	 { 
	vvst.aa.w	%vr2,%r0,3904           ; @0x3068
	vvmov1.vi.to.w	%vr0,15,%r25            ; @0x3068
 ;	 }
	vvst.aa.w	%vr0,%r1,3840           ; @0x3072
	vvst.aa.w	%vr0,%r0,3840           ; @0x3078
	bl	clock                           ; @0x307e
	mov_s	%r13,%r0                        ; @0x3082
	add	%r0,%r56,0x2000@u32             ; @0x3084
	add	%r1,%r56,0x1000@u32             ; @0x308c
	add	%r2,%r56,0                      ; @0x3094
	mov	%r3,1024                        ; @0x3098
	bl	vec_sum                         ; @0x309c
	mov_s	%r19,0x408f4000@u32             ; @0x30a0
	mov_s	%r18,0                          ; @0x30a6
	bl	clock                           ; @0x30a8
	sub_s	%r0,%r0,%r13                    ; @0x30ac
	fint2d	%r2,%r0                         ; @0x30ae
	fdmul	%r14,%r2,%r18                   ; @0x30b2
	bl	_timer_clocks_per_sec           ; @0x30b6
	fuint2d	%r2,%r0                         ; @0x30ba
	fddiv	%r20,%r14,%r2                   ; @0x30be
	add2	%r0,%r16,(.L.str.1-.L.str.3)/4  ; @0x30c2
	mov_s	%r1,%r20                        ; @0x30c6
	mov_s	%r2,%r21                        ; @0x30c8
	bl	printf                          ; @0x30ca
	add	%r13,%r16,.Lstr.13-.L.str.3     ; @0x30ce
	mov_s	%r0,%r13                        ; @0x30d2
	bl	puts                            ; @0x30d4
	ld	%r4,[%r56,4096]                 ; @0x30d8
	ld	%r6,[%r56,0]                    ; @0x30e0
	ld	%r2,[%r56,8192]                 ; @0x30e4
	mov_s	%r0,%r16                        ; @0x30ec
	mov_s	%r1,0                           ; @0x30ee
	mov_s	%r3,0                           ; @0x30f0
	mov_s	%r5,0                           ; @0x30f2
	bl	printf                          ; @0x30f4
	ld	%r4,[%r56,4100]                 ; @0x30f8
	ld	%r6,[%r56,4]                    ; @0x3100
	ld	%r2,[%r56,8196]                 ; @0x3104
	mov_s	%r0,%r16                        ; @0x310c
	mov_s	%r1,1                           ; @0x310e
	mov_s	%r3,1                           ; @0x3110
	mov_s	%r5,1                           ; @0x3112
	bl	printf                          ; @0x3114
	ld	%r4,[%r56,4104]                 ; @0x3118
	ld	%r6,[%r56,8]                    ; @0x3120
	ld	%r2,[%r56,8200]                 ; @0x3124
	mov_s	%r0,%r16                        ; @0x312c
	mov_s	%r1,2                           ; @0x312e
	mov_s	%r3,2                           ; @0x3130
	mov_s	%r5,2                           ; @0x3132
	bl	printf                          ; @0x3134
	ld	%r4,[%r56,4108]                 ; @0x3138
	ld	%r6,[%r56,12]                   ; @0x3140
	ld	%r2,[%r56,8204]                 ; @0x3144
	mov_s	%r0,%r16                        ; @0x314c
	mov_s	%r1,3                           ; @0x314e
	mov_s	%r3,3                           ; @0x3150
	mov_s	%r5,3                           ; @0x3152
	bl	printf                          ; @0x3154
	ld	%r4,[%r56,4112]                 ; @0x3158
	ld	%r6,[%r56,16]                   ; @0x3160
	ld	%r2,[%r56,8208]                 ; @0x3164
	mov_s	%r0,%r16                        ; @0x316c
	mov_s	%r1,4                           ; @0x316e
	mov_s	%r3,4                           ; @0x3170
	mov_s	%r5,4                           ; @0x3172
	bl	printf                          ; @0x3174
	mov_s	%r0,10                          ; @0x3178
	bl	putchar                         ; @0x317a
	add1	%r0,%r16,(.L.str.5-.L.str.3)/2  ; @0x317e
	mov_s	%r1,16                          ; @0x3182
	bl	printf                          ; @0x3184
	bl	clock                           ; @0x3188
	mov_s	%r14,%r0                        ; @0x318c
	add	%r0,%r56,0x2000@u32             ; @0x318e
	add	%r1,%r56,0x1000@u32             ; @0x3196
	add	%r2,%r56,0                      ; @0x319e
	mov	%r3,1024                        ; @0x31a2
	bl	vectorized_vec_sum              ; @0x31a6
	bl	clock                           ; @0x31aa
	sub_s	%r0,%r0,%r14                    ; @0x31ae
	fint2d	%r2,%r0                         ; @0x31b0
	fdmul	%r14,%r2,%r18                   ; @0x31b4
	bl	_timer_clocks_per_sec           ; @0x31b8
	fuint2d	%r2,%r0                         ; @0x31bc
	fddiv	%r14,%r14,%r2                   ; @0x31c0
	add2	%r0,%r16,(.L.str.6-.L.str.3)/4  ; @0x31c4
	mov_s	%r1,%r14                        ; @0x31c8
	mov_s	%r2,%r15                        ; @0x31ca
	bl	printf                          ; @0x31cc
	fddiv	%r2,%r20,%r14                   ; @0x31d0
	add1	%r14,%r16,(.L.str.7-.L.str.3)/2 ; @0x31d4
	mov_s	%r0,%r14                        ; @0x31d8
	mov_s	%r1,%r2                         ; @0x31da
	mov_s	%r2,%r3                         ; @0x31dc
	bl	printf                          ; @0x31de
	mov_s	%r0,%r13                        ; @0x31e2
	bl	puts                            ; @0x31e4
	ld	%r4,[%r56,4096]                 ; @0x31e8
	ld	%r6,[%r56,0]                    ; @0x31f0
	ld	%r2,[%r56,8192]                 ; @0x31f4
	mov_s	%r0,%r16                        ; @0x31fc
	mov_s	%r1,0                           ; @0x31fe
	mov_s	%r3,0                           ; @0x3200
	mov_s	%r5,0                           ; @0x3202
	bl	printf                          ; @0x3204
	ld	%r4,[%r56,4100]                 ; @0x3208
	ld	%r6,[%r56,4]                    ; @0x3210
	ld	%r2,[%r56,8196]                 ; @0x3214
	mov_s	%r0,%r16                        ; @0x321c
	mov_s	%r1,1                           ; @0x321e
	mov_s	%r3,1                           ; @0x3220
	mov_s	%r5,1                           ; @0x3222
	bl	printf                          ; @0x3224
	ld	%r4,[%r56,4104]                 ; @0x3228
	ld	%r6,[%r56,8]                    ; @0x3230
	ld	%r2,[%r56,8200]                 ; @0x3234
	mov_s	%r0,%r16                        ; @0x323c
	mov_s	%r1,2                           ; @0x323e
	mov_s	%r3,2                           ; @0x3240
	mov_s	%r5,2                           ; @0x3242
	bl	printf                          ; @0x3244
	ld	%r4,[%r56,4108]                 ; @0x3248
	ld	%r6,[%r56,12]                   ; @0x3250
	ld	%r2,[%r56,8204]                 ; @0x3254
	mov_s	%r0,%r16                        ; @0x325c
	mov_s	%r1,3                           ; @0x325e
	mov_s	%r3,3                           ; @0x3260
	mov_s	%r5,3                           ; @0x3262
	bl	printf                          ; @0x3264
	ld	%r4,[%r56,4112]                 ; @0x3268
	ld	%r6,[%r56,16]                   ; @0x3270
	ld	%r2,[%r56,8208]                 ; @0x3274
	mov_s	%r0,%r16                        ; @0x327c
	mov_s	%r1,4                           ; @0x327e
	mov_s	%r3,4                           ; @0x3280
	mov_s	%r5,4                           ; @0x3282
	bl	printf                          ; @0x3284
	mov_s	%r0,10                          ; @0x3288
	bl	putchar                         ; @0x328a
	add1	%r0,%r16,(.Lstr.12-.L.str.3)/2  ; @0x328e
	bl.d	puts                            ; @0x3292
	nop_s                                   ; inserted to benefit BPU
                                        ; @0x3296
	bl	clock                           ; @0x3298
	mov_s	%r15,%r0                        ; @0x329c
	add	%r0,%r56,0x2000@u32             ; @0x329e
	add	%r1,%r56,0x1000@u32             ; @0x32a6
	add	%r2,%r56,0                      ; @0x32ae
	mov	%r3,1024                        ; @0x32b2
	bl	autovectorized_vec_sum          ; @0x32b6
	bl	clock                           ; @0x32ba
	sub_s	%r0,%r0,%r15                    ; @0x32be
	fint2d	%r2,%r0                         ; @0x32c0
	fdmul	%r18,%r2,%r18                   ; @0x32c4
	bl	_timer_clocks_per_sec           ; @0x32c8
	fuint2d	%r2,%r0                         ; @0x32cc
	fddiv	%r18,%r18,%r2                   ; @0x32d0
	add3	%r0,%r16,(.L.str.9-.L.str.3)/8  ; @0x32d4
	mov_s	%r1,%r18                        ; @0x32d8
	mov_s	%r2,%r19                        ; @0x32da
	bl	printf                          ; @0x32dc
	fddiv	%r2,%r20,%r18                   ; @0x32e0
	mov_s	%r0,%r14                        ; @0x32e4
	mov_s	%r1,%r2                         ; @0x32e6
	mov_s	%r2,%r3                         ; @0x32e8
	bl	printf                          ; @0x32ea
	mov_s	%r0,%r13                        ; @0x32ee
	bl	puts                            ; @0x32f0
	ld	%r4,[%r56,4096]                 ; @0x32f4
	ld	%r6,[%r56,0]                    ; @0x32fc
	ld	%r2,[%r56,8192]                 ; @0x3300
	mov_s	%r0,%r16                        ; @0x3308
	mov_s	%r1,0                           ; @0x330a
	mov_s	%r3,0                           ; @0x330c
	mov_s	%r5,0                           ; @0x330e
	bl	printf                          ; @0x3310
	ld	%r4,[%r56,4100]                 ; @0x3314
	ld	%r6,[%r56,4]                    ; @0x331c
	ld	%r2,[%r56,8196]                 ; @0x3320
	mov_s	%r0,%r16                        ; @0x3328
	mov_s	%r1,1                           ; @0x332a
	mov_s	%r3,1                           ; @0x332c
	mov_s	%r5,1                           ; @0x332e
	bl	printf                          ; @0x3330
	ld	%r4,[%r56,4104]                 ; @0x3334
	ld	%r6,[%r56,8]                    ; @0x333c
	ld	%r2,[%r56,8200]                 ; @0x3340
	mov_s	%r0,%r16                        ; @0x3348
	mov_s	%r1,2                           ; @0x334a
	mov_s	%r3,2                           ; @0x334c
	mov_s	%r5,2                           ; @0x334e
	bl	printf                          ; @0x3350
	ld	%r4,[%r56,4108]                 ; @0x3354
	ld	%r6,[%r56,12]                   ; @0x335c
	ld	%r2,[%r56,8204]                 ; @0x3360
	mov_s	%r0,%r16                        ; @0x3368
	mov_s	%r1,3                           ; @0x336a
	mov_s	%r3,3                           ; @0x336c
	mov_s	%r5,3                           ; @0x336e
	bl	printf                          ; @0x3370
	ld	%r4,[%r56,4112]                 ; @0x3374
	ld	%r6,[%r56,16]                   ; @0x337c
	ld	%r2,[%r56,8208]                 ; @0x3380
	mov_s	%r0,%r16                        ; @0x3388
	mov_s	%r1,4                           ; @0x338a
	mov_s	%r3,4                           ; @0x338c
	mov_s	%r5,4                           ; @0x338e
	bl	printf                          ; @0x3390
	mov	%r0,0                           ; widened to benefit BPU
                                        ; @0x3394
	b	.LBB0_4                         ; widened to benefit BPU
                                        ; @0x3398
.LBB0_3:                                ; %if.then
                                        ; @0x339c
	add2	%r0,%r16,(.Lstr-.L.str.3)/4     ; @0x339c
	bl	puts                            ; @0x33a0
	mov_s	%r0,1                           ; @0x33a4
.LBB0_4:                                ; %cleanup
                                        ; @0x33a6
	add3	%r56,%r56,12288/8               ; @0x33a6
	ld	%blink,[%sp,32]                 ; @0x33aa
	.cfa_restore	{%blink}                ; @0x33ae
	ldd	%r20,[%sp,24]                   ; @0x33ae
	.cfa_restore	{%r21}                  ; @0x33b2
	.cfa_restore	{%r20}                  ; @0x33b2
	ldd	%r18,[%sp,16]                   ; @0x33b2
	.cfa_restore	{%r19}                  ; @0x33b6
	.cfa_restore	{%r18}                  ; @0x33b6
	ld	%r16,[%sp,12]                   ; @0x33b6
	.cfa_restore	{%r16}                  ; @0x33ba
	ldd	%r14,[%sp,4]                    ; @0x33ba
	.cfa_restore	{%r15}                  ; @0x33be
	.cfa_restore	{%r14}                  ; @0x33be
	ld_s	%r13,[%sp,0]                    ; @0x33be
	.cfa_restore	{%r13}                  ; @0x33c0
	add1	%sp,%sp,2276/2                  ; @0x33c0
	.cfa_pop	2276                            ; @0x33c4
	j_s	[%blink]                        ; @0x33c4
	.cfa_ef
.Lfunc_end0:                            ; @0x33c6

	.reloc	_init_ad,0	;startup code to enable %status AD bit ; -- End function
