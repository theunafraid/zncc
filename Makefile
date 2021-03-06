CC=g++
CFLAGS=-g -std=gnu++11 -pthread -I. -O3

OS=$(shell uname)

ifeq ($(OS), Darwin)
CLFLAGS=-framework OpenCL -DGPU_SUPPORT
else
CLFLAGS=-lOpenCL -DGPU_SUPPORT
endif

#-Wall
all: main.cpp zncc.cpp lodepng.cpp cmdline.c util.cpp zncc_gpu.cpp
	$(shell mkdir -p outputs)
	$(CC) -o zncc main.cpp zncc.cpp lodepng.cpp cmdline.c util.cpp zncc_gpu.cpp $(CFLAGS) $(CLFLAGS)

cpu: main.cpp zncc.cpp lodepng.cpp cmdline.c util.cpp
	$(shell mkdir -p outputs)
	$(CC) -o zncc main.cpp zncc.cpp lodepng.cpp cmdline.c util.cpp $(CFLAGS) 

clean:
	rm outputs/depthmap.png
	rm zncc
# Deliberately not deleting all PNGs.
