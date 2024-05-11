VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsResponseMessage"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private m_Buffer As String
Private m_HeaderId As Long

Public Property Get Buffer() As String
    Buffer = m_Buffer
End Property

Public Property Get HeaderId() As Long
    HeaderId = m_HeaderId
End Property

Public Property Get Header() As String
    Header = EncodeB64(m_HeaderId)
End Property

Public Property Let HeaderId(ByVal value As Long)
    m_HeaderId = value
End Property

Private Sub Class_Initialize()
    m_Buffer = ""
End Sub

Public Sub WriteString(ByVal value As Variant)
    m_Buffer = m_Buffer + Clean(CStr(value)) + Chr(2)
End Sub

Public Sub WriteInt(ByVal value As Long)
    m_Buffer = m_Buffer + EncodeVL64(value)
End Sub

Public Sub WriteBool(ByVal value As Boolean)
    If (value = True) Then
        m_Buffer = m_Buffer + EncodeVL64(0)
    Else
        m_Buffer = m_Buffer + EncodeVL64(1)
    End If
End Sub

Public Sub WriteValue(ByVal value As Variant)
    m_Buffer = m_Buffer + Clean(CStr(value))
End Sub

' Stop packet injection!
Public Function Clean(ByVal value As String) As String
    Dim cleanedValue As String
    cleanedValue = value
    cleanedValue = Replace(cleanedValue, Chr(1), "")
    cleanedValue = Replace(cleanedValue, Chr(2), "")
    cleanedValue = Replace(cleanedValue, Chr(9), "")
    cleanedValue = Replace(cleanedValue, Chr(13), "")
    Clean = cleanedValue
End Function

' Builds the final packet for sending off
Public Function Build() As String
    Dim outputMessage As String
    outputMessage = Me.Header
    outputMessage = outputMessage + Me.Buffer
    outputMessage = outputMessage + Chr(1)
    
    Build = outputMessage
End Function

