from src.token import tokenize
from src.parser import verify_valid, build_tree
import src.productions
from src.ast import build_ir, ir_to_string, simplify_ir
from src.compile import compile

# BAD_FILE = "ll1_invalid_book.txt"
# GOOD_FILE = "ll1_valid_class.txt"
# BOOK_FILE = "ll1_valid_book.txt"
# TO_IR_FILE = "ll1_to_ir.txt"
GOOD_FILE = "files/accept-2-no-flum.txt"
OUT_FILE = "out.nasm"

def verify(file):
    asm = compile(file)
    if asm is None:
        print("Failed to compile")
    else:
        f = open(OUT_FILE, 'w')
        f.write(asm)
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

    verify(GOOD_FILE)
    #verify(BAD_FILE)
