echo off
setlocal enabledelayedexpansion

:: Get Commit Date
for /f "tokens=1" %%a in ('"git show -s --format=%%cd --date=format:%%m/%%d/%%Y"') do SET COMMIT_DATE=%%a

:: Find the latest vMAJOR.MINOR.PATCH tag and compute commits since that tag.
set "TAG="
for /f "delims=" %%t in ('cmd /c "git describe --abbrev=0 --tags --match v[0-9]*.[0-9]*.[0-9]* 2>nul"') do set "TAG=%%t"

if defined TAG (
  set "BASE=!TAG!"
  if "!BASE:~0,1!"=="v" set "BASE=!BASE:~1!"
  for /f %%c in ('git rev-list !TAG!..HEAD --count') do set "COUNT=%%c"
  set "COMMIT_VERSION=!BASE!.!COUNT!"
) else (
  for /f "tokens=2" %%a in ('"git show -s --format=%%ci"') do SET COMMIT_TIMESTAMP=%%a
  set "COMMIT_VERSION=!COMMIT_TIMESTAMP::=.!"
)

msbuild ts_litex_driver.sln -t:restore -p:RestorePackagesConfig=true /p:Platform=x64
msbuild ts_litex_driver.sln /p:Configuration=Debug /p:Platform=x64 /p:DriverDate=%COMMIT_DATE% /p:DriverVersion=%COMMIT_VERSION%
msbuild ts_litex_driver.sln /p:Configuration=Release /p:Platform=x64 /p:DriverDate=%COMMIT_DATE% /p:DriverVersion=%COMMIT_VERSION%

endlocal