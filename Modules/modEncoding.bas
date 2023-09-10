Attribute VB_Name = "modEncoding"
Option Explicit

Private Declare Sub EncodeInt32 Lib "shared_lib.dll" _
    Alias "EncodeInt32@16" ( _
    ByVal inputPtr As Long, _
    ByVal inputLength As Long, _
    ByRef outputLength As Integer, _
    ByVal i As Long _
)

Public Function EncodeVL64(ByVal i As Long) As String
    Dim encodedVal As String
    Dim outputLength As Integer
    
    encodedVal = Space(6)
    outputLength = 0
    
    Call EncodeInt32(StrPtr(encodedVal), LenB(encodedVal), outputLength, i)
    
    If (outputLength = 0) Then
        EncodeVL64 = vbNullString
    Else
        EncodeVL64 = Mid(encodedVal, 1, outputLength)
    End If
End Function








