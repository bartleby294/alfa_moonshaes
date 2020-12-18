#include "omega_include"
void main()
{
effect eDisease = EffectDisease(DISEASE_DEMON_FEVER);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDisease,oMyTarget);
}
