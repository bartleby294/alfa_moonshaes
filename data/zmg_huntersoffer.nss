//::///////////////////////////////////////////////
//:: FileName zmg_huntersoffer
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 0
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{
    if(!HasItem(GetPCSpeaker(), "_DeadDeer"))
        return FALSE;
    return TRUE;
}
