extern malloc
extern free
extern fprintf

section .text

global strCmp
global strClone
global strDelete
global strPrint
global strLen

; ** String **

; int32_t strCmp(char* a, char* b)
; 0 si son iguales
; 1 si a < b
; -1 si a > b
strCmp:
	push rbp
	mov rbp, rsp
    
    mov rdx, [rdi]
    mov rcx, [rsi]
    
    .main:
        cmp dl, cl ; compara por byte
        jl .one 
        jg .minus_one
        je .equal

    .equal:
        cmp dx, byte 0 
        jz .zero 
        shr rdx, 8 ; "borra" el ultimo byte de rdx
        shr rcx, 8 
        jmp .main 

    .zero:
        mov rax, 0
        jmp .end

    .one: 
        mov rax, 1
        jmp .end

    .minus_one:
        mov rax, -1
        jmp .end
    
    .end:
	    pop rbp
    	ret

; char* strClone(char* a)
strClone:
    push rbp
    mov rbp, rsp
    
    push r12
    push r13

    mov r13, rdi ; guarda mensaje en la pila
    
    call strLen
    
    inc rcx
    mov r12, rcx ; guarda la longitud
    inc rax
    mov rdi, rax

    call malloc 

    mov rcx, r12

    mov rsi, r13 ; mensaje
    mov rdi, rax ; destino
    ; movsb no toma parametros, directamente agarra (r/e)si y (r/e)di
    rep movsb ; mueve un byte (char) rcx-veces y lo guarda en rdi
    
    pop r13
    pop r12
    pop rbp
	ret

; void strDelete(char* a)
strDelete:
    push rbp
    mov rbp, rsp

    call free

    pop rbp
	ret

; void strPrint(char* a, FILE* pFile)
strPrint:
    push rbp
    mov rbp, rsp

    push r12
    sub rsp, 8

    mov r12, rdi
    mov rdi, rsi
    mov rsi, r12
    
    call fprintf
    
    add rsp, 8
    pop r12
    pop rbp
	ret

; uint32_t strLen(char* a)
strLen:
	push rbp
	mov rbp, rsp
	mov rcx, 0

	.cycle:
		cmp [rdi + rcx], byte 0
		jz .end
		inc rcx
		jmp .cycle
	
	.end:
		mov rax, rcx

	pop rbp
	ret
