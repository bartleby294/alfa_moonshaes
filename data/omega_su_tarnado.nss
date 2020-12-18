#include "omega_include"
void main()
    {
 if (GetIsObjectValid(oMyTarget) == TRUE)
  {
 ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_IMP_TORNADO), oMyTarget);
  DestroyObject(oMyTarget, 2.0);
  }
  else
  {
DelayCommand(4.0, AssignCommand ( oDM, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_IMP_TORNADO), lTargetLoc)));
   }
   }
