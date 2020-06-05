#include "omega_include"
void main()
{
object oArea = GetArea(GetPCSpeaker());
int nDay, nNight;

nDay = GetLocalInt(oDM, "F_AM_D");
nNight = GetLocalInt(oDM, "F_AM_N");
SetFogAmount(FOG_TYPE_SUN, nDay, oArea);
SetFogAmount(FOG_TYPE_MOON, nNight, oArea);

}
