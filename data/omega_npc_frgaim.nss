#include "omega_include"
void main()
{
eEffect = EffectPolymorph(POLYMORPH_TYPE_JNAH_GIANT_MALE);
ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_POLYMORPH), oMyTarget);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oMyTarget);
}
