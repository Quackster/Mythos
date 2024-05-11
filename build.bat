@ECHO OFF

CD src/shared_lib

ECHO Buidling shared_lib.dll
start BUILD_WINDOWS.bat

CD ../../

COPY src\shared_lib\shared_lib.dll . /Y

ECHO Building Visual Basic 6.0 project (Mythos)
ECHO ... this may require administrator privileges

START VB6 /make Mythos.vbp Mythos.exe
pause
