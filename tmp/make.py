#!/usr/bin/env python
import os
import subprocess

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

if __name__ == "__main__":
    make()
