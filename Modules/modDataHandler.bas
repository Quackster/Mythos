Attribute VB_Name = "modDataHandler"
Public Sub Log(sText As String)
On Error Resume Next
    With frmMain
        .txtMessages.Text = .txtMessages.Text & sText & vbNewLine
        .txtMessages.SelStart = Len(.txtMessages) - 2
    End With
End Sub

Public Function Send(Index As Integer, data As clsResponseMessage)
    Log "[OUTGOING] -> " & data.Build
    With frmMain
        If frmMain.MainServer(Index).State = 7 Then
            frmMain.MainServer(Index).SendData data.Build
        End If
    End With
End Function


