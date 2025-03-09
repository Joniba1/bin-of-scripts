:: This script terminates the process that is LISTENING on a specified port 
:: by finding its PID using netstat and then killing it with taskkill

:: Usage: killport [port]

@echo off
if "%1"=="" (
    echo Usage: killport [port]
    exit /b
)

setlocal enabledelayedexpansion

for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":%1" ^| findstr "LISTENING"') do (
    echo Found LISTENING process on port %1 with PID %%a
    echo Terminating PID %%a...
    taskkill /PID %%a /F
    echo PID %%a terminated successfully.
)

