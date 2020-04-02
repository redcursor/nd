@echo OFF 
::
:: Network Diagnostic (Windows user)
:: Copyright (C) 20XX Shakiba Moshiri
::
:: cd /d c:/Users/%username%/Desktop

:: clear the screen
cls

:: set global variables
set TITLE=Network Diagnostic (Windows user)
set OUTPUT=result.txt

:: title , date , time
title %TITLE%
echo %TITLE% > %OUTPUT%
echo. >> %OUTPUT%
echo Start date: %DATE%
echo Start date: %DATE%  >> %OUTPUT%
echo Start time: %TIME%
echo Start time: %TIME% >> %OUTPUT%
echo.
echo. >> %OUTPUT%

:: set user's variables
echo.
set /p DN=1. Enter Domain name: 
set /p IP=2. Enter IP Address: 
echo.

:: save entered variables by user
echo Domain name: %DN% >> %OUTPUT% 2>&1
echo Ip Address: %IP%  >> %OUTPUT% 2>&1
echo. >> %OUTPUT%
echo. >> %OUTPUT%
echo.

:: flush DNS cache
echo | set /p=flushing DNS cache ... 
call _ipconfig_flushdns_.bat >> %OUTPUT% 2>&1
call :perror %errorlevel%
echo.

:: DNS query 
echo | set /p=nslookup: %DN% ... 
call _nslookup_.bat >> %OUTPUT% 2>&1
call :perror %errorlevel%
echo.

:: ping domain.com
echo | set /p=ping domain: %DN% ... 
call _ping_domain_.bat >> %OUTPUT% 2>&1
call :perror %errorlevel%
echo.

:: ping ip address of domain.com
echo | set /p=ping ip: %IP% ... 
call _ping_ip_.bat >> %OUTPUT% 2>&1
call :perror %errorlevel%
echo.

:: trace the ip
echo | set /p=trace route: %IP% ... 
call _tracert_ip_.bat >> %OUTPUT% 2>&1
call :perror %errorlevel%
echo.

echo.
echo End time: %TIME%
echo End time: %TIME% >> %OUTPUT%
echo please send "%OUTPUT%" file to your Web Hosting Support Team
echo.

pause
exit /b 0

:perror
if %~1 == 0 (
	echo [ ok ]
) else (
	echo [ error ]
)
exit /b 0
