from dataclasses import dataclass
import typing

DIGITS = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']
SYMBOLS = ['!', '@', '#', '$', '%', '^', '&', '*', '(' ,')', '-', '_', '=', '+',
           '[', ']', '{', '}', ';', ':', '\'', '|', ',', '?', '/']

@dataclass
class PartNumber:
    number: int
    starts_at: tuple[int]
    ends_at: tuple[int]
    is_part: bool
    neighbor_grids: list[tuple[int]]

@dataclass
class Symbol:
    symbol: str
    at: int
    neighbor_grids: list[tuple[int]]

def calculate_neighbor_grids(starts_at: int, ends_at: int, line_no: tuple[int]):
    grids: tuple[int] = ()
    if line_no[0] != 0:
        for i in range(starts_at):
            pass

def find_numbers_in_line(line: str, line_no: tuple[int]) -> list[PartNumber]:
    global DIGITS
    numbers: list[PartNumber] = []
    starts_at: int = -1
    scaning_number: bool = False
    scanned_number: str = ""
    for i, char in enumerate(line):
        if char in DIGITS:
            if not scaning_number:
                scaning_number = True
                starts_at = i
            scanned_number + char
        else:
            if scaning_number:
                numbers.append(PartNumber(int(scaning_number), (line_no[0], starts_at),
                                          (line_no[0], i - 1), False, 
                                          calculate_neighbor_grids(starts_at, i - 1, line_no)))
                scaning_number = False
                starts_at = -1
                


def find_symbols_in_line(line: str) -> list[Symbol]:
    global SYMBOLS
    pass

if __name__ == "__main__":
    with open("input.txt") as input_file:
        input_lines = input_file.readlines()

    symbols = list[Symbol]
    part_numbers = list[PartNumber]

    for i, line in enumerate(input_lines):
        print(line)