#include "_moonwell01const"

void main()
{
    object oPC = GetPCSpeaker();
    object obHbObj = GetObjectByTag("moonwell01onhbob");
    object light = GetLocalObject(obHbObj, "lightobject");

    DestroyObject(light, 1.0);

    object highDruid = GetLocalObject(obHbObj, "highDruid");
    object Druid01 = GetObjectByTag("moonwelldruid001");
    object Druid02 = GetObjectByTag("moonwelldruid002");
    object Druid03 = GetObjectByTag("moonwelldruid003");
    object Druid04 = GetObjectByTag("moonwelldruid004");

    location WalkLoc = GetLocalLocation(obHbObj, "WalkLoc");
    location HighDruidDespawnLoc = GetLocalLocation(obHbObj,
                                                        "HighDruidDespawnLoc");
    location Druid01DespawnLoc = GetLocalLocation(obHbObj, "Druid01DespawnLoc");
    location Druid02DespawnLoc = GetLocalLocation(obHbObj, "Druid02DespawnLoc");
    location Druid03DespawnLoc = GetLocalLocation(obHbObj, "Druid03DespawnLoc");
    location Druid04DespawnLoc = GetLocalLocation(obHbObj, "Druid04DespawnLoc");

    AssignCommand(highDruid, ActionMoveToLocation(WalkLoc, TRUE));
    AssignCommand(highDruid, ActionMoveToLocation(HighDruidDespawnLoc, TRUE));
    AssignCommand(Druid01, ActionMoveToLocation(Druid01DespawnLoc, FALSE));
    AssignCommand(Druid02, ActionMoveToLocation(Druid02DespawnLoc, FALSE));
    AssignCommand(Druid03, ActionMoveToLocation(Druid03DespawnLoc, FALSE));
    AssignCommand(Druid04, ActionMoveToLocation(Druid04DespawnLoc, FALSE));

    DestroyObject(highDruid, 15.0);
    DestroyObject(Druid01, 12.0);
    DestroyObject(Druid02, 12.0);
    DestroyObject(Druid03, 12.0);
    DestroyObject(Druid04, 12.0);

    DelayCommand(14.0, AssignCommand(highDruid,
                                        SpeakString("Disapears into forest")));
    DelayCommand(11.0, AssignCommand(Druid01,
                                        SpeakString("Disapears into forest")));
    DelayCommand(11.0, AssignCommand(Druid02,
                                        SpeakString("Disapears into forest")));
    DelayCommand(11.0, AssignCommand(Druid03,
                                        SpeakString("Disapears into forest")));
    DelayCommand(11.0, AssignCommand(Druid04,
                                        SpeakString("Disapears into forest")));

    SetLocalInt(obHbObj, "state", DONE_STATE);
}
