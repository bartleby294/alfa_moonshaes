#include "nw_i0_plotwizard"
#include "ms_xp_util"

void main()
{
    object oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "SulfurMistletoeandaBottleofMinne");
    DestroyObject(oItemToTake);
    CreateItemOnObject("potionofcurel005", GetPCSpeaker());

    object PartyMember = GetFactionLeader(GetPCSpeaker());

    while(PartyMember != OBJECT_INVALID)
    {
        if( (GetCampaignInt("moonshaes","embla_quest_state",PartyMember) == 1))
        {
            SetCampaignInt("moonshaes","embla_quest_state", 2, PartyMember);
            GiveAndLogXP(PartyMember, 30, "EMBLA", "for embla_quest_state.");
        }
        else
        {
             SendMessageToPC(PartyMember, "Youve already done this quest.");
        }

        PartyMember = GetNextFactionMember( PartyMember,TRUE);
    }

}
