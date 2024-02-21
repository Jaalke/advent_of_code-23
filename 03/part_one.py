import schematic

if __name__ == "__main__":
    with open("input.txt") as input_file:
        input_lines = input_file.readlines()

    symbols = schematic.find_symbols(input_lines)
    numbers = schematic.find_numbers(input_lines)

    part_number_sum = 0

    for number in numbers:
        if schematic.is_part_number(number, symbols):
            part_number_sum += number.number

    print(f"The sum of enigne part numbers is {part_number_sum}.")