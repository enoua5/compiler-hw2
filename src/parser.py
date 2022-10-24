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
        elif type(focus) is Terminal or focus == SpecialSymbols.EOF:
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
            