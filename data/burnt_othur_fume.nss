
#include "omega_include"
void main()
{
effect eEffect = EffectPoison(POISON_BURNT_OTHUR_FUMES);

ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oMyTarget);
}

