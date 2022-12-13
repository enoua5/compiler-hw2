
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
    sub     rsp, 1000 ; TODO replace with calculated value
    ; 2
    mov rcx, 2
    ; =
    mov qword[rbp-8], rcx
    ; var1
    mov rcx, [rbp-8]
    ; print
    mov rax, rcx
    call printInt
    ; var1
    mov rcx, [rbp-8]
    ; var1
    mov rbx, [rbp-8]
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-16], rcx
    ; var2
    mov rcx, [rbp-16]
    ; print
    mov rax, rcx
    call printInt
    ; var1
    mov rcx, [rbp-8]
    ; var2
    mov rbx, [rbp-16]
    ; *
    mov rax, rcx
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rcx, rax
    ; =
    mov qword[rbp-24], rcx
    ; var3
    mov rcx, [rbp-24]
    ; print
    mov rax, rcx
    call printInt
    ; var3
    mov rcx, [rbp-24]
    ; var2
    mov rbx, [rbp-16]
    ; -
    mov rax, rcx
    sub rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-32], rcx
    ; var4
    mov rcx, [rbp-32]
    ; print
    mov rax, rcx
    call printInt
    ; var4
    mov rcx, [rbp-32]
    ; var3
    mov rbx, [rbp-24]
    ; /
    mov rax, rcx
    mov rdx, 0
    idiv rbx
    mov rcx, rax
    ; =
    mov qword[rbp-40], rcx
    ; var5
    mov rcx, [rbp-40]
    ; print
    mov rax, rcx
    call printInt
    ; var1
    mov rcx, [rbp-8]
    ; var2
    mov rbx, [rbp-16]
    ; var3
    mov rsi, [rbp-24]
    ; *
    mov rax, rbx
    mov edx, eax
    mov rax, rsi
    imul eax, edx
    mov rbx, rax
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-48], rcx
    ; var6
    mov rcx, [rbp-48]
    ; print
    mov rax, rcx
    call printInt
    ; var4
    mov rcx, [rbp-32]
    ; var1
    mov rbx, [rbp-8]
    ; -
    mov rax, rcx
    sub rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-56], rcx
    ; var7
    mov rcx, [rbp-56]
    ; print
    mov rax, rcx
    call printInt
    ; 3
    mov rcx, 3
    ; 4
    mov rbx, 4
    ; *
    mov rax, rcx
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rcx, rax
    ; =
    mov qword[rbp-64], rcx
    ; var8
    mov rcx, [rbp-64]
    ; print
    mov rax, rcx
    call printInt
    ; 12
    mov rcx, 12
    ; 6
    mov rbx, 6
    ; /
    mov rax, rcx
    mov rdx, 0
    idiv rbx
    mov rcx, rax
    ; =
    mov qword[rbp-72], rcx
    ; var9
    mov rcx, [rbp-72]
    ; print
    mov rax, rcx
    call printInt
    ; 12
    mov rcx, 12
    ; 6
    mov rbx, 6
    ; /
    mov rax, rcx
    mov rdx, 0
    idiv rbx
    mov rcx, rax
    ; =
    mov qword[rbp-80], rcx
    ; var10
    mov rcx, [rbp-80]
    ; print
    mov rax, rcx
    call printInt
    ; 5
    mov rcx, 5
    ; 4
    mov rbx, 4
    ; 3
    mov rsi, 3
    ; *
    mov rax, rbx
    mov edx, eax
    mov rax, rsi
    imul eax, edx
    mov rbx, rax
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-88], rcx
    ; var11
    mov rcx, [rbp-88]
    ; print
    mov rax, rcx
    call printInt
    ; 12
    mov rcx, 12
    ; 34
    mov rbx, 34
    ; 45
    mov rsi, 45
    ; *
    mov rax, rbx
    mov edx, eax
    mov rax, rsi
    imul eax, edx
    mov rbx, rax
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-96], rcx
    ; var12
    mov rcx, [rbp-96]
    ; print
    mov rax, rcx
    call printInt
    ; 6
    mov rcx, 6
    ; 5
    mov rbx, 5
    ; /
    mov rax, rcx
    mov rdx, 0
    idiv rbx
    mov rcx, rax
    ; =
    mov qword[rbp-104], rcx
    ; var13
    mov rcx, [rbp-104]
    ; print
    mov rax, rcx
    call printInt
    ; 2
    mov rcx, 2
    ; 2
    mov rbx, 2
    ; *
    mov rax, rcx
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rcx, rax
    ; 5
    mov rbx, 5
    ; 5
    mov rsi, 5
    ; *
    mov rax, rbx
    mov edx, eax
    mov rax, rsi
    imul eax, edx
    mov rbx, rax
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-112], rcx
    ; var14
    mov rcx, [rbp-112]
    ; print
    mov rax, rcx
    call printInt
    ; 42
    mov rcx, 42
    ; =
    mov qword[rbp-120], rcx
    ; var15
    mov rcx, [rbp-120]
    ; print
    mov rax, rcx
    call printInt
    ; 42
    mov rcx, 42
    ; =
    mov qword[rbp-128], rcx
    ; var16
    mov rcx, [rbp-128]
    ; print
    mov rax, rcx
    call printInt
    ; 42
    mov rcx, 42
    ; =
    mov qword[rbp-136], rcx
    ; var17
    mov rcx, [rbp-136]
    ; print
    mov rax, rcx
    call printInt
    ; 42
    mov rcx, 42
    ; =
    mov qword[rbp-144], rcx
    ; var18
    mov rcx, [rbp-144]
    ; print
    mov rax, rcx
    call printInt
    ; var1
    mov rcx, [rbp-8]
    ; =
    mov qword[rbp-152], rcx
    ; var19
    mov rcx, [rbp-152]
    ; print
    mov rax, rcx
    call printInt
    ; var1
    mov rcx, [rbp-8]
    ; var19
    mov rbx, [rbp-152]
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-160], rcx
    ; var20
    mov rcx, [rbp-160]
    ; print
    mov rax, rcx
    call printInt
    ; var1
    mov rcx, [rbp-8]
    ; var2
    mov rbx, [rbp-16]
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-168], rcx
    ; var21
    mov rcx, [rbp-168]
    ; print
    mov rax, rcx
    call printInt
    ; var9
    mov rcx, [rbp-72]
    ; var10
    mov rbx, [rbp-80]
    ; *
    mov rax, rcx
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rcx, rax
    ; =
    mov qword[rbp-176], rcx
    ; var22
    mov rcx, [rbp-176]
    ; print
    mov rax, rcx
    call printInt
    ; var1
    mov rcx, [rbp-8]
    ; var2
    mov rbx, [rbp-16]
    ; var3
    mov rsi, [rbp-24]
    ; *
    mov rax, rbx
    mov edx, eax
    mov rax, rsi
    imul eax, edx
    mov rbx, rax
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-184], rcx
    ; var23
    mov rcx, [rbp-184]
    ; print
    mov rax, rcx
    call printInt
    ; var19
    mov rcx, [rbp-152]
    ; var20
    mov rbx, [rbp-160]
    ; -
    mov rax, rcx
    sub rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-192], rcx
    ; var24
    mov rcx, [rbp-192]
    ; print
    mov rax, rcx
    call printInt
    ; 1234
    mov rcx, 1234
    ; 5678
    mov rbx, 5678
    ; *
    mov rax, rcx
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rcx, rax
    ; =
    mov qword[rbp-200], rcx
    ; var25
    mov rcx, [rbp-200]
    ; print
    mov rax, rcx
    call printInt
    ; 100000
    mov rcx, 100000
    ; var13
    mov rbx, [rbp-104]
    ; /
    mov rax, rcx
    mov rdx, 0
    idiv rbx
    mov rcx, rax
    ; =
    mov qword[rbp-208], rcx
    ; var26
    mov rcx, [rbp-208]
    ; print
    mov rax, rcx
    call printInt
    ; 12
    mov rcx, 12
    ; 8
    mov rbx, 8
    ; -
    mov rax, rcx
    sub rax, rbx
    mov rcx, rax
    ; 3
    mov rbx, 3
    ; -
    mov rax, rcx
    sub rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-216], rcx
    ; var27
    mov rcx, [rbp-216]
    ; print
    mov rax, rcx
    call printInt
    ; 5
    mov rcx, 5
    ; 8
    mov rbx, 8
    ; 4
    mov rsi, 4
    ; /
    mov rax, rbx
    mov rdx, 0
    idiv rsi
    mov rbx, rax
    ; *
    mov rax, rcx
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rcx, rax
    ; =
    mov qword[rbp-224], rcx
    ; var28
    mov rcx, [rbp-224]
    ; print
    mov rax, rcx
    call printInt
    ; 1
    mov rcx, 1
    ; 2
    mov rbx, 2
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; 3
    mov rbx, 3
    ; *
    mov rax, rcx
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rcx, rax
    ; =
    mov qword[rbp-232], rcx
    ; var29
    mov rcx, [rbp-232]
    ; print
    mov rax, rcx
    call printInt
    ; var1
    mov rcx, [rbp-8]
    ; var2
    mov rbx, [rbp-16]
    ; /
    mov rax, rcx
    mov rdx, 0
    idiv rbx
    mov rcx, rax
    ; var3
    mov rbx, [rbp-24]
    ; var4
    mov rsi, [rbp-32]
    ; *
    mov rax, rbx
    mov edx, eax
    mov rax, rsi
    imul eax, edx
    mov rbx, rax
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-240], rcx
    ; var30
    mov rcx, [rbp-240]
    ; print
    mov rax, rcx
    call printInt
    ; 1
    mov rcx, 1
    ; =
    mov qword[rbp-248], rcx
    ; 2
    mov rcx, 2
    ; =
    mov qword[rbp-256], rcx
    ; 2
    mov rcx, 2
    ; =
    mov qword[rbp-264], rcx
    ; 3
    mov rcx, 3
    ; =
    mov qword[rbp-272], rcx
    ; a_
    mov rcx, [rbp-256]
    ; =
    mov qword[rbp-280], rcx
    ; var31
    mov rcx, [rbp-280]
    ; print
    mov rax, rcx
    call printInt
    ; a_
    mov rcx, [rbp-256]
    ; =
    mov qword[rbp-288], rcx
    ; var32
    mov rcx, [rbp-288]
    ; print
    mov rax, rcx
    call printInt
    ; v_____2
    mov rcx, [rbp-264]
    ; v__3__
    mov rbx, [rbp-272]
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-296], rcx
    ; var33
    mov rcx, [rbp-296]
    ; print
    mov rax, rcx
    call printInt
    ; 300
    mov rcx, 300
    ; var1
    mov rbx, [rbp-8]
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-304], rcx
    ; var34
    mov rcx, [rbp-304]
    ; print
    mov rax, rcx
    call printInt
    ; var33
    mov rcx, [rbp-296]
    ; var2
    mov rbx, [rbp-16]
    ; -
    mov rax, rcx
    sub rax, rbx
    mov rcx, rax
    ; 18
    mov rbx, 18
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-312], rcx
    ; var35
    mov rcx, [rbp-312]
    ; print
    mov rax, rcx
    call printInt
    ; 9
    mov rcx, 9
    ; 2
    mov rbx, 2
    ; 110
    mov rsi, 110
    ; 30
    mov rdi, 30
    ; 2
    mov r8, 2
    ; /
    mov rax, rdi
    mov rdx, 0
    idiv r8
    mov rdi, rax
    ; -
    mov rax, rsi
    sub rax, rdi
    mov rsi, rax
    ; *
    mov rax, rbx
    mov edx, eax
    mov rax, rsi
    imul eax, edx
    mov rbx, rax
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; 8
    mov rbx, 8
    ; *
    mov rax, rcx
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rcx, rax
    ; 1000
    mov rbx, 1000
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; 2
    mov rbx, 2
    ; /
    mov rax, rcx
    mov rdx, 0
    idiv rbx
    mov rcx, rax
    ; 3
    mov rbx, 3
    ; 3
    mov rsi, 3
    ; *
    mov rax, rbx
    mov edx, eax
    mov rax, rsi
    imul eax, edx
    mov rbx, rax
    ; 3
    mov rsi, 3
    ; *
    mov rax, rbx
    mov edx, eax
    mov rax, rsi
    imul eax, edx
    mov rbx, rax
    ; 3
    mov rsi, 3
    ; *
    mov rax, rbx
    mov edx, eax
    mov rax, rsi
    imul eax, edx
    mov rbx, rax
    ; 1
    mov rsi, 1
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; 2
    mov rsi, 2
    ; /
    mov rax, rbx
    mov rdx, 0
    idiv rsi
    mov rbx, rax
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-320], rcx
    ; var36
    mov rcx, [rbp-320]
    ; print
    mov rax, rcx
    call printInt
    ; 2
    mov rcx, 2
    ; 3
    mov rbx, 3
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-328], rcx
    ; var37
    mov rcx, [rbp-328]
    ; print
    mov rax, rcx
    call printInt
    ; var1
    mov rcx, [rbp-8]
    ; var2
    mov rbx, [rbp-16]
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-336], rcx
    ; var38
    mov rcx, [rbp-336]
    ; print
    mov rax, rcx
    call printInt
    ; 42
    mov rcx, 42
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rcx
    imul eax, edx
    mov rcx, rax
    ; =
    mov qword[rbp-344], rcx
    ; var39
    mov rcx, [rbp-344]
    ; print
    mov rax, rcx
    call printInt
    ; 42
    mov rcx, 42
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rcx
    imul eax, edx
    mov rcx, rax
    ; =
    mov qword[rbp-352], rcx
    ; var40
    mov rcx, [rbp-352]
    ; print
    mov rax, rcx
    call printInt
    ; 42
    mov rcx, 42
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rcx
    imul eax, edx
    mov rcx, rax
    ; =
    mov qword[rbp-360], rcx
    ; var41
    mov rcx, [rbp-360]
    ; print
    mov rax, rcx
    call printInt
    ; var1
    mov rcx, [rbp-8]
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rcx
    imul eax, edx
    mov rcx, rax
    ; =
    mov qword[rbp-368], rcx
    ; var42
    mov rcx, [rbp-368]
    ; print
    mov rax, rcx
    call printInt
    ; 2
    mov rcx, 2
    ; 3
    mov rbx, 3
    ; -
    mov rax, rcx
    sub rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-376], rcx
    ; var44
    mov rcx, [rbp-376]
    ; print
    mov rax, rcx
    call printInt
    ; 2
    mov rcx, 2
    ; 3
    mov rbx, 3
    ; -
    mov rax, rcx
    sub rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-384], rcx
    ; var45
    mov rcx, [rbp-384]
    ; print
    mov rax, rcx
    call printInt
    ; 2
    mov rcx, 2
    ; 3
    mov rbx, 3
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rbx, rax
    ; -
    mov rax, rcx
    sub rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-392], rcx
    ; var46
    mov rcx, [rbp-392]
    ; print
    mov rax, rcx
    call printInt
    ; 2
    mov rcx, 2
    ; 3
    mov rbx, 3
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rbx, rax
    ; -
    mov rax, rcx
    sub rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-400], rcx
    ; var47
    mov rcx, [rbp-400]
    ; print
    mov rax, rcx
    call printInt
    ; 2
    mov rcx, 2
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rcx
    imul eax, edx
    mov rcx, rax
    ; 3
    mov rbx, 3
    ; -
    mov rax, rcx
    sub rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-408], rcx
    ; var48
    mov rcx, [rbp-408]
    ; print
    mov rax, rcx
    call printInt
    ; 2
    mov rcx, 2
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rcx
    imul eax, edx
    mov rcx, rax
    ; 3
    mov rbx, 3
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rbx, rax
    ; -
    mov rax, rcx
    sub rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-416], rcx
    ; var49
    mov rcx, [rbp-416]
    ; print
    mov rax, rcx
    call printInt
    ; 2
    mov rcx, 2
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rcx
    imul eax, edx
    mov rcx, rax
    ; 3
    mov rbx, 3
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rbx, rax
    ; -
    mov rax, rcx
    sub rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-424], rcx
    ; var50
    mov rcx, [rbp-424]
    ; print
    mov rax, rcx
    call printInt
    ; 2
    mov rcx, 2
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rcx
    imul eax, edx
    mov rcx, rax
    ; 3
    mov rbx, 3
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rbx, rax
    ; -
    mov rax, rcx
    sub rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-432], rcx
    ; var51
    mov rcx, [rbp-432]
    ; print
    mov rax, rcx
    call printInt
    ; 2
    mov rcx, 2
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rcx
    imul eax, edx
    mov rcx, rax
    ; 3
    mov rbx, 3
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rbx, rax
    ; -
    mov rax, rcx
    sub rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-440], rcx
    ; var52
    mov rcx, [rbp-440]
    ; print
    mov rax, rcx
    call printInt
    ; 2
    mov rcx, 2
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rcx
    imul eax, edx
    mov rcx, rax
    ; 3
    mov rbx, 3
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rbx, rax
    ; -
    mov rax, rcx
    sub rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-448], rcx
    ; var53
    mov rcx, [rbp-448]
    ; print
    mov rax, rcx
    call printInt
    ; 2
    mov rcx, 2
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rcx
    imul eax, edx
    mov rcx, rax
    ; 3
    mov rbx, 3
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rbx, rax
    ; -
    mov rax, rcx
    sub rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-456], rcx
    ; var54
    mov rcx, [rbp-456]
    ; print
    mov rax, rcx
    call printInt
    ; 2
    mov rcx, 2
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rcx
    imul eax, edx
    mov rcx, rax
    ; 3
    mov rbx, 3
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rbx, rax
    ; -
    mov rax, rcx
    sub rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-464], rcx
    ; var55
    mov rcx, [rbp-464]
    ; print
    mov rax, rcx
    call printInt
    ; 2
    mov rcx, 2
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rcx
    imul eax, edx
    mov rcx, rax
    ; 3
    mov rbx, 3
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rbx, rax
    ; 4
    mov rsi, 4
    ; -
    mov rax, rbx
    sub rax, rsi
    mov rbx, rax
    ; -
    mov rax, rcx
    sub rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-472], rcx
    ; var56
    mov rcx, [rbp-472]
    ; print
    mov rax, rcx
    call printInt
    ; 2
    mov rcx, 2
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rcx
    imul eax, edx
    mov rcx, rax
    ; 3
    mov rbx, 3
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rbx, rax
    ; 4
    mov rsi, 4
    ; -
    mov rax, rbx
    sub rax, rsi
    mov rbx, rax
    ; -
    mov rax, rcx
    sub rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-480], rcx
    ; var57
    mov rcx, [rbp-480]
    ; print
    mov rax, rcx
    call printInt
    ; 2
    mov rcx, 2
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rcx
    imul eax, edx
    mov rcx, rax
    ; 3
    mov rbx, 3
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rbx, rax
    ; 4
    mov rsi, 4
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rsi
    imul eax, edx
    mov rsi, rax
    ; -
    mov rax, rbx
    sub rax, rsi
    mov rbx, rax
    ; -
    mov rax, rcx
    sub rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-488], rcx
    ; var58
    mov rcx, [rbp-488]
    ; print
    mov rax, rcx
    call printInt
    ; 2
    mov rcx, 2
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rcx
    imul eax, edx
    mov rcx, rax
    ; 2
    mov rbx, 2
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rbx, rax
    ; 2
    mov rsi, 2
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rsi
    imul eax, edx
    mov rsi, rax
    ; 2
    mov rdi, 2
    ; -
    mov rax, rsi
    sub rax, rdi
    mov rsi, rax
    ; -
    mov rax, rbx
    sub rax, rsi
    mov rbx, rax
    ; -
    mov rax, rcx
    sub rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-496], rcx
    ; var59
    mov rcx, [rbp-496]
    ; print
    mov rax, rcx
    call printInt
    ; 2
    mov rcx, 2
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rcx
    imul eax, edx
    mov rcx, rax
    ; 2
    mov rbx, 2
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rbx, rax
    ; 2
    mov rsi, 2
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rsi
    imul eax, edx
    mov rsi, rax
    ; 2
    mov rdi, 2
    ; -
    mov rax, rsi
    sub rax, rdi
    mov rsi, rax
    ; -
    mov rax, rbx
    sub rax, rsi
    mov rbx, rax
    ; -
    mov rax, rcx
    sub rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-504], rcx
    ; var60
    mov rcx, [rbp-504]
    ; print
    mov rax, rcx
    call printInt
    ; 11
    mov rcx, 11
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rcx
    imul eax, edx
    mov rcx, rax
    ; 22
    mov rbx, 22
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rbx, rax
    ; 33
    mov rsi, 33
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rsi
    imul eax, edx
    mov rsi, rax
    ; 44
    mov rdi, 44
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rdi
    imul eax, edx
    mov rdi, rax
    ; 55
    mov r8, 55
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, r8
    imul eax, edx
    mov r8, rax
    ; 66
    mov r9, 66
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, r9
    imul eax, edx
    mov r9, rax
    ; -
    mov rax, r8
    sub rax, r9
    mov r8, rax
    ; -
    mov rax, rdi
    sub rax, r8
    mov rdi, rax
    ; -
    mov rax, rsi
    sub rax, rdi
    mov rsi, rax
    ; -
    mov rax, rbx
    sub rax, rsi
    mov rbx, rax
    ; -
    mov rax, rcx
    sub rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-512], rcx
    ; var61
    mov rcx, [rbp-512]
    ; print
    mov rax, rcx
    call printInt
    ; 2
    mov rcx, 2
    ; 3
    mov rbx, 3
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rbx, rax
    ; -
    mov rax, rcx
    sub rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-520], rcx
    ; var62
    mov rcx, [rbp-520]
    ; print
    mov rax, rcx
    call printInt
    ; 2
    mov rcx, 2
    ; 3
    mov rbx, 3
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rbx, rax
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-528], rcx
    ; var63
    mov rcx, [rbp-528]
    ; print
    mov rax, rcx
    call printInt
    ; 184
    mov rcx, 184
    ; 84
    mov rbx, 84
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rbx, rax
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-536], rcx
    ; var64
    mov rcx, [rbp-536]
    ; print
    mov rax, rcx
    call printInt
    ; 2
    mov rcx, 2
    ; a
    mov rbx, [rbp-248]
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rbx, rax
    ; -
    mov rax, rcx
    sub rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-544], rcx
    ; var65
    mov rcx, [rbp-544]
    ; print
    mov rax, rcx
    call printInt
    ; 2
    mov rcx, 2
    ; a
    mov rbx, [rbp-248]
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rbx, rax
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-552], rcx
    ; var66
    mov rcx, [rbp-552]
    ; print
    mov rax, rcx
    call printInt
    ; 2
    mov rcx, 2
    ; 4
    mov rbx, 4
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rbx, rax
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-560], rcx
    ; var67
    mov rcx, [rbp-560]
    ; print
    mov rax, rcx
    call printInt
    ; 2
    mov rcx, 2
    ; 4
    mov rbx, 4
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rbx, rax
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-568], rcx
    ; var68
    mov rcx, [rbp-568]
    ; print
    mov rax, rcx
    call printInt
    ; 2
    mov rcx, 2
    ; 4
    mov rbx, 4
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rbx, rax
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-576], rcx
    ; var69
    mov rcx, [rbp-576]
    ; print
    mov rax, rcx
    call printInt
    ; 4
    mov rcx, 4
    ; 3
    mov rbx, 3
    ; *
    mov rax, rcx
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rcx, rax
    ; 2
    mov rbx, 2
    ; /
    mov rax, rcx
    mov rdx, 0
    idiv rbx
    mov rcx, rax
    ; 1
    mov rbx, 1
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-584], rcx
    ; var70
    mov rcx, [rbp-584]
    ; print
    mov rax, rcx
    call printInt
    ; 4
    mov rcx, 4
    ; =
    mov qword[rbp-592], rcx
    ; 3
    mov rcx, 3
    ; =
    mov qword[rbp-600], rcx
    ; 2
    mov rcx, 2
    ; =
    mov qword[rbp-608], rcx
    ; 1
    mov rcx, 1
    ; =
    mov qword[rbp-616], rcx
    ; four
    mov rcx, [rbp-592]
    ; three
    mov rbx, [rbp-600]
    ; *
    mov rax, rcx
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rcx, rax
    ; two
    mov rbx, [rbp-608]
    ; /
    mov rax, rcx
    mov rdx, 0
    idiv rbx
    mov rcx, rax
    ; one
    mov rbx, [rbp-616]
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-624], rcx
    ; var71
    mov rcx, [rbp-624]
    ; print
    mov rax, rcx
    call printInt
    ; 4
    mov rcx, 4
    ; 3
    mov rbx, 3
    ; *
    mov rax, rcx
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rcx, rax
    ; 2
    mov rbx, 2
    ; /
    mov rax, rcx
    mov rdx, 0
    idiv rbx
    mov rcx, rax
    ; one
    mov rbx, [rbp-616]
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-632], rcx
    ; var72
    mov rcx, [rbp-632]
    ; print
    mov rax, rcx
    call printInt
    ; 2
    mov rcx, 2
    ; 3
    mov rbx, 3
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; 4
    mov rbx, 4
    ; *
    mov rax, rcx
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rcx, rax
    ; 7
    mov rbx, 7
    ; 8
    mov rsi, 8
    ; 2
    mov rdi, 2
    ; /
    mov rax, rsi
    mov rdx, 0
    idiv rdi
    mov rsi, rax
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-640], rcx
    ; var73
    mov rcx, [rbp-640]
    ; print
    mov rax, rcx
    call printInt
    ; 2
    mov rcx, 2
    ; 3
    mov rbx, 3
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; 4
    mov rbx, 4
    ; *
    mov rax, rcx
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rcx, rax
    ; 7
    mov rbx, 7
    ; var1
    mov rsi, [rbp-8]
    ; 2
    mov rdi, 2
    ; /
    mov rax, rsi
    mov rdx, 0
    idiv rdi
    mov rsi, rax
    ; +
    mov rax, rbx
    add rax, rsi
    mov rbx, rax
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-648], rcx
    ; var74
    mov rcx, [rbp-648]
    ; print
    mov rax, rcx
    call printInt
    ; var75
    mov rcx, [rbp-656]
    ; 1234
    mov rcx, 1234
    ; =
    mov qword[rbp-656], rcx
    ; var75
    mov rcx, [rbp-656]
    ; print
    mov rax, rcx
    call printInt
    ; 314
    mov rcx, 314
    ; =
    mov qword[rbp-664], rcx
    ; var76
    mov rcx, [rbp-664]
    ; print
    mov rax, rcx
    call printInt
    ; 1
    mov rcx, 1
    ; =
    mov qword[rbp-672], rcx
    ; varIf1
    mov rcx, [rbp-672]
    ; if
    cmp rcx, 0
    jz end_if_0
    ; varIf1
    mov rcx, [rbp-672]
    ; print
    mov rax, rcx
    call printInt
