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
     && GetLocalInt(GetPCSpeaker(), "iElsworthquest") < 12
     && GetLocalInt(GetPCSpeaker(), "iElsworthquest") > 9) {
    	return TRUE;
     }
     return FALSE;

}
