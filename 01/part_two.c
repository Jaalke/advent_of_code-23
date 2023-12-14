#include <stdio.h>
#include <stdlib.h>
#include <string.h>

const char *DIGIT_WORDS[] = {"one", "two", "three", "four", "five", "six", "seven", "eight", "nine"}; 
const char *DIGIT_SYMBOLS[] = {"1", "2", "3", "4", "5", "6", "7", "8", "9"};

int *mark_occurrences(int *mark_array, char *input_string, const char *word, int digit) {
    // Returns an int array the length of the input string, with digits 1-9 marked 
    // at positions they start in the string, and 0 for positions with no digit
    // starting at that position in the string. For "1twof", the return is [1,2,0,0,0]

    size_t word_len = strlen(word);
    size_t string_len = strlen(input_string);
    
    for (int i = 0; i < string_len; i++) {
        int is_matched = 1;
        for (int j = 0; j < word_len; j++) {
            if (input_string[i + j] != word[j]) {
                is_matched = 0;
                break;
            }
        }
        if (is_matched == 1) {
            mark_array[i] = digit;
        }
    }
}

int get_calibration_no(char *line) {
    int first_digit = 0;
    int second_digit = 0;
    int is_first_digit = 1;
    int i = 0;

    int *digit_array = (int *) calloc(strlen(line), sizeof(int));

    for (int i = 0; i < 9; i++) {
        mark_occurrences(digit_array, line, DIGIT_WORDS[i], i + 1);
        mark_occurrences(digit_array, line, DIGIT_SYMBOLS[i], i + 1);
    }

    for (int i = 0; i < strlen(line); i++) {
        if (digit_array[i] != 0) {
            if (is_first_digit == 1) {
                is_first_digit = 0;
                first_digit = digit_array[i];
                second_digit = first_digit;
            } else {
                second_digit = digit_array[i];
            }
        }
    }

    return first_digit * 10 + second_digit;
}

int main(int argc, char **argv) {
    char filename[] = "input.txt";
    FILE *input_file = fopen(filename, "r");

    int calibration_total = 0;

    char current_line[128];
    while (fgets(current_line, sizeof(current_line), input_file) != NULL) {
        calibration_total += get_calibration_no(current_line);
    }

    printf("The calibration total is %d.\n", calibration_total);
    fclose(input_file);

    return 0;
}