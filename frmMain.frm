VERSION 5.00
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
   Begin MSWinsockLib.Winsock MainServer 
      Index           =   0
      Left            =   120
      Top             =   120
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
      LocalPort       =   12321
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Const MAX_SOCKETS As Integer = 100
Private Const SERVER_PORT As Integer = 12321

Private sockets(MAX_SOCKETS) As Integer

Private Sub Form_Load()
    MainServer(0).LocalPort = SERVER_PORT
    MainServer(0).Listen
    
    'Dim totalBytes As Long
    'MsgBox (EncodeVL64(1337))
    'MsgBox (DecodeVL64("YNE", totalBytes))
    'MsgBox (CStr(Len(EncodeB64(139))))
    'MsgBox (DecodeB64("BK"))
    
End Sub

Private Sub MainServer_ConnectionRequest(Index As Integer, ByVal requestID As Long)
    Dim freeSocketID As Integer
    freeSocketID = FindFreeSocket()
    
    If freeSocketID >= 0 Then
        sockets(freeSocketID) = True
        Load MainServer(freeSocketID)
        
        MainServer(freeSocketID).Accept requestID
        MainServer(freeSocketID).SendData "@@" & Chr(1)
    Else
        ' No free socket available, handle error or reject request
        MainServer(requestID).Close
        
    End If
End Sub

Private Sub MainServer_DataArrival(Index As Integer, ByVal bytesTotal As Long)
    Dim incomingMessage As String
    Dim incomingMessageLength As String
    
    Dim packetLength As Integer
    Dim packetData As String
    
   ' Do
        ' Check if there are at least 2 bytes available to read the packet length
        If MainServer(Index).BytesReceived > 2 Then 'Exit Do
        
        ' Read the packet
        MainServer(Index).GetData incomingMessage
        
        ' Check if there are enough bytes available to read the full packet
        'If MainServer(Index).BytesReceived < packetLength Then Exit Do
        
        ' Read the packet data
        'MainServer(Index).Get packetData, packetLength
        
        ' Process the packet data (e.g., display in a MsgBox)
        MsgBox packetData
        End If
        
    'Loop While MainServer(Index).InBufferCount > 0
End Sub



Private Function FindFreeSocket() As Integer
    Dim i As Integer
    For i = 1 To MAX_SOCKETS
        If Not sockets(i) Then
            FindFreeSocket = i
            Exit Function
        End If
    Next i
    FindFreeSocket = 0 ' No free socket found
End Function

