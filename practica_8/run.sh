#!/usr/bin/sh
# make
# qemu-system-i386 -s -S -drive format=raw,if=floppy,file=diskette.img --monitor stdio && make clean
make gdb && make clean
