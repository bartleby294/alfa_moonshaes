#include "omega_include"
void main()
{
effect eDisease = EffectDisease(DISEASE_SHAKES);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDisease,oMyTarget);
}
