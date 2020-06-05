#include "omega_include"
void main()
{
effect eDisease = EffectDisease(DISEASE_BLINDING_SICKNESS);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDisease,oMyTarget);
}
