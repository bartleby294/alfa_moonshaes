#include "ms_seed_bancamp"
#include "ms_bandit_ambcon"

void main()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);
    int banditCampCnt = GetCampaignInt(MS_BANDIT_CAMP_NUM, GetResRef(oArea));
    SeedRandomBanditCampAtLocation(oArea, banditCampCnt, GetLocation(oPC));
}
