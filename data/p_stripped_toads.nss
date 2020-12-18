
#include "omega_include"
void main()
{
effect eEffect = EffectPoison(POISON_STRIPED_TOADSTOOL);

ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oMyTarget);
}


