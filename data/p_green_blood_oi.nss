
#include "omega_include"
void main()
{
effect eEffect = EffectPoison(POISON_GREENBLOOD_OIL);

ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oMyTarget);
}


