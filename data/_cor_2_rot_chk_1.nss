//::///////////////////////////////////////////////
//:: FileName _cor_2_rot_chk_1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/28/2006 8:49:42 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!HasItem(GetPCSpeaker(), "TickettoRottesheim"))
		return FALSE;

	return TRUE;
}
