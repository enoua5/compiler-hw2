from enum import Enum, auto
from src.token_enums import Terminal
from src.compile import PARAM_REGISTERS

class VarType(Enum):
    NUM = auto()
    FLUM = auto()

def term_to_type(kw:Terminal) -> VarType:
    if kw == Terminal.KW_NUM:
        return VarType.NUM
    if kw == Terminal.KW_FLUM:
        return VarType.FLUM
    return None

class AlreadyDefinedException(LookupError):
    pass

class VariableInfo:
    type: VarType
    offset: int

    def __init__(self, type: VarType, offset: int):
        self.type = type
        self.offset = offset + 1

class Scope:
    vars: dict[VariableInfo]
    start_offset: int
    end_offset: int

    def __init__(self, offset: int):
        self.start_offset = offset
        self.end_offset = offset
        self.vars = {}

    def add_var(self, var_name: str, var_type: VarType) -> VariableInfo:
        if var_name in self.vars:
            raise AlreadyDefinedException(var_name)

        self.vars[var_name] = VariableInfo(var_type, self.end_offset)
        self.end_offset += 1

    def get_info(self, var_name: str) -> VariableInfo | None:
        # returns None if not found
        return self.vars.get(var_name)

class SymbolTable:
    table: list[Scope]

    def __init__(self):
        self.table = [Scope(0)]

    def new_scope(self)->None:
        try:
            last_end = self.table[-1].end_offset
        except:
            last_end = 0
        self.table.append(Scope(last_end))

    # a False return value indicates that the global scope has been popped
    def pop_scope(self)->bool:
        try:
            self.table.pop()
            if len(self.table) == 0:
                return False
            return True
        except IndexError:
            return False

    # can raise AlreadyDefinedException
    def add_var(self, var_name: str, var_type: VarType) -> VariableInfo:
        return self.table[-1].add_var(var_name, var_type)

    def get_info(self, var_name:str) -> VariableInfo | None:
        for scope in reversed(self.table):
            search = scope.get_info(var_name)
            if search is not None:
                return search
        return None

    def top_of_stack(self) -> int:
        return self.table[-1].end_offset
    

    