:: This batch file execute and output your PC Info
@echo OFF

goto check_Permissions

:check_Permissions
echo.
echo Administrative permissions required. Detecting permissions...

net session >nul 2>&1
if %errorLevel% == 0 (
	echo.
    echo Fuyoh! Administrative permissions confirmed, you are so smart! 
	goto run_powershell
) else (
    goto admin_failed
)

:run_powershell
PowerShell.exe -NoProfile -Command "& {Start-Process PowerShell.exe -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""%~dp0theJuice.ps1""' -Verb RunAs}"
@echo.
@echo Gathering Info... ...
timeout 1 >nul
@echo. 
@echo Created a file on desktop name: PC_Info.
timeout 1 >nul
@echo. 
@echo Done liao, simply click one button to exit
@echo.
@echo.
PAUSE
goto :eof

:admin_failed
@echo. 
echo Admin Level Detection Failure.
@echo. 
@echo Aiyoyo, right click and open the "OPEN_THIS" file as Administrator. xD
@echo.
@echo. 
PAUSE
goto :eof
