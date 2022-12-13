from src.parse import Node
from src.token_enums import Terminal, Nonterminal, Token, TokenType

USELESS_TERMS = [Terminal.L_PAREN.value, Terminal.R_PAREN.value]
OPERATORS = [Terminal.DIV.value, Terminal.MULT.value, Terminal.PLUS.value, Terminal.MINUS.value, Terminal.EXPON.value, Terminal.NEG.value, Terminal.EQ.value, Terminal.L_CALL_PAREN.value]
INCLUDED_KEYWORDS = [Terminal.KW_FLUM, Terminal.KW_NUM, Terminal.KW_PRINT, Terminal.KW_GIFT, Terminal.KW_PARAM1, Terminal.KW_PARAM2, Terminal.KW_PARAM3, Terminal.KW_FUNCTION, Terminal.KW_IF, Terminal.KW_WHILE]
APPENDED_KEYWORDS = [Terminal.KW_PRINT, Terminal.KW_GIFT]

def ir_to_string(ir):
    ret = ""
    for i in ir:
        if type(i) == Token:
            if i.type == TokenType.UNARY_NEGATIVE:
                ret += "NEG "
            else:
                ret += i.text + " "
        elif i == Terminal.KW_FLUM:
            ret += "DECLARE_FLUM" + " "
        elif i == Terminal.KW_NUM:
            ret += "DECLARE_NUM" + " "
        elif i == Terminal.KW_PRINT:
            ret += "PRINT()" + " "
        else:
            ret += str(i) + " "
    return ret

def simplify_ir(ir):
    stack = []
    end_of_calc = False
    for i in ir:
        if end_of_calc:
            stack.append(i)
            
        elif i.type == TokenType.NUMBER:
            stack.append(int(i.text))

        elif i.type == TokenType.OPERATOR:
            r_op = stack.pop()
            l_op = stack.pop()
            if i.text == '+':
                stack.append(l_op + r_op)
            if i.text == '-':
                stack.append(l_op - r_op)
            if i.text == '*':
                stack.append(l_op * r_op)
            if i.text == '/':
                stack.append(l_op / r_op)
            if i.text == '^':
                stack.append(l_op ** r_op)
        
        elif i.type == TokenType.UNARY_NEGATIVE:
            stack[-1] *= -1

        elif i.type == TokenType.NAME:
            stack.append(i)
            end_of_calc = True

    return stack

def build_ir(parse_tree, ir_stack):
    ir = _build_ir(parse_tree, ir_stack)

    if len(ir) > 0:
        if ir[0] == Terminal.KW_FUNCTION:
            # don't call a function just because it was defined
            ir.remove(Terminal.L_CALL_PAREN.value)
        if Terminal.L_CALL_PAREN.value in ir:
            # throw in an extra comma at the end of param lsits so we know to add the last expression to the call
            try:
                index = -1
                while True:
                    index = ir.index(Terminal.L_CALL_PAREN.value, index+1)
                    if index > 0:
                        ir = ir[:index] + [Terminal.COMMA.value] + ir[index:]
                        index += 1
            except:
                # .index() throws an error when something isn't found, so...
                pass

    return ir

def _build_ir(parse_tree, ir_stack):

    left_of_operator = []
    operator = None
    ront = None
    remaining = []

    phase = 0
    for child in parse_tree.children:
        if child.value in USELESS_TERMS:
            continue
        if child.value in OPERATORS:
            phase += 1
        
        if phase == 0:
            left_of_operator.append(child)
        elif phase == 1:
            operator = child
            phase += 1
        elif phase == 2:
            ront = child
            phase += 1
        else:
            remaining.append(child)
        
    for i in left_of_operator:
        _build_ir(i, ir_stack)
    if ront is not None:
        _build_ir(ront, ir_stack)
    if operator is not None:
        _build_ir(operator, ir_stack)
    if type(parse_tree.value) == Token:
        ir_stack.append(parse_tree.value)
    for i in remaining:
        _build_ir(i, ir_stack)
    if parse_tree.value in INCLUDED_KEYWORDS:
        ir_stack.append(parse_tree.value)

    if len(ir_stack) > 1 and ir_stack[0] in APPENDED_KEYWORDS:
        ir_stack = ir_stack[1:]+ir_stack[:1]

    return ir_stack
