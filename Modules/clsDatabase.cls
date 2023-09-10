VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsDatabase"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public Connection As ADODB.Connection
Public ResultSet As ADODB.Recordset

Public Sub Connect()
    Set Conn = New ADODB.Connection
    Set Rs = New ADODB.Recordset
    
    Conn.ConnectionString = _
    "Provider=MSDASQL;Driver={PostgreSQL Unicode}" & _
    ";SERVER=localhost;PORT=5432;UID=postgres;" & _
    "Pwd=123;DATABASE=mythos;" & _
    "ByteaAsLongVarBinary=1;BoolsAsChar=0;"
    
    Conn.Open
End Sub

Public Sub ExecuteScalar(ByVal Query As String)
    Rs.Open Query, Conn, adOpenStatic, adLockOptimistic
    
    If Not Rs.EOF Then
        Rs.MoveFirst
    End If
    
End Sub
