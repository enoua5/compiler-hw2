from src.token_enums import *

OPERATORS = ['+', '-', '/', '*', '^']
SUBTRACT_AFTER = [TokenType.NUMBER, TokenType.NAME, TokenType.R_PAREN]
DIGITS = "1234567890"
NAME_CHARS = DIGITS + '_' + "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

class TermTokPair:
    def __init__(self, tok):
        if tok == SpecialSymbols.EOF:
            self.term = tok
            self.tok = tok
        else:
            self.term = Terminal(tok)
            self.tok = tok

def tokenize(line):
    # we'll keep track of this to diferentiate negative numbers and subtraction
    prev_type = None

    line = list(line)
    #print(line)
    line_iter = iter(line)
    for c in line_iter:
        #print(c)
        if (c in DIGITS):
            #print("NUMBER")
            type = TokenType.NUMBER
            
            eof_found = False

            number = c
            try:
                c = next(line_iter)
                while c in DIGITS:
                    number += c
                    #print(number)
                    c = next(line_iter)
            except StopIteration:
                eof_found = True

            yield TermTokPair(Token(number, type))
            prev_type = type

            if eof_found:
                break
        
        elif c.isalpha():
            #print("NAME")
            type = TokenType.NAME

            eof_found = False
            
            name = c
            try:
                c = next(line_iter)
                while c in NAME_CHARS:
                    name += c
                    #print(name)
                    c = next(line_iter)
            except StopIteration:
                eof_found = True

            yield TermTokPair(Token(name, type))
            prev_type = type

            if eof_found:
                break


        if (c == '-') and (prev_type not in SUBTRACT_AFTER):
            type = TokenType.UNARY_NEGATIVE
            yield TermTokPair(Token(c, type))
            prev_type = type
        # intential if instead of elif, because the lengthy ones move the interator one past their end
        elif c in OPERATORS:
            #print("OP")
            type = TokenType.OPERATOR
            yield TermTokPair(Token(c, type))
            prev_type = type
        elif c == '(':
            #print("PAREN")
            type =  TokenType.L_PAREN
            yield TermTokPair(Token(c, type))
            prev_type = type
        elif c == ')':
            #print("PAREN")
            type =  TokenType.R_PAREN
            yield TermTokPair(Token(c, type))
            prev_type = type
        elif not c.isspace():
            raise SyntaxError("Unexpected character '"+c+"'")


    yield TermTokPair(SpecialSymbols.EOF)