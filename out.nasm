
    GLOBAL main
    extern printf

section .data
numberPrinter db "%d",0x0d,0x0a,0

section .text
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
    mov rax, [rbp-0]
    mov rcx,  rax
    ; print
    sub rsp, 16
    mov rax, rcx
    call printInt
    add rsp, 16
    ; var1
    mov rax, [rbp-0]
    mov rcx,  rax
    ; var1
    mov rax, [rbp-0]
    mov rbx,  rax
    ; +
    mov rax, rbx
    add rax, rcx
    mov rcx, rax
    ; =
    mov qword[rbp-8], rcx
    ; var2
    mov rax, [rbp-8]
    mov rcx,  rax
    ; print
    sub rsp, 32
    mov rax, rcx
    call printInt
    add rsp, 32
    ; var1
    mov rax, [rbp-0]
    mov rcx,  rax
    ; var2
    mov rax, [rbp-8]
    mov rbx,  rax
    ; *
    mov rax, rbx
    mov edx, eax
    mov rax, rcx
    imul eax, edx
    mov rcx, rax
    ; =
    mov qword[rbp-16], rcx
    ; var3
    mov rax, [rbp-16]
    mov rcx,  rax
    ; print
    sub rsp, 48
    mov rax, rcx
    call printInt
    add rsp, 48
    ; var3
    mov rax, [rbp-16]
    mov rcx,  rax
    ; var2
    mov rax, [rbp-8]
    mov rbx,  rax
    ; -
    mov rax, rcx
    sub rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-24], rcx
    ; var4
    mov rax, [rbp-24]
    mov rcx,  rax
    ; print
    sub rsp, 64
    mov rax, rcx
    call printInt
    add rsp, 64
    ; var4
    mov rax, [rbp-24]
    mov rcx,  rax
    ; var3
    mov rax, [rbp-16]
    mov rbx,  rax
    ; /
    mov rax, rcx
    mov rdx, 0
    idiv rbx
    mov rcx, rax
    ; =
    mov qword[rbp-32], rcx
    ; var5
    mov rax, [rbp-32]
    mov rcx,  rax
    ; print
    sub rsp, 80
    mov rax, rcx
    call printInt
    add rsp, 80
    ; var1
    mov rax, [rbp-0]
    mov rcx,  rax
    ; var2
    mov rax, [rbp-8]
    mov rbx,  rax
    ; var3
    mov rax, [rbp-16]
    mov rsi,  rax
    ; *
    mov rax, rsi
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rbx, rax
    ; +
    mov rax, rbx
    add rax, rcx
    mov rcx, rax
    ; =
    mov qword[rbp-40], rcx
    ; var6
    mov rax, [rbp-40]
    mov rcx,  rax
    ; print
    sub rsp, 96
    mov rax, rcx
    call printInt
    add rsp, 96
    ; var4
    mov rax, [rbp-24]
    mov rcx,  rax
    ; var1
    mov rax, [rbp-0]
    mov rbx,  rax
    ; -
    mov rax, rcx
    sub rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-48], rcx
    ; var7
    mov rax, [rbp-48]
    mov rcx,  rax
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
    mov rax, rbx
    mov edx, eax
    mov rax, rcx
    imul eax, edx
    mov rcx, rax
    ; =
    mov qword[rbp-56], rcx
    ; var8
    mov rax, [rbp-56]
    mov rcx,  rax
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
    mov rax, [rbp-64]
    mov rcx,  rax
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
    mov rax, [rbp-72]
    mov rcx,  rax
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
    mov rax, rsi
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rbx, rax
    ; +
    mov rax, rbx
    add rax, rcx
    mov rcx, rax
    ; =
    mov qword[rbp-80], rcx
    ; var11
    mov rax, [rbp-80]
    mov rcx,  rax
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
    mov rax, rsi
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rbx, rax
    ; +
    mov rax, rbx
    add rax, rcx
    mov rcx, rax
    ; =
    mov qword[rbp-88], rcx
    ; var12
    mov rax, [rbp-88]
    mov rcx,  rax
    ; print
    sub rsp, 192
    mov rax, rcx
    call printInt
    add rsp, 192
    ; 4
    mov rcx, 4
    ; 5
    mov rbx, 5
    ; /
    mov rax, rcx
    mov rdx, 0
    idiv rbx
    mov rcx, rax
    ; =
    mov qword[rbp-96], rcx
    ; var13
    mov rax, [rbp-96]
    mov rcx,  rax
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
    mov rax, rbx
    mov edx, eax
    mov rax, rcx
    imul eax, edx
    mov rcx, rax
    ; 5
    mov rbx, 5
    ; 5
    mov rsi, 5
    ; *
    mov rax, rsi
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rbx, rax
    ; +
    mov rax, rbx
    add rax, rcx
    mov rcx, rax
    ; =
    mov qword[rbp-104], rcx
    ; var14
    mov rax, [rbp-104]
    mov rcx,  rax
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
    mov rax, [rbp-112]
    mov rcx,  rax
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
    mov rax, [rbp-120]
    mov rcx,  rax
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
    mov rax, [rbp-128]
    mov rcx,  rax
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
    mov rax, [rbp-136]
    mov rcx,  rax
    ; print
    sub rsp, 288
    mov rax, rcx
    call printInt
    add rsp, 288
    ; var1
    mov rax, [rbp-0]
    mov rcx,  rax
    ; =
    mov qword[rbp-144], rcx
    ; var19
    mov rax, [rbp-144]
    mov rcx,  rax
    ; print
    sub rsp, 304
    mov rax, rcx
    call printInt
    add rsp, 304
    ; var1
    mov rax, [rbp-0]
    mov rcx,  rax
    ; var19
    mov rax, [rbp-144]
    mov rbx,  rax
    ; +
    mov rax, rbx
    add rax, rcx
    mov rcx, rax
    ; =
    mov qword[rbp-152], rcx
    ; var20
    mov rax, [rbp-152]
    mov rcx,  rax
    ; print
    sub rsp, 320
    mov rax, rcx
    call printInt
    add rsp, 320
    ; var1
    mov rax, [rbp-0]
    mov rcx,  rax
    ; var2
    mov rax, [rbp-8]
    mov rbx,  rax
    ; +
    mov rax, rbx
    add rax, rcx
    mov rcx, rax
    ; =
    mov qword[rbp-160], rcx
    ; var21
    mov rax, [rbp-160]
    mov rcx,  rax
    ; print
    sub rsp, 336
    mov rax, rcx
    call printInt
    add rsp, 336
    ; var9
    mov rax, [rbp-64]
    mov rcx,  rax
    ; var10
    mov rax, [rbp-72]
    mov rbx,  rax
    ; *
    mov rax, rbx
    mov edx, eax
    mov rax, rcx
    imul eax, edx
    mov rcx, rax
    ; =
    mov qword[rbp-168], rcx
    ; var22
    mov rax, [rbp-168]
    mov rcx,  rax
    ; print
    sub rsp, 352
    mov rax, rcx
    call printInt
    add rsp, 352
    ; var1
    mov rax, [rbp-0]
    mov rcx,  rax
    ; var2
    mov rax, [rbp-8]
    mov rbx,  rax
    ; var3
    mov rax, [rbp-16]
    mov rsi,  rax
    ; *
    mov rax, rsi
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rbx, rax
    ; +
    mov rax, rbx
    add rax, rcx
    mov rcx, rax
    ; =
    mov qword[rbp-176], rcx
    ; var23
    mov rax, [rbp-176]
    mov rcx,  rax
    ; print
    sub rsp, 368
    mov rax, rcx
    call printInt
    add rsp, 368
    ; var19
    mov rax, [rbp-144]
    mov rcx,  rax
    ; var20
    mov rax, [rbp-152]
    mov rbx,  rax
    ; -
    mov rax, rcx
    sub rax, rbx
    mov rcx, rax
    ; =
    mov qword[rbp-184], rcx
    ; var24
    mov rax, [rbp-184]
    mov rcx,  rax
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
    mov rax, rbx
    mov edx, eax
    mov rax, rcx
    imul eax, edx
    mov rcx, rax
    ; =
    mov qword[rbp-192], rcx
    ; var25
    mov rax, [rbp-192]
    mov rcx,  rax
    ; print
    sub rsp, 400
    mov rax, rcx
    call printInt
    add rsp, 400
    ; 100000
    mov rcx, 100000
    ; var13
    mov rax, [rbp-96]
    mov rbx,  rax
    ; /
    mov rax, rcx
    mov rdx, 0
    idiv rbx
    mov rcx, rax
    ; =
    mov qword[rbp-200], rcx
    ; var26
    mov rax, [rbp-200]
    mov rcx,  rax
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
    mov rax, [rbp-208]
    mov rcx,  rax
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
    mov rax, rbx
    mov edx, eax
    mov rax, rcx
    imul eax, edx
    mov rcx, rax
    ; =
    mov qword[rbp-216], rcx
    ; var28
    mov rax, [rbp-216]
    mov rcx,  rax
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
    mov rax, rbx
    add rax, rcx
    mov rcx, rax
    ; 3
    mov rbx, 3
    ; *
    mov rax, rbx
    mov edx, eax
    mov rax, rcx
    imul eax, edx
    mov rcx, rax
    ; =
    mov qword[rbp-224], rcx
    ; var29
    mov rax, [rbp-224]
    mov rcx,  rax
    ; print
    sub rsp, 464
    mov rax, rcx
    call printInt
    add rsp, 464
    ; var1
    mov rax, [rbp-0]
    mov rcx,  rax
    ; var2
    mov rax, [rbp-8]
    mov rbx,  rax
    ; /
    mov rax, rcx
    mov rdx, 0
    idiv rbx
    mov rcx, rax
    ; var3
    mov rax, [rbp-16]
    mov rbx,  rax
    ; var4
    mov rax, [rbp-24]
    mov rsi,  rax
    ; *
    mov rax, rsi
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rbx, rax
    ; +
    mov rax, rbx
    add rax, rcx
    mov rcx, rax
    ; =
    mov qword[rbp-232], rcx
    ; var30
    mov rax, [rbp-232]
    mov rcx,  rax
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
    mov rax, [rbp-240]
    mov rcx,  rax
    ; =
    mov qword[rbp-272], rcx
    ; var31
    mov rax, [rbp-272]
    mov rcx,  rax
    ; print
    sub rsp, 560
    mov rax, rcx
    call printInt
    add rsp, 560
    ; a_
    mov rax, [rbp-240]
    mov rcx,  rax
    ; =
    mov qword[rbp-280], rcx
    ; var32
    mov rax, [rbp-280]
    mov rcx,  rax
    ; print
    sub rsp, 576
    mov rax, rcx
    call printInt
    add rsp, 576
    ; v_____2
    mov rax, [rbp-248]
    mov rcx,  rax
    ; v__3__
    mov rax, [rbp-264]
    mov rbx,  rax
    ; +
    mov rax, rbx
    add rax, rcx
    mov rcx, rax
    ; =
    mov qword[rbp-288], rcx
    ; var33
    mov rax, [rbp-288]
    mov rcx,  rax
    ; print
    sub rsp, 592
    mov rax, rcx
    call printInt
    add rsp, 592
    ; 300
    mov rcx, 300
    ; var1
    mov rax, [rbp-0]
    mov rbx,  rax
    ; +
    mov rax, rbx
    add rax, rcx
    mov rcx, rax
    ; =
    mov qword[rbp-296], rcx
    ; var34
    mov rax, [rbp-296]
    mov rcx,  rax
    ; print
    sub rsp, 608
    mov rax, rcx
    call printInt
    add rsp, 608
    ; var33
    mov rax, [rbp-288]
    mov rcx,  rax
    ; var2
    mov rax, [rbp-8]
    mov rbx,  rax
    ; -
    mov rax, rcx
    sub rax, rbx
    mov rcx, rax
    ; 18
    mov rbx, 18
    ; +
    mov rax, rbx
    add rax, rcx
    mov rcx, rax
    ; =
    mov qword[rbp-304], rcx
    ; var35
    mov rax, [rbp-304]
    mov rcx,  rax
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
    mov rax, rsi
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rbx, rax
    ; +
    mov rax, rbx
    add rax, rcx
    mov rcx, rax
    ; 8
    mov rbx, 8
    ; *
    mov rax, rbx
    mov edx, eax
    mov rax, rcx
    imul eax, edx
    mov rcx, rax
    ; 1000
    mov rbx, 1000
    ; +
    mov rax, rbx
    add rax, rcx
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
    mov rax, rsi
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rbx, rax
    ; 3
    mov rsi, 3
    ; *
    mov rax, rsi
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rbx, rax
    ; 3
    mov rsi, 3
    ; *
    mov rax, rsi
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rbx, rax
    ; 1
    mov rsi, 1
    ; +
    mov rax, rsi
    add rax, rbx
    mov rbx, rax
    ; 2
    mov rsi, 2
    ; /
    mov rax, rbx
    mov rdx, 0
    idiv rsi
    mov rbx, rax
    ; +
    mov rax, rbx
    add rax, rcx
    mov rcx, rax
    ; =
    mov qword[rbp-312], rcx
    ; var36
    mov rax, [rbp-312]
    mov rcx,  rax
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
    mov rax, rbx
    add rax, rcx
    mov rcx, rax
    ; =
    mov qword[rbp-320], rcx
    ; var37
    mov rax, [rbp-320]
    mov rcx,  rax
    ; print
    sub rsp, 656
    mov rax, rcx
    call printInt
    add rsp, 656
    ; var1
    mov rax, [rbp-0]
    mov rcx,  rax
    ; var2
    mov rax, [rbp-8]
    mov rbx,  rax
    ; +
    mov rax, rbx
    add rax, rcx
    mov rcx, rax
    ; =
    mov qword[rbp-328], rcx
    ; var38
    mov rax, [rbp-328]
    mov rcx,  rax
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
    mov rax, [rbp-336]
    mov rcx,  rax
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
    mov rax, [rbp-344]
    mov rcx,  rax
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
    mov rax, [rbp-352]
    mov rcx,  rax
    ; print
    sub rsp, 720
    mov rax, rcx
    call printInt
    add rsp, 720
    ; var1
    mov rax, [rbp-0]
    mov rcx,  rax
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rcx
    imul eax, edx
    mov rcx, rax
    ; =
    mov qword[rbp-360], rcx
    ; var42
    mov rax, [rbp-360]
    mov rcx,  rax
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
    mov rax, [rbp-0]
    mov rbx,  rax
    ; *
    mov rax, rbx
    mov edx, eax
    mov rax, rcx
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
    mov rax, [rbp-368]
    mov rcx,  rax
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
    mov rax, [rbp-376]
    mov rcx,  rax
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
    mov rax, [rbp-384]
    mov rcx,  rax
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
    mov rax, [rbp-392]
    mov rcx,  rax
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
    mov rax, [rbp-400]
    mov rcx,  rax
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
    mov rax, [rbp-408]
    mov rcx,  rax
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
    mov rax, [rbp-416]
    mov rcx,  rax
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
    mov rax, [rbp-424]
    mov rcx,  rax
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
    mov rax, [rbp-432]
    mov rcx,  rax
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
    mov rax, [rbp-440]
    mov rcx,  rax
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
    mov rax, [rbp-448]
    mov rcx,  rax
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
    mov rax, [rbp-456]
    mov rcx,  rax
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
    mov rax, [rbp-464]
    mov rcx,  rax
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
    mov rax, [rbp-472]
    mov rcx,  rax
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
    mov rax, [rbp-480]
    mov rcx,  rax
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
    mov rax, [rbp-488]
    mov rcx,  rax
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
    mov rax, [rbp-496]
    mov rcx,  rax
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
    mov rax, [rbp-504]
    mov rcx,  rax
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
    mov rax, [rbp-512]
    mov rcx,  rax
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
    mov rax, [rbp-520]
    mov rcx,  rax
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
    mov rax, rbx
    add rax, rcx
    mov rcx, rax
    ; =
    mov qword[rbp-528], rcx
    ; var63
    mov rax, [rbp-528]
    mov rcx,  rax
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
    mov rax, rbx
    add rax, rcx
    mov rcx, rax
    ; =
    mov qword[rbp-536], rcx
    ; var64
    mov rax, [rbp-536]
    mov rcx,  rax
    ; print
    sub rsp, 1088
    mov rax, rcx
    call printInt
    add rsp, 1088
    ; 2
    mov rcx, 2
    ; a
    mov rax, [rbp-256]
    mov rbx,  rax
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
    mov rax, [rbp-544]
    mov rcx,  rax
    ; print
    sub rsp, 1104
    mov rax, rcx
    call printInt
    add rsp, 1104
    ; 2
    mov rcx, 2
    ; a
    mov rax, [rbp-256]
    mov rbx,  rax
    ; *-1
    mov rax, -1
    mov edx, eax
    mov rax, rbx
    imul eax, edx
    mov rbx, rax
    ; +
    mov rax, rbx
    add rax, rcx
    mov rcx, rax
    ; =
    mov qword[rbp-552], rcx
    ; var66
    mov rax, [rbp-552]
    mov rcx,  rax
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
    mov rax, rbx
    add rax, rcx
    mov rcx, rax
    ; =
    mov qword[rbp-560], rcx
    ; var67
    mov rax, [rbp-560]
    mov rcx,  rax
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
    mov rax, rbx
    add rax, rcx
    mov rcx, rax
    ; =
    mov qword[rbp-568], rcx
    ; var68
    mov rax, [rbp-568]
    mov rcx,  rax
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
    mov rax, rbx
    add rax, rcx
    mov rcx, rax
    ; =
    mov qword[rbp-576], rcx
    ; var69
    mov rax, [rbp-576]
    mov rcx,  rax
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
    mov rax, rbx
    mov edx, eax
    mov rax, rcx
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
    mov rax, rbx
    add rax, rcx
    mov rcx, rax
    ; =
    mov qword[rbp-584], rcx
    ; var70
    mov rax, [rbp-584]
    mov rcx,  rax
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
    mov rax, [rbp-592]
    mov rcx,  rax
    ; three
    mov rax, [rbp-600]
    mov rbx,  rax
    ; *
    mov rax, rbx
    mov edx, eax
    mov rax, rcx
    imul eax, edx
    mov rcx, rax
    ; two
    mov rax, [rbp-608]
    mov rbx,  rax
    ; /
    mov rax, rcx
    mov rdx, 0
    idiv rbx
    mov rcx, rax
    ; one
    mov rax, [rbp-616]
    mov rbx,  rax
    ; +
    mov rax, rbx
    add rax, rcx
    mov rcx, rax
    ; =
    mov qword[rbp-624], rcx
    ; var71
    mov rax, [rbp-624]
    mov rcx,  rax
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
    mov rax, rbx
    mov edx, eax
    mov rax, rcx
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
    mov rax, [rbp-616]
    mov rbx,  rax
    ; +
    mov rax, rbx
    add rax, rcx
    mov rcx, rax
    ; =
    mov qword[rbp-632], rcx
    ; var72
    mov rax, [rbp-632]
    mov rcx,  rax
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
    mov rax, rbx
    add rax, rcx
    mov rcx, rax
    ; 4
    mov rbx, 4
    ; *
    mov rax, rbx
    mov edx, eax
    mov rax, rcx
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
    mov rax, rsi
    add rax, rbx
    mov rbx, rax
    ; +
    mov rax, rbx
    add rax, rcx
    mov rcx, rax
    ; =
    mov qword[rbp-640], rcx
    ; var73
    mov rax, [rbp-640]
    mov rcx,  rax
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
    mov rax, rbx
    add rax, rcx
    mov rcx, rax
    ; 4
    mov rbx, 4
    ; *
    mov rax, rbx
    mov edx, eax
    mov rax, rcx
    imul eax, edx
    mov rcx, rax
    ; 7
    mov rbx, 7
    ; var1
    mov rax, [rbp-0]
    mov rsi,  rax
    ; 2
    mov rdi, 2
    ; /
    mov rax, rsi
    mov rdx, 0
    idiv rdi
    mov rsi, rax
    ; +
    mov rax, rsi
    add rax, rbx
    mov rbx, rax
    ; +
    mov rax, rbx
    add rax, rcx
    mov rcx, rax
    ; =
    mov qword[rbp-648], rcx
    ; var74
    mov rax, [rbp-648]
    mov rcx,  rax
    ; print
    sub rsp, 1312
    mov rax, rcx
    call printInt
    add rsp, 1312
    ; var75
    mov rax, [rbp-656]
    mov rcx,  rax
    ; 1234
    mov rcx, 1234
    ; =
    mov qword[rbp-656], rcx
    ; var75
    mov rax, [rbp-656]
    mov rcx,  rax
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
    mov rax, [rbp-664]
    mov rcx,  rax
    ; print
    sub rsp, 1344
    mov rax, rcx
    call printInt
    add rsp, 1344
    ; 1.23456
    mov rcx, 1.23456
    ; =
    mov qword[rbp-672], rcx
    ; num1
    mov rax, [rbp-672]
    mov rcx,  rax
    ; print
    sub rsp, 1360
    mov rax, rcx
    call printInt
    add rsp, 1360
    ; .1
    mov rcx, .1
    ; =
    mov qword[rbp-680], rcx
    ; num2
    mov rax, [rbp-680]
    mov rcx,  rax
    ; print
    sub rsp, 1376
    mov rax, rcx
    call printInt
    add rsp, 1376
    ; 3.14159
    mov rcx, 3.14159
    ; =
    mov qword[rbp-688], rcx
    ; num3
    mov rax, [rbp-688]
    mov rcx,  rax
    ; print
    sub rsp, 1392
    mov rax, rcx
    call printInt
    add rsp, 1392
    ; num2
    mov rax, [rbp-680]
    mov rcx,  rax
    ; num3
    mov rax, [rbp-688]
    mov rbx,  rax
    ; +
    mov rax, rbx
    add rax, rcx
    mov rcx, rax
    ; =
    mov qword[rbp-696], rcx
    ; num4
    mov rax, [rbp-696]
    mov rcx,  rax
    ; print
    sub rsp, 1408
    mov rax, rcx
    call printInt
    add rsp, 1408
    ; num2
    mov rax, [rbp-680]
    mov rcx,  rax
    ; num3
    mov rax, [rbp-688]
    mov rbx,  rax
    ; *
    mov rax, rbx
    mov edx, eax
    mov rax, rcx
    imul eax, edx
    mov rcx, rax
    ; =
    mov qword[rbp-704], rcx
    ; num5
    mov rax, [rbp-704]
    mov rcx,  rax
    ; print
    sub rsp, 1424
    mov rax, rcx
    call printInt
    add rsp, 1424

exit:
    mov rax, 60
    xor rdi, rdi
    syscall
