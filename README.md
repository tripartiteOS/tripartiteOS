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

You'll probably want more DOS tools and drivers, so check out [THIRD_PARTY.md](https://github.com/ProximalElk6186/tripartiteOS/blob/main/THIRD_PARTY.md) for a list of software included with official builds of tripartiteOS.
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
| Component                         | Purpose                               | Acquiring a copy                                                 |
| :-------------------------------- | :------------------------------------ | :--------------------------------------------------------------- |
| `NASM`                            | For assembling 16-bit startup code    | [nasm.us](https://www.nasm.us)                                   |
| `DJGPP`                           | For compiling 32-bit parts            | [https://www.delorie.com/djgpp/](https://www.delorie.com/djgpp/) |
| `DEBUG.EXE` or `DosBox`           | Optional DOS testing                  |                                                                  |
| `QEMU`, `VMware`, or `VirtualBox` | To boot the OS                        |                                                                  |

Add all of the tools to `path`.

>[!WARNING]
> To compile the 32-bit kernel and utilities, you will need:
> 
> - **DJGPP** (tested with version 2.x)
>   - Set up `DJGPP.ENV` correctly
>   - Add `bin` directory to your system `PATH`
> - A **_32-bit version of Windows_** (e.g. Windows XP) or **_real MS-DOS_**
>	- **64-bit Windows _cannot_ run DJGPP programs** due to lack of 16-bit support
>	- Alternatively, you can build inside **DOSBox**, **VirtualBox**, or on real hardware
>
> Regardless, **YOU MUST TEST THE KERNEL UNDER <ins>REAL DOS!</ins>** This is because Windows forces PMODE DOS apps to work in CPU ring 3 whereas tripartiteOS requires ring 0 access.

> [!NOTE]
> Building on Linux is currently not supported. Use Windows to build tripartiteOS.
#### Project structure
| Folder    | Contents											|
| :-------- | :------------------------------------------------ |
| `src16\`  | 16-bit DOS-compatible bootstrap code				|
| `src32\`  | 32-bit kernel components (Protected mode)         |
| `src64\`  | 64-bit features (long mode support)               |
| `common\` | Shared libraries, headers, and utilities			|
| `build\`  | Compiled objects and final binaries				|
### Building Steps
This section contains instructions on building tripartiteOS itself. You'll need a command-line environment like `Developer Command Prompt for VS` (Windows).

You can use a convenience script `buildAll.bat` in the project's root.

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
