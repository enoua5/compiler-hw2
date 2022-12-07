from src.token_enums import *

OPERATORS = ['+', '-', '/', '*', '^', '=']
KEYWORDS = {
    "print": Terminal.KW_PRINT,
    "flum": Terminal.KW_FLUM,
    "num": Terminal.KW_NUM,
    "if": Terminal.KW_IF,
    "function": Terminal.KW_FUNCTION,
    "gift": Terminal.KW_GIFT,
    "param1": Terminal.KW_PARAM1,
    "param2": Terminal.KW_PARAM2,
    "param3": Terminal.KW_PARAM3,
}
SUBTRACT_AFTER = [TokenType.NUMBER, TokenType.NAME, TokenType.R_PAREN]
DIGITS = "1234567890."
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
            used_dec_point = (number == '.')
            try:
                c = next(line_iter)
                while c in DIGITS:
                    if c == '.':
                        if used_dec_point:
                            break
                        used_dec_point = True

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

            if name in KEYWORDS:
                yield TermTokPair(KEYWORDS[name])
                prev_type = TokenType.KEYWORD
            else:
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
            if prev_type == TokenType.NAME:
                type = TokenType.L_CALL_PAREN
            else:
                type =  TokenType.L_PAREN
            yield TermTokPair(Token(c, type))
            prev_type = type
        elif c == ')':
            #print("PAREN")
            type =  TokenType.R_PAREN
            yield TermTokPair(Token(c, type))
            prev_type = type
        elif c == '{':
            type = TokenType.L_CURL
            yield TermTokPair(Token(c, type))
            prev_type = type
        elif c == '}':
            type = TokenType.R_CURL
            yield TermTokPair(Token(c, type))
            prev_type = type
        elif c == ',':
            type = TokenType.COMMA
            yield TermTokPair(Token(c, type))
            prev_type = type

        elif not c.isspace():
            raise SyntaxError("Unexpected character '"+c+"'")


    yield TermTokPair(SpecialSymbols.EOF)