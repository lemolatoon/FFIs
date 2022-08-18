.intel_syntax noprefix

.global start
.global exit
.text
start:
    push rdi # function pointer (arg0)
    mov rax, 1 # write
    mov rdi, 1 # stdout
    mov rdx, 34 # size of char
    lea rsi, [helloworld + rip] # ptr of string
    syscall
call_c_sharp:
    sub rsp, 8 # 16bit alignment
    call hello_fortran # call fortran function
    add rsp, 8
call_python:
    pop r10
    lea	rdi, [msg_from_asm + rip]
    sub rsp, 8 # 16bit alignment
    call r10 # call python function
    add rsp, 8
    mov rax, 42
    ret
exit:
    mov rax, 0x3c # exit
    mov rdi, 42 # status code
    syscall

.data
helloworld:
    .string "Hello, World! written in Assembly\n"
msg_from_asm:
    .string "Message From Assembly"