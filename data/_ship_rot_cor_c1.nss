//::///////////////////////////////////////////////
//:: FileName _ship_rot_cor_c1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/28/2006 8:26:19 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!HasItem(GetPCSpeaker(), "TickettoCorwell"))
		return FALSE;

	return TRUE;
}
