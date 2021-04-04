#include "ms_bandit_ambcon"

void main()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);
    int banditCampCnt = GetCampaignInt(MS_BANDIT_CAMP_NUM, GetResRef(oArea));
    string banditCampCntStr = IntToString(banditCampCnt);
    SetCustomToken(21472645, banditCampCntStr);
}
