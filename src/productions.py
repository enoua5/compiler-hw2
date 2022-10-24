from enum import Enum, auto
from tokenize import Token
from src.token import Token, TokenType

class Nonterminal(Enum):
    GOAL = auto()
    PROD = auto()
    PROD_ = auto()
    TERM = auto()
    TERM_ = auto()
    FACTOR = auto()
    FACT_VAL = auto()
    EXPR = auto()
    EXPR_ = auto()

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

class CFG_rhs:
    def __init__(self, prod_list: list[Terminal|Nonterminal]):
        self.prod_list = prod_list

class CFG:
    def __init__(self):
        self.productions = {}
        self.productions_arr = []

    def add_production(self, lhs: Nonterminal, rhs: CFG_rhs):
        if not lhs in self.productions:
            self.productions[lhs] = []
        self.productions[lhs].append(rhs)
        self.productions_arr.append((lhs, rhs))

    def __repr__(self) -> str:
        return self.productions.__repr__()


def get_class_productions():
    cfg = CFG()

    cfg.add_production(Nonterminal.GOAL, [Nonterminal.EXPR])
    cfg.add_production(Nonterminal.GOAL, [SpecialSymbols.EMPTY])

    cfg.add_production(Nonterminal.EXPR, [Nonterminal.PROD, Nonterminal.EXPR_])
    cfg.add_production(Nonterminal.EXPR_, [Terminal.EXPON, Nonterminal.PROD, Nonterminal.EXPR_])
    cfg.add_production(Nonterminal.EXPR_, [SpecialSymbols.EMPTY])

    cfg.add_production(Nonterminal.PROD, [Nonterminal.TERM, Nonterminal.PROD_])

    cfg.add_production(Nonterminal.PROD_, [Terminal.PLUS, Nonterminal.TERM, Nonterminal.PROD_])
    cfg.add_production(Nonterminal.PROD_, [Terminal.MINUS, Nonterminal.TERM, Nonterminal.PROD_])
    cfg.add_production(Nonterminal.PROD_, [SpecialSymbols.EMPTY])

    cfg.add_production(Nonterminal.TERM, [Nonterminal.FACT_VAL, Nonterminal.TERM_])

    cfg.add_production(Nonterminal.TERM_, [Terminal.MULT, Nonterminal.FACT_VAL, Nonterminal.TERM_])
    cfg.add_production(Nonterminal.TERM_, [Terminal.DIV, Nonterminal.FACT_VAL, Nonterminal.TERM_])
    cfg.add_production(Nonterminal.TERM_, [SpecialSymbols.EMPTY])

    cfg.add_production(Nonterminal.FACT_VAL, [Terminal.NEG, Nonterminal.FACTOR])
    cfg.add_production(Nonterminal.FACT_VAL, [Nonterminal.FACTOR])

    cfg.add_production(Nonterminal.FACTOR, [Terminal.L_PAREN, Nonterminal.EXPR, Terminal.R_PAREN])
    cfg.add_production(Nonterminal.FACTOR, [Terminal.NUMBER])
    cfg.add_production(Nonterminal.FACTOR, [Terminal.NAME])

    return cfg

def get_book_productions():
    cfg = CFG()

    cfg.add_production(Nonterminal.GOAL, [Nonterminal.EXPR])

    cfg.add_production(Nonterminal.EXPR, [Nonterminal.TERM, Nonterminal.PROD_])

    cfg.add_production(Nonterminal.EXPR_, [Terminal.PLUS, Nonterminal.TERM, Nonterminal.EXPR_])
    cfg.add_production(Nonterminal.EXPR_, [Terminal.MINUS, Nonterminal.TERM, Nonterminal.EXPR_])
    cfg.add_production(Nonterminal.EXPR_, [SpecialSymbols.EMPTY])

    cfg.add_production(Nonterminal.TERM, [Nonterminal.FACTOR, Nonterminal.TERM_])

    cfg.add_production(Nonterminal.TERM_, [Terminal.MULT, Nonterminal.FACTOR, Nonterminal.TERM_])
    cfg.add_production(Nonterminal.TERM_, [Terminal.DIV, Nonterminal.FACTOR, Nonterminal.TERM_])
    cfg.add_production(Nonterminal.TERM_, [SpecialSymbols.EMPTY])

    cfg.add_production(Nonterminal.FACTOR, [Terminal.L_PAREN, Nonterminal.EXPR, Terminal.R_PAREN])
    cfg.add_production(Nonterminal.FACTOR, [Terminal.NUMBER])
    cfg.add_production(Nonterminal.FACTOR, [Terminal.NAME])

    return cfg


class SpecialSymbols(Enum):
    EOF = auto()
    EMPTY = auto()

