@ECHO OFF

CD src/shared_lib

ECHO Buidling shared_lib.dll
start BUILD_WINDOWS.bat

CD ../../

COPY src\shared_lib\shared_lib.dll . /Y

EXIT
