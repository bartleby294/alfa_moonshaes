#include "ms_xp_util"

void main()
{
    object thisone=GetLastUsedBy();
    int nXpAmount=1000;
    GiveAndLogXP(thisone, nXpAmount, "GIVE XP", "for _givexp.");
}
