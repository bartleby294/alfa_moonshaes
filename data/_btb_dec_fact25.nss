#include "x0_i0_stringlib"

void main()
{
    string factionStr = GetLocalString(GetPCSpeaker(), "CONVERSATION_TARGET");

    int curFactionInt = GetCampaignInt("FACTION_ACTIVITY", factionStr);
    int newFactonInt = curFactionInt - 25;
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
