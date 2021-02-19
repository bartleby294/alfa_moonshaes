#include "omega_include"
void main()
{
object oSpawn;
location lTarget;
lTarget = GetLocation(oDM);

oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "omega_dietyghost", lTarget);


}
