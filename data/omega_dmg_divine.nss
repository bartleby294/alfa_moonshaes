#include "omega_include"
void main()
{
int nDamage = DAMAGE_TYPE_DIVINE;
SetLocalInt(oDM, "DAMAGE_TYPE", nDamage);
SetCustomToken(6970, "Divine");
}
