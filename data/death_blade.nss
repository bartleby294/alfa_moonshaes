
#include "omega_include"
void main()
{
effect eEffect = EffectPoison(POISON_DEATHBLADE);

ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oMyTarget);
}

