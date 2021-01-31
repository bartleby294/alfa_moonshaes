#include "_moonwell01const"

float getFacing(vector centerPoint, vector otherPoint) {
    return VectorToAngle(Vector(otherPoint.x - centerPoint.x,
                                otherPoint.y - centerPoint.y,
                                0.0));
}

/**
    Return a location some units of distance away on a straight line.
 */
location pickSpawnLoc(object oPC, object point, float offset, float rotation) {

    vector pointVector = GetPosition(point);
    vector pcVector = GetPosition(oPC);

    float x1 = pcVector.x - pointVector.x;
    float y1 = pcVector.y - pointVector.y;

    float angle = VectorToAngle(Vector(x1,  y1, 0.0));
    float x = offset * cos(angle + rotation);
    float y = offset * sin(angle + rotation);

    location loc = Location(GetArea(oPC),
        Vector(pointVector.x + x, pointVector.y+ y, 0.0), 0.0);
    float z = GetGroundHeight(loc);

    loc = Location(GetArea(oPC),
        Vector(pointVector.x + x, pointVector.y + y, z),
            getFacing(pointVector, GetPositionFromLocation(loc)));

    return loc;
}

void moonwellSpawn(object oPC) {

    object obHbObj = GetObjectByTag("moonwell01onhbob");
    int state = GetLocalInt(obHbObj, "state");
    // if a dm has disabled the scene or its in progress skip out.
    if(state > NO_STATE || !GetIsPC(oPC)) {
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

    object HighDruid = GetObjectByTag("moonwelldruid");
    object Druid01 = GetObjectByTag("moonwelldruid001");
    object Druid02 = GetObjectByTag("moonwelldruid002");
    object Druid03 = GetObjectByTag("moonwelldruid003");
    object Druid04 = GetObjectByTag("moonwelldruid004");
    DestroyObject(GetNearestObjectByTag("alfa_shaftligt6"), 0.1);

    // Create our actors and props if they dont already exist.
    if(HighDruid == OBJECT_INVALID) {
        HighDruid = CreateObject(OBJECT_TYPE_CREATURE, "moonwelldruid",
                                    HighDruidSpawnLoc,
                                    FALSE, "moonwelldruid000");
    }
    if(Druid01 == OBJECT_INVALID) {
        Druid01 = CreateObject(OBJECT_TYPE_CREATURE, "moonwelldruid001",
                                    Druid01SpawnLoc, FALSE, "moonwelldruid001");
    }
    if(Druid02 == OBJECT_INVALID) {
        Druid02 = CreateObject(OBJECT_TYPE_CREATURE, "moonwelldruid002",
                                    Druid02SpawnLoc, FALSE, "moonwelldruid002");
    }
    if(Druid03 == OBJECT_INVALID) {
        Druid03 = CreateObject(OBJECT_TYPE_CREATURE, "moonwelldruid003",
                                    Druid03SpawnLoc, FALSE, "moonwelldruid003");
    }
    if(Druid04 == OBJECT_INVALID) {
        Druid04 = CreateObject(OBJECT_TYPE_CREATURE, "moonwelldruid004",
                                    Druid04SpawnLoc, FALSE, "moonwelldruid004");
    }

    object Light = CreateObject(OBJECT_TYPE_PLACEABLE, "alfa_shaftligt6",
                                    LightSpawnLoc, FALSE, "alfa_shaftligt6");

    // Move toward the moonwell.
    AssignCommand(HighDruid, ActionMoveToLocation(HighDruidStandLoc, FALSE));
    AssignCommand(Druid01, ActionMoveToLocation(Druid01StandLoc, FALSE));
    AssignCommand(Druid02, ActionMoveToLocation(Druid02StandLoc, FALSE));

    // Speak
    SetLocalObject(obHbObj, "lightobject", Light);
    SetLocalObject(obHbObj, "highDruid", HighDruid);
    AssignCommand(HighDruid, DelayCommand(1.0,
                        SpeakString("Step Into The Light!",
                        TALKVOLUME_SILENT_SHOUT)));
    SendMessageToPC(oPC, "High Druid: Step Into The Light!");
    return;

}
