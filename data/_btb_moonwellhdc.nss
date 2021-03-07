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
#include "_btb_moonwellcon"

void main()
{
    object oPC = GetLastSpeaker();
    object obHbObj = GetNearestObjectByTag("moonwell01onhbob");
    int state = GetLocalInt(obHbObj, "state");

    // if conversation is allowed start it.
    if(state == CONVO_END_STATE) {
        SetLocalInt(obHbObj, "turns_since_convo", 0);
        AssignCommand(OBJECT_SELF, ActionStartConversation(oPC,
                                              "_btb_moon_con01", FALSE, FALSE));
    }


    ExecuteScript("nw_c2_default4", OBJECT_SELF);
}
