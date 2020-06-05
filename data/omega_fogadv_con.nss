#include "omega_include"
int StartingConditional()
{
string sConst = GetLocalString(oDM, "ADVANCED_CONSTRUCT");
int iCheck = GetStringLength(sConst);

if (!(iCheck != 6)) return FALSE;

return TRUE;
}

