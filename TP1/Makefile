CC=gcc
CFLAGS1 = -std=c11 -g `pkg-config --cflags libxml-2.0` `pkg-config --cflags glib-2.0` -o filtro1
CFLAGS2 = -std=c11 -g `pkg-config --cflags libxml-2.0` `pkg-config --cflags glib-2.0` -o filtro2
CFLAGS3 = -std=c11 -g `pkg-config --cflags libxml-2.0` `pkg-config --cflags glib-2.0` -o filtro3
LIBS = `pkg-config --libs libxml-2.0` `pkg-config --libs glib-2.0`
FLEX=flex
FLEXFLAGS1 = -o filtro1.c
FLEXFLAGS2 = -o filtro2.c
FLEXFLAGS3 = -o filtro3.c
LIBS = `pkg-config --libs libxml-2.0` `pkg-config --libs glib-2.0`

program:
	$(FLEX) $(FLEXFLAGS1) filtro1.l
	$(CC) $(CFLAGS1) filtro1.c estruturas.c $(LIBS)
	$(FLEX) $(FLEXFLAGS2) filtro2.l
	$(CC) $(CFLAGS2) filtro2.c
	$(FLEX) $(FLEXFLAGS3) filtro3.l
	$(CC) $(CFLAGS3) filtro3.c

clean:
	rm filtro1 filtro2 filtro3
	rm filtro1.c filtro2.c filtro3.c
	rm -rf *.dSYM
