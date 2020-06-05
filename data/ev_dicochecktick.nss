//::///////////////////////////////////////////////
//:: FileName ev_dicochecktick
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/14/2003 7:25:40 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "TickettoWD"))
        return FALSE;

    return TRUE;
}
