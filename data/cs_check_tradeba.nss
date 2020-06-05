//::///////////////////////////////////////////////
//:: FileName cs_check_tradeba
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 12/4/2004 11:20:08 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!HasItem(GetPCSpeaker(), "alfa_trade_bar"))
		return FALSE;

	return TRUE;
}
