#include "omega_include"
void main()
{
int XPint = GetXP(oMyTarget);
int Gint = GetGold(oMyTarget);
string lstring = GetPCPlayerName(oMyTarget);
string XPstring = IntToString(XPint);
string Gstring = IntToString(Gint);

SetCustomToken(6902,lstring);
SetCustomToken(6903,XPstring);
SetCustomToken(6904,Gstring);
}
