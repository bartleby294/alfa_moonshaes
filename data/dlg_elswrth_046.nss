//::///////////////////////////////////////////////
//:: FileName dlg_elswrth_046
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect the campaign variables
    if(!(GetCampaignInt("MinorQuests", "iElsworthquest", GetPCSpeaker()) < 7))
	return FALSE;
    if(!(GetCampaignInt("MinorQuests", "iElsworthquest", GetPCSpeaker()) > 3))
      return FALSE;

      return TRUE;
}
