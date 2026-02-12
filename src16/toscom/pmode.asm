[BITS 16]
[ORG 0x100]

start:
    cli                     ; Disable interrupts
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00          ; Temporary stack

    ; Setup GDT
    lgdt [gdt_descriptor]

    ; Enable A20 (if running on real hardware)
    call enable_a20

    ; Enter protected mode
    mov eax, cr0
    or eax, 1
    mov cr0, eax

    ; Far jump to clear prefetch and load CS with 32-bit selector
    jmp dword 0x08:protected_mode_entry

; ---------------------
; GDT Setup
; ---------------------
gdt_start:
    ; Null descriptor
    dq 0x0000000000000000

    ; Code segment: base=0, limit=4GB, type=0x9A, granularity=0xCF
    dq 0x00CF9A000000FFFF

    ; Data segment: base=0, limit=4GB, type=0x92, granularity=0xCF
    dq 0x00CF92000000FFFF

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start

; ---------------------
; Protected Mode Code
; ---------------------
[BITS 32]
protected_mode_entry:
    ; Update segment registers
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov esp, 0x90000

    ; Do something in pmode
    mov dword [0xB8000], 0x2F4B2F4B ; "KK" in color

.hang:
    jmp .hang

; ---------------------
; Dummy A20 Enabler (stubbed for VirtualBox or DOSBox)
; ---------------------
[BITS 16]
enable_a20:
    ret
