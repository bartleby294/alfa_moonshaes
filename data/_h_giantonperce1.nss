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
    object sound = GetObjectByTag("_EvilLaugh_towerlvl2");
    object sound2 = GetObjectByTag("_h_giantbattlecry");

    ExecuteScript("nw_c2_default2", OBJECT_SELF);

    if(GetIsPC(seen) && GetLastPerceptionSeen())
    {
        SpeakString("saw PC");
        SoundObjectStop(sound);
        SoundObjectPlay(sound2);
    }
}
