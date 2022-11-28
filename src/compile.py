
from src.token import tokenize
from src.parser import build_tree
from src.ast import build_ir, ir_to_string
from src.symbol_table import SymbolTable, VarType, VariableInfo, AlreadyDefinedException, term_to_type
from src.token_enums import Terminal, TokenType, Token

CALC_REGISTER_ORDER = [
    "rcx",
    "rbx",
    "rsi",
    "rdi",
    "r8",
    "r9",
    "r10",
    "r11",
    "r12",
    "r13",
    "r14",
    "r15",
]

FLUM_REGISTER_ORDER = [
    "xmm1",
    "xmm2",
    "xmm3",
    "xmm4",
    "xmm5",
    "xmm6",
    "xmm7",
    "xmm8",
    "xmm9",
    "xmm10",
    "xmm11",
    "xmm12",
    "xmm13",
    "xmm14",
    "xmm15",
]

class RegStack:
    def __init__(self, real_stack_base:int):
        self.real_stack_base = real_stack_base

        self.num_stack_length = 0
        self.flum_stack_length = 0

        self.nums_on_real_stack = 0
        self.flums_on_real_stack = 0
        self.locations_used = []
        self.types = []

    def next_num(self) -> str:
        if len(CALC_REGISTER_ORDER) > self.num_stack_length:
            place = CALC_REGISTER_ORDER[self.num_stack_length]
        else:
            place = "[rbp-"+str(self.real_stack_base + self.nums_on_real_stack + self.flums_on_real_stack)+"]"
            self.nums_on_real_stack += 1

        self.locations_used.append(place)
        self.types.append(VarType.NUM)
        self.num_stack_length += 1
        return place

    def next_flum(self) -> str:
        if len(FLUM_REGISTER_ORDER) > self.flum_stack_length:
            place = FLUM_REGISTER_ORDER[self.flum_stack_length]
        else:
            place = "[rbp-"+str(self.real_stack_base + self.nums_on_real_stack + self.flums_on_real_stack)+"]"
            self.nums_on_real_stack += 1

        self.locations_used.append(place)
        self.types.append(VarType.FLUM)
        self.flum_stack_length += 1
        return place

    def pop(self) -> tuple[str, VarType]:
        place = self.locations_used.pop()
        type = self.types.pop()

        if type == VarType.FLUM:
            self.flum_stack_length -= 1
            if place[0] == '[':
                self.flums_on_real_stack -= 1
        else:
            self.num_stack_length -= 1
            if place[0] == '[':
                self.nums_on_real_stack -= 1

        return (place, type)

    def rsp_needed(self) -> int:
        return (self.real_stack_base + self.flums_on_real_stack + self.nums_on_real_stack)*8


ASM_HEADER = """
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
"""

ASM_TAIL = """
exit:
    mov rax, 60
    xor rdi, rdi
    syscall
"""

