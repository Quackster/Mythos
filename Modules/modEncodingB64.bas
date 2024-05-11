Attribute VB_Name = "modEncodingB64"
Option Explicit

Private Declare Sub DllEncodeB64 Lib "shared_lib.dll" _
    Alias "encodeB64@12" ( _
    ByVal inputPtr As Long, _
    ByVal inputLength As Long, _
    ByVal i As Long _
)

Private Declare Function DllDecodeB64 Lib "shared_lib.dll" _
    Alias "decodeB64@4" ( _
    ByVal bzData As String _
) As Long


Public Function EncodeB64(ByVal i As Long) As String
    Dim encodedVal As String
    encodedVal = Space(2)
    
    Call DllEncodeB64(StrPtr(encodedVal), i, 2)
    EncodeB64 = Mid(encodedVal, 1, 2)
End Function


Public Function DecodeB64(ByVal encodedValue As String) As Long
    DecodeB64 = DllDecodeB64(encodedValue)
End Function

