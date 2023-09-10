VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "VBScriptEngine"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private WithEvents scriptEngine As MSScriptControl.ScriptControl
Attribute scriptEngine.VB_VarHelpID = -1

Private Sub Class_Initialize()
    ' Create an instance of the ScriptControl
    Set scriptEngine = New MSScriptControl.ScriptControl
         
    scriptEngine.Language = "VBScript"
    scriptEngine.AllowUI = True
    scriptEngine.AddObject "frmMain", frmMain
    'scriptEngine.AddCode (code)
    
End Sub

Private Sub Class_Terminate()
    ' Release the ScriptControl
    Set scriptEngine = Nothing
End Sub

Public Function ExecuteScript(ByVal script As String) As Variant
    'On Error Resume Next
    ' Execute the VBScript code
    ExecuteScript = scriptEngine.Eval(script)
    If Err.Number <> 0 Then
        ExecuteScript = "Error: " & Err.Description
    End If
    'On Error GoTo 0
End Function