def compile(file)->str|None:
    f = open(file, 'r')
    lines = f.readlines()
    f.close()

    asm = ASM_HEADER

    error_free = True

    table = SymbolTable()

    for line_num, line in enumerate(lines):
        try:
            token_list = tokenize(line)
            
            tree = build_tree(token_list)
            if tree == False:
                print("Could not parse line "+str(line_num+1))
                error_free = False
                continue

        except SyntaxError as e:
            print("Syntax error on line "+str(line_num+1)+": "+e.msg)
            error_free = False
            continue
        except KeyError as e:
            print("Parse error on line "+str(line_num+1))
            error_free = False
            continue

        ir = build_ir(tree, [])
        if len(ir) == 0:
            continue

        if ir[0] in [Terminal.KW_NUM, Terminal.KW_FLUM]:
            var_type = term_to_type(ir.pop(0))

            name_type = ir[0].type
            if name_type != TokenType.NAME:
                print("Expected a name to be declared on line "+str(line_num+1))
                error_free = False
                continue

            var_name = ir[0].text

            try:
                table.add_var(var_name, var_type)
            except AlreadyDefinedException:
                print(var_name + " is already defined in scope on line "+str(line_num+1))
                error_free = False
                continue

        assignment_location = None
        if type(ir[-1]) == Token and ir[-1] == Token('=', TokenType.OPERATOR):
            if type(ir[0]) != Token or ir[0].type != TokenType.NAME:
                print("Can only assign to a variable; line "+str(line_num+1))
                error_free = False
                continue

            assignment_location = table.get_info(ir.pop(0).text)
            if assignment_location is None:
                print(var_name + " assigned before declaration on line "+str(line_num+1))
                error_free = False
                continue
        
        expr_stack = RegStack(table.top_of_stack())
        for token in ir:
            if type(token) == Token:
                if token.type == TokenType.NAME:
                    asm += "    ; "+token.text+'\n'
                    var_loc = table.get_info(token.text)
                    if var_loc is None:
                        print("Use of undeclared variable, "+token.text+" on line "+str(line_num+1))
                        error_free = False
                        break

                    if var_loc.type == VarType.NUM:
                        next_loc = expr_stack.next_num()
                        if next_loc[0] == "[":
                            next_loc = "qword"+next_loc
                            asm += "    mov rax, [rbp-"+str(var_loc.offset*8)+"]\n"
                            asm += "    mov "+next_loc+", rax\n"
                        else:
                            asm += "    mov "+next_loc+", [rbp-"+str(var_loc.offset*8)+"]\n"
                    
                    elif var_loc.type == VarType.FLUM:
                        next_loc = expr_stack.next_flum()
                        if next_loc[0] == "[":
                            next_loc = "qword"+next_loc

                            asm += "    mov rax, [rbp-"+str(var_loc.offset*8)+"]\n"
                            asm += "    mov "+next_loc+", rax\n"

                        else:
                            asm += "    movlpd "+next_loc+", [rbp-"+str(var_loc.offset*8)+"]\n"

                    
                elif token.type == TokenType.NUMBER:
                    asm += "    ; "+token.text+'\n'
                    if '.' in token.text:
                        next_loc = expr_stack.next_flum()

                        if next_loc[0] == "[":
                            next_loc = "qword"+next_loc
                        
                        padded_flum = token.text
                        if padded_flum[0] == '.':
                            padded_flum = '0'+padded_flum
                        if padded_flum[-1] == '.':
                            padded_flum = padded_flum+'0'
                            
                        asm += "    mov rax, __float64__(" + padded_flum + ")\n"
                        asm += "    mov qword[rsp-"+str(expr_stack.rsp_needed())+"], rax\n"
                        asm += "    movlpd "+next_loc+", qword[rsp-"+str(expr_stack.rsp_needed())+"]\n"
                    else:
                        next_loc = expr_stack.next_num()
                        if next_loc[0] == "[":
                            next_loc = "qword"+next_loc
                        asm += "    mov "+next_loc+", " + str(token.text) + '\n'
                elif token.type == TokenType.OPERATOR:

                    if token.text == '=':
                        asm += "    ; =\n"
                        a, a_type = expr_stack.pop()
                        if assignment_location.type != a_type:
                            print("Mismatch of types in assignment on line "+str(line_num))
                            error_free = False
                            break

                        if a_type == VarType.NUM:
                            asm += "    mov qword[rbp-"+str(assignment_location.offset*8)+"], "+a+"\n"
                        elif a_type == VarType.FLUM:
                            asm += "    movlpd qword[rbp-"+str(assignment_location.offset*8)+"], "+a+"\n"


                        continue

                    a, a_type = expr_stack.pop()
                    b, b_type = expr_stack.pop()
                    if a_type != b_type:
                        print("Type mismatch on line "+str(line_num))
                        error_free = False
                        break

                    try:

                        if token.text == '+':
                            asm += "    ; +\n"

                            if a_type == VarType.NUM:
                                asm += "    mov rax, "+b+"\n"
                                asm += "    add rax, "+a+'\n'
                            elif a_type == VarType.FLUM:
                                if b[0] == '[':
                                    asm += "    movlpd xmm0, "+b+"\n"
                                    asm += "    addsd xmm0, "+a+"\n"
                                else:
                                    asm += "    movlpd [rsp-"+str(expr_stack.rsp_needed())+"], "+b+"\n"
                                    asm += "    movlpd xmm0, [rsp-"+str(expr_stack.rsp_needed())+"]\n"
                                    asm += "    addsd xmm0, "+a+"\n"


                        elif token.text == '-':
                            asm += "    ; -\n"

                            if a_type == VarType.NUM:
                                asm += "    mov rax, "+b+"\n"
                                asm += "    sub rax, "+a+'\n'
                            elif a_type == VarType.FLUM:
                                if b[0] == '[':
                                    asm += "    movlpd xmm0, "+b+"\n"
                                    asm += "    subsd xmm0, "+a+"\n"
                                else:
                                    asm += "    movlpd [rsp-"+str(expr_stack.rsp_needed())+"], "+b+"\n"
                                    asm += "    movlpd xmm0, [rsp-"+str(expr_stack.rsp_needed())+"]\n"
                                    asm += "    subsd xmm0, "+a+"\n"

                        elif token.text == '*':
                            asm += "    ; *\n"
                            if a_type == VarType.NUM:
                                asm += "    mov rax, "+b+"\n"
                                asm += "    mov edx, eax\n"
                                asm += "    mov rax, "+a+"\n"
                                asm += "    imul eax, edx\n"
                            elif a_type == VarType.FLUM:
                                if b[0] == '[':
                                    asm += "    movlpd xmm0, "+b+"\n"
                                    asm += "    mulsd xmm0, "+a+"\n"
                                else:
                                    asm += "    movlpd [rsp-"+str(expr_stack.rsp_needed())+"], "+b+"\n"
                                    asm += "    movlpd xmm0, [rsp-"+str(expr_stack.rsp_needed())+"]\n"
                                    asm += "    mulsd xmm0, "+a+"\n"
                        elif token.text == '/':
                            asm += "    ; /\n"
                            
                            if a_type == VarType.NUM:
                                asm += "    mov rax, "+b+"\n"
                                asm += "    mov rdx, 0\n"
                                #asm += "    cqo\n"
                                asm += "    idiv "+a+'\n'
                            elif a_type == VarType.FLUM:
                                if b[0] == '[':
                                    asm += "    movlpd xmm0, "+b+"\n"
                                    asm += "    divsd xmm0, "+a+"\n"
                                else:
                                    asm += "    movlpd [rsp-"+str(expr_stack.rsp_needed())+"], "+b+"\n"
                                    asm += "    movlpd xmm0, [rsp-"+str(expr_stack.rsp_needed())+"]\n"
                                    asm += "    divsd xmm0, "+a+"\n"


                    except IndexError:
                        print("Unexpected end of stack parsing expression on line "+str(line_num+1))
                        error_free = False
                        break

                    if a_type == VarType.NUM:
                        next_loc = expr_stack.next_num()
                        if next_loc[0] == "[":
                            next_loc = "qword"+next_loc
                        asm += "    mov "+next_loc+", rax\n"
                    elif a_type == VarType.FLUM:
                        next_loc = expr_stack.next_flum()
                        if next_loc[0] == "[":
                            next_loc = "qword"+next_loc
                            asm += "    movlpd "+next_loc+", xmm0\n"
                        else:
                            asm += "    movlpd [rsp-"+str(expr_stack.rsp_needed())+"], xmm0\n"
                            asm += "    movlpd "+next_loc+", [rsp-"+str(expr_stack.rsp_needed())+"]\n"

                
                else:
                    if token.type == TokenType.UNARY_NEGATIVE:
                        asm += "    ; *-1\n"
                        a, a_type = expr_stack.pop()
                        if a_type == VarType.NUM:
                            asm += "    mov rax, -1\n"
                            asm += "    mov edx, eax\n"
                            asm += "    mov rax, "+a+"\n"
                            asm += "    imul eax, edx\n"
                            next_loc = expr_stack.next_num()
                            if next_loc[0] == "[":
                                next_loc = "qword"+next_loc
                            asm += "    mov "+next_loc+", rax\n"
                        elif a_type == VarType.FLUM:
                            asm += "    mov [rsp-"+str(expr_stack.rsp_needed())+"], __float64__(-1)\n"
                            asm += "    movlpd xmm0, [rsp-"+str(expr_stack.rsp_needed())+"]\n"
                            asm += "    mulsd xmm0, "+a+"\n"

                            next_loc = expr_stack.next_flum()
                            if next_loc[0] == "[":
                                next_loc = "qword"+next_loc
                            asm += "    movlpd "+next_loc+", xmm0\n"

            else:
                if token == Terminal.KW_PRINT:
                    a, a_type = expr_stack.pop()

                    asm += "    ; print\n"
                    # TODO ??????????????????????????????????????????????????????
                    asm += "    sub rsp, "+str(expr_stack.rsp_needed()*2)+"\n"
                    if a_type == VarType.NUM:
                        asm += "    mov rax, "+a+"\n"
                        asm += "    call printInt\n"
                    else:
                        if a[0] == '[':
                            asm += "    movlpd xmm0, "+a+"\n"
                        else:
                            asm += "    movlpd [rsp], "+a+"\n"
                            asm += "    movlpd xmm0, [rsp]\n"
                        asm += "    call printFloat\n"

                    
                    asm += "    add rsp, "+str(expr_stack.rsp_needed()*2)+"\n"

                    
        else:
            continue

    asm += ASM_TAIL


    if error_free:
        return asm
    return None
        