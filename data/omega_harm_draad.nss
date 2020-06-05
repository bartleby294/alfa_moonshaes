#include "omega_include"
void main()
{
int nDrain = GetLocalInt(oDM, "LEVEL_DRAIN");
int nLevel = GetLocalInt(oDM, "PCS_LEVEL");
nDrain ++;

    if (nLevel <= nDrain)
    {
 int nMath = nLevel - 1;
    nDrain = nMath;
    }

SetLocalInt(oDM, "LEVEL_DRAIN", nDrain);

SetCustomToken(7009, IntToString(nDrain));
}
