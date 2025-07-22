REM Assumes that MSVC is in your PATH
cl /c /O2 kernel32.c
link /subsystem:native /entry:KernelMain kernel32.obj