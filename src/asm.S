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
    call hello_fortran # call fortran function
call_python:
    pop r10
    lea	rdi, [msg_from_asm + rip]
    sub rsp, 8 # 16bytes alignment
    call r10 # call python function
    add rsp, 8
    mov rax, 42
    ret
exit:
    mov rax, 1 # write
    mov rdi, 1 # stdout
    lea rsi, exit_msg[rip] # ptr of string
    mov rdx, 45 # size of char
    syscall
    mov rax, 0x3c # exit
    mov rdi, 42 # status code
    syscall
.global print_rsp
print_rsp:
    lea rdi, [p_fmt + rip]
    mov rsi, rsp
    mov eax, 0 # n_floating point
    call printf
    ret

.data
helloworld:
    .string "Hello, World! written in Assembly\n"
msg_from_asm:
    .string "Message From Assembly"
p_fmt:
    .string "%p\n\0"
exit_msg:
    .string "Exiting by x86-64 Assembly with status 42...\n"
