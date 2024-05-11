VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsRequestMessage"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private m_Buffer As String
Attribute m_Buffer.VB_VarHelpID = -1
Private m_Header As String
Private m_Counter As Long

Public Property Get Buffer() As String
    Buffer = m_Buffer
End Property

Public Property Let Buffer(ByVal value As String)
    m_Buffer = value
End Property

Public Property Get Header() As String
    Header = m_Header
End Property

Public Property Get HeaderId() As Long
    HeaderId = DecodeB64(m_Header)
End Property

Public Property Let Header(ByVal value As String)
    m_Header = value
End Property

Private Sub Class_Initialize()
    m_Counter = 1
End Sub

Public Function PopString() As String
    Dim stringLength As Long
    Dim stringValue As String
    
    stringLength = DecodeB64(Mid(m_Buffer, m_Counter, 2))
    stringValue = Mid(m_Buffer, m_Counter + 2, stringLength)
    
    m_Counter = m_Counter + stringLength + 2
    
    PopString = stringValue
End Function

Public Function PopInt() As Long
    Dim totalBytes As Long
    Dim value As String
    
    value = DecodeVL64(Mid(m_Buffer, m_Counter), totalBytes)
    m_Counter = m_Counter + totalBytes
    
    PopInt = value
End Function

Public Function PopBool() As Boolean
    Dim value As Long
    
    If (Me.PopInt() = 1) Then
        PopBool = True
    Else
        PopBool = False
    End If
End Function
