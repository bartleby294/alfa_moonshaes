#include "omega_include"
void main()
{
int nStat = GetLocalInt(oDM, "CURSE_STR");

nStat += 1;
SetLocalInt(oDM, "CURSE_STR", nStat);

string sStat = IntToString(nStat);
SetCustomToken(7001, sStat);
}
