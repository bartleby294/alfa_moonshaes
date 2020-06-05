void main()
{
object oPC = GetEnteringObject();
object oWP02 = GetWaypointByTag("BHOH01_02");
location lLoc = GetLocation(oWP02);

AssignCommand(oPC, ActionJumpToLocation(lLoc));
}
