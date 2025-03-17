
bsort100：     文件格式 elf64-littleaarch64


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
  4004b4:	f00000f0 	adrp	x16, 41f000 <__FRAME_END__+0x1e658>
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
  400544:	f00000e0 	adrp	x0, 41f000 <__FRAME_END__+0x1e658>
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
  400578:	f00000e1 	adrp	x1, 41f000 <__FRAME_END__+0x1e658>
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
  4005b4:	f00000e2 	adrp	x2, 41f000 <__FRAME_END__+0x1e658>
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
  40060c:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400610:	9100c000 	add	x0, x0, #0x30
  400614:	94000016 	bl	40066c <Initialize>
  400618:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  40061c:	9100c000 	add	x0, x0, #0x30
  400620:	94000036 	bl	4006f8 <BubbleSort>
  400624:	52800000 	mov	w0, #0x0                   	// #0
  400628:	a8c17bfd 	ldp	x29, x30, [sp], #16
  40062c:	d65f03c0 	ret

0000000000400630 <ttime>:
  400630:	d100c3ff 	sub	sp, sp, #0x30
  400634:	fd4007e0 	ldr	d0, [sp, #8]
  400638:	5e61d800 	scvtf	d0, d0
  40063c:	d2e809c0 	mov	x0, #0x404e000000000000    	// #4633641066610819072
  400640:	9e670001 	fmov	d1, x0
  400644:	1e611800 	fdiv	d0, d0, d1
  400648:	d2c80000 	mov	x0, #0x400000000000        	// #70368744177664
  40064c:	f2e811e0 	movk	x0, #0x408f, lsl #48
  400650:	9e670001 	fmov	d1, x0
  400654:	1e610800 	fmul	d0, d0, d1
  400658:	1e780000 	fcvtzs	w0, d0
  40065c:	b9002fe0 	str	w0, [sp, #44]
  400660:	b9402fe0 	ldr	w0, [sp, #44]
  400664:	9100c3ff 	add	sp, sp, #0x30
  400668:	d65f03c0 	ret

000000000040066c <Initialize>:
  40066c:	d10083ff 	sub	sp, sp, #0x20
  400670:	f90007e0 	str	x0, [sp, #8]
  400674:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400678:	91072000 	add	x0, x0, #0x1c8
  40067c:	12800001 	mov	w1, #0xffffffff            	// #-1
  400680:	b9000001 	str	w1, [x0]
  400684:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400688:	91072000 	add	x0, x0, #0x1c8
  40068c:	b9400000 	ldr	w0, [x0]
  400690:	b9001be0 	str	w0, [sp, #24]
  400694:	52800020 	mov	w0, #0x1                   	// #1
  400698:	b9001fe0 	str	w0, [sp, #28]
  40069c:	14000011 	b	4006e0 <Initialize+0x74>
  4006a0:	b9401fe1 	ldr	w1, [sp, #28]
  4006a4:	b9401be0 	ldr	w0, [sp, #24]
  4006a8:	1b007c21 	mul	w1, w1, w0
  4006ac:	d2800020 	mov	x0, #0x1                   	// #1
  4006b0:	f2b00400 	movk	x0, #0x8020, lsl #16
  4006b4:	39400000 	ldrb	w0, [x0]
  4006b8:	2a0003e3 	mov	w3, w0
  4006bc:	b9801fe0 	ldrsw	x0, [sp, #28]
  4006c0:	d37ef400 	lsl	x0, x0, #2
  4006c4:	f94007e2 	ldr	x2, [sp, #8]
  4006c8:	8b000040 	add	x0, x2, x0
  4006cc:	1b037c21 	mul	w1, w1, w3
  4006d0:	b9000001 	str	w1, [x0]
  4006d4:	b9401fe0 	ldr	w0, [sp, #28]
  4006d8:	11000400 	add	w0, w0, #0x1
  4006dc:	b9001fe0 	str	w0, [sp, #28]
  4006e0:	b9401fe0 	ldr	w0, [sp, #28]
  4006e4:	7101901f 	cmp	w0, #0x64
  4006e8:	54fffdcd 	b.le	4006a0 <Initialize+0x34>
  4006ec:	d503201f 	nop
  4006f0:	910083ff 	add	sp, sp, #0x20
  4006f4:	d65f03c0 	ret

00000000004006f8 <BubbleSort>:
  4006f8:	d10083ff 	sub	sp, sp, #0x20
  4006fc:	f90007e0 	str	x0, [sp, #8]
  400700:	b9001fff 	str	wzr, [sp, #28]
  400704:	52800020 	mov	w0, #0x1                   	// #1
  400708:	b90017e0 	str	w0, [sp, #20]
  40070c:	14000040 	b	40080c <BubbleSort+0x114>
  400710:	52800020 	mov	w0, #0x1                   	// #1
  400714:	b9001fe0 	str	w0, [sp, #28]
  400718:	52800020 	mov	w0, #0x1                   	// #1
  40071c:	b9001be0 	str	w0, [sp, #24]
  400720:	14000030 	b	4007e0 <BubbleSort+0xe8>
  400724:	52800c81 	mov	w1, #0x64                  	// #100
  400728:	b94017e0 	ldr	w0, [sp, #20]
  40072c:	4b000020 	sub	w0, w1, w0
  400730:	b9401be1 	ldr	w1, [sp, #24]
  400734:	6b00003f 	cmp	w1, w0
  400738:	540005cc 	b.gt	4007f0 <BubbleSort+0xf8>
  40073c:	b9801be0 	ldrsw	x0, [sp, #24]
  400740:	d37ef400 	lsl	x0, x0, #2
  400744:	f94007e1 	ldr	x1, [sp, #8]
  400748:	8b000020 	add	x0, x1, x0
  40074c:	b9400001 	ldr	w1, [x0]
  400750:	b9801be0 	ldrsw	x0, [sp, #24]
  400754:	91000400 	add	x0, x0, #0x1
  400758:	d37ef400 	lsl	x0, x0, #2
  40075c:	f94007e2 	ldr	x2, [sp, #8]
  400760:	8b000040 	add	x0, x2, x0
  400764:	b9400000 	ldr	w0, [x0]
  400768:	6b00003f 	cmp	w1, w0
  40076c:	5400034d 	b.le	4007d4 <BubbleSort+0xdc>
  400770:	b9801be0 	ldrsw	x0, [sp, #24]
  400774:	d37ef400 	lsl	x0, x0, #2
  400778:	f94007e1 	ldr	x1, [sp, #8]
  40077c:	8b000020 	add	x0, x1, x0
  400780:	b9400000 	ldr	w0, [x0]
  400784:	b90013e0 	str	w0, [sp, #16]
  400788:	b9801be0 	ldrsw	x0, [sp, #24]
  40078c:	91000400 	add	x0, x0, #0x1
  400790:	d37ef400 	lsl	x0, x0, #2
  400794:	f94007e1 	ldr	x1, [sp, #8]
  400798:	8b000021 	add	x1, x1, x0
  40079c:	b9801be0 	ldrsw	x0, [sp, #24]
  4007a0:	d37ef400 	lsl	x0, x0, #2
  4007a4:	f94007e2 	ldr	x2, [sp, #8]
  4007a8:	8b000040 	add	x0, x2, x0
  4007ac:	b9400021 	ldr	w1, [x1]
  4007b0:	b9000001 	str	w1, [x0]
  4007b4:	b9801be0 	ldrsw	x0, [sp, #24]
  4007b8:	91000400 	add	x0, x0, #0x1
  4007bc:	d37ef400 	lsl	x0, x0, #2
  4007c0:	f94007e1 	ldr	x1, [sp, #8]
  4007c4:	8b000020 	add	x0, x1, x0
  4007c8:	b94013e1 	ldr	w1, [sp, #16]
  4007cc:	b9000001 	str	w1, [x0]
  4007d0:	b9001fff 	str	wzr, [sp, #28]
  4007d4:	b9401be0 	ldr	w0, [sp, #24]
  4007d8:	11000400 	add	w0, w0, #0x1
  4007dc:	b9001be0 	str	w0, [sp, #24]
  4007e0:	b9401be0 	ldr	w0, [sp, #24]
  4007e4:	71018c1f 	cmp	w0, #0x63
  4007e8:	54fff9ed 	b.le	400724 <BubbleSort+0x2c>
  4007ec:	14000002 	b	4007f4 <BubbleSort+0xfc>
  4007f0:	d503201f 	nop
  4007f4:	b9401fe0 	ldr	w0, [sp, #28]
  4007f8:	7100001f 	cmp	w0, #0x0
  4007fc:	54000101 	b.ne	40081c <BubbleSort+0x124>  // b.any
  400800:	b94017e0 	ldr	w0, [sp, #20]
  400804:	11000400 	add	w0, w0, #0x1
  400808:	b90017e0 	str	w0, [sp, #20]
  40080c:	b94017e0 	ldr	w0, [sp, #20]
  400810:	71018c1f 	cmp	w0, #0x63
  400814:	54fff7ed 	b.le	400710 <BubbleSort+0x18>
  400818:	14000002 	b	400820 <BubbleSort+0x128>
  40081c:	d503201f 	nop
  400820:	d503201f 	nop
  400824:	910083ff 	add	sp, sp, #0x20
  400828:	d65f03c0 	ret

Disassembly of section .fini:

000000000040082c <_fini>:
  40082c:	d503201f 	nop
  400830:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
  400834:	910003fd 	mov	x29, sp
  400838:	a8c17bfd 	ldp	x29, x30, [sp], #16
  40083c:	d65f03c0 	ret
