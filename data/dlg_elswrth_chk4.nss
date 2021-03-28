//::///////////////////////////////////////////////
//:: FileName dlg_elswrth_chk4
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2
//:://////////////////////////////////////////////

#include "nw_i0_tool"

int StartingConditional()
{
{
    // Inspect the campaign variables
    if(!(GetCampaignInt("MinorQuests", "iElsworthquest", GetPCSpeaker()) < 6))
	return FALSE;
    if(!(GetCampaignInt("MinorQuests", "iElsworthquest", GetPCSpeaker()) > 3))
      return FALSE;

      return TRUE;

}

{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "ElsworthsLoveLetter"))
        return FALSE;

    return TRUE;
}

}
