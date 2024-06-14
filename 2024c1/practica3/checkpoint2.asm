extern sumar_c
extern restar_c
;########### SECCION DE DATOS
section .data

;########### SECCION DE TEXTO (PROGRAMA)
section .text

;########### LISTA DE FUNCIONES EXPORTADAS

global alternate_sum_4
global alternate_sum_4_simplified
global alternate_sum_8
global product_2_f
global product_9_f
global alternate_sum_4_using_c

;########### DEFINICION DE FUNCIONES
; uint32_t alternate_sum_4(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4);
; registros: x1[rdi], x2[rsi], x3[rdx], x4[rcx]
alternate_sum_4:
	;prologo
	push rbp
    mov rbp,rsp

	;recordar que si la pila estaba alineada a 16 al hacer la llamada
	;con el push de RIP como efecto del CALL queda alineada a 8
    sub rdi,rsi
    sub rdx,rcx
    add rdi,rdx
    mov rax,rdi

	;epilogo
	pop rbp
	ret

; uint32_t alternate_sum_4_using_c(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4);
; registros: x1[rdi], x2[rsi], x3[rdx], x4[rcx]
alternate_sum_4_using_c:
	;prologo
	push rbp ; alineado a 16
	mov rbp,rsp

	call restar_c

	mov rdi, rdx
	mov rsi, rcx

	mov rdx, rax

	sub rsp, 8

	call restar_c

	add rsp, 8

    mov rsi, rax
	mov rdi, rdx

	sub rsp, 8

	call sumar_c

	add rsp, 8

	;epilogo
	pop rbp
	ret

; uint32_t alternate_sum_4_simplified(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4);
; registros: x1[rdi], x2[rsi], x3[rdx], x4[rcx]
alternate_sum_4_simplified:
    sub rdi,rsi
	sub rdx,rcx
	add rdi,rdx
	mov rax,rdi
	ret

; uint32_t alternate_sum_8(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4, uint32_t x5, uint32_t x6, uint32_t x7, uint32_t x8);
; registros y pila: x1[rdi], x2[rsi], x3[rdx], x4[rcx], x5[rcx], x6[r8], x7[r9], x8[rbp]
alternate_sum_8:
	;prologo
    push rbp ; alineado a 16
	mov rbp,rsp
	push r15

    sub rsp, 8

	call restar_c   ;x1 - x2

	add rsp, 8

	mov r15, rax

	mov rdi, rdx
	mov rsi, rcx

	sub rsp, 8

	call restar_c   ;x3 - x4

	add rsp, 8

	add r15, rax

	mov rdi, r8
	mov rsi, r9

	sub rsp, 8

	call restar_c  ;x5 - x6

	add rsp, 8

	add r15, rax

	mov rdi, [rbp + 0x10]
	mov rsi, [rbp + 0x18]

	sub rsp, 8

	call restar_c   ;x7 -x8

	add rsp, 8

	add r15, rax

	mov rax, r15

	;epilogo
    pop r15
	pop rbp
	ret

; SUGERENCIA: investigar uso de instrucciones para convertir enteros a floats y viceversa
;void product_2_f(uint32_t * destination, uint32_t x1, float f1);
;registros: destination[rdi], x1[rsi], f1[xmm0]
product_2_f:
    push rbp 
	mov rbp,rsp

	cvtsi2ss xmm1, rsi
	
	mulss xmm0, xmm1

	cvttss2si edx, xmm0

	mov [rdi], edx

	pop rbp
	ret

;extern void product_9_f(uint32_t * destination
;, uint32_t x1, float f1, uint32_t x2, float f2, uint32_t x3, float f3, uint32_t x4, float f4
;, uint32_t x5, float f5, uint32_t x6, float f6, uint32_t x7, float f7, uint32_t x8, float f8
;, uint32_t x9, float f9);
;registros y pila: destination[rdi], x1[rsi], f1[xmm0], x2[rdx], f2[xmm1], x3[rcx], f3[xmm2], x4[r8], f4[xmm3]
;	, x5[r9], f5[xmm4], x6[rbp+0x10], f6[xmm5], x7[rbp+0x18], f7[xmm6], x8[rbp+0x20], f8[xmm7],
;	, x9[rbp+0x28], f9[rbp+0x30]
product_9_f:
	;prologo
	push rbp
	mov rbp, rsp

    pxor xmm8, xmm8

	;convertimos los flotantes de cada registro xmm en doubles
    cvtps2pd xmm0, xmm0
    cvtps2pd xmm1, xmm1
    cvtps2pd xmm2, xmm2
    cvtps2pd xmm3, xmm3
    cvtps2pd xmm4, xmm4
    cvtps2pd xmm5, xmm5
    cvtps2pd xmm6, xmm6
    cvtps2pd xmm7, xmm7
    cvtps2pd xmm8, [rbp + 0x30]

	;multiplicamos los doubles en xmm0 <- xmm0 * xmm1, xmmo * xmm2 , ...
	mulpd xmm0, xmm1
	mulpd xmm0, xmm2
	mulpd xmm0, xmm3
	mulpd xmm0, xmm4
	mulpd xmm0, xmm5
	mulpd xmm0, xmm6
	mulpd xmm0, xmm7
	mulpd xmm0, xmm8

    ; limpiamos los xmm 
    pxor xmm1, xmm1
    pxor xmm2, xmm2
    pxor xmm3, xmm3
    pxor xmm4, xmm4
    pxor xmm5, xmm5
    pxor xmm6, xmm6
    pxor xmm7, xmm7
    pxor xmm8, xmm8
    pxor xmm9, xmm9
	
    ; convertimos los enteros en doubles y los multiplicamos por xmm0.
    cvtsi2sd xmm1, rsi
    cvtsi2sd xmm2, rdx
    cvtsi2sd xmm3, rcx
    cvtsi2sd xmm4, r8
    cvtsi2sd xmm5, r9
    cvtsi2sd xmm6, [rbp + 0x10]
    cvtsi2sd xmm7, [rbp + 0x18]
    cvtsi2sd xmm8, [rbp + 0x20]
    cvtsi2sd xmm9, [rbp + 0x28]

    mulpd xmm0, xmm1
	mulpd xmm0, xmm2
	mulpd xmm0, xmm3
	mulpd xmm0, xmm4
	mulpd xmm0, xmm5
	mulpd xmm0, xmm6
	mulpd xmm0, xmm7
	mulpd xmm0, xmm8
	mulpd xmm0, xmm9

    ;respuesta en destination
    movlpd [rdi], xmm0

    ; epilogo
	pop rbp
	ret
