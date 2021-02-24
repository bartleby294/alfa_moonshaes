#include "omega_include"
void main()
{
object oSpawn =CreateObject(OBJECT_TYPE_PLACEABLE, "omega_soundbox", lTargetLoc);
SetLocalObject(oDM, "SOUND_BOX", oSpawn);

}
