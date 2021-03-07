 #include "_btb_moonwellcon"
#include "_btb_util"

void moonwellSpawn(object oPC, object obHbObj) {

    //object obHbObj = GetNearestObjectByTag("moonwell01onhbob", oPC);
    int state = GetLocalInt(obHbObj, "state");
    // if were at or beyond conversation state dont execute.
    if(state >= INTEROGATION_STATE || !GetIsPC(oPC)) {
        return;
    }
    SetLocalInt(obHbObj, "state", INTEROGATION_STATE);
    object moonwell = GetObjectByTag("ABoomingVoice2");

    // sort out all our locations.
    location HighDruidSpawnLoc = pickSpawnLoc(oPC, moonwell, 15.0, 180.0);
    location Druid01SpawnLoc = pickSpawnLoc(oPC, moonwell, 15.0, 90.0);
    location Druid02SpawnLoc = pickSpawnLoc(oPC, moonwell, 15.0, 270.0);
    location Druid03SpawnLoc = pickSpawnLoc(oPC, moonwell, 15.0, 135.0);
    location Druid04SpawnLoc = pickSpawnLoc(oPC, moonwell, 15.0, 225.0);
    location LightSpawnLoc = pickSpawnLoc(oPC, moonwell, 7.0, 0.0);
    location WalkLoc = pickSpawnLoc(oPC, moonwell, 7.0, 90.0);

    location HighDruidStandLoc = pickSpawnLoc(oPC, moonwell, 12.0, 180.0);
    location Druid01StandLoc = pickSpawnLoc(oPC, moonwell, 12.0, 90.0);
    location Druid02StandLoc = pickSpawnLoc(oPC, moonwell, 12.0, 270.0);

    location HighDruidDespawnLoc = pickSpawnLoc(oPC, moonwell, 30.0, 180.0);
    location Druid01DespawnLoc = pickSpawnLoc(oPC, moonwell, 30.0, 90.0);
    location Druid02DespawnLoc = pickSpawnLoc(oPC, moonwell, 30.0, 270.0);
    location Druid03DespawnLoc = pickSpawnLoc(oPC, moonwell, 30.0, 135.0);
    location Druid04DespawnLoc = pickSpawnLoc(oPC, moonwell, 30.0, 225.0);

    SetLocalLocation(obHbObj, "HighDruidDespawnLoc", HighDruidDespawnLoc);
    SetLocalLocation(obHbObj, "Druid01DespawnLoc", Druid01DespawnLoc);
    SetLocalLocation(obHbObj, "Druid02DespawnLoc", Druid02DespawnLoc);
    SetLocalLocation(obHbObj, "Druid03DespawnLoc", Druid03DespawnLoc);
    SetLocalLocation(obHbObj, "Druid04DespawnLoc", Druid04DespawnLoc);
    SetLocalLocation(obHbObj, "LightSpawnLoc", LightSpawnLoc);
    SetLocalLocation(obHbObj, "WalkLoc", WalkLoc);
    SetLocalObject(obHbObj, "oPC", oPC);
    SetLocalInt(obHbObj, "timer", 0); // reset the timeer to 0

    //object HighDruid = GetNearestObjectByTag("moonwelldruid", oPC);
    //object Druid01 = GetNearestObjectByTag("moonwelldruid001ingame", oPC);
    //object Druid02 = GetNearestObjectByTag("moonwelldruid002ingame", oPC);
    //object Druid03 = GetNearestObjectByTag("moonwelldruid003ingame", oPC);
    //object Druid04 = GetNearestObjectByTag("moonwelldruid004ingame", oPC);
    object HighDruid = GetLocalObject(obHbObj, "highDruid");
    object Druid01 = GetLocalObject(obHbObj, "Druid01");
    object Druid02 = GetLocalObject(obHbObj, "Druid02");
    object Druid03 = GetLocalObject(obHbObj, "Druid03");
    object Druid04 = GetLocalObject(obHbObj, "Druid04");
    DestroyObject(GetNearestObjectByTag("alfa_shaftligt6"), 0.1);

    // Create our actors and props if they dont already exist.
    if(HighDruid == OBJECT_INVALID) {
        SendMessageToPC(oPC, "High Druid was null");
        HighDruid = CreateObject(OBJECT_TYPE_CREATURE, "moonwelldruid",
                                    HighDruidSpawnLoc,
                                    FALSE, "moonwelldruid000");
        effect Walk = EffectMovementSpeedDecrease(50);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, Walk, HighDruid);
    }
    if(Druid01 == OBJECT_INVALID) {
        SendMessageToPC(oPC, "Druid01 was null");
        Druid01 = CreateObject(OBJECT_TYPE_CREATURE, "moonwelldruid001",
                              Druid01SpawnLoc, FALSE, "moonwelldruid001");
    }
    if(Druid02 == OBJECT_INVALID) {
        SendMessageToPC(oPC, "Druid02 was null");
        Druid02 = CreateObject(OBJECT_TYPE_CREATURE, "moonwelldruid002",
                              Druid02SpawnLoc, FALSE, "moonwelldruid002");
    }
    if(Druid03 == OBJECT_INVALID) {
        SendMessageToPC(oPC, "Druid03 was null");
        Druid03 = CreateObject(OBJECT_TYPE_CREATURE, "moonwelldruid003",
                              Druid03SpawnLoc, FALSE, "moonwelldruid003");
    }
    if(Druid04 == OBJECT_INVALID) {
        SendMessageToPC(oPC, "Druid04 was null");
        Druid04 = CreateObject(OBJECT_TYPE_CREATURE, "moonwelldruid004",
                              Druid04SpawnLoc, FALSE, "moonwelldruid004");
    }

    object Light = CreateObject(OBJECT_TYPE_PLACEABLE, "alfa_shaftligt6",
                                    LightSpawnLoc, FALSE, "alfa_shaftligt6");

    SetLocalObject(obHbObj, "highDruid", HighDruid);
    SetLocalObject(obHbObj, "Druid01", Druid01);
    SetLocalObject(obHbObj, "Druid02", Druid02);
    SetLocalObject(obHbObj, "Druid03", Druid03);
    SetLocalObject(obHbObj, "Druid04", Druid04);
    SetLocalObject(obHbObj, "lightobject", Light);

    // Move toward the moonwell.
    AssignCommand(HighDruid, ActionMoveToLocation(HighDruidStandLoc, FALSE));
    AssignCommand(Druid01, ActionMoveToLocation(Druid01StandLoc, FALSE));
    AssignCommand(Druid02, ActionMoveToLocation(Druid02StandLoc, FALSE));

    // Speak
    AssignCommand(HighDruid, DelayCommand(1.0,
                        SpeakString("Step Into The Light!",
                        TALKVOLUME_SILENT_SHOUT)));
    SendMessageToPC(oPC, "High Druid: Step Into The Light!");
    return;

}
