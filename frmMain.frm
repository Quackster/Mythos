VERSION 5.00
Object = "{CDE57A40-8B86-11D0-B3C6-00A0C90AEA82}#1.0#0"; "MSDATGRD.OCX"
Object = "{248DD890-BB45-11CF-9ABC-0080C7E7B78D}#1.0#0"; "MSWINSCK.OCX"
Begin VB.Form frmMain 
   Caption         =   "Form1"
   ClientHeight    =   4620
   ClientLeft      =   60
   ClientTop       =   405
   ClientWidth     =   5055
   LinkTopic       =   "Form1"
   ScaleHeight     =   4620
   ScaleWidth      =   5055
   StartUpPosition =   3  'Windows Default
   Begin MSWinsockLib.Winsock sckGame 
      Index           =   0
      Left            =   240
      Top             =   3120
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
   Begin MSDataGridLib.DataGrid DataGrid1 
      Height          =   2535
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   4815
      _ExtentX        =   8493
      _ExtentY        =   4471
      _Version        =   393216
      AllowUpdate     =   -1  'True
      Appearance      =   0
      Enabled         =   -1  'True
      HeadLines       =   1
      RowHeight       =   15
      AllowAddNew     =   -1  'True
      AllowDelete     =   -1  'True
      BeginProperty HeadFont {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ColumnCount     =   2
      BeginProperty Column00 
         DataField       =   ""
         Caption         =   ""
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   3081
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column01 
         DataField       =   ""
         Caption         =   ""
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   3081
            SubFormatType   =   0
         EndProperty
      EndProperty
      SplitCount      =   1
      BeginProperty Split0 
         BeginProperty Column00 
         EndProperty
         BeginProperty Column01 
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Form_Load()
    sckGame(0).LocalPort = 1232 'What port the server will listen on
    sckGame(0).Listen 'Tells the server to listen on
    
    
    'Dim Connection As clsDatabase
    'Set Connection = New clsDatabase
    
    'Call Connection.Connect
    'Call Connection.ExecuteScalar("SELECT * FROM users")
    
    'Set DataGrid1.DataSource = Connection.ResultSet
    
    'MsgBox (EncodeVL64(1337))
    
    Dim scriptEngine As VBScriptEngine
    Set scriptEngine = New VBScriptEngine

'Dim code As String
'        code = "Private Function TEST()" & vbCrLf & _
'"    Call frmMain.TEST()" & vbCrLf & _
'"    TEST = 1" & vbCrLf & _
'"End Function"

    scriptEngine.ExecuteScript ("frmMain.TEST")
    'MsgBox (scriptEngine.ExecuteScript("TEST"))

End Sub

Sub TEST()
MsgBox ("lol")
End Sub

Sub CallMyFunctionProgrammatically()
    Dim result As String
    Dim parameter As String
    
    ' Set the parameter value
    parameter = "John"
    
    ' Call MyFunction using CallByName
    result = CallByName(Me, "MyFunction", VbMethod, parameter)
    
    ' Display the result
    MsgBox result
End Sub

Public Function MyFunction(parameter As String) As String
    ' Your code here
    MyFunction = "Hello, " & parameter
End Function

Private Sub sckGame_ConnectionRequest(Index As Integer, ByVal requestID As Long)
     Load sock(requestID)
     sock(requestID).Accept requestID
     sock(requestID).SendData "BKHello testing" & Chr(1)
End Sub

