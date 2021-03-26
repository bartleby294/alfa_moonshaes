#include "x0_i0_stringlib"

void oldMain()
{
    string factionStr = GetLocalString(GetPCSpeaker(), "CONVERSATION_TARGET");

    int curFactionInt = GetCampaignInt("FACTION_ACTIVITY", factionStr);
    int newFactonInt = curFactionInt + 25;
    SetCampaignInt("FACTION_ACTIVITY", factionStr, newFactonInt);

    string tokenValue = "";
    struct sStringTokenizer sTok;
    sTok = GetStringTokenizer(factionStr, "_");

    while(HasMoreTokens(sTok)) {
        sTok = AdvanceToNextToken(sTok);
        tokenValue = GetNextToken(sTok);
    }

    SetCustomToken(StringToInt(tokenValue), IntToString(newFactonInt));
}

void main()
{
    object oPC = GetPCSpeaker();
    int banditActivityLevel = GetCampaignInt("FACTION_ACTIVITY",
                               "BANDIT_ACTIVITY_LEVEL_2147440");
    SetCampaignInt("FACTION_ACTIVITY", "BANDIT_ACTIVITY_LEVEL_2147440",
                   banditActivityLevel + 25);
    SetCustomToken(2147440, IntToString(banditActivityLevel + 25));
}

