VERSION 5.00
Object = "{00028C01-0000-0000-0000-000000000046}#1.0#0"; "DBGRID32.OCX"
Begin VB.Form frmMain 
   Caption         =   "Form1"
   ClientHeight    =   8415
   ClientLeft      =   60
   ClientTop       =   405
   ClientWidth     =   12390
   LinkTopic       =   "Form1"
   ScaleHeight     =   8415
   ScaleWidth      =   12390
   StartUpPosition =   3  'Windows Default
   Begin MSDBGrid.DBGrid DBGrid1 
      Height          =   8055
      Left            =   120
      OleObjectBlob   =   "frmMain.frx":0000
      TabIndex        =   0
      Top             =   120
      Width           =   12135
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim Conn As ADODB.Connection
Dim Rs As ADODB.Recordset

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

    ' Initialize the connection and recordset objects
    Set Conn = New ADODB.Connection
    Set Rs = New ADODB.Recordset
    
    ' Replace "YourDSN" with the name of your PostgreSQL DSN
    Conn.ConnectionString = "Provider=MSDASQL;Driver=PostgreSQL ODBC Driver(ANSI);SERVER=localhost;PORT=5432;UID=postgres;Pwd=123;DATABASE=mythos;ByteaAsLongVarBinary=1;BoolsAsChar=0;"
    
    Conn.Open
    
    ' Set the DataGrid's DataSource to the recordset
    Set DBGrid1.DataSource = Rs

MsgBox (EncodeVL64(0))
MsgBox (EncodeVL64(1))
MsgBox (EncodeVL64(2))
MsgBox (EncodeVL64(3))
MsgBox (EncodeVL64(10))
MsgBox (EncodeVL64(100))
MsgBox (EncodeVL64(1337))

End Sub

