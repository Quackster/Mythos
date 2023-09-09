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
std::string ConvertWCSToMBS(const wchar_t* pstr, long wslen)
{
    int len = ::WideCharToMultiByte(CP_ACP, 0, pstr, wslen, NULL, 0, NULL, NULL);

    std::string dblstr(len, '\0');
    len = ::WideCharToMultiByte(CP_ACP, 0 /* no flags */,
                                pstr, wslen /* not necessary NULL-terminated */,
                                &dblstr[0], len,
                                NULL, NULL /* no default char */);

    return dblstr;
}

std::string ConvertBSTRToMBS(BSTR bstr)
{
    int wslen = ::SysStringLen(bstr);
    return ConvertWCSToMBS((wchar_t*)bstr, wslen);
}


BSTR ConvertMBSToBSTR(const std::string& str)
{
    int wslen = ::MultiByteToWideChar(CP_ACP, 0 /* no flags */,
                                      str.data(), str.length(),
                                      NULL, 0);

    BSTR wsdata = ::SysAllocStringLen(NULL, wslen);
    ::MultiByteToWideChar(CP_ACP, 0 /* no flags */,
                          str.data(), str.length(),
                          wsdata, wslen);
    return wsdata;
}

void copystr (LPSTR, long, std::string);

void SHARED_LIB EncodeInt32(LPSTR, long, int*, int);
void SHARED_LIB strtest(LPSTR);

#ifdef __cplusplus
}
#endif