//::///////////////////////////////////////////////
//:: FileName cornqueststart
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2
//:://////////////////////////////////////////////
#include "qst__pqj_inc"
#include "nw_i0_tool"

void main()
{
    // Set the variables
    SetCampaignInt("RepeatableStatics", "cornqueststatus", 1, GetPCSpeaker());
    AddPersistentJournalQuestEntry("k010",1,GetPCSpeaker(),FALSE,FALSE,FALSE);
}
