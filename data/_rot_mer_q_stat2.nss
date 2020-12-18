// 1 = in progress
#include "NW_I0_GENERIC"
#include "nw_i0_plotwizard"
void main()
{
    //SetLocalInt(OBJECT_SELF, "p001began", 1);
    CreateItemOnObject("rottpact01", GetPCSpeaker());

    object PartyMember = GetFactionLeader(GetPCSpeaker());

    while(PartyMember != OBJECT_INVALID)
    {
        if( (GetCampaignInt("moonshaes","rott_merch_quest_state",PartyMember) < 1))
        {
            SetCampaignInt("moonshaes","rott_merch_quest_state", 1, PartyMember);
        }
        /*else
        {
            SetCampaignInt("moonshaes","embla_quest_state", 52, PartyMember);
        }*/

        PartyMember = GetNextFactionMember(PartyMember,TRUE);
    }

}
