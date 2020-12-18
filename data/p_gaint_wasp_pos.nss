
#include "omega_include"
void main()
{
effect eEffect = EffectPoison(POISON_GIANT_WASP_POISON);

ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oMyTarget);
}

