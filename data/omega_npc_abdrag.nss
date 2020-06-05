#include "omega_include"
void main()
{
ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_POLYMORPH), oMyTarget);
eEffect = EffectPolymorph(POLYMORPH_TYPE_ANCIENT_BLUE_DRAGON);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oMyTarget);
}
