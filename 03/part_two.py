import schematic

if __name__ == "__main__":
    with open("input.txt") as input_file:
        input_lines = input_file.readlines()

    symbols = schematic.find_symbols(input_lines)
    numbers = schematic.find_numbers(input_lines)

    gear_ratios_sum = 0

    for symbol in symbols:
        gear_ratios_sum += schematic.get_gear_ratio(symbol, numbers)

    print(f"The sum of gear ratios is {gear_ratios_sum}")