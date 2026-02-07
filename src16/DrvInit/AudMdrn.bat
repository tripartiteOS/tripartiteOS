:: The initialization of the modern sound drivers in tripartiteOS
:: Meant to be executed from within autoexec.bat
JLOAD.EXE QPIEMU.DLL
HDPMI32i -r -x
SBEMU
ECHO Done initializing a newer AC'97 or Intel HD Audio sound card!