end_if_0:
    ; 0
    mov rcx, 0
    ; =
    mov qword[rbp-680], rcx
    ; varIf2
    mov rcx, [rbp-680]
    ; if
    cmp rcx, 0
    jz end_if_1
    ; varIf2
    mov rcx, [rbp-680]
    ; print
    mov rax, rcx
    call printInt
end_if_1:
    ; 1
    mov rcx, 1
    ; =
    mov qword[rbp-688], rcx
    ; varScope
    mov rcx, [rbp-688]
    ; if
    cmp rcx, 0
    jz end_if_2
    ; varScope
    mov rcx, [rbp-688]
    ; print
    mov rax, rcx
    call printInt
end_if_2:
    ; varScope
    mov rcx, [rbp-688]
    ; print
    mov rax, rcx
    call printInt
    jmp end_function_myFunction
function_myFunction:
    push rbp
    mov rbp, rsp
    sub rsp, 1000 ; TODO replace with calculated value
    ; 1234
    mov rcx, 1234
    ; =
    mov qword[rbp-8], rcx
    ; func1
    mov rcx, [rbp-8]
    ; gift
    mov rax, rcx
    add rsp, 1000 ; TODO replace with calculated value
    pop rbp
    ret
    ; prepare to exit function
    add rsp, 1000 ; TODO replace with calculated value
    pop rbp
    ret
