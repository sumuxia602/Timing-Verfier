
cnt：     文件格式 elf64-littleaarch64


Disassembly of section .init:

0000000000400498 <_init>:
  400498:	d503201f 	nop
  40049c:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
  4004a0:	910003fd 	mov	x29, sp
  4004a4:	94000028 	bl	400544 <call_weak_fn>
  4004a8:	a8c17bfd 	ldp	x29, x30, [sp], #16
  4004ac:	d65f03c0 	ret

Disassembly of section .plt:

00000000004004b0 <.plt>:
  4004b0:	a9bf7bf0 	stp	x16, x30, [sp, #-16]!
  4004b4:	f00000f0 	adrp	x16, 41f000 <__FRAME_END__+0x1e550>
  4004b8:	f947fe11 	ldr	x17, [x16, #4088]
  4004bc:	913fe210 	add	x16, x16, #0xff8
  4004c0:	d61f0220 	br	x17
  4004c4:	d503201f 	nop
  4004c8:	d503201f 	nop
  4004cc:	d503201f 	nop

00000000004004d0 <__libc_start_main@plt>:
  4004d0:	90000110 	adrp	x16, 420000 <__libc_start_main@GLIBC_2.34>
  4004d4:	f9400211 	ldr	x17, [x16]
  4004d8:	91000210 	add	x16, x16, #0x0
  4004dc:	d61f0220 	br	x17

00000000004004e0 <__gmon_start__@plt>:
  4004e0:	90000110 	adrp	x16, 420000 <__libc_start_main@GLIBC_2.34>
  4004e4:	f9400611 	ldr	x17, [x16, #8]
  4004e8:	91002210 	add	x16, x16, #0x8
  4004ec:	d61f0220 	br	x17

00000000004004f0 <abort@plt>:
  4004f0:	90000110 	adrp	x16, 420000 <__libc_start_main@GLIBC_2.34>
  4004f4:	f9400a11 	ldr	x17, [x16, #16]
  4004f8:	91004210 	add	x16, x16, #0x10
  4004fc:	d61f0220 	br	x17

Disassembly of section .text:

0000000000400500 <_start>:
  400500:	d503201f 	nop
  400504:	d280001d 	mov	x29, #0x0                   	// #0
  400508:	d280001e 	mov	x30, #0x0                   	// #0
  40050c:	aa0003e5 	mov	x5, x0
  400510:	f94003e1 	ldr	x1, [sp]
  400514:	910023e2 	add	x2, sp, #0x8
  400518:	910003e6 	mov	x6, sp
  40051c:	90000000 	adrp	x0, 400000 <__abi_tag-0x278>
  400520:	9114d000 	add	x0, x0, #0x534
  400524:	d2800003 	mov	x3, #0x0                   	// #0
  400528:	d2800004 	mov	x4, #0x0                   	// #0
  40052c:	97ffffe9 	bl	4004d0 <__libc_start_main@plt>
  400530:	97fffff0 	bl	4004f0 <abort@plt>

0000000000400534 <__wrap_main>:
  400534:	d503201f 	nop
  400538:	14000033 	b	400604 <main>
  40053c:	d503201f 	nop

0000000000400540 <_dl_relocate_static_pie>:
  400540:	d65f03c0 	ret

0000000000400544 <call_weak_fn>:
  400544:	f00000e0 	adrp	x0, 41f000 <__FRAME_END__+0x1e550>
  400548:	f947ec00 	ldr	x0, [x0, #4056]
  40054c:	b4000040 	cbz	x0, 400554 <call_weak_fn+0x10>
  400550:	17ffffe4 	b	4004e0 <__gmon_start__@plt>
  400554:	d65f03c0 	ret
  400558:	d503201f 	nop
  40055c:	d503201f 	nop

0000000000400560 <deregister_tm_clones>:
  400560:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400564:	9100a000 	add	x0, x0, #0x28
  400568:	90000101 	adrp	x1, 420000 <__libc_start_main@GLIBC_2.34>
  40056c:	9100a021 	add	x1, x1, #0x28
  400570:	eb00003f 	cmp	x1, x0
  400574:	540000c0 	b.eq	40058c <deregister_tm_clones+0x2c>  // b.none
  400578:	f00000e1 	adrp	x1, 41f000 <__FRAME_END__+0x1e550>
  40057c:	f947e821 	ldr	x1, [x1, #4048]
  400580:	b4000061 	cbz	x1, 40058c <deregister_tm_clones+0x2c>
  400584:	aa0103f0 	mov	x16, x1
  400588:	d61f0200 	br	x16
  40058c:	d65f03c0 	ret

0000000000400590 <register_tm_clones>:
  400590:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400594:	9100a000 	add	x0, x0, #0x28
  400598:	90000101 	adrp	x1, 420000 <__libc_start_main@GLIBC_2.34>
  40059c:	9100a021 	add	x1, x1, #0x28
  4005a0:	cb000021 	sub	x1, x1, x0
  4005a4:	d37ffc22 	lsr	x2, x1, #63
  4005a8:	8b810c41 	add	x1, x2, x1, asr #3
  4005ac:	9341fc21 	asr	x1, x1, #1
  4005b0:	b40000c1 	cbz	x1, 4005c8 <register_tm_clones+0x38>
  4005b4:	f00000e2 	adrp	x2, 41f000 <__FRAME_END__+0x1e550>
  4005b8:	f947f042 	ldr	x2, [x2, #4064]
  4005bc:	b4000062 	cbz	x2, 4005c8 <register_tm_clones+0x38>
  4005c0:	aa0203f0 	mov	x16, x2
  4005c4:	d61f0200 	br	x16
  4005c8:	d65f03c0 	ret
  4005cc:	d503201f 	nop

00000000004005d0 <__do_global_dtors_aux>:
  4005d0:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
  4005d4:	910003fd 	mov	x29, sp
  4005d8:	f9000bf3 	str	x19, [sp, #16]
  4005dc:	90000113 	adrp	x19, 420000 <__libc_start_main@GLIBC_2.34>
  4005e0:	3940a260 	ldrb	w0, [x19, #40]
  4005e4:	35000080 	cbnz	w0, 4005f4 <__do_global_dtors_aux+0x24>
  4005e8:	97ffffde 	bl	400560 <deregister_tm_clones>
  4005ec:	52800020 	mov	w0, #0x1                   	// #1
  4005f0:	3900a260 	strb	w0, [x19, #40]
  4005f4:	f9400bf3 	ldr	x19, [sp, #16]
  4005f8:	a8c27bfd 	ldp	x29, x30, [sp], #32
  4005fc:	d65f03c0 	ret

0000000000400600 <frame_dummy>:
  400600:	17ffffe4 	b	400590 <register_tm_clones>

0000000000400604 <main>:
  400604:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
  400608:	910003fd 	mov	x29, sp
  40060c:	94000042 	bl	400714 <InitSeed>
  400610:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400614:	9100e000 	add	x0, x0, #0x38
  400618:	94000004 	bl	400628 <Test>
  40061c:	52800020 	mov	w0, #0x1                   	// #1
  400620:	a8c17bfd 	ldp	x29, x30, [sp], #16
  400624:	d65f03c0 	ret

0000000000400628 <Test>:
  400628:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
  40062c:	910003fd 	mov	x29, sp
  400630:	f9000fe0 	str	x0, [sp, #24]
  400634:	f9400fe0 	ldr	x0, [sp, #24]
  400638:	94000015 	bl	40068c <Initialize>
  40063c:	d2807d00 	mov	x0, #0x3e8                 	// #1000
  400640:	f9001fe0 	str	x0, [sp, #56]
  400644:	f9400fe0 	ldr	x0, [sp, #24]
  400648:	94000038 	bl	400728 <Sum>
  40064c:	d280bb80 	mov	x0, #0x5dc                 	// #1500
  400650:	f9001be0 	str	x0, [sp, #48]
  400654:	f9401be1 	ldr	x1, [sp, #48]
  400658:	f9401fe0 	ldr	x0, [sp, #56]
  40065c:	cb000020 	sub	x0, x1, x0
  400660:	9e670000 	fmov	d0, x0
  400664:	5e61d800 	scvtf	d0, d0
  400668:	d2c80000 	mov	x0, #0x400000000000        	// #70368744177664
  40066c:	f2e811e0 	movk	x0, #0x408f, lsl #48
  400670:	9e670001 	fmov	d1, x0
  400674:	1e611800 	fdiv	d0, d0, d1
  400678:	1e624000 	fcvt	s0, d0
  40067c:	bd002fe0 	str	s0, [sp, #44]
  400680:	52800000 	mov	w0, #0x0                   	// #0
  400684:	a8c47bfd 	ldp	x29, x30, [sp], #64
  400688:	d65f03c0 	ret

000000000040068c <Initialize>:
  40068c:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
  400690:	910003fd 	mov	x29, sp
  400694:	a90153f3 	stp	x19, x20, [sp, #16]
  400698:	f90013f5 	str	x21, [sp, #32]
  40069c:	f9001fe0 	str	x0, [sp, #56]
  4006a0:	52800013 	mov	w19, #0x0                   	// #0
  4006a4:	14000015 	b	4006f8 <Initialize+0x6c>
  4006a8:	52800014 	mov	w20, #0x0                   	// #0
  4006ac:	14000010 	b	4006ec <Initialize+0x60>
  4006b0:	93407e61 	sxtw	x1, w19
  4006b4:	aa0103e0 	mov	x0, x1
  4006b8:	d37be800 	lsl	x0, x0, #5
  4006bc:	cb010000 	sub	x0, x0, x1
  4006c0:	d37ef400 	lsl	x0, x0, #2
  4006c4:	8b010000 	add	x0, x0, x1
  4006c8:	d37be800 	lsl	x0, x0, #5
  4006cc:	aa0003e1 	mov	x1, x0
  4006d0:	f9401fe0 	ldr	x0, [sp, #56]
  4006d4:	8b010015 	add	x21, x0, x1
  4006d8:	9400006a 	bl	400880 <RandomInteger>
  4006dc:	2a0003e1 	mov	w1, w0
  4006e0:	93407e80 	sxtw	x0, w20
  4006e4:	b8207aa1 	str	w1, [x21, x0, lsl #2]
  4006e8:	11000694 	add	w20, w20, #0x1
  4006ec:	710f9e9f 	cmp	w20, #0x3e7
  4006f0:	54fffe0d 	b.le	4006b0 <Initialize+0x24>
  4006f4:	11000673 	add	w19, w19, #0x1
  4006f8:	710f9e7f 	cmp	w19, #0x3e7
  4006fc:	54fffd6d 	b.le	4006a8 <Initialize+0x1c>
  400700:	52800000 	mov	w0, #0x0                   	// #0
  400704:	a94153f3 	ldp	x19, x20, [sp, #16]
  400708:	f94013f5 	ldr	x21, [sp, #32]
  40070c:	a8c47bfd 	ldp	x29, x30, [sp], #64
  400710:	d65f03c0 	ret

0000000000400714 <InitSeed>:
  400714:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400718:	9100c000 	add	x0, x0, #0x30
  40071c:	b900001f 	str	wzr, [x0]
  400720:	52800000 	mov	w0, #0x0                   	// #0
  400724:	d65f03c0 	ret

0000000000400728 <Sum>:
  400728:	a9bd53f3 	stp	x19, x20, [sp, #-48]!
  40072c:	f9000fe0 	str	x0, [sp, #24]
  400730:	b9002fff 	str	wzr, [sp, #44]
  400734:	b9002bff 	str	wzr, [sp, #40]
  400738:	b90027ff 	str	wzr, [sp, #36]
  40073c:	b90023ff 	str	wzr, [sp, #32]
  400740:	52800013 	mov	w19, #0x0                   	// #0
  400744:	1400003a 	b	40082c <Sum+0x104>
  400748:	52800014 	mov	w20, #0x0                   	// #0
  40074c:	14000035 	b	400820 <Sum+0xf8>
  400750:	93407e61 	sxtw	x1, w19
  400754:	aa0103e0 	mov	x0, x1
  400758:	d37be800 	lsl	x0, x0, #5
  40075c:	cb010000 	sub	x0, x0, x1
  400760:	d37ef400 	lsl	x0, x0, #2
  400764:	8b010000 	add	x0, x0, x1
  400768:	d37be800 	lsl	x0, x0, #5
  40076c:	aa0003e1 	mov	x1, x0
  400770:	f9400fe0 	ldr	x0, [sp, #24]
  400774:	8b010000 	add	x0, x0, x1
  400778:	93407e81 	sxtw	x1, w20
  40077c:	b8617800 	ldr	w0, [x0, x1, lsl #2]
  400780:	7100001f 	cmp	w0, #0x0
  400784:	5400028a 	b.ge	4007d4 <Sum+0xac>  // b.tcont
  400788:	93407e61 	sxtw	x1, w19
  40078c:	aa0103e0 	mov	x0, x1
  400790:	d37be800 	lsl	x0, x0, #5
  400794:	cb010000 	sub	x0, x0, x1
  400798:	d37ef400 	lsl	x0, x0, #2
  40079c:	8b010000 	add	x0, x0, x1
  4007a0:	d37be800 	lsl	x0, x0, #5
  4007a4:	aa0003e1 	mov	x1, x0
  4007a8:	f9400fe0 	ldr	x0, [sp, #24]
  4007ac:	8b010000 	add	x0, x0, x1
  4007b0:	93407e81 	sxtw	x1, w20
  4007b4:	b8617800 	ldr	w0, [x0, x1, lsl #2]
  4007b8:	b9402fe1 	ldr	w1, [sp, #44]
  4007bc:	0b000020 	add	w0, w1, w0
  4007c0:	b9002fe0 	str	w0, [sp, #44]
  4007c4:	b94027e0 	ldr	w0, [sp, #36]
  4007c8:	11000400 	add	w0, w0, #0x1
  4007cc:	b90027e0 	str	w0, [sp, #36]
  4007d0:	14000013 	b	40081c <Sum+0xf4>
  4007d4:	93407e61 	sxtw	x1, w19
  4007d8:	aa0103e0 	mov	x0, x1
  4007dc:	d37be800 	lsl	x0, x0, #5
  4007e0:	cb010000 	sub	x0, x0, x1
  4007e4:	d37ef400 	lsl	x0, x0, #2
  4007e8:	8b010000 	add	x0, x0, x1
  4007ec:	d37be800 	lsl	x0, x0, #5
  4007f0:	aa0003e1 	mov	x1, x0
  4007f4:	f9400fe0 	ldr	x0, [sp, #24]
  4007f8:	8b010000 	add	x0, x0, x1
  4007fc:	93407e81 	sxtw	x1, w20
  400800:	b8617800 	ldr	w0, [x0, x1, lsl #2]
  400804:	b9402be1 	ldr	w1, [sp, #40]
  400808:	0b000020 	add	w0, w1, w0
  40080c:	b9002be0 	str	w0, [sp, #40]
  400810:	b94023e0 	ldr	w0, [sp, #32]
  400814:	11000400 	add	w0, w0, #0x1
  400818:	b90023e0 	str	w0, [sp, #32]
  40081c:	11000694 	add	w20, w20, #0x1
  400820:	710f9e9f 	cmp	w20, #0x3e7
  400824:	54fff96d 	b.le	400750 <Sum+0x28>
  400828:	11000673 	add	w19, w19, #0x1
  40082c:	710f9e7f 	cmp	w19, #0x3e7
  400830:	54fff8cd 	b.le	400748 <Sum+0x20>
  400834:	90001f80 	adrp	x0, 7f0000 <Array+0x3cffc8>
  400838:	9124e000 	add	x0, x0, #0x938
  40083c:	b9402fe1 	ldr	w1, [sp, #44]
  400840:	b9000001 	str	w1, [x0]
  400844:	90001f80 	adrp	x0, 7f0000 <Array+0x3cffc8>
  400848:	91250000 	add	x0, x0, #0x940
  40084c:	b94027e1 	ldr	w1, [sp, #36]
  400850:	b9000001 	str	w1, [x0]
  400854:	90001f80 	adrp	x0, 7f0000 <Array+0x3cffc8>
  400858:	9124f000 	add	x0, x0, #0x93c
  40085c:	b9402be1 	ldr	w1, [sp, #40]
  400860:	b9000001 	str	w1, [x0]
  400864:	90001f80 	adrp	x0, 7f0000 <Array+0x3cffc8>
  400868:	91251000 	add	x0, x0, #0x944
  40086c:	b94023e1 	ldr	w1, [sp, #32]
  400870:	b9000001 	str	w1, [x0]
  400874:	d503201f 	nop
  400878:	a8c353f3 	ldp	x19, x20, [sp], #48
  40087c:	d65f03c0 	ret

0000000000400880 <RandomInteger>:
  400880:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400884:	9100c000 	add	x0, x0, #0x30
  400888:	b9400001 	ldr	w1, [x0]
  40088c:	528010a0 	mov	w0, #0x85                  	// #133
  400890:	1b007c20 	mul	w0, w1, w0
  400894:	11014401 	add	w1, w0, #0x51
  400898:	528298e0 	mov	w0, #0x14c7                	// #5319
  40089c:	72a20620 	movk	w0, #0x1031, lsl #16
  4008a0:	9b207c20 	smull	x0, w1, w0
  4008a4:	d360fc00 	lsr	x0, x0, #32
  4008a8:	13097c02 	asr	w2, w0, #9
  4008ac:	131f7c20 	asr	w0, w1, #31
  4008b0:	4b000040 	sub	w0, w2, w0
  4008b4:	5283f3e2 	mov	w2, #0x1f9f                	// #8095
  4008b8:	1b027c00 	mul	w0, w0, w2
  4008bc:	4b000020 	sub	w0, w1, w0
  4008c0:	90000101 	adrp	x1, 420000 <__libc_start_main@GLIBC_2.34>
  4008c4:	9100c021 	add	x1, x1, #0x30
  4008c8:	b9000020 	str	w0, [x1]
  4008cc:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4008d0:	9100c000 	add	x0, x0, #0x30
  4008d4:	b9400000 	ldr	w0, [x0]
  4008d8:	d65f03c0 	ret

Disassembly of section .fini:

00000000004008dc <_fini>:
  4008dc:	d503201f 	nop
  4008e0:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
  4008e4:	910003fd 	mov	x29, sp
  4008e8:	a8c17bfd 	ldp	x29, x30, [sp], #16
  4008ec:	d65f03c0 	ret
