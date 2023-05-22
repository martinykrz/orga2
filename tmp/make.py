#!/usr/bin/env python
import os
import subprocess
import argparse

def compile_asm():
    asm_files = [f for f in os.listdir() if f.endswith('.asm')]
    for asm in asm_files:
        obj = f"build/{asm.removesuffix('.asm')}.o"
        subprocess.run([
            "nasm",
            "-felf64",
            "-g",
            "-F",
            "dwarf",
            "-o",
            obj,
            asm
        ])
    return None

def compile_filters():
    filtros_files = [f for f in os.listdir() if ("Offset" in f or "Sharpen" in f) and f.endswith('.c')]
    for f in filtros_files:
        obj = f"build/{f.removesuffix('.c')}.o"
        subprocess.run([
            "cc",
            "-ggdb",
            "-Wall",
            "-Wno-unused-parameter",
            "-Wextra",
            "-std=c99",
            "-no-pie",
            "-pedantic",
            "-m64",
            "-O0",
            "-march=native",
            "-c",
            "-o",
            obj,
            f
        ])
    return None

def compile_c_files():
    cfiles = [f for f in os.listdir() if ("libbmp" in f or "imagenes" in f or "utils" in f or "main" in f) and f.endswith('.c')]
    for f in cfiles:
        obj = f"build/{f.removesuffix('.c')}.o"
        subprocess.run([
            "cc",
            "-ggdb",
            "-Wall",
            "-Wno-unused-parameter",
            "-Wextra",
            "-std=c99",
            "-no-pie",
            "-pedantic",
            "-m64",
            "-O0",
            "-march=native",
            "-c",
            "-o",
            obj,
            f
        ])
    return None

def make():
    if not os.path.exists("build/"):
        os.mkdir("build/")
    compile_asm()
    compile_filters()
    compile_c_files()
    command = [
            "cc",
            "-ggdb",
            "-Wall",
            "-Wno-unused-parameter",
            "-Wextra",
            "-std=c99",
            "-no-pie",
            "-pedantic",
            "-m64",
            "-O0",
            "-march=native",
            "-o",
            "build/main"
        ]
    for obj in [f"build/{x}" for x in os.listdir("build/") if x.endswith('.o')]:
        command.append(obj)
    subprocess.run(command)
    return None

def clean():
    for file in os.listdir("build/"):
        file_path = os.path.join("build/", file)
        if os.path.isfile(file_path):
            os.remove(file_path)
    return None

def rn():
    subprocess.run(["./build/main"])
    return None

def debug():
    subprocess.run([
        "gdb",
        "-q",
        "./build/main"
        ])
    return None

def main(mk: bool, run: bool, dbg: bool, all: bool):
    if mk:
        clean()
        make()
    elif run:
        rn()
    elif dbg:
        debug()
    elif all:
        clean()
        make()
        rn()
        debug()
    else:
        print("No flag activated")

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("-m", "--make", action='store_true', help="Make objs and exe")
    parser.add_argument("-r", "--run", action='store_true', help="Run exe")
    parser.add_argument("-d", "--debug", action='store_true', help="Debug program")
    parser.add_argument("-a", "--all", action='store_true', help="Make, run and debug")
    args = parser.parse_args()
    main(mk=args.make, run=args.run, dbg=args.debug, all=args.all)
