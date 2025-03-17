
bsort100：     文件格式 elf64-littleaarch64


Disassembly of section .interp:

0000000000400238 <.interp>:
  400238:	62696c2f 	.inst	0x62696c2f ; undefined
  40023c:	2d646c2f 	ldp	s15, s27, [x1, #-224]
  400240:	756e696c 	.inst	0x756e696c ; undefined
  400244:	61612d78 	.inst	0x61612d78 ; undefined
  400248:	36686372 	tbz	w18, #13, 400eb4 <__FRAME_END__+0x50c>
  40024c:	6f732e34 	.inst	0x6f732e34 ; undefined
  400250:	地址 0x0000000000400250 越界。


Disassembly of section .note.gnu.build-id:

0000000000400254 <.note.gnu.build-id>:
  400254:	00000004 	udf	#4
  400258:	00000014 	udf	#20
  40025c:	00000003 	udf	#3
  400260:	00554e47 	.inst	0x00554e47 ; undefined
  400264:	af49e8d5 	.inst	0xaf49e8d5 ; undefined
  400268:	fa5b8170 	.inst	0xfa5b8170 ; undefined
  40026c:	8612878e 	.inst	0x8612878e ; undefined
  400270:	4d9ac87c 	.inst	0x4d9ac87c ; undefined
  400274:	fc315b25 	str	d5, [x25, w17, uxtw #3]

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
  40037c:	34332e32 	cbz	w18, 466940 <__bss_end__+0x46770>
  400380:	54495f00 	b.eq	492f60 <__bss_end__+0x72d90>  // b.none
  400384:	65645f4d 	fnmla	z13.h, p7/m, z26.h, z4.h
  400388:	69676572 	ldpsw	x18, x25, [x11, #-200]
  40038c:	72657473 	.inst	0x72657473 ; undefined
  400390:	6c434d54 	ldnp	d20, d19, [x10, #48]
  400394:	54656e6f 	b.nv	4cb160 <__bss_end__+0xaaf90>
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

Disassembly of section .rodata:

0000000000400840 <_IO_stdin_used>:
  400840:	00020001 	.inst	0x00020001 ; undefined

Disassembly of section .eh_frame_hdr:

0000000000400844 <__GNU_EH_FRAME_HDR>:
  400844:	3b031b01 	.inst	0x3b031b01 ; undefined
  400848:	00000058 	udf	#88
  40084c:	0000000a 	udf	#10
  400850:	fffffcbc 	.inst	0xfffffcbc ; undefined
  400854:	00000070 	udf	#112
  400858:	fffffcfc 	.inst	0xfffffcfc ; undefined
  40085c:	00000084 	udf	#132
  400860:	fffffd1c 	.inst	0xfffffd1c ; undefined
  400864:	0000009c 	udf	#156
  400868:	fffffd4c 	.inst	0xfffffd4c ; undefined
  40086c:	000000b0 	udf	#176
  400870:	fffffd8c 	.inst	0xfffffd8c ; undefined
  400874:	000000c4 	udf	#196
  400878:	fffffdbc 	.inst	0xfffffdbc ; undefined
  40087c:	000000e8 	udf	#232
  400880:	fffffdc0 	.inst	0xfffffdc0 ; undefined
  400884:	000000fc 	udf	#252
  400888:	fffffdec 	.inst	0xfffffdec ; undefined
  40088c:	0000011c 	udf	#284
  400890:	fffffe28 	.inst	0xfffffe28 ; undefined
  400894:	00000134 	udf	#308
  400898:	fffffeb4 	.inst	0xfffffeb4 ; undefined
  40089c:	0000014c 	udf	#332

Disassembly of section .eh_frame:

00000000004008a0 <__FRAME_END__-0x108>:
  4008a0:	00000010 	udf	#16
  4008a4:	00000000 	udf	#0
  4008a8:	00527a01 	.inst	0x00527a01 ; undefined
  4008ac:	011e7804 	.inst	0x011e7804 ; undefined
  4008b0:	001f0c1b 	.inst	0x001f0c1b ; undefined
  4008b4:	00000010 	udf	#16
  4008b8:	00000018 	udf	#24
  4008bc:	fffffc44 	.inst	0xfffffc44 ; undefined
  4008c0:	0000003c 	udf	#60
  4008c4:	1e074100 	.inst	0x1e074100 ; undefined
  4008c8:	00000014 	udf	#20
  4008cc:	0000002c 	udf	#44
  4008d0:	fffffc70 	.inst	0xfffffc70 ; undefined
  4008d4:	00000004 	udf	#4
	...
  4008e0:	00000010 	udf	#16
  4008e4:	00000044 	udf	#68
  4008e8:	fffffc78 	.inst	0xfffffc78 ; undefined
  4008ec:	00000030 	udf	#48
  4008f0:	00000000 	udf	#0
  4008f4:	00000010 	udf	#16
  4008f8:	00000058 	udf	#88
  4008fc:	fffffc94 	.inst	0xfffffc94 ; undefined
  400900:	0000003c 	udf	#60
  400904:	00000000 	udf	#0
  400908:	00000020 	udf	#32
  40090c:	0000006c 	udf	#108
  400910:	fffffcc0 	.inst	0xfffffcc0 ; undefined
  400914:	00000030 	udf	#48
  400918:	200e4100 	.inst	0x200e4100 ; undefined
  40091c:	039e049d 	.inst	0x039e049d ; undefined
  400920:	48029342 	stlxrh	w2, w2, [x26]
  400924:	0ed3ddde 	.inst	0x0ed3ddde ; undefined
  400928:	00000000 	udf	#0
  40092c:	00000010 	udf	#16
  400930:	00000090 	udf	#144
  400934:	fffffccc 	.inst	0xfffffccc ; undefined
  400938:	00000004 	udf	#4
  40093c:	00000000 	udf	#0
  400940:	0000001c 	udf	#28
  400944:	000000a4 	udf	#164
  400948:	fffffcbc 	.inst	0xfffffcbc ; undefined
  40094c:	0000002c 	udf	#44
  400950:	100e4100 	adr	x0, 41d170 <__FRAME_END__+0x1c7c8>
  400954:	019e029d 	.inst	0x019e029d ; undefined
  400958:	0eddde49 	.inst	0x0eddde49 ; undefined
  40095c:	00000000 	udf	#0
  400960:	00000014 	udf	#20
  400964:	000000c4 	udf	#196
  400968:	fffffcc8 	.inst	0xfffffcc8 ; undefined
  40096c:	0000003c 	udf	#60
  400970:	300e4100 	adr	x0, 41d191 <__FRAME_END__+0x1c7e9>
  400974:	00000e4d 	udf	#3661
  400978:	00000014 	udf	#20
  40097c:	000000dc 	udf	#220
  400980:	fffffcec 	.inst	0xfffffcec ; undefined
  400984:	0000008c 	udf	#140
  400988:	200e4100 	.inst	0x200e4100 ; undefined
  40098c:	00000e61 	udf	#3681
  400990:	00000014 	udf	#20
  400994:	000000f4 	udf	#244
  400998:	fffffd60 	.inst	0xfffffd60 ; undefined
  40099c:	00000134 	udf	#308
  4009a0:	200e4100 	.inst	0x200e4100 ; undefined
  4009a4:	000e4b02 	.inst	0x000e4b02 ; undefined

00000000004009a8 <__FRAME_END__>:
  4009a8:	00000000 	udf	#0

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
  41fe20:	0040082c 	.inst	0x0040082c ; undefined
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

0000000000420030 <Array>:
	...

00000000004201c4 <Seed>:
  4201c4:	00000000 	udf	#0

00000000004201c8 <factor>:
	...

Disassembly of section .comment:

0000000000000000 <.comment>:
   0:	3a434347 	ccmn	w26, w3, #0x7, mi  // mi = first
   4:	4e472820 	trn1	v0.8h, v1.8h, v7.8h
   8:	31202955 	adds	w21, w10, #0x80a
   c:	2e332e30 	uqsub	v16.8b, v17.8b, v19.8b
  10:	地址 0x0000000000000010 越界。


Disassembly of section .gnu.build.attributes:

00000000004201d0 <.gnu.build.attributes>:
  4201d0:	00000008 	udf	#8
  4201d4:	00000010 	udf	#16
  4201d8:	00000100 	udf	#256
  4201dc:	01244147 	.inst	0x01244147 ; undefined
  4201e0:	00316133 	.inst	0x00316133 ; NYI
  4201e4:	00400500 	.inst	0x00400500 ; undefined
  4201e8:	00000000 	udf	#0
  4201ec:	0040053c 	.inst	0x0040053c ; undefined
  4201f0:	00000000 	udf	#0
  4201f4:	00000008 	udf	#8
  4201f8:	00000010 	udf	#16
  4201fc:	00000100 	udf	#256
  420200:	01244147 	.inst	0x01244147 ; undefined
  420204:	00316133 	.inst	0x00316133 ; NYI
  420208:	00400544 	.inst	0x00400544 ; undefined
  42020c:	00000000 	udf	#0
  420210:	00400558 	.inst	0x00400558 ; undefined
  420214:	00000000 	udf	#0
  420218:	00000008 	udf	#8
  42021c:	00000010 	udf	#16
  420220:	00000100 	udf	#256
  420224:	01244147 	.inst	0x01244147 ; undefined
  420228:	00316133 	.inst	0x00316133 ; NYI
  42022c:	00400498 	.inst	0x00400498 ; undefined
  420230:	00000000 	udf	#0
  420234:	004004a8 	.inst	0x004004a8 ; undefined
  420238:	00000000 	udf	#0
  42023c:	00000008 	udf	#8
  420240:	00000010 	udf	#16
  420244:	00000100 	udf	#256
  420248:	01244147 	.inst	0x01244147 ; undefined
  42024c:	00316133 	.inst	0x00316133 ; NYI
  420250:	0040082c 	.inst	0x0040082c ; undefined
  420254:	00000000 	udf	#0
  420258:	00400838 	.inst	0x00400838 ; undefined
  42025c:	00000000 	udf	#0
  420260:	00000008 	udf	#8
  420264:	00000010 	udf	#16
  420268:	00000100 	udf	#256
  42026c:	01244147 	.inst	0x01244147 ; undefined
  420270:	00316133 	.inst	0x00316133 ; NYI
  420274:	0040082c 	.inst	0x0040082c ; undefined
  420278:	00000000 	udf	#0
  42027c:	0040082c 	.inst	0x0040082c ; undefined
  420280:	00000000 	udf	#0
  420284:	00000008 	udf	#8
  420288:	00000010 	udf	#16
  42028c:	00000100 	udf	#256
  420290:	01244147 	.inst	0x01244147 ; undefined
  420294:	00316133 	.inst	0x00316133 ; NYI
  420298:	004004a8 	.inst	0x004004a8 ; undefined
  42029c:	00000000 	udf	#0
  4202a0:	004004b0 	.inst	0x004004b0 ; undefined
  4202a4:	00000000 	udf	#0
  4202a8:	00000008 	udf	#8
  4202ac:	00000010 	udf	#16
  4202b0:	00000100 	udf	#256
  4202b4:	01244147 	.inst	0x01244147 ; undefined
  4202b8:	00316133 	.inst	0x00316133 ; NYI
  4202bc:	00400838 	.inst	0x00400838 ; undefined
  4202c0:	00000000 	udf	#0
  4202c4:	00400840 	.inst	0x00400840 ; undefined
  4202c8:	00000000 	udf	#0

Disassembly of section .debug_aranges:

0000000000000000 <.debug_aranges>:
   0:	0000002c 	udf	#44
   4:	00000002 	udf	#2
   8:	00080000 	.inst	0x00080000 ; undefined
   c:	00000000 	udf	#0
  10:	00400604 	.inst	0x00400604 ; undefined
  14:	00000000 	udf	#0
  18:	00000228 	udf	#552
	...

Disassembly of section .debug_info:

0000000000000000 <.debug_info>:
   0:	000002a0 	udf	#672
   4:	00000004 	udf	#4
   8:	01080000 	.inst	0x01080000 ; undefined
   c:	0000005e 	udf	#94
  10:	0001410c 	.inst	0x0001410c ; undefined
  14:	00002d00 	udf	#11520
  18:	40060400 	.inst	0x40060400 ; undefined
  1c:	00000000 	udf	#0
  20:	00022800 	.inst	0x00022800 ; undefined
	...
  2c:	08010200 	stxrb	w1, w0, [x16]
  30:	0000008b 	udf	#139
  34:	99070202 	stlur	w2, [x16, #112]
  38:	02000000 	.inst	0x02000000 ; undefined
  3c:	00e10704 	.inst	0x00e10704 ; undefined
  40:	08020000 	stxrb	w2, w0, [x0]
  44:	0000dc07 	udf	#56327
  48:	06010200 	.inst	0x06010200 ; undefined
  4c:	0000008d 	udf	#141
  50:	19050202 	stlurb	w2, [x16, #80]
  54:	03000001 	.inst	0x03000001 ; undefined
  58:	6e690504 	uhadd	v4.8h, v8.8h, v9.8h
  5c:	08020074 	stxrb	w2, w20, [x3]
  60:	00000505 	udf	#1285
  64:	010f0400 	.inst	0x010f0400 ; undefined
  68:	9c020000 	ldr	q0, 4068 <__abi_tag-0x3fc210>
  6c:	00005e1b 	udf	#24091
  70:	08010200 	stxrb	w1, w0, [x16]
  74:	00000094 	udf	#148
  78:	00011104 	.inst	0x00011104 ; undefined
  7c:	13070300 	sbfiz	w0, w24, #25, #1
  80:	00000065 	udf	#101
  84:	d7070802 	.inst	0xd7070802 ; undefined
  88:	02000000 	.inst	0x02000000 ; undefined
  8c:	00000508 	udf	#1288
  90:	74050000 	.inst	0x74050000 ; undefined
  94:	2000736d 	.inst	0x2000736d ; undefined
  98:	d4082004 	.inst	0xd4082004 ; undefined
  9c:	06000000 	.inst	0x06000000 ; undefined
  a0:	00000017 	udf	#23
  a4:	780d2204 	sturh	w4, [x16, #210]
  a8:	00000000 	udf	#0
  ac:	0000fe06 	udf	#65030
  b0:	0d230400 	.inst	0x0d230400 ; undefined
  b4:	00000078 	udf	#120
  b8:	00ac0608 	.inst	0x00ac0608 ; undefined
  bc:	25040000 	cmpge	p0.b, p0/z, z0.b, #4
  c0:	0000780d 	udf	#30733
  c4:	2f061000 	.inst	0x2f061000 ; undefined
  c8:	04000001 	add	z1.b, p0/m, z1.b, z0.b
  cc:	00780d26 	.inst	0x00780d26 ; undefined
  d0:	00180000 	.inst	0x00180000 ; undefined
  d4:	00005707 	udf	#22279
  d8:	0000e400 	udf	#58368
  dc:	00420800 	.inst	0x00420800 ; undefined
  e0:	00640000 	.inst	0x00640000 ; undefined
  e4:	0000d109 	udf	#53513
  e8:	051d0100 	mov	z0.b, p13/z, #8
  ec:	000000d4 	udf	#212
  f0:	00300309 	.inst	0x00300309 ; NYI
  f4:	00000042 	udf	#66
  f8:	45090000 	.inst	0x45090000 ; undefined
  fc:	01000000 	.inst	0x01000000 ; undefined
 100:	0057141d 	.inst	0x0057141d ; undefined
 104:	03090000 	.inst	0x03090000 ; undefined
 108:	004201c4 	.inst	0x004201c4 ; undefined
 10c:	00000000 	udf	#0
 110:	00010809 	.inst	0x00010809 ; undefined
 114:	051e0100 	mov	z0.b, p14/z, #8
 118:	00000057 	udf	#87
 11c:	01c80309 	.inst	0x01c80309 ; undefined
 120:	00000042 	udf	#66
 124:	ee0a0000 	.inst	0xee0a0000 ; undefined
 128:	01000000 	.inst	0x01000000 ; undefined
 12c:	00570159 	.inst	0x00570159 ; undefined
 130:	06f80000 	.inst	0x06f80000 ; undefined
 134:	00000040 	udf	#64
 138:	01340000 	.inst	0x01340000 ; undefined
 13c:	00000000 	udf	#0
 140:	9c010000 	ldr	q0, 2140 <__abi_tag-0x3fe138>
 144:	0000019e 	udf	#414
 148:	0000d10b 	udf	#53515
 14c:	055a0100 	mov	z0.h, p10/z, #8
 150:	0000019e 	udf	#414
 154:	0c689102 	.inst	0x0c689102 ; undefined
 158:	0000013a 	udf	#314
 15c:	57085f01 	.inst	0x57085f01 ; undefined
 160:	02000000 	.inst	0x02000000 ; undefined
 164:	f90c7c91 	str	x17, [x4, #6392]
 168:	01000000 	.inst	0x01000000 ; undefined
 16c:	00570860 	.inst	0x00570860 ; undefined
 170:	91020000 	add	x0, x0, #0x80
 174:	00540d70 	.inst	0x00540d70 ; undefined
 178:	60010000 	.inst	0x60010000 ; undefined
 17c:	0000570e 	udf	#22286
 180:	00580c00 	.inst	0x00580c00 ; undefined
 184:	60010000 	.inst	0x60010000 ; undefined
 188:	00005719 	udf	#22297
 18c:	78910200 	ldursh	x0, [x16, #-240]
 190:	0100690e 	.inst	0x0100690e ; undefined
 194:	00572060 	.inst	0x00572060 ; undefined
 198:	91020000 	add	x0, x0, #0x80
 19c:	080f0074 	stxrb	w15, w20, [x3]
 1a0:	00000057 	udf	#87
 1a4:	0000c60a 	udf	#50698
 1a8:	01440100 	.inst	0x01440100 ; undefined
 1ac:	00000057 	udf	#87
 1b0:	0040066c 	.inst	0x0040066c ; undefined
 1b4:	00000000 	udf	#0
 1b8:	0000008c 	udf	#140
 1bc:	00000000 	udf	#0
 1c0:	01f49c01 	.inst	0x01f49c01 ; undefined
 1c4:	d10b0000 	sub	x0, x0, #0x2c0
 1c8:	01000000 	.inst	0x01000000 ; undefined
 1cc:	019e0545 	.inst	0x019e0545 ; undefined
 1d0:	91020000 	add	x0, x0, #0x80
 1d4:	00580c68 	.inst	0x00580c68 ; undefined
 1d8:	4a010000 	eor	w0, w0, w1
 1dc:	00005709 	udf	#22281
 1e0:	7c910200 	.inst	0x7c910200 ; undefined
 1e4:	00012a0c 	.inst	0x00012a0c ; undefined
 1e8:	104a0100 	adr	x0, 94208 <__abi_tag-0x36c070>
 1ec:	00000057 	udf	#87
 1f0:	00789102 	.inst	0x00789102 ; undefined
 1f4:	0000210a 	udf	#8458
 1f8:	05350100 	ext	z0.b, z0.b, z8.b, #168
 1fc:	00000057 	udf	#87
 200:	00400630 	.inst	0x00400630 ; undefined
 204:	00000000 	udf	#0
 208:	0000003c 	udf	#60
 20c:	00000000 	udf	#0
 210:	02359c01 	.inst	0x02359c01 ; undefined
 214:	230c0000 	.inst	0x230c0000 ; undefined
 218:	01000001 	.inst	0x01000001 ; undefined
 21c:	00920f3b 	.inst	0x00920f3b ; undefined
 220:	91020000 	add	x0, x0, #0x80
 224:	001b0c58 	.inst	0x001b0c58 ; undefined
 228:	3c010000 	stur	b0, [x0, #16]
 22c:	00005708 	udf	#22280
 230:	7c910200 	.inst	0x7c910200 ; undefined
 234:	00c11000 	.inst	0x00c11000 ; undefined
 238:	20010000 	.inst	0x20010000 ; undefined
 23c:	00005701 	udf	#22273
 240:	40060400 	.inst	0x40060400 ; undefined
 244:	00000000 	udf	#0
 248:	00002c00 	udf	#11264
 24c:	00000000 	udf	#0
 250:	9c9c0100 	ldr	q0, fffffffffff38270 <__bss_end__+0xffffffffffb180a0>
 254:	0d000002 	st1	{v2.b}[0], [x0]
 258:	000000b7 	udf	#183
 25c:	5e0a2201 	sha1m	q1, s16, v10.4s
 260:	0d000000 	st1	{v0.b}[0], [x0]
 264:	0000000e 	udf	#14
 268:	5e152201 	sha1m	q1, s16, v21.4s
 26c:	0d000000 	st1	{v0.b}[0], [x0]
 270:	0000004a 	udf	#74
 274:	9c0a2301 	ldr	q1, 146d4 <__abi_tag-0x3ebba4>
 278:	11000002 	add	w2, w0, #0x0
 27c:	000000c6 	udf	#198
 280:	57042901 	.inst	0x57042901 ; undefined
 284:	8d000000 	.inst	0x8d000000 ; undefined
 288:	12000002 	and	w2, w0, #0x1
 28c:	00ee1300 	.inst	0x00ee1300 ; undefined
 290:	2b010000 	adds	w0, w0, w1
 294:	00005704 	udf	#22276
 298:	00001200 	udf	#4608
 29c:	27040402 	.inst	0x27040402 ; undefined
 2a0:	00000000 	udf	#0

Disassembly of section .debug_abbrev:

0000000000000000 <.debug_abbrev>:
   0:	25011101 	cmpge	p1.b, p4/z, z8.b, #1
   4:	030b130e 	.inst	0x030b130e ; undefined
   8:	110e1b0e 	add	w14, w24, #0x386
   c:	10071201 	adr	x1, e24c <__abi_tag-0x3f202c>
  10:	02000017 	.inst	0x02000017 ; undefined
  14:	0b0b0024 	add	w4, w1, w11
  18:	0e030b3e 	.inst	0x0e030b3e ; undefined
  1c:	24030000 	cmphs	p0.b, p0/z, z0.b, z3.b
  20:	3e0b0b00 	.inst	0x3e0b0b00 ; undefined
  24:	0008030b 	.inst	0x0008030b ; undefined
  28:	00160400 	.inst	0x00160400 ; undefined
  2c:	0b3a0e03 	add	w3, w16, w26, uxtb #3
  30:	0b390b3b 	add	w27, w25, w25, uxtb #2
  34:	00001349 	udf	#4937
  38:	03011305 	.inst	0x03011305 ; undefined
  3c:	3a0b0b08 	.inst	0x3a0b0b08 ; undefined
  40:	390b3b0b 	strb	w11, [x24, #718]
  44:	0013010b 	.inst	0x0013010b ; undefined
  48:	000d0600 	.inst	0x000d0600 ; undefined
  4c:	0b3a0e03 	add	w3, w16, w26, uxtb #3
  50:	0b390b3b 	add	w27, w25, w25, uxtb #2
  54:	0b381349 	add	w9, w26, w24, uxtb #4
  58:	01070000 	.inst	0x01070000 ; undefined
  5c:	01134901 	.inst	0x01134901 ; undefined
  60:	08000013 	stxrb	w0, w19, [x0]
  64:	13490021 	.inst	0x13490021 ; undefined
  68:	00000b2f 	udf	#2863
  6c:	03003409 	.inst	0x03003409 ; undefined
  70:	3b0b3a0e 	.inst	0x3b0b3a0e ; undefined
  74:	490b390b 	.inst	0x490b390b ; undefined
  78:	02193f13 	.inst	0x02193f13 ; undefined
  7c:	0a000018 	and	w24, w0, w0
  80:	193f012e 	.inst	0x193f012e ; undefined
  84:	0b3a0e03 	add	w3, w16, w26, uxtb #3
  88:	0b390b3b 	add	w27, w25, w25, uxtb #2
  8c:	01111349 	.inst	0x01111349 ; undefined
  90:	18400712 	ldr	w18, 80170 <__abi_tag-0x380108>
  94:	01194297 	.inst	0x01194297 ; undefined
  98:	0b000013 	add	w19, w0, w0
  9c:	0e030005 	tbl	v5.8b, {v0.16b}, v3.8b
  a0:	0b3b0b3a 	add	w26, w25, w27, uxtb #2
  a4:	13490b39 	.inst	0x13490b39 ; undefined
  a8:	00001802 	udf	#6146
  ac:	0300340c 	.inst	0x0300340c ; undefined
  b0:	3b0b3a0e 	.inst	0x3b0b3a0e ; undefined
  b4:	490b390b 	.inst	0x490b390b ; undefined
  b8:	00180213 	.inst	0x00180213 ; undefined
  bc:	00340d00 	.inst	0x00340d00 ; NYI
  c0:	0b3a0e03 	add	w3, w16, w26, uxtb #3
  c4:	0b390b3b 	add	w27, w25, w25, uxtb #2
  c8:	00001349 	udf	#4937
  cc:	0300340e 	.inst	0x0300340e ; undefined
  d0:	3b0b3a08 	.inst	0x3b0b3a08 ; undefined
  d4:	490b390b 	.inst	0x490b390b ; undefined
  d8:	00180213 	.inst	0x00180213 ; undefined
  dc:	000f0f00 	.inst	0x000f0f00 ; undefined
  e0:	13490b0b 	.inst	0x13490b0b ; undefined
  e4:	2e100000 	ext	v0.8b, v0.8b, v16.8b, #0
  e8:	03193f01 	.inst	0x03193f01 ; undefined
  ec:	3b0b3a0e 	.inst	0x3b0b3a0e ; undefined
  f0:	490b390b 	.inst	0x490b390b ; undefined
  f4:	12011113 	and	w19, w8, #0x8000000f
  f8:	96184007 	bl	fffffffff8610114 <__bss_end__+0xfffffffff81eff44>
  fc:	13011942 	sbfx	w2, w10, #1, #6
 100:	2e110000 	ext	v0.8b, v0.8b, v17.8b, #0
 104:	03193f01 	.inst	0x03193f01 ; undefined
 108:	3b0b3a0e 	.inst	0x3b0b3a0e ; undefined
 10c:	490b390b 	.inst	0x490b390b ; undefined
 110:	01193c13 	.inst	0x01193c13 ; undefined
 114:	12000013 	and	w19, w0, #0x1
 118:	00000018 	udf	#24
 11c:	3f012e13 	.inst	0x3f012e13 ; undefined
 120:	3a0e0319 	adcs	w25, w24, w14
 124:	390b3b0b 	strb	w11, [x24, #718]
 128:	3c13490b 	.inst	0x3c13490b ; undefined
 12c:	00000019 	udf	#25

Disassembly of section .debug_line:

0000000000000000 <.debug_line>:
   0:	0000015a 	udf	#346
   4:	007f0003 	.inst	0x007f0003 ; undefined
   8:	01040000 	.inst	0x01040000 ; undefined
   c:	000d0efb 	.inst	0x000d0efb ; undefined
  10:	01010101 	.inst	0x01010101 ; undefined
  14:	01000000 	.inst	0x01000000 ; undefined
  18:	2f010000 	.inst	0x2f010000 ; undefined
  1c:	2f727375 	fcmla	v21.4h, v27.4h, v18.h[1], #270
  20:	6c636e69 	ldnp	d9, d27, [x19, #-464]
  24:	2f656475 	.inst	0x2f656475 ; undefined
  28:	73746962 	.inst	0x73746962 ; undefined
  2c:	73752f00 	.inst	0x73752f00 ; undefined
  30:	6e692f72 	uqsub	v18.8h, v27.8h, v9.8h
  34:	64756c63 	.inst	0x64756c63 ; undefined
  38:	69622f65 	ldpsw	x5, x11, [x27, #-240]
  3c:	742f7374 	.inst	0x742f7374 ; undefined
  40:	73657079 	.inst	0x73657079 ; undefined
  44:	73752f00 	.inst	0x73752f00 ; undefined
  48:	6e692f72 	uqsub	v18.8h, v27.8h, v9.8h
  4c:	64756c63 	.inst	0x64756c63 ; undefined
  50:	79732f65 	ldrh	w5, [x27, #6550]
  54:	62000073 	.inst	0x62000073 ; undefined
  58:	74726f73 	.inst	0x74726f73 ; undefined
  5c:	2e303031 	usubw	v17.8h, v1.8h, v16.8b
  60:	00000063 	udf	#99
  64:	70797400 	adr	x0, f2ee7 <__abi_tag-0x30d391>
  68:	682e7365 	.inst	0x682e7365 ; undefined
  6c:	00000100 	udf	#256
  70:	636f6c63 	.inst	0x636f6c63 ; undefined
  74:	2e745f6b 	uqrshl	v11.4h, v27.4h, v20.4h
  78:	00020068 	.inst	0x00020068 ; undefined
  7c:	6d697400 	ldp	d0, d29, [x0, #-368]
  80:	682e7365 	.inst	0x682e7365 ; undefined
  84:	00000300 	udf	#768
  88:	00010500 	.inst	0x00010500 ; undefined
  8c:	06040209 	.inst	0x06040209 ; undefined
  90:	00000040 	udf	#64
  94:	20030000 	.inst	0x20030000 ; undefined
  98:	36040501 	tbz	w1, #0, ffffffffffff8138 <__bss_end__+0xffffffffffbd7f68>
  9c:	5101053e 	sub	w30, w9, #0x41
  a0:	25130536 	cmpgt	p6.b, p1/z, z9.b, #-13
  a4:	05201e05 	ext	z5.b, z5.b, z16.b, #7
  a8:	0a054a26 	and	w6, w17, w5, lsl #18
  ac:	01052f4a 	.inst	0x01052f4a ; undefined
  b0:	0b053621 	add	w1, w17, w5, lsl #13
  b4:	4f060532 	movi	v18.4s, #0xc9
  b8:	054b0c05 	.inst	0x054b0c05 ; undefined
  bc:	19052e01 	.inst	0x19052e01 ; undefined
  c0:	03040200 	.inst	0x03040200 ; undefined
  c4:	00210521 	.inst	0x00210521 ; NYI
  c8:	3c030402 	str	b2, [x0], #48
  cc:	02000a05 	.inst	0x02000a05 ; undefined
  d0:	054a0304 	.inst	0x054a0304 ; undefined
  d4:	0402001f 	.inst	0x0402001f ; undefined
  d8:	12054a03 	and	w3, w16, #0xf8003fff
  dc:	03040200 	.inst	0x03040200 ; undefined
  e0:	002a0520 	.inst	0x002a0520 ; NYI
  e4:	1f030402 	fmadd	s2, s0, s3, s1
  e8:	02000105 	.inst	0x02000105 ; undefined
  ec:	3e3c0104 	.inst	0x3e3c0104 ; undefined
  f0:	053c0903 	ext	z3.b, z3.b, z8.b, #226
  f4:	0b052f08 	add	w8, w24, w5, lsl #11
  f8:	2e040523 	.inst	0x2e040523 ; undefined
  fc:	05240e05 	ext	z5.b, z5.b, z16.b, #35
 100:	07052f12 	.inst	0x07052f12 ; undefined
 104:	231e052e 	.inst	0x231e052e ; undefined
 108:	053c0d05 	ext	z5.b, z5.b, z8.b, #227
 10c:	22053e13 	.inst	0x22053e13 ; undefined
 110:	660d0558 	.inst	0x660d0558 ; undefined
 114:	05301905 	ext	z5.b, z5.b, z8.b, #134
 118:	21054a12 	.inst	0x21054a12 ; undefined
 11c:	5812052f 	ldr	x15, 241c0 <__abi_tag-0x3dc0b8>
 120:	054a2105 	.inst	0x054a2105 ; undefined
 124:	1205201a 	and	w26, w0, #0xf800000f
 128:	581c0521 	ldr	x1, 381cc <__abi_tag-0x3c80ac>
 12c:	052f1405 	ext	z5.b, z5.b, z0.b, #125
 130:	2078030b 	.inst	0x2078030b ; undefined
 134:	02000705 	.inst	0x02000705 ; undefined
 138:	053a0104 	ext	z4.b, z4.b, z8.b, #208
 13c:	0a054e0d 	and	w13, w16, w5, lsl #19
 140:	05200a03 	ext	z3.b, z3.b, z16.b, #2
 144:	3c6f0303 	.inst	0x3c6f0303 ; undefined
 148:	02000405 	.inst	0x02000405 ; undefined
 14c:	053a0104 	ext	z4.b, z4.b, z8.b, #208
 150:	4a14030a 	eor	w10, w24, w20
 154:	09030105 	.inst	0x09030105 ; undefined
 158:	00030220 	.inst	0x00030220 ; undefined
 15c:	地址 0x000000000000015c 越界。


Disassembly of section .debug_str:

0000000000000000 <.debug_str>:
   0:	676e6f6c 	.inst	0x676e6f6c ; undefined
   4:	6e6f6c20 	umin	v0.8h, v1.8h, v15.8h
   8:	6e692067 	usubl2	v7.4s, v3.8h, v9.8h
   c:	74530074 	.inst	0x74530074 ; undefined
  10:	6954706f 	ldpsw	x15, x28, [x3, #160]
  14:	7400656d 	.inst	0x7400656d ; undefined
  18:	755f736d 	.inst	0x755f736d ; undefined
  1c:	656d6974 	fnmls	z20.h, p2/m, z11.h, z13.h
  20:	69747400 	ldpsw	x0, x29, [x0, #-96]
  24:	6600656d 	.inst	0x6600656d ; undefined
  28:	74616f6c 	.inst	0x74616f6c ; undefined
  2c:	6f682f00 	.inst	0x6f682f00 ; undefined
  30:	672f656d 	.inst	0x672f656d ; undefined
  34:	6a756775 	bics	w21, w27, w21, lsr #25
  38:	614d2f69 	.inst	0x614d2f69 ; undefined
  3c:	6472616c 	.inst	0x6472616c ; undefined
  40:	6e656c61 	umin	v1.8h, v3.8h, v5.8h
  44:	65655300 	fnmla	z0.h, p4/m, z24.h, z5.h
  48:	6f540064 	mla	v4.8h, v3.8h, v4.h[1]
  4c:	546c6174 	.inst	0x546c6174 ; undefined
  50:	00656d69 	.inst	0x00656d69 ; undefined
  54:	7473614c 	.inst	0x7473614c ; undefined
  58:	65646e49 	fnmls	z9.h, p3/m, z18.h, z4.h
  5c:	4e470078 	.inst	0x4e470078 ; undefined
  60:	31432055 	adds	w21, w2, #0xc8, lsl #12
  64:	30312037 	adr	x23, 62469 <__abi_tag-0x39de0f>
  68:	312e332e 	adds	w14, w25, #0xb8c
  6c:	6c6d2d20 	ldnp	d0, d11, [x9, #-304]
  70:	6c747469 	ldnp	d9, d29, [x3, #-192]
  74:	6e652d65 	uqsub	v5.8h, v11.8h, v5.8h
  78:	6e616964 	fcvtxn2	v4.4s, v11.2d
  7c:	616d2d20 	.inst	0x616d2d20 ; undefined
  80:	6c3d6962 	stnp	d2, d26, [x11, #-48]
  84:	20343670 	.inst	0x20343670 ; undefined
  88:	7500672d 	.inst	0x7500672d ; undefined
  8c:	6769736e 	.inst	0x6769736e ; undefined
  90:	2064656e 	.inst	0x2064656e ; undefined
  94:	72616863 	.inst	0x72616863 ; undefined
  98:	6f687300 	fcmla	v0.8h, v24.8h, v8.h[1], #270
  9c:	75207472 	.inst	0x75207472 ; undefined
  a0:	6769736e 	.inst	0x6769736e ; undefined
  a4:	2064656e 	.inst	0x2064656e ; undefined
  a8:	00746e69 	.inst	0x00746e69 ; undefined
  ac:	5f736d74 	.inst	0x5f736d74 ; undefined
  b0:	69747563 	ldpsw	x3, x29, [x11, #-96]
  b4:	5300656d 	ubfx	w13, w11, #0, #26
  b8:	74726174 	.inst	0x74726174 ; undefined
  bc:	656d6954 	fnmls	z20.h, p2/m, z10.h, z13.h
  c0:	69616d00 	ldpsw	x0, x27, [x8, #-248]
  c4:	6e49006e 	.inst	0x6e49006e ; undefined
  c8:	61697469 	.inst	0x61697469 ; undefined
  cc:	657a696c 	fnmls	z12.h, p2/m, z11.h, z26.h
  d0:	72724100 	.inst	0x72724100 ; undefined
  d4:	6c007961 	stnp	d1, d30, [x11]
  d8:	20676e6f 	.inst	0x20676e6f ; undefined
  dc:	676e6f6c 	.inst	0x676e6f6c ; undefined
  e0:	736e7520 	.inst	0x736e7520 ; undefined
  e4:	656e6769 	fnmls	z9.h, p1/m, z27.h, z14.h
  e8:	6e692064 	usubl2	v4.4s, v3.8h, v9.8h
  ec:	75420074 	.inst	0x75420074 ; undefined
  f0:	656c6262 	fnmls	z2.h, p0/m, z19.h, z12.h
  f4:	74726f53 	.inst	0x74726f53 ; undefined
  f8:	6d655400 	ldp	d0, d21, [x0, #-432]
  fc:	6d740070 	ldp	d16, d0, [x3, #-192]
 100:	74735f73 	.inst	0x74735f73 ; undefined
 104:	00656d69 	.inst	0x00656d69 ; undefined
 108:	74636166 	.inst	0x74636166 ; undefined
 10c:	5f00726f 	.inst	0x5f00726f ; undefined
 110:	6f6c635f 	umlsl2	v31.4s, v26.8h, v12.h[2]
 114:	745f6b63 	.inst	0x745f6b63 ; undefined
 118:	6f687300 	fcmla	v0.8h, v24.8h, v8.h[1], #270
 11c:	69207472 	stgp	x18, x29, [x3, #-1024]
 120:	6200746e 	.inst	0x6200746e ; undefined
 124:	65666675 	fnmls	z21.h, p1/m, z19.h, z6.h
 128:	61660072 	.inst	0x61660072 ; undefined
 12c:	74007463 	.inst	0x74007463 ; undefined
 130:	635f736d 	.inst	0x635f736d ; undefined
 134:	6d697473 	ldp	d19, d29, [x3, #-368]
 138:	6f530065 	mla	v5.8h, v3.8h, v3.h[1]
 13c:	64657472 	.inst	0x64657472 ; undefined
 140:	6f736200 	umlsl2	v0.4s, v16.8h, v3.h[3]
 144:	30317472 	adr	x18, 62fd1 <__abi_tag-0x39d2a7>
 148:	00632e30 	.inst	0x00632e30 ; undefined
