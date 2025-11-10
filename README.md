# Thunderscope LiteX Windows Driver and Library

This repo contains Visual Studio projects for building a driver, library and test application for the Thunderscope using the [LitePCIe LiteX core](https://github.com/enjoy-digital/litepcie).

## Install Visual Studio Build Tools

Use winget and the provided vsconfig file to install the toolchain.

```cmd
winget install --id Microsoft.VisualStudio.2022.BuildTools --force --override "--wait --passive --config buildtools.vsconfig"
```

## Setup Test Signing

1. Create a [Test Signing Certificate](https://learn.microsoft.com/en-us/windows-hardware/drivers/install/creating-test-certificates)

2. [Enable loading Test Signed Drivers](https://learn.microsoft.com/en-us/windows-hardware/drivers/install/the-testsigning-boot-configuration-option) on your Test PC. 

```cmd
> Bcdedit.exe -set TESTSIGNING ON
```

## Building with Visual Studio

1. Download and install Visual Studio 2022 Build Tools

2. Open the solution

3. Setup a test certificate for the `thunderscopedrv` project

4. Build the solution with the `builddriver.bat` script

```cmd
> builddriver.bat
```

This 

## Building with EWDK

1. Download and install the EWDK.

2. Launch the EWDK environment

```cmd
> <EWDKInstallDir>\LaunchBuildEnv.cmd
```

3. From within the EWDK environment, build the solution with `msbuild`
```cmd
<Driver-Repo-Dir> > msbuild ts_litex_driver.sln /p:Configuration=Release /p:Platform=x64
```

4. To create a driver with a release version, build the solution with the following properties
```cmd
<Driver-Repo-Dir> > msbuild ts_litex_driver.sln /p:Configuration=Release /p:Platform=x64 /p:DriverDate=<tag-date> /p:DriverVersion=<tag-version>
```

## Install Debug Driver

1. Open a terminal with Admin privileges

2. From the root of the driver project, use `pnputil` to install the driver.
```cmd
<Driver-Repo-Dir> > pnputil /add-driver x64\Debug\thunderscopedrv\thunderscopedrv.inf /install
```

## Build Library and test app with cmake

```cmd
<LitePCIe-Repo-Dir>\build > cmake ..
<LitePCIe-Repo-Dir>\build > cmake --build .
```


## Run CodeQL
See [Run CodeQL Analysis on Windows DriverCode](https://learn.microsoft.com/en-us/windows-hardware/drivers/devtest/static-tools-and-codeql) for setup instructions.  Summarized below:

- Install CodeQL CLI
- Install WHCP Packs

Run the `runCodeQL.bat` script to run the CodeQL analysis.  This should be run within the same environment as a build.
