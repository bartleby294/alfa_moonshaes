void main()
{
object oDM = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);

switch (Random(2))
{
case 0: AssignCommand ( oDM, PlaySound("c_wraith_bat1"));
    break;

case 1: AssignCommand ( oDM, PlaySound("as_pl_zombiem3"));
    break;

}

}

