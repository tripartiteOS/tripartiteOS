:: Package installation script file for an example package for tripartiteOS.
:: The packages are installed into C:\TRPRTOS\packages\exampl~1 as a DOS 8.3 name (remember, this OS relies so much on DOS that it can barely be called an OS).
@ECHO off
:start
ECHO This is the package installation script for the example package for tripartiteOS.
ECHO This package will be installed into C:\TRPRTOS\packages\exampl~1.

:: The following file is a system file that requests a system reboot after the installation is complete. It is required for this package to work properly.
:: The developer must decide themselves whether to include this or not, but it is recommended to include it if the package makes significant changes to the system that require a reboot to take effect.
:: The driver packs, which are a type of package that installs drivers for hardware devices, must include this file to ensure that the drivers are properly loaded after installation.
:: For the tech savvy users, this file lives in C:\TRPRTOS\SYSTEM\PKGAPI\reqsysrb.com and is a tpOS32 executable that takes two arguments: /caller and /reason. The /caller argument is a string that identifies the package or installer that is requesting the reboot, and the /reason argument is a string that explains why the reboot is necessary. This information is used by the system to display a message to the user when the reboot is requested, and it can also be used for logging purposes.
reqsysrb /caller="Example Package Installer" /reason="The example package has been installed and requires a reboot to take effect."
:: That's it, anything you put past this (unless you jump to a label) will not be executed since the system will be rebooted.