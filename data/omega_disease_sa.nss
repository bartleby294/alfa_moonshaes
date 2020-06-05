#include "omega_include"
void main()
{
effect eDisease = EffectDisease(DISEASE_RED_SLAAD_EGGS);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDisease,oMyTarget);
}
