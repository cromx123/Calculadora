%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int yylex(); // Declaración de Flex
void yyerror(char* s); // Función para capturar errores de análisis sintáctico

int sum(int a,int b);
int rest(int a,int b);
int mult(int a,int b);
int division(int a,int b);
%}

%token NUMBER
%left '+' '-'
%left '*' '/'
%right UMINUS

%%

calc: /* vacío */
    | calc expression '\n' { printf("Resultado: %d\n", $2);}
    ;

expression: NUMBER                { $$ = $1; }
    | expression '+' expression   { $$ = sum($1,$3); } //Funciona Bien
    | expression '-' expression   { $$ = rest($1,$3); } //Funciona Bien
    | expression '*' expression   { $$ = mult($1,$3); } //Funciona Bien
    | expression '/' expression   { $$ = division($1,$3); } //Funciona Bien
    | '-' expression %prec UMINUS { $$ = -$2; }
    ;

%%

int main() {
    yyparse();
    return 0;
}
int calc_yylex(){
     int n;
     scanf("%d", &n);
     return n;
}
void yyerror(char* s){fprintf(stderr,"%s\n",s);}

int sum(int a,int b){
    int carry = 0,Resultado = 0,digito = 1;

    while (a != 0 || b != 0) {
        int bitA = a % 10;
        int bitB = b % 10;
        int suma = bitA + bitB + carry;
        int bitResultado = suma % 2;

        carry = suma / 2;
        Resultado += bitResultado * digito;
        digito *= 10;
        a /= 10;
        b /= 10;
    }
    
    if (carry != 0) {
        Resultado += carry * digito;
    }
    
    return Resultado;
}
int rest(int a,int b){
    int carry = 0,Resultado = 0,digito = 1;
    if (b > a) { //invierte a por b
        int temp = a;
        a = b;
        b = temp;
    }
    while (a != 0 || b != 0) {
        int bitA = a % 10;
        int bitB = b % 10;
        
        bitA -= carry;
        
        if (bitA < bitB) {
            bitA += 2;
            carry = 1;
        } else {
            carry = 0;
        }
        
        int bitResultado = bitA - bitB;
        
        Resultado += bitResultado * digito;
        digito *= 10;
        
        a /= 10;
        b /= 10;
    }
    
    return Resultado;
}
int mult(int a,int b){
    int producto = 0;
    int factor = 1;

    while (b != 0) {
        int bit = b % 10;
        b /= 10;

        if (bit) {
            int Pproducto = a * factor;
            producto = sum(producto,Pproducto);
        }
        factor *= 10;
    }

    return producto;
}
int division(int a,int b){
    if (b == 0) {
        printf("Error: división entre cero\n");
        return 0;
    }
    int cociente = 0;

    while (a >= b) {
        // Se desplaza el divisor a la izquierda hasta que tenga la misma longitud que el dividendo
        int temp = b;
        int bitPosicion = 1;
        while (temp <= a) {
            temp *= 10;
            bitPosicion *= 10;
        }

        // Se actualiza el cociente y el residuo
        bitPosicion /= 10;
        temp /= 10;
        cociente += bitPosicion;
        a = rest(a, temp);
    }

    return cociente;
}


