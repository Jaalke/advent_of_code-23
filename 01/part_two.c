#include <stdio.h>
#include <stdlib.h>

char *DIGIT_STRINGS[] = {"one", "two", "three", "four", "five", "six", "seven", "eight", "nine"}; 

void add_incomplete_word(char *og_string, char *word, int n_letters, int starting_at) {
    for (int i = 0; i < n_letters; i++) {
        og_string[starting_at + i] = word[i];
    }
}

char *word_to_digit(char *og_string, char *word, int digit) {
    char *output = (char *) calloc(128, sizeof(char));
    int word_i = 0;
    int string_i = 0;
    int output_i = 0;
    int word_detected = 0;

    while (og_string[string_i] != '\n') {

        if (word_detected == 1) {
            if (word[word_i] == '\0') {
                output[output_i] = digit + 48;
                word_i = 0;
                output_i++;
            } else if (og_string[string_i] == word[word_i]) {
                word_i++;
            } else {
                add_incomplete_word(output, word, word_i, output_i);
                word_detected = 0;
                output_i += word_i;
                word_i = 0;
            }
        } else {
            if (og_string[string_i] == word[word_i]) {
                word_detected = 1;
                word_i++;
            } else {
                output[output_i] = og_string[string_i];
                output_i++;
            }
        }

        string_i++;
    }

    return output;
}

int get_calibration_no(char *line) {
    int first_digit = 0;
    int second_digit = 0;
    int is_first_digit = 1;
    int i = 0;

    while (line[i] != '\n') {
        if (line[i] > 47 && line[i] < 58) {
            if (is_first_digit == 1) {
                first_digit = line[i] - 48;
                second_digit = first_digit;
                is_first_digit = 0;
            } else {
                second_digit = line[i] - 48;
            }
        }

        i++;
    }
    
    return first_digit * 10 + second_digit;
}

int main(int argc, char **argv) {
    // char filename[] = "input.txt";
    // FILE *input_file = fopen(filename, "r");

    // int calibration_total = 0;

    // char current_line[128];
    // while (fgets(current_line, sizeof(current_line), input_file) != NULL) {
    //     calibration_total += get_calibration_no(current_line);
    // }

    // printf("The calibration total is %d.\n", calibration_total);
    // fclose(input_file);

    char *test_string = "1dfdfhasersf32awerfseven";
    char *out_string = word_to_digit(test_string, "seven", 7);
    printf("%s\n", out_string);
    return 0;
}