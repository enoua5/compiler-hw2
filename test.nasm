
    GLOBAL main
    extern printf

section .data
numberPrinter db "%d",0x0d,0x0a,0
flumberPrinter db "%g", 10, 0

section .text
printFloat:
    push    rbp                     ; Avoid stack alignment issues
    push    rcx
    push    rdx
    push    rsi
    push    rdi
    push    r8
    push    r9
    push    r10
    push    r11

    mov     rdi, flumberPrinter
    mov     rax, 1                  ; 1 non-int arg
    and     rsp, -16                ; align to avoid a segfault
    call    [rel printf wrt ..got]
    
    pop     r11
    pop     r10
    pop     r9
    pop     r8
    pop     rdi
    pop     rsi
    pop     rdx
    pop     rcx
    pop     rbp                     ; Avoid stack alignment issues
    ret


printInt:
    push    rbp                     ; Avoid stack alignment issues
    push    rax
    push    rcx
    push    rdx
    push    rsi
    push    rdi
    push    r8
    push    r9
    push    r10
    push    r11
    push    r12

    mov     rdi, numberPrinter      ; set printf format parameter
    mov     rsi, rax                ; set printf value paramete
    xor     rax, rax                ; set rax to 0 (number of float/vector regs used is 0)
    mov     r12, rsp                ; r12 is preserved according to ABI, so we save our rsp there
    and     rsp, -16                ; align to avoid a segfault
    call    [rel printf wrt ..got]
    mov     rsp, r12
    
    pop     r12
    pop     r11
    pop     r10
    pop     r9
    pop     r8
    pop     rdi
    pop     rsi
    pop     rdx
    pop     rcx
    pop     rax
    pop     rbp                     ; Avoid stack alignment issues
    ret
main:
	push	rbp
	mov	    rbp, rsp
    sub     rsp, 40
    jmp end_function_test
function_test:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    ; param1 
    ; param2 
    ; +
    mov rax, r11
    add rax, r12
    mov r14, rax
    ; =
    mov qword[rbp-8], r14
    ; number
    mov rcx, [rbp-8]
    ; print
    mov rax, rcx
    call printInt
    ; number
    mov rcx, [rbp-8]
    ; gift
    mov rax, rcx
    add rsp, 16
    pop rbp
    ret
    ; prepare to exit function
    add rsp, 16
    pop rbp
    ret
end_function_test:
    jmp end_function_test2
function_test2:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    ; 1
    mov rcx, 1
    ; gift
    mov rax, rcx
    add rsp, 16
    pop rbp
    ret
    ; prepare to exit function
    add rsp, 16
    pop rbp
    ret
end_function_test2:
    ; preparing to call test
    ; 1
    mov rcx, 1
    ; add as param
    mov r11, rcx
    ; 2
    mov rcx, 2
    ; add as param
    mov r12, rcx
    ; call
    push r11
    push r12
    push r13
    call function_test
    pop r13
    pop r12
    pop r11
    mov rcx, rax
    ; =
    mov qword[rbp-8], rcx
    ; value
    mov rcx, [rbp-8]
    ; print
    mov rax, rcx
    call printInt
    ; preparing to call test2
    ; call
    push r11
    push r12
    push r13
    call function_test2
    pop r13
    pop r12
    pop r11
    mov rcx, rax
    ; =
    mov qword[rbp-16], rcx
    ; value2
    mov rcx, [rbp-16]
    ; print
    mov rax, rcx
    call printInt
    ; preparing to call test
    ; preparing to call test2
    ; call
    push r11
    push r12
    push r13
    call function_test2
    pop r13
    pop r12
    pop r11
    mov rcx, rax
    ; add as param
    mov r11, rcx
    ; 1
    mov rcx, 1
    ; add as param
    mov r12, rcx
    ; call
    push r11
    push r12
    push r13
    call function_test
    pop r13
    pop r12
    pop r11
    mov rcx, rax
    ; =
    mov qword[rbp-24], rcx
    ; value3
    mov rcx, [rbp-24]
    ; print
    mov rax, rcx
    call printInt
    ; 1
    mov rcx, 1
    ; =
    mov qword[rbp-32], rcx
    ; bool
    mov rcx, [rbp-32]
    ; if
    cmp rcx, 0
    jz end_if_0
    ; 42
    mov rcx, 42
    ; print
    mov rax, rcx
    call printInt
end_if_0:
    ; bool
    mov rcx, [rbp-32]
    ; 1
    mov rbx, 1
    ; -
    mov rax, rcx
    sub rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-32], rcx
    ; bool
    mov rcx, [rbp-32]
    ; if
    cmp rcx, 0
    jz end_if_1
    ; 24
    mov rcx, 24
    ; print
    mov rax, rcx
    call printInt
