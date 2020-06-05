#include "omega_include"
void main()
{
effect eDisease = EffectDisease(DISEASE_GHOUL_ROT);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDisease,oMyTarget);
}
