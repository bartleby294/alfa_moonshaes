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

    object oNoticed = GetLocalObject(OBJECT_SELF, "spooker");

    if(GetLocalInt(OBJECT_SELF, "isattacked") == 1)
    {
        //AssignCommand(OBJECT_SELF, SpeakString("Heartbeat script is attacked = 1", TALKVOLUME_TALK));

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
        return;
    }

    //if spooked
    if(GetLocalInt(OBJECT_SELF, "spooked") == 1)
    {
        //AssignCommand(OBJECT_SELF, SpeakString("Heartbeat script spooked", TALKVOLUME_TALK));

        ActionMoveAwayFromObject(GetLocalObject(OBJECT_SELF, "spooker"), TRUE, 300.0);
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
        return;
    }
    if(oNoticed == OBJECT_INVALID)
    {
        return;
    }

    if(GetStealthMode(oNoticed) != STEALTH_MODE_ACTIVATED)
        {
            //AssignCommand(OBJECT_SELF, SpeakString("heartbeat no stealth", TALKVOLUME_TALK));
            SetLocalInt(OBJECT_SELF, "spooked", 1);

            if(GetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH) == TRUE)
            {
                SetActionMode(OBJECT_SELF,ACTION_MODE_STEALTH, FALSE);
            }

                ActionMoveAwayFromObject(oNoticed, TRUE, 300.0);
                return;
        }

        ExecuteScript("nw_c2_default1", OBJECT_SELF);

}
