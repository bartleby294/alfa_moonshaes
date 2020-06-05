
#include "omega_include"
void main()
{
effect eEffect = EffectPoison(POISON_BLUE_WHINNIS);

ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oMyTarget);
}

