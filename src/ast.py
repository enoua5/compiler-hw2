from src.parser import Node
from src.token_enums import Terminal, Nonterminal, Token, TokenType

USELESS_TERMS = [Terminal.L_PAREN.value, Terminal.R_PAREN.value]
OPERATORS = [Terminal.DIV.value, Terminal.MULT.value, Terminal.PLUS.value, Terminal.MINUS.value, Terminal.EXPON.value, Terminal.NEG.value]

def ir_to_string(ir):
    ret = ""
    for i in ir:
        if type(i) == Token:
            if i.type == TokenType.UNARY_NEGATIVE:
                ret += "NEG "
            else:
                ret += i.text + " "
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
        build_ir(i, ir_stack)
    if ront is not None:
        build_ir(ront, ir_stack)
    if operator is not None:
        build_ir(operator, ir_stack)
    if type(parse_tree.value) == Token:
        ir_stack.append(parse_tree.value)
    for i in remaining:
        build_ir(i, ir_stack)
        

    return ir_stack
