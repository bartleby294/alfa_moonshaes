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

void main()
{

    if(GetIsDMPossessed(OBJECT_SELF) == TRUE) {
        return;
    }

    int nMatch2 = GetListenPatternNumber();

    // Start
    if(nMatch2 == 2011)
    {
        SpeakString("Ya!");
        SetLocalInt(OBJECT_SELF, "waggonStopped", FALSE);
    }

    // Stop
    if(nMatch2 == 2012)
    {
        SpeakString("Whoa Hold!");
        SetLocalInt(OBJECT_SELF, "waggonStopped", TRUE);
        ClearAllActions();
    }

    //ExecuteScript("nw_c2_default4", OBJECT_SELF);
}
