>[!NOTE]
> This article is WIP (Work-In-Progress).
# tripartiteOS — Boot process
###### Licensed as GNU GPLv2
This document describes the boot process of tripartiteOS.
## Step 0. BIOS initializes the PC hardware and boots MS-DOS.
This process won't be documented as this part is common to all OSes.
## Step 1. MS-DOS boots
1. IO.SYS loads MSDOS.SYS into memory.
2. String "Starting MS-DOS..." is printed onto the screen.
3. The CONFIG.SYS file is being executed.
4. COMMAND.COM is started
5. The AUTOEXEC.BAT file is executed.
## Step 2. tripartiteOS itself is booted
6. From within it, TOS.COM is executed.
7. The boot logo is displayed.
8. The KERNEL.EXE is executed, and it continues the init.