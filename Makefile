CFLAGS = -c -fPIC -Wall
INC = include
OBJECTS = mixer.o pcm.o
LIB = libtinyalsa.so
CROSS_COMPILE =
CC=gcc

all: $(LIB) tinyplay tinycap tinymix tinypcminfo

tinyplay: $(LIB) tinyplay.o
	$(CROSS_COMPILE)$(CC) tinyplay.o -L. -ltinyalsa -o tinyplay

tinycap: $(LIB) tinycap.o
	$(CROSS_COMPILE)$(CC) tinycap.o -L. -ltinyalsa -o tinycap

tinymix: $(LIB) tinymix.o
	$(CROSS_COMPILE)$(CC) tinymix.o -L. -ltinyalsa -o tinymix

tinypcminfo: $(LIB) tinypcminfo.o
	$(CROSS_COMPILE)$(CC) tinypcminfo.o -L. -ltinyalsa -o tinypcminfo

$(LIB): $(OBJECTS)
	$(CROSS_COMPILE)gcc -shared $(OBJECTS) -o $(LIB)

.c.o:
	$(CROSS_COMPILE)$(CC) $(CFLAGS) $< -I$(INC)

clean:
	-rm $(LIB) $(OBJECTS) tinyplay.o tinyplay tinycap.o tinycap \
	tinymix.o tinymix tinypcminfo.o tinypcminfo
