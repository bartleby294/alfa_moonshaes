#include "ms_bandit_ambcon"

void main()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);
    int banditAmbushCnt = GetCampaignInt(MS_BANDITS_PER_AREA, GetResRef(oArea));
    SetCampaignInt(MS_BANDITS_PER_AREA, GetResRef(oArea), banditAmbushCnt + 1);
}

