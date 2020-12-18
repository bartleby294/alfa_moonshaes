#include "omega_include"
void main()
{
effect eEffect = EffectFrightened();
effect eVis = EffectVisualEffect(VFX_IMP_HEAD_EVIL);

ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oMyTarget);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oMyTarget);
}
