extern malloc
extern free
extern fprintf

section .data
format db "%s", 0
null db "NULL", 10
hello db "Hello", 10

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
    
    push rdi ; guarda mensaje en la pila
    
    sub rsp, 8
    call strLen
    add rsp, 8
    
    inc rcx
    push rcx ; guarda la longitud
    inc rax
    mov rdi, rax

    sub rsp, 8
    call malloc 
    add rsp, 8

    pop rcx
    pop rdi

    mov rsi, rdi ; mensaje
    mov rdi, rax ; destino
    ; movsb no toma parametros, directamente agarra (r/e)si y (r/e)di
    rep movsb ; mueve un byte (char) rcx-veces y lo guarda en rdi
    
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
    ; SIGFAULT, dont'know why
    push rbp
    mov rbp, rsp

    push rdi
    push rsi

    mov rdi, rsi
    cmp [rsp + 0x8], byte 0
    je .null
    mov rsi, [rsp + 0x8]
    mov rdx, hello
    jmp .main
    
    .null:
        mov rsi, format
        mov rdx, null

    .main:
        sub rsp, 8
        call fprintf 
        add rsp, 8

    pop rsi
    pop rdi

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
