
SET PACKAGE_FOLDER=%1
echo %PACKAGE_FOLDER%

call CmdExtensions.exe GetIniConfig -FilePath:"config.ini" -Key:remote-machine-user > temp.txt
set /p USERNAME=<temp.txt

call CmdExtensions.exe GetIniConfig -FilePath:"config.ini" -Key:remote-machine-password > temp.txt
set /p PASSWORD=<temp.txt

call CmdExtensions.exe GetIniConfig -FilePath:"config.ini" -Key:remote-machine-packages-folder > temp.txt
set /p COPY_TO=<temp.txt

net use %COPY_TO% %PASSWORD% /user:%USERNAME%
:copy
robocopy "%PACKAGE_FOLDER%" %COPY_TO% /S /R:5 /W:5
IF ERRORLEVEL 0 goto disconnect
goto end
:disconnect 
net use %COPY_TO% /delete
goto end

call disconnect-vpn.bat
:end