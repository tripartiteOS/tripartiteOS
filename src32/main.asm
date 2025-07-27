BITS 32
org 0x100       ; Required for EXE-style layout

_start:
    ; Write "OK" to video memory at 0xB8000
    mov eax, 0x2F4B      ; 'K'<<8 | 'O'
    mov [0xB8000], eax

.loop:
    hlt
    jmp .loop
