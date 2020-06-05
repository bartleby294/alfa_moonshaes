//::///////////////////////////////////////////////
//:: FileName _ham_merch_q
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/20/2006 12:00:15 AM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "HammerstaadPact"))
        return FALSE;

    return TRUE;
}
