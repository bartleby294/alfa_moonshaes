void main()
{
object oDM = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);

switch (Random(5))
{
case 0: AssignCommand ( oDM, PlaySound("c_werecat_bat2"));
    break;

case 1: AssignCommand ( oDM, PlaySound("c_werecat_bat1"));
    break;

case 2: AssignCommand ( oDM, PlaySound("c_catlion_bat1"));
    break;

case 3:  AssignCommand ( oDM, PlaySound("c_catpanth_bat1"));
    break;

case 4: AssignCommand ( oDM, PlaySound("c_cat_bat2"));
    break;
}

}

