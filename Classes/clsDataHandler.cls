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
    Log ("[INCOMING] -> " & Me.Buffer.Header & " / " & Me.Buffer.HeaderId & " " & Me.Buffer.Buffer)
        
    Dim methodName As String
    methodName = "Message_" & CStr(Me.Buffer.HeaderId)
    
    If Not MethodExists(methodName) Then
        Exit Function
    End If
End Function

Private Function MethodExists(methodName As String) As Boolean
    On Error Resume Next
    MethodExists = Not IsNull(CallByName(Me, methodName, VbMethod))
    On Error GoTo 0
End Function

Public Function Message_206()
    Send Index, "DUH"
End Function

Public Function Message_202()
    Send Index, "DAQBQAdd-MM-yyyy{2}JHKHPAHRAHIISAIPB" & Chr(2) & "QBI"
    Send Index, "@H[100,105,110,115,120,125,130,135,140,145,150,155,160,165,170,175,176,177,178,180,185,190,195,200,205,206,207,210,215,220,225,230,235,240,245,250,255,260,265,266,267,270,275,280,281,285,290,295,300,305,500,505,510,515,520,525,530,535,540,545,550,555,565,570,575,580,585,590,595,596,600,605,610,615,620,625,626,627,630,635,640,645,650,655,660,665,667,669,670,675,680,685,690,695,696,700,705,710,715,720,725,730,735,740]"
End Function

Public Function Message_4()
    Send Index, "@C"
End Function

Public Function Message_7()
    Send Index, "@E1" & Chr(2) & "alex" & Chr(2) & "5900161001720017300168501" & Chr(2) & "F" & Chr(2) & "i love oldschool :3" & Chr(2) & "H" & Chr(2) & "HH"
End Function





