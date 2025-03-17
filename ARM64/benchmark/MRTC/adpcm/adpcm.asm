
adpcm：     文件格式 elf64-littleaarch64


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
  4004b4:	f00000f0 	adrp	x16, 41f000 <__FRAME_END__+0x1c78c>
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
  400538:	14000790 	b	402378 <main>
  40053c:	d503201f 	nop

0000000000400540 <_dl_relocate_static_pie>:
  400540:	d65f03c0 	ret

0000000000400544 <call_weak_fn>:
  400544:	f00000e0 	adrp	x0, 41f000 <__FRAME_END__+0x1c78c>
  400548:	f947ec00 	ldr	x0, [x0, #4056]
  40054c:	b4000040 	cbz	x0, 400554 <call_weak_fn+0x10>
  400550:	17ffffe4 	b	4004e0 <__gmon_start__@plt>
  400554:	d65f03c0 	ret
  400558:	d503201f 	nop
  40055c:	d503201f 	nop

0000000000400560 <deregister_tm_clones>:
  400560:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400564:	91130000 	add	x0, x0, #0x4c0
  400568:	90000101 	adrp	x1, 420000 <__libc_start_main@GLIBC_2.34>
  40056c:	91130021 	add	x1, x1, #0x4c0
  400570:	eb00003f 	cmp	x1, x0
  400574:	540000c0 	b.eq	40058c <deregister_tm_clones+0x2c>  // b.none
  400578:	f00000e1 	adrp	x1, 41f000 <__FRAME_END__+0x1c78c>
  40057c:	f947e821 	ldr	x1, [x1, #4048]
  400580:	b4000061 	cbz	x1, 40058c <deregister_tm_clones+0x2c>
  400584:	aa0103f0 	mov	x16, x1
  400588:	d61f0200 	br	x16
  40058c:	d65f03c0 	ret

0000000000400590 <register_tm_clones>:
  400590:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400594:	91130000 	add	x0, x0, #0x4c0
  400598:	90000101 	adrp	x1, 420000 <__libc_start_main@GLIBC_2.34>
  40059c:	91130021 	add	x1, x1, #0x4c0
  4005a0:	cb000021 	sub	x1, x1, x0
  4005a4:	d37ffc22 	lsr	x2, x1, #63
  4005a8:	8b810c41 	add	x1, x2, x1, asr #3
  4005ac:	9341fc21 	asr	x1, x1, #1
  4005b0:	b40000c1 	cbz	x1, 4005c8 <register_tm_clones+0x38>
  4005b4:	f00000e2 	adrp	x2, 41f000 <__FRAME_END__+0x1c78c>
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
  4005e0:	39530260 	ldrb	w0, [x19, #1216]
  4005e4:	35000080 	cbnz	w0, 4005f4 <__do_global_dtors_aux+0x24>
  4005e8:	97ffffde 	bl	400560 <deregister_tm_clones>
  4005ec:	52800020 	mov	w0, #0x1                   	// #1
  4005f0:	39130260 	strb	w0, [x19, #1216]
  4005f4:	f9400bf3 	ldr	x19, [sp, #16]
  4005f8:	a8c27bfd 	ldp	x29, x30, [sp], #32
  4005fc:	d65f03c0 	ret

0000000000400600 <frame_dummy>:
  400600:	17ffffe4 	b	400590 <register_tm_clones>

0000000000400604 <my_abs>:
  400604:	d10083ff 	sub	sp, sp, #0x20
  400608:	b9000fe0 	str	w0, [sp, #12]
  40060c:	b9400fe0 	ldr	w0, [sp, #12]
  400610:	7100001f 	cmp	w0, #0x0
  400614:	5400008b 	b.lt	400624 <my_abs+0x20>  // b.tstop
  400618:	b9400fe0 	ldr	w0, [sp, #12]
  40061c:	b9001fe0 	str	w0, [sp, #28]
  400620:	14000004 	b	400630 <my_abs+0x2c>
  400624:	b9400fe0 	ldr	w0, [sp, #12]
  400628:	4b0003e0 	neg	w0, w0
  40062c:	b9001fe0 	str	w0, [sp, #28]
  400630:	b9401fe0 	ldr	w0, [sp, #28]
  400634:	910083ff 	add	sp, sp, #0x20
  400638:	d65f03c0 	ret

000000000040063c <my_fabs>:
  40063c:	d10083ff 	sub	sp, sp, #0x20
  400640:	b9000fe0 	str	w0, [sp, #12]
  400644:	b9400fe0 	ldr	w0, [sp, #12]
  400648:	7100001f 	cmp	w0, #0x0
  40064c:	5400008b 	b.lt	40065c <my_fabs+0x20>  // b.tstop
  400650:	b9400fe0 	ldr	w0, [sp, #12]
  400654:	b9001fe0 	str	w0, [sp, #28]
  400658:	14000004 	b	400668 <my_fabs+0x2c>
  40065c:	b9400fe0 	ldr	w0, [sp, #12]
  400660:	4b0003e0 	neg	w0, w0
  400664:	b9001fe0 	str	w0, [sp, #28]
  400668:	b9401fe0 	ldr	w0, [sp, #28]
  40066c:	910083ff 	add	sp, sp, #0x20
  400670:	d65f03c0 	ret

0000000000400674 <my_sin>:
  400674:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
  400678:	910003fd 	mov	x29, sp
  40067c:	b9001fe0 	str	w0, [sp, #28]
  400680:	b9002bff 	str	wzr, [sp, #40]
  400684:	52800020 	mov	w0, #0x1                   	// #1
  400688:	b90027e0 	str	w0, [sp, #36]
  40068c:	14000005 	b	4006a0 <my_sin+0x2c>
  400690:	b9401fe1 	ldr	w1, [sp, #28]
  400694:	12831120 	mov	w0, #0xffffe776            	// #-6282
  400698:	0b000020 	add	w0, w1, w0
  40069c:	b9001fe0 	str	w0, [sp, #28]
  4006a0:	b9401fe1 	ldr	w1, [sp, #28]
  4006a4:	52831140 	mov	w0, #0x188a                	// #6282
  4006a8:	6b00003f 	cmp	w1, w0
  4006ac:	54ffff2c 	b.gt	400690 <my_sin+0x1c>
  4006b0:	14000005 	b	4006c4 <my_sin+0x50>
  4006b4:	b9401fe1 	ldr	w1, [sp, #28]
  4006b8:	52831140 	mov	w0, #0x188a                	// #6282
  4006bc:	0b000020 	add	w0, w1, w0
  4006c0:	b9001fe0 	str	w0, [sp, #28]
  4006c4:	b9401fe1 	ldr	w1, [sp, #28]
  4006c8:	12831120 	mov	w0, #0xffffe776            	// #-6282
  4006cc:	6b00003f 	cmp	w1, w0
  4006d0:	54ffff2b 	b.lt	4006b4 <my_sin+0x40>  // b.tstop
  4006d4:	b9401fe0 	ldr	w0, [sp, #28]
  4006d8:	b9002fe0 	str	w0, [sp, #44]
  4006dc:	b9402fe0 	ldr	w0, [sp, #44]
  4006e0:	b9002be0 	str	w0, [sp, #40]
  4006e4:	b9401fe0 	ldr	w0, [sp, #28]
  4006e8:	1b007c00 	mul	w0, w0, w0
  4006ec:	4b0003e1 	neg	w1, w0
  4006f0:	b9402fe0 	ldr	w0, [sp, #44]
  4006f4:	1b007c21 	mul	w1, w1, w0
  4006f8:	b94027e0 	ldr	w0, [sp, #36]
  4006fc:	531f7800 	lsl	w0, w0, #1
  400700:	11000402 	add	w2, w0, #0x1
  400704:	b94027e0 	ldr	w0, [sp, #36]
  400708:	1b007c40 	mul	w0, w2, w0
  40070c:	531f7800 	lsl	w0, w0, #1
  400710:	1ac00c20 	sdiv	w0, w1, w0
  400714:	b9002fe0 	str	w0, [sp, #44]
  400718:	b9402be1 	ldr	w1, [sp, #40]
  40071c:	b9402fe0 	ldr	w0, [sp, #44]
  400720:	0b000020 	add	w0, w1, w0
  400724:	b9002be0 	str	w0, [sp, #40]
  400728:	b94027e0 	ldr	w0, [sp, #36]
  40072c:	11000400 	add	w0, w0, #0x1
  400730:	b90027e0 	str	w0, [sp, #36]
  400734:	14000015 	b	400788 <my_sin+0x114>
  400738:	b9401fe0 	ldr	w0, [sp, #28]
  40073c:	1b007c00 	mul	w0, w0, w0
  400740:	4b0003e1 	neg	w1, w0
  400744:	b9402fe0 	ldr	w0, [sp, #44]
  400748:	1b007c21 	mul	w1, w1, w0
  40074c:	b94027e0 	ldr	w0, [sp, #36]
  400750:	531f7800 	lsl	w0, w0, #1
  400754:	11000402 	add	w2, w0, #0x1
  400758:	b94027e0 	ldr	w0, [sp, #36]
  40075c:	1b007c40 	mul	w0, w2, w0
  400760:	531f7800 	lsl	w0, w0, #1
  400764:	1ac00c20 	sdiv	w0, w1, w0
  400768:	b9002fe0 	str	w0, [sp, #44]
  40076c:	b9402be1 	ldr	w1, [sp, #40]
  400770:	b9402fe0 	ldr	w0, [sp, #44]
  400774:	0b000020 	add	w0, w1, w0
  400778:	b9002be0 	str	w0, [sp, #40]
  40077c:	b94027e0 	ldr	w0, [sp, #36]
  400780:	11000400 	add	w0, w0, #0x1
  400784:	b90027e0 	str	w0, [sp, #36]
  400788:	b9402fe0 	ldr	w0, [sp, #44]
  40078c:	97ffffac 	bl	40063c <my_fabs>
  400790:	7100001f 	cmp	w0, #0x0
  400794:	54fffd2c 	b.gt	400738 <my_sin+0xc4>
  400798:	b9402be0 	ldr	w0, [sp, #40]
  40079c:	a8c37bfd 	ldp	x29, x30, [sp], #48
  4007a0:	d65f03c0 	ret

00000000004007a4 <my_cos>:
  4007a4:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
  4007a8:	910003fd 	mov	x29, sp
  4007ac:	b9001fe0 	str	w0, [sp, #28]
  4007b0:	5280c441 	mov	w1, #0x622                 	// #1570
  4007b4:	b9401fe0 	ldr	w0, [sp, #28]
  4007b8:	4b000020 	sub	w0, w1, w0
  4007bc:	97ffffae 	bl	400674 <my_sin>
  4007c0:	a8c27bfd 	ldp	x29, x30, [sp], #32
  4007c4:	d65f03c0 	ret

00000000004007c8 <encode>:
  4007c8:	a9ba7bfd 	stp	x29, x30, [sp, #-96]!
  4007cc:	910003fd 	mov	x29, sp
  4007d0:	b9001fe0 	str	w0, [sp, #28]
  4007d4:	b9001be1 	str	w1, [sp, #24]
  4007d8:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4007dc:	9100a000 	add	x0, x0, #0x28
  4007e0:	f9002be0 	str	x0, [sp, #80]
  4007e4:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4007e8:	91132000 	add	x0, x0, #0x4c8
  4007ec:	f90027e0 	str	x0, [sp, #72]
  4007f0:	f94027e0 	ldr	x0, [sp, #72]
  4007f4:	91001001 	add	x1, x0, #0x4
  4007f8:	f90027e1 	str	x1, [sp, #72]
  4007fc:	b9400000 	ldr	w0, [x0]
  400800:	93407c01 	sxtw	x1, w0
  400804:	f9402be0 	ldr	x0, [sp, #80]
  400808:	91001002 	add	x2, x0, #0x4
  40080c:	f9002be2 	str	x2, [sp, #80]
  400810:	b9400000 	ldr	w0, [x0]
  400814:	93407c00 	sxtw	x0, w0
  400818:	9b007c20 	mul	x0, x1, x0
  40081c:	f9001fe0 	str	x0, [sp, #56]
  400820:	f94027e0 	ldr	x0, [sp, #72]
  400824:	91001001 	add	x1, x0, #0x4
  400828:	f90027e1 	str	x1, [sp, #72]
  40082c:	b9400000 	ldr	w0, [x0]
  400830:	93407c01 	sxtw	x1, w0
  400834:	f9402be0 	ldr	x0, [sp, #80]
  400838:	91001002 	add	x2, x0, #0x4
  40083c:	f9002be2 	str	x2, [sp, #80]
  400840:	b9400000 	ldr	w0, [x0]
  400844:	93407c00 	sxtw	x0, w0
  400848:	9b007c20 	mul	x0, x1, x0
  40084c:	f9001be0 	str	x0, [sp, #48]
  400850:	b9005fff 	str	wzr, [sp, #92]
  400854:	14000020 	b	4008d4 <encode+0x10c>
  400858:	f94027e0 	ldr	x0, [sp, #72]
  40085c:	91001001 	add	x1, x0, #0x4
  400860:	f90027e1 	str	x1, [sp, #72]
  400864:	b9400000 	ldr	w0, [x0]
  400868:	93407c01 	sxtw	x1, w0
  40086c:	f9402be0 	ldr	x0, [sp, #80]
  400870:	91001002 	add	x2, x0, #0x4
  400874:	f9002be2 	str	x2, [sp, #80]
  400878:	b9400000 	ldr	w0, [x0]
  40087c:	93407c00 	sxtw	x0, w0
  400880:	9b007c20 	mul	x0, x1, x0
  400884:	f9401fe1 	ldr	x1, [sp, #56]
  400888:	8b000020 	add	x0, x1, x0
  40088c:	f9001fe0 	str	x0, [sp, #56]
  400890:	f94027e0 	ldr	x0, [sp, #72]
  400894:	91001001 	add	x1, x0, #0x4
  400898:	f90027e1 	str	x1, [sp, #72]
  40089c:	b9400000 	ldr	w0, [x0]
  4008a0:	93407c01 	sxtw	x1, w0
  4008a4:	f9402be0 	ldr	x0, [sp, #80]
  4008a8:	91001002 	add	x2, x0, #0x4
  4008ac:	f9002be2 	str	x2, [sp, #80]
  4008b0:	b9400000 	ldr	w0, [x0]
  4008b4:	93407c00 	sxtw	x0, w0
  4008b8:	9b007c20 	mul	x0, x1, x0
  4008bc:	f9401be1 	ldr	x1, [sp, #48]
  4008c0:	8b000020 	add	x0, x1, x0
  4008c4:	f9001be0 	str	x0, [sp, #48]
  4008c8:	b9405fe0 	ldr	w0, [sp, #92]
  4008cc:	11000400 	add	w0, w0, #0x1
  4008d0:	b9005fe0 	str	w0, [sp, #92]
  4008d4:	b9405fe0 	ldr	w0, [sp, #92]
  4008d8:	7100241f 	cmp	w0, #0x9
  4008dc:	54fffbed 	b.le	400858 <encode+0x90>
  4008e0:	f94027e0 	ldr	x0, [sp, #72]
  4008e4:	91001001 	add	x1, x0, #0x4
  4008e8:	f90027e1 	str	x1, [sp, #72]
  4008ec:	b9400000 	ldr	w0, [x0]
  4008f0:	93407c01 	sxtw	x1, w0
  4008f4:	f9402be0 	ldr	x0, [sp, #80]
  4008f8:	91001002 	add	x2, x0, #0x4
  4008fc:	f9002be2 	str	x2, [sp, #80]
  400900:	b9400000 	ldr	w0, [x0]
  400904:	93407c00 	sxtw	x0, w0
  400908:	9b007c20 	mul	x0, x1, x0
  40090c:	f9401fe1 	ldr	x1, [sp, #56]
  400910:	8b000020 	add	x0, x1, x0
  400914:	f9001fe0 	str	x0, [sp, #56]
  400918:	f94027e0 	ldr	x0, [sp, #72]
  40091c:	b9400000 	ldr	w0, [x0]
  400920:	93407c01 	sxtw	x1, w0
  400924:	f9402be0 	ldr	x0, [sp, #80]
  400928:	91001002 	add	x2, x0, #0x4
  40092c:	f9002be2 	str	x2, [sp, #80]
  400930:	b9400000 	ldr	w0, [x0]
  400934:	93407c00 	sxtw	x0, w0
  400938:	9b007c20 	mul	x0, x1, x0
  40093c:	f9401be1 	ldr	x1, [sp, #48]
  400940:	8b000020 	add	x0, x1, x0
  400944:	f9001be0 	str	x0, [sp, #48]
  400948:	f94027e0 	ldr	x0, [sp, #72]
  40094c:	d1002000 	sub	x0, x0, #0x8
  400950:	f90023e0 	str	x0, [sp, #64]
  400954:	b9005fff 	str	wzr, [sp, #92]
  400958:	1400000c 	b	400988 <encode+0x1c0>
  40095c:	f94023e1 	ldr	x1, [sp, #64]
  400960:	d1001020 	sub	x0, x1, #0x4
  400964:	f90023e0 	str	x0, [sp, #64]
  400968:	f94027e0 	ldr	x0, [sp, #72]
  40096c:	d1001002 	sub	x2, x0, #0x4
  400970:	f90027e2 	str	x2, [sp, #72]
  400974:	b9400021 	ldr	w1, [x1]
  400978:	b9000001 	str	w1, [x0]
  40097c:	b9405fe0 	ldr	w0, [sp, #92]
  400980:	11000400 	add	w0, w0, #0x1
  400984:	b9005fe0 	str	w0, [sp, #92]
  400988:	b9405fe0 	ldr	w0, [sp, #92]
  40098c:	7100541f 	cmp	w0, #0x15
  400990:	54fffe6d 	b.le	40095c <encode+0x194>
  400994:	f94027e0 	ldr	x0, [sp, #72]
  400998:	d1001001 	sub	x1, x0, #0x4
  40099c:	f90027e1 	str	x1, [sp, #72]
  4009a0:	b9401fe1 	ldr	w1, [sp, #28]
  4009a4:	b9000001 	str	w1, [x0]
  4009a8:	f94027e0 	ldr	x0, [sp, #72]
  4009ac:	b9401be1 	ldr	w1, [sp, #24]
  4009b0:	b9000001 	str	w1, [x0]
  4009b4:	f9401fe1 	ldr	x1, [sp, #56]
  4009b8:	f9401be0 	ldr	x0, [sp, #48]
  4009bc:	8b000020 	add	x0, x1, x0
  4009c0:	934ffc00 	asr	x0, x0, #15
  4009c4:	2a0003e1 	mov	w1, w0
  4009c8:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4009cc:	9114a000 	add	x0, x0, #0x528
  4009d0:	b9000001 	str	w1, [x0]
  4009d4:	f9401fe1 	ldr	x1, [sp, #56]
  4009d8:	f9401be0 	ldr	x0, [sp, #48]
  4009dc:	cb000020 	sub	x0, x1, x0
  4009e0:	934ffc00 	asr	x0, x0, #15
  4009e4:	2a0003e1 	mov	w1, w0
  4009e8:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4009ec:	9114b000 	add	x0, x0, #0x52c
  4009f0:	b9000001 	str	w1, [x0]
  4009f4:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4009f8:	91172001 	add	x1, x0, #0x5c8
  4009fc:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400a00:	9116c000 	add	x0, x0, #0x5b0
  400a04:	940004cd 	bl	401d38 <filtez>
  400a08:	2a0003e1 	mov	w1, w0
  400a0c:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400a10:	91168000 	add	x0, x0, #0x5a0
  400a14:	b9000001 	str	w1, [x0]
  400a18:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400a1c:	91181000 	add	x0, x0, #0x604
  400a20:	b9400004 	ldr	w4, [x0]
  400a24:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400a28:	91179000 	add	x0, x0, #0x5e4
  400a2c:	b9400001 	ldr	w1, [x0]
  400a30:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400a34:	91182000 	add	x0, x0, #0x608
  400a38:	b9400002 	ldr	w2, [x0]
  400a3c:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400a40:	9117a000 	add	x0, x0, #0x5e8
  400a44:	b9400000 	ldr	w0, [x0]
  400a48:	2a0003e3 	mov	w3, w0
  400a4c:	2a0403e0 	mov	w0, w4
  400a50:	940004e4 	bl	401de0 <filtep>
  400a54:	2a0003e1 	mov	w1, w0
  400a58:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400a5c:	91169000 	add	x0, x0, #0x5a4
  400a60:	b9000001 	str	w1, [x0]
  400a64:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400a68:	91168000 	add	x0, x0, #0x5a0
  400a6c:	b9400001 	ldr	w1, [x0]
  400a70:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400a74:	91169000 	add	x0, x0, #0x5a4
  400a78:	b9400000 	ldr	w0, [x0]
  400a7c:	0b000021 	add	w1, w1, w0
  400a80:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400a84:	9116a000 	add	x0, x0, #0x5a8
  400a88:	b9000001 	str	w1, [x0]
  400a8c:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400a90:	9114a000 	add	x0, x0, #0x528
  400a94:	b9400001 	ldr	w1, [x0]
  400a98:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400a9c:	9116a000 	add	x0, x0, #0x5a8
  400aa0:	b9400000 	ldr	w0, [x0]
  400aa4:	4b000021 	sub	w1, w1, w0
  400aa8:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400aac:	9116b000 	add	x0, x0, #0x5ac
  400ab0:	b9000001 	str	w1, [x0]
  400ab4:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400ab8:	9116b000 	add	x0, x0, #0x5ac
  400abc:	b9400002 	ldr	w2, [x0]
  400ac0:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400ac4:	91183000 	add	x0, x0, #0x60c
  400ac8:	b9400000 	ldr	w0, [x0]
  400acc:	2a0003e1 	mov	w1, w0
  400ad0:	2a0203e0 	mov	w0, w2
  400ad4:	940004de 	bl	401e4c <quantl>
  400ad8:	2a0003e1 	mov	w1, w0
  400adc:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400ae0:	91167000 	add	x0, x0, #0x59c
  400ae4:	b9000001 	str	w1, [x0]
  400ae8:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400aec:	91183000 	add	x0, x0, #0x60c
  400af0:	b9400000 	ldr	w0, [x0]
  400af4:	93407c01 	sxtw	x1, w0
  400af8:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400afc:	91167000 	add	x0, x0, #0x59c
  400b00:	b9400000 	ldr	w0, [x0]
  400b04:	13027c02 	asr	w2, w0, #2
  400b08:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400b0c:	91022000 	add	x0, x0, #0x88
  400b10:	93407c42 	sxtw	x2, w2
  400b14:	b8627800 	ldr	w0, [x0, x2, lsl #2]
  400b18:	93407c00 	sxtw	x0, w0
  400b1c:	9b007c20 	mul	x0, x1, x0
  400b20:	934ffc00 	asr	x0, x0, #15
  400b24:	2a0003e1 	mov	w1, w0
  400b28:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400b2c:	9117f000 	add	x0, x0, #0x5fc
  400b30:	b9000001 	str	w1, [x0]
  400b34:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400b38:	91167000 	add	x0, x0, #0x59c
  400b3c:	b9400002 	ldr	w2, [x0]
  400b40:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400b44:	91178000 	add	x0, x0, #0x5e0
  400b48:	b9400000 	ldr	w0, [x0]
  400b4c:	2a0003e1 	mov	w1, w0
  400b50:	2a0203e0 	mov	w0, w2
  400b54:	940004ee 	bl	401f0c <logscl>
  400b58:	2a0003e1 	mov	w1, w0
  400b5c:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400b60:	91178000 	add	x0, x0, #0x5e0
  400b64:	b9000001 	str	w1, [x0]
  400b68:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400b6c:	91178000 	add	x0, x0, #0x5e0
  400b70:	b9400000 	ldr	w0, [x0]
  400b74:	52800101 	mov	w1, #0x8                   	// #8
  400b78:	94000505 	bl	401f8c <scalel>
  400b7c:	2a0003e1 	mov	w1, w0
  400b80:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400b84:	91183000 	add	x0, x0, #0x60c
  400b88:	b9000001 	str	w1, [x0]
  400b8c:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400b90:	9117f000 	add	x0, x0, #0x5fc
  400b94:	b9400001 	ldr	w1, [x0]
  400b98:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400b9c:	91168000 	add	x0, x0, #0x5a0
  400ba0:	b9400000 	ldr	w0, [x0]
  400ba4:	0b000021 	add	w1, w1, w0
  400ba8:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400bac:	9117b000 	add	x0, x0, #0x5ec
  400bb0:	b9000001 	str	w1, [x0]
  400bb4:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400bb8:	9117f000 	add	x0, x0, #0x5fc
  400bbc:	b9400003 	ldr	w3, [x0]
  400bc0:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400bc4:	9116c002 	add	x2, x0, #0x5b0
  400bc8:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400bcc:	91172001 	add	x1, x0, #0x5c8
  400bd0:	2a0303e0 	mov	w0, w3
  400bd4:	94000506 	bl	401fec <upzero>
  400bd8:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400bdc:	91179000 	add	x0, x0, #0x5e4
  400be0:	b9400005 	ldr	w5, [x0]
  400be4:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400be8:	9117a000 	add	x0, x0, #0x5e8
  400bec:	b9400001 	ldr	w1, [x0]
  400bf0:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400bf4:	9117b000 	add	x0, x0, #0x5ec
  400bf8:	b9400002 	ldr	w2, [x0]
  400bfc:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400c00:	9117c000 	add	x0, x0, #0x5f0
  400c04:	b9400003 	ldr	w3, [x0]
  400c08:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400c0c:	9117d000 	add	x0, x0, #0x5f4
  400c10:	b9400000 	ldr	w0, [x0]
  400c14:	2a0003e4 	mov	w4, w0
  400c18:	2a0503e0 	mov	w0, w5
  400c1c:	94000558 	bl	40217c <uppol2>
  400c20:	2a0003e1 	mov	w1, w0
  400c24:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400c28:	9117a000 	add	x0, x0, #0x5e8
  400c2c:	b9000001 	str	w1, [x0]
  400c30:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400c34:	91179000 	add	x0, x0, #0x5e4
  400c38:	b9400004 	ldr	w4, [x0]
  400c3c:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400c40:	9117a000 	add	x0, x0, #0x5e8
  400c44:	b9400001 	ldr	w1, [x0]
  400c48:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400c4c:	9117b000 	add	x0, x0, #0x5ec
  400c50:	b9400002 	ldr	w2, [x0]
  400c54:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400c58:	9117c000 	add	x0, x0, #0x5f0
  400c5c:	b9400000 	ldr	w0, [x0]
  400c60:	2a0003e3 	mov	w3, w0
  400c64:	2a0403e0 	mov	w0, w4
  400c68:	9400057b 	bl	402254 <uppol1>
  400c6c:	2a0003e1 	mov	w1, w0
  400c70:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400c74:	91179000 	add	x0, x0, #0x5e4
  400c78:	b9000001 	str	w1, [x0]
  400c7c:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400c80:	9116a000 	add	x0, x0, #0x5a8
  400c84:	b9400001 	ldr	w1, [x0]
  400c88:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400c8c:	9117f000 	add	x0, x0, #0x5fc
  400c90:	b9400000 	ldr	w0, [x0]
  400c94:	0b000021 	add	w1, w1, w0
  400c98:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400c9c:	91180000 	add	x0, x0, #0x600
  400ca0:	b9000001 	str	w1, [x0]
  400ca4:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400ca8:	91181000 	add	x0, x0, #0x604
  400cac:	b9400001 	ldr	w1, [x0]
  400cb0:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400cb4:	91182000 	add	x0, x0, #0x608
  400cb8:	b9000001 	str	w1, [x0]
  400cbc:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400cc0:	91180000 	add	x0, x0, #0x600
  400cc4:	b9400001 	ldr	w1, [x0]
  400cc8:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400ccc:	91181000 	add	x0, x0, #0x604
  400cd0:	b9000001 	str	w1, [x0]
  400cd4:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400cd8:	9117c000 	add	x0, x0, #0x5f0
  400cdc:	b9400001 	ldr	w1, [x0]
  400ce0:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400ce4:	9117d000 	add	x0, x0, #0x5f4
  400ce8:	b9000001 	str	w1, [x0]
  400cec:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400cf0:	9117b000 	add	x0, x0, #0x5ec
  400cf4:	b9400001 	ldr	w1, [x0]
  400cf8:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400cfc:	9117c000 	add	x0, x0, #0x5f0
  400d00:	b9000001 	str	w1, [x0]
  400d04:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400d08:	91190001 	add	x1, x0, #0x640
  400d0c:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400d10:	91196000 	add	x0, x0, #0x658
  400d14:	94000409 	bl	401d38 <filtez>
  400d18:	2a0003e1 	mov	w1, w0
  400d1c:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400d20:	9118a000 	add	x0, x0, #0x628
  400d24:	b9000001 	str	w1, [x0]
  400d28:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400d2c:	911a0000 	add	x0, x0, #0x680
  400d30:	b9400004 	ldr	w4, [x0]
  400d34:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400d38:	9119c000 	add	x0, x0, #0x670
  400d3c:	b9400001 	ldr	w1, [x0]
  400d40:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400d44:	911a1000 	add	x0, x0, #0x684
  400d48:	b9400002 	ldr	w2, [x0]
  400d4c:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400d50:	9119d000 	add	x0, x0, #0x674
  400d54:	b9400000 	ldr	w0, [x0]
  400d58:	2a0003e3 	mov	w3, w0
  400d5c:	2a0403e0 	mov	w0, w4
  400d60:	94000420 	bl	401de0 <filtep>
  400d64:	2a0003e1 	mov	w1, w0
  400d68:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400d6c:	9118b000 	add	x0, x0, #0x62c
  400d70:	b9000001 	str	w1, [x0]
  400d74:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400d78:	9118b000 	add	x0, x0, #0x62c
  400d7c:	b9400001 	ldr	w1, [x0]
  400d80:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400d84:	9118a000 	add	x0, x0, #0x628
  400d88:	b9400000 	ldr	w0, [x0]
  400d8c:	0b000021 	add	w1, w1, w0
  400d90:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400d94:	91185000 	add	x0, x0, #0x614
  400d98:	b9000001 	str	w1, [x0]
  400d9c:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400da0:	9114b000 	add	x0, x0, #0x52c
  400da4:	b9400001 	ldr	w1, [x0]
  400da8:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400dac:	91185000 	add	x0, x0, #0x614
  400db0:	b9400000 	ldr	w0, [x0]
  400db4:	4b000021 	sub	w1, w1, w0
  400db8:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400dbc:	91186000 	add	x0, x0, #0x618
  400dc0:	b9000001 	str	w1, [x0]
  400dc4:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400dc8:	91186000 	add	x0, x0, #0x618
  400dcc:	b9400000 	ldr	w0, [x0]
  400dd0:	7100001f 	cmp	w0, #0x0
  400dd4:	540000cb 	b.lt	400dec <encode+0x624>  // b.tstop
  400dd8:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400ddc:	91188000 	add	x0, x0, #0x620
  400de0:	52800061 	mov	w1, #0x3                   	// #3
  400de4:	b9000001 	str	w1, [x0]
  400de8:	14000005 	b	400dfc <encode+0x634>
  400dec:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400df0:	91188000 	add	x0, x0, #0x620
  400df4:	52800021 	mov	w1, #0x1                   	// #1
  400df8:	b9000001 	str	w1, [x0]
  400dfc:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400e00:	91184000 	add	x0, x0, #0x610
  400e04:	b9400000 	ldr	w0, [x0]
  400e08:	93407c01 	sxtw	x1, w0
  400e0c:	d2804680 	mov	x0, #0x234                 	// #564
  400e10:	9b007c20 	mul	x0, x1, x0
  400e14:	934cfc00 	asr	x0, x0, #12
  400e18:	b9002fe0 	str	w0, [sp, #44]
  400e1c:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400e20:	91186000 	add	x0, x0, #0x618
  400e24:	b9400000 	ldr	w0, [x0]
  400e28:	97fffdf7 	bl	400604 <my_abs>
  400e2c:	2a0003e1 	mov	w1, w0
  400e30:	b9402fe0 	ldr	w0, [sp, #44]
  400e34:	6b01001f 	cmp	w0, w1
  400e38:	5400010a 	b.ge	400e58 <encode+0x690>  // b.tcont
  400e3c:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400e40:	91188000 	add	x0, x0, #0x620
  400e44:	b9400000 	ldr	w0, [x0]
  400e48:	51000401 	sub	w1, w0, #0x1
  400e4c:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400e50:	91188000 	add	x0, x0, #0x620
  400e54:	b9000001 	str	w1, [x0]
  400e58:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400e5c:	91184000 	add	x0, x0, #0x610
  400e60:	b9400000 	ldr	w0, [x0]
  400e64:	93407c01 	sxtw	x1, w0
  400e68:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400e6c:	91188000 	add	x0, x0, #0x620
  400e70:	b9400002 	ldr	w2, [x0]
  400e74:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400e78:	91128000 	add	x0, x0, #0x4a0
  400e7c:	93407c42 	sxtw	x2, w2
  400e80:	b8627800 	ldr	w0, [x0, x2, lsl #2]
  400e84:	93407c00 	sxtw	x0, w0
  400e88:	9b007c20 	mul	x0, x1, x0
  400e8c:	934ffc00 	asr	x0, x0, #15
  400e90:	2a0003e1 	mov	w1, w0
  400e94:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400e98:	91187000 	add	x0, x0, #0x61c
  400e9c:	b9000001 	str	w1, [x0]
  400ea0:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400ea4:	91188000 	add	x0, x0, #0x620
  400ea8:	b9400002 	ldr	w2, [x0]
  400eac:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400eb0:	91189000 	add	x0, x0, #0x624
  400eb4:	b9400000 	ldr	w0, [x0]
  400eb8:	2a0003e1 	mov	w1, w0
  400ebc:	2a0203e0 	mov	w0, w2
  400ec0:	94000511 	bl	402304 <logsch>
  400ec4:	2a0003e1 	mov	w1, w0
  400ec8:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400ecc:	91189000 	add	x0, x0, #0x624
  400ed0:	b9000001 	str	w1, [x0]
  400ed4:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400ed8:	91189000 	add	x0, x0, #0x624
  400edc:	b9400000 	ldr	w0, [x0]
  400ee0:	52800141 	mov	w1, #0xa                   	// #10
  400ee4:	9400042a 	bl	401f8c <scalel>
  400ee8:	2a0003e1 	mov	w1, w0
  400eec:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400ef0:	91184000 	add	x0, x0, #0x610
  400ef4:	b9000001 	str	w1, [x0]
  400ef8:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400efc:	91187000 	add	x0, x0, #0x61c
  400f00:	b9400001 	ldr	w1, [x0]
  400f04:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400f08:	9118a000 	add	x0, x0, #0x628
  400f0c:	b9400000 	ldr	w0, [x0]
  400f10:	0b000021 	add	w1, w1, w0
  400f14:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400f18:	9118c000 	add	x0, x0, #0x630
  400f1c:	b9000001 	str	w1, [x0]
  400f20:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400f24:	91187000 	add	x0, x0, #0x61c
  400f28:	b9400003 	ldr	w3, [x0]
  400f2c:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400f30:	91196002 	add	x2, x0, #0x658
  400f34:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400f38:	91190001 	add	x1, x0, #0x640
  400f3c:	2a0303e0 	mov	w0, w3
  400f40:	9400042b 	bl	401fec <upzero>
  400f44:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400f48:	9119c000 	add	x0, x0, #0x670
  400f4c:	b9400005 	ldr	w5, [x0]
  400f50:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400f54:	9119d000 	add	x0, x0, #0x674
  400f58:	b9400001 	ldr	w1, [x0]
  400f5c:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400f60:	9118c000 	add	x0, x0, #0x630
  400f64:	b9400002 	ldr	w2, [x0]
  400f68:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400f6c:	9119e000 	add	x0, x0, #0x678
  400f70:	b9400003 	ldr	w3, [x0]
  400f74:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400f78:	9119f000 	add	x0, x0, #0x67c
  400f7c:	b9400000 	ldr	w0, [x0]
  400f80:	2a0003e4 	mov	w4, w0
  400f84:	2a0503e0 	mov	w0, w5
  400f88:	9400047d 	bl	40217c <uppol2>
  400f8c:	2a0003e1 	mov	w1, w0
  400f90:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400f94:	9119d000 	add	x0, x0, #0x674
  400f98:	b9000001 	str	w1, [x0]
  400f9c:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400fa0:	9119c000 	add	x0, x0, #0x670
  400fa4:	b9400004 	ldr	w4, [x0]
  400fa8:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400fac:	9119d000 	add	x0, x0, #0x674
  400fb0:	b9400001 	ldr	w1, [x0]
  400fb4:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400fb8:	9118c000 	add	x0, x0, #0x630
  400fbc:	b9400002 	ldr	w2, [x0]
  400fc0:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400fc4:	9119e000 	add	x0, x0, #0x678
  400fc8:	b9400000 	ldr	w0, [x0]
  400fcc:	2a0003e3 	mov	w3, w0
  400fd0:	2a0403e0 	mov	w0, w4
  400fd4:	940004a0 	bl	402254 <uppol1>
  400fd8:	2a0003e1 	mov	w1, w0
  400fdc:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400fe0:	9119c000 	add	x0, x0, #0x670
  400fe4:	b9000001 	str	w1, [x0]
  400fe8:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400fec:	91185000 	add	x0, x0, #0x614
  400ff0:	b9400001 	ldr	w1, [x0]
  400ff4:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400ff8:	91187000 	add	x0, x0, #0x61c
  400ffc:	b9400000 	ldr	w0, [x0]
  401000:	0b000021 	add	w1, w1, w0
  401004:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401008:	9118d000 	add	x0, x0, #0x634
  40100c:	b9000001 	str	w1, [x0]
  401010:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401014:	911a0000 	add	x0, x0, #0x680
  401018:	b9400001 	ldr	w1, [x0]
  40101c:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401020:	911a1000 	add	x0, x0, #0x684
  401024:	b9000001 	str	w1, [x0]
  401028:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  40102c:	9118d000 	add	x0, x0, #0x634
  401030:	b9400001 	ldr	w1, [x0]
  401034:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401038:	911a0000 	add	x0, x0, #0x680
  40103c:	b9000001 	str	w1, [x0]
  401040:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401044:	9119e000 	add	x0, x0, #0x678
  401048:	b9400001 	ldr	w1, [x0]
  40104c:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401050:	9119f000 	add	x0, x0, #0x67c
  401054:	b9000001 	str	w1, [x0]
  401058:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  40105c:	9118c000 	add	x0, x0, #0x630
  401060:	b9400001 	ldr	w1, [x0]
  401064:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401068:	9119e000 	add	x0, x0, #0x678
  40106c:	b9000001 	str	w1, [x0]
  401070:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401074:	91188000 	add	x0, x0, #0x620
  401078:	b9400000 	ldr	w0, [x0]
  40107c:	531a6401 	lsl	w1, w0, #6
  401080:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401084:	91167000 	add	x0, x0, #0x59c
  401088:	b9400000 	ldr	w0, [x0]
  40108c:	2a000020 	orr	w0, w1, w0
  401090:	a8c67bfd 	ldp	x29, x30, [sp], #96
  401094:	d65f03c0 	ret

0000000000401098 <decode>:
  401098:	a9ba7bfd 	stp	x29, x30, [sp, #-96]!
  40109c:	910003fd 	mov	x29, sp
  4010a0:	b9001fe0 	str	w0, [sp, #28]
  4010a4:	b9401fe0 	ldr	w0, [sp, #28]
  4010a8:	12001401 	and	w1, w0, #0x3f
  4010ac:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4010b0:	911a2000 	add	x0, x0, #0x688
  4010b4:	b9000001 	str	w1, [x0]
  4010b8:	b9401fe0 	ldr	w0, [sp, #28]
  4010bc:	13067c01 	asr	w1, w0, #6
  4010c0:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4010c4:	91188000 	add	x0, x0, #0x620
  4010c8:	b9000001 	str	w1, [x0]
  4010cc:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4010d0:	911ae001 	add	x1, x0, #0x6b8
  4010d4:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4010d8:	911a8000 	add	x0, x0, #0x6a0
  4010dc:	94000317 	bl	401d38 <filtez>
  4010e0:	2a0003e1 	mov	w1, w0
  4010e4:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4010e8:	911b7000 	add	x0, x0, #0x6dc
  4010ec:	b9000001 	str	w1, [x0]
  4010f0:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4010f4:	911ba000 	add	x0, x0, #0x6e8
  4010f8:	b9400004 	ldr	w4, [x0]
  4010fc:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401100:	911bd000 	add	x0, x0, #0x6f4
  401104:	b9400001 	ldr	w1, [x0]
  401108:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  40110c:	911bb000 	add	x0, x0, #0x6ec
  401110:	b9400002 	ldr	w2, [x0]
  401114:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401118:	911be000 	add	x0, x0, #0x6f8
  40111c:	b9400000 	ldr	w0, [x0]
  401120:	2a0003e3 	mov	w3, w0
  401124:	2a0403e0 	mov	w0, w4
  401128:	9400032e 	bl	401de0 <filtep>
  40112c:	2a0003e1 	mov	w1, w0
  401130:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401134:	911b8000 	add	x0, x0, #0x6e0
  401138:	b9000001 	str	w1, [x0]
  40113c:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401140:	911b8000 	add	x0, x0, #0x6e0
  401144:	b9400001 	ldr	w1, [x0]
  401148:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  40114c:	911b7000 	add	x0, x0, #0x6dc
  401150:	b9400000 	ldr	w0, [x0]
  401154:	0b000021 	add	w1, w1, w0
  401158:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  40115c:	911b9000 	add	x0, x0, #0x6e4
  401160:	b9000001 	str	w1, [x0]
  401164:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401168:	911a6000 	add	x0, x0, #0x698
  40116c:	b9400000 	ldr	w0, [x0]
  401170:	93407c01 	sxtw	x1, w0
  401174:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401178:	911a2000 	add	x0, x0, #0x688
  40117c:	b9400000 	ldr	w0, [x0]
  401180:	13027c02 	asr	w2, w0, #2
  401184:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401188:	91022000 	add	x0, x0, #0x88
  40118c:	93407c42 	sxtw	x2, w2
  401190:	b8627800 	ldr	w0, [x0, x2, lsl #2]
  401194:	93407c00 	sxtw	x0, w0
  401198:	9b007c20 	mul	x0, x1, x0
  40119c:	934ffc00 	asr	x0, x0, #15
  4011a0:	2a0003e1 	mov	w1, w0
  4011a4:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4011a8:	911a7000 	add	x0, x0, #0x69c
  4011ac:	b9000001 	str	w1, [x0]
  4011b0:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4011b4:	911a6000 	add	x0, x0, #0x698
  4011b8:	b9400000 	ldr	w0, [x0]
  4011bc:	93407c01 	sxtw	x1, w0
  4011c0:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4011c4:	91167000 	add	x0, x0, #0x59c
  4011c8:	b9400002 	ldr	w2, [x0]
  4011cc:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4011d0:	91052000 	add	x0, x0, #0x148
  4011d4:	93407c42 	sxtw	x2, w2
  4011d8:	b8627800 	ldr	w0, [x0, x2, lsl #2]
  4011dc:	93407c00 	sxtw	x0, w0
  4011e0:	9b007c20 	mul	x0, x1, x0
  4011e4:	934ffc00 	asr	x0, x0, #15
  4011e8:	2a0003e1 	mov	w1, w0
  4011ec:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4011f0:	911bf000 	add	x0, x0, #0x6fc
  4011f4:	b9000001 	str	w1, [x0]
  4011f8:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4011fc:	911bf000 	add	x0, x0, #0x6fc
  401200:	b9400001 	ldr	w1, [x0]
  401204:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401208:	911b9000 	add	x0, x0, #0x6e4
  40120c:	b9400000 	ldr	w0, [x0]
  401210:	0b000021 	add	w1, w1, w0
  401214:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401218:	911a4000 	add	x0, x0, #0x690
  40121c:	b9000001 	str	w1, [x0]
  401220:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401224:	911a2000 	add	x0, x0, #0x688
  401228:	b9400002 	ldr	w2, [x0]
  40122c:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401230:	911c0000 	add	x0, x0, #0x700
  401234:	b9400000 	ldr	w0, [x0]
  401238:	2a0003e1 	mov	w1, w0
  40123c:	2a0203e0 	mov	w0, w2
  401240:	94000333 	bl	401f0c <logscl>
  401244:	2a0003e1 	mov	w1, w0
  401248:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  40124c:	911c0000 	add	x0, x0, #0x700
  401250:	b9000001 	str	w1, [x0]
  401254:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401258:	911c0000 	add	x0, x0, #0x700
  40125c:	b9400000 	ldr	w0, [x0]
  401260:	52800101 	mov	w1, #0x8                   	// #8
  401264:	9400034a 	bl	401f8c <scalel>
  401268:	2a0003e1 	mov	w1, w0
  40126c:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401270:	911a6000 	add	x0, x0, #0x698
  401274:	b9000001 	str	w1, [x0]
  401278:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  40127c:	911a7000 	add	x0, x0, #0x69c
  401280:	b9400001 	ldr	w1, [x0]
  401284:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401288:	911b7000 	add	x0, x0, #0x6dc
  40128c:	b9400000 	ldr	w0, [x0]
  401290:	0b000021 	add	w1, w1, w0
  401294:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401298:	911b4000 	add	x0, x0, #0x6d0
  40129c:	b9000001 	str	w1, [x0]
  4012a0:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4012a4:	911a7000 	add	x0, x0, #0x69c
  4012a8:	b9400003 	ldr	w3, [x0]
  4012ac:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4012b0:	911a8002 	add	x2, x0, #0x6a0
  4012b4:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4012b8:	911ae001 	add	x1, x0, #0x6b8
  4012bc:	2a0303e0 	mov	w0, w3
  4012c0:	9400034b 	bl	401fec <upzero>
  4012c4:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4012c8:	911bd000 	add	x0, x0, #0x6f4
  4012cc:	b9400005 	ldr	w5, [x0]
  4012d0:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4012d4:	911be000 	add	x0, x0, #0x6f8
  4012d8:	b9400001 	ldr	w1, [x0]
  4012dc:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4012e0:	911b4000 	add	x0, x0, #0x6d0
  4012e4:	b9400002 	ldr	w2, [x0]
  4012e8:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4012ec:	911b5000 	add	x0, x0, #0x6d4
  4012f0:	b9400003 	ldr	w3, [x0]
  4012f4:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4012f8:	911b6000 	add	x0, x0, #0x6d8
  4012fc:	b9400000 	ldr	w0, [x0]
  401300:	2a0003e4 	mov	w4, w0
  401304:	2a0503e0 	mov	w0, w5
  401308:	9400039d 	bl	40217c <uppol2>
  40130c:	2a0003e1 	mov	w1, w0
  401310:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401314:	911be000 	add	x0, x0, #0x6f8
  401318:	b9000001 	str	w1, [x0]
  40131c:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401320:	911bd000 	add	x0, x0, #0x6f4
  401324:	b9400004 	ldr	w4, [x0]
  401328:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  40132c:	911be000 	add	x0, x0, #0x6f8
  401330:	b9400001 	ldr	w1, [x0]
  401334:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401338:	911b4000 	add	x0, x0, #0x6d0
  40133c:	b9400002 	ldr	w2, [x0]
  401340:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401344:	911b5000 	add	x0, x0, #0x6d4
  401348:	b9400000 	ldr	w0, [x0]
  40134c:	2a0003e3 	mov	w3, w0
  401350:	2a0403e0 	mov	w0, w4
  401354:	940003c0 	bl	402254 <uppol1>
  401358:	2a0003e1 	mov	w1, w0
  40135c:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401360:	911bd000 	add	x0, x0, #0x6f4
  401364:	b9000001 	str	w1, [x0]
  401368:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  40136c:	911b9000 	add	x0, x0, #0x6e4
  401370:	b9400001 	ldr	w1, [x0]
  401374:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401378:	911a7000 	add	x0, x0, #0x69c
  40137c:	b9400000 	ldr	w0, [x0]
  401380:	0b000021 	add	w1, w1, w0
  401384:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401388:	911bc000 	add	x0, x0, #0x6f0
  40138c:	b9000001 	str	w1, [x0]
  401390:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401394:	911ba000 	add	x0, x0, #0x6e8
  401398:	b9400001 	ldr	w1, [x0]
  40139c:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4013a0:	911bb000 	add	x0, x0, #0x6ec
  4013a4:	b9000001 	str	w1, [x0]
  4013a8:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4013ac:	911bc000 	add	x0, x0, #0x6f0
  4013b0:	b9400001 	ldr	w1, [x0]
  4013b4:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4013b8:	911ba000 	add	x0, x0, #0x6e8
  4013bc:	b9000001 	str	w1, [x0]
  4013c0:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4013c4:	911b5000 	add	x0, x0, #0x6d4
  4013c8:	b9400001 	ldr	w1, [x0]
  4013cc:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4013d0:	911b6000 	add	x0, x0, #0x6d8
  4013d4:	b9000001 	str	w1, [x0]
  4013d8:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4013dc:	911b4000 	add	x0, x0, #0x6d0
  4013e0:	b9400001 	ldr	w1, [x0]
  4013e4:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4013e8:	911b5000 	add	x0, x0, #0x6d4
  4013ec:	b9000001 	str	w1, [x0]
  4013f0:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4013f4:	911ca001 	add	x1, x0, #0x728
  4013f8:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4013fc:	911c4000 	add	x0, x0, #0x710
  401400:	9400024e 	bl	401d38 <filtez>
  401404:	2a0003e1 	mov	w1, w0
  401408:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  40140c:	911d0000 	add	x0, x0, #0x740
  401410:	b9000001 	str	w1, [x0]
  401414:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401418:	911d1000 	add	x0, x0, #0x744
  40141c:	b9400004 	ldr	w4, [x0]
  401420:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401424:	911d3000 	add	x0, x0, #0x74c
  401428:	b9400001 	ldr	w1, [x0]
  40142c:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401430:	911d2000 	add	x0, x0, #0x748
  401434:	b9400002 	ldr	w2, [x0]
  401438:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  40143c:	911d4000 	add	x0, x0, #0x750
  401440:	b9400000 	ldr	w0, [x0]
  401444:	2a0003e3 	mov	w3, w0
  401448:	2a0403e0 	mov	w0, w4
  40144c:	94000265 	bl	401de0 <filtep>
  401450:	2a0003e1 	mov	w1, w0
  401454:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401458:	911d6000 	add	x0, x0, #0x758
  40145c:	b9000001 	str	w1, [x0]
  401460:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401464:	911d6000 	add	x0, x0, #0x758
  401468:	b9400001 	ldr	w1, [x0]
  40146c:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401470:	911d0000 	add	x0, x0, #0x740
  401474:	b9400000 	ldr	w0, [x0]
  401478:	0b000021 	add	w1, w1, w0
  40147c:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401480:	911d7000 	add	x0, x0, #0x75c
  401484:	b9000001 	str	w1, [x0]
  401488:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  40148c:	911a5000 	add	x0, x0, #0x694
  401490:	b9400000 	ldr	w0, [x0]
  401494:	93407c01 	sxtw	x1, w0
  401498:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  40149c:	91188000 	add	x0, x0, #0x620
  4014a0:	b9400002 	ldr	w2, [x0]
  4014a4:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4014a8:	91128000 	add	x0, x0, #0x4a0
  4014ac:	93407c42 	sxtw	x2, w2
  4014b0:	b8627800 	ldr	w0, [x0, x2, lsl #2]
  4014b4:	93407c00 	sxtw	x0, w0
  4014b8:	9b007c20 	mul	x0, x1, x0
  4014bc:	934ffc00 	asr	x0, x0, #15
  4014c0:	2a0003e1 	mov	w1, w0
  4014c4:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4014c8:	911c2000 	add	x0, x0, #0x708
  4014cc:	b9000001 	str	w1, [x0]
  4014d0:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4014d4:	91188000 	add	x0, x0, #0x620
  4014d8:	b9400002 	ldr	w2, [x0]
  4014dc:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4014e0:	911c3000 	add	x0, x0, #0x70c
  4014e4:	b9400000 	ldr	w0, [x0]
  4014e8:	2a0003e1 	mov	w1, w0
  4014ec:	2a0203e0 	mov	w0, w2
  4014f0:	94000385 	bl	402304 <logsch>
  4014f4:	2a0003e1 	mov	w1, w0
  4014f8:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4014fc:	911c3000 	add	x0, x0, #0x70c
  401500:	b9000001 	str	w1, [x0]
  401504:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401508:	911c3000 	add	x0, x0, #0x70c
  40150c:	b9400000 	ldr	w0, [x0]
  401510:	52800141 	mov	w1, #0xa                   	// #10
  401514:	9400029e 	bl	401f8c <scalel>
  401518:	2a0003e1 	mov	w1, w0
  40151c:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401520:	911a5000 	add	x0, x0, #0x694
  401524:	b9000001 	str	w1, [x0]
  401528:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  40152c:	911c2000 	add	x0, x0, #0x708
  401530:	b9400001 	ldr	w1, [x0]
  401534:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401538:	911d0000 	add	x0, x0, #0x740
  40153c:	b9400000 	ldr	w0, [x0]
  401540:	0b000021 	add	w1, w1, w0
  401544:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401548:	911d5000 	add	x0, x0, #0x754
  40154c:	b9000001 	str	w1, [x0]
  401550:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401554:	911c2000 	add	x0, x0, #0x708
  401558:	b9400003 	ldr	w3, [x0]
  40155c:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401560:	911c4002 	add	x2, x0, #0x710
  401564:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401568:	911ca001 	add	x1, x0, #0x728
  40156c:	2a0303e0 	mov	w0, w3
  401570:	9400029f 	bl	401fec <upzero>
  401574:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401578:	911d3000 	add	x0, x0, #0x74c
  40157c:	b9400005 	ldr	w5, [x0]
  401580:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401584:	911d4000 	add	x0, x0, #0x750
  401588:	b9400001 	ldr	w1, [x0]
  40158c:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401590:	911d5000 	add	x0, x0, #0x754
  401594:	b9400002 	ldr	w2, [x0]
  401598:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  40159c:	911d9000 	add	x0, x0, #0x764
  4015a0:	b9400003 	ldr	w3, [x0]
  4015a4:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4015a8:	911da000 	add	x0, x0, #0x768
  4015ac:	b9400000 	ldr	w0, [x0]
  4015b0:	2a0003e4 	mov	w4, w0
  4015b4:	2a0503e0 	mov	w0, w5
  4015b8:	940002f1 	bl	40217c <uppol2>
  4015bc:	2a0003e1 	mov	w1, w0
  4015c0:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4015c4:	911d4000 	add	x0, x0, #0x750
  4015c8:	b9000001 	str	w1, [x0]
  4015cc:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4015d0:	911d3000 	add	x0, x0, #0x74c
  4015d4:	b9400004 	ldr	w4, [x0]
  4015d8:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4015dc:	911d4000 	add	x0, x0, #0x750
  4015e0:	b9400001 	ldr	w1, [x0]
  4015e4:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4015e8:	911d5000 	add	x0, x0, #0x754
  4015ec:	b9400002 	ldr	w2, [x0]
  4015f0:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4015f4:	911d9000 	add	x0, x0, #0x764
  4015f8:	b9400000 	ldr	w0, [x0]
  4015fc:	2a0003e3 	mov	w3, w0
  401600:	2a0403e0 	mov	w0, w4
  401604:	94000314 	bl	402254 <uppol1>
  401608:	2a0003e1 	mov	w1, w0
  40160c:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401610:	911d3000 	add	x0, x0, #0x74c
  401614:	b9000001 	str	w1, [x0]
  401618:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  40161c:	911d7000 	add	x0, x0, #0x75c
  401620:	b9400001 	ldr	w1, [x0]
  401624:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401628:	911c2000 	add	x0, x0, #0x708
  40162c:	b9400000 	ldr	w0, [x0]
  401630:	0b000021 	add	w1, w1, w0
  401634:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401638:	9118e000 	add	x0, x0, #0x638
  40163c:	b9000001 	str	w1, [x0]
  401640:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401644:	911d1000 	add	x0, x0, #0x744
  401648:	b9400001 	ldr	w1, [x0]
  40164c:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401650:	911d2000 	add	x0, x0, #0x748
  401654:	b9000001 	str	w1, [x0]
  401658:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  40165c:	9118e000 	add	x0, x0, #0x638
  401660:	b9400001 	ldr	w1, [x0]
  401664:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401668:	911d1000 	add	x0, x0, #0x744
  40166c:	b9000001 	str	w1, [x0]
  401670:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401674:	911d9000 	add	x0, x0, #0x764
  401678:	b9400001 	ldr	w1, [x0]
  40167c:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401680:	911da000 	add	x0, x0, #0x768
  401684:	b9000001 	str	w1, [x0]
  401688:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  40168c:	911d5000 	add	x0, x0, #0x754
  401690:	b9400001 	ldr	w1, [x0]
  401694:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401698:	911d9000 	add	x0, x0, #0x764
  40169c:	b9000001 	str	w1, [x0]
  4016a0:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4016a4:	911a4000 	add	x0, x0, #0x690
  4016a8:	b9400001 	ldr	w1, [x0]
  4016ac:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4016b0:	9118e000 	add	x0, x0, #0x638
  4016b4:	b9400000 	ldr	w0, [x0]
  4016b8:	4b000021 	sub	w1, w1, w0
  4016bc:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4016c0:	91166000 	add	x0, x0, #0x598
  4016c4:	b9000001 	str	w1, [x0]
  4016c8:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4016cc:	911a4000 	add	x0, x0, #0x690
  4016d0:	b9400001 	ldr	w1, [x0]
  4016d4:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4016d8:	9118e000 	add	x0, x0, #0x638
  4016dc:	b9400000 	ldr	w0, [x0]
  4016e0:	0b000021 	add	w1, w1, w0
  4016e4:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4016e8:	91165000 	add	x0, x0, #0x594
  4016ec:	b9000001 	str	w1, [x0]
  4016f0:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4016f4:	9100a000 	add	x0, x0, #0x28
  4016f8:	f90023e0 	str	x0, [sp, #64]
  4016fc:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401700:	9114c000 	add	x0, x0, #0x530
  401704:	f9001fe0 	str	x0, [sp, #56]
  401708:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  40170c:	91158000 	add	x0, x0, #0x560
  401710:	f90017e0 	str	x0, [sp, #40]
  401714:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401718:	91166000 	add	x0, x0, #0x598
  40171c:	b9400000 	ldr	w0, [x0]
  401720:	93407c01 	sxtw	x1, w0
  401724:	f94023e0 	ldr	x0, [sp, #64]
  401728:	91001002 	add	x2, x0, #0x4
  40172c:	f90023e2 	str	x2, [sp, #64]
  401730:	b9400000 	ldr	w0, [x0]
  401734:	93407c00 	sxtw	x0, w0
  401738:	9b007c20 	mul	x0, x1, x0
  40173c:	f9002be0 	str	x0, [sp, #80]
  401740:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401744:	91165000 	add	x0, x0, #0x594
  401748:	b9400000 	ldr	w0, [x0]
  40174c:	93407c01 	sxtw	x1, w0
  401750:	f94023e0 	ldr	x0, [sp, #64]
  401754:	91001002 	add	x2, x0, #0x4
  401758:	f90023e2 	str	x2, [sp, #64]
  40175c:	b9400000 	ldr	w0, [x0]
  401760:	93407c00 	sxtw	x0, w0
  401764:	9b007c20 	mul	x0, x1, x0
  401768:	f90027e0 	str	x0, [sp, #72]
  40176c:	b9005fff 	str	wzr, [sp, #92]
  401770:	14000020 	b	4017f0 <decode+0x758>
  401774:	f9401fe0 	ldr	x0, [sp, #56]
  401778:	91001001 	add	x1, x0, #0x4
  40177c:	f9001fe1 	str	x1, [sp, #56]
  401780:	b9400000 	ldr	w0, [x0]
  401784:	93407c01 	sxtw	x1, w0
  401788:	f94023e0 	ldr	x0, [sp, #64]
  40178c:	91001002 	add	x2, x0, #0x4
  401790:	f90023e2 	str	x2, [sp, #64]
  401794:	b9400000 	ldr	w0, [x0]
  401798:	93407c00 	sxtw	x0, w0
  40179c:	9b007c20 	mul	x0, x1, x0
  4017a0:	f9402be1 	ldr	x1, [sp, #80]
  4017a4:	8b000020 	add	x0, x1, x0
  4017a8:	f9002be0 	str	x0, [sp, #80]
  4017ac:	f94017e0 	ldr	x0, [sp, #40]
  4017b0:	91001001 	add	x1, x0, #0x4
  4017b4:	f90017e1 	str	x1, [sp, #40]
  4017b8:	b9400000 	ldr	w0, [x0]
  4017bc:	93407c01 	sxtw	x1, w0
  4017c0:	f94023e0 	ldr	x0, [sp, #64]
  4017c4:	91001002 	add	x2, x0, #0x4
  4017c8:	f90023e2 	str	x2, [sp, #64]
  4017cc:	b9400000 	ldr	w0, [x0]
  4017d0:	93407c00 	sxtw	x0, w0
  4017d4:	9b007c20 	mul	x0, x1, x0
  4017d8:	f94027e1 	ldr	x1, [sp, #72]
  4017dc:	8b000020 	add	x0, x1, x0
  4017e0:	f90027e0 	str	x0, [sp, #72]
  4017e4:	b9405fe0 	ldr	w0, [sp, #92]
  4017e8:	11000400 	add	w0, w0, #0x1
  4017ec:	b9005fe0 	str	w0, [sp, #92]
  4017f0:	b9405fe0 	ldr	w0, [sp, #92]
  4017f4:	7100241f 	cmp	w0, #0x9
  4017f8:	54fffbed 	b.le	401774 <decode+0x6dc>
  4017fc:	f9401fe0 	ldr	x0, [sp, #56]
  401800:	b9400000 	ldr	w0, [x0]
  401804:	93407c01 	sxtw	x1, w0
  401808:	f94023e0 	ldr	x0, [sp, #64]
  40180c:	91001002 	add	x2, x0, #0x4
  401810:	f90023e2 	str	x2, [sp, #64]
  401814:	b9400000 	ldr	w0, [x0]
  401818:	93407c00 	sxtw	x0, w0
  40181c:	9b007c20 	mul	x0, x1, x0
  401820:	f9402be1 	ldr	x1, [sp, #80]
  401824:	8b000020 	add	x0, x1, x0
  401828:	f9002be0 	str	x0, [sp, #80]
  40182c:	f94017e0 	ldr	x0, [sp, #40]
  401830:	b9400000 	ldr	w0, [x0]
  401834:	93407c01 	sxtw	x1, w0
  401838:	f94023e0 	ldr	x0, [sp, #64]
  40183c:	91001002 	add	x2, x0, #0x4
  401840:	f90023e2 	str	x2, [sp, #64]
  401844:	b9400000 	ldr	w0, [x0]
  401848:	93407c00 	sxtw	x0, w0
  40184c:	9b007c20 	mul	x0, x1, x0
  401850:	f94027e1 	ldr	x1, [sp, #72]
  401854:	8b000020 	add	x0, x1, x0
  401858:	f90027e0 	str	x0, [sp, #72]
  40185c:	f9402be0 	ldr	x0, [sp, #80]
  401860:	934efc00 	asr	x0, x0, #14
  401864:	2a0003e1 	mov	w1, w0
  401868:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  40186c:	91163000 	add	x0, x0, #0x58c
  401870:	b9000001 	str	w1, [x0]
  401874:	f94027e0 	ldr	x0, [sp, #72]
  401878:	934efc00 	asr	x0, x0, #14
  40187c:	2a0003e1 	mov	w1, w0
  401880:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401884:	91164000 	add	x0, x0, #0x590
  401888:	b9000001 	str	w1, [x0]
  40188c:	f9401fe0 	ldr	x0, [sp, #56]
  401890:	d1001000 	sub	x0, x0, #0x4
  401894:	f9001be0 	str	x0, [sp, #48]
  401898:	f94017e0 	ldr	x0, [sp, #40]
  40189c:	d1001000 	sub	x0, x0, #0x4
  4018a0:	f90013e0 	str	x0, [sp, #32]
  4018a4:	b9005fff 	str	wzr, [sp, #92]
  4018a8:	14000014 	b	4018f8 <decode+0x860>
  4018ac:	f9401be1 	ldr	x1, [sp, #48]
  4018b0:	d1001020 	sub	x0, x1, #0x4
  4018b4:	f9001be0 	str	x0, [sp, #48]
  4018b8:	f9401fe0 	ldr	x0, [sp, #56]
  4018bc:	d1001002 	sub	x2, x0, #0x4
  4018c0:	f9001fe2 	str	x2, [sp, #56]
  4018c4:	b9400021 	ldr	w1, [x1]
  4018c8:	b9000001 	str	w1, [x0]
  4018cc:	f94013e1 	ldr	x1, [sp, #32]
  4018d0:	d1001020 	sub	x0, x1, #0x4
  4018d4:	f90013e0 	str	x0, [sp, #32]
  4018d8:	f94017e0 	ldr	x0, [sp, #40]
  4018dc:	d1001002 	sub	x2, x0, #0x4
  4018e0:	f90017e2 	str	x2, [sp, #40]
  4018e4:	b9400021 	ldr	w1, [x1]
  4018e8:	b9000001 	str	w1, [x0]
  4018ec:	b9405fe0 	ldr	w0, [sp, #92]
  4018f0:	11000400 	add	w0, w0, #0x1
  4018f4:	b9005fe0 	str	w0, [sp, #92]
  4018f8:	b9405fe0 	ldr	w0, [sp, #92]
  4018fc:	7100241f 	cmp	w0, #0x9
  401900:	54fffd6d 	b.le	4018ac <decode+0x814>
  401904:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401908:	91166000 	add	x0, x0, #0x598
  40190c:	b9400001 	ldr	w1, [x0]
  401910:	f9401fe0 	ldr	x0, [sp, #56]
  401914:	b9000001 	str	w1, [x0]
  401918:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  40191c:	91165000 	add	x0, x0, #0x594
  401920:	b9400001 	ldr	w1, [x0]
  401924:	f94017e0 	ldr	x0, [sp, #40]
  401928:	b9000001 	str	w1, [x0]
  40192c:	d503201f 	nop
  401930:	a8c67bfd 	ldp	x29, x30, [sp], #96
  401934:	d65f03c0 	ret

0000000000401938 <reset>:
  401938:	d10043ff 	sub	sp, sp, #0x10
  40193c:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401940:	911a6000 	add	x0, x0, #0x698
  401944:	52800401 	mov	w1, #0x20                  	// #32
  401948:	b9000001 	str	w1, [x0]
  40194c:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401950:	911a6000 	add	x0, x0, #0x698
  401954:	b9400001 	ldr	w1, [x0]
  401958:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  40195c:	91183000 	add	x0, x0, #0x60c
  401960:	b9000001 	str	w1, [x0]
  401964:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401968:	911a5000 	add	x0, x0, #0x694
  40196c:	52800101 	mov	w1, #0x8                   	// #8
  401970:	b9000001 	str	w1, [x0]
  401974:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401978:	911a5000 	add	x0, x0, #0x694
  40197c:	b9400001 	ldr	w1, [x0]
  401980:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401984:	91184000 	add	x0, x0, #0x610
  401988:	b9000001 	str	w1, [x0]
  40198c:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401990:	91182000 	add	x0, x0, #0x608
  401994:	b900001f 	str	wzr, [x0]
  401998:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  40199c:	91182000 	add	x0, x0, #0x608
  4019a0:	b9400001 	ldr	w1, [x0]
  4019a4:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4019a8:	91181000 	add	x0, x0, #0x604
  4019ac:	b9000001 	str	w1, [x0]
  4019b0:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4019b4:	91181000 	add	x0, x0, #0x604
  4019b8:	b9400001 	ldr	w1, [x0]
  4019bc:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4019c0:	9117d000 	add	x0, x0, #0x5f4
  4019c4:	b9000001 	str	w1, [x0]
  4019c8:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4019cc:	9117d000 	add	x0, x0, #0x5f4
  4019d0:	b9400001 	ldr	w1, [x0]
  4019d4:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4019d8:	9117c000 	add	x0, x0, #0x5f0
  4019dc:	b9000001 	str	w1, [x0]
  4019e0:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4019e4:	9117c000 	add	x0, x0, #0x5f0
  4019e8:	b9400001 	ldr	w1, [x0]
  4019ec:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4019f0:	9117a000 	add	x0, x0, #0x5e8
  4019f4:	b9000001 	str	w1, [x0]
  4019f8:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4019fc:	9117a000 	add	x0, x0, #0x5e8
  401a00:	b9400001 	ldr	w1, [x0]
  401a04:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401a08:	91179000 	add	x0, x0, #0x5e4
  401a0c:	b9000001 	str	w1, [x0]
  401a10:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401a14:	91179000 	add	x0, x0, #0x5e4
  401a18:	b9400001 	ldr	w1, [x0]
  401a1c:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401a20:	91178000 	add	x0, x0, #0x5e0
  401a24:	b9000001 	str	w1, [x0]
  401a28:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401a2c:	911a1000 	add	x0, x0, #0x684
  401a30:	b900001f 	str	wzr, [x0]
  401a34:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401a38:	911a1000 	add	x0, x0, #0x684
  401a3c:	b9400001 	ldr	w1, [x0]
  401a40:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401a44:	911a0000 	add	x0, x0, #0x680
  401a48:	b9000001 	str	w1, [x0]
  401a4c:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401a50:	911a0000 	add	x0, x0, #0x680
  401a54:	b9400001 	ldr	w1, [x0]
  401a58:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401a5c:	9119f000 	add	x0, x0, #0x67c
  401a60:	b9000001 	str	w1, [x0]
  401a64:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401a68:	9119f000 	add	x0, x0, #0x67c
  401a6c:	b9400001 	ldr	w1, [x0]
  401a70:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401a74:	9119e000 	add	x0, x0, #0x678
  401a78:	b9000001 	str	w1, [x0]
  401a7c:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401a80:	9119e000 	add	x0, x0, #0x678
  401a84:	b9400001 	ldr	w1, [x0]
  401a88:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401a8c:	9119d000 	add	x0, x0, #0x674
  401a90:	b9000001 	str	w1, [x0]
  401a94:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401a98:	9119d000 	add	x0, x0, #0x674
  401a9c:	b9400001 	ldr	w1, [x0]
  401aa0:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401aa4:	9119c000 	add	x0, x0, #0x670
  401aa8:	b9000001 	str	w1, [x0]
  401aac:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401ab0:	9119c000 	add	x0, x0, #0x670
  401ab4:	b9400001 	ldr	w1, [x0]
  401ab8:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401abc:	91189000 	add	x0, x0, #0x624
  401ac0:	b9000001 	str	w1, [x0]
  401ac4:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401ac8:	911bb000 	add	x0, x0, #0x6ec
  401acc:	b900001f 	str	wzr, [x0]
  401ad0:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401ad4:	911bb000 	add	x0, x0, #0x6ec
  401ad8:	b9400001 	ldr	w1, [x0]
  401adc:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401ae0:	911ba000 	add	x0, x0, #0x6e8
  401ae4:	b9000001 	str	w1, [x0]
  401ae8:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401aec:	911ba000 	add	x0, x0, #0x6e8
  401af0:	b9400001 	ldr	w1, [x0]
  401af4:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401af8:	911b6000 	add	x0, x0, #0x6d8
  401afc:	b9000001 	str	w1, [x0]
  401b00:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401b04:	911b6000 	add	x0, x0, #0x6d8
  401b08:	b9400001 	ldr	w1, [x0]
  401b0c:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401b10:	911b5000 	add	x0, x0, #0x6d4
  401b14:	b9000001 	str	w1, [x0]
  401b18:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401b1c:	911b5000 	add	x0, x0, #0x6d4
  401b20:	b9400001 	ldr	w1, [x0]
  401b24:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401b28:	911be000 	add	x0, x0, #0x6f8
  401b2c:	b9000001 	str	w1, [x0]
  401b30:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401b34:	911be000 	add	x0, x0, #0x6f8
  401b38:	b9400001 	ldr	w1, [x0]
  401b3c:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401b40:	911bd000 	add	x0, x0, #0x6f4
  401b44:	b9000001 	str	w1, [x0]
  401b48:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401b4c:	911bd000 	add	x0, x0, #0x6f4
  401b50:	b9400001 	ldr	w1, [x0]
  401b54:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401b58:	911c0000 	add	x0, x0, #0x700
  401b5c:	b9000001 	str	w1, [x0]
  401b60:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401b64:	911d2000 	add	x0, x0, #0x748
  401b68:	b900001f 	str	wzr, [x0]
  401b6c:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401b70:	911d2000 	add	x0, x0, #0x748
  401b74:	b9400001 	ldr	w1, [x0]
  401b78:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401b7c:	911d1000 	add	x0, x0, #0x744
  401b80:	b9000001 	str	w1, [x0]
  401b84:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401b88:	911d1000 	add	x0, x0, #0x744
  401b8c:	b9400001 	ldr	w1, [x0]
  401b90:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401b94:	911da000 	add	x0, x0, #0x768
  401b98:	b9000001 	str	w1, [x0]
  401b9c:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401ba0:	911da000 	add	x0, x0, #0x768
  401ba4:	b9400001 	ldr	w1, [x0]
  401ba8:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401bac:	911d9000 	add	x0, x0, #0x764
  401bb0:	b9000001 	str	w1, [x0]
  401bb4:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401bb8:	911d9000 	add	x0, x0, #0x764
  401bbc:	b9400001 	ldr	w1, [x0]
  401bc0:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401bc4:	911d4000 	add	x0, x0, #0x750
  401bc8:	b9000001 	str	w1, [x0]
  401bcc:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401bd0:	911d4000 	add	x0, x0, #0x750
  401bd4:	b9400001 	ldr	w1, [x0]
  401bd8:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401bdc:	911d3000 	add	x0, x0, #0x74c
  401be0:	b9000001 	str	w1, [x0]
  401be4:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401be8:	911d3000 	add	x0, x0, #0x74c
  401bec:	b9400001 	ldr	w1, [x0]
  401bf0:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401bf4:	911c3000 	add	x0, x0, #0x70c
  401bf8:	b9000001 	str	w1, [x0]
  401bfc:	b9000fff 	str	wzr, [sp, #12]
  401c00:	14000014 	b	401c50 <reset+0x318>
  401c04:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401c08:	91172000 	add	x0, x0, #0x5c8
  401c0c:	b9800fe1 	ldrsw	x1, [sp, #12]
  401c10:	b821781f 	str	wzr, [x0, x1, lsl #2]
  401c14:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401c18:	91190000 	add	x0, x0, #0x640
  401c1c:	b9800fe1 	ldrsw	x1, [sp, #12]
  401c20:	b821781f 	str	wzr, [x0, x1, lsl #2]
  401c24:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401c28:	911ae000 	add	x0, x0, #0x6b8
  401c2c:	b9800fe1 	ldrsw	x1, [sp, #12]
  401c30:	b821781f 	str	wzr, [x0, x1, lsl #2]
  401c34:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401c38:	911ca000 	add	x0, x0, #0x728
  401c3c:	b9800fe1 	ldrsw	x1, [sp, #12]
  401c40:	b821781f 	str	wzr, [x0, x1, lsl #2]
  401c44:	b9400fe0 	ldr	w0, [sp, #12]
  401c48:	11000400 	add	w0, w0, #0x1
  401c4c:	b9000fe0 	str	w0, [sp, #12]
  401c50:	b9400fe0 	ldr	w0, [sp, #12]
  401c54:	7100141f 	cmp	w0, #0x5
  401c58:	54fffd6d 	b.le	401c04 <reset+0x2cc>
  401c5c:	b9000fff 	str	wzr, [sp, #12]
  401c60:	14000014 	b	401cb0 <reset+0x378>
  401c64:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401c68:	9116c000 	add	x0, x0, #0x5b0
  401c6c:	b9800fe1 	ldrsw	x1, [sp, #12]
  401c70:	b821781f 	str	wzr, [x0, x1, lsl #2]
  401c74:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401c78:	91196000 	add	x0, x0, #0x658
  401c7c:	b9800fe1 	ldrsw	x1, [sp, #12]
  401c80:	b821781f 	str	wzr, [x0, x1, lsl #2]
  401c84:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401c88:	911a8000 	add	x0, x0, #0x6a0
  401c8c:	b9800fe1 	ldrsw	x1, [sp, #12]
  401c90:	b821781f 	str	wzr, [x0, x1, lsl #2]
  401c94:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401c98:	911c4000 	add	x0, x0, #0x710
  401c9c:	b9800fe1 	ldrsw	x1, [sp, #12]
  401ca0:	b821781f 	str	wzr, [x0, x1, lsl #2]
  401ca4:	b9400fe0 	ldr	w0, [sp, #12]
  401ca8:	11000400 	add	w0, w0, #0x1
  401cac:	b9000fe0 	str	w0, [sp, #12]
  401cb0:	b9400fe0 	ldr	w0, [sp, #12]
  401cb4:	7100141f 	cmp	w0, #0x5
  401cb8:	54fffd6d 	b.le	401c64 <reset+0x32c>
  401cbc:	b9000fff 	str	wzr, [sp, #12]
  401cc0:	14000008 	b	401ce0 <reset+0x3a8>
  401cc4:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401cc8:	91132000 	add	x0, x0, #0x4c8
  401ccc:	b9800fe1 	ldrsw	x1, [sp, #12]
  401cd0:	b821781f 	str	wzr, [x0, x1, lsl #2]
  401cd4:	b9400fe0 	ldr	w0, [sp, #12]
  401cd8:	11000400 	add	w0, w0, #0x1
  401cdc:	b9000fe0 	str	w0, [sp, #12]
  401ce0:	b9400fe0 	ldr	w0, [sp, #12]
  401ce4:	7100581f 	cmp	w0, #0x16
  401ce8:	54fffeed 	b.le	401cc4 <reset+0x38c>
  401cec:	b9000fff 	str	wzr, [sp, #12]
  401cf0:	1400000c 	b	401d20 <reset+0x3e8>
  401cf4:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401cf8:	9114c000 	add	x0, x0, #0x530
  401cfc:	b9800fe1 	ldrsw	x1, [sp, #12]
  401d00:	b821781f 	str	wzr, [x0, x1, lsl #2]
  401d04:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401d08:	91158000 	add	x0, x0, #0x560
  401d0c:	b9800fe1 	ldrsw	x1, [sp, #12]
  401d10:	b821781f 	str	wzr, [x0, x1, lsl #2]
  401d14:	b9400fe0 	ldr	w0, [sp, #12]
  401d18:	11000400 	add	w0, w0, #0x1
  401d1c:	b9000fe0 	str	w0, [sp, #12]
  401d20:	b9400fe0 	ldr	w0, [sp, #12]
  401d24:	7100281f 	cmp	w0, #0xa
  401d28:	54fffe6d 	b.le	401cf4 <reset+0x3bc>
  401d2c:	d503201f 	nop
  401d30:	910043ff 	add	sp, sp, #0x10
  401d34:	d65f03c0 	ret

0000000000401d38 <filtez>:
  401d38:	d10083ff 	sub	sp, sp, #0x20
  401d3c:	f90007e0 	str	x0, [sp, #8]
  401d40:	f90003e1 	str	x1, [sp]
  401d44:	f94007e0 	ldr	x0, [sp, #8]
  401d48:	91001001 	add	x1, x0, #0x4
  401d4c:	f90007e1 	str	x1, [sp, #8]
  401d50:	b9400000 	ldr	w0, [x0]
  401d54:	93407c01 	sxtw	x1, w0
  401d58:	f94003e0 	ldr	x0, [sp]
  401d5c:	91001002 	add	x2, x0, #0x4
  401d60:	f90003e2 	str	x2, [sp]
  401d64:	b9400000 	ldr	w0, [x0]
  401d68:	93407c00 	sxtw	x0, w0
  401d6c:	9b007c20 	mul	x0, x1, x0
  401d70:	f9000be0 	str	x0, [sp, #16]
  401d74:	52800020 	mov	w0, #0x1                   	// #1
  401d78:	b9001fe0 	str	w0, [sp, #28]
  401d7c:	14000012 	b	401dc4 <filtez+0x8c>
  401d80:	f94007e0 	ldr	x0, [sp, #8]
  401d84:	91001001 	add	x1, x0, #0x4
  401d88:	f90007e1 	str	x1, [sp, #8]
  401d8c:	b9400000 	ldr	w0, [x0]
  401d90:	93407c01 	sxtw	x1, w0
  401d94:	f94003e0 	ldr	x0, [sp]
  401d98:	91001002 	add	x2, x0, #0x4
  401d9c:	f90003e2 	str	x2, [sp]
  401da0:	b9400000 	ldr	w0, [x0]
  401da4:	93407c00 	sxtw	x0, w0
  401da8:	9b007c20 	mul	x0, x1, x0
  401dac:	f9400be1 	ldr	x1, [sp, #16]
  401db0:	8b000020 	add	x0, x1, x0
  401db4:	f9000be0 	str	x0, [sp, #16]
  401db8:	b9401fe0 	ldr	w0, [sp, #28]
  401dbc:	11000400 	add	w0, w0, #0x1
  401dc0:	b9001fe0 	str	w0, [sp, #28]
  401dc4:	b9401fe0 	ldr	w0, [sp, #28]
  401dc8:	7100141f 	cmp	w0, #0x5
  401dcc:	54fffdad 	b.le	401d80 <filtez+0x48>
  401dd0:	f9400be0 	ldr	x0, [sp, #16]
  401dd4:	934efc00 	asr	x0, x0, #14
  401dd8:	910083ff 	add	sp, sp, #0x20
  401ddc:	d65f03c0 	ret

0000000000401de0 <filtep>:
  401de0:	d10083ff 	sub	sp, sp, #0x20
  401de4:	b9000fe0 	str	w0, [sp, #12]
  401de8:	b9000be1 	str	w1, [sp, #8]
  401dec:	b90007e2 	str	w2, [sp, #4]
  401df0:	b90003e3 	str	w3, [sp]
  401df4:	b9400fe0 	ldr	w0, [sp, #12]
  401df8:	531f7800 	lsl	w0, w0, #1
  401dfc:	93407c00 	sxtw	x0, w0
  401e00:	f9000fe0 	str	x0, [sp, #24]
  401e04:	b9800be0 	ldrsw	x0, [sp, #8]
  401e08:	f9400fe1 	ldr	x1, [sp, #24]
  401e0c:	9b007c20 	mul	x0, x1, x0
  401e10:	f9000fe0 	str	x0, [sp, #24]
  401e14:	b94007e0 	ldr	w0, [sp, #4]
  401e18:	531f7800 	lsl	w0, w0, #1
  401e1c:	93407c00 	sxtw	x0, w0
  401e20:	f9000be0 	str	x0, [sp, #16]
  401e24:	b98003e1 	ldrsw	x1, [sp]
  401e28:	f9400be0 	ldr	x0, [sp, #16]
  401e2c:	9b007c20 	mul	x0, x1, x0
  401e30:	f9400fe1 	ldr	x1, [sp, #24]
  401e34:	8b000020 	add	x0, x1, x0
  401e38:	f9000fe0 	str	x0, [sp, #24]
  401e3c:	f9400fe0 	ldr	x0, [sp, #24]
  401e40:	934ffc00 	asr	x0, x0, #15
  401e44:	910083ff 	add	sp, sp, #0x20
  401e48:	d65f03c0 	ret

0000000000401e4c <quantl>:
  401e4c:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
  401e50:	910003fd 	mov	x29, sp
  401e54:	b9001fe0 	str	w0, [sp, #28]
  401e58:	b9001be1 	str	w1, [sp, #24]
  401e5c:	b9401fe0 	ldr	w0, [sp, #28]
  401e60:	97fff9e9 	bl	400604 <my_abs>
  401e64:	93407c00 	sxtw	x0, w0
  401e68:	f9001be0 	str	x0, [sp, #48]
  401e6c:	b9003bff 	str	wzr, [sp, #56]
  401e70:	14000011 	b	401eb4 <quantl+0x68>
  401e74:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401e78:	910ca000 	add	x0, x0, #0x328
  401e7c:	b9803be1 	ldrsw	x1, [sp, #56]
  401e80:	b8617800 	ldr	w0, [x0, x1, lsl #2]
  401e84:	93407c01 	sxtw	x1, w0
  401e88:	b9801be0 	ldrsw	x0, [sp, #24]
  401e8c:	9b007c20 	mul	x0, x1, x0
  401e90:	934ffc00 	asr	x0, x0, #15
  401e94:	f90017e0 	str	x0, [sp, #40]
  401e98:	f9401be1 	ldr	x1, [sp, #48]
  401e9c:	f94017e0 	ldr	x0, [sp, #40]
  401ea0:	eb00003f 	cmp	x1, x0
  401ea4:	5400010d 	b.le	401ec4 <quantl+0x78>
  401ea8:	b9403be0 	ldr	w0, [sp, #56]
  401eac:	11000400 	add	w0, w0, #0x1
  401eb0:	b9003be0 	str	w0, [sp, #56]
  401eb4:	b9403be0 	ldr	w0, [sp, #56]
  401eb8:	7100741f 	cmp	w0, #0x1d
  401ebc:	54fffdcd 	b.le	401e74 <quantl+0x28>
  401ec0:	14000002 	b	401ec8 <quantl+0x7c>
  401ec4:	d503201f 	nop
  401ec8:	b9401fe0 	ldr	w0, [sp, #28]
  401ecc:	7100001f 	cmp	w0, #0x0
  401ed0:	540000eb 	b.lt	401eec <quantl+0xa0>  // b.tstop
  401ed4:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401ed8:	910e8000 	add	x0, x0, #0x3a0
  401edc:	b9803be1 	ldrsw	x1, [sp, #56]
  401ee0:	b8617800 	ldr	w0, [x0, x1, lsl #2]
  401ee4:	b9003fe0 	str	w0, [sp, #60]
  401ee8:	14000006 	b	401f00 <quantl+0xb4>
  401eec:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401ef0:	91108000 	add	x0, x0, #0x420
  401ef4:	b9803be1 	ldrsw	x1, [sp, #56]
  401ef8:	b8617800 	ldr	w0, [x0, x1, lsl #2]
  401efc:	b9003fe0 	str	w0, [sp, #60]
  401f00:	b9403fe0 	ldr	w0, [sp, #60]
  401f04:	a8c47bfd 	ldp	x29, x30, [sp], #64
  401f08:	d65f03c0 	ret

0000000000401f0c <logscl>:
  401f0c:	d10083ff 	sub	sp, sp, #0x20
  401f10:	b9000fe0 	str	w0, [sp, #12]
  401f14:	b9000be1 	str	w1, [sp, #8]
  401f18:	b9800be1 	ldrsw	x1, [sp, #8]
  401f1c:	aa0103e0 	mov	x0, x1
  401f20:	d379e000 	lsl	x0, x0, #7
  401f24:	cb010000 	sub	x0, x0, x1
  401f28:	9347fc00 	asr	x0, x0, #7
  401f2c:	f9000fe0 	str	x0, [sp, #24]
  401f30:	f9400fe0 	ldr	x0, [sp, #24]
  401f34:	2a0003e2 	mov	w2, w0
  401f38:	b9400fe0 	ldr	w0, [sp, #12]
  401f3c:	13027c01 	asr	w1, w0, #2
  401f40:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401f44:	91092000 	add	x0, x0, #0x248
  401f48:	93407c21 	sxtw	x1, w1
  401f4c:	b8617800 	ldr	w0, [x0, x1, lsl #2]
  401f50:	0b000040 	add	w0, w2, w0
  401f54:	b9000be0 	str	w0, [sp, #8]
  401f58:	b9400be0 	ldr	w0, [sp, #8]
  401f5c:	7100001f 	cmp	w0, #0x0
  401f60:	5400004a 	b.ge	401f68 <logscl+0x5c>  // b.tcont
  401f64:	b9000bff 	str	wzr, [sp, #8]
  401f68:	b9400be1 	ldr	w1, [sp, #8]
  401f6c:	52890000 	mov	w0, #0x4800                	// #18432
  401f70:	6b00003f 	cmp	w1, w0
  401f74:	5400006d 	b.le	401f80 <logscl+0x74>
  401f78:	52890000 	mov	w0, #0x4800                	// #18432
  401f7c:	b9000be0 	str	w0, [sp, #8]
  401f80:	b9400be0 	ldr	w0, [sp, #8]
  401f84:	910083ff 	add	sp, sp, #0x20
  401f88:	d65f03c0 	ret

0000000000401f8c <scalel>:
  401f8c:	d10083ff 	sub	sp, sp, #0x20
  401f90:	b9000fe0 	str	w0, [sp, #12]
  401f94:	b9000be1 	str	w1, [sp, #8]
  401f98:	b9400fe0 	ldr	w0, [sp, #12]
  401f9c:	13067c00 	asr	w0, w0, #6
  401fa0:	12001000 	and	w0, w0, #0x1f
  401fa4:	b9001fe0 	str	w0, [sp, #28]
  401fa8:	b9400fe0 	ldr	w0, [sp, #12]
  401fac:	130b7c00 	asr	w0, w0, #11
  401fb0:	b9001be0 	str	w0, [sp, #24]
  401fb4:	f00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  401fb8:	910aa000 	add	x0, x0, #0x2a8
  401fbc:	b9801fe1 	ldrsw	x1, [sp, #28]
  401fc0:	b8617801 	ldr	w1, [x0, x1, lsl #2]
  401fc4:	b9400be0 	ldr	w0, [sp, #8]
  401fc8:	11000402 	add	w2, w0, #0x1
  401fcc:	b9401be0 	ldr	w0, [sp, #24]
  401fd0:	4b000040 	sub	w0, w2, w0
  401fd4:	1ac02820 	asr	w0, w1, w0
  401fd8:	b90017e0 	str	w0, [sp, #20]
  401fdc:	b94017e0 	ldr	w0, [sp, #20]
  401fe0:	531d7000 	lsl	w0, w0, #3
  401fe4:	910083ff 	add	sp, sp, #0x20
  401fe8:	d65f03c0 	ret

0000000000401fec <upzero>:
  401fec:	d100c3ff 	sub	sp, sp, #0x30
  401ff0:	b9001fe0 	str	w0, [sp, #28]
  401ff4:	f9000be1 	str	x1, [sp, #16]
  401ff8:	f90007e2 	str	x2, [sp, #8]
  401ffc:	b9401fe0 	ldr	w0, [sp, #28]
  402000:	7100001f 	cmp	w0, #0x0
  402004:	54000341 	b.ne	40206c <upzero+0x80>  // b.any
  402008:	b9002fff 	str	wzr, [sp, #44]
  40200c:	14000014 	b	40205c <upzero+0x70>
  402010:	b9802fe0 	ldrsw	x0, [sp, #44]
  402014:	d37ef400 	lsl	x0, x0, #2
  402018:	f94007e1 	ldr	x1, [sp, #8]
  40201c:	8b000020 	add	x0, x1, x0
  402020:	b9400000 	ldr	w0, [x0]
  402024:	93407c01 	sxtw	x1, w0
  402028:	aa0103e0 	mov	x0, x1
  40202c:	d378dc00 	lsl	x0, x0, #8
  402030:	cb010000 	sub	x0, x0, x1
  402034:	9348fc02 	asr	x2, x0, #8
  402038:	b9802fe0 	ldrsw	x0, [sp, #44]
  40203c:	d37ef400 	lsl	x0, x0, #2
  402040:	f94007e1 	ldr	x1, [sp, #8]
  402044:	8b000020 	add	x0, x1, x0
  402048:	2a0203e1 	mov	w1, w2
  40204c:	b9000001 	str	w1, [x0]
  402050:	b9402fe0 	ldr	w0, [sp, #44]
  402054:	11000400 	add	w0, w0, #0x1
  402058:	b9002fe0 	str	w0, [sp, #44]
  40205c:	b9402fe0 	ldr	w0, [sp, #44]
  402060:	7100141f 	cmp	w0, #0x5
  402064:	54fffd6d 	b.le	402010 <upzero+0x24>
  402068:	1400002b 	b	402114 <upzero+0x128>
  40206c:	b9002fff 	str	wzr, [sp, #44]
  402070:	14000026 	b	402108 <upzero+0x11c>
  402074:	b9801fe1 	ldrsw	x1, [sp, #28]
  402078:	b9802fe0 	ldrsw	x0, [sp, #44]
  40207c:	d37ef400 	lsl	x0, x0, #2
  402080:	f9400be2 	ldr	x2, [sp, #16]
  402084:	8b000040 	add	x0, x2, x0
  402088:	b9400000 	ldr	w0, [x0]
  40208c:	93407c00 	sxtw	x0, w0
  402090:	9b007c20 	mul	x0, x1, x0
  402094:	f100001f 	cmp	x0, #0x0
  402098:	5400008b 	b.lt	4020a8 <upzero+0xbc>  // b.tstop
  40209c:	52801000 	mov	w0, #0x80                  	// #128
  4020a0:	b9002be0 	str	w0, [sp, #40]
  4020a4:	14000003 	b	4020b0 <upzero+0xc4>
  4020a8:	12800fe0 	mov	w0, #0xffffff80            	// #-128
  4020ac:	b9002be0 	str	w0, [sp, #40]
  4020b0:	b9802fe0 	ldrsw	x0, [sp, #44]
  4020b4:	d37ef400 	lsl	x0, x0, #2
  4020b8:	f94007e1 	ldr	x1, [sp, #8]
  4020bc:	8b000020 	add	x0, x1, x0
  4020c0:	b9400000 	ldr	w0, [x0]
  4020c4:	93407c01 	sxtw	x1, w0
  4020c8:	aa0103e0 	mov	x0, x1
  4020cc:	d378dc00 	lsl	x0, x0, #8
  4020d0:	cb010000 	sub	x0, x0, x1
  4020d4:	9348fc00 	asr	x0, x0, #8
  4020d8:	b90027e0 	str	w0, [sp, #36]
  4020dc:	b9802fe0 	ldrsw	x0, [sp, #44]
  4020e0:	d37ef400 	lsl	x0, x0, #2
  4020e4:	f94007e1 	ldr	x1, [sp, #8]
  4020e8:	8b000020 	add	x0, x1, x0
  4020ec:	b9402be2 	ldr	w2, [sp, #40]
  4020f0:	b94027e1 	ldr	w1, [sp, #36]
  4020f4:	0b010041 	add	w1, w2, w1
  4020f8:	b9000001 	str	w1, [x0]
  4020fc:	b9402fe0 	ldr	w0, [sp, #44]
  402100:	11000400 	add	w0, w0, #0x1
  402104:	b9002fe0 	str	w0, [sp, #44]
  402108:	b9402fe0 	ldr	w0, [sp, #44]
  40210c:	7100141f 	cmp	w0, #0x5
  402110:	54fffb2d 	b.le	402074 <upzero+0x88>
  402114:	f9400be0 	ldr	x0, [sp, #16]
  402118:	91005000 	add	x0, x0, #0x14
  40211c:	f9400be1 	ldr	x1, [sp, #16]
  402120:	b9401021 	ldr	w1, [x1, #16]
  402124:	b9000001 	str	w1, [x0]
  402128:	f9400be0 	ldr	x0, [sp, #16]
  40212c:	91004000 	add	x0, x0, #0x10
  402130:	f9400be1 	ldr	x1, [sp, #16]
  402134:	b9400c21 	ldr	w1, [x1, #12]
  402138:	b9000001 	str	w1, [x0]
  40213c:	f9400be0 	ldr	x0, [sp, #16]
  402140:	91003000 	add	x0, x0, #0xc
  402144:	f9400be1 	ldr	x1, [sp, #16]
  402148:	b9400821 	ldr	w1, [x1, #8]
  40214c:	b9000001 	str	w1, [x0]
  402150:	f9400be0 	ldr	x0, [sp, #16]
  402154:	91001000 	add	x0, x0, #0x4
  402158:	f9400be1 	ldr	x1, [sp, #16]
  40215c:	b9400021 	ldr	w1, [x1]
  402160:	b9000001 	str	w1, [x0]
  402164:	f9400be0 	ldr	x0, [sp, #16]
  402168:	b9401fe1 	ldr	w1, [sp, #28]
  40216c:	b9000001 	str	w1, [x0]
  402170:	d503201f 	nop
  402174:	9100c3ff 	add	sp, sp, #0x30
  402178:	d65f03c0 	ret

000000000040217c <uppol2>:
  40217c:	d10103ff 	sub	sp, sp, #0x40
  402180:	b9001fe0 	str	w0, [sp, #28]
  402184:	b9001be1 	str	w1, [sp, #24]
  402188:	b90017e2 	str	w2, [sp, #20]
  40218c:	b90013e3 	str	w3, [sp, #16]
  402190:	b9000fe4 	str	w4, [sp, #12]
  402194:	b9801fe0 	ldrsw	x0, [sp, #28]
  402198:	d37ef400 	lsl	x0, x0, #2
  40219c:	f9001fe0 	str	x0, [sp, #56]
  4021a0:	b98017e1 	ldrsw	x1, [sp, #20]
  4021a4:	b98013e0 	ldrsw	x0, [sp, #16]
  4021a8:	9b007c20 	mul	x0, x1, x0
  4021ac:	f100001f 	cmp	x0, #0x0
  4021b0:	5400008b 	b.lt	4021c0 <uppol2+0x44>  // b.tstop
  4021b4:	f9401fe0 	ldr	x0, [sp, #56]
  4021b8:	cb0003e0 	neg	x0, x0
  4021bc:	f9001fe0 	str	x0, [sp, #56]
  4021c0:	f9401fe0 	ldr	x0, [sp, #56]
  4021c4:	9347fc00 	asr	x0, x0, #7
  4021c8:	f9001fe0 	str	x0, [sp, #56]
  4021cc:	b98017e1 	ldrsw	x1, [sp, #20]
  4021d0:	b9800fe0 	ldrsw	x0, [sp, #12]
  4021d4:	9b007c20 	mul	x0, x1, x0
  4021d8:	f100001f 	cmp	x0, #0x0
  4021dc:	540000ab 	b.lt	4021f0 <uppol2+0x74>  // b.tstop
  4021e0:	f9401fe0 	ldr	x0, [sp, #56]
  4021e4:	91020000 	add	x0, x0, #0x80
  4021e8:	f9001be0 	str	x0, [sp, #48]
  4021ec:	14000004 	b	4021fc <uppol2+0x80>
  4021f0:	f9401fe0 	ldr	x0, [sp, #56]
  4021f4:	d1020000 	sub	x0, x0, #0x80
  4021f8:	f9001be0 	str	x0, [sp, #48]
  4021fc:	b9801be1 	ldrsw	x1, [sp, #24]
  402200:	aa0103e0 	mov	x0, x1
  402204:	d379e000 	lsl	x0, x0, #7
  402208:	cb010000 	sub	x0, x0, x1
  40220c:	9347fc00 	asr	x0, x0, #7
  402210:	2a0003e1 	mov	w1, w0
  402214:	f9401be0 	ldr	x0, [sp, #48]
  402218:	0b000020 	add	w0, w1, w0
  40221c:	b9002fe0 	str	w0, [sp, #44]
  402220:	b9402fe0 	ldr	w0, [sp, #44]
  402224:	71400c1f 	cmp	w0, #0x3, lsl #12
  402228:	5400006d 	b.le	402234 <uppol2+0xb8>
  40222c:	52860000 	mov	w0, #0x3000                	// #12288
  402230:	b9002fe0 	str	w0, [sp, #44]
  402234:	b9402fe0 	ldr	w0, [sp, #44]
  402238:	31400c1f 	cmn	w0, #0x3, lsl #12
  40223c:	5400006a 	b.ge	402248 <uppol2+0xcc>  // b.tcont
  402240:	1285ffe0 	mov	w0, #0xffffd000            	// #-12288
  402244:	b9002fe0 	str	w0, [sp, #44]
  402248:	b9402fe0 	ldr	w0, [sp, #44]
  40224c:	910103ff 	add	sp, sp, #0x40
  402250:	d65f03c0 	ret

0000000000402254 <uppol1>:
  402254:	d100c3ff 	sub	sp, sp, #0x30
  402258:	b9000fe0 	str	w0, [sp, #12]
  40225c:	b9000be1 	str	w1, [sp, #8]
  402260:	b90007e2 	str	w2, [sp, #4]
  402264:	b90003e3 	str	w3, [sp]
  402268:	b9800fe1 	ldrsw	x1, [sp, #12]
  40226c:	aa0103e0 	mov	x0, x1
  402270:	d378dc00 	lsl	x0, x0, #8
  402274:	cb010000 	sub	x0, x0, x1
  402278:	9348fc00 	asr	x0, x0, #8
  40227c:	f90013e0 	str	x0, [sp, #32]
  402280:	b98007e1 	ldrsw	x1, [sp, #4]
  402284:	b98003e0 	ldrsw	x0, [sp]
  402288:	9b007c20 	mul	x0, x1, x0
  40228c:	f100001f 	cmp	x0, #0x0
  402290:	540000ab 	b.lt	4022a4 <uppol1+0x50>  // b.tstop
  402294:	f94013e0 	ldr	x0, [sp, #32]
  402298:	11030000 	add	w0, w0, #0xc0
  40229c:	b9002fe0 	str	w0, [sp, #44]
  4022a0:	14000004 	b	4022b0 <uppol1+0x5c>
  4022a4:	f94013e0 	ldr	x0, [sp, #32]
  4022a8:	51030000 	sub	w0, w0, #0xc0
  4022ac:	b9002fe0 	str	w0, [sp, #44]
  4022b0:	52878001 	mov	w1, #0x3c00                	// #15360
  4022b4:	b9400be0 	ldr	w0, [sp, #8]
  4022b8:	4b000020 	sub	w0, w1, w0
  4022bc:	b9001fe0 	str	w0, [sp, #28]
  4022c0:	b9402fe1 	ldr	w1, [sp, #44]
  4022c4:	b9401fe0 	ldr	w0, [sp, #28]
  4022c8:	6b00003f 	cmp	w1, w0
  4022cc:	5400006d 	b.le	4022d8 <uppol1+0x84>
  4022d0:	b9401fe0 	ldr	w0, [sp, #28]
  4022d4:	b9002fe0 	str	w0, [sp, #44]
  4022d8:	b9401fe0 	ldr	w0, [sp, #28]
  4022dc:	4b0003e0 	neg	w0, w0
  4022e0:	b9402fe1 	ldr	w1, [sp, #44]
  4022e4:	6b00003f 	cmp	w1, w0
  4022e8:	5400008a 	b.ge	4022f8 <uppol1+0xa4>  // b.tcont
  4022ec:	b9401fe0 	ldr	w0, [sp, #28]
  4022f0:	4b0003e0 	neg	w0, w0
  4022f4:	b9002fe0 	str	w0, [sp, #44]
  4022f8:	b9402fe0 	ldr	w0, [sp, #44]
  4022fc:	9100c3ff 	add	sp, sp, #0x30
  402300:	d65f03c0 	ret

0000000000402304 <logsch>:
  402304:	d10083ff 	sub	sp, sp, #0x20
  402308:	b9000fe0 	str	w0, [sp, #12]
  40230c:	b9000be1 	str	w1, [sp, #8]
  402310:	b9800be1 	ldrsw	x1, [sp, #8]
  402314:	aa0103e0 	mov	x0, x1
  402318:	d379e000 	lsl	x0, x0, #7
  40231c:	cb010000 	sub	x0, x0, x1
  402320:	9347fc00 	asr	x0, x0, #7
  402324:	b9001fe0 	str	w0, [sp, #28]
  402328:	d00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  40232c:	9112c000 	add	x0, x0, #0x4b0
  402330:	b9800fe1 	ldrsw	x1, [sp, #12]
  402334:	b8617800 	ldr	w0, [x0, x1, lsl #2]
  402338:	b9401fe1 	ldr	w1, [sp, #28]
  40233c:	0b000020 	add	w0, w1, w0
  402340:	b9000be0 	str	w0, [sp, #8]
  402344:	b9400be0 	ldr	w0, [sp, #8]
  402348:	7100001f 	cmp	w0, #0x0
  40234c:	5400004a 	b.ge	402354 <logsch+0x50>  // b.tcont
  402350:	b9000bff 	str	wzr, [sp, #8]
  402354:	b9400be1 	ldr	w1, [sp, #8]
  402358:	528b0000 	mov	w0, #0x5800                	// #22528
  40235c:	6b00003f 	cmp	w1, w0
  402360:	5400006d 	b.le	40236c <logsch+0x68>
  402364:	528b0000 	mov	w0, #0x5800                	// #22528
  402368:	b9000be0 	str	w0, [sp, #8]
  40236c:	b9400be0 	ldr	w0, [sp, #8]
  402370:	910083ff 	add	sp, sp, #0x20
  402374:	d65f03c0 	ret

0000000000402378 <main>:
  402378:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
  40237c:	910003fd 	mov	x29, sp
  402380:	f9000bf3 	str	x19, [sp, #16]
  402384:	97fffd6d 	bl	401938 <reset>
  402388:	52800140 	mov	w0, #0xa                   	// #10
  40238c:	b9002be0 	str	w0, [sp, #40]
  402390:	5280fa00 	mov	w0, #0x7d0                 	// #2000
  402394:	b90027e0 	str	w0, [sp, #36]
  402398:	b9002fff 	str	wzr, [sp, #44]
  40239c:	14000011 	b	4023e0 <main+0x68>
  4023a0:	b94027e1 	ldr	w1, [sp, #36]
  4023a4:	b9402fe0 	ldr	w0, [sp, #44]
  4023a8:	1b007c21 	mul	w1, w1, w0
  4023ac:	528188a0 	mov	w0, #0xc45                 	// #3141
  4023b0:	1b007c20 	mul	w0, w1, w0
  4023b4:	97fff8fc 	bl	4007a4 <my_cos>
  4023b8:	2a0003e1 	mov	w1, w0
  4023bc:	b9402be0 	ldr	w0, [sp, #40]
  4023c0:	1b007c22 	mul	w2, w1, w0
  4023c4:	d00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4023c8:	911dc000 	add	x0, x0, #0x770
  4023cc:	b9802fe1 	ldrsw	x1, [sp, #44]
  4023d0:	b8217802 	str	w2, [x0, x1, lsl #2]
  4023d4:	b9402fe0 	ldr	w0, [sp, #44]
  4023d8:	11000400 	add	w0, w0, #0x1
  4023dc:	b9002fe0 	str	w0, [sp, #44]
  4023e0:	b9402fe0 	ldr	w0, [sp, #44]
  4023e4:	7100081f 	cmp	w0, #0x2
  4023e8:	54fffdcd 	b.le	4023a0 <main+0x28>
  4023ec:	b9002fff 	str	wzr, [sp, #44]
  4023f0:	1400001b 	b	40245c <main+0xe4>
  4023f4:	d00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4023f8:	911dc000 	add	x0, x0, #0x770
  4023fc:	b9802fe1 	ldrsw	x1, [sp, #44]
  402400:	b8617802 	ldr	w2, [x0, x1, lsl #2]
  402404:	b9402fe0 	ldr	w0, [sp, #44]
  402408:	11000401 	add	w1, w0, #0x1
  40240c:	d00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  402410:	911dc000 	add	x0, x0, #0x770
  402414:	93407c21 	sxtw	x1, w1
  402418:	b8617803 	ldr	w3, [x0, x1, lsl #2]
  40241c:	b9402fe0 	ldr	w0, [sp, #44]
  402420:	531f7c01 	lsr	w1, w0, #31
  402424:	0b000020 	add	w0, w1, w0
  402428:	13017c00 	asr	w0, w0, #1
  40242c:	2a0003f3 	mov	w19, w0
  402430:	2a0303e1 	mov	w1, w3
  402434:	2a0203e0 	mov	w0, w2
  402438:	97fff8e4 	bl	4007c8 <encode>
  40243c:	2a0003e2 	mov	w2, w0
  402440:	d00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  402444:	911e2000 	add	x0, x0, #0x788
  402448:	93407e61 	sxtw	x1, w19
  40244c:	b8217802 	str	w2, [x0, x1, lsl #2]
  402450:	b9402fe0 	ldr	w0, [sp, #44]
  402454:	11000800 	add	w0, w0, #0x2
  402458:	b9002fe0 	str	w0, [sp, #44]
  40245c:	b9402fe0 	ldr	w0, [sp, #44]
  402460:	71000c1f 	cmp	w0, #0x3
  402464:	54fffc8d 	b.le	4023f4 <main+0x7c>
  402468:	b9002fff 	str	wzr, [sp, #44]
  40246c:	1400001e 	b	4024e4 <main+0x16c>
  402470:	b9402fe0 	ldr	w0, [sp, #44]
  402474:	531f7c01 	lsr	w1, w0, #31
  402478:	0b000020 	add	w0, w1, w0
  40247c:	13017c00 	asr	w0, w0, #1
  402480:	2a0003e1 	mov	w1, w0
  402484:	d00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  402488:	911e2000 	add	x0, x0, #0x788
  40248c:	93407c21 	sxtw	x1, w1
  402490:	b8617800 	ldr	w0, [x0, x1, lsl #2]
  402494:	97fffb01 	bl	401098 <decode>
  402498:	d00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  40249c:	91163000 	add	x0, x0, #0x58c
  4024a0:	b9400002 	ldr	w2, [x0]
  4024a4:	d00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4024a8:	911e6000 	add	x0, x0, #0x798
  4024ac:	b9802fe1 	ldrsw	x1, [sp, #44]
  4024b0:	b8217802 	str	w2, [x0, x1, lsl #2]
  4024b4:	b9402fe0 	ldr	w0, [sp, #44]
  4024b8:	11000401 	add	w1, w0, #0x1
  4024bc:	d00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4024c0:	91164000 	add	x0, x0, #0x590
  4024c4:	b9400002 	ldr	w2, [x0]
  4024c8:	d00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4024cc:	911e6000 	add	x0, x0, #0x798
  4024d0:	93407c21 	sxtw	x1, w1
  4024d4:	b8217802 	str	w2, [x0, x1, lsl #2]
  4024d8:	b9402fe0 	ldr	w0, [sp, #44]
  4024dc:	11000800 	add	w0, w0, #0x2
  4024e0:	b9002fe0 	str	w0, [sp, #44]
  4024e4:	b9402fe0 	ldr	w0, [sp, #44]
  4024e8:	71000c1f 	cmp	w0, #0x3
  4024ec:	54fffc2d 	b.le	402470 <main+0xf8>
  4024f0:	d00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4024f4:	911e6000 	add	x0, x0, #0x798
  4024f8:	b9802fe1 	ldrsw	x1, [sp, #44]
  4024fc:	b8617801 	ldr	w1, [x0, x1, lsl #2]
  402500:	b9402fe0 	ldr	w0, [sp, #44]
  402504:	11000402 	add	w2, w0, #0x1
  402508:	d00000e0 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  40250c:	911e6000 	add	x0, x0, #0x798
  402510:	93407c42 	sxtw	x2, w2
  402514:	b8627800 	ldr	w0, [x0, x2, lsl #2]
  402518:	0b000020 	add	w0, w1, w0
  40251c:	f9400bf3 	ldr	x19, [sp, #16]
  402520:	a8c37bfd 	ldp	x29, x30, [sp], #48
  402524:	d65f03c0 	ret

Disassembly of section .fini:

0000000000402528 <_fini>:
  402528:	d503201f 	nop
  40252c:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
  402530:	910003fd 	mov	x29, sp
  402534:	a8c17bfd 	ldp	x29, x30, [sp], #16
  402538:	d65f03c0 	ret
