from src.token import tokenize
from src.parser import verify_valid
import src.productions

BAD_FILE = "ll1_invalid_book.txt"
GOOD_FILE = "ll1_valid_class.txt"
BOOK_FILE = "ll1_valid_book.txt"

def verify(file, should_be_good):
    f = open(file, 'r')
    
    lines = f.readlines()

    okay_lines = 0
    total_lines = 0
    for line in lines:
        line_okay = True
        try:
            token_list = tokenize(line)
            line_okay = verify_valid(token_list)
        except SyntaxError:
            line_okay = False
        
        if line_okay != should_be_good:
            print("Line was miscategorized:", line.replace('\n',''))
        if line_okay:
            okay_lines += 1
        total_lines += 1
    print("File '", file, "' had",okay_lines,'/',total_lines,"valid.")


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

    verify(GOOD_FILE, True)
    verify(BAD_FILE, False)