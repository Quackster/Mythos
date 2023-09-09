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

Private Declare Function GetAnswerOfLife Lib "shared_lib.dll" () As Integer

'Private Declare Sub copystr Lib "shared_lib.dll" ( _
'    ByVal theString As Long, _
'    ByVal Bytes As Long _
')

Private Declare Sub EncodeInt32 Lib "shared_lib.dll" _
    Alias "EncodeInt32@12" ( _
    ByVal inputPtr As Long, _
    ByVal inputLength As Long, _
    ByVal i As Integer _
)

Private Function EncodeVL64(ByVal i As Integer) As String
    Dim encodedVal As String
    encodedVal = Space(6)
    
    Call EncodeInt32(StrPtr(encodedVal), LenB(encodedVal), i)
    EncodeVL64 = encodedVal
End Function

Private Sub Form_Load()
Call EncodeVL64(1337)
Call EncodeVL64(-1)
End Sub

