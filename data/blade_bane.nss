
#include "omega_include"
void main()
{
effect eEffect = EffectPoison(POISON_BLADE_BANE);

ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oMyTarget);
}

