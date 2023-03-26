section .text
 global _start
 _start:
    mov     al,5
    add     al,3
    syscall
    
    mov     rax,60
    mov     rdi,0
    syscall
