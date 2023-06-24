%{
#include "y.tab.h"
%}

%%

[0-9]+      { yylval = atoi(yytext); return NUMBER; }
[ \t]       ; /* Ignorar espacios en blanco y tabulaciones */
\n          return '\n';
.           return yytext[0];

%%

int yywrap() {
    return 1;
}