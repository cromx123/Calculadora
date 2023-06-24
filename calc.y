%{
#include <stdio.h>
#include <math.h>

int yylex(); // Declaración de Flex
void yyerror(const char* mensaje); // Función para capturar errores de análisis sintáctico
int Resultado =0; //variable que almacena el resultado

int convertBinaryToDecimal(int binary);
int convertDecimalToBinary(int decimal);
%}

// Reglas gramaticales
%token NUMBER
%left '+' '-'
%left '*' '/'

%%
calc: /* vacío */
    | calc expr '\n' { printf("Resultado: %d\n", convertDecimalToBinary(Resultado));}
    ;

// Regla de expresión aritmética
expr: NUMBER             { Resultado = convertBinaryToDecimal($1); }
         | expr '+' expr { Resultado = convertBinaryToDecimal($1) + convertBinaryToDecimal($3); }
         | expr '-' expr { Resultado = convertBinaryToDecimal($1) - convertBinaryToDecimal($3); }
         | expr '*' expr { Resultado = convertBinaryToDecimal($1) * convertBinaryToDecimal($3); }
         | expr '/' expr { Resultado = convertBinaryToDecimal($1) / convertBinaryToDecimal($3); }
         ;

%%

int main() {
    printf("Ingresa numeros binarios (0 y 1) para calcular");
    yyparse();  // Llama a la función de análisis sintáctico generada por Yacc

    return 0;
}
int calc_yylex(){
     int n;
     scanf("%d", &n);
     return n;
}


void yyerror(const char* mensaje) {
    printf("Error: %s\n", mensaje);
}

// Conversión de binario a decimal 
int convertBinaryToDecimal(int binary) {
    int decimal = 0;
    int base = 1;
    while (binary != 0) {
        int remainder = binary % 10;
        binary /= 10;
        decimal += remainder * base;
        base *= 2;
    }
    return decimal;
}
// Conversión de decimal a binario
int convertDecimalToBinary(int decimal) {
    int binary = 0;
    int base = 1;

    while (decimal > 0) {
        int resto = decimal % 2;
        decimal /= 2;
        binary += resto * base;
        base *= 10;
    }
    return binary;
}
