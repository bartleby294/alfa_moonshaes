void main()
{
object oDM = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);


switch (Random(3))
{
case 0: AssignCommand ( oDM, PlaySound("as_pl_cryingm1"));
    break;

case 1: AssignCommand ( oDM, PlaySound("as_pl_cryingm2"));
    break;

case 2: AssignCommand ( oDM, PlaySound("as_pl_cryingm3"));
    break;
}

}
