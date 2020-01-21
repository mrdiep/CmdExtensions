@echo off
call CmdExtensions.exe GetIniConfig -FilePath:"config.ini" -Key:backend-repos > temp.txt
set /p BACKEND_PATH=<temp.txt

call CmdExtensions.exe GetIniConfig -FilePath:"config.ini" -Key:frontend-repos > temp.txt
set /p FRONTEND_PATH=<temp.txt

call CmdExtensions.exe GetIniConfig -FilePath:"config.ini" -Key:packages-folder > temp.txt
set /p PACKAGES_PATH=<temp.txt

call CmdExtensions.exe GetIniConfig -FilePath:"config.ini" -Key:bin-enviroment > temp.txt
set /p BIN_PATH=<temp.txt

call CmdExtensions.exe GetIniConfig -FilePath:"config.ini" -Key:7zip-cli > temp.txt
set /p ZIP_CLI=<temp.txt

@echo on

cd "%BACKEND_PATH%"
call git fetch
call git reset --hard origin/master

cd "%FRONTEND_PATH%"
call git fetch
call git reset --hard origin/master
call npm run build

cd "%BIN_PATH%"

echo -------------------WAIT MANUAL BUILD IN DEPLOY-BACKEND----------------
call build-backend.bat

@echo off
title Package Creator

setlocal enabledelayedexpansion
echo Enter version:
set /p versionName=Package Version Name:
md BUILD-PACKAGE-VERSION-%versionName%

cd "%BIN_PATH%"
call CmdExtensions.exe GetDate -Format:"yyyyMMddHHmmss.fff" > temp.txt
set /p TimeNow=<temp.txt

call %ZIP_CLI% a "%PACKAGES_PATH%\BUILD-PACKAGE-VERSION-%versionName%-%TimeNow%\FrontEnd Version %versionName%.zip" "%FRONTEND_PATH%\dist\*"
call %ZIP_CLI% a "%PACKAGES_PATH%\BUILD-PACKAGE-VERSION-%versionName%-%TimeNow%\External-OService Version %versionName%.zip" "%BACKEND_PATH%\Applications\App.App.External.OService\bin\Release\*"
call %ZIP_CLI% a "%PACKAGES_PATH%\BUILD-PACKAGE-VERSION-%versionName%-%TimeNow%\External-PushDataService Version %versionName%.zip" "%BACKEND_PATH%\Applications\App.App.External.PushDataService\bin\Release\*"
call %ZIP_CLI% a "%PACKAGES_PATH%\BUILD-PACKAGE-VERSION-%versionName%-%TimeNow%\Email Service Version %versionName%.zip" "%BACKEND_PATH%\Applications\App.App.EmailSenderService\bin\Release\*"
call %ZIP_CLI% a "%PACKAGES_PATH%\BUILD-PACKAGE-VERSION-%versionName%-%TimeNow%\BackEnd Version %versionName%.zip" "%BACKEND_PATH%\WebApi\App.App.WebApi\bin" "%BACKEND_PATH%\WebApi\App.App.WebApi\Config" "%BACKEND_PATH%\WebApi\App.App.WebApi\Content" "%BACKEND_PATH%\WebApi\App.App.WebApi\Images" "%BACKEND_PATH%\WebApi\App.App.WebApi\Web.config" "%BACKEND_PATH%\WebApi\App.App.WebApi\packages.config"

call connect-vpn.bat

call copy-file.bat "%PACKAGES_PATH%\BUILD-PACKAGE-VERSION-%versionName%-%TimeNow%"

call disconnect-vpn.bat

echo Copy Done
pause