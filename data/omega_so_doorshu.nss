void main()
{
object oDM = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);

switch (Random(2))
{
case 0: AssignCommand ( oDM, PlaySound("as_sw_woodplate1"));
    break;

case 1: AssignCommand ( oDM, PlaySound("as_dr_woodmedcl1"));
    break;
}

}
