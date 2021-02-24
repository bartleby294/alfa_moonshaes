#include "omega_include"
void main()
{
object oSoundBox = GetLocalObject(oDM, "SOUND_BOX");


switch (Random(3))
{
case 0: AssignCommand ( oSoundBox, PlaySound("as_pl_cryingm1"));
    break;

case 1: AssignCommand ( oSoundBox, PlaySound("as_pl_cryingm2"));
    break;

case 2: AssignCommand ( oSoundBox, PlaySound("as_pl_cryingm3"));
    break;
}

}
