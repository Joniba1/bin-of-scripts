:: Description: Terminates processes LISTENING on specified ports by finding their PIDs using netstat and then killing them with taskkill
:: Usage: killport [port1] [port2] [port3] ...

@echo off

if "%1"=="" (
  echo Usage: killport [port1] [port2] [port3] ...
  exit /b
)

setlocal enabledelayedexpansion

:loop
if "%1"=="" goto :end

for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":%1" ^| findstr "LISTENING"') do (
  echo Found LISTENING process on port %1 with PID %%a
  echo Terminating PID %%a...
  taskkill /PID %%a /F
  echo PID %%a terminated successfully.
)

shift
goto :loop

:end
endlocal
