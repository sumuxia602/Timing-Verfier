
ud：     文件格式 elf64-littleaarch64


Disassembly of section .interp:

0000000000400238 <.interp>:
  400238:	62696c2f 	.inst	0x62696c2f ; undefined
  40023c:	2d646c2f 	ldp	s15, s27, [x1, #-224]
  400240:	756e696c 	.inst	0x756e696c ; undefined
  400244:	61612d78 	.inst	0x61612d78 ; undefined
  400248:	36686372 	tbz	w18, #13, 400eb4 <__FRAME_END__+0x108>
  40024c:	6f732e34 	.inst	0x6f732e34 ; undefined
  400250:	地址 0x0000000000400250 越界。


Disassembly of section .note.gnu.build-id:

0000000000400254 <.note.gnu.build-id>:
  400254:	00000004 	udf	#4
  400258:	00000014 	udf	#20
  40025c:	00000003 	udf	#3
  400260:	00554e47 	.inst	0x00554e47 ; undefined
  400264:	04e09ca8 	lsl	z8.d, z5.d, #32
  400268:	7feb6f14 	.inst	0x7feb6f14 ; undefined
  40026c:	262e594b 	.inst	0x262e594b ; undefined
  400270:	986fe06a 	ldrsw	x10, 4dfe7c <a+0xbfe4c>
  400274:	11d75249 	.inst	0x11d75249 ; undefined

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
  40037c:	34332e32 	cbz	w18, 466940 <a+0x46910>
  400380:	54495f00 	b.eq	492f60 <a+0x72f30>  // b.none
  400384:	65645f4d 	fnmla	z13.h, p7/m, z26.h, z4.h
  400388:	69676572 	ldpsw	x18, x25, [x11, #-200]
  40038c:	72657473 	.inst	0x72657473 ; undefined
  400390:	6c434d54 	ldnp	d20, d19, [x10, #48]
  400394:	54656e6f 	b.nv	4cb160 <a+0xab130>
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

Disassembly of section .rodata:

0000000000400c7c <_IO_stdin_used>:
  400c7c:	00020001 	.inst	0x00020001 ; undefined

Disassembly of section .eh_frame_hdr:

0000000000400c80 <__GNU_EH_FRAME_HDR>:
  400c80:	3b031b01 	.inst	0x3b031b01 ; undefined
  400c84:	0000004c 	udf	#76
  400c88:	00000008 	udf	#8
  400c8c:	fffff880 	.inst	0xfffff880 ; undefined
  400c90:	00000064 	udf	#100
  400c94:	fffff8c0 	.inst	0xfffff8c0 ; undefined
  400c98:	00000078 	udf	#120
  400c9c:	fffff8e0 	.inst	0xfffff8e0 ; undefined
  400ca0:	00000090 	udf	#144
  400ca4:	fffff910 	.inst	0xfffff910 ; undefined
  400ca8:	000000a4 	udf	#164
  400cac:	fffff950 	.inst	0xfffff950 ; undefined
  400cb0:	000000b8 	udf	#184
  400cb4:	fffff980 	.inst	0xfffff980 ; undefined
  400cb8:	000000dc 	udf	#220
  400cbc:	fffff984 	.inst	0xfffff984 ; undefined
  400cc0:	000000f0 	udf	#240
  400cc4:	fffffb18 	.inst	0xfffffb18 ; undefined
  400cc8:	00000110 	udf	#272

Disassembly of section .eh_frame:

0000000000400cd0 <__FRAME_END__-0xdc>:
  400cd0:	00000010 	udf	#16
  400cd4:	00000000 	udf	#0
  400cd8:	00527a01 	.inst	0x00527a01 ; undefined
  400cdc:	011e7804 	.inst	0x011e7804 ; undefined
  400ce0:	001f0c1b 	.inst	0x001f0c1b ; undefined
  400ce4:	00000010 	udf	#16
  400ce8:	00000018 	udf	#24
  400cec:	fffff814 	.inst	0xfffff814 ; undefined
  400cf0:	0000003c 	udf	#60
  400cf4:	1e074100 	.inst	0x1e074100 ; undefined
  400cf8:	00000014 	udf	#20
  400cfc:	0000002c 	udf	#44
  400d00:	fffff840 	.inst	0xfffff840 ; undefined
  400d04:	00000004 	udf	#4
	...
  400d10:	00000010 	udf	#16
  400d14:	00000044 	udf	#68
  400d18:	fffff848 	.inst	0xfffff848 ; undefined
  400d1c:	00000030 	udf	#48
  400d20:	00000000 	udf	#0
  400d24:	00000010 	udf	#16
  400d28:	00000058 	udf	#88
  400d2c:	fffff864 	.inst	0xfffff864 ; undefined
  400d30:	0000003c 	udf	#60
  400d34:	00000000 	udf	#0
  400d38:	00000020 	udf	#32
  400d3c:	0000006c 	udf	#108
  400d40:	fffff890 	.inst	0xfffff890 ; undefined
  400d44:	00000030 	udf	#48
  400d48:	200e4100 	.inst	0x200e4100 ; undefined
  400d4c:	039e049d 	.inst	0x039e049d ; undefined
  400d50:	48029342 	stlxrh	w2, w2, [x26]
  400d54:	0ed3ddde 	.inst	0x0ed3ddde ; undefined
  400d58:	00000000 	udf	#0
  400d5c:	00000010 	udf	#16
  400d60:	00000090 	udf	#144
  400d64:	fffff89c 	.inst	0xfffff89c ; undefined
  400d68:	00000004 	udf	#4
  400d6c:	00000000 	udf	#0
  400d70:	0000001c 	udf	#28
  400d74:	000000a4 	udf	#164
  400d78:	fffff88c 	.inst	0xfffff88c ; undefined
  400d7c:	00000194 	udf	#404
  400d80:	300e4100 	adr	x0, 41d5a1 <__FRAME_END__+0x1c7f5>
  400d84:	059e069d 	mov	z29.s, p14/z, #52
  400d88:	ddde6302 	.inst	0xddde6302 ; undefined
  400d8c:	0000000e 	udf	#14
  400d90:	00000018 	udf	#24
  400d94:	000000c4 	udf	#196
  400d98:	fffffa00 	.inst	0xfffffa00 ; undefined
  400d9c:	000004d0 	udf	#1232
  400da0:	d00e4100 	adrp	x0, 1cc22000 <__bss_end__+0x1c617c10>
  400da4:	0132031f 	.inst	0x0132031f ; undefined
  400da8:	0000000e 	udf	#14

0000000000400dac <__FRAME_END__>:
  400dac:	00000000 	udf	#0

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
  41fe20:	00400c68 	.inst	0x00400c68 ; undefined
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

Disassembly of section .bss:

0000000000420028 <completed.0>:
	...

0000000000420030 <a>:
	...

00000000006084b0 <b>:
	...

0000000000609450 <x>:
	...

Disassembly of section .comment:

0000000000000000 <.comment>:
   0:	3a434347 	ccmn	w26, w3, #0x7, mi  // mi = first
   4:	4e472820 	trn1	v0.8h, v1.8h, v7.8h
   8:	31202955 	adds	w21, w10, #0x80a
   c:	2e332e30 	uqsub	v16.8b, v17.8b, v19.8b
  10:	地址 0x0000000000000010 越界。


Disassembly of section .gnu.build.attributes:

000000000060a3f0 <.gnu.build.attributes>:
  60a3f0:	00000008 	udf	#8
  60a3f4:	00000010 	udf	#16
  60a3f8:	00000100 	udf	#256
  60a3fc:	01244147 	.inst	0x01244147 ; undefined
  60a400:	00316133 	.inst	0x00316133 ; NYI
  60a404:	00400500 	.inst	0x00400500 ; undefined
  60a408:	00000000 	udf	#0
  60a40c:	0040053c 	.inst	0x0040053c ; undefined
  60a410:	00000000 	udf	#0
  60a414:	00000008 	udf	#8
  60a418:	00000010 	udf	#16
  60a41c:	00000100 	udf	#256
  60a420:	01244147 	.inst	0x01244147 ; undefined
  60a424:	00316133 	.inst	0x00316133 ; NYI
  60a428:	00400544 	.inst	0x00400544 ; undefined
  60a42c:	00000000 	udf	#0
  60a430:	00400558 	.inst	0x00400558 ; undefined
  60a434:	00000000 	udf	#0
  60a438:	00000008 	udf	#8
  60a43c:	00000010 	udf	#16
  60a440:	00000100 	udf	#256
  60a444:	01244147 	.inst	0x01244147 ; undefined
  60a448:	00316133 	.inst	0x00316133 ; NYI
  60a44c:	00400498 	.inst	0x00400498 ; undefined
  60a450:	00000000 	udf	#0
  60a454:	004004a8 	.inst	0x004004a8 ; undefined
  60a458:	00000000 	udf	#0
  60a45c:	00000008 	udf	#8
  60a460:	00000010 	udf	#16
  60a464:	00000100 	udf	#256
  60a468:	01244147 	.inst	0x01244147 ; undefined
  60a46c:	00316133 	.inst	0x00316133 ; NYI
  60a470:	00400c68 	.inst	0x00400c68 ; undefined
  60a474:	00000000 	udf	#0
  60a478:	00400c74 	.inst	0x00400c74 ; undefined
  60a47c:	00000000 	udf	#0
  60a480:	00000008 	udf	#8
  60a484:	00000010 	udf	#16
  60a488:	00000100 	udf	#256
  60a48c:	01244147 	.inst	0x01244147 ; undefined
  60a490:	00316133 	.inst	0x00316133 ; NYI
  60a494:	00400c68 	.inst	0x00400c68 ; undefined
  60a498:	00000000 	udf	#0
  60a49c:	00400c68 	.inst	0x00400c68 ; undefined
  60a4a0:	00000000 	udf	#0
  60a4a4:	00000008 	udf	#8
  60a4a8:	00000010 	udf	#16
  60a4ac:	00000100 	udf	#256
  60a4b0:	01244147 	.inst	0x01244147 ; undefined
  60a4b4:	00316133 	.inst	0x00316133 ; NYI
  60a4b8:	004004a8 	.inst	0x004004a8 ; undefined
  60a4bc:	00000000 	udf	#0
  60a4c0:	004004b0 	.inst	0x004004b0 ; undefined
  60a4c4:	00000000 	udf	#0
  60a4c8:	00000008 	udf	#8
  60a4cc:	00000010 	udf	#16
  60a4d0:	00000100 	udf	#256
  60a4d4:	01244147 	.inst	0x01244147 ; undefined
  60a4d8:	00316133 	.inst	0x00316133 ; NYI
  60a4dc:	00400c74 	.inst	0x00400c74 ; undefined
  60a4e0:	00000000 	udf	#0
  60a4e4:	00400c7c 	.inst	0x00400c7c ; undefined
  60a4e8:	00000000 	udf	#0

Disassembly of section .debug_aranges:

0000000000000000 <.debug_aranges>:
   0:	0000002c 	udf	#44
   4:	00000002 	udf	#2
   8:	00080000 	.inst	0x00080000 ; undefined
   c:	00000000 	udf	#0
  10:	00400604 	.inst	0x00400604 ; undefined
  14:	00000000 	udf	#0
  18:	00000664 	udf	#1636
	...

Disassembly of section .debug_info:

0000000000000000 <.debug_info>:
   0:	00000194 	udf	#404
   4:	00000004 	udf	#4
   8:	01080000 	.inst	0x01080000 ; undefined
   c:	00000031 	udf	#49
  10:	00001b0c 	udf	#6924
  14:	00005e00 	udf	#24064
  18:	40060400 	.inst	0x40060400 ; undefined
  1c:	00000000 	udf	#0
  20:	00066400 	.inst	0x00066400 ; undefined
	...
  2c:	004c0200 	.inst	0x004c0200 ; undefined
  30:	00450000 	.inst	0x00450000 ; undefined
  34:	45030000 	.inst	0x45030000 ; undefined
  38:	f3000000 	.inst	0xf3000000 ; undefined
  3c:	00450301 	.inst	0x00450301 ; undefined
  40:	01f30000 	.inst	0x01f30000 ; undefined
  44:	07080400 	.inst	0x07080400 ; undefined
  48:	00000000 	udf	#0
  4c:	12050804 	and	w4, w0, #0x38000000
  50:	05000000 	orr	z0.s, z0.s, #0x1
  54:	4a010061 	eor	w1, w3, w1
  58:	00002d0a 	udf	#11530
  5c:	30030900 	adr	x0, 617d <__abi_tag-0x3fa0fb>
  60:	00004200 	udf	#16896
  64:	02000000 	.inst	0x02000000 ; undefined
  68:	0000004c 	udf	#76
  6c:	00000078 	udf	#120
  70:	00004503 	udf	#17667
  74:	0001f300 	.inst	0x0001f300 ; undefined
  78:	01006205 	.inst	0x01006205 ; undefined
  7c:	0067174a 	.inst	0x0067174a ; undefined
  80:	03090000 	.inst	0x03090000 ; undefined
  84:	006084b0 	.inst	0x006084b0 ; undefined
  88:	00000000 	udf	#0
  8c:	01007805 	.inst	0x01007805 ; undefined
  90:	00671f4a 	.inst	0x00671f4a ; undefined
  94:	03090000 	.inst	0x03090000 ; undefined
  98:	00609450 	.inst	0x00609450 ; undefined
  9c:	00000000 	udf	#0
  a0:	00002a06 	udf	#10758
  a4:	05660100 	ext	z0.b, {z8.b, z9.b}, #48
  a8:	00000123 	udf	#291
  ac:	00400798 	.inst	0x00400798 ; undefined
  b0:	00000000 	udf	#0
  b4:	000004d0 	udf	#1232
  b8:	00000000 	udf	#0
  bc:	01239c01 	.inst	0x01239c01 ; undefined
  c0:	25070000 	cmpge	p0.b, p0/z, z0.b, #7
  c4:	01000000 	.inst	0x01000000 ; undefined
  c8:	01231066 	.inst	0x01231066 ; undefined
  cc:	91030000 	add	x0, x0, #0xc0
  d0:	6e0860bc 	ext	v28.16b, v5.16b, v8.16b, #12
  d4:	1a660100 	.inst	0x1a660100 ; undefined
  d8:	00000123 	udf	#291
  dc:	60b89103 	.inst	0x60b89103 ; undefined
  e0:	01006909 	.inst	0x01006909 ; undefined
  e4:	01230768 	.inst	0x01230768 ; undefined
  e8:	91020000 	add	x0, x0, #0x80
  ec:	006a097c 	.inst	0x006a097c ; undefined
  f0:	230a6801 	.inst	0x230a6801 ; undefined
  f4:	02000001 	.inst	0x02000001 ; undefined
  f8:	6b097891 	subs	w17, w4, w9, lsl #30
  fc:	0d680100 	.inst	0x0d680100 ; undefined
 100:	00000123 	udf	#291
 104:	09749102 	.inst	0x09749102 ; undefined
 108:	69010077 	stgp	x23, x0, [x3, #32]
 10c:	00004c08 	udf	#19464
 110:	68910200 	stgp	x0, x0, [x16], #544
 114:	01007909 	.inst	0x01007909 ; undefined
 118:	00670b69 	.inst	0x00670b69 ; undefined
 11c:	91030000 	add	x0, x0, #0xc0
 120:	0a0060c8 	and	w8, w6, w0, lsl #24
 124:	6e690504 	uhadd	v4.8h, v8.8h, v9.8h
 128:	200b0074 	.inst	0x200b0074 ; undefined
 12c:	01000000 	.inst	0x01000000 ; undefined
 130:	0604064e 	.inst	0x0604064e ; undefined
 134:	00000040 	udf	#64
 138:	01940000 	.inst	0x01940000 ; undefined
 13c:	00000000 	udf	#0
 140:	9c010000 	ldr	q0, 2140 <__abi_tag-0x3fe138>
 144:	01006909 	.inst	0x01006909 ; undefined
 148:	01230751 	.inst	0x01230751 ; undefined
 14c:	91020000 	add	x0, x0, #0x80
 150:	006a097c 	.inst	0x006a097c ; undefined
 154:	230a5101 	.inst	0x230a5101 ; undefined
 158:	02000001 	.inst	0x02000001 ; undefined
 15c:	250c7891 	bic	p1.b, p14/z, p4.b, p12.b
 160:	01000000 	.inst	0x01000000 ; undefined
 164:	01230d51 	.inst	0x01230d51 ; undefined
 168:	91020000 	add	x0, x0, #0x80
 16c:	006e096c 	.inst	0x006e096c ; undefined
 170:	23195101 	.inst	0x23195101 ; undefined
 174:	02000001 	.inst	0x02000001 ; undefined
 178:	7a0c6891 	.inst	0x7a0c6891 ; undefined
 17c:	01000000 	.inst	0x01000000 ; undefined
 180:	01232251 	.inst	0x01232251 ; undefined
 184:	91020000 	add	x0, x0, #0x80
 188:	00770964 	.inst	0x00770964 ; undefined
 18c:	4c0c5301 	.inst	0x4c0c5301 ; undefined
 190:	02000000 	.inst	0x02000000 ; undefined
 194:	00007091 	udf	#28817

Disassembly of section .debug_abbrev:

0000000000000000 <.debug_abbrev>:
   0:	25011101 	cmpge	p1.b, p4/z, z8.b, #1
   4:	030b130e 	.inst	0x030b130e ; undefined
   8:	110e1b0e 	add	w14, w24, #0x386
   c:	10071201 	adr	x1, e24c <__abi_tag-0x3f202c>
  10:	02000017 	.inst	0x02000017 ; undefined
  14:	13490101 	.inst	0x13490101 ; undefined
  18:	00001301 	udf	#4865
  1c:	49002103 	.inst	0x49002103 ; undefined
  20:	00052f13 	.inst	0x00052f13 ; undefined
  24:	00240400 	.inst	0x00240400 ; NYI
  28:	0b3e0b0b 	add	w11, w24, w30, uxtb #2
  2c:	00000e03 	udf	#3587
  30:	03003405 	.inst	0x03003405 ; undefined
  34:	3b0b3a08 	.inst	0x3b0b3a08 ; undefined
  38:	490b390b 	.inst	0x490b390b ; undefined
  3c:	02193f13 	.inst	0x02193f13 ; undefined
  40:	06000018 	.inst	0x06000018 ; undefined
  44:	193f012e 	.inst	0x193f012e ; undefined
  48:	0b3a0e03 	add	w3, w16, w26, uxtb #3
  4c:	0b390b3b 	add	w27, w25, w25, uxtb #2
  50:	13491927 	.inst	0x13491927 ; undefined
  54:	07120111 	.inst	0x07120111 ; undefined
  58:	42971840 	.inst	0x42971840 ; undefined
  5c:	00130119 	.inst	0x00130119 ; undefined
  60:	00050700 	.inst	0x00050700 ; undefined
  64:	0b3a0e03 	add	w3, w16, w26, uxtb #3
  68:	0b390b3b 	add	w27, w25, w25, uxtb #2
  6c:	18021349 	ldr	w9, 42d4 <__abi_tag-0x3fbfa4>
  70:	05080000 	.inst	0x05080000 ; undefined
  74:	3a080300 	adcs	w0, w24, w8
  78:	390b3b0b 	strb	w11, [x24, #718]
  7c:	0213490b 	.inst	0x0213490b ; undefined
  80:	09000018 	.inst	0x09000018 ; undefined
  84:	08030034 	stxrb	w3, w20, [x1]
  88:	0b3b0b3a 	add	w26, w25, w27, uxtb #2
  8c:	13490b39 	.inst	0x13490b39 ; undefined
  90:	00001802 	udf	#6146
  94:	0b00240a 	add	w10, w0, w0, lsl #9
  98:	030b3e0b 	.inst	0x030b3e0b ; undefined
  9c:	0b000008 	add	w8, w0, w0
  a0:	193f012e 	.inst	0x193f012e ; undefined
  a4:	0b3a0e03 	add	w3, w16, w26, uxtb #3
  a8:	0b390b3b 	add	w27, w25, w25, uxtb #2
  ac:	07120111 	.inst	0x07120111 ; undefined
  b0:	42961840 	.inst	0x42961840 ; undefined
  b4:	0c000019 	st4	{v25.8b-v28.8b}, [x0]
  b8:	0e030034 	tbl	v20.8b, {v1.16b}, v3.8b
  bc:	0b3b0b3a 	add	w26, w25, w27, uxtb #2
  c0:	13490b39 	.inst	0x13490b39 ; undefined
  c4:	00001802 	udf	#6146
	...

Disassembly of section .debug_line:

0000000000000000 <.debug_line>:
   0:	00000235 	udf	#565
   4:	001b0003 	.inst	0x001b0003 ; undefined
   8:	01040000 	.inst	0x01040000 ; undefined
   c:	000d0efb 	.inst	0x000d0efb ; undefined
  10:	01010101 	.inst	0x01010101 ; undefined
  14:	01000000 	.inst	0x01000000 ; undefined
  18:	00010000 	.inst	0x00010000 ; undefined
  1c:	632e6475 	.inst	0x632e6475 ; undefined
  20:	00000000 	udf	#0
  24:	00010500 	.inst	0x00010500 ; undefined
  28:	06040209 	.inst	0x06040209 ; undefined
  2c:	00000040 	udf	#64
  30:	ce030000 	eor3	v0.16b, v0.16b, v3.16b, v0.16b
  34:	0d050100 	.inst	0x0d050100 ; undefined
  38:	2e190530 	.inst	0x2e190530 ; undefined
  3c:	05330905 	ext	z5.b, z5.b, z8.b, #154
  40:	07052003 	.inst	0x07052003 ; undefined
  44:	210b0522 	.inst	0x210b0522 ; undefined
  48:	05200505 	ext	z5.b, z5.b, z8.b, #1
  4c:	1e052214 	.inst	0x1e052214 ; undefined
  50:	2e19052e 	.inst	0x2e19052e ; undefined
  54:	052e0f05 	ext	z5.b, z5.b, z24.b, #115
  58:	1105bb09 	add	w9, w24, #0x16e
  5c:	0010054b 	.inst	0x0010054b ; undefined
  60:	08020402 	stxrb	w2, w2, [x0]
  64:	0009059f 	.inst	0x0009059f ; undefined
  68:	ba020402 	rmif	x0, #4, #2
  6c:	02001905 	.inst	0x02001905 ; undefined
  70:	05370204 	ext	z4.b, z4.b, z16.b, #184
  74:	04020005 	.inst	0x04020005 ; undefined
  78:	0a053c01 	and	w1, w0, w5, lsl #15
  7c:	02040200 	.inst	0x02040200 ; undefined
  80:	00170551 	.inst	0x00170551 ; undefined
  84:	03020402 	.inst	0x03020402 ; undefined
  88:	03055876 	.inst	0x03055876 ; undefined
  8c:	01040200 	.inst	0x01040200 ; undefined
  90:	030c053c 	.inst	0x030c053c ; undefined
  94:	01054a0d 	.inst	0x01054a0d ; undefined
  98:	09053f4b 	.inst	0x09053f4b ; undefined
  9c:	20030540 	.inst	0x20030540 ; undefined
  a0:	05220b05 	ext	z5.b, z5.b, z24.b, #18
  a4:	09053c05 	.inst	0x09053c05 ; undefined
  a8:	0f05c922 	.inst	0x0f05c922 ; undefined
  ac:	2009053d 	.inst	0x2009053d ; undefined
  b0:	02001405 	.inst	0x02001405 ; undefined
  b4:	05210304 	ext	z4.b, z4.b, z24.b, #8
  b8:	0402001e 	.inst	0x0402001e ; undefined
  bc:	1805ba03 	ldr	w3, b7fc <__abi_tag-0x3f4a7c>
  c0:	03040200 	.inst	0x03040200 ; undefined
  c4:	000d05ba 	.inst	0x000d05ba ; undefined
  c8:	20030402 	.inst	0x20030402 ; undefined
  cc:	02001c05 	.inst	0x02001c05 ; undefined
  d0:	053b0304 	ext	z4.b, z4.b, z24.b, #216
  d4:	04020009 	.inst	0x04020009 ; undefined
  d8:	19053c01 	.inst	0x19053c01 ; undefined
  dc:	02040200 	.inst	0x02040200 ; undefined
  e0:	0013054c 	.inst	0x0013054c ; undefined
  e4:	74020402 	.inst	0x74020402 ; undefined
  e8:	02000f05 	.inst	0x02000f05 ; undefined
  ec:	052e0204 	ext	z4.b, z4.b, z16.b, #112
  f0:	0402001b 	.inst	0x0402001b ; undefined
  f4:	ba7a0302 	.inst	0xba7a0302 ; undefined
  f8:	02000505 	.inst	0x02000505 ; undefined
  fc:	053c0104 	ext	z4.b, z4.b, z8.b, #224
 100:	4a09030b 	eor	w11, w24, w9
 104:	053c0505 	ext	z5.b, z5.b, z8.b, #225
 108:	0905220e 	.inst	0x0905220e ; undefined
 10c:	c90d052e 	.inst	0xc90d052e ; undefined
 110:	05200705 	ext	z5.b, z5.b, z24.b, #1
 114:	04020011 	.inst	0x04020011 ; undefined
 118:	14052103 	b	148524 <__abi_tag-0x2b7d54>
 11c:	03040200 	.inst	0x03040200 ; undefined
 120:	001e052e 	.inst	0x001e052e ; undefined
 124:	ba030402 	rmif	x0, #6, #2
 128:	02001805 	.inst	0x02001805 ; undefined
 12c:	05ba0304 	zip1	z4.q, z24.q, z26.q
 130:	0402000b 	.inst	0x0402000b ; undefined
 134:	1b052003 	madd	w3, w0, w5, w8
 138:	03040200 	.inst	0x03040200 ; undefined
 13c:	0007053b 	.inst	0x0007053b ; undefined
 140:	3c010402 	str	b2, [x0], #16
 144:	02000a05 	.inst	0x02000a05 ; undefined
 148:	054c0204 	.inst	0x054c0204 ; undefined
 14c:	04020011 	.inst	0x04020011 ; undefined
 150:	1b052e02 	madd	w2, w16, w5, w11
 154:	02040200 	.inst	0x02040200 ; undefined
 158:	000505c3 	.inst	0x000505c3 ; undefined
 15c:	3c010402 	str	b2, [x0], #16
 160:	02001605 	.inst	0x02001605 ; undefined
 164:	75030204 	.inst	0x75030204 ; undefined
 168:	0003054a 	.inst	0x0003054a ; undefined
 16c:	3c010402 	str	b2, [x0], #16
 170:	14030b05 	b	c2d84 <__abi_tag-0x33d4f4>
 174:	3c08054a 	str	b10, [x10], #128
 178:	05220905 	ext	z5.b, z5.b, z8.b, #18
 17c:	07052e03 	.inst	0x07052e03 ; undefined
 180:	590b0522 	.inst	0x590b0522 ; undefined
 184:	05200505 	ext	z5.b, z5.b, z8.b, #1
 188:	04020010 	.inst	0x04020010 ; undefined
 18c:	17052103 	b	fffffffffc148598 <__bss_end__+0xfffffffffbb3e1a8>
 190:	03040200 	.inst	0x03040200 ; undefined
 194:	001405ba 	.inst	0x001405ba ; undefined
 198:	4a030402 	eor	w2, w0, w3, lsl #1
 19c:	02000905 	.inst	0x02000905 ; undefined
 1a0:	05200304 	ext	z4.b, z4.b, z24.b, #0
 1a4:	04020018 	.inst	0x04020018 ; undefined
 1a8:	05053b03 	.inst	0x05053b03 ; undefined
 1ac:	01040200 	.inst	0x01040200 ; undefined
 1b0:	000a053c 	.inst	0x000a053c ; undefined
 1b4:	4c020402 	.inst	0x4c020402 ; undefined
 1b8:	02001705 	.inst	0x02001705 ; undefined
 1bc:	05530204 	mov	z4.h, p3/z, #16
 1c0:	04020003 	.inst	0x04020003 ; undefined
 1c4:	0b053c01 	add	w1, w0, w5, lsl #15
 1c8:	4a150552 	eor	w18, w10, w21, lsl #1
 1cc:	05740f05 	ext	z5.b, {z24.b, z25.b}, #163
 1d0:	09052008 	.inst	0x09052008 ; undefined
 1d4:	3c03054c 	str	b12, [x10], #48
 1d8:	05220705 	ext	z5.b, z5.b, z24.b, #17
 1dc:	0505590b 	.inst	0x0505590b ; undefined
 1e0:	0010053c 	.inst	0x0010053c ; undefined
 1e4:	21030402 	.inst	0x21030402 ; undefined
 1e8:	02001705 	.inst	0x02001705 ; undefined
 1ec:	05ba0304 	zip1	z4.q, z24.q, z26.q
 1f0:	04020014 	.inst	0x04020014 ; undefined
 1f4:	09054a03 	.inst	0x09054a03 ; undefined
 1f8:	03040200 	.inst	0x03040200 ; undefined
 1fc:	001b0520 	.inst	0x001b0520 ; undefined
 200:	3b030402 	.inst	0x3b030402 ; undefined
 204:	02000505 	.inst	0x02000505 ; undefined
 208:	053c0104 	ext	z4.b, z4.b, z8.b, #224
 20c:	04020014 	.inst	0x04020014 ; undefined
 210:	0e054c02 	.inst	0x0e054c02 ; undefined
 214:	02040200 	.inst	0x02040200 ; undefined
 218:	000a0574 	.inst	0x000a0574 ; undefined
 21c:	2e020402 	.inst	0x2e020402 ; undefined
 220:	02001905 	.inst	0x02001905 ; undefined
 224:	05450204 	.inst	0x05450204 ; undefined
 228:	04020003 	.inst	0x04020003 ; undefined
 22c:	09053c01 	.inst	0x09053c01 ; undefined
 230:	21010544 	.inst	0x21010544 ; undefined
 234:	01000202 	.inst	0x01000202 ; undefined
 238:	地址 0x0000000000000238 越界。


Disassembly of section .debug_str:

0000000000000000 <.debug_str>:
   0:	676e6f6c 	.inst	0x676e6f6c ; undefined
   4:	736e7520 	.inst	0x736e7520 ; undefined
   8:	656e6769 	fnmls	z9.h, p1/m, z27.h, z14.h
   c:	6e692064 	usubl2	v4.4s, v3.8h, v9.8h
  10:	6f6c0074 	mla	v20.8h, v3.8h, v12.h[2]
  14:	6920676e 	stgp	x14, x25, [x27, #-1024]
  18:	7500746e 	.inst	0x7500746e ; undefined
  1c:	00632e64 	.inst	0x00632e64 ; undefined
  20:	6e69616d 	rsubhn2	v13.8h, v11.4s, v9.4s
  24:	616d6e00 	.inst	0x616d6e00 ; undefined
  28:	756c0078 	.inst	0x756c0078 ; undefined
  2c:	706d6364 	adr	x4, dac9b <__abi_tag-0x3255dd>
  30:	554e4700 	.inst	0x554e4700 ; undefined
  34:	37314320 	tbnz	w0, #6, 2898 <__abi_tag-0x3fd9e0>
  38:	2e303120 	usubw	v0.8h, v9.8h, v16.8b
  3c:	20312e33 	.inst	0x20312e33 ; undefined
  40:	696c6d2d 	ldpsw	x13, x27, [x9, #-160]
  44:	656c7474 	fnmls	z20.h, p5/m, z3.h, z12.h
  48:	646e652d 	.inst	0x646e652d ; undefined
  4c:	206e6169 	.inst	0x206e6169 ; undefined
  50:	62616d2d 	.inst	0x62616d2d ; undefined
  54:	706c3d69 	adr	x9, d8803 <__abi_tag-0x327a75>
  58:	2d203436 	stp	s22, s13, [x1, #-256]
  5c:	682f0067 	.inst	0x682f0067 ; undefined
  60:	2f656d6f 	.inst	0x2f656d6f ; undefined
  64:	6e61796a 	.inst	0x6e61796a ; undefined
  68:	72702f67 	.inst	0x72702f67 ; undefined
  6c:	6172676f 	.inst	0x6172676f ; undefined
  70:	524d2f6d 	.inst	0x524d2f6d ; undefined
  74:	752f4354 	.inst	0x752f4354 ; undefined
  78:	68630064 	.inst	0x68630064 ; undefined
  7c:	7272656b 	.inst	0x7272656b ; undefined
	...
