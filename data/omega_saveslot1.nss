 #include "omega_include"
void main()
{
object oArea = GetArea(GetPCSpeaker());
int nColor = GetFogColor(FOG_TYPE_SUN, oArea);
int nColor2 = GetFogColor(FOG_TYPE_MOON, oArea);
string sSlot = (IntToString(nColor) + "DN" + IntToString(nColor2));
string sVarName = GetLocalString(oDM,"ADVANCED_CONSTRUCT2");
SetCampaignString("Omega_Wand", sVarName , sSlot, oDM);

 if (sVarName == "F_S1")
 {
SetCustomToken(6987, "Full");
 }
 else if (sVarName == "F_S2")
 {
SetCustomToken(6988, "Full");

 }
 else if (sVarName == "F_S3")
 {
 SetCustomToken(6989, "Full");
 }
}
