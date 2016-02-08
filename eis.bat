@echo off
setlocal EnableDelayedExpansion
set export=exported.txt
set log=installed.txt
type NUL>"%export%"
call choco list -l >"%log%"
for /f "tokens=1-2" %%s in (%log%) do (
	set software=%%s
	set version=%%t

	if /i not "!version!"=="packages" (
		for /f "usebackq delims=. tokens=1-2" %%c in ('!software!') do (
			set compare=%%c.%%d
			if /i "!software!"=="!compare!" (
				echo -^> Skipped !software!
			) else (
				echo -^> Adding !software!
				echo !software!>>"%export%"
			)
		)
	)
)
if exist "%export%" (
	echo.
	echo Software list exported to %CD%\%export%
	echo Type cil.bat %export% to install them all ^^!
	echo.
)
echo Press any key to exit... & pause>NUL
