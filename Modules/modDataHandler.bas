Attribute VB_Name = "modDataHandler"
Public Sub Log(sText As String)
On Error Resume Next
    With frmMain
        .txtMessages.text = .txtMessages.text & sText & vbNewLine
        .txtMessages.SelStart = Len(.txtMessages) - 2
    End With
End Sub

Public Function Clean(text As String) As String
    Dim cleanedText As String
    cleanedText = text
    cleanedText = Replace(cleanedText, Chr(1), "{1}")
    cleanedText = Replace(cleanedText, Chr(2), "{2}")
    cleanedText = Replace(cleanedText, Chr(9), "{9}")
    cleanedText = Replace(cleanedText, Chr(12), "{12}")
    cleanedText = Replace(cleanedText, Chr(13), "{13}")
    Clean = cleanedText
End Function

Public Function Send(Index As Integer, data As clsResponseMessage)
    Log "[OUTGOING] -> " & Clean(data.Build)
    With frmMain
        If frmMain.MainServer(Index).State = 7 Then
            frmMain.MainServer(Index).SendData data.Build
        End If
    End With
End Function


