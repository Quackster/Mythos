## Mythos

Experimental DLL calling for VL64/B64 encoding for the Habbo Hotel protocol from within Visual Basic 6.0

## Screenshot

![](https://i.imgur.com/z7IIJKs.png)

## Code Snippets

```vb
Private Sub MainServer_DataArrival(Index As Integer, ByVal bytesTotal As Long)
    Dim incomingMessage As String
    Dim incomingMessageLength As Long
    
    Dim pointer As Long
    pointer = 1
    
    Dim packetLength As Long
    Dim packetHeader As String
    Dim packetData As String
    
    Do
        ' Check if there are at least 5 bytes available to read the packet length and the first character of data
        If MainServer(Index).BytesReceived < 5 Then Exit Do
        
        ' Read the buffer
        MainServer(Index).GetData incomingMessage
        incomingMessageLength = MainServer(Index).BytesReceived
        
        ' Harvest packet length
        packetLength = DecodeB64(Mid(incomingMessage, pointer, 3))
        pointer = pointer + 3
                
        If packetLength <= 0 Or packetLength > 1000 Then
            ' Invalid packet length
            Exit Sub
        End If
        
        ' Check if there are enough bytes available to read the entire packet
        If bytesTotal < packetLength Then Exit Do
        
        ' Harvest packet header
        packetHeader = Mid(incomingMessage, pointer, 2)
        pointer = pointer + 2
        
        ' Harvest packet data
        packetData = Mid(incomingMessage, pointer, packetLength - 2)
        pointer = pointer + packetLength - 2
        
        ' Create request class
        Dim requestMessage As New clsRequestMessage
        requestMessage.Buffer = packetData
        requestMessage.Header = packetHeader
        
        ' Create data handler class
        Dim dataHandler As New clsDataHandler
        dataHandler.Index = Index
        Set dataHandler.Buffer = requestMessage
        
        Call dataHandler.Parse
    Loop While Len(Mid(incomingMessage, pointer)) > 0
End Sub
```

## Requirements

- Visual Basic 6.0 IDE
- Your project is compiling under 'native' and **not** P-code, the DLL calls will not work otherwise
- [tdm-gcc 32-bit](https://jmeubank.github.io/tdm-gcc/) for Windows; or
- Packages ``g++ gcc oleaut32`` for Linux/Unix systems 

### How it works

*C++ Code*

Copying strings back to the memory allocated Visual Basic 6.0 string, this is probably very evil, but it works!

```c
void copystr(LPSTR destination, long destinationLength, std::string output) {
    int j = 0;
    for (int i = 0; i <= destinationLength; i += 2) {
        char ch = *(destination + i);
        
        if (ch == '\0' || output[j] == '\0')
          break;

        *(destination + i) = output[j];
        
        j++;
        
        if (j >= output.length())
          break;
    }
}
```

The actual 'EncodeInt32' function

```c
void encodeVL64(/*LPSTR*/char *destination, long destinationLength, int *outputLength, int i) {
    int numBytes = 0;
    char* wf = (char*)malloc(6);
    int pos = 0;
    numBytes = 1;
    int startPos = pos;
    int negativeMask = i >= 0 ? 0 : 4;
    i = abs(i);
    wf[pos++] = (char)(64 + (i & 3));
    for (i >>= 2; i != 0; i >>= 6) {
        numBytes++;
        wf[pos++] = (char)(64 + (i & 0x3F));
    }
    wf[startPos] = (char)(wf[startPos] | (numBytes << 3) | negativeMask);

    // Skip the null bytes in the result
    char* bzData = (char*)malloc(numBytes + 1);
    for (int x = 0; x < numBytes; x++) {
        bzData[x] = wf[x];
    }

    bzData[numBytes] = '\0';
    
    // Copy to allocated VB6 string
    std::string allocated(bzData);
    copystr(destination, destinationLength, allocated);
    
    // Free memory
    free(wf);
    free(bzData);
    
    *outputLength = numBytes;
}
```

*Visual Basic 6.0 code*

Run ``dumpbin.exe /exports shared_lib.dll`` on our shared DLL file.

You will see:

```
Dump of file shared_lib.dll

File Type: DLL

  Section contains the following exports for shared_lib.dll

           0 characteristics
    663EC498 time date stamp Sat May 11 11:06:32 2024
        0.00 version
           1 ordinal base
           4 number of functions
           4 number of names

    ordinal hint RVA      name

          1    0 000015B9 decodeB64@4
          2    1 00001526 decodeVL64@8
          3    2 00001627 encodeB64@12
          4    3 00001278 encodeVL64@16
```

The 'EncodeInt32@16' is the exported function name we'll use.

```vb
Option Explicit

Private Declare Sub DllEncodeVL64 Lib "shared_lib.dll" _
    Alias "encodeVL64@16" ( _
    ByVal inputPtr As Long, _
    ByVal inputLength As Long, _
    ByRef outputLength As Integer, _
    ByVal i As Long _
)

Private Declare Function DllDecodeVL64 Lib "shared_lib.dll" _
    Alias "decodeVL64@8" ( _
    ByVal bzData As String, _
    ByRef totalBytes As Long _
) As Long


Public Function EncodeVL64(ByVal i As Long) As String
    Dim encodedVal As String
    Dim outputLength As Integer
    
    encodedVal = Space(6)
    outputLength = 0
    
    Call DllEncodeVL64(StrPtr(encodedVal), LenB(encodedVal), outputLength, i)
    
    If (outputLength = 0) Then
        EncodeVL64 = vbNullString
    Else
        EncodeVL64 = Mid(encodedVal, 1, outputLength)
    End If
End Function

Public Function DecodeVL64(ByVal encodedValue As String, ByRef totalBytes As Long) As Long
    DecodeVL64 = DllDecodeVL64(encodedValue, totalBytes)
End Function
```

## Bulding the DLL

*Windows*

```
C:\TDM-GCC-32\bin\g++.exe -std=c++11 -U__STRICT_ANSI__  -c -DBUILD_MY_DLL shared_lib.cpp
C:\TDM-GCC-32\bin\g++.exe -L. -loleaut32 -shared -o shared_lib.dll shared_lib.o -Wl,--out-implib,libshared_lib.a,--enable-stdcall-fixup
```

*Linux/Unix*

```
g++ -std=c++11 -U__STRICT_ANSI__  -c -DBUILD_MY_DLL shared_lib.cpp  
g++ -L. -loleaut32 -shared -o shared_lib.dll shared_lib.o -Wl,--out-implib,libshared_lib.a,--enable-stdcall-fixup
```
