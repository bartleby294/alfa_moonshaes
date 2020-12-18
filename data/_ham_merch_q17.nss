#include "nw_i0_plotwizard"
#include "NW_I0_GENERIC"
void main()
{

    object oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "TornUpHammerstaadPact");
    DestroyObject(oItemToTake);

    object PartyMember = GetFactionLeader(GetPCSpeaker());

    while(PartyMember != OBJECT_INVALID)
    {
        if( (GetCampaignInt("moonshaes", "pace_merch_quest_state",PartyMember) == 1))
        {
            SetCampaignInt("moonshaes", "pace_merch_quest_state", 2, PartyMember);
            GiveXPToCreature(PartyMember, 15);
        }
        else
        {
             SendMessageToPC(PartyMember, "Youve already done this quest.");
        }

        PartyMember = GetNextFactionMember( PartyMember,TRUE);
    }

    AssignCommand(GetObjectByTag("Aworriedlookingmerchant") , WalkWayPoints(FALSE,0.0));
}
