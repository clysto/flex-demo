CC = gcc
OBJECTS = lex.o main.o
CFLAGS = -std=c99 -fPIC

lex: $(OBJECTS)
	$(CC) $(CFLAGS) -o lex $(OBJECTS)
	rm -rf *.o lex.yy.c

lib: lex.o
	$(CC) -shared lex.o -o liblex.so

lex.o: lex.yy.c
	$(CC) $(CFLAGS) -c -o lex.o lex.yy.c

lex.yy.c: lex.l
	flex lex.l

.PHONY: clean
clean:
	rm -rf *.o lex.yy.c lex dist *.so

.PHONY: dist
.ONESHELL:
dist: lex.yy.c lex.h
	[ -d dist ] || mkdir dist
	cp lex.yy.c ./dist/lex.c
	cp lex.h ./dist/lex.h
	rm -rf *.o lex.yy.c
