void main()
{
    object oPC = GetPCSpeaker();


    object HighDruidSpawnWP = GetNearestObjectByTag("High_Druid_Spawn01");
    object Druid01SpawnWP = GetNearestObjectByTag("Druid01_Spawn01");
    object Druid02SpawnWP = GetNearestObjectByTag("Druid02_Spawn01");
    object OnHBObj = GetNearestObjectByTag("moonwell01VarStorage");

    object Light = GetLocalObject(OnHBObj, "lightobject");
    DestroyObject(Light, 1.0);

    SetLocalInt(OnHBObj, "Moonwell01HBTimer", 4);

    //object HighDruid = GetNearestObjectByTag("MoonwellHighDruid");
    object Druid01 = GetNearestObjectByTag("MoonwellDruid01");
    object Druid02 = GetNearestObjectByTag("MoonwellDruid02");
    object Druid03 = GetNearestObjectByTag("MoonwellDruid03");
    object Druid04 = GetNearestObjectByTag("MoonwellDruid04");

    //AssignCommand(HighDruid, ClearAllActions());
    //effect Walk2 = EffectMovementSpeedIncrease(99);
    //ApplyEffectToObject(DURATION_TYPE_PERMANENT, Walk2, HighDruid);

    //AssignCommand(HighDruid, ActionMoveToObject(HighDruidSpawnWP, FALSE,1.0));
    AssignCommand(Druid01, ActionMoveToObject(Druid01SpawnWP, FALSE,1.0));
    AssignCommand(Druid02, ActionMoveToObject(Druid02SpawnWP, FALSE,1.0));

    //DestroyObject(HighDruid, 16.0);
    DestroyObject(Druid01, 16.0);
    DestroyObject(Druid02, 16.0);
    DestroyObject(Druid03, 16.0);
    DestroyObject(Druid04, 16.0);


    //DelayCommand(15.0, AssignCommand(HighDruid, SpeakString("Disapears into forest")));
    DelayCommand(15.0, AssignCommand(Druid01, SpeakString("Disapears into forest")));
    DelayCommand(15.0, AssignCommand(Druid02, SpeakString("Disapears into forest")));
    DelayCommand(15.0, AssignCommand(Druid03, SpeakString("Disapears into forest")));
    DelayCommand(15.0, AssignCommand(Druid04, SpeakString("Disapears into forest")));

    ExecuteScript("_moonwell01con03",oPC);
}
