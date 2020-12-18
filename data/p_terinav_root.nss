
#include "omega_include"
void main()
{
effect eEffect = EffectPoison(POISON_TERINAV_ROOT);

ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oMyTarget);
}

