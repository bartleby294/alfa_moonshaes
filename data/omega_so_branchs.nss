void main()
{
object oDM = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);

switch (Random(5))
{
case 0: AssignCommand ( oDM, PlaySound("fs_grass_hard3"));
    break;

case 1: AssignCommand ( oDM, PlaySound("as_na_branchsnp1"));
    break;

case 2: AssignCommand ( oDM, PlaySound("as_na_branchsnp2"));
    break;

case 3:  AssignCommand ( oDM, PlaySound("as_na_branchsnp3"));
    break;

case 4: AssignCommand ( oDM, PlaySound("as_na_branchsnp4"));
    break;
}

}
