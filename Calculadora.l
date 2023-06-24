%{
#include "calculadora.tab.h"
#include <math.h>
%}

%%

[0-9]+      {   int decimal= atoi(yytext);
                int binary = 0;
                int base = 1;

                while (decimal > 0) {
                    int resto = decimal % 2;
                    decimal /= 2;
                    binary += resto * base;
                    base *= 10;
                }
                yylval = binary;
                return NUMBER; }
[ \t]       ; /* Ignorar espacios en blanco y tabulaciones */
\n          return '\n';
.           return yytext[0];

%%

int yywrap() {
    return 1;
}