#include "omega_include"
void main()
{
effect eDisease = EffectDisease(DISEASE_DREAD_BLISTERS);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDisease,oMyTarget);
}
