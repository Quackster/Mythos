VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   3135
   ClientLeft      =   60
   ClientTop       =   405
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   ScaleHeight     =   3135
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Declare Sub EncodeInt32 Lib "shared_lib.dll" _
    Alias "EncodeInt32@16" ( _
    ByVal inputPtr As Long, _
    ByVal inputLength As Long, _
    ByRef outputLength As Integer, _
    ByVal i As Long _
)


Private Function EncodeVL64(ByVal i As Double) As String
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


Private Sub Form_Load()

Dim Test1 As String
Test1 = EncodeVL64(323213)

MsgBox Test1 & "=1337"

Dim Test2 As String
Test2 = EncodeVL64(12)

MsgBox Test2 & "=12"

End Sub

