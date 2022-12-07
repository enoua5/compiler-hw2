from src.productions import SpecialSymbols, Terminal, Nonterminal, get_table

LOOKAHEAD, PROD = get_table()

def verify_valid(word_iter):
    # word ← NextWord( );
    word = next(word_iter)
    # push eof onto Stack;
    stack = []
    stack.append(SpecialSymbols.EOF)
    # push the start symbol, S, onto Stack;
    stack.append(Nonterminal.GOAL)
    # focus ← top of Stack;
    focus = stack[-1]
    # loop forever;
    while True:
        # if (focus = eof and word = eof)
        if focus == SpecialSymbols.EOF and word == SpecialSymbols.EOF:
            # then report success and exit the loop;
            return True
        # else if (focus ∈ T or focus = eof) then begin;
        if type(focus) is Terminal or focus == SpecialSymbols.EOF:
            # if focus matches word then begin;
            if focus == word:
                # pop Stack;
                stack.pop()
                # word ← NextWord( );
                word = next(word_iter)
            # else report an error looking for symbol at top of stack;
            else:
                return False
        # else begin; /* focus is a nonterminal */
        else:
            # if Table[focus,word] is A → B1B2 ··· Bk then begin;
            if LOOKAHEAD[(focus, word)] != -1:
                (A,B) = PROD[LOOKAHEAD[(focus, word)]]
                k = len(B)
                # pop Stack;
                stack.pop()
                # for i ← k to 1 by -1 do;
                for i in range(k-1, -1, -1):
                    # if (Bi ≠ ϵ)
                    if B[i] != SpecialSymbols.EMPTY:
                        # then push Bi onto Stack;
                        stack.append(B[i])
            # else report an error expanding focus;
            else:
                return False
        # focus ← top of Stack;
        focus = stack[-1]

class Node:
    def __init__(self, value):
        self.value = value
        self.children = []
        self.parent = None

    def _to_string(self, depth=0):
        ret = (" "*depth)+str(self.value.__repr__())+"\n"
        for i in self.children:
            ret += i._to_string(depth+1)
        if len(self.children) != 0:
            orig_rep = str(self.value.__repr__())
            slash_rep = orig_rep[:1] + '/' + orig_rep[1:]
            ret += (" "*depth)+slash_rep+"\n"
        return ret

    def __str__(self):
        return self._to_string()

    def add_child(self, child):
        child.parent = self
        self.children = [child] + self.children

class symbol_pair:
    def __init__(self, item):
        self.item = item
        self.node = Node(item)

def build_tree(word_iter):
    
    # word ← NextWord( );
    word = next(word_iter)
    # push eof onto Stack;
    stack = []
    stack.append(symbol_pair(SpecialSymbols.EOF))
    # push the start symbol, S, onto Stack;
    stack.append(symbol_pair(Nonterminal.GOAL))
    # focus ← top of Stack;
    tree_root = stack[-1].node
    focus = stack[-1]
    # loop forever;
    while True:
        # if (focus = eof and word = eof)
        if focus.item == SpecialSymbols.EOF and word.term == SpecialSymbols.EOF:
            # then report success and exit the loop;
            return tree_root
        # else if (focus ∈ T or focus = eof) then begin;
        if type(focus.item) is Terminal or focus == SpecialSymbols.EOF:
            # if focus matches word then begin;
            if focus.item == word.term:
                focus.node.value = word.tok
                # pop Stack;
                stack.pop()
                # word ← NextWord( );
                word = next(word_iter)
            # else report an error looking for symbol at top of stack;
            else:
                return False
        # else begin; /* focus is a nonterminal */
        else:
            # if Table[focus,word] is A → B1B2 ··· Bk then begin;
            if LOOKAHEAD[(focus.item, word.term)] != -1:
                (A,B) = PROD[LOOKAHEAD[(focus.item, word.term)]]
                k = len(B)
                # pop Stack;
                stack.pop()
                # for i ← k to 1 by -1 do;
                for i in range(k-1, -1, -1):
                    # if (Bi ≠ ϵ)
                    if B[i] != SpecialSymbols.EMPTY:
                        # then push Bi onto Stack;
                        stack.append(symbol_pair(B[i]))
                        focus.node.add_child(stack[-1].node)
                        if type(stack[-1].item) is Terminal:
                            stack[-1].node.value = word.tok
            # else report an error expanding focus;
            else:
                return False
        # focus ← top of Stack;
        focus = stack[-1]
