#include "omega_include"
void main()
{
effect eDisease = EffectDisease(DISEASE_MUMMY_ROT);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDisease,oMyTarget);
}
