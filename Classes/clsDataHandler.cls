VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsDataHandler"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Private m_Index As Integer
Private m_Buffer As clsRequestMessage

Public Property Get Index() As Integer
    Index = m_Index
End Property

Public Property Let Index(ByVal Value As Integer)
    m_Index = Value
End Property

Public Property Get Buffer() As clsRequestMessage
    Set Buffer = m_Buffer
End Property

Public Property Set Buffer(ByRef Value As clsRequestMessage)
    Set m_Buffer = Value
End Property

Public Function Parse()
    ' MsgBox ("Message_" & CStr(Me.Buffer.HeaderId))
    Log ("[INCOMING] (UNKNOWN) -> " & Me.Buffer.Header & " / " & Me.Buffer.HeaderId & " " & Me.Buffer.Buffer)
        
    Dim methodName As String
    methodName = "Message_" & CStr(Me.Buffer.HeaderId)
    If Not MethodExists(methodName) Then
        'MsgBox "Method '" & methodName & "' not found."
        Exit Function
    End If
    ' Call CallByName(Me, methodName, VbMethod)
End Function

Private Function MethodExists(methodName As String) As Boolean
    On Error Resume Next
    MethodExists = Not IsNull(CallByName(Me, methodName, VbMethod))
    On Error GoTo 0
End Function

Public Function Message_206()
    MsgBox ("Incoming message: " & Me.Buffer.Header)
    
    Send Index, "BKtest"
    
End Function





