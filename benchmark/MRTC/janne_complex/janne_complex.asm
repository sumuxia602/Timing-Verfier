
janne_complex：     文件格式 elf64-littleaarch64


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
  4004b4:	f00000f0 	adrp	x16, 41f000 <__FRAME_END__+0x1e7d0>
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
  400538:	14000060 	b	4006b8 <main>
  40053c:	d503201f 	nop

0000000000400540 <_dl_relocate_static_pie>:
  400540:	d65f03c0 	ret

0000000000400544 <call_weak_fn>:
  400544:	f00000e0 	adrp	x0, 41f000 <__FRAME_END__+0x1e7d0>
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
  400578:	f00000e1 	adrp	x1, 41f000 <__FRAME_END__+0x1e7d0>
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
  4005b4:	f00000e2 	adrp	x2, 41f000 <__FRAME_END__+0x1e7d0>
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

0000000000400604 <complex>:
  400604:	d10043ff 	sub	sp, sp, #0x10
  400608:	b9000fe0 	str	w0, [sp, #12]
  40060c:	b9000be1 	str	w1, [sp, #8]
  400610:	14000024 	b	4006a0 <complex+0x9c>
  400614:	b9400be0 	ldr	w0, [sp, #8]
  400618:	7100141f 	cmp	w0, #0x5
  40061c:	540000ed 	b.le	400638 <complex+0x34>
  400620:	b9400be1 	ldr	w1, [sp, #8]
  400624:	2a0103e0 	mov	w0, w1
  400628:	531f7800 	lsl	w0, w0, #1
  40062c:	0b010000 	add	w0, w0, w1
  400630:	b9000be0 	str	w0, [sp, #8]
  400634:	14000004 	b	400644 <complex+0x40>
  400638:	b9400be0 	ldr	w0, [sp, #8]
  40063c:	11000800 	add	w0, w0, #0x2
  400640:	b9000be0 	str	w0, [sp, #8]
  400644:	b9400be0 	ldr	w0, [sp, #8]
  400648:	7100241f 	cmp	w0, #0x9
  40064c:	5400010d 	b.le	40066c <complex+0x68>
  400650:	b9400be0 	ldr	w0, [sp, #8]
  400654:	7100301f 	cmp	w0, #0xc
  400658:	540000ac 	b.gt	40066c <complex+0x68>
  40065c:	b9400fe0 	ldr	w0, [sp, #12]
  400660:	11002800 	add	w0, w0, #0xa
  400664:	b9000fe0 	str	w0, [sp, #12]
  400668:	14000004 	b	400678 <complex+0x74>
  40066c:	b9400fe0 	ldr	w0, [sp, #12]
  400670:	11000400 	add	w0, w0, #0x1
  400674:	b9000fe0 	str	w0, [sp, #12]
  400678:	b9400be1 	ldr	w1, [sp, #8]
  40067c:	b9400fe0 	ldr	w0, [sp, #12]
  400680:	6b00003f 	cmp	w1, w0
  400684:	54fffc8b 	b.lt	400614 <complex+0x10>  // b.tstop
  400688:	b9400fe0 	ldr	w0, [sp, #12]
  40068c:	11000800 	add	w0, w0, #0x2
  400690:	b9000fe0 	str	w0, [sp, #12]
  400694:	b9400be0 	ldr	w0, [sp, #8]
  400698:	51002800 	sub	w0, w0, #0xa
  40069c:	b9000be0 	str	w0, [sp, #8]
  4006a0:	b9400fe0 	ldr	w0, [sp, #12]
  4006a4:	7100741f 	cmp	w0, #0x1d
  4006a8:	54fffe8d 	b.le	400678 <complex+0x74>
  4006ac:	52800020 	mov	w0, #0x1                   	// #1
  4006b0:	910043ff 	add	sp, sp, #0x10
  4006b4:	d65f03c0 	ret

00000000004006b8 <main>:
  4006b8:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
  4006bc:	910003fd 	mov	x29, sp
  4006c0:	52800020 	mov	w0, #0x1                   	// #1
  4006c4:	b9001fe0 	str	w0, [sp, #28]
  4006c8:	52800020 	mov	w0, #0x1                   	// #1
  4006cc:	b9001be0 	str	w0, [sp, #24]
  4006d0:	b90017ff 	str	wzr, [sp, #20]
  4006d4:	b9401be1 	ldr	w1, [sp, #24]
  4006d8:	b9401fe0 	ldr	w0, [sp, #28]
  4006dc:	97ffffca 	bl	400604 <complex>
  4006e0:	b90017e0 	str	w0, [sp, #20]
  4006e4:	b94017e0 	ldr	w0, [sp, #20]
  4006e8:	a8c27bfd 	ldp	x29, x30, [sp], #32
  4006ec:	d65f03c0 	ret

Disassembly of section .fini:

00000000004006f0 <_fini>:
  4006f0:	d503201f 	nop
  4006f4:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
  4006f8:	910003fd 	mov	x29, sp
  4006fc:	a8c17bfd 	ldp	x29, x30, [sp], #16
  400700:	d65f03c0 	ret
