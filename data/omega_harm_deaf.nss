#include "omega_include"
void main()
{
effect eVis = EffectVisualEffect(VFX_IMP_BLIND_DEAF_M);
effect eDeaf = EffectDeaf();

ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oMyTarget);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDeaf, oMyTarget);
}
