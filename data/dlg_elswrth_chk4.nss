//::///////////////////////////////////////////////
//:: FileName dlg_elswrth_chk4
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2
//:://////////////////////////////////////////////

#include "nw_i0_tool"

int StartingConditional()
{
{
    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "iElsworthquest") < 6))
        return FALSE;
    if(!(GetLocalInt(GetPCSpeaker(), "iElsworthquest") > 3))
        return FALSE;

    return TRUE;

}

{

	// Make sure the PC speaker has these items in their inventory
	if(!HasItem(GetPCSpeaker(), "ElsworthsLoveLetter"))
		return FALSE;

	return TRUE;
}

}
