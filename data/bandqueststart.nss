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
    SetLocalInt(GetPCSpeaker(), "bandqueststatus", 1);
    AddPersistentJournalQuestEntry("k011",1,GetPCSpeaker(),FALSE,FALSE,FALSE);
}
