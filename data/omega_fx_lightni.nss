#include "omega_include"
void main()
{
    // Lightning Strike by Jhenne. 06/29/02

   // tell the DM object to create a Lightning visual effect at targetted location
   AssignCommand( oDM, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_LIGHTNING_M), lTargetLoc));
   // tell the DM object to play a thunderclap
   AssignCommand ( oDM, PlaySound ("as_wt_thundercl3"));
   // create a scorch mark where the lightning hit
   object oScorch = CreateObject ( OBJECT_TYPE_PLACEABLE, "plc_weathmark", lTargetLoc, FALSE);
   object oTargetArea = GetArea(oDM);
   int nXPos, nYPos, nCount;
   for(nCount = 0; nCount < 5; nCount++)
   {
      nXPos = Random(10) - 5;
      nYPos = Random(10) - 5;

      vector vNewVector = GetPositionFromLocation(lTargetLoc);
      vNewVector.x += nXPos;
      vNewVector.y += nYPos;

      location lNewLoc = Location(oTargetArea, vNewVector, 0.0);
      AssignCommand( oDM, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_LIGHTNING_S), lNewLoc));
   }
   DelayCommand ( 20.0, DestroyObject ( oScorch));
}
