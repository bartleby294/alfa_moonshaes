#include "omega_include"
void main()
{
object oSpawn;
location lTarget;
object oDM = GetLastSpeaker();
lTarget = GetLocation(oDM);

oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "omega_dietyghost", lTarget);
SetLocalObject(oDM, OMW_DEITY_MASTER_LO, oSpawn);
}
