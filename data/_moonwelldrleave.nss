#include "_btb_moonwellcon"

void moonwellDruidsLeave()
{
    object oPC = GetPCSpeaker();
    object obHbObj = GetNearestObjectByTag("moonwell01onhbob", oPC);
    object light = GetLocalObject(obHbObj, "lightobject");

    if(obHbObj == OBJECT_INVALID) {
        SendMessageToPC(oPC, "OBJECT_INVALID");
    } else {
        SendMessageToPC(oPC, "OBJECT VALID");
    }

    SetLocalInt(obHbObj, "state", LEAVING_STATE);
    DestroyObject(light, 1.0);

    //object highDruid = GetLocalObject(obHbObj, "highDruid");
    //object Druid01 = GetObjectByTag("moonwelldruid001");
    //object Druid02 = GetObjectByTag("moonwelldruid002");
    //object Druid03 = GetObjectByTag("moonwelldruid003");
    //object Druid04 = GetObjectByTag("moonwelldruid004");

    object HighDruid = GetLocalObject(obHbObj, "highDruid");
    object Druid01 = GetLocalObject(obHbObj, "Druid01");
    object Druid02 = GetLocalObject(obHbObj, "Druid02");
    object Druid03 = GetLocalObject(obHbObj, "Druid03");
    object Druid04 = GetLocalObject(obHbObj, "Druid04");

    location WalkLoc = GetLocalLocation(obHbObj, "WalkLoc");
    location HighDruidDespawnLoc = GetLocalLocation(obHbObj,
                                                        "HighDruidDespawnLoc");
    location Druid01DespawnLoc = GetLocalLocation(obHbObj, "Druid01DespawnLoc");
    location Druid02DespawnLoc = GetLocalLocation(obHbObj, "Druid02DespawnLoc");
    location Druid03DespawnLoc = GetLocalLocation(obHbObj, "Druid03DespawnLoc");
    location Druid04DespawnLoc = GetLocalLocation(obHbObj, "Druid04DespawnLoc");

    AssignCommand(HighDruid, ActionMoveToLocation(WalkLoc));
    AssignCommand(HighDruid, ActionMoveToLocation(HighDruidDespawnLoc));
    AssignCommand(Druid01, ActionMoveToLocation(Druid01DespawnLoc));
    AssignCommand(Druid02, ActionMoveToLocation(Druid02DespawnLoc));
    AssignCommand(Druid03, ActionMoveToLocation(Druid03DespawnLoc));
    AssignCommand(Druid04, ActionMoveToLocation(Druid04DespawnLoc));
}
