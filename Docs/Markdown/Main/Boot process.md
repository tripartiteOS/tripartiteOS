>[!NOTE]
> This article is WIP (Work-In-Progress).
# tripartiteOS � Boot process
###### Licensed as GNU GPLv2
This document describes the boot process of tripartiteOS.

0. BIOS initializes the PC hardware and boots MS-DOS.
This process won't be documented as this part is common to all OSes.
1. `IO.SYS` loads `MSDOS.SYS` into memory.
2. String "Starting MS-DOS..." is printed onto the screen.
3. The `CONFIG.SYS` file is being executed.
4. A menu with choices is displayed to the user to select the desired starup mode.
5. If applicable, `SETVER.EXE` is executed.
6. If applicable, `HIMEMSX.EXE` is executed.
5. `COMMAND.COM` is started.
6. The `AUTOEXEC.BAT` file is executed.
7. From within it, `TOS.COM` is executed.
8. The boot logo is displayed.
9. The `KERNEL.EXE` is executed, and it continues the init.