//::///////////////////////////////////////////////
//:: Name x2_def_onconv
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default On Conversation script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////
#include "x0_i0_plotgiver"

void main()
{
    object oNPC = GetObjectByTag("Embla");
    object oPC =  GetPCSpeaker();

    ExecuteScript("nw_c2_default4", OBJECT_SELF);

    if( GetQuestStatus(oPC,1,oNPC) == QUEST_COMPLETE )
    {
         DelayCommand(0.2, AssignCommand(GetObjectByTag("Embla"), ActionStartConversation(GetPCSpeaker(), "_h_embla_post_q",FALSE,TRUE) ));
    }
}
