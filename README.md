╔═══════════════════════════════╗
 
║░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░║

║░████░░█████░░░░░░░███░░░████░░║

║░░░░░█░█░░░░█░░░░░█░░░█░█░░░░░░║

║░███░░░█████░░░░░░█░░░█░░███░░░║

║░░░░█░░█░░░░░░██░░█░░░█░░░░░█░░║

║░░░░░█░█░░░░░░░░░░█░░░█░░░░░░█░║

║░░░░█░░█░░░░░░░░░░█░░░█░░░░░█░░║

║░███░░░█░░░░░░░░░░░███░░░███░░░║

║░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░║

╚═══════════════════════════════╝
# ░░░tripartiteOS [wip]░░░░
#### ░░░░░░░░░The triple-era OS░░░░░░░░░
- 16-bit software? 32-bit? 64-bit? tripartiteOS runs all of them!
- Fully DOS-compatible — flawlessly runs DOS programs as if you were running under a real DOS!
### Why choosing between eras? Have them all!
tripartiteOS flawlessly runs programs from the 80's, 90's and current day.
### Coordinate all programs no matter their age!
tripartiteOS allows for communication between all of the processes — the developers can fully coordinate the programs no matter their bitness!
### Convenient for development!
You are in full control — write real-mode drivers, flat binary loaders, or 64-bit applications.
### Open-source!
tripartiteOS is fully open-source and released under GPL v2, meaning everybody can contribute to the project!

All config files (`Configs\`) are licensed under CC0!
### Built with industry-leading tools!
tripartiteOS is built using NASM and MSVC/GCC which are industry-leading tools!
### Private!
tripartiteOS lacks any telemetry, ensuring maximal privacy!
### Secure!
tripartiteOS isn't vulnerable to any modern-day viruses, malware and threats meaning your data will be safe!
## Build guide
So, you want to build tripartiteOS yourself? Great! Follow the instructions given in this section to set up all of the required tools and compile the OS.
### Prerequisites
#### Required Toolchain
| Component                         | Purpose                               | Acquiring a copy                  |
| :--------------------------------- | :------------------------------------- | :--------------------------------- |
| `NASM`                            | For assembling 16-bit startup code    | [nasm.us](https://www.nasm.us)    |
| `GCC`                             | For compiling 32-bit and 64-bit parts | [https://gcc.gnu.org/](https://gcc.gnu.org/) |
| `DEBUG.EXE` or `DosBox`           | Optional DOS testing                  | Great for virtual DOS testing     |
| `QEMU`, `VMware`, or `VirtualBox` | To boot the OS                        | Any x86 emulator                  |

Add all of the tools to `path`.

> [!NOTE]
> Building on Linux is currently not supported. Use Windows to build tripartiteOS.
#### Project structure
| Folder    | Contents											|
| :--------- | :------------------------------------------------- |
| `src16\`  | 16-bit DOS-compatible bootstrap code				|
| `src32\`  | 32-bit kernel components (Protected mode)         |
| `src64\`  | 64-bit features (long mode support)               |
| `common\` | Shared libraries, headers, and utilities			|
| `build\`  | Compiled objects and final binaries				|
### Building Steps
This section contains instructions on building tripartiteOS itself. You'll need a command-line environment like `Developer Command Prompt for VS` (Windows).

You can use a convenience script `buildAll.bat` in the project's root.
<!--#### 1. Build the 16-bit initialisation code
```bash
cd src16
cd tos.com
nasm -f bin tos.asm -o tos.com
copy tos.com ..\..\build\
```
#### 2. Build the 32-bit part
```bash
cd ..\src32
cl /c /O2 kernel32.c
link /subsystem:native /entry:KernelMain kernel32.obj
copy kernel32.obj ..\build\
```
#### 3. Build the 64-bit part
```bash
cd ../src64
cl /c /O2 /favor:AMD64 kernel64.c
link /machine:x64 /entry:KernelMain64 kernel64.obj
```
---->
## Warranty Disclaimer
Copyright (C) 2025 — `Present` `ProximalElk6186`

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation in the version 2 of the License.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License along
with this program.
