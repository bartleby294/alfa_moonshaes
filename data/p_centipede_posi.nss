
#include "omega_include"
void main()
{
effect eEffect = EffectPoison(POISON_SMALL_CENTIPEDE_POISON);

ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oMyTarget);
}

