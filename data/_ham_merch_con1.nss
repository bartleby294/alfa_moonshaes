//::///////////////////////////////////////////////
//:: FileName _ham_merch_con1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/22/2006 3:10:10 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!HasItem(GetPCSpeaker(), "TornUpHammerstaadPact"))
		return FALSE;

	return TRUE;
}
