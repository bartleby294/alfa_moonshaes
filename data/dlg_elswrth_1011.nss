//::///////////////////////////////////////////////
//:: FileName dlg_elswrth_1011
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 0
//:://////////////////////////////////////////////
int StartingConditional()
{

	// Inspect local variables
	if(!(GetLocalInt(GetPCSpeaker(), "iElsworthquest") < 12))
		return FALSE;
	if(!(GetLocalInt(GetPCSpeaker(), "iElsworthquest") > 9))
		return FALSE;

	return TRUE;
}
