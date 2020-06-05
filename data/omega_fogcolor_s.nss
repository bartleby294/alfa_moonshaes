#include "omega_include"
void main()
{
SetLocalInt(oDM, "FOG_TIME_CONST", FOG_TYPE_SUN);
SetCustomToken(6977, "Day time Fog");
SetCustomToken(6975, "Not Specified");
SetCustomToken(6976, "Not Specified");
//debug, basicly so the system doesn't get fobard if someone
//doesn't select a color.
SetLocalInt(oDM, "FOG_COLOR", FOG_COLOR_GREEN);
}
