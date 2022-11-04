from src.token import tokenize
from src.parser import verify_valid, build_tree
import src.productions
from src.ast import build_ir, ir_to_string, simplify_ir

BAD_FILE = "ll1_invalid_book.txt"
GOOD_FILE = "ll1_valid_class.txt"
BOOK_FILE = "ll1_valid_book.txt"
TO_IR_FILE = "ll1_to_ir.txt"

def verify(file):
    f = open(file, 'r')
    
    lines = f.readlines()

    # okay_lines = 0
    # total_lines = 0
    for line in lines:
        line_okay = True
        postfix = "[COULD NOT PARSE]"
        postfix_simplified = "[ERROR]"
        try:
            token_list = tokenize(line)
            tree = build_tree(token_list)
            if tree == False:
                line_okay = False
                raise Exception()
            ir = build_ir(tree, [])
            postfix = ir_to_string(ir)
            ir_simplified = simplify_ir(ir)
            postfix_simplified = ir_to_string(ir_simplified)

        except:
            
            line_okay = False
        
        print("  Valid:" if line_okay else "Invalid:", line[:-1], "........", postfix, "........", postfix_simplified)



    f.close()




def print_table(table):
    print(" "*9, end="  ")
    print("EOF".rjust(6), end="  ")
    for i in src.productions.Terminal:
        print(i.name.rjust(6), end="  ")
    print()
    for nt in src.productions.Nonterminal:
        print(nt.name.rjust(9), end="  ")
        print(str(table[(nt, src.productions.SpecialSymbols.EOF)]).rjust(7), end="  ")
        for t in src.productions.Terminal:
            print(str(table[(nt, t)]).rjust(6), end="  ")
        print()

if __name__ == '__main__':
    #table, *ignore = src.productions.get_table()
    #print_table(table)

    verify(TO_IR_FILE)
    #verify(BAD_FILE)
