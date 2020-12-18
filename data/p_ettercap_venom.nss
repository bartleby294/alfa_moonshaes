
#include "omega_include"
void main()
{
effect eEffect = EffectPoison(POISON_ETTERCAP_VENOM);

ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oMyTarget);
}


