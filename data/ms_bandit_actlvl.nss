#include "ms_bandit_ambcon"
#include "x0_i0_stringlib"

void oldMain()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);

    string factionStr = GetLocalString(GetPCSpeaker(), "CONVERSATION_TARGET");
    int curFactionInt = GetCampaignInt("FACTION_ACTIVITY", factionStr);
    string curFactionIntStr = IntToString(curFactionInt);
    SetCustomToken(2147440, curFactionIntStr);
}

void main(){
    int banditActivityLevel = GetCampaignInt("FACTION_ACTIVITY",
                               "BANDIT_ACTIVITY_LEVEL_2147440");
    SetCustomToken(2147440, IntToString(banditActivityLevel));
}

