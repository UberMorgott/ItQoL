@echo off
setlocal enabledelayedexpansion

:: One-time admin elevation
fltmc >nul 2>&1 || (
    powershell -c "Start-Process cmd '/c \"%~f0\"' -Verb RunAs"
    exit /b
)

:: Package definitions
set "url1=https://download.microsoft.com/download/8/B/4/8B42259F-5D70-43F4-AC2E-4B208FD8D66A/vcredist_x86.exe"
set "url2=https://download.microsoft.com/download/8/B/4/8B42259F-5D70-43F4-AC2E-4B208FD8D66A/vcredist_x64.exe"
set "url3=https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x86.exe"
set "url4=https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x64.exe"
set "url5=https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x86.exe"
set "url6=https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x64.exe"
set "url7=https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x86.exe"
set "url8=https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x64.exe"
set "url9=https://aka.ms/highdpimfc2013x86enu"
set "url10=https://aka.ms/highdpimfc2013x64enu"
set "url11=https://aka.ms/vs/17/release/vc_redist.x86.exe"
set "url12=https://aka.ms/vs/17/release/vc_redist.x64.exe"
set "url13=https://download.microsoft.com/download/8/4/A/84A35BF1-DAFE-4AE8-82AF-AD2AE20B6B14/directx_Jun2010_redist.exe"

set "arg1=/Q"
set "arg2=/Q"
set "arg3=/q"
set "arg4=/q"
set "arg5=/quiet /norestart"
set "arg6=/quiet /norestart"
set "arg7=/quiet /norestart"
set "arg8=/quiet /norestart"
set "arg9=/quiet /norestart"
set "arg10=/quiet /norestart"
set "arg11=/quiet /norestart"
set "arg12=/quiet /norestart"
set "arg13=dx"

set "name1=Visual C++ 2005 x86"
set "name2=Visual C++ 2005 x64"
set "name3=Visual C++ 2008 x86"
set "name4=Visual C++ 2008 x64"
set "name5=Visual C++ 2010 x86"
set "name6=Visual C++ 2010 x64"
set "name7=Visual C++ 2012 x86"
set "name8=Visual C++ 2012 x64"
set "name9=Visual C++ 2013 x86"
set "name10=Visual C++ 2013 x64"
set "name11=Visual C++ 2015-2022 x86"
set "name12=Visual C++ 2015-2022 x64"
set "name13=DirectX June 2010"

set "N=13"

:: Route: downloader subprocess
if "%~1"=="__dl" goto :downloader

:: Work in temp directory
set "W=%TEMP%\redist_%RANDOM%"
mkdir "!W!"
cd /d "!W!"

:: Launch downloader in background (silent — only installer writes to console)
start /b cmd /c ""%~f0" __dl"

:: ===== INSTALLER (foreground) =====
set /a i=1
:install
if !i! gtr %N% goto :done

set "nm=!name%i%!"
set "ar=!arg%i%!"

:: Wait for download
if not exist "!i!.exe" (timeout /t 1 /nobreak >nul & goto :install)

title Installing [!i!/%N%] !nm!

if "!ar!"=="dx" goto :install_dx

"!i!.exe" !ar! >nul 2>nul
goto :install_next

:install_dx
"!i!.exe" /Q /C /T:".\dx"
".\dx\DXSETUP.exe" /silent
rmdir /s /q ".\dx"

:install_next
del "!i!.exe" /q 2>nul
set /a i+=1
goto :install

:done
cd /d "%TEMP%"
rmdir /s /q "!W!" 2>nul
echo.
echo ==============================
echo   Done!
echo ==============================
title Done
timeout /t 5
exit /b

:: ===== DOWNLOADER (background) =====
:downloader
for /L %%i in (1,1,%N%) do call :dl_one %%i
exit /b

:dl_one
set "idx=%1"
echo.
echo [%idx%/%N%] Downloading !name%idx%!
curl -L -# -o "%idx%.tmp" "!url%idx%!" && ren "%idx%.tmp" "%idx%.exe"
goto :eof
