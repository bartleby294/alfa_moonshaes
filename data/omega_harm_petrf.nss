#include "omega_include"
void main()
{
effect ePetrify = EffectPetrify();

effect eVis = EffectVisualEffect(VFX_IMP_HEAD_ODD);

ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oMyTarget);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePetrify, oMyTarget);
;
}