end_function_myFunction:
    ; 0
    mov rcx, 0
    ; =
    mov qword[rbp-696], rcx
    ; preparing to call myFunction
    ; call
    push r11
    push r12
    push r13
    call function_myFunction
    pop r13
    pop r12
    pop r11
    mov rcx, rax
    ; =
    mov qword[rbp-696], rcx
    ; varResult
    mov rcx, [rbp-696]
    ; print
    mov rax, rcx
    call printInt
    jmp end_function_myAddingFunction
function_myAddingFunction:
    push rbp
    mov rbp, rsp
    sub rsp, 1000 ; TODO replace with calculated value
    ; param1 
    ; param2 
    ; +
    mov rax, r11
    add rax, r12
    mov r14, rax
    ; param3 
    ; +
    mov rax, r14
    add rax, r13
    mov r10, rax
    ; =
    mov qword[rbp-8], r10
    ; returnValue
    mov rcx, [rbp-8]
    ; gift
    mov rax, rcx
    add rsp, 1000 ; TODO replace with calculated value
    pop rbp
    ret
    ; prepare to exit function
    add rsp, 1000 ; TODO replace with calculated value
    pop rbp
    ret
end_function_myAddingFunction:
    ; 0
    mov rcx, 0
    ; =
    mov qword[rbp-704], rcx
    ; preparing to call myAddingFunction
    ; 100
    mov rcx, 100
    ; add as param
    mov r11, rcx
    ; 200
    mov rcx, 200
    ; add as param
    mov r12, rcx
    ; 300
    mov rcx, 300
    ; add as param
    mov r13, rcx
    ; call
    push r11
    push r12
    push r13
    call function_myAddingFunction
    pop r13
    pop r12
    pop r11
    mov rcx, rax
    ; =
    mov qword[rbp-704], rcx
    ; varPresent
    mov rcx, [rbp-704]
    ; print
    mov rax, rcx
    call printInt
    jmp end_function_approxCircleArea
