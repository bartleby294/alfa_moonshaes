//::///////////////////////////////////////////////
//:: FileName dlg_elswrth_chk5
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect the campaign variable
    if(!(GetCampaignInt("MinorQuests", "iElsworthquest", GetPCSpeaker()) == 5))
      return FALSE;

      return TRUE;
}
