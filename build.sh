#i686-w64-mingw32-g++ 

#i686-w64-mingw32-g++ -c UnitFunctions.cpp
#i686-w64-mingw32-g++ -c UnitEntryPoint.cpp
#i686-w64-mingw32-g++ -o Functions.dll UnitEntryPoint.o UnitFunctions.o

g++ -std=c++11 -U__STRICT_ANSI__  -c -DBUILD_MY_DLL shared_lib.cpp  
g++ -L. -loleaut32 -shared -o shared_lib.dll shared_lib.o -Wl,--out-implib,libshared_lib.a,--enable-stdcall-fixup