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
Private Declare Function GetAnswerOfLife Lib "shared_lib.dll" () As Integer

Private Declare Sub copystr Lib "shared_lib.dll" ( _
    ByVal theString As Long, _
    ByVal Bytes As Long _
)



Private Sub Form_Load()

    Dim sTest As String
    sTest = "HELLO MY NAME IS ALEX WELCOME HI"
    
    copystr StrPtr(sTest), LenB(sTest)
    MsgBox sTest
    
    

End Sub
