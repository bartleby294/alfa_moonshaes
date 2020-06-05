#include "omega_include"
void main()
{
int nStat = GetLocalInt(oDM, "CURSE_DEX");

nStat += 1;
SetLocalInt(oDM, "CURSE_DEX", nStat);

string sStat = IntToString(nStat);
SetCustomToken(7002, sStat);
}
