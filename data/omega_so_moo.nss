void main()
{
object oDM = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);


switch (Random(1))
{
case 0: AssignCommand ( oDM, PlaySound("as_an_cow1"));
    break;

case 1: AssignCommand ( oDM, PlaySound("as_an_cow2"));
    break;
}

}


