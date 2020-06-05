
#include "omega_include"
void main()
{
effect eEffect = EffectPoison(POISON_BLACK_LOTUS_EXTRACT);

ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oMyTarget);
}

