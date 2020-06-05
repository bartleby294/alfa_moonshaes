
#include "omega_include"
void main()
{
effect eEffect = EffectPoison(POISON_IRON_GOLEM);

ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oMyTarget);
}

