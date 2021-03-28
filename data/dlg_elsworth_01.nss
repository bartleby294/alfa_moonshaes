//::///////////////////////////////////////////////
//:: FileName dlg_elsworth_01
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect the campaign variables
    if(!(GetCampaignInt("MinorQuests", "iElsworthquest", GetPCSpeaker()) < 3))
	return FALSE;
    if(!(GetCampaignInt("MinorQuests", "iElsworthquest", GetPCSpeaker()) > 0))
      return FALSE;

      return TRUE;
}
