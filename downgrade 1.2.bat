��
cls
@echo off
setlocal enabledelayedexpansion
:start
set sp=%programdata%\script
set ver=1.2
set /p clientpath=<!sp!\clientpath.txt
set /p execpath=<!sp!\execpath.txt
title roblox downgrader v%ver% ^| by chicken

echo loading..
echo finding dependencies..
curl >nul 2>&1
if %errorLevel%==2 ( echo found curl!
) else ( call :curl )
if not exist !sp! ( md !sp! )

if not exist !sp!\clienttype.txt ( goto clienttype )

if not exist !sp!\clientpath.txt (
	echo.
	echo where is your roblox folder at?
	echo input the directory path, not the executable
	echo ex: C:\Users\chicken\AppData\Local\Bloxstrap\Roblox\Player
	echo.
	set /p clientpath="where is your roblox at? "
	echo !clientpath! >!sp!\clientpath.txt
)

if not exist !sp!\execpath.txt (
	echo.
	echo it doesn't seem you set up your executor path.
	echo input the executable, not the directory.
	echo ex: C:\Users\chicken\3D Objects\solara\Bootstrapper.exe
	set /p execpath="where is your executor at? "
	echo !execpath! >!sp!\execpath.txt
)

:menu
cls
echo what do you want to do?
echo r. restart script
echo w. wipe all script data
echo s. start executor and roblox
echo 0. exit
echo 1. start roblox
echo 2. downgrade roblox
echo 3. start executor
echo 4. github page
echo 5. check out my batch multitool
set /p script="choose an option: "
if %script%==r ( goto start
) else if %script%==w (
	del /f !sp!\execpath.txt !sp!\clientpath.txt !sp!\clienttype.txt
	exit
) else if %script%==s (
	start "" "!execpath!"
	timeout /t 3 >nul
	start "" "!clientpath!\RobloxPlayerBeta.exe"
	call :del
) else if %script%==0 ( exit
) else if %script%==1 (
	start "" "!clientpath!\RobloxPlayerBeta.exe"
	call :del
) else if %script%==2 ( goto downgrade
) else if %script%==3 (
	start "" "!execpath!"
	call :del
) else if %script%==4 ( goto message
) else if %script%==5 ( start "" https://github.com/chicken-projects/roblox-downgrader
) else if %script%==6 ( start "" http://chicken.bulletinbay.com/data/scripts
) else (
	echo invalid option!
	timeout /t 2 >nul
	goto menu
)
goto askexit
:downgrade
cls
echo ex: b71c150c7c1f40de
set /p hash="what roblox hash? "
start "" https://rdd.latte.to/?channel=LIVE^&binaryType=WindowsPlayer^&version=!hash!
echo save in current folder %systemdrive%%~dp0
echo and DO NOT RENAME.
echo click any key when done downloading..
pause >nul
del /f /q /s "!clientpath!\*"
powershell -command "Expand-Archive -Path '%~dp0LIVE-WindowsPlayer-version-!hash!.zip' -DestinationPath '!clientpath!\'"
goto askexit

:askexit
echo.
set /p askexit="would you like to go to the menu? (y/n) "
if %askexit%==y ( goto menu
) else ( exit )
echo.
echo how'd you get here?
goto askexit
:clienttype
echo this is for roblox downgrader. >!sp!\clienttype.txt
	echo 1. bloxstrap
	echo 2. other
	set /p clienttype="choose an option: "
	if %clienttype%==1 ( echo ok, good!
	) else (
		del /f /q !sp!\*
		echo you need bloxstrap!
		echo click any key to exit..
		pause >nul
		exit
	)
goto start

:curl
echo you need curl for this script.
set /p curl="would you like to install curl? (y/n) "
if %curl%==y (
	winget install cURL.cURL
	goto start
) else (
	echo ok.
	echo click any key to continue
	pause >nul
	exit
)
:del
del /s /f /q %tmp%\*
del /s /f /q %homepath%\AppData\LocalLow\Intel\ShaderCache\*
exit
endlocal