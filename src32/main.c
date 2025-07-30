#include <stdio.h>
int main(void)
{
	unsigned short cs;
	__asm__ volatile ("mov %%cs, %0" : "=r"(cs));
	printf("CS = 0x%X (CPL = %d)\n", cs, cs & 3);
}