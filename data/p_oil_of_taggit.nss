
#include "omega_include"
void main()
{
effect eEffect = EffectPoison(POISON_OIL_OF_TAGGIT);

ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oMyTarget);
}

