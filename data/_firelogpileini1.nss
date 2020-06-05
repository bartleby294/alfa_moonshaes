void main()
{

    object oPC = GetLastUsedBy();
    //object FireGuy = GetNearestObjectByTag("FireVarHolder", OBJECT_SELF,1);
    //Puts Log on fire
    if(GetLocalInt(OBJECT_SELF, "FireState") == 1)
    {
        AssignCommand(oPC, SpeakString("**Places log on fire**"));
        SetLocalInt(OBJECT_SELF, "firetime", 0);
        return;
    }
    // Starts fire
    if(GetLocalInt(OBJECT_SELF, "FireState") == 0)
    {
        location WPLoc = GetLocation(GetNearestObjectByTag("_On_Used_Flame_WP", OBJECT_SELF, 1));
        object flame = CreateObject(OBJECT_TYPE_PLACEABLE, "flamelarge001", WPLoc, FALSE);
        SetLocalObject(OBJECT_SELF, "FireObject", flame);
        SetLocalInt(OBJECT_SELF, "firetime", 0);
        SetLocalInt(OBJECT_SELF, "FireState", 1);
        AssignCommand(oPC, SpeakString("**Starts fire**"));

        object flamesound = GetNearestObjectByTag("FireLarge1");
        SoundObjectSetVolume(flamesound, 99);
    }

}
