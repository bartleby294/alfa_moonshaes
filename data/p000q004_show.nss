#include "nw_i0_plotwizard"
int StartingConditional()
{
  if(GetCampaignInt("moonshaes","embla_quest_state", GetPCSpeaker()) == 2)
    {
        return TRUE;
    }

    return FALSE;
}