function_approxCircleArea:
    push rbp
    mov rbp, rsp
    sub rsp, 1000 ; TODO replace with calculated value
    ; 0
    mov rcx, 0
    ; =
    mov qword[rbp-8], rcx
    ; 314
    mov rcx, 314
    ; param1 
    ; *
    mov rax, rcx
    mov edx, eax
    mov rax, r11
    imul eax, edx
    mov r15, rax
    ; param1 
    ; *
    mov rax, r15
    mov edx, eax
    mov rax, r11
    imul eax, edx
    mov r14, rax
    ; 100
    mov r15, 100
    ; /
    mov rax, r14
    mov rdx, 0
    idiv r15
    mov r14, rax
    ; =
    mov qword[rbp-8], r14
    ; returnValue
    mov rcx, [rbp-8]
    ; gift
    mov rax, rcx
    add rsp, 1000 ; TODO replace with calculated value
    pop rbp
    ret
    ; prepare to exit function
    add rsp, 1000 ; TODO replace with calculated value
    pop rbp
    ret
end_function_approxCircleArea:
    ; 0
    mov rcx, 0
    ; =
    mov qword[rbp-712], rcx
    ; preparing to call approxCircleArea
    ; 50
    mov rcx, 50
    ; add as param
    mov r11, rcx
    ; call
    push r11
    push r12
    push r13
    call function_approxCircleArea
    pop r13
    pop r12
    pop r11
    mov rcx, rax
    ; =
    mov qword[rbp-712], rcx
    ; approxArea
    mov rcx, [rbp-712]
    ; print
    mov rax, rcx
    call printInt
    jmp end_function_cylinderVolume
