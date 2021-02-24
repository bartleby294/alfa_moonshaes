void main()
{

    object oPC = GetLastUsedBy();
    //object FireGuy = GetNearestObjectByTag("FireVarHolder", OBJECT_SELF,1);
    //Puts Log on fire
    if(GetLocalInt(OBJECT_SELF, "FireState01") == 1)
    {
        AssignCommand(oPC, SpeakString("**Places log on fire**"));
        SetLocalInt(OBJECT_SELF, "firetime01", 0);
        return;
    }
    // Starts fire
    if(GetLocalInt(OBJECT_SELF, "FireState01") == 0)
    {
        location WPLoc = GetLocation(GetNearestObjectByTag("_On_Used_Flame_WP", OBJECT_SELF, 1));
        object flame01 = CreateObject(OBJECT_TYPE_PLACEABLE, "flamelarge001", WPLoc, FALSE);
        SetLocalObject(OBJECT_SELF, "FireObject01", flame01);
        SetLocalInt(OBJECT_SELF, "firetime01", 0);
        SetLocalInt(OBJECT_SELF, "FireState01", 1);
        AssignCommand(oPC, SpeakString("**Starts fire**"));

        object flamesound01 = GetNearestObjectByTag("FireLarge01");
        SoundObjectSetVolume(flamesound01, 99);
    }

}
