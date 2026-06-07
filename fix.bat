@echo off
title  ms-gamingoverlay fix
echo   Fix "ms-gamingoverlay" link error
echo   For Windows 10 LTSC
echo   Maintained  by: mcbennet-coder
echo   https://github.com/mcbennet-coder
echo.

:: Check admin rights
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ERROR : Please run as Administrator!
    pause
    exit /b 1
)

echo 1.Closing Explorer...
taskkill /f /im explorer.exe > nul 2>&1

echo 2.Writing Registry keys...

:: Main keys, disabling GameDVR и GameBar
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 0 /f > nul 2>&1
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f > nul 2>&1
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d 2 /f > nul 2>&1
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_FSEBehavior" /t REG_DWORD /d 2 /f > nul 2>&1

:: Politicians, so that the system does not try to re-enable this good
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 0 /f > nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_DWORD /d 0 /f > nul 2>&1

:: We remove the protocol association so that the system doesn't even have to look for something to open this link with.
reg delete "HKEY_CURRENT_USER\SOFTWARE\Classes\ms-gamingoverlay" /f > nul 2>&1

echo 3.Cleaning temporary files...
del /f /s /q "%localappdata%\Packages\Microsoft.GamingServices_*" > nul 2>&1
del /f /s /q "%localappdata%\Packages\Microsoft.XboxApp_*" > nul 2>&1

echo 4.Restarting Explorer and applying changes...
start explorer.exe

echo.
echo Operation completed successfully!
pause