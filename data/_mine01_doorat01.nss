void main()
{
    object oPC = GetLastUsedBy();
    object waypoint = GetObjectByTag("_hammerstaad01");

    DelayCommand(1.0, AssignCommand(oPC, ActionJumpToObject(waypoint, TRUE)));
}
