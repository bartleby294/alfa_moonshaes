#include "omega_include"
void main()
{
int nDay = GetFogAmount(FOG_TYPE_SUN, oDM);
SetLocalInt(oDM, "F_AM_D", nDay);
int nNight = GetFogAmount(FOG_TYPE_MOON, oDM);
SetLocalInt(oDM, "F_AM_N", nDay);

SetLocalInt(oDM, "FOG_TIME_CONST", FOG_TYPE_SUN);

SetCustomToken(6992, IntToString(nDay));
SetCustomToken(6993, IntToString(nNight));
SetCustomToken(6994, "Editing Day time denseness");
}
