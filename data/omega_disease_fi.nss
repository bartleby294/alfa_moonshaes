#include "omega_include"
void main()
{
effect eDisease = EffectDisease(DISEASE_FILTH_FEVER);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDisease,oMyTarget);
}
