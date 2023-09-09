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

Private Declare Sub EncodeInt32 Lib "shared_lib.dll" ( _
    ByVal inputPtr As Long, _
    ByVal inputLength As Long, _
    ByVal i As Integer _
)

Private Function EncodeVL64() As String
    Dim encodedVal As String
        Dim i As Integer
    Dim inputPtr As Long
    Dim inputLength As Long
    
    i = 1337
    encodedVal = Space(6)
    
    inputPtr = StrPtr(encodedVal)
    inputLength = LenB(encodedVal)
        
    Call EncodeInt32(inputPtr, inputLength, 1)

    MsgBox (encodedVal)
    
End Function

Private Function LeaveCheck(empid As String) As String ' Notice the As String
    Dim desc As String
    Dim sSQL As String

    LeaveCheck = empid
End Function


Private Sub Form_Load()
Call EncodeVL64
Call EncodeVL64
    

End Sub

