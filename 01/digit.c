#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *replace_all_words(char *input_string, const char *target, char *replacement) {
    size_t word_len = strlen(target);
    size_t string_len = strlen(input_string);

    char org_string[string_len];
    strcpy(org_string, input_string);
    input_string[0] = '\0';

    char *segment_start = org_string;
    char *segment_end = org_string;
    
    while (strstr(segment_start, target) != NULL) {
        segment_end = strstr(segment_start, target);
        strncat(input_string, segment_start, segment_end - segment_start);
        strcat(input_string, replacement);
        segment_end += word_len;
        segment_start = segment_end;
    }

    strcat(input_string, segment_start);

    return input_string;
}

int main(int argc, int **argv) {
    char string[64] = "sevenpartonesevensevenparttwosevenpartthreeseven";
    char *needle = "seven";
    char *digit = "7";

    printf("%s\n", replace_all_words(string, needle, digit));
}