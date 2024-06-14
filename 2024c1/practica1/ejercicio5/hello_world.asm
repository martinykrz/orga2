section .data
 hello: db "Hello, World!", 0xa ;string to print
 helloLen: equ $ - hello ;length of string ($ means the current location)
 martin: db "Martin Yaciuk Rodriguez, 26/20", 0xa
 martinLen: equ $ - martin
 ;TODO More names

section .text
 global _start ;start in _start
 _start:
    mov     rax,1 ;sys_write
    mov     rdi,1 ;stdout
    mov     rsi,hello ;message to write
    mov     rdx,helloLen ;message length
    syscall ;call kernel
    
    ; Martin print
    mov rax, 1
    mov rdi, 1
    mov rsi, martin
    mov rdx, martinLen
    syscall 

    ;end program
    mov     rax,60 ;sys_exit
    mov     rdi,0 ;error code 0 (success)
    syscall
