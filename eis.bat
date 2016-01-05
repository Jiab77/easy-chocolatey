@echo off
setlocal EnableDelayedExpansion
set export=ci-list2.txt
set log=log-installed.txt
type NUL>"%export%"
call choco list -l >"%log%"
for /f "tokens=1-2" %%s in (%log%) do (
	set software=%%s
	set version=%%t

	if /i not "!version!"=="packages" (
		for /f "usebackq delims=. tokens=1-2" %%c in ('!software!') do (
			REM echo S=!software! - C=%%c - D=%%d -^> %%c.%%d
			if /i "!software!"=="%%c.%%d" (
				echo -^> Skipped !software!
			) else (
				echo -^> Adding !software!
				echo !software!>>ci-list2.txt
			)
		)
	)
)
if exist %export% (
	echo.
	echo Software list exported to %CD%\%export%
	echo Type cil.bat %export% to install them all ^^!
	echo.
)