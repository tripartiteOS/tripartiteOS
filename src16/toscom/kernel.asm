org 0x100

start:
    ; Set mode 13h
    mov ax, 0x0013
    int 0x10

    ; Init mouse
    mov ax, 0
    int 0x33
    cmp ax, 0
    je no_mouse

    ; Initial previous position (off-screen)
    mov word [prev_x], 0xFFFF
    mov word [prev_y], 0xFFFF

main_loop:
    ; Get mouse position
    mov ax, 3
    int 0x33
    mov [mouse_x], cx
    mov [mouse_y], dx

    ; Restore background where cursor *was*
    cmp word [prev_x], 0xFFFF
    je .skip_restore
    mov cx, [prev_x]
    mov dx, [prev_y]
    call restore_background
.skip_restore:

    ; Save new background under cursor
    mov cx, [mouse_x]
    mov dx, [mouse_y]
    call save_background

    ; Draw cursor at new pos
    mov cx, [mouse_x]
    mov dx, [mouse_y]
    call draw_cursor

    ; Store current as previous
    mov ax, [mouse_x]
    mov [prev_x], ax
    mov ax, [mouse_y]
    mov [prev_y], ax

    ; Small delay
    mov cx, 5000
.delay:
    loop .delay

    jmp main_loop

no_mouse:
    mov ah, 9
    mov dx, msg_no_mouse
    int 0x21
    jmp $

; ========== Save background under (CX, DX) into buffer ==========
save_background:
    push ax
    push bx 
    push cx 
    push dx 
    push di 
    push si 
    push es
    mov ax, 0xA000
    mov es, ax

    mov si, 0
    mov bx, dx      ; base Y
    mov di, cx      ; base X

    mov dh, 8       ; 8 rows
.row:
    mov dl, 8       ; 8 cols
.col:
    mov ax, bx
    mov cx, 320
    mul cx
    add ax, di
    mov di, ax
    mov al, [es:di]
    mov [saved_background + si], al
    inc si
    inc di
    sub di, ax      ; undo offset
    inc di          ; next X
    dec dl
    jnz .col
    inc bx          ; next row (Y)
    mov di, cx      ; reset X
    dec dh
    jnz .row
    pop es 
    pop si 
    pop di 
    pop dx 
    pop cx 
    pop bx 
    pop ax
    ret

; ========== Restore background at (CX, DX) from buffer ==========
restore_background:
    push ax 
    push bx 
    push cx 
    push dx 
    push di 
    push si 
    push es
    mov ax, 0xA000
    mov es, ax

    mov si, 0
    mov bx, dx
    mov di, cx

    mov dh, 8
.row:
    mov dl, 8
.col:
    mov ax, bx
    mov cx, 320
    mul cx
    add ax, di
    mov di, ax
    mov al, [saved_background + si]
    mov [es:di], al
    inc si
    inc di
    sub di, ax
    inc di
    dec dl
    jnz .col
    inc bx
    mov di, cx
    dec dh
    jnz .row
    pop es 
    pop si 
    pop di 
    pop dx 
    pop cx 
    pop bx 
    pop ax
    ret

; ========== Draw cursor bitmap ==========
draw_cursor:
    pusha
    mov si, cursor_bitmap
    mov bx, dx
    mov di, cx
    mov dh, 8
.row:
    mov dl, 8
.col:
    lodsb
    cmp al, 0
    je .skip
    push ax
    mov cx, di
    mov dx, bx
    call draw_pixel
    pop ax
.skip:
    inc di
    dec dl
    jnz .col
    inc bx
    mov di, cx
    dec dh
    jnz .row
    popa
    ret

; ========== Plot pixel at (CX, DX) ==========
draw_pixel:
    push es
    mov ax, 0xA000
    mov es, ax
    mov ax, dx
    mov bx, 320
    mul bx
    add ax, cx
    mov di, ax
    mov [es:di], al
    pop es
    ret

cursor_bitmap:
    db 0,0,15,0,0,15,0,0
    db 0,0,15,0,0,15,0,0
    db 15,15,15,15,15,15,15,15
    db 0,0,15,0,0,15,0,0
    db 0,0,15,0,0,15,0,0
    db 0,0,15,0,0,15,0,0
    db 0,0,0,0,0,0,0,0
    db 0,0,15,0,0,15,0,0

saved_background: times 64 db 0
mouse_x: dw 0
mouse_y: dw 0
prev_x:  dw 0
prev_y:  dw 0

msg_no_mouse: db 'No mouse found.$'
