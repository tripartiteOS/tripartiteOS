@ECHO off
REM TRIPARTITEOS
REM PROTECTED MODE KERNEL
REM BUILDING FILE
REM GNU GPL v.2 licensed. See LICENSE.md for details
gcc main.c -o kernel.exe -lm
stubedit kernel.exe dpmi=CWSDPR0.EXE