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

@dataclass
class Symbol:
    symbol: str
    at: int

def find_numbers(schematic_lines: list[str]) -> list[PartNumber]:
    numbers = []
    
    for i, line in enumerate(schematic_lines):
        reading_number = False
        number = ""
        starts_at = 0
        for j, ch in enumerate(line):
            if ch in DIGITS:
                if not reading_number:
                    starts_at = j
                number += ch
                reading_number = True
            else:
                if reading_number:
                    reading_number = False
                    numbers.append(PartNumber(int(number), starts_at, j, False))
                    number = ""

    return numbers

def find_symbols(schematic_lines: list[str]) -> list[Symbol]:
    symbols = []

    for i, line in enumerate(schematic_lines):
        for j, ch in enumerate(line):
            if ch in SYMBOLS:
                symbols.append(Symbol(ch, j))

    return symbols


if __name__ == "__main__":
    with open("input.txt") as input_file:
        input_lines = input_file.readlines()

    symbols = find_symbols(input_lines)
    numbers = find_numbers(input_lines)

    print( [number.number for number in numbers] )
    print( [symbol.symbol for symbol in symbols] )