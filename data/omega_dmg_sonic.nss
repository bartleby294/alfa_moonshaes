#include "omega_include"
void main()
{
int nDamage = DAMAGE_TYPE_SONIC;
SetLocalInt(oDM, "DAMAGE_TYPE", nDamage);
SetCustomToken(6970, "Sonic");
}
