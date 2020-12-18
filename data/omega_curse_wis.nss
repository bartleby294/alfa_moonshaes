#include "omega_include"
void main()
{
int nStat = GetLocalInt(oDM, "CURSE_WIS");

nStat += 1;
SetLocalInt(oDM, "CURSE_WIS", nStat);
string sStat = IntToString(nStat);
SetCustomToken(7005, sStat);
}
