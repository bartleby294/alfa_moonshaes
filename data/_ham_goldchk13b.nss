//::///////////////////////////////////////////////
//:: FileName _smug_goldcond1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/19/2006 9:29:53 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetGold(GetPCSpeaker()) < 13))
        return FALSE;

    return TRUE;
}
