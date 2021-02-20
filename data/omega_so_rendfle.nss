void main()
{
object oDM = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
AssignCommand ( oDM, PlaySound("c_ghoul_bat2"));
}
