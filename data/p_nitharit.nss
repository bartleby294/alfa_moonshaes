
#include "omega_include"
void main()
{
effect eEffect = EffectPoison(POISON_NITHARIT);

ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oMyTarget);
}

