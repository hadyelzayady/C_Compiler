all: compiler

yac.tab.c yac.tab.h:	yac.y
	bison -d yac.y

lex.yy.c: lex.l yac.tab.h
	flex lex.l

compiler: lex.yy.c yac.tab.c yac.tab.h
	gcc -o compiler yac.tab.c lex.yy.c

clean:
	rm compiler yac.tab.c lex.yy.c yac.tab.h
