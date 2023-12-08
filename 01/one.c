#include <stdio.h>

int main(int argc, char **argv) {

    int calibration_total = 0;
    int first_digit = 0;
    int second_digit = 0;
    int is_first_digit = 1;
    char current_input;

    while (current_input = getc(stdin)) {
        switch (current_input) {
            case 26:
                return 0;
                break;
            case 10:
                calibration_total += ((first_digit * 10) + second_digit);
                is_first_digit = 1;
                printf("The current calibration total is %i.\n", calibration_total);
                first_digit, second_digit = 0;
                break;
            default:
                if (current_input > 47 && current_input < 58) {
                    if (is_first_digit == 1) {
                        first_digit = (current_input - 48);
                        second_digit = first_digit;
                        is_first_digit = 0;
                    } else {
                        second_digit = (current_input - 48);
                    }
                }
            break;
        }
    }
}