#include "omega_include"
void main()
{
object oArea = GetArea(GetPCSpeaker());
int nSkybox = GetLocalInt(oDM, "SKYBOX_TYPE");
SetSkyBox(nSkybox, oArea);
}

