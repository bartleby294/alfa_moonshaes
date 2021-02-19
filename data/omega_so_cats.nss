void main()
{
object oTarget = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
AssignCommand ( oTarget, PlaySound("as_an_catscrech2"));
}
