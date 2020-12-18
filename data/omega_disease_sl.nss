#include "omega_include"
void main()
{
effect eDisease = EffectDisease(DISEASE_SLIMY_DOOM);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDisease,oMyTarget);
}
