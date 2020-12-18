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
    ExecuteScript("nw_c2_default1", OBJECT_SELF);

    object deer = GetObjectByTag("_h_spit_deer");
    object oNpC =  GetObjectByTag("_h_Ham_butch");

    if(GetLocalInt(OBJECT_SELF, "convostate") != 1)
    {
        AssignCommand(oNpC, ActionAttack(deer, FALSE));
    }
}
