#include "omega_include"
void main()
{
int nStat = GetLocalInt(oDM, "CURSE_CHR");

nStat += 1;
SetLocalInt(oDM, "CURSE_CHR", nStat);

string sStat = IntToString(nStat);
SetCustomToken(7006, sStat);
}
