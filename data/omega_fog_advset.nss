#include "omega_include"
void main()
{
object oArea = GetArea(GetPCSpeaker());
int nColor = GetFogColor(FOG_TYPE_SUN, oArea);
int nColor2 = GetFogColor(FOG_TYPE_MOON, oArea);

GetHexDayCode(nColor);

GetHexNightCode(nColor2);
}
