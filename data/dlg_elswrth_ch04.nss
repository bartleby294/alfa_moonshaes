//::///////////////////////////////////////////////
//:: FileName dlg_elswrth_ch04
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect the campaign variable
    if(!(GetCampaignInt("MinorQuests", "iElsworthquest", GetPCSpeaker()) == 4))
      return FALSE;

      return TRUE;
}
