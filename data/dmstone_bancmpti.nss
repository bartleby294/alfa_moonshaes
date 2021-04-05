#include "ms_bandit_ambcon"
#include "nwnx_time"

void main()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);
    int banditCampTime = GetCampaignInt("BANDIT_CAMP_PC_LAST_OBSERVED",
                                        "BANDIT_CAMP_PC_LAST_OBSERVED"
                                        + GetTag(oArea));
    string banditCampTimeStr = IntToString(banditCampTime);
    SetCustomToken(21473845, banditCampTimeStr);
}
