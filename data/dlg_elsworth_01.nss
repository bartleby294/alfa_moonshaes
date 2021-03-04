//::///////////////////////////////////////////////
//:: FileName dlg_elsworth_01
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "iElsworthquest") < 3))
        return FALSE;
    if(!(GetLocalInt(GetPCSpeaker(), "iElsworthquest") > 0))
        return FALSE;

    return TRUE;
}
