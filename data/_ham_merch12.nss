//::///////////////////////////////////////////////
//:: FileName _ham_merch12
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/20/2006 4:17:55 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!HasItem(GetPCSpeaker(), "SignedHammerstaadPactNoSeal"))
		return FALSE;

	return TRUE;
}
