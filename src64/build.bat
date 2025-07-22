cl /c /O2 /favor:AMD64 kernel64.c
link /machine:x64 /entry:KernelMain64 kernel64.obj