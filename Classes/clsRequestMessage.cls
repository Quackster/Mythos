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

Public Property Get Buffer() As String
    Buffer = m_Buffer
End Property

Public Property Let Buffer(ByVal Value As String)
    m_Buffer = Value
End Property

Public Property Get Header() As String
    Header = m_Header
End Property

Public Property Get HeaderId() As Long
    HeaderId = DecodeB64(m_Header)
End Property

Public Property Let Header(ByVal Value As String)
    m_Header = Value
End Property


