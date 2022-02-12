%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "lex.h"
void unrecognized(const char *text, int line);
%}

%option yylineno
%option noyywrap

delim       [ \t]
ws          {delim}+
letter      [A-Za-z]
digit       [0-9]
id          {letter}({letter}|{digit})*
number      {digit}+(\.{digit}+)?

%%
{ws}        /* ignore white spaces */
"("         return TYPE_LPAREN;
")"         return TYPE_RPAREN;
"+"         return TYPE_PLUS;
"-"         return TYPE_MINUS;
"*"         return TYPE_MUL;
"/"         return TYPE_DIV;
"||"        return TYPE_OR;
"&&"        return TYPE_AND;
"!"         return TYPE_NOT;
"<"         return TYPE_LT;
"<="        return TYPE_LE;
">"         return TYPE_GT;
">="        return TYPE_GE;
"begin"     return TYPE_BEGIN;
"end"       return TYPE_END;
"true"      return TYPE_TRUE;
"false"     return TYPE_FALSE;
"if"        return TYPE_IF;
"then"      return TYPE_THEN;
":="        return TYPE_ASSIGN;
{number}    return TYPE_NUMBER;
{id}        return TYPE_ID;
";"         return TYPE_SEMI;
\n          /* ignore white spaces */
<<EOF>>     return 0;
.           unrecognized(yytext, yylineno);
%%

void unrecognized(const char *text, int line) {
    printf("at line %d:\n", line);
    printf("unrecognized character: `%s`\n", text);
    exit(1);
}

int lex(FILE *fd, Token *token) {
    yyin = fd;
    token->type = yylex();
    token->line = yylineno;
    int len = strlen(yytext);
    token->text = (char *)malloc(len + 1);
    strcpy(token->text, yytext);
    return token->type;
}
