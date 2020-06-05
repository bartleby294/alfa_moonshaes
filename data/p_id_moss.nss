
#include "omega_include"
void main()
{
effect eEffect = EffectPoison(POISON_ID_MOSS);

ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oMyTarget);
}

