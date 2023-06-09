@echo off

REM Set up array of download URLs and corresponding installation options
setlocal EnableDelayedExpansion
set /a count=0
for %%i in (
    "https://download.microsoft.com/download/8/B/4/8B42259F-5D70-43F4-AC2E-4B208FD8D66A/vcredist_x86.exe /q"
    "https://download.microsoft.com/download/8/B/4/8B42259F-5D70-43F4-AC2E-4B208FD8D66A/vcredist_x64.exe /q"
    "https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x86.exe /qb"
    "https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x64.exe /qb"
    "https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x86.exe /passive /norestart"
    "https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x64.exe /passive /norestart"
    "https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x86.exe /passive /norestart"
    "https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x64.exe /passive /norestart"
    "https://download.visualstudio.microsoft.com/download/pr/10912113/5da66ddebb0ad32ebd4b922fd82e8e25/vcredist_x86.exe /passive /norestart"
    "https://download.visualstudio.microsoft.com/download/pr/10912041/cee5d6bca2ddbcd039da727bf4acb48a/vcredist_x64.exe /passive /norestart"
    "https://aka.ms/vs/17/release/vc_redist.x86.exe /passive /norestart"
    "https://aka.ms/vs/17/release/vc_redist.x64.exe /passive /norestart"
) do (
  set arr[!count!]=%%~i
  set /a count+=1
)

REM Download and install files from the array
for /L %%i in (0,1,11) do (
  echo Processing !arr[%%i]!
  for /f "tokens=1,*" %%j in ("!arr[%%i]!") do (
    set "downloadUrl=%%~j"
    set "installParams=%%~k"
    powershell -Command "Invoke-WebRequest -Uri '!downloadUrl!' -OutFile 'tempFile.exe'; Start-Process 'tempFile.exe' -ArgumentList '!installParams!' -Wait"
  )
  del /f tempFile.exe
)

REM End of script
echo Done.
