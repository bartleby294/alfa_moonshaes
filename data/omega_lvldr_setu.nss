#include "omega_include"
void main()
{
int nLevel = GetHitDice(oMyTarget);
SetLocalInt(oDM, "PCS_LEVEL", nLevel);

    SetCustomToken(7008, IntToString(nLevel));
    SetCustomToken(7009, "0");

}
