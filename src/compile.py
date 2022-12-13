
from src.tokenizer import tokenize
from src.parse import build_tree
from src.tree import build_ir, ir_to_string
from src.token_enums import Terminal, TokenType, Token

CALC_REGISTER_ORDER = [
    "rcx",
    "rbx",
    "rsi",
    "rdi",
    "r8",
    "r9",
    "r10",
    "r14",
    "r15",
]

PARAM_REGISTERS = {
    "param1": "r11",
    "param2": "r12",
    "param3": "r13",
}

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

from src.symbol_table import SymbolTable, VarType, VariableInfo, AlreadyDefinedException, term_to_type

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
            # TODO this is incorrect
            place = "[rbp-"+str(self.real_stack_base + self.nums_on_real_stack + self.flums_on_real_stack + 1)+"]"
            self.nums_on_real_stack += 1

        self.locations_used.append(place)
        self.types.append(VarType.NUM)
        self.num_stack_length += 1
        return place

    def next_flum(self) -> str:
        if len(FLUM_REGISTER_ORDER) > self.flum_stack_length:
            place = FLUM_REGISTER_ORDER[self.flum_stack_length]
        else:
            # TODO this is incorrect
            place = "[rbp-"+str(self.real_stack_base + self.nums_on_real_stack + self.flums_on_real_stack + 1)+"]"
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

class FunctionCallInfo:
    def __init__(self, name:str):
        self.name = name
        self.param_count = 0
    def next_location(self) -> str|None:
        if self.param_count >= len(PARAM_REGISTERS):
            return None
        self.param_count += 1
        reg = PARAM_REGISTERS["param"+str(self.param_count)]
        return reg

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
    sub     rsp, !!main rsp offset!!
