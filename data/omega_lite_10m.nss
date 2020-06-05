#include "omega_include"
void main()
{
int nEffect = GetLocalInt(oDM, "LIGHT_EFFECT");
nEffect += 1;
SendMessageToPC(oDM, IntToString(nEffect));
effect eEffect = EffectVisualEffect(nEffect);

AssignCommand (oDM , ApplyEffectToObject ( DURATION_TYPE_PERMANENT, eEffect, oMyTarget));

}
