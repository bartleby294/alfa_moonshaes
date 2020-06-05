#include "omega_include"
void main()
{
int nStat = GetLocalInt(oDM, "CURSE_INT");

nStat += 1;
SetLocalInt(oDM, "CURSE_INT", nStat);

string sStat = IntToString(nStat);
SetCustomToken(7004, sStat);
}
