echo off
setlocal

:: Get Commit Date
for /f "tokens=1" %%a in ('"git show -s --format=%%cd --date=format:%%m/%%d/%%Y"') do SET COMMIT_DATE=%%a

:: Get Commit timestamp
for /f "tokens=2" %%a in ('"git show -s --format=%%ci"') do SET COMMIT_TIMESTAMP=%%a
Set COMMIT_VERSION=%COMMIT_TIMESTAMP::=.%

msbuild ts_litex_driver.sln /p:Configuration=Debug /p:Platform=x64 /p:DriverDate=%COMMIT_DATE% /p:DriverVersion=%COMMIT_VERSION%
msbuild ts_litex_driver.sln /p:Configuration=Release /p:Platform=x64 /p:DriverDate=%COMMIT_DATE% /p:DriverVersion=%COMMIT_VERSION%

endlocal