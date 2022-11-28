
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
    push    rcx
    push    rdx
    push    rsi
    push    rdi
    push    r8
    push    r9
    push    r10
    push    r11

    mov     rdi, numberPrinter      ; set printf format parameter
    mov     rsi, rax                ; set printf value paramete
    xor     rax, rax                ; set rax to 0 (number of float/vector regs used is 0)
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
main:
	push	rbp
	mov	    rbp, rsp
    ; 2
    mov rcx, 2
    ; =
    mov qword[rbp-0], rcx
    ; var1
    mov rcx, [rbp-0]
    ; print
    sub rsp, 16
    mov rax, rcx
    call printInt
    add rsp, 16
    ; var1
    mov rcx, [rbp-0]
    ; var1
    mov rbx, [rbp-0]
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-8], rcx
    ; var2
    mov rcx, [rbp-8]
    ; print
    sub rsp, 32
    mov rax, rcx
    call printInt
    add rsp, 32
    ; var1
    mov rcx, [rbp-0]
    ; var2
    mov rbx, [rbp-8]
    ; *
    mov rax, rcx
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rcx, rax
    ; =
    mov qword[rbp-16], rcx
    ; var3
    mov rcx, [rbp-16]
    ; print
    sub rsp, 48
    mov rax, rcx
    call printInt
    add rsp, 48
    ; var3
    mov rcx, [rbp-16]
    ; var2
    mov rbx, [rbp-8]
    ; -
    mov rax, rcx
    sub rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-24], rcx
    ; var4
    mov rcx, [rbp-24]
    ; print
    sub rsp, 64
    mov rax, rcx
    call printInt
    add rsp, 64
    ; var4
    mov rcx, [rbp-24]
    ; var3
    mov rbx, [rbp-16]
    ; /
    mov rax, rcx
    mov rdx, 0
    idiv rbx
    mov rcx, rax
    ; =
    mov qword[rbp-32], rcx
    ; var5
    mov rcx, [rbp-32]
    ; print
    sub rsp, 80
    mov rax, rcx
    call printInt
    add rsp, 80
    ; var1
    mov rcx, [rbp-0]
    ; var2
    mov rbx, [rbp-8]
    ; var3
    mov rsi, [rbp-16]
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
    mov qword[rbp-40], rcx
    ; var6
    mov rcx, [rbp-40]
    ; print
    sub rsp, 96
    mov rax, rcx
    call printInt
    add rsp, 96
    ; var4
    mov rcx, [rbp-24]
    ; var1
    mov rbx, [rbp-0]
    ; -
    mov rax, rcx
    sub rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-48], rcx
    ; var7
    mov rcx, [rbp-48]
    ; print
    sub rsp, 112
    mov rax, rcx
    call printInt
    add rsp, 112
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
    mov qword[rbp-56], rcx
    ; var8
    mov rcx, [rbp-56]
    ; print
    sub rsp, 128
    mov rax, rcx
    call printInt
    add rsp, 128
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
    mov qword[rbp-64], rcx
    ; var9
    mov rcx, [rbp-64]
    ; print
    sub rsp, 144
    mov rax, rcx
    call printInt
    add rsp, 144
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
    ; var10
    mov rcx, [rbp-72]
    ; print
    sub rsp, 160
    mov rax, rcx
    call printInt
    add rsp, 160
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
    mov qword[rbp-80], rcx
    ; var11
    mov rcx, [rbp-80]
    ; print
    sub rsp, 176
    mov rax, rcx
    call printInt
    add rsp, 176
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
    mov qword[rbp-88], rcx
    ; var12
    mov rcx, [rbp-88]
    ; print
    sub rsp, 192
    mov rax, rcx
    call printInt
    add rsp, 192
    ; 5
    mov rcx, 5
    ; 4
    mov rbx, 4
    ; /
    mov rax, rcx
    mov rdx, 0
    idiv rbx
    mov rcx, rax
    ; =
    mov qword[rbp-96], rcx
    ; var13
    mov rcx, [rbp-96]
    ; print
    sub rsp, 208
    mov rax, rcx
    call printInt
    add rsp, 208
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
    mov qword[rbp-104], rcx
    ; var14
    mov rcx, [rbp-104]
    ; print
    sub rsp, 224
    mov rax, rcx
    call printInt
    add rsp, 224
    ; 42
    mov rcx, 42
    ; =
    mov qword[rbp-112], rcx
    ; var15
    mov rcx, [rbp-112]
    ; print
    sub rsp, 240
    mov rax, rcx
    call printInt
    add rsp, 240
    ; 42
    mov rcx, 42
    ; =
    mov qword[rbp-120], rcx
    ; var16
    mov rcx, [rbp-120]
    ; print
    sub rsp, 256
    mov rax, rcx
    call printInt
    add rsp, 256
    ; 42
    mov rcx, 42
    ; =
    mov qword[rbp-128], rcx
    ; var17
    mov rcx, [rbp-128]
    ; print
    sub rsp, 272
    mov rax, rcx
    call printInt
    add rsp, 272
    ; 42
    mov rcx, 42
    ; =
    mov qword[rbp-136], rcx
    ; var18
    mov rcx, [rbp-136]
    ; print
    sub rsp, 288
    mov rax, rcx
    call printInt
    add rsp, 288
    ; var1
    mov rcx, [rbp-0]
    ; =
    mov qword[rbp-144], rcx
    ; var19
    mov rcx, [rbp-144]
    ; print
    sub rsp, 304
    mov rax, rcx
    call printInt
    add rsp, 304
    ; var1
    mov rcx, [rbp-0]
    ; var19
    mov rbx, [rbp-144]
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-152], rcx
    ; var20
    mov rcx, [rbp-152]
    ; print
    sub rsp, 320
    mov rax, rcx
    call printInt
    add rsp, 320
    ; var1
    mov rcx, [rbp-0]
    ; var2
    mov rbx, [rbp-8]
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-160], rcx
    ; var21
    mov rcx, [rbp-160]
    ; print
    sub rsp, 336
    mov rax, rcx
    call printInt
    add rsp, 336
    ; var9
    mov rcx, [rbp-64]
    ; var10
    mov rbx, [rbp-72]
    ; *
    mov rax, rcx
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rcx, rax
    ; =
    mov qword[rbp-168], rcx
    ; var22
    mov rcx, [rbp-168]
    ; print
    sub rsp, 352
    mov rax, rcx
    call printInt
    add rsp, 352
    ; var1
    mov rcx, [rbp-0]
    ; var2
    mov rbx, [rbp-8]
    ; var3
    mov rsi, [rbp-16]
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
    mov qword[rbp-176], rcx
    ; var23
    mov rcx, [rbp-176]
    ; print
    sub rsp, 368
    mov rax, rcx
    call printInt
    add rsp, 368
    ; var19
    mov rcx, [rbp-144]
    ; var20
    mov rbx, [rbp-152]
    ; -
    mov rax, rcx
    sub rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-184], rcx
    ; var24
    mov rcx, [rbp-184]
    ; print
    sub rsp, 384
    mov rax, rcx
    call printInt
    add rsp, 384
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
    mov qword[rbp-192], rcx
    ; var25
    mov rcx, [rbp-192]
    ; print
    sub rsp, 400
    mov rax, rcx
    call printInt
    add rsp, 400
    ; 100000
    mov rcx, 100000
    ; var13
    mov rbx, [rbp-96]
    ; /
    mov rax, rcx
    mov rdx, 0
    idiv rbx
    mov rcx, rax
    ; =
    mov qword[rbp-200], rcx
    ; var26
    mov rcx, [rbp-200]
    ; print
    sub rsp, 416
    mov rax, rcx
    call printInt
    add rsp, 416
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
    mov qword[rbp-208], rcx
    ; var27
    mov rcx, [rbp-208]
    ; print
    sub rsp, 432
    mov rax, rcx
    call printInt
    add rsp, 432
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
    mov qword[rbp-216], rcx
    ; var28
    mov rcx, [rbp-216]
    ; print
    sub rsp, 448
    mov rax, rcx
    call printInt
    add rsp, 448
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
    mov qword[rbp-224], rcx
    ; var29
    mov rcx, [rbp-224]
    ; print
    sub rsp, 464
    mov rax, rcx
    call printInt
    add rsp, 464
    ; var1
    mov rcx, [rbp-0]
    ; var2
    mov rbx, [rbp-8]
    ; /
    mov rax, rcx
    mov rdx, 0
    idiv rbx
    mov rcx, rax
    ; var3
    mov rbx, [rbp-16]
    ; var4
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
    mov qword[rbp-232], rcx
    ; var30
    mov rcx, [rbp-232]
    ; print
    sub rsp, 480
    mov rax, rcx
    call printInt
    add rsp, 480
    ; 1
    mov rcx, 1
    ; =
    mov qword[rbp-240], rcx
    ; 2
    mov rcx, 2
    ; =
    mov qword[rbp-248], rcx
    ; 3
    mov rcx, 3
    ; =
    mov qword[rbp-256], rcx
    ; 4
    mov rcx, 4
    ; =
    mov qword[rbp-264], rcx
    ; a_
    mov rcx, [rbp-240]
    ; =
    mov qword[rbp-272], rcx
    ; var31
    mov rcx, [rbp-272]
    ; print
    sub rsp, 560
    mov rax, rcx
    call printInt
    add rsp, 560
    ; a_
    mov rcx, [rbp-240]
    ; =
    mov qword[rbp-280], rcx
    ; var32
    mov rcx, [rbp-280]
    ; print
    sub rsp, 576
    mov rax, rcx
    call printInt
    add rsp, 576
    ; v_____2
    mov rcx, [rbp-248]
    ; v__3__
    mov rbx, [rbp-264]
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-288], rcx
    ; var33
    mov rcx, [rbp-288]
    ; print
    sub rsp, 592
    mov rax, rcx
    call printInt
    add rsp, 592
    ; 300
    mov rcx, 300
    ; var1
    mov rbx, [rbp-0]
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-296], rcx
    ; var34
    mov rcx, [rbp-296]
    ; print
    sub rsp, 608
    mov rax, rcx
    call printInt
    add rsp, 608
    ; var33
    mov rcx, [rbp-288]
    ; var2
    mov rbx, [rbp-8]
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
    mov qword[rbp-304], rcx
    ; var35
    mov rcx, [rbp-304]
    ; print
    sub rsp, 624
    mov rax, rcx
    call printInt
    add rsp, 624
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
    mov qword[rbp-312], rcx
    ; var36
    mov rcx, [rbp-312]
    ; print
    sub rsp, 640
    mov rax, rcx
    call printInt
    add rsp, 640
    ; 2
    mov rcx, 2
    ; 3
    mov rbx, 3
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-320], rcx
    ; var37
    mov rcx, [rbp-320]
    ; print
    sub rsp, 656
    mov rax, rcx
    call printInt
    add rsp, 656
    ; var1
    mov rcx, [rbp-0]
    ; var2
    mov rbx, [rbp-8]
    ; +
    mov rax, rcx
    add rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-328], rcx
    ; var38
    mov rcx, [rbp-328]
    ; print
    sub rsp, 672
    mov rax, rcx
    call printInt
    add rsp, 672
    ; 42
    mov rcx, 42
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rcx
    imul eax, edx
    mov rcx, rax
    ; =
    mov qword[rbp-336], rcx
    ; var39
    mov rcx, [rbp-336]
    ; print
    sub rsp, 688
    mov rax, rcx
    call printInt
    add rsp, 688
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
    ; var40
    mov rcx, [rbp-344]
    ; print
    sub rsp, 704
    mov rax, rcx
    call printInt
    add rsp, 704
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
    ; var41
    mov rcx, [rbp-352]
    ; print
    sub rsp, 720
    mov rax, rcx
    call printInt
    add rsp, 720
    ; var1
    mov rcx, [rbp-0]
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rcx
    imul eax, edx
    mov rcx, rax
    ; =
    mov qword[rbp-360], rcx
    ; var42
    mov rcx, [rbp-360]
    ; print
    sub rsp, 736
    mov rax, rcx
    call printInt
    add rsp, 736
    ; 1
    mov rcx, 1
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rcx
    imul eax, edx
    mov rcx, rax
    ; var1
    mov rbx, [rbp-0]
    ; *
    mov rax, rcx
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rcx, rax
    ; 1
    mov rbx, 1
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rbx, rax
    ; /
    mov rax, rcx
    mov rdx, 0
    idiv rbx
    mov rcx, rax
    ; =
    mov qword[rbp-368], rcx
    ; var43
    mov rcx, [rbp-368]
    ; print
    sub rsp, 752
    mov rax, rcx
    call printInt
    add rsp, 752
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
    sub rsp, 768
    mov rax, rcx
    call printInt
    add rsp, 768
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
    sub rsp, 784
    mov rax, rcx
    call printInt
    add rsp, 784
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
    sub rsp, 800
    mov rax, rcx
    call printInt
    add rsp, 800
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
    sub rsp, 816
    mov rax, rcx
    call printInt
    add rsp, 816
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
    sub rsp, 832
    mov rax, rcx
    call printInt
    add rsp, 832
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
    sub rsp, 848
    mov rax, rcx
    call printInt
    add rsp, 848
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
    sub rsp, 864
    mov rax, rcx
    call printInt
    add rsp, 864
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
    sub rsp, 880
    mov rax, rcx
    call printInt
    add rsp, 880
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
    sub rsp, 896
    mov rax, rcx
    call printInt
    add rsp, 896
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
    sub rsp, 912
    mov rax, rcx
    call printInt
    add rsp, 912
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
    sub rsp, 928
    mov rax, rcx
    call printInt
    add rsp, 928
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
    sub rsp, 944
    mov rax, rcx
    call printInt
    add rsp, 944
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
    sub rsp, 960
    mov rax, rcx
    call printInt
    add rsp, 960
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
    sub rsp, 976
    mov rax, rcx
    call printInt
    add rsp, 976
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
    sub rsp, 992
    mov rax, rcx
    call printInt
    add rsp, 992
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
    sub rsp, 1008
    mov rax, rcx
    call printInt
    add rsp, 1008
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
    sub rsp, 1024
    mov rax, rcx
    call printInt
    add rsp, 1024
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
    sub rsp, 1040
    mov rax, rcx
    call printInt
    add rsp, 1040
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
    sub rsp, 1056
    mov rax, rcx
    call printInt
    add rsp, 1056
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
    sub rsp, 1072
    mov rax, rcx
    call printInt
    add rsp, 1072
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
    sub rsp, 1088
    mov rax, rcx
    call printInt
    add rsp, 1088
    ; 2
    mov rcx, 2
    ; a
    mov rbx, [rbp-256]
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
    sub rsp, 1104
    mov rax, rcx
    call printInt
    add rsp, 1104
    ; 2
    mov rcx, 2
    ; a
    mov rbx, [rbp-256]
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
    sub rsp, 1120
    mov rax, rcx
    call printInt
    add rsp, 1120
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
    sub rsp, 1136
    mov rax, rcx
    call printInt
    add rsp, 1136
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
    sub rsp, 1152
    mov rax, rcx
    call printInt
    add rsp, 1152
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
    sub rsp, 1168
    mov rax, rcx
    call printInt
    add rsp, 1168
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
    sub rsp, 1184
    mov rax, rcx
    call printInt
    add rsp, 1184
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
    sub rsp, 1264
    mov rax, rcx
    call printInt
    add rsp, 1264
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
    sub rsp, 1280
    mov rax, rcx
    call printInt
    add rsp, 1280
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
    sub rsp, 1296
    mov rax, rcx
    call printInt
    add rsp, 1296
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
    mov rsi, [rbp-0]
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
    sub rsp, 1312
    mov rax, rcx
    call printInt
    add rsp, 1312
    ; var75
    mov rcx, [rbp-656]
    ; 1234
    mov rcx, 1234
    ; =
    mov qword[rbp-656], rcx
    ; var75
    mov rcx, [rbp-656]
    ; print
    sub rsp, 1328
    mov rax, rcx
    call printInt
    add rsp, 1328
    ; 314
    mov rcx, 314
    ; =
    mov qword[rbp-664], rcx
    ; var76
    mov rcx, [rbp-664]
    ; print
    sub rsp, 1344
    mov rax, rcx
    call printInt
    add rsp, 1344
    ; 1.23456
    mov rax, __float64__(1.23456)
    mov qword[rsp-680], rax
    movlpd xmm1, qword[rsp-680]
    ; =
    movlpd qword[rbp-672], xmm1
    ; num1
    movlpd xmm1, [rbp-672]
    ; print
    sub rsp, 1360
    movlpd [rsp], xmm1
    movlpd xmm0, [rsp]
    call printFloat
    add rsp, 1360
    ; .1
    mov rax, __float64__(0.1)
    mov qword[rsp-688], rax
    movlpd xmm1, qword[rsp-688]
    ; =
    movlpd qword[rbp-680], xmm1
    ; num2
    movlpd xmm1, [rbp-680]
    ; print
    sub rsp, 1376
    movlpd [rsp], xmm1
    movlpd xmm0, [rsp]
    call printFloat
    add rsp, 1376
    ; 3.14159
    mov rax, __float64__(3.14159)
    mov qword[rsp-696], rax
    movlpd xmm1, qword[rsp-696]
    ; =
    movlpd qword[rbp-688], xmm1
    ; num3
    movlpd xmm1, [rbp-688]
    ; print
    sub rsp, 1392
    movlpd [rsp], xmm1
    movlpd xmm0, [rsp]
    call printFloat
    add rsp, 1392
    ; num2
    movlpd xmm1, [rbp-680]
    ; num3
    movlpd xmm2, [rbp-688]
    ; +
    movlpd [rsp-704], xmm1
    movlpd xmm0, [rsp-704]
    addsd xmm0, xmm2
    movlpd [rsp-704], xmm0
    movlpd xmm1, [rsp-704]
    ; =
    movlpd qword[rbp-696], xmm1
    ; num4
    movlpd xmm1, [rbp-696]
    ; print
    sub rsp, 1408
    movlpd [rsp], xmm1
    movlpd xmm0, [rsp]
    call printFloat
    add rsp, 1408
    ; num2
    movlpd xmm1, [rbp-680]
    ; num3
    movlpd xmm2, [rbp-688]
    ; *
    movlpd [rsp-712], xmm1
    movlpd xmm0, [rsp-712]
    mulsd xmm0, xmm2
    movlpd [rsp-712], xmm0
    movlpd xmm1, [rsp-712]
    ; =
    movlpd qword[rbp-704], xmm1
    ; num5
    movlpd xmm1, [rbp-704]
    ; print
    sub rsp, 1424
    movlpd [rsp], xmm1
    movlpd xmm0, [rsp]
    call printFloat
    add rsp, 1424

exit:
    mov rax, 60
    xor rdi, rdi
    syscall
