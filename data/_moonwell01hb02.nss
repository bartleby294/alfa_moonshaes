//::///////////////////////////////////////////////
//:: Name x2_def_heartbeat
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default Heartbeat script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

void main()
{
    if(GetIsInCombat(OBJECT_SELF)) {
        ExecuteScript("nw_c2_default1", OBJECT_SELF);
    } else {
        if(GetLocalInt(OBJECT_SELF, "ConvoState") == 1)
        {
          //AssignCommand(OBJECT_SELF, ActionStartConversation(GetLocalObject(OBJECT_SELF, "TalkTo"), "_moonpool01con03", FALSE, FALSE));
        }

        if(GetLocalInt(OBJECT_SELF, "ConvoState") == 2)
        {
         //AssignCommand(OBJECT_SELF, ActionStartConversation(GetLocalObject(OBJECT_SELF, "TalkTo"), "_moonpool01con02", FALSE, FALSE));
        }

        if(GetLocalInt(OBJECT_SELF, "ConvoState") == 3)
        {
          //AssignCommand(OBJECT_SELF, ActionStartConversation(GetLocalObject(OBJECT_SELF, "TalkTo"), "_moonpool01con01", FALSE, FALSE));
        }
    }
}
