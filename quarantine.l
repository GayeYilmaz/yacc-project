%{
#include <stdlib.h>
#include "quarantine.h"
#include "y.tab.h"
void yyerror(char *);
%} 
num     [1-9][0-9]*
id      [a-z]
comment "/*"([^*]|\*+[^*/])*\*+"/"
bop     [()=;{}.]

%%

{id}       { 
                yylval.sIndex = *yytext - 'a';
                return VARIABLE;
            }

0           {
                yylval.iValue = atoi(yytext);
                return INTEGER;
            }

{num}       {
                yylval.iValue = atoi(yytext);
                return INTEGER;
            }

{bop}       {
                return *yytext;
             }
{comment}       return COMMENT;
[//][^\r\n]*    return COMMENT;
"true"          return TRUE;
"false"         return FALSE;
"+"             return PLUS;
"-"             return MINUS;
"*"             return TIMES;
\<           return LT;
\>             return GT;
">="            return GE;
"<="            return LE;
"=="            return EQ;
"!="            return NE;
"while"         return WHILE;
"if"            return IF;
"else"          return ELSE;
"print"         return PRINT;


[ \t\n]+        ;       /* ignore whitespace */

.               yyerror("Unknown character");
%%

int yywrap(void) {
    return 1;
}


