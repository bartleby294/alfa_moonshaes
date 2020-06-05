#include "omega_include"
void main()
{
int nAdd;
string sVarable;
sVarable = GetLocalString(oDM, "ADVANCED_CONSTRUCT");
//SendMessageToAllDMs(sVarable);
nAdd = -100;
int nDNcheck = GetLocalInt(oDM, "FOG_COLOR_SET");

FogAdvancedMath(nAdd, sVarable);
}

