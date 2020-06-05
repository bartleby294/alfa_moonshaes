#include "nw_i0_plotwizard"
#include "NW_I0_GENERIC"
void main()
{
    object oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "Rottpact02");
    DestroyObject(oItemToTake);

    if(GetLocalInt(GetPCSpeaker(), "rottmerchqgold") == 1)
    {
        GiveGoldToCreature(GetPCSpeaker(), 75);
    }

    object PartyMember = GetFactionLeader(GetPCSpeaker());

    while(PartyMember != OBJECT_INVALID)
    {
        if( (GetCampaignInt("moonshaes", "rott_merch_quest_state",PartyMember) == 1))
        {
            SetCampaignInt("moonshaes", "rott_merch_quest_state", 2, PartyMember);
            GiveXPToCreature(PartyMember, 30);

            if(GetLocalInt(PartyMember, "rottmerchqgold") == 0)
            {
               SetCampaignInt("moonshaes", "rott_merch_quest_state", 3, PartyMember);
               object oItem2 = CreateItemOnObject("rottmerchfavor1", PartyMember);
               SetLocalString(oItem2, "Data", GetPCPlayerName(PartyMember));
            }

            if(GetLocalInt(PartyMember, "rottmerchqgold") == 2)
            {
               object oItem2 = CreateItemOnObject("rottmerchfavor2", PartyMember);
               SetLocalString(oItem2, "Data", GetPCPlayerName(PartyMember));
            }
        }

        else
        {
             SendMessageToPC(PartyMember, "Youve already done this quest.");
        }

        PartyMember = GetNextFactionMember( PartyMember,TRUE);
    }


    AssignCommand(GetObjectByTag("Aworriedlookingmerchant") , WalkWayPoints(FALSE,0.0));
}
