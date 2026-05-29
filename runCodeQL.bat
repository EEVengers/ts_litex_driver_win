echo off
setlocal


:: Create new database
codeql database create codeql_db --overwrite --language=cpp --source-root=. --command="msbuild ts_litex_driver.sln /t:rebuild /p:Configuration=Release /p:Platform=x64"

:: Run CodeQL Analysis
codeql database analyze .\codeql_db microsoft/windows-drivers:windows-driver-suites/mustfix.qls --format=sarifv2.1.0 --output=litepciedrv\driverMustFixAnalysis.sarif
codeql database analyze .\codeql_db microsoft/windows-drivers:windows-driver-suites/mustrun.qls --format=sarifv2.1.0 --output=litepciedrv\driverMustRunAnalysis.sarif
codeql database analyze .\codeql_db microsoft/windows-drivers:windows-driver-suites/recommended.qls --format=sarifv2.1.0 --output=litepciedrv\driverRecommendedAnalysis.sarif

pushd "litepciedrv"
msbuild thunderscopedrv.vcxproj /target:dvl /p:Configuration="Release" /P:Platform=x64
popd

endlocal