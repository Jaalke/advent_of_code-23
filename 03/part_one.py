from dataclasses import dataclass
import typing

DIGITS = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']
SYMBOLS = ['!', '@', '#', '$', '%', '^', '&', '*', '(' ,')', '-', '_', '=', '+',
           '[', ']', '{', '}', ';', ':', '\'', '|', ',', '?', '/']

@dataclass
class PartNumber:
    number: int
    on_line: int
    starts_at: int
    ends_at: int
    is_part: bool

@dataclass
class Symbol:
    symbol: str
    on_line: int
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
                    numbers.append(PartNumber(int(number), i, starts_at, j, False))
                    number = ""

    return numbers

def find_symbols(schematic_lines: list[str]) -> list[Symbol]:
    symbols = []

    for i, line in enumerate(schematic_lines):
        for j, ch in enumerate(line):
            if ch in SYMBOLS:
                symbols.append(Symbol(ch, i, j))

    return symbols

def get_vertically_adjecent_symbols(symbols: list[Symbol], line) -> list[PartNumber]:
    filter_fun = lambda x : x.on_line < line + 2 and x.on_line > line - 2
    return filter(filter_fun, symbols)

def is_horizontally_adjacent(part: PartNumber, symbol: Symbol) -> bool:
    if symbol.at > part.starts_at - 2 and symbol.at < part.ends_at + 2:
        return True
    else:
        return False

def is_part_number(part: PartNumber, symbols: list[Symbol]) -> bool:
    for symbol in get_vertically_adjecent_symbols(symbols, part.on_line):
        if is_horizontally_adjacent(part, symbol):
            return True
    return False

if __name__ == "__main__":
    with open("input.txt") as input_file:
        input_lines = input_file.readlines()

    symbols = find_symbols(input_lines)
    numbers = find_numbers(input_lines)

    part_number_sum = 0

    for number in numbers:
        if is_part_number(number, symbols):
            part_number_sum += number.number

    print(f"The sum of enigne part numbers is {part_number_sum}.")