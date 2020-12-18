#include "omega_include"
void main()
{
object oArea = GetArea(GetPCSpeaker());
int nDRed, nDGreen, nDBlue, nNRed, nNGreen, nNBlue, nSettings;
nDRed = GetLocalInt(oDM, "FOG_D_RED");
nDGreen = GetLocalInt(oDM, "FOG_D_GREEN");
nDBlue = GetLocalInt(oDM, "FOG_D_BLUE");

nNRed = GetLocalInt(oDM, "FOG_N_RED");
nNGreen = GetLocalInt(oDM, "FOG_N_GREEN");
nNBlue = GetLocalInt(oDM, "FOG_N_BLUE");

int nDtotal = ((nDBlue<<16) + (nDGreen<<8) + nDRed);
int nNtotal = ((nNBlue<<16) + (nNGreen<<8) + nNRed);
SetFogColor(FOG_TYPE_SUN, nDtotal, oArea);
SetFogColor(FOG_TYPE_MOON, nNtotal, oArea);


}
