YACC=yacc
YACCFLAGS = -vd

FLEX=flex

CC=gcc
CFLAGS = -o

program:
	$(YACC) $(YACCFLAGS) diaporama.y
	$(FLEX) analisadorLexico.l
	$(CC) $(CFLAGS) diap y.tab.c auxiliares.c

clean:
	rm diap
	rm lex.yy.c y.tab.c
	rm y.output
	rm y.tab.h
