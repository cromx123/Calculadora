***MODO DE COMPILACION***
1) yacc -d Calculadora.y
1) flex Calculadora.lex
2) gcc -o Calculadora  y.tab.c lex.yy.c -ll
3) ./[nombre con extension .exe]