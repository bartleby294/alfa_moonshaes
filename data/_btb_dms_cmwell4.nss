#include "_btb_moonwellcon"
#include "_btb_moonwelllea"

void main()
{
    object oPC = GetPCSpeaker();
    object obHbObj = GetNearestObjectByTag("moonwell01onhbob", oPC);
    object highDruid = GetNearestObjectByTag("moonwelldruid000");
    object Druid01 = GetNearestObjectByTag("moonwelldruid001");
    object Druid02 = GetNearestObjectByTag("moonwelldruid002");
    object Druid03 = GetNearestObjectByTag("moonwelldruid003");
    object Druid04 = GetNearestObjectByTag("moonwelldruid004");
    object light = GetNearestObjectByTag("alfa_shaftligt6");

    float Druid01Dist = GetDistanceToObject(Druid01);
    float Druid02Dist = GetDistanceToObject(Druid02);
    float Druid03Dist = GetDistanceToObject(Druid03);
    float Druid04Dist = GetDistanceToObject(Druid04);
    float highDruidDist = GetDistanceToObject(highDruid);

    if(Druid01Dist < 0.0 && Druid02Dist < 0.0
        && Druid03Dist < 0.0 && Druid04Dist < 0.0
        && highDruidDist < 0.0) {
        //WriteTimestampedLogEntry("State Change From: " + getState(state) +
        //                 " To: " + getState(DONE_STATE));
        SetLocalInt(obHbObj, "state", DONE_STATE);
        SetLocalInt(obHbObj, "leaveCnt", 0);
        SetLocalInt(obHbObj, "timer", 0);
        return;
    }

    DestroyObject(light, 1.0);

    // in case druids get hung up on something despawn after timer.
    int leaveCnt = GetLocalInt(obHbObj, "leaveCnt");
    SetLocalInt(obHbObj, "leaveCnt", leaveCnt = leaveCnt + 1);

    location HighDruidDespawnLoc = GetLocalLocation(obHbObj,
                                                     "HighDruidDespawnLoc");
    location Druid01DespawnLoc = GetLocalLocation(obHbObj,
                                                      "Druid01DespawnLoc");
    location Druid02DespawnLoc = GetLocalLocation(obHbObj,
                                                      "Druid02DespawnLoc");
    location Druid03DespawnLoc = GetLocalLocation(obHbObj,
                                                       "Druid03DespawnLoc");
    location Druid04DespawnLoc = GetLocalLocation(obHbObj,
                                                       "Druid04DespawnLoc");
    location WalkLoc = GetLocalLocation(obHbObj, "WalkLoc");

    //AssignCommand(highDruid, ActionMoveToLocation(WalkLoc));
    AssignCommand(highDruid, ActionMoveToLocation(HighDruidDespawnLoc));
    AssignCommand(Druid01, ActionMoveToLocation(Druid01DespawnLoc));
    AssignCommand(Druid02, ActionMoveToLocation(Druid02DespawnLoc));
    AssignCommand(Druid03, ActionMoveToLocation(Druid03DespawnLoc));
    AssignCommand(Druid04, ActionMoveToLocation(Druid04DespawnLoc));

    //SendMessageToPC(oPC, "Druid01 Dist: " + FloatToString(Druid01Dist));
    if(Druid01Dist > 20.0 || leaveCnt > 5) {
        DelayCommand(1.0, AssignCommand(Druid01,
                                   SpeakString("*Disapears into forest*")));
        DestroyObject(Druid01, 3.0);
        DelayCommand(3.1, SetLocalObject(obHbObj, "Druid01", OBJECT_INVALID));
    }
    //SendMessageToPC(oPC, "Druid02 Dist: " + FloatToString(Druid02Dist));
    if(Druid02Dist > 20.0 || leaveCnt > 5) {
        DelayCommand(1.0, AssignCommand(Druid02,
                                   SpeakString("*Disapears into forest*")));
        DestroyObject(Druid02, 3.0);
        DelayCommand(3.1, SetLocalObject(obHbObj, "Druid02", OBJECT_INVALID));
    }
    //SendMessageToPC(oPC, "Druid03 Dist: " + FloatToString(Druid03Dist));
    if(Druid03Dist > 20.0 || leaveCnt > 5) {
        DelayCommand(1.0, AssignCommand(Druid03,
                                   SpeakString("*Disapears into forest*")));
        DestroyObject(Druid03, 3.0);
        DelayCommand(3.1, SetLocalObject(obHbObj, "Druid03", OBJECT_INVALID));
    }
    //SendMessageToPC(oPC, "Druid04 Dist: " + FloatToString(Druid04Dist));
    if(Druid04Dist > 20.0 || leaveCnt > 5) {
        DelayCommand(1.0, AssignCommand(Druid04,
                                   SpeakString("*Disapears into forest*")));
        DestroyObject(Druid04, 3.0);
        DelayCommand(3.1, SetLocalObject(obHbObj, "Druid04", OBJECT_INVALID));
    }
    //SendMessageToPC(oPC, "highDruid Dist: " + FloatToString(highDruidDist));
    if(highDruidDist > 20.0 || leaveCnt > 5) {
        DelayCommand(1.0, AssignCommand(highDruid,
                                   SpeakString("*Disapears into forest*")));
        DestroyObject(highDruid, 3.0);
        DelayCommand(3.1, SetLocalObject(obHbObj, "highDruid", OBJECT_INVALID));
    }

    SetLocalInt(obHbObj, "state", LEAVING_STATE);
}
