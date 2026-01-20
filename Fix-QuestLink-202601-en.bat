@echo off

echo ==========================================
echo Emergency Fix Program for Quest Link Issues
echo January 20, 2026
echo ==========================================
echo.

rem Check for administrator privileges
NET SESSION > NUL 2>&1
IF %ERRORLEVEL% == 0 (
    GOTO PROCESS
) ELSE (
    ECHO Administrator rights are required to run this file.
    ECHO Right-click the file and select "Run as administrator."
    ECHO Aborting.
    pause
    EXIT /B 1
)

:PROCESS

ECHO Enter the number of the action you want to run and press ENTER.
ECHO.
ECHO 1: Apply temporary Quest Link fix
ECHO 2: Remove temporary fix
ECHO 3: Exit
ECHO.
set /p choice=Enter your choice (1/2/3):
ECHO.

IF "%choice%"=="3" (
    ECHO No actions were taken.
    GOTO END
)
IF "%choice%"=="1" (
    ECHO Applying the temporary Quest Link fix...
    netsh advfirewall firewall set rule name="oculus-dash:dash\bin\OculusDash.exe Outbound" new enable=no
    netsh advfirewall firewall add rule name="oculus-dash temporary disable" dir=out program="%ProgramFiles%\Oculus\Support\oculus-dash\dash\bin\OculusDash.exe" action=block
    ECHO If "OK" appears twice, the fix completed successfully.
    ECHO After Meta releases an official fix, run this program to remove the temporary workaround.
    GOTO END
)
IF "%choice%"=="2" (
    ECHO Removing the temporary Quest Link fix...
    netsh advfirewall firewall delete rule name="oculus-dash temporary disable"
    netsh advfirewall firewall set rule name="oculus-dash:dash\bin\OculusDash.exe Outbound" new enable=yes
    ECHO If "OK" appears twice, the removal completed successfully.
    GOTO END
)

:END
ECHO.
ECHO Exiting program.
pause
EXIT /B 0