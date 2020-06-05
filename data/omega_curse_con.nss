#include "omega_include"
void main()
{
int nStat = GetLocalInt(oDM, "CURSE_CON");

nStat += 1;
SetLocalInt(oDM, "CURSE_CON", nStat);

string sStat = IntToString(nStat);
SetCustomToken(7003, sStat);
}
