
#include "omega_include"
void main()
{
effect eEffect = EffectPoison(POISON_SMALL_SPIDER_VENOM);

ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oMyTarget);
}

