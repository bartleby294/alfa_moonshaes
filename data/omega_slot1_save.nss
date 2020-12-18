#include "omega_include"
void main()
{
string sVarName = GetLocalString(oDM,"ADVANCED_CONSTRUCT2");

string sVarable = GetCampaignString("Omega_Wand",sVarName, oDM);

SaveLoadDecoder(sVarable);
}
