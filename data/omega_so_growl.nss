void main()
{
object oDM = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);

switch (Random(4))
{
case 0: AssignCommand ( oDM, PlaySound("c_zombwar_bat1"));
    break;

case 1: AssignCommand ( oDM, PlaySound("c_slaadwek_bat2"));
    break;

case 2: AssignCommand ( oDM, PlaySound("c_slaadwek_bat2"));
    break;

case 3:  AssignCommand ( oDM, PlaySound("c_slaadpow_bat1"));
    break;

}

}
