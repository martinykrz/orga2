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

def main():
    subprocess.run(["./build/main"])
    return None

def refresh():
    clean()
    make()
    return None

def rerun():
    refresh()
    main()
    return None

def debug():
    subprocess.run([
        "gdb",
        "-q",
        "./build/main"
        ])
    return None

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("-r", "--run", help="Run program [make/clean/refresh/main/rerun/debug]", type=str)
    args = parser.parse_args()
    match args.run:
        case "make":
            make()
        case "clean":
            clean()
        case "main":
            main()
        case "refresh":
            refresh()
        case "rerun":
            rerun()
        case "debug":
            debug()
        case _:
            parser.print_help()
