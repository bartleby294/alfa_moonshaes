//::///////////////////////////////////////////////
//:: FileName dlg_elswrth_chk6
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
        return TRUE; // Return TRUE if he has the required amount
        }
    return FALSE; // return FALSE otherwise. (do not display text)
}
