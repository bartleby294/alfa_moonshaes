//::///////////////////////////////////////////////
//:: FileName _smug_tok_chk_01
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/25/2006 4:50:29 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(HasItem(GetPCSpeaker(), "_SmugglersToken"))
        return FALSE;

    return TRUE;
}
