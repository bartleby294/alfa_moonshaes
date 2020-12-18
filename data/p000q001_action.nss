//Starts a Database entry to keep track of quest status.

#include "X0_I0_PARTYWIDE"

void main()
{
    // 1 = quest taken
    // 52 = quest has been completed number
   object PartyMember = GetFactionLeader(GetPCSpeaker());

    while(PartyMember != OBJECT_INVALID)
    {
        if( (GetCampaignInt("moonshaes","embla_quest_state",PartyMember) < 1))
        {
            SetCampaignInt("moonshaes","embla_quest_state", 1, PartyMember);
        }
        /*else
        {
            SetCampaignInt("moonshaes","embla_quest_state", 52, PartyMember);
        }*/

        PartyMember = GetNextFactionMember( PartyMember,TRUE);
    }
}
