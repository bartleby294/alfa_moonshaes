#include "omega_include"
void main()
{
object oSoundBox = GetLocalObject(oDM, "SOUND_BOX");

switch (Random(3))
{
case 0: AssignCommand ( oSoundBox, PlaySound("as_pl_cryingf1"));
    break;

case 1: AssignCommand ( oSoundBox, PlaySound("as_pl_cryingf2"));
    break;

case 2: AssignCommand ( oSoundBox, PlaySound("as_pl_cryingf3"));
    break;
}

}
