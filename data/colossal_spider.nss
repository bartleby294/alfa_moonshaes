
#include "omega_include"
void main()
{
effect eEffect = EffectPoison(POISON_COLOSSAL_SPIDER_VENOM);

ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oMyTarget);
}

