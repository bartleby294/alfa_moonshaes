//::///////////////////////////////////////////////
//:: FileName _smugler_ham01
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/19/2006 10:09:21 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!HasItem(GetPCSpeaker(), "_SmugglersToken"))
		return FALSE;

	return TRUE;
}
