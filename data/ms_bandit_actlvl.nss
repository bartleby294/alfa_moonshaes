#include "ms_bandit_ambcon"
#include "x0_i0_stringlib"

void main()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);

    string factionStr = GetLocalString(GetPCSpeaker(), "CONVERSATION_TARGET");
    int curFactionInt = GetCampaignInt("FACTION_ACTIVITY", factionStr);
    string curFactionIntStr = IntToString(curFactionInt);
    SetCustomToken(2147440, curFactionIntStr);
}

