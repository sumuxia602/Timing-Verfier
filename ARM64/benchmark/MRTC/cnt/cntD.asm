
cnt：     文件格式 elf64-littleaarch64


Disassembly of section .interp:

0000000000400238 <.interp>:
  400238:	62696c2f 	.inst	0x62696c2f ; undefined
  40023c:	2d646c2f 	ldp	s15, s27, [x1, #-224]
  400240:	756e696c 	.inst	0x756e696c ; undefined
  400244:	61612d78 	.inst	0x61612d78 ; undefined
  400248:	36686372 	tbz	w18, #13, 400eb4 <__FRAME_END__+0x404>
  40024c:	6f732e34 	.inst	0x6f732e34 ; undefined
  400250:	地址 0x0000000000400250 越界。


Disassembly of section .note.gnu.build-id:

0000000000400254 <.note.gnu.build-id>:
  400254:	00000004 	udf	#4
  400258:	00000014 	udf	#20
  40025c:	00000003 	udf	#3
  400260:	00554e47 	.inst	0x00554e47 ; undefined
  400264:	3dece325 	ldr	q5, [x25, #45952]
  400268:	c662c4ff 	.inst	0xc662c4ff ; undefined
  40026c:	beca87d6 	.inst	0xbeca87d6 ; undefined
  400270:	0ce4df32 	.inst	0x0ce4df32 ; undefined
  400274:	86ebcf01 	.inst	0x86ebcf01 ; undefined

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
  40037c:	34332e32 	cbz	w18, 466940 <Array+0x46908>
  400380:	54495f00 	b.eq	492f60 <Array+0x72f28>  // b.none
  400384:	65645f4d 	fnmla	z13.h, p7/m, z26.h, z4.h
  400388:	69676572 	ldpsw	x18, x25, [x11, #-200]
  40038c:	72657473 	.inst	0x72657473 ; undefined
  400390:	6c434d54 	ldnp	d20, d19, [x10, #48]
  400394:	54656e6f 	b.nv	4cb160 <Array+0xab128>
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

Disassembly of section .rodata:

00000000004008f0 <_IO_stdin_used>:
  4008f0:	00020001 	.inst	0x00020001 ; undefined

Disassembly of section .eh_frame_hdr:

00000000004008f4 <__GNU_EH_FRAME_HDR>:
  4008f4:	3b031b01 	.inst	0x3b031b01 ; undefined
  4008f8:	00000068 	udf	#104
  4008fc:	0000000c 	udf	#12
  400900:	fffffc0c 	.inst	0xfffffc0c ; undefined
  400904:	00000080 	udf	#128
  400908:	fffffc4c 	.inst	0xfffffc4c ; undefined
  40090c:	00000094 	udf	#148
  400910:	fffffc6c 	.inst	0xfffffc6c ; undefined
  400914:	000000ac 	udf	#172
  400918:	fffffc9c 	.inst	0xfffffc9c ; undefined
  40091c:	000000c0 	udf	#192
  400920:	fffffcdc 	.inst	0xfffffcdc ; undefined
  400924:	000000d4 	udf	#212
  400928:	fffffd0c 	.inst	0xfffffd0c ; undefined
  40092c:	000000f8 	udf	#248
  400930:	fffffd10 	.inst	0xfffffd10 ; undefined
  400934:	0000010c 	udf	#268
  400938:	fffffd34 	.inst	0xfffffd34 ; undefined
  40093c:	0000012c 	udf	#300
  400940:	fffffd98 	.inst	0xfffffd98 ; undefined
  400944:	0000014c 	udf	#332
  400948:	fffffe20 	.inst	0xfffffe20 ; undefined
  40094c:	00000174 	udf	#372
  400950:	fffffe34 	.inst	0xfffffe34 ; undefined
  400954:	00000188 	udf	#392
  400958:	ffffff8c 	.inst	0xffffff8c ; undefined
  40095c:	000001a8 	udf	#424

Disassembly of section .eh_frame:

0000000000400960 <__FRAME_END__-0x150>:
  400960:	00000010 	udf	#16
  400964:	00000000 	udf	#0
  400968:	00527a01 	.inst	0x00527a01 ; undefined
  40096c:	011e7804 	.inst	0x011e7804 ; undefined
  400970:	001f0c1b 	.inst	0x001f0c1b ; undefined
  400974:	00000010 	udf	#16
  400978:	00000018 	udf	#24
  40097c:	fffffb84 	.inst	0xfffffb84 ; undefined
  400980:	0000003c 	udf	#60
  400984:	1e074100 	.inst	0x1e074100 ; undefined
  400988:	00000014 	udf	#20
  40098c:	0000002c 	udf	#44
  400990:	fffffbb0 	.inst	0xfffffbb0 ; undefined
  400994:	00000004 	udf	#4
	...
  4009a0:	00000010 	udf	#16
  4009a4:	00000044 	udf	#68
  4009a8:	fffffbb8 	.inst	0xfffffbb8 ; undefined
  4009ac:	00000030 	udf	#48
  4009b0:	00000000 	udf	#0
  4009b4:	00000010 	udf	#16
  4009b8:	00000058 	udf	#88
  4009bc:	fffffbd4 	.inst	0xfffffbd4 ; undefined
  4009c0:	0000003c 	udf	#60
  4009c4:	00000000 	udf	#0
  4009c8:	00000020 	udf	#32
  4009cc:	0000006c 	udf	#108
  4009d0:	fffffc00 	.inst	0xfffffc00 ; undefined
  4009d4:	00000030 	udf	#48
  4009d8:	200e4100 	.inst	0x200e4100 ; undefined
  4009dc:	039e049d 	.inst	0x039e049d ; undefined
  4009e0:	48029342 	stlxrh	w2, w2, [x26]
  4009e4:	0ed3ddde 	.inst	0x0ed3ddde ; undefined
  4009e8:	00000000 	udf	#0
  4009ec:	00000010 	udf	#16
  4009f0:	00000090 	udf	#144
  4009f4:	fffffc0c 	.inst	0xfffffc0c ; undefined
  4009f8:	00000004 	udf	#4
  4009fc:	00000000 	udf	#0
  400a00:	0000001c 	udf	#28
  400a04:	000000a4 	udf	#164
  400a08:	fffffbfc 	.inst	0xfffffbfc ; undefined
  400a0c:	00000024 	udf	#36
  400a10:	100e4100 	adr	x0, 41d230 <__FRAME_END__+0x1c780>
  400a14:	019e029d 	.inst	0x019e029d ; undefined
  400a18:	0eddde47 	.inst	0x0eddde47 ; undefined
  400a1c:	00000000 	udf	#0
  400a20:	0000001c 	udf	#28
  400a24:	000000c4 	udf	#196
  400a28:	fffffc00 	.inst	0xfffffc00 ; undefined
  400a2c:	00000064 	udf	#100
  400a30:	400e4100 	.inst	0x400e4100 ; undefined
  400a34:	079e089d 	.inst	0x079e089d ; undefined
  400a38:	0eddde57 	.inst	0x0eddde57 ; undefined
  400a3c:	00000000 	udf	#0
  400a40:	00000024 	udf	#36
  400a44:	000000e4 	udf	#228
  400a48:	fffffc44 	.inst	0xfffffc44 ; undefined
  400a4c:	00000088 	udf	#136
  400a50:	400e4100 	.inst	0x400e4100 ; undefined
  400a54:	079e089d 	.inst	0x079e089d ; undefined
  400a58:	94069343 	bl	5a5764 <Array+0x18572c>
  400a5c:	5d049505 	.inst	0x5d049505 ; undefined
  400a60:	d3d5ddde 	.inst	0xd3d5ddde ; undefined
  400a64:	00000ed4 	udf	#3796
  400a68:	00000010 	udf	#16
  400a6c:	0000010c 	udf	#268
  400a70:	fffffca4 	.inst	0xfffffca4 ; undefined
  400a74:	00000014 	udf	#20
  400a78:	00000000 	udf	#0
  400a7c:	0000001c 	udf	#28
  400a80:	00000120 	udf	#288
  400a84:	fffffca4 	.inst	0xfffffca4 ; undefined
  400a88:	00000158 	udf	#344
  400a8c:	300e4100 	adr	x0, 41d2ad <__FRAME_END__+0x1c7fd>
  400a90:	05940693 	mov	z19.s, p4/z, #52
  400a94:	d3d45402 	.inst	0xd3d45402 ; undefined
  400a98:	0000000e 	udf	#14
  400a9c:	00000010 	udf	#16
  400aa0:	00000140 	udf	#320
  400aa4:	fffffddc 	.inst	0xfffffddc ; undefined
  400aa8:	0000005c 	udf	#92
  400aac:	00000000 	udf	#0

0000000000400ab0 <__FRAME_END__>:
  400ab0:	00000000 	udf	#0

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
  41fe20:	004008dc 	.inst	0x004008dc ; undefined
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

0000000000420030 <Seed>:
	...

0000000000420038 <Array>:
	...

00000000007f0938 <Postotal>:
  7f0938:	00000000 	udf	#0

00000000007f093c <Negtotal>:
  7f093c:	00000000 	udf	#0

00000000007f0940 <Poscnt>:
  7f0940:	00000000 	udf	#0

00000000007f0944 <Negcnt>:
  7f0944:	00000000 	udf	#0

Disassembly of section .comment:

0000000000000000 <.comment>:
   0:	3a434347 	ccmn	w26, w3, #0x7, mi  // mi = first
   4:	4e472820 	trn1	v0.8h, v1.8h, v7.8h
   8:	31202955 	adds	w21, w10, #0x80a
   c:	2e332e30 	uqsub	v16.8b, v17.8b, v19.8b
  10:	地址 0x0000000000000010 越界。


Disassembly of section .gnu.build.attributes:

00000000007f0948 <.gnu.build.attributes>:
  7f0948:	00000008 	udf	#8
  7f094c:	00000010 	udf	#16
  7f0950:	00000100 	udf	#256
  7f0954:	01244147 	.inst	0x01244147 ; undefined
  7f0958:	00316133 	.inst	0x00316133 ; NYI
  7f095c:	00400500 	.inst	0x00400500 ; undefined
  7f0960:	00000000 	udf	#0
  7f0964:	0040053c 	.inst	0x0040053c ; undefined
  7f0968:	00000000 	udf	#0
  7f096c:	00000008 	udf	#8
  7f0970:	00000010 	udf	#16
  7f0974:	00000100 	udf	#256
  7f0978:	01244147 	.inst	0x01244147 ; undefined
  7f097c:	00316133 	.inst	0x00316133 ; NYI
  7f0980:	00400544 	.inst	0x00400544 ; undefined
  7f0984:	00000000 	udf	#0
  7f0988:	00400558 	.inst	0x00400558 ; undefined
  7f098c:	00000000 	udf	#0
  7f0990:	00000008 	udf	#8
  7f0994:	00000010 	udf	#16
  7f0998:	00000100 	udf	#256
  7f099c:	01244147 	.inst	0x01244147 ; undefined
  7f09a0:	00316133 	.inst	0x00316133 ; NYI
  7f09a4:	00400498 	.inst	0x00400498 ; undefined
  7f09a8:	00000000 	udf	#0
  7f09ac:	004004a8 	.inst	0x004004a8 ; undefined
  7f09b0:	00000000 	udf	#0
  7f09b4:	00000008 	udf	#8
  7f09b8:	00000010 	udf	#16
  7f09bc:	00000100 	udf	#256
  7f09c0:	01244147 	.inst	0x01244147 ; undefined
  7f09c4:	00316133 	.inst	0x00316133 ; NYI
  7f09c8:	004008dc 	.inst	0x004008dc ; undefined
  7f09cc:	00000000 	udf	#0
  7f09d0:	004008e8 	.inst	0x004008e8 ; undefined
  7f09d4:	00000000 	udf	#0
  7f09d8:	00000008 	udf	#8
  7f09dc:	00000010 	udf	#16
  7f09e0:	00000100 	udf	#256
  7f09e4:	01244147 	.inst	0x01244147 ; undefined
  7f09e8:	00316133 	.inst	0x00316133 ; NYI
  7f09ec:	004008dc 	.inst	0x004008dc ; undefined
  7f09f0:	00000000 	udf	#0
  7f09f4:	004008dc 	.inst	0x004008dc ; undefined
  7f09f8:	00000000 	udf	#0
  7f09fc:	00000008 	udf	#8
  7f0a00:	00000010 	udf	#16
  7f0a04:	00000100 	udf	#256
  7f0a08:	01244147 	.inst	0x01244147 ; undefined
  7f0a0c:	00316133 	.inst	0x00316133 ; NYI
  7f0a10:	004004a8 	.inst	0x004004a8 ; undefined
  7f0a14:	00000000 	udf	#0
  7f0a18:	004004b0 	.inst	0x004004b0 ; undefined
  7f0a1c:	00000000 	udf	#0
  7f0a20:	00000008 	udf	#8
  7f0a24:	00000010 	udf	#16
  7f0a28:	00000100 	udf	#256
  7f0a2c:	01244147 	.inst	0x01244147 ; undefined
  7f0a30:	00316133 	.inst	0x00316133 ; NYI
  7f0a34:	004008e8 	.inst	0x004008e8 ; undefined
  7f0a38:	00000000 	udf	#0
  7f0a3c:	004008f0 	.inst	0x004008f0 ; undefined
  7f0a40:	00000000 	udf	#0

Disassembly of section .debug_aranges:

0000000000000000 <.debug_aranges>:
   0:	0000002c 	udf	#44
   4:	00000002 	udf	#2
   8:	00080000 	.inst	0x00080000 ; undefined
   c:	00000000 	udf	#0
  10:	00400604 	.inst	0x00400604 ; undefined
  14:	00000000 	udf	#0
  18:	000002d8 	udf	#728
	...

Disassembly of section .debug_info:

0000000000000000 <.debug_info>:
   0:	000002a8 	udf	#680
   4:	00000004 	udf	#4
   8:	01080000 	.inst	0x01080000 ; undefined
   c:	00000017 	udf	#23
  10:	0001020c 	.inst	0x0001020c ; undefined
  14:	00006300 	udf	#25344
  18:	40060400 	.inst	0x40060400 ; undefined
  1c:	00000000 	udf	#0
  20:	0002d800 	.inst	0x0002d800 ; undefined
	...
  2c:	00b20200 	.inst	0x00b20200 ; undefined
  30:	19010000 	stlurb	w0, [x0, #16]
  34:	0000390d 	udf	#14605
  38:	00580300 	.inst	0x00580300 ; undefined
  3c:	00510000 	.inst	0x00510000 ; undefined
  40:	51040000 	sub	w0, w0, #0x100
  44:	e7000000 	.inst	0xe7000000 ; undefined
  48:	00510403 	.inst	0x00510403 ; undefined
  4c:	03e70000 	.inst	0x03e70000 ; undefined
  50:	07080500 	.inst	0x07080500 ; undefined
  54:	00000048 	udf	#72
  58:	69050406 	stgp	x6, x1, [x0, #160]
  5c:	0700746e 	.inst	0x0700746e ; undefined
  60:	00000092 	udf	#146
  64:	58052f01 	ldr	x1, a644 <__abi_tag-0x3f5c34>
  68:	09000000 	.inst	0x09000000 ; undefined
  6c:	42003003 	.inst	0x42003003 ; undefined
  70:	00000000 	udf	#0
  74:	00000700 	udf	#1792
  78:	31010000 	adds	w0, w0, #0x40
  7c:	00002d08 	udf	#11528
  80:	38030900 	sttrb	w0, [x8, #48]
  84:	00004200 	udf	#16896
  88:	07000000 	.inst	0x07000000 ; undefined
  8c:	0000010e 	udf	#270
  90:	58053301 	ldr	x1, a6f0 <__abi_tag-0x3f5b88>
  94:	09000000 	.inst	0x09000000 ; undefined
  98:	7f093803 	.inst	0x7f093803 ; undefined
  9c:	00000000 	udf	#0
  a0:	005a0700 	.inst	0x005a0700 ; undefined
  a4:	33010000 	bfi	w0, w0, #31, #1
  a8:	0000580f 	udf	#22543
  ac:	3c030900 	.inst	0x3c030900 ; undefined
  b0:	00007f09 	udf	#32521
  b4:	07000000 	.inst	0x07000000 ; undefined
  b8:	000000db 	udf	#219
  bc:	58193301 	ldr	x1, 3271c <__abi_tag-0x3cdb5c>
  c0:	09000000 	.inst	0x09000000 ; undefined
  c4:	7f094003 	.inst	0x7f094003 ; undefined
  c8:	00000000 	udf	#0
  cc:	00e20700 	.inst	0x00e20700 ; undefined
  d0:	33010000 	bfi	w0, w0, #31, #1
  d4:	00005821 	udf	#22561
  d8:	44030900 	.inst	0x44030900 ; undefined
  dc:	00007f09 	udf	#32521
  e0:	08000000 	stxrb	w0, w0, [x0]
  e4:	000000c4 	udf	#196
  e8:	5805f701 	ldr	x1, bfc8 <__abi_tag-0x3f42b0>
  ec:	80000000 	.inst	0x80000000 ; undefined
  f0:	00004008 	udf	#16392
  f4:	5c000000 	ldr	d0, f4 <__abi_tag-0x400184>
  f8:	00000000 	udf	#0
  fc:	01000000 	.inst	0x01000000 ; undefined
 100:	7553099c 	.inst	0x7553099c ; undefined
 104:	9e01006d 	.inst	0x9e01006d ; undefined
 108:	40072806 	.inst	0x40072806 ; undefined
 10c:	00000000 	udf	#0
 110:	00015800 	.inst	0x00015800 ; undefined
 114:	00000000 	udf	#0
 118:	929c0100 	mov	x0, #0xffffffffffff1ff7    	// #-57353
 11c:	0a000001 	and	w1, w0, w0
 120:	00000000 	udf	#0
 124:	a3119e01 	.inst	0xa3119e01 ; undefined
 128:	02000001 	.inst	0x02000001 ; undefined
 12c:	110b6891 	add	w17, w4, #0x2da
 130:	01000000 	.inst	0x01000000 ; undefined
 134:	005810a2 	.inst	0x005810a2 ; undefined
 138:	63010000 	.inst	0x63010000 ; undefined
 13c:	0000ac0b 	udf	#44043
 140:	17a20100 	b	fffffffffe880540 <__bss_end__+0xfffffffffe08fbf8>
 144:	00000058 	udf	#88
 148:	690c6401 	stgp	x1, x25, [x0, #384]
 14c:	a2010032 	.inst	0xa2010032 ; undefined
 150:	0000581e 	udf	#22558
 154:	00800b00 	.inst	0x00800b00 ; undefined
 158:	a6010000 	.inst	0xa6010000 ; undefined
 15c:	00005807 	udf	#22535
 160:	7c910200 	.inst	0x7c910200 ; undefined
 164:	0000870b 	udf	#34571
 168:	07a80100 	.inst	0x07a80100 ; undefined
 16c:	00000058 	udf	#88
 170:	0b789102 	.inst	0x0b789102 ; undefined
 174:	000000a7 	udf	#167
 178:	5807aa01 	ldr	x1, f6b8 <__abi_tag-0x3f0bc0>
 17c:	02000000 	.inst	0x02000000 ; undefined
 180:	a20b7491 	.inst	0xa20b7491 ; undefined
 184:	01000000 	.inst	0x01000000 ; undefined
 188:	005807ac 	.inst	0x005807ac ; undefined
 18c:	91020000 	add	x0, x0, #0x80
 190:	58030070 	ldr	x16, 619c <__abi_tag-0x3fa0dc>
 194:	a3000000 	.inst	0xa3000000 ; undefined
 198:	04000001 	add	z1.b, p0/m, z1.b, z0.b
 19c:	00000051 	udf	#81
 1a0:	0d0003e7 	st1	{v7.b}[0], [sp]
 1a4:	00019208 	.inst	0x00019208 ; undefined
 1a8:	008e0800 	.inst	0x008e0800 ; undefined
 1ac:	92010000 	and	x0, x0, #0x8000000080000000
 1b0:	00005805 	udf	#22533
 1b4:	40071400 	.inst	0x40071400 ; undefined
 1b8:	00000000 	udf	#0
 1bc:	00001400 	udf	#5120
 1c0:	00000000 	udf	#0
 1c4:	0e9c0100 	.inst	0x0e9c0100 ; undefined
 1c8:	00000097 	udf	#151
 1cc:	58057901 	ldr	x1, b0ec <__abi_tag-0x3f518c>
 1d0:	8c000000 	.inst	0x8c000000 ; undefined
 1d4:	00004006 	udf	#16390
 1d8:	88000000 	stxr	w0, w0, [x0]
 1dc:	00000000 	udf	#0
 1e0:	01000000 	.inst	0x01000000 ; undefined
 1e4:	0002209c 	.inst	0x0002209c ; undefined
 1e8:	00000a00 	udf	#2560
 1ec:	79010000 	strh	w0, [x0, #128]
 1f0:	0001a317 	.inst	0x0001a317 ; undefined
 1f4:	78910200 	ldursh	x0, [x16, #-240]
 1f8:	0000b90b 	udf	#47371
 1fc:	117d0100 	add	w0, w8, #0xf40, lsl #12
 200:	00000058 	udf	#88
 204:	060b6301 	.inst	0x060b6301 ; undefined
 208:	01000000 	.inst	0x01000000 ; undefined
 20c:	00581d7d 	.inst	0x00581d7d ; undefined
 210:	64010000 	.inst	0x64010000 ; undefined
 214:	0032690c 	.inst	0x0032690c ; NYI
 218:	58297d01 	ldr	x1, 531b8 <__abi_tag-0x3ad0c0>
 21c:	00000000 	udf	#0
 220:	0001170e 	.inst	0x0001170e ; undefined
 224:	054d0100 	.inst	0x054d0100 ; undefined
 228:	00000058 	udf	#88
 22c:	00400628 	.inst	0x00400628 ; undefined
 230:	00000000 	udf	#0
 234:	00000064 	udf	#100
 238:	00000000 	udf	#0
 23c:	027f9c01 	.inst	0x027f9c01 ; undefined
 240:	000a0000 	.inst	0x000a0000 ; undefined
 244:	01000000 	.inst	0x01000000 ; undefined
 248:	01a3114d 	.inst	0x01a3114d ; undefined
 24c:	91020000 	add	x0, x0, #0x80
 250:	00f30b58 	.inst	0x00f30b58 ; undefined
 254:	51010000 	sub	w0, w0, #0x40
 258:	00027f09 	.inst	0x00027f09 ; undefined
 25c:	78910200 	ldursh	x0, [x16, #-240]
 260:	00011c0b 	.inst	0x00011c0b ; undefined
 264:	14510100 	b	1440664 <__bss_end__+0xc4fd1c>
 268:	0000027f 	udf	#639
 26c:	0b709102 	.inst	0x0b709102 ; undefined
 270:	000000e9 	udf	#233
 274:	860a5301 	.inst	0x860a5301 ; undefined
 278:	02000002 	.inst	0x02000002 ; undefined
 27c:	05006c91 	orr	z17.h, z17.h, #0xf8
 280:	00d20508 	.inst	0x00d20508 ; undefined
 284:	04050000 	.inst	0x04050000 ; undefined
 288:	00010804 	.inst	0x00010804 ; undefined
 28c:	00fd0f00 	.inst	0x00fd0f00 ; undefined
 290:	39010000 	strb	w0, [x0, #64]
 294:	00005805 	udf	#22533
 298:	40060400 	.inst	0x40060400 ; undefined
 29c:	00000000 	udf	#0
 2a0:	00002400 	udf	#9216
 2a4:	00000000 	udf	#0
 2a8:	009c0100 	.inst	0x009c0100 ; undefined

Disassembly of section .debug_abbrev:

0000000000000000 <.debug_abbrev>:
   0:	25011101 	cmpge	p1.b, p4/z, z8.b, #1
   4:	030b130e 	.inst	0x030b130e ; undefined
   8:	110e1b0e 	add	w14, w24, #0x386
   c:	10071201 	adr	x1, e24c <__abi_tag-0x3f202c>
  10:	02000017 	.inst	0x02000017 ; undefined
  14:	0e030016 	tbl	v22.8b, {v0.16b}, v3.8b
  18:	0b3b0b3a 	add	w26, w25, w27, uxtb #2
  1c:	13490b39 	.inst	0x13490b39 ; undefined
  20:	01030000 	.inst	0x01030000 ; undefined
  24:	01134901 	.inst	0x01134901 ; undefined
  28:	04000013 	add	z19.b, p0/m, z19.b, z0.b
  2c:	13490021 	.inst	0x13490021 ; undefined
  30:	0000052f 	udf	#1327
  34:	0b002405 	add	w5, w0, w0, lsl #9
  38:	030b3e0b 	.inst	0x030b3e0b ; undefined
  3c:	0600000e 	.inst	0x0600000e ; undefined
  40:	0b0b0024 	add	w4, w1, w11
  44:	08030b3e 	stxrb	w3, w30, [x25]
  48:	34070000 	cbz	w0, e048 <__abi_tag-0x3f2230>
  4c:	3a0e0300 	adcs	w0, w24, w14
  50:	390b3b0b 	strb	w11, [x24, #718]
  54:	3f13490b 	.inst	0x3f13490b ; undefined
  58:	00180219 	.inst	0x00180219 ; undefined
  5c:	002e0800 	.inst	0x002e0800 ; NYI
  60:	0e03193f 	uzp1	v31.8b, v9.8b, v3.8b
  64:	0b3b0b3a 	add	w26, w25, w27, uxtb #2
  68:	19270b39 	.inst	0x19270b39 ; undefined
  6c:	01111349 	.inst	0x01111349 ; undefined
  70:	18400712 	ldr	w18, 80150 <__abi_tag-0x380128>
  74:	00194297 	.inst	0x00194297 ; undefined
  78:	012e0900 	.inst	0x012e0900 ; undefined
  7c:	0803193f 	stxrb	w3, wzr, [x9]
  80:	0b3b0b3a 	add	w26, w25, w27, uxtb #2
  84:	19270b39 	.inst	0x19270b39 ; undefined
  88:	07120111 	.inst	0x07120111 ; undefined
  8c:	42971840 	.inst	0x42971840 ; undefined
  90:	00130119 	.inst	0x00130119 ; undefined
  94:	00050a00 	.inst	0x00050a00 ; undefined
  98:	0b3a0e03 	add	w3, w16, w26, uxtb #3
  9c:	0b390b3b 	add	w27, w25, w25, uxtb #2
  a0:	18021349 	ldr	w9, 4308 <__abi_tag-0x3fbf70>
  a4:	340b0000 	cbz	w0, 160a4 <__abi_tag-0x3ea1d4>
  a8:	3a0e0300 	adcs	w0, w24, w14
  ac:	390b3b0b 	strb	w11, [x24, #718]
  b0:	0213490b 	.inst	0x0213490b ; undefined
  b4:	0c000018 	st4	{v24.8b-v27.8b}, [x0]
  b8:	08030034 	stxrb	w3, w20, [x1]
  bc:	0b3b0b3a 	add	w26, w25, w27, uxtb #2
  c0:	13490b39 	.inst	0x13490b39 ; undefined
  c4:	0f0d0000 	.inst	0x0f0d0000 ; undefined
  c8:	490b0b00 	.inst	0x490b0b00 ; undefined
  cc:	0e000013 	tbl	v19.8b, {v0.16b}, v0.8b
  d0:	193f012e 	.inst	0x193f012e ; undefined
  d4:	0b3a0e03 	add	w3, w16, w26, uxtb #3
  d8:	0b390b3b 	add	w27, w25, w25, uxtb #2
  dc:	13491927 	.inst	0x13491927 ; undefined
  e0:	07120111 	.inst	0x07120111 ; undefined
  e4:	42961840 	.inst	0x42961840 ; undefined
  e8:	00130119 	.inst	0x00130119 ; undefined
  ec:	002e0f00 	.inst	0x002e0f00 ; NYI
  f0:	0e03193f 	uzp1	v31.8b, v9.8b, v3.8b
  f4:	0b3b0b3a 	add	w26, w25, w27, uxtb #2
  f8:	19270b39 	.inst	0x19270b39 ; undefined
  fc:	01111349 	.inst	0x01111349 ; undefined
 100:	18400712 	ldr	w18, 801e0 <__abi_tag-0x380098>
 104:	00194296 	.inst	0x00194296 ; undefined
	...

Disassembly of section .debug_line:

0000000000000000 <.debug_line>:
   0:	00000129 	udf	#297
   4:	001c0003 	.inst	0x001c0003 ; undefined
   8:	01040000 	.inst	0x01040000 ; undefined
   c:	000d0efb 	.inst	0x000d0efb ; undefined
  10:	01010101 	.inst	0x01010101 ; undefined
  14:	01000000 	.inst	0x01000000 ; undefined
  18:	00010000 	.inst	0x00010000 ; undefined
  1c:	2e746e63 	umin	v3.4h, v19.4h, v20.4h
  20:	00000063 	udf	#99
  24:	01050000 	.inst	0x01050000 ; undefined
  28:	04020900 	.inst	0x04020900 ; undefined
  2c:	00004006 	udf	#16390
  30:	03000000 	.inst	0x03000000 ; undefined
  34:	0405013a 	.inst	0x0405013a ; undefined
  38:	0b052630 	add	w16, w17, w5, lsl #9
  3c:	2201053e 	.inst	0x2201053e ; undefined
  40:	44040536 	.inst	0x44040536 ; undefined
  44:	05300e05 	ext	z5.b, z5.b, z16.b, #131
  48:	0d053004 	.inst	0x0d053004 ; undefined
  4c:	321a0530 	orr	w16, w9, #0xc0
  50:	054a2705 	.inst	0x054a2705 ; undefined
  54:	0b05580e 	add	w14, w0, w5, lsl #22
  58:	052e0e03 	ext	z3.b, z3.b, z16.b, #115
  5c:	0a032201 	and	w1, w16, w3, lsl #8
  60:	5e14052e 	mov	s14, v9.s[2]
  64:	05200405 	ext	z5.b, z5.b, z0.b, #1
  68:	07052217 	.inst	0x07052217 ; undefined
  6c:	000f0520 	.inst	0x000f0520 ; undefined
  70:	22030402 	.inst	0x22030402 ; undefined
  74:	02002a05 	.inst	0x02002a05 ; undefined
  78:	059e0304 	mov	z4.s, p14/z, #24
  7c:	04020028 	.inst	0x04020028 ; undefined
  80:	3c052e03 	str	b3, [x16, #82]!
  84:	03040200 	.inst	0x03040200 ; undefined
  88:	0007052c 	.inst	0x0007052c ; undefined
  8c:	20010402 	.inst	0x20010402 ; undefined
  90:	02003905 	.inst	0x02003905 ; undefined
  94:	052c0204 	ext	z4.b, z4.b, z16.b, #96
  98:	04020004 	.inst	0x04020004 ; undefined
  9c:	0b052001 	add	w1, w0, w5, lsl #8
  a0:	22010535 	.inst	0x22010535 ; undefined
  a4:	054a0a03 	.inst	0x054a0a03 ; undefined
  a8:	0b051409 	add	w9, w0, w5, lsl #5
  ac:	2201053e 	.inst	0x2201053e ; undefined
  b0:	34070526 	cbz	w6, e154 <__abi_tag-0x3f2124>
  b4:	05222222 	mov	z2.h, h17
  b8:	0305240e 	.inst	0x0305240e ; undefined
  bc:	22100520 	.inst	0x22100520 ; undefined
  c0:	05200505 	ext	z5.b, z5.b, z8.b, #1
  c4:	1205280b 	and	w11, w0, #0xf800003f
  c8:	2e05059e 	.inst	0x2e05059e ; undefined
  cc:	05321305 	ext	z5.b, z5.b, z24.b, #148
  d0:	0b059e1a 	.inst	0x0b059e1a ; undefined
  d4:	3e08052e 	.inst	0x3e08052e ; undefined
  d8:	05501305 	mov	z5.h, p0/z, #-104
  dc:	0b059e1a 	.inst	0x0b059e1a ; undefined
  e0:	3e08052e 	.inst	0x3e08052e ; undefined
  e4:	02002b05 	.inst	0x02002b05 ; undefined
  e8:	6a030204 	ands	w4, w16, w3
  ec:	0005053c 	.inst	0x0005053c ; undefined
  f0:	20010402 	.inst	0x20010402 ; undefined
  f4:	02002905 	.inst	0x02002905 ; undefined
  f8:	052c0204 	ext	z4.b, z4.b, z16.b, #96
  fc:	04020003 	.inst	0x04020003 ; undefined
 100:	0c052001 	.inst	0x0c052001 ; undefined
 104:	052e1e03 	ext	z3.b, z3.b, z16.b, #119
 108:	0c054c0a 	.inst	0x0c054c0a ; undefined
 10c:	4c0a054c 	.inst	0x4c0a054c ; undefined
 110:	034d0105 	.inst	0x034d0105 ; undefined
 114:	12053c22 	and	w2, w1, #0xf80007ff
 118:	58190514 	ldr	x20, 321b8 <__abi_tag-0x3ce0c0>
 11c:	05201f05 	ext	z5.b, z5.b, z24.b, #7
 120:	0b059e09 	.inst	0x0b059e09 ; undefined
 124:	3e01053e 	.inst	0x3e01053e ; undefined
 128:	01000102 	.inst	0x01000102 ; undefined
 12c:	地址 0x000000000000012c 越界。


Disassembly of section .debug_str:

0000000000000000 <.debug_str>:
   0:	61727241 	.inst	0x61727241 ; undefined
   4:	6e490079 	.inst	0x6e490079 ; undefined
   8:	4972656e 	.inst	0x4972656e ; undefined
   c:	7865646e 	.inst	0x7865646e ; undefined
  10:	74754f00 	.inst	0x74754f00 ; undefined
  14:	47007265 	.inst	0x47007265 ; undefined
  18:	4320554e 	.inst	0x4320554e ; undefined
  1c:	31203731 	adds	w17, w25, #0x80d
  20:	2e332e30 	uqsub	v16.8b, v17.8b, v19.8b
  24:	6d2d2031 	stp	d17, d8, [x1, #-304]
  28:	7474696c 	.inst	0x7474696c ; undefined
  2c:	652d656c 	.inst	0x652d656c ; undefined
  30:	6169646e 	.inst	0x6169646e ; undefined
  34:	6d2d206e 	stp	d14, d8, [x3, #-304]
  38:	3d696261 	ldr	b1, [x19, #2648]
  3c:	3436706c 	cbz	w12, 6ce48 <__abi_tag-0x393430>
  40:	20672d20 	.inst	0x20672d20 ; undefined
  44:	00304f2d 	.inst	0x00304f2d ; NYI
  48:	676e6f6c 	.inst	0x676e6f6c ; undefined
  4c:	736e7520 	.inst	0x736e7520 ; undefined
  50:	656e6769 	fnmls	z9.h, p1/m, z27.h, z14.h
  54:	6e692064 	usubl2	v4.4s, v3.8h, v9.8h
  58:	654e0074 	fadd	z20.h, z3.h, z14.h
  5c:	746f7467 	.inst	0x746f7467 ; undefined
  60:	2f006c61 	.inst	0x2f006c61 ; undefined
  64:	656d6f68 	fnmls	z8.h, p3/m, z27.h, z13.h
  68:	61796a2f 	.inst	0x61796a2f ; undefined
  6c:	702f676e 	adr	x14, 5ed5b <__abi_tag-0x3a151d>
  70:	72676f72 	.inst	0x72676f72 ; undefined
  74:	4d2f6d61 	.inst	0x4d2f6d61 ; undefined
  78:	2f435452 	.inst	0x2f435452 ; undefined
  7c:	00746e63 	.inst	0x00746e63 ; undefined
  80:	746f7450 	.inst	0x746f7450 ; undefined
  84:	4e006c61 	.inst	0x4e006c61 ; undefined
  88:	61746f74 	.inst	0x61746f74 ; undefined
  8c:	6e49006c 	.inst	0x6e49006c ; undefined
  90:	65537469 	fcmeq	p9.h, p5/z, z3.h, z19.h
  94:	49006465 	.inst	0x49006465 ; undefined
  98:	6974696e 	ldpsw	x14, x26, [x11, #-96]
  9c:	7a696c61 	.inst	0x7a696c61 ; undefined
  a0:	634e0065 	.inst	0x634e0065 ; undefined
  a4:	5000746e 	adr	x14, f32 <__abi_tag-0x3ff346>
  a8:	00746e63 	.inst	0x00746e63 ; undefined
  ac:	656e6e49 	fnmls	z9.h, p3/m, z18.h, z14.h
  b0:	616d0072 	.inst	0x616d0072 ; undefined
  b4:	78697274 	lduminlh	w9, w20, [x19]
  b8:	74754f00 	.inst	0x74754f00 ; undefined
  bc:	6e497265 	.inst	0x6e497265 ; undefined
  c0:	00786564 	.inst	0x00786564 ; undefined
  c4:	646e6152 	.inst	0x646e6152 ; undefined
  c8:	6e496d6f 	.inst	0x6e496d6f ; undefined
  cc:	65676574 	fnmls	z20.h, p1/m, z11.h, z7.h
  d0:	6f6c0072 	mla	v18.8h, v3.8h, v12.h[2]
  d4:	6920676e 	stgp	x14, x25, [x27, #-1024]
  d8:	5000746e 	adr	x14, f66 <__abi_tag-0x3ff312>
  dc:	6e63736f 	uabdl2	v15.4s, v27.8h, v3.8h
  e0:	654e0074 	fadd	z20.h, z3.h, z14.h
  e4:	746e6367 	.inst	0x746e6367 ; undefined
  e8:	746f5400 	.inst	0x746f5400 ; undefined
  ec:	69546c61 	ldpsw	x1, x27, [x3, #160]
  f0:	5300656d 	ubfx	w13, w11, #0, #26
  f4:	74726174 	.inst	0x74726174 ; undefined
  f8:	656d6954 	fnmls	z20.h, p2/m, z10.h, z13.h
  fc:	69616d00 	ldpsw	x0, x27, [x8, #-248]
 100:	6e63006e 	uaddl2	v14.4s, v3.8h, v3.8h
 104:	00632e74 	.inst	0x00632e74 ; undefined
 108:	616f6c66 	.inst	0x616f6c66 ; undefined
 10c:	6f500074 	mla	v20.8h, v3.8h, v0.h[1]
 110:	746f7473 	.inst	0x746f7473 ; undefined
 114:	54006c61 	b.ne	ea0 <__abi_tag-0x3ff3d8>  // b.any
 118:	00747365 	.inst	0x00747365 ; undefined
 11c:	706f7453 	adr	x19, defa7 <__abi_tag-0x3212d1>
 120:	656d6954 	fnmls	z20.h, p2/m, z10.h, z13.h
	...
