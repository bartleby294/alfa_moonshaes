
#include "omega_include"
void main()
{
effect eEffect = EffectPoison(POISON_LICH_DUST);

ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oMyTarget);
}


