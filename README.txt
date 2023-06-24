***MODO DE COMPILACION***
1) bison -d Calculadora.y
2) lex calculadora.l
3) gcc -c lex.yy.c
4) gcc -c calculadora.tab.c
5) gcc -o calculadora calculadora.tab.o lex.yy.o -lfl
6) ./calculadora