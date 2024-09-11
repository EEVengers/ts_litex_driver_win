echo off

setlocal
for /F "delims== tokens=1,* eol=#" %%i in (.\version.txt) do set %%i=%%~j

msbuild litepciedrv.vcxproj /p:Configuration=Debug /p:Platform=x64

msbuild litepciedrv.vcxproj /p:Configuration=Release /p:Platform=x64
stampinf -d %STAMPINF_DATE% -v %STAMPINF_VERSION% -x -f x64\Release\litepciedrv.inf
stampinf -d %STAMPINF_DATE% -v %STAMPINF_VERSION% -x -f x64\Release\litepciedrv\litepciedrv.inf

endlocal