def get_FIRST():
    FIRST = {}
    prod = get_class_productions().productions_arr

    # for each α ∈ (T ∪ eof ∪ ϵ) do;
    for term in Terminal:
        # FIRST(α) ← α;
        FIRST[term] = {term}
    FIRST[SpecialSymbols.EOF] = {SpecialSymbols.EOF}
    FIRST[SpecialSymbols.EMPTY] = {SpecialSymbols.EMPTY}

    # for each A ∈ NT do;
    for nt in Nonterminal:
        # FIRST(A) ← ∅ ;
        FIRST[nt] = set()

    # while (FIRST sets are still changing) do;
    FIRST_changed = True
    while FIRST_changed:
        FIRST_changed = False
        # for each p ∈ P, where p has the form A→β do;
        for A,B in prod:
            # if β is β1β2 ...βk , where βi ∈ T ∪ NT, then begin;
            i=0
            k = len(B)
            if SpecialSymbols.EMPTY not in B and SpecialSymbols.EOF not in B:
                # rhs ← FIRST(β1) − {ϵ};
                rhs = FIRST[B[0]] - {SpecialSymbols.EMPTY}
                # i ← 1;
                i = 0
                # while (ϵ ∈ FIRST(βi) and i ≤ k-1) do;
                while (SpecialSymbols.EMPTY in FIRST[B[i]]) and i <= k-2:
                    # rhs ← rhs ∪ (FIRST(βi+1) − {ϵ}) ;
                    rhs = rhs.union(FIRST[B[i+1]] - {SpecialSymbols.EMPTY})
                    # i ← i + 1;
                    i += 1

            # if i = k and ϵ ∈ FIRST(βk)
            if i == k-1 and SpecialSymbols.EMPTY in FIRST[B[k-1]]:
                # then rhs ← rhs ∪ {ϵ};
                rhs = rhs.union({SpecialSymbols.EMPTY})
            # FIRST(A) ← FIRST(A) ∪ rhs;
            new_A = FIRST[A].union(rhs)
            if new_A != FIRST[A]:
                FIRST[A] = new_A
                FIRST_changed = True



    return (FIRST, prod)

def get_FOLLOW():
    FIRST, prod = get_FIRST()
    FOLLOW = {}

    # for each A ∈ N T do;
    for nt in Nonterminal:
        # FOLLOW(A) ← ∅ ;
        FOLLOW[nt] = set()

    # FOLLOW(S) ← {eof} ;
    # I think???? this is what it means?
    FOLLOW[Nonterminal.GOAL] = {SpecialSymbols.EOF}

    # while (FOLLOW sets are still changing) do;
    FOLLOW_changed = True
    while FOLLOW_changed:
        FOLLOW_changed = False
        # for each p ∈ P of the form A→β1β2 ···βk do;
        for A,B in prod:
            # TRAILER ← FOLLOW(A);
            TRAILER = set(FOLLOW[A])
            # for i ← k down to 1 do;
            k = len(B)
            for i in range(k-1, -1, -1):
                # if βi ∈ NT then begin;
                if B[i] in Nonterminal:
                    # FOLLOW(βi) ← FOLLOW(βi) ∪ TRAILER;
                    new_FOLLOW = FOLLOW[B[i]].union(TRAILER)
                    if new_FOLLOW != FOLLOW[B[i]]:
                        FOLLOW[B[i]] = new_FOLLOW
                        FOLLOW_changed = True
                    
                    # if ϵ ∈ FIRST(βi)
                    if SpecialSymbols.EMPTY in FIRST[B[i]]:
                        # then TRAILER ← TRAILER ∪ (FIRST(βi) − ϵ);
                        TRAILER = TRAILER.union(FIRST[B[i]] - {SpecialSymbols.EMPTY})
                    else:
                        # else TRAILER ← FIRST(βi);
                        TRAILER = set(FIRST[B[i]])
                else:
                    # else TRAILER ← FIRST(βi); // is {βi}
                    TRAILER = set(FIRST[B[i]])
    return (FOLLOW, FIRST, prod)

def get_FIRST_P():
    FOLLOW, FIRST, prod = get_FOLLOW()
    FIRST_P = []

    for A,B in prod:
        FIRST_S = set()
        for Bi in B:
            FIRST_S = FIRST_S.union(FIRST[Bi])
            if SpecialSymbols.EMPTY not in FIRST[Bi]:
                break
        if SpecialSymbols.EMPTY  in FIRST_S:
            FIRST_S = FIRST_S.union(FOLLOW[A])
        FIRST_P.append(FIRST_S)

    return (FIRST_P, prod)

def get_table():
    FIRST_P, prod = get_FIRST_P()

    table = {}

    # for each nonterminal A do;
    for A in Nonterminal:
        # for each terminal w do;
        for w in Terminal:
            # Table[A ,w] ← error;
            table[(A,w)] = -1
        table[(A,SpecialSymbols.EOF)] = -1
        # for each production p of the form A→β do;
        for p in range(len(prod)):
            A,B = prod[p]
            # for each terminal w ∈ FIRST+(A→β) do;
            for w in FIRST_P[p]:
                if type(w) is not Terminal:
                    continue
                if table.get((A,w)) not in [-1, None, p]:
                    raise Exception("BACKTRACK DEPENDENCY DETECTED! PANIC!")
                table[(A,w)] = p
            if SpecialSymbols.EOF in FIRST_P[p]:
                if table.get((A,SpecialSymbols.EOF)) not in [-1, None, p]:
                    raise Exception("BACKTRACK DEPENDENCY DETECTED! PANIC!")
                table[(A,SpecialSymbols.EOF)] = p

    return (table, prod)
