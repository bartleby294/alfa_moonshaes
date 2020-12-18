
#include "omega_include"
void main()
{
effect eEffect = EffectPoison(POISON_HUGE_SPIDER_VENOM);

ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oMyTarget);
}

