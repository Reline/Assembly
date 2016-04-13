@echo off
FOR %%i IN (*.sln*) DO (
	set file=%%i
)
set debugger=C:%HOMEPATH%\Downloads\snapshot_2016-04-13_12-07\release\x96dbg.exe
set file=%file:~0,-4%
start /wait /min cmd /C build.bat

if exist %file%\Debug\%file%.exe (
	start %debugger% %CD%\%file%\Debug\%file%.exe
) else (
	echo "Please run build and fix your problems first."
	exit /b 1
)