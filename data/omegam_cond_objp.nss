#include "omega_include"
int StartingConditional()
{
 if (oMyTarget == OBJECT_INVALID)
 return FALSE;
 if (GetIsPC(oMyTarget))
  return FALSE;

    return TRUE;
}
