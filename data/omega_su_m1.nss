#include "omega_include"
void main()
    {
 if (GetIsObjectValid(oMyTarget) == TRUE)
  {
 ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_FNF_SUMMON_MONSTER_1), oMyTarget);
  DestroyObject(oMyTarget, 3.0);
  }
  else
  {
DelayCommand(4.0, AssignCommand ( oDM, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_FNF_SUMMON_MONSTER_1), lTargetLoc)));
   }
   }
