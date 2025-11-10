echo off
setlocal


:: Create new database
codeql database create codeql_db --overwrite --language=cpp --source-root=. --command="msbuild ts_litex_driver.sln /t:rebuild /p:Configuration=Release /p:Platform=x64"

:: Run CodeQL Analysis
codeql database analyze .\codeql_db microsoft/windows-drivers:windows-driver-suites/mustfix.qls --format=sarifv2.1.0 --output=driverMustFixAnalysis.sarif
codeql database analyze .\codeql_db microsoft/windows-drivers:windows-driver-suites/mustrun.qls --format=sarifv2.1.0 --output=driverMustRunAnalysis.sarif
codeql database analyze .\codeql_db microsoft/windows-drivers:windows-driver-suites/recommended.qls --format=sarifv2.1.0 --output=driverRecommendedAnalysis.sarif

endlocal