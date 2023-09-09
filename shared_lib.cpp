#include "shared_lib.h"

const int GetAnswerOfLife()
{
  return 42;
}

void copystr(LPSTR input, long inputLength, std::string output) {
    int j = 0;
    for (int i = 0; i <= inputLength; i += 2) {
        char ch = *(input + i);
        
        if (ch == '\0' || output[j] == '\0')
          break;

        *(input + i) = output[j];
        
        j++;
        
        if (j >= output.length())
          break;
    }
}


void EncodeInt32(LPSTR inputPtr, long inputLength, int i) {
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
    
    MessageBox(NULL, bzData, "Message Box Example", MB_ICONINFORMATION | MB_OK);
    
  
    // Copy to allocated VB6 string
    std::string allocated(bzData);
    copystr(inputPtr, inputLength, allocated);
    
    // Free memory
    free(wf);
    free(bzData);
}
