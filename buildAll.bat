rmdir build
	cd src16
		build.bat
	cd ..
	cd src32
		build.bat
	cd ..
	cd src64
		build.bat
	cd ..
mkdir build
	cd build
		mkdir TRPRTOS
		cd TRPRTOS
			mkdir SYSTEM
		cd ..
	cd ..
cd src16
	cd tos.com
		copy tos.com ..\build\TRPRTOS\SYSTEM\
	cd ..
cd src32
	copy kernel32.obj ..\build\TRPRTOS\SYSTEM\
	cd ..
cd src64 copy kernel64.obj ..\build\TRPRTOS\SYSTEM\
REM Other stuff yet to do, I'm too lazy to write it rn