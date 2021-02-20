void main()
{
object oDM = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);


switch (Random(7))
{
case 0: AssignCommand ( oDM, PlaySound("as_pl_shriekm3"));
    break;

case 1: AssignCommand ( oDM, PlaySound("as_pl_screamm5"));
    break;

case 2: AssignCommand ( oDM, PlaySound("as_pl_screamm4"));
    break;

case 3:  AssignCommand ( oDM, PlaySound("as_pl_screamm3"));
    break;

case 4: AssignCommand ( oDM, PlaySound("as_pl_screamm2"));
    break;

case 5: AssignCommand( oDM, PlaySound("as_pl_screamm1"));
    break;

case 6: AssignCommand( oDM, PlaySound("as_pl_ailingm4"));
    break;

}
}
