#include "omega_include"
void main()
{
object oSoundBox = GetLocalObject(oDM, "SOUND_BOX");


switch (Random(1))
{
case 0: AssignCommand ( oSoundBox, PlaySound("as_an_cow1"));
    break;

case 1: AssignCommand ( oSoundBox, PlaySound("as_an_cow2"));
    break;
}

}


