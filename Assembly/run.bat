@echo off
FOR %%i IN (*.sln*) DO (
	set file=%%i
)
set file=%file:~0,-4%
start /wait /min cmd /C build.bat

if exist %file%\Debug\%file%.exe (
	start %file%\Debug\%file%.exe
) else (
	echo "Please run build and fix your problems first."
	exit /b 1
)