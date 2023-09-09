#ifndef SHARED_LIB_H
#define SHARED_LIB_H

#include <string>
#include <windows.h>

#pragma comment(lib, "OleAut32")

#define SHARED_LIB __stdcall __declspec(dllexport)

using namespace std;

#ifdef __cplusplus

extern "C"
{
#endif

__declspec (dllexport) const int GetAnswerOfLife();
__declspec (dllexport) void copystr (LPSTR, int);

#ifdef __cplusplus
}
#endif

#endif