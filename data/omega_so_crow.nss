#include "omega_include"
void main()
{
object oSoundBox = GetLocalObject(oDM, "SOUND_BOX");

switch (Random(2))
{
case 0: AssignCommand ( oSoundBox, PlaySound("as_an_crow1"));
    break;

case 1: AssignCommand ( oSoundBox, PlaySound("as_an_crow2"));
    break;
}

}

