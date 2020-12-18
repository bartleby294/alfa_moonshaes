#include "omega_include"

void main()
{
AssignCommand ( oDM, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_FNF_METEOR_SWARM), lTargetLoc));
AssignCommand ( oDM, DelayCommand (1.0, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect (VFX_FNF_SCREEN_SHAKE), lTargetLoc)));
object oTargetArea = GetArea(oDM);
int nXPos, nYPos, nCount;
for(nCount = 0; nCount < 15; nCount++)
  {
nXPos = Random(30) - 15;
nYPos = Random(30) - 15;

vector vNewVector = GetPosition(oDM);
vNewVector.x += nXPos;
vNewVector.y += nYPos;
location lFireLoc = Location(oTargetArea, vNewVector, 0.0);
object oFire = CreateObject ( OBJECT_TYPE_PLACEABLE, "plc_flamelarge", lFireLoc, FALSE);
object oDust = CreateObject ( OBJECT_TYPE_PLACEABLE, "plc_dustplume", lFireLoc, FALSE);
DelayCommand ( 10.0, DestroyObject ( oFire));
DelayCommand ( 14.0, DestroyObject ( oDust));
   }

}


