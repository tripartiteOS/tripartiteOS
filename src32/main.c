#include <stdio.h>
#include "defines/bugcheck/bugcheck.h"
//#include "Interrupts/ints.c" //bugged & unfinished so commented-out ¯\_(ツ)_/¯
void kernel_panic(unsigned int errorCode);
void HandlePanic(char errorCode[]);

int main(void)
{
	unsigned short cs;
	__asm__ volatile ("mov %%cs, %0" : "=r"(cs));
	if (cs % 3 == 3) for (;;){kernel_panic(0x00000002);}	// Means you run it through Windows' NTVDM, it doesn't allow any ring 0 access, so we cannot use it

	kernel_panic(0xDEADBEEF);
}

/// <summary>
/// Prints an error message and halts the CPU.
/// </summary>
/// <param name="errorCode">Error code. Those are like Windows' bugcheck — you never know when one pops up ☻</param>
void kernel_panic(unsigned int errorCode) 
{
	if (errorCode == 0xDEADBEEF | errorCode == 0xDEADDEAD) 
	{
		HandlePanic("MANUALLY_INITIATED_CRASH");
	}
	if (errorCode == 0x00000001) 
	{
		HandlePanic("KMODE_STACK_OVERFLOW_EXCEPTION");
	}
	if (errorCode == 0x00000002)
	{
		HandlePanic("NTVDM_LAUNCH");
	}
}
void HandlePanic(char errorCode[])
{
	printf(ERRCODE_BEGIN_GENERAL);
	printf(errorCode);
	printf(ERRCODE_TROUBLESHOOTING_BEGIN);
	if (errorCode == "MANUALLY_INITIATED_CRASH") printf(MANUALLY_INITIATED_CRASH_TROUBLESHOOTING_STEPS);
	if (errorCode == "KMODE_STACK_OVERFLOW_EXCEPTION") printf(KMODE_STACK_OVERFLOW_EXCEPTION_TROUBLESHOOTING_STEPS);
	if (errorCode == "NTVDM_LAUNCH") printf(NTVDM_LAUNCH_TROUBLESHOOTING_STEPS);

	printf(ERRCODE_CONTACT_ADMIN);

	// Halt the CPU
	for (;;) 
	{
		__asm__ volatile (
			"cli\n\t"
			"hlt"
		);
	}
}
int SetVideoMode(unsigned char mode)
{
	__asm__ volatile (
		"mov al, %0\n\t"
		"int $0x10"
		:
		: "r"(mode)
	);
	return 0;
}