@echo off
setlocal enabledelayedexpansion
:: Generic Windows entry. Copy to repo root and adjust exe / vcpkg paths.
:: Usage: build.cmd [debug|release|tests|benchmark|configure|rebuild|clean|run|help]
set "SOURCE_DIR=%~dp0"
set "BUILD_ROOT=%SOURCE_DIR%build"
set "COMMAND=build"
set "BUILD_CONFIG=release"
set "VCPKG_ROOT=%VCPKG_ROOT%"
if "%VCPKG_ROOT%"=="" if exist "%SOURCE_DIR%third_party\vcpkg\scripts\buildsystems\vcpkg.cmake" (
    set "VCPKG_ROOT=%SOURCE_DIR%third_party\vcpkg"
)

:parse
if "%~1"=="" goto :done_parse
if /i "%~1"=="release"   ( set "BUILD_CONFIG=release" & shift & goto :parse )
if /i "%~1"=="debug"     ( set "BUILD_CONFIG=debug"   & shift & goto :parse )
if /i "%~1"=="tests"     ( set "COMMAND=tests"        & shift & goto :parse )
if /i "%~1"=="benchmark" ( set "COMMAND=benchmark"    & shift & goto :parse )
if /i "%~1"=="configure" ( set "COMMAND=configure"    & shift & goto :parse )
if /i "%~1"=="rebuild"   ( set "COMMAND=rebuild"      & shift & goto :parse )
if /i "%~1"=="clean"     ( set "COMMAND=clean"        & shift & goto :parse )
if /i "%~1"=="run"       ( set "COMMAND=run"          & shift & goto :parse )
if /i "%~1"=="help"      ( goto :help )
if /i "%~1"=="-h"        ( goto :help )
echo Unknown argument: %~1
exit /b 1

:done_parse
set "BUILD_DIR=%BUILD_ROOT%\%BUILD_CONFIG%"
if /i "%COMMAND%"=="clean" goto :clean
if /i "%COMMAND%"=="rebuild" (
    if exist "%BUILD_DIR%" rmdir /s /q "%BUILD_DIR%"
)
call :configure || exit /b 1
if /i "%COMMAND%"=="configure" exit /b 0
cmake --build "%BUILD_DIR%" --config %BUILD_CONFIG% || exit /b 1
if /i "%COMMAND%"=="tests" (
    ctest --test-dir "%BUILD_DIR%" --output-on-failure --build-config %BUILD_CONFIG% || exit /b 1
)
if /i "%COMMAND%"=="benchmark" (
    ctest --test-dir "%BUILD_DIR%" -R benchmark --output-on-failure --build-config %BUILD_CONFIG% || exit /b 1
)
if /i "%COMMAND%"=="run" (
    echo Launch the app from %BUILD_DIR% — set APP_EXE in this script.
)
exit /b 0

:configure
if not exist "%BUILD_DIR%" mkdir "%BUILD_DIR%"
set "CMAKE_EXTRA="
if not "%VCPKG_ROOT%"=="" set "CMAKE_EXTRA=-DCMAKE_TOOLCHAIN_FILE=%VCPKG_ROOT%\scripts\buildsystems\vcpkg.cmake"
if /i "%COMMAND%"=="tests" set "CMAKE_EXTRA=%CMAKE_EXTRA% -DBUILD_TESTING=ON"
if /i "%COMMAND%"=="benchmark" set "CMAKE_EXTRA=%CMAKE_EXTRA% -DBUILD_TESTING=ON -DBUILD_BENCHMARK=ON"
cmake -S "%SOURCE_DIR%" -B "%BUILD_DIR%" -DCMAKE_BUILD_TYPE=%BUILD_CONFIG% %CMAKE_EXTRA%
exit /b %ERRORLEVEL%

:clean
if exist "%BUILD_ROOT%" rmdir /s /q "%BUILD_ROOT%"
echo Removed %BUILD_ROOT%
exit /b 0

:help
echo build.cmd [debug^|release^|tests^|benchmark^|configure^|rebuild^|clean^|run^|help]
exit /b 0
