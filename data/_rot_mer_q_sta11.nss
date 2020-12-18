#include "nw_i0_tool"
int StartingConditional()
{
      if(GetCampaignInt("moonshaes","rott_merch_quest_state",GetPCSpeaker()) == 3 || HasItem(GetPCSpeaker(), "rottmerchfavor2"))
    {
        return TRUE;
    }

    return FALSE;
}
