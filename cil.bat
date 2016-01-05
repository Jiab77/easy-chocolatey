@echo off
for %%a in (cls echo) do %%a.
setlocal EnableDelayedExpansion
title Chocolatey list installer
set list=%~1
set n=0
set total=0
for /f %%? in (!list!) do (
	set /a total+=1
)
echo Total: !total! soft to install
echo.
for /f %%i in (!list!) do (
	set /a n+=1
	title Installing software [!n! / !total!] - %%i...
	call ci.bat %%i
)
title Finished ^^! [!n! / !total!]
echo. & echo Installation finished ^^!
echo Check chocolatey log file if errors...
echo.
