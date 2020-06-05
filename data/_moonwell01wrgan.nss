void main()
{
    object OnHBObj = GetNearestObjectByTag("Moonwell01OnHBObj");
    SetLocalInt(OnHBObj, "Moonwell01HBTimer", 3);
    object HighDruid = GetNearestObjectByTag("MoonwellHighDruid");

    AssignCommand(HighDruid, ClearAllActions());
    effect Walk2 = EffectMovementSpeedIncrease(99);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, Walk2, HighDruid);
}
