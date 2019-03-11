CC=gcc
CFLAGS = -std=c11 -g `pkg-config --cflags libxml-2.0` `pkg-config --cflags glib-2.0` -o filtro
LIBS = `pkg-config --libs libxml-2.0` `pkg-config --libs glib-2.0`
FLEX=flex
FLEXFLAGS = -o filtro.c

program:
	$(FLEX) $(FLEXFLAGS) filtro.l
	$(CC) $(CFLAGS) filtro.c

clean:
	rm filtro
	rm filtro.c
