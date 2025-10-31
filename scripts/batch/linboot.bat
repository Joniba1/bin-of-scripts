:: Reboots directly from Windows into Ubuntu
@echo off

set /p CONFIRM=Are you sure you want to reboot into Ubuntu? [y/N]: 

set CONFIRM=%CONFIRM:~0,1%
set CONFIRM=%CONFIRM:a=A%
set CONFIRM=%CONFIRM:b=B%
set CONFIRM=%CONFIRM:c=C%

IF /I "%CONFIRM%"=="y" (
    echo Rebooting into Ubuntu...
    bcdedit /set {bootmgr} path \EFI\ubuntu\grubx64.efi
    shutdown /r /t 0
) ELSE (
    echo Cancelled. Staying in Windows.
)
