#include "omega_include"
void main()
{
object oSpawn =CreateObject(OBJECT_TYPE_PLACEABLE, "omega_soundbox", lTargetLoc);

if(oSpawn == OBJECT_INVALID) {
    SendMessageToPC(oDM, "oSpawn is invalid");
} else {
    SendMessageToPC(oDM, "oSpawn is valid");
}

SetLocalObject(oDM, "SOUND_BOX", oSpawn);

}
