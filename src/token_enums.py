from enum import Enum, auto

class TokenType(Enum):
    OPERATOR = auto()
    NUMBER = auto()
    NAME = auto()
    KEYWORD = auto()
    L_PAREN = auto()
    L_CALL_PAREN = auto()
    R_PAREN = auto()
    L_CURL = auto()
    R_CURL = auto()
    COMMA = auto()
    UNARY_NEGATIVE = auto()

class Nonterminal(Enum):
    GOAL = auto()
    DECLARATION = auto()
    DECLARATION_ = auto()
    ASSIGNMENT = auto()
    IF_STATEMENT = auto()
    WHILE_STATEMENT = auto()
    FUNCTION_DECL = auto()
    RETURN = auto()
    TYPE_NAME = auto()
    PRINT = auto()
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
    FUNCTION_CALL = auto()
    PARAMETER_LIST = auto()
    PARAMETER_LIST_ = auto()
    PARAMETER_VALUE = auto()
    NAME_POST = auto()


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
    EQ = Token("=", TokenType.OPERATOR)
    NEG = Token('-', TokenType.UNARY_NEGATIVE)
    L_PAREN = Token('(', TokenType.L_PAREN)
    L_CALL_PAREN = Token('(', TokenType.L_CALL_PAREN)
    R_PAREN = Token(')', TokenType.R_PAREN)
    L_CURL = Token('{', TokenType.L_CURL)
    R_CURL = Token('}', TokenType.R_CURL)
    COMMA = Token(',', TokenType.COMMA)
    NUMBER = Token(None, TokenType.NUMBER)
    NAME = Token(None, TokenType.NAME)

    KW_PRINT = Token("print", TokenType.KEYWORD)
    KW_NUM = Token("num", TokenType.KEYWORD)
    KW_FLUM = Token("flum", TokenType.KEYWORD)
    KW_IF = Token("if", TokenType.KEYWORD)
    KW_FUNCTION = Token("function", TokenType.KEYWORD)
    KW_GIFT = Token("gift", TokenType.KEYWORD)
    KW_PARAM1 = Token("param1", TokenType.KEYWORD)
    KW_PARAM2 = Token("param2", TokenType.KEYWORD)
    KW_PARAM3 = Token("param3", TokenType.KEYWORD)
    KW_WHILE = Token("while", TokenType.KEYWORD)
