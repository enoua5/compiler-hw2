from src.parser import Node
from src.token_enums import Terminal, Nonterminal

USELESS_TERMS = [Terminal.L_PAREN, Terminal.R_PAREN]
RONTS = [Nonterminal.PROD_RONT, Nonterminal.TERM_RONT, Nonterminal.VAL_RONT]
OPERATORS = [Terminal.DIV, Terminal.MULT, Terminal.PLUS, Terminal.MINUS, Terminal.EXPON]

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
    if type(parse_tree.value) == Terminal:
        ir_stack.append(parse_tree.value)
    for i in remaining:
        build_ir(i, ir_stack)
        

    return ir_stack
