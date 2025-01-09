@echo off
:: Set the Command Prompt to UTF-8 encoding for special character support
chcp 65001 >nul
cls

:: Prompt the user to enter a port number
set /p port=Enter the port number: 

:: Find the Process ID (PID) associated with the port number
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :%port%') do (
    set pid=%%a
    goto :kill
)

echo No process found for the given port number.
pause
exit /b

:kill
:: Attempt to kill the process using its PID
echo Process ID found for port %port%: %pid%
taskkill /F /PID %pid% >nul 2>&1
if %errorlevel% neq 0 (
    echo Access denied or unable to terminate the process. Try running as administrator.
) else (
    echo Process successfully terminated.
)
pause
exit /b