#ifndef LEX_H
#define LEX_H

#include <stdio.h>

enum TokenType {
    TYPE_LPAREN = 1,
    TYPE_RPAREN,
    TYPE_PLUS,
    TYPE_MINUS,
    TYPE_MUL,
    TYPE_DIV,
    TYPE_OR,
    TYPE_AND,
    TYPE_NOT,
    TYPE_LT,
    TYPE_LE,
    TYPE_GT,
    TYPE_GE,
    TYPE_BEGIN,
    TYPE_END,
    TYPE_TRUE,
    TYPE_FALSE,
    TYPE_IF,
    TYPE_THEN,
    TYPE_ASSIGN,
    TYPE_NUMBER,
    TYPE_ID,
    TYPE_SEMI
};

typedef struct {
    char *text;
    int type;
    int line;
} Token;

int lex(FILE *fd, Token *token);

#endif
