#include "ms_bandit_ambcon"

void main()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);
    int banditCampCnt = GetCampaignInt(MS_BANDIT_CAMP_NUM, GetResRef(oArea));
    SetCampaignInt(MS_BANDIT_CAMP_NUM, GetResRef(oArea), banditCampCnt - 1);
}

