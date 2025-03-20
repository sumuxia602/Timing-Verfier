
ud：     文件格式 elf64-littleaarch64


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
  4004b4:	f00000f0 	adrp	x16, 41f000 <__FRAME_END__+0x1e254>
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
  400544:	f00000e0 	adrp	x0, 41f000 <__FRAME_END__+0x1e254>
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
  400578:	f00000e1 	adrp	x1, 41f000 <__FRAME_END__+0x1e254>
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
  4005b4:	f00000e2 	adrp	x2, 41f000 <__FRAME_END__+0x1e254>
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
  400604:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
  400608:	910003fd 	mov	x29, sp
  40060c:	52803e80 	mov	w0, #0x1f4                 	// #500
  400610:	b9001fe0 	str	w0, [sp, #28]
  400614:	52800c80 	mov	w0, #0x64                  	// #100
  400618:	b9001be0 	str	w0, [sp, #24]
  40061c:	b9002fff 	str	wzr, [sp, #44]
  400620:	14000053 	b	40076c <main+0x168>
  400624:	f90013ff 	str	xzr, [sp, #32]
  400628:	b9002bff 	str	wzr, [sp, #40]
  40062c:	14000044 	b	40073c <main+0x138>
  400630:	b9402fe0 	ldr	w0, [sp, #44]
  400634:	11000401 	add	w1, w0, #0x1
  400638:	b9402be0 	ldr	w0, [sp, #40]
  40063c:	11000400 	add	w0, w0, #0x1
  400640:	0b000020 	add	w0, w1, w0
  400644:	93407c03 	sxtw	x3, w0
  400648:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  40064c:	9100c002 	add	x2, x0, #0x30
  400650:	b9802be4 	ldrsw	x4, [sp, #40]
  400654:	b9802fe1 	ldrsw	x1, [sp, #44]
  400658:	aa0103e0 	mov	x0, x1
  40065c:	d37be800 	lsl	x0, x0, #5
  400660:	cb010000 	sub	x0, x0, x1
  400664:	d37ef400 	lsl	x0, x0, #2
  400668:	8b010000 	add	x0, x0, x1
  40066c:	d37ef400 	lsl	x0, x0, #2
  400670:	8b040000 	add	x0, x0, x4
  400674:	f8207843 	str	x3, [x2, x0, lsl #3]
  400678:	b9402fe1 	ldr	w1, [sp, #44]
  40067c:	b9402be0 	ldr	w0, [sp, #40]
  400680:	6b00003f 	cmp	w1, w0
  400684:	54000381 	b.ne	4006f4 <main+0xf0>  // b.any
  400688:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  40068c:	9100c002 	add	x2, x0, #0x30
  400690:	b9802be3 	ldrsw	x3, [sp, #40]
  400694:	b9802fe1 	ldrsw	x1, [sp, #44]
  400698:	aa0103e0 	mov	x0, x1
  40069c:	d37be800 	lsl	x0, x0, #5
  4006a0:	cb010000 	sub	x0, x0, x1
  4006a4:	d37ef400 	lsl	x0, x0, #2
  4006a8:	8b010000 	add	x0, x0, x1
  4006ac:	d37ef400 	lsl	x0, x0, #2
  4006b0:	8b030000 	add	x0, x0, x3
  4006b4:	fc607840 	ldr	d0, [x2, x0, lsl #3]
  4006b8:	5e61d800 	scvtf	d0, d0
  4006bc:	1e602800 	fadd	d0, d0, d0
  4006c0:	5ee1b800 	fcvtzs	d0, d0
  4006c4:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4006c8:	9100c002 	add	x2, x0, #0x30
  4006cc:	b9802be3 	ldrsw	x3, [sp, #40]
  4006d0:	b9802fe1 	ldrsw	x1, [sp, #44]
  4006d4:	aa0103e0 	mov	x0, x1
  4006d8:	d37be800 	lsl	x0, x0, #5
  4006dc:	cb010000 	sub	x0, x0, x1
  4006e0:	d37ef400 	lsl	x0, x0, #2
  4006e4:	8b010000 	add	x0, x0, x1
  4006e8:	d37ef400 	lsl	x0, x0, #2
  4006ec:	8b030000 	add	x0, x0, x3
  4006f0:	fc207840 	str	d0, [x2, x0, lsl #3]
  4006f4:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4006f8:	9100c002 	add	x2, x0, #0x30
  4006fc:	b9802be3 	ldrsw	x3, [sp, #40]
  400700:	b9802fe1 	ldrsw	x1, [sp, #44]
  400704:	aa0103e0 	mov	x0, x1
  400708:	d37be800 	lsl	x0, x0, #5
  40070c:	cb010000 	sub	x0, x0, x1
  400710:	d37ef400 	lsl	x0, x0, #2
  400714:	8b010000 	add	x0, x0, x1
  400718:	d37ef400 	lsl	x0, x0, #2
  40071c:	8b030000 	add	x0, x0, x3
  400720:	f8607840 	ldr	x0, [x2, x0, lsl #3]
  400724:	f94013e1 	ldr	x1, [sp, #32]
  400728:	8b000020 	add	x0, x1, x0
  40072c:	f90013e0 	str	x0, [sp, #32]
  400730:	b9402be0 	ldr	w0, [sp, #40]
  400734:	11000400 	add	w0, w0, #0x1
  400738:	b9002be0 	str	w0, [sp, #40]
  40073c:	b9402be1 	ldr	w1, [sp, #40]
  400740:	b9401be0 	ldr	w0, [sp, #24]
  400744:	6b00003f 	cmp	w1, w0
  400748:	54fff74d 	b.le	400630 <main+0x2c>
  40074c:	90001040 	adrp	x0, 608000 <a+0x1e7fd0>
  400750:	9112c000 	add	x0, x0, #0x4b0
  400754:	b9802fe1 	ldrsw	x1, [sp, #44]
  400758:	f94013e2 	ldr	x2, [sp, #32]
  40075c:	f8217802 	str	x2, [x0, x1, lsl #3]
  400760:	b9402fe0 	ldr	w0, [sp, #44]
  400764:	11000400 	add	w0, w0, #0x1
  400768:	b9002fe0 	str	w0, [sp, #44]
  40076c:	b9402fe1 	ldr	w1, [sp, #44]
  400770:	b9401be0 	ldr	w0, [sp, #24]
  400774:	6b00003f 	cmp	w1, w0
  400778:	54fff56d 	b.le	400624 <main+0x20>
  40077c:	b9401be1 	ldr	w1, [sp, #24]
  400780:	b9401fe0 	ldr	w0, [sp, #28]
  400784:	94000005 	bl	400798 <ludcmp>
  400788:	b90017e0 	str	w0, [sp, #20]
  40078c:	d503201f 	nop
  400790:	a8c37bfd 	ldp	x29, x30, [sp], #48
  400794:	d65f03c0 	ret

0000000000400798 <ludcmp>:
  400798:	d13f43ff 	sub	sp, sp, #0xfd0
  40079c:	b9000fe0 	str	w0, [sp, #12]
  4007a0:	b9000be1 	str	w1, [sp, #8]
  4007a4:	b90fcfff 	str	wzr, [sp, #4044]
  4007a8:	140000a9 	b	400a4c <ludcmp+0x2b4>
  4007ac:	b94fcfe0 	ldr	w0, [sp, #4044]
  4007b0:	11000400 	add	w0, w0, #0x1
  4007b4:	b90fcbe0 	str	w0, [sp, #4040]
  4007b8:	1400004e 	b	4008f0 <ludcmp+0x158>
  4007bc:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4007c0:	9100c002 	add	x2, x0, #0x30
  4007c4:	b98fcfe3 	ldrsw	x3, [sp, #4044]
  4007c8:	b98fcbe1 	ldrsw	x1, [sp, #4040]
  4007cc:	aa0103e0 	mov	x0, x1
  4007d0:	d37be800 	lsl	x0, x0, #5
  4007d4:	cb010000 	sub	x0, x0, x1
  4007d8:	d37ef400 	lsl	x0, x0, #2
  4007dc:	8b010000 	add	x0, x0, x1
  4007e0:	d37ef400 	lsl	x0, x0, #2
  4007e4:	8b030000 	add	x0, x0, x3
  4007e8:	f8607840 	ldr	x0, [x2, x0, lsl #3]
  4007ec:	f907dfe0 	str	x0, [sp, #4024]
  4007f0:	b94fcfe0 	ldr	w0, [sp, #4044]
  4007f4:	7100001f 	cmp	w0, #0x0
  4007f8:	540004c0 	b.eq	400890 <ludcmp+0xf8>  // b.none
  4007fc:	b90fc7ff 	str	wzr, [sp, #4036]
  400800:	14000020 	b	400880 <ludcmp+0xe8>
  400804:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400808:	9100c002 	add	x2, x0, #0x30
  40080c:	b98fc7e3 	ldrsw	x3, [sp, #4036]
  400810:	b98fcbe1 	ldrsw	x1, [sp, #4040]
  400814:	aa0103e0 	mov	x0, x1
  400818:	d37be800 	lsl	x0, x0, #5
  40081c:	cb010000 	sub	x0, x0, x1
  400820:	d37ef400 	lsl	x0, x0, #2
  400824:	8b010000 	add	x0, x0, x1
  400828:	d37ef400 	lsl	x0, x0, #2
  40082c:	8b030000 	add	x0, x0, x3
  400830:	f8607842 	ldr	x2, [x2, x0, lsl #3]
  400834:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400838:	9100c003 	add	x3, x0, #0x30
  40083c:	b98fcfe4 	ldrsw	x4, [sp, #4044]
  400840:	b98fc7e1 	ldrsw	x1, [sp, #4036]
  400844:	aa0103e0 	mov	x0, x1
  400848:	d37be800 	lsl	x0, x0, #5
  40084c:	cb010000 	sub	x0, x0, x1
  400850:	d37ef400 	lsl	x0, x0, #2
  400854:	8b010000 	add	x0, x0, x1
  400858:	d37ef400 	lsl	x0, x0, #2
  40085c:	8b040000 	add	x0, x0, x4
  400860:	f8607860 	ldr	x0, [x3, x0, lsl #3]
  400864:	9b007c40 	mul	x0, x2, x0
  400868:	f947dfe1 	ldr	x1, [sp, #4024]
  40086c:	cb000020 	sub	x0, x1, x0
  400870:	f907dfe0 	str	x0, [sp, #4024]
  400874:	b94fc7e0 	ldr	w0, [sp, #4036]
  400878:	11000400 	add	w0, w0, #0x1
  40087c:	b90fc7e0 	str	w0, [sp, #4036]
  400880:	b94fc7e1 	ldr	w1, [sp, #4036]
  400884:	b94fcfe0 	ldr	w0, [sp, #4044]
  400888:	6b00003f 	cmp	w1, w0
  40088c:	54fffbcb 	b.lt	400804 <ludcmp+0x6c>  // b.tstop
  400890:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400894:	9100c001 	add	x1, x0, #0x30
  400898:	b98fcfe2 	ldrsw	x2, [sp, #4044]
  40089c:	d281f500 	mov	x0, #0xfa8                 	// #4008
  4008a0:	9b007c40 	mul	x0, x2, x0
  4008a4:	8b000020 	add	x0, x1, x0
  4008a8:	f9400000 	ldr	x0, [x0]
  4008ac:	f947dfe1 	ldr	x1, [sp, #4024]
  4008b0:	9ac00c23 	sdiv	x3, x1, x0
  4008b4:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4008b8:	9100c002 	add	x2, x0, #0x30
  4008bc:	b98fcfe4 	ldrsw	x4, [sp, #4044]
  4008c0:	b98fcbe1 	ldrsw	x1, [sp, #4040]
  4008c4:	aa0103e0 	mov	x0, x1
  4008c8:	d37be800 	lsl	x0, x0, #5
  4008cc:	cb010000 	sub	x0, x0, x1
  4008d0:	d37ef400 	lsl	x0, x0, #2
  4008d4:	8b010000 	add	x0, x0, x1
  4008d8:	d37ef400 	lsl	x0, x0, #2
  4008dc:	8b040000 	add	x0, x0, x4
  4008e0:	f8207843 	str	x3, [x2, x0, lsl #3]
  4008e4:	b94fcbe0 	ldr	w0, [sp, #4040]
  4008e8:	11000400 	add	w0, w0, #0x1
  4008ec:	b90fcbe0 	str	w0, [sp, #4040]
  4008f0:	b94fcbe1 	ldr	w1, [sp, #4040]
  4008f4:	b9400be0 	ldr	w0, [sp, #8]
  4008f8:	6b00003f 	cmp	w1, w0
  4008fc:	54fff60d 	b.le	4007bc <ludcmp+0x24>
  400900:	b94fcfe0 	ldr	w0, [sp, #4044]
  400904:	11000400 	add	w0, w0, #0x1
  400908:	b90fcbe0 	str	w0, [sp, #4040]
  40090c:	14000049 	b	400a30 <ludcmp+0x298>
  400910:	b94fcfe0 	ldr	w0, [sp, #4044]
  400914:	11000401 	add	w1, w0, #0x1
  400918:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  40091c:	9100c002 	add	x2, x0, #0x30
  400920:	b98fcbe3 	ldrsw	x3, [sp, #4040]
  400924:	93407c21 	sxtw	x1, w1
  400928:	aa0103e0 	mov	x0, x1
  40092c:	d37be800 	lsl	x0, x0, #5
  400930:	cb010000 	sub	x0, x0, x1
  400934:	d37ef400 	lsl	x0, x0, #2
  400938:	8b010000 	add	x0, x0, x1
  40093c:	d37ef400 	lsl	x0, x0, #2
  400940:	8b030000 	add	x0, x0, x3
  400944:	f8607840 	ldr	x0, [x2, x0, lsl #3]
  400948:	f907dfe0 	str	x0, [sp, #4024]
  40094c:	b90fc7ff 	str	wzr, [sp, #4036]
  400950:	14000022 	b	4009d8 <ludcmp+0x240>
  400954:	b94fcfe0 	ldr	w0, [sp, #4044]
  400958:	11000401 	add	w1, w0, #0x1
  40095c:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400960:	9100c002 	add	x2, x0, #0x30
  400964:	b98fc7e3 	ldrsw	x3, [sp, #4036]
  400968:	93407c21 	sxtw	x1, w1
  40096c:	aa0103e0 	mov	x0, x1
  400970:	d37be800 	lsl	x0, x0, #5
  400974:	cb010000 	sub	x0, x0, x1
  400978:	d37ef400 	lsl	x0, x0, #2
  40097c:	8b010000 	add	x0, x0, x1
  400980:	d37ef400 	lsl	x0, x0, #2
  400984:	8b030000 	add	x0, x0, x3
  400988:	f8607842 	ldr	x2, [x2, x0, lsl #3]
  40098c:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400990:	9100c003 	add	x3, x0, #0x30
  400994:	b98fcbe4 	ldrsw	x4, [sp, #4040]
  400998:	b98fc7e1 	ldrsw	x1, [sp, #4036]
  40099c:	aa0103e0 	mov	x0, x1
  4009a0:	d37be800 	lsl	x0, x0, #5
  4009a4:	cb010000 	sub	x0, x0, x1
  4009a8:	d37ef400 	lsl	x0, x0, #2
  4009ac:	8b010000 	add	x0, x0, x1
  4009b0:	d37ef400 	lsl	x0, x0, #2
  4009b4:	8b040000 	add	x0, x0, x4
  4009b8:	f8607860 	ldr	x0, [x3, x0, lsl #3]
  4009bc:	9b007c40 	mul	x0, x2, x0
  4009c0:	f947dfe1 	ldr	x1, [sp, #4024]
  4009c4:	cb000020 	sub	x0, x1, x0
  4009c8:	f907dfe0 	str	x0, [sp, #4024]
  4009cc:	b94fc7e0 	ldr	w0, [sp, #4036]
  4009d0:	11000400 	add	w0, w0, #0x1
  4009d4:	b90fc7e0 	str	w0, [sp, #4036]
  4009d8:	b94fc7e1 	ldr	w1, [sp, #4036]
  4009dc:	b94fcfe0 	ldr	w0, [sp, #4044]
  4009e0:	6b00003f 	cmp	w1, w0
  4009e4:	54fffb8d 	b.le	400954 <ludcmp+0x1bc>
  4009e8:	b94fcfe0 	ldr	w0, [sp, #4044]
  4009ec:	11000401 	add	w1, w0, #0x1
  4009f0:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4009f4:	9100c002 	add	x2, x0, #0x30
  4009f8:	b98fcbe3 	ldrsw	x3, [sp, #4040]
  4009fc:	93407c21 	sxtw	x1, w1
  400a00:	aa0103e0 	mov	x0, x1
  400a04:	d37be800 	lsl	x0, x0, #5
  400a08:	cb010000 	sub	x0, x0, x1
  400a0c:	d37ef400 	lsl	x0, x0, #2
  400a10:	8b010000 	add	x0, x0, x1
  400a14:	d37ef400 	lsl	x0, x0, #2
  400a18:	8b030000 	add	x0, x0, x3
  400a1c:	f947dfe1 	ldr	x1, [sp, #4024]
  400a20:	f8207841 	str	x1, [x2, x0, lsl #3]
  400a24:	b94fcbe0 	ldr	w0, [sp, #4040]
  400a28:	11000400 	add	w0, w0, #0x1
  400a2c:	b90fcbe0 	str	w0, [sp, #4040]
  400a30:	b94fcbe1 	ldr	w1, [sp, #4040]
  400a34:	b9400be0 	ldr	w0, [sp, #8]
  400a38:	6b00003f 	cmp	w1, w0
  400a3c:	54fff6ad 	b.le	400910 <ludcmp+0x178>
  400a40:	b94fcfe0 	ldr	w0, [sp, #4044]
  400a44:	11000400 	add	w0, w0, #0x1
  400a48:	b90fcfe0 	str	w0, [sp, #4044]
  400a4c:	b94fcfe1 	ldr	w1, [sp, #4044]
  400a50:	b9400be0 	ldr	w0, [sp, #8]
  400a54:	6b00003f 	cmp	w1, w0
  400a58:	54ffeaab 	b.lt	4007ac <ludcmp+0x14>  // b.tstop
  400a5c:	90001040 	adrp	x0, 608000 <a+0x1e7fd0>
  400a60:	9112c000 	add	x0, x0, #0x4b0
  400a64:	f9400000 	ldr	x0, [x0]
  400a68:	f9000fe0 	str	x0, [sp, #24]
  400a6c:	52800020 	mov	w0, #0x1                   	// #1
  400a70:	b90fcfe0 	str	w0, [sp, #4044]
  400a74:	1400002b 	b	400b20 <ludcmp+0x388>
  400a78:	90001040 	adrp	x0, 608000 <a+0x1e7fd0>
  400a7c:	9112c000 	add	x0, x0, #0x4b0
  400a80:	b98fcfe1 	ldrsw	x1, [sp, #4044]
  400a84:	f8617800 	ldr	x0, [x0, x1, lsl #3]
  400a88:	f907dfe0 	str	x0, [sp, #4024]
  400a8c:	b90fcbff 	str	wzr, [sp, #4040]
  400a90:	14000018 	b	400af0 <ludcmp+0x358>
  400a94:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400a98:	9100c002 	add	x2, x0, #0x30
  400a9c:	b98fcbe3 	ldrsw	x3, [sp, #4040]
  400aa0:	b98fcfe1 	ldrsw	x1, [sp, #4044]
  400aa4:	aa0103e0 	mov	x0, x1
  400aa8:	d37be800 	lsl	x0, x0, #5
  400aac:	cb010000 	sub	x0, x0, x1
  400ab0:	d37ef400 	lsl	x0, x0, #2
  400ab4:	8b010000 	add	x0, x0, x1
  400ab8:	d37ef400 	lsl	x0, x0, #2
  400abc:	8b030000 	add	x0, x0, x3
  400ac0:	f8607841 	ldr	x1, [x2, x0, lsl #3]
  400ac4:	b98fcbe0 	ldrsw	x0, [sp, #4040]
  400ac8:	d37df000 	lsl	x0, x0, #3
  400acc:	910063e2 	add	x2, sp, #0x18
  400ad0:	f8606840 	ldr	x0, [x2, x0]
  400ad4:	9b007c20 	mul	x0, x1, x0
  400ad8:	f947dfe1 	ldr	x1, [sp, #4024]
  400adc:	cb000020 	sub	x0, x1, x0
  400ae0:	f907dfe0 	str	x0, [sp, #4024]
  400ae4:	b94fcbe0 	ldr	w0, [sp, #4040]
  400ae8:	11000400 	add	w0, w0, #0x1
  400aec:	b90fcbe0 	str	w0, [sp, #4040]
  400af0:	b94fcbe1 	ldr	w1, [sp, #4040]
  400af4:	b94fcfe0 	ldr	w0, [sp, #4044]
  400af8:	6b00003f 	cmp	w1, w0
  400afc:	54fffccb 	b.lt	400a94 <ludcmp+0x2fc>  // b.tstop
  400b00:	b98fcfe0 	ldrsw	x0, [sp, #4044]
  400b04:	d37df000 	lsl	x0, x0, #3
  400b08:	910063e1 	add	x1, sp, #0x18
  400b0c:	f947dfe2 	ldr	x2, [sp, #4024]
  400b10:	f8206822 	str	x2, [x1, x0]
  400b14:	b94fcfe0 	ldr	w0, [sp, #4044]
  400b18:	11000400 	add	w0, w0, #0x1
  400b1c:	b90fcfe0 	str	w0, [sp, #4044]
  400b20:	b94fcfe1 	ldr	w1, [sp, #4044]
  400b24:	b9400be0 	ldr	w0, [sp, #8]
  400b28:	6b00003f 	cmp	w1, w0
  400b2c:	54fffa6d 	b.le	400a78 <ludcmp+0x2e0>
  400b30:	b9800be0 	ldrsw	x0, [sp, #8]
  400b34:	d37df000 	lsl	x0, x0, #3
  400b38:	910063e1 	add	x1, sp, #0x18
  400b3c:	f8606821 	ldr	x1, [x1, x0]
  400b40:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400b44:	9100c002 	add	x2, x0, #0x30
  400b48:	b9800be3 	ldrsw	x3, [sp, #8]
  400b4c:	d281f500 	mov	x0, #0xfa8                 	// #4008
  400b50:	9b007c60 	mul	x0, x3, x0
  400b54:	8b000040 	add	x0, x2, x0
  400b58:	f9400000 	ldr	x0, [x0]
  400b5c:	9ac00c22 	sdiv	x2, x1, x0
  400b60:	b0001040 	adrp	x0, 609000 <b+0xb50>
  400b64:	91114000 	add	x0, x0, #0x450
  400b68:	b9800be1 	ldrsw	x1, [sp, #8]
  400b6c:	f8217802 	str	x2, [x0, x1, lsl #3]
  400b70:	b9400be0 	ldr	w0, [sp, #8]
  400b74:	51000400 	sub	w0, w0, #0x1
  400b78:	b90fcfe0 	str	w0, [sp, #4044]
  400b7c:	14000035 	b	400c50 <ludcmp+0x4b8>
  400b80:	b98fcfe0 	ldrsw	x0, [sp, #4044]
  400b84:	d37df000 	lsl	x0, x0, #3
  400b88:	910063e1 	add	x1, sp, #0x18
  400b8c:	f8606820 	ldr	x0, [x1, x0]
  400b90:	f907dfe0 	str	x0, [sp, #4024]
  400b94:	b94fcfe0 	ldr	w0, [sp, #4044]
  400b98:	11000400 	add	w0, w0, #0x1
  400b9c:	b90fcbe0 	str	w0, [sp, #4040]
  400ba0:	14000018 	b	400c00 <ludcmp+0x468>
  400ba4:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400ba8:	9100c002 	add	x2, x0, #0x30
  400bac:	b98fcbe3 	ldrsw	x3, [sp, #4040]
  400bb0:	b98fcfe1 	ldrsw	x1, [sp, #4044]
  400bb4:	aa0103e0 	mov	x0, x1
  400bb8:	d37be800 	lsl	x0, x0, #5
  400bbc:	cb010000 	sub	x0, x0, x1
  400bc0:	d37ef400 	lsl	x0, x0, #2
  400bc4:	8b010000 	add	x0, x0, x1
  400bc8:	d37ef400 	lsl	x0, x0, #2
  400bcc:	8b030000 	add	x0, x0, x3
  400bd0:	f8607841 	ldr	x1, [x2, x0, lsl #3]
  400bd4:	b0001040 	adrp	x0, 609000 <b+0xb50>
  400bd8:	91114000 	add	x0, x0, #0x450
  400bdc:	b98fcbe2 	ldrsw	x2, [sp, #4040]
  400be0:	f8627800 	ldr	x0, [x0, x2, lsl #3]
  400be4:	9b007c20 	mul	x0, x1, x0
  400be8:	f947dfe1 	ldr	x1, [sp, #4024]
  400bec:	cb000020 	sub	x0, x1, x0
  400bf0:	f907dfe0 	str	x0, [sp, #4024]
  400bf4:	b94fcbe0 	ldr	w0, [sp, #4040]
  400bf8:	11000400 	add	w0, w0, #0x1
  400bfc:	b90fcbe0 	str	w0, [sp, #4040]
  400c00:	b94fcbe1 	ldr	w1, [sp, #4040]
  400c04:	b9400be0 	ldr	w0, [sp, #8]
  400c08:	6b00003f 	cmp	w1, w0
  400c0c:	54fffccd 	b.le	400ba4 <ludcmp+0x40c>
  400c10:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400c14:	9100c001 	add	x1, x0, #0x30
  400c18:	b98fcfe2 	ldrsw	x2, [sp, #4044]
  400c1c:	d281f500 	mov	x0, #0xfa8                 	// #4008
  400c20:	9b007c40 	mul	x0, x2, x0
  400c24:	8b000020 	add	x0, x1, x0
  400c28:	f9400000 	ldr	x0, [x0]
  400c2c:	f947dfe1 	ldr	x1, [sp, #4024]
  400c30:	9ac00c22 	sdiv	x2, x1, x0
  400c34:	b0001040 	adrp	x0, 609000 <b+0xb50>
  400c38:	91114000 	add	x0, x0, #0x450
  400c3c:	b98fcfe1 	ldrsw	x1, [sp, #4044]
  400c40:	f8217802 	str	x2, [x0, x1, lsl #3]
  400c44:	b94fcfe0 	ldr	w0, [sp, #4044]
  400c48:	51000400 	sub	w0, w0, #0x1
  400c4c:	b90fcfe0 	str	w0, [sp, #4044]
  400c50:	b94fcfe0 	ldr	w0, [sp, #4044]
  400c54:	7100001f 	cmp	w0, #0x0
  400c58:	54fff94a 	b.ge	400b80 <ludcmp+0x3e8>  // b.tcont
  400c5c:	52800000 	mov	w0, #0x0                   	// #0
  400c60:	913f43ff 	add	sp, sp, #0xfd0
  400c64:	d65f03c0 	ret

Disassembly of section .fini:

0000000000400c68 <_fini>:
  400c68:	d503201f 	nop
  400c6c:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
  400c70:	910003fd 	mov	x29, sp
  400c74:	a8c17bfd 	ldp	x29, x30, [sp], #16
  400c78:	d65f03c0 	ret
