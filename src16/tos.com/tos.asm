;           |====================================================|
;           |                     TRINITY-OS                     |
;           |            TOS.COM INITIALISATION FILE             |
;           |            LETS F***ING GOOOOOOOOOOOOOO            |
;           |====================================================|
;            \ GNU GPL v.2 licensed. See LICENSE.md for details /
;             \================================================/
org 0x100

start:
    xor ax, ax
    mov ax, cs
    mov ds, ax
    mov es, ax

    call check_dos_version
    jc incorrect_dos_version
    jmp dos_ver_ok

check_dos_version:
    mov ah, 0x30
    int 0x21
    cmp al, 5
    jb  .dos_too_old
    cmp al, 5
    jne .version_ok
    cmp ah, 0
    jb  .dos_too_old
    jmp .version_ok

.dos_too_old:
    stc
    ret

.version_ok:
    clc
    ret

incorrect_dos_version:
    mov dx, incorrectdos
    mov ah, 0x09
    int 0x21
    jmp $

dos_ver_ok:
    mov dx, ver_ok
    mov ah, 0x09
    int 0x21
    jmp $

; === All data goes at the very end ===

incorrectdos db 'Incorrect DOS version! You need at least 5.0, but detected a lower version.$'
ver_ok db 'Detected a correct DOS version!$'