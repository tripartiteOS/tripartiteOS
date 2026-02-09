@ECHO OFF
PROMPT $P$G
C:\pathcfg.bat

:: Go to whichever option the user selected in the boot menu through CONFIG.SYS
GOTO %CONFIG%

:: Load all of the drivers, then load tripartiteOS
:TRIOS
:: Mouse driver with wheel support enabled
C:\TRPRTOS\SYSTEM\DRVINIT\mousewhl.bat

:: Modern sound card driver
C:\TRPRTOS\SYSTEM\DRVINIT\audmdrn.bat

:: CD-ROM driver
C:\TRPRTOS\SYSTEM\DRVINIT\cdrom.bat

:: RAM Drive driver needed for runtime configuration variables and that kind of thingies
C:\TRPRTOS\SYSTEM\DRVINIT\ramdrv.bat

:: ONLY FOR OLD SOUND CARDS
:: C:\TRPRTOS\SYSTEM\DRVINIT\audold.bat

:: The GUI itself
C:\TRPRTOS\SYSTEM\DRVINIT\trprtos.bat

:: Display the safe to turn off screen upon exiting the GUI
GOTO SHUTDOWN

:: Load no drivers, then load tripartiteOS
:SAFE
ECHO Safe mode selected. No drivers loaded.

:: RAM Drive driver needed for runtime configuration variables and that kind of thingies
C:\TRPRTOS\SYSTEM\DRVINIT\ramdrv.bat

:: The GUI itself
C:\TRPRTOS\SYSTEM\DRVINIT\trprtos.bat

:: Display the safe to turn off screen upon exiting the GUI
GOTO SHUTDOWN

:: Load all drivers, then load the command prompt
:CMD
:: Mouse driver with wheel support disabled
C:\TRPRTOS\SYSTEM\DRVINIT\mouse.bat

:: Modern sound card driver
C:\TRPRTOS\SYSTEM\DRVINIT\audmdrn.bat

:: CD-ROM driver
C:\TRPRTOS\SYSTEM\DRVINIT\cdrom.bat

:: ONLY FOR OLD SOUND CARDS
:: C:\TRPRTOS\SYSTEM\DRVINIT\audold.bat

:: Exit
GOTO END

:: Load all drivers and the mouse with scrolling support, then load the command prompt
:CMDWHEEL
:: Mouse driver with wheel support enabled
C:\TRPRTOS\SYSTEM\DRVINIT\mousewhl.bat

:: Modern sound card driver
C:\TRPRTOS\SYSTEM\DRVINIT\audmdrn.bat

:: CD-ROM driver
C:\TRPRTOS\SYSTEM\DRVINIT\cdrom.bat

:: ONLY FOR OLD SOUND CARDS
:: C:\TRPRTOS\SYSTEM\DRVINIT\audold.bat

:: Exit
GOTO END

:: Load no drivers, then load the command prompt
:CMDSAFE
ECHO Safe mode selected. No drivers loaded.
GOTO END

:SHUTDOWN
:: Display the safe to turn off screen after the main shell program exits
ECHO ==========================
ECHO IT'S NOW SAFE TO TURN OFF
ECHO       YOUR COMPUTER
ECHO ==========================

:LOOPSD
:: Halt the CPU
halt.com
goto LOOPSD

:END