end_if_1:
    ; 1
    mov rcx, 1
    ; 1
    mov rbx, 1
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; 1
    mov rbx, 1
    ; 1
    mov rsi, 1
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; 1
    mov rbx, 1
    ; 1
    mov rsi, 1
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; 1
    mov rsi, 1
    ; 1
    mov rdi, 1
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; 1
    mov rbx, 1
    ; 1
    mov rsi, 1
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; 1
    mov rsi, 1
    ; 1
    mov rdi, 1
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; 1
    mov rsi, 1
    ; 1
    mov rdi, 1
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; 1
    mov rbx, 1
    ; 1
    mov rsi, 1
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; 1
    mov rsi, 1
    ; 1
    mov rdi, 1
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; 1
    mov rsi, 1
    ; 1
    mov rdi, 1
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; 1
    mov rsi, 1
    ; 1
    mov rdi, 1
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; 1
    mov rbx, 1
    ; 1
    mov rsi, 1
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; 1
    mov rsi, 1
    ; 1
    mov rdi, 1
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; 1
    mov rsi, 1
    ; 1
    mov rdi, 1
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; 1
    mov rsi, 1
    ; 1
    mov rdi, 1
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; 1
    mov rbx, 1
    ; 1
    mov rsi, 1
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; 1
    mov rsi, 1
    ; 1
    mov rdi, 1
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; 1
    mov rsi, 1
    ; 1
    mov rdi, 1
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; 1
    mov rsi, 1
    ; 1
    mov rdi, 1
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; 1
    mov rbx, 1
    ; 1
    mov rsi, 1
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; 1
    mov rsi, 1
    ; 1
    mov rdi, 1
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; 1
    mov rsi, 1
    ; 1
    mov rdi, 1
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; 1
    mov rsi, 1
    ; 1
    mov rdi, 1
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; 1
    mov rsi, 1
    ; 1
    mov rdi, 1
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; 1
    mov rsi, 1
    ; 1
    mov rdi, 1
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; 1
    mov r10, 1
    ; 1
    mov r14, 1
    ; +
    mov rax, r10
    add rax, r14
    mov r10, rax
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; 1
    mov rbx, 1
    ; 1
    mov rsi, 1
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; 1
    mov rsi, 1
    ; 1
    mov rdi, 1
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; 1
    mov rsi, 1
    ; 1
    mov rdi, 1
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; 1
    mov rsi, 1
    ; 1
    mov rdi, 1
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; 1
    mov rsi, 1
    ; 1
    mov rdi, 1
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; 1
    mov rsi, 1
    ; 1
    mov rdi, 1
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; 1
    mov rsi, 1
    ; 1
    mov rdi, 1
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; 1
    mov rsi, 1
    ; 1
    mov rdi, 1
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; 1
    mov r10, 1
    ; 1
    mov r14, 1
    ; +
    mov rax, r10
    add rax, r14
    mov r10, rax
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; 1
    mov r10, 1
    ; 1
    mov r14, 1
    ; +
    mov rax, r10
    add rax, r14
    mov r10, rax
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; 1
    mov r10, 1
    ; 1
    mov r14, 1
    ; +
    mov rax, r10
    add rax, r14
    mov r10, rax
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; 1
    mov r10, 1
    ; 1
    mov r14, 1
    ; +
    mov rax, r10
    add rax, r14
    mov r10, rax
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; 1
    mov r10, 1
    ; 1
    mov r14, 1
    ; +
    mov rax, r10
    add rax, r14
    mov r10, rax
    ; 1
    mov r14, 1
    ; 1
    mov r15, 1
    ; +
    mov rax, r14
    add rax, r15
    mov r14, rax
    ; +
    mov rax, r10
    add rax, r14
    mov r10, rax
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; 1
    mov rbx, 1
    ; 1
    mov rsi, 1
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; 1
    mov rsi, 1
    ; 1
    mov rdi, 1
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; 1
    mov rsi, 1
    ; 1
    mov rdi, 1
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; 1
    mov rsi, 1
    ; 1
    mov rdi, 1
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; 1
    mov rsi, 1
    ; 1
    mov rdi, 1
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; 1
    mov rsi, 1
    ; 1
    mov rdi, 1
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; 1
    mov rsi, 1
    ; 1
    mov rdi, 1
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; 1
    mov rsi, 1
    ; 1
    mov rdi, 1
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; 1
    mov r10, 1
    ; 1
    mov r14, 1
    ; +
    mov rax, r10
    add rax, r14
    mov r10, rax
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; 1
    mov r10, 1
    ; 1
    mov r14, 1
    ; +
    mov rax, r10
    add rax, r14
    mov r10, rax
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; 1
    mov r10, 1
    ; 1
    mov r14, 1
    ; +
    mov rax, r10
    add rax, r14
    mov r10, rax
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; 1
    mov r10, 1
    ; 1
    mov r14, 1
    ; +
    mov rax, r10
    add rax, r14
    mov r10, rax
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; 1
    mov r10, 1
    ; 1
    mov r14, 1
    ; +
    mov rax, r10
    add rax, r14
    mov r10, rax
    ; 1
    mov r14, 1
    ; 1
    mov r15, 1
    ; +
    mov rax, r14
    add rax, r15
    mov r14, rax
    ; +
    mov rax, r10
    add rax, r14
    mov r10, rax
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; 1
    mov rsi, 1
    ; 1
    mov rdi, 1
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; 1
    mov r10, 1
    ; 1
    mov r14, 1
    ; +
    mov rax, r10
    add rax, r14
    mov r10, rax
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; 1
    mov r10, 1
    ; 1
    mov r14, 1
    ; +
    mov rax, r10
    add rax, r14
    mov r10, rax
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; 1
    mov r10, 1
    ; 1
    mov r14, 1
    ; +
    mov rax, r10
    add rax, r14
    mov r10, rax
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; 1
    mov rdi, 1
    ; 1
    mov r8, 1
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; 1
    mov r10, 1
    ; 1
    mov r14, 1
    ; +
    mov rax, r10
    add rax, r14
    mov r10, rax
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; 1
    mov r10, 1
    ; 1
    mov r14, 1
    ; +
    mov rax, r10
    add rax, r14
    mov r10, rax
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; 1
    mov r10, 1
    ; 1
    mov r14, 1
    ; +
    mov rax, r10
    add rax, r14
    mov r10, rax
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; 1
    mov r10, 1
    ; 1
    mov r14, 1
    ; +
    mov rax, r10
    add rax, r14
    mov r10, rax
    ; 1
    mov r14, 1
    ; 1
    mov r15, 1
    ; +
    mov rax, r14
    add rax, r15
    mov r14, rax
    ; +
    mov rax, r10
    add rax, r14
    mov r10, rax
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; 1
    mov r8, 1
    ; 1
    mov r9, 1
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; 1
    mov r10, 1
    ; 1
    mov r14, 1
    ; +
    mov rax, r10
    add rax, r14
    mov r10, rax
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; 1
    mov r10, 1
    ; 1
    mov r14, 1
    ; +
    mov rax, r10
    add rax, r14
    mov r10, rax
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; 1
    mov r10, 1
    ; 1
    mov r14, 1
    ; +
    mov rax, r10
    add rax, r14
    mov r10, rax
    ; 1
    mov r14, 1
    ; 1
    mov r15, 1
    ; +
    mov rax, r14
    add rax, r15
    mov r14, rax
    ; +
    mov rax, r10
    add rax, r14
    mov r10, rax
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; 1
    mov r9, 1
    ; 1
    mov r10, 1
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; 1
    mov r10, 1
    ; 1
    mov r14, 1
    ; +
    mov rax, r10
    add rax, r14
    mov r10, rax
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; 1
    mov r10, 1
    ; 1
    mov r14, 1
    ; +
    mov rax, r10
    add rax, r14
    mov r10, rax
    ; 1
    mov r14, 1
    ; 1
    mov r15, 1
    ; +
    mov rax, r14
    add rax, r15
    mov r14, rax
    ; +
    mov rax, r10
    add rax, r14
    mov r10, rax
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; 1
    mov r10, 1
    ; 1
    mov r14, 1
    ; +
    mov rax, r10
    add rax, r14
    mov r10, rax
    ; 1
    mov r14, 1
    ; 1
    mov r15, 1
    ; +
    mov rax, r14
    add rax, r15
    mov r14, rax
    ; +
    mov rax, r10
    add rax, r14
    mov r10, rax
    ; 1
    mov r14, 1
    ; 1
    mov r15, 1
    ; +
    mov rax, r14
    add rax, r15
    mov r14, rax
    ; 1
    mov r15, 1
    ; 1
    mov qword[rsp-40], 1
    ; +
    mov rax, r15
    add rax, [rsp-40]
    mov r15, rax
    ; +
    mov rax, r14
    add rax, r15
    mov r14, rax
    ; +
    mov rax, r10
    add rax, r14
    mov r10, rax
    ; +
    mov rax, r9
    add rax, r10
    mov r9, rax
    ; +
    mov rax, r8
    add rax, r9
    mov r8, rax
    ; +
    mov rax, rdi
    add rax, r8
    mov rdi, rax
    ; +
    mov rax, rsi
    add rax, rdi
    mov rsi, rax
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; print
    mov rax, rcx
    call printInt
    ; value
    mov rcx, [rbp-8]
    ; print
    mov rax, rcx
    call printInt

exit:
    add rsp, 40
    mov rax, 60
    xor rdi, rdi
    syscall
