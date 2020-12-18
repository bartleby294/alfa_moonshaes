#include "omega_include"
void main()
{
    object oDM = GetLastSpeaker();
    object oMyTarget = GetLocalObject(oDM, "OMWandTarget");
    eEffect = EffectLinkEffects(EffectParalyze(), EffectVisualEffect(VFX_DUR_PARALYZED));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(eEffect), oMyTarget);
 }

