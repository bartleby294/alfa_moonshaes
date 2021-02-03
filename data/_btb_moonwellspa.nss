#include "_btb_moonwellcon"
#include "_btb_moonwelluti"
#include "_btb_util"

void moonwellSpawn(object oPC, object obHbObj, object highDruid, object Druid01,
                   object Druid02, object Druid03, object Druid04, int state,
                   object light) {

    // if were at or beyond conversation state dont execute.
    if(state >= INTEROGATION_STATE || !GetIsPC(oPC)) {
        return;
    }

    //WriteTimestampedLogEntry("State Change From: " + getState(state) +
    //                         " To: " + getState(INTEROGATION_STATE));
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

    DestroyObject(light, 0.1);

    // Create our actors and props if they dont already exist.
    if(highDruid == OBJECT_INVALID) {
        //WriteTimestampedLogEntry("Creating New High Druid");
        highDruid = CreateObject(OBJECT_TYPE_CREATURE, "moonwelldruid",
                                    HighDruidSpawnLoc,
                                    FALSE, "moonwelldruid000");
        effect Walk = EffectMovementSpeedDecrease(50);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, Walk, highDruid);
    } else {
        WriteTimestampedLogEntry("Using Existing High Druid");
    }
    if(Druid01 == OBJECT_INVALID) {
        //WriteTimestampedLogEntry("Creating New Druid01");
        Druid01 = CreateObject(OBJECT_TYPE_CREATURE, "moonwelldruid001",
                              Druid01SpawnLoc, FALSE, "moonwelldruid001");
    } else {
        //WriteTimestampedLogEntry("Using Existing Druid01");
    }
    if(Druid02 == OBJECT_INVALID) {
        //WriteTimestampedLogEntry("Creating New Druid02");
        Druid02 = CreateObject(OBJECT_TYPE_CREATURE, "moonwelldruid002",
                              Druid02SpawnLoc, FALSE, "moonwelldruid002");
    } else {
        //WriteTimestampedLogEntry("Using Existing Druid02");
    }
    if(Druid03 == OBJECT_INVALID) {
        //WriteTimestampedLogEntry("Creating New Druid03");
        Druid03 = CreateObject(OBJECT_TYPE_CREATURE, "moonwelldruid003",
                              Druid03SpawnLoc, FALSE, "moonwelldruid003");
    } else {
        WriteTimestampedLogEntry("Using Existing Druid03");
    }
    if(Druid04 == OBJECT_INVALID) {
        //WriteTimestampedLogEntry("Creating New Druid04");
        Druid04 = CreateObject(OBJECT_TYPE_CREATURE, "moonwelldruid004",
                              Druid04SpawnLoc, FALSE, "moonwelldruid004");
    } else {
        //WriteTimestampedLogEntry("Using Existing Druid04");
    }

    object Light = CreateObject(OBJECT_TYPE_PLACEABLE, "alfa_shaftligt6",
                                    LightSpawnLoc, FALSE, "alfa_shaftligt6");

    // Move toward the moonwell.
    AssignCommand(highDruid, ActionMoveToLocation(HighDruidStandLoc, FALSE));
    AssignCommand(Druid01, ActionMoveToLocation(Druid01StandLoc, FALSE));
    AssignCommand(Druid02, ActionMoveToLocation(Druid02StandLoc, FALSE));

    // Speak
    AssignCommand(highDruid, DelayCommand(1.0,
                        SpeakString("Step Into The Light!",
                        TALKVOLUME_SILENT_SHOUT)));
    SendMessageToPC(oPC, "High Druid: Step Into The Light!");
    return;

}
