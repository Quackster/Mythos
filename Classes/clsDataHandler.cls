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

Public Property Let Index(ByVal value As Integer)
    m_Index = value
End Property

Public Property Get Buffer() As clsRequestMessage
    Set Buffer = m_Buffer
End Property

Public Property Set Buffer(ByRef value As clsRequestMessage)
    Set m_Buffer = value
End Property

Public Function Parse()
    Log ("[INCOMING] -> " & Me.Buffer.HeaderId & " / " & Me.Buffer.Header & " " & Clean(Me.Buffer.Buffer))
        
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
    'Dim responseMessage As New clsResponseMessage
    'responseMessage.HeaderId = 277
    'responseMessage.WriteInt (0)
    'Send Index, responseMessage
    
    Dim responseMessage As New clsResponseMessage
    responseMessage.HeaderId = 257
    responseMessage.WriteInt (9)
    responseMessage.WriteInt (4)
    responseMessage.WriteInt (0)
    responseMessage.WriteInt (7)
    responseMessage.WriteInt (1)
    responseMessage.WriteInt (6)
    responseMessage.WriteInt (0)
    responseMessage.WriteInt (8)
    responseMessage.WriteString ("")
    responseMessage.WriteInt (2)
    responseMessage.WriteInt (0)
    responseMessage.WriteInt (9)
    responseMessage.WriteInt (1)
    responseMessage.WriteInt (1)
    responseMessage.WriteInt (1)
    responseMessage.WriteInt (3)
    responseMessage.WriteInt (0)
    responseMessage.WriteInt (5)
    responseMessage.WriteString ("dd-MM-yyyy")
    Send Index, responseMessage
    
End Function

Public Function UNUSED_Message_202()
    Dim responseMessage As New clsResponseMessage
    responseMessage.HeaderId = 257
    responseMessage.WriteInt (9)
    responseMessage.WriteInt (4)
    responseMessage.WriteInt (0)
    responseMessage.WriteInt (7)
    responseMessage.WriteInt (1)
    responseMessage.WriteInt (6)
    responseMessage.WriteInt (0)
    responseMessage.WriteInt (8)
    responseMessage.WriteString ("")
    responseMessage.WriteInt (2)
    responseMessage.WriteInt (0)
    responseMessage.WriteInt (9)
    responseMessage.WriteInt (1)
    responseMessage.WriteInt (1)
    responseMessage.WriteInt (1)
    responseMessage.WriteInt (3)
    responseMessage.WriteInt (0)
    responseMessage.WriteInt (5)
    responseMessage.WriteString ("dd-MM-yyyy")
    Send Index, responseMessage
    
    Set responseMessage = New clsResponseMessage
    responseMessage.HeaderId = 8
    responseMessage.WriteValue ("[100,105,110,115,120,125,130,135,140,145,150,155,160,165,170,175,176,177,178,180,185,190,195,200,205,206,207,210,215,220,225,230,235,240,245,250,255,260,265,266,267,270,275,280,281,285,290,295,300,305,500,505,510,515,520,525,530,535,540,545,550,555,565,570,575,580,585,590,595,596,600,605,610,615,620,625,626,627,630,635,640,645,650,655,660,665,667,669,670,675,680,685,690,695,696,700,705,710,715,720,725,730,735,740]")
    Send Index, responseMessage
End Function

Public Function Message_415()
    Dim ssoTicket As String
    ssoTicket = Me.Buffer.PopString()
    
    Dim responseMessage As New clsResponseMessage
    responseMessage.HeaderId = 3
    Send Index, responseMessage
    
    Set responseMessage = New clsResponseMessage
    responseMessage.HeaderId = 139
    responseMessage.WriteValue ("Hello!")
    Send Index, responseMessage
End Function

Public Function Message_7()
    Dim responseMessage As New clsResponseMessage
    responseMessage.HeaderId = 5
    responseMessage.WriteString (1)
    responseMessage.WriteString ("Alex")
    responseMessage.WriteString ("5900161001720017300168501")
    responseMessage.WriteString ("F")
    responseMessage.WriteString ("i love oldschool :3")
    responseMessage.WriteInt (0) ' Tickets
    responseMessage.WriteString ("") ' Pool figure
    responseMessage.WriteInt (0) ' Film
    responseMessage.WriteBool (False) ' Receive news
    Send Index, responseMessage
End Function

Public Function Message_12()
    Dim responseMessage As New clsResponseMessage
    responseMessage.HeaderId = 12
    Send Index, responseMessage
End Function

Public Function Message_150()
    Dim hideFull As Boolean
    Dim categoryId As Long
    
    hideFull = Me.Buffer.PopBool()
    categoryId = Me.Buffer.PopInt()
    
    Dim responseMessage As New clsResponseMessage
    responseMessage.HeaderId = 139
    responseMessage.WriteValue ("hideFull: " & CStr(hideFull) & vbNewLine)
    responseMessage.WriteValue ("categoryId: " & CStr(categoryId))
    Send Index, responseMessage
End Function
