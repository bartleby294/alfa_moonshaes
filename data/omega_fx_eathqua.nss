#include "omega_include"
void main()
{
 // Earthquake Effect by Jhenne, 06/29/02
   // declare variables used for targetting and commands.
   location lDMLoc = GetLocation ( oDM);

   // tell the DM object to shake the screen
   AssignCommand( oDM, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), lTargetLoc));
   AssignCommand ( oDM, DelayCommand( 2.8, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_FNF_SCREEN_BUMP), lTargetLoc)));
   AssignCommand ( oDM, DelayCommand( 3.0, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_FNF_SCREEN_SHAKE), lTargetLoc)));
   AssignCommand ( oDM, DelayCommand( 4.5, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_FNF_SCREEN_BUMP), lTargetLoc)));
   AssignCommand ( oDM, DelayCommand( 5.8, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_FNF_SCREEN_BUMP), lTargetLoc)));
   // tell the DM object to play an earthquake sound
   AssignCommand ( oDM, PlaySound ("as_cv_boomdist1"));
   AssignCommand ( oDM, DelayCommand ( 2.0, PlaySound ("as_wt_thunderds3")));
   AssignCommand ( oDM, DelayCommand ( 4.0, PlaySound ("as_cv_boomdist1")));
   // create a dust plume at the DM and clicking location
   object oTargetArea = GetArea(oDM);
   int nXPos, nYPos, nCount;
   for(nCount = 0; nCount < 15; nCount++)
   {
      nXPos = Random(30) - 15;
      nYPos = Random(30) - 15;

      vector vNewVector = GetPosition(oDM);
      vNewVector.x += nXPos;
      vNewVector.y += nYPos;

      location lDustLoc = Location(oTargetArea, vNewVector, 0.0);
      object oDust = CreateObject ( OBJECT_TYPE_PLACEABLE, "plc_dustplume", lDustLoc, FALSE);
      DelayCommand ( 4.0, DestroyObject ( oDust));
}
}
