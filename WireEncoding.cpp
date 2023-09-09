#include <iostream>
#include <vector>
#include <cmath>

class WireEncoding {
public:
    static const uint8_t NEGATIVE = 72; // 'H'
    static const uint8_t POSITIVE = 73; // 'I'
    static const int MAX_INTEGER_BYTE_AMOUNT = 6;

    static std::vector<uint8_t> EncodeInt32(int i) {
        std::vector<uint8_t> wf(MAX_INTEGER_BYTE_AMOUNT);
        int pos = 0;
        int numBytes = 1;
        int startPos = pos;
        int negativeMask = i >= 0 ? 0 : 4;
        i = std::abs(i);
        wf[pos++] = static_cast<uint8_t>(64 + (i & 3));
        for (i >>= 2; i != 0; i >>= WireEncoding::MAX_INTEGER_BYTE_AMOUNT) {
            numBytes++;
            wf[pos++] = static_cast<uint8_t>(64 + (i & 0x3f));
        }
        wf[startPos] = static_cast<uint8_t>(wf[startPos] | (numBytes << 3) | negativeMask);

        // Skip the null bytes in the result
        std::vector<uint8_t> bzData(numBytes);
        for (int x = 0; x < numBytes; x++) {
            bzData[x] = wf[x];
        }

        return bzData;
    }

    static int DecodeInt32(const std::vector<uint8_t>& bzData, int& totalBytes) {
        int pos = 0;
        int v = 0;
        bool negative = (bzData[pos] & 4) == 4;
        totalBytes = static_cast<int>(bzData[pos] >> 3) & 7;
        v = bzData[pos] & 3;
        pos++;
        int shiftAmount = 2;
        for (int b = 1; b < totalBytes; b++) {
            v |= (bzData[pos] & 0x3f) << shiftAmount;
            shiftAmount = 2 + 6 * b;
            pos++;
        }

        if (negative == true) {
            v *= -1;
        }

        return v;
    }
};