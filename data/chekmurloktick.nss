//::///////////////////////////////////////////////
//:: FileName chekmurloktick
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/20/2002 12:57:46 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "TickettoWesthaven"))
        return FALSE;

    return TRUE;
}
