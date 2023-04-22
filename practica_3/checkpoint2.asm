extern sumar_c
extern restar_c

extern mult_c
;########### SECCION DE DATOS
section .data

;########### SECCION DE TEXTO (PROGRAMA)
section .text

;########### LISTA DE FUNCIONES EXPORTADAS

global alternate_sum_4
global alternate_sum_4_simplified
global alternate_sum_8
global product_2_f
global alternate_sum_4_using_c

;########### DEFINICION DE FUNCIONES
; uint32_t alternate_sum_4(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4);
; registros: x1[?], x2[?], x3[?], x4[?]
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
; registros: x1[?], x2[?], x3[?], x4[?]
alternate_sum_4_simplified:

	sub rdi,rsi
	sub rdx,rcx
	add rdi,rdx
	mov rax,rdi
	ret

; uint32_t alternate_sum_8(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4, uint32_t x5, uint32_t x6, uint32_t x7, uint32_t x8);
; registros y pila: x1[?], x2[?], x3[?], x4[?], x5[?], x6[?], x7[rbp + 0x12], x8[rbp + 0x14]
alternate_sum_8:
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

	call restar_c   ;x3- x4

	add rsp, 8

	add r15, rax

	mov rdi, r8
	mov rsi, r9

	sub rsp, 8

	call restar_c  ;x5 -x6

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
;registros: destination[?], x1[?], f1[?]
product_2_f:

	push rbp 
	mov rbp,rsp

	cvtsi2ss xmm1, rsi
	
	mulss xmm0, xmm1

	cvttss2si edx, xmm0

	mov [rdi], edx

	pop rbp
	ret
