
#include "omega_include"
void main()
{
effect eEffect = EffectPoison(POISON_CARRION_CRAWLER_BRAIN_JUICE);

ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oMyTarget);
}


