
#include "omega_include"
void main()
{
effect eEffect = EffectPoison(POISON_SHADOW_ESSENCE);

ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oMyTarget);
}

