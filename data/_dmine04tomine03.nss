void main()
{
    object oPC = GetPCSpeaker();
    object waypoint = GetObjectByTag("Mine03ATWaypoint01");

    AssignCommand(oPC, ActionJumpToObject(waypoint, TRUE));
}
