#include "ms_bandit_ambcon"
#include "nwnx_time"

void main()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);
    int lastBanditCampCreate = GetCampaignInt("BANDIT_CAMP", "BANDIT_CAMP_"
                                              + GetTag(oArea));
    string lastBanditCampCreateStr = IntToString(lastBanditCampCreate);
    SetCustomToken(21423845, lastBanditCampCreateStr);
}
