void main()
{
object oDM = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);


switch (Random(7))
{
case 0: AssignCommand ( oDM, PlaySound("as_pl_coughm1"));
    break;

case 1: AssignCommand ( oDM, PlaySound("as_pl_coughm2"));
    break;

case 2: AssignCommand ( oDM, PlaySound("as_pl_coughm3"));
    break;

case 3:  AssignCommand ( oDM, PlaySound("as_pl_coughm4"));
    break;

case 4: AssignCommand ( oDM, PlaySound("as_pl_coughm5"));
    break;

case 5: AssignCommand( oDM, PlaySound("as_pl_coughm6"));
    break;

case 6: AssignCommand( oDM, PlaySound("as_pl_coughm7"));
    break;

}
}
