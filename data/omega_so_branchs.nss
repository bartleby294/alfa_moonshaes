#include "omega_include"
void main()
{
object oSoundBox = GetLocalObject(oDM, "SOUND_BOX");

switch (Random(5))
{
case 0: AssignCommand ( oSoundBox, PlaySound("fs_grass_hard3"));
    break;

case 1: AssignCommand ( oSoundBox, PlaySound("as_na_branchsnp1"));
    break;

case 2: AssignCommand ( oSoundBox, PlaySound("as_na_branchsnp2"));
    break;

case 3:  AssignCommand ( oSoundBox, PlaySound("as_na_branchsnp3"));
    break;

case 4: AssignCommand ( oSoundBox, PlaySound("as_na_branchsnp4"));
    break;
}

}
