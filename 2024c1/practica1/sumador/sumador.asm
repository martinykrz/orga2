extern print_uint64

section	.data

section	.text
	global _start
_start:            
    xor al, al
    xor bl, bl

    mov al, 32
    mov bl, 64

    add al, bl

    mov rdi, rax
    call print_uint64

    ; exit program
    mov rax, 60
    mov rdi, 0
    syscall
