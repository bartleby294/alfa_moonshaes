//::///////////////////////////////////////////////
//:: FileName dlg_elswrth_kgck
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()

{
    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "ElsworthsLoveLetter"))
        return FALSE;

    return TRUE;
 }

