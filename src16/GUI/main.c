//#include <dos.h>
//#include <conio.h>
//#include <stdint.h>
//
//#define SCREEN_WIDTH 320
//#define SCREEN_HEIGHT 200
//#define VIDEO_MEMORY ((uint8_t*)0xA0000)
//
//// Simple 8x8 arrow cursor bitmap
//uint8_t cursor_bitmap[8] = {
//    0b10000000,
//    0b11000000,
//    0b11100000,
//    0b11110000,
//    0b11111000,
//    0b11110000,
//    0b11000000,
//    0b10000000
//};
//
//// Draw XOR cursor at x, y
//void draw_cursor(int x, int y) {
//    int row, col, px, py;
//    uint8_t bits;
//    uint8_t* pixel;
//    for (row = 0; row < 8; row++) {
//        bits = cursor_bitmap[row];
//        for (col = 0; col < 8; col++) {
//            if (bits & (0x80 >> col)) {
//                px = x + col;
//                py = y + row;
//                if (px < SCREEN_WIDTH && py < SCREEN_HEIGHT) {
//                    pixel = &VIDEO_MEMORY[py * SCREEN_WIDTH + px];
//                    *pixel ^= 0xFF; // XOR with 0xFF for inversion
//                }
//            }
//        }
//    }
//}
//
//// Set video mode 13h
//void set_video_mode() {
//    union REGS regs;
//    regs.h.ah = 0x00;
//    regs.h.al = 0x13;
//    int86(0x10, &regs, &regs);
//}
//
//// Init mouse
//int init_mouse() {
//    union REGS regs;
//    regs.x.ax = 0x0000;
//    int86(0x33, &regs, &regs);
//    return regs.x.ax == 0xFFFF;
//}
//
//// Get mouse position
//void get_mouse_pos(int* x, int* y) {
//    union REGS regs;
//    regs.x.ax = 0x0003;
//    int86(0x33, &regs, &regs);
//    *x = regs.x.cx;
//    *y = regs.x.dx;
//}
//
//int main() {
//    int x = 0, y = 0;
//    int prev_x = -1, prev_y = -1;
//
//    set_video_mode();
//    if (!init_mouse()) {
//        return 1; // No mouse
//    }
//
//    while (!kbhit()) {
//        get_mouse_pos(&x, &y);
//        x = x * SCREEN_WIDTH / 640;
//        y = y * SCREEN_HEIGHT / 200;
//
//        if (x != prev_x || y != prev_y) {
//            if (prev_x >= 0 && prev_y >= 0) draw_cursor(prev_x, prev_y); // erase
//            draw_cursor(x, y); // draw new
//            prev_x = x;
//            prev_y = y;
//        }
//    }
//
//    getch(); // Wait for key
//    return 0;
//}
//

#include <dos.h>
#include <stdio.h>
#include <conio.h>

unsigned char far* vga_ptr = NULL;

void set_mode_13h() {
    union REGS regs;
    regs.h.ah = 0x00;
    regs.h.al = 0x13;
    int86(0x10, &regs, &regs);
}

void set_text_mode() {
    union REGS regs;
    regs.h.ah = 0x00;
    regs.h.al = 0x03;
    int86(0x10, &regs, &regs);
}

int map_vga_memory() {
    union REGS regs;
    struct SREGS sregs;

    regs.x.ax = 0x0800;       // DPMI: Map conventional memory
    regs.x.bx = 0xA000;       // Segment A000h
    regs.x.cx = 0x1000;       // 64KB (in paragraphs)
    int86x(0x31, &regs, &regs, &sregs);

    if (regs.x.cflag) {
        printf("Failed to map VGA memory!\n");
        return 0;
    }

    vga_ptr = (unsigned char far*)MK_FP(sregs.es, regs.x.di);
    return 1;
}

int main() {
    int y, x;
    set_mode_13h();

    if (!map_vga_memory()) {
        set_text_mode();
        return 1;
    }

    // Draw checkerboard pattern
    for (y = 0; y < 200; y++) {
        for (x = 0; x < 320; x++) {
            vga_ptr[y * 320 + x] = (x ^ y) & 0xFF; // XOR pattern
        }
    }

    getch(); // Wait for keypress

    set_text_mode();
    return 0;
}