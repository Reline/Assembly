@echo off
FOR %%i IN (*.sln*) DO (
	set file=%%i
)
set file=%file:~0,-4%

del %file%\Debug /Q
C:\Windows\Microsoft.NET\Framework64\v4.0.30319\MSBuild.exe %file%\%file%.vcxproj
