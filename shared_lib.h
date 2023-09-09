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

void SHARED_LIB EncodeInt32(LPSTR, long, int*, int);

#ifdef __cplusplus
}
#endif