function_cylinderVolume:
    push rbp
    mov rbp, rsp
    sub rsp, 1000 ; TODO replace with calculated value
    ; 0
    mov rcx, 0
    ; =
    mov qword[rbp-8], rcx
    ; param1 
    ; param2 
    ; *
    mov rax, r11
    mov edx, eax
    mov rax, r12
    imul eax, edx
    mov r14, rax
    ; =
    mov qword[rbp-8], r14
    ; returnValue
    mov rcx, [rbp-8]
    ; gift
    mov rax, rcx
    add rsp, 1000 ; TODO replace with calculated value
    pop rbp
    ret
    ; prepare to exit function
    add rsp, 1000 ; TODO replace with calculated value
    pop rbp
    ret
end_function_cylinderVolume:
    ; 114
    mov rcx, 114
    ; =
    mov qword[rbp-720], rcx
    ; 100
    mov rcx, 100
    ; =
    mov qword[rbp-728], rcx
    ; 0
    mov rcx, 0
    ; =
    mov qword[rbp-736], rcx
    ; preparing to call cylinderVolume
    ; cylinderBaseArea
    mov rcx, [rbp-720]
    ; add as param
    mov r11, rcx
    ; cylinderHeight
    mov rcx, [rbp-728]
    ; add as param
    mov r12, rcx
    ; call
    push r11
    push r12
    push r13
    call function_cylinderVolume
    pop r13
    pop r12
    pop r11
    mov rcx, rax
    ; =
    mov qword[rbp-736], rcx
    ; volume
    mov rcx, [rbp-736]
    ; print
    mov rax, rcx
    call printInt
    ; preparing to call cylinderVolume
    ; preparing to call approxCircleArea
    ; 33
    mov rcx, 33
    ; add as param
    mov r11, rcx
    ; call
    push r11
    push r12
    push r13
    call function_approxCircleArea
    pop r13
    pop r12
    pop r11
    mov rcx, rax
    ; add as param
    mov r11, rcx
    ; 44
    mov rcx, 44
    ; add as param
    mov r12, rcx
    ; call
    push r11
    push r12
    push r13
    call function_cylinderVolume
    pop r13
    pop r12
    pop r11
    mov rcx, rax
    ; =
    mov qword[rbp-736], rcx
    ; volume
    mov rcx, [rbp-736]
    ; print
    mov rax, rcx
    call printInt

exit:
    add     rsp, 1000 ; TODO replace with calculated value
    mov rax, 60
    xor rdi, rdi
    syscall
