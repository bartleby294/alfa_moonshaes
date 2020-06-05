
#include "omega_include"
void main()
{
effect eEffect = EffectPoison(POISON_CHAOS_MIST);

ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oMyTarget);
}

