@echo off

:: BatchGotAdmin        
:-------------------------------------        
REM  --> Check for permissions  
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"  
REM --> If error flag set, we do not have admin.  
if '%errorlevel%' NEQ '0' (    echo Requesting administrative privileges...    goto UACPrompt) else ( goto gotAdmin )  
:UACPrompt  
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"  
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"  
    "%temp%\getadmin.vbs"  
    del "%temp%\getadmin.vbs"
    exit /B
:gotAdmin  

call :sub >%~dp0%\powercfg_output.txt
exit /b 0

:sub
    echo Last Wake:
    powercfg -lastwake
    echo --------------
    echo Wake Armed:
    powercfg -devicequery wake_armed
    echo --------------
    echo Wake Timers:
    powercfg -waketimers
    echo --------------
    echo Wake Programmable Devices:
    powercfg -devicequery wake_programmable
    echo --------------
    echo Available Sleep States:
    powercfg -a
    echo --------------
    echo Use powercfg -devicedisablewake "exact device name" to disable the wake functionality of device