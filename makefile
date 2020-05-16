quarantine: lex.yy.c y.tab.c
	gcc -g lex.yy.c y.tab.c -o quarantine

lex.yy.c: y.tab.c quarantine.l
	lex quarantine.l

y.tab.c: quarantinealcc.y
	yacc -d quarantinecalc.y

clean: 
	rm -rf lex.yy.c y.tab.c y.tab.h quarantine quarantine.dSYM
