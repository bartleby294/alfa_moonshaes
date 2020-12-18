
#include "omega_include"
void main()
{
effect eEffect = EffectPoison(POISON_PIT_FIEND_ICHOR);

ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oMyTarget);
}


