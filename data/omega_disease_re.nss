#include "omega_include"
void main()
{
effect eDisease = EffectDisease(DISEASE_RED_ACHE);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDisease,oMyTarget);
}
