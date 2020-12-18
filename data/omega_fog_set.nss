#include "omega_include"
void main()
{
object oArea = GetArea(GetPCSpeaker());
int nTime = GetLocalInt(oDM, "FOG_TIME_CONST");
int nColor =GetLocalInt(oDM, "FOG_COLOR");

SetFogColor(nTime, nColor, oArea);
}
