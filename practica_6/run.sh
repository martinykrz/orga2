#!/usr/bin/sh
make
qemu-system-i386 -s -S -fda diskette.img --monitor stdio && make clean
