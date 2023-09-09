#include "shared_lib.h"

const int GetAnswerOfLife()
{
  return 42;
}

void copystr(LPSTR input, int length) {
    for (int i = 0; i <= length; i += 2) {
      char ch = *(input + i);
      
      if (ch == '\0')
        break;
      
      if (ch == 'A')
        continue;
      
      *(input + i) = 'L';
    }
}
