//::///////////////////////////////////////////////
//:: FileName cornqueststart0
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2
//:://////////////////////////////////////////////
int StartingConditional()
{
    // Inspect local variables
    if(!(GetCampaignInt("RepeatableStatics", "cornqueststatus", GetPCSpeaker()) < 1))
        return FALSE;

    return TRUE;
}
