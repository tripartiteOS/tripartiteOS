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
    ;jmp $

print_starting_msg:
    ; First clear the screen
    mov ah, 0
    mov al, 3
    int 0x10
    ; Then display the "Starting tripartiteOS" message
    mov dx, starting_tos
    mov ah, 0x09
    int 0x21
    ;jmp $   ; Infinite loop (for now)

check_superex_xms:
    mov ah, 0x0C8
    int 0x2F
    
    cmp ax, 0
    je xms_error
    
    ; Store values
    mov [largest_block_kb], eax
    mov [total_mem_kb], edx
    
    ; Print the message
    mov dx, msg_superex_success
    mov ah, 0x09
    int 0x21
    
    ; Print largest block
    mov eax, [largest_block_kb]
    call print_eax_as_decimal
    mov dx, newline
    mov ah, 0x09
    int 0x21

    ; Print total memory
    mov dx, msg_superex_total
    mov ah, 0x09
    int 0x21

    mov eax, [total_mem_kb]
    call print_eax_as_decimal

    jmp $

xms_error:
    mov dx, msg_superex_error
    mov ah, 0x09
    int 0x21
    mov eax, [total_mem_kb]
    call print_eax_as_decimal

    jmp $

; === Subs ===

clear_screen:
    mov ah, 0
    mov al, 3
    int 0x10
    ret

print_eax_as_decimal:
    push ax
    push bx
    push cx
    push dx
    push si
    mov cx, 0          ; digit count
    mov si, buffer_end

.print_loop:
    xor edx, edx
    mov ebx, 10
    div ebx            ; EAX / 10 => quotient in EAX, remainder in EDX
    add dl, '0'
    dec si
    mov [si], dl
    inc cx
    test eax, eax
    jnz .print_loop

    ; Print digits one by one
.print_digits:
    mov ah, 0x0E
    mov al, [si]
    int 10h
    inc si
    loop .print_digits

    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret

; === All data goes at the very end ===

incorrectdos db 'Incorrect DOS version! You need at least 5.0, but detected a lower version.$'
ver_ok db 'Detected a correct DOS version!$'
starting_tos db 'Starting tripartiteOS...$'
msg_superex_success db 'Super-Extended XMS is available, largest block (KB): $'
msg_superex_total db 13, 10, 'Total available (KB): $'
msg_superex_error db 'Could not display amount of Super-Extended XMS, tripartiteOS is unable to start.$'
newline db 13, 10, '$'

buffer resb 12
buffer_end:

largest_block_kb dd 0
total_mem_kb dd 0