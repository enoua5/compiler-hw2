from enum import Enum, auto

class TokenType(Enum):
    OPERATOR = auto()
    NUMBER = auto()
    NAME = auto()
    L_PAREN = auto()
    R_PAREN = auto()
    UNARY_NEGATIVE = auto()

class Nonterminal(Enum):
    GOAL = auto()
    PROD = auto()
    PROD_ = auto()
    PROD_RONT = auto()
    TERM = auto()
    TERM_ = auto()
    TERM_RONT = auto()
    FACTOR = auto()
    FACT_VAL = auto()
    VAL_RONT = auto()
    EXPR = auto()
    EXPR_ = auto()


class SpecialSymbols(Enum):
    EOF = auto()
    EMPTY = auto()

    
class Token:
    def __init__(self, text, type):
        self.text = text
        self.type = type

    def __repr__(self):
        return self.type.name+": '"+str(self.text)+"'"

    def __eq__(self, other):
        if type(self) != type(other):
            return False
        if self.type != other.type:
            return False
        # if text is set to None, we only care if the types match
        if self.text == None or other.text == None:
            return True
        return self.text == other.text

class Terminal(Enum):
    EXPON = Token("^", TokenType.OPERATOR)
    PLUS = Token("+", TokenType.OPERATOR)
    MINUS = Token("-", TokenType.OPERATOR)
    MULT = Token("*", TokenType.OPERATOR)
    DIV = Token("/", TokenType.OPERATOR)
    NEG = Token(None, TokenType.UNARY_NEGATIVE)
    L_PAREN = Token(None, TokenType.L_PAREN)
    R_PAREN = Token(None, TokenType.R_PAREN)
    NUMBER = Token(None, TokenType.NUMBER)
    NAME = Token(None, TokenType.NAME)
