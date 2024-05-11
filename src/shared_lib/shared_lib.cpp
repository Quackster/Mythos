#include "shared_lib.h"

void copystr(/*LPSTR*/char *destination, long destinationLength, std::string output) {
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

int decodeVL64(char *bzData, int* totalBytes) {
    int is_negative = (bzData[0] & 4) == 4;
    *totalBytes = (bzData[0] >> 3) & 7;
    
    int result = bzData[0] & 3;

    int shift_amount = 2;
    for (int i = 1; i < *totalBytes; i++) {
        result |= (bzData[i] & 0x3f) << shift_amount;
        shift_amount += 6;
    }

    if (is_negative) {
        result = -result;
    }

    return result;
}

int decodeB64(char *bzData) {
    int result = 0;

    for (int i = 0; i < strlen(bzData); i++) {
        result += ((bzData[i] - 0x40) << 6 * (strlen(bzData) - 1 - i));
    }

    return result;
}

void encodeB64(char *destination, int value, int length) {
    char *bzData = (char*) malloc(length + 1 *sizeof(char));
    int slot = 0;
    int sub_value;

    for (int i = 0; i < length; i++) {
        sub_value = (value >> 6 * (length - 1 - i)) & 0x3f;
        bzData[slot++] = (char) (sub_value + 0x40);
    }

    // Copy to allocated VB6 string
    std::string allocated(bzData);
    copystr(destination, length, allocated);
    
    free(bzData);
}