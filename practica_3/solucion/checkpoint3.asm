extern mult_doubles

extern mult_doubles_aux
;########### SECCION DE DATOS
section .data

;########### SECCION DE TEXTO (PROGRAMA)
section .text

;########### LISTA DE FUNCIONES EXPORTADAS
global complex_sum_z
global packed_complex_sum_z
global product_9_f

;########### DEFINICION DE FUNCIONES
;extern uint32_t complex_sum_z(complex_item *arr, uint32_t arr_length);
;registros: arr[?], arr_length[?]
complex_sum_z:
	;prologo
	push rbp 
	mov rbp,rsp
	
	mov r9, 0x0
	mov rdx, 24

	mov rcx, rsi ; carga la cantidad de iteraciones a hacer al contador de vueltas
	.cycle:     ; etiqueta a donde retorna el ciclo que itera sobre arr

        add r9, [rdi + rdx] 
        add rdx, 32	
	
    loop .cycle ; decrementa ecx y si es distinto de 0 salta a .cycle

	mov rax, r9

	;epilogo
	pop rbp
	ret

;extern uint32_t packed_complex_sum_z(packed_complex_item *arr, uint32_t arr_length);
;registros: arr[?], arr_length[?]
packed_complex_sum_z:

	;prologo
	push rbp 
	mov rbp,rsp

	mov r9, 0x0
	mov rdx, 20

	mov rcx, rsi 
	.cycle:     

	    add r9, [rdi + rdx] 

	add rdx, 24

	loop .cycle 

	mov rax, r9

	;epilogo
	pop rbp
	ret


;extern void product_9_f(uint32_t * destination
;, uint32_t x1, float f1, uint32_t x2, float f2, uint32_t x3, float f3, uint32_t x4, float f4
;, uint32_t x5, float f5, uint32_t x6, float f6, uint32_t x7, float f7, uint32_t x8, float f8
;, uint32_t x9, float f9);
;registros y pila: destination[rdi], x1[rsi], f1[?], x2[rdx], f2[?], x3[rcx], f3[?], x4[r8], f4[?]
;	, x5[r9], f5[?], x6[rbp + 10], f6[?], x7[rbp + 18], f7[?], x8[rbp + 20], f8[?],
;	, x9[rbp + 22], f9[rbp + 24]
product_9_f:
	;prologo
	push rbp
	mov rbp, rsp

	;simple float -> double
	cvtss2sd xmm0, xmm0
	cvtss2sd xmm1, xmm1
	cvtss2sd xmm2, xmm2
	cvtss2sd xmm3, xmm3
	cvtss2sd xmm4, xmm4
	cvtss2sd xmm5, xmm5
	cvtss2sd xmm6, xmm6
	cvtss2sd xmm7, xmm7

    ; multiply f1 to f8
    mulsd xmm0, xmm1
    mulsd xmm0, xmm2
    mulsd xmm0, xmm3
    mulsd xmm0, xmm4
    mulsd xmm0, xmm5
    mulsd xmm0, xmm6
    mulsd xmm0, xmm7

    ; multiply f9
    cvtss2sd xmm1, [rbp + 0x30]
    mulsd xmm0, xmm1

    ; int -> double
    cvtsi2sd xmm1, rsi
    cvtsi2sd xmm2, rdx
    cvtsi2sd xmm3, rcx
    cvtsi2sd xmm4, r8
    cvtsi2sd xmm5, r9
    cvtsi2sd xmm6, [rbp + 0x10] 
    cvtsi2sd xmm7, [rbp + 0x18]

    ; multiply x1 to x7
    mulsd xmm0, xmm1
    mulsd xmm0, xmm2
    mulsd xmm0, xmm3
    mulsd xmm0, xmm4
    mulsd xmm0, xmm5
    mulsd xmm0, xmm6
    mulsd xmm0, xmm7

    ; multiply x8 and x9
    cvtsi2sd xmm1, [rbp + 0x20]
    cvtsi2sd xmm2, [rbp + 0x28]
    mulsd xmm0, xmm1
    mulsd xmm0, xmm2
    
    ; result in xmm0 -> [rdi]
    movsd [rdi], xmm0

	; epilogo
	pop rbp
	ret
