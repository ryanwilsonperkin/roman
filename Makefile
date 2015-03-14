CFLAGS=-std=cobol85 -O -Wall -free
OS=$(shell uname -s)

ifeq "$(OS)" "Darwin"
	DYLIB_EXT=".dylib"
else
	DYLIB_EXT=".so"
endif

all: roman

roman: conv.$(DYLIB_EXT) roman.cob
	cobc $(CFLAGS) -x roman.cob -o roman

conv.$(DYLIB_EXT): conv.cob
	cobc $(CFLAGS) -m conv.cob
