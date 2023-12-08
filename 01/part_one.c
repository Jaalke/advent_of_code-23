#include <stdio.h>

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
    char filename[] = "input_one.txt";
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