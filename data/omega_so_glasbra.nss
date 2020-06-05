#include "omega_include"
void main()
{
object oSoundBox = GetLocalObject(oDM, "SOUND_BOX");

switch (Random(7))
{
case 0: AssignCommand ( oSoundBox, PlaySound("as_cv_barglass3"));
    break;

case 1: AssignCommand ( oSoundBox, PlaySound("as_cv_claybreak1"));
    break;

case 2: AssignCommand ( oSoundBox, PlaySound("as_cv_claybreak2"));
    break;

case 3:  AssignCommand ( oSoundBox, PlaySound("as_cv_claybreak3"));
    break;

case 4: AssignCommand ( oSoundBox, PlaySound("as_cv_glasbreak3"));
    break;

case 5: AssignCommand( oSoundBox, PlaySound("as_cv_glasbreak2"));
    break;

case 6: AssignCommand( oSoundBox, PlaySound("as_cv_glasbreak1"));
    break;
}

}

