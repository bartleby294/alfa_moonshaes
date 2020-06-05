
#include "omega_include"
void main()
{
effect eEffect = EffectPoison(POISON_BLACK_ADDER_VENOM);

ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oMyTarget);
}

