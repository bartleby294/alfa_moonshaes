//::///////////////////////////////////////////////
//:: FileName cornquesthandin1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2
//:://////////////////////////////////////////////
int StartingConditional()
{

	// Inspect local variables
	if(!(GetLocalInt(GetPCSpeaker(), "cornqueststatus") == 1))
		return FALSE;

	return TRUE;
}