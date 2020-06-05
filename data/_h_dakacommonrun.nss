//::///////////////////////////////////////////////
//:: Name x2_def_percept
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default On Perception script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

void main()
{
    object seen = GetLastPerceived();
    object movewaypoint = GetObjectByTag("_h_dakaruntowp");
    object movewaypoint2 = GetObjectByTag("_h_dakaruntowp2");

    if(GetIsPC(seen) && GetLastPerceptionSeen())
    {

        ClearAllActions();
        if(d2(1) == 1)
           ActionInteractObject(movewaypoint);
        else
           ActionInteractObject(movewaypoint2);
        SpeakString("<Draconic> Intruder! Run!");
    }

    ExecuteScript("nw_c2_default2", OBJECT_SELF);
}
