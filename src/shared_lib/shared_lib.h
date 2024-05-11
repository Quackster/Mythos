#include <string>
#include <windows.h>

#pragma comment(lib, "OleAut32")

#ifdef BUILD_MY_DLL
  #define SHARED_LIB __stdcall __declspec(dllexport)
#else
  #define SHARED_LIB __stdcall __declspec(dllimport)
#endif

#ifdef __cplusplus

extern "C"
{
#endif

void SHARED_LIB encodeVL64(/*LPSTR*/char*, long, int*, int);
int SHARED_LIB decodeVL64(/*LPSTR*/char*, int*);
int SHARED_LIB decodeB64(/*LPSTR*/char*);
void SHARED_LIB encodeB64(/*LPSTR*/char*, int, int);

#ifdef __cplusplus
}
#endif