from src.token import tokenize
from src.parser import verify_valid, build_tree
import src.productions
from src.ast import build_ir, ir_to_string, simplify_ir

# BAD_FILE = "ll1_invalid_book.txt"
# GOOD_FILE = "ll1_valid_class.txt"
# BOOK_FILE = "ll1_valid_book.txt"
# TO_IR_FILE = "ll1_to_ir.txt"
GOOD_FILE = "accept-2.txt"

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
            print("="*20)
            print(line)
            token_list = tokenize(line)
            # for token in token_list:
            #     print(token.term, token.tok)
            # token_list = tokenize(line)
            tree = build_tree(token_list)
            # print()
            # print(tree)
            if tree == False:
                line_okay = False
                raise Exception()
            ir = build_ir(tree, [])
            postfix = ir_to_string(ir)
            print(postfix)
            #ir_simplified = simplify_ir(ir)
            #postfix_simplified = ir_to_string(ir_simplified)

        except:
            line_okay = False
        
        #print("  Valid:" if line_okay else "Invalid:", line[:-1], "........", ir,"........", tree)



    f.close()




def print_table(table):
    print(" "*13, end="  ")
    print("EOF".rjust(6), end="  ")
    for i in src.productions.Terminal:
        print(i.name.rjust(6), end="  ")
    print()
    for nt in src.productions.Nonterminal:
        print(nt.name.rjust(13), end="  ")
        print(str(table[(nt, src.productions.SpecialSymbols.EOF)]).rjust(7), end="  ")
        for t in src.productions.Terminal:
            print(str(table[(nt, t)]).rjust(6), end="  ")
        print()

if __name__ == '__main__':
    table, *ignore = src.productions.get_table()
    print_table(table)

    verify(GOOD_FILE)
    #verify(BAD_FILE)
