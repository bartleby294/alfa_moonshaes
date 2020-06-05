//::///////////////////////////////////////////////
//:: Name x2_def_endcombat
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default Combat Round End script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////
#include "NW_I0_GENERIC"

void main()
{
    //ExecuteScript("nw_c2_default3", OBJECT_SELF);
    SetLocalInt(OBJECT_SELF, "isattacked", 1);
    object attacker = GetNearestSeenOrHeardEnemy();
    SetLocalObject(OBJECT_SELF, "attacker", attacker);

    if(GetLocalInt(OBJECT_SELF, "isattacked") == 1)
    {
        //AssignCommand(OBJECT_SELF, SpeakString("Combat Script is attacked = 1", TALKVOLUME_TALK));

        ActionMoveAwayFromObject(GetLocalObject(OBJECT_SELF, "attacker"), TRUE, 300.0);
        int n = GetLocalInt(OBJECT_SELF, "roundsrunning");
        int q = n+1;
        SetLocalInt(OBJECT_SELF, "roundsrunning", q);

        //int z = GetLocalInt(OBJECT_SELF, "roundsrunning");
        //string bob = IntToString(z);

        //AssignCommand(OBJECT_SELF, SpeakString("n is:", TALKVOLUME_TALK));
        //AssignCommand(OBJECT_SELF, SpeakString(bob, TALKVOLUME_TALK));

        if(GetLocalInt(OBJECT_SELF, "roundsrunning") > 3)
        {
            AssignCommand(OBJECT_SELF, SpeakString("*The deer gets away*", TALKVOLUME_TALK));
            DestroyObject(OBJECT_SELF, 1.3);
        }
    }


}
