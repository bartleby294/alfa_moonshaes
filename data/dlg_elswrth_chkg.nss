//::///////////////////////////////////////////////
//:: FileName dlg_elswrth_chkg
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if(GetGold(oPC) > 19) // Set the gold amount you want.
        {
        return TRUE; // Return TRUE if he has enough gold
        }
    return FALSE; // return FALSE otherwise. (do not display text)
}
