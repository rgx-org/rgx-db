@echo off
setlocal
:: Because of this insane behaviour of modern Windows Terminal:
:: https://github.com/microsoft/terminal/issues/13306
:: we need to do some stupid checking stuff first...

:: Remove trailing backslash if present
set "CURDIR=%CD%"
if "%CURDIR:~-1%"=="\" set "CURDIR=%CURDIR:~0,-1%"

set "USERDIR=%USERPROFILE%"
if "%USERDIR:~-1%"=="\" set "USERDIR=%USERDIR:~0,-1%"

if /i "%CURDIR%"=="%USERDIR%" (
    echo Detected default user directory — aborting.
    exit /b
)

:: Normal launch continue...
powershell -ExecutionPolicy Bypass -File "%~dp0\dgVoodoo\dgVoodooToggle.ps1" on
echo Applying changes...
cd ..
extras\elevate.exe -w opensetup.exe /defaults

echo dgVoodoo enabled. You can close this window now.
pause >nul
