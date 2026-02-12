:: tripartiteOS main build script
:: I mean it should theoretically work
@ECHO off
chcp 65001
ECHO ╔══════════════════════════════════════╗
ECHO ║    tripartiteOS main build script    ║
ECHO ╠══════════════════════════════════════╣
ECHO ║ I mean, it should theoretically work ║
ECHO ║ but no gurantees. Licensed under GPL ║
ECHO ║            version 2 btw.            ║
ECHO ╟──────────────────────────────────────╢
ECHO ║   0. Backing up the previous build   ║
ECHO ╚══════════════════════════════════════╝

MOVE /Y .\src16\toscom\tos.com .\src16\toscom\tos.prev.com
ECHO Backed up the 16-bit bootstrap part!

MOVE /Y .\src32\kernel.exe .\src32\kernel.prev.exe
ECHO Backed up the 32-bit kernel part!

del /f /s /q build
rmdir /s /q build

ECHO ╔══════════════════════════════════════╗
ECHO ║1. Building the 16-bit bootstrap part ║
ECHO ╚══════════════════════════════════════╝

nasm -f bin .\src16\toscom\tos.asm -o .\src16\toscom\tos.com
if not exist .\src16\toscom\tos.asm goto BFB

ECHO ╔══════════════════════════════════════╗
ECHO ║  2. Building the 32-bit kernel part  ║
ECHO ╚══════════════════════════════════════╝

cd src32
.\build.bat

goto CRESTR

:BFB
ECHO ╔══════════════════════════════════════╗
ECHO ║    Building the bootstrap FAILED!    ║
ECHO ╚══════════════════════════════════════╝
ECHO ╔══════════════════════════════════════╗
ECHO ║      See above log for details.      ║
ECHO ╚══════════════════════════════════════╝

:CRESTR
ECHO Making the file structure...

mkdir .\build
ECHO Made the build directory!

copy .\configs\*.* .\build\*.*
ECHO Copied the config files to the build directory!

mkdir .\build\trprtos
ECHO Made the trprtos directory!

move /Y .\build\system.ini .\build\trprtos\system.ini
move /Y .\build\trprtos.ini .\build\trprtos\trprtos.ini
ECHO Moved the ini files to the trprtos directory!

mkdir .\build\trprtos\system
ECHO Made the system directory!

copy .\src16\toscom\tos.com .\build\trprtos\system\tos.com
ECHO Copied the tos.com file!

copy .\src32\kernel.exe .\build\trprtos\system\kernel.exe
ECHO Copied the kernel!

copy .\src32\cwsdpr0.exe .\build\trprtos\system\cwsdpr0.exe
ECHO copied the DPMI!

mkdir .\build\trprtos\system\drivers
ECHO Made the drivers directory!

copy .\src16\Drivers\*.* .\build\trprtos\system\drivers\*.*
ECHO Copied the drivers!

mkdir .\build\trprtos\system\drvinit
ECHO Made the drvinit directory!

copy .\src16\DrvInit\*.* .\build\trprtos\system\drvinit\*.*
ECHO Copied the driver initialization software!

:FINISH
ECHO ╔══════════════════════════════════════╗
ECHO ║           Build SUCCEEDED!           ║
ECHO ╚══════════════════════════════════════╝
pause
exit