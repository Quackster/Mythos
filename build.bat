@echo off
taskkill -f -im Project1.exe
C:\TDM-GCC-32\bin\g++.exe -std=c++11 -U__STRICT_ANSI__  -c -DBUILD_MY_DLL shared_lib.cpp
C:\TDM-GCC-32\bin\g++.exe -L. -loleaut32 -shared -o shared_lib.dll shared_lib.o -Wl,--out-implib,libshared_lib.a,--enable-stdcall-fixup
pause