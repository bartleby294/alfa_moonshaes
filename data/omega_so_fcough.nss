void main()
{
object oDM = GetLastSpeaker();

switch (Random(7))
{
case 0: AssignCommand ( oDM, PlaySound("as_pl_coughf1"));
    break;

case 1: AssignCommand ( oDM, PlaySound("as_pl_coughf2"));
    break;

case 2: AssignCommand ( oDM, PlaySound("as_pl_coughf3"));
    break;

case 3:  AssignCommand ( oDM, PlaySound("as_pl_coughf4"));
    break;

case 4: AssignCommand ( oDM, PlaySound("as_pl_coughf5"));
    break;

case 5: AssignCommand( oDM, PlaySound("as_pl_coughf6"));
    break;

case 6: AssignCommand( oDM, PlaySound("as_pl_coughf7"));
    break;

}
}
