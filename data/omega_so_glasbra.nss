void main()
{
object oDM = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);

switch (Random(7))
{
case 0: AssignCommand ( oDM, PlaySound("as_cv_barglass3"));
    break;

case 1: AssignCommand ( oDM, PlaySound("as_cv_claybreak1"));
    break;

case 2: AssignCommand ( oDM, PlaySound("as_cv_claybreak2"));
    break;

case 3:  AssignCommand ( oDM, PlaySound("as_cv_claybreak3"));
    break;

case 4: AssignCommand ( oDM, PlaySound("as_cv_glasbreak3"));
    break;

case 5: AssignCommand( oDM, PlaySound("as_cv_glasbreak2"));
    break;

case 6: AssignCommand( oDM, PlaySound("as_cv_glasbreak1"));
    break;
}

}

