#include "omega_include"
void main()
{
int nDrain = GetLocalInt(oDM, "LEVEL_DRAIN");
effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
effect eEffect = EffectNegativeLevel(nDrain);

ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oMyTarget);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oMyTarget);
}
