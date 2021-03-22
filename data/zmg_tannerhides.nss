//::///////////////////////////////////////////////
//:: FileName zmg_tannerhides
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if((!HasItem(GetPCSpeaker(), "050_hide")) || (!HasItem(GetPCSpeaker(), "050_hide002")) || (!HasItem(GetPCSpeaker(), "050_hide001")))
        return FALSE;

    return TRUE;
}
