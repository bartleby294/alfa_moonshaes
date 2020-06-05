void main()
{
    //TakeGoldFromCreature(2,GetPCSpeaker(),TRUE);
    object oWay = GetWaypointByTag("WP_LuskenEntrance");
    AssignCommand(GetPCSpeaker(),ActionJumpToObject(oWay,FALSE));
}
