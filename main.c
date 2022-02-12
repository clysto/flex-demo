#include "lex.h"
#include <stdio.h>

int main(int argc, char const *argv[]) {
    Token token;
    FILE *fd;
    if (argc < 2) {
        fd = stdin;
    } else {
        fd = fopen(argv[1], "r");
        if (fd == NULL) {
            fprintf(stderr, "file not found\n");
            return -1;
        }
    }
    while (lex(fd, &token)) {
        printf("line: %2d,\ttype: %2d,\ttoken: `%s`\n", token.line, token.type,
               token.text);
    }
    return 0;
}
