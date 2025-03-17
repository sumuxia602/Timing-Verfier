
adpcm：     文件格式 elf64-littleaarch64


Disassembly of section .interp:

0000000000400238 <.interp>:
  400238:	62696c2f 	.inst	0x62696c2f ; undefined
  40023c:	2d646c2f 	ldp	s15, s27, [x1, #-224]
  400240:	756e696c 	.inst	0x756e696c ; undefined
  400244:	61612d78 	.inst	0x61612d78 ; undefined
  400248:	36686372 	tbz	w18, #13, 400eb4 <encode+0x6ec>
  40024c:	6f732e34 	.inst	0x6f732e34 ; undefined
  400250:	地址 0x0000000000400250 越界。


Disassembly of section .note.gnu.build-id:

0000000000400254 <.note.gnu.build-id>:
  400254:	00000004 	udf	#4
  400258:	00000014 	udf	#20
  40025c:	00000003 	udf	#3
  400260:	00554e47 	.inst	0x00554e47 ; undefined
  400264:	72d0e96d 	.inst	0x72d0e96d ; undefined
  400268:	b05d47a1 	adrp	x1, bacf5000 <__bss_end__+0xba8d4850>
  40026c:	bda698fc 	.inst	0xbda698fc ; undefined
  400270:	49ae8a0e 	.inst	0x49ae8a0e ; undefined
  400274:	0d303d2c 	.inst	0x0d303d2c ; undefined

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
  40037c:	34332e32 	cbz	w18, 466940 <__bss_end__+0x46190>
  400380:	54495f00 	b.eq	492f60 <__bss_end__+0x727b0>  // b.none
  400384:	65645f4d 	fnmla	z13.h, p7/m, z26.h, z4.h
  400388:	69676572 	ldpsw	x18, x25, [x11, #-200]
  40038c:	72657473 	.inst	0x72657473 ; undefined
  400390:	6c434d54 	ldnp	d20, d19, [x10, #48]
  400394:	54656e6f 	b.nv	4cb160 <__bss_end__+0xaa9b0>
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

Disassembly of section .rodata:

000000000040253c <_IO_stdin_used>:
  40253c:	00020001 	.inst	0x00020001 ; undefined

Disassembly of section .eh_frame_hdr:

0000000000402540 <__GNU_EH_FRAME_HDR>:
  402540:	3b031b01 	.inst	0x3b031b01 ; undefined
  402544:	000000c4 	udf	#196
  402548:	00000017 	udf	#23
  40254c:	ffffdfc0 	.inst	0xffffdfc0 ; undefined
  402550:	000000dc 	udf	#220
  402554:	ffffe000 	.inst	0xffffe000 ; undefined
  402558:	000000f0 	udf	#240
  40255c:	ffffe020 	.inst	0xffffe020 ; undefined
  402560:	00000108 	udf	#264
  402564:	ffffe050 	.inst	0xffffe050 ; undefined
  402568:	0000011c 	udf	#284
  40256c:	ffffe090 	.inst	0xffffe090 ; undefined
  402570:	00000130 	udf	#304
  402574:	ffffe0c0 	.inst	0xffffe0c0 ; undefined
  402578:	00000154 	udf	#340
  40257c:	ffffe0c4 	.inst	0xffffe0c4 ; undefined
  402580:	00000168 	udf	#360
  402584:	ffffe0fc 	.inst	0xffffe0fc ; undefined
  402588:	00000180 	udf	#384
  40258c:	ffffe134 	.inst	0xffffe134 ; undefined
  402590:	00000198 	udf	#408
  402594:	ffffe264 	.inst	0xffffe264 ; undefined
  402598:	000001b8 	udf	#440
  40259c:	ffffe288 	.inst	0xffffe288 ; undefined
  4025a0:	000001d8 	udf	#472
  4025a4:	ffffeb58 	.inst	0xffffeb58 ; undefined
  4025a8:	000001f8 	udf	#504
  4025ac:	fffff3f8 	.inst	0xfffff3f8 ; undefined
  4025b0:	00000218 	udf	#536
  4025b4:	fffff7f8 	.inst	0xfffff7f8 ; undefined
  4025b8:	00000230 	udf	#560
  4025bc:	fffff8a0 	.inst	0xfffff8a0 ; undefined
  4025c0:	00000248 	udf	#584
  4025c4:	fffff90c 	.inst	0xfffff90c ; undefined
  4025c8:	00000260 	udf	#608
  4025cc:	fffff9cc 	.inst	0xfffff9cc ; undefined
  4025d0:	00000280 	udf	#640
  4025d4:	fffffa4c 	.inst	0xfffffa4c ; undefined
  4025d8:	00000298 	udf	#664
  4025dc:	fffffaac 	.inst	0xfffffaac ; undefined
  4025e0:	000002b0 	udf	#688
  4025e4:	fffffc3c 	.inst	0xfffffc3c ; undefined
  4025e8:	000002c8 	udf	#712
  4025ec:	fffffd14 	.inst	0xfffffd14 ; undefined
  4025f0:	000002e0 	udf	#736
  4025f4:	fffffdc4 	.inst	0xfffffdc4 ; undefined
  4025f8:	000002f8 	udf	#760
  4025fc:	fffffe38 	.inst	0xfffffe38 ; undefined
  402600:	00000310 	udf	#784

Disassembly of section .eh_frame:

0000000000402608 <__FRAME_END__-0x26c>:
  402608:	00000010 	udf	#16
  40260c:	00000000 	udf	#0
  402610:	00527a01 	.inst	0x00527a01 ; undefined
  402614:	011e7804 	.inst	0x011e7804 ; undefined
  402618:	001f0c1b 	.inst	0x001f0c1b ; undefined
  40261c:	00000010 	udf	#16
  402620:	00000018 	udf	#24
  402624:	ffffdedc 	.inst	0xffffdedc ; undefined
  402628:	0000003c 	udf	#60
  40262c:	1e074100 	.inst	0x1e074100 ; undefined
  402630:	00000014 	udf	#20
  402634:	0000002c 	udf	#44
  402638:	ffffdf08 	.inst	0xffffdf08 ; undefined
  40263c:	00000004 	udf	#4
	...
  402648:	00000010 	udf	#16
  40264c:	00000044 	udf	#68
  402650:	ffffdf10 	.inst	0xffffdf10 ; undefined
  402654:	00000030 	udf	#48
  402658:	00000000 	udf	#0
  40265c:	00000010 	udf	#16
  402660:	00000058 	udf	#88
  402664:	ffffdf2c 	.inst	0xffffdf2c ; undefined
  402668:	0000003c 	udf	#60
  40266c:	00000000 	udf	#0
  402670:	00000020 	udf	#32
  402674:	0000006c 	udf	#108
  402678:	ffffdf58 	.inst	0xffffdf58 ; undefined
  40267c:	00000030 	udf	#48
  402680:	200e4100 	.inst	0x200e4100 ; undefined
  402684:	039e049d 	.inst	0x039e049d ; undefined
  402688:	48029342 	stlxrh	w2, w2, [x26]
  40268c:	0ed3ddde 	.inst	0x0ed3ddde ; undefined
  402690:	00000000 	udf	#0
  402694:	00000010 	udf	#16
  402698:	00000090 	udf	#144
  40269c:	ffffdf64 	.inst	0xffffdf64 ; undefined
  4026a0:	00000004 	udf	#4
  4026a4:	00000000 	udf	#0
  4026a8:	00000014 	udf	#20
  4026ac:	000000a4 	udf	#164
  4026b0:	ffffdf54 	.inst	0xffffdf54 ; undefined
  4026b4:	00000038 	udf	#56
  4026b8:	200e4100 	.inst	0x200e4100 ; undefined
  4026bc:	00000e4c 	udf	#3660
  4026c0:	00000014 	udf	#20
  4026c4:	000000bc 	udf	#188
  4026c8:	ffffdf74 	.inst	0xffffdf74 ; undefined
  4026cc:	00000038 	udf	#56
  4026d0:	200e4100 	.inst	0x200e4100 ; undefined
  4026d4:	00000e4c 	udf	#3660
  4026d8:	0000001c 	udf	#28
  4026dc:	000000d4 	udf	#212
  4026e0:	ffffdf94 	.inst	0xffffdf94 ; undefined
  4026e4:	00000130 	udf	#304
  4026e8:	300e4100 	adr	x0, 41ef09 <__FRAME_END__+0x1c695>
  4026ec:	059e069d 	mov	z29.s, p14/z, #52
  4026f0:	ddde4a02 	.inst	0xddde4a02 ; undefined
  4026f4:	0000000e 	udf	#14
  4026f8:	0000001c 	udf	#28
  4026fc:	000000f4 	udf	#244
  402700:	ffffe0a4 	.inst	0xffffe0a4 ; undefined
  402704:	00000024 	udf	#36
  402708:	200e4100 	.inst	0x200e4100 ; undefined
  40270c:	039e049d 	.inst	0x039e049d ; undefined
  402710:	0eddde47 	.inst	0x0eddde47 ; undefined
  402714:	00000000 	udf	#0
  402718:	0000001c 	udf	#28
  40271c:	00000114 	udf	#276
  402720:	ffffe0a8 	.inst	0xffffe0a8 ; undefined
  402724:	000008d0 	udf	#2256
  402728:	600e4100 	.inst	0x600e4100 ; undefined
  40272c:	0b9e0c9d 	add	w29, w4, w30, asr #3
  402730:	de023203 	.inst	0xde023203 ; undefined
  402734:	00000edd 	udf	#3805
  402738:	0000001c 	udf	#28
  40273c:	00000134 	udf	#308
  402740:	ffffe958 	.inst	0xffffe958 ; undefined
  402744:	000008a0 	udf	#2208
  402748:	600e4100 	.inst	0x600e4100 ; undefined
  40274c:	0b9e0c9d 	add	w29, w4, w30, asr #3
  402750:	de022603 	.inst	0xde022603 ; undefined
  402754:	00000edd 	udf	#3805
  402758:	00000014 	udf	#20
  40275c:	00000154 	udf	#340
  402760:	fffff1d8 	.inst	0xfffff1d8 ; undefined
  402764:	00000400 	udf	#1024
  402768:	100e4100 	adr	x0, 41ef88 <__FRAME_END__+0x1c714>
  40276c:	000efe02 	.inst	0x000efe02 ; undefined
  402770:	00000014 	udf	#20
  402774:	0000016c 	udf	#364
  402778:	fffff5c0 	.inst	0xfffff5c0 ; undefined
  40277c:	000000a8 	udf	#168
  402780:	200e4100 	.inst	0x200e4100 ; undefined
  402784:	00000e68 	udf	#3688
  402788:	00000014 	udf	#20
  40278c:	00000184 	udf	#388
  402790:	fffff650 	.inst	0xfffff650 ; undefined
  402794:	0000006c 	udf	#108
  402798:	200e4100 	.inst	0x200e4100 ; undefined
  40279c:	00000e59 	udf	#3673
  4027a0:	0000001c 	udf	#28
  4027a4:	0000019c 	udf	#412
  4027a8:	fffff6a4 	.inst	0xfffff6a4 ; undefined
  4027ac:	000000c0 	udf	#192
  4027b0:	400e4100 	.inst	0x400e4100 ; undefined
  4027b4:	079e089d 	.inst	0x079e089d ; undefined
  4027b8:	0eddde6e 	.inst	0x0eddde6e ; undefined
  4027bc:	00000000 	udf	#0
  4027c0:	00000014 	udf	#20
  4027c4:	000001bc 	udf	#444
  4027c8:	fffff744 	.inst	0xfffff744 ; undefined
  4027cc:	00000080 	udf	#128
  4027d0:	200e4100 	.inst	0x200e4100 ; undefined
  4027d4:	00000e5e 	udf	#3678
  4027d8:	00000014 	udf	#20
  4027dc:	000001d4 	udf	#468
  4027e0:	fffff7ac 	.inst	0xfffff7ac ; undefined
  4027e4:	00000060 	udf	#96
  4027e8:	200e4100 	.inst	0x200e4100 ; undefined
  4027ec:	00000e56 	udf	#3670
  4027f0:	00000014 	udf	#20
  4027f4:	000001ec 	udf	#492
  4027f8:	fffff7f4 	.inst	0xfffff7f4 ; undefined
  4027fc:	00000190 	udf	#400
  402800:	300e4100 	adr	x0, 41f021 <__FRAME_END__+0x1c7ad>
  402804:	000e6202 	.inst	0x000e6202 ; undefined
  402808:	00000014 	udf	#20
  40280c:	00000204 	udf	#516
  402810:	fffff96c 	.inst	0xfffff96c ; undefined
  402814:	000000d8 	udf	#216
  402818:	400e4100 	.inst	0x400e4100 ; undefined
  40281c:	00000e74 	udf	#3700
  402820:	00000014 	udf	#20
  402824:	0000021c 	udf	#540
  402828:	fffffa2c 	.inst	0xfffffa2c ; undefined
  40282c:	000000b0 	udf	#176
  402830:	300e4100 	adr	x0, 41f051 <__FRAME_END__+0x1c7dd>
  402834:	00000e6a 	udf	#3690
  402838:	00000014 	udf	#20
  40283c:	00000234 	udf	#564
  402840:	fffffac4 	.inst	0xfffffac4 ; undefined
  402844:	00000074 	udf	#116
  402848:	200e4100 	.inst	0x200e4100 ; undefined
  40284c:	00000e5b 	udf	#3675
  402850:	00000020 	udf	#32
  402854:	0000024c 	udf	#588
  402858:	fffffb20 	.inst	0xfffffb20 ; undefined
  40285c:	000001b0 	udf	#432
  402860:	300e4100 	adr	x0, 41f081 <__FRAME_END__+0x1c80d>
  402864:	059e069d 	mov	z29.s, p14/z, #52
  402868:	02049342 	.inst	0x02049342 ; undefined
  40286c:	d3ddde68 	.inst	0xd3ddde68 ; undefined
  402870:	0000000e 	udf	#14

0000000000402874 <__FRAME_END__>:
  402874:	00000000 	udf	#0

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
  41fe20:	00402528 	.inst	0x00402528 ; undefined
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

0000000000420028 <h>:
  420028:	0000000c 	udf	#12
  42002c:	ffffffd4 	.inst	0xffffffd4 ; undefined
  420030:	ffffffd4 	.inst	0xffffffd4 ; undefined
  420034:	000000d4 	udf	#212
  420038:	00000030 	udf	#48
  42003c:	fffffd90 	.inst	0xfffffd90 ; undefined
  420040:	00000080 	udf	#128
  420044:	000005a8 	udf	#1448
  420048:	fffffcb8 	.inst	0xfffffcb8 ; undefined
  42004c:	fffff36c 	.inst	0xfffff36c ; undefined
  420050:	00000edc 	udf	#3804
  420054:	00003c90 	udf	#15504
  420058:	00003c90 	udf	#15504
  42005c:	00000edc 	udf	#3804
  420060:	fffff36c 	.inst	0xfffff36c ; undefined
  420064:	fffffcb8 	.inst	0xfffffcb8 ; undefined
  420068:	000005a8 	udf	#1448
  42006c:	00000080 	udf	#128
  420070:	fffffd90 	.inst	0xfffffd90 ; undefined
  420074:	00000030 	udf	#48
  420078:	000000d4 	udf	#212
  42007c:	ffffffd4 	.inst	0xffffffd4 ; undefined
  420080:	ffffffd4 	.inst	0xffffffd4 ; undefined
  420084:	0000000c 	udf	#12

0000000000420088 <qq4_code4_table>:
  420088:	00000000 	udf	#0
  42008c:	ffffb018 	.inst	0xffffb018 ; undefined
  420090:	ffffcda0 	.inst	0xffffcda0 ; undefined
  420094:	ffffdcf8 	.inst	0xffffdcf8 ; undefined
  420098:	ffffe770 	.inst	0xffffe770 ; undefined
  42009c:	ffffef70 	.inst	0xffffef70 ; undefined
  4200a0:	fffff5e8 	.inst	0xfffff5e8 ; undefined
  4200a4:	fffffb50 	.inst	0xfffffb50 ; undefined
  4200a8:	00004fe8 	udf	#20456
  4200ac:	00003260 	udf	#12896
  4200b0:	00002308 	udf	#8968
  4200b4:	00001890 	udf	#6288
  4200b8:	00001090 	udf	#4240
  4200bc:	00000a18 	udf	#2584
  4200c0:	000004b0 	udf	#1200
  4200c4:	00000000 	udf	#0

00000000004200c8 <qq5_code5_table>:
  4200c8:	fffffee8 	.inst	0xfffffee8 ; undefined
  4200cc:	fffffee8 	.inst	0xfffffee8 ; undefined
  4200d0:	ffffa4c8 	.inst	0xffffa4c8 ; undefined
  4200d4:	ffffbb68 	.inst	0xffffbb68 ; undefined
  4200d8:	ffffc8d8 	.inst	0xffffc8d8 ; undefined
  4200dc:	ffffd270 	.inst	0xffffd270 ; undefined
  4200e0:	ffffd9e8 	.inst	0xffffd9e8 ; undefined
  4200e4:	ffffe008 	.inst	0xffffe008 ; undefined
  4200e8:	ffffe530 	.inst	0xffffe530 ; undefined
  4200ec:	ffffe9b0 	.inst	0xffffe9b0 ; undefined
  4200f0:	ffffeda8 	.inst	0xffffeda8 ; undefined
  4200f4:	fffff138 	.inst	0xfffff138 ; undefined
  4200f8:	fffff470 	.inst	0xfffff470 ; undefined
  4200fc:	fffff760 	.inst	0xfffff760 ; undefined
  420100:	fffffa10 	.inst	0xfffffa10 ; undefined
  420104:	fffffc90 	.inst	0xfffffc90 ; undefined
  420108:	00005b38 	udf	#23352
  42010c:	00004498 	udf	#17560
  420110:	00003728 	udf	#14120
  420114:	00002d90 	udf	#11664
  420118:	00002618 	udf	#9752
  42011c:	00001ff8 	udf	#8184
  420120:	00001ad0 	udf	#6864
  420124:	00001650 	udf	#5712
  420128:	00001258 	udf	#4696
  42012c:	00000ec8 	udf	#3784
  420130:	00000b90 	udf	#2960
  420134:	000008a0 	udf	#2208
  420138:	000005f0 	udf	#1520
  42013c:	00000370 	udf	#880
  420140:	00000118 	udf	#280
  420144:	fffffee8 	.inst	0xfffffee8 ; undefined

0000000000420148 <qq6_code6_table>:
  420148:	ffffff78 	.inst	0xffffff78 ; undefined
  42014c:	ffffff78 	.inst	0xffffff78 ; undefined
  420150:	ffffff78 	.inst	0xffffff78 ; undefined
  420154:	ffffff78 	.inst	0xffffff78 ; undefined
  420158:	ffff9f18 	.inst	0xffff9f18 ; undefined
  42015c:	ffffaa70 	.inst	0xffffaa70 ; undefined
  420160:	ffffb5c0 	.inst	0xffffb5c0 ; undefined
  420164:	ffffbec0 	.inst	0xffffbec0 ; undefined
  420168:	ffffc578 	.inst	0xffffc578 ; undefined
  42016c:	ffffcb38 	.inst	0xffffcb38 ; undefined
  420170:	ffffd008 	.inst	0xffffd008 ; undefined
  420174:	ffffd448 	.inst	0xffffd448 ; undefined
  420178:	ffffd808 	.inst	0xffffd808 ; undefined
  42017c:	ffffdb70 	.inst	0xffffdb70 ; undefined
  420180:	ffffde80 	.inst	0xffffde80 ; undefined
  420184:	ffffe150 	.inst	0xffffe150 ; undefined
  420188:	ffffe3e8 	.inst	0xffffe3e8 ; undefined
  42018c:	ffffe650 	.inst	0xffffe650 ; undefined
  420190:	ffffe890 	.inst	0xffffe890 ; undefined
  420194:	ffffeab0 	.inst	0xffffeab0 ; undefined
  420198:	ffffecb0 	.inst	0xffffecb0 ; undefined
  42019c:	ffffee90 	.inst	0xffffee90 ; undefined
  4201a0:	fffff058 	.inst	0xfffff058 ; undefined
  4201a4:	fffff208 	.inst	0xfffff208 ; undefined
  4201a8:	fffff3a0 	.inst	0xfffff3a0 ; undefined
  4201ac:	fffff528 	.inst	0xfffff528 ; undefined
  4201b0:	fffff6a0 	.inst	0xfffff6a0 ; undefined
  4201b4:	fffff810 	.inst	0xfffff810 ; undefined
  4201b8:	fffff968 	.inst	0xfffff968 ; undefined
  4201bc:	fffffab0 	.inst	0xfffffab0 ; undefined
  4201c0:	fffffbf0 	.inst	0xfffffbf0 ; undefined
  4201c4:	fffffd28 	.inst	0xfffffd28 ; undefined
  4201c8:	000060e8 	udf	#24808
  4201cc:	00005590 	udf	#21904
  4201d0:	00004a40 	udf	#19008
  4201d4:	00004140 	udf	#16704
  4201d8:	00003a88 	udf	#14984
  4201dc:	000034c8 	udf	#13512
  4201e0:	00002ff8 	udf	#12280
  4201e4:	00002bb8 	udf	#11192
  4201e8:	000027f8 	udf	#10232
  4201ec:	00002490 	udf	#9360
  4201f0:	00002180 	udf	#8576
  4201f4:	00001eb0 	udf	#7856
  4201f8:	00001c18 	udf	#7192
  4201fc:	000019b0 	udf	#6576
  420200:	00001770 	udf	#6000
  420204:	00001550 	udf	#5456
  420208:	00001350 	udf	#4944
  42020c:	00001170 	udf	#4464
  420210:	00000fa8 	udf	#4008
  420214:	00000df8 	udf	#3576
  420218:	00000c60 	udf	#3168
  42021c:	00000ad8 	udf	#2776
  420220:	00000960 	udf	#2400
  420224:	000007f0 	udf	#2032
  420228:	00000698 	udf	#1688
  42022c:	00000550 	udf	#1360
  420230:	00000410 	udf	#1040
  420234:	000002d8 	udf	#728
  420238:	000001b0 	udf	#432
  42023c:	00000088 	udf	#136
  420240:	fffffe50 	.inst	0xfffffe50 ; undefined
  420244:	ffffff78 	.inst	0xffffff78 ; undefined

0000000000420248 <wl_code_table>:
  420248:	ffffffc4 	.inst	0xffffffc4 ; undefined
  42024c:	00000be2 	udf	#3042
  420250:	000004ae 	udf	#1198
  420254:	0000021a 	udf	#538
  420258:	0000014e 	udf	#334
  42025c:	000000ac 	udf	#172
  420260:	0000003a 	udf	#58
  420264:	ffffffe2 	.inst	0xffffffe2 ; undefined
  420268:	00000be2 	udf	#3042
  42026c:	000004ae 	udf	#1198
  420270:	0000021a 	udf	#538
  420274:	0000014e 	udf	#334
  420278:	000000ac 	udf	#172
  42027c:	0000003a 	udf	#58
  420280:	ffffffe2 	.inst	0xffffffe2 ; undefined
  420284:	ffffffc4 	.inst	0xffffffc4 ; undefined

0000000000420288 <wl_table>:
  420288:	ffffffc4 	.inst	0xffffffc4 ; undefined
  42028c:	ffffffe2 	.inst	0xffffffe2 ; undefined
  420290:	0000003a 	udf	#58
  420294:	000000ac 	udf	#172
  420298:	0000014e 	udf	#334
  42029c:	0000021a 	udf	#538
  4202a0:	000004ae 	udf	#1198
  4202a4:	00000be2 	udf	#3042

00000000004202a8 <ilb_table>:
  4202a8:	00000800 	udf	#2048
  4202ac:	0000082d 	udf	#2093
  4202b0:	0000085b 	udf	#2139
  4202b4:	0000088a 	udf	#2186
  4202b8:	000008b9 	udf	#2233
  4202bc:	000008ea 	udf	#2282
  4202c0:	0000091c 	udf	#2332
  4202c4:	0000094f 	udf	#2383
  4202c8:	00000983 	udf	#2435
  4202cc:	000009b9 	udf	#2489
  4202d0:	000009ef 	udf	#2543
  4202d4:	00000a27 	udf	#2599
  4202d8:	00000a60 	udf	#2656
  4202dc:	00000a9a 	udf	#2714
  4202e0:	00000ad6 	udf	#2774
  4202e4:	00000b12 	udf	#2834
  4202e8:	00000b50 	udf	#2896
  4202ec:	00000b90 	udf	#2960
  4202f0:	00000bd1 	udf	#3025
  4202f4:	00000c13 	udf	#3091
  4202f8:	00000c56 	udf	#3158
  4202fc:	00000c9c 	udf	#3228
  420300:	00000ce2 	udf	#3298
  420304:	00000d2b 	udf	#3371
  420308:	00000d74 	udf	#3444
  42030c:	00000dc0 	udf	#3520
  420310:	00000e0d 	udf	#3597
  420314:	00000e5c 	udf	#3676
  420318:	00000eac 	udf	#3756
  42031c:	00000efe 	udf	#3838
  420320:	00000f52 	udf	#3922
  420324:	00000fa8 	udf	#4008

0000000000420328 <decis_levl>:
  420328:	00000118 	udf	#280
  42032c:	00000240 	udf	#576
  420330:	00000370 	udf	#880
  420334:	000004b0 	udf	#1200
  420338:	000005f0 	udf	#1520
  42033c:	00000748 	udf	#1864
  420340:	000008a0 	udf	#2208
  420344:	00000a18 	udf	#2584
  420348:	00000b90 	udf	#2960
  42034c:	00000d30 	udf	#3376
  420350:	00000ec8 	udf	#3784
  420354:	00001090 	udf	#4240
  420358:	00001258 	udf	#4696
  42035c:	00001450 	udf	#5200
  420360:	00001650 	udf	#5712
  420364:	00001890 	udf	#6288
  420368:	00001ad0 	udf	#6864
  42036c:	00001d60 	udf	#7520
  420370:	00001ff8 	udf	#8184
  420374:	00002308 	udf	#8968
  420378:	00002618 	udf	#9752
  42037c:	000029d8 	udf	#10712
  420380:	00002d90 	udf	#11664
  420384:	00003260 	udf	#12896
  420388:	00003728 	udf	#14120
  42038c:	00003de0 	udf	#15840
  420390:	00004498 	udf	#17560
  420394:	00004fe8 	udf	#20456
  420398:	00005b38 	udf	#23352
  42039c:	00007fff 	udf	#32767

00000000004203a0 <quant26bt_pos>:
  4203a0:	0000003d 	udf	#61
  4203a4:	0000003c 	udf	#60
  4203a8:	0000003b 	udf	#59
  4203ac:	0000003a 	udf	#58
  4203b0:	00000039 	udf	#57
  4203b4:	00000038 	udf	#56
  4203b8:	00000037 	udf	#55
  4203bc:	00000036 	udf	#54
  4203c0:	00000035 	udf	#53
  4203c4:	00000034 	udf	#52
  4203c8:	00000033 	udf	#51
  4203cc:	00000032 	udf	#50
  4203d0:	00000031 	udf	#49
  4203d4:	00000030 	udf	#48
  4203d8:	0000002f 	udf	#47
  4203dc:	0000002e 	udf	#46
  4203e0:	0000002d 	udf	#45
  4203e4:	0000002c 	udf	#44
  4203e8:	0000002b 	udf	#43
  4203ec:	0000002a 	udf	#42
  4203f0:	00000029 	udf	#41
  4203f4:	00000028 	udf	#40
  4203f8:	00000027 	udf	#39
  4203fc:	00000026 	udf	#38
  420400:	00000025 	udf	#37
  420404:	00000024 	udf	#36
  420408:	00000023 	udf	#35
  42040c:	00000022 	udf	#34
  420410:	00000021 	udf	#33
  420414:	00000020 	udf	#32
  420418:	00000020 	udf	#32
  42041c:	00000000 	udf	#0

0000000000420420 <quant26bt_neg>:
  420420:	0000003f 	udf	#63
  420424:	0000003e 	udf	#62
  420428:	0000001f 	udf	#31
  42042c:	0000001e 	udf	#30
  420430:	0000001d 	udf	#29
  420434:	0000001c 	udf	#28
  420438:	0000001b 	udf	#27
  42043c:	0000001a 	udf	#26
  420440:	00000019 	udf	#25
  420444:	00000018 	udf	#24
  420448:	00000017 	udf	#23
  42044c:	00000016 	udf	#22
  420450:	00000015 	udf	#21
  420454:	00000014 	udf	#20
  420458:	00000013 	udf	#19
  42045c:	00000012 	udf	#18
  420460:	00000011 	udf	#17
  420464:	00000010 	udf	#16
  420468:	0000000f 	udf	#15
  42046c:	0000000e 	udf	#14
  420470:	0000000d 	udf	#13
  420474:	0000000c 	udf	#12
  420478:	0000000b 	udf	#11
  42047c:	0000000a 	udf	#10
  420480:	00000009 	udf	#9
  420484:	00000008 	udf	#8
  420488:	00000007 	udf	#7
  42048c:	00000006 	udf	#6
  420490:	00000005 	udf	#5
  420494:	00000004 	udf	#4
  420498:	00000004 	udf	#4
  42049c:	00000000 	udf	#0

00000000004204a0 <qq2_code2_table>:
  4204a0:	ffffe310 	.inst	0xffffe310 ; undefined
  4204a4:	fffff9b0 	.inst	0xfffff9b0 ; undefined
  4204a8:	00001cf0 	udf	#7408
  4204ac:	00000650 	udf	#1616

00000000004204b0 <wh_code_table>:
  4204b0:	0000031e 	udf	#798
  4204b4:	ffffff2a 	.inst	0xffffff2a ; undefined
  4204b8:	0000031e 	udf	#798
  4204bc:	ffffff2a 	.inst	0xffffff2a ; undefined

Disassembly of section .bss:

00000000004204c0 <completed.0>:
	...

00000000004204c8 <tqmf>:
	...

0000000000420528 <xl>:
  420528:	00000000 	udf	#0

000000000042052c <xh>:
  42052c:	00000000 	udf	#0

0000000000420530 <accumc>:
	...

0000000000420560 <accumd>:
	...

000000000042058c <xout1>:
  42058c:	00000000 	udf	#0

0000000000420590 <xout2>:
  420590:	00000000 	udf	#0

0000000000420594 <xs>:
  420594:	00000000 	udf	#0

0000000000420598 <xd>:
  420598:	00000000 	udf	#0

000000000042059c <il>:
  42059c:	00000000 	udf	#0

00000000004205a0 <szl>:
  4205a0:	00000000 	udf	#0

00000000004205a4 <spl>:
  4205a4:	00000000 	udf	#0

00000000004205a8 <sl>:
  4205a8:	00000000 	udf	#0

00000000004205ac <el>:
  4205ac:	00000000 	udf	#0

00000000004205b0 <delay_bpl>:
	...

00000000004205c8 <delay_dltx>:
	...

00000000004205e0 <nbl>:
  4205e0:	00000000 	udf	#0

00000000004205e4 <al1>:
  4205e4:	00000000 	udf	#0

00000000004205e8 <al2>:
  4205e8:	00000000 	udf	#0

00000000004205ec <plt>:
  4205ec:	00000000 	udf	#0

00000000004205f0 <plt1>:
  4205f0:	00000000 	udf	#0

00000000004205f4 <plt2>:
  4205f4:	00000000 	udf	#0

00000000004205f8 <rs>:
  4205f8:	00000000 	udf	#0

00000000004205fc <dlt>:
  4205fc:	00000000 	udf	#0

0000000000420600 <rlt>:
  420600:	00000000 	udf	#0

0000000000420604 <rlt1>:
  420604:	00000000 	udf	#0

0000000000420608 <rlt2>:
  420608:	00000000 	udf	#0

000000000042060c <detl>:
  42060c:	00000000 	udf	#0

0000000000420610 <deth>:
  420610:	00000000 	udf	#0

0000000000420614 <sh>:
  420614:	00000000 	udf	#0

0000000000420618 <eh>:
  420618:	00000000 	udf	#0

000000000042061c <dh>:
  42061c:	00000000 	udf	#0

0000000000420620 <ih>:
  420620:	00000000 	udf	#0

0000000000420624 <nbh>:
  420624:	00000000 	udf	#0

0000000000420628 <szh>:
  420628:	00000000 	udf	#0

000000000042062c <sph>:
  42062c:	00000000 	udf	#0

0000000000420630 <ph>:
  420630:	00000000 	udf	#0

0000000000420634 <yh>:
  420634:	00000000 	udf	#0

0000000000420638 <rh>:
	...

0000000000420640 <delay_dhx>:
	...

0000000000420658 <delay_bph>:
	...

0000000000420670 <ah1>:
  420670:	00000000 	udf	#0

0000000000420674 <ah2>:
  420674:	00000000 	udf	#0

0000000000420678 <ph1>:
  420678:	00000000 	udf	#0

000000000042067c <ph2>:
  42067c:	00000000 	udf	#0

0000000000420680 <rh1>:
  420680:	00000000 	udf	#0

0000000000420684 <rh2>:
  420684:	00000000 	udf	#0

0000000000420688 <ilr>:
  420688:	00000000 	udf	#0

000000000042068c <yl>:
  42068c:	00000000 	udf	#0

0000000000420690 <rl>:
  420690:	00000000 	udf	#0

0000000000420694 <dec_deth>:
  420694:	00000000 	udf	#0

0000000000420698 <dec_detl>:
  420698:	00000000 	udf	#0

000000000042069c <dec_dlt>:
  42069c:	00000000 	udf	#0

00000000004206a0 <dec_del_bpl>:
	...

00000000004206b8 <dec_del_dltx>:
	...

00000000004206d0 <dec_plt>:
  4206d0:	00000000 	udf	#0

00000000004206d4 <dec_plt1>:
  4206d4:	00000000 	udf	#0

00000000004206d8 <dec_plt2>:
  4206d8:	00000000 	udf	#0

00000000004206dc <dec_szl>:
  4206dc:	00000000 	udf	#0

00000000004206e0 <dec_spl>:
  4206e0:	00000000 	udf	#0

00000000004206e4 <dec_sl>:
  4206e4:	00000000 	udf	#0

00000000004206e8 <dec_rlt1>:
  4206e8:	00000000 	udf	#0

00000000004206ec <dec_rlt2>:
  4206ec:	00000000 	udf	#0

00000000004206f0 <dec_rlt>:
  4206f0:	00000000 	udf	#0

00000000004206f4 <dec_al1>:
  4206f4:	00000000 	udf	#0

00000000004206f8 <dec_al2>:
  4206f8:	00000000 	udf	#0

00000000004206fc <dl>:
  4206fc:	00000000 	udf	#0

0000000000420700 <dec_nbl>:
  420700:	00000000 	udf	#0

0000000000420704 <dec_yh>:
  420704:	00000000 	udf	#0

0000000000420708 <dec_dh>:
  420708:	00000000 	udf	#0

000000000042070c <dec_nbh>:
  42070c:	00000000 	udf	#0

0000000000420710 <dec_del_bph>:
	...

0000000000420728 <dec_del_dhx>:
	...

0000000000420740 <dec_szh>:
  420740:	00000000 	udf	#0

0000000000420744 <dec_rh1>:
  420744:	00000000 	udf	#0

0000000000420748 <dec_rh2>:
  420748:	00000000 	udf	#0

000000000042074c <dec_ah1>:
  42074c:	00000000 	udf	#0

0000000000420750 <dec_ah2>:
  420750:	00000000 	udf	#0

0000000000420754 <dec_ph>:
  420754:	00000000 	udf	#0

0000000000420758 <dec_sph>:
  420758:	00000000 	udf	#0

000000000042075c <dec_sh>:
  42075c:	00000000 	udf	#0

0000000000420760 <dec_rh>:
  420760:	00000000 	udf	#0

0000000000420764 <dec_ph1>:
  420764:	00000000 	udf	#0

0000000000420768 <dec_ph2>:
	...

0000000000420770 <test_data.2>:
	...

0000000000420788 <compressed.1>:
	...

0000000000420798 <result.0>:
	...

Disassembly of section .comment:

0000000000000000 <.comment>:
   0:	3a434347 	ccmn	w26, w3, #0x7, mi  // mi = first
   4:	4e472820 	trn1	v0.8h, v1.8h, v7.8h
   8:	31202955 	adds	w21, w10, #0x80a
   c:	2e332e30 	uqsub	v16.8b, v17.8b, v19.8b
  10:	地址 0x0000000000000010 越界。


Disassembly of section .gnu.build.attributes:

00000000004207b0 <.gnu.build.attributes>:
  4207b0:	00000008 	udf	#8
  4207b4:	00000010 	udf	#16
  4207b8:	00000100 	udf	#256
  4207bc:	01244147 	.inst	0x01244147 ; undefined
  4207c0:	00316133 	.inst	0x00316133 ; NYI
  4207c4:	00400500 	.inst	0x00400500 ; undefined
  4207c8:	00000000 	udf	#0
  4207cc:	0040053c 	.inst	0x0040053c ; undefined
  4207d0:	00000000 	udf	#0
  4207d4:	00000008 	udf	#8
  4207d8:	00000010 	udf	#16
  4207dc:	00000100 	udf	#256
  4207e0:	01244147 	.inst	0x01244147 ; undefined
  4207e4:	00316133 	.inst	0x00316133 ; NYI
  4207e8:	00400544 	.inst	0x00400544 ; undefined
  4207ec:	00000000 	udf	#0
  4207f0:	00400558 	.inst	0x00400558 ; undefined
  4207f4:	00000000 	udf	#0
  4207f8:	00000008 	udf	#8
  4207fc:	00000010 	udf	#16
  420800:	00000100 	udf	#256
  420804:	01244147 	.inst	0x01244147 ; undefined
  420808:	00316133 	.inst	0x00316133 ; NYI
  42080c:	00400498 	.inst	0x00400498 ; undefined
  420810:	00000000 	udf	#0
  420814:	004004a8 	.inst	0x004004a8 ; undefined
  420818:	00000000 	udf	#0
  42081c:	00000008 	udf	#8
  420820:	00000010 	udf	#16
  420824:	00000100 	udf	#256
  420828:	01244147 	.inst	0x01244147 ; undefined
  42082c:	00316133 	.inst	0x00316133 ; NYI
  420830:	00402528 	.inst	0x00402528 ; undefined
  420834:	00000000 	udf	#0
  420838:	00402534 	.inst	0x00402534 ; undefined
  42083c:	00000000 	udf	#0
  420840:	00000008 	udf	#8
  420844:	00000010 	udf	#16
  420848:	00000100 	udf	#256
  42084c:	01244147 	.inst	0x01244147 ; undefined
  420850:	00316133 	.inst	0x00316133 ; NYI
  420854:	00402528 	.inst	0x00402528 ; undefined
  420858:	00000000 	udf	#0
  42085c:	00402528 	.inst	0x00402528 ; undefined
  420860:	00000000 	udf	#0
  420864:	00000008 	udf	#8
  420868:	00000010 	udf	#16
  42086c:	00000100 	udf	#256
  420870:	01244147 	.inst	0x01244147 ; undefined
  420874:	00316133 	.inst	0x00316133 ; NYI
  420878:	004004a8 	.inst	0x004004a8 ; undefined
  42087c:	00000000 	udf	#0
  420880:	004004b0 	.inst	0x004004b0 ; undefined
  420884:	00000000 	udf	#0
  420888:	00000008 	udf	#8
  42088c:	00000010 	udf	#16
  420890:	00000100 	udf	#256
  420894:	01244147 	.inst	0x01244147 ; undefined
  420898:	00316133 	.inst	0x00316133 ; NYI
  42089c:	00402534 	.inst	0x00402534 ; undefined
  4208a0:	00000000 	udf	#0
  4208a4:	0040253c 	.inst	0x0040253c ; undefined
  4208a8:	00000000 	udf	#0

Disassembly of section .debug_aranges:

0000000000000000 <.debug_aranges>:
   0:	0000002c 	udf	#44
   4:	00000002 	udf	#2
   8:	00080000 	.inst	0x00080000 ; undefined
   c:	00000000 	udf	#0
  10:	00400604 	.inst	0x00400604 ; undefined
  14:	00000000 	udf	#0
  18:	00001f24 	udf	#7972
	...

Disassembly of section .debug_info:

0000000000000000 <.debug_info>:
       0:	0000108d 	udf	#4237
       4:	00000004 	udf	#4
       8:	01080000 	.inst	0x01080000 ; undefined
       c:	000002df 	udf	#735
      10:	00016c0c 	.inst	0x00016c0c ; undefined
      14:	00004e00 	udf	#19968
      18:	40060400 	.inst	0x40060400 ; undefined
      1c:	00000000 	udf	#0
      20:	001f2400 	.inst	0x001f2400 ; undefined
	...
      2c:	05040200 	.inst	0x05040200 ; undefined
      30:	00746e69 	.inst	0x00746e69 ; undefined
      34:	00002d03 	udf	#11523
      38:	00004400 	udf	#17408
      3c:	00440400 	.inst	0x00440400 ; undefined
      40:	00170000 	.inst	0x00170000 ; undefined
      44:	54070805 	b.pl	e144 <__abi_tag-0x3f2134>  // b.nfrst
      48:	06000002 	.inst	0x06000002 ; undefined
      4c:	00000217 	udf	#535
      50:	34056501 	cbz	w1, acf0 <__abi_tag-0x3f5588>
      54:	09000000 	.inst	0x09000000 ; undefined
      58:	4204c803 	.inst	0x4204c803 ; undefined
      5c:	00000000 	udf	#0
      60:	00680700 	.inst	0x00680700 ; undefined
      64:	34056901 	cbz	w1, ad84 <__abi_tag-0x3f54f4>
      68:	09000000 	.inst	0x09000000 ; undefined
      6c:	42002803 	.inst	0x42002803 ; undefined
      70:	00000000 	udf	#0
      74:	6c780700 	ldnp	d0, d1, [x24, #-128]
      78:	056f0100 	ext	z0.b, {z8.b, z9.b}, #120
      7c:	0000002d 	udf	#45
      80:	05280309 	ext	z9.b, z9.b, z24.b, #64
      84:	00000042 	udf	#66
      88:	78070000 	sturh	w0, [x0, #112]
      8c:	6f010068 	.inst	0x6f010068 ; undefined
      90:	00002d08 	udf	#11528
      94:	2c030900 	stnp	s0, s2, [x8, #24]
      98:	00004205 	udf	#16901
      9c:	03000000 	.inst	0x03000000 ; undefined
      a0:	0000002d 	udf	#45
      a4:	000000af 	udf	#175
      a8:	00004404 	udf	#17412
      ac:	06000a00 	.inst	0x06000a00 ; undefined
      b0:	0000034b 	udf	#843
      b4:	9f057201 	.inst	0x9f057201 ; undefined
      b8:	09000000 	.inst	0x09000000 ; undefined
      bc:	42053003 	.inst	0x42053003 ; undefined
      c0:	00000000 	udf	#0
      c4:	03520600 	.inst	0x03520600 ; undefined
      c8:	72010000 	ands	w0, w0, #0x80000000
      cc:	00009f10 	udf	#40720
      d0:	60030900 	.inst	0x60030900 ; undefined
      d4:	00004205 	udf	#16901
      d8:	06000000 	.inst	0x06000000 ; undefined
      dc:	00000015 	udf	#21
      e0:	2d057501 	stp	s1, s29, [x8, #40]
      e4:	09000000 	.inst	0x09000000 ; undefined
      e8:	42058c03 	.inst	0x42058c03 ; undefined
      ec:	00000000 	udf	#0
      f0:	001b0600 	.inst	0x001b0600 ; undefined
      f4:	75010000 	.inst	0x75010000 ; undefined
      f8:	00002d0b 	udf	#11531
      fc:	90030900 	adrp	x0, 6120000 <__bss_end__+0x5cff850>
     100:	00004205 	udf	#16901
     104:	07000000 	.inst	0x07000000 ; undefined
     108:	01007378 	.inst	0x01007378 ; undefined
     10c:	002d0577 	.inst	0x002d0577 ; NYI
     110:	03090000 	.inst	0x03090000 ; undefined
     114:	00420594 	.inst	0x00420594 ; undefined
     118:	00000000 	udf	#0
     11c:	00647807 	.inst	0x00647807 ; undefined
     120:	2d087701 	stp	s1, s29, [x24, #64]
     124:	09000000 	.inst	0x09000000 ; undefined
     128:	42059803 	.inst	0x42059803 ; undefined
     12c:	00000000 	udf	#0
     130:	6c690700 	ldnp	d0, d1, [x24, #-368]
     134:	057b0100 	ext	z0.b, {z8.b, z9.b}, #216
     138:	0000002d 	udf	#45
     13c:	059c0309 	mov	z9.s, p12/z, #24
     140:	00000042 	udf	#66
     144:	73070000 	.inst	0x73070000 ; undefined
     148:	01006c7a 	.inst	0x01006c7a ; undefined
     14c:	002d087b 	.inst	0x002d087b ; NYI
     150:	03090000 	.inst	0x03090000 ; undefined
     154:	004205a0 	.inst	0x004205a0 ; undefined
     158:	00000000 	udf	#0
     15c:	6c707307 	ldnp	d7, d28, [x24, #-256]
     160:	0c7b0100 	.inst	0x0c7b0100 ; undefined
     164:	0000002d 	udf	#45
     168:	05a40309 	zip1	z9.q, z24.q, z4.q
     16c:	00000042 	udf	#66
     170:	73070000 	.inst	0x73070000 ; undefined
     174:	7b01006c 	.inst	0x7b01006c ; undefined
     178:	00002d10 	udf	#11536
     17c:	a8030900 	stnp	x0, x2, [x8, #48]
     180:	00004205 	udf	#16901
     184:	07000000 	.inst	0x07000000 ; undefined
     188:	01006c65 	.inst	0x01006c65 ; undefined
     18c:	002d137b 	.inst	0x002d137b ; NYI
     190:	03090000 	.inst	0x03090000 ; undefined
     194:	004205ac 	.inst	0x004205ac ; undefined
     198:	00000000 	udf	#0
     19c:	00002d03 	udf	#11523
     1a0:	0001ac00 	.inst	0x0001ac00 ; undefined
     1a4:	00440400 	.inst	0x00440400 ; undefined
     1a8:	000f0000 	.inst	0x000f0000 ; undefined
     1ac:	0002cf06 	.inst	0x0002cf06 ; undefined
     1b0:	057d0100 	ext	z0.b, {z8.b, z9.b}, #232
     1b4:	0000019c 	udf	#412
     1b8:	00880309 	.inst	0x00880309 ; undefined
     1bc:	00000042 	udf	#66
     1c0:	2d030000 	stp	s0, s0, [x0, #24]
     1c4:	d2000000 	eor	x0, x0, #0x100000001
     1c8:	04000001 	add	z1.b, p0/m, z1.b, z0.b
     1cc:	00000044 	udf	#68
     1d0:	1c06001f 	ldr	s31, c1d0 <__abi_tag-0x3f40a8>
     1d4:	01000002 	.inst	0x01000002 ; undefined
     1d8:	01c20582 	.inst	0x01c20582 ; undefined
     1dc:	03090000 	.inst	0x03090000 ; undefined
     1e0:	004200c8 	.inst	0x004200c8 ; undefined
     1e4:	00000000 	udf	#0
     1e8:	00002d03 	udf	#11523
     1ec:	0001f800 	.inst	0x0001f800 ; undefined
     1f0:	00440400 	.inst	0x00440400 ; undefined
     1f4:	003f0000 	.inst	0x003f0000 ; NYI
     1f8:	00019806 	.inst	0x00019806 ; undefined
     1fc:	05890100 	.inst	0x05890100 ; undefined
     200:	000001e8 	udf	#488
     204:	01480309 	.inst	0x01480309 ; undefined
     208:	00000042 	udf	#66
     20c:	2d030000 	stp	s0, s0, [x0, #24]
     210:	1e000000 	.inst	0x1e000000 ; undefined
     214:	04000002 	add	z2.b, p0/m, z2.b, z0.b
     218:	00000044 	udf	#68
     21c:	e2060005 	.inst	0xe2060005 ; undefined
     220:	01000001 	.inst	0x01000001 ; undefined
     224:	020e0594 	.inst	0x020e0594 ; undefined
     228:	03090000 	.inst	0x03090000 ; undefined
     22c:	004205b0 	.inst	0x004205b0 ; undefined
     230:	00000000 	udf	#0
     234:	00006d06 	udf	#27910
     238:	05960100 	mov	z0.s, p6/z, #8
     23c:	0000020e 	udf	#526
     240:	05c80309 	.inst	0x05c80309 ; undefined
     244:	00000042 	udf	#66
     248:	bc060000 	stur	s0, [x0, #96]
     24c:	01000002 	.inst	0x01000002 ; undefined
     250:	019c0598 	.inst	0x019c0598 ; undefined
     254:	03090000 	.inst	0x03090000 ; undefined
     258:	00420248 	.inst	0x00420248 ; undefined
     25c:	00000000 	udf	#0
     260:	00002d03 	udf	#11523
     264:	00027000 	.inst	0x00027000 ; undefined
     268:	00440400 	.inst	0x00440400 ; undefined
     26c:	00070000 	.inst	0x00070000 ; undefined
     270:	00023706 	.inst	0x00023706 ; undefined
     274:	059d0100 	mov	z0.s, p13/z, #8
     278:	00000260 	udf	#608
     27c:	02880309 	.inst	0x02880309 ; undefined
     280:	00000042 	udf	#66
     284:	ca060000 	eor	x0, x0, x6
     288:	01000000 	.inst	0x01000000 ; undefined
     28c:	01c205a1 	.inst	0x01c205a1 ; undefined
     290:	03090000 	.inst	0x03090000 ; undefined
     294:	004202a8 	.inst	0x004202a8 ; undefined
     298:	00000000 	udf	#0
     29c:	6c626e07 	ldnp	d7, d27, [x16, #-480]
     2a0:	0da80100 	st2	{v0.b, v1.b}[0], [x8], x8
     2a4:	0000002d 	udf	#45
     2a8:	05e00309 	.inst	0x05e00309 ; undefined
     2ac:	00000042 	udf	#66
     2b0:	61070000 	.inst	0x61070000 ; undefined
     2b4:	0100316c 	.inst	0x0100316c ; undefined
     2b8:	002d0da9 	.inst	0x002d0da9 ; NYI
     2bc:	03090000 	.inst	0x03090000 ; undefined
     2c0:	004205e4 	.inst	0x004205e4 ; undefined
     2c4:	00000000 	udf	#0
     2c8:	326c6107 	.inst	0x326c6107 ; undefined
     2cc:	11a90100 	.inst	0x11a90100 ; undefined
     2d0:	0000002d 	udf	#45
     2d4:	05e80309 	.inst	0x05e80309 ; undefined
     2d8:	00000042 	udf	#66
     2dc:	70070000 	adr	x0, e2df <__abi_tag-0x3f1f99>
     2e0:	0100746c 	.inst	0x0100746c ; undefined
     2e4:	002d0daa 	.inst	0x002d0daa ; NYI
     2e8:	03090000 	.inst	0x03090000 ; undefined
     2ec:	004205ec 	.inst	0x004205ec ; undefined
     2f0:	00000000 	udf	#0
     2f4:	0000a406 	udf	#41990
     2f8:	11aa0100 	.inst	0x11aa0100 ; undefined
     2fc:	0000002d 	udf	#45
     300:	05f00309 	.inst	0x05f00309 ; undefined
     304:	00000042 	udf	#66
     308:	ad060000 	stp	q0, q0, [x0, #192]
     30c:	01000000 	.inst	0x01000000 ; undefined
     310:	002d16aa 	.inst	0x002d16aa ; NYI
     314:	03090000 	.inst	0x03090000 ; undefined
     318:	004205f4 	.inst	0x004205f4 ; undefined
     31c:	00000000 	udf	#0
     320:	00737207 	.inst	0x00737207 ; undefined
     324:	2d0dab01 	stp	s1, s10, [x24, #108]
     328:	09000000 	.inst	0x09000000 ; undefined
     32c:	4205f803 	.inst	0x4205f803 ; undefined
     330:	00000000 	udf	#0
     334:	6c640700 	ldnp	d0, d1, [x24, #-448]
     338:	ac010074 	stnp	q20, q0, [x3, #32]
     33c:	00002d0d 	udf	#11533
     340:	fc030900 	.inst	0xfc030900 ; undefined
     344:	00004205 	udf	#16901
     348:	07000000 	.inst	0x07000000 ; undefined
     34c:	00746c72 	.inst	0x00746c72 ; undefined
     350:	2d0dad01 	stp	s1, s11, [x8, #108]
     354:	09000000 	.inst	0x09000000 ; undefined
     358:	42060003 	.inst	0x42060003 ; undefined
     35c:	00000000 	udf	#0
     360:	01ba0600 	.inst	0x01ba0600 ; undefined
     364:	ad010000 	stp	q0, q0, [x0, #32]
     368:	00002d11 	udf	#11537
     36c:	04030900 	subr	z0.b, p2/m, z0.b, z8.b
     370:	00004206 	udf	#16902
     374:	06000000 	.inst	0x06000000 ; undefined
     378:	000001f8 	udf	#504
     37c:	2d16ad01 	stp	s1, s11, [x8, #180]
     380:	09000000 	.inst	0x09000000 ; undefined
     384:	42060803 	.inst	0x42060803 ; undefined
     388:	00000000 	udf	#0
     38c:	002d0300 	.inst	0x002d0300 ; NYI
     390:	039d0000 	.inst	0x039d0000 ; undefined
     394:	44040000 	.inst	0x44040000 ; undefined
     398:	1d000000 	.inst	0x1d000000 ; undefined
     39c:	02760600 	.inst	0x02760600 ; undefined
     3a0:	b0010000 	adrp	x0, 2001000 <__bss_end__+0x1be0850>
     3a4:	00038d05 	.inst	0x00038d05 ; undefined
     3a8:	28030900 	stnp	w0, w2, [x8, #24]
     3ac:	00004203 	udf	#16899
     3b0:	06000000 	.inst	0x06000000 ; undefined
     3b4:	00000041 	udf	#65
     3b8:	2d0db701 	stp	s1, s13, [x24, #108]
     3bc:	09000000 	.inst	0x09000000 ; undefined
     3c0:	42060c03 	.inst	0x42060c03 ; undefined
     3c4:	00000000 	udf	#0
     3c8:	002d0300 	.inst	0x002d0300 ; NYI
     3cc:	03d90000 	.inst	0x03d90000 ; undefined
     3d0:	44040000 	.inst	0x44040000 ; undefined
     3d4:	1e000000 	.inst	0x1e000000 ; undefined
     3d8:	00780600 	.inst	0x00780600 ; undefined
     3dc:	bb010000 	.inst	0xbb010000 ; undefined
     3e0:	0003c905 	.inst	0x0003c905 ; undefined
     3e4:	a0030900 	.inst	0xa0030900 ; undefined
     3e8:	00004203 	udf	#16899
     3ec:	06000000 	.inst	0x06000000 ; undefined
     3f0:	00000000 	udf	#0
     3f4:	c905c401 	.inst	0xc905c401 ; undefined
     3f8:	09000003 	.inst	0x09000003 ; undefined
     3fc:	42042003 	.inst	0x42042003 ; undefined
     400:	00000000 	udf	#0
     404:	00300600 	.inst	0x00300600 ; NYI
     408:	cc010000 	.inst	0xcc010000 ; undefined
     40c:	00002d0d 	udf	#11533
     410:	10030900 	adr	x0, 6530 <__abi_tag-0x3f9d48>
     414:	00004206 	udf	#16902
     418:	07000000 	.inst	0x07000000 ; undefined
     41c:	01006873 	.inst	0x01006873 ; undefined
     420:	002d0dcd 	.inst	0x002d0dcd ; NYI
     424:	03090000 	.inst	0x03090000 ; undefined
     428:	00420614 	.inst	0x00420614 ; undefined
     42c:	00000000 	udf	#0
     430:	00686507 	.inst	0x00686507 ; undefined
     434:	2d0dce01 	stp	s1, s19, [x16, #108]
     438:	09000000 	.inst	0x09000000 ; undefined
     43c:	42061803 	.inst	0x42061803 ; undefined
     440:	00000000 	udf	#0
     444:	002d0300 	.inst	0x002d0300 ; NYI
     448:	04550000 	.inst	0x04550000 ; undefined
     44c:	44040000 	.inst	0x44040000 ; undefined
     450:	03000000 	.inst	0x03000000 ; undefined
     454:	02660600 	.inst	0x02660600 ; undefined
     458:	d0010000 	adrp	x0, 2002000 <__bss_end__+0x1be1850>
     45c:	00044505 	.inst	0x00044505 ; undefined
     460:	a0030900 	.inst	0xa0030900 ; undefined
     464:	00004204 	udf	#16900
     468:	06000000 	.inst	0x06000000 ; undefined
     46c:	000000d4 	udf	#212
     470:	4505d401 	adclt	z1.s, z0.s, z5.s
     474:	09000004 	.inst	0x09000004 ; undefined
     478:	4204b003 	.inst	0x4204b003 ; undefined
     47c:	00000000 	udf	#0
     480:	68640700 	.inst	0x68640700 ; undefined
     484:	0dd90100 	ld1	{v0.b}[0], [x8], x25
     488:	0000002d 	udf	#45
     48c:	061c0309 	.inst	0x061c0309 ; undefined
     490:	00000042 	udf	#66
     494:	69070000 	stgp	x0, x0, [x0, #224]
     498:	d9010068 	stlur	x8, [x3, #16]
     49c:	00002d10 	udf	#11536
     4a0:	20030900 	.inst	0x20030900 ; undefined
     4a4:	00004206 	udf	#16902
     4a8:	07000000 	.inst	0x07000000 ; undefined
     4ac:	0068626e 	.inst	0x0068626e ; undefined
     4b0:	2d0dda01 	stp	s1, s22, [x16, #108]
     4b4:	09000000 	.inst	0x09000000 ; undefined
     4b8:	42062403 	.inst	0x42062403 ; undefined
     4bc:	00000000 	udf	#0
     4c0:	7a730700 	.inst	0x7a730700 ; undefined
     4c4:	da010068 	sbc	x8, x3, x1
     4c8:	00002d11 	udf	#11537
     4cc:	28030900 	stnp	w0, w2, [x8, #24]
     4d0:	00004206 	udf	#16902
     4d4:	07000000 	.inst	0x07000000 ; undefined
     4d8:	00687073 	.inst	0x00687073 ; undefined
     4dc:	2d0ddb01 	stp	s1, s22, [x24, #108]
     4e0:	09000000 	.inst	0x09000000 ; undefined
     4e4:	42062c03 	.inst	0x42062c03 ; undefined
     4e8:	00000000 	udf	#0
     4ec:	68700700 	.inst	0x68700700 ; undefined
     4f0:	11db0100 	.inst	0x11db0100 ; undefined
     4f4:	0000002d 	udf	#45
     4f8:	06300309 	.inst	0x06300309 ; undefined
     4fc:	00000042 	udf	#66
     500:	79070000 	strh	w0, [x0, #896]
     504:	db010068 	.inst	0xdb010068 ; undefined
     508:	00002d14 	udf	#11540
     50c:	34030900 	cbz	w0, 662c <__abi_tag-0x3f9c4c>
     510:	00004206 	udf	#16902
     514:	07000000 	.inst	0x07000000 ; undefined
     518:	01006872 	.inst	0x01006872 ; undefined
     51c:	002d17db 	.inst	0x002d17db ; NYI
     520:	03090000 	.inst	0x03090000 ; undefined
     524:	00420638 	.inst	0x00420638 ; undefined
     528:	00000000 	udf	#0
     52c:	0001d806 	.inst	0x0001d806 ; undefined
     530:	0ddd0100 	ld1	{v0.b}[0], [x8], x29
     534:	0000020e 	udf	#526
     538:	06400309 	.inst	0x06400309 ; undefined
     53c:	00000042 	udf	#66
     540:	ce060000 	eor3	v0.16b, v0.16b, v6.16b, v0.16b
     544:	01000001 	.inst	0x01000001 ; undefined
     548:	020e0ddf 	.inst	0x020e0ddf ; undefined
     54c:	03090000 	.inst	0x03090000 ; undefined
     550:	00420658 	.inst	0x00420658 ; undefined
     554:	00000000 	udf	#0
     558:	31686107 	adds	w7, w8, #0xa18, lsl #12
     55c:	0de10100 	ld2	{v0.b, v1.b}[0], [x8], x1
     560:	0000002d 	udf	#45
     564:	06700309 	.inst	0x06700309 ; undefined
     568:	00000042 	udf	#66
     56c:	61070000 	.inst	0x61070000 ; undefined
     570:	01003268 	.inst	0x01003268 ; undefined
     574:	002d11e1 	.inst	0x002d11e1 ; NYI
     578:	03090000 	.inst	0x03090000 ; undefined
     57c:	00420674 	.inst	0x00420674 ; undefined
     580:	00000000 	udf	#0
     584:	31687007 	adds	w7, w0, #0xa1c, lsl #12
     588:	0de20100 	ld2	{v0.b, v1.b}[0], [x8], x2
     58c:	0000002d 	udf	#45
     590:	06780309 	.inst	0x06780309 ; undefined
     594:	00000042 	udf	#66
     598:	70070000 	adr	x0, e59b <__abi_tag-0x3f1cdd>
     59c:	01003268 	.inst	0x01003268 ; undefined
     5a0:	002d11e2 	.inst	0x002d11e2 ; NYI
     5a4:	03090000 	.inst	0x03090000 ; undefined
     5a8:	0042067c 	.inst	0x0042067c ; undefined
     5ac:	00000000 	udf	#0
     5b0:	31687207 	adds	w7, w16, #0xa1c, lsl #12
     5b4:	0de30100 	ld2	{v0.b, v1.b}[0], [x8], x3
     5b8:	0000002d 	udf	#45
     5bc:	06800309 	.inst	0x06800309 ; undefined
     5c0:	00000042 	udf	#66
     5c4:	72070000 	ands	w0, w0, #0x2000000
     5c8:	01003268 	.inst	0x01003268 ; undefined
     5cc:	002d11e3 	.inst	0x002d11e3 ; NYI
     5d0:	03090000 	.inst	0x03090000 ; undefined
     5d4:	00420684 	.inst	0x00420684 ; undefined
     5d8:	00000000 	udf	#0
     5dc:	726c6907 	.inst	0x726c6907 ; undefined
     5e0:	0de60100 	ld2	{v0.b, v1.b}[0], [x8], x6
     5e4:	0000002d 	udf	#45
     5e8:	06880309 	.inst	0x06880309 ; undefined
     5ec:	00000042 	udf	#66
     5f0:	79070000 	strh	w0, [x0, #896]
     5f4:	e601006c 	.inst	0xe601006c ; undefined
     5f8:	00002d11 	udf	#11537
     5fc:	8c030900 	.inst	0x8c030900 ; undefined
     600:	00004206 	udf	#16902
     604:	07000000 	.inst	0x07000000 ; undefined
     608:	01006c72 	.inst	0x01006c72 ; undefined
     60c:	002d14e6 	.inst	0x002d14e6 ; NYI
     610:	03090000 	.inst	0x03090000 ; undefined
     614:	00420690 	.inst	0x00420690 ; undefined
     618:	00000000 	udf	#0
     61c:	00002c06 	udf	#11270
     620:	0de70100 	ld2	{v0.b, v1.b}[0], [x8], x7
     624:	0000002d 	udf	#45
     628:	06940309 	.inst	0x06940309 ; undefined
     62c:	00000042 	udf	#66
     630:	3d060000 	str	b0, [x0, #384]
     634:	01000000 	.inst	0x01000000 ; undefined
     638:	002d16e7 	.inst	0x002d16e7 ; NYI
     63c:	03090000 	.inst	0x03090000 ; undefined
     640:	00420698 	.inst	0x00420698 ; undefined
     644:	00000000 	udf	#0
     648:	0001ec06 	.inst	0x0001ec06 ; undefined
     64c:	1fe70100 	fnmadd	h0, h8, h7, h0
     650:	0000002d 	udf	#45
     654:	069c0309 	.inst	0x069c0309 ; undefined
     658:	00000042 	udf	#66
     65c:	94060000 	bl	18065c <__abi_tag-0x27fc1c>
     660:	01000002 	.inst	0x01000002 ; undefined
     664:	020e0de9 	.inst	0x020e0de9 ; undefined
     668:	03090000 	.inst	0x03090000 ; undefined
     66c:	004206a0 	.inst	0x004206a0 ; undefined
     670:	00000000 	udf	#0
     674:	00024006 	.inst	0x00024006 ; undefined
     678:	0deb0100 	ld2	{v0.b, v1.b}[0], [x8], x11
     67c:	0000020e 	udf	#526
     680:	06b80309 	.inst	0x06b80309 ; undefined
     684:	00000042 	udf	#66
     688:	e2060000 	.inst	0xe2060000 ; undefined
     68c:	01000000 	.inst	0x01000000 ; undefined
     690:	002d09ed 	.inst	0x002d09ed ; NYI
     694:	03090000 	.inst	0x03090000 ; undefined
     698:	004206d0 	.inst	0x004206d0 ; undefined
     69c:	00000000 	udf	#0
     6a0:	0000a006 	udf	#40966
     6a4:	11ed0100 	.inst	0x11ed0100 ; undefined
     6a8:	0000002d 	udf	#45
     6ac:	06d40309 	.inst	0x06d40309 ; undefined
     6b0:	00000042 	udf	#66
     6b4:	a9060000 	stp	x0, x0, [x0, #96]
     6b8:	01000000 	.inst	0x01000000 ; undefined
     6bc:	002d1aed 	.inst	0x002d1aed ; NYI
     6c0:	03090000 	.inst	0x03090000 ; undefined
     6c4:	004206d8 	.inst	0x004206d8 ; undefined
     6c8:	00000000 	udf	#0
     6cc:	00004606 	udf	#17926
     6d0:	09ee0100 	.inst	0x09ee0100 ; undefined
     6d4:	0000002d 	udf	#45
     6d8:	06dc0309 	.inst	0x06dc0309 ; undefined
     6dc:	00000042 	udf	#66
     6e0:	5b060000 	.inst	0x5b060000 ; undefined
     6e4:	01000001 	.inst	0x01000001 ; undefined
     6e8:	002d11ee 	.inst	0x002d11ee ; NYI
     6ec:	03090000 	.inst	0x03090000 ; undefined
     6f0:	004206e0 	.inst	0x004206e0 ; undefined
     6f4:	00000000 	udf	#0
     6f8:	0002ae06 	.inst	0x0002ae06 ; undefined
     6fc:	19ee0100 	.inst	0x19ee0100 ; undefined
     700:	0000002d 	udf	#45
     704:	06e40309 	.inst	0x06e40309 ; undefined
     708:	00000042 	udf	#66
     70c:	b6060000 	tbz	x0, #32, ffffffffffffc70c <__bss_end__+0xffffffffffbdbf5c>
     710:	01000001 	.inst	0x01000001 ; undefined
     714:	002d09ef 	.inst	0x002d09ef ; NYI
     718:	03090000 	.inst	0x03090000 ; undefined
     71c:	004206e8 	.inst	0x004206e8 ; undefined
     720:	00000000 	udf	#0
     724:	0001f406 	.inst	0x0001f406 ; undefined
     728:	12ef0100 	.inst	0x12ef0100 ; undefined
     72c:	0000002d 	udf	#45
     730:	06ec0309 	.inst	0x06ec0309 ; undefined
     734:	00000042 	udf	#66
     738:	bf060000 	.inst	0xbf060000 ; undefined
     73c:	01000001 	.inst	0x01000001 ; undefined
     740:	002d1bef 	.inst	0x002d1bef ; NYI
     744:	03090000 	.inst	0x03090000 ; undefined
     748:	004206f0 	.inst	0x004206f0 ; undefined
     74c:	00000000 	udf	#0
     750:	0000ba06 	udf	#47622
     754:	09f00100 	.inst	0x09f00100 ; undefined
     758:	0000002d 	udf	#45
     75c:	06f40309 	.inst	0x06f40309 ; undefined
     760:	00000042 	udf	#66
     764:	c2060000 	.inst	0xc2060000 ; undefined
     768:	01000000 	.inst	0x01000000 ; undefined
     76c:	002d11f0 	.inst	0x002d11f0 ; NYI
     770:	03090000 	.inst	0x03090000 ; undefined
     774:	004206f8 	.inst	0x004206f8 ; undefined
     778:	00000000 	udf	#0
     77c:	006c6407 	.inst	0x006c6407 ; undefined
     780:	2d09f101 	stp	s1, s28, [x8, #76]
     784:	09000000 	.inst	0x09000000 ; undefined
     788:	4206fc03 	.inst	0x4206fc03 ; undefined
     78c:	00000000 	udf	#0
     790:	00f80600 	.inst	0x00f80600 ; undefined
     794:	f2010000 	ands	x0, x0, #0x8000000080000000
     798:	00002d09 	udf	#11529
     79c:	00030900 	.inst	0x00030900 ; undefined
     7a0:	00004207 	udf	#16903
     7a4:	06000000 	.inst	0x06000000 ; undefined
     7a8:	00000154 	udf	#340
     7ac:	2d11f201 	stp	s1, s28, [x16, #140]
     7b0:	09000000 	.inst	0x09000000 ; undefined
     7b4:	42070403 	.inst	0x42070403 ; undefined
     7b8:	00000000 	udf	#0
     7bc:	02a00600 	.inst	0x02a00600 ; undefined
     7c0:	f2010000 	ands	x0, x0, #0x8000000080000000
     7c4:	00002d18 	udf	#11544
     7c8:	08030900 	stxrb	w3, w0, [x8]
     7cc:	00004207 	udf	#16903
     7d0:	06000000 	.inst	0x06000000 ; undefined
     7d4:	000000f0 	udf	#240
     7d8:	2d1ff201 	stp	s1, s28, [x16, #252]
     7dc:	09000000 	.inst	0x09000000 ; undefined
     7e0:	42070c03 	.inst	0x42070c03 ; undefined
     7e4:	00000000 	udf	#0
     7e8:	02810600 	.inst	0x02810600 ; undefined
     7ec:	f5010000 	.inst	0xf5010000 ; undefined
     7f0:	00020e0d 	.inst	0x00020e0d ; undefined
     7f4:	10030900 	adr	x0, 6914 <__abi_tag-0x3f9964>
     7f8:	00004207 	udf	#16903
     7fc:	06000000 	.inst	0x06000000 ; undefined
     800:	00000185 	udf	#389
     804:	0e0df701 	.inst	0x0e0df701 ; undefined
     808:	09000002 	.inst	0x09000002 ; undefined
     80c:	42072803 	.inst	0x42072803 ; undefined
     810:	00000000 	udf	#0
     814:	00350600 	.inst	0x00350600 ; NYI
     818:	f9010000 	str	x0, [x0, #512]
     81c:	00002d0d 	udf	#11533
     820:	40030900 	.inst	0x40030900 ; undefined
     824:	00004207 	udf	#16903
     828:	06000000 	.inst	0x06000000 ; undefined
     82c:	000000b2 	udf	#178
     830:	2d0dfb01 	stp	s1, s30, [x24, #108]
     834:	09000000 	.inst	0x09000000 ; undefined
     838:	42074403 	.inst	0x42074403 ; undefined
     83c:	00000000 	udf	#0
     840:	01340600 	.inst	0x01340600 ; undefined
     844:	fb010000 	.inst	0xfb010000 ; undefined
     848:	00002d15 	udf	#11541
     84c:	48030900 	stxrh	w3, w0, [x8]
     850:	00004207 	udf	#16903
     854:	06000000 	.inst	0x06000000 ; undefined
     858:	00000093 	udf	#147
     85c:	2d0dfc01 	stp	s1, s31, [x0, #108]
     860:	09000000 	.inst	0x09000000 ; undefined
     864:	42074c03 	.inst	0x42074c03 ; undefined
     868:	00000000 	udf	#0
     86c:	01160600 	.inst	0x01160600 ; undefined
     870:	fc010000 	stur	d0, [x0, #16]
     874:	00002d15 	udf	#11541
     878:	50030900 	adr	x0, 699a <__abi_tag-0x3f98de>
     87c:	00004207 	udf	#16903
     880:	06000000 	.inst	0x06000000 ; undefined
     884:	00000100 	udf	#256
     888:	2d0dfd01 	stp	s1, s31, [x8, #108]
     88c:	09000000 	.inst	0x09000000 ; undefined
     890:	42075403 	.inst	0x42075403 ; undefined
     894:	00000000 	udf	#0
     898:	014c0600 	.inst	0x014c0600 ; undefined
     89c:	fd010000 	str	d0, [x0, #512]
     8a0:	00002d14 	udf	#11540
     8a4:	58030900 	ldr	x0, 69c4 <__abi_tag-0x3f98b4>
     8a8:	00004207 	udf	#16903
     8ac:	06000000 	.inst	0x06000000 ; undefined
     8b0:	000002a7 	udf	#679
     8b4:	2d09ff01 	stp	s1, s31, [x24, #76]
     8b8:	09000000 	.inst	0x09000000 ; undefined
     8bc:	42075c03 	.inst	0x42075c03 ; undefined
     8c0:	00000000 	udf	#0
     8c4:	01c70600 	.inst	0x01c70600 ; undefined
     8c8:	ff010000 	.inst	0xff010000 ; undefined
     8cc:	00002d10 	udf	#11536
     8d0:	60030900 	.inst	0x60030900 ; undefined
     8d4:	00004207 	udf	#16903
     8d8:	08000000 	stxrb	w0, w0, [x0]
     8dc:	0000013c 	udf	#316
     8e0:	09010101 	.inst	0x09010101 ; undefined
     8e4:	0000002d 	udf	#45
     8e8:	07640309 	.inst	0x07640309 ; undefined
     8ec:	00000042 	udf	#66
     8f0:	44080000 	.inst	0x44080000 ; undefined
     8f4:	01000001 	.inst	0x01000001 ; undefined
     8f8:	2d110101 	stp	s1, s0, [x8, #136]
     8fc:	09000000 	.inst	0x09000000 ; undefined
     900:	42076803 	.inst	0x42076803 ; undefined
     904:	00000000 	udf	#0
     908:	009b0900 	.inst	0x009b0900 ; undefined
     90c:	36010000 	tbz	w0, #0, 290c <__abi_tag-0x3fd96c>
     910:	002d0503 	.inst	0x002d0503 ; NYI
     914:	23780000 	.inst	0x23780000 ; undefined
     918:	00000040 	udf	#64
     91c:	01b00000 	.inst	0x01b00000 ; undefined
     920:	00000000 	udf	#0
     924:	9c010000 	ldr	q0, 2924 <__abi_tag-0x3fd954>
     928:	0000099c 	udf	#2460
     92c:	0100690a 	.inst	0x0100690a ; undefined
     930:	2d090338 	stp	s24, s0, [x25, #72]
     934:	02000000 	.inst	0x02000000 ; undefined
     938:	6a0a7c91 	ands	w17, w4, w10, lsl #31
     93c:	03380100 	.inst	0x03380100 ; undefined
     940:	00002d0b 	udf	#11531
     944:	78910200 	ldursh	x0, [x16, #-240]
     948:	0100660a 	.inst	0x0100660a ; undefined
     94c:	2d0d0338 	stp	s24, s0, [x25, #104]
     950:	02000000 	.inst	0x02000000 ; undefined
     954:	290b7491 	stp	w17, w29, [x4, #88]
     958:	01000003 	.inst	0x01000003 ; undefined
     95c:	0e100339 	tbl	v25.8b, {v25.16b}, v16.8b
     960:	09000002 	.inst	0x09000002 ; undefined
     964:	42077003 	.inst	0x42077003 ; undefined
     968:	00000000 	udf	#0
     96c:	022c0b00 	.inst	0x022c0b00 ; undefined
     970:	39010000 	strb	w0, [x0, #64]
     974:	099c2203 	.inst	0x099c2203 ; undefined
     978:	03090000 	.inst	0x03090000 ; undefined
     97c:	00420788 	.inst	0x00420788 ; undefined
     980:	00000000 	udf	#0
     984:	00000e0b 	udf	#3595
     988:	03390100 	.inst	0x03390100 ; undefined
     98c:	00020e33 	.inst	0x00020e33 ; undefined
     990:	98030900 	ldrsw	x0, 6ab0 <__abi_tag-0x3f97c8>
     994:	00004207 	udf	#16903
     998:	00000000 	udf	#0
     99c:	00002d03 	udf	#11523
     9a0:	0009ac00 	.inst	0x0009ac00 ; undefined
     9a4:	00440400 	.inst	0x00440400 ; undefined
     9a8:	00020000 	.inst	0x00020000 ; undefined
     9ac:	0001fd0c 	.inst	0x0001fd0c ; undefined
     9b0:	032a0100 	.inst	0x032a0100 ; undefined
     9b4:	00002d05 	udf	#11525
     9b8:	40230400 	.inst	0x40230400 ; undefined
     9bc:	00000000 	udf	#0
     9c0:	00007400 	udf	#29696
     9c4:	00000000 	udf	#0
     9c8:	fe9c0100 	.inst	0xfe9c0100 ; undefined
     9cc:	0d000009 	st1	{v9.b}[0], [x0]
     9d0:	01006869 	.inst	0x01006869 ; undefined
     9d4:	2d10032a 	stp	s10, s0, [x25, #128]
     9d8:	02000000 	.inst	0x02000000 ; undefined
     9dc:	6e0d6c91 	mov	v17.b[6], v4.b[13]
     9e0:	01006862 	.inst	0x01006862 ; undefined
     9e4:	2d17032a 	stp	s10, s0, [x25, #184]
     9e8:	02000000 	.inst	0x02000000 ; undefined
     9ec:	770a6891 	.inst	0x770a6891 ; undefined
     9f0:	2c010064 	stnp	s4, s0, [x3, #8]
     9f4:	002d0903 	.inst	0x002d0903 ; NYI
     9f8:	91020000 	add	x0, x0, #0x80
     9fc:	a80c007c 	stnp	x28, x0, [x3, #192]
     a00:	01000001 	.inst	0x01000001 ; undefined
     a04:	2d05030b 	stp	s11, s0, [x24, #40]
     a08:	54000000 	b.eq	a08 <__abi_tag-0x3ff870>  // b.none
     a0c:	00004022 	udf	#16418
     a10:	b0000000 	adrp	x0, 1000 <__abi_tag-0x3ff278>
     a14:	00000000 	udf	#0
     a18:	01000000 	.inst	0x01000000 ; undefined
     a1c:	000a929c 	.inst	0x000a929c ; undefined
     a20:	6c610d00 	ldnp	d0, d3, [x8, #-496]
     a24:	0b010031 	add	w17, w1, w1
     a28:	002d1003 	.inst	0x002d1003 ; NYI
     a2c:	91020000 	add	x0, x0, #0x80
     a30:	02040e5c 	.inst	0x02040e5c ; undefined
     a34:	0b010000 	add	w0, w0, w1
     a38:	002d1803 	.inst	0x002d1803 ; NYI
     a3c:	91020000 	add	x0, x0, #0x80
     a40:	6c700d58 	ldnp	d24, d3, [x10, #-256]
     a44:	0b010074 	add	w20, w3, w1
     a48:	002d2103 	.inst	0x002d2103 ; NYI
     a4c:	91020000 	add	x0, x0, #0x80
     a50:	00a40e54 	.inst	0x00a40e54 ; undefined
     a54:	0b010000 	add	w0, w0, w1
     a58:	002d2903 	.inst	0x002d2903 ; NYI
     a5c:	91020000 	add	x0, x0, #0x80
     a60:	64770a50 	.inst	0x64770a50 ; undefined
     a64:	0d010032 	.inst	0x0d010032 ; undefined
     a68:	0a920e03 	and	w3, w16, w18, asr #3
     a6c:	91020000 	add	x0, x0, #0x80
     a70:	64770a70 	.inst	0x64770a70 ; undefined
     a74:	0e010033 	tbl	v19.8b, {v1.16b}, v1.8b
     a78:	002d0903 	.inst	0x002d0903 ; NYI
     a7c:	91020000 	add	x0, x0, #0x80
     a80:	02ca0b6c 	.inst	0x02ca0b6c ; undefined
     a84:	0e010000 	tbl	v0.8b, {v0.16b}, v1.8b
     a88:	002d0d03 	.inst	0x002d0d03 ; NYI
     a8c:	91020000 	add	x0, x0, #0x80
     a90:	0805007c 	stxrb	w5, w28, [x3]
     a94:	00012405 	.inst	0x00012405 ; undefined
     a98:	01af0c00 	.inst	0x01af0c00 ; undefined
     a9c:	f3010000 	.inst	0xf3010000 ; undefined
     aa0:	002d0502 	.inst	0x002d0502 ; NYI
     aa4:	217c0000 	.inst	0x217c0000 ; undefined
     aa8:	00000040 	udf	#64
     aac:	00d80000 	.inst	0x00d80000 ; undefined
     ab0:	00000000 	udf	#0
     ab4:	9c010000 	ldr	q0, 2ab4 <__abi_tag-0x3fd7c4>
     ab8:	00000b3d 	udf	#2877
     abc:	316c610d 	adds	w13, w8, #0xb18, lsl #12
     ac0:	02f30100 	.inst	0x02f30100 ; undefined
     ac4:	00002d10 	udf	#11536
     ac8:	5c910200 	ldr	d0, fffffffffff22b08 <__bss_end__+0xffffffffffb02358>
     acc:	326c610d 	.inst	0x326c610d ; undefined
     ad0:	02f30100 	.inst	0x02f30100 ; undefined
     ad4:	00002d18 	udf	#11544
     ad8:	58910200 	ldr	x0, fffffffffff22b18 <__bss_end__+0xffffffffffb02368>
     adc:	746c700d 	.inst	0x746c700d ; undefined
     ae0:	02f30100 	.inst	0x02f30100 ; undefined
     ae4:	00002d20 	udf	#11552
     ae8:	54910200 	b.eq	fffffffffff22b28 <__bss_end__+0xffffffffffb02378>  // b.none
     aec:	0000a40e 	udf	#41998
     af0:	02f30100 	.inst	0x02f30100 ; undefined
     af4:	00002d28 	udf	#11560
     af8:	50910200 	adr	x0, fffffffffff22b3a <__bss_end__+0xffffffffffb0238a>
     afc:	0000ad0e 	udf	#44302
     b00:	02f30100 	.inst	0x02f30100 ; undefined
     b04:	00002d31 	udf	#11569
     b08:	4c910200 	st4	{v0.16b-v3.16b}, [x16], x17
     b0c:	3264770a 	.inst	0x3264770a ; undefined
     b10:	02f50100 	.inst	0x02f50100 ; undefined
     b14:	000a920e 	.inst	0x000a920e ; undefined
     b18:	78910200 	ldursh	x0, [x16, #-240]
     b1c:	3464770a 	cbz	w10, c99fc <__abi_tag-0x33687c>
     b20:	02f50100 	.inst	0x02f50100 ; undefined
     b24:	000a9212 	.inst	0x000a9212 ; undefined
     b28:	70910200 	adr	x0, fffffffffff22b6b <__bss_end__+0xffffffffffb023bb>
     b2c:	0002040b 	.inst	0x0002040b ; undefined
     b30:	02f60100 	.inst	0x02f60100 ; undefined
     b34:	00002d09 	udf	#11529
     b38:	6c910200 	stp	d0, d0, [x16], #272
     b3c:	02090f00 	.inst	0x02090f00 ; undefined
     b40:	d7010000 	.inst	0xd7010000 ; undefined
     b44:	1fec0602 	fnmadd	h2, h16, h12, h1
     b48:	00000040 	udf	#64
     b4c:	01900000 	.inst	0x01900000 ; undefined
     b50:	00000000 	udf	#0
     b54:	9c010000 	ldr	q0, 2b54 <__abi_tag-0x3fd724>
     b58:	00000bbb 	udf	#3003
     b5c:	746c640d 	.inst	0x746c640d ; undefined
     b60:	02d70100 	.inst	0x02d70100 ; undefined
     b64:	00002d11 	udf	#11537
     b68:	6c910200 	stp	d0, d0, [x16], #272
     b6c:	00017b0e 	.inst	0x00017b0e ; undefined
     b70:	02d70100 	.inst	0x02d70100 ; undefined
     b74:	000bbb1a 	.inst	0x000bbb1a ; undefined
     b78:	60910200 	.inst	0x60910200 ; undefined
     b7c:	696c620d 	ldpsw	x13, x24, [x16, #-160]
     b80:	02d70100 	.inst	0x02d70100 ; undefined
     b84:	000bbb24 	.inst	0x000bbb24 ; undefined
     b88:	58910200 	ldr	x0, fffffffffff22bc8 <__bss_end__+0xffffffffffb02418>
     b8c:	0100690a 	.inst	0x0100690a ; undefined
     b90:	2d0902d9 	stp	s25, s0, [x22, #72]
     b94:	02000000 	.inst	0x02000000 ; undefined
     b98:	770a7c91 	.inst	0x770a7c91 ; undefined
     b9c:	01003264 	.inst	0x01003264 ; undefined
     ba0:	2d0b02d9 	stp	s25, s0, [x22, #88]
     ba4:	02000000 	.inst	0x02000000 ; undefined
     ba8:	770a7891 	.inst	0x770a7891 ; undefined
     bac:	01003364 	.inst	0x01003364 ; undefined
     bb0:	2d0f02d9 	stp	s25, s0, [x22, #120]
     bb4:	02000000 	.inst	0x02000000 ; undefined
     bb8:	10007491 	adr	x17, 1a48 <__abi_tag-0x3fe830>
     bbc:	00002d08 	udf	#11528
     bc0:	012d0c00 	.inst	0x012d0c00 ; undefined
     bc4:	cb010000 	sub	x0, x0, x1
     bc8:	002d0502 	.inst	0x002d0502 ; NYI
     bcc:	1f8c0000 	.inst	0x1f8c0000 ; undefined
     bd0:	00000040 	udf	#64
     bd4:	00600000 	.inst	0x00600000 ; undefined
     bd8:	00000000 	udf	#0
     bdc:	9c010000 	ldr	q0, 2bdc <__abi_tag-0x3fd69c>
     be0:	00000c35 	udf	#3125
     be4:	6c626e0d 	ldnp	d13, d27, [x16, #-480]
     be8:	02cb0100 	.inst	0x02cb0100 ; undefined
     bec:	00002d10 	udf	#11536
     bf0:	6c910200 	stp	d0, d0, [x16], #272
     bf4:	0001070e 	.inst	0x0001070e ; undefined
     bf8:	02cb0100 	.inst	0x02cb0100 ; undefined
     bfc:	00002d18 	udf	#11544
     c00:	68910200 	stgp	x0, x0, [x16], #544
     c04:	3164770a 	adds	w10, w24, #0x91d, lsl #12
     c08:	02cd0100 	.inst	0x02cd0100 ; undefined
     c0c:	00002d09 	udf	#11529
     c10:	7c910200 	.inst	0x7c910200 ; undefined
     c14:	3264770a 	.inst	0x3264770a ; undefined
     c18:	02cd0100 	.inst	0x02cd0100 ; undefined
     c1c:	00002d0d 	udf	#11533
     c20:	78910200 	ldursh	x0, [x16, #-240]
     c24:	3364770a 	.inst	0x3364770a ; undefined
     c28:	02cd0100 	.inst	0x02cd0100 ; undefined
     c2c:	00002d11 	udf	#11537
     c30:	74910200 	.inst	0x74910200 ; undefined
     c34:	02100c00 	.inst	0x02100c00 ; undefined
     c38:	bf010000 	.inst	0xbf010000 ; undefined
     c3c:	002d0502 	.inst	0x002d0502 ; NYI
     c40:	1f0c0000 	fmadd	s0, s0, s12, s0
     c44:	00000040 	udf	#64
     c48:	00800000 	.inst	0x00800000 ; undefined
     c4c:	00000000 	udf	#0
     c50:	9c010000 	ldr	q0, 2c50 <__abi_tag-0x3fd628>
     c54:	00000c87 	udf	#3207
     c58:	006c690d 	.inst	0x006c690d ; undefined
     c5c:	1002bf01 	adr	x1, 643c <__abi_tag-0x3f9e3c>
     c60:	0000002d 	udf	#45
     c64:	0d6c9102 	.inst	0x0d6c9102 ; undefined
     c68:	006c626e 	.inst	0x006c626e ; undefined
     c6c:	1702bf01 	b	fffffffffc0b0870 <__bss_end__+0xfffffffffbc900c0>
     c70:	0000002d 	udf	#45
     c74:	0a689102 	.inst	0x0a689102 ; undefined
     c78:	01006477 	.inst	0x01006477 ; undefined
     c7c:	920e02c1 	and	x1, x22, #0x4000000040000
     c80:	0200000a 	.inst	0x0200000a ; undefined
     c84:	11007891 	add	w17, w4, #0x1e
     c88:	0000024d 	udf	#589
     c8c:	05029f01 	orr	z1.d, z1.d, #0xffffe03fffffffff
     c90:	0000002d 	udf	#45
     c94:	00401e4c 	.inst	0x00401e4c ; undefined
     c98:	00000000 	udf	#0
     c9c:	000000c0 	udf	#192
     ca0:	00000000 	udf	#0
     ca4:	0d099c01 	.inst	0x0d099c01 ; undefined
     ca8:	650d0000 	.inst	0x650d0000 ; undefined
     cac:	9f01006c 	.inst	0x9f01006c ; undefined
     cb0:	002d1002 	.inst	0x002d1002 ; NYI
     cb4:	91020000 	add	x0, x0, #0x80
     cb8:	00410e5c 	.inst	0x00410e5c ; undefined
     cbc:	9f010000 	.inst	0x9f010000 ; undefined
     cc0:	002d1702 	.inst	0x002d1702 ; NYI
     cc4:	91020000 	add	x0, x0, #0x80
     cc8:	69720a58 	ldpsw	x24, x2, [x18, #-112]
     ccc:	a101006c 	.inst	0xa101006c ; undefined
     cd0:	002d0902 	.inst	0x002d0902 ; NYI
     cd4:	91020000 	add	x0, x0, #0x80
     cd8:	696d0a7c 	ldpsw	x28, x2, [x19, #-152]
     cdc:	a101006c 	.inst	0xa101006c ; undefined
     ce0:	002d0d02 	.inst	0x002d0d02 ; NYI
     ce4:	91020000 	add	x0, x0, #0x80
     ce8:	64770a78 	.inst	0x64770a78 ; undefined
     cec:	02a20100 	.inst	0x02a20100 ; undefined
     cf0:	000a920e 	.inst	0x000a920e ; undefined
     cf4:	70910200 	adr	x0, fffffffffff22d37 <__bss_end__+0xffffffffffb02587>
     cf8:	0000ea0b 	udf	#59915
     cfc:	02a20100 	.inst	0x02a20100 ; undefined
     d00:	000a9211 	.inst	0x000a9211 ; undefined
     d04:	68910200 	stgp	x0, x0, [x16], #544
     d08:	03220c00 	.inst	0x03220c00 ; undefined
     d0c:	94010000 	bl	40d0c <__abi_tag-0x3bf56c>
     d10:	002d0502 	.inst	0x002d0502 ; NYI
     d14:	1de00000 	.inst	0x1de00000 ; undefined
     d18:	00000040 	udf	#64
     d1c:	006c0000 	.inst	0x006c0000 ; undefined
     d20:	00000000 	udf	#0
     d24:	9c010000 	ldr	q0, 2d24 <__abi_tag-0x3fd554>
     d28:	00000d8c 	udf	#3468
     d2c:	0001ba0e 	.inst	0x0001ba0e ; undefined
     d30:	02940100 	.inst	0x02940100 ; undefined
     d34:	00002d10 	udf	#11536
     d38:	6c910200 	stp	d0, d0, [x16], #272
     d3c:	316c610d 	adds	w13, w8, #0xb18, lsl #12
     d40:	02940100 	.inst	0x02940100 ; undefined
     d44:	00002d19 	udf	#11545
     d48:	68910200 	stgp	x0, x0, [x16], #544
     d4c:	0001f80e 	.inst	0x0001f80e ; undefined
     d50:	02940100 	.inst	0x02940100 ; undefined
     d54:	00002d21 	udf	#11553
     d58:	64910200 	fcmla	z0.s, p0/m, z16.s, z17.s, #0
     d5c:	326c610d 	.inst	0x326c610d ; undefined
     d60:	02940100 	.inst	0x02940100 ; undefined
     d64:	00002d2a 	udf	#11562
     d68:	60910200 	.inst	0x60910200 ; undefined
     d6c:	006c700a 	.inst	0x006c700a ; undefined
     d70:	0e029601 	.inst	0x0e029601 ; undefined
     d74:	00000a92 	udf	#2706
     d78:	0a789102 	.inst	0x0a789102 ; undefined
     d7c:	00326c70 	.inst	0x00326c70 ; NYI
     d80:	11029601 	add	w1, w16, #0xa5
     d84:	00000a92 	udf	#2706
     d88:	00709102 	.inst	0x00709102 ; undefined
     d8c:	0003330c 	.inst	0x0003330c ; undefined
     d90:	02850100 	.inst	0x02850100 ; undefined
     d94:	00002d05 	udf	#11525
     d98:	401d3800 	.inst	0x401d3800 ; undefined
     d9c:	00000000 	udf	#0
     da0:	0000a800 	udf	#43008
     da4:	00000000 	udf	#0
     da8:	ed9c0100 	.inst	0xed9c0100 ; undefined
     dac:	0d00000d 	st1	{v13.b}[0], [x0]
     db0:	006c7062 	.inst	0x006c7062 ; undefined
     db4:	11028501 	add	w1, w8, #0xa1
     db8:	00000bbb 	udf	#3003
     dbc:	0d689102 	.inst	0x0d689102 ; undefined
     dc0:	00746c64 	.inst	0x00746c64 ; undefined
     dc4:	1a028501 	.inst	0x1a028501 ; undefined
     dc8:	00000bbb 	udf	#3003
     dcc:	0a609102 	.inst	0x0a609102 ; undefined
     dd0:	87010069 	.inst	0x87010069 ; undefined
     dd4:	002d0902 	.inst	0x002d0902 ; NYI
     dd8:	91020000 	add	x0, x0, #0x80
     ddc:	6c7a0a7c 	ldnp	d28, d2, [x19, #-96]
     de0:	02880100 	.inst	0x02880100 ; undefined
     de4:	000a920e 	.inst	0x000a920e ; undefined
     de8:	70910200 	adr	x0, fffffffffff22e2b <__bss_end__+0xffffffffffb0267b>
     dec:	03591200 	.inst	0x03591200 ; undefined
     df0:	60010000 	.inst	0x60010000 ; undefined
     df4:	19380602 	.inst	0x19380602 ; undefined
     df8:	00000040 	udf	#64
     dfc:	04000000 	add	z0.b, p0/m, z0.b, z0.b
     e00:	00000000 	udf	#0
     e04:	9c010000 	ldr	q0, 2e04 <__abi_tag-0x3fd474>
     e08:	00000e1b 	udf	#3611
     e0c:	0100690a 	.inst	0x0100690a ; undefined
     e10:	2d090262 	stp	s2, s0, [x19, #72]
     e14:	02000000 	.inst	0x02000000 ; undefined
     e18:	13007c91 	asr	w17, w4, #0
     e1c:	0000033a 	udf	#826
     e20:	0601d701 	.inst	0x0601d701 ; undefined
     e24:	00401098 	.inst	0x00401098 ; undefined
     e28:	00000000 	udf	#0
     e2c:	000008a0 	udf	#2208
     e30:	00000000 	udf	#0
     e34:	0eca9c01 	.inst	0x0eca9c01 ; undefined
     e38:	210e0000 	.inst	0x210e0000 ; undefined
     e3c:	01000000 	.inst	0x01000000 ; undefined
     e40:	2d1101d7 	stp	s23, s0, [x14, #136]
     e44:	03000000 	.inst	0x03000000 ; undefined
     e48:	0a7fbc91 	.inst	0x0a7fbc91 ; undefined
     e4c:	d9010069 	stlur	x9, [x3, #16]
     e50:	002d0901 	.inst	0x002d0901 ; NYI
     e54:	91020000 	add	x0, x0, #0x80
     e58:	61780a7c 	.inst	0x61780a7c ; undefined
     e5c:	da010031 	sbc	x17, x1, x1
     e60:	0a920e01 	and	w1, w16, w18, asr #3
     e64:	91020000 	add	x0, x0, #0x80
     e68:	61780a70 	.inst	0x61780a70 ; undefined
     e6c:	da010032 	sbc	x18, x1, x1
     e70:	0a921201 	and	w1, w16, w18, asr #4
     e74:	91020000 	add	x0, x0, #0x80
     e78:	011e0b68 	.inst	0x011e0b68 ; undefined
     e7c:	db010000 	.inst	0xdb010000 ; undefined
     e80:	0bbb0a01 	.inst	0x0bbb0a01 ; undefined
     e84:	91020000 	add	x0, x0, #0x80
     e88:	01740b60 	.inst	0x01740b60 ; undefined
     e8c:	db010000 	.inst	0xdb010000 ; undefined
     e90:	0bbb1101 	.inst	0x0bbb1101 ; undefined
     e94:	91020000 	add	x0, x0, #0x80
     e98:	031a0b58 	.inst	0x031a0b58 ; undefined
     e9c:	db010000 	.inst	0xdb010000 ; undefined
     ea0:	0bbb1901 	.inst	0x0bbb1901 ; undefined
     ea4:	91020000 	add	x0, x0, #0x80
     ea8:	028d0b50 	.inst	0x028d0b50 ; undefined
     eac:	db010000 	.inst	0xdb010000 ; undefined
     eb0:	0bbb2201 	.inst	0x0bbb2201 ; undefined
     eb4:	91020000 	add	x0, x0, #0x80
     eb8:	035f0b48 	.inst	0x035f0b48 ; undefined
     ebc:	db010000 	.inst	0xdb010000 ; undefined
     ec0:	0bbb2a01 	.inst	0x0bbb2a01 ; undefined
     ec4:	91020000 	add	x0, x0, #0x80
     ec8:	13110040 	sbfiz	w0, w2, #15, #1
     ecc:	01000003 	.inst	0x01000003 ; undefined
     ed0:	2d050143 	stp	s3, s0, [x10, #40]
     ed4:	c8000000 	stxr	w0, x0, [x0]
     ed8:	00004007 	udf	#16391
     edc:	d0000000 	adrp	x0, 2000 <__abi_tag-0x3fe278>
     ee0:	00000008 	udf	#8
     ee4:	01000000 	.inst	0x01000000 ; undefined
     ee8:	000f7c9c 	.inst	0x000f7c9c ; undefined
     eec:	008e0e00 	.inst	0x008e0e00 ; undefined
     ef0:	43010000 	.inst	0x43010000 ; undefined
     ef4:	002d1001 	.inst	0x002d1001 ; NYI
     ef8:	91030000 	add	x0, x0, #0xc0
     efc:	800e7fbc 	.inst	0x800e7fbc ; undefined
     f00:	01000001 	.inst	0x01000001 ; undefined
     f04:	2d190143 	stp	s3, s0, [x10, #200]
     f08:	03000000 	.inst	0x03000000 ; undefined
     f0c:	0a7fb891 	.inst	0x0a7fb891 ; undefined
     f10:	45010069 	.inst	0x45010069 ; undefined
     f14:	002d0901 	.inst	0x002d0901 ; NYI
     f18:	91020000 	add	x0, x0, #0x80
     f1c:	011e0b7c 	.inst	0x011e0b7c ; undefined
     f20:	46010000 	.inst	0x46010000 ; undefined
     f24:	0bbb0a01 	.inst	0x0bbb0a01 ; undefined
     f28:	91020000 	add	x0, x0, #0x80
     f2c:	01630b70 	.inst	0x01630b70 ; undefined
     f30:	46010000 	.inst	0x46010000 ; undefined
     f34:	0bbb1101 	.inst	0x0bbb1101 ; undefined
     f38:	91020000 	add	x0, x0, #0x80
     f3c:	03410b68 	.inst	0x03410b68 ; undefined
     f40:	46010000 	.inst	0x46010000 ; undefined
     f44:	0bbb1b01 	.inst	0x0bbb1b01 ; undefined
     f48:	91020000 	add	x0, x0, #0x80
     f4c:	61780a60 	.inst	0x61780a60 ; undefined
     f50:	01470100 	.inst	0x01470100 ; undefined
     f54:	000a920e 	.inst	0x000a920e ; undefined
     f58:	58910200 	ldr	x0, fffffffffff22f98 <__bss_end__+0xffffffffffb027e8>
     f5c:	0062780a 	.inst	0x0062780a ; undefined
     f60:	11014701 	add	w1, w24, #0x51
     f64:	00000a92 	udf	#2706
     f68:	0b509102 	.inst	0x0b509102 ; undefined
     f6c:	000000ea 	udf	#234
     f70:	09014801 	.inst	0x09014801 ; undefined
     f74:	0000002d 	udf	#45
     f78:	004c9102 	.inst	0x004c9102 ; undefined
     f7c:	0002b511 	.inst	0x0002b511 ; undefined
     f80:	013c0100 	.inst	0x013c0100 ; undefined
     f84:	00002d05 	udf	#11525
     f88:	4007a400 	.inst	0x4007a400 ; undefined
     f8c:	00000000 	udf	#0
     f90:	00002400 	udf	#9216
     f94:	00000000 	udf	#0
     f98:	b09c0100 	adrp	x0, ffffffff38021000 <__bss_end__+0xffffffff37c00850>
     f9c:	0d00000f 	st1	{v15.b}[0], [x0]
     fa0:	00646172 	.inst	0x00646172 ; undefined
     fa4:	10013c01 	adr	x1, 3724 <__abi_tag-0x3fcb54>
     fa8:	0000002d 	udf	#45
     fac:	007c9102 	.inst	0x007c9102 ; undefined
     fb0:	00030c11 	.inst	0x00030c11 ; undefined
     fb4:	011c0100 	.inst	0x011c0100 ; undefined
     fb8:	00002d05 	udf	#11525
     fbc:	40067400 	.inst	0x40067400 ; undefined
     fc0:	00000000 	udf	#0
     fc4:	00013000 	.inst	0x00013000 ; undefined
     fc8:	00000000 	udf	#0
     fcc:	149c0100 	b	27013cc <__bss_end__+0x22e0c1c>
     fd0:	0d000010 	st1	{v16.b}[0], [x0]
     fd4:	00646172 	.inst	0x00646172 ; undefined
     fd8:	10011c01 	adr	x1, 3358 <__abi_tag-0x3fcf20>
     fdc:	0000002d 	udf	#45
     fe0:	0b6c9102 	.inst	0x0b6c9102 ; undefined
     fe4:	00000027 	udf	#39
     fe8:	07011e01 	.inst	0x07011e01 ; undefined
     fec:	0000002d 	udf	#45
     ff0:	0a7c9102 	.inst	0x0a7c9102 ; undefined
     ff4:	00707061 	.inst	0x00707061 ; undefined
     ff8:	07011f01 	.inst	0x07011f01 ; undefined
     ffc:	0000002d 	udf	#45
    1000:	0a789102 	.inst	0x0a789102 ; undefined
    1004:	00636e69 	.inst	0x00636e69 ; undefined
    1008:	07012101 	.inst	0x07012101 ; undefined
    100c:	0000002d 	udf	#45
    1010:	00749102 	.inst	0x00749102 ; undefined
    1014:	0000860c 	udf	#34316
    1018:	01130100 	.inst	0x01130100 ; undefined
    101c:	00002d05 	udf	#11525
    1020:	40063c00 	.inst	0x40063c00 ; undefined
    1024:	00000000 	udf	#0
    1028:	00003800 	udf	#14336
    102c:	00000000 	udf	#0
    1030:	549c0100 	b.eq	fffffffffff39050 <__bss_end__+0xffffffffffb188a0>  // b.none
    1034:	0d000010 	st1	{v16.b}[0], [x0]
    1038:	1301006e 	sbfiz	w14, w3, #31, #1
    103c:	002d1101 	.inst	0x002d1101 ; NYI
    1040:	91020000 	add	x0, x0, #0x80
    1044:	00660a6c 	.inst	0x00660a6c ; undefined
    1048:	07011501 	.inst	0x07011501 ; undefined
    104c:	0000002d 	udf	#45
    1050:	007c9102 	.inst	0x007c9102 ; undefined
    1054:	00019114 	.inst	0x00019114 ; undefined
    1058:	01090100 	.inst	0x01090100 ; undefined
    105c:	00002d05 	udf	#11525
    1060:	40060400 	.inst	0x40060400 ; undefined
    1064:	00000000 	udf	#0
    1068:	00003800 	udf	#14336
    106c:	00000000 	udf	#0
    1070:	0d9c0100 	st1	{v0.b}[0], [x8], x28
    1074:	0901006e 	.inst	0x0901006e ; undefined
    1078:	002d1001 	.inst	0x002d1001 ; NYI
    107c:	91020000 	add	x0, x0, #0x80
    1080:	006d0a6c 	.inst	0x006d0a6c ; undefined
    1084:	07010b01 	.inst	0x07010b01 ; undefined
    1088:	0000002d 	udf	#45
    108c:	007c9102 	.inst	0x007c9102 ; undefined
	...

Disassembly of section .debug_abbrev:

0000000000000000 <.debug_abbrev>:
   0:	25011101 	cmpge	p1.b, p4/z, z8.b, #1
   4:	030b130e 	.inst	0x030b130e ; undefined
   8:	110e1b0e 	add	w14, w24, #0x386
   c:	10071201 	adr	x1, e24c <__abi_tag-0x3f202c>
  10:	02000017 	.inst	0x02000017 ; undefined
  14:	0b0b0024 	add	w4, w1, w11
  18:	08030b3e 	stxrb	w3, w30, [x25]
  1c:	01030000 	.inst	0x01030000 ; undefined
  20:	01134901 	.inst	0x01134901 ; undefined
  24:	04000013 	add	z19.b, p0/m, z19.b, z0.b
  28:	13490021 	.inst	0x13490021 ; undefined
  2c:	00000b2f 	udf	#2863
  30:	0b002405 	add	w5, w0, w0, lsl #9
  34:	030b3e0b 	.inst	0x030b3e0b ; undefined
  38:	0600000e 	.inst	0x0600000e ; undefined
  3c:	0e030034 	tbl	v20.8b, {v1.16b}, v3.8b
  40:	0b3b0b3a 	add	w26, w25, w27, uxtb #2
  44:	13490b39 	.inst	0x13490b39 ; undefined
  48:	1802193f 	ldr	wzr, 436c <__abi_tag-0x3fbf0c>
  4c:	34070000 	cbz	w0, e04c <__abi_tag-0x3f222c>
  50:	3a080300 	adcs	w0, w24, w8
  54:	390b3b0b 	strb	w11, [x24, #718]
  58:	3f13490b 	.inst	0x3f13490b ; undefined
  5c:	00180219 	.inst	0x00180219 ; undefined
  60:	00340800 	.inst	0x00340800 ; NYI
  64:	0b3a0e03 	add	w3, w16, w26, uxtb #3
  68:	0b39053b 	add	w27, w9, w25, uxtb #1
  6c:	193f1349 	.inst	0x193f1349 ; undefined
  70:	00001802 	udf	#6146
  74:	3f012e09 	.inst	0x3f012e09 ; undefined
  78:	3a0e0319 	adcs	w25, w24, w14
  7c:	39053b0b 	strb	w11, [x24, #334]
  80:	1113490b 	add	w11, w8, #0x4d2
  84:	40071201 	.inst	0x40071201 ; undefined
  88:	19429618 	.inst	0x19429618 ; undefined
  8c:	00001301 	udf	#4865
  90:	0300340a 	.inst	0x0300340a ; undefined
  94:	3b0b3a08 	.inst	0x3b0b3a08 ; undefined
  98:	490b3905 	.inst	0x490b3905 ; undefined
  9c:	00180213 	.inst	0x00180213 ; undefined
  a0:	00340b00 	.inst	0x00340b00 ; NYI
  a4:	0b3a0e03 	add	w3, w16, w26, uxtb #3
  a8:	0b39053b 	add	w27, w9, w25, uxtb #1
  ac:	18021349 	ldr	w9, 4314 <__abi_tag-0x3fbf64>
  b0:	2e0c0000 	ext	v0.8b, v0.8b, v12.8b, #0
  b4:	03193f01 	.inst	0x03193f01 ; undefined
  b8:	3b0b3a0e 	.inst	0x3b0b3a0e ; undefined
  bc:	270b3905 	.inst	0x270b3905 ; undefined
  c0:	11134919 	add	w25, w8, #0x4d2
  c4:	40071201 	.inst	0x40071201 ; undefined
  c8:	19429718 	.inst	0x19429718 ; undefined
  cc:	00001301 	udf	#4865
  d0:	0300050d 	.inst	0x0300050d ; undefined
  d4:	3b0b3a08 	.inst	0x3b0b3a08 ; undefined
  d8:	490b3905 	.inst	0x490b3905 ; undefined
  dc:	00180213 	.inst	0x00180213 ; undefined
  e0:	00050e00 	.inst	0x00050e00 ; undefined
  e4:	0b3a0e03 	add	w3, w16, w26, uxtb #3
  e8:	0b39053b 	add	w27, w9, w25, uxtb #1
  ec:	18021349 	ldr	w9, 4354 <__abi_tag-0x3fbf24>
  f0:	2e0f0000 	ext	v0.8b, v0.8b, v15.8b, #0
  f4:	03193f01 	.inst	0x03193f01 ; undefined
  f8:	3b0b3a0e 	.inst	0x3b0b3a0e ; undefined
  fc:	270b3905 	.inst	0x270b3905 ; undefined
 100:	12011119 	and	w25, w8, #0x8000000f
 104:	97184007 	bl	fffffffffc610120 <__bss_end__+0xfffffffffc1ef970>
 108:	13011942 	sbfx	w2, w10, #1, #6
 10c:	0f100000 	.inst	0x0f100000 ; undefined
 110:	490b0b00 	.inst	0x490b0b00 ; undefined
 114:	11000013 	add	w19, w0, #0x0
 118:	193f012e 	.inst	0x193f012e ; undefined
 11c:	0b3a0e03 	add	w3, w16, w26, uxtb #3
 120:	0b39053b 	add	w27, w9, w25, uxtb #1
 124:	13491927 	.inst	0x13491927 ; undefined
 128:	07120111 	.inst	0x07120111 ; undefined
 12c:	42961840 	.inst	0x42961840 ; undefined
 130:	00130119 	.inst	0x00130119 ; undefined
 134:	012e1200 	.inst	0x012e1200 ; undefined
 138:	0e03193f 	uzp1	v31.8b, v9.8b, v3.8b
 13c:	053b0b3a 	ext	z26.b, z26.b, z25.b, #218
 140:	01110b39 	.inst	0x01110b39 ; undefined
 144:	18400712 	ldr	w18, 80224 <__abi_tag-0x380054>
 148:	01194297 	.inst	0x01194297 ; undefined
 14c:	13000013 	sbfx	w19, w0, #0, #1
 150:	193f012e 	.inst	0x193f012e ; undefined
 154:	0b3a0e03 	add	w3, w16, w26, uxtb #3
 158:	0b39053b 	add	w27, w9, w25, uxtb #1
 15c:	01111927 	.inst	0x01111927 ; undefined
 160:	18400712 	ldr	w18, 80240 <__abi_tag-0x380038>
 164:	01194296 	.inst	0x01194296 ; undefined
 168:	14000013 	b	1b4 <__abi_tag-0x4000c4>
 16c:	193f012e 	.inst	0x193f012e ; undefined
 170:	0b3a0e03 	add	w3, w16, w26, uxtb #3
 174:	0b39053b 	add	w27, w9, w25, uxtb #1
 178:	13491927 	.inst	0x13491927 ; undefined
 17c:	07120111 	.inst	0x07120111 ; undefined
 180:	42971840 	.inst	0x42971840 ; undefined
 184:	00000019 	udf	#25

Disassembly of section .debug_line:

0000000000000000 <.debug_line>:
   0:	000008ec 	udf	#2284
   4:	001e0003 	.inst	0x001e0003 ; undefined
   8:	01040000 	.inst	0x01040000 ; undefined
   c:	000d0efb 	.inst	0x000d0efb ; undefined
  10:	01010101 	.inst	0x01010101 ; undefined
  14:	01000000 	.inst	0x01000000 ; undefined
  18:	00010000 	.inst	0x00010000 ; undefined
  1c:	63706461 	.inst	0x63706461 ; undefined
  20:	00632e6d 	.inst	0x00632e6d ; undefined
  24:	00000000 	udf	#0
  28:	09000105 	.inst	0x09000105 ; undefined
  2c:	40060402 	.inst	0x40060402 ; undefined
  30:	00000000 	udf	#0
  34:	02890300 	.inst	0x02890300 ; undefined
  38:	31060501 	adds	w1, w8, #0x181
  3c:	02001105 	.inst	0x02001105 ; undefined
  40:	053c0104 	ext	z4.b, z4.b, z8.b, #224
  44:	053d3d0a 	.inst	0x053d3d0a ; undefined
  48:	05322101 	mov	z1.h, z8.h[4]
  4c:	11053106 	add	w6, w8, #0x14c
  50:	01040200 	.inst	0x01040200 ; undefined
  54:	3d0a053c 	str	b28, [x9, #641]
  58:	2101053d 	.inst	0x2101053d ; undefined
  5c:	3e070531 	.inst	0x3e070531 ; undefined
  60:	31090522 	adds	w2, w9, #0x241
  64:	05210b05 	ext	z5.b, z5.b, z24.b, #10
  68:	054d4909 	.inst	0x054d4909 ; undefined
  6c:	0905210b 	.inst	0x0905210b ; undefined
  70:	08054c49 	stxrb	w5, w9, [x2]
  74:	2f18052f 	ushr	v15.4h, v9.4h, #8
  78:	052e1305 	ext	z5.b, z5.b, z24.b, #116
  7c:	16052010 	b	fffffffff81480bc <__bss_end__+0xfffffffff7d2790c>
  80:	2e1c052f 	.inst	0x2e1c052f ; undefined
  84:	05201105 	ext	z5.b, z5.b, z8.b, #4
  88:	07053b08 	.inst	0x07053b08 ; undefined
  8c:	4b060530 	sub	w16, w9, w6, lsl #1
  90:	053f0805 	ext	z5.b, z5.b, z0.b, #250
  94:	1505211a 	b	41484fc <__bss_end__+0x3d27d4c>
  98:	2012052e 	.inst	0x2012052e ; undefined
  9c:	2e18052f 	.inst	0x2e18052f ; undefined
  a0:	05200d05 	ext	z5.b, z5.b, z8.b, #3
  a4:	09053b0a 	.inst	0x09053b0a ; undefined
  a8:	4b080530 	sub	w16, w9, w8, lsl #1
  ac:	05380905 	ext	z5.b, z5.b, z8.b, #194
  b0:	0a052e08 	and	w8, w16, w5, lsl #11
  b4:	21010535 	.inst	0x21010535 ; undefined
  b8:	3d0b0532 	str	b18, [x9, #705]
  bc:	334b0105 	.inst	0x334b0105 ; undefined
  c0:	05510b05 	mov	z5.h, p1/z, #88
  c4:	1a053d0e 	.inst	0x1a053d0e ; undefined
  c8:	3c11053d 	str	b29, [x9], #-240
  cc:	05200a05 	ext	z5.b, z5.b, z16.b, #2
  d0:	21052027 	.inst	0x21052027 ; undefined
  d4:	2e08053c 	.inst	0x2e08053c ; undefined
  d8:	052f1a05 	ext	z5.b, z5.b, z16.b, #126
  dc:	0a053c11 	and	w17, w0, w5, lsl #15
  e0:	20270520 	.inst	0x20270520 ; undefined
  e4:	053c2105 	mov	z5.s, z8.s[3]
  e8:	0b052e08 	add	w8, w16, w5, lsl #11
  ec:	20050531 	.inst	0x20050531 ; undefined
  f0:	02001f05 	.inst	0x02001f05 ; undefined
  f4:	05210304 	ext	z4.b, z4.b, z24.b, #8
  f8:	04020016 	.inst	0x04020016 ; undefined
  fc:	0f053c03 	.inst	0x0f053c03 ; undefined
 100:	03040200 	.inst	0x03040200 ; undefined
 104:	002c0520 	.inst	0x002c0520 ; NYI
 108:	20030402 	.inst	0x20030402 ; undefined
 10c:	02002605 	.inst	0x02002605 ; undefined
 110:	053c0304 	ext	z4.b, z4.b, z24.b, #224
 114:	04020023 	.inst	0x04020023 ; undefined
 118:	0c052e03 	.inst	0x0c052e03 ; undefined
 11c:	03040200 	.inst	0x03040200 ; undefined
 120:	001f0520 	.inst	0x001f0520 ; undefined
 124:	3d030402 	str	b2, [x0, #193]
 128:	02001605 	.inst	0x02001605 ; undefined
 12c:	053c0304 	ext	z4.b, z4.b, z24.b, #224
 130:	0402000f 	.inst	0x0402000f ; undefined
 134:	2c052003 	stnp	s3, s8, [x0, #40]
 138:	03040200 	.inst	0x03040200 ; undefined
 13c:	00260520 	.inst	0x00260520 ; NYI
 140:	3c030402 	str	b2, [x0], #48
 144:	02002305 	.inst	0x02002305 ; undefined
 148:	052e0304 	ext	z4.b, z4.b, z24.b, #112
 14c:	0402000c 	.inst	0x0402000c ; undefined
 150:	1b052003 	madd	w3, w0, w5, w8
 154:	03040200 	.inst	0x03040200 ; undefined
 158:	0005053a 	.inst	0x0005053a ; undefined
 15c:	3c010402 	str	b2, [x0], #16
 160:	05411b05 	eor	z5.s, z5.s, #0xe03fffff
 164:	0b053c12 	add	w18, w0, w5, lsl #15
 168:	20280520 	.inst	0x20280520 ; undefined
 16c:	053c2205 	mov	z5.s, z16.s[3]
 170:	08052e1f 	stxrb	w5, wzr, [x16]
 174:	3d120520 	str	b0, [x9, #1153]
 178:	052e0b05 	ext	z5.b, z5.b, z24.b, #114
 17c:	20052026 	.inst	0x20052026 ; undefined
 180:	2e1d053c 	.inst	0x2e1d053c ; undefined
 184:	05200805 	ext	z5.b, z5.b, z0.b, #2
 188:	0b053f0f 	add	w15, w24, w5, lsl #15
 18c:	2005053e 	.inst	0x2005053e ; undefined
 190:	02003705 	.inst	0x02003705 ; undefined
 194:	05200304 	ext	z4.b, z4.b, z24.b, #0
 198:	04020028 	.inst	0x04020028 ; undefined
 19c:	2d053c03 	stp	s3, s15, [x0, #40]
 1a0:	03040200 	.inst	0x03040200 ; undefined
 1a4:	002b053c 	.inst	0x002b053c ; NYI
 1a8:	20030402 	.inst	0x20030402 ; undefined
 1ac:	02001b05 	.inst	0x02001b05 ; undefined
 1b0:	05200304 	ext	z4.b, z4.b, z24.b, #0
 1b4:	04020005 	.inst	0x04020005 ; undefined
 1b8:	0e053c01 	umov	w1, v0.b[2]
 1bc:	3c11053d 	str	b29, [x9], #-240
 1c0:	052f0f05 	ext	z5.b, z5.b, z24.b, #123
 1c4:	14053f0e 	b	14fdfc <__abi_tag-0x2b047c>
 1c8:	2008053c 	.inst	0x2008053c ; undefined
 1cc:	054b0e05 	.inst	0x054b0e05 ; undefined
 1d0:	08053c14 	stxrb	w5, w20, [x0]
 1d4:	510b0520 	sub	w0, w9, #0x2c1
 1d8:	05660905 	ext	z5.b, {z8.b, z9.b}, #50
 1dc:	09053f0b 	.inst	0x09053f0b ; undefined
 1e0:	3f0e05f2 	.inst	0x3f0e05f2 ; undefined
 1e4:	05740805 	ext	z5.b, {z0.b, z1.b}, #162
 1e8:	08053d0d 	stxrb	w5, w13, [x8]
 1ec:	3f0a0574 	.inst	0x3f0a0574 ; undefined
 1f0:	059e0805 	mov	z5.s, p14/z, #64
 1f4:	2a05400c 	orr	w12, w0, w5, lsl #16
 1f8:	4a26054a 	eon	w10, w10, w6, lsl #1
 1fc:	05581605 	mov	z5.h, p8/z, #-80
 200:	09052031 	.inst	0x09052031 ; undefined
 204:	4d0b0520 	.inst	0x4d0b0520 ; undefined
 208:	059e0905 	mov	z5.s, p14/z, #72
 20c:	0a05400c 	and	w12, w0, w5, lsl #16
 210:	3f0f0566 	.inst	0x3f0f0566 ; undefined
 214:	05740905 	ext	z5.b, {z8.b, z9.b}, #162
 218:	0b054205 	add	w5, w16, w5, lsl #16
 21c:	08090594 	stxrb	w9, w20, [x12]
 220:	400b052e 	.inst	0x400b052e ; undefined
 224:	05f20905 	.inst	0x05f20905 ; undefined
 228:	09053f0e 	.inst	0x09053f0e ; undefined
 22c:	3f0a0574 	.inst	0x3f0a0574 ; undefined
 230:	05676767 	zip2	z7.h, z27.h, z7.h
 234:	09056a0b 	.inst	0x09056a0b ; undefined
 238:	3e0b0566 	.inst	0x3e0b0566 ; undefined
 23c:	05f20905 	.inst	0x05f20905 ; undefined
 240:	08053f0e 	stxrb	w5, w14, [x24]
 244:	3e0d0574 	.inst	0x3e0d0574 ; undefined
 248:	05740805 	ext	z5.b, {z0.b, z1.b}, #162
 24c:	0705400b 	.inst	0x0705400b ; undefined
 250:	2f0c053c 	ushr	v28.8b, v9.8b, #4
 254:	4c13055b 	.inst	0x4c13055b ; undefined
 258:	054a1205 	.inst	0x054a1205 ; undefined
 25c:	0b052e1f 	add	wzr, w16, w5, lsl #11
 260:	21080520 	.inst	0x21080520 ; undefined
 264:	05580705 	mov	z5.h, p8/z, #56
 268:	0402001e 	.inst	0x0402001e ; undefined
 26c:	0b053c01 	add	w1, w0, w5, lsl #15
 270:	4a250577 	eon	w23, w11, w5, lsl #1
 274:	05821505 	and	z5.d, z5.d, #0xc000007fffffffff
 278:	0805202b 	stxrb	w5, w11, [x1]
 27c:	4d0b0520 	.inst	0x4d0b0520 ; undefined
 280:	059e0905 	mov	z5.s, p14/z, #72
 284:	0a053f0c 	and	w12, w24, w5, lsl #15
 288:	3f0d0566 	.inst	0x3f0d0566 ; undefined
 28c:	05740805 	ext	z5.b, {z0.b, z1.b}, #162
 290:	0b054105 	add	w5, w8, w5, lsl #16
 294:	08090594 	stxrb	w9, w20, [x12]
 298:	3f0b052e 	.inst	0x3f0b052e ; undefined
 29c:	05f20905 	.inst	0x05f20905 ; undefined
 2a0:	08053f0d 	stxrb	w5, w13, [x24]
 2a4:	3f090574 	.inst	0x3f090574 ; undefined
 2a8:	05676767 	zip2	z7.h, z27.h, z7.h
 2ac:	0f056915 	.inst	0x0f056915 ; undefined
 2b0:	4b01054a 	sub	w10, w10, w1, lsl #1
 2b4:	42110533 	.inst	0x42110533 ; undefined
 2b8:	052e0905 	ext	z5.b, z5.b, z8.b, #114
 2bc:	08053d10 	stxrb	w5, w16, [x8]
 2c0:	410f052e 	.inst	0x410f052e ; undefined
 2c4:	05660d05 	ext	z5.b, {z8.b, z9.b}, #51
 2c8:	0d053f0f 	.inst	0x0d053f0f ; undefined
 2cc:	3e1605f2 	.inst	0x3e1605f2 ; undefined
 2d0:	05740c05 	ext	z5.b, {z0.b, z1.b}, #163
 2d4:	33053f10 	bfxil	w16, w24, #5, #11
 2d8:	4a2e054a 	eon	w10, w10, w14, lsl #1
 2dc:	05581e05 	mov	z5.h, p8/z, #-16
 2e0:	0d05203a 	.inst	0x0d05203a ; undefined
 2e4:	4d0b0520 	.inst	0x4d0b0520 ; undefined
 2e8:	054a2905 	.inst	0x054a2905 ; undefined
 2ec:	2f058219 	.inst	0x2f058219 ; undefined
 2f0:	20080520 	.inst	0x20080520 ; undefined
 2f4:	054c0d05 	.inst	0x054c0d05 ; undefined
 2f8:	0f057408 	orr	v8.2s, #0xa0, lsl #24
 2fc:	9e0d053f 	.inst	0x9e0d053f ; undefined
 300:	053f1005 	ext	z5.b, z5.b, z0.b, #252
 304:	1705660e 	b	fffffffffc159b3c <__bss_end__+0xfffffffffbd3938c>
 308:	740d0540 	.inst	0x740d0540 ; undefined
 30c:	053f0505 	ext	z5.b, z5.b, z8.b, #249
 310:	0d05930f 	.inst	0x0d05930f ; undefined
 314:	0f052e08 	.inst	0x0f052e08 ; undefined
 318:	f20d053f 	tst	x9, #0x18000000180000
 31c:	053f1605 	ext	z5.b, z5.b, z16.b, #253
 320:	0e05740d 	.inst	0x0e05740d ; undefined
 324:	6767673f 	.inst	0x6767673f ; undefined
 328:	056b0f05 	ext	z5.b, {z24.b, z25.b}, #91
 32c:	0f05660d 	movi	v13.2s, #0xb0, lsl #24
 330:	f20d053f 	tst	x9, #0x18000000180000
 334:	053f1605 	ext	z5.b, z5.b, z16.b, #253
 338:	0f05740c 	orr	v12.2s, #0xa0, lsl #24
 33c:	4a2d053f 	eon	wzr, w9, w13, lsl #1
 340:	05821d05 	and	z5.d, z5.d, #0xe000003fffffffff
 344:	0c052033 	.inst	0x0c052033 ; undefined
 348:	4d0f0520 	.inst	0x4d0f0520 ; undefined
 34c:	059e0d05 	mov	z5.s, p14/z, #104
 350:	0e053f10 	umov	w16, v24.b[2]
 354:	3f150566 	.inst	0x3f150566 ; undefined
 358:	05740c05 	ext	z5.b, {z0.b, z1.b}, #163
 35c:	0f053f05 	.inst	0x0f053f05 ; undefined
 360:	080d0593 	stxrb	w13, w19, [x12]
 364:	3f0f052e 	.inst	0x3f0f052e ; undefined
 368:	05f20d05 	.inst	0x05f20d05 ; undefined
 36c:	08053f11 	stxrb	w5, w17, [x24]
 370:	3f0d0574 	.inst	0x3f0d0574 ; undefined
 374:	6b676767 	.inst	0x6b676767 ; undefined
 378:	05740805 	ext	z5.b, {z0.b, z1.b}, #162
 37c:	08053d0d 	stxrb	w5, w13, [x8]
 380:	3f0b0574 	.inst	0x3f0b0574 ; undefined
 384:	3d3d0c05 	str	b5, [x0, #3907]
 388:	053d0b05 	ext	z5.b, z5.b, z24.b, #234
 38c:	17054a1d 	b	fffffffffc152c00 <__bss_end__+0xfffffffffbd32450>
 390:	2e09053c 	.inst	0x2e09053c ; undefined
 394:	052f0b05 	ext	z5.b, z5.b, z24.b, #122
 398:	17054a1d 	b	fffffffffc152c0c <__bss_end__+0xfffffffffbd3245c>
 39c:	2e09053c 	.inst	0x2e09053c ; undefined
 3a0:	05300b05 	ext	z5.b, z5.b, z24.b, #130
 3a4:	1e052005 	.inst	0x1e052005 ; undefined
 3a8:	03040200 	.inst	0x03040200 ; undefined
 3ac:	00170521 	.inst	0x00170521 ; undefined
 3b0:	3c030402 	str	b2, [x0], #48
 3b4:	02001005 	.inst	0x02001005 ; undefined
 3b8:	05200304 	ext	z4.b, z4.b, z24.b, #0
 3bc:	0402002b 	.inst	0x0402002b ; undefined
 3c0:	25052003 	cmplt	p3.b, p0/z, z0.b, #5
 3c4:	03040200 	.inst	0x03040200 ; undefined
 3c8:	0022053c 	.inst	0x0022053c ; NYI
 3cc:	2e030402 	.inst	0x2e030402 ; undefined
 3d0:	02000d05 	.inst	0x02000d05 ; undefined
 3d4:	05200304 	ext	z4.b, z4.b, z24.b, #0
 3d8:	0402001e 	.inst	0x0402001e ; undefined
 3dc:	17053d03 	b	fffffffffc14f7e8 <__bss_end__+0xfffffffffbd2f038>
 3e0:	03040200 	.inst	0x03040200 ; undefined
 3e4:	0010053c 	.inst	0x0010053c ; undefined
 3e8:	20030402 	.inst	0x20030402 ; undefined
 3ec:	02002b05 	.inst	0x02002b05 ; undefined
 3f0:	05200304 	ext	z4.b, z4.b, z24.b, #0
 3f4:	04020025 	.inst	0x04020025 ; undefined
 3f8:	22053c03 	.inst	0x22053c03 ; undefined
 3fc:	03040200 	.inst	0x03040200 ; undefined
 400:	000d052e 	.inst	0x000d052e ; undefined
 404:	20030402 	.inst	0x20030402 ; undefined
 408:	02001b05 	.inst	0x02001b05 ; undefined
 40c:	053a0304 	ext	z4.b, z4.b, z24.b, #208
 410:	04020005 	.inst	0x04020005 ; undefined
 414:	13053c01 	sbfx	w1, w0, #5, #11
 418:	2e0c0541 	.inst	0x2e0c0541 ; undefined
 41c:	05202505 	.inst	0x05202505 ; undefined
 420:	1c053c1f 	ldr	s31, aba0 <__abi_tag-0x3f56d8>
 424:	2009052e 	.inst	0x2009052e ; undefined
 428:	053d1305 	ext	z5.b, z5.b, z24.b, #236
 42c:	25052e0c 	cmplt	p12.b, p3/z, z16.b, #5
 430:	3c1f0520 	str	b0, [x9], #-16
 434:	052e1c05 	ext	z5.b, z5.b, z0.b, #119
 438:	11052009 	add	w9, w0, #0x148
 43c:	2e0b053f 	.inst	0x2e0b053f ; undefined
 440:	054b1105 	.inst	0x054b1105 ; undefined
 444:	0d052e0b 	.inst	0x0d052e0b ; undefined
 448:	0b053d4d 	add	w13, w10, w5, lsl #15
 44c:	2005053d 	.inst	0x2005053d ; undefined
 450:	02001d05 	.inst	0x02001d05 ; undefined
 454:	05210304 	ext	z4.b, z4.b, z24.b, #8
 458:	04020010 	.inst	0x04020010 ; undefined
 45c:	15053c03 	b	414f468 <__bss_end__+0x3d2ecb8>
 460:	03040200 	.inst	0x03040200 ; undefined
 464:	0013053c 	.inst	0x0013053c ; undefined
 468:	20030402 	.inst	0x20030402 ; undefined
 46c:	02001d05 	.inst	0x02001d05 ; undefined
 470:	05210304 	ext	z4.b, z4.b, z24.b, #8
 474:	04020010 	.inst	0x04020010 ; undefined
 478:	15053c03 	b	414f484 <__bss_end__+0x3d2ecd4>
 47c:	03040200 	.inst	0x03040200 ; undefined
 480:	0013053c 	.inst	0x0013053c ; undefined
 484:	20030402 	.inst	0x20030402 ; undefined
 488:	02001b05 	.inst	0x02001b05 ; undefined
 48c:	051e0304 	mov	z4.b, p14/z, #24
 490:	04020005 	.inst	0x04020005 ; undefined
 494:	0d053c01 	.inst	0x0d053c01 ; undefined
 498:	05055940 	.inst	0x05055940 ; undefined
 49c:	2101055a 	.inst	0x2101055a ; undefined
 4a0:	23150533 	.inst	0x23150533 ; undefined
 4a4:	054a0a05 	.inst	0x054a0a05 ; undefined
 4a8:	0a056715 	and	w21, w24, w5, lsl #25
 4ac:	6731054a 	.inst	0x6731054a ; undefined
 4b0:	053c2a05 	tbl	z5.b, {z16.b, z17.b}, z28.b
 4b4:	1c056623 	ldr	s3, b178 <__abi_tag-0x3f5100>
 4b8:	66150566 	.inst	0x66150566 ; undefined
 4bc:	05660f05 	ext	z5.b, {z24.b, z25.b}, #51
 4c0:	2d056609 	stp	s9, s25, [x16, #40]
 4c4:	3c270567 	.inst	0x3c270567 ; undefined
 4c8:	05662105 	mov	z5.h, z8.h[9]
 4cc:	1505661b 	b	4159d38 <__bss_end__+0x3d39588>
 4d0:	660f0566 	.inst	0x660f0566 ; undefined
 4d4:	05660905 	ext	z5.b, {z8.b, z9.b}, #50
 4d8:	4205674d 	.inst	0x4205674d ; undefined
 4dc:	6637053c 	.inst	0x6637053c ; undefined
 4e0:	05662c05 	tbx	z5.h, z0.h, z6.h
 4e4:	17056621 	b	fffffffffc159d68 <__bss_end__+0xfffffffffbd395b8>
 4e8:	660d0566 	.inst	0x660d0566 ; undefined
 4ec:	05674905 	uzp1	p5.h, p8.h, p7.h
 4f0:	35053c3f 	cbnz	wzr, ac74 <__abi_tag-0x3f5604>
 4f4:	662b0566 	.inst	0x662b0566 ; undefined
 4f8:	05662105 	mov	z5.h, z8.h[9]
 4fc:	0d056617 	.inst	0x0d056617 ; undefined
 500:	680b0566 	.inst	0x680b0566 ; undefined
 504:	05200505 	ext	z5.b, z5.b, z8.b, #1
 508:	04020017 	.inst	0x04020017 ; undefined
 50c:	16052103 	b	fffffffff8148918 <__bss_end__+0xfffffffff7d28168>
 510:	03040200 	.inst	0x03040200 ; undefined
 514:	0019054b 	.inst	0x0019054b ; undefined
 518:	4b030402 	sub	w2, w0, w3, lsl #1
 51c:	02001805 	.inst	0x02001805 ; undefined
 520:	054b0304 	.inst	0x054b0304 ; undefined
 524:	0402001a 	.inst	0x0402001a ; undefined
 528:	05054603 	.inst	0x05054603 ; undefined
 52c:	01040200 	.inst	0x01040200 ; undefined
 530:	430b053c 	.inst	0x430b053c ; undefined
 534:	05200505 	ext	z5.b, z5.b, z8.b, #1
 538:	04020016 	.inst	0x04020016 ; undefined
 53c:	02002103 	.inst	0x02002103 ; undefined
 540:	054b0304 	.inst	0x054b0304 ; undefined
 544:	04020018 	.inst	0x04020018 ; undefined
 548:	02004b03 	.inst	0x02004b03 ; undefined
 54c:	054b0304 	.inst	0x054b0304 ; undefined
 550:	0402001a 	.inst	0x0402001a ; undefined
 554:	05054603 	.inst	0x05054603 ; undefined
 558:	01040200 	.inst	0x01040200 ; undefined
 55c:	430b053c 	.inst	0x430b053c ; undefined
 560:	05200505 	ext	z5.b, z5.b, z8.b, #1
 564:	04020027 	.inst	0x04020027 ; undefined
 568:	1b052003 	madd	w3, w0, w5, w8
 56c:	03040200 	.inst	0x03040200 ; undefined
 570:	0005054a 	.inst	0x0005054a ; undefined
 574:	3c010402 	str	b2, [x0], #16
 578:	053e0b05 	ext	z5.b, z5.b, z24.b, #242
 57c:	13052005 	sbfx	w5, w0, #5, #4
 580:	03040200 	.inst	0x03040200 ; undefined
 584:	04020021 	.inst	0x04020021 ; undefined
 588:	1b054b03 	madd	w3, w24, w5, w18
 58c:	03040200 	.inst	0x03040200 ; undefined
 590:	00050548 	.inst	0x00050548 ; undefined
 594:	3c010402 	str	b2, [x0], #16
 598:	21010540 	.inst	0x21010540 ; undefined
 59c:	3f150534 	.inst	0x3f150534 ; undefined
 5a0:	053c1105 	ext	z5.b, z5.b, z8.b, #228
 5a4:	2005200a 	.inst	0x2005200a ; undefined
 5a8:	3c1c0520 	str	b0, [x9], #-64
 5ac:	052e0805 	ext	z5.b, z5.b, z0.b, #114
 5b0:	0505300b 	.inst	0x0505300b ; undefined
 5b4:	001a052e 	.inst	0x001a052e ; undefined
 5b8:	21030402 	.inst	0x21030402 ; undefined
 5bc:	02001605 	.inst	0x02001605 ; undefined
 5c0:	053c0304 	ext	z4.b, z4.b, z24.b, #224
 5c4:	0402000f 	.inst	0x0402000f ; undefined
 5c8:	25052003 	cmplt	p3.b, p0/z, z0.b, #5
 5cc:	03040200 	.inst	0x03040200 ; undefined
 5d0:	00210520 	.inst	0x00210520 ; NYI
 5d4:	3c030402 	str	b2, [x0], #48
 5d8:	02001e05 	.inst	0x02001e05 ; undefined
 5dc:	052e0304 	ext	z4.b, z4.b, z24.b, #112
 5e0:	0402000c 	.inst	0x0402000c ; undefined
 5e4:	1a052003 	.inst	0x1a052003 ; undefined
 5e8:	03040200 	.inst	0x03040200 ; undefined
 5ec:	0005053b 	.inst	0x0005053b ; undefined
 5f0:	3c010402 	str	b2, [x0], #16
 5f4:	053f1505 	ext	z5.b, z5.b, z8.b, #253
 5f8:	05342f01 	tbx	z1.b, z24.b, z20.b
 5fc:	08055a0b 	stxrb	w5, w11, [x16]
 600:	2f0a052e 	ushr	v14.8b, v9.8b, #6
 604:	05200805 	ext	z5.b, z5.b, z0.b, #2
 608:	09053d0c 	.inst	0x09053d0c ; undefined
 60c:	2f0b052e 	ushr	v14.8b, v9.8b, #5
 610:	05201405 	ext	z5.b, z5.b, z0.b, #5
 614:	15052e08 	b	414be34 <__bss_end__+0x3d2b684>
 618:	2f01053d 	mvni	v29.2s, #0x29
 61c:	4f0a0532 	sshr	v18.16b, v9.16b, #6
 620:	052e0805 	ext	z5.b, z5.b, z0.b, #114
 624:	0505310d 	.inst	0x0505310d ; undefined
 628:	211c0520 	.inst	0x211c0520 ; undefined
 62c:	05582205 	mov	z5.h, p8/z, #4096
 630:	0f052021 	.inst	0x0f052021 ; undefined
 634:	2f0b0520 	ushr	v0.8b, v9.8b, #5
 638:	02002105 	.inst	0x02002105 ; undefined
 63c:	05480204 	.inst	0x05480204 ; undefined
 640:	04020005 	.inst	0x04020005 ; undefined
 644:	09053c01 	.inst	0x09053c01 ; undefined
 648:	2307054c 	.inst	0x2307054c ; undefined
 64c:	02001505 	.inst	0x02001505 ; undefined
 650:	053c0104 	ext	z4.b, z4.b, z8.b, #224
 654:	0b05670e 	add	w14, w24, w5, lsl #25
 658:	21010559 	.inst	0x21010559 ; undefined
 65c:	052e1003 	ext	z3.b, z3.b, z0.b, #116
 660:	15053e0b 	b	414fe8c <__bss_end__+0x3d2f6dc>
 664:	3c080520 	str	b0, [x9], #128
 668:	052f0b05 	ext	z5.b, z5.b, z24.b, #122
 66c:	22052e26 	.inst	0x22052e26 ; undefined
 670:	4a09052e 	eor	w14, w9, w9, lsl #1
 674:	052f0705 	ext	z5.b, z5.b, z24.b, #121
 678:	04020015 	.inst	0x04020015 ; undefined
 67c:	07053c01 	.inst	0x07053c01 ; undefined
 680:	00190521 	.inst	0x00190521 ; undefined
 684:	4a010402 	eor	w2, w0, w1, lsl #1
 688:	052f0b05 	ext	z5.b, z5.b, z24.b, #122
 68c:	05332101 	mov	z1.b, z8.b[9]
 690:	09053e10 	.inst	0x09053e10 ; undefined
 694:	14052f2e 	b	14c34c <__abi_tag-0x2b3f2c>
 698:	4a2d053d 	eon	w29, w9, w13, lsl #1
 69c:	052e3105 	tbl	z5.b, {z8.b}, z14.b
 6a0:	10052e09 	adr	x9, ac60 <__abi_tag-0x3f5618>
 6a4:	2f01052f 	mvni	v15.2s, #0x29
 6a8:	4d070534 	.inst	0x4d070534 ; undefined
 6ac:	053d0d05 	ext	z5.b, z5.b, z8.b, #235
 6b0:	21052007 	.inst	0x21052007 ; undefined
 6b4:	03040200 	.inst	0x03040200 ; undefined
 6b8:	001d0521 	.inst	0x001d0521 ; undefined
 6bc:	66030402 	.inst	0x66030402 ; undefined
 6c0:	02002605 	.inst	0x02002605 ; undefined
 6c4:	053c0304 	ext	z4.b, z4.b, z24.b, #224
 6c8:	0402000c 	.inst	0x0402000c ; undefined
 6cc:	12052003 	and	w3, w0, #0xf800000f
 6d0:	03040200 	.inst	0x03040200 ; undefined
 6d4:	0010054a 	.inst	0x0010054a ; undefined
 6d8:	20030402 	.inst	0x20030402 ; undefined
 6dc:	02001c05 	.inst	0x02001c05 ; undefined
 6e0:	051f0304 	mov	z4.b, p15/z, #24
 6e4:	04020007 	.inst	0x04020007 ; undefined
 6e8:	0d053c01 	.inst	0x0d053c01 ; undefined
 6ec:	2007054f 	.inst	0x2007054f ; undefined
 6f0:	05210c05 	ext	z5.b, z5.b, z0.b, #11
 6f4:	1505201a 	b	414875c <__bss_end__+0x3d27fac>
 6f8:	200b0566 	.inst	0x200b0566 ; undefined
 6fc:	02002805 	.inst	0x02002805 ; undefined
 700:	052e0104 	ext	z4.b, z4.b, z8.b, #112
 704:	04020038 	.inst	0x04020038 ; undefined
 708:	1e053c02 	.inst	0x1e053c02 ; undefined
 70c:	02040200 	.inst	0x02040200 ; undefined
 710:	001a052f 	.inst	0x001a052f ; undefined
 714:	66020402 	.inst	0x66020402 ; undefined
 718:	02002305 	.inst	0x02002305 ; undefined
 71c:	053c0204 	ext	z4.b, z4.b, z16.b, #224
 720:	0402000d 	.inst	0x0402000d ; undefined
 724:	0c052002 	.inst	0x0c052002 ; undefined
 728:	02040200 	.inst	0x02040200 ; undefined
 72c:	00160521 	.inst	0x00160521 ; undefined
 730:	4a020402 	eor	w2, w0, w2, lsl #1
 734:	02001005 	.inst	0x02001005 ; undefined
 738:	053c0204 	ext	z4.b, z4.b, z16.b, #224
 73c:	0402001c 	.inst	0x0402001c ; undefined
 740:	07051d02 	.inst	0x07051d02 ; undefined
 744:	01040200 	.inst	0x01040200 ; undefined
 748:	4309053c 	.inst	0x4309053c ; undefined
 74c:	052e0d05 	ext	z5.b, z5.b, z8.b, #115
 750:	0d053d09 	.inst	0x0d053d09 ; undefined
 754:	3d09052e 	str	b14, [x9, #577]
 758:	052e0d05 	ext	z5.b, z5.b, z8.b, #115
 75c:	13053d09 	sbfx	w9, w8, #5, #11
 760:	2e0d052e 	.inst	0x2e0d052e ; undefined
 764:	3d050521 	str	b1, [x9, #321]
 768:	34210105 	cbz	w5, 42788 <__abi_tag-0x3bdaf0>
 76c:	05690e05 	ext	z5.b, {z16.b, z17.b}, #75
 770:	08052009 	stxrb	w5, w9, [x0]
 774:	2011052f 	.inst	0x2011052f ; undefined
 778:	052e0705 	ext	z5.b, z5.b, z24.b, #113
 77c:	04020022 	.inst	0x04020022 ; undefined
 780:	09052e01 	.inst	0x09052e01 ; undefined
 784:	3d08053d 	str	b29, [x9, #513]
 788:	05201105 	ext	z5.b, z5.b, z8.b, #4
 78c:	0d052e07 	.inst	0x0d052e07 ; undefined
 790:	18054d2f 	ldr	w15, b134 <__abi_tag-0x3f5144>
 794:	2017053e 	.inst	0x2017053e ; undefined
 798:	053c2205 	mov	z5.s, z16.s[3]
 79c:	0a052010 	and	w16, w0, w5, lsl #8
 7a0:	2307053c 	.inst	0x2307053c ; undefined
 7a4:	02001b05 	.inst	0x02001b05 ; undefined
 7a8:	053c0104 	ext	z4.b, z4.b, z8.b, #224
 7ac:	1c052f07 	ldr	s7, ad8c <__abi_tag-0x3f54ec>
 7b0:	01040200 	.inst	0x01040200 ; undefined
 7b4:	2f0b053c 	ushr	v28.8b, v9.8b, #5
 7b8:	34210105 	cbz	w5, 427d8 <__abi_tag-0x3bdaa0>
 7bc:	055b0c05 	mov	z5.h, p11/z, #96
 7c0:	09052015 	.inst	0x09052015 ; undefined
 7c4:	2f08053c 	ushr	v28.8b, v9.8b, #8
 7c8:	05201105 	ext	z5.b, z5.b, z8.b, #4
 7cc:	10052e07 	adr	x7, ad8c <__abi_tag-0x3f54ec>
 7d0:	200e052f 	.inst	0x200e052f ; undefined
 7d4:	053f1005 	ext	z5.b, z5.b, z0.b, #252
 7d8:	0905200e 	.inst	0x0905200e ; undefined
 7dc:	4b070531 	sub	w17, w9, w7, lsl #1
 7e0:	02001905 	.inst	0x02001905 ; undefined
 7e4:	054a0104 	.inst	0x054a0104 ; undefined
 7e8:	07052f0f 	.inst	0x07052f0f ; undefined
 7ec:	001a052e 	.inst	0x001a052e ; undefined
 7f0:	3c010402 	str	b2, [x0], #16
 7f4:	053d0b05 	ext	z5.b, z5.b, z24.b, #234
 7f8:	10032101 	adr	x1, 6c18 <__abi_tag-0x3f9660>
 7fc:	3e0b052e 	.inst	0x3e0b052e ; undefined
 800:	05201505 	ext	z5.b, z5.b, z8.b, #5
 804:	08053c1d 	stxrb	w5, w29, [x0]
 808:	211d0520 	.inst	0x211d0520 ; undefined
 80c:	054a0905 	.inst	0x054a0905 ; undefined
 810:	15053d07 	b	414fc2c <__bss_end__+0x3d2f47c>
 814:	01040200 	.inst	0x01040200 ; undefined
 818:	2107053c 	.inst	0x2107053c ; undefined
 81c:	02001905 	.inst	0x02001905 ; undefined
 820:	054a0104 	.inst	0x054a0104 ; undefined
 824:	01052f0b 	.inst	0x01052f0b ; undefined
 828:	06053321 	.inst	0x06053321 ; undefined
 82c:	25080541 	cmpge	p1.b, p1/z, z10.b, #8
 830:	052e1005 	ext	z5.b, z5.b, z0.b, #116
 834:	0505340b 	.inst	0x0505340b ; undefined
 838:	00300520 	.inst	0x00300520 ; NYI
 83c:	21030402 	.inst	0x21030402 ; undefined
 840:	02002505 	.inst	0x02002505 ; undefined
 844:	053c0304 	ext	z4.b, z4.b, z24.b, #224
 848:	04020024 	.inst	0x04020024 ; undefined
 84c:	1c054a03 	ldr	s3, b18c <__abi_tag-0x3f50ec>
 850:	03040200 	.inst	0x03040200 ; undefined
 854:	001d052e 	.inst	0x001d052e ; undefined
 858:	49030402 	.inst	0x49030402 ; undefined
 85c:	02000505 	.inst	0x02000505 ; undefined
 860:	053c0104 	ext	z4.b, z4.b, z8.b, #224
 864:	3c0e030a 	stur	b10, [x24, #224]
 868:	05200405 	ext	z5.b, z5.b, z0.b, #1
 86c:	04020019 	.inst	0x04020019 ; undefined
 870:	38052103 	sturb	w3, [x8, #82]
 874:	03040200 	.inst	0x03040200 ; undefined
 878:	0019054a 	.inst	0x0019054a ; undefined
 87c:	2e030402 	.inst	0x2e030402 ; undefined
 880:	02001305 	.inst	0x02001305 ; undefined
 884:	054a0304 	.inst	0x054a0304 ; undefined
 888:	04020019 	.inst	0x04020019 ; undefined
 88c:	17055803 	b	fffffffffc156898 <__bss_end__+0xfffffffffbd360e8>
 890:	03040200 	.inst	0x03040200 ; undefined
 894:	001f054a 	.inst	0x001f054a ; undefined
 898:	49030402 	.inst	0x49030402 ; undefined
 89c:	02000405 	.inst	0x02000405 ; undefined
 8a0:	053c0104 	ext	z4.b, z4.b, z8.b, #224
 8a4:	05053f0b 	.inst	0x05053f0b ; undefined
 8a8:	001a0520 	.inst	0x001a0520 ; undefined
 8ac:	21030402 	.inst	0x21030402 ; undefined
 8b0:	02000705 	.inst	0x02000705 ; undefined
 8b4:	05580304 	mov	z4.h, p8/z, #24
 8b8:	04020011 	.inst	0x04020011 ; undefined
 8bc:	0f055903 	fmls	v3.4h, v8.4h, v5.h[4]
 8c0:	03040200 	.inst	0x03040200 ; undefined
 8c4:	00130575 	.inst	0x00130575 ; undefined
 8c8:	2e030402 	.inst	0x2e030402 ; undefined
 8cc:	02002005 	.inst	0x02002005 ; undefined
 8d0:	05710304 	ext	z4.b, {z24.b, z25.b}, #136
 8d4:	04020005 	.inst	0x04020005 ; undefined
 8d8:	12053c01 	and	w1, w0, #0xf80007ff
 8dc:	053c1103 	ext	z3.b, z3.b, z8.b, #228
 8e0:	1c054a1e 	ldr	s30, b220 <__abi_tag-0x3f5058>
 8e4:	4a15052e 	eor	w14, w9, w21, lsl #1
 8e8:	02210105 	.inst	0x02210105 ; undefined
 8ec:	01010003 	.inst	0x01010003 ; undefined

Disassembly of section .debug_str:

0000000000000000 <.debug_str>:
   0:	6e617571 	uabd	v17.8h, v11.8h, v1.8h
   4:	62363274 	.inst	0x62363274 ; undefined
   8:	656e5f74 	fnmla	z20.h, p7/m, z27.h, z14.h
   c:	65720067 	fmla	z7.h, p0/m, z3.h, z18.h
  10:	746c7573 	.inst	0x746c7573 ; undefined
  14:	756f7800 	.inst	0x756f7800 ; undefined
  18:	78003174 	sturh	w20, [x11, #3]
  1c:	3274756f 	.inst	0x3274756f ; undefined
  20:	706e6900 	adr	x0, dcd43 <__abi_tag-0x323535>
  24:	64007475 	.inst	0x64007475 ; undefined
  28:	00666669 	.inst	0x00666669 ; undefined
  2c:	5f636564 	.inst	0x5f636564 ; undefined
  30:	68746564 	.inst	0x68746564 ; undefined
  34:	63656400 	.inst	0x63656400 ; undefined
  38:	687a735f 	.inst	0x687a735f ; undefined
  3c:	63656400 	.inst	0x63656400 ; undefined
  40:	7465645f 	.inst	0x7465645f ; undefined
  44:	6564006c 	fmla	z12.h, p0/m, z3.h, z4.h
  48:	7a735f63 	.inst	0x7a735f63 ; undefined
  4c:	682f006c 	.inst	0x682f006c ; undefined
  50:	2f656d6f 	.inst	0x2f656d6f ; undefined
  54:	6e61796a 	.inst	0x6e61796a ; undefined
  58:	72702f67 	.inst	0x72702f67 ; undefined
  5c:	6172676f 	.inst	0x6172676f ; undefined
  60:	524d2f6d 	.inst	0x524d2f6d ; undefined
  64:	612f4354 	.inst	0x612f4354 ; undefined
  68:	6d637064 	ldp	d4, d28, [x3, #-464]
  6c:	6c656400 	ldnp	d0, d25, [x0, #-432]
  70:	645f7961 	fcmla	z1.h, p6/m, z11.h, z31.h, #270
  74:	0078746c 	.inst	0x0078746c ; undefined
  78:	6e617571 	uabd	v17.8h, v11.8h, v1.8h
  7c:	62363274 	.inst	0x62363274 ; undefined
  80:	6f705f74 	.inst	0x6f705f74 ; undefined
  84:	796d0073 	ldrh	w19, [x3, #5760]
  88:	6261665f 	.inst	0x6261665f ; undefined
  8c:	69780073 	ldpsw	x19, x0, [x3, #-64]
  90:	6400316e 	.inst	0x6400316e ; undefined
  94:	615f6365 	.inst	0x615f6365 ; undefined
  98:	6d003168 	stp	d8, d12, [x11]
  9c:	006e6961 	.inst	0x006e6961 ; undefined
  a0:	5f636564 	.inst	0x5f636564 ; undefined
  a4:	31746c70 	adds	w16, w3, #0xd1b, lsl #12
  a8:	63656400 	.inst	0x63656400 ; undefined
  ac:	746c705f 	.inst	0x746c705f ; undefined
  b0:	65640032 	fmla	z18.h, p0/m, z1.h, z4.h
  b4:	68725f63 	.inst	0x68725f63 ; undefined
  b8:	65640031 	fmla	z17.h, p0/m, z1.h, z4.h
  bc:	6c615f63 	ldnp	d3, d23, [x27, #-496]
  c0:	65640031 	fmla	z17.h, p0/m, z1.h, z4.h
  c4:	6c615f63 	ldnp	d3, d23, [x27, #-496]
  c8:	6c690032 	ldnp	d18, d0, [x1, #-368]
  cc:	61745f62 	.inst	0x61745f62 ; undefined
  d0:	00656c62 	.inst	0x00656c62 ; undefined
  d4:	635f6877 	.inst	0x635f6877 ; undefined
  d8:	5f65646f 	.inst	0x5f65646f ; undefined
  dc:	6c626174 	ldnp	d20, d24, [x11, #-480]
  e0:	65640065 	fmla	z5.h, p0/m, z3.h, z4.h
  e4:	6c705f63 	ldnp	d3, d23, [x27, #-256]
  e8:	65640074 	fmla	z20.h, p0/m, z3.h, z4.h
  ec:	00736963 	.inst	0x00736963 ; undefined
  f0:	5f636564 	.inst	0x5f636564 ; undefined
  f4:	0068626e 	.inst	0x0068626e ; undefined
  f8:	5f636564 	.inst	0x5f636564 ; undefined
  fc:	006c626e 	.inst	0x006c626e ; undefined
 100:	5f636564 	.inst	0x5f636564 ; undefined
 104:	73006870 	.inst	0x73006870 ; undefined
 108:	74666968 	.inst	0x74666968 ; undefined
 10c:	6e6f635f 	rsubhn2	v31.8h, v26.4s, v15.4s
 110:	6e617473 	uabd	v19.8h, v3.8h, v1.8h
 114:	65640074 	fmla	z20.h, p0/m, z3.h, z4.h
 118:	68615f63 	.inst	0x68615f63 ; undefined
 11c:	5f680032 	.inst	0x5f680032 ; undefined
 120:	00727470 	.inst	0x00727470 ; undefined
 124:	676e6f6c 	.inst	0x676e6f6c ; undefined
 128:	746e6920 	.inst	0x746e6920 ; undefined
 12c:	61637300 	.inst	0x61637300 ; undefined
 130:	006c656c 	.inst	0x006c656c ; undefined
 134:	5f636564 	.inst	0x5f636564 ; undefined
 138:	00326872 	.inst	0x00326872 ; NYI
 13c:	5f636564 	.inst	0x5f636564 ; undefined
 140:	00316870 	.inst	0x00316870 ; NYI
 144:	5f636564 	.inst	0x5f636564 ; undefined
 148:	00326870 	.inst	0x00326870 ; NYI
 14c:	5f636564 	.inst	0x5f636564 ; undefined
 150:	00687073 	.inst	0x00687073 ; undefined
 154:	5f636564 	.inst	0x5f636564 ; undefined
 158:	64006879 	.inst	0x64006879 ; undefined
 15c:	735f6365 	.inst	0x735f6365 ; undefined
 160:	74006c70 	.inst	0x74006c70 ; undefined
 164:	5f666d71 	.inst	0x5f666d71 ; undefined
 168:	00727470 	.inst	0x00727470 ; undefined
 16c:	63706461 	.inst	0x63706461 ; undefined
 170:	00632e6d 	.inst	0x00632e6d ; undefined
 174:	705f6361 	adr	x1, bede3 <__abi_tag-0x341495>
 178:	64007274 	.inst	0x64007274 ; undefined
 17c:	0069746c 	.inst	0x0069746c ; undefined
 180:	326e6978 	.inst	0x326e6978 ; undefined
 184:	63656400 	.inst	0x63656400 ; undefined
 188:	6c65645f 	ldnp	d31, d25, [x2, #-432]
 18c:	7868645f 	.inst	0x7868645f ; undefined
 190:	5f796d00 	.inst	0x5f796d00 ; undefined
 194:	00736261 	.inst	0x00736261 ; undefined
 198:	5f367171 	.inst	0x5f367171 ; undefined
 19c:	65646f63 	fnmls	z3.h, p3/m, z27.h, z4.h
 1a0:	61745f36 	.inst	0x61745f36 ; undefined
 1a4:	00656c62 	.inst	0x00656c62 ; undefined
 1a8:	6f707075 	fcmla	v21.8h, v3.8h, v16.h[1], #270
 1ac:	7500316c 	.inst	0x7500316c ; undefined
 1b0:	6c6f7070 	ldnp	d16, d28, [x3, #-272]
 1b4:	65640032 	fmla	z18.h, p0/m, z1.h, z4.h
 1b8:	6c725f63 	ldnp	d3, d23, [x27, #-224]
 1bc:	64003174 	.inst	0x64003174 ; undefined
 1c0:	725f6365 	.inst	0x725f6365 ; undefined
 1c4:	6400746c 	.inst	0x6400746c ; undefined
 1c8:	725f6365 	.inst	0x725f6365 ; undefined
 1cc:	65640068 	fmla	z8.h, p0/m, z3.h, z4.h
 1d0:	5f79616c 	.inst	0x5f79616c ; undefined
 1d4:	00687062 	.inst	0x00687062 ; undefined
 1d8:	616c6564 	.inst	0x616c6564 ; undefined
 1dc:	68645f79 	.inst	0x68645f79 ; undefined
 1e0:	65640078 	fmla	z24.h, p0/m, z3.h, z4.h
 1e4:	5f79616c 	.inst	0x5f79616c ; undefined
 1e8:	006c7062 	.inst	0x006c7062 ; undefined
 1ec:	5f636564 	.inst	0x5f636564 ; undefined
 1f0:	00746c64 	.inst	0x00746c64 ; undefined
 1f4:	5f636564 	.inst	0x5f636564 ; undefined
 1f8:	32746c72 	.inst	0x32746c72 ; undefined
 1fc:	676f6c00 	.inst	0x676f6c00 ; undefined
 200:	00686373 	.inst	0x00686373 ; undefined
 204:	326c7061 	.inst	0x326c7061 ; undefined
 208:	7a707500 	.inst	0x7a707500 ; undefined
 20c:	006f7265 	.inst	0x006f7265 ; undefined
 210:	73676f6c 	.inst	0x73676f6c ; undefined
 214:	74006c63 	.inst	0x74006c63 ; undefined
 218:	00666d71 	.inst	0x00666d71 ; undefined
 21c:	5f357171 	.inst	0x5f357171 ; undefined
 220:	65646f63 	fnmls	z3.h, p3/m, z27.h, z4.h
 224:	61745f35 	.inst	0x61745f35 ; undefined
 228:	00656c62 	.inst	0x00656c62 ; undefined
 22c:	706d6f63 	adr	x3, db01b <__abi_tag-0x32525d>
 230:	73736572 	.inst	0x73736572 ; undefined
 234:	77006465 	.inst	0x77006465 ; undefined
 238:	61745f6c 	.inst	0x61745f6c ; undefined
 23c:	00656c62 	.inst	0x00656c62 ; undefined
 240:	5f636564 	.inst	0x5f636564 ; undefined
 244:	5f6c6564 	.inst	0x5f6c6564 ; undefined
 248:	78746c64 	.inst	0x78746c64 ; undefined
 24c:	61757100 	.inst	0x61757100 ; undefined
 250:	006c746e 	.inst	0x006c746e ; undefined
 254:	676e6f6c 	.inst	0x676e6f6c ; undefined
 258:	736e7520 	.inst	0x736e7520 ; undefined
 25c:	656e6769 	fnmls	z9.h, p1/m, z27.h, z14.h
 260:	6e692064 	usubl2	v4.4s, v3.8h, v9.8h
 264:	71710074 	subs	w20, w3, #0xc40, lsl #12
 268:	6f635f32 	.inst	0x6f635f32 ; undefined
 26c:	5f326564 	.inst	0x5f326564 ; undefined
 270:	6c626174 	ldnp	d20, d24, [x11, #-480]
 274:	65640065 	fmla	z5.h, p0/m, z3.h, z4.h
 278:	5f736963 	.inst	0x5f736963 ; undefined
 27c:	6c76656c 	ldnp	d12, d25, [x11, #-160]
 280:	63656400 	.inst	0x63656400 ; undefined
 284:	6c65645f 	ldnp	d31, d25, [x2, #-432]
 288:	6870625f 	.inst	0x6870625f ; undefined
 28c:	5f646100 	.inst	0x5f646100 ; undefined
 290:	00727470 	.inst	0x00727470 ; undefined
 294:	5f636564 	.inst	0x5f636564 ; undefined
 298:	5f6c6564 	.inst	0x5f6c6564 ; undefined
 29c:	006c7062 	.inst	0x006c7062 ; undefined
 2a0:	5f636564 	.inst	0x5f636564 ; undefined
 2a4:	64006864 	.inst	0x64006864 ; undefined
 2a8:	735f6365 	.inst	0x735f6365 ; undefined
 2ac:	65640068 	fmla	z8.h, p0/m, z3.h, z4.h
 2b0:	6c735f63 	ldnp	d3, d23, [x27, #-208]
 2b4:	5f796d00 	.inst	0x5f796d00 ; undefined
 2b8:	00736f63 	.inst	0x00736f63 ; undefined
 2bc:	635f6c77 	.inst	0x635f6c77 ; undefined
 2c0:	5f65646f 	.inst	0x5f65646f ; undefined
 2c4:	6c626174 	ldnp	d20, d24, [x11, #-480]
 2c8:	70610065 	adr	x5, c22d7 <__abi_tag-0x33dfa1>
 2cc:	7100316c 	subs	w12, w11, #0xc
 2d0:	635f3471 	.inst	0x635f3471 ; undefined
 2d4:	3465646f 	cbz	w15, caf60 <__abi_tag-0x335318>
 2d8:	6261745f 	.inst	0x6261745f ; undefined
 2dc:	4700656c 	.inst	0x4700656c ; undefined
 2e0:	4320554e 	.inst	0x4320554e ; undefined
 2e4:	31203731 	adds	w17, w25, #0x80d
 2e8:	2e332e30 	uqsub	v16.8b, v17.8b, v19.8b
 2ec:	6d2d2031 	stp	d17, d8, [x1, #-304]
 2f0:	7474696c 	.inst	0x7474696c ; undefined
 2f4:	652d656c 	.inst	0x652d656c ; undefined
 2f8:	6169646e 	.inst	0x6169646e ; undefined
 2fc:	6d2d206e 	stp	d14, d8, [x3, #-304]
 300:	3d696261 	ldr	b1, [x19, #2648]
 304:	3436706c 	cbz	w12, 6d110 <__abi_tag-0x393168>
 308:	00672d20 	.inst	0x00672d20 ; undefined
 30c:	735f796d 	.inst	0x735f796d ; undefined
 310:	65006e69 	.inst	0x65006e69 ; undefined
 314:	646f636e 	.inst	0x646f636e ; undefined
 318:	63610065 	.inst	0x63610065 ; undefined
 31c:	7274705f 	.inst	0x7274705f ; undefined
 320:	69660031 	ldpsw	x17, x0, [x1, #-208]
 324:	7065746c 	adr	x12, cb1b3 <__abi_tag-0x3350c5>
 328:	73657400 	.inst	0x73657400 ; undefined
 32c:	61645f74 	.inst	0x61645f74 ; undefined
 330:	66006174 	.inst	0x66006174 ; undefined
 334:	65746c69 	fnmls	z9.h, p3/m, z3.h, z20.h
 338:	6564007a 	fmla	z26.h, p0/m, z3.h, z4.h
 33c:	65646f63 	fnmls	z3.h, p3/m, z27.h, z4.h
 340:	6d717400 	ldp	d0, d29, [x0, #-240]
 344:	74705f66 	.inst	0x74705f66 ; undefined
 348:	61003172 	.inst	0x61003172 ; undefined
 34c:	6d756363 	ldp	d3, d24, [x27, #-176]
 350:	63610063 	.inst	0x63610063 ; undefined
 354:	646d7563 	.inst	0x646d7563 ; undefined
 358:	73657200 	.inst	0x73657200 ; undefined
 35c:	61007465 	.inst	0x61007465 ; undefined
 360:	74705f64 	.inst	0x74705f64 ; undefined
 364:	地址 0x0000000000000364 越界。

