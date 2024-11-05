@echo off
echo Optimizing PC for Gaming...
echo Starting optimization process...

set logFile="%temp%\optimization_log.txt"
echo Optimization Log - %date% %time% > %logFile%
echo Please wait while the optimization script runs...

:: Step 1: Set High-Performance Power Plan
echo Setting High Performance Power Plan...
echo Setting High Performance Power Plan... >> %logFile%
powercfg -duplicatescheme a1841308-3541-4fab-bc81-f71556f20b4a >> %logFile% 2>&1 || (
    echo Failed to set High Performance Power Plan & pause
    goto :end
)

:: Step 2: Stop unnecessary services to free up resources
echo Stopping unnecessary services...
echo Stopping unnecessary services... >> %logFile%
net stop "SysMain" >> %logFile% 2>&1 || echo Could not stop SysMain >> %logFile%
net stop "DiagTrack" >> %logFile% 2>&1 || echo Could not stop DiagTrack >> %logFile%
net stop "WSearch" >> %logFile% 2>&1 || echo Could not stop WSearch >> %logFile%
net stop "MapsBroker" >> %logFile% 2>&1 || echo Could not stop MapsBroker >> %logFile%
net stop "Fax" >> %logFile% 2>&1 || echo Could not stop Fax >> %logFile%
net stop "Spooler" >> %logFile% 2>&1 || echo Could not stop Print Spooler >> %logFile%
net stop "Bluetooth Support Service" >> %logFile% 2>&1 || echo Could not stop Bluetooth Support >> %logFile%

:: Step 3: Clear Temporary Files
echo Clearing Temporary Files...
echo Clearing Temporary Files... >> %logFile%
del /q /f /s %TEMP%\* >> %logFile% 2>&1 || echo Could not clear TEMP files >> %logFile%
del /q /f /s C:\Windows\Temp\* >> %logFile% 2>&1 || echo Could not clear Windows TEMP files >> %logFile%

:: Step 4: Disable Game DVR and Xbox Game Bar
echo Disabling Game DVR and Xbox Game Bar...
echo Disabling Game DVR and Xbox Game Bar... >> %logFile%
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f >> %logFile% 2>&1 || echo Failed to disable GameDVR >> %logFile%
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 0 /f >> %logFile% 2>&1 || echo Failed to disable AllowGameDVR >> %logFile%
reg add "HKCU\Software\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d 0 /f >> %logFile% 2>&1 || echo Failed to disable Game Bar auto game mode >> %logFile%
reg add "HKCU\Software\Microsoft\GameBar" /v "ShowStartupPanel" /t REG_DWORD /d 0 /f >> %logFile% 2>&1 || echo Failed to disable Game Bar startup panel >> %logFile%

:: Step 5: Disable Visual Effects
echo Disabling Visual Effects for performance...
echo Disabling Visual Effects... >> %logFile%
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d 2 /f >> %logFile% 2>&1 || echo Failed to disable Visual Effects >> %logFile%

:: Step 6: Free up memory
echo Flushing DNS cache to free up memory...
echo Flushing DNS cache... >> %logFile%
ipconfig /flushdns >> %logFile% 2>&1 || echo Failed to flush DNS >> %logFile%

:: Step 7: Restart Explorer (Optional, improves responsiveness)
echo Restarting Windows Explorer...
echo Restarting Explorer... >> %logFile%
taskkill /f /im explorer.exe >> %logFile% 2>&1 || echo Failed to restart Explorer >> %logFile%
start explorer.exe >> %logFile% 2>&1

:end
echo Optimization Complete! Check the log file for details: %logFile%
pause
exit