"""

ASM_TAIL = """
exit:
    add rsp, !!main rsp offset!!
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

    local_table = SymbolTable()
    main_table = SymbolTable()
    table = main_table
    function_list = []
    if_label_count = 0
    end_label_stack = []

    for line_num, line in enumerate(lines):
        print('----')
        print(str(line_num).rjust(4,'0'),":",line)
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
        print(ir)
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
        function_call_stack = []
        prev_token = None
        first_token = None
        ir_iter = iter(ir)
        for token in ir_iter:
            if first_token is None:
                first_token = token

            if type(token) == Token:
                if token.type == TokenType.NAME:
                    if token.text in function_list:
                        asm += "    ; preparing to call " + token.text + '\n'
                        function_call_stack.append(FunctionCallInfo(token.text))
                    else:
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
                        try:
                            a, a_type = expr_stack.pop()
                        except:
                            print("Malformed expression on line",line_num)
                            error_free = False
                            break
                        if assignment_location.type != a_type:
                            print("Mismatch of types in assignment on line "+str(line_num))
                            error_free = False
                            break

                        if a_type == VarType.NUM:
                            asm += "    mov qword[rbp-"+str(assignment_location.offset*8)+"], "+a+"\n"
                        elif a_type == VarType.FLUM:
                            asm += "    movlpd qword[rbp-"+str(assignment_location.offset*8)+"], "+a+"\n"


                        continue
                    
                    try:
                        a, a_type = expr_stack.pop()
                        b, b_type = expr_stack.pop()
                    except:
                        print("Malformed expression on line",line_num)
                        error_free = False
                        break
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

                elif token.type == TokenType.L_CURL:
                    table.new_scope()

                    if first_token == Terminal.KW_IF:
                        a, a_type = expr_stack.pop()
                        asm += "    ; if\n"
                        asm += "    cmp "+a+", 0\n"
                        end_label = "end_if_"+str(if_label_count)
                        if_label_count += 1 
                        asm += "    jz "+end_label+"\n"
                        end_label_stack.append(end_label)
                        print(end_label_stack)

                elif token.type == TokenType.R_CURL:
                    pop_success = table.pop_scope()
                    if not pop_success:
                        table.new_scope()
                        print("Unexpected end of scope on line",line_num)
                        error_free = False
                        break
                    end_label = end_label_stack.pop()

                    if end_label.startswith("end_function"):
                        table = main_table
                        asm += "    ; prepare to exit function\n"
                        asm += "    add rsp, "+str(local_table.get_rsp_offset())+"\n"
                        asm += "    pop rbp\n"
                        asm += "    ret\n"
                        function_name = end_label.replace("end_function_", "", 1)
                        asm = asm.replace("!!function "+function_name+" rsp!!", str(local_table.get_rsp_offset()))
                        local_table.clear()

                    asm += end_label+":\n"

                elif token.type == TokenType.COMMA:
                        if type(prev_token) == Token and prev_token.type == TokenType.NAME and prev_token.text in function_list:
                            pass
                        else:
                            asm += "    ; add as param\n"
                            try:
                                a, a_type = expr_stack.pop()
                            except:
                                print("Malformed expression on line",line_num)
                                error_free = False
                                break
                            if a_type != VarType.NUM:
                                print("Error on line",line_num,": only nums can be passed as a parameter")
                                error_free = False
                                break
                            try:
                                param_loc = function_call_stack[-1].next_location()
                                if param_loc is None:
                                    print("More than max arguments supplied to function on line",line_num)
                                    error_free = False
                                    break
                                asm += "    mov "+param_loc+", "+a+"\n"

                            except Exception as e:
                                print("Malformed expression on line",line_num)
                                error_free = False
                                break
                
                elif token.type == TokenType.L_CALL_PAREN:
                    asm += "    ; call\n"
                    function_to_call = function_call_stack.pop().name
                    asm += "    push r11\n"
                    asm += "    push r12\n"
                    asm += "    push r13\n"
                    asm += "    call function_"+function_to_call+"\n"
                    asm += "    pop r13\n"
                    asm += "    pop r12\n"
                    asm += "    pop r11\n"
                    next_loc = expr_stack.next_num()
                    if next_loc[0] == "[":
                        next_loc = "qword"+next_loc
                    asm += "    mov "+next_loc+", rax\n"

                elif token.type == TokenType.UNARY_NEGATIVE:
                    asm += "    ; *-1\n"
                    try:
                        a, a_type = expr_stack.pop()
                    except:
                        print("Malformed expression on line",line_num)
                        error_free = False
                        break
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
                    try:
                        a, a_type = expr_stack.pop()
                    except:
                        print("Malformed expression on line",line_num)
                        error_free = False
                        break

                    asm += "    ; print\n"
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

                    
                    # asm += "    add rsp, "+str(expr_stack.rsp_needed()*2)+"\n"

                if token == Terminal.KW_FUNCTION:
                    function_name = next(ir_iter)
                    if type(function_name) != Token or function_name.type != TokenType.NAME:
                        print("Expected function name on line", line_num)
                        error_free = False
                        break
                    function_name = function_name.text
                    if function_name in function_list:
                        print("Redefinition of function", function_name, "on line", line_num)
                        error_free = False
                        break

                    function_list.append(function_name)
                    end_label_stack.append("end_function_"+function_name)

                    asm += "    jmp end_function_"+function_name+"\n"
                    asm += "function_"+function_name+":\n"
                    asm += "    push rbp\n"
                    asm += "    mov rbp, rsp\n"
                    asm += "    sub rsp, !!function "+function_name+" rsp!!\n"
                    table = local_table

                if token == Terminal.KW_PARAM1:
                    asm += "    ; param1 \n"
                    expr_stack.locations_used.append(PARAM_REGISTERS["param1"])
                    expr_stack.types.append(VarType.NUM)
                if token == Terminal.KW_PARAM2:
                    asm += "    ; param2 \n"
                    expr_stack.locations_used.append(PARAM_REGISTERS["param2"])
                    expr_stack.types.append(VarType.NUM)
                if token == Terminal.KW_PARAM3:
                    asm += "    ; param3 \n"
                    expr_stack.locations_used.append(PARAM_REGISTERS["param3"])
                    expr_stack.types.append(VarType.NUM)

                if token == Terminal.KW_GIFT:
                    asm += "    ; gift\n"
                    try:
                        a, a_type = expr_stack.pop()
                    except:
                        print("Malformed expression on line",line_num)
                        error_free = False
                        break
                    if a_type != VarType.NUM:
                        print("Attempt to return non-num on line",line_num)
                        error_free = False
                        break
                    asm += "    mov rax, "+a+"\n"
                    asm += "    add rsp, "+str(local_table.get_rsp_offset())+"\n"
                    asm += "    pop rbp\n"
                    asm += "    ret\n"


            prev_token = token

                    
        else:
            continue

    asm += ASM_TAIL

    asm = asm.replace("!!main rsp offset!!", str(main_table.get_rsp_offset()))

    if error_free:
        return asm
    return None
        