void main()
{

    object OnHBObj = GetNearestObjectByTag("Moonwell01OnHBObj");
    object HighDruid = GetNearestObjectByTag("MoonwellHighDruid");
    object oPC = GetEnteringObject();

    if(GetLocalInt(OnHBObj, "Moonwell01HBTimer") == 1)
    {
        SetLocalInt(OnHBObj, "StateStorageVar", 0);
        SetLocalInt(OnHBObj, "StateStorageVar2", 0);
        SetLocalInt(OnHBObj, "Moonwell01HBTimer", 0);
        SetLocalInt(OnHBObj, "StateStorageVar3", 0);
        SetLocalInt(HighDruid, "ConvoState", 3);
        SetLocalObject(HighDruid, "TalkTo", oPC);
        AssignCommand(HighDruid, ClearAllActions());
        effect Walk = EffectMovementSpeedDecrease(50);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, Walk, HighDruid);
        AssignCommand(HighDruid, ActionStartConversation(oPC, "_moonpool01con01", FALSE, FALSE));
    }
}
