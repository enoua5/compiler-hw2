from src.token import tokenize
from src.parser import verify_valid, build_tree
import src.productions
from src.ast import build_ir

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
        # line_okay = True
        # try:
        print()
        print("="*20)
        print(line)
        token_list = tokenize(line)
        tree = build_tree(token_list)
        print(tree)
        print(build_ir(tree, []))

    #     except SyntaxError:
    #         line_okay = False
        
    #     if line_okay != should_be_good:
    #         print("Line was miscategorized:", line.replace('\n',''))
    #     if line_okay:
    #         okay_lines += 1
    #     total_lines += 1
    # print("File '", file, "' had",okay_lines,'/',total_lines,"valid.")


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
    table, *ignore = src.productions.get_table()
    print_table(table)

    verify(TO_IR_FILE)
    #verify(BAD_FILE, False)