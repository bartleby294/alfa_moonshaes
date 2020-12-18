#include "omega_include"
void main()
{
effect eEffect = EffectSleep();
effect eVis = EffectVisualEffect(VFX_IMP_SLEEP);

ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oMyTarget);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oMyTarget);
}
