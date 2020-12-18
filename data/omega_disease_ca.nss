#include "omega_include"
void main()
{
effect eDisease = EffectDisease(DISEASE_CACKLE_FEVER);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDisease,oMyTarget);
}
