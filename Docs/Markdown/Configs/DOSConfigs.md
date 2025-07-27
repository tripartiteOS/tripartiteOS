# tripartiteOS -- DOS configuration file documentation
###### Licensed as GNU GPLv2
## `config.sys`
First of all, this config file shows a menu. This is done via the `[MENU]` section, command `MENUITEM`.

This way, four choices are defined.

At the end of te `[MENU]` section, there is a `MENUCOLOR` command.

Then, you can see a bunch of sections. Note that they must be named exactly as defined in section `[MENU]`, commands `MENUITEM`.

Please note that here we don't yet have the `PATH` environment variable set up meaning that it's required to provide the absolute path to the entries.

## `autoexec.bat`

First of all, it disables printing executed commands into the terminal.

Then it sets the `PATH` environment variable. We recommend you to **NOT** modify this string.

Then it goes to `%CONFIG%`. This gets set by the `MENUITEM` command selections in `config.sys`.

Then we load the mouse driver (`CTMOUSE.EXE`), the sound driver (`JLOAD.EXE QPIEMU.DLL`, `HDPMI32i -r -x`, `SBEMU`), and, if "CMD-only" mode wasn't chosen, we execute the OS binary itself.

Note that this example is used in the official binaries of tripartiteOS.