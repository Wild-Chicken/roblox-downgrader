��
cls
@echo off
setlocal enabledelayedexpansion
:start
set sp=%programdata%\script
set ver=1.0
set /p clientpath=<!sp!\clientpath.txt
title roblox downgrader v%ver% ^| by chicken

echo loading..
echo finding dependencies..
curl >nul 2>&1
if %errorLevel%==2 ( echo found curl!
) else ( goto curl )
if not exist !sp! ( md !sp! )

if not exist !sp!\clientpath.txt (
	echo.
	echo input the directory path, not the executable
	echo ex: C:\Users\chicken\AppData\Local\Bloxstrap\Roblox\Player
	echo.
	set /p clientpath="where is your roblox at? "
	echo !clientpath! >!sp!\clientpath.txt
	goto menu
)

:menu
cls
echo what do you want to do?
echo r. restart script
echo w. wipe all script data
echo 0. exit
echo 1. start roblox (without updating, of course)
echo 2. downgrade roblox
echo 3. start executor
set /p script="choose an option: "
if %script%==r ( goto start
) else if %script%==w ( del /f /q /s !sp!\* & exit
) else if %script%==0 ( exit
) else if %script%==1 ( start "" "!clientpath!\RobloxPlayerBeta.exe"
) else if %script%==2 ( goto downgrade

:downgrade
cls
echo ex: b71c150c7c1f40de
set /p hash="what roblox hash? "
start "" https://rdd.latte.to/?channel=LIVE^&binaryType=WindowsPlayer^&version=!hash!
echo save in current folder! (%~dp0)
echo click any key when done downloading..
pause >nul
del /f /q /s "!clientpath!"\*
powershell -command "Expand-Archive -Path '%~dp0' -DestinationPath '!clientpath!'"
goto askexit

:askexit
echo.
set /p askexit="would you like to go to the menu? (y/n) "
if %askexit%==y ( goto menu
) else ( exit )
echo.
echo how'd you get here?
goto askexit
:curl
echo you need curl for this script.
set /p curl="would you like to install curl? (y/n) "
if %curl%==y ( winget install cURL.cURL & goto start
) else (
	echo ok.
	echo click any key to continue
	pause >nul
	exit
)
echo fard
endlocal