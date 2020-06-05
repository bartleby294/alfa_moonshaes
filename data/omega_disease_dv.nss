#include "omega_include"
void main()
{
effect eDisease = EffectDisease(DISEASE_DEVIL_CHILLS);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDisease,oMyTarget);
}
