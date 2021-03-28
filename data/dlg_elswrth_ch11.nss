//::///////////////////////////////////////////////
//:: FileName dlg_elswrth_ch11
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 0
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()


{

  if(
  HasItem(GetPCSpeaker(), "ElsworthsLoveLetter")
     && GetCampaignInt("MinorQuests", "iElsworthquest", GetPCSpeaker()) < 12
     && GetCampaignInt("MinorQuests", "iElsworthquest", GetPCSpeaker()) > 9) {
        return TRUE;
     }
     return FALSE;

}
