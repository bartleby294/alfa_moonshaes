#include "omega_include"
void main()
{
int nDamage = DAMAGE_TYPE_PIERCING;
SetLocalInt(oDM, "DAMAGE_TYPE", nDamage);
SetCustomToken(6970, "Piercing");
}
