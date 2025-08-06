struct IDTEntry {
    uint16_t offset_low;   // Bits 0–15 of ISR address
    uint16_t selector;     // Code segment selector in GDT
    uint8_t  zero;         // Always 0
    uint8_t  type_attr;    // Type + attributes
    uint16_t offset_high;  // Bits 16–31 of ISR address
} __attribute__((packed));

struct IDTPointer {
    uint16_t limit;
    uint32_t base;
} __attribute__((packed));

#define IDT_ENTRIES 256
static struct IDTEntry idt[IDT_ENTRIES];
static struct IDTPointer idt_ptr;

void idt_set_gate(int num, uint32_t base, uint16_t sel, uint8_t flags) {
    idt[num].offset_low = base & 0xFFFF;
    idt[num].selector = sel;
    idt[num].zero = 0;
    idt[num].type_attr = flags;
    idt[num].offset_high = (base >> 16) & 0xFFFF;
}

extern void idt_flush(uint32_t);  // defined in ASM below

void idt_install(void) {
    idt_ptr.limit = sizeof(struct IDTEntry) * IDT_ENTRIES - 1;
    idt_ptr.base = (uint32_t)&idt;

    // Clear IDT first
    for (int i = 0; i < IDT_ENTRIES; i++) {
        idt_set_gate(i, 0, 0, 0);
    }

    // Load with lidt
    idt_flush((uint32_t)&idt_ptr);
}

__asm__ volatile(
        "global idt_flush\n\t"
        "idt_flush\n\t"
        "mov eax, [esp+4]\n\t"
        "lidt [eax]\n\t"
        "ret"
    )