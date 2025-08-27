;           |====================================================|
;           |                   TRIPARTITE-OS                    |
;           |            TOS.COM INITIALISATION FILE             |
;           |            LETS F***ING GOOOOOOOOOOOOOO            |
;           |====================================================|
;            \ GNU GPL v.2 licensed. See LICENSE.md for details /
;             \================================================/
org 0x100

palette_size equ logo_palette_end - logo_palette
image_size equ logo_image_end - logo_image

; For fading routines
PALETTE_SEG equ 0x0A000
PALETTE_OFF equ 0x8000
FADE_STEPS equ 32

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

    ;jmp $

    ;call pmode_init

    ;call start_kernel
    call display_disclaimer
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

display_disclaimer:
    ; Set video mode (optional, e.g., 03h = 80x25 text)
    mov ah, 0
    mov al, 3
    int 10h

    ; Print the disclaimer
    mov dx, disclaimer
    call print_string

    call delay_125ms
    call delay_125ms
    call delay_125ms
    call delay_125ms
    call delay_125ms
    call delay_125ms
    call delay_125ms
    call delay_125ms
    call delay_125ms
    call delay_125ms

    call display_bootlogo
; ==========================
; Delay (~125ms per call)
delay_125ms:
    mov ecx, 0xFFFF
    .loop:
        dec ecx
        jnz .loop
    ret

; ==========================
; BIOS string printer (terminated with '$')
print_string:
    mov ah, 09h
    int 21h
    ret

display_bootlogo:
    ; First, set up the graphics mode
    mov ax, 0x13
    int 0x10

    ; Then load the palette
    mov dx, 0x3C8
    xor al, al
    out dx, al            ; Start at palette index 0

    mov dx, 0x3C9
    mov si, logo_palette
    mov cx, 256           ; 256 colors

.load_palette:
    lodsb                 ; R
    shr al, 2
    out dx, al

    lodsb                 ; G
    shr al, 2
    out dx, al

    lodsb                 ; B
    shr al, 2
    out dx, al

    loop .load_palette

    ; Finally, load the copy the image itself
    mov si, logo_image
    mov di, 0xA000  ; VRAM segment
    mov es, di
    xor di, di
    mov cx, image_size
    rep movsb

loop_start:
    call scroll_bottom
    call clear_bottom_line  ; otherwise it looks kinda glitchy
    call delay
    jmp loop_start


scroll_bottom:
    push ds
    mov ax, 0xA000
    mov ds, ax

    mov cx, 16                                  ; Number of lines
    mov si, (184 + 15) * 320                    ; Start from line 199 (bottom), go upward
scroll_line_loop:
    ; Save last pixel of line
    mov al, [si + 319]

    ; Shift right
    mov di, si
    mov bx, 319
.scroll_pixel_loop:
    mov dl, [di + bx - 1]       ; dl = pixel at x-1
    mov [di + bx], dl           ; move to x
    dec bx
    jnz .scroll_pixel_loop

    ; Restore saved pixel to leftmost
    mov [si], al

    sub si, 320
    loop scroll_line_loop

    pop ds
    ret


clear_bottom_line:
    push ds
    mov ax, 0xA000
    mov ds, ax

    mov di, 199 * 320           ; start of line 199
    mov cx, 320
    xor al, al                  ; color 0 = black (or set to desired color)
    rep stosb                   ; fill line with color

    pop ds

    push ds
    mov ax, 0xA000
    mov ds, ax

    mov di, 198 * 320           ; start of line 199
    mov cx, 320
    xor al, al                  ; color 0 = black (or set to desired color)
    rep stosb                   ; fill line with color

    pop ds


    push ds
    mov ax, 0xA000
    mov ds, ax

    mov di, 197 * 320           ; start of line 199
    mov cx, 320
    xor al, al                  ; color 0 = black (or set to desired color)
    rep stosb                   ; fill line with color

    pop ds
    ret

start_kernel:
    mov dx, kernel_name  ; DS:DX -> filename
    mov ax, 0x4B00        ; EXEC function: load & execute
    int 0x21              ; call DOS
    jc  start_kernel_error             ; if CF set, jump to error

    ; Kernel apparently loaded successfully, so the code after this comment won't run until we return from the kernel
    ; We're either shutting down or restarting, so AX won't be used. We'll tell if we're restarting by the value of AX
    ; If it is 0, we're shutting down. If it is 1, we're restarting.
    cmp ax, 0
    je  shutdown_system
    cmp ax, 1
    je  restart_system

shutdown_system:
    ; Print shutdown message
    mov dx, safetoshutdown
    mov ah, 9
    int 0x21
    hlt ; No ACPI

restart_system:
    jmp FFFF:0 ; Reset vector

start_kernel_error:
    ; Print error message
    mov dx, err_msg
    mov ah, 9
    int 0x21

    mov ax, 0x4C01        ; Exit with error code 1
    int 0x21

delay:
    mov cx, 0FFFFh
.delay_loop:
    nop
    loop .delay_loop
    ret

; === All data goes at the very end ===

incorrectdos db 'Incorrect DOS version! You need at least 5.0, but detected a lower version.$'
ver_ok db 'Detected a correct DOS version!$'
starting_tos db 'Starting tripartiteOS...$'
msg_superex_success db 'Super-Extended XMS is available, largest block (KB): $'
msg_superex_total db 13, 10, 'Total available (KB): $'
msg_superex_error db 'Could not display amount of Super-Extended XMS, tripartiteOS is unable to start.$'
kernel_name db 'KERNEL.EXE$'
err_msg     db 'Error launching KERNEL.EXE$'
newline db 13, 10, '$'

disclaimer   db "Copyright (C) 2025 — Present, ProximalElk6186 and GitHub contributors",
             db 13,10,"This program is free software; you can redistribute it and/or",
             db 13,10,"modify it under the terms of the GNU General Public License as",
             db 13,10,"published by the Free Software Foundation in the version 2",
             db 13,10,"of the License.",
             db 13,10,"This program is distributed in the hope that it will be useful,",
             db 13,10,"but WITHOUT ANY WARRANTY; without even the implied warranty of",
             db 13,10,"MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.",
             db 13,10,"See the GNU General Public License for more details.",13,10,'$'

safetoshutdown db 13,10,"It is now safe to turn off your computer.",'$'

buffer resb 12
buffer_end:

largest_block_kb dd 0
total_mem_kb dd 0


section .data
logo_palette:
    incbin "neologo/logo.data.pal"
logo_palette_end:

logo_image:
    incbin "neologo/logo.data"
logo_image_end:

scroll_start_line equ 184
num_scroll_lines  equ 16
screen_width      equ 320
video_segment     equ 0xA000
