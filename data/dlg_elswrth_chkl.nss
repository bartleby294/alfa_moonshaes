//::///////////////////////////////////////////////
//:: FileName dlg_elswrth_chkl
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()


{

  if(
  HasItem(GetPCSpeaker(), "ElsworthsLoveLetter")
     && GetCampaignInt("MinorQuests", "iElsworthquest", GetPCSpeaker()) == 1) {
        return TRUE;
     }
     return FALSE;

}

