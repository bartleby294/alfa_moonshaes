//::///////////////////////////////////////////////
//:: FileName chcek_for_misty
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/7/2002 3:49:55 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "TickettoSommersdal"))
        return FALSE;

    return TRUE;
}
