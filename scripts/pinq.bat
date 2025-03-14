@echo off

:: Description: Pings www.google.com a specified number of times to test connectivity.
:: Usage: pinq -n [number_of_pings]

set count=4

if "%1"=="" (
    goto exec
) else if not "%1"=="-n" (
    goto error
)

set "str=%~2"
if "%str:~0,1%"=="-" (
    echo Error: Inavlid number
    goto end
)

set count=%2

:exec
ping www.google.com -n %count%

:error
echo Usage: pinq -n [number_of_pings]

:end