void main()
{
object oPC = GetEnteringObject();
object oWP01 = GetWaypointByTag("BHOH01_01");
location lLoc = GetLocation(oWP01);

AssignCommand(oPC, ActionJumpToLocation(lLoc));
}
