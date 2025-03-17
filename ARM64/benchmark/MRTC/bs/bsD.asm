
bs：     文件格式 elf64-littleaarch64


Disassembly of section .interp:

0000000000400238 <.interp>:
  400238:	62696c2f 	.inst	0x62696c2f ; undefined
  40023c:	2d646c2f 	ldp	s15, s27, [x1, #-224]
  400240:	756e696c 	.inst	0x756e696c ; undefined
  400244:	61612d78 	.inst	0x61612d78 ; undefined
  400248:	36686372 	tbz	w18, #13, 400eb4 <__FRAME_END__+0x674>
  40024c:	6f732e34 	.inst	0x6f732e34 ; undefined
  400250:	地址 0x0000000000400250 越界。


Disassembly of section .note.gnu.build-id:

0000000000400254 <.note.gnu.build-id>:
  400254:	00000004 	udf	#4
  400258:	00000014 	udf	#20
  40025c:	00000003 	udf	#3
  400260:	00554e47 	.inst	0x00554e47 ; undefined
  400264:	f7f3f161 	.inst	0xf7f3f161 ; undefined
  400268:	ca5b7a3c 	eor	x28, x17, x27, lsr #30
  40026c:	984861c2 	ldrsw	x2, 490ea4 <__bss_end__+0x70dfc>
  400270:	6c859786 	stp	d6, d5, [x28], #88
  400274:	e7b210db 	.inst	0xe7b210db ; undefined

Disassembly of section .note.ABI-tag:

0000000000400278 <__abi_tag>:
  400278:	00000004 	udf	#4
  40027c:	00000010 	udf	#16
  400280:	00000001 	udf	#1
  400284:	00554e47 	.inst	0x00554e47 ; undefined
  400288:	00000000 	udf	#0
  40028c:	00000003 	udf	#3
  400290:	00000007 	udf	#7
  400294:	00000000 	udf	#0

Disassembly of section .gnu.hash:

0000000000400298 <.gnu.hash>:
  400298:	00000001 	udf	#1
  40029c:	00000001 	udf	#1
  4002a0:	00000001 	udf	#1
	...

Disassembly of section .dynsym:

00000000004002b8 <.dynsym>:
	...
  4002d0:	00000001 	udf	#1
  4002d4:	00000012 	udf	#18
	...
  4002e8:	00000039 	udf	#57
  4002ec:	00000020 	udf	#32
	...
  400300:	00000055 	udf	#85
  400304:	00000020 	udf	#32
	...
  400318:	00000013 	udf	#19
  40031c:	00000012 	udf	#18
	...
  400330:	00000064 	udf	#100
  400334:	00000020 	udf	#32
	...

Disassembly of section .dynstr:

0000000000400348 <.dynstr>:
  400348:	6c5f5f00 	ldnp	d0, d23, [x24, #496]
  40034c:	5f636269 	.inst	0x5f636269 ; undefined
  400350:	72617473 	.inst	0x72617473 ; undefined
  400354:	616d5f74 	.inst	0x616d5f74 ; undefined
  400358:	61006e69 	.inst	0x61006e69 ; undefined
  40035c:	74726f62 	.inst	0x74726f62 ; undefined
  400360:	62696c00 	.inst	0x62696c00 ; undefined
  400364:	6f732e63 	.inst	0x6f732e63 ; undefined
  400368:	4700362e 	.inst	0x4700362e ; undefined
  40036c:	4342494c 	.inst	0x4342494c ; undefined
  400370:	312e325f 	cmn	w18, #0xb8c
  400374:	4c470037 	.inst	0x4c470037 ; undefined
  400378:	5f434249 	.inst	0x5f434249 ; undefined
  40037c:	34332e32 	cbz	w18, 466940 <__bss_end__+0x46898>
  400380:	54495f00 	b.eq	492f60 <__bss_end__+0x72eb8>  // b.none
  400384:	65645f4d 	fnmla	z13.h, p7/m, z26.h, z4.h
  400388:	69676572 	ldpsw	x18, x25, [x11, #-200]
  40038c:	72657473 	.inst	0x72657473 ; undefined
  400390:	6c434d54 	ldnp	d20, d19, [x10, #48]
  400394:	54656e6f 	b.nv	4cb160 <__bss_end__+0xab0b8>
  400398:	656c6261 	fnmls	z1.h, p0/m, z19.h, z12.h
  40039c:	675f5f00 	.inst	0x675f5f00 ; undefined
  4003a0:	5f6e6f6d 	.inst	0x5f6e6f6d ; undefined
  4003a4:	72617473 	.inst	0x72617473 ; undefined
  4003a8:	005f5f74 	.inst	0x005f5f74 ; undefined
  4003ac:	4d54495f 	.inst	0x4d54495f ; undefined
  4003b0:	6765725f 	.inst	0x6765725f ; undefined
  4003b4:	65747369 	fnmls	z9.h, p4/m, z27.h, z20.h
  4003b8:	434d5472 	.inst	0x434d5472 ; undefined
  4003bc:	656e6f6c 	fnmls	z12.h, p3/m, z27.h, z14.h
  4003c0:	6c626154 	ldnp	d20, d24, [x10, #-480]
  4003c4:	地址 0x00000000004003c4 越界。


Disassembly of section .gnu.version:

00000000004003c6 <.gnu.version>:
  4003c6:	00020000 	.inst	0x00020000 ; undefined
  4003ca:	00010001 	.inst	0x00010001 ; undefined
  4003ce:	00010003 	.inst	0x00010003 ; undefined

Disassembly of section .gnu.version_r:

00000000004003d8 <.gnu.version_r>:
  4003d8:	00020001 	.inst	0x00020001 ; undefined
  4003dc:	00000019 	udf	#25
  4003e0:	00000010 	udf	#16
  4003e4:	00000000 	udf	#0
  4003e8:	06969197 	.inst	0x06969197 ; undefined
  4003ec:	00030000 	.inst	0x00030000 ; undefined
  4003f0:	00000023 	udf	#35
  4003f4:	00000010 	udf	#16
  4003f8:	069691b4 	.inst	0x069691b4 ; undefined
  4003fc:	00020000 	.inst	0x00020000 ; undefined
  400400:	0000002e 	udf	#46
  400404:	00000000 	udf	#0

Disassembly of section .rela.dyn:

0000000000400408 <.rela.dyn>:
  400408:	0041ffd0 	.inst	0x0041ffd0 ; undefined
  40040c:	00000000 	udf	#0
  400410:	00000401 	udf	#1025
  400414:	00000002 	udf	#2
	...
  400420:	0041ffd8 	.inst	0x0041ffd8 ; undefined
  400424:	00000000 	udf	#0
  400428:	00000401 	udf	#1025
  40042c:	00000003 	udf	#3
	...
  400438:	0041ffe0 	.inst	0x0041ffe0 ; undefined
  40043c:	00000000 	udf	#0
  400440:	00000401 	udf	#1025
  400444:	00000005 	udf	#5
	...

Disassembly of section .rela.plt:

0000000000400450 <.rela.plt>:
  400450:	00420000 	.inst	0x00420000 ; undefined
  400454:	00000000 	udf	#0
  400458:	00000402 	udf	#1026
  40045c:	00000001 	udf	#1
	...
  400468:	00420008 	.inst	0x00420008 ; undefined
  40046c:	00000000 	udf	#0
  400470:	00000402 	udf	#1026
  400474:	00000003 	udf	#3
	...
  400480:	00420010 	.inst	0x00420010 ; undefined
  400484:	00000000 	udf	#0
  400488:	00000402 	udf	#1026
  40048c:	00000004 	udf	#4
	...

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
  4004b4:	f00000f0 	adrp	x16, 41f000 <__FRAME_END__+0x1e7c0>
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
  400544:	f00000e0 	adrp	x0, 41f000 <__FRAME_END__+0x1e7c0>
  400548:	f947ec00 	ldr	x0, [x0, #4056]
  40054c:	b4000040 	cbz	x0, 400554 <call_weak_fn+0x10>
  400550:	17ffffe4 	b	4004e0 <__gmon_start__@plt>
  400554:	d65f03c0 	ret
  400558:	d503201f 	nop
  40055c:	d503201f 	nop

0000000000400560 <deregister_tm_clones>:
  400560:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400564:	91028000 	add	x0, x0, #0xa0
  400568:	90000101 	adrp	x1, 420000 <__libc_start_main@GLIBC_2.34>
  40056c:	91028021 	add	x1, x1, #0xa0
  400570:	eb00003f 	cmp	x1, x0
  400574:	540000c0 	b.eq	40058c <deregister_tm_clones+0x2c>  // b.none
  400578:	f00000e1 	adrp	x1, 41f000 <__FRAME_END__+0x1e7c0>
  40057c:	f947e821 	ldr	x1, [x1, #4048]
  400580:	b4000061 	cbz	x1, 40058c <deregister_tm_clones+0x2c>
  400584:	aa0103f0 	mov	x16, x1
  400588:	d61f0200 	br	x16
  40058c:	d65f03c0 	ret

0000000000400590 <register_tm_clones>:
  400590:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400594:	91028000 	add	x0, x0, #0xa0
  400598:	90000101 	adrp	x1, 420000 <__libc_start_main@GLIBC_2.34>
  40059c:	91028021 	add	x1, x1, #0xa0
  4005a0:	cb000021 	sub	x1, x1, x0
  4005a4:	d37ffc22 	lsr	x2, x1, #63
  4005a8:	8b810c41 	add	x1, x2, x1, asr #3
  4005ac:	9341fc21 	asr	x1, x1, #1
  4005b0:	b40000c1 	cbz	x1, 4005c8 <register_tm_clones+0x38>
  4005b4:	f00000e2 	adrp	x2, 41f000 <__FRAME_END__+0x1e7c0>
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
  4005e0:	39428260 	ldrb	w0, [x19, #160]
  4005e4:	35000080 	cbnz	w0, 4005f4 <__do_global_dtors_aux+0x24>
  4005e8:	97ffffde 	bl	400560 <deregister_tm_clones>
  4005ec:	52800020 	mov	w0, #0x1                   	// #1
  4005f0:	39028260 	strb	w0, [x19, #160]
  4005f4:	f9400bf3 	ldr	x19, [sp, #16]
  4005f8:	a8c27bfd 	ldp	x29, x30, [sp], #32
  4005fc:	d65f03c0 	ret

0000000000400600 <frame_dummy>:
  400600:	17ffffe4 	b	400590 <register_tm_clones>

0000000000400604 <main>:
  400604:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
  400608:	910003fd 	mov	x29, sp
  40060c:	52800100 	mov	w0, #0x8                   	// #8
  400610:	94000004 	bl	400620 <binary_search>
  400614:	52800000 	mov	w0, #0x0                   	// #0
  400618:	a8c17bfd 	ldp	x29, x30, [sp], #16
  40061c:	d65f03c0 	ret

0000000000400620 <binary_search>:
  400620:	d10083ff 	sub	sp, sp, #0x20
  400624:	b9000fe0 	str	w0, [sp, #12]
  400628:	b90017ff 	str	wzr, [sp, #20]
  40062c:	528001c0 	mov	w0, #0xe                   	// #14
  400630:	b9001be0 	str	w0, [sp, #24]
  400634:	12800000 	mov	w0, #0xffffffff            	// #-1
  400638:	b9001fe0 	str	w0, [sp, #28]
  40063c:	1400002a 	b	4006e4 <binary_search+0xc4>
  400640:	b94017e1 	ldr	w1, [sp, #20]
  400644:	b9401be0 	ldr	w0, [sp, #24]
  400648:	0b000020 	add	w0, w1, w0
  40064c:	13017c00 	asr	w0, w0, #1
  400650:	b90013e0 	str	w0, [sp, #16]
  400654:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400658:	9100a001 	add	x1, x0, #0x28
  40065c:	b98013e0 	ldrsw	x0, [sp, #16]
  400660:	d37df000 	lsl	x0, x0, #3
  400664:	8b000020 	add	x0, x1, x0
  400668:	b9400000 	ldr	w0, [x0]
  40066c:	b9400fe1 	ldr	w1, [sp, #12]
  400670:	6b00003f 	cmp	w1, w0
  400674:	54000181 	b.ne	4006a4 <binary_search+0x84>  // b.any
  400678:	b94017e0 	ldr	w0, [sp, #20]
  40067c:	51000400 	sub	w0, w0, #0x1
  400680:	b9001be0 	str	w0, [sp, #24]
  400684:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  400688:	9100a001 	add	x1, x0, #0x28
  40068c:	b98013e0 	ldrsw	x0, [sp, #16]
  400690:	d37df000 	lsl	x0, x0, #3
  400694:	8b000020 	add	x0, x1, x0
  400698:	b9400400 	ldr	w0, [x0, #4]
  40069c:	b9001fe0 	str	w0, [sp, #28]
  4006a0:	14000011 	b	4006e4 <binary_search+0xc4>
  4006a4:	90000100 	adrp	x0, 420000 <__libc_start_main@GLIBC_2.34>
  4006a8:	9100a001 	add	x1, x0, #0x28
  4006ac:	b98013e0 	ldrsw	x0, [sp, #16]
  4006b0:	d37df000 	lsl	x0, x0, #3
  4006b4:	8b000020 	add	x0, x1, x0
  4006b8:	b9400000 	ldr	w0, [x0]
  4006bc:	b9400fe1 	ldr	w1, [sp, #12]
  4006c0:	6b00003f 	cmp	w1, w0
  4006c4:	540000aa 	b.ge	4006d8 <binary_search+0xb8>  // b.tcont
  4006c8:	b94013e0 	ldr	w0, [sp, #16]
  4006cc:	51000400 	sub	w0, w0, #0x1
  4006d0:	b9001be0 	str	w0, [sp, #24]
  4006d4:	14000004 	b	4006e4 <binary_search+0xc4>
  4006d8:	b94013e0 	ldr	w0, [sp, #16]
  4006dc:	11000400 	add	w0, w0, #0x1
  4006e0:	b90017e0 	str	w0, [sp, #20]
  4006e4:	b94017e1 	ldr	w1, [sp, #20]
  4006e8:	b9401be0 	ldr	w0, [sp, #24]
  4006ec:	6b00003f 	cmp	w1, w0
  4006f0:	54fffa8d 	b.le	400640 <binary_search+0x20>
  4006f4:	b9401fe0 	ldr	w0, [sp, #28]
  4006f8:	910083ff 	add	sp, sp, #0x20
  4006fc:	d65f03c0 	ret

Disassembly of section .fini:

0000000000400700 <_fini>:
  400700:	d503201f 	nop
  400704:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
  400708:	910003fd 	mov	x29, sp
  40070c:	a8c17bfd 	ldp	x29, x30, [sp], #16
  400710:	d65f03c0 	ret

Disassembly of section .rodata:

0000000000400714 <_IO_stdin_used>:
  400714:	00020001 	.inst	0x00020001 ; undefined

Disassembly of section .eh_frame_hdr:

0000000000400718 <__GNU_EH_FRAME_HDR>:
  400718:	3b031b01 	.inst	0x3b031b01 ; undefined
  40071c:	0000004c 	udf	#76
  400720:	00000008 	udf	#8
  400724:	fffffde8 	.inst	0xfffffde8 ; undefined
  400728:	00000064 	udf	#100
  40072c:	fffffe28 	.inst	0xfffffe28 ; undefined
  400730:	00000078 	udf	#120
  400734:	fffffe48 	.inst	0xfffffe48 ; undefined
  400738:	00000090 	udf	#144
  40073c:	fffffe78 	.inst	0xfffffe78 ; undefined
  400740:	000000a4 	udf	#164
  400744:	fffffeb8 	.inst	0xfffffeb8 ; undefined
  400748:	000000b8 	udf	#184
  40074c:	fffffee8 	.inst	0xfffffee8 ; undefined
  400750:	000000dc 	udf	#220
  400754:	fffffeec 	.inst	0xfffffeec ; undefined
  400758:	000000f0 	udf	#240
  40075c:	ffffff08 	.inst	0xffffff08 ; undefined
  400760:	00000110 	udf	#272

Disassembly of section .eh_frame:

0000000000400768 <__FRAME_END__-0xd8>:
  400768:	00000010 	udf	#16
  40076c:	00000000 	udf	#0
  400770:	00527a01 	.inst	0x00527a01 ; undefined
  400774:	011e7804 	.inst	0x011e7804 ; undefined
  400778:	001f0c1b 	.inst	0x001f0c1b ; undefined
  40077c:	00000010 	udf	#16
  400780:	00000018 	udf	#24
  400784:	fffffd7c 	.inst	0xfffffd7c ; undefined
  400788:	0000003c 	udf	#60
  40078c:	1e074100 	.inst	0x1e074100 ; undefined
  400790:	00000014 	udf	#20
  400794:	0000002c 	udf	#44
  400798:	fffffda8 	.inst	0xfffffda8 ; undefined
  40079c:	00000004 	udf	#4
	...
  4007a8:	00000010 	udf	#16
  4007ac:	00000044 	udf	#68
  4007b0:	fffffdb0 	.inst	0xfffffdb0 ; undefined
  4007b4:	00000030 	udf	#48
  4007b8:	00000000 	udf	#0
  4007bc:	00000010 	udf	#16
  4007c0:	00000058 	udf	#88
  4007c4:	fffffdcc 	.inst	0xfffffdcc ; undefined
  4007c8:	0000003c 	udf	#60
  4007cc:	00000000 	udf	#0
  4007d0:	00000020 	udf	#32
  4007d4:	0000006c 	udf	#108
  4007d8:	fffffdf8 	.inst	0xfffffdf8 ; undefined
  4007dc:	00000030 	udf	#48
  4007e0:	200e4100 	.inst	0x200e4100 ; undefined
  4007e4:	039e049d 	.inst	0x039e049d ; undefined
  4007e8:	48029342 	stlxrh	w2, w2, [x26]
  4007ec:	0ed3ddde 	.inst	0x0ed3ddde ; undefined
  4007f0:	00000000 	udf	#0
  4007f4:	00000010 	udf	#16
  4007f8:	00000090 	udf	#144
  4007fc:	fffffe04 	.inst	0xfffffe04 ; undefined
  400800:	00000004 	udf	#4
  400804:	00000000 	udf	#0
  400808:	0000001c 	udf	#28
  40080c:	000000a4 	udf	#164
  400810:	fffffdf4 	.inst	0xfffffdf4 ; undefined
  400814:	0000001c 	udf	#28
  400818:	100e4100 	adr	x0, 41d038 <__FRAME_END__+0x1c7f8>
  40081c:	019e029d 	.inst	0x019e029d ; undefined
  400820:	0eddde45 	.inst	0x0eddde45 ; undefined
  400824:	00000000 	udf	#0
  400828:	00000014 	udf	#20
  40082c:	000000c4 	udf	#196
  400830:	fffffdf0 	.inst	0xfffffdf0 ; undefined
  400834:	000000e0 	udf	#224
  400838:	200e4100 	.inst	0x200e4100 ; undefined
  40083c:	00000e76 	udf	#3702

0000000000400840 <__FRAME_END__>:
  400840:	00000000 	udf	#0

Disassembly of section .init_array:

000000000041fde8 <__frame_dummy_init_array_entry>:
  41fde8:	00400600 	.inst	0x00400600 ; undefined
  41fdec:	00000000 	udf	#0

Disassembly of section .fini_array:

000000000041fdf0 <__do_global_dtors_aux_fini_array_entry>:
  41fdf0:	004005d0 	.inst	0x004005d0 ; undefined
  41fdf4:	00000000 	udf	#0

Disassembly of section .dynamic:

000000000041fdf8 <_DYNAMIC>:
  41fdf8:	00000001 	udf	#1
  41fdfc:	00000000 	udf	#0
  41fe00:	00000019 	udf	#25
  41fe04:	00000000 	udf	#0
  41fe08:	0000000c 	udf	#12
  41fe0c:	00000000 	udf	#0
  41fe10:	00400498 	.inst	0x00400498 ; undefined
  41fe14:	00000000 	udf	#0
  41fe18:	0000000d 	udf	#13
  41fe1c:	00000000 	udf	#0
  41fe20:	00400700 	.inst	0x00400700 ; undefined
  41fe24:	00000000 	udf	#0
  41fe28:	00000019 	udf	#25
  41fe2c:	00000000 	udf	#0
  41fe30:	0041fde8 	.inst	0x0041fde8 ; undefined
  41fe34:	00000000 	udf	#0
  41fe38:	0000001b 	udf	#27
  41fe3c:	00000000 	udf	#0
  41fe40:	00000008 	udf	#8
  41fe44:	00000000 	udf	#0
  41fe48:	0000001a 	udf	#26
  41fe4c:	00000000 	udf	#0
  41fe50:	0041fdf0 	.inst	0x0041fdf0 ; undefined
  41fe54:	00000000 	udf	#0
  41fe58:	0000001c 	udf	#28
  41fe5c:	00000000 	udf	#0
  41fe60:	00000008 	udf	#8
  41fe64:	00000000 	udf	#0
  41fe68:	6ffffef5 	.inst	0x6ffffef5 ; undefined
  41fe6c:	00000000 	udf	#0
  41fe70:	00400298 	.inst	0x00400298 ; undefined
  41fe74:	00000000 	udf	#0
  41fe78:	00000005 	udf	#5
  41fe7c:	00000000 	udf	#0
  41fe80:	00400348 	.inst	0x00400348 ; undefined
  41fe84:	00000000 	udf	#0
  41fe88:	00000006 	udf	#6
  41fe8c:	00000000 	udf	#0
  41fe90:	004002b8 	.inst	0x004002b8 ; undefined
  41fe94:	00000000 	udf	#0
  41fe98:	0000000a 	udf	#10
  41fe9c:	00000000 	udf	#0
  41fea0:	0000007e 	udf	#126
  41fea4:	00000000 	udf	#0
  41fea8:	0000000b 	udf	#11
  41feac:	00000000 	udf	#0
  41feb0:	00000018 	udf	#24
  41feb4:	00000000 	udf	#0
  41feb8:	00000015 	udf	#21
	...
  41fec8:	00000003 	udf	#3
  41fecc:	00000000 	udf	#0
  41fed0:	0041ffe8 	.inst	0x0041ffe8 ; undefined
  41fed4:	00000000 	udf	#0
  41fed8:	00000002 	udf	#2
  41fedc:	00000000 	udf	#0
  41fee0:	00000048 	udf	#72
  41fee4:	00000000 	udf	#0
  41fee8:	00000014 	udf	#20
  41feec:	00000000 	udf	#0
  41fef0:	00000007 	udf	#7
  41fef4:	00000000 	udf	#0
  41fef8:	00000017 	udf	#23
  41fefc:	00000000 	udf	#0
  41ff00:	00400450 	.inst	0x00400450 ; undefined
  41ff04:	00000000 	udf	#0
  41ff08:	00000007 	udf	#7
  41ff0c:	00000000 	udf	#0
  41ff10:	00400408 	.inst	0x00400408 ; undefined
  41ff14:	00000000 	udf	#0
  41ff18:	00000008 	udf	#8
  41ff1c:	00000000 	udf	#0
  41ff20:	00000048 	udf	#72
  41ff24:	00000000 	udf	#0
  41ff28:	00000009 	udf	#9
  41ff2c:	00000000 	udf	#0
  41ff30:	00000018 	udf	#24
  41ff34:	00000000 	udf	#0
  41ff38:	6ffffffe 	.inst	0x6ffffffe ; undefined
  41ff3c:	00000000 	udf	#0
  41ff40:	004003d8 	.inst	0x004003d8 ; undefined
  41ff44:	00000000 	udf	#0
  41ff48:	6fffffff 	.inst	0x6fffffff ; undefined
  41ff4c:	00000000 	udf	#0
  41ff50:	00000001 	udf	#1
  41ff54:	00000000 	udf	#0
  41ff58:	6ffffff0 	.inst	0x6ffffff0 ; undefined
  41ff5c:	00000000 	udf	#0
  41ff60:	004003c6 	.inst	0x004003c6 ; undefined
	...

Disassembly of section .got:

000000000041ffc8 <_GLOBAL_OFFSET_TABLE_>:
  41ffc8:	0041fdf8 	.inst	0x0041fdf8 ; undefined
	...

Disassembly of section .got.plt:

000000000041ffe8 <.got.plt>:
	...
  420000:	004004b0 	.inst	0x004004b0 ; undefined
  420004:	00000000 	udf	#0
  420008:	004004b0 	.inst	0x004004b0 ; undefined
  42000c:	00000000 	udf	#0
  420010:	004004b0 	.inst	0x004004b0 ; undefined
  420014:	00000000 	udf	#0

Disassembly of section .data:

0000000000420018 <__data_start>:
	...

0000000000420020 <__dso_handle>:
	...

0000000000420028 <data>:
  420028:	00000001 	udf	#1
  42002c:	00000064 	udf	#100
  420030:	00000005 	udf	#5
  420034:	000000c8 	udf	#200
  420038:	00000006 	udf	#6
  42003c:	0000012c 	udf	#300
  420040:	00000007 	udf	#7
  420044:	000002bc 	udf	#700
  420048:	00000008 	udf	#8
  42004c:	00000384 	udf	#900
  420050:	00000009 	udf	#9
  420054:	000000fa 	udf	#250
  420058:	0000000a 	udf	#10
  42005c:	00000190 	udf	#400
  420060:	0000000b 	udf	#11
  420064:	00000258 	udf	#600
  420068:	0000000c 	udf	#12
  42006c:	00000320 	udf	#800
  420070:	0000000d 	udf	#13
  420074:	000005dc 	udf	#1500
  420078:	0000000e 	udf	#14
  42007c:	000004b0 	udf	#1200
  420080:	0000000f 	udf	#15
  420084:	0000006e 	udf	#110
  420088:	00000010 	udf	#16
  42008c:	0000008c 	udf	#140
  420090:	00000011 	udf	#17
  420094:	00000085 	udf	#133
  420098:	00000012 	udf	#18
  42009c:	0000000a 	udf	#10

Disassembly of section .bss:

00000000004200a0 <completed.0>:
	...

Disassembly of section .comment:

0000000000000000 <.comment>:
   0:	3a434347 	ccmn	w26, w3, #0x7, mi  // mi = first
   4:	4e472820 	trn1	v0.8h, v1.8h, v7.8h
   8:	31202955 	adds	w21, w10, #0x80a
   c:	2e332e30 	uqsub	v16.8b, v17.8b, v19.8b
  10:	地址 0x0000000000000010 越界。


Disassembly of section .gnu.build.attributes:

00000000004200a8 <.gnu.build.attributes>:
  4200a8:	00000008 	udf	#8
  4200ac:	00000010 	udf	#16
  4200b0:	00000100 	udf	#256
  4200b4:	01244147 	.inst	0x01244147 ; undefined
  4200b8:	00316133 	.inst	0x00316133 ; NYI
  4200bc:	00400500 	.inst	0x00400500 ; undefined
  4200c0:	00000000 	udf	#0
  4200c4:	0040053c 	.inst	0x0040053c ; undefined
  4200c8:	00000000 	udf	#0
  4200cc:	00000008 	udf	#8
  4200d0:	00000010 	udf	#16
  4200d4:	00000100 	udf	#256
  4200d8:	01244147 	.inst	0x01244147 ; undefined
  4200dc:	00316133 	.inst	0x00316133 ; NYI
  4200e0:	00400544 	.inst	0x00400544 ; undefined
  4200e4:	00000000 	udf	#0
  4200e8:	00400558 	.inst	0x00400558 ; undefined
  4200ec:	00000000 	udf	#0
  4200f0:	00000008 	udf	#8
  4200f4:	00000010 	udf	#16
  4200f8:	00000100 	udf	#256
  4200fc:	01244147 	.inst	0x01244147 ; undefined
  420100:	00316133 	.inst	0x00316133 ; NYI
  420104:	00400498 	.inst	0x00400498 ; undefined
  420108:	00000000 	udf	#0
  42010c:	004004a8 	.inst	0x004004a8 ; undefined
  420110:	00000000 	udf	#0
  420114:	00000008 	udf	#8
  420118:	00000010 	udf	#16
  42011c:	00000100 	udf	#256
  420120:	01244147 	.inst	0x01244147 ; undefined
  420124:	00316133 	.inst	0x00316133 ; NYI
  420128:	00400700 	.inst	0x00400700 ; undefined
  42012c:	00000000 	udf	#0
  420130:	0040070c 	.inst	0x0040070c ; undefined
  420134:	00000000 	udf	#0
  420138:	00000008 	udf	#8
  42013c:	00000010 	udf	#16
  420140:	00000100 	udf	#256
  420144:	01244147 	.inst	0x01244147 ; undefined
  420148:	00316133 	.inst	0x00316133 ; NYI
  42014c:	00400700 	.inst	0x00400700 ; undefined
  420150:	00000000 	udf	#0
  420154:	00400700 	.inst	0x00400700 ; undefined
  420158:	00000000 	udf	#0
  42015c:	00000008 	udf	#8
  420160:	00000010 	udf	#16
  420164:	00000100 	udf	#256
  420168:	01244147 	.inst	0x01244147 ; undefined
  42016c:	00316133 	.inst	0x00316133 ; NYI
  420170:	004004a8 	.inst	0x004004a8 ; undefined
  420174:	00000000 	udf	#0
  420178:	004004b0 	.inst	0x004004b0 ; undefined
  42017c:	00000000 	udf	#0
  420180:	00000008 	udf	#8
  420184:	00000010 	udf	#16
  420188:	00000100 	udf	#256
  42018c:	01244147 	.inst	0x01244147 ; undefined
  420190:	00316133 	.inst	0x00316133 ; NYI
  420194:	0040070c 	.inst	0x0040070c ; undefined
  420198:	00000000 	udf	#0
  42019c:	00400714 	.inst	0x00400714 ; undefined
  4201a0:	00000000 	udf	#0

Disassembly of section .debug_aranges:

0000000000000000 <.debug_aranges>:
   0:	0000002c 	udf	#44
   4:	00000002 	udf	#2
   8:	00080000 	.inst	0x00080000 ; undefined
   c:	00000000 	udf	#0
  10:	00400604 	.inst	0x00400604 ; undefined
  14:	00000000 	udf	#0
  18:	000000fc 	udf	#252
	...

Disassembly of section .debug_info:

0000000000000000 <.debug_info>:
   0:	0000011e 	udf	#286
   4:	00000004 	udf	#4
   8:	01080000 	.inst	0x01080000 ; undefined
   c:	00000036 	udf	#54
  10:	0000000c 	udf	#12
  14:	00001e00 	udf	#7680
  18:	40060400 	.inst	0x40060400 ; undefined
  1c:	00000000 	udf	#0
  20:	0000fc00 	udf	#64512
	...
  2c:	00680200 	.inst	0x00680200 ; undefined
  30:	01080000 	.inst	0x01080000 ; undefined
  34:	0055082e 	.inst	0x0055082e ; undefined
  38:	6b030000 	subs	w0, w0, w3
  3c:	01007965 	.inst	0x01007965 ; undefined
  40:	0055082f 	.inst	0x0055082f ; undefined
  44:	04000000 	add	z0.b, p0/m, z0.b, z0.b
  48:	00000018 	udf	#24
  4c:	55083001 	.inst	0x55083001 ; undefined
  50:	04000000 	add	z0.b, p0/m, z0.b, z0.b
  54:	05040500 	.inst	0x05040500 ; undefined
  58:	00746e69 	.inst	0x00746e69 ; undefined
  5c:	00002d06 	udf	#11526
  60:	00006c00 	udf	#27648
  64:	006c0700 	.inst	0x006c0700 ; undefined
  68:	000e0000 	.inst	0x000e0000 ; undefined
  6c:	05070808 	.inst	0x05070808 ; undefined
  70:	09000000 	.inst	0x09000000 ; undefined
  74:	0000006d 	udf	#109
  78:	5c0d3701 	ldr	d1, 1a758 <__abi_tag-0x3e5b20>
  7c:	09000000 	.inst	0x09000000 ; undefined
  80:	42002803 	.inst	0x42002803 ; undefined
  84:	00000000 	udf	#0
  88:	00720a00 	.inst	0x00720a00 ; undefined
  8c:	4c010000 	.inst	0x4c010000 ; undefined
  90:	00005501 	udf	#21761
  94:	40062000 	.inst	0x40062000 ; undefined
  98:	00000000 	udf	#0
  9c:	0000e000 	udf	#57344
  a0:	00000000 	udf	#0
  a4:	f49c0100 	.inst	0xf49c0100 ; undefined
  a8:	0b000000 	add	w0, w0, w0
  ac:	4c010078 	.inst	0x4c010078 ; undefined
  b0:	00005501 	udf	#21761
  b4:	6c910200 	stp	d0, d0, [x16], #272
  b8:	0000170c 	udf	#5900
  bc:	074e0100 	.inst	0x074e0100 ; undefined
  c0:	00000055 	udf	#85
  c4:	0d7c9102 	.inst	0x0d7c9102 ; undefined
  c8:	0064696d 	.inst	0x0064696d ; undefined
  cc:	550f4e01 	.inst	0x550f4e01 ; undefined
  d0:	02000000 	.inst	0x02000000 ; undefined
  d4:	750d7091 	.inst	0x750d7091 ; undefined
  d8:	4e010070 	tbl	v16.16b, {v3.16b}, v1.16b
  dc:	00005514 	udf	#21780
  e0:	78910200 	ldursh	x0, [x16, #-240]
  e4:	776f6c0d 	.inst	0x776f6c0d ; undefined
  e8:	184e0100 	ldr	w0, 9c108 <__abi_tag-0x364170>
  ec:	00000055 	udf	#85
  f0:	00749102 	.inst	0x00749102 ; undefined
  f4:	0000630e 	udf	#25358
  f8:	01470100 	.inst	0x01470100 ; undefined
  fc:	00000055 	udf	#85
 100:	00400604 	.inst	0x00400604 ; undefined
 104:	00000000 	udf	#0
 108:	0000001c 	udf	#28
 10c:	00000000 	udf	#0
 110:	720f9c01 	ands	w1, w0, #0x1fe01fe
 114:	01000000 	.inst	0x01000000 ; undefined
 118:	00550249 	.inst	0x00550249 ; undefined
 11c:	00100000 	.inst	0x00100000 ; undefined
	...

Disassembly of section .debug_abbrev:

0000000000000000 <.debug_abbrev>:
   0:	25011101 	cmpge	p1.b, p4/z, z8.b, #1
   4:	030b130e 	.inst	0x030b130e ; undefined
   8:	110e1b0e 	add	w14, w24, #0x386
   c:	10071201 	adr	x1, e24c <__abi_tag-0x3f202c>
  10:	02000017 	.inst	0x02000017 ; undefined
  14:	0e030113 	tbl	v19.8b, {v8.16b}, v3.8b
  18:	0b3a0b0b 	add	w11, w24, w26, uxtb #2
  1c:	0b390b3b 	add	w27, w25, w25, uxtb #2
  20:	00001301 	udf	#4865
  24:	03000d03 	.inst	0x03000d03 ; undefined
  28:	3b0b3a08 	.inst	0x3b0b3a08 ; undefined
  2c:	490b390b 	.inst	0x490b390b ; undefined
  30:	000b3813 	.inst	0x000b3813 ; undefined
  34:	000d0400 	.inst	0x000d0400 ; undefined
  38:	0b3a0e03 	add	w3, w16, w26, uxtb #3
  3c:	0b390b3b 	add	w27, w25, w25, uxtb #2
  40:	0b381349 	add	w9, w26, w24, uxtb #4
  44:	24050000 	cmphs	p0.b, p0/z, z0.b, z5.b
  48:	3e0b0b00 	.inst	0x3e0b0b00 ; undefined
  4c:	0008030b 	.inst	0x0008030b ; undefined
  50:	01010600 	.inst	0x01010600 ; undefined
  54:	13011349 	sbfx	w9, w26, #1, #4
  58:	21070000 	.inst	0x21070000 ; undefined
  5c:	2f134900 	.inst	0x2f134900 ; undefined
  60:	0800000b 	stxrb	w0, w11, [x0]
  64:	0b0b0024 	add	w4, w1, w11
  68:	0e030b3e 	.inst	0x0e030b3e ; undefined
  6c:	34090000 	cbz	w0, 1206c <__abi_tag-0x3ee20c>
  70:	3a0e0300 	adcs	w0, w24, w14
  74:	390b3b0b 	strb	w11, [x24, #718]
  78:	3f13490b 	.inst	0x3f13490b ; undefined
  7c:	00180219 	.inst	0x00180219 ; undefined
  80:	012e0a00 	.inst	0x012e0a00 ; undefined
  84:	0e03193f 	uzp1	v31.8b, v9.8b, v3.8b
  88:	0b3b0b3a 	add	w26, w25, w27, uxtb #2
  8c:	13490b39 	.inst	0x13490b39 ; undefined
  90:	07120111 	.inst	0x07120111 ; undefined
  94:	42971840 	.inst	0x42971840 ; undefined
  98:	00130119 	.inst	0x00130119 ; undefined
  9c:	00050b00 	.inst	0x00050b00 ; undefined
  a0:	0b3a0803 	add	w3, w0, w26, uxtb #2
  a4:	0b390b3b 	add	w27, w25, w25, uxtb #2
  a8:	18021349 	ldr	w9, 4310 <__abi_tag-0x3fbf68>
  ac:	340c0000 	cbz	w0, 180ac <__abi_tag-0x3e81cc>
  b0:	3a0e0300 	adcs	w0, w24, w14
  b4:	390b3b0b 	strb	w11, [x24, #718]
  b8:	0213490b 	.inst	0x0213490b ; undefined
  bc:	0d000018 	st1	{v24.b}[0], [x0]
  c0:	08030034 	stxrb	w3, w20, [x1]
  c4:	0b3b0b3a 	add	w26, w25, w27, uxtb #2
  c8:	13490b39 	.inst	0x13490b39 ; undefined
  cc:	00001802 	udf	#6146
  d0:	3f012e0e 	.inst	0x3f012e0e ; undefined
  d4:	3a0e0319 	adcs	w25, w24, w14
  d8:	390b3b0b 	strb	w11, [x24, #718]
  dc:	1113490b 	add	w11, w8, #0x4d2
  e0:	40071201 	.inst	0x40071201 ; undefined
  e4:	19429618 	.inst	0x19429618 ; undefined
  e8:	2e0f0000 	ext	v0.8b, v0.8b, v15.8b, #0
  ec:	03193f01 	.inst	0x03193f01 ; undefined
  f0:	3b0b3a0e 	.inst	0x3b0b3a0e ; undefined
  f4:	490b390b 	.inst	0x490b390b ; undefined
  f8:	00193c13 	.inst	0x00193c13 ; undefined
  fc:	00181000 	.inst	0x00181000 ; undefined
 100:	地址 0x0000000000000100 越界。


Disassembly of section .debug_line:

0000000000000000 <.debug_line>:
   0:	00000075 	udf	#117
   4:	001b0003 	.inst	0x001b0003 ; undefined
   8:	01040000 	.inst	0x01040000 ; undefined
   c:	000d0efb 	.inst	0x000d0efb ; undefined
  10:	01010101 	.inst	0x01010101 ; undefined
  14:	01000000 	.inst	0x01000000 ; undefined
  18:	00010000 	.inst	0x00010000 ; undefined
  1c:	632e7362 	.inst	0x632e7362 ; undefined
  20:	00000000 	udf	#0
  24:	00010500 	.inst	0x00010500 ; undefined
  28:	06040209 	.inst	0x06040209 ; undefined
  2c:	00000040 	udf	#64
  30:	c7030000 	.inst	0xc7030000 ; undefined
  34:	02050100 	.inst	0x02050100 ; undefined
  38:	3d01052f 	str	b15, [x9, #65]
  3c:	31070531 	adds	w17, w9, #0x1c1
  40:	05210605 	ext	z5.b, z5.b, z16.b, #9
  44:	09052f0a 	.inst	0x09052f0a ; undefined
  48:	2110052f 	.inst	0x2110052f ; undefined
  4c:	053c0905 	ext	z5.b, z5.b, z8.b, #226
  50:	08052f13 	stxrb	w5, w19, [x24]
  54:	3d0a0566 	str	b6, [x11, #641]
  58:	053d0e05 	ext	z5.b, z5.b, z16.b, #235
  5c:	0a058815 	.inst	0x0a058815 ; undefined
  60:	3d050566 	str	b6, [x11, #321]
  64:	05501305 	mov	z5.h, p0/z, #-104
  68:	3c6f0309 	.inst	0x3c6f0309 ; undefined
  6c:	1d030a05 	.inst	0x1d030a05 ; undefined
  70:	2101054a 	.inst	0x2101054a ; undefined
  74:	01000202 	.inst	0x01000202 ; undefined
  78:	地址 0x0000000000000078 越界。


Disassembly of section .debug_str:

0000000000000000 <.debug_str>:
   0:	632e7362 	.inst	0x632e7362 ; undefined
   4:	6e6f6c00 	umin	v0.8h, v0.8h, v15.8h
   8:	6e752067 	usubl2	v7.4s, v3.8h, v21.8h
   c:	6e676973 	.inst	0x6e676973 ; undefined
  10:	69206465 	stgp	x5, x25, [x3, #-1024]
  14:	6600746e 	.inst	0x6600746e ; undefined
  18:	756c6176 	.inst	0x756c6176 ; undefined
  1c:	682f0065 	.inst	0x682f0065 ; undefined
  20:	2f656d6f 	.inst	0x2f656d6f ; undefined
  24:	75677567 	.inst	0x75677567 ; undefined
  28:	4d2f696a 	.inst	0x4d2f696a ; undefined
  2c:	72616c61 	.inst	0x72616c61 ; undefined
  30:	656c6164 	fnmls	z4.h, p0/m, z11.h, z12.h
  34:	4e47006e 	.inst	0x4e47006e ; undefined
  38:	31432055 	adds	w21, w2, #0xc8, lsl #12
  3c:	30312037 	adr	x23, 62441 <__abi_tag-0x39de37>
  40:	312e332e 	adds	w14, w25, #0xb8c
  44:	6c6d2d20 	ldnp	d0, d11, [x9, #-304]
  48:	6c747469 	ldnp	d9, d29, [x3, #-192]
  4c:	6e652d65 	uqsub	v5.8h, v11.8h, v5.8h
  50:	6e616964 	fcvtxn2	v4.4s, v11.2d
  54:	616d2d20 	.inst	0x616d2d20 ; undefined
  58:	6c3d6962 	stnp	d2, d26, [x11, #-48]
  5c:	20343670 	.inst	0x20343670 ; undefined
  60:	6d00672d 	stp	d13, d25, [x25]
  64:	006e6961 	.inst	0x006e6961 ; undefined
  68:	41544144 	.inst	0x41544144 ; undefined
  6c:	74616400 	.inst	0x74616400 ; undefined
  70:	69620061 	ldpsw	x1, x0, [x3, #-240]
  74:	7972616e 	ldrh	w14, [x11, #6448]
  78:	6165735f 	.inst	0x6165735f ; undefined
  7c:	00686372 	.inst	0x00686372 ; undefined
