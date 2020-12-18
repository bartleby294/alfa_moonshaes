#include "omega_include"
void main()
{
int nDamage = DAMAGE_TYPE_COLD;
SetLocalInt(oDM, "DAMAGE_TYPE", nDamage);
SetCustomToken(6970, "Cold");
}
