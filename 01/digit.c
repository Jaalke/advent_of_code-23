#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void word_to_digit(char *og_string, char *word, char digit) {
    

    size_t word_len = strlen(word);
    size_t string_len = strlen(og_string);


}

int main(int argc, int **argv) {
    char *string = "aewrgaertdvsevenasdfqer2";
    char *needle = "seven";
    char *ouputstring = strstr(string, needle);
    
    if (ouputstring != NULL) {
        printf("%p\n", ouputstring - string);
    }
}