ECHO OFF
call CmdExtensions.exe GetIniConfig -FilePath:"config.ini" -Key:solution-path > temp.txt
set /p solution_path=<temp.txt

call ColorText 02 "Restoring nuget App.App"
call nuget.exe restore %solution_path%

call ColorText 02 "Building App.App"

SET logfile="Logs\Build_App.App_LOG.log"
set solutionPath=%solution_path%

call CmdExtensions.exe GetIniConfig -FilePath:"config.ini" -Key:msbuild-enviroment > temp.txt
set /p msbuild_enviroment=<temp.txt

:: Set build environment
call %msbuild_enviroment%

:: Publish project
call msbuild %solutionPath% /maxcpucount:4 /t:Clean,Build /p:Configuration=Release /l:FileLogger,Microsoft.Build.Engine;logfile=%logfile% /clp:ErrorsOnly

cd %Temp%
call ColorText 02 "Build App.App Done"
