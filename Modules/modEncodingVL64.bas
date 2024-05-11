Attribute VB_Name = "modEncodingVL64"
Option Explicit

Private Declare Sub DllEncodeVL64 Lib "shared_lib.dll" _
    Alias "encodeVL64@16" ( _
    ByVal inputPtr As Long, _
    ByVal inputLength As Long, _
    ByRef outputLength As Integer, _
    ByVal i As Long _
)

Private Declare Function DllDecodeVL64 Lib "shared_lib.dll" _
    Alias "decodeVL64@8" ( _
    ByVal bzData As String, _
    ByRef totalBytes As Long _
) As Long


Public Function EncodeVL64(ByVal i As Long) As String
    Dim encodedVal As String
    Dim outputLength As Integer
    
    encodedVal = Space(6)
    outputLength = 0
    
    Call DllEncodeVL64(StrPtr(encodedVal), LenB(encodedVal), outputLength, i)
    
    If (outputLength = 0) Then
        EncodeVL64 = vbNullString
    Else
        EncodeVL64 = Mid(encodedVal, 1, outputLength)
    End If
End Function

Public Function DecodeVL64(ByVal encodedValue As String, ByRef totalBytes As Long) As Long
    DecodeVL64 = DllDecodeVL64(encodedValue, totalBytes)
End Function



