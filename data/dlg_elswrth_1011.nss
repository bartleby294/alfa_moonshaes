//::///////////////////////////////////////////////
//:: FileName dlg_elswrth_1011
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 0
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect the campaign variables
    if(!(GetCampaignInt("MinorQuests", "iElsworthquest", GetPCSpeaker()) < 12))
	return FALSE;
    if(!(GetCampaignInt("MinorQuests", "iElsworthquest", GetPCSpeaker()) > 9))
      return FALSE;

      return TRUE;
}
