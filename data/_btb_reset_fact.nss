#include "x0_i0_stringlib"

void main()
{
    string factionStr = GetLocalString(GetPCSpeaker(), "CONVERSATION_TARGET");

    int newFactonInt = 0;
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
