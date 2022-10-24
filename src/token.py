from enum import Enum, auto

class TokenType(Enum):
    OPERATOR = auto()
    NUMBER = auto()
    NAME = auto()
    L_PAREN = auto()
    R_PAREN = auto()
    UNARY_NEGATIVE = auto()

OPERATORS = ['+', '-', '/', '*', '^']
SUBTRACT_AFTER = [TokenType.NUMBER, TokenType.NAME, TokenType.R_PAREN]
DIGITS = "1234567890"
NAME_CHARS = DIGITS + '_' + "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    
class Token:
    def __init__(self, text, type):
        self.text = text
        self.type = type

    def __repr__(self):
        return self.type.name+": '"+str(self.text)+"'"

    def __eq__(self, other):
        if self.type != other.type:
            return False
        # if text is set to None, we only care if the types match
        if self.text == None or other.text == None:
            return True
        return self.text == other.text

def tokenize(line):
    tokens = []

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

            tokens.append(Token(number, type))
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

            tokens.append(Token(name, type))
            prev_type = type

            if eof_found:
                break


        if (c == '-') and (prev_type not in SUBTRACT_AFTER):
            type = TokenType.UNARY_NEGATIVE
            tokens.append(Token(c, type))
            prev_type = type
        # intential if instead of elif, because the lengthy ones move the interator one past their end
        elif c in OPERATORS:
            #print("OP")
            type = TokenType.OPERATOR
            tokens.append(Token(c, type))
            prev_type = type
        elif c == '(':
            #print("PAREN")
            type =  TokenType.L_PAREN
            tokens.append(Token(c, type))
            prev_type = type
        elif c == ')':
            #print("PAREN")
            type =  TokenType.R_PAREN
            tokens.append(Token(c, type))
            prev_type = type
        elif not c.isspace():
            raise SyntaxError("Unexpected character '"+c+"'")


    